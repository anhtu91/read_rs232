unit RawInputKeyboardHook;

{
  TetzkatLipHoka 2016

  Source: CnRawInput.pas
}

{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_CAST OFF}

interface

uses
  SysUtils, Windows, Messages, Classes, Forms;

const
  WM_INPUT          = $00FF;
  WM_HOOK           = WM_USER + 666;  
  RIM_INPUT         = 0;
  RIM_INPUTSINK     = 1;
  RIM_TYPEMOUSE     = 0;
  RIM_TYPEKEYBOARD  = 1;
  RIM_TYPEHID       = 2;

  RI_MOUSE_LEFT_BUTTON_DOWN   = $0001; // Left Button changed to down.
  {$EXTERNALSYM RI_MOUSE_LEFT_BUTTON_DOWN}
  RI_MOUSE_LEFT_BUTTON_UP     = $0002; // Left Button changed to up.
  {$EXTERNALSYM RI_MOUSE_LEFT_BUTTON_UP}
  RI_MOUSE_RIGHT_BUTTON_DOWN  = $0004; // Right Button changed to down.
  {$EXTERNALSYM RI_MOUSE_RIGHT_BUTTON_DOWN}
  RI_MOUSE_RIGHT_BUTTON_UP    = $0008; // Right Button changed to up.
  {$EXTERNALSYM RI_MOUSE_RIGHT_BUTTON_UP}
  RI_MOUSE_MIDDLE_BUTTON_DOWN = $0010; // Middle Button changed to down.
  {$EXTERNALSYM RI_MOUSE_MIDDLE_BUTTON_DOWN}
  RI_MOUSE_MIDDLE_BUTTON_UP   = $0020; // Middle Button changed to up.
  {$EXTERNALSYM RI_MOUSE_MIDDLE_BUTTON_UP}
 
  RI_MOUSE_BUTTON_1_DOWN = RI_MOUSE_LEFT_BUTTON_DOWN;
  {$EXTERNALSYM RI_MOUSE_BUTTON_1_DOWN}
  RI_MOUSE_BUTTON_1_UP   = RI_MOUSE_LEFT_BUTTON_UP;
  {$EXTERNALSYM RI_MOUSE_BUTTON_1_UP}
  RI_MOUSE_BUTTON_2_DOWN = RI_MOUSE_RIGHT_BUTTON_DOWN;
  {$EXTERNALSYM RI_MOUSE_BUTTON_2_DOWN}
  RI_MOUSE_BUTTON_2_UP   = RI_MOUSE_RIGHT_BUTTON_UP;
  {$EXTERNALSYM RI_MOUSE_BUTTON_2_UP}
  RI_MOUSE_BUTTON_3_DOWN = RI_MOUSE_MIDDLE_BUTTON_DOWN;
  {$EXTERNALSYM RI_MOUSE_BUTTON_3_DOWN}
  RI_MOUSE_BUTTON_3_UP   = RI_MOUSE_MIDDLE_BUTTON_UP;
  {$EXTERNALSYM RI_MOUSE_BUTTON_3_UP}
 
  RI_MOUSE_BUTTON_4_DOWN = $0040;
  {$EXTERNALSYM RI_MOUSE_BUTTON_4_DOWN}
  RI_MOUSE_BUTTON_4_UP   = $0080;
  {$EXTERNALSYM RI_MOUSE_BUTTON_4_UP}
  RI_MOUSE_BUTTON_5_DOWN = $0100;
  {$EXTERNALSYM RI_MOUSE_BUTTON_5_DOWN}
  RI_MOUSE_BUTTON_5_UP   = $0200;
  {$EXTERNALSYM RI_MOUSE_BUTTON_5_UP}
 
  RI_MOUSE_WHEEL = $0400;
  {$EXTERNALSYM RI_MOUSE_WHEEL}

  MOUSE_MOVE_RELATIVE      = 0;
  {$EXTERNALSYM MOUSE_MOVE_RELATIVE}
  MOUSE_MOVE_ABSOLUTE      = 1;
  {$EXTERNALSYM MOUSE_MOVE_ABSOLUTE}
  MOUSE_VIRTUAL_DESKTOP    = $02; // the coordinates are mapped to the virtual desktop
  {$EXTERNALSYM MOUSE_VIRTUAL_DESKTOP}
  MOUSE_ATTRIBUTES_CHANGED = $04; // requery for mouse attributes
  {$EXTERNALSYM MOUSE_ATTRIBUTES_CHANGED}

  KEYBOARD_OVERRUN_MAKE_CODE = $FF;
  {$EXTERNALSYM KEYBOARD_OVERRUN_MAKE_CODE}
 
  RI_KEY_MAKE            = 0;
  {$EXTERNALSYM RI_KEY_MAKE}
  RI_KEY_BREAK           = 1;
  {$EXTERNALSYM RI_KEY_BREAK}
  RI_KEY_E0              = 2;
  {$EXTERNALSYM RI_KEY_E0}
  RI_KEY_E1              = 4;
  {$EXTERNALSYM RI_KEY_E1}
  RI_KEY_TERMSRV_SET_LED = 8;
  {$EXTERNALSYM RI_KEY_TERMSRV_SET_LED}
  RI_KEY_TERMSRV_SHADOW  = $10;
  {$EXTERNALSYM RI_KEY_TERMSRV_SHADOW}

  RID_INPUT  = $10000003;
  {$EXTERNALSYM RID_INPUT}
  RID_HEADER = $10000005;
  {$EXTERNALSYM RID_HEADER}

  RIDI_PREPARSEDDATA = $20000005;
  {$EXTERNALSYM RIDI_PREPARSEDDATA}
  RIDI_DEVICENAME    = $20000007; // the return valus is the character length, not the byte size
  {$EXTERNALSYM RIDI_DEVICENAME}
  RIDI_DEVICEINFO    = $2000000b;
  {$EXTERNALSYM RIDI_DEVICEINFO}

  RIDEV_REMOVE       = $00000001;
  {$EXTERNALSYM RIDEV_REMOVE}
  RIDEV_EXCLUDE      = $00000010;
  {$EXTERNALSYM RIDEV_EXCLUDE}
  RIDEV_PAGEONLY     = $00000020;
  {$EXTERNALSYM RIDEV_PAGEONLY}
  RIDEV_NOLEGACY     = $00000030;
  {$EXTERNALSYM RIDEV_NOLEGACY}
  RIDEV_INPUTSINK    = $00000100;
  {$EXTERNALSYM RIDEV_INPUTSINK}
  RIDEV_CAPTUREMOUSE = $00000200; // effective when mouse nolegacy is specified, otherwise it would be an error
  {$EXTERNALSYM RIDEV_CAPTUREMOUSE}
  RIDEV_NOHOTKEYS    = $00000200; // effective for keyboard.
  {$EXTERNALSYM RIDEV_NOHOTKEYS}
  RIDEV_APPKEYS      = $00000400;  // effective for keyboard.
  {$EXTERNALSYM RIDEV_APPKEYS}
  RIDEV_EXMODEMASK   = $000000F0;
  {$EXTERNALSYM RIDEV_EXMODEMASK}    

type
  HRAWINPUT = THANDLE;

  tagRAWINPUTHEADER = record
    dwType: DWORD;
    dwSize: DWORD;
    hDevice: THANDLE;
    wParam: WPARAM;
  end;
  {$EXTERNALSYM tagRAWINPUTHEADER}
  RAWINPUTHEADER = tagRAWINPUTHEADER;
  {$EXTERNALSYM RAWINPUTHEADER}
  PRAWINPUTHEADER = ^RAWINPUTHEADER;
  {$EXTERNALSYM PRAWINPUTHEADER}
  LPRAWINPUTHEADER = ^RAWINPUTHEADER;
  {$EXTERNALSYM LPRAWINPUTHEADER}
  TRawInputHeader = RAWINPUTHEADER;
 
  tagRAWMOUSE = record
    usFlags: WORD;
    union: record
    case Integer of
      0: (
        ulButtons: ULONG);
      1: (
        usButtonFlags: WORD;
        usButtonData: WORD);
    end;
    ulRawButtons: ULONG;
    lLastX: LongInt;
    lLastY: LongInt;
    ulExtraInformation: ULONG;
  end;
  {$EXTERNALSYM tagRAWMOUSE}
  RAWMOUSE = tagRAWMOUSE;
  {$EXTERNALSYM RAWMOUSE}
  PRAWMOUSE = ^RAWMOUSE;
  {$EXTERNALSYM PRAWMOUSE}
  LPRAWMOUSE = ^RAWMOUSE;
  {$EXTERNALSYM LPRAWMOUSE}
  TRawMouse = RAWMOUSE;
 
  tagRAWKEYBOARD = record
    MakeCode: WORD;
    Flags: WORD;
    Reserved: WORD;
    VKey: WORD;
    Message: UINT;
    ExtraInformation: ULONG;
  end;
  {$EXTERNALSYM tagRAWKEYBOARD}
  RAWKEYBOARD = tagRAWKEYBOARD;
  {$EXTERNALSYM RAWKEYBOARD}
  PRAWKEYBOARD = ^RAWKEYBOARD;
  {$EXTERNALSYM PRAWKEYBOARD}
  LPRAWKEYBOARD = ^RAWKEYBOARD;
  {$EXTERNALSYM LPRAWKEYBOARD}
  TRawKeyBoard = RAWKEYBOARD;
 
  tagRAWHID = record
    dwSizeHid: DWORD;    // byte size of each report
    dwCount: DWORD;      // number of input packed
    bRawData: array [0..0] of BYTE;
  end;
  {$EXTERNALSYM tagRAWHID}
  RAWHID = tagRAWHID;
  {$EXTERNALSYM RAWHID}
  PRAWHID = ^RAWHID;
  {$EXTERNALSYM PRAWHID}
  LPRAWHID = ^RAWHID;
  {$EXTERNALSYM LPRAWHID}
  TRawHid = RAWHID;
 
  tagRAWINPUT = record
    header: RAWINPUTHEADER;
    case Integer of
      0: (mouse: RAWMOUSE);
      1: (keyboard: RAWKEYBOARD);
      2: (hid: RAWHID);
  end;
  {$EXTERNALSYM tagRAWINPUT}
  RAWINPUT = tagRAWINPUT;
  {$EXTERNALSYM RAWINPUT}
  PRAWINPUT = ^RAWINPUT;
  {$EXTERNALSYM PRAWINPUT}
  LPRAWINPUT = ^RAWINPUT;
  {$EXTERNALSYM LPRAWINPUT}
  TRawInput = RAWINPUT;

  PRID_DEVICE_INFO_MOUSE = ^RID_DEVICE_INFO_MOUSE;
  {$EXTERNALSYM PRID_DEVICE_INFO_MOUSE}
  tagRID_DEVICE_INFO_MOUSE = record
    dwId: DWORD;
    dwNumberOfButtons: DWORD;
    dwSampleRate: DWORD;
  end;
  {$EXTERNALSYM tagRID_DEVICE_INFO_MOUSE}
  RID_DEVICE_INFO_MOUSE = tagRID_DEVICE_INFO_MOUSE;
  {$EXTERNALSYM RID_DEVICE_INFO_MOUSE}
  TRidDeviceInfoMouse = RID_DEVICE_INFO_MOUSE;
  PRidDeviceInfoMouse = PRID_DEVICE_INFO_MOUSE;
 
  PRID_DEVICE_INFO_KEYBOARD = ^RID_DEVICE_INFO_KEYBOARD;
  {$EXTERNALSYM PRID_DEVICE_INFO_KEYBOARD}
  tagRID_DEVICE_INFO_KEYBOARD = record
    dwType: DWORD;
    dwSubType: DWORD;
    dwKeyboardMode: DWORD;
    dwNumberOfFunctionKeys: DWORD;
    dwNumberOfIndicators: DWORD;
    dwNumberOfKeysTotal: DWORD;
  end;
  {$EXTERNALSYM tagRID_DEVICE_INFO_KEYBOARD}
  RID_DEVICE_INFO_KEYBOARD = tagRID_DEVICE_INFO_KEYBOARD;
  {$EXTERNALSYM RID_DEVICE_INFO_KEYBOARD}
  TRidDeviceInfoKeyboard = RID_DEVICE_INFO_KEYBOARD;
  PRidDeviceInfoKeyboard = PRID_DEVICE_INFO_KEYBOARD;
 
  PRID_DEVICE_INFO_HID = ^RID_DEVICE_INFO_HID;
  {$EXTERNALSYM PRID_DEVICE_INFO_HID}
  tagRID_DEVICE_INFO_HID = record
    dwVendorId: DWORD;
    dwProductId: DWORD;
    dwVersionNumber: DWORD;
    usUsagePage: WORD;
    usUsage: WORD;
  end;
  {$EXTERNALSYM tagRID_DEVICE_INFO_HID}
  RID_DEVICE_INFO_HID = tagRID_DEVICE_INFO_HID;
  {$EXTERNALSYM RID_DEVICE_INFO_HID}
  TRidDeviceInfoHid = RID_DEVICE_INFO_HID;
  PRidDeviceInfoHid = PRID_DEVICE_INFO_HID;
 
  tagRID_DEVICE_INFO = record
    cbSize: DWORD;
    dwType: DWORD;
    case Integer of
    0: (mouse: RID_DEVICE_INFO_MOUSE);
    1: (keyboard: RID_DEVICE_INFO_KEYBOARD);
    2: (hid: RID_DEVICE_INFO_HID);
  end;
  {$EXTERNALSYM tagRID_DEVICE_INFO}
  RID_DEVICE_INFO = tagRID_DEVICE_INFO;
  {$EXTERNALSYM RID_DEVICE_INFO}
  PRID_DEVICE_INFO = ^RID_DEVICE_INFO;
  {$EXTERNALSYM PRID_DEVICE_INFO}
  LPRID_DEVICE_INFO = ^RID_DEVICE_INFO;
  {$EXTERNALSYM LPRID_DEVICE_INFO}
  TRidDeviceInfo = RID_DEVICE_INFO;
  PRidDeviceInfo = PRID_DEVICE_INFO;

  TGetRawInputDeviceInfo = function (hDevice: THANDLE; uiCommand: UINT; pData: POINTER;
    var pcbSize: UINT): UINT; stdcall;

  TGetRawInputBuffer = function (pData: PRAWINPUT; var pcbSize: UINT;
    cbSizeHeader: UINT): UINT; stdcall;

  TGetRawInputData = function (hRawInput: HRAWINPUT; uiCommand: UINT; pData: POINTER;
    var pcbSize: UINT; cbSizeHeader: UINT): UINT; stdcall;

  LPRAWINPUTDEVICE = ^RAWINPUTDEVICE;
  {$EXTERNALSYM LPRAWINPUTDEVICE}
  PRAWINPUTDEVICE = ^RAWINPUTDEVICE;
  {$EXTERNALSYM PRAWINPUTDEVICE}
  tagRAWINPUTDEVICE = record
    usUsagePage: WORD; // Toplevel collection UsagePage
    usUsage: WORD;     // Toplevel collection Usage
    dwFlags: DWORD;
    hwndTarget: HWND;    // Target hwnd. NULL = follows keyboard focus
  end;
  {$EXTERNALSYM tagRAWINPUTDEVICE}
  RAWINPUTDEVICE = tagRAWINPUTDEVICE;
  {$EXTERNALSYM RAWINPUTDEVICE}
  TRawInputDevice = RAWINPUTDEVICE;

  PRAWINPUTDEVICELIST = ^RAWINPUTDEVICELIST;
  {$EXTERNALSYM PRAWINPUTDEVICELIST}
  tagRAWINPUTDEVICELIST = record
    hDevice: THANDLE;
    dwType: DWORD;
  end;
  {$EXTERNALSYM tagRAWINPUTDEVICELIST}
  RAWINPUTDEVICELIST = tagRAWINPUTDEVICELIST;
  {$EXTERNALSYM RAWINPUTDEVICELIST}
  TRawInputDeviceList = RAWINPUTDEVICELIST;
 
  TGetRawInputDeviceList = function (pRawInputDeviceList: PRAWINPUTDEVICELIST; var puiNumDevices: UINT; cbSize: UINT): UINT; stdcall;

  TRegisterRawInputDevices = function (pRawInputDevices: PRAWINPUTDEVICE; uiNumDevices: UINT; cbSize: UINT): BOOL; stdcall;

  TGetRegisteredRawInputDevices = function (pRawInputDevices: PRAWINPUTDEVICE; var puiNumDevices: UINT; cbSize: UINT): UINT; stdcall;

  TOnRawKeyEvent = function (Sender: TObject; RI: tagRAWINPUT ) : Boolean of object;
  TOnRawKey = function (Sender: TObject; Key: Word; FromKeyBoard: THandle) : Boolean of object;

  TQueueItem = record
    VK      : Word;
    Handled : Boolean;
  end;  

  TRawKeyboardHook = class(TComponent)
  private
    FEnabled: Boolean;
    FDevices: array of RAWINPUTDEVICELIST;
    FKeyBoardNames: TStrings;
    FRegistered: Boolean;
    FOnRawKeyDown: TOnRawKey;
    FOnRawKeyUp: TOnRawKey;
    FOnRawKey: TOnRawKeyEvent;
    FKeyBoardCount: Integer;
    fItemFound : boolean;
    fItems : Array of tQueueItem;
    procedure RegisterRawInput;
    function GetKeyBoardCount: Integer;
    procedure SetEnabled(const Value: Boolean);
    function GetKeyBoardName(Index: Integer): string;
  protected
    procedure WinProc(var Message: TMessage);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure UpdateKeyBoardsInfo;
    function KeyBoardNameFromHandle(KeyHandle: THandle): string;
    property KeyBoardCount: Integer read GetKeyBoardCount;
    property KeyBoardName[Index: Integer]: string read GetKeyBoardName;
  published
    property Enabled: Boolean read FEnabled write SetEnabled;
    property OnRawKeyDown: TOnRawKey read FOnRawKeyDown write FOnRawKeyDown;
    property OnRawKeyUp: TOnRawKey read FOnRawKeyUp write FOnRawKeyUp;
    property OnRawKey: TOnRawKeyEvent read FOnRawKey write FOnRawKey;    
  end;

function KeyboardHookProc(Code: Integer; WordParam: Word; LongParam: LongInt): LongInt; stdcall;

var
  RawKeyboardHook : TRawKeyboardHook;

implementation

var
  WndHandle : THandle;
  KeyBoardHook : HHook;
  User32DllHandle: THandle = 0;
  User32NeedFree: Boolean = False;

  GetRawInputDeviceInfo        : TGetRawInputDeviceInfo        = nil;
  GetRawInputBuffer            : TGetRawInputBuffer            = nil;
  GetRawInputData              : TGetRawInputData              = nil;
  GetRawInputDeviceList        : TGetRawInputDeviceList        = nil;
  RegisterRawInputDevices      : TRegisterRawInputDevices      = nil;
  GetRegisteredRawInputDevices : TGetRegisteredRawInputDevices = nil;

{ TRawKeyboardHook }

constructor TRawKeyboardHook.Create(AOwner: TComponent);
begin
  inherited;
  if @GetRawInputDeviceInfo = nil then
    raise Exception.Create('Only Windows XP/2003 or Later can be Supported.');

  FEnabled := False;
  FKeyBoardNames := TStringList.Create;
  if WndHandle = 0 then
    WndHandle := {$IF CompilerVersion >= 14}Classes.{$IFEND}AllocateHWnd(WinProc);

  SetLength(fItems, 0);
  UpdateKeyBoardsInfo;
end;

destructor TRawKeyboardHook.Destroy;
begin
  if WndHandle <> 0 then
    begin
    {$IF CompilerVersion >= 14}Classes.{$IFEND}DeallocateHWnd(WndHandle);
    WndHandle := 0;
    end;

  FKeyBoardNames.Free;
  SetLength(FDevices, 0);
  SetLength(fItems, 0);
  inherited;
end;

function TRawKeyboardHook.GetKeyBoardCount: Integer;
begin
  Result := FKeyBoardCount;
end;

procedure TRawKeyboardHook.RegisterRawInput;
var
  Device: array[0..0] of RAWINPUTDEVICE;
begin
  if FRegistered then
    Exit;

  Device[0].usUsagePage := RIM_TYPEKEYBOARD;
  Device[0].usUsage     := 6; //6 ??????
  Device[0].hwndTarget := WndHandle;

//  if FBackground then
    Device[0].dwFlags  := RIDEV_INPUTSINK;
//  else
//    Device[0].dwFlags := RIDEV_CAPTUREMOUSE;

  // ???? RawInputDevice
  if not (RegisterRawInputDevices(@Device, 1, SizeOf(RAWINPUTDEVICE))) then
    raise Exception.Create('RegisterRawInputDevices error!')
  else
    FRegistered := True;
end;

procedure TRawKeyboardHook.SetEnabled(const Value: Boolean);
begin
  if FEnabled = Value then
    Exit;
  FEnabled := Value;
  if FEnabled then
    begin
    RegisterRawInput;
    KeyBoardHook := SetWindowsHookEx( WH_KEYBOARD, @KeyboardHookProc, HInstance, GetCurrentThreadId );
    end
  else
    begin
    if KeyBoardHook <> 0 then
      begin
      UnHookWindowsHookEx( KeyBoardHook );
      KeyBoardHook := 0;
      end;
    end;
end;

procedure TRawKeyboardHook.WinProc(var Message: TMessage);
const
  TimeOut = 10000;
var
  Ri: tagRAWINPUT;
  Size: Cardinal;
  Time : DWORD;
  msg : tagMSG;
  i, j : Integer;
  fHandled : Boolean;
begin
  if FEnabled then
    begin
    if (Message.Msg = WM_INPUT) then
      begin
      Ri.header.dwSize := SizeOf(RAWINPUTHEADER);
      Size := SizeOf(RAWINPUTHEADER);
      GetRawInputData(HRAWINPUT(Message.LParam), RID_INPUT, nil, Size, SizeOf(RAWINPUTHEADER));

      if GetRawInputData(HRAWINPUT(Message.LParam), RID_INPUT, @Ri, Size, SizeOf(RAWINPUTHEADER)) = Size then
        begin
        if (Ri.header.dwType = RIM_TYPEKEYBOARD) then
          begin
          fHandled := false;
          if Assigned(FOnRawKey) then
            fHandled := FOnRawKey(Self, RI);

          if Ri.keyboard.Message = WM_KEYDOWN then
            begin
            if Assigned(FOnRawKeyDown) then
              fHandled := FOnRawKeyDown(Self, Ri.keyboard.VKey, Ri.header.hDevice );
            end
          else if Ri.keyboard.Message = WM_KEYUP then
            begin
            if Assigned(FOnRawKeyUp) then
              fHandled := FOnRawKeyUp(Self, Ri.keyboard.VKey, Ri.header.hDevice );
            end;

          SetLength( fItems, Length( fItems )+1 );
          fItems[ High( fItems ) ].VK := ri.keyboard.VKey;
          fItems[ High( fItems ) ].Handled := fHandled;
          end;
        end;
      end
    else if (Message.Msg = WM_HOOK) then
      begin
      fItemFound := false;
      Time := GetTickCount;      
      if ( Length( fItems ) > 0 ) then
        begin
        for i := 0 to High( fItems ) do
          begin
          if ( fItems[ i ].VK = Message.WParam ) then
            begin
            if fItems[ i ].Handled then
              Message.Result := 1;
            fItemFound := True;

            for j := i to High( fItems )-1 do
              fItems[ j ] := fItems[ j+1 ];
            SetLength( fItems, Length( fItems )-1 );

            Break;
            end;
          end;
        end
      else
        begin
        while (NOT fItemFound) do
          begin
          while (NOT PeekMessage(msg, WndHandle, WM_INPUT, WM_INPUT, PM_REMOVE) ) do
            begin
            // If current time is less than start, the time rolled over to 0
            if ( ( GetTickCount - Time ) > TimeOut ) then
              begin
              // Ignore the Hook message, if it exceeded the limit
//              swprintf_s (text, 128, L"Hook TIMED OUT: %X (%d)\n", virtualKeyCode, keyPressed);
//              OutputDebugString( 'Hook TimeOut' );
              Exit;
              end;
            end;
          end;
        end;
      end;
    end
  else if Message.Msg = WM_ENDSESSION then
    Application.Terminate
  else
    inherited;
end;

procedure GetRawInputAPIs;
begin
  if Win32Platform = VER_PLATFORM_WIN32_NT then
  begin
    User32DllHandle := GetModuleHandle('User32.DLL');
    if User32DllHandle = 0 then
    begin
      User32DllHandle := LoadLibrary('User32.DLL');
      User32NeedFree := User32DllHandle <> 0;
    end;

    if User32DllHandle <> 0 then
    begin
      @GetRawInputDeviceInfo        := GetProcAddress(User32DllHandle, 'GetRawInputDeviceInfoA');
      @GetRawInputBuffer            := GetProcAddress(User32DllHandle, 'GetRawInputBuffer');
      @GetRawInputData              := GetProcAddress(User32DllHandle, 'GetRawInputData');
      @GetRawInputDeviceList        := GetProcAddress(User32DllHandle, 'GetRawInputDeviceList');
      @RegisterRawInputDevices      := GetProcAddress(User32DllHandle, 'RegisterRawInputDevices');
      @GetRegisteredRawInputDevices := GetProcAddress(User32DllHandle, 'GetRegisteredRawInputDevices');
    end;
  end;
  WndHandle := 0;
end;

procedure FreeRawInputAPIs;
begin
  if User32NeedFree and (User32DllHandle <> 0) then
  begin
    FreeLibrary(User32DllHandle);
    User32DllHandle := 0;
  end;

  if KeyBoardHook <> 0 then
    begin
    UnHookWindowsHookEx( KeyBoardHook );
    KeyBoardHook := 0;
    end;
end;

procedure TRawKeyboardHook.UpdateKeyBoardsInfo;
var
  C, Sl: Cardinal;
  KBName: array[0..1023] of AnsiChar;
  I: Integer;
//  DevInfo: RID_DEVICE_INFO;
begin
  FKeyBoardCount := 0;
  FKeyBoardNames.Clear;
  Sl := SizeOf(KBName);
  if GetRawInputDeviceList(nil, C, SizeOf(RAWINPUTDEVICELIST)) = 0 then
  begin
    if C > 0 then
    begin
      SetLength(FDevices, C);
      if GetRawInputDeviceList(@FDevices[0], C, SizeOf(RAWINPUTDEVICELIST)) <> $FFFFFFFF then
      begin
        for I := 0 to C - 1 do
        begin
          if FDevices[I].dwType = RIM_TYPEKEYBOARD then
          begin
//            DevInfo.cbSize := SizeOf(RID_DEVICE_INFO);
//            C := DevInfo.cbSize;
//            GetRawInputDeviceInfo(FDevices[I].hDevice, RIDI_DEVICEINFO, @DevInfo, C);

            Inc(FKeyBoardCount);
            GetRawInputDeviceInfo(FDevices[I].hDevice, RIDI_DEVICENAME, @KBName, Sl);
            FKeyBoardNames.AddObject({$IFDEF UNICODE}String{$ENDIF}(KBName), TObject(FDevices[I].hDevice));
          end;
        end;
      end;
    end;
  end;
end;

function TRawKeyboardHook.GetKeyBoardName(Index: Integer): string;
begin
  if (Index >= 0) and (Index < FKeyBoardNames.Count) then
    Result := FKeyBoardNames[Index];
end;

function TRawKeyboardHook.KeyBoardNameFromHandle(KeyHandle: THandle): string;
var
  I: Integer;
begin
  I := FKeyBoardNames.IndexOfObject(TObject(KeyHandle));
  if I >= 0 then
    Result := FKeyBoardNames[I]
  else
    Result := '';
end;

function KeyboardHookProc(Code: Integer; WordParam: Word; LongParam: LongInt) : LongInt;
begin
  result := 0;
//  case WordParam of
//    vk_Space:
//      begin
//
//      end;
//  end;

  if SendMessage( WndHandle, WM_HOOK, WordParam, LongParam ) <> 0 then
    Result := 1; // To prevent Windows from passing the keystrokes to the target window, the Result value must be a nonzero value.
end;

initialization
  GetRawInputAPIs;
  RawKeyboardHook := TRawKeyboardHook.Create( nil );

finalization
  RawKeyboardHook.free;
  FreeRawInputAPIs;

end.