unit uWEBIO;

{
  uWEBIO v0.91 - 25.11.2015
}

//{$DEFINE ThreadTimeing} // Enables Thread-Timeing Calculation

interface

uses
  Windows, Classes, Controls, Forms, StdCtrls, Buttons, Spin, SyncObjs, Sockets, ExtCtrls;

const
  MAX_MODULES_           = 10;
  MAX_ONCHANGE_THREADS_  = 50;
  MAX_CHANS_             = 24;
  MAX_RECONNECTS_        = 10;
  ReplyTimeout_ : DWORD  = 10000;

type
  tLastCommandItem = record
    command    : string;
    time       : Dword;
    end;
  // LastCommand
  tLastCommand = class
  private
    fID   : Word;
    Items : Array of tLastCommandItem;
    procedure   Del( value : Word );
  public
    constructor Create( ID : Word );
    procedure   Add( value : string );
    procedure   Check( value : string );
  end;

  tWEBIO_CHANS = ( CHAN2, CHAN12, CHAN24 );

  tWEBIO_fSettings = record
    IP : String;
    Port : WORD;
    Password : String;
    Channels : tWEBIO_CHANS;
    ConnectTime : DWord;
    Reconnects : Byte;
    end;

  // OnChange
  tOnChange = procedure (Sender : TObject; ModuleID, Chan : Byte; Value : boolean);
  tOnChangeThread = class(TThread)
  private
    { Private-Deklarationen }
    fSender        : TObject;
    fSynchronized  : Boolean;
    fModuleID, fChan : Byte;
    fRecDigital    : tOnChange;
    fbValue        : Boolean;
    procedure Execution;
  protected
    procedure Execute; override;
  public
    procedure SetInfos( Rec : tOnChange; Sender : TObject; ModuleID, Chan : integer; Value : boolean; Synchronized : Boolean = False ); overload;
  end;
  tOnChangeEvent = class
  private
    Threads : Array of tOnChangeThread;
    CritSection : TCriticalSection;
    fLastEventTime : Array of DWord;
    fLastEventTimeSynchronized : Array of DWord;
    fInterval : Word;
    function NilAndReturnIndex: integer;
//    procedure NilUnusedThreads;
  public
    constructor Create;
    destructor  Destroy; override;
    property    Interval : Word read fInterval write fInterval default 0;
    function    Add( Rec : tOnChange; Sender : TObject; ModuleID, Chan, ChanOffset : integer; Value : boolean; Synchronized : Boolean = False ): integer; overload;
  end;

  // Base
  tBaseCard = class
    private
      fModuleNum : Byte;
      fActiveModule : Byte;
      fSimulation : array [0..MAX_MODULES_-1] of boolean;
      fError : Array[0..MAX_MODULES_-1] of integer;
      fOnChangeHandler : tOnChangeEvent;
      procedure   SetActiveCard( val : byte );
      function    GetSimulation : Boolean;
      procedure   SetSimulation( val : boolean );
      function    GetError: integer;
      function    GetOnChangeInterval: Word;
      procedure   SetOnChangeInterval( val : Word );
    public
      constructor Create;
      destructor  Destroy; override;
      function    IsError( ModuleID : SmallInt = -1 ) : integer;
      property    Simulation : Boolean read GetSimulation write SetSimulation default false;
      property    Modules : Byte read fModuleNum default 0;
      property    ActiveCard : Byte read fActiveModule write SetActiveCard default 0;
      property    ErrorCode : integer read GetError;
      property    OnChangeInterval : Word read GetOnChangeInterval write SetOnChangeInterval;
    end;
  tWEBIOThread = class(TThread)
  private
    { Private-Deklarationen }
    {$IFDEF ThreadTimeing}
    fQueryPerformanceFrequency : Int64;
    fRuntime : Extended;
    {$ENDIF}
    fFrequency : SmallInt;
    procedure   SetFrequency( val : SmallInt );
  protected
    property    Frequency : SmallInt read fFrequency write SetFrequency default 10;
  public
    constructor Create( CreateSuspended : boolean );
    procedure   Execute; override;
    {$IFDEF ThreadTimeing}
    property    Runtime : Extended read fRuntime;
    {$ENDIF}
  end;

  tWEBIO = class(tBaseCard)
    private
      TCPClient : array [0..MAX_MODULES_-1] of TTCPClient;
      fSettings : array [0..MAX_MODULES_-1] of tWEBIO_fSettings;
      fDigitalInVal,
      fDigitalOutVal,
      fDigitalInValSim : array [0..MAX_MODULES_-1] of DWord;
      fDigitalIn,
      fDigitalInSim,
      fDigitalOut : Array [0..MAX_MODULES_-1, 0..MAX_CHANS_-1] of boolean;
      myThread : tWEBIOThread;
      fOnChange, fOnChangeSynchronized,
      fOnOutChange, fOnOutChangeSynchronized : tOnChange;
      lastCommands : array [0..MAX_MODULES_-1] of tLastCommand;
      fDeInited : boolean;      
      procedure pSetSimulation( val : boolean );
      function  pGetSimulation: boolean;
      procedure Reset( ModuleID : Integer = -1 );
      procedure TcpClientConnect(Sender: TObject);
      procedure TcpClientDisconnect(Sender: TObject);
      procedure TcpClientError(Sender: TObject; SocketError: Integer);
      procedure TcpClientReceive(Sender: TObject; Buf: PAnsiChar; var DataLen: Integer);
      procedure TcpClientSend(Sender: TObject; Buf: PAnsiChar; var DataLen: Integer);
      function  SendBuffer( str: String; ModuleID : Integer = -1 ):Integer;
    public
      InStrings  : Array [0..MAX_MODULES_-1, 0..MAX_CHANS_-1] of String;
      OutStrings : Array [0..MAX_MODULES_-1, 0..MAX_CHANS_-1] of String;
      constructor Create;
      destructor  Destroy; override;
      procedure   DeInit;
      function    Connect( IP : string; Port : Word; Password : string; Channels : tWEBIO_CHANS; ModuleID : Integer = -1 ) : integer;
      function    Disconnect( ModuleID : Integer = -1 ) : integer;
      procedure   SetSimulation( val : boolean; ModuleID : SmallInt = -1 );
      property    Simulation : boolean read pGetSimulation write pSetSimulation;
      function    IsConnected( ModuleID : Integer = -1 ): boolean;
      function    Read1DigitalInput( chan : byte; ModuleID : SmallInt = -1 ): byte;
      function    Read1DigitalOutput( chan : byte; ModuleID : SmallInt = -1 ): byte;
      function    ReadAllDigitalInput( var value : Byte; ModuleID : SmallInt = -1 ) : boolean;
      function    Write1DigitalOutput( chan, value : byte; ModuleID : SmallInt = -1 ) : integer;
      function    WriteAllDigitalOutput( value : boolean; ModuleID : SmallInt = -1 ): integer;
      function    Write1DigitalInputSim( chan, value : byte; ModuleID : SmallInt = -1 ) : integer;
      property    OnChange : tOnChange read fOnChange write fOnChange;
      property    OnChangeSynchronized : tOnChange read fOnChangeSynchronized write fOnChangeSynchronized;
      property    OnOutChange : tOnChange read fOnOutChange write fOnOutChange;
      property    OnOutChangeSynchronized : tOnChange read fOnOutChangeSynchronized write fOnOutChangeSynchronized;
  end;

  TFrmWEBIO = class(TForm)
    mmoError: TMemo;
    pnlChans: TPanel;
    lblOutCaption: TLabel;
    ShapeIn6: TShape;
    ShapeIn8: TShape;
    ShapeIn1: TShape;
    ShapeIn2: TShape;
    ShapeIn3: TShape;
    ShapeIn4: TShape;
    ShapeIn5: TShape;
    ShapeIn7: TShape;
    lblInCaption: TLabel;
    SBtnOut01: TSpeedButton;
    SBtnOut02: TSpeedButton;
    SBtnOut03: TSpeedButton;
    SBtnOut04: TSpeedButton;
    SBtnOut05: TSpeedButton;
    SBtnOut06: TSpeedButton;
    SBtnOut07: TSpeedButton;
    SBtnOut08: TSpeedButton;
    lblOut1: TLabel;
    lblOut3: TLabel;
    lblOut2: TLabel;
    lblOut5: TLabel;
    lblOut4: TLabel;
    lblOut6: TLabel;
    lblOut7: TLabel;
    lblOut8: TLabel;
    SBtnOut09: TSpeedButton;
    SBtnOut10: TSpeedButton;
    SBtnOut11: TSpeedButton;
    SBtnOut12: TSpeedButton;
    lblOut9: TLabel;
    lblOut10: TLabel;
    lblOut11: TLabel;
    lblOut12: TLabel;
    ShapeIn10: TShape;
    ShapeIn12: TShape;
    ShapeIn9: TShape;
    ShapeIn11: TShape;
    grpIn: TGroupBox;
    lblIn1: TLabel;
    lblIn6: TLabel;
    lblIn2: TLabel;
    lblIn8: TLabel;
    lblIn3: TLabel;
    lblIn5: TLabel;
    lblIn7: TLabel;
    lblIn4: TLabel;
    lblIn10: TLabel;
    lblIn12: TLabel;
    lblIn9: TLabel;
    lblIn11: TLabel;
    chkIn1: TCheckBox;
    chkIn2: TCheckBox;
    chkIn3: TCheckBox;
    chkIn4: TCheckBox;
    chkIn5: TCheckBox;
    chkIn6: TCheckBox;
    chkIN7: TCheckBox;
    chkIN8: TCheckBox;
    chkIN9: TCheckBox;
    chkIN10: TCheckBox;
    chkIN11: TCheckBox;
    chkIN12: TCheckBox;
    chkSimulation: TCheckBox;
    pnlTop: TPanel;
    lblFrequency: TLabel;
    lblCard: TLabel;
    pnlInit: TPanel;
    seFrequenz: TSpinEdit;
    selCard: TSpinEdit;
    grpConnection: TGroupBox;
    lbledtIP: TLabeledEdit;
    lbledtPort: TLabeledEdit;
    lbledtPassword: TLabeledEdit;
    btnConnect: TButton;
    grpData: TGroupBox;
    lbledtSend: TLabeledEdit;
    lbledtReceive: TLabeledEdit;
    btnTime: TButton;
    btnGetCounter: TButton;
    btnDiagnostics: TButton;
    ShapeIn18: TShape;
    ShapeIn20: TShape;
    ShapeIn13: TShape;
    ShapeIn14: TShape;
    ShapeIn15: TShape;
    ShapeIn16: TShape;
    ShapeIn17: TShape;
    ShapeIn19: TShape;
    SBtnOut13: TSpeedButton;
    SBtnOut14: TSpeedButton;
    SBtnOut15: TSpeedButton;
    SBtnOut16: TSpeedButton;
    SBtnOut17: TSpeedButton;
    SBtnOut18: TSpeedButton;
    SBtnOut19: TSpeedButton;
    SBtnOut20: TSpeedButton;
    SBtnOut21: TSpeedButton;
    SBtnOut22: TSpeedButton;
    SBtnOut23: TSpeedButton;
    SBtnOut24: TSpeedButton;
    ShapeIn22: TShape;
    ShapeIn24: TShape;
    ShapeIn21: TShape;
    ShapeIn23: TShape;
    lblOut13: TLabel;
    lblOut14: TLabel;
    lblOut15: TLabel;
    lblOut16: TLabel;
    lblOut17: TLabel;
    lblOut18: TLabel;
    lblOut19: TLabel;
    lblOut20: TLabel;
    lblOut21: TLabel;
    lblOut22: TLabel;
    lblOut23: TLabel;
    lblOut24: TLabel;
    chkIn13: TCheckBox;
    chkIn14: TCheckBox;
    chkIn15: TCheckBox;
    chkIn16: TCheckBox;
    chkIn17: TCheckBox;
    chkIn18: TCheckBox;
    chkIN19: TCheckBox;
    chkIN20: TCheckBox;
    chkIN21: TCheckBox;
    chkIN22: TCheckBox;
    chkIN23: TCheckBox;
    chkIN24: TCheckBox;
    lblIn13: TLabel;
    lblIn18: TLabel;
    lblIn14: TLabel;
    lblIn20: TLabel;
    lblIn15: TLabel;
    lblIn17: TLabel;
    lblIn19: TLabel;
    lblIn16: TLabel;
    lblIn22: TLabel;
    lblIn24: TLabel;
    lblIn21: TLabel;
    lblIn23: TLabel;
    rgChans: TRadioGroup;  procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure tmrRefreshTimer(Sender: TObject);

    procedure SButtonClick(Sender: TObject);
    procedure seFrequenzChange(Sender: TObject);
    procedure CheckBoxINClick(Sender: TObject);
    procedure CheckBoxSimulationClick(Sender: TObject);
    procedure selCardChange(Sender: TObject);
    procedure selCardKeyPress(Sender: TObject; var Key: Char);
    procedure SetShape( ID : byte; state : boolean );
    procedure seFrequenzKeyPress(Sender: TObject; var Key: Char);
    procedure btnConnectClick(Sender: TObject);
    procedure btnGetCounterClick(Sender: TObject);
    procedure btnTimeClick(Sender: TObject);
    procedure btnDiagnosisClick(Sender: TObject);
  private
    { Private-Deklarationen}
    tmrRefresh: TTimer;
    fRefresh_fSettings : boolean;
  public
    { Public-Deklarationen}
  end;

var
  FrmWEBIO: TFrmWEBIO;
  WEBIO   : tWEBIO;

function Matches(const S,Wildcard: String): Boolean;

implementation

uses
  MMSystem, Math, StrUtils, Masks, SysUtils, Graphics,
  PingSend,
  uTLH.Numeral, uTLH.Strings, uTLH.SysUtils;

{$R *.DFM}

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
constructor tLastCommand.Create( ID : Word );
begin
  inherited Create;
  SetLength( Items, 0 );
  fID := ID;
end;

procedure tLastCommand.Add( value : string );
begin
  if NOT Assigned(self) then
    Exit;

  if ( Matches( value,'*input*' ) ) then
    value := 'input'
  else if (Matches( value,'*output*' ) ) then
    value := 'output'
  else
    begin
    value := StringReplace( value,'GET /','',[rfReplaceAll] );
    value := StringReplace( value,'?PW=','',[rfReplaceAll] );
    value := StringReplace( value,'&','',[rfReplaceAll] );
    end;

  SetLength( Items, Length( Items )+1 );
  Items[ Length( Items )-1 ].Command := value;
  Items[ Length( Items )-1 ].Time    := GetTickCount;
end;

procedure tLastCommand.Del( value : Word );
var
  i : integer;
begin
  if NOT Assigned(self) then
    Exit;

  if ( value > Length(Items)-1 ) then
    Exit;

  for i := value to Length( Items )-2 do
    Items[i] := Items[i+1];

  SetLength( Items, Length( Items )-1 );
end;

procedure tLastCommand.Check( value : string );
var
  Time : DWord;
  i    : integer;
begin
  if NOT Assigned(self) then
    Exit;

  Time := GetTickCount;
  for i := Length( Items )-1 downTo 0 do
    begin
    if ( Matches( value, '*' + Items[i].Command + '*' ) ) OR (( Items[i].Command = 'time' ) AND ( Matches( value, '??.??.????*??:??:??' ) ) ) then
      begin
//      if Assigned( FrmWebIO ) then
//        if FrmWebIO.Visible then
//          FrmWebIO.mmoError.Lines.Add( Format( 'ID: %d - RECEIVED response for cmd: "%s".', [ fID, Items[i].Command ] ) );
      Del( i );
      end
    else if ( Time-Items[i].time >= ReplyTimeout_ ) then
      begin
      if Assigned( FrmWebIO ) then
        if FrmWebIO.Visible then
          FrmWebIO.mmoError.Lines.Add( Format( 'ID: %d - Never received response for cmd: "%s".', [ fID, Items[i].Command ] ) );
      WEBIO.fError[fID] := -100;

      Del( i );
      end;
    end;
end;

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------

procedure TFrmWEBIO.FormCreate(Sender: TObject);
begin
  tmrRefresh := TTimer.Create(self);
  tmrRefresh.Interval := 10;
  tmrRefresh.OnTimer := tmrRefreshTimer;
  tmrRefresh.Enabled := false;

  selCard.MaxValue := WEBIO.Modules;
  if WEBIO.Modules > 0 then
    begin
    PnlInit.Font.Color := clGreen;
    end;
end;

procedure TFrmWEBIO.FormShow(Sender: TObject);
begin
  tmrRefresh.Enabled := true;
  fRefresh_fSettings := true;
end;

procedure TFrmWEBIO.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  tmrRefresh.Enabled := false;
end;

procedure TFrmWEBIO.tmrRefreshTimer(Sender: TObject);
var
  i : Integer;
  comp : TComponent;
begin
  chkSimulation.Checked := WEBIO.fSimulation[ WEBIO.fActiveModule ];
  if WEBIO.fSimulation[ WEBIO.fActiveModule ] then
    grpIn.Font.Color := clBlack
  else
    grpIn.Font.Color := clGray;
  grpIn.Enabled := WEBIO.fSimulation[ WEBIO.fActiveModule ];

  if WEBIO.TCPClient[ WEBIO.fActiveModule ].Active then
    begin
    pnlInit.Font.Color := clLime;
    pnlInit.Caption := 'Init OK'
    end
  else
    begin
    pnlInit.Font.Color := clRed;
    pnlInit.Caption := 'Init fehler'
    end;

  if WEBIO.TCPClient[ WEBIO.fActiveModule ].Active then
    FrmWEBIO.btnConnect.Caption := 'Disconnect'
  else
    FrmWEBIO.btnConnect.Caption := 'Connect';

  for i := 1 to MAX_CHANS_ do
    begin
    comp := self.FindComponent( Format( 'lblIn%d', [ i ]));
    if comp <> NIL then
      (comp as TLabel).Caption := WEBIO.InStrings[ WEBIO.fActiveModule, i-1 ];

    comp := self.FindComponent( Format( 'lblOut%d', [ i ]));
    if comp <> NIL then
      (comp as TLabel).Caption := WEBIO.OutStrings[ WEBIO.fActiveModule, i-1 ];

    if WEBIO.Simulation then
      SetShape( i, WEBIO.fDigitalInSim[ WEBIO.fActiveModule, i-1] )
    else
      SetShape( i, WEBIO.fDigitalIn[ WEBIO.fActiveModule, i-1] );

    comp := self.FindComponent( Format( 'SBtnOut%.02d', [ i ]));
    if comp <> NIL then
      (comp as TSpeedButton).Down := WEBIO.fDigitalOut[ WEBIO.fActiveModule, i-1 ];
    end;

  if fRefresh_fSettings then
    begin
    lbledtIP.Text       := WEBIO.fSettings[ WEBIO.fActiveModule ].IP;
    lbledtPort.Text     := IntToStr( WEBIO.fSettings[ WEBIO.fActiveModule ].Port );
    lbledtPassword.Text := WEBIO.fSettings[ WEBIO.fActiveModule ].Password;

    if Assigned( WEBIO.myThread ) then
      seFrequenz.Value := WEBIO.myThread.Frequency;

    fRefresh_fSettings := false;

    if ( WEBIO.fSettings[ WEBIO.fActiveModule ].Channels = CHAN24 ) then
      begin
      pnlChans.Height := 502;
      self.Height := 745;
      rgChans.ItemIndex := 2;
      end
    else if ( WEBIO.fSettings[ WEBIO.fActiveModule ].Channels = CHAN12 ) then
      begin
      pnlChans.Height := 261;
      self.Height := 745-ABS(261-502);
      rgChans.ItemIndex := 1;
      end
    else
      begin
      pnlChans.Height := 60;
      self.Height := 745-ABS(60-502);
      rgChans.ItemIndex := 0;      
      end;
    end;
end;

//---------------------------------------------------------------------------
// Form
//---------------------------------------------------------------------------
procedure TFrmWEBIO.SButtonClick(Sender: TObject);
var
  s  : string;
  nr : integer;
begin
  s  := TSpeedButton(Sender).Name;
  nr := StrToIntDef(Copy(s, Length(s) - 1, 2), 1);
  WEBIO.Write1DigitalOutput(nr, Integer(TSpeedButton(Sender).Down) );
end;

procedure TFrmWEBIO.CheckBoxINClick(Sender: TObject);
var
  s : string;
  c, i : integer;
  val : Word;
begin
  if NOT (sender is TCheckBox) then
    Exit;

  s := (Sender as TCheckBox).Name;
  c := StrToIntDef( RightStr( s, Length(s)-5 ), -1);
  WEBIO.fDigitalInSim[ WEBIO.fActiveModule, c-1] := (Sender as TCheckBox).checked;

  val := 0;
  for i := 0 to MAX_CHANS_-1 do
    val := WriteBitInDWord(val, Byte(WEBIO.fDigitalInSim[ WEBIO.fActiveModule, i]), i);
  WEBIO.fDigitalInValSim[ WEBIO.fActiveModule ] := val;

  if WEBIO.Simulation then
    begin
    if Assigned(WEBIO.OnChange) then
      WEBIO.fOnChangeHandler.Add( WEBIO.OnChange, self, WEBIO.fActiveModule, c, 0, (sender as TCheckBox).checked, false );
    if Assigned(WEBIO.OnChangeSynchronized) then
      WEBIO.fOnChangeHandler.Add( WEBIO.OnChangeSynchronized, self, WEBIO.fActiveModule, c, 0, (sender as TCheckBox).checked, true );
    end;
end;

procedure TFrmWEBIO.seFrequenzChange(Sender: TObject);
begin
  if NOT (Sender is TSpinEdit) then
    Exit;

  WEBIO.myThread.Frequency := (Sender as TSpinEdit).Value;
  fRefresh_fSettings := true;
end;

procedure TFrmWEBIO.seFrequenzKeyPress(Sender: TObject; var Key: Char);
begin
  Key := #0;
end;

procedure TFrmWEBIO.selCardChange(Sender: TObject);
var
  val : integer;
begin
  if NOT (Sender is TSpinEdit) then
    Exit;

  val := (Sender as TSpinEdit).Value-1;

  if NOT (val <= 0) or (val > WEBIO.fModuleNum) then
    WEBIO.fActiveModule := val;

  (Sender as TSpinEdit).Value := WEBIO.fActiveModule;
end;

procedure TFrmWEBIO.selCardKeyPress(Sender: TObject; var Key: Char);
begin
  Key := #0;
end;

procedure TFrmWEBIO.CheckBoxSimulationClick(Sender: TObject);
begin
  WEBIO.Simulation := chkSimulation.Checked;
end;

procedure TFrmWEBIO.btnConnectClick(Sender: TObject);
var
  chans : tWEBIO_CHANS;
begin
  case rgChans.ItemIndex of
     0 : chans := CHAN2;
     1 : chans := CHAN12;
     2 : chans := CHAN24;
  else
    Exit;
  end;

  if WEBIO.TCPClient[ WEBIO.fActiveModule ].Active then
    WEBIO.Disconnect
  else
    if WEBIO.Connect( lbledtIP.Text, StrToIntDef( lbledtPort.Text, 0 ), lbledtPassword.Text, chans, WEBIO.fActiveModule ) = 0 then
      fRefresh_fSettings := true;
end;

procedure TFrmWEBIO.btnGetCounterClick(Sender: TObject);
begin
  lbledtSend.Text := 'GET /counter?PW=%s&';
  WebIO.SendBuffer( Format( 'GET /counter?PW=%s&', [ WEBIO.fSettings[ WEBIO.fActiveModule ].Password ] ), WEBIO.fActiveModule );
end;

procedure TFrmWEBIO.btnTimeClick(Sender: TObject);
begin
  lbledtSend.Text := 'GET /time?PW=%s&';
  WebIO.SendBuffer( Format( 'GET /time?PW=%s&', [ WEBIO.fSettings[ WEBIO.fActiveModule ].Password ] ), WEBIO.fActiveModule );
end;

procedure TFrmWEBIO.btnDiagnosisClick(Sender: TObject);
begin
  lbledtSend.Text := 'GET /diagnosis?PW=%s&';
  WebIO.SendBuffer( Format( 'GET /diagnosis?PW=%s&', [ WEBIO.fSettings[ WEBIO.fActiveModule ].Password ] ), WEBIO.fActiveModule );
end;

procedure TFrmWEBIO.SetShape( ID : byte; state : boolean );
var
  comp : TComponent;
begin
  comp := self.FindComponent( Format('ShapeIn%d',[ID]) );
  if comp <> NIL then
    begin
    if state then
      (comp as TShape).Brush.Color := clLime
    else
      (comp as TShape).Brush.Color := clGreen;
    end;

  comp := self.FindComponent( Format('chkIn%d',[ID]) );
  if comp <> NIL then
    (comp as TCheckBox).checked := state
end;

//---------------------------------------------------------------------------
// OnChange
//---------------------------------------------------------------------------
constructor tOnChangeEvent.Create;
begin
  inherited;
  fInterval := 0;
  SetLength( fLastEventTime, MAX_CHANS_ );
  SetLength( fLastEventTimeSynchronized, MAX_CHANS_ );
  SetLength( Threads, MAX_ONCHANGE_THREADS_ );
  CritSection := TCriticalSection.Create;
end;

destructor tOnChangeEvent.Destroy;
begin
  fInterval := 0;
  CritSection.free;
  inherited;
end;

//procedure tOnChangeEvent.NilUnusedThreads;
//var
//  i : Integer;
//begin
//  CritSection.Enter;
//  for i := 0 to Length(Threads)-1 do
//    begin
//    if Assigned(Threads[i])
//      if (Threads[i].Terminated) then
//          begin
//          Threads[i].free;
//          Threads[i] := nil;
//          end;
//    end;
//  CritSection.Leave;
//end;

function tOnChangeEvent.NilAndReturnIndex: integer;
var
  i : Integer;
begin
  result := -1;

  CritSection.Enter;
  for i := 0 to Length(Threads)-1 do
    begin
    if Assigned(Threads[i]) then
      if (Threads[i].Terminated) then
        begin
        Threads[i].free;
        Threads[i] := nil;
        end;
    if (Threads[i] = nil) then
      begin
      result := i;
      Break;
      end;
    end;
  CritSection.Leave;
end;

function tOnChangeEvent.Add( Rec : tOnChange; Sender : TObject; ModuleID, Chan, ChanOffset : integer; Value : boolean; Synchronized : Boolean = False ): integer;
var
  i : integer;
begin
  result := -2;
  if Synchronized then
    begin
    if NOT (timeGetTime > fLastEventTime[ chan-1+ChanOffset ]+fInterval) then
      Exit;
    fLastEventTime[ chan-1+ChanOffset ] := timeGetTime;
    end
  else
    begin
    if NOT (timeGetTime > fLastEventTimeSynchronized[ chan-1+ChanOffset ]+fInterval) then
      Exit;
    fLastEventTimeSynchronized[ chan-1+ChanOffset ] := timeGetTime;
    end;

  result := -1;
  i := NilAndReturnIndex;
  if (i < 0) then
    Exit;

  Threads[i] := tOnChangeThread.Create( true );
  Threads[i].SetInfos( Rec, Sender, ModuleID, Chan, Value, Synchronized );
  Threads[i].Resume;
  result := 0;
end;

procedure tOnChangeThread.SetInfos( Rec : tOnChange; Sender : TObject; ModuleID, Chan : integer; Value : boolean; Synchronized : Boolean = false );
begin
  fRecDigital := Rec;
  fSender := Sender;
  fModuleID := ModuleID;
  fChan := Chan;
  fbValue := value;
  fSynchronized := synchronized;
end;

Procedure tOnChangeThread.Execution;
begin
  if Assigned(fRecDigital) then
    fRecDigital( fSender, fModuleID, fChan, fbValue );
end;

Procedure tOnChangeThread.Execute;
begin
  if fSynchronized then
    Synchronize( Execution )
  else
    Execution;
  Terminate;
end;

//---------------------------------------------------------------------------
// Base
//---------------------------------------------------------------------------
constructor tBaseCard.Create;
begin
  fOnChangeHandler := tOnChangeEvent.Create;
end;

destructor tBaseCard.Destroy;
begin
  fOnChangeHandler.Free;
end;

function tBaseCard.GetSimulation : Boolean;
begin
  result := fSimulation[ fActiveModule ];
end;

procedure tBaseCard.SetSimulation( val : boolean );
begin
  if (fSimulation[ fActiveModule ] = val) then
    Exit;

  fSimulation[ fActiveModule ] := val;
end;

procedure tBaseCard.SetActiveCard( val : byte );
begin
  if (fActiveModule = val ) OR ( val > Modules-1 ) then
    Exit;

  fActiveModule := val;
end;

function tBaseCard.IsError( ModuleID : SmallInt = -1 ): integer;
begin
  if (ModuleID = -1) then
    ModuleID := fActiveModule
  else
    ModuleID := Min( MAX_MODULES_, Max( 0, ModuleID ) );

  result := fError[ ModuleID ];
end;

function tBaseCard.GetError: integer;
begin
  result := fError[ fActiveModule ];
end;

function tBaseCard.GetOnChangeInterval: Word;
begin
  result := fOnChangeHandler.Interval;
end;

procedure tBaseCard.SetOnChangeInterval( val : Word );
begin
  fOnChangeHandler.Interval := val;
end;

procedure tWEBIOThread.SetFrequency( val : SmallInt );
begin
  if NOT Assigned(self) then
    Exit;

  if (fFrequency = val) then
    Exit;

  if (val < 1) or (val > 1000) then
    Exit;

  fFrequency := val;
end;

constructor tWEBIOThread.Create( CreateSuspended : boolean );
begin
  inherited;
  {$IFDEF ThreadTimeing}
  QueryPerformanceFrequency( fQueryPerformanceFrequency );
  {$ENDIF}
  fFrequency := 10;
end;

Procedure tWEBIOThread.Execute;
const
  TIMEOUTTIME = 1000;
  BUFFERSIZE  = 100;
var
  {$IFDEF ThreadTimeing}
  fStartTime, fEndTime : Int64;
  {$ENDIF}
  i, c : integer;
  start   : dword;
  buffer  : array [ 0..BUFFERSIZE-1 ] of AnsiChar;
  TimeOut : Boolean;

  val     : DWord;
  bVal    : Boolean;  
begin
  while (not Terminated) AND (not suspended) do
    begin
    if (NOT Assigned( WEBIO )) OR (NOT ( WEBIO.Modules > 0 )) then
      begin
      Sleep(Frequency);
      continue;
      end;

    {$IFDEF ThreadTimeing}
    QueryPerformanceCounter( fStartTime );
    {$ENDIF}

    for c := 0 to WEBIO.Modules-1 do
      begin
      if ( Suspended or Terminated ) then
        break;

      if ( NOT WebIO.TCPClient[c].Active ) OR ( GetTickCount < WEBIO.fSettings[c].ConnectTime+500 ) then
        Continue;

      Fillchar( buffer, SizeOf( buffer), 0);
      WebIO.SendBuffer( Format( 'GET /input?PW=%s&', [ WebIO.fSettings[c].Password ] ), c );

      start   := GetTickCount;
      TimeOut := false;
      while (NOT TimeOut) AND ( WebIO.TCPClient[c].Active ) AND ( ( NOT Suspended ) AND ( NOT Terminated ) ) do
        begin
        TimeOut := (GetTickCount - start > TIMEOUTTIME);
        if WebIO.TCPClient[c].WaitForData( 10 ) then
          begin
          i := WebIO.TCPClient[c].PeekBuf( buffer, Length( Buffer ) );
          WebIO.TCPClient[c].ReceiveBuf( buffer, i );

          if ( Matches( buffer,'input;*')) then
            begin
            val := HexToInt( GetTok( buffer, 2, ';' ) );
            if ( WEBIO.fDigitalInVal[ c ] <> val ) then
              begin
              WEBIO.fDigitalInVal[ c ] := val;
              for i := 0 to MAX_CHANS_-1 do
                begin
                bVal := Boolean( ReadBitFromDWord( val, i ) );
                if ( WEBIO.fDigitalIn[ c, i ] <> bVal) then
                  begin
                  if Assigned(WEBIO.OnChange) then
                    WEBIO.fOnChangeHandler.Add( WEBIO.OnChange, self, c, i+1, 0, bVal, false );
                  if Assigned(WEBIO.OnChangeSynchronized) then
                    WEBIO.fOnChangeHandler.Add( WEBIO.OnChangeSynchronized, self, c, i+1, 0, bVal, true );
                  WEBIO.fDigitalIn[ c, i ] := bVal;
                  end;
                end;
              end;
            end;

          WEBIO.lastCommands[c].Check( buffer );
          break;
          end;
        end;

      if TimeOut then
        WEBIO.fError[c] := -2000
      else
        WEBIO.fError[c] := 0;
      end;

    {$IFDEF ThreadTimeing}
    QueryPerformanceCounter( fEndTime );
    fRuntime := ( fEndTime - fStartTime ) * 1000 / fQueryPerformanceFrequency;

    if ( fRuntime >= Frequency ) then
      begin
      fRuntime := fRuntime;
      end
    else if ( fRuntime <= Frequency ) then
      Sleep( Frequency-Trunc(fRuntime) )
    else
    {$ENDIF}
      Sleep(Frequency);
    end;
end;

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
constructor tWEBIO.Create;
var
  i : integer;
begin
  inherited;
  fDeInited := false;
  for i := 0 to MAX_MODULES_-1 do
    begin
    TCPClient[i] := TTCPClient.Create( nil );
    TCPClient[i].OnConnect    := TcpClientConnect;
    TCPClient[i].OnDisconnect := TcpClientDisconnect;
    TCPClient[i].OnReceive    := TcpClientReceive;
    TCPClient[i].OnError      := TCPClientError;
    TCPClient[i].OnSend       := TCPClientSend;

    fSettings[i].IP           := '192.168.2.1';
    fSettings[i].Port         := 80;
    fSettings[i].Password     := '';
    fSettings[i].Channels     := CHAN2;
    fSettings[i].ConnectTime  := 0;
    fSettings[i].Reconnects   := 0;

    lastCommands[i]           := tLastCommand.Create(i);
    end;

  myThread := tWEBIOThread.Create( false );
  myThread.FreeOnTerminate := false;
end;

destructor tWEBIO.Destroy;
begin
  DeInit;
  inherited;
end;

procedure tWEBIO.SetSimulation( val : boolean; ModuleID : SmallInt = -1 );
var
  i : integer;
begin
  if (fSimulation[ fActiveModule ] = val) then
    Exit;
  fSimulation[ fActiveModule ] := val;

  for i := 0 to MAX_CHANS_-1 do
    begin
    if (WEBIO.fDigitalInSim[ WEBIO.fActiveModule, i ] <> WEBIO.fDigitalIn[ WEBIO.fActiveModule, i ]) then
      begin
      if Assigned(WEBIO.OnChange) then
        WEBIO.fOnChangeHandler.Add( WEBIO.OnChange, self, WEBIO.fActiveModule, i+1, 0, Boolean(WEBIO.fDigitalIn[ WEBIO.fActiveModule, i ]), false );
      if Assigned(WEBIO.OnChangeSynchronized) then
        WEBIO.fOnChangeHandler.Add( WEBIO.OnChangeSynchronized, self, WEBIO.fActiveModule, i+1, 0, Boolean(WEBIO.fDigitalIn[ WEBIO.fActiveModule, i ]), true );
      end;
    end;
end;

procedure tWEBIO.pSetSimulation( val : boolean );
begin
  SetSimulation( val );
end;

function tWEBIO.pGetSimulation: boolean;
begin
  result := GetSimulation;
end;

function tWEBIO.IsConnected( ModuleID : Integer = -1 ) : boolean;
begin
  if (ModuleID = -1) then
    ModuleID := fActiveModule
  else
    ModuleID := Min( MAX_MODULES_, Max( 0, ModuleID ) );

  result := WebIO.TCPClient[ ModuleID ].Active;
end;

procedure tWEBIO.Reset( ModuleID : Integer = -1 );
var
  i : integer;
begin
  if (ModuleID = -1) then
    ModuleID := fActiveModule
  else
    ModuleID := Min( MAX_MODULES_, Max( 0, ModuleID ) );
    
  fDigitalInVal[ ModuleID ] := 0;
  fDigitalInValSim[ ModuleID ] := 0;
  fDigitalOutVal[ ModuleID ] := 0;
  for i := 0 to MAX_CHANS_-1 do
    begin
    fDigitalIn[ ModuleID, i ] := false;
    fDigitalInSim[ ModuleID, i ] := false;
    fDigitalOut[ ModuleID, i ] := false;
    end;
end;

function tWEBIO.Connect( IP : string; Port : Word; Password : string; Channels : tWEBIO_CHANS; ModuleID : Integer = -1 ) : integer;
begin
  result := -1;
  if ( IP = '' ) OR ( NOT IsIPv4( IP ) ) then
    Exit;

  result := -2;
  if ( PingHost( IP ) < 0 ) then
    Exit;

  if (ModuleID = -1) then
    ModuleID := Modules
  else
    ModuleID := Min( MAX_MODULES_, Max( 0, ModuleID ) );

  result := -3;
  if NOT TCPClient[ ModuleID ].Active then
    begin
    TCPClient[ ModuleID ].RemoteHost  := IP;
    TCPClient[ ModuleID ].RemotePort  := IntToStr(Port);
    TCPClient[ ModuleID ].Active      := true;

    if ( TCPClient[ ModuleID ].Active ) then
      begin
      fSettings[ ModuleID ].IP          := IP;
      fSettings[ ModuleID ].Port        := Port;
      fSettings[ ModuleID ].Password    := Password;
      fSettings[ ModuleID ].Channels    := Channels;
      fSettings[ ModuleID ].ConnectTime := GetTickCount;
      fSettings[ ModuleID ].Reconnects  := 0;
      WriteAllDigitalOutput( false );      
      Inc(fModuleNum);
      result := 0;
      end;
    end
  else
    result := 0;
end;

function tWEBIO.Disconnect( ModuleID : Integer = -1 ) : integer;
begin
  if (ModuleID = -1) then
    ModuleID := fActiveModule
  else
    ModuleID := Min( MAX_MODULES_, Max( 0, ModuleID ) );

  result := -1;
  fSettings[ ModuleID ].Reconnects := MAX_RECONNECTS_;  
  if TCPClient[ ModuleID ].Active then
    begin
    WriteAllDigitalOutput( false );
    Delay(250);
    fSettings[ ModuleID ].ConnectTime := GetTickCount;
    TCPClient[ ModuleID ].Active := false;
    if ( NOT TCPClient[ ModuleID ].Active ) then
      begin
      Reset( ModuleID );
      result := 0;
      end;
    end
  else
    result := 0;
end;

procedure tWEBIO.DeInit;
var
  i : Integer;
  vDelay : Boolean;
begin
  if fDeInited then
    Exit;
  fDeInited := True;

  vDelay := false;
  for i := 0 to MAX_MODULES_-1 do
    begin
    if Assigned( TCPClient[i] ) then
      begin
      TCPClient[i].OnReceive := nil;
      TCPClient[i].OnError := nil;

      if ( TCPClient[i].Active ) then
        begin
        WriteAllDigitalOutput( false );
        Delay(250);
        end;
      if ( TCPClient[i].Active ) OR ( ( fSettings[i].Reconnects > 0 ) AND ( fSettings[i].Reconnects < MAX_RECONNECTS_ ) ) then
        begin
        fSettings[i].Reconnects := MAX_RECONNECTS_;
        TCPClient[i].Active := False;
        vDelay := True;
        end;
      end;
    end;
  if vDelay then
    Delay( 1000 );

  for i := 0 to MAX_MODULES_-1 do
    begin
    fSettings[i].Reconnects := MAX_RECONNECTS_;
    if Assigned( TCPClient[i] ) then
      begin

      TCPClient[i].Active := false;
      end;
    TCPClient[i].Free;
    lastCommands[i].Free;
    end;

  if Assigned(myThread) then
    begin
    myThread.Terminate;
    while (NOT myThread.Terminated) do
      sleep(10);
    myThread.Free;
    myThread := nil;
    end;

  fModuleNum := 0;
end;

function tWEBIO.Read1DigitalInput( chan : byte; ModuleID : SmallInt = -1 ): byte;
begin
  if (ModuleID = -1) then
    ModuleID := fActiveModule
  else
    ModuleID := Min( MAX_MODULES_, Max( 0, ModuleID ) );

  result := 0;
  if NOT ( chan in [1..MAX_CHANS_] ) then
    Exit;

  if Simulation then
    result := Integer(fDigitalInSim[ ModuleID, chan-1 ])
  else
    result := Integer(fDigitalIn[ ModuleID, chan-1 ]);
end;

function tWEBIO.Read1DigitalOutput( chan : byte; ModuleID : SmallInt = -1 ): byte;
begin
  if (ModuleID = -1) then
    ModuleID := fActiveModule
  else
    ModuleID := Min( MAX_MODULES_, Max( 0, ModuleID ) );

  result := 0;
  if NOT ( chan in [1..MAX_CHANS_] ) then
    Exit;

  result := Integer(fDigitalOut[ ModuleID, chan-1 ]);
end;

function tWEBIO.ReadAllDigitalInput( var value : Byte; ModuleID : SmallInt = -1 ) : boolean;
begin
  if (ModuleID = -1) then
    ModuleID := fActiveModule
  else
    ModuleID := Min( MAX_MODULES_, Max( 0, ModuleID ) );

  result := true;
  if Simulation then
    value := fDigitalInValSim[ ModuleID ]
  else
    value := fDigitalInVal[ ModuleID ];
end;

function tWEBIO.WriteAllDigitalOutput( value : boolean; ModuleID : SmallInt = -1 ): integer;
var
  i : integer;
begin
  if (ModuleID = -1) then
    ModuleID := fActiveModule
  else
    ModuleID := Min( MAX_MODULES_, Max( 0, ModuleID ) );

  result := -1;
  if NOT TCPClient[ModuleID].Active then
    begin
    fError[ModuleID] := result;
    Exit;
    end;

  SendBuffer( Format( 'GET /outputaccess?PW=%s&State=%d&', [ fSettings[ModuleID].Password, Byte( value ) ] ), ModuleID );
  for i := 0 to MAX_CHANS_-1 do
    begin
    fDigitalOut[ ModuleID, i ] := value;
    if Assigned(WEBIO.OnOutChange) then
      WEBIO.fOnChangeHandler.Add( WEBIO.OnOutChange, self, ModuleID, i+1, MAX_CHANS_-1, Boolean(value), false );
    if Assigned(WEBIO.OnOutChangeSynchronized) then
      WEBIO.fOnChangeHandler.Add( WEBIO.OnOutChangeSynchronized, self, ModuleID, i+1, MAX_CHANS_-1, Boolean(value), true );
    end;
  result := 0;
end;

function tWEBIO.Write1DigitalOutput( chan, value : byte; ModuleID : SmallInt = -1 ): integer;
var
  state : string;
  i     : Integer;
  val   : DWord;
begin
  if (ModuleID = -1) then
    ModuleID := fActiveModule
  else
    ModuleID := Min( MAX_MODULES_, Max( 0, ModuleID ) );

  result := -1;
  if NOT ( chan in [1..MAX_CHANS_] ) then
    Exit;

  if ( fDigitalOut[ ModuleID, chan-1 ] = Boolean(value) ) then
    begin
    result := 0;
    Exit;
    end;

  result := -2;
  if ( NOT TCPClient[ModuleID].Active ) then
    begin
    fError[ModuleID] := result;
    Exit;
    end;

  if Boolean(value) then
    state := 'ON'
  else
    state := 'OFF';
  SendBuffer( Format( 'GET /outputaccess%d?PW=%s&State=%s&', [ chan-1, fSettings[ModuleID].Password, state ]), ModuleID );

  fDigitalOut[ ModuleID, chan-1 ] := Boolean(value);
  if Assigned(WEBIO.OnOutChange) then
    WEBIO.fOnChangeHandler.Add( WEBIO.OnOutChange, self, ModuleID, chan, MAX_CHANS_-1, Boolean(value), false );
  if Assigned(WEBIO.OnOutChangeSynchronized) then
    WEBIO.fOnChangeHandler.Add( WEBIO.OnOutChangeSynchronized, self, ModuleID, chan, MAX_CHANS_-1, Boolean(value), true );

  val := 0;
  for i := 0 to MAX_CHANS_-1 do
    val := WriteBitInDWord(val, Byte(WEBIO.fDigitalInSim[ ModuleID, i ]), i);
  WEBIO.fDigitalOutVal[ ModuleID ] := val;

  result := 0;
  fError[ModuleID] := result;
end;

function tWEBIO.Write1DigitalInputSim( chan, value : byte; ModuleID : SmallInt = -1 ): integer;
var
  i : integer;
  val : DWord;
begin
  if (ModuleID = -1) then
    ModuleID := fActiveModule
  else
    ModuleID := Min( MAX_MODULES_, Max( 0, ModuleID ) );

  result := -1;
  if NOT ( chan in [1..MAX_CHANS_] ) then
    Exit;

  result := 0;
  if (fDigitalInSim[ ModuleID, chan-1 ] = Boolean(value)) then
    Exit;
  WEBIO.fDigitalInSim[ ModuleID, chan-1 ] := Boolean(value);

  val := 0;
  for i := 0 to MAX_CHANS_-1 do
    val := WriteBitInDWord(val, Byte(WEBIO.fDigitalInSim[ ModuleID, i ]), i);
  WEBIO.fDigitalInValSim[ ModuleID ] := val;

  if WEBIO.Simulation then
    begin
    if Assigned(WEBIO.OnChange) then
      WEBIO.fOnChangeHandler.Add( WEBIO.OnChange, self, ModuleID, chan, 0, Boolean(value), false );
    if Assigned(WEBIO.OnChangeSynchronized) then
      WEBIO.fOnChangeHandler.Add( WEBIO.OnChangeSynchronized, self, ModuleID, chan, 0, Boolean(value), true );
    end
  else
    Result := -1;
end;

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------

procedure tWEBIO.TcpClientConnect(Sender: TObject);
var
  i, ModuleID : Integer;
begin
  if NOT (Sender is TTCPClient) then
    Exit;

  ModuleID := -1;
  for i := 0 to fModuleNum-1 do
    begin
    if ( (Sender as TTCPClient).RemoteHost = fSettings[ i ].IP ) then
      begin
      ModuleID := i;
      Break;
      end;
    end;
  if ( ModuleID < 0 ) then
    Exit;

  fError[ ModuleID ] := 0;
end;

procedure tWEBIO.TcpClientDisconnect(Sender: TObject);
var
  i, ModuleID : Integer;
begin
  if NOT (Sender is TTCPClient) then
    Exit;

  ModuleID := -1;
  for i := 0 to fModuleNum-1 do
    begin
    if ( (Sender as TTCPClient).RemoteHost = fSettings[ i ].IP ) then
      begin
      ModuleID := i;
      Break;
      end;
    end;
  if ( ModuleID < 0 ) then
    Exit;

  fError[ ModuleID ] := -1000;
end;

{$WARNINGS OFF}
procedure tWEBIO.TcpClientSend(Sender: TObject; Buf: PAnsiChar; var DataLen: Integer);
var
  i, ModuleID : Integer;
begin
  if NOT (Sender is TTCPClient) then
    Exit;

  ModuleID := -1;
  for i := 0 to fModuleNum-1 do
    begin
    if ( (Sender as TTCPClient).RemoteHost = fSettings[ i ].IP ) then
      begin
      ModuleID := i;
      Break;
      end;
    end;
  if ( ModuleID < 0 ) then
    Exit;

//  if ModuleID = WEBIO.fActiveModule then
//    FrmWebIO.lbledtSend.Text := Buf;
end;

procedure tWEBIO.TcpClientError(Sender: TObject; SocketError: Integer);
var
  i : integer;
  ModuleID : Integer;
begin
  if ( NOT Assigned( self ) ) OR ( NOT (Sender is TTCPClient) ) then
    Exit;

  ModuleID := -1;
  for i := 0 to fModuleNum-1 do
    begin
    if ( (Sender as TTCPClient).RemoteHost = fSettings[ i ].IP ) then
      begin
      ModuleID := i;
      Break;
      end;
    end;
  if ( ModuleID < 0 ) then
    Exit;

  if Assigned( FrmWebIO ) then
    if FrmWebIO.Visible then
      FrmWebIO.mmoError.Lines.Add( Format( 'ID: %d - Connection Error: %d', [ ModuleID, SocketError ] ) );

  if TcpClient[ModuleID].Active then
    TcpClient[ModuleID].Active  := false;

  if ( SocketError = 10038 ) OR ( SocketError = 10057 ) OR ( SocketError = 10058 ) OR ( SocketError = 10049 ) OR ( SocketError = 10060 ) then
    Exit;

  if ( fSettings[ ModuleID ].ConnectTime < GetTickCount+1000 ) then
    begin
    if ( fSettings[ ModuleID ].Reconnects >= MAX_RECONNECTS_ ) then
      begin
      if Assigned( FrmWebIO ) then
        if FrmWebIO.Visible then
          FrmWebIO.mmoError.Lines.Add( Format( 'ID: %d - Reconnect failed %d times, stopping..', [ ModuleID, fSettings[ ModuleID ].Reconnects ] ) );
      Exit;
      end
    else
      begin
      fSettings[ ModuleID ].Reconnects := fSettings[ ModuleID ].Reconnects+1;
      Delay(1000);
      end;
    end
  else
    fSettings[ ModuleID ].Reconnects := 0;

  if ( PingHost( TcpClient[ ModuleID ].RemoteHost ) < 0 ) then
    begin
    fError[ModuleID] := -300;
    Exit;
    end;

  if NOT TcpClient[ ModuleID ].Active then
    begin
    fSettings[ ModuleID ].ConnectTime := GetTickCount;
    TcpClient[ ModuleID ].Active := true;

    if NOT Assigned( self ) then
      Exit;

    if Assigned( FrmWebIO ) then
      if FrmWebIO.Visible then
        if TcpClient[ ModuleID ].Active then
          FrmWebIO.mmoError.Lines.Add( Format( 'ID: %d - Connection reinitialised', [ ModuleID ] ) )
        else
          FrmWebIO.mmoError.Lines.Add( Format( 'ID: %d - Connection reinitialisation failed', [ ModuleID ] ));

    fError[ModuleID] := -200;
    end;
end;

procedure tWEBIO.TcpClientReceive(Sender: TObject; Buf: PAnsiChar; var DataLen: Integer);
var
  i        : Integer;
  ModuleID : Integer;
  val      : DWord;
  bVal     : Boolean;
begin
  if ( NOT Assigned( self ) ) OR ( NOT (Sender is TTCPClient) ) then
    Exit;

  ModuleID := -1;
  for i := 0 to fModuleNum-1 do
    begin
    if ( (Sender as TTCPClient).RemoteHost = fSettings[ i ].IP ) then
      begin
      ModuleID := i;
      Break;
      end;
    end;
  if ( ModuleID < 0 ) then
    Exit;

  if ( Matches( buf,'input;*' ) ) OR ( Matches( buf,'output;*' ) ) then // Hide Thread and Outputs
    Exit;

  if ( ModuleID = WEBIO.fActiveModule ) then
    if Assigned( FrmWebIO ) then
      if FrmWebIO.Visible then
        FrmWebIO.lbledtReceive.Text := buf;

  {
  //** if something like "input;0123"
  if ( Matches( buf,'input;*')) then
    begin
    val := HexToInt( GetTok( Buf, 2, ';' ) );
    if ( WEBIO.fDigitalInVal[ ModuleID ] <> val ) then
      begin
      WEBIO.fDigitalInVal[ ModuleID ] := val;
      for i := 0 to MAX_CHANS_-1 do
        begin
        bVal := Boolean( ReadBitFromDWord( val, i ) );
        if ( WEBIO.fDigitalIn[ ModuleID, i ] <> bVal) then
          begin
          if Assigned(WEBIO.OnChange) then
            WEBIO.fOnChangeHandler.Add( WEBIO.OnChange, self, ModuleID, i+1, 0, bVal, false );
          if Assigned(WEBIO.OnChangeSynchronized) then
            WEBIO.fOnChangeHandler.Add( WEBIO.OnChangeSynchronized, self, ModuleID, i+1, 0, bVal, true );
          WEBIO.fDigitalIn[ ModuleID, i ] := bVal;
          end;
        end;
      end;
    end;
  }

  //** if something like "input3;ON"
  if ( Matches( buf,'input?;O*')) then
    begin
    i := StrToInt( Copy( buf, 6, 1));
    fDigitalIn[ 0, i ] := ( GetTok( Buf, 2, ';' ) = 'ON' );
    val := 0;
    for i := 0 to MAX_CHANS_-1 do
      val := WriteBitInDWord(val, Byte(fDigitalIn[ ModuleID, i ]), i);
    fDigitalInVal[ ModuleID ] := val;
    end;

  //** if something like "input11;ON"
  if (Matches(buf,'input??;O*')) then
    begin
    i := StrToInt( Copy( buf, 6, 2));
    fDigitalIn[ 0, i ] := ( GetTok( Buf, 2, ';' ) = 'ON' );
    val := 0;
    for i := 0 to MAX_CHANS_-1 do
      val := WriteBitInDWord(val, Byte(fDigitalIn[ ModuleID, i ]), i);
    fDigitalInVal[ ModuleID ] := val;
    end;

  //** output values
  //** if something like "output;0123"
  if ( Matches( buf, 'output;*')) then
    begin
    val := HexToInt( GetTok( Buf, 2, ';' ) );
    if ( WEBIO.fDigitalOutVal[ ModuleID ] <> val ) then
      begin
      WEBIO.fDigitalOutVal[ ModuleID ] := val;
      for i := 0 to MAX_CHANS_-1 do
        begin
        bVal := Boolean( ReadBitFromDWord( val, i ) );
        if ( WEBIO.fDigitalOut[ ModuleID, i ] <> bVal) then
          begin
          if Assigned(WEBIO.OnOutChange) then
            WEBIO.fOnChangeHandler.Add( WEBIO.OnOutChange, self, ModuleID, i+1, 0, bVal, false );
          if Assigned(WEBIO.OnOutChangeSynchronized) then
            WEBIO.fOnChangeHandler.Add( WEBIO.OnOutChangeSynchronized, self, ModuleID, i+1, 0, bVal, true );
          WEBIO.fDigitalOut[ ModuleID, i ] := bVal;
          end;
        end;
      end;
    end;

  //** if something like "output3;ON"
  if ( Matches( buf, 'output?;O*')) then
    begin
    i := StrToInt(Copy( buf, 7, 1));
    fDigitalOut[ 0, i ] := ( GetTok( Buf, 2, ';' ) = 'ON' );
    end;

  //** if something like "output11;ON"
  if (Matches(buf,'output??;O?*')) then
    begin
    i := StrToInt(Copy( buf, 7, 2));
    fDigitalOut[ 0, i ] := ( GetTok( Buf, 2, ';' ) = 'ON' );
    end;

   (*
   //** counter values
  //** if something like "counter3;456"
  if (Matches(buf,'counter?;???')) then
   begin
   bitposition := strtoint( Copy( buf, pos1 - 1, 1));
   (FindComponent( 'ed_counter' + inttostr(bitposition)) as TEdit).Text := GetTok( Buf, 2, ';' );
   end;

  //** if something like "counter11;456"
  if (Matches(buf,'counter??;???')) then
   begin
   bitposition := Strtoint( Copy( buf, pos1 - 2, 2));
   (FindComponent( 'ed_counter' + inttostr(bitposition)) as TEdit).Text := GetTok( Buf, 2, ';' );
   end; *)
end;
{$WARNINGS ON}

function tWEBIO.SendBuffer( str : string; ModuleID : Integer = -1 ):Integer;
//results: 0=ok, -1=waiting for reply (not send), -2=exceeded waiting time for last reply
var
  buffer : array [0..100] of byte;
  i      : integer;
begin
  result := -1;
  if ( NOT Assigned( self ) ) then
    Exit;

  if (ModuleID = -1) then
    ModuleID := fActiveModule
  else
    ModuleID := Min( MAX_MODULES_, Max( 0, ModuleID ) );

  if NOT ( TCPClient[ ModuleID ].Active ) then
    Exit;

  Fillchar( buffer, SizeOf( buffer ), 0);
  for i := 0 to Length( str ) - 1 do
    buffer[ i ] := Byte( str[ i + 1 ] );
  TcpClient[ModuleID].SendBuf( buffer, Length( str ));

  lastCommands[ ModuleID ].Add( str );
  result := 0;
end;

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------

function Matches(const S,Wildcard: String): Boolean;
var
  Mask: TMask;
begin
  Mask := TMask.Create(Wildcard);
  Result := Mask.Matches(S);
  Mask.Free;
end;

initialization
  WEBIO := tWEBIO.Create;
finalization
  WEBIO.free;

end.
