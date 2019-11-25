unit uFrmOptions;

{$I SMP.inc}

interface

uses
  SysUtils, Classes, Controls, Forms, SerDlgs, StdCtrls, ExtCtrls, ComCtrls, Buttons, 
  JvComCtrls, JvSelectDirectory, JvExControls,
  uParameter
  {$IFDEF BARCODE},RawInputKeyboardHook{$ENDIF}
  ;

type
  TFrmOptions = class(TForm)
    pgcOptions: TPageControl;
    tsGeneral: TTabSheet;
    grpGeneral: TGroupBox;
    lblDecimal: TLabel;
    lblEdtMaxValue: TLabeledEdit;
    lblEdtDirectory: TLabeledEdit;
    btnDirectory: TButton;
    cbbDecimal: TComboBox;
    tsRS232: TTabSheet;
    grpRS232: TGroupBox;
    lblSerialPort: TLabel;
    lblSerialBaudrate: TLabel;
    lblSerialDataBits: TLabel;
    lblSerialParity: TLabel;
    lblSerialStopBits: TLabel;
    lblDataFormat: TLabel;
    cbbSerialDataBits: TSerDataBitsComboBox;
    cbbSerialParity: TSerParityBitComboBox;
    cbbSerialPort: TSerPortComboBox;
    cbbSerialStop: TSerStopBitsComboBox;
    cbbSerialBaud: TSerBaudComboBox;
    chkSerialActive: TCheckBox;
    cbbDataFormat: TComboBox;
    tsWebIO: TTabSheet;
    grpWebIO: TGroupBox;
    lblIP: TLabel;
    lblEdtPort: TLabeledEdit;
    lbledtPassword: TLabeledEdit;
    chkUseWebIO: TCheckBox;
    jvIPEdtIP: TJvIPAddress;
    tsMSSQL: TTabSheet;
    datenbankGruppe: TGroupBox;
    chkMSSQL_Enabled: TCheckBox;
    lbledtMSSQL_Server: TLabeledEdit;
    lbledtMSSQL_User: TLabeledEdit;
    lbledtMSSQL_Password: TLabeledEdit;
    lbledtMSSQL_DB: TLabeledEdit;
    lbledtMSSQL_Table: TLabeledEdit;
    tsPrinter: TTabSheet;
    grpPrinter: TGroupBox;
    chkPrint: TCheckBox;
    cbbPrinterFormat: TComboBox;
    chkPrinter_Enabled: TCheckBox;
    lbledtMSSQL_Provider: TLabeledEdit;
    lbledtMSSQL_DataSource: TLabeledEdit;
    tsBarcode: TTabSheet;
    grpBarcodeDevice: TGroupBox;
    lbledtBarcodeHID: TLabeledEdit;
    tsPassword: TTabSheet;
    grpPassword: TGroupBox;
    lbledtPasswordCurrent: TLabeledEdit;
    lbledtPasswordNew: TLabeledEdit;
    btnPasswordApply: TButton;
    lbledtBarcodeText: TLabeledEdit;
    btnBarcodeTeachIn: TButton;
    grpBarcodeTarget: TGroupBox;
    cbbBarcodeTarget: TComboBox;
    chkBarcodeEnabled: TCheckBox;
    pnlControls: TPanel;
    btnApply: TBitBtn;
    btnSaveClose: TBitBtn;
    btnCancel: TBitBtn;
    lbledtPasswordNewRetype: TLabeledEdit;
    grpLanguage: TGroupBox;
    cbbLanguage: TComboBox;
    rgMeters: TRadioGroup;
    rgMetersDisplay: TRadioGroup;
    grpInfos: TGroupBox;
    lbledtInfo2: TLabeledEdit;
    lbledtInfo1: TLabeledEdit;
    lbledtInfo3: TLabeledEdit;
    rgGridData: TRadioGroup;
    rgPrinterType: TRadioGroup;
    chkAutoSave: TCheckBox;
    chkExportHeader: TCheckBox;
    chkEditableIndex: TCheckBox;
    chkResetIndex: TCheckBox;
    tsEthernet: TTabSheet;
    grpEthernetIP: TGroupBox;
    jvIPEdtEthernet: TJvIPAddress;
    lbledtEthernet_Port: TLabeledEdit;
    lblEthernetIP: TLabel;
    chkEthernet_Active: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure jvIPEdtIPExit(Sender: TObject);
    procedure chkSerialActiveClick(Sender: TObject);
    procedure cbbDataFormatChange(Sender: TObject);
    procedure chkUseWebIOClick(Sender: TObject);
    procedure chkUseDB(Sender: TObject);
    procedure cbbDataFormatKeyPress(Sender: TObject; var Key: Char);
    procedure cbbDecimalChange(Sender: TObject);
    procedure cbbDecimalKeyPress(Sender: TObject; var Key: Char);
    procedure cbbPrinterFormatChange(Sender: TObject);
    procedure btnDirectoryClick(Sender: TObject);
    procedure lblEdtMaxValueKeyPress(Sender: TObject; var Key: Char);
    procedure chkPrinter_EnabledClick(Sender: TObject);
    procedure grpLanguageDblClick(Sender: TObject);
    procedure btnPasswordApplyClick(Sender: TObject);
    {$IFDEF BARCODE}
    function  RawKeyEvent( Sender : TObject; RI : tagRAWINPUT ) : Boolean;
    {$ENDIF}
    procedure btnParameters(Sender: TObject);        
    procedure btnBarcodeTeachInClick(Sender: TObject);
    procedure chkBarcodeEnabledClick(Sender: TObject);
    procedure rgGridDataClick(Sender: TObject);
  private
    { Private-Deklarationen }
    {$IFDEF BARCODE}
    fBarcodeTeachIn     : boolean;
    fBarcodeLastReceive : Cardinal;
    fBarcodeLastText    : String;
    {$ENDIF}
    procedure InitParameter;
    procedure SetParameterDependencys;
  public
    { Public-Deklarationen }
  end;

  tParameter = class( T_INI_DATEI )
    // RS232
    Serial_Port     : T_PARAM_NR;
    Serial_Baudrate : T_PARAM_NR;
    Serial_DataBits : T_PARAM_NR;
    Serial_Parity   : T_PARAM_NR;
    Serial_StopBits : T_PARAM_NR;
    Serial_Format   : T_PARAM_NR;

    {$IFDEF PRINTER}
    // Printer
    PrinterType     : T_PARAM_NR;
    PrinterFont     : T_PARAM_STR;
    PrinterFontSize : T_PARAM_INT;
    AutoPrint       : T_PARAM_BOOL;
    PrinterFormat   : T_PARAM_NR;
    PrinterEnabled  : T_PARAM_BOOL;
    {$ENDIF}

    {$IFDEF WEBIO}
    // WebIO
    WebIO_Active    : T_PARAM_BOOL;
    WebIO_IP        : T_PARAM_STR;
    WebIO_Port      : T_PARAM_INT;
    WebIO_Password  : T_PARAM_STR;
    {$ENDIF}

    {$IFDEF MSSQL}
    // MSSQL
    MSSQL_Enabled   : T_PARAM_BOOL;
    MSSQL_Server    : T_PARAM_STR;
    MSSQL_Provider  : T_PARAM_STR;
    MSSQL_DataSource: T_PARAM_STR;
    MSSQL_Username  : T_PARAM_STR;
    MSSQL_Password  : T_PARAM_STR;
    MSSQL_DB        : T_PARAM_STR;
    MSSQL_Table     : T_PARAM_STR;
    {$ENDIF}

    {$IFDEF BARCODE}
    // Barcode
    BarCodeDevice   : T_PARAM_STR;
    BarCodeTarget   : T_PARAM_NR;
    BarcodeEnabled  : T_PARAM_BOOL;
    {$ENDIF}

    {$IFDEF ETHERNET}
    Ethernet_Active : T_PARAM_BOOL;
    Ethernet_IP     : T_PARAM_STR;
    Ethernet_Port   : T_PARAM_INT;
    {$ENDIF}

    Password        : T_PARAM_STR;
    MaxValue        : T_PARAM_INT;
    Directory       : T_PARAM_STR;
    Decimals        : T_PARAM_NR;
    Meters          : T_PARAM_NR;
    MetersDisplay   : T_PARAM_NR;
    GridData        : T_PARAM_NR;
    AutoSave        : T_PARAM_BOOL;
    GraphicBgColor  : T_PARAM_INT;
    GraphicVgColor  : T_PARAM_INT;
    ExportHeader    : T_PARAM_BOOL;
    EditableIndex   : T_PARAM_BOOL;
    ResetIndex      : T_PARAM_BOOL;

    // Infos
    Info1_Caption  : T_PARAM_STR;
    Info1          : T_PARAM_STR;
    Info2_Caption  : T_PARAM_STR;
    Info2          : T_PARAM_STR;
    Info3_Caption  : T_PARAM_STR;
    Info3          : T_PARAM_STR;
    end;  

var
  FrmOptions: TFrmOptions;
  parameter: tParameter;

const
  ParameterFile_ = 'Parameter.ini';
  MASTER_Password = 'Schneewittchen';

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

implementation

uses
  Windows, Dialogs, uTLH.Files, uTLH.SysUtils, Main
  ,Graphics
  ,Language
  {$IFDEF WEBIO},uWEBIO{$ENDIF}
  {$IFDEF ETHERNET}, uHTTPReader{$ENDIF}  
  ;

{$R *.dfm}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

procedure TFrmOptions.FormCreate(Sender: TObject);
begin
  {$IFDEF BARCODE}
  fBarcodeTeachIn     := false;
  fBarcodeLastReceive := 0;
  fBarcodeLastText    := '';
  RawKeyboardHook.OnRawKey := RawKeyEvent;  
  {$ENDIF}

  ListLanguageFiles( cbbLanguage );
  InitParameter;
  FrmRS232.SetParameterDependencys;
  SetParameterDependencys;

  {$IFDEF ETHERNET}
  HTTPReaderThread := tHTTPReaderThread.Create( false );  
  if parameter.Ethernet_Active.Wert then
    begin
    HTTPReaderThread.IP   := parameter.Ethernet_IP.Wert;
    HTTPReaderThread.Port := parameter.Ethernet_Port.Wert;
    if NOT HTTPReaderThread.SetRunning( True ) then 
      FrmRS232.pnlEthernet.Visible := True;
    end
  else
  {$ENDIF}
    begin
    FrmRS232.Serial.PortByIndex( parameter.Serial_Port.Wert );
    FrmRS232.Serial.Active := True;
    if FrmRS232.Serial.Active then
      begin
      chkSerialActive.Checked := True;
      end
    else
      FrmRS232.pnlRS232Error.Visible := True;
    end;

 {$IFDEF WEBIO}
  FrmRS232.pnlWebIO.Visible := parameter.WebIO_Active.Wert;
  if ( parameter.WebIO_Active.Wert ) then
    begin
    FrmRS232.pnlWebIO.Caption := GetSourceCodeString( 1007, 'WebIO Init..' );
    Application.ProcessMessages;

    if ( WEBIO.Connect( parameter.WebIO_IP.Wert, parameter.WebIO_Port.Wert, parameter.WebIO_Password.Wert, CHAN2 ) = 0 ) then
      begin
      FrmRS232.pnlWebIO.Caption := GetSourceCodeString( 1008, 'Init OK' );
      FrmRS232.pnlWebIO.Color   := $00FF00{clLime};
      end
    else
      FrmRS232.pnlWebIO.Caption := GetSourceCodeString( 1009, 'WebIO Error!' );

    cbbDataFormat.ItemIndex := 1; // PC-Mode
    cbbDataFormat.Enabled := false;
    cbbDataFormatChange( cbbDataFormat );
    end;
  {$ENDIF}

  tsPrinter.TabVisible := {$IFDEF PRINTER}True{$ELSE}False{$ENDIF};
  tsWEBIO.TabVisible   := {$IFDEF WEBIO}True{$ELSE}False{$ENDIF};
  tsMSSQL.TabVisible   := {$IFDEF MSSQL}True{$ELSE}False{$ENDIF};
  tsBarcode.TabVisible := {$IFDEF BARCODE}True{$ELSE}False{$ENDIF};
  tsEthernet.TabVisible := {$IFDEF ETHERNET}True{$ELSE}False{$ENDIF};
end;

procedure TFrmOptions.FormDestroy(Sender: TObject);
begin
  {$IFDEF BARCODE}
  RawKeyboardHook.OnRawKey := nil;
  {$ENDIF}
  if Assigned( parameter ) then
    parameter.Free;
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TFrmOptions.InitParameter;
begin
  parameter := tParameter.Create( ExtractFilePath( ParamStr( 0 ) ) + ParameterFile_ );
  with parameter do
    begin
    OpenIniDatei;
    SetzteSection( 'Parameter' );

    // General
    Init_StrParam( Password, 'meer', 'Password', lbledtPasswordCurrent );
    Init_IntParam( MaxValue, 10, 0, 10, 'MaxValue', lblEdtMaxValue );
    Init_StrParam( Directory, GetApplicationDirectory + 'Values\', 'Directory', lblEdtDirectory, True );
    Init_NrParam( Decimals, 2, 'Decimals', cbbDecimal );
    Init_NrParam( Meters, 0, 'Meters (Input)', rgMeters );
    Init_NrParam( MetersDisplay, 0, 'Meters (Displayed)', rgMetersDisplay );
    Init_BoolParam( AutoSave, false, 'Auto Save', chkAutoSave );

    Init_IntParam( GraphicBgColor, clWhite, clBlack, clWhite, 'Graphic BgColor', nil );
    Init_IntParam( GraphicVgColor, clBlack, clBlack, clWhite, 'Graphic VgColor', nil );
    Init_BoolParam( ExportHeader, True, 'ExportHeader', chkExportHeader );
    Init_BoolParam( EditableIndex, False, 'EditableIndex', chkEditableIndex );
    Init_BoolParam( ResetIndex, False, 'ResetIndex', chkResetIndex );

    // Infos
    Init_StrParam( Info1_Caption, 'OrderID', 'Info1 Caption', lbledtInfo1 );
    Init_StrParam( Info1, '', 'Info1', FrmRS232.lbledtInfo1 );

    Init_StrParam( Info2_Caption, 'Tester', 'Info2 Caption', lbledtInfo2 );
    Init_StrParam( Info2, '', 'Info2', FrmRS232.lbledtInfo2 );

    Init_StrParam( Info3_Caption, '', 'Info3 Caption', lbledtInfo3 );
    Init_StrParam( Info3, '', 'Info3', FrmRS232.lbledtInfo3 );
    Init_NrParam( GridData, 0, 'Grid Data', rgGridData );

    // RS232
    Init_NrParam( Serial_Port, 0, 'RS232 Port', cbbSerialPort );
    Init_NrParam( Serial_Baudrate, 8, 'RS232 Baudrate', cbbSerialBaud );
    Init_NrParam( Serial_DataBits, 3, 'RS232 DataBits', cbbSerialDataBits );
    Init_NrParam( Serial_Parity, 2, 'RS232 Parity', cbbSerialParity );
    Init_NrParam( Serial_StopBits, 0, 'RS232 StopBits', cbbSerialStop );
    Init_NrParam( Serial_Format, 0, 'RS232 DataFormat', cbbDataFormat );

    {$IFDEF PRINTER}
    // Printer
    Init_NrParam( PrinterType, 0, 'PrinterName', rgPrinterType );
    Init_StrParam( PrinterFont, 'Arial', 'Printer Font', nil );
    Init_IntParam( PrinterFontSize, 11, 0, 200, 'Printer FontSize', nil );
    Init_BoolParam( AutoPrint, False, 'Auto Print', chkPrint );
    Init_NrParam( PrinterFormat, 0, 'Printer Format', cbbPrinterFormat );
    Init_BoolParam( PrinterEnabled, False, 'Printer Enabled', chkPrinter_Enabled );
    {$ENDIF}

    {$IFDEF MSSQL} // MSSQL
    Init_BoolParam( MSSQL_Enabled, False, 'MSSQL_Enabled', chkMSSQL_Enabled );
    Init_StrParam( MSSQL_Server, 'localhost', 'MSSQL_Server', lbledtMSSQL_Server );
    Init_StrParam( MSSQL_Provider, 'SQLNCLI11.1', 'MSSQL_Provider', lbledtMSSQL_Provider );
    Init_StrParam( MSSQL_DataSource, Format( '%s\SQLEXPRESS', [ GetComputerName ] ), 'MSSQL_DataSource', lbledtMSSQL_DataSource );
    Init_StrParam( MSSQL_Username, '', 'MSSQL_Username', lbledtMSSQL_User );
    Init_StrParam( MSSQL_Password, '', 'MSSQL_Password', lbledtMSSQL_Password );
    Init_StrParam( MSSQL_DB, 'SBS_Imess', 'MSSQL_DB', lbledtMSSQL_DB );
    Init_StrParam( MSSQL_Table, 'Saebel', 'MSSQL_Table', lbledtMSSQL_Table );
    {$ENDIF}

    {$IFDEF WEBIO} // WebIO
    Init_BoolParam( WebIO_Active, false, 'WebIO Active', chkUseWebIO );
    Init_StrParam( WebIO_IP, '192.168.1.100', 'WebIO IP', jvIPEdtIP );
    Init_IntParam( WebIO_Port, 80,  1, High(Word), 'WebIO Port', lblEdtPort);
    Init_StrParam( WebIO_Password, '', 'WebIO Password', lblEdtPassword );
    {$ENDIF}

    // Barcode
    {$IFDEF BARCODE}
    Init_StrParam( BarCodeDevice, '', 'Barcode Device', lbledtBarcodeHID );
    Init_NrParam( BarCodeTarget, 0, 'Barcode Target', cbbBarcodeTarget );
    Init_BoolParam( BarcodeEnabled, false, 'Barcode Enabled', chkBarcodeEnabled );
    {$ENDIF}

    {$IFDEF ETHERNET}
    Init_BoolParam( Ethernet_Active, false, 'Ethernet Active', chkEthernet_Active );
    Init_StrParam( Ethernet_IP, '192.168.1.100', 'Ethernet IP', jvIPEdtEthernet );
    Init_IntParam( Ethernet_Port, 80,  1, High(Word), 'Ethernet Port', lblEdtEthernet_Port);
    {$ENDIF}

    CloseIniDatei;
    end;
end;

procedure TFrmOptions.SetParameterDependencys;
begin
  {$IFDEF PRINTER}
  chkPrint.Enabled := ( cbbPrinterFormat.ItemIndex = 0 ) OR ( cbbPrinterFormat.ItemIndex = cbbPrinterFormat.Items.Count-1 ); // 1Line or Endless
  {$ENDIF}
  {$IFDEF BARCODE}
  RawKeyboardHook.Enabled := parameter.BarcodeEnabled.Wert;
  {$ENDIF}
end;

procedure TFrmOptions.jvIPEdtIPExit(Sender: TObject);
begin
  if NOT (Sender is TJvIPAddress) then
    Exit;
  {$IFDEF WEBIO}
  parameter.WebIO_IP.Wert := TJvIPAddress( Sender ).Text;
  {$ENDIF}
end;

procedure TFrmOptions.chkSerialActiveClick(Sender: TObject);
begin
  if NOT (Sender is TCheckBox) then
    Exit;
  FrmRS232.Serial.Active := TCheckBox(Sender).Checked;
  TCheckBox(Sender).Checked := FrmRS232.Serial.Active;
end;

procedure TFrmOptions.cbbDataFormatChange(Sender: TObject);
var
  last : boolean;
begin
  if NOT ( Sender is TComboBox ) then
    Exit;

  last := FrmRS232.Serial.active;
  FrmRS232.Serial.Active := false;
  Delay( 250 );
  case TComboBox(Sender).ItemIndex of
//    0 : Serial.EventChar := #10; // CRLF (Print1)
//    1 : Serial.EventChar := #13; // CR   (Print2)
//    2 : Serial.EventChar := #03; // ETX (PC-Mode)
    0 : FrmRS232.Serial.EventChar := #13; // CR
    1 : FrmRS232.Serial.EventChar := #03; // ETX (PC-Mode)
  else
    FrmRS232.Serial.EventChar := #13; // CR
  end;
  FrmRS232.Serial.Active := last;

  parameter.ParameterUebernehmen( True, True, True );
end;

procedure TFrmOptions.chkUseWebIOClick(Sender: TObject);
begin
  if NOT (Sender is TCheckBox) then
    Exit;

  cbbDataFormat.Enabled := NOT TCheckBox(Sender).Checked;
  parameter.ParameterUebernehmen( True, True, True );
end;

procedure TFrmOptions.chkUseDB(Sender: TObject);
begin
  parameter.ParameterUebernehmen( True, True );
end;

procedure TFrmOptions.cbbDataFormatKeyPress(Sender: TObject; var Key: Char);
begin
  Key := #0;
end;

procedure TFrmOptions.cbbDecimalChange(Sender: TObject);
begin
  parameter.ParameterUebernehmen( True, True, True );
end;

procedure TFrmOptions.cbbDecimalKeyPress(Sender: TObject; var Key: Char);
begin
  Key := #0;
end;

procedure TFrmOptions.cbbPrinterFormatChange(Sender: TObject);
begin
  if NOT (Sender is TComboBox) then
    Exit;
  Parameter.ParameterUebernehmen( False, False );
  chkPrint.Enabled := ( TComboBox(Sender).ItemIndex = 0 ) OR ( TComboBox(Sender).ItemIndex = TComboBox(Sender).Items.Count-1 ); // 1Line or Endless
end;

procedure TFrmOptions.btnDirectoryClick(Sender: TObject);
var
  JvSelDir: TJvSelectDirectory;
begin
  JvSelDir := TJvSelectDirectory.Create( self );
  JvSelDir.InitialDir := parameter.Directory.Wert;

  if JvSelDir.Execute then
    begin
    if NOT DirectoryExists( JvSelDir.Directory ) then
      ShowMessage( 'Invalid Directory, choose another.' )
    else
      parameter.Directory.Wert := JvSelDir.Directory;
    end;
  JvSelDir.free;
end;

procedure TFrmOptions.lblEdtMaxValueKeyPress(Sender: TObject; var Key: Char);
begin
  if NOT (Sender is TLabeledEdit) then
    Exit;

  if ( Key = #13 ) then
    begin
    parameter.MaxValue.Wert := StrToInt( TLabeledEdit(Sender).Text );
    FrmRS232.Draw( FrmRS232.LastValue, parameter.GraphicBgColor.Wert, parameter.GraphicVgColor.Wert );
    Key := #0;
    end;

  if NOT ( Key in [#8, #48..#57] ) then
    Key := #0;
end;

procedure TFrmOptions.chkPrinter_EnabledClick(Sender: TObject);
begin
  if NOT (Sender is TCheckBox) then
    Exit;

  if NOT Visible then
    Exit;

  if TCheckBox( Sender ).Checked then
    begin
    {$IFDEF PRINTER}
    parameter.PrinterType.Wert := rgPrinterType.ItemIndex;
    {$ENDIF}
    if NOT FrmRS232.FindPrinter then
      begin
      TCheckBox( Sender ).Checked := false;
      ShowMessage( GetSourceCodeString( 1010, 'Error: Printer not found, deactivating ...' ) );
      Exit;
      end;
    end;
end;

procedure TFrmOptions.grpLanguageDblClick(Sender: TObject);
begin
  if FrmRS232.Service > 1 then
    FrmLanguage.Show;
end;

procedure TFrmOptions.rgGridDataClick(Sender: TObject);
begin
   if NOT ( Sender is TRadioGroup ) then
     Exit;

  case TRadioGroup( Sender ).ItemIndex of
    1 : begin
        if ( lbledtInfo1.Text = '' ) then
          TRadioGroup( Sender ).ItemIndex := 0; // No Caption ..
        end;
    2 : begin
        if ( lbledtInfo2.Text = '' ) then
          TRadioGroup( Sender ).ItemIndex := 0; // No Caption ..
        end;
    3 : begin
        if ( lbledtInfo3.Text = '' ) then
          TRadioGroup( Sender ).ItemIndex := 0; // No Caption ..
        end;
  else
    Exit;
  end;
end;

// Password
procedure TFrmOptions.btnPasswordApplyClick(Sender: TObject);
begin
  if NOT ( LowerCase( lbledtPasswordCurrent.Text ) = LowerCase( parameter.Password.Wert ) ) AND
     NOT ( LowerCase( lbledtPasswordCurrent.Text ) = LowerCase( MASTER_Password ) ) then
    ShowMessage( GetSourceCodeString( 1011, 'Wrong Password!' ) )
  else if ( lbledtPasswordNew.Text = '' ) then
    ShowMessage( GetSourceCodeString( 1012, 'Please enter a new password.' ) )
  else if ( LowerCase( lbledtPasswordNew.Text ) <> LowerCase( lbledtPasswordNewRetype.Text ) ) then
    ShowMessage( GetSourceCodeString( 1013, 'New passwords arent equal.' ) )
  else
    begin
    parameter.Password.Wert := lbledtPasswordNew.Text;
    lbledtPasswordNew.Text := '';
    lbledtPasswordNewRetype.Text := '';
    ShowMessage( GetSourceCodeString( 1014, 'Password change succesfull.' ) );
    end;
end;

// Apply, Save, Cancel
procedure TFrmOptions.btnParameters(Sender: TObject);
begin
//  if NOT ( Sender is TBitBtn ) then
//    Exit;

  if ( Sender = btnApply ) then
    begin
    parameter.ParameterUebernehmen( false );
    FrmRS232.SetParameterDependencys;
    SetParameterDependencys;
    end
  else if ( Sender = btnSaveClose ) then
    begin
    parameter.ParameterUebernehmen( True, True, True );
    FrmRS232.SetParameterDependencys;
    SetParameterDependencys;
    Close;
    end
  else if ( Sender = btnCancel ) then
    begin
    parameter.Reload;
    FrmRS232.SetParameterDependencys;
    SetParameterDependencys;
    Close;
    end;
end;

// Barcode
procedure TFrmOptions.btnBarcodeTeachInClick(Sender: TObject);
begin
  lbledtBarcodeHID.Text := ''; 
  lbledtBarcodeText.Text := '';

  chkBarcodeEnabled.Checked := false;
  btnBarcodeTeachIn.Enabled := false;
  {$IFDEF BARCODE}
  fBarcodeTeachIn := True;
  RawKeyboardHook.Enabled := True;
  {$ENDIF}
end;

procedure TFrmOptions.chkBarcodeEnabledClick(Sender: TObject);
{$IFDEF BARCODE}
var
  i : integer;
  found : boolean;
{$ENDIF}
begin
  if NOT ( Sender is TCheckBox ) then
    Exit;

  if TCheckBox( Sender ).Checked then
    begin
    if ( lbledtBarcodeHID.Text = '' ) then
      begin
      TCheckBox( Sender ).Checked := false;
      ShowMessage( GetSourceCodeString( 1015, 'Error: No Device Teached' ) );
      end;

    {$IFDEF BARCODE}
    found := False;
    for i := 0 to RawKeyboardHook.KeyboardCount-1 do
      begin
      found := ( LowerCase( RawKeyboardHook.KeyBoardName[ i ] ) = LowerCase( lbledtBarcodeHID.Text ) );
      if found then
        break;
      end;
    if NOT found then
      begin
      TCheckBox( Sender ).Checked := false;
      lbledtBarcodeHID.Text := '';
      ShowMessage( GetSourceCodeString( 1016, 'Error: Teached Device is not found' ) );
      end;
    {$ENDIF}
    end;
end;

{$IFDEF BARCODE}
function TFrmOptions.RawKeyEvent( Sender : TObject; RI : tagRAWINPUT ) : Boolean;
  function GetCharFromVirtualKey(Key: Word): String;
  var
    keyboardState: TKeyboardState;
    asciiResult: Integer;
  begin
    GetKeyboardState(keyboardState);

    SetLength(Result, 2);
    {$WARN UNSAFE_CODE OFF}
    asciiResult := ToAscii(key, MapVirtualKey(key, 0), keyboardState, @Result[1], 0);
    {$WARN UNSAFE_CODE ON}
    case asciiResult of
      0: Result := '';
      1: SetLength(Result, 1);
      2:;
    else
        Result := '';
    end;
  end;
const
  INPUT_TIMEOUT = 200;
begin
  result := false;

  if ( Ri.keyboard.VKey < 33 ) then
    Exit; // ControlChar, "processing" stops the "controlled Chars" (XP, SP3, Span)

  if fBarcodeTeachIn then
    begin
    lbledtBarcodeHID.Text := RawKeyboardHook.KeyBoardNameFromHandle( Ri.header.hDevice );
    RawKeyboardHook.Enabled := false;
    result := True;
    end
  else if ( LowerCase( RawKeyboardHook.KeyBoardNameFromHandle( Ri.header.hDevice ) ) = LowerCase( parameter.BarCodeDevice.Wert ) ) then
    result := True;

  if result AND ( RI.keyboard.Message = $0100{WM_KEYDOWN} ) then
    begin
    if ( GetTickCount-fBarcodeLastReceive > INPUT_TIMEOUT ) then
      fBarcodeLastText := '';
    fBarcodeLastText := fBarcodeLastText + GetCharFromVirtualKey( Ri.keyboard.VKey );
    fBarcodeLastReceive := GetTickCount;

    if fBarcodeTeachIn then
      begin
      fBarcodeTeachIn := false;
      lbledtBarcodeText.Text := fBarcodeLastText;
      btnBarcodeTeachIn.Enabled := True;
      end
    else
      begin
      case parameter.BarCodeTarget.Wert of
        0 : FrmRS232.lbledtInfo1.Text := fBarcodeLastText;
        1 : FrmRS232.lbledtInfo2.Text := fBarcodeLastText;
        2 : FrmRS232.lbledtInfo3.Text := fBarcodeLastText;
      end;
      end;
    end;
end;
{$ENDIF}

end.
