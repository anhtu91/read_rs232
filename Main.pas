unit Main;

{$I SMP.inc}

interface

uses
  Windows, SysUtils, Classes, Controls, Forms, Buttons, Graphics, Menus, Grids, StdCtrls, ExtCtrls, Dialogs,
  JvDialogs,
  uCheckStringGrid,
  Serial,
  uTLH.ComponentTools
  {$IFDEF MSSQL},uMSSQL{$ENDIF}
  ;

type
  TFrmRS232 = class(TForm)  
    pmResults: TPopupMenu;
    miRemove: TMenuItem;
    miClear: TMenuItem;
    Serial: TSerial;
    N1: TMenuItem;
    miSaveCSV: TMenuItem;
    JSaveDlg1: TJvSaveDialog;
    imgLogo: TImage;
    pnlControls: TPanel;
    miSave: TMenuItem;
    miSavePDF: TMenuItem;
    pnlResults: TPanel;
    pnlGraphic: TPanel;
    imgSabre: TImage;
    miPrint: TMenuItem;
    N2: TMenuItem;
    PrintAll1: TMenuItem;
    grpControls: TGroupBox;
    BBtnSaveCSV: TBitBtn;
    BBtnSavePDF: TBitBtn;
    BBtnClear: TBitBtn;
    BBtnRemove: TBitBtn;
    BBtnPrint: TBitBtn;
    pnlRS232Error: TPanel;
    pnlWebIO: TPanel;
    pnlPrinter: TPanel;
    miOptions: TMenuItem;
    grpDebug: TGroupBox;
    edtDebug: TEdit;
    bBtnOptions: TBitBtn;
    bBtnNewPage: TBitBtn;
    miNewPage: TMenuItem;
    pnlInfo3: TPanel;
    lbledtInfo3: TLabeledEdit;
    pnlInfo2: TPanel;
    lbledtInfo2: TLabeledEdit;
    pnlInfo1: TPanel;
    lbledtInfo1: TLabeledEdit;
    pnlMSSQL: TPanel;
    pnlServiceMode: TPanel;
    pnlService: TPanel;
    bBtnService: TBitBtn;
    pnlServiceLogin: TPanel;
    pnlServicePassword: TPanel;
    bBtnServiceOK: TBitBtn;
    bBtnServiceCancel: TBitBtn;
    lbledtServicePassword: TLabeledEdit;
    miService: TMenuItem;
    pnlAutoPrint: TPanel;
    chkAutoPrint: TCheckBox;
    pnlEthernet: TPanel;
    procedure miRemoveClick(Sender: TObject);
    procedure miClearClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure miSaveCSVClick(Sender: TObject);
    procedure SerialEventChar(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure miSavePDFClick(Sender: TObject);
    procedure miOptionsClick(Sender: TObject);    
    procedure BBtnSaveCSVClick(Sender: TObject);
    procedure BBtnSavePDFClick(Sender: TObject);
    procedure BBtnClearClick(Sender: TObject);
    procedure BBtnRemoveClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure pnlWebIOClick(Sender: TObject);
    procedure miPrintClick(Sender: TObject);
    procedure BBtnPrintClick(Sender: TObject);
    procedure PrintAllClick(Sender: TObject);
    procedure BtnOptionsClick(Sender: TObject);
    procedure edtDebugKeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure miNewPageClick(Sender: TObject);
    procedure bBtnNewPageClick(Sender: TObject);
    procedure lbledtInfoKeyPress(Sender: TObject; var Key: Char);
    procedure lbledtInfo1Change(Sender: TObject);
    procedure bBtnServiceClick(Sender: TObject);
    procedure bBtnServiceOKClick(Sender: TObject);
    procedure bBtnServiceCancelClick(Sender: TObject);
    procedure miServiceClick(Sender: TObject);
    procedure imgLogoClick(Sender: TObject);
    procedure chkAutoPrintClick(Sender: TObject);
  private
    { Private-Deklarationen }
    StrGridResults : TCheckStringGrid;
    fCurrentIndex  : Cardinal;
    fLastValue     : Extended;
    fNewPage       : boolean;
    fService       : Byte;
    fIDE           : boolean;
    {$IFDEF MSSQL}
    fMSSQL         : tMSSQL;
    {$ENDIF}
    procedure AddValue( Index : Cardinal; Value : Extended );
    procedure DelValue( Index : Cardinal );
    procedure SaveCSV( Append : boolean = false; Full : boolean = false ); 
    procedure SavePDF;
    procedure Clear;
    {$IFDEF PRINTER}
    procedure Print( Index : Cardinal; Value : Extended; DateTime : string = '' );
    {$ENDIF}
    procedure UpdateReadOnlyCols;    
  public
    { Public-Deklarationen }
    procedure ProcessValue( Value : Double );    
    function  FindPrinter : Boolean;    
    procedure SetParameterDependencys;
    procedure SetServiceDependencys;
    procedure Draw( Value : Extended; bgCol : TColor = clWhite; fgCol : TColor = clBlack );
    property  LastValue : Extended read fLastValue;
    property  Service   : Byte     read fService;
  end;

var
  FrmRS232: TFrmRS232;
  Mutex_ : THandle;
  AppTitle_ : String;

const
  MutexTitle_    = 'imessSaebelmessplatte';
  Version_       = 'v1.22';

{$IFDEF WEBIO}
procedure WebIO_OnChange( Sender : TObject; ModuleID, Chan : Byte; Value : boolean );
{$ENDIF}

implementation

uses
  Math, Mathrout, 
  SynPdf, uTLH.Strings,
  uFrmOptions, Language,
  uTLH.Graphics
  {$IFDEF WEBIO}, uWEBIO{$ENDIF}
  {$IFDEF PRINTER}, Printers, uPrinter, StrUtils{$ENDIF}
  ;

{$R *.dfm}

const
  PrinterNames_ : Array [0..1] of String = ( 'TSC TTP-245C', 'TSC TC200' ); 

procedure TFrmRS232.FormCreate(Sender: TObject);
begin
  fIDE := FindWindow( 'TappBuilder', NIL ) <> 0;

  if NOT fIDE then
    begin
    mutex_ := CreateMutex( nil, true, MutexTitle_ );
    if GetLastError = ERROR_ALREADY_EXISTS then
      begin
      ShowMessage( 'Application may not be started twice!' );
      Close;
      halt;
      exit;
      end;
    end;

  Icon                  := Application.Icon;
  StrGridResults        := TCheckStringGrid.Create( self );
  StrGridResults.Parent := pnlResults;
  StrGridResults.Align  := alClient;
//  StrGridResults.OnKeyPress := StrGridResultsKeyPress; // MS
  StrGridResults.MenuEnabled := false;

  StrGridResults.Options := [ goFixedVertLine..goHorzLine, goEditing ];
  StrGridResults.SelectedCellColor := -1;
  StrGridResults.SelectedRowColoring := True;
  StrGridResults.SelectedRowColor := clRed;
  StrGridResults.FixedCols := 0;
  StrGridResults.ColCount  := 4;
  StrGridResults.RowCount  := 1;

  fCurrentIndex        := 1;
  fLastValue           := 0;
  fNewPage             := false;
  if fIDE then
    fService           := 2
  else
    fService           := 0;
  SetServiceDependencys;

  JSaveDlg1.DefaultExt := '.csv';
  JSaveDlg1.Filter := 'CSV|*.csv';

  {$IFDEF WEBIO}
  WEBIO.InStrings[ 0, 0 ] := 'Trigger';
  WEBIO.OnChange := WebIO_OnChange;
  {$ENDIF}
end;

procedure TFrmRS232.FormDestroy(Sender: TObject);
begin
  CloseHandle( mutex_ );
end;

procedure TFrmRS232.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  parameter.ParameterUebernehmen( True, True, True );
end;

procedure TFrmRS232.FormResize(Sender: TObject);
var
  i : integer;
begin
  StrGridResults.ColWidths[0] := 220;
  for i := 1 to StrGridResults.ColCount-1 do
    StrGridResults.ColWidths[i] := (StrGridResults.Width-StrGridResults.ColWidths[0]-(StrGridResults.ColCount*2)) div (StrGridResults.ColCount-1);

  if Assigned( parameter ) then
    Draw( fLastValue, parameter.GraphicBgColor.Wert, parameter.GraphicVgColor.Wert )
  else
    Draw( fLastValue )  
end;

procedure TFrmRS232.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (NOT (ssAlt IN Shift)) AND (NOT (ssCtrl IN Shift)) AND (NOT (ssShift IN Shift)) then
    begin
    Case Key of
      VK_F1  : miSaveCSVClick( Sender );
      VK_F2  : miSavePDFClick( Sender );
      VK_F3  : miClearClick( Sender );
      VK_F4  : miRemoveClick( Sender );
      VK_F5  : miOptionsClick( Sender );
      VK_F6  : miPrintClick( Sender );
      VK_F7  : miNewPageClick( Sender );
      VK_F12 : miServiceClick( Sender );
    end;
    end;
end;

procedure TFrmRS232.pnlWebIOClick(Sender: TObject);
begin
  {$IFDEF WEBIO}
  FrmWEBIO.Show;
  {$ENDIF}
end;

procedure TFrmRS232.SetParameterDependencys;
var
  i : integer;
begin
  // Language
  AppTitle_ := GetSourceCodeString( 1000, 'Säbelmessplatte' );
  Caption := AppTitle_ + ' ' + Version_;

  StrGridResults.Cells[ 0, 0 ] := GetSourceCodeString( 1001, 'Date/Time' );
  StrGridResults.CellColor[ 1, 0 ] := -1;
  StrGridResults.CellColor[ 2, 0 ] := -1;
  case parameter.MetersDisplay.Wert of
    0 : begin
        StrGridResults.ColCount := 4;
        StrGridResults.Cells[ 1, 0 ] := GetSourceCodeString( 1002, 'Säbel pro 1m' );
        StrGridResults.Cells[ 2, 0 ] := GetSourceCodeString( 1003, 'Säbel pro 2m' );

        // Meter (Input)
        StrGridResults.CellColor[ 1, 0 ] := IfThen( ( parameter.Meters.Wert = 0 ), clLime, -1 );
        StrGridResults.CellColor[ 2, 0 ] := IfThen( ( parameter.Meters.Wert = 1 ), clLime, -1 );
        end;
    1 : begin
        StrGridResults.ColCount := 3;
        StrGridResults.Cells[ 1, 0 ] := GetSourceCodeString( 1002, 'Säbel pro 1m' );
        end;
    2 : begin
        StrGridResults.ColCount := 3;
        StrGridResults.Cells[ 1, 0 ] := GetSourceCodeString( 1003, 'Säbel pro 2m' );
        end;
  end;
  for i := 1 to StrGridResults.ColCount-1 do
    StrGridResults.ColWidths[i] := (StrGridResults.Width-StrGridResults.ColWidths[0]-(StrGridResults.ColCount*2)) div (StrGridResults.ColCount-1);

  case parameter.GridData.Wert of
    0 : StrGridResults.Cells[ IfThen( parameter.MetersDisplay.Wert = 0, 3, 2 ), 0 ] := GetSourceCodeString( 1004, 'Index' );
    1 : StrGridResults.Cells[ IfThen( parameter.MetersDisplay.Wert = 0, 3, 2 ), 0 ] := parameter.Info1_Caption.Wert;
    2 : StrGridResults.Cells[ IfThen( parameter.MetersDisplay.Wert = 0, 3, 2 ), 0 ] := parameter.Info2_Caption.Wert;
    3 : StrGridResults.Cells[ IfThen( parameter.MetersDisplay.Wert = 0, 3, 2 ), 0 ] := parameter.Info3_Caption.Wert;
  end;

  UpdateReadOnlyCols;

  BBtnSaveCSV.Enabled := NOT parameter.AutoSave.Wert;
  BBtnSavePDF.Enabled := NOT parameter.AutoSave.Wert;
  miSave.Visible      := NOT parameter.AutoSave.Wert;

  // Other
  JSaveDlg1.InitialDir := parameter.Directory.Wert;
  
  pnlInfo1.Visible := parameter.Info1_Caption.Wert <> '';
  lbledtInfo1.EditLabel.Caption := parameter.Info1_Caption.Wert;

  pnlInfo2.Visible := parameter.Info2_Caption.Wert <> '';
  lbledtInfo2.EditLabel.Caption := parameter.Info2_Caption.Wert;

  pnlInfo3.Visible := parameter.Info3_Caption.Wert <> '';
  lbledtInfo3.EditLabel.Caption := parameter.Info3_Caption.Wert;

  // Re-Sort alTop Elements
  imgLogo.Top       := 10;
  pnlRS232Error.Top := 9;
  pnlEthernet.Top   := 8;
  pnlWebIO.Top      := 7;
  pnlMSSQL.Top      := 6;
  pnlPrinter.Top    := 5;
  pnlAutoPrint.Top  := 4;
  pnlInfo1.Top      := 3;
  pnlInfo2.Top      := 2;
  pnlInfo3.Top      := 1;

  {$IFDEF PRINTER}
  if parameter.PrinterEnabled.Wert then
    begin
    pnlPrinter.Visible := NOT FindPrinter;
//    parameter.PrinterEnabled.Wert := NOT pnlPrinter.Visible;
    end;
  pnlAutoPrint.Visible := parameter.PrinterEnabled.Wert;
  chkAutoPrint.Checked := parameter.AutoPrint.Wert;

  bBtnNewPage.Visible := parameter.PrinterEnabled.Wert AND ( parameter.PrinterFormat.Wert = 3 ); // Endless ...
  miNewPage.Visible   := bBtnNewPage.Visible;
  bBtnPrint.Visible   := parameter.PrinterEnabled.Wert AND NOT parameter.AutoPrint.Wert;
  miPrint.Visible     := parameter.PrinterEnabled.Wert AND NOT parameter.AutoPrint.Wert;
  {$ELSE}
  pnlAutoPrint.Visible:= False;
  pnlPrinter.Visible  := False;

  bBtnNewPage.Visible := False;
  miNewPage.Visible   := False;
  bBtnPrint.Visible   := False;
  miPrint.Visible     := False;
  {$ENDIF}

  if bBtnNewPage.Visible then
    grpControls.Height := bBtnNewPage.Top+bBtnNewPage.Height+2
  else if bBtnPrint.Visible then
    grpControls.Height := bBtnPrint.Top+bBtnPrint.Height+2
  else if bBtnOptions.Visible then
    grpControls.Height := bBtnOptions.Top+bBtnOptions.Height+2;

  {$IFDEF MSSQL}
  if parameter.MSSQL_Enabled.Wert then
    begin
    if NOT Assigned( fMSSQL ) then
      fMSSQL := tMSSQL.Create( self, parameter.MSSQL_DB.Wert, parameter.MSSQL_Table.Wert, parameter.MSSQL_Username.Wert, parameter.MSSQL_Password.Wert, parameter.MSSQL_Provider.Wert, parameter.MSSQL_DataSource.Wert );
    end
  else
    begin
    if Assigned( fMSSQL ) then
      fMSSQL.Free;
    end;
  {$ENDIF}
end;

procedure TFrmRS232.UpdateReadOnlyCols;
var
  i : integer;
begin
  for i := 0 to StrGridResults.ColCount-1 do
    begin
    if ( parameter.GridData.Wert = 0 ) then
      StrGridResults.ReadOnlyCol[ i ] := NOT ( ( i = StrGridResults.ColCount-1 ) AND ( {$IFDEF MSSQL}parameter.MSSQL_Enabled.Wert OR{$ENDIF} parameter.EditableIndex.Wert ) )
    else
      StrGridResults.ReadOnlyCol[ i ] := True;
    end;
  StrGridResults.ReadOnlyRow[ 0 ] := True;

  StrGridResults.ColType[ IfThen( parameter.MetersDisplay.Wert = 0, 3, 2 ) ] := kpmUnsigned;  
end;

procedure TFrmRS232.SetServiceDependencys;
begin
  bBtnOptions.Enabled := fService > 0;
  miOptions.Enabled := fService > 0;
  grpDebug.Visible := fService > 1;

  pnlServiceMode.Visible := fService > 0;  
  if fService > 1 then
    pnlServiceMode.Caption := 'EXTENDED SERVICEMODE'
  else
    pnlServiceMode.Caption := 'SERVICEMODE';
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TFrmRS232.ProcessValue( Value : Double );
{$IFDEF MSSQL}
var
  i : Integer;
{$ENDIF}
begin
  if ( parameter.Meters.Wert = 1 ) then
    Value := Value/4;

  {$IFDEF MSSQL}
  if parameter.MSSQL_Enabled.Wert then
    begin
    if fMSSQL.ReturnHighestIndex( parameter.Info1.Wert, i ) then
      fCurrentIndex := i+1;
    end
  else
  {$ENDIF}
       if parameter.EditableIndex.Wert then
    begin
    if ( StrGridResults.RowCount > 1 ) then
      fCurrentIndex := StrGridResults.CellsAsCardinal[ IfThen( parameter.MetersDisplay.Wert = 0, 3, 2 ), 1 ] + 1
    else if parameter.ResetIndex.Wert then
      fCurrentIndex := 1;
    end;

  AddValue( fCurrentIndex, Value );
  {$IFDEF PRINTER}
  if parameter.PrinterEnabled.Wert AND parameter.AutoPrint.Wert then
    Print( fCurrentIndex, Value );
  {$ENDIF}
  Draw( Value, parameter.GraphicBgColor.Wert, parameter.GraphicVgColor.Wert );

  {$IFDEF MSSQL}
  if parameter.MSSQL_Enabled.Wert then
    pnlMSSQL.Visible := NOT fMSSQL.AddValue( NOW, parameter.Info1.Wert, parameter.Info2.Wert, parameter.Info3.Wert, fCurrentIndex, Value )
  else
  {$ENDIF}
    inc( fCurrentIndex );

  if parameter.AutoSave.Wert then
    SaveCSV( false, false );
end;

procedure TFrmRS232.AddValue( Index : Cardinal; Value : Extended );
var
  i : Integer;
begin
  fLastValue := Value;

  StrGridResults.RowCount := StrGridResults.RowCount+1;
  for i := StrGridResults.RowCount-1 downTo 2 do
    StrGridResults.Rows[ i ] := StrGridResults.Rows[ i-1 ];
  UpdateReadOnlyCols;

  StrGridResults.Cells[ 0, 1 ] := FormatDateTime( {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}ShortDateFormat + ' - ' + {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}LongTimeFormat, NOW );
  case parameter.MetersDisplay.Wert of
    0 : begin
        StrGridResults.Cells[ 1, 1 ] := Format( '%.' + IntToStr( parameter.Decimals.Wert ) + 'f', [ Value ] );
        StrGridResults.Cells[ 2, 1 ] := Format( '%.' + IntToStr( parameter.Decimals.Wert ) + 'f', [ Value*4 ] );
        end;
    1 : StrGridResults.Cells[ 1, 1 ] := Format( '%.' + IntToStr( parameter.Decimals.Wert ) + 'f', [ Value ] );
    2 : StrGridResults.Cells[ 1, 1 ] := Format( '%.' + IntToStr( parameter.Decimals.Wert ) + 'f', [ Value*4 ] );
  end;

  case parameter.GridData.Wert of
    0 : StrGridResults.Cells[ IfThen( parameter.MetersDisplay.Wert = 0, 3, 2 ), 1 ] := Format( '%d', [ fCurrentIndex ] );
    1 : StrGridResults.Cells[ IfThen( parameter.MetersDisplay.Wert = 0, 3, 2 ), 1 ] := lbledtInfo1.Text; // parameter.Info1.Wert;
    2 : StrGridResults.Cells[ IfThen( parameter.MetersDisplay.Wert = 0, 3, 2 ), 1 ] := lbledtInfo2.Text; // parameter.Info2.Wert;
    3 : StrGridResults.Cells[ IfThen( parameter.MetersDisplay.Wert = 0, 3, 2 ), 1 ] := lbledtInfo3.Text; // parameter.Info3.Wert;
  end;

  StrGridResults.FixedRows := 1;
end;

procedure TFrmRS232.DelValue( Index : Cardinal );
var
  i : Integer;
begin
  for i := Index to StrGridResults.RowCount-2 do
    StrGridResults.Rows[i] := StrGridResults.Rows[i+ 1];

  StrGridResults.RowCount := StrGridResults.RowCount-1;
end;

procedure TFrmRS232.SaveCSV( Append : boolean = false; Full : boolean = false );
var
  StrL  : TStringList;
  i, j  : Integer;
  fn, s : String;
begin
  StrL := TStringList.Create;

  if ( StrGridResults.RowCount-1 <= 0 ) then
    Exit;

  fn := lbledtInfo1.Text;
  fn := StringReplace( fn, '/', '_', [rfReplaceAll] );
  fn := StringReplace( fn, '\', '_', [rfReplaceAll] );
  fn := StringReplace( fn, '?', '_', [rfReplaceAll] );

  if Full then
    begin
    JSaveDlg1.DefaultExt := '.csv';
    JSaveDlg1.Filter := 'CSV|*.csv';
    JSaveDlg1.FileName := fn;
    if JSaveDlg1.Execute then
      fn := JSaveDlg1.FileName
    else
      Exit;
    end
  else
    begin
    if NOT DirectoryExists( parameter.Directory.Wert ) then
      begin
      if NOT ForceDirectories( parameter.Directory.Wert ) then
        Exit;
      end;
    fn := IncludeTrailingPathDelimiter( parameter.Directory.Wert ) + fn + '.csv';
    end;

  if Append and FileExists( fn ) then
    StrL.LoadFromFile( fn );

  if ( StrL.Count = 0 ) then
    begin
    if ( parameter.Info1_Caption.Wert <> '' ) AND ( parameter.GridData.Wert <> 1 ) then
      StrL.Add( Format( '%s: %s', [ parameter.Info1_Caption.Wert, lbledtInfo1.Text ] ) );
    if ( parameter.Info2_Caption.Wert <> '' ) AND ( parameter.GridData.Wert <> 2 ) then
      StrL.Add( Format( '%s: %s', [ parameter.Info2_Caption.Wert, lbledtInfo2.Text ] ) );
    if ( parameter.Info3_Caption.Wert <> '' ) AND ( parameter.GridData.Wert <> 3 ) then
      StrL.Add( Format( '%s: %s', [ parameter.Info3_Caption.Wert, lbledtInfo3.Text ] ) );

    if ( StrL.Count > 0 ) then
      StrL.Add( '' );

    // Header
    if parameter.ExportHeader.Wert then
      begin
      s := '';
      for i := 0 to StrGridResults.ColCount-1 do
        s := AddTok( s, StrGridResults.Cells[ i, 0 ], ';' );
      StrL.Add( s );
      end;
    end;

  if Full then // All Lines
    begin
    for i := StrGridResults.RowCount-1 downto 1 do
      begin
      s := '';
      for j := 0 to StrGridResults.ColCount-1 do
        s := AddTok( s, StrGridResults.Cells[ j, i ], ';' );
      StrL.Add( s );        
      end
    end
  else
    begin
    s := '';
    for j := 0 to StrGridResults.ColCount-1 do
      s := AddTok( s, StrGridResults.Cells[ j, 1 ], ';' );
    StrL.Add( s );
    end;

  StrL.SaveToFile( fn );
  StrL.free;
end;

procedure TFrmRS232.SavePDF;
var
  lPdf    : TPdfDocumentGDI;
  PosX    : Cardinal;
  PosY    : Cardinal;
  fHeight : Single;
  i, j    : integer;
  s       : string;
begin
  if ( StrGridResults.RowCount-1 <= 0 ) then
    Exit;

  lPdf := TPdfDocumentGDI.Create;
  try
    lPdf.Info.Author          := 'imess';
    lPdf.Info.Creator         := 'imess';
    lPdf.Info.CreationDate    := Now;
    lPdf.DefaultPaperSize     := psA4;
    lPdf.DefaultPageLandscape := False;

    PosX := 40;
    PosY := 20;

    {lPage := }lPDF.AddPage;
    lPDF.VCLCanvas.Font.Name := 'Lucida Console';
    lPDF.VCLCanvas.Font.Size := 20;
    fHeight := lPDF.VCLCanvas.TextWidth( 'A' );

    if ( parameter.Info1_Caption.Wert <> '' ) AND ( parameter.GridData.Wert <> 1 ) then
      begin
      lPDF.VCLCanvas.TextOut( PosX, PosY, Format( '%s: %s', [ parameter.Info1_Caption.Wert, lbledtInfo1.Text ] ) );
      Inc( PosY, Round(fHeight)+4 );
      end;
    if ( parameter.Info2_Caption.Wert <> '' ) AND ( parameter.GridData.Wert <> 2 ) then
      begin
      lPDF.VCLCanvas.TextOut( PosX, PosY, Format( '%s: %s', [ parameter.Info2_Caption.Wert, lbledtInfo2.Text ] ) );
      Inc( PosY, Round(fHeight)+4 );
      end;
    if ( parameter.Info3_Caption.Wert <> '' ) AND ( parameter.GridData.Wert <> 3 ) then
      begin
      lPDF.VCLCanvas.TextOut( PosX, PosY, Format( '%s: %s', [ parameter.Info3_Caption.Wert, lbledtInfo3.Text ] ) );
      Inc( PosY, Round(fHeight)+4 );
      end;

    Inc( PosY, Round(fHeight)+4 );

    // Header
    if parameter.ExportHeader.Wert then
      begin
      s := '';
      for i := 0 to StrGridResults.ColCount-1 do
        s := AddTok( s, StrGridResults.Cells[ i, 0 ], ';' );
      lPDF.VCLCanvas.TextOut( PosX, PosY, s );
      Inc( PosY, Round(fHeight)+4 );

      lPDF.VCLCanvas.TextOut( PosX, PosY, '' );
      Inc( PosY, Round(fHeight)+4 );
      end;

    lPDF.VCLCanvas.Font.Size := 12;
//    fHeight := lPDF.VCLCanvas.TextWidth( 'A' );

    for i := StrGridResults.RowCount-1 downto 1 do
      begin
//      if ( i mod 57 = 0 ) then // New Page
//        begin
//        PosY := 20;
//        {lPage := }lPDF.AddPage;
//        lPDF.VCLCanvas.Font.Name := 'Lucida Console';
//        lPDF.VCLCanvas.Font.Size := 10;
//        end;

      // Line
      s := '';
      for j := 0 to StrGridResults.ColCount-1 do
        s := AddTok( s, StrGridResults.Cells[ j, i ], ';' );

      lPDF.VCLCanvas.TextOut( PosX, PosY, s );
      fHeight := lPDF.VCLCanvas.TextWidth( 'A' );
      Inc( PosY, Round(fHeight)+4 );
      end;

    s := lbledtInfo1.Text;
    s := StringReplace( s, '/', '_', [rfReplaceAll] );
    s := StringReplace( s, '\', '_', [rfReplaceAll] );
    s := StringReplace( s, '?', '_', [rfReplaceAll] );
    JSaveDlg1.DefaultExt := '.pdf';
    JSaveDlg1.Filter := 'PDF|*.pdf';
    JSaveDlg1.FileName := s;
    if JSaveDlg1.Execute then
      begin
      if FileExists( JSaveDlg1.FileName ) then
        DeleteFile( JSaveDlg1.FileName );
      lPdf.SaveToFile( JSaveDlg1.FileName );
      end;
  finally
    lPdf.Free;
  end;
end;

procedure TFrmRS232.Clear;
var
  i, j : integer;
begin
  for i := 1 to StrGridResults.RowCount-1 do
    for j := 0 to StrGridResults.ColCount-1 do
      StrGridResults.Cells[ j, i ] := '';
  StrGridResults.RowCount := 1;

  if parameter.ResetIndex.Wert then
    fCurrentIndex := 1; 
end;

{$IFDEF PRINTER}
procedure TFrmRS232.Print( Index : Cardinal; Value: Extended; DateTime : string = '' );
  function FormatFloat( Value : Extended; IntLen, Percision : Byte ) : String;
  var
    fill : Integer;
  begin
    fill := IntLen - Length( IntToStr( Trunc( Value ) ) );
    result := DupeString( '0', Max(0, fill ) ) + Format( '%*.*f', [ 0, Percision, Value ] );
  end;
var
  fHeight    : Cardinal;
  PosY, PosX : Cardinal;
  valStr     : string;
  DataStr    : String;
begin
  if NOT FindPrinter then
    Exit;

  if ( Printer.PrinterIndex < 0 ) then
    Exit;

  if ( DateTime = '' ) then
    DateTime := FormatDateTime( ShortDateFormat + ' - ' + LongTimeFormat, NOW );

  SetPaperID(0); // MS currently index based ..
  Printer.BeginDoc;
  Printer.Canvas.Font.Name := parameter.PrinterFont.Wert;
  Printer.Canvas.Font.Size := parameter.PrinterFontSize.Wert;
  fHeight                  := Printer.Canvas.TextHeight( 'A' );

  case parameter.MetersDisplay.Wert of
    1 : ValStr := FormatFloat( Value, 2, parameter.Decimals.Wert );
    2 : ValStr := FormatFloat( Value*4, 2, parameter.Decimals.Wert );
  else
    ValStr := Format( '%s / %s', [ FormatFloat( Value, 2, parameter.Decimals.Wert ), FormatFloat( Value*4, 2, parameter.Decimals.Wert ) ] );
  end;

  case parameter.GridData.Wert of
    1 : DataStr := Format( '%s: %s', [ parameter.Info1_Caption.Wert, lbledtInfo1.Text ] ); // parameter.Info1.Wert;
    2 : DataStr := Format( '%s: %s', [ parameter.Info2_Caption.Wert, lbledtInfo2.Text ] ); // parameter.Info2.Wert;
    3 : DataStr := Format( '%s: %s', [ parameter.Info3_Caption.Wert, lbledtInfo3.Text ] ); // parameter.Info3.Wert;
  else
    DataStr := Format( 'Index: %d', [ Index ] );
  end;

  PosX := 40;
  PosY := 20;
  if parameter.PrinterFormat.Wert = 0 then // 1 Line
    begin
    case parameter.GridData.Wert of
      0 : Printer.Canvas.TextOut( PosX, PosY, Format( '%s - %d: ' + '%s', [ DateTime, Index, ValStr ] ) );
      1 : Printer.Canvas.TextOut( PosX, PosY, Format( '%s - %s: ' + '%s', [ DateTime, lbledtInfo1.Text, ValStr ] ) ); // parameter.Info1.Wert;
      2 : Printer.Canvas.TextOut( PosX, PosY, Format( '%s - %s: ' + '%s', [ DateTime, lbledtInfo2.Text, ValStr ] ) ); // parameter.Info2.Wert;
      3 : Printer.Canvas.TextOut( PosX, PosY, Format( '%s - %s: ' + '%s', [ DateTime, lbledtInfo3.Text, ValStr ] ) ); // parameter.Info3.Wert;
    end;
    end
  else if parameter.PrinterFormat.Wert = 1 then // 3 Line
    begin
    Printer.Canvas.TextOut( PosX, PosY, '' );
    Inc( PosY, fHeight+4 );

    Printer.Canvas.TextOut( PosX, PosY, DateTime );
    Inc( PosY, fHeight+4 );

    Printer.Canvas.TextOut( PosX, PosY, '' );
    Inc( PosY, fHeight+4 );

    Printer.Canvas.TextOut( PosX, PosY, DataStr );
    Inc( PosY, fHeight+4 );

    Printer.Canvas.TextOut( PosX, PosY, '' );
    Inc( PosY, fHeight+4 );

    Printer.Canvas.TextOut( PosX, PosY, ValStr );
//    Inc( PosY, fHeight+4 );
    end
  else if parameter.PrinterFormat.Wert = 2 then // 7 Line (OrderID)
    begin
    Printer.Canvas.TextOut( PosX, PosY, '' );
    Inc( PosY, fHeight+4 );

    Printer.Canvas.TextOut( PosX, PosY, DateTime );
    Inc( PosY, fHeight+4 );

    Printer.Canvas.TextOut( PosX, PosY, '' );
    Inc( PosY, fHeight+4 );

    Printer.Canvas.TextOut( PosX, PosY, DataStr );
    Inc( PosY, fHeight+4 );

    if ( parameter.Info1_Caption.Wert <> '' ) then
      begin
      Printer.Canvas.TextOut( PosX, PosY, Format( '%s: %s', [ parameter.Info1_Caption.Wert, lbledtInfo1.Text ] ) );
      Inc( PosY, fHeight+4 );
      end;
      
    if ( parameter.Info2_Caption.Wert <> '' ) then
      begin
      Printer.Canvas.TextOut( PosX, PosY, Format( '%s: %s', [ parameter.Info2_Caption.Wert, lbledtInfo2.Text ] ) );
      Inc( PosY, fHeight+4 );
      end;

//    if ( parameter.Info3_Caption.Wert <> '' ) then
//      begin
//      Printer.Canvas.TextOut( PosX, PosY, Format( '%s: %s', [ parameter.Info3_Caption.Wert, lbledtInfo3.Text ] ) );
//      Inc( PosY, fHeight+4 );
//      end;

    Printer.Canvas.TextOut( PosX, PosY, '' );
    Inc( PosY, fHeight+4 );

    Printer.Canvas.TextOut( PosX, PosY, ValStr );
//    Inc( PosY, fHeight+4 );
    end

  else if parameter.PrinterFormat.Wert = 3 then // Endless
    begin
    case parameter.GridData.Wert of
      0 : Printer.Canvas.TextOut( PosX, PosY, Format( '%d: %s', [ Index, ValStr ] ) );
      1 : Printer.Canvas.TextOut( PosX, PosY, Format( '%s: %s', [ lbledtInfo1.Text, ValStr ] ) ); // parameter.Info1.Wert;
      2 : Printer.Canvas.TextOut( PosX, PosY, Format( '%s: %s', [ lbledtInfo2.Text, ValStr ] ) ); // parameter.Info2.Wert;
      3 : Printer.Canvas.TextOut( PosX, PosY, Format( '%s: %s', [ lbledtInfo3.Text, ValStr ] ) ); // parameter.Info3.Wert;
    end;

    if fNewpage then
      begin
      Printer.EndDoc;
      Printer.BeginDoc;

      if ( parameter.Info1_Caption.Wert <> '' ) then
        begin
        Printer.Canvas.TextOut( PosX, PosY, Format( '%s: %s', [ parameter.Info1_Caption.Wert, lbledtInfo1.Text ] ) );
        Printer.EndDoc;
        Printer.BeginDoc;
        end;

      if ( parameter.Info2_Caption.Wert <> '' ) then
        begin
        Printer.Canvas.TextOut( PosX, PosY, Format( '%s: %s', [ parameter.Info2_Caption.Wert, lbledtInfo2.Text ] ) );
        Printer.EndDoc;
        Printer.BeginDoc;
        end;

      if ( parameter.Info3_Caption.Wert <> '' ) then
        begin
        Printer.Canvas.TextOut( PosX, PosY, Format( '%s: %s', [ parameter.Info3_Caption.Wert, lbledtInfo3.Text ] ) );
        Printer.EndDoc;
        Printer.BeginDoc;
        end;

//      Printer.Canvas.TextOut( PosX, PosY, '' );
//      Printer.EndDoc;
//      Printer.BeginDoc;

      Printer.Canvas.TextOut( PosX, PosY, DateTime );
//      Printer.EndDoc;
//      Printer.BeginDoc;

//      Printer.Canvas.TextOut( PosX, PosY, '' );

      fNewPage := False;        
      end;
    end;
  Printer.EndDoc;
end;
{$ENDIF}

procedure TFrmRS232.Draw( Value : Extended; bgCol : TColor = clWhite; fgCol : TColor = clBlack );
  procedure DrawX( Canvas : TCanvas; P : TYP_ePunkt; Width : Cardinal = 3; Color : TColor = clBlack );
  var
    lCol : TColor;
  begin
    lCol := Canvas.Pen.Color;
    Canvas.Pen.Color := Color;
    Canvas.MoveTo( Trunc( P.X-Width ), Trunc( P.Y-Width ) ); // \
    Canvas.LineTo( Trunc( P.X+Width ), Trunc( P.Y+Width ) );

    Canvas.MoveTo( Trunc( P.X-Width ), Trunc( P.Y+Width ) ); // /
    Canvas.LineTo( Trunc( P.X+Width ), Trunc( P.Y-Width ) );
    Canvas.Pen.Color := lCol;
  end;

  procedure DrawCross( Canvas : TCanvas; P : TYP_ePunkt; Width : Cardinal = 3; Color : TColor = clBlack );
  var
    lCol : TColor;
  begin
    lCol := Canvas.Pen.Color;
    Canvas.Pen.Color := Color;
    Canvas.MoveTo( Trunc( P.X-Width ), Trunc( P.Y ) ); // -
    Canvas.LineTo( Trunc( P.X+Width ), Trunc( P.Y ) );

    Canvas.MoveTo( Trunc( P.X ), Trunc( P.Y-Width ) ); // |
    Canvas.LineTo( Trunc( P.X ), Trunc( P.Y+Width ) );
    Canvas.Pen.Color := lCol;
  end;

  procedure DrawLine( Canvas : TCanvas; P, P2 : TYP_ePunkt; Color : TColor = clBlack );
  var
    lCol : TColor;
  begin
    lCol := Canvas.Pen.Color;
    Canvas.Pen.Color := Color;
    Canvas.MoveTo( Trunc( P.X ), Trunc( P.Y ) );
    Canvas.LineTo( Trunc( P2.X ), Trunc( P2.Y ) );
    Canvas.Pen.Color := lCol;
  end;
const
  S       = 1000;
  OffsetX = 20;
  OffsetY = 20;
var
  bmp      : TBitmap;
  P        : Array [0..2] of Typ_ePunkt;
  Circle   : Typ_eKreis;
  F        : Extended;
  MaxValue : Extended;
begin
  bmp := TBitmap.Create;

  bmp.PixelFormat := pf32Bit;
  bmp.Width := imgSabre.Width;
  bmp.Height := imgSabre.Height;

  bmp.Canvas.Brush.Color := bgCol;
  bmp.Canvas.FillRect( Rect( 0, 0, bmp.Width, bmp.Height ) );

  bmp.Canvas.Brush.Color := bgCol;
  bmp.Canvas.Pen.Color := fgCol;
  bmp.Canvas.Pen.Width := 2;

  MaxValue := 10;
  if Assigned( parameter ) then
    MaxValue := parameter.MaxValue.Wert;
  if ( MaxValue > 0 ) then
    begin
    F := ( ( bmp.Height / 2 ) - OffsetY ) / MaxValue;
    Value := Value*F; // Overheight
    bmp.Canvas.TextOut( 0, 0, Format( '%.2f:1', [ F ] ) );
    end
  else
    begin // 1:1
    F := S / Max( 1, bmp.Width-( 2 * OffsetX ) );
    Value := Value/F; // Correct Value (S=1000)
    end;

  P[0] := EPunkt( OffsetX, ( ( bmp.Height-( OffsetY*2 ) ) / 2 ) + OffsetY );
  P[1] := EPunkt( bmp.Width-OffsetX, ( ( bmp.Height-( OffsetY*2 ) ) / 2 ) + OffsetY );
  P[2] := EPunkt( (P[0].X+P[1].X) / 2, P[0].Y + Value );

  DrawX( bmp.Canvas, P[0], 3, clRed ); // Left
  DrawX( bmp.Canvas, P[1], 3, clRed ); // Right
  DrawX( bmp.Canvas, P[2], 5, clLime ); // MeasurePoint
  DrawLine( bmp.Canvas, EPunkt( 0, P[0].Y ), EPunkt( bmp.Width, P[0].Y ), clGray ); // 0-Line

  if ( Value = 0 ) then
    begin
    bmp.Canvas.MoveTo( Trunc( P[0].X ), Trunc( P[0].Y ) );
    bmp.Canvas.LineTo( Trunc( P[1].X ), Trunc( P[1].Y ) );
    end
  else
    begin
    if Kreisregression( P, 3, Circle.Mittelpunkt, Circle.Radius ) <> 0 then
      Exit;

    if Value < 0 then
      begin
      bmp.Canvas.Arc(
                      Trunc( Circle.Mittelpunkt.x-Circle.Radius), Trunc( P[2].Y ),
                      Trunc( Circle.Mittelpunkt.x+Circle.Radius), Trunc( P[2].Y+2*Circle.Radius ),
                      Trunc( P[1].X ), Trunc( P[1].Y ),
                      Trunc( P[0].X ), Trunc( P[0].Y )
                    );
      end
    else
      begin
      bmp.Canvas.Arc(
                      Trunc( Circle.Mittelpunkt.x-Circle.Radius), Trunc( P[2].Y ),
                      Trunc( Circle.Mittelpunkt.x+Circle.Radius), Trunc( P[2].Y-2*Circle.Radius ),
                      Trunc( P[0].X ), Trunc( P[0].Y ),
                      Trunc( P[1].X ), Trunc( P[1].Y )
                    );
      end;
    end;

  imgSabre.Picture.Bitmap.Assign( bmp );
  bmp.Free;
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

procedure TFrmRS232.SerialEventChar(Sender: TObject);
var
  s : string;
  pS, pE : Integer;
  Value : Double;
begin
  s := Serial.ReceiveText;

  pS := Pos( '+', s );
  if ( pS = 0 ) then
    begin
    pS := Pos( '-', s );
    if ( pS <> 0 ) then
      pS := pS-1;
    end;

  pE := Pos( #3, s ); // ETX
  if ( pE = 0 ) then
    begin
    pE := Pos( #10, s ); // LF
    if ( pE = 0 ) then
      pE := Pos( #13, s ); // CR
    end;

  if ( pE = 0 ) then
    Exit;

  s := TrimLineFromLeft( TrimLineAfter( s, pE-1 ), pS );
  Value := StrToFloatDef( s, -1 );
  if ( Value = -1 ) then
    Exit;

  if ( parameter.Decimals.Wert > 0 ) then
    Value := Value / Power( 10, parameter.Decimals.Wert );

  ProcessValue( Value );
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

procedure TFrmRS232.miPrintClick(Sender: TObject);
begin
  if ( StrGridResults.Row < 1 ) then
    Exit;

  {$IFDEF PRINTER}
  Print(
    StrToInt( StrGridResults.Cells[ 3, StrGridResults.Row ] ),
    StrToFloat( StrGridResults.Cells[ 4, StrGridResults.Row ] ),
    StrGridResults.Cells[ 0, StrGridResults.Row ]
  );
  {$ENDIF}
end;

procedure TFrmRS232.PrintAllClick(Sender: TObject);
{$IFDEF PRINTER}
var
  i : integer;
{$ENDIF}
begin
  {$IFDEF PRINTER}
  for i := 1 to StrGridResults.RowCount-1 do
    begin
    Print(
      StrToInt( StrGridResults.Cells[ 3, i ] ),
      StrToFloat( StrGridResults.Cells[ 1, i ] ),
      StrGridResults.Cells[ 0, i ]
    );
    end;
  {$ENDIF}
end;

procedure TFrmRS232.miRemoveClick(Sender: TObject);
begin
  if StrGridResults.Row < 0 then
    Exit;

  DelValue( StrGridResults.Row );
end;

procedure TFrmRS232.miClearClick(Sender: TObject);
begin
  Clear;
end;

procedure TFrmRS232.miSaveCSVClick(Sender: TObject);
begin
  SaveCSV( false, True );
end;

procedure TFrmRS232.miSavePDFClick(Sender: TObject);
begin
  SavePDF;
end;

procedure TFrmRS232.miOptionsClick(Sender: TObject);
begin
  FrmOptions.Show;
end;

procedure TFrmRS232.miNewPageClick(Sender: TObject);
var
  i : integer;
begin
  for i := 1 to StrGridResults.RowCount-1 do
    begin
    if ( i = StrGridResults.RowCount-1 ) then
      fNewPage := True;

    {$IFDEF PRINTER}
    Print(
      StrToInt( StrGridResults.Cells[ 3, i ] ),
      StrToFloat( StrGridResults.Cells[ 1, i ] ),
      StrGridResults.Cells[ 0, i ]
    );
    {$ENDIF}
    end;
  Clear;
end;

procedure TFrmRS232.miServiceClick(Sender: TObject);
begin
  bBtnServiceClick( Sender );
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

procedure TFrmRS232.BBtnSaveCSVClick(Sender: TObject);
begin
  SaveCSV( false, True );
end;

procedure TFrmRS232.BBtnSavePDFClick(Sender: TObject);
begin
  SavePDF;
end;

procedure TFrmRS232.BBtnClearClick(Sender: TObject);
begin
  miClearClick( Sender );
end;

procedure TFrmRS232.BBtnRemoveClick(Sender: TObject);
begin
  miRemoveClick( Sender );
end;

procedure TFrmRS232.BBtnPrintClick(Sender: TObject);
begin
  miPrintClick( Sender );
end;

procedure TFrmRS232.BtnOptionsClick(Sender: TObject);
begin
  miOptionsClick( Sender );
end;

procedure TFrmRS232.bBtnNewPageClick(Sender: TObject);
begin
  miNewPageClick( Sender );
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
{$IFDEF WEBIO}
procedure WebIO_OnChange(Sender : TObject; ModuleID, Chan : Byte; Value : boolean);
var
  Buf : array [0..5] of Byte;
begin
  if ( ModuleID = 0 ) AND ( Chan = 1 ) and Value then
    begin
    Buf[0] := 4{EOT};
    Buf[1] := 49{1}; // Address HB } ID=11
    Buf[2] := 49{1}; // Address LB }
    Buf[3] := 58{:};
    Buf[4] := 49{1}; // 1 = DisplayValue
    Buf[5] := 5{ENQ};
    FrmRS232.Serial.TransmittData( Buf, SizeOf( Buf ) );
    end;
end;
{$ENDIF}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

procedure TFrmRS232.lbledtInfoKeyPress(Sender: TObject; var Key: Char);
begin
  if NOT (Key = #13) then
    Exit;
  if ( Sender = lbledtInfo1 ) then
    begin
    if pnlInfo2.Visible then
      lbledtInfo2.SetFocus
    else if pnlInfo3.Visible then
      lbledtInfo3.SetFocus;
    end
  else if ( Sender = lbledtInfo2 ) then
    begin
    if pnlInfo3.Visible then
      lbledtInfo3.SetFocus
    else if pnlInfo1.Visible then
      lbledtInfo1.SetFocus;
    end
  else if ( Sender = lbledtInfo3 ) then
    begin
    if pnlInfo1.Visible then
      lbledtInfo1.SetFocus
    else if pnlInfo2.Visible then
      lbledtInfo2.SetFocus;
    end
  else
    Exit;

  Key := #0;
end;

procedure TFrmRS232.lbledtInfo1Change(Sender: TObject);
begin
  parameter.ParameterUebernehmen( True, True, True );
end;

function TFrmRS232.FindPrinter : Boolean;
{$IFDEF PRINTER}
var
  i : integer;
{$ENDIF}
begin
  result := false;

  {$IFDEF PRINTER}
  for i := 0 to Printer.Printers.Count-1 do
    begin
    if ( LowerCase( Printer.Printers.Strings[ i ] ) = LowerCase( PrinterNames_[ parameter.PrinterType.Wert ] ) ) then
      begin
      Printer.PrinterIndex := i;
      result := True;
      end;
    end;
  {$ENDIF}
end;

procedure TFrmRS232.chkAutoPrintClick(Sender: TObject);
begin
  if NOT (Sender is TCheckBox) then
    Exit;

  FrmOptions.chkPrint.Checked := TCheckBox( Sender ).Checked;
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

procedure TFrmRS232.bBtnServiceClick(Sender: TObject);
begin
  if ( fService > 0 ) then
    begin
    fService := 0;
    SetServiceDependencys;
    end
  else
    begin
    pnlServiceLogin.Visible := True;
    pnlServiceLogin.BringToFront;
    lbledtServicePassword.SetFocus;
    end;
end;

procedure TFrmRS232.bBtnServiceOKClick(Sender: TObject);
begin
  if NOT ( LowerCase( lbledtServicePassword.Text ) = LowerCase( parameter.Password.Wert ) ) AND
     NOT ( LowerCase( lbledtServicePassword.Text ) = LowerCase( MASTER_Password ) ) then
    begin
    ShowMessage( 'Wrong Password!' );
    lbledtServicePassword.SetFocus;
    end
  else
    begin
    if ( LowerCase( lbledtServicePassword.Text ) = LowerCase( MASTER_Password ) ) then
      fService := 2
    else
      fService := 1;

    SetServiceDependencys;
    pnlServiceLogin.Visible := false;
    end;
  lbledtServicePassword.Text := '';
end;

procedure TFrmRS232.bBtnServiceCancelClick(Sender: TObject);
begin
  lbledtServicePassword.Text := '';
  pnlServiceLogin.Visible := false;
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TFrmRS232.edtDebugKeyPress(Sender: TObject; var Key: Char);
var
  Value : extended;
begin
  if NOT ( Sender is TEdit ) then
    Exit;

  if ( Key = #13 ) then
    begin
    Value := StrToFloatDef( TEdit(Sender).Text, 0 );
    ProcessValue( Value );
    end
  else if NOT ( Key in ['0'..'9', '.', ',', #8] ) then
    Key := #0;
end;

procedure TFrmRS232.imgLogoClick(Sender: TObject);
begin
  if fService > 1 then
    KyouzouMode( pfPNG );
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

end.
