{
  TetzkatLipHoka 2015-2019

  uTLH: SysUtils
  Last updated: 04/04/2019
}

{
Delay                               - Delay (Empty Repeat/Sleep)
DelayTick                           - Delay (ProcessMessages/Sleep)
DelayAPI                            - Delay (PeekMessage)
DelayEvent                          - Delay (Event based)

IsCtrlDown                          - Returns true if CTRL is pressed
IsAltDown                           - Returns true if Alt is pressed
IsShiftDown                         - Returns true if Shift is pressed
ShiftStateToKeys                    - Reverse TShiftState to Keys
IsApplicationFullScreen             - Returns true if there is a fullscreen Application on the given Monitor
IsCalledInMainThread                - Returns true if executing thread is mainthread
IsUnicodeVersion                    - Returns true if Charsize is <> 1 (ANSI Char is 1Byte)
IsWindows64                         - Returns true if Windows is 64bit
Is64bitProcessHandle                - Returns true if Software for given ProcessHandle is 64bit
Is64bitProcessPID                   - Returns true if Software for given ProcessID is 64bit
Is64BitModule                       - Returns true if given DLL is 64bit
KillProcessPID                      - Returns true if given ProcessID was killed
KillProcessHandle                   - Returns true if given ProcessHandle was killed
SetProcessPriorityPID               - Returns true if priority for given ProcessID was changed
SetProcessPriority                  - Returns true if priority for given ProcessHandle was changed
GetProcessHandleFromID              - Returns ProcessHandle for given ProcessID

ResumeProcess                       - Returns true if process with given pid was suspended
SuspendProcess                      - Returns true if process with given pid was resumed

CommittedStackSize                  - Returns current StackUsage in Bytes ( Win x68 & x64 )
GetProcessMemory                    - Returns MemoryInformations about own Process
GetWorkingSetSize                   - Returns current MemoryUsage in Bytes
GetPrivateUsage                     - Returns current (allocated) MemoryUsage in Bytes
GetPeakPageFileUsage                - Returns current (reserved) MemoryUsage in Bytes
GetMemoryStatus                     - Returns GlobalMemoryStatus (Avail Ram/Pagefile)
HookResourceString                  - Overwrite Delphi's Resource-Strings (Language-Dependings)
			                                See Const.pas for const-names
			                                Ex: HookResourceString( @SCannotOpenClipboard, 'Nije moguce otvoriti Clipboard' );
GetResourceString                   - Get Resource-String
WindowHandleBelongsToUs             - Returns true if given WindowHandle belongs to our process
MethodIsEqual                       - Returns true if 2 methods are equal (Point to same target)
PixelToMonitorID                    - Returns Screen.Monitor[] ID for given Pixel
SetTimePeriod                       - Configures System-Timer-Resolution to Min/Max Values (TimeBeginPeriod/TimeEndPeriod)
ReturnEnumWindows                   - Returns Windows as ENumWindowsList
ReturnEnumDesktopWindows            - Returns desktop windows as ENumWindowsList
ReturnEnumThreadWindows             - Returns thread windows as ENumWindowsList

ListProcesses                       - Returns process list
IsProcessRunning                    - Returns true if process with given ProcessHandle is present
IsProcessRunningPID                 - Returns true if process with given ProcessID is present

ListModules                         - Returns module list for given pid
IsModuleLoaded                      - Returns true if module is loaded for given pid
ListThreads                         - Returns thread list for given pid

GetProcessCPURunTime                - Returns CPU runtime for own process
GetWin32_VideoControllerInfo        - Returns VideoControllers installed
GetOSVersionInfoEx                  - Return OS-VersionInfo
GetWinVersion                       - Return Windows-Version
GetWinServicePack                   - Return Windows-ServicePack
GetWinBuild                         - Return Windows-Build
IsWindowsAdministrator              - Returns true if executing user has Adminrights
IsApplicationAdmin                  - Returns true if Application is running with Adminrights
GetComputerName                     - Returns ComputerName

RegisterLibrary                     - Calls DllRegisterServer/DllUnregisterServer in DLLs (Similiar to regsvr32 call)
IsClassIDRegistered                 - Checks if ClassID is registered (DLL/OCX Registrations)
IsClassNameRegistered               - Checks if ClassName is registered, can return ClassID (DLL/OCX Registrations)
IsFileRegistered                    - Checks if File is registered, can return ClassID (DLL/OCX Registrations)

LCIDtoCodePage                      - Returns CodePage for given LCID
IsNativeCodePage                    - Returns true if current CodePage is the Default AnsiCodePage
GetLocaleNameFromReg                - Returns LocaleName for current user from Registry

ExecutePEFromMemory                 - Execute 32Bit PE-Exe-File from Memory
                                      NOTE: has ability to Patch Code via function before Thread is resumed

NameThread                          - Assign a Name to a Thread (Debugging Only)

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Registry~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
SetPrivilege                        - Set Windows-Privileges - (internally)Required for Registry
RegistryLoadKeyFromFile             - Load registry-key from File (Hive, Binary)
RegistrySaveKeyToFile               - Write registry-key to File (Hive, Binary)
RegistryLoadKeyFromRegFile          - Load registry-key from File
RegistrySaveKeyToRegFile            - Write registry-key to File
RegistryDeleteKey                   - Delete registry-key
RegistryReadMultiSZ                 - Read MultiSZ(StringList)-Type
RegistryWriteMultiSZ                - Write MultiSZ(StringList)-Type

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Environment~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
GetEnvironmentPath                  - Read Global or User EnvironmentPath
SetEnvironmentPath                  - Write Global or User EnvironmentPath
AddEnvironmentPath                  - Add Path to Global or User EnvironmentPath
DelEnvironmentPath                  - Remove Path from Global or User EnvironmentPath
Send_SETTINGCHANGE_Broadcast        - Sends WM_SETTINGCHANGE-Broadcast

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Dongle~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ListUSBDeviceSerials                - List DeviceInfos for currently available USB-Devices
IsUSBSerialPresent                  - Check if given Serial is a currently connected USB-Device

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ShellExecute~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ShellExecuteAndWait                 - Operation:
                                        edit       Launches an editor and opens the document for editing.
                                        explore    Explores the folder specified by lpFile.
                                        find       Initiates a search starting from the specified directory.
                                        open       Opens the file, folder specified by the lpFile parameter.
                                        print      Prints the document file specified by lpFile.
                                        properties Displays the file or folder's properties.

                                      FileName: Specifies the name of the file or object on which ShellExecuteEx will perform the action specified by the lpVerb parameter.
                                      Parameter: String that contains the application parameters. The parameters must be separated by spaces.
                                      Directory: specifies the name of the working directory. If this member is not specified, the current directory is used as the working directory.
                                      Show: Flags that specify how an application is to be shown when it is opened. It can be one of the SW_ values
                                      bWait: If true, the function waits for the process to terminate

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Delphi 10 Seattle~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CurrencyString
ShortDateFormat
LongDateFormat
ShortTimeFormat
LongTimeFormat
DecimalSeparator
DateSeparator
ThousandSeparator
}

{$IFNDEF TLH_OMIT_SECTIONS}
unit uTLH.SysUtils;

{$I uTLH.inc}
(*
{$DEFINE SetTimePeriod} // Auto Synchronize TimePeriods on Initialize
*)

interface

uses
  Windows,
  PsAPI{MemoryInformation},
  TlHelp32{ListProcess},
  Classes{RegistryRead/WriteMultiSZ};  
{$ENDIF TLH_OMIT_SECTIONS}

{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CAST OFF}
{$WARN GARBAGE OFF}
{$WARN SUSPICIOUS_TYPECAST OFF}
{$IF CompilerVersion >= 22}
  {$LEGACYIFEND ON}
{$IFEND}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
{$IF NOT Defined( TLH_IMPLEMENTATIONSECTION ) AND NOT Defined( TLH_INITIALIZATIONSECTION ) AND NOT Defined( TLH_FINALIZATIONSECTION )}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
type
  {$EXTERNALSYM _PROCESS_MEMORY_COUNTERS_EX}
  _PROCESS_MEMORY_COUNTERS_EX = record
    cb                          : Cardinal;
    PageFaultCount              : Cardinal;
    PeakWorkingSetSize          : {$IFDEF WIN64}UINT64{$ELSE}UINT{$ENDIF};
    WorkingSetSize              : {$IFDEF WIN64}UINT64{$ELSE}UINT{$ENDIF};
    QuotaPeakPagedPoolUsage     : {$IFDEF WIN64}UINT64{$ELSE}UINT{$ENDIF};
    QuotaPagedPoolUsage         : {$IFDEF WIN64}UINT64{$ELSE}UINT{$ENDIF};
    QuotaPeakNonPagedPoolUsage  : {$IFDEF WIN64}UINT64{$ELSE}UINT{$ENDIF};
    QuotaNonPagedPoolUsage      : {$IFDEF WIN64}UINT64{$ELSE}UINT{$ENDIF};
    PagefileUsage               : {$IFDEF WIN64}UINT64{$ELSE}UINT{$ENDIF};
    PeakPagefileUsage           : {$IFDEF WIN64}UINT64{$ELSE}UINT{$ENDIF};
    PrivateUsage                : {$IFDEF WIN64}UINT64{$ELSE}UINT{$ENDIF};
  end;
  {$EXTERNALSYM PROCESS_MEMORY_COUNTERS_EX}
  PROCESS_MEMORY_COUNTERS_EX = _PROCESS_MEMORY_COUNTERS_EX;
  {$EXTERNALSYM PPROCESS_MEMORY_COUNTERS_EX}
  PPROCESS_MEMORY_COUNTERS_EX = ^PROCESS_MEMORY_COUNTERS_EX;
  TProcessMemoryCountersEx = _PROCESS_MEMORY_COUNTERS_EX;
  PProcessMemoryCountersEx = PPROCESS_MEMORY_COUNTERS_EX;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure Delay( dwMilliseconds: Cardinal; vSleep : Boolean = True; vProcessMessages : Boolean = True );
procedure DelayTick( dwMilliseconds: Cardinal; vSleep : Boolean = True; vProcessMessages : Boolean = True );
procedure DelayAPI( dwMilliseconds: Cardinal );
procedure DelayEvent( dwMilliseconds: Cardinal; vSleep : Boolean = True; vProcessMessages : Boolean = True );

function IsCtrlDown : Boolean;
function IsShiftDown : Boolean;
function IsAltDown : Boolean;
function ShiftStateToKeys( AShiftState: TShiftState ): Word;

function IsApplicationFullScreen( Monitor : Byte ): Boolean;
function IsCalledInMainThread: Boolean;
function IsUnicodeVersion: boolean;
function IsWindows64: Boolean;

function Is64bitProcessHandle( Handle: THandle ) : boolean;
function Is64bitProcessPID( PID: Cardinal ) : boolean;
function Is64bitModule( fileName: PChar ) : boolean;
function KillProcessPID( PID: Cardinal ): boolean;
function KillProcessHandle( Handle: THandle ): boolean;
function SetProcessPriorityPID( PID : Cardinal; Priority: Integer = NORMAL_PRIORITY_CLASS ): Boolean;
function SetProcessPriority( Handle: THandle; Priority: Integer = NORMAL_PRIORITY_CLASS ): Boolean;

function GetProcessHandleFromID( ID: Cardinal ): THandle;

{$IF NOT Declared( OpenThread )}
function OpenThread(dwDesiredAccess: DWord; bInheritHandle: Boolean; dwThreadId: DWord): THandle; stdcall; external kernel32 name 'OpenThread';
{$IFEND}

Function ResumeProcess( ProcessID: Cardinal ): Boolean;
function SuspendProcess( ProcessID : Cardinal ) : Boolean;

function CommittedStackSize: Cardinal;
function GetProcessMemory( var PMC : TProcessMemoryCountersEx; AppHandle : Integer = -1 ): integer;
function GetWorkingSetSize: {$IFDEF WIN64}UINT64{$ELSE}UINT{$ENDIF};
function GetPrivateUsage: {$IFDEF WIN64}UINT64{$ELSE}UINT{$ENDIF};
function GetPeakPageFileUsage: {$IFDEF WIN64}UINT64{$ELSE}UINT{$ENDIF};
function GetProcessCPURunTime( var value : Cardinal ): integer;
function GetMemoryStatus : TMemoryStatus;

procedure HookResourceString( ResStringRec: pResStringRec; NewStr: PChar );
function GetResourceString( ResStringRec: pResStringRec ) : String;
function WindowHandleBelongsToUs( Handle : THandle ): boolean;
function PixelToMonitorID( Pixel : TPoint ): Byte;
function MethodIsEqual( const MethodPointer1, MethodPointer2 ): Boolean;

procedure SetTimePeriod;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// ENumWindows
type
  ENumWindowsResult = record
    Handle       : HWND;
    ClassName,
    Title        : String;
    Pid          : Cardinal;
    Rect         : TRect;
    Width,
    Height       : Cardinal;
    Visible,
    IsIconic     : Boolean;
    end;
  ENumWindowsArray = Array of ENumWindowsResult;
  pENumWindowsArray = ^ENumWindowsArray;

function EnumWindowsProc( hHwnd: HWND; Entrys : pENumWindowsArray ): bool; stdcall;
function ReturnEnumWindows : ENumWindowsArray;
function ReturnEnumDesktopWindows( handle: THandle ) : ENumWindowsArray;
function ReturnEnumThreadWindows( ThreadID: Cardinal ) : ENumWindowsArray;

// ProcessList
type
  tProcessItemRecord = Record
    PID       : Cardinal;
    ParentPID : Cardinal;
    Threads   : Integer;
    Priority  : Integer;
    Size      : Cardinal;
    Usage     : Cardinal;
    ExePath   : String;
    Is64Bit   : boolean;
  end;
  tProcessRecord = Record
    Items : Array of tProcessItemRecord;
    Count: Cardinal;
  end;
procedure ListProcesses( var fProcesses : tProcessRecord  );

{$IF NOT Declared( GetProcessId )}
function GetProcessId( Handle : THandle ) : Cardinal; stdcall; external kernel32 name 'GetProcessId';
{$IFEND}

function IsProcessRunning( Process : THandle ) : Boolean;
function IsProcessRunningPID( ProcessID : Cardinal ) : Boolean;

// ListModules
type
  tModuleRecord = Array of TModuleEntry32;
function ListModules( PID: Cardinal ): tModuleRecord;
function IsModuleLoaded( PID : Cardinal; Name : string ): boolean;

// ListThreads
type
  tThreadRecord = Array of TThreadEntry32;
function ListThreads( PID: Cardinal ) : tThreadRecord;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
type
  Win32VideoController = record
    Name : String;
    PNPDeviceID : String;
  end;
  Win32VideoControllers = Array of Win32VideoController;
function GetWin32_VideoControllerInfo: Win32VideoControllers;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
type
  //http://msdn2.microsoft.com/en-us/library/ms724833.aspx
  TOSVersionInfoEx = packed record
    dwOSVersionInfoSize : Cardinal;
    dwMajorVersion      : Cardinal;
    dwMinorVersion      : Cardinal;
    dwBuildNumber       : Cardinal;
    dwPlatformId        : Cardinal;
    szCSDVersion        : array[0..127] of AnsiChar;
    wServicePackMajor   : WORD;
    wServicePackMinor   : WORD;
    wSuiteMask          : WORD;
    wProductType        : BYTE;
    wReserved           : BYTE;
  end;
function GetOSVersionInfoEx : TOSVersionInfoEx;
function GetWinVersion:string;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function GetWinServicePack:string;
function GetWinBuild : Cardinal;
function IsWindowsAdministrator: Boolean;
function IsApplicationAdmin : Boolean;
function GetComputerName: String;

function RegisterLibrary( FileName : string; vRegister : boolean = True ) : Integer;
function IsClassIDRegistered( ClassID: String; var FileName : string ): Boolean; overload;
function IsClassIDRegistered( ClassID: String ): Boolean; overload;
function IsClassNameRegistered( ClassName: String; var ClassID : string ): Boolean; overload;
function IsClassNameRegistered( ClassName: String ): Boolean; overload;
function IsFileRegistered( var FileName : String ) : Boolean; overload;
function IsFileRegistered( var FileName : String; var ClassID : String ) : Boolean; overload;

function LCIDtoCodePage( LCID : Cardinal ) : Word;
function IsNativeCodePage : boolean;
function GetLocaleNameFromReg: string;
function ShellExecuteAndWait( FileName, Parameter, Directory: string; Operation : string = 'open'; Show: Word = SW_HIDE; bWait: Boolean = True ): Longint;

type
  TExecuteBeforeResume = function( ThreadHandle : THandle ) : boolean;
function ExecutePEFromMemory( pFile: Pointer; ExeFileName : string = ''; Params: string = ''; ExecuteBeforeResume : TExecuteBeforeResume = nil; vPI : pProcessInformation = nil ) : boolean;

// NameThread
{$IF NOT Declared( TThreadID )}
type
  TThreadID = LongWord;
{$IFEND}
{$IF NOT Declared( IsDebuggerPresent )}
function IsDebuggerPresent: BOOL; stdcall; external kernel32 name 'IsDebuggerPresent';
{$IFEND}
procedure NameThread( AThreadName: string; AThreadID: TThreadID = TThreadID( -1 ) );

// TRegistry
const
  SE_ASSIGNPRIMARYTOKEN_NAME = 'SeAssignPrimaryTokenPrivilege'; // Required to assign the primary token of a process.
  SE_AUDIT_NAME = 'SeAuditPrivilege'; // Required to generate audit-log entries. Give this privilege to secure servers.
  SE_BACKUP_NAME = 'SeBackupPrivilege';
  SE_CHANGE_NOTIFY_NAME = 'SeChangeNotifyPrivilege'; // Required to receive notifications of changes to files or directories. This privilege also causes the system to skip all traversal access checks. It is enabled by default for all users.
  SE_CREATE_GLOBAL_NAME = 'SeCreateGlobalPrivilege'; // Required to create named file mapping objects in the global namespace during Terminal Services sessions. This privilege is enabled by default for administrators, services, and the local system account.
  SE_CREATE_PAGEFILE_NAME = 'SeCreatePagefilePrivilege'; // Required to create a paging file.
  SE_CREATE_PERMANENT_NAME = 'SeCreatePermanentPrivilege'; // Required to create a permanent object.
  SE_CREATE_SYMBOLIC_LINK_NAME = 'SeCreateSymbolicLinkPrivilege'; // Required to create a symbolic link.
  SE_CREATE_TOKEN_NAME = 'SeCreateTokenPrivilege'; // Required to create a primary token.
  SE_DEBUG_NAME = 'SeDebugPrivilege'; // Required to debug and adjust the memory of a process owned by another account.
  SE_ENABLE_DELEGATION_NAME = 'SeEnableDelegationPrivilege'; // Required to mark user and computer accounts as trusted for delegation.
  SE_IMPERSONATE_NAME = 'SeImpersonatePrivilege'; // Required to impersonate.
  SE_INC_BASE_PRIORITY_NAME = 'SeIncreaseBasePriorityPrivilege'; // Required to increase the base priority of a process.
  SE_INCREASE_QUOTA_NAME = 'SeIncreaseQuotaPrivilege'; // Required to increase the quota assigned to a process.
  SE_INC_WORKING_SET_NAME = 'SeIncreaseWorkingSetPrivilege'; // Required to allocate more memory for applications that run in the context of users.
  SE_LOAD_DRIVER_NAME = 'SeLoadDriverPrivilege'; // Required to load or unload a device driver.
  SE_LOCK_MEMORY_NAME = 'SeLockMemoryPrivilege'; // Required to lock physical pages in memory.
  SE_MACHINE_ACCOUNT_NAME = 'SeMachineAccountPrivilege'; // Required to create a computer account.
  SE_MANAGE_VOLUME_NAME = 'SeManageVolumePrivilege'; // Required to enable volume management privileges.
  SE_PROF_SINGLE_PROCESS_NAME = 'SeProfileSingleProcessPrivilege'; // Required to gather profiling information for a single process.
  SE_RELABEL_NAME = 'SeRelabelPrivilege'; // Required to modify the mandatory integrity level of an object.
  SE_REMOTE_SHUTDOWN_NAME = 'SeRemoteShutdownPrivilege'; // Required to shut down a system using a network request.
  SE_RESTORE_NAME = 'SeRestorePrivilege'; {Required to perform restore operations. This privilege causes the system to grant all write access control to any file, regardless of the ACL specified for the file. Any access request other than write is still evaluated with the ACL. Additionally, this privilege enables you to set any valid user or group SID as the owner of a file. This privilege is required by the RegLoadKey function. The following access rights are granted if this privilege is held:
                                            WRITE_DAC
                                            WRITE_OWNER
                                            ACCESS_SYSTEM_SECURITY
                                            FILE_GENERIC_WRITE
                                            FILE_ADD_FILE
                                            FILE_ADD_SUBDIRECTORY
                                            DELETE}
  SE_SECURITY_NAME = 'SeSecurityPrivilege'; // Required to perform a number of security-related functions, such as controlling and viewing audit messages. This privilege identifies its holder as a security operator.
  SE_SHUTDOWN_NAME = 'SeShutdownPrivilege'; // Required to shut down a local system.
  SE_SYNC_AGENT_NAME = 'SeSyncAgentPrivilege'; // Required for a domain controller to use the Lightweight Directory Access Protocol directory synchronization services. This privilege enables the holder to read all objects and properties in the directory, regardless of the protection on the objects and properties. By default, it is assigned to the Administrator and LocalSystem accounts on domain controllers.
  SE_SYSTEM_ENVIRONMENT_NAME = 'SeSystemEnvironmentPrivilege'; // Required to modify the nonvolatile RAM of systems that use this type of memory to store configuration information.
  SE_SYSTEM_PROFILE_NAME = 'SeSystemProfilePrivilege'; // Required to gather profiling information for the entire system.
  SE_SYSTEMTIME_NAME = 'SeSystemtimePrivilege'; // Required to modify the system time.
  SE_TAKE_OWNERSHIP_NAME = 'SeTakeOwnershipPrivilege'; // Required to take ownership of an object without being granted discretionary access. This privilege allows the owner value to be set only to those values that the holder may legitimately assign as the owner of an object.
  SE_TCB_NAME = 'SeTcbPrivilege'; // This privilege identifies its holder as part of the trusted computer base. Some trusted protected subsystems are granted this privilege.
  SE_TIME_ZONE_NAME = 'SeTimeZonePrivilege'; // Required to adjust the time zone associated with the computer's internal clock.
  SE_TRUSTED_CREDMAN_ACCESS_NAME = 'SeTrustedCredManAccessPrivilege'; // Required to access Credential Manager as a trusted caller.
  SE_UNDOCK_NAME = 'SeUndockPrivilege'; // Required to undock a laptop.
  SE_UNSOLICITED_INPUT_NAME = 'SeUnsolicitedInputPrivilege'; // Required to read unsolicited input from a terminal device.

function SetPrivilege( Privilege: PChar; EnablePrivilege: Boolean; out PreviousState: Boolean ): Cardinal;
function RegistryLoadKeyFromFile( RootKey : HKEY; Key, FileName : string ): Boolean;
function RegistrySaveKeyToFile( RootKey : HKEY; Key, FileName : string ): Boolean;
function RegistryDeleteKey( RootKey : HKEY; Key : string ): Boolean;
function RegistryLoadKeyFromRegFile( FileName : string; WaitForFinish : boolean = True ): Boolean;
function RegistrySaveKeyToRegFile( RootKey, Key, FileName : string; WaitForFinish : boolean = True ): Boolean; overload;
function RegistrySaveKeyToRegFile( RootKey : HKEY; Key, FileName : string; WaitForFinish : boolean = True ): Boolean; overload;
function RegistryReadMultiSZ( const CurrentKey: HKey; const Subkey, ValueName: string; Strings: TStrings ) : boolean;
function RegistryWriteMultiSZ( const CurrentKey: HKey; const Subkey, ValueName: string; Strings: TStrings ) : boolean;

// Environment
function Send_SETTINGCHANGE_Broadcast( sType : string = 'Environment' ) : boolean;
function GetEnvironmentPath( UserEnvironment: Boolean ): string;
function SetEnvironmentPath( UserEnvironment: Boolean; NewPaths : string ): boolean;
function AddEnvironmentPath( UserEnvironment: Boolean; NewPath : string ): boolean;
function DelEnvironmentPath( UserEnvironment: Boolean; RemovePath : string ): boolean;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
type
  tUSB_DeviceInfo = record
    Name   : String;
    VID    : String;
    PID    : String;
    Serial : String;
  end;
  tUSB_DeviceInfos = Array of tUSB_DeviceInfo;
procedure ListUSBDeviceSerials( var USB : tUSB_DeviceInfos );
function IsUSBSerialPresent( Serial : String ): boolean;

// Delphi 10 Seattle Deprecates
{$IF CompilerVersion >= 30}
function CurrencyString : String;
function LongDateFormat : String;
function ShortDateFormat : String;
function ShortTimeFormat : String;
function LongTimeFormat : String;
function DecimalSeparator : Char;
function DateSeparator : Char;
function ThousandSeparator : Char;

procedure SetCurrencyString( value : String );
procedure SetLongDateFormat( value : String );
procedure SetShortDateFormat( value : String );
procedure SetShortTimeFormat( value : String );
procedure SetLongTimeFormat( value : String );
procedure SetDecimalSeparator( value : Char );
procedure SetDateSeparator( value : Char );
procedure SetThousandSeparator( value : Char );
{$IFEND}
{$IFEND TLH_IMPLEMENTATIONSECTION}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
{$IFNDEF TLH_OMIT_SECTIONS}
implementation

uses
  Forms, Messages, // DelayEvent
  SysUtils, ShellApi, Registry, // Registry
  StrUtils, // Is...Registered
  ComObj, ActiveX, Variants,{GetWin32_VideoControllerInfo}
  MMSystem{SetTimePeriod},
  WinSvc{IsApplicationAdmin}

  {$IF Defined( madExcept )} // NameThreads
  ,madExcept
  {$ELSEIF Defined( EurekaLog )}
  ,EThreadsManager
  {$IFEND}
  {$IFDEF DDDebug},DDDAccess{$ENDIF}
  ;
{$ENDIF TLH_OMIT_SECTIONS}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
{$IF NOT Defined( TLH_INTERFACESECTION ) AND NOT Defined( TLH_INITIALIZATIONSECTION ) AND NOT Defined( TLH_FINALIZATIONSECTION )}
procedure Delay( dwMilliseconds: Cardinal; vSleep : Boolean = True; vProcessMessages : Boolean = True );
var
  Start, Now, Freq : Int64;
begin
  QueryPerformanceFrequency( Freq );
  QueryPerformanceCounter( Start );
  repeat
    if ( GetCurrentThreadId = MainThreadID ) AND vProcessMessages then
      Application.ProcessMessages;
    if vSleep then
      Sleep( 1 );
    QueryPerformanceCounter( Now );
  until ( ( ( Now-Start ) / Freq * 1000 ) >= dwMilliseconds );
end;

procedure DelayTick( dwMilliseconds: Cardinal; vSleep : Boolean = True; vProcessMessages : Boolean = True );
var
  TickCount,
  tC         : Cardinal;
  res        : boolean;
begin
  TickCount := GetTickCount;
  repeat
    if ( GetCurrentThreadId = MainThreadID ) AND vProcessMessages then
      Application.ProcessMessages;
    if vSleep then
      Sleep( 1 );

    tC := GetTickCount;
    if ( TickCount > ( High( Cardinal )-dwMilliseconds ) ) then
      res := ( tC >= ( ( dwMilliseconds - ( High( Cardinal )-TickCount ) ) ) ) AND ( tC < High( Word ) )
    else
      res := ( tC >= TickCount+dwMilliseconds );
  until res;
end;

procedure DelayAPI( dwMilliseconds: Cardinal );
var
  TickCount,
  tC         : Cardinal;
  res        : boolean;
  Msg        : TMsg;
begin
  TickCount := GetTickCount;
  repeat
    if PeekMessage( Msg, 0, 0, 0, PM_REMOVE ) then
      begin
      if Msg.message = WM_QUIT then
        begin
        PostQuitMessage( Msg.wParam );
        Break;
        end;
      TranslateMessage( Msg );
      DispatchMessage( Msg );
      end;

    tC := GetTickCount;
    if ( TickCount > ( High( Cardinal )-dwMilliseconds ) ) then
      res := ( tC >= ( ( dwMilliseconds - ( High( Cardinal )-TickCount ) ) ) ) AND ( tC < High( Word ) )
    else
      res := ( tC >= TickCount+dwMilliseconds );
  until res;
end;

procedure DelayEvent( dwMilliseconds: Cardinal; vSleep : Boolean = True; vProcessMessages : Boolean = True );
var
  TickCount : Cardinal;
  tC        : Cardinal;
  dif       : Cardinal;
  Event     : THandle;
begin
  Event := CreateEvent( nil, False, False, nil );
  TickCount := GetTickCount;
  try
    while ( dwMilliseconds > 0 ) and ( MsgWaitForMultipleObjects( 1, Event, False, dwMilliseconds, QS_ALLINPUT ) <> WAIT_TIMEOUT ) do
      begin
      if ( GetCurrentThreadId = MainThreadID ) AND vProcessMessages then
        Application.ProcessMessages;
      if vSleep then
        Sleep( 1 );

      tC := GetTickCount;
      if ( TickCount > High( Word ) ) AND ( tC < High( Word ) ) then
        dif := tC + ( High( Cardinal ) - TickCount )
      else
        dif := tC-TickCount;

      if ( dif > dwMilliseconds ) then
        dwMilliseconds := 0
      else
        Dec( dwMilliseconds, dif );
      end;
  finally
    CloseHandle( Event );
  end;
end;

function IsCtrlDown : Boolean;
var
  State : TKeyboardState;
begin
  GetKeyboardState( State );
  Result := ( ( State[vk_Control] And 128 ) <> 0 );
end;

function IsShiftDown : Boolean;
var
  State : TKeyboardState;
begin
  GetKeyboardState( State );
  Result := ( ( State[vk_Shift] and 128 ) <> 0 );
end;

function IsAltDown : Boolean;
var
  State : TKeyboardState;
begin
  GetKeyboardState( State );
  Result := ( ( State[vk_Menu] and 128 ) <> 0 );
end;

function ShiftStateToKeys( AShiftState: TShiftState ): Word;
begin
  // Reverse function for Forms.KeysToShiftState
  // However it doesn't revert MK_XBUTTON1/MK_XBUTTON2
  // but Scintilla as of version 3.25 doesn't use it.
  Result := 0;
  if ssShift in AShiftState then
    Result := Result or MK_SHIFT;
  if ssCtrl in AShiftState then
    Result := Result or MK_CONTROL;
  if ssLeft in AShiftState then
    Result := Result or MK_LBUTTON;
  if ssRight in AShiftState then
    Result := Result or MK_RBUTTON;
  if ssMiddle in AShiftState then
    Result := Result or MK_MBUTTON;
end;

function IsApplicationFullScreen( Monitor : Byte ): Boolean;
var
  Process    : ENumWindowsArray;
  ScreenRect : TRect;
  i          : integer;
begin
  result := false;
  if ( Monitor > Screen.MonitorCount-1 ) then
    Exit;
  ScreenRect := Screen.Monitors[ Monitor ].BoundsRect;

  Process := ReturnEnumWindows;
  for i := Low( Process ) to High( Process ) do
    begin
    if Process[i].Visible AND ( NOT Process[i].IsIconic ) AND
      ( ( ScreenRect.Left = Process[i].Rect.Left ) AND
       ( ScreenRect.Right = Process[i].Rect.Right ) AND
       ( ScreenRect.Top = Process[i].Rect.Top ) AND
       ( ScreenRect.Bottom = Process[i].Rect.Bottom ) ) then
      begin
      result := true;
      Break;
      end;
    end;
end;

function IsCalledInMainThread: Boolean;
begin
  result := ( Windows.GetCurrentThreadId = System.MainThreadID );
end;

function IsUnicodeVersion: boolean;
begin
  {$IFDEF UNICODE}
  result := True;
  {$ELSE}
  result := False;
  {$ENDIF}
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
var
  // Is64bitProcess
  Done64Init     : boolean = false;
  IsWow64Process : function ( processHandle: THandle; var wow64Process: bool ) : boolean; stdcall = nil;
  Am64OS         : boolean = false;
function IsWindows64: Boolean;
const
  PROCESSOR_ARCHITECTURE_AMD64 = 9;
var
  gnsi : procedure ( var si: TSystemInfo ) stdcall;
  si   : TSystemInfo;
begin
  if not Done64Init then
    begin
    gnsi := GetProcAddress( GetModuleHandle( kernel32 ), 'GetNativeSystemInfo' );
    if @gnsi <> nil then
      begin
      ZeroMemory( @si, sizeOf( si ) );
      gnsi( si );
      Am64OS := si.wProcessorArchitecture = PROCESSOR_ARCHITECTURE_AMD64;
      if Am64OS then
        IsWow64Process := GetProcAddress( GetModuleHandle( kernel32 ), 'IsWow64Process' );
      end;
    Done64Init := True; 
    end;
  result := Am64OS;
end;
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function Is64bitProcessPID( PID: Cardinal ) : boolean;
var
  Handle : THandle;
begin
  result := false;
  if PID = GetCurrentProcessID then
    begin
    {$IFDEF Win64}
    result := True;
    {$ENDIF}
    Exit;
    end;
  Handle := OpenProcess( PROCESS_QUERY_INFORMATION, FALSE, PID );
  if ( Handle = INVALID_HANDLE_VALUE ) then
    Exit;

  Result := Is64bitProcessHandle( Handle );
  CloseHandle( Handle );
end;

function Is64bitProcessHandle( Handle: THandle ) : boolean;
var
  b1 : bool;
begin
  result := false;
  if Handle = GetCurrentProcess then
    begin
    {$IFDEF Win64}
    result := True;
    {$ENDIF}
    Exit;
    end;
  b1 := false;
  if IsWindows64 AND Assigned( IsWow64Process ) then
    begin
    if IsWow64Process( Handle, b1 ) then
      result := ( not b1 )
    end;
end;

function KillProcessHandle( Handle: THandle ): boolean;
begin
  result := TerminateProcess( Handle, 0 );
end;

function KillProcessPID( PID: Cardinal ): boolean;
var
  ProcessHandle: THandle;
begin
  result := false;
  ProcessHandle := OpenProcess( PROCESS_TERMINATE, False, PID );
  if ( ProcessHandle = INVALID_HANDLE_VALUE ) then
    Exit;
  result := TerminateProcess( ProcessHandle, 0 );
end;

function SetProcessPriorityPID( PID: Cardinal; Priority: Integer = NORMAL_PRIORITY_CLASS ): Boolean;
var
  HProc: Thandle;
begin
  result := false;
  HProc := OpenProcess( PROCESS_SET_INFORMATION, false, PID );
  if ( HProc = INVALID_HANDLE_VALUE ) then
    Exit;
  result := SetPriorityClass( HProc, priority );
  CloseHandle( HProc );
end;

function SetProcessPriority( Handle: THandle; Priority: Integer = NORMAL_PRIORITY_CLASS ): Boolean;
begin
  result := SetPriorityClass( Handle, priority );
end;

function GetProcessHandleFromID( ID: Cardinal ): THandle;
begin
  Result := OpenProcess( PROCESS_CREATE_THREAD or PROCESS_QUERY_INFORMATION or PROCESS_VM_OPERATION or PROCESS_VM_WRITE or PROCESS_VM_READ, False, ID );
end;

Function ResumeProcess( ProcessID: Cardinal ): Boolean;
const
  THREAD_ALL_ACCESS = STANDARD_RIGHTS_REQUIRED or SYNCHRONIZE or $03FF;
var
  Snapshot,
  cThr      : THandle;
  ThrHandle : THandle;
  Thread    : TThreadEntry32;
begin
  Result := False;
  cThr := GetCurrentThreadId;
  Snapshot := CreateToolhelp32Snapshot( TH32CS_SNAPTHREAD, 0 );
  if Snapshot = INVALID_HANDLE_VALUE then
    Exit;

  Thread.dwSize := SizeOf( TThreadEntry32 );
  if Thread32First(Snapshot, Thread) then
    repeat
      if NOT ( ( Thread.th32ThreadID <> cThr ) and ( Thread.th32OwnerProcessID = ProcessID ) )then
        Continue;

      ThrHandle := OpenThread( THREAD_ALL_ACCESS, false, Thread.th32ThreadID );
      if ThrHandle = 0 then
        Continue;
      ResumeThread( ThrHandle );
      CloseHandle( ThrHandle );
    until not Thread32Next( Snapshot, Thread );
  Result := CloseHandle( Snapshot );
end;

function SuspendProcess( ProcessID : Cardinal ) : Boolean;
var
  hSnap : THandle;
  THR32 : THREADENTRY32;
  hOpen : THandle;
begin
  Result := FALSE;
  hSnap := CreateToolhelp32Snapshot(TH32CS_SNAPTHREAD, 0);
  if hSnap = INVALID_HANDLE_VALUE then
    Exit;

  THR32.dwSize := SizeOf(THR32);
  Thread32First( hSnap, THR32 );
  repeat
    if THR32.th32OwnerProcessID <> ProcessID then
      Continue;
    hOpen := OpenThread( $0002, FALSE, THR32.th32ThreadID );
    if hOpen = INVALID_HANDLE_VALUE then
      Continue;

    Result := TRUE;
    SuspendThread( hOpen );
    CloseHandle( hOpen );
  until Thread32Next( hSnap, THR32 ) = FALSE;
  CloseHandle( hSnap );
end;

function Is64bitModule( fileName: PChar ) : boolean; // madshi
const
  // PE header constants
  CENEWHDR = $003C;  // offset of new EXE header
  CEMAGIC  = $5A4D;  // old EXE magic id:  'MZ'
  CPEMAGIC = $4550;  // NT portable executable
  IMAGE_NT_OPTIONAL_HDR64_MAGIC = $20b;  // 64bit PE file

  function GetImageNtHeaders( module: HMODULE ) : PImageNtHeaders;
    function IsBadReadPtr2( src: pointer; count: Cardinal ) : boolean;
    var
      mbi : TMemoryBasicInformation;
    begin
      result := ( VirtualQuery( src, mbi, sizeOf( mbi ) ) <> sizeOf( mbi ) ) or ( mbi.State <> MEM_COMMIT ) or ( mbi.Protect and ( PAGE_EXECUTE_READ or PAGE_EXECUTE_READWRITE or PAGE_READONLY or PAGE_READWRITE or PAGE_WRITECOPY ) = 0 ) or ( mbi.Protect and PAGE_GUARD <> 0 ) or
                {$IF CompilerVersion < 21} {NativeUInt didn't exist or was broken before Delphi 2010.}
                ( Cardinal( src ) + count > Cardinal( mbi.BaseAddress ) + mbi.RegionSize );
                {$ELSE}
                ( NativeUInt( src ) + count > NativeUInt( mbi.BaseAddress ) + mbi.RegionSize );
                {$IFEND}
    end;
  begin
    result := nil;
    try
      if ( not IsBadReadPtr2( pointer( module ), 2 ) ) and ( PWord( module )^ = CEMAGIC ) then
        begin
        result := pointer( module + Cardinal( pointer( module + CENEWHDR )^ ) );
        if result^.signature <> CPEMAGIC then
          result := nil;
        end;
    except
      result := nil
    end;
  end;
var
  fh, map : THandle;
  buf     : pointer;
  nh      : PImageNtHeaders;
begin
  result := false;
  {$IFDEF UNICODE}
  fh := CreateFileW( fileName, GENERIC_READ, FILE_SHARE_READ, nil, OPEN_EXISTING, 0, 0 );
  {$ELSE}
  fh := CreateFileA( fileName, GENERIC_READ, FILE_SHARE_READ, nil, OPEN_EXISTING, 0, 0 );
  {$ENDIF}
  if fh <> INVALID_HANDLE_VALUE then
    begin
    map := CreateFileMapping( fh, nil, PAGE_READONLY, 0, 0, nil );
    if map <> 0 then
      begin
      buf := MapViewOfFile( map, FILE_MAP_READ, 0, 0, 0 );
      if buf <> nil then
        begin
        nh := GetImageNtHeaders( HMODULE( buf ) );
        result := ( nh <> nil ) and ( nh.OptionalHeader.Magic = IMAGE_NT_OPTIONAL_HDR64_MAGIC );
        UnmapViewOfFile( buf );
        end;
      CloseHandle( map );
      end;
    CloseHandle( fh );
    end;
end;

function CommittedStackSize: Cardinal;
//NB: Win32 uses FS, Win64 uses GS as base for Thread Information Block.
asm
 {$IFDEF WIN32}
  mov eax, [fs:04h] // TIB: base of the stack
  mov edx, [fs:08h] // TIB: lowest committed stack page
  sub eax, edx      // compute difference in EAX ( =Result )
 {$ENDIF}
 {$IFDEF WIN64}
  mov rax, abs [gs:08h] // TIB: base of the stack
  mov rdx, abs [gs:10h] // TIB: lowest committed stack page
  sub rax, rdx          // compute difference in RAX ( =Result )
 {$ENDIF}
end;

function GetProcessMemory( var PMC : TProcessMemoryCountersEx; AppHandle : Integer = -1 ): integer;
var
  hProcess : THandle;
  hProgramm : THandle;
begin
  if ( AppHandle = -1 ) then
    hProcess := GetCurrentProcess
  else
    begin
    GetWindowThreadProcessID( AppHandle, @hProgramm );
    hProcess := OpenProcess( Process_Query_Information or Process_VM_Read, False, hProgramm );
    if hProcess = Invalid_Handle_Value then
      begin
      result := -1;
      Exit;
      end;
    end;
  if NOT GetProcessMemoryInfo( hProcess, @PMC, SizeOf( PMC ) ) then
    begin
    result := -2;
    Exit;
    end;

  CloseHandle( hProcess );
  result := 0;
end;

function GetWorkingSetSize: {$IFDEF WIN64}UINT64{$ELSE}UINT{$ENDIF};
var
  pmc: TProcessMemoryCountersEx;
begin
  result := 0;
  pmc.cb := SizeOf( pmc );
  if GetProcessMemoryInfo( GetCurrentProcess, @pmc, SizeOf( pmc ) ) then
    Result := pmc.WorkingSetSize
//  else
//    RaiseLastOSError;
end;

function GetPrivateUsage: {$IFDEF WIN64}UINT64{$ELSE}UINT{$ENDIF};
var
  pmc: TProcessMemoryCountersEx;
begin
  result := 0;
  pmc.cb := SizeOf( pmc );
  if GetProcessMemoryInfo( GetCurrentProcess, @pmc, SizeOf( pmc ) ) then
    Result := pmc.PrivateUsage
//  else
//    RaiseLastOSError;
end;

function GetPeakPageFileUsage: {$IFDEF WIN64}UINT64{$ELSE}UINT{$ENDIF};
var
  pmc: TProcessMemoryCountersEx;
begin
  result := 0;
  pmc.cb := SizeOf( pmc );
  if GetProcessMemoryInfo( GetCurrentProcess, @pmc, SizeOf( pmc ) ) then
    Result := pmc.PeakPageFileUsage
//  else
//    RaiseLastOSError;
end;

function GetMemoryStatus : TMemoryStatus;
begin
  result.dwLength := SizeOf( result );
  GlobalMemoryStatus( result );
end;

procedure HookResourceString( ResStringRec: pResStringRec; NewStr: PChar );
var
  OldProtect: Cardinal;
begin
  if NOT Assigned( ResStringRec ) then
    Exit;

  VirtualProtect( ResStringRec, SizeOf( ResStringRec^ ), PAGE_EXECUTE_READWRITE, @OldProtect );
  {$IF CompilerVersion < 21} {NativeUInt didn't exist or was broken before Delphi 2010.}
  ResStringRec^.Identifier := Cardinal( NewStr );
  {$ELSE}
  ResStringRec^.Identifier := NativeUint( NewStr );
  {$IFEND}
  VirtualProtect( ResStringRec, SizeOf( ResStringRec^ ), OldProtect, @OldProtect );
end;

function GetResourceString( ResStringRec: pResStringRec ) : String;
begin
  if NOT Assigned( ResStringRec ) then
    Exit;
  result := LoadResString( ResStringRec );
end;
function WindowHandleBelongsToUs( Handle : THandle ): boolean;
var
  pPID, pPID2 : Cardinal;
begin
  result := false;
  if NOT IsWindow( Handle ) then
    Exit;
  GetWindowThreadProcessId( Application.Handle, pPID );
  GetWindowThreadProcessId( Handle, pPID2 );
  result := ( pPID = pPID2 );
end;

function PixelToMonitorID( Pixel : TPoint ): Byte;
var
  i : integer;
begin
  result := 0;
  if Screen.MonitorCount = 1 then
    Exit;
  for i := 0 to Screen.MonitorCount-1 do
    if ( ( Pixel.X >= Screen.Monitors[i].WorkareaRect.Left ) AND ( Pixel.X <= Screen.Monitors[i].WorkareaRect.Right ) ) and
       ( ( Pixel.Y >= Screen.Monitors[i].WorkareaRect.Top ) AND ( Pixel.Y <= Screen.Monitors[i].WorkareaRect.Bottom ) ) then
      begin
      result := i;
      break;
      end;
end;

//function MethodIsEqual( const Method1, Method2 : TMethod ): Boolean;
function MethodIsEqual( const MethodPointer1, MethodPointer2 ): Boolean;
var
  Method1: System.TMethod absolute MethodPointer1;
  Method2: System.TMethod absolute MethodPointer2;
begin
  Result := ( Method1.Code = Method2.Code ) and ( Method1.Data = Method2.Data );
end;

procedure SetTimePeriod;
var
  TimeCaps : TTimeCaps;
begin
  if ( timeGetDevCaps( @TimeCaps, SizeOf( TimeCaps ) ) = 0 ) then
    begin
    timeBeginPeriod( TimeCaps.wPeriodMin );
    timeEndPeriod( TimeCaps.wPeriodMax );
    end;
end;

function EnumWindowsProc( hHwnd: HWND; Entrys : pENumWindowsArray ): bool; stdcall;
var
  pPid : Cardinal;
  title, ClassName : string;
  Data : ENumWindowsResult;
begin
  result := false;
  if ( hHwnd <> 0 ) then
    begin
    GetWindowThreadProcessId( hHwnd, pPid );
    SetLength( ClassName, 255 );
    SetLength( ClassName, GetClassName( hHwnd, PChar( className ), Length( className ) ) );
    SetLength( title, 255 );
    SetLength( title, GetWindowText( hHwnd, PChar( title ), Length( title ) ) );

    Data.Handle    := hHwnd;
    Data.ClassName := ClassName;
    Data.Title     := title;
    Data.Pid       := pPid;
    GetWindowRect( hHwnd, Data.Rect );
    Data.Width     := Abs( Data.Rect.Right-Data.Rect.Left );
    Data.Height    := Abs( Data.Rect.Bottom-Data.Rect.Top );
    Data.Visible   := IsWindowVisible( hHwnd );
    Data.IsIconic  := IsIconic( hHwnd );

    SetLength( Entrys^, Length( Entrys^ )+1 );
    Entrys^[ High( Entrys^ ) ] := Data;

    Result := true;
    end;
end;

function ReturnEnumWindows : ENumWindowsArray;
begin
  SetLength( result, 0 );
  EnumWindows( @EnumWindowsProc, Integer( @result ) );
end;

function ReturnEnumDesktopWindows( handle: THandle ) : ENumWindowsArray; // MS check, PID?
begin
  SetLength( result, 0 );
  EnumDesktopWindows( handle, @EnumWindowsProc, Integer( @result ) );
end;

function ReturnEnumThreadWindows( ThreadID: Cardinal ) : ENumWindowsArray;
begin
  SetLength( result, 0 );
  EnumThreadWindows( ThreadID, @EnumWindowsProc, Integer( @result ) );
end;

procedure ListProcesses( var fProcesses : tProcessRecord );
var
  Process32: TProcessEntry32;
  Module32: TModuleEntry32;
  ProcessSnapshot: THandle;
  ModuleSnapshot: THandle;
  SystemDirectory: array[0..255] of Char;
begin
  GetWindowsDirectory( @SystemDirectory, SizeOf( SystemDirectory ) );

  fProcesses.Count := 0;
  ProcessSnapshot := CreateToolHelp32SnapShot( TH32CS_SNAPALL, 0 );
  Process32.dwSize := SizeOf( TProcessEntry32 );
  Process32First( ProcessSnapshot, Process32 );
  repeat
    Inc( fProcesses.Count );
    SetLength( fProcesses.Items, fProcesses.Count );

    ModuleSnapshot := CreateToolHelp32SnapShot( TH32CS_SNAPMODULE, Process32.th32ProcessID );
    Module32.dwSize := SizeOf( TModuleEntry32 );
    Module32First( ModuleSnapshot, Module32 );

    fProcesses.Items[ fProcesses.Count-1 ].PID     := Process32.th32ProcessID;
    if Process32.th32ProcessID = 0 then
      fProcesses.Items[ fProcesses.Count-1 ].ExePath := 'Idle process' // Process32.szExeFile
    else if Process32.th32ProcessID = 4 then
      fProcesses.Items[ fProcesses.Count-1 ].ExePath := 'System' // Process32.szExeFile
    else
      begin
      if Copy( Module32.szExePath, 1, 4 ) = '\??\' then
        fProcesses.Items[ fProcesses.Count-1 ].ExePath := Copy( Module32.szExePath, 5, Length( Module32.szExePath ) - 4 )
      else if Copy( Module32.szExePath, 1, 11 ) = '\SystemRoot' then
        fProcesses.Items[ fProcesses.Count-1 ].ExePath := SystemDirectory + Copy( Module32.szExePath, 12, Length( Module32.szExePath ) - 11 )
      else
        fProcesses.Items[ fProcesses.Count-1 ].ExePath := Module32.szExePath;
      end;

    fProcesses.Items[ fProcesses.Count-1 ].Threads   := Process32.cntThreads;
    fProcesses.Items[ fProcesses.Count-1 ].ParentPID := Process32.th32ParentProcessID;
    fProcesses.Items[ fProcesses.Count-1 ].Priority  := Process32.pcPriClassBase;
    fProcesses.Items[ fProcesses.Count-1 ].Size      := Process32.dwSize;
    fProcesses.Items[ fProcesses.Count-1 ].Usage     := Process32.cntUsage; // MS

    fProcesses.Items[ fProcesses.Count-1 ].Is64Bit   := Is64bitProcessPID( fProcesses.Items[ fProcesses.Count-1 ].PID );
    if fProcesses.Items[ fProcesses.Count-1 ].Is64Bit then
      fProcesses.Items[ fProcesses.Count-1 ].ExePath := Process32.szExeFile;

    CloseHandle( ModuleSnapshot );
  until not ( Process32Next( ProcessSnapshot, Process32 ) );
  CloseHandle( ProcessSnapshot );
end;

function IsProcessRunning( Process : THandle ) : Boolean;
var
  Processes : tProcessRecord;
  i         : Integer;
  vPID      : Cardinal;
begin
  vPID := GetProcessID( Process );

  result := false;
  ListProcesses( Processes );
  for i := Low( Processes.Items ) to High( Processes.Items ) do
    begin
    if ( Processes.Items[ i ].PID = vPID ) then
      begin
      result := True;
      break;
      end;
    end;
  SetLength( Processes.Items, 0 );
end;

function IsProcessRunningPID( ProcessID : Cardinal ) : Boolean;
var
  Processes : tProcessRecord;
  i         : Integer;
begin
  result := false;
  ListProcesses( Processes );
  for i := Low( Processes.Items ) to High( Processes.Items ) do
    begin
    if ( Processes.Items[ i ].PID = ProcessID ) then
      begin
      result := True;
      break;
      end;
    end;
  SetLength( Processes.Items, 0 );
end;

function ListModules( PID: Cardinal ) : tModuleRecord;
var
  hSnapShot: THandle;
  lpme: TModuleEntry32;

  procedure AddToList;
  begin
    SetLength( result, Length( result )+1 );
    result[Length( result )-1] := lpme;
  end;
begin
  SetLength( result, 0 );
  hSnapShot := CreateToolHelp32Snapshot( TH32CS_SNAPMODULE, PID );
  if hSnapShot = INVALID_HANDLE_VALUE then
    Exit;

  lpme.dwSize := SizeOf( lpme );
  if Module32First( hSnapShot, lpme ) then
    AddToList;
  while Module32Next( hSnapShot, lpme ) do
    AddToList;
  CloseHandle( hSnapShot );
end;

function IsModuleLoaded( PID : Cardinal; Name : string ): boolean;
var
  M : tModuleRecord;
  i : Integer;
begin
  result := false;
  if ( Name = '' ) then
    Exit;
  M := ListModules( PID );
  for i := Low( M ) to High( M ) do
    begin
    if ( LowerCase( Name ) = LowerCase( M[i].szModule ) ) then
      begin
      result := True;
      break;
      end;
    end;
end;

function ListThreads( PID: Cardinal ) : tThreadRecord;
var
  hSnapShot: THandle;
  lpte: TThreadEntry32;

  procedure AddToList;
  begin
    if ( lpte.Th32OwnerProcessID = PID ) then
      begin
      SetLength( result, Length( result )+1 );
      result[Length( result )-1] := lpte;
      end;
  end;
begin
  SetLength( result, 0 );
  hSnapShot := CreateToolhelp32Snapshot( TH32CS_SNAPTHREAD, PID );
  if hSnapShot = INVALID_HANDLE_VALUE then
    Exit;

  lpte.dwSize := SizeOf( lpte );
  if Thread32First( hSnapShot, lpte ) then
    AddToList;
  while Thread32Next( hSnapShot, lpte ) do
    AddToList;
  CloseHandle( hSnapShot );
end;

function GetProcessCPURunTime( var value : Cardinal ): integer;
var
  Dummy, Kernel, User: TFileTime;
begin
  if Win32Platform <> VER_PLATFORM_WIN32_NT then
    begin
    result := -1;
    Exit;
    end;

  if not GetProcessTimes( GetCurrentProcess, Dummy, Dummy, Kernel, User ) then
    begin
    result := -2;
    Exit;
    end;
  Result := 0;
  value := ( Int64( Kernel ) + Int64( User ) ) div 10000000; // Returns seconds
end;

function GetWin32_VideoControllerInfo: Win32VideoControllers;
const
  WbemUser            ='';
  WbemPassword        ='';
  WbemComputer        ='localhost';
  wbemFlagForwardOnly = $00000020;
var
  FSWbemLocator : OLEVariant;
  FWMIService   : OLEVariant;
  FWbemObjectSet: OLEVariant;
  FWbemObject   : OLEVariant;
  oEnum         : IEnumvariant;
  iValue        : LongWord;
  i             : Integer;
begin;
  i := 0;
//  CoInitialize( nil );
  FSWbemLocator := CreateOleObject( 'WbemScripting.SWbemLocator' );
  FWMIService   := FSWbemLocator.ConnectServer( WbemComputer, 'root\CIMV2', WbemUser, WbemPassword );
  FWbemObjectSet:= FWMIService.ExecQuery( 'SELECT Name,PNPDeviceID  FROM Win32_VideoController','WQL',wbemFlagForwardOnly );
  oEnum         := IUnknown( FWbemObjectSet._NewEnum ) as IEnumVariant;
  while oEnum.Next( 1, FWbemObject, iValue ) = 0 do
    begin
    SetLength( result, i+1 );
    result[ i ].Name := String( FWbemObject.Name );
    result[ i ].PNPDeviceID := String( FWbemObject.PNPDeviceID );
    inc( i );
    FWbemObject := Unassigned;
    end;
//  CoUninitialize;
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function GetOSVersionEx( var lpVersionInformation: TOSVersionInfoEx ): BOOL; stdcall; external kernel32 name 'GetVersionExA'; // GetWinVersion
function GetOSVersionInfoEx : TOSVersionInfoEx;
var
  OSVersionInfo   : TOSVersionInfo absolute Result;
  Done : Boolean;
begin
  FillChar( Result, SizeOf( Result ), #0 );
  Done := False;
  try
    Result.dwOSVersionInfoSize := SizeOf( TOSVersionInfoEx );
    Done := GetOSVersionEx( Result );
  except
  end;
  if not( Done ) then
  begin
    try
      FillChar( Result, SizeOf( Result ), #0 );
      Result.dwOSVersionInfoSize := SizeOf( TOSVersionInfo );
      {Done := }GetVersionEx( OSVersionInfo );
    except
    end;
  end;
end;

function GetWinVersion : string;
  function WindowsBuildFromRegistry: Cardinal;
  begin
    Result := 0;
    with TRegistry.Create( KEY_EXECUTE ) do
    try
      RootKey := HKEY_LOCAL_MACHINE;
      if OpenKeyReadOnly( 'SOFTWARE\Microsoft\Windows NT\CurrentVersion\' ) then
      try
        result := Cardinal( StrToIntDef( ReadString( 'CurrentBuildNumber' ), 0 ) );
      except
      end;
      CloseKey;
    finally
      Free;
    end;
  end;
const
  VER_SUITE_PERSONAL  = $00000200;
  VER_NT_WORKSTATION  = $00000001;
  VER_SUITE_WH_SERVER = $00008000;
  SM_SERVERR2         = 89;
var
  OSInfo : TOSVersionInfoEx;
begin
  Result := 'Unbekannte Windows-Version';
  OSInfo := GetOSVersionInfoEx;
  case OSInfo.dwPlatformId of
    VER_PLATFORM_WIN32s:
    begin
      Result := 'Win32s';
    end;
    VER_PLATFORM_WIN32_WINDOWS:
    begin
      if ( OSInfo.dwMajorVersion = 4 ) and ( OSInfo.dwMinorVersion =  0 ) then
        Result := 'Windows 95';
      if ( OSInfo.dwMajorVersion = 4 ) and ( OSInfo.dwMinorVersion = 10 ) then
        Result := 'Windows 98';
      if ( OSInfo.dwMajorVersion = 4 ) and ( OSInfo.dwMinorVersion = 90 ) then
        Result := 'Windows Millennium Edition';
    end;
    VER_PLATFORM_WIN32_NT:
    begin
      if ( OSInfo.dwMajorVersion = 4 ) and ( OSInfo.dwMinorVersion = 0 ) then
        Result := 'Windows NT';
      if ( OSInfo.dwMajorVersion = 5 ) and ( OSInfo.dwMinorVersion = 0 ) then
        Result := 'Windows 2000';
      if ( OSInfo.dwMajorVersion = 5 ) and ( OSInfo.dwMinorVersion = 1 ) then
        Result := 'Windows XP';

      if ( OSInfo.dwMajorVersion = 5 ) and ( OSInfo.dwMinorVersion = 2 ) then
      begin
        if GetSystemMetrics( SM_SERVERR2 ) <> 0 then
          Result := 'Windows Server 2003 "R2"'
         else
           if ( OSInfo.wProductType = VER_NT_WORKSTATION ) then
             Result := 'Windows XP x64'
           else
             if OSInfo.wSuiteMask = VER_SUITE_WH_SERVER then
               Result := 'Windows Home Server'
             else
               Result := 'Windows Server 2003';
      end
      else if ( OSInfo.dwMajorVersion = 6 ) and ( OSInfo.dwMinorVersion = 0 ) then
        begin
        if ( OSInfo.wProductType = VER_NT_WORKSTATION ) then
          Result := 'Windows Vista'
        else
          Result := 'Windows Server 2008';
        end
      else if ( OSInfo.dwMajorVersion = 6 ) and ( OSInfo.dwMinorVersion = 1 ) then
        begin
        if ( OSInfo.wProductType = VER_NT_WORKSTATION ) then
          Result := 'Windows 7'
        else
          Result := 'Windows Server 2008 R2';
        end
      else if ( OSInfo.dwMajorVersion = 6 ) and ( OSInfo.dwMinorVersion = 2 ) then
        begin
        if ( OSInfo.wProductType = VER_NT_WORKSTATION ) then // 9200
          Result := 'Windows 8'
        else
          Result := 'Windows Server 2012';

        case WindowsBuildFromRegistry of
            9600..9840   : begin
                           if ( OSInfo.wProductType = VER_NT_WORKSTATION ) then
                             Result := 'Windows 8.1'
                           else
                             Result := 'Windows Server 2012 R2';
                           end;
            9841..11081  : begin
                           if ( OSInfo.wProductType = VER_NT_WORKSTATION ) then
                             Result := 'Windows 10'
                           else
                             Result := 'Windows Server 2016';
                           end;
            11082..14900 : begin
                           if ( OSInfo.wProductType = VER_NT_WORKSTATION ) then
                             Result := 'Windows 10 Anniversary'
                           else
                             Result := 'Windows Server 2016';
                           end;
            14901..15063 : begin
                           if ( OSInfo.wProductType = VER_NT_WORKSTATION ) then
                             Result := 'Windows 10 Creators'
                           else
                             Result := 'Windows Server 2016';
                           end;
            15064..16299 : begin
                           if ( OSInfo.wProductType = VER_NT_WORKSTATION ) then
                             Result := 'Windows 10 Creators (Fall)'
                           else
                             Result := 'Windows Server 2016';
                           end;
(*
            16300..17110 : begin
                           if ( OSInfo.wProductType = VER_NT_WORKSTATION ) then
                             Result := 'Windows 10'
                           else
                             Result := 'Windows Server 2016';
                           end;
            17111..17604 : begin
                           if ( OSInfo.wProductType = VER_NT_WORKSTATION ) then
                             Result := 'Windows 10'
                           else
                             Result := 'Windows Server 2016';
                           end;
*)
        else // Newest ...
          begin
          if ( OSInfo.wProductType = VER_NT_WORKSTATION ) then
            Result := 'Windows 10 Creators ( Fall )'
          else
            Result := 'Windows Server 2016';
          end;
        end;
        end
      else if ( OSInfo.dwMajorVersion = 6 ) and ( OSInfo.dwMinorVersion = 3 ) then
        begin
        if ( OSInfo.wProductType = VER_NT_WORKSTATION ) then
          Result := 'Windows 8.1'
        else
          Result := 'Windows Server 2012 R2';
        end
      else if ( OSInfo.dwMajorVersion = 10 ) and ( OSInfo.dwMinorVersion = 0 ) then
        begin
        if ( OSInfo.wProductType = VER_NT_WORKSTATION ) then
          Result := 'Windows 10'
        else
          Result := 'Windows Server 2016';
        end;
      if ( OSInfo.wSuiteMask and VER_SUITE_PERSONAL ) = VER_SUITE_PERSONAL then
        Result := Result + ' Home Edition'
      else
        Result := Result + ' Professional';
    end;
  end;
  Result := Trim( Result + ' ' + string( OSInfo.szCSDVersion ) );
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function GetWinServicePack : string;
var
  OSInfo : TOSVersionInfoEx;
begin
  OSInfo := GetOSVersionInfoEx;
  result := Format( '%d.%d', [ OSInfo.wServicePackMajor, OSInfo.wServicePackMinor ] );
end;

function GetWinBuild : Cardinal;
var
  OSInfo : TOSVersionInfoEx;
begin
  OSInfo := GetOSVersionInfoEx;
  result := OSInfo.dwBuildNumber;
end;

function IsWindowsAdministrator: Boolean;
// Returns TRUE if the user has administrator priveleges
// Returns a boolean indicating whether or not user has admin
// privileges. Call only when running under NT. Win9.x will return false!
const
  SECURITY_NT_AUTHORITY: SID_IDENTIFIER_AUTHORITY =
    ( Value: ( 0,0,0,0,0,5 ) ); // ntifs
  SECURITY_BUILTIN_DOMAIN_RID: Cardinal = $00000020;
  DOMAIN_ALIAS_RID_ADMINS: Cardinal = $00000220;
  DOMAIN_ALIAS_RID_USERS : Cardinal = $00000221;
  DOMAIN_ALIAS_RID_GUESTS: Cardinal = $00000222;
  DOMAIN_ALIAS_RID_POWER_: Cardinal = $00000223;
var
  hAccessToken       : tHandle;
  ptgGroups          : pTokenGroups;
  dwInfoBufferSize   : Cardinal;
  psidAdministrators : PSID;
  int                : integer;            // counter
  blnResult          : boolean;            // return flag
begin
  Result := False;
  blnResult := OpenThreadToken( GetCurrentThread, TOKEN_QUERY, True, hAccessToken );
  if ( not blnResult ) then
    begin
    if GetLastError = ERROR_NO_TOKEN then
    blnResult := OpenProcessToken( GetCurrentProcess, TOKEN_QUERY, hAccessToken );
    end;
  ptgGroups := nil;
  if ( blnResult ) then
  try
    GetMem( ptgGroups, 1024 );
    blnResult := GetTokenInformation( hAccessToken, TokenGroups, ptgGroups, 1024, dwInfoBufferSize );
    CloseHandle( hAccessToken );
    if ( blnResult ) then
      begin
      AllocateAndInitializeSid( SECURITY_NT_AUTHORITY, 2, SECURITY_BUILTIN_DOMAIN_RID,
                                DOMAIN_ALIAS_RID_ADMINS, 0, 0, 0, 0, 0, 0, psidAdministrators );
      {$IFOPT R+}
        {$DEFINE RMINUS}
        {$R-}
      {$ENDIF}
      for int := 0 to ptgGroups.GroupCount - 1 do
        if EqualSid( psidAdministrators, ptgGroups.Groups[ int ].Sid ) then
          begin
          Result := True;
          Break;
          end;
      {$IFDEF IMINUS}
        {$R-}
        {$UNDEF IMINUS}
      {$ENDIF}

      FreeSid( psidAdministrators );
      end;
  finally
    If ptgGroups <> nil then
      FreeMem( ptgGroups );
  end;
end;

function IsApplicationAdmin : Boolean;
var
  H: SC_HANDLE;
begin
  if Win32Platform = VER_PLATFORM_WIN32_NT then
    begin
    H := OpenSCManager ( PChar( '' ), nil, SC_MANAGER_ALL_ACCESS );
    Result := H <> 0;
    if Result then
      CloseServiceHandle( H );
    end
  else
    Result := True
end;

function GetComputerName: String;
var
  Size: Cardinal;
begin
  Size := MAX_COMPUTERNAME_LENGTH + 1;
  SetLength( Result, Size );
  if Windows.GetComputerName( PChar( Result ), Size ) then
    SetLength( Result, Size )
  else
    Result := '';
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function RegisterLibrary( FileName : string; vRegister : boolean = True ) : Integer;
type
  TRegProc = function : HResult; stdcall;
var
  Handle : THandle;
  Proc   : TRegProc;
begin
  result := -3;
  Handle := LoadLibrary( PChar( FileName ) );
  if Handle = 0 then
    Exit;
  try
    if vRegister then
      @Proc := GetProcAddress( Handle, 'DllRegisterServer' )
    else
      @Proc := GetProcAddress( Handle, 'DllUnregisterServer' );
    result := -2;
    if NOT Assigned( Proc )then
      Exit;
    result := -1;
    if Proc <> 0 then
      Exit;
    result := 0;
  finally
    FreeLibrary( Handle );
  end;
end;

function IsClassIDRegistered( ClassID: String; var FileName : string ): Boolean;
var
  KeyList : TStringList;
  i       : Integer;
  Key     : String;
  Reg     : TRegistry;
begin
  Result := false;
  FileName := '';
  if ( ClassID = '' ) then
    Exit;

  if ( LeftStr( ClassID, 1 ) <> '{' ) then
    ClassID := '{' + ClassID;
  if ( RightStr( ClassID, 1 ) <> '}' ) then
    ClassID := ClassID + '}';

  KeyList := TStringList.Create;
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_CLASSES_ROOT;

  if Reg.OpenKey( '', false ) then
    begin
    Reg.GetKeyNames( KeyList );
    Reg.CloseKey;

    for i := 0 to KeyList.Count -1 do
      begin
      Key := KeyList.Strings[ i ];
      if NOT Reg.OpenKey( '\' + Key, False ) then
        Continue;

      if NOT Reg.KeyExists( 'CLSID' ) then
        Continue;

      Reg.CloseKey;
      if NOT Reg.OpenKey( '\' + Key + '\CLSID', false ) then
        continue;

      if ( LowerCase( ClassID ) = LowerCase( Reg.ReadString( '' ) ) ) then
        begin
        Result := true;

        Reg.CloseKey;
        if Reg.OpenKey( '\CLSID\' + ClassID + '\' + 'InprocServer32', false ) then
          FileName := Reg.ReadString( '' );

        Reg.CloseKey;
        break;
        end;
      end;
    end;
  Reg.Free;
  KeyList.Free;
end;

function IsClassIDRegistered( ClassID: String ): Boolean;
var
  FileName : string;
begin
  result := IsClassIDRegistered( ClassID, FileName );
end;

function IsClassNameRegistered( ClassName: String; var ClassID : string ): Boolean;
var
  KeyList : TStringList;
  i       : Integer;
  Key     : String;
  Reg     : TRegistry;
begin
  Result := false;
  ClassID := '';
  if ( ClassName = '' ) then
    Exit;

  KeyList := TStringList.Create;
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_CLASSES_ROOT;

  if Reg.OpenKey( '', false ) then
    begin
    Reg.GetKeyNames( KeyList );
    Reg.CloseKey;

    for i := 0 to KeyList.Count -1 do
      begin
      Key := KeyList.Strings[ i ];
      if NOT Reg.OpenKey( '\' + Key, False ) then
        Continue;

      if NOT Reg.KeyExists( 'CLSID' ) then
        Continue;

      Reg.CloseKey;
      if Reg.OpenKey( '\' + Key + '\CLSID', false ) then
        begin
        ClassID := Reg.ReadString( '' );
        Reg.CloseKey;
        if NOT Reg.OpenKey( '\CLSID\' + ClassID + '\' + 'ProgID', false ) then
          Continue;

        if ( LowerCase( ClassName ) = LowerCase( Reg.ReadString( '' ) ) ) then
          begin
          Result := true;
          Reg.CloseKey;
          break;
          end;
        end;
      end;
    end;
  Reg.Free;
  KeyList.Free;
end;

function IsClassNameRegistered( ClassName: String ): Boolean;
var
  ClassID : string;
begin
  result := IsClassNameRegistered( ClassName, ClassID );
end;

function IsFileRegistered( var FileName : String ) : Boolean; overload;
var
  ClassID : string;
begin
  result := IsFileRegistered( FileName, ClassID );
end;

function IsFileRegistered( var FileName : String; var ClassID : String ) : Boolean; overload;
var
  KeyList   : TStringList;
  i         : Integer;
  Key       : String;
  Reg       : TRegistry;
  FileOnly  : boolean;
  tFileName : String;
begin
  result := false;
  ClassID := '';
  if ( FileName = '' ) then
    Exit;

  FileOnly := ( ExtractFileName( FileName ) = FileName );
  KeyList := TStringList.Create;
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_CLASSES_ROOT;

  if Reg.OpenKey( 'CLSID', false ) then
    begin
    Reg.GetKeyNames( KeyList );
    Reg.CloseKey;

    for i := 0 to KeyList.Count -1 do
      begin
      Key := KeyList.Strings[ i ];
      if NOT Reg.OpenKey( '\CLSID\' + Key, False ) then
        Continue;

      Reg.CloseKey;
      if NOT Reg.OpenKey( '\CLSID\' + Key + '\InprocServer32', false ) then
        continue;

      tFileName := Reg.ReadString( '' );
      if ( NOT FileOnly AND ( LowerCase( FileName ) = LowerCase( tFileName ) ) ) OR
         ( FileOnly AND ( LowerCase( FileName ) = LowerCase( ExtractFileName( tFileName ) ) ) ) then
        begin
        Result := true;
        FileName := tFileName;
        ClassID := Key;
        Reg.CloseKey;
        break;
        end;
      end;
    end;
  Reg.Free;
  KeyList.Free;
end;

function LCIDtoCodePage( LCID : Cardinal ) : Word;
var
  buf : Array [0..4] of Char;
begin
  GetLocaleInfo( LCID, LOCALE_IDEFAULTANSICODEPAGE, buf, SizeOf( buf ) );
  result := StrToIntDef( buf, 0 );
end;

function IsNativeCodePage : boolean;
var
  Buf: array[ 0..6 ] of Char;
  ACP : Cardinal;
begin
  result := false;
  if ( Win32Platform = VER_PLATFORM_WIN32_NT ) and ( Win32MajorVersion >= 5 ) then
    begin
    GetLocaleInfo( 0, LOCALE_IDefaultAnsiCodePage, Buf, 6 );
    ACP := GetACP;
    result := ( StrToInt64Def( Buf, ACP ) = ACP );
    end;
end;

function GetLocaleNameFromReg: string;
var
  Reg : TRegistry;
begin
  result := '';
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_CURRENT_USER;
  if Reg.OpenKey( 'Control Panel\International', false ) then
    begin
    Result := Reg.ReadString( 'LocaleName' );
    Reg.CloseKey;
    end;
  Reg.Free;
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function ShellExecuteAndWait( FileName, Parameter, Directory: string; Operation : string = 'open'; Show: Word = SW_HIDE; bWait: Boolean = True ): Longint;
var
  Info: TShellExecuteInfo;
begin
  FillChar( Info, SizeOf( Info ), #0 );
  Info.cbSize       := SizeOf( Info );
  Info.fMask        := SEE_MASK_NOCLOSEPROCESS;
  Info.lpVerb       := PChar( Operation );
  Info.lpFile       := PChar( FileName );
  Info.lpParameters := PChar( Parameter );
  Info.lpDirectory  := PChar( Directory );
  Info.nShow        := Show;

  result := -2;
  if NOT ShellExecuteEx( @Info ) then
    Exit;

  Result := 0;
  if NOT bWait then
    Exit;

  while ( WaitForSingleObject( Info.hProcess, 100 ) = WAIT_TIMEOUT ) do
    begin
    if ( Windows.GetCurrentThreadId = System.MainThreadID ) then
      Application.ProcessMessages
    else
      Sleep( 10 );
    end;

  if NOT GetExitCodeProcess( Info.hProcess, Cardinal( Result ) ) then
    result := -1;
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function NtUnmapViewOfSection( ProcessHandle : THandle; BaseAddress : Pointer ) : Cardinal; stdcall; external 'ntdll';

function ExecutePEFromMemory( pFile: Pointer; ExeFileName : string = ''; Params: string = ''; ExecuteBeforeResume : TExecuteBeforeResume = nil; vPI : pProcessInformation = nil ) : boolean;
type
  PImageBaseRelocation = ^TImageBaseRelocation;
  TImageBaseRelocation = packed record
     VirtualAddress: Cardinal;
     SizeOfBlock: Cardinal;
  end;
var
  PI          : TProcessInformation;
  SI          : TStartupInfo;
  CT          : PContext;
  CTBase      : PContext;
  IDH         : PImageDosHeader;
  INH         : PImageNtHeaders;
  dwImageBase : Cardinal;
  pModule     : Pointer;
  dwNull      : THandle;

  ISH         : PImageSectionHeader;
  i           : Cardinal;
  aPnt        : Pointer;

  relocation  : PImageBaseRelocation;
  relInfo     : ^Word;
  patchAddrHL : ^Cardinal;
  l_type,
  l_offset    : integer;
begin
  Result := false;

  if ( pFile = nil ) then
    Exit;

  if ( ExeFileName = '' ) OR ( NOT FileExists( ExeFileName ) ) then
    ExeFileName := Application.ExeName;
  if ( Params <> '' ) then
    Params := '"' + ExeFileName + '" ' + Params;

  IDH := pFile;
  if IDH^.e_magic <> IMAGE_DOS_SIGNATURE then
    Exit;

  INH := Pointer( Integer( pFile ) + IDH^._lfanew );
  if INH^.Signature <> IMAGE_NT_SIGNATURE then
    Exit;

  FillChar( SI, SizeOf( TStartupInfo ), #0 );
  FillChar( PI, SizeOf( TProcessInformation ), #0 );
  if ( vPI <> nil ) then
    Move( Pi, vPI^, SizeOf( TProcessInformation ) );

  SI.cb := SizeOf( TStartupInfo );
  if NOT CreateProcess( PChar( ExeFileName ), PChar( Params ), nil, nil, FALSE, CREATE_SUSPENDED, nil, nil, SI, PI ) then
    Exit;
  if ( vPI <> nil ) then
    Move( Pi, vPI^, SizeOf( TProcessInformation ) );    

  // Get4ByteAlignedContext
  CTBase := VirtualAlloc( nil, SizeOf( TContext ) + 4, MEM_COMMIT, PAGE_READWRITE );
  CT := CTBase;
  if CTBase <> nil then
    while ( ( Cardinal( CT ) mod 4 ) <> 0 ) do
      CT := Pointer( Cardinal( CT ) + 1 );

  if CT <> nil then
    begin
    CT.ContextFlags := CONTEXT_FULL;
    if GetThreadContext( PI.hThread, CT^ ) then
      begin
      ReadProcessMemory( PI.hProcess, Pointer( CT.Ebx + 8 ), @dwImageBase, 4, dwNull );
      if dwImageBase = INH^.OptionalHeader.ImageBase then
        begin
        if NtUnmapViewOfSection( PI.hProcess, Pointer( INH^.OptionalHeader.ImageBase ) ) = 0 then
          pModule := VirtualAllocEx( PI.hProcess, Pointer( INH^.OptionalHeader.ImageBase ), INH^.OptionalHeader.SizeOfImage, MEM_COMMIT or MEM_RESERVE, PAGE_EXECUTE_READWRITE )
        else
          pModule := VirtualAllocEx( PI.hProcess, nil, INH^.OptionalHeader.SizeOfImage, MEM_COMMIT or MEM_RESERVE, PAGE_EXECUTE_READWRITE );
        end
      else
        pModule := VirtualAllocEx( PI.hProcess, Pointer( INH^.OptionalHeader.ImageBase ), INH^.OptionalHeader.SizeOfImage, MEM_COMMIT or MEM_RESERVE, PAGE_EXECUTE_READWRITE );
      if pModule <> nil then
        begin
        // AlignImage
        GetMem( aPnt, INH^.OptionalHeader.SizeOfImage );
        ZeroMemory( aPnt, INH^.OptionalHeader.SizeOfImage );
        CopyMemory( aPnt, IDH, INH^.OptionalHeader.SizeOfHeaders );
        for i := 0 to INH^.FileHeader.NumberOfSections - 1 do
          begin
          ISH := Pointer( Integer( IDH ) + IDH^._lfanew + 248 + Integer( i ) * 40 );
          CopyMemory( Pointer( Cardinal( aPnt ) + ISH^.VirtualAddress ), Pointer( Cardinal( IDH ) + ISH^.PointerToRawData ), ISH^.SizeOfRawData );
          end;
        pFile := aPnt;

        if Cardinal( pModule ) <> INH^.OptionalHeader.ImageBase then
          begin
          // PerformBaseRelocation
          if INH^.OptionalHeader.DataDirectory[5].Size > 0 then
            begin
            relocation := PImageBaseRelocation( Cardinal( pFile ) + INH^.OptionalHeader.DataDirectory[5].VirtualAddress );
            while relocation.VirtualAddress > 0 do
              begin
              aPnt := Pointer( ( Cardinal( pFile ) + relocation.VirtualAddress ) );
              relInfo := Pointer( Cardinal( relocation ) + 8 );
              for i := 0 to ( trunc( ( ( relocation.SizeOfBlock - 8 ) / 2 ) ) - 1 ) do
                begin
                l_type := ( relInfo^ shr 12 );
                l_offset := relInfo^ and $FFF;
                if l_type = 3 then
                  begin
                  patchAddrHL := Pointer( Cardinal( aPnt ) + Cardinal( l_offset ) );
                  patchAddrHL^ := patchAddrHL^ + {f_delta}( Cardinal( pModule ) - INH^.OptionalHeader.ImageBase );
                  end;
                inc( relInfo );
                end;
              relocation := Pointer( cardinal( relocation ) + relocation.SizeOfBlock );
              end;
            end;

          INH^.OptionalHeader.ImageBase := Cardinal( pModule );
          CopyMemory( Pointer( Integer( pFile ) + IDH^._lfanew ), INH, 248 );
          end;
        WriteProcessMemory( PI.hProcess, pModule, pFile, INH.OptionalHeader.SizeOfImage, dwNull );
        WriteProcessMemory( PI.hProcess, Pointer( CT.Ebx + 8 ), @pModule, 4, dwNull );
        CT.Eax := Cardinal( pModule ) + INH^.OptionalHeader.AddressOfEntryPoint;
        SetThreadContext( PI.hThread, CT^ );

        if Assigned( ExecuteBeforeResume ) then
          begin
          if NOT ExecuteBeforeResume( PI.hThread ) then
            TerminateProcess( PI.hThread, 254 );
          end;

        ResumeThread( PI.hThread );
//        Result := PI.hThread;
        result := True;
        end;
      end;
    VirtualFree( CTBase, 0, MEM_RELEASE );
    end;
  if NOT Result then
    TerminateProcess( PI.hProcess, 0 );
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// NameThread
procedure NameThread( AThreadName: string; AThreadID: TThreadID = TThreadID( -1 ) );
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  {$IF CompilerVersion < 21} // {$IF NOT Declared( TThread.NameThreadForDebugging )}
  // Setting a Thread Name ( Unmanaged ):
  // http://msdn.microsoft.com/en-us/library/xcb2z8hs( VS.71 ).aspx
  procedure NameThreadForDebugging( AThreadName: string; AThreadID: TThreadID = TThreadID( -1 ) );
  {$IF NOT Declared( cSetThreadNameExcep )}
  const
    cSetThreadNameExcep  = $406D1388;
  {$IFEND}
  type
    TThreadNameInfo = record
      FType: LongWord;     // must be 0x1000
      FName: PAnsiChar;    // pointer to name ( in user address space )
      FThreadID: LongWord; // thread ID ( -1 indicates caller thread )
      FFlags: LongWord;    // reserved for future use, must be zero
    end;
  var
    ThreadNameInfo: TThreadNameInfo;
  begin
    // Applicable only for debugged applications
    if NOT IsDebuggerPresent then
      Exit;

    if ( AThreadID = 0 ) then
      AThreadID := TThreadID( -1 );

    FillChar( ThreadNameInfo, SizeOf( ThreadNameInfo ), 0 );
    ThreadNameInfo.FType     := $1000;
    ThreadNameInfo.FName     := PAnsiChar( {$IFDEF UNICODE}AnsiString( AThreadName ){$ELSE}AThreadName{$ENDIF} );
    ThreadNameInfo.FThreadID := AThreadID;
    ThreadNameInfo.FFlags    := 0;

    try
      RaiseException( cSetThreadNameExcep, 0, SizeOf( ThreadNameInfo ) div SizeOf( LongWord ), @ThreadNameInfo );
    except
    end;
  end;
  {$IFEND}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  {$IF Defined( madExcept )}
    madExcept.NameThread( AThreadID, AThreadName );
  {$ELSEIF Defined( EurekaLog )}
    EThreadsManager.NameThread( AThreadName, AThreadID );
  {$ELSE}
    {$IF CompilerVersion >= 21} // {$IF Declared( TThread.NameThreadForDebugging )}
      TThread.NameThreadForDebugging( AThreadName, AThreadID );
    {$ELSE}
      NameThreadForDebugging( AThreadName, AThreadID );
    {$IFEND}
  {$IFEND}

  {$IF Declared( DDDAccess )} // Needs to be called since it has its own system ..
    if ( AThreadID = 0 ) OR ( AThreadID = TThreadID( -1 ) ) then // DDDebug doesnt support -1
      AThreadID := GetCurrentThreadId;
    ThreadHandler.SetThreadName( AThreadID, AThreadName );
  {$IFEND}
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function SetPrivilege( Privilege: PChar; EnablePrivilege: Boolean; out PreviousState: Boolean ): Cardinal;
var
  Token: THandle;
  NewState: TTokenPrivileges;
  Luid: TLargeInteger;
  PrevState: TTokenPrivileges;
  Return: Cardinal;
begin
  PreviousState := True;
  if ( GetVersion( ) > $80000000 ) then // Win9x 
    Result := ERROR_SUCCESS
  else
    begin // WinNT
    if not OpenProcessToken( GetCurrentProcess( ), MAXIMUM_ALLOWED, Token ) then
      Result := GetLastError
    else
    try
      if not LookupPrivilegeValue( nil, Privilege, Luid ) then
        Result := GetLastError
      else
        begin
        NewState.PrivilegeCount := 1;
        NewState.Privileges[0].Luid := Luid;
        if EnablePrivilege then
          NewState.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED
        else
          NewState.Privileges[0].Attributes := 0;
        if not AdjustTokenPrivileges( Token, False, NewState, SizeOf( TTokenPrivileges ), PrevState, Return ) then
          Result := GetLastError
        else
          begin
          Result := ERROR_SUCCESS;
          PreviousState := ( PrevState.Privileges[0].Attributes and SE_PRIVILEGE_ENABLED <> 0 );
          end;
        end;
    finally
      CloseHandle( Token );
    end;
    end;
end;

function RegistryLoadKeyFromRegFile( FileName : string; WaitForFinish : boolean = True ): Boolean;
begin
  result := false;
  if NOT FileExists( FileName ) then
    Exit;
//  result := NOT ( ShellExecute( 0, nil, 'regedit.exe', PChar( '/s "' + FileName + '"' ),nil, SW_HIDE ) <= 32 );
  result := ( ShellExecuteAndWait( 'regedit.exe', '/s "' + FileName + '"', '', 'open', SW_HIDE, WaitForFinish ) = 0 );
end;

function RegistrySaveKeyToRegFile( RootKey : HKEY; Key, FileName : string; WaitForFinish : boolean = True ): Boolean;
var
  sRootKey : string;
begin
  result := false;
  if ( RootKey = HKEY_CLASSES_ROOT          ) then
    sRootKey := 'HKEY_CLASSES_ROOT'
  else if ( RootKey = HKEY_CURRENT_USER     ) then
    sRootKey := 'HKEY_CURRENT_USER'
  else if ( RootKey = HKEY_LOCAL_MACHINE    ) then
    sRootKey := 'HKEY_LOCAL_MACHINE'
  else if ( RootKey = HKEY_USERS            ) then
    sRootKey := 'HKEY_USERS'
  else if ( RootKey = HKEY_PERFORMANCE_DATA ) then
    sRootKey := 'HKEY_PERFORMANCE_DATA'
  else if ( RootKey = HKEY_CURRENT_CONFIG   ) then
    sRootKey := 'HKEY_CURRENT_CONFIG'
  else if ( RootKey = HKEY_DYN_DATA         ) then
    sRootKey := 'HKEY_DYN_DATA'
  else
    Exit;

  Result := RegistrySaveKeyToRegFile( sRootKey, Key, FileName, WaitForFinish );
end;

function RegistrySaveKeyToRegFile( RootKey, Key, FileName : string; WaitForFinish : boolean = True ): Boolean;
begin
//  result := NOT ( ShellExecute( 0,nil,'regedit.exe', PChar( '/e "' + FileName + '" "' + RootKey + '\' + Key + '"' ),nil, SW_HIDE ) <= 32 );
  result := ( ShellExecuteAndWait( 'regedit.exe', '/e "' + FileName + '" "' + RootKey + '\' + Key + '"', '', 'open', SW_HIDE, WaitForFinish ) = 0 );
end;

function RegistryLoadKeyFromFile( RootKey : HKEY; Key, FileName : string ): Boolean;
var
  Reg : TRegistry;
  PrevState : Boolean;
begin
  result := false;

  if NOT FileExists( FileName ) then
    Exit;

  if not SetPrivilege( SE_RESTORE_NAME, True, PrevState ) = 0 then
    Exit;

  Reg := TRegistry.Create( KEY_READ OR KEY_WRITE );
  Reg.RootKey := RootKey;
  if Reg.KeyExists( Key ) then
    if Reg.DeleteKey( Key ) then
      result := Reg.LoadKey( Key, FileName );

  SetPrivilege( SE_RESTORE_NAME, PrevState, PrevState );
  Reg.free
end;

function RegistrySaveKeyToFile( RootKey : HKEY; Key, FileName : string ): Boolean;
var
  Reg : TRegistry;
  PrevState : Boolean;
begin
  result := false;

  if not SetPrivilege( SE_BACKUP_NAME, True, PrevState ) = 0 then
    Exit;

  Reg := TRegistry.Create( KEY_READ OR KEY_WRITE );
  if FileExists( FileName ) then // No override support
    DeleteFile( PChar( FileName ) );

  Reg.RootKey := RootKey;
  if Reg.KeyExists( Key ) then
    result := Reg.SaveKey( Key, FileName );

  SetPrivilege( SE_BACKUP_NAME, PrevState, PrevState );
  Reg.free
end;

function RegistryDeleteKey( RootKey : HKEY; Key : string ): Boolean;
var
  Reg : TRegistry;
  PrevState : Boolean;
begin
  result := false;

  if not SetPrivilege( SE_RESTORE_NAME, True, PrevState ) = 0 then
    Exit;
  Reg := TRegistry.Create( KEY_READ OR KEY_WRITE );
  Reg.RootKey := RootKey;
  if Reg.KeyExists( Key ) then
    result := Reg.DeleteKey( Key );

  SetPrivilege( SE_RESTORE_NAME, PrevState, PrevState );
  Reg.free
end;

function RegistryReadMultiSZ( const CurrentKey: HKey; const Subkey, ValueName: string; Strings: TStrings ) : boolean;
var
  valueType: Cardinal;
  valueLen: Cardinal;
  p, buffer: PChar;
  key: HKEY;
begin
  result := false;
  Strings.Clear;
  if RegOpenKeyEx( CurrentKey, PChar( Subkey ), 0, KEY_READ, key ) <> ERROR_SUCCESS then
    Exit;

  if RegQueryValueEx( key, PChar( ValueName ), nil, @valueType, nil, @valueLen ) <> ERROR_SUCCESS then
    Exit;

  if valueType <> REG_MULTI_SZ then
    Exit;

  GetMem( buffer, valueLen );

  // receive the value's data ( in an array ).
  RegQueryValueEx( key,
                  PChar( ValueName ),
                  nil,
                  nil,
                  PBYTE( buffer ),
                  @valueLen );

  // Add values to stringlist
  p := buffer;
  while p^ <> #0 do
    begin
    Strings.Add( p );
    Inc( p, lstrlen( p ) + 1 )
    end;
  FreeMem( buffer );
      
  result := True;
end;

function RegistryWriteMultiSZ( const CurrentKey: HKey; const Subkey, ValueName: string; Strings: TStrings ) : boolean;
var
  key       : HKEY;
  str       : string;
  i         : Integer;
begin
  result := false;

  for i := 0 to Strings.Count-1 do
    str := str + Strings[i] + #0;
  str := str + #0;

  if RegOpenKeyEx( CurrentKey, PChar( Subkey ), 0, KEY_WRITE, key ) <> ERROR_SUCCESS then
    Exit;
  result := RegSetValueEx( Key, pchar( valueName ), 0, REG_MULTI_SZ, pointer( str ), Length( str ) ) = 0;
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Environment
function Send_SETTINGCHANGE_Broadcast( sType : string = 'Environment' ) : boolean;
//var
//  aResult : Cardinal;
begin
  result := SendNotifyMessage( HWND_BROADCAST, WM_SETTINGCHANGE, WPARAM( 0 ), LPARAM( PChar( sType ) ) );
//  SendMessageTimeout( HWND_BROADCAST, $001A WM_SETTINGCHANGE, WPARAM( 0 ), LPARAM( PChar( sType ) ), SMTO_NORMAL, 4000, @aResult );
//  result := aResult = 0;
//  if aResult <> 0 then
//    SysErrorMessage( aResult );
end;

function GetEnvironmentPath( UserEnvironment: Boolean ): string;
const
  cKeyHKLM = 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment';
  cKeyHKCU = 'Environment';
var
  Reg : TRegistry;
  RegKey: string;
begin
  result := '';
  Reg := TRegistry.Create;
  if UserEnvironment then
    begin
    Reg.RootKey := HKEY_CURRENT_USER;
    RegKey      := cKeyHKCU;
    end
  else
    begin
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    RegKey      := cKeyHKLM;
    end;
  if Reg.OpenKey( RegKey, false ) then
    begin
    result := Reg.ReadString( 'Path' );
    Reg.CloseKey;
    end;
  Reg.Free;
end;

function SetEnvironmentPath( UserEnvironment: Boolean; NewPaths : string ): boolean;
const
  cKeyHKLM = 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment';
  cKeyHKCU = 'Environment';
var
  Reg : TRegistry;
  RegKey: string;
begin
  Reg := TRegistry.Create;
  if UserEnvironment then
    begin
    Reg.RootKey := HKEY_CURRENT_USER;
    RegKey      := cKeyHKCU;
    end
  else
    begin
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    RegKey      := cKeyHKLM;
    end;
  result := Reg.OpenKey( RegKey, false );
  if result then
    begin
    Reg.WriteExpandString( 'Path', NewPaths );
    Reg.CloseKey;
    Send_SETTINGCHANGE_Broadcast( 'Environment' );
    end;
  Reg.Free;
end;

function AddEnvironmentPath( UserEnvironment: Boolean; NewPath : string ): boolean;
  function AddTok( Text, Token : string; C : Char ) : string;
  var
    StrL  : TStringList;
    i     : Integer;
    found : Boolean;
  begin
    StrL := TStringList.Create;
    StrL.Text := StringReplace( Text, ';', #13, [ rfReplaceAll ] );

    found := false;
    for i := 0 to StrL.Count-1 do
      begin
      if ( LowerCase( StrL[ i ] ) = LowerCase( Token ) ) then
        found := True;
      end;
    if NOT Found then
      StrL.Add( Token );
    result := StringReplace( StrL.Text, #13#10, ';', [ rfReplaceAll ] );
    StrL.Free;
    result := StringReplace( result, ';;', ';', [ rfReplaceAll ] );
    if ( RightStr( result, 1 ) = ';' ) then
      Result := LeftStr( result, Length( result )-1 );
  end;
const
  cKeyHKLM = 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment';
  cKeyHKCU = 'Environment';
var
  Reg : TRegistry;
  RegKey: string;
begin
  Reg := TRegistry.Create;
  if UserEnvironment then
    begin
    Reg.RootKey := HKEY_CURRENT_USER;
    RegKey      := cKeyHKCU;
    end
  else
    begin
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    RegKey      := cKeyHKLM;
    end;
  result := Reg.OpenKey( RegKey, false );
  if result then
    begin
    Reg.WriteExpandString( 'Path', AddTok( Reg.ReadString( 'Path' ), NewPath, ';' ) );
    Reg.CloseKey;
    Send_SETTINGCHANGE_Broadcast( 'Environment' );
    end;
  Reg.Free;
end;

function DelEnvironmentPath( UserEnvironment: Boolean; RemovePath : string ): boolean;
  function RemTok( Text, Token : string; C : Char ) : string;
  var
    StrL  : TStringList;
    i     : Integer;
  begin
    StrL := TStringList.Create;
    StrL.Text := StringReplace( Text, ';', #13, [ rfReplaceAll ] );

    for i := StrL.Count-1 downTo 0 do
      begin
      if ( LowerCase( StrL[ i ] ) = LowerCase( Token ) ) then
        StrL.Delete( i );
      end;
    result := StringReplace( StrL.Text, #13#10, ';', [ rfReplaceAll ] );
    StrL.Free;
    result := StringReplace( result, ';;', ';', [ rfReplaceAll ] );
    if ( RightStr( result, 1 ) = ';' ) then
      Result := LeftStr( result, Length( result )-1 );
  end;
const
  cKeyHKLM = 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment';
  cKeyHKCU = 'Environment';
var
  Reg : TRegistry;
  RegKey: string;
begin
  Reg := TRegistry.Create;
  if UserEnvironment then
    begin
    Reg.RootKey := HKEY_CURRENT_USER;
    RegKey      := cKeyHKCU;
    end
  else
    begin
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    RegKey      := cKeyHKLM;
    end;
  result := Reg.OpenKey( RegKey, false );
  if result then
    begin
    Reg.WriteExpandString( 'Path', RemTok( Reg.ReadString( 'Path' ), RemovePath, ';' ) );
    Reg.CloseKey;
    Send_SETTINGCHANGE_Broadcast( 'Environment' );
    end;
  Reg.Free;
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure ListUSBDeviceSerials( var USB : tUSB_DeviceInfos );
var
  Reg, Reg2 : TRegistry;
  i         : Integer;
  Value     : String;
  P, P2     : Integer;
begin
  Reg := TRegistry.Create;
  Reg.Access := KEY_EXECUTE;
  Reg.RootKey := HKEY_LOCAL_MACHINE;
  if NOT Reg.OpenKey( '\SYSTEM\CurrentControlSet\Services\USBSTOR\Enum', false ) then
    begin
    Reg.Free;
    Exit;
    end;
  Reg2 := TRegistry.Create;

  SetLength( USB, Reg.ReadInteger( 'Count' ) );
  for i := 0 to Reg.ReadInteger( 'Count' )-1 do
    begin
    Value  := Reg.ReadString( IntToStr( i ) );

    P := Pos( '_', Value );
    P2 := PosEx( '&', Value, P );
    if ( P <> 0 ) AND ( P2 <> 0 ) then
      USB[ i ].Vid := Copy( Value, P+1, P2-1-P );

    P := PosEx( '_', Value, P2 );
    P2 := PosEx( '\', Value, P );
    if ( P <> 0 ) AND ( P2 <> 0 ) then
      USB[ i ].PID := Copy( Value, P+1, P2-1-P );

    P := PosEx( '\', Value, P2 );
    if ( P <> 0 ) then
      USB[ i ].Serial := Copy( Value, P+1, Length( Value )-P );

    Reg2.Access     := KEY_EXECUTE;
    Reg2.RootKey    := HKEY_LOCAL_MACHINE;
    if Reg2.OpenKey( Format( '\SYSTEM\CurrentControlSet\Enum\USB\Vid_%s&Pid_%s\%s', [ USB[ i ].VID, USB[ i ].PID, UpperCase( USB[ i ].Serial ) ] ), false ) then
      USB[ i ].Name := Reg2.ReadString( 'LocationInformation' )
    else
      USB[ i ].Name := '';
    end;

  Reg.free;
  Reg2.free;
end;

function IsUSBSerialPresent( Serial : String ): boolean;
var
  USB : tUSB_DeviceInfos;
  i   : Integer;
begin
	result      := false;
	if ( Serial = '' ) then
		Exit;

  ListUSBDeviceSerials( USB );
  for i := Low( USB ) to High( USB ) do
    begin
    if ( UpperCase( StringReplace( USB[ i ].Serial, ' ', '',[ rfReplaceAll ] ) ) = UpperCase( Serial ) ) then
      begin
      result := True;
      Break;
      end;
    end;
  SetLength( USB, 0 );
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Delphi 10 Seattle
{$IF CompilerVersion >= 30}
function CurrencyString : String;
begin
  result := {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}CurrencyString;
end;

function ShortDateFormat : String;
begin
  result := {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}ShortDateFormat;
end;

function LongDateFormat : String;
begin
  result := {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}LongDateFormat;
end;

function LongTimeFormat : String;
begin
  result := {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}LongTimeFormat;
end;

function ShortTimeFormat : String;
begin
  result := {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}ShortTimeFormat;
end;

function DecimalSeparator : Char;
begin
  result := {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}DecimalSeparator;
end;

function DateSeparator : Char;
begin
  result := {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}DateSeparator;
end;

function ThousandSeparator : Char;
begin
  result := {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}ThousandSeparator;
end;

procedure SetCurrencyString( value : String );
begin
  {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}CurrencyString := value;
end;

procedure SetLongDateFormat( value : String );
begin
  {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}LongDateFormat := value;
end;

procedure SetShortDateFormat( value : String );
begin
  {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}ShortDateFormat := value;
end;

procedure SetShortTimeFormat( value : String );
begin
  {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}ShortTimeFormat := value;
end;

procedure SetLongTimeFormat( value : String );
begin
  {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}LongTimeFormat := value;
end;

procedure SetDecimalSeparator( value : Char );
begin
  {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}DecimalSeparator := value;
end;

procedure SetDateSeparator( value : Char );
begin
  {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}DateSeparator := value;
end;

procedure SetThousandSeparator( value : Char );
begin
  {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}ThousandSeparator := value;
end;
{$IFEND}

{$IFEND TLH_INTERFACESECTION}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

{$IFNDEF TLH_OMIT_SECTIONS}
initialization
{$ENDIF TLH_OMIT_SECTIONS}
{$IF NOT Defined( TLH_INTERFACESECTION ) AND NOT Defined( TLH_IMPLEMENTATIONSECTION ) AND NOT Defined( TLH_FINALIZATIONSECTION )}
  {$IFDEF SetTimePeriod}
  SetTimePeriod;
  {$ENDIF}
{$IFEND}

{$IFNDEF TLH_OMIT_SECTIONS}
end.
{$ENDIF TLH_OMIT_SECTIONS}
