unit uPrinter;

interface

{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_CAST OFF}

uses
  Windows, Classes, Printers;

type
  TPaperName = array[0..63] of Char;
  TPaperInfo = packed record
    papername: TPapername;
    paperID: Word;
    papersize: TPoint;
  end;
  TPaperInfos = array of TPaperInfo;
  TPaperSizes = array of TPoint;


function  GetPaperID: SmallInt;
procedure SetPaperID( ID : SmallInt );
procedure GetPapernames(sl: TStrings; index: Integer);
procedure GetPapersizes(var sizes: TPaperSizes; index: Integer);
procedure GetPaperInfo(var infos: TPaperInfos; index: Integer);

implementation

uses
  SysUtils, WinSpool;

function GetPaperID: SmallInt;
var
  Device, Driver, Port: array[0..127] of char;
  hDeviceMode: THandle;
  pDevMode: PDeviceMode;
begin
  result := -1;
  with Printer do
  begin
    GetPrinter(Device, Driver, Port, hDeviceMode);
    pDevMode := GlobalLock(hDevicemode);
    if pDevMode <> nil then
    try
      with pDevMode^ do
      begin
        dmFields := dmFields or DM_PAPERSIZE;
        Result := dmPapersize;
      end;
    finally
      GlobalUnlock(hDevicemode);
    end;
  end;
end;

procedure SetPaperID( ID : SmallInt );
var
  Device, Driver, Port: array[0..80] of Char;
  DevMode: THandle;
  pDevmode: PDeviceMode;
  Papers: TPaperInfos;
begin
  GetPaperInfo(Papers, Printer.PrinterIndex);

  Printer.GetPrinter(Device, Driver, Port, DevMode);
  if Devmode <> 0 then
  begin
    pDevMode := GlobalLock(Devmode);
    if pDevmode <> nil then
    try
      with pDevmode^ do
      begin
        dmPapersize := Papers[ID].paperID;
        dmPaperLength := Papers[ID].papersize.Y;
        dmPaperWidth := Papers[ID].papersize.X;
        dmFields := dmFields or DM_PAPERSIZE OR DM_PAPERLENGTH OR DM_PAPERWIDTH;
      end;
    finally
      GlobalUnlock(Devmode);
    end;
  end;
end; 

procedure GetPapernames(sl: TStrings; index: Integer);
type
  TPaperNameArray = array[1..High(Integer) div Sizeof(TPaperName)] of TPaperName;
  PPapernameArray = ^TPaperNameArray;
  TPaperArray = array[1..High(Integer) div Sizeof(Word)] of Word;
  PPaperArray = ^TPaperArray;
var
  Device, Driver, Port: array[0..255] of Char;
  hDevMode: THandle;
  i, numPaperNames, numPapers, temp: Integer;
  pPaperNames: PPapernameArray;
  pPapers: PPaperArray;
begin
  Assert(Assigned(sl));
  Printer.PrinterIndex := index;
  Printer.GetPrinter(Device, Driver, Port, hDevmode);
  numPaperNames := WinSpool.DeviceCapabilities(Device, Port, DC_PAPERNAMES, nil, nil);

  numPapers := WinSpool.DeviceCapabilities(Device, Port, DC_PAPERS, nil, nil);
  if numPapers <> numPaperNames then
  begin
    raise Exception.Create('DeviceCapabilities reports different number of papers and paper-names');
  end;
  if numPaperNames > 0 then
  begin
    GetMem(pPaperNames, numPaperNames * Sizeof(TPapername));
    GetMem(pPapers, numPapers * Sizeof(Word));
    try
      WinSpool.DeviceCapabilities(Device, Port, DC_PAPERNAMES, Pchar(pPaperNames),
        nil);
      WinSpool.DeviceCapabilities(Device, Port, DC_PAPERS, Pchar(pPapers), nil);
      sl.clear;
      for i := 1 to numPaperNames do
      begin
        temp := pPapers^[i];
        sl.addObject(pPaperNames^[i], TObject(temp));
      end;
    finally
      FreeMem(pPaperNames);
      if pPapers <> nil then
        FreeMem(pPapers);
    end;
  end;
end;
 
procedure GetPapersizes(var sizes: TPaperSizes; index: Integer);
var
  Device, Driver, Port: array[0..255] of Char;
  hDevMode: THandle;
  numPapers: Integer;
begin
  Printer.PrinterIndex := index;
  Printer.GetPrinter(Device, Driver, Port, hDevmode);
  numPapers := WinSpool.DeviceCapabilities(Device, Port, DC_PAPERS, nil, nil);
  SetLength(sizes, numPapers);
  if numPapers > 0 then
    WinSpool.DeviceCapabilities(Device, Port, DC_PAPERSIZE, PChar(@sizes[0]), nil);
end;
 
procedure GetPaperInfo(var infos: TPaperInfos; index: Integer);
var
  sizes: TPaperSizes;
  sl: TStringlist;
  i: Integer;
begin
  sl := Tstringlist.Create;
  try
    GetPaperNames(sl, index);
    GetPaperSizes(sizes, index);
    Assert(sl.count = Length(sizes));
    SetLength(infos, sl.count);
    for i := 0 to sl.count - 1 do
    begin
      StrPLCopy(infos[i].papername, sl[i], Sizeof(TPapername) - 1);
      infos[i].paperID := LoWord(Longword(sl.Objects[i]));
      infos[i].papersize := sizes[i];
    end;
  finally
    sl.Free;
  end;
end;

end.
