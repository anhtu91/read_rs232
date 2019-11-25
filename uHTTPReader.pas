unit uHTTPReader;

interface

uses
  Classes, SysUtils;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
type
  tHTTPReaderThread = class(TThread)
  private
    fIP        : string;
    fPort      : Word;
    fRunning   : Boolean;
    fFrequency : Cardinal;
    fOutput    : Double;
    fLFS       : TFormatSettings;
    procedure   SetFrequency( Value : Cardinal );
    procedure   ProcessValue;
    procedure   SetRunning_( Value : Boolean );
    procedure   SetIP( Value : String );
  protected
    procedure   Execute; override;
  public
    constructor Create( CreateSuspended : boolean = false ); reintroduce;
    destructor  Destroy; override;
    function    SetRunning( Value : Boolean ): boolean;

    property    IP        : string   read fIP        write SetIP;
    property    Port      : Word     read fPort      write fPort;
    property    Running   : boolean  read fRunning   write SetRunning_;
    property    Frequency : Cardinal read fFrequency write SetFrequency;
  end;

var
  HTTPReaderThread : tHTTPReaderThread;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

implementation

uses
  Windows, PingSend, uTLH.Strings,
  httpsend,
  Main;

const
  DEFAULT_IP_   = '192.168.1.100';
  DEFAULT_PORT_ = 8080;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
constructor tHTTPReaderThread.Create( CreateSuspended : boolean = false );
begin
  fIP        := DEFAULT_IP_;
  fPort      := DEFAULT_PORT_;
  fRunning   := false;
  fOutput    := 0;
  fFrequency := 250;
  GetLocaleFormatSettings( 0, fLFS );
  fLFS.DecimalSeparator := ',';

  inherited;
end;

destructor tHTTPReaderThread.Destroy;
begin
  inherited;
end;

procedure tHTTPReaderThread.Execute;
  function HttpGetText(const URL: string; const Response: TStrings): Boolean;
  var
    HTTP: THTTPSend;
  begin
    HTTP := THTTPSend.Create;
    try
      HTTP.KeepAliveTimeout := 500;
      Result := HTTP.HTTPMethod('GET', URL);
      if Result then
        Response.LoadFromStream(HTTP.Document);
    finally
      HTTP.Free;
    end;
  end;

var
  S : TStringList;
begin
  S := TStringList.Create;
  while NOT Terminated do
    begin
    if NOT fRunning OR ( fIP = '' ) then
      begin
      Sleep( 500 );
      Continue;
      end;

    if HttpGetText( 'http://' + fIP + ':' + IntToStr( fPort ) + '/', S ) then
      begin
      if ( S.Count = 1 ) then
        begin
        fOutput := StrToFloatDef( S[ 0 ], 0, fLFS );
        Synchronize( ProcessValue );
        end;
      end;

    Sleep( fFrequency );
    end;
  S.free;
end;

procedure tHTTPReaderThread.SetRunning_( Value : Boolean );
begin
  SetRunning( Value );
end;

procedure tHTTPReaderThread.SetIP( Value : String );
begin
  if NOT Assigned( self ) then
    Exit;
  if ( fIP = Value ) then
    Exit;
  if NOT IsIPv4( Value ) then
    Exit;
  fIP := Value;
end;

function tHTTPReaderThread.SetRunning( Value : Boolean ): boolean;
begin
  result := false;
  if NOT Assigned( self ) then
    Exit;
  if ( fRunning = Value ) then
    Exit;
  if Value then
    begin
    if ( PingHost( fIP ) < 0 ) then
      Exit;
    end;

  fRunning := Value;
  result := True;
end;

procedure tHTTPReaderThread.SetFrequency( Value : Cardinal );
begin
  if NOT Assigned( self ) then
    Exit;
  if ( fFrequency = Value ) then
    Exit;
  if ( fFrequency < 1 ) OR ( fFrequency > 5*60000 ) then
    Exit;
  fFrequency := Value;
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure tHTTPReaderThread.ProcessValue; // Synchronized since its probably accessing VCL ..
begin
  FrmRS232.ProcessValue( fOutput );
  fOutput := 0;
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TerminateAndFree;
begin
  if NOT Assigned( HTTPReaderThread ) then
    Exit;

  if HTTPReaderThread.Running then
    HTTPReaderThread.Running := False;

  if NOT HTTPReaderThread.Terminated then
    begin
    HTTPReaderThread.Terminate;
    while NOT HTTPReaderThread.Terminated do
      Sleep( 10 );
    HTTPReaderThread.free;
    end;
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

initialization
//  HTTPReaderThread := tHTTPReaderThread.Create( false );

finalization
  TerminateAndFree;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

end.
