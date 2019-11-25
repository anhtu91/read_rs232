{
  TetzkatLipHoka 2015-2019

  uTLH: Files
  Last updated: 05/26/2019
}

{
GetFileExtension                    - Return extension of given filename
RemoveFileExtension                 - Stip extension of given filename
IsCharAllowedInPath                 - Returns true if given char is allowed for filenames
IsValidFilePath                     - Returns true if given path is valid
IsLogicalDrive                      - Returns true if the given DriveLetter is ( logical ) Valid
IsNetworkDrivePresent               - Returns true if the given DriveLetter is in use ( has a valid Size )
PurgeFiles                          - Deletes files (Mask) older than X days/ms
IsFileInUse                         - Returns if file is already opened or not
IsDirectoryWriteable                - Returns true if directory is writeable
FileSizeByte                        - Returns FileSize for given file (-1 if non existant), Works if File is in use
FileSizeKByte                       - Returns FileSize for given file (-1 if non existant), Works if File is in use
FileSizeMByte                       - Returns FileSize for given file (-1 if non existant), Works if File is in use
FileVersion                         - Returns FileVersion for given file/stream/resource
OpenFolderInExplorer                - Opens given folder with Windows Explorer
GetFileOwner                        - Returns owner user and domain for file/folder
SetFileAccess                       - Set access for given file/folder
                                      https://support.microsoft.com/de-de/kb/243330
// Directorys
GetDirSize                          - Return Size for given directory
CopyDir                             - SHFileOperation Method ( Semi-Windows 7 compatible but fast as hell )
MoveDir                             - SHFileOperation Method ( Semi-Windows 7 compatible but fast as hell )
DelDir                              - SHFileOperation Method ( Semi-Windows 7 compatible but fast as hell )
DelDirDelphi                        - Remove ( non empty/empty ( NO Subdirectorys ) ) directory using Delphi natives
EmptyDir                            - Removes a directorys content ( NO Subdirectorys )

ReturnLastDirectory                 - Returns last SubDirectory from given path
StripLastDirectory                  - Strips last SubDirectory from given path
GetParentDirectory                  - Returns parent-directory of given file or directory
IsDirectoryEmpty                    - Returns if given directory is empty
GetSubDirectories                   - Lists SubDirectorys of given Path
GetApplicationDirectory             - Return Path of Running Application
GetWinCommonAppDataDir              - Return ApplicationData directory of 'All Users'
GetWinAppDataDir                    - Return ApplicationData directory
GetWinDir                           - Return Windows-Directory
GetProgramFilesDir                  - Returns Program Files-Directory
GetMyDocumentsDir                   - Returns current profiles 'MyDocuments'-Directory
GetPublicDocumentDir                - Returns AllUsers 'MyDocuments'-Directory
GetSharedFilesDir                   - Returns SharedFiles-Directory
GetDesktopDir                       - Returns current profiles 'Desktop'-Directory
GetCommonDesktopDir                 - Returns common 'Desktop'-Directory
GetQuickLaunchDir                   - Returns current profiles QuickLaunch-Directory
GetCommonQuickLaunchDir             - Returns common QuickLaunch-Directory
GetStartMenuDir                     - Returns current profiles StartMenu-Directory
GetStartMenuProgramDir              - Returns current profiles StartMenu\Programs-Directory
GetCommonStartmenuDir               - Returns common Startmenu-Directory
GetCommonMenuProgramDir             - Returns common profiles StartMenu\Programs-Directory
GetWinUserDir                       - Returns Windows-UserDirectory
GetAutoStartDir                     - Returns current profiles 'AutoStart'-Directory
GetShellFolder                      - Return ShellFolders, for CSIDL's see:
                                      http://msdn.microsoft.com/en-us/library/windows/desktop/bb762494%28v=vs.85%29.aspx
EnvironmentPath                     - Return EnvironmentPath for given file (if file is found, else blank string)

CreateShellLink                     - Create or Update ShellLink/Shortcut-Files

GetFilesDropped                     - Returns List of Filenames Drag/Dropped to Application

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
SetFileAttributeReadOnly            - Sets Read-Only-Attribute for Files and/or Folder
UnSetFileAttributeReadOnly          - Removes Read-Only-Attribute for Files and/or Folder

SetFileAttributeHidden              - Sets Hidden-Attribute for Files and/or Folder
UnSetFileAttributeHidden            - Removes Hidden-Attribute for Files and/or Folder

SetFileAttributeSystem              - Sets System-Attribute for Files and/or Folder
UnSetFileAttributeSystem            - Removes System-Attribute for Files and/or Folder

EnumerateFilesToProcedure           - Enumerates all Files and Folders matching and gives them to Procedure (Internal)

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
FileSearch                          - QuickFunction of TFileSearch
                                      Called with 'Path, Ext : string; RecurseSubFolders : boolean = false'
                                      returns TStringList with file founds.
                                      Note: might take a bit time to finish, its designed for!
                                      If you want background processing, use TFileSearch instead.
                                      FileSearch( ) is designed to deliver results in structural process without
                                      event usage.

TFileSearch                         - Properties:
                                        property Stop : boolean - Set to true if you want to cancel searching.
                                        property SearchFile : shortstring - Set starting path and file mask for searching ( e.g. "c:\*.doc" ).
                                        property RecurseSubFolders : boolean - Do recursing or not.
                                        property FilesFound : TStringList - drh : list of files found ( read only )
                                        property Searching : boolean - drh : Indicates if a search is in progress ( read only )
                                      Event handlers:
                                        property OnFileFind : TFindFileEvent - On match found
                                        property OnChangeFolder : TChangeFolderEvent - On change folder
                                        property OnFinish : TNotifyEvent - On end of searching
                                    - Methods:
                                        procedure Start; - Start searching.

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
}
{$IFNDEF TLH_OMIT_SECTIONS}
unit uTLH.Files;

{$I uTLH.inc}

interface

uses
  Classes, SysUtils,
  AccCtrl{SetFileAccess};
{$ENDIF TLH_OMIT_SECTIONS}

{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_TYPE OFF}
{$WARN SYMBOL_PLATFORM OFF}
{$WARN GARBAGE OFF}
{$IF CompilerVersion >= 23.0}
  {$WARN IMPLICIT_STRING_CAST OFF}
  {$WARN IMPLICIT_STRING_CAST_LOSS OFF}
{$IFEND}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
{$IF NOT Defined( TLH_IMPLEMENTATIONSECTION ) AND NOT Defined( TLH_INITIALIZATIONSECTION ) AND NOT Defined( TLH_FINALIZATIONSECTION )}
function GetFileExtension( Str : String ): String;
function RemoveFileExtension( Str : String ): String;
function IsCharAllowedInPath( c : char ): boolean;
function IsValidFilePath( const FileName: String ): Boolean;
function IsLogicalDrive( Drive: char ): boolean; overload;
function IsLogicalDrive( Drive: string ): boolean; overload;
function IsNetworkDrivePresent( Drive: string ): boolean; overload;
function IsNetworkDrivePresent( Drive: char ): boolean; overload;
function PurgeFiles( const AFileMask : string; AOlderThan : Int64; AUseDays : boolean = True; AFailOnError : boolean = false ) : integer;
function IsFileInUse( fName: string ) : boolean;
function IsDirectoryWriteable( fName: string ) : boolean;
function FileSizeMByte( FileName : String ): Int64;
function FileSizeKByte( FileName : String ): Int64;
function FileSizeByte( FileName : String ): Int64;
function FileVersion( FileName : String; AsInt64: PInt64 = nil ): ShortString; overload;
function FileVersion( Stream: TStream; AsInt64: PInt64 = nil ): ShortString; overload;
function FileVersionRes( const ResourceName: string; AsInt64: PInt64 = nil ): ShortString; overload;
procedure OpenFolderInExplorer( strFolder: string );
function GetFileOwner( FileName: string; var Domain, Username: string ): Boolean;
function SetFileAccess( Path : string; SID : string = 'S-1-5-32-545'{Users}; Access : ACCESS_MODE = GRANT_ACCESS ) : boolean;

// Directorys
function CopyDir( const fromDir, toDir: string ): Boolean;
function MoveDir( const fromDir, toDir: string ): Boolean;
function DelDir( dir: string ): Boolean;
function EmptyDir( dir: string ): Boolean;
function GetDirSize( dir: string; subdir: Boolean ): Int64;

type
  TDelDirOnProgress = function( Current, Total : Cardinal ) : Boolean of object;
function DelDirDelphi( dir: string; vProcessMessages : boolean = false; OnProgress : TDelDirOnProgress = nil ): Boolean;

function StripLastDirectory( vPath : string ): string;
function ReturnLastDirectory( vPath : string ): string;
function GetSubDirectories( const directory : string; withoutSearchPath : boolean = false; recursive : Boolean = false; recursiveIterations : Word = 0 ): TStringList;
function GetParentDirectory( fFile : string ): string;
function IsDirectoryEmpty( const directory : string ) : boolean;
function GetApplicationDirectory: string;
function GetWinCommonAppDataDir: string;
function GetWinUserDir: string;
function GetAutoStartDir: string;
function GetWinAppDataDir: string;
function GetWinDir:string;
function GetProgramFilesDir:string;
function GetMyDocumentsDir: string;
function GetPublicDocumentDir: string;
function GetSharedFilesDir : string;
function GetDesktopDir : string;
function GetCommonDesktopDir : string;
function GetQuickLaunchDir : string;
function GetCommonQuickLaunchDir : string;
function GetStartMenuDir : string;
function GetStartMenuProgramDir : string;
function GetCommonStartmenuDir : string;
function GetCommonStartmenuProgramDir : string;

Function EnvironmentPath( FileName : string ): string;
function CreateShellLink( const TargetName: string; LinkPath : string = ''; LinkName : string = ''; WorkingDirectory : string = ''; Arguments : string = ''; Description : string = ''; IconFile : string = ''; IconID : Integer = 0 ): Boolean;

function GetFilesDropped (aHandle: THandle; aList: TStrings): Boolean;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
type
  TFileEnumerationProcedure = procedure( const Name: string );

procedure EnumerateFilesToProcedure( Directory: string; const Proc: TFileEnumerationProcedure; const mask: string = '*.*'; Recursive: Boolean = false );
procedure FileEnumerationSetReadOnly( const Name: string );
procedure FileEnumerationRemoveReadOnly( const Name: string );
procedure FileEnumerationSetHidden( const Name: string );
procedure FileEnumerationRemoveHidden( const Name: string );
procedure FileEnumerationSetSystem( const Name: string );
procedure FileEnumerationRemoveSystem( const Name: string );

procedure SetFileAttributeReadOnly( Directory: string; const mask: string = '*.*'; Recursive: Boolean = false );
procedure UnSetFileAttributeReadOnly( Directory: string; const mask: string = '*.*'; Recursive: Boolean = false );
procedure SetFileAttributeHidden( Directory: string; const mask: string = '*.*'; Recursive: Boolean = false );
procedure UnSetFileAttributeHidden( Directory: string; const mask: string = '*.*'; Recursive: Boolean = false );
procedure SetFileAttributeSystem( Directory: string; const mask: string = '*.*'; Recursive: Boolean = false );
procedure UnSetFileAttributeSystem( Directory: string; const mask: string = '*.*'; Recursive: Boolean = false );

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
const
  CSIDL_FLAG_CREATE = $8000;
  CSIDL_ADMINTOOLS = $30;
  CSIDL_ALTSTARTUP = $1D;
  CSIDL_APPDATA = $1A; // Anwendungsdaten
  CSIDL_BITBUCKET = $A;
  CSIDL_CDBURN_AREA = $3B; // CD Burning
  CSIDL_COMMON_ADMINTOOLS = $2F; // FE alle Benutzer ( All Users )
  CSIDL_COMMON_ALTSTARTUP = $1D;
  CSIDL_COMMON_APPDATA = $23;
  CSIDL_COMMON_DESKTOPDIRECTORY = $19; // Desktop
  CSIDL_COMMON_DOCUMENTS = $2E;
  CSIDL_COMMON_FAVORITES = $1F; // Favoriten
  CSIDL_COMMON_MUSIC = $35; // Gemeinsame Musik
  CSIDL_COMMON_PICTURES = $36; // Gemeinsame Bilder
  CSIDL_COMMON_PROGRAMS = $17; // Programme-Ordner im Startmenu
  CSIDL_COMMON_STARTMENU = $16; // Starmenu
  CSIDL_COMMON_STARTUP = $18; // Autostart
  CSIDL_COMMON_TEMPLATES = $2D; // Vorlagen
  CSIDL_COMMON_VIDEO = $37; // Gemeinsame Videos
  CSIDL_CONTROLS = $3;
  CSIDL_COOKIES = $21; // Cookies
  CSIDL_DESKTOP = $0; // Desktop
  CSIDL_DESKTOPDIRECTORY = $10;
  CSIDL_DRIVES = $11; // Treiber
  CSIDL_FAVORITES = $6; // Favoriten
  CSIDL_FONTS = $14; // Schriftarten
  CSIDL_HISTORY = $22; // Verlauf
  CSIDL_INTERNET = $1;
  CSIDL_INTERNET_CACHE = $20; // Temporäre Internetdateien
  CSIDL_LOCAL_APPDATA = $1C; // Anwendungsdaten
  CSIDL_MYDOCUMENTS = $C;
  CSIDL_MYMUSIC = $D; // Eigene Musik
  CSIDL_MYPICTURES = $27; // Eigene Bilder
  CSIDL_MYVIDEO = $E; // Eigene Videos
  CSIDL_NETHOOD = $13; // Netzwerkumgebung
  CSIDL_NETWORK = $12;
  CSIDL_PERSONAL = $5; // Eigene Dateien
  CSIDL_PRINTERS = $4;
  CSIDL_PRINTHOOD = $1B; // Druckerumgebung
  CSIDL_PROFILE = $28; // Profil
  CSIDL_PROGRAM_FILES = $26; // Programme
  CSIDL_PROGRAM_FILES_COMMON = $2B; // Gemeinsamme Dateien
  CSIDL_PROGRAMS = $2; // Programme ( im StartmenE
  CSIDL_RECENT = $8; // Zuletzt verwendete Dokumente
  CSIDL_SENDTO = $9; // Senden An
  CSIDL_STARTMENU = $B; // Startmenu
  CSIDL_STARTUP = $7; // Autostart
  CSIDL_SYSTEM = $25; // System ( bzw. System32 )
  CSIDL_SYSTEMX86 = $29; // System32
  CSIDL_TEMPLATES = $15; // Vorlagen
  CSIDL_WINDOWS = $24; // Windows
function GetShellFolder( CSIDLFolder : integer ) : string;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
type
  TFindFileEvent = procedure( fullpath : string; info : TSearchRec ) of object;
  TChangeFolderEvent = procedure( fullpath : string; info : TSearchRec ) of object;

  TFileSearch = class( TComponent )
  private
    { Private declarations }
    fRec : boolean;
    fStop : boolean;
    fSearching : boolean;
    fFilesFound : TStringList;
    fFileFindEvent : TFindFileEvent;
    fChangeFolderEvent : TChangeFolderEvent;
    fFinishEvent : TNotifyEvent;
    fdirName : shortstring;
  protected
    { Protected declarations }
    procedure ScanDir( fdirName:string;attr:word );
  public
    { Public declarations }
    constructor Create( aOwner:TComponent ); override;
    destructor Destroy; override;
    procedure Start;
    property Searching : boolean read fSearching;
  published
    { Published declarations }
    property Stop : boolean read fStop write fStop default false;
    property SearchFile : shortstring read fdirName write fdirName;
    property FilesFound : TStringList read fFilesFound;
    property RecurseSubFolders : boolean read fRec write fRec default true;
    property OnFileFind : TFindFileEvent read fFileFindEvent write fFileFindEvent;
    property OnChangeFolder : TChangeFolderEvent read fChangeFolderEvent write fChangeFolderEvent;
    property OnFinish : TNotifyEvent read fFinishEvent write fFinishEvent;
  end;

function FileSearch( Path, Ext : String; RecurseSubFolders : boolean = false ): TStringList; overload;
function FileSearch( Path, Ext : String; var StrL : TStringList; RecurseSubFolders : boolean = false ): boolean; overload;

{$IFEND TLH_IMPLEMENTATIONSECTION}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
{$IFNDEF TLH_OMIT_SECTIONS}
implementation

uses
  ShellAPI, Windows{SHFileOperations},
  ShlObj, StrUtils,
  Forms{FileSearch},
  AclApi{SetFileAccess},
  ComObj, ActiveX{CreateShellLink};
{$ENDIF TLH_OMIT_SECTIONS}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
{$IF NOT Defined( TLH_INTERFACESECTION ) AND NOT Defined( TLH_INITIALIZATIONSECTION ) AND NOT Defined( TLH_FINALIZATIONSECTION )}
function GetFileExtension( Str : String ): String;
begin
  result := RightStr( Str, Length( Str ) - Length( ChangeFileExt( str, '' ) ) - 1 );
end;

function RemoveFileExtension( Str : String ): String;
begin
  result := ChangeFileExt( str, '' );
//  result := GetTok( result ,1, NumTok( result, '.' )-1, '.' );
end;

function IsCharAllowedInPath( c : char ): boolean;
begin
  {$IF CompilerVersion >= 22}
  Result := NOT CharInSet( c, [ '\', '/', ':', '*', '?', '"', '<', '>', '|' ] );
  {$ELSE}
  Result := NOT ( c in [ '\', '/', ':', '*', '?', '"', '<', '>', '|' ] );
  {$IFEND}
end;

function IsValidFilePath( const FileName: String ): Boolean;
const
  INVALID_FILE_ATTRIBUTES = $ffffffff;
var
  S: String;
  I: Integer;
begin
  Result := False;
  S := FileName;
  repeat
    I := LastDelimiter( '\/', S );
    MoveFile( nil, PChar( S ) );
    if ( GetLastError = ERROR_ALREADY_EXISTS ) or ( ( GetFileAttributes( PChar( Copy( S, I + 1, MaxInt ) ) ) = INVALID_FILE_ATTRIBUTES ) and ( GetLastError=ERROR_INVALID_NAME ) ) then
      Exit;
    if I>0 then
      S := Copy( S,1,I-1 );
  until I = 0;
  Result := True;
end;

function IsLogicalDrive( Drive: string ): boolean;
var
  cDrive : Char;
begin
  result := false;
  if ( Drive = '' ) then
    Exit;

  cDrive := UpCase( ExtractFileDrive( Drive )[ 1 ] );
  if ( cDrive = '' ) then
    Exit;

  result := IsLogicalDrive( cDrive );
end;

function IsLogicalDrive( Drive: char ): boolean;
begin
  Result := False;
  Drive := UpCase( Drive );

  if Drive = '' then
    Exit;

  {$IF CompilerVersion >= 22}
  if CharInSet( UpCase( Drive ), [ 'A'..'Z' ] ) then
  {$ELSE}
  if ( UpCase( Drive ) in [ 'A'..'Z' ] ) then
  {$IFEND}
    result := ( ( GetLogicalDrives And ( 1 Shl ( Ord( Drive ) - Ord( 'A' ) ) ) ) = 0 );
end;

function IsNetworkDrivePresent( Drive: string ): boolean;
begin
  result := false;
  if ( Drive = '' ) then
    Exit;

  result := IsNetworkDrivePresent( UpCase( Drive[ 1 ] ) );
end;

function IsNetworkDrivePresent( Drive: char ): boolean;
begin
  result := false;
  if ( Drive = '' ) then
    Exit;
  result := DiskSize( ord( Drive )-$40 ) <> -1;
end;

function PurgeFiles( const AFileMask : string; AOlderThan : Int64; AUseDays : boolean = True; AFailOnError : boolean = false ) : integer;
  function DateTimeToMilliseconds( aDateTime: TDateTime ): Int64;
  var
    TimeStamp: TTimeStamp;
  begin
    TimeStamp := DateTimeToTimeStamp ( aDateTime );
    Result := Int64( TimeStamp.Date ) * MSecsPerDay + TimeStamp.Time;
  end;

  function MillisecondsBetween( const anow, athen: TDateTime ): Int64;
  begin
    if anow > athen then
      Result := DateTimeToMilliseconds( anow ) - DateTimeToMilliseconds( athen )
    else
      Result := DateTimeToMilliseconds( athen ) - DateTimeToMilliseconds( anow );
  end;
var
  rDirInfo   : TSearchRec;
  iError     : boolean;
  dtNow      : TDateTime;
  sFilePath  : string;
begin
  Result    := 0;
  sFilePath := ExtractFilePath( AFileMask );
  iError    := NOT ( FindFirst( AFileMask, faAnyFile, rDirInfo ) = 0 );
  if AUseDays then
    dtNow   := Date
  else
    dtNow   := NOW;

  while ( NOT iError ) do
    begin
    // Exclude Directories
    if ( rDirInfo.Name <> '.' ) and ( rDirInfo.Name <> '..' ) and ( rDirInfo.Attr and faDirectory <> faDirectory ) then
      begin
      {$IF CompilerVersion >= 22}
      if ( ( NOT AUseDays ) AND ( MillisecondsBetween( dtNow, rDirInfo.TimeStamp ) > AOlderThan ) ) or ( Trunc( dtNow - rDirInfo.TimeStamp ) + 1 > AOlderThan ) then
      {$ELSE}
      if ( ( NOT AUseDays ) AND ( MillisecondsBetween( dtNow, FileDateToDateTime( rDirInfo.Time ) ) > AOlderThan ) ) or ( Trunc( dtNow - FileDateToDateTime( rDirInfo.Time ) ) + 1 > AOlderThan ) then
      {$IFEND}
        begin
        // Delete the file - raise exception if fail and AFailOnError set
        if ( not DeleteFile( PChar( sFilePath + rDirInfo.Name ) ) ) and AFailOnError then
          begin
          raise Exception.Create( 'PurgFiles( ) Failed on file' + #13#10 +
                                  sFilePath + rDirInfo.Name + #13#10#13#10 +
                                  SysErrorMessage( GetLastError )
                                );
          end;
        inc( Result );
        end;
      end;

    iError := ( FindNext( rDirInfo ) <> 0 );
    if iError then
      Windows.FindClose( rDirInfo.FindHandle );
    end;
end;

function IsFileInUse( fName: string ) : boolean;
var
  HFileRes: HFILE;
begin
  Result := False;
  if not FileExists( fName ) then
    Exit;
  try
    HFileRes := CreateFile( PChar( fName ),GENERIC_READ or GENERIC_WRITE, 0, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0 );
  except
    HFileRes := INVALID_HANDLE_VALUE;  
  end;
  Result := ( HFileRes = INVALID_HANDLE_VALUE );
  if not( Result ) then
    CloseHandle( HFileRes );
end;

function IsDirectoryWriteable( fName: string ) : boolean;
var
  TempFileName: array[ 0..MAX_PATH ] of Char;
begin
  Result := ( GetTempFileName( PChar( IncludeTrailingBackslash( fName ) ), '$', 0, TempFileName ) <> 0 );
  if Result then
    Result := DeleteFile( TempFileName );
end;

function FileSizeMByte( FileName : String ): Int64;
begin
  result := FileSizeKByte( FileName ) div 1024;
end;

function FileSizeKByte( FileName : String ): Int64;
begin
  result := FileSizeByte( FileName ) div 1024;
end;

function FileSizeByte( fileName : string ) : Int64;
var
 sr : TSearchRec;
begin
  result := -1;
  if ( FindFirst( fileName, faAnyFile, sr ) = 0 ) then
    result := Int64( sr.FindData.nFileSizeHigh ) shl Int64( 32 ) + Int64( sr.FindData.nFileSizeLow );
  Windows.FindClose( sr.FindHandle );
end;

function FileVersion( FileName : string; AsInt64: PInt64 = nil ): ShortString;
type
  TVerTranslation = record
    Language : Word;
    CharSet  : Word;
  end;
  PVerTranslation = ^TVerTranslation;
var
  len, hnd : Cardinal;
  buf      : string;
  pfi      : PVsFixedFileInfo;
  Version  : Int64;

  Handle  : Cardinal;
  Res     : Boolean;
  Size    : Integer;
  Data    : Pointer;
  Buffer  : Pointer;
  {$IFDEF VER110} // D4
  Bytes   : Integer;
  {$ELSE}
  Bytes   : UINT;
  {$ENDIF}
  TempStr : Array[ 0..259 ] of Char;
  BaseStr : String;
  InfoStr : String;
  Trans   : PVerTranslation;
  TrSize  : Integer;
begin
  Version := 0;
  len := GetFileVersionInfoSize( PChar( FileName ), hnd );
  if len <> 0 then
    begin
    SetLength( buf, len );
    if GetFileVersionInfo( PChar( FileName ), hnd, len, pointer( buf ) ) and VerQueryValue( Pointer( buf ), '\', Pointer( pfi ), len ) then
      Version := int64( pfi^.dwFileVersionMS ) shl 32 + int64( pfi^.dwFileVersionLS );
    end;

  if ( Version <> 0 ) then
    result := IntToStr(   Version shr 48            ) + '.' +
              IntToStr( ( Version shr 32 ) and $FFFF ) + '.' +
              IntToStr( ( Version shr 16 ) and $FFFF ) + '.' +
              IntToStr(   Version          and $FFFF )
  else
    begin
    result := '0.0.0.0';

    Size := GetFileVersionInfoSize( StrPCopy( TempStr, FileName ), Handle );
    if Size = 0 then
      Exit;

    { Allocate some memory and get version info block. }
    GetMem( Data, Size );
    Res := GetFileVersionInfo( TempStr, Handle, Size, Data );
    if not Res then
      Exit;

    { Get the translation value. We need it to get the version info. }
    Res := VerQueryValue(  Data, '\VarFileInfo\Translation', Buffer, Bytes );
    if not Res then
      Exit;

    TrSize := Bytes;
    try
      GetMem( Trans, TrSize );
      Move( Buffer^, Trans^, TrSize );
    except
      FreeMem( Data, Size );
      Exit;
    end;

    { Build a base string including the translation value. }
    BaseStr := Format( 'StringFileInfo\%.4x%.4x\', [ Trans^.Language, Trans^.CharSet ] );

    { FileVersion }
    InfoStr := BaseStr + 'FileVersion';
    Res := VerQueryValue( Data, StrPCopy( TempStr, InfoStr ), Buffer, Bytes );
    if Res and ( Bytes <> 0 ) then
      begin
      result := StrPas( PChar( Buffer ) );
      Exit;
      end;

    { ProductVersion }
    InfoStr := BaseStr + 'ProductVersion';
    Res := VerQueryValue( Data, StrPCopy( TempStr, InfoStr ), Buffer, Bytes );
    if Res and ( Bytes <> 0 ) then
      result := StrPas( PChar( Buffer ) );

    FreeMem( Data, Size );
    FreeMem( Trans, TrSize );

    Version := Variant( result );
    end;

  if Assigned( AsInt64 ) then
    AsInt64^ := Version;
end;

function FileVersion( Stream: TStream; AsInt64: PInt64 = nil ): ShortString;
const
  VS_VERSION_INFO: WideString = 'VS_VERSION_INFO';
  Signature = $FEEF04BD;
var
  WS: WideString;
  PVerValue: PVSFixedFileInfo;
  i: Integer;
begin
  Result := '';
  if Assigned( AsInt64 ) then
    AsInt64^ := 0;
  Stream.Position := 0;
  i := Stream.Size - Stream.Position;
  SetLength( WS, i div 2 + 1 );
  Stream.ReadBuffer( WS[ {$IF CompilerVersion >= 24}Low( WS ){$ELSE}1{$IFEND} ], i );
  i := Pos( VS_VERSION_INFO, WS );
  PVerValue := PVSFixedFileInfo( @WS[ i + Length( VS_VERSION_INFO ) + 2 ] );
  if ( i >= {$IF CompilerVersion >= 24}Low( WS ){$ELSE}1{$IFEND} ) and ( PVerValue^.dwSignature = Signature ) then
    begin
    with PVerValue^ do
      begin
      Result := Format( '%d.%d.%d.%d', [ HiWord( dwFileVersionMS ), // Major
        LoWord( dwFileVersionMS ), // Minor
        HiWord( dwFileVersionLS ), // Release
        LoWord( dwFileVersionLS ) ] ); // Build
      if Assigned( AsInt64 ) then
        AsInt64^ := Int64( dwFileVersionMS ) shl 32 or dwFileVersionLS;
      end;
    end;
end;

function FileVersionRes( const ResourceName: string; AsInt64: PInt64 = nil ): Shortstring;
var
  RS: TResourceStream;
begin
  result := '';
  if ( FindResource( hInstance, PChar( ResourceName ), RT_RCDATA ) = 0 ) then
    Exit;

  RS := TResourceStream.Create( HInstance, ResourceName, RT_RCDATA );
  try
    Result := FileVersion( RS, AsInt64 );
  finally
    RS.Free;
  end;
end;

procedure OpenFolderInExplorer( strFolder: string );
begin
  ShellExecute( Application.Handle, PChar( 'explore' ), PChar( strFolder ), nil, nil, SW_SHOWNORMAL );
end;

{$IF CompilerVersion < 22}
function ConvertStringSidToSid( StringSid: PWideChar; var Sid: PSID ): Boolean; stdcall; external 'advapi32.dll' name 'ConvertStringSidToSidW'; overload;
function ConvertStringSidToSid( StringSid: PAnsiChar; var Sid: PSID ): Boolean; stdcall; external 'advapi32.dll' name 'ConvertStringSidToSidA'; overload;
{$IFEND}

function GetFileOwner( FileName: string; var Domain, Username: string ): Boolean;
var
  SecDescr: PSecurityDescriptor;
  SizeNeeded, SizeNeeded2: Cardinal;
  OwnerSID: PSID;
  OwnerDefault: BOOL;
  OwnerName, DomainName: PChar;
  OwnerType: SID_NAME_USE;
begin
  result := False;
  GetMem( SecDescr, 1024 );
  GetMem( OwnerSID, SizeOf( PSID ) );
  GetMem( OwnerName, 1024 );
  GetMem( DomainName, 1024 );
  try
    if not GetFileSecurity( PChar( FileName ), OWNER_SECURITY_INFORMATION, SecDescr, 1024, SizeNeeded ) then
      Exit;
    if not GetSecurityDescriptorOwner( SecDescr, OwnerSID, OwnerDefault ) then
      Exit;
    SizeNeeded  := 1024;
    SizeNeeded2 := 1024;
    if not LookupAccountSID( nil, OwnerSID, OwnerName, SizeNeeded, DomainName, SizeNeeded2, OwnerType ) then
      Exit;
    Domain   := DomainName;
    Username := OwnerName;
  finally
    FreeMem( SecDescr );
    FreeMem( OwnerName );
    FreeMem( DomainName );
  end;
  result := True;
end;

function SetFileAccess( Path : string; SID : string = 'S-1-5-32-545'{Users}; Access : ACCESS_MODE = GRANT_ACCESS ) : boolean;
var
  pSD : PSECURITY_DESCRIPTOR;
  NewDacl, OldDacl: PACl;
  EA: {array [ 0..5 ] of} EXPLICIT_ACCESS;
  res : Cardinal;
  bsid : PSID;
begin
  result := False;
  if NOT FileExists( Path ) and NOT {$IF CompilerVersion >= 22}SysUtils.{$IFEND}DirectoryExists( Path ) then
    Exit;

  {$IF CompilerVersion >= 32}
  res := GetNamedSecurityInfo( PChar( Path ), SE_FILE_OBJECT, DACL_SECURITY_INFORMATION, nil, nil, @OldDacl, nil, @pSD );
  {$ELSE}
  res := GetNamedSecurityInfo( PChar( Path ), SE_FILE_OBJECT, DACL_SECURITY_INFORMATION, nil, nil, @OldDacl, nil, pSD );
  {$IFEND}
  if ( res <> ERROR_SUCCESS ) then
    Exit;

  ConvertStringSidToSid( PChar( SID ), bsid );
  BuildTrusteeWithSid( @EA.Trustee, bsid );
  EA.grfAccessPermissions := GENERIC_ALL;
  EA.grfAccessMode        := Access;
  EA.grfInheritance       := SUB_CONTAINERS_AND_OBJECTS_INHERIT;
  EA.Trustee.TrusteeForm  := TRUSTEE_IS_SID;
  EA.Trustee.TrusteeType  := TRUSTEE_IS_USER;

//  BuildExplicitAccessWithName( @EA, PChar( 'Users' ), GENERIC_ALL, ACCESS, SUB_CONTAINERS_AND_OBJECTS_INHERIT );
  res := SetEntriesInAcl( 1, @EA, OldDacl, NewDacl );
  if ( res <> ERROR_SUCCESS ) then
    begin
    LocalFree( Cardinal( pSD ) );
    Exit;
    end;
  res := SetNamedSecurityInfo( PChar( Path ), SE_FILE_OBJECT, DACL_SECURITY_INFORMATION, nil, nil, NewDacl, nil );
  LocalFree( Cardinal( NewDacl ) );
  LocalFree( Cardinal( pSD ) );
  result := res = ERROR_SUCCESS;
end;

// SHFileOperations
// http://msdn.microsoft.com/ja-jp/library/windows/desktop/bb762164%28v=vs.85%29.aspx
function CopyDir( const fromDir, toDir: string ): Boolean;
var
  fos: TSHFileOpStruct;
begin
  ZeroMemory( @fos, SizeOf( fos ) );
  with fos do
  begin
    wFunc  := FO_COPY;
//    fFlags := FOF_FILESONLY OR FOF_NOCONFIRMATION;
    fFlags := FOF_SILENT or FOF_NOERRORUI or FOF_NOCONFIRMATION;
    pFrom  := PChar( ExcludeTrailingBackslash( fromdir ) + #0 );
    pTo    := PChar( toDir )
  end;
  Result := ( 0 = ShFileOperation( fos ) );
end;

function MoveDir( const fromDir, toDir: string ): Boolean;
var
  fos: TSHFileOpStruct;
begin
  ZeroMemory( @fos, SizeOf( fos ) );
  with fos do
  begin
    wFunc  := FO_MOVE;
    fFlags := FOF_FILESONLY;
    pFrom  := PChar( ExcludeTrailingBackslash( fromdir ) + #0 );
    pTo    := PChar( toDir )
  end;
  Result := ( 0 = ShFileOperation( fos ) );
end;

function DelDir( dir: string ): Boolean;
var
  fos: TSHFileOpStruct;
begin
  result := false;
  if NOT {$IF CompilerVersion >= 22}SysUtils.{$IFEND}DirectoryExists( dir ) then
    Exit;
  ZeroMemory( @fos, SizeOf( fos ) );
  with fos do
  begin
    wFunc  := FO_DELETE;
    fFlags := FOF_SILENT or FOF_NOERRORUI or FOF_NOCONFIRMATION;
    pFrom  := PChar( ExcludeTrailingBackslash( dir ) + #0 );
  end;
  Result := ( 0 = ShFileOperation( fos ) );
end;

function DelDirDelphi( dir: string; vProcessMessages : boolean = false; OnProgress : TDelDirOnProgress = nil ): Boolean;
var
  Files : TStringList;
  i : integer;
  IsCalledInMainThread : Boolean;
begin
  result := false;
  if NOT {$IF CompilerVersion >= 22}SysUtils.{$IFEND}DirectoryExists( dir ) then
    Exit;

  IsCalledInMainThread := GetCurrentThreadId = MainThreadID;

  Files := TStringList.Create;
  Files.Assign( FileSearch( IncludeTrailingBackslash( dir ), '*', True ) );
  for i := 0 to Files.Count-1 do
    begin
    if {$IF CompilerVersion >= 22}SysUtils.{$IFEND}DirectoryExists( Files[ i ] ) then
      Continue;
    if FileExists( Files[ i ] ) then
      DeleteFile( PChar( Files[ i ] ) );

    if Assigned( OnProgress ) then
      begin
      if NOT OnProgress( i+1, Files.Count ) then
        begin
        Files.Free;
        Exit;
        end;
      end;

    if IsCalledInMainThread AND vProcessMessages then
      Application.ProcessMessages;
    end;

  for i := Files.Count-1 downTo 0 do
    begin
    if NOT {$IF CompilerVersion >= 22}SysUtils.{$IFEND}DirectoryExists( Files[ i ] ) then
      Continue;
    if {$IF CompilerVersion >= 22}SysUtils.{$IFEND}DirectoryExists( Files[ i ] ) then
      RemoveDir( Files[ i ] );

    if IsCalledInMainThread AND vProcessMessages then
      Application.ProcessMessages;
    end;

  Files.free;
  result := RemoveDir( dir );
end;

function EmptyDir( dir: string ): Boolean;
var
  Files : TStringList;
  i : integer;
begin
  result := false;
  if NOT {$IF CompilerVersion >= 22}SysUtils.{$IFEND}DirectoryExists( dir ) then
    Exit;
  Files := TStringList.Create;
  Files.Assign( FileSearch( IncludeTrailingBackslash( dir ), '*' ) );
  for i := 0 to Files.Count-1 do
    begin
    if FileExists( Files[ i ] ) then
      DeleteFile( PChar( Files[ i ] ) );
    end;
  Files.free;
  result := true;
end;

function GetDirSize( dir: string; subdir: Boolean ): Int64;
var
  rec: TSearchRec;
  found: Integer;
begin
  Result := 0;
  if dir[ Length( dir ) ] <> '\' then
    dir := dir + '\';
  found := FindFirst( dir + '*.*', faAnyFile, rec );
  while found = 0 do
    begin
    Inc( Result, rec.Size );
    if ( rec.Attr and faDirectory > 0 ) and ( rec.Name[ 1 ] <> '.' ) and ( subdir = True ) then
      Inc( Result, GetDirSize( dir + rec.Name, True ) );
    found := FindNext( rec );
    end;
  SysUtils.FindClose( rec );
end;

function GetSubDirectories( const directory : string; withoutSearchPath : boolean = false; recursive : Boolean = false; recursiveIterations : Word = 0 ): TStringList;
  procedure GetSubDirs_( const sRootDir: string; slt: TStrings; CallID : Cardinal = 0 );
  var
    srSearch: TSearchRec;
    sSearchPath: string;
    sltSub: TStrings;
    i: Integer;
  begin
    sltSub := TStringList.Create;
    slt.BeginUpdate;
    try
      sSearchPath := IncludeTrailingPathDelimiter( sRootDir );
      if FindFirst( sSearchPath + '*', faDirectory, srSearch ) = 0 then
        repeat
          if ( ( srSearch.Attr and faDirectory ) = faDirectory ) and
            ( srSearch.Name <> '.' ) and
            ( srSearch.Name <> '..' ) then
          begin
            slt.Add( sSearchPath + srSearch.Name );
            sltSub.Add( sSearchPath + srSearch.Name );
          end;
        until ( FindNext( srSearch ) <> 0 );

      SysUtils.FindClose( srSearch );

      if recursive and ( CallID < recursiveIterations ) then
        begin
        for i := 0 to sltSub.Count - 1 do
          GetSubDirs_( sltSub.Strings[ i ], slt, CallID+1 );
        end;
    finally
      slt.EndUpdate;
      FreeAndNil( sltSub );
    end;
  end;
var
  i  : Integer;
begin
  Result := TStringList.Create;
  GetSubDirs_( directory, result );
  if ( result.Count > 0 ) AND withoutSearchPath then
    begin
    for i := 0 to result.Count-1 do
      result[ i ] := RightStr( result[ i ], Length( result[ i ] )-Length( directory ) );
    end;
end;

function StripLastDirectory( vPath : string ): string;
var
  nT : integer;
begin
  result := vPath;

  vPath := ExcludeTrailingBackslash( vPath );
  nT := 0;
  while ( PosEx( '\', vPath, nT+1 ) <> 0 ) do
    nT := PosEx( '\', vPath, nT+1 );

  if ( nT < 4 ) then
    Exit;

  result := LeftStr( vPath, nT );

//  nT := NumTok( vPath, '\' );
//  if ( vPath = '' ) OR ( nT < 2 ) then
//    Exit;
//  result := IncludeTrailingBackslash( GetTok( vPath, 1, nT-1, '\' ) );
end;

function ReturnLastDirectory( vPath : string ): string;
var
  nT : Integer;
begin
  result := vPath;
  vPath := ExcludeTrailingBackslash( vPath );

  nT := 0;
  while ( PosEx( '\', vPath, nT+1 ) <> 0 ) do
    nT := PosEx( '\', vPath, nT+1 );

  if ( nT = 0 ) then
    Exit;

  result := RightStr( vPath, Length( vPath )-nT );

//  nT := NumTok( vPath, '\' );
//  if ( vPath = '' ) OR ( nT < 2 ) then
//    Exit;
//
//  result := GetTok( vPath, nT, nT, '\' );
end;

function GetParentDirectory( fFile : string ): string;
begin
  if ( fFile = '' ) then
    Exit;

  result := ExpandFileName( fFile + '\..' )
end;

function IsDirectoryEmpty( const directory : string ) : boolean;
var
  searchRec : TSearchRec;
begin
  result := false;
  if ( directory = '' ) then
    Exit;
  try
   result := ( FindFirst( directory+'\*.*', faAnyFile, searchRec ) = 0 ) AND ( FindNext( searchRec ) = 0 ) AND ( FindNext( searchRec ) <> 0 );
  finally
    SysUtils.FindClose( searchRec );
  end;
end;

function GetApplicationDirectory: string;
begin
  Result := ExtractFilePath( ParamStr( 0 ) );
end;

function GetWinCommonAppDataDir: string;
begin
  Result := GetShellFolder( CSIDL_COMMON_APPDATA {.$23} );
end;

function GetWinUserDir: string;
begin
  result := GetShellFolder( CSIDL_PROFILE );
end;

function GetAutoStartDir: string;
begin
  result := GetShellFolder( CSIDL_STARTUP );
end;

function GetWinAppDataDir: string;
begin
  Result := GetShellFolder( CSIDL_APPDATA {.$1A} );
end;

function GetProgramFilesDir: string;
begin
  result := GetShellFolder( CSIDL_PROGRAM_FILES {.$26} );
end;

function GetMyDocumentsDir: string;
begin
  result := GetShellFolder( CSIDL_PERSONAL );
end;

function GetPublicDocumentDir: string;
begin
  Result := GetSHellFolder( CSIDL_COMMON_DOCUMENTS {46} );
end;

function GetSharedFilesDir : string;
begin
  result := GetShellFolder( CSIDL_PROGRAM_FILES_COMMON {.$2B} );
end;

function GetDesktopDir : string;
begin
  result := GetShellFolder( CSIDL_DESKTOP {.$0} );
end;

function GetCommonDesktopDir : string;
begin
  result := GetShellFolder( CSIDL_COMMON_DESKTOPDIRECTORY );
end;

function GetQuickLaunchDir : string;
const
  NewPath = 'User Pinned\TaskBar\';
begin
  result := GetShellFolder( CSIDL_APPDATA ) + 'Microsoft\Internet Explorer\Quick Launch\';
  if {$IF CompilerVersion >= 22}SysUtils.{$IFEND}DirectoryExists( result + NewPath ) then
    result := result + NewPath;
end;

function GetCommonQuickLaunchDir : string;
const
  NewPath = 'User Pinned\TaskBar\';
begin
  result := GetShellFolder( CSIDL_COMMON_APPDATA ) + 'Microsoft\Internet Explorer\Quick Launch\';
  if {$IF CompilerVersion >= 22}SysUtils.{$IFEND}DirectoryExists( result + NewPath ) then
    result := result + NewPath;
end;

function GetStartMenuDir : string;
begin
  result := GetShellFolder( CSIDL_STARTMENU );
end;

function GetStartMenuProgramDir : string;
begin
  result := GetShellFolder( CSIDL_PROGRAMS );
end;

function GetCommonStartmenuDir : string;
begin
  result := GetShellFolder( CSIDL_COMMON_STARTMENU );
end;

function GetCommonStartmenuProgramDir : string;
begin
  result := GetShellFolder( CSIDL_COMMON_PROGRAMS );
end;

function GetWinDir: string;
begin
  Result := IncludeTrailingPathDelimiter( GetEnvironmentVariable( 'WinDir' ) );
end;

function GetShellFolder( CSIDLFolder : integer ) : string;
// http://msdn.microsoft.com/en-us/library/windows/desktop/bb762494%28v=vs.85%29.aspx
const
  MAX_PATH = 255;
begin
  SetLength( Result, MAX_PATH );
  SHGetSpecialFolderPath( 0, PChar( Result ), CSIDLFolder, false );
  SetLength( Result, StrLen( PChar( Result ) ) );
  if ( Result <> '' ) then
    Result := IncludeTrailingBackslash( Result );
end;

function EnvironmentPath( Filename: string ): string;
var
  Cnt     : Cardinal;
  PathStr : PChar;
begin
  Cnt := SearchPath( nil, PChar( Filename ), nil, 0, nil, PathStr );
  if ( Cnt = 0 ) then
    Exit;
  SetLength( result, Cnt-1 );
  if ( SearchPath( nil, PChar( Filename ), nil, Cnt, PChar( result ), PathStr ) > 0 ) then
    result := ExtractFilePath( result )
  else
    result := '';
end;

function CreateShellLink( const TargetName: string; LinkPath : string = ''; LinkName : string = ''; WorkingDirectory : string = ''; Arguments : string = ''; Description : string = ''; IconFile : string = ''; IconID : Integer = 0 ): Boolean;
var
  IObject   : IUnknown;
  ISLink    : IShellLink;
  IPFile    : IPersistFile;
  wLinkName : WideString;
begin
  Result := False;

//  if NOT FileExists( TargetName ) AND NOT DirectoryExists( TargetName ) then
//    Exit;

  if ( LinkPath = '' ) then
    LinkPath := GetDesktopDir;
  LinkPath := IncludeTrailingBackslash( LinkPath );

  if ( LinkName = '' ) then
    LinkName := ChangeFileExt( ExtractFileName( TargetName ), '.lnk' );

  if ( LowerCase( ExtractFileExt( LinkName ) ) <> '.lnk' ) then
    LinkName := LinkName + '.lnk';

  if ( WorkingDirectory = '' ) then
    WorkingDirectory := ExtractFilePath( TargetName );

  if NOT {$IF CompilerVersion >= 22}SysUtils.{$IFEND}DirectoryExists( LinkPath ) then
    Exit;

  wLinkName := LinkPath + LinkName;
  IObject := CreateComObject( CLSID_ShellLink );
  ISLink  := IObject as IShellLink;
  IPFile  := IObject as IPersistFile;

  if FileExists( wLinkName ) then
    IPFile.Load( PWideChar( wLinkName ), 0 );

  // Set
  ISLink.SetPath( PChar( TargetName ) );
  ISLink.SetWorkingDirectory( PChar( WorkingDirectory ) );

  ISLink.SetDescription( PChar( Description ) );
  ISLink.SetArguments( PChar( Arguments ) );
  if ( IconFile <> '' ) AND FileExists( IconFile ) then
    ISLink.SetIconLocation( PChar( IconFile ), IconID );

  if IPFile.Save( PWideChar( wLinkName ), False ) = S_OK then
    Result := True;

  IObject := nil;
end;

function GetFilesDropped (aHandle: THandle; aList: TStrings): Boolean;
var
  FileCount : Integer;
  Index : Integer;
  Buffer : array [0..MAX_PATH] of Char;
begin
  FileCount := DragQueryFile( aHandle, Cardinal(-1), nil, 0 );
  aList.BeginUpdate;
  try
    for Index := 0 to FileCount - 1 do
      begin
      DragQueryFile( aHandle, Index, @Buffer, SizeOf( Buffer ) );
      aList.Add( Buffer );
      end;
  finally
    aList.EndUpdate;
  end;
  Result := (FileCount > 0);
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure EnumerateFilesToProcedure( Directory: string; const Proc: TFileEnumerationProcedure; const mask: string = '*.*'; Recursive: Boolean = false );
const
  faNewAnyFileEx = $00017FFF;
var
  Rec: TSearchRec;
begin
  if ( Mask = '' ) then
    begin
    Proc( Directory );
    Exit;
    end;

  Directory := IncludeTrailingPathDelimiter( Directory );
  if ( FindFirst( Directory + mask, faNewAnyFileEx, Rec ) = 0 ) then
    try
      repeat
        if ( Rec.Name = '.' ) OR ( Rec.Name = '..' ) then
          Continue;

        if ( ( Rec.Attr and faDirectory ) = faDirectory ) then
          begin
          Proc( Directory + Rec.Name );
          if Recursive then
            EnumerateFilesToProcedure( Directory + Rec.Name, Proc, mask, Recursive );
          end
        else
          Proc( Directory + Rec.Name );
      until ( FindNext( Rec ) <> 0 );
    finally
      SysUtils.FindClose( Rec );
    end;
end;

// ~~
procedure FileEnumerationSetReadOnly( const Name: string );
begin
  SetFileAttributes( PChar( Name ), GetFileAttributes( PChar( Name ) ) OR FILE_ATTRIBUTE_READONLY );
end;
procedure FileEnumerationRemoveReadOnly( const Name: string );
begin
  SetFileAttributes( PChar( Name ), GetFileAttributes( PChar( Name ) ) AND ( NOT FILE_ATTRIBUTE_READONLY ) );
end;

procedure FileEnumerationSetHidden( const Name: string );
begin
  SetFileAttributes( PChar( Name ), GetFileAttributes( PChar( Name ) ) OR FILE_ATTRIBUTE_HIDDEN );
end;
procedure FileEnumerationRemoveHidden( const Name: string );
begin
  SetFileAttributes( PChar( Name ), GetFileAttributes( PChar( Name ) ) AND ( NOT FILE_ATTRIBUTE_HIDDEN ) );
end;

procedure FileEnumerationSetSystem( const Name: string );
begin
  SetFileAttributes( PChar( Name ), GetFileAttributes( PChar( Name ) ) OR FILE_ATTRIBUTE_SYSTEM );
end;
procedure FileEnumerationRemoveSystem( const Name: string );
begin
  SetFileAttributes( PChar( Name ), GetFileAttributes( PChar( Name ) ) AND ( NOT FILE_ATTRIBUTE_SYSTEM ) );
end;

// ~~
procedure SetFileAttributeReadOnly( Directory: string; const mask: string = '*.*'; Recursive: Boolean = false );
begin
  EnumerateFilesToProcedure( Directory, FileEnumerationSetReadOnly, mask, Recursive );
end;

procedure UnSetFileAttributeReadOnly( Directory: string; const mask: string = '*.*'; Recursive: Boolean = false );
begin
  EnumerateFilesToProcedure( Directory, FileEnumerationRemoveReadOnly, mask, Recursive );
end;

procedure SetFileAttributeHidden( Directory: string; const mask: string = '*.*'; Recursive: Boolean = false );
begin
  EnumerateFilesToProcedure( Directory, FileEnumerationSetHidden, mask, Recursive );
end;

procedure UnSetFileAttributeHidden( Directory: string; const mask: string = '*.*'; Recursive: Boolean = false );
begin
  EnumerateFilesToProcedure( Directory, FileEnumerationRemoveHidden, mask, Recursive );
end;

procedure SetFileAttributeSystem( Directory: string; const mask: string = '*.*'; Recursive: Boolean = false );
begin
  EnumerateFilesToProcedure( Directory, FileEnumerationSetSystem, mask, Recursive );
end;

procedure UnSetFileAttributeSystem( Directory: string; const mask: string = '*.*'; Recursive: Boolean = false );
begin
  EnumerateFilesToProcedure( Directory, FileEnumerationRemoveSystem, mask, Recursive );
end;


// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
constructor TFileSearch.Create( aOwner:TComponent );
begin
      inherited create( aOwner );

      fFilesFound := TStringList.Create;     // drh 4/6/98: Create results list
      fRec := true;
      fSearching := false;                   // drh 4/6/98: Initialise "Searching" flag
      fStop := false;
end;

// drh 4/6/98: Added destructor handler
destructor TFileSearch.Destroy;
begin
     fFilesFound.Free;
     inherited Destroy;
end;

procedure TFileSearch.Start;
var
   i, newWildCard : Integer;
   curSearchPath, wildCards : String;
   srchPaths : TStringList;
begin
  fStop := false;

  fSearching := True;   // drh 4/6/98: flag to indicate we are searching
  fFilesFound.Clear;    // drh 4/6/98: new search, so no files should be listed

  // Look for ";" wildcard seperators.
  // loop through replacing the "filename" with each wildcard...
  newWildCard := Pos( ';', fDirName );

  if newWildCard > 0 then
    begin
    curSearchPath := Copy( fdirName, 1, newWildCard-1 );
    wildCards := Copy( fdirName, newWildCard+1, length( fDirName ) );

    srchPaths := TStringList.Create;
    srchPaths.Add( curSearchPath );

    // Build up a list of search paths by looping through each wildcard
    while length( wildCards ) > 0 do
      begin
      curSearchPath := ExtractFilePath( curSearchPath );
      newWildCard := Pos( ';', wildCards );

      if newWildCard > 0 then
        begin
        curSearchPath := curSearchPath + Copy( wildCards, 1, newWildCard-1 );
        wildCards := Copy( wildCards, newWildCard+1, length( wildCards ) );
        end
      else
        begin
        curSearchPath := curSearchPath + wildCards;
        wildCards := '';
        end;

       srchPaths.Add( curSearchPath );
      end;

    // Well, we got the paths, lets start searching them shall we?
    for i := 0 to srchPaths.Count - 1 do
      ScanDir( srchPaths.Strings[ i ], faAnyFile );

    // get rid of search paths.
    srchPaths.Free;
    end
  else // no other wildcards to search, just a single file def
    ScanDir( fdirName, faAnyFile );

  // drh 4/6/98:
  // the following was moved here from end of "ScanDir", just in
  // case multiple searches are being carried out ( dont want
  // multiple end of search events being fired ).
  if Assigned( fFinishEvent ) then
    fFinishEvent( Self );         // notify user that searching is complete.

  fSearching := False; // drh 4/6/98: flag indicates we arnt searching any more
end;

procedure TFileSearch.ScanDir( fdirName:string; attr:word );
const
  fi : string = '*.*';
  p : string = '.';
  pp : string = '..' ;
var
  Synchronized : Boolean;
  path : string;
  doserror : integer;
  sfi : string;

  procedure showq( fullpath:string; FolderInfo:TSearchRec );
  var
    dirq : TSearchRec;
  begin
    if assigned( fChangeFolderEvent ) then
      fChangeFolderEvent( fullpath,FolderInfo );

    doserror := findfirst( fullpath+sfi,attr,dirq );
    while ( doserror = 0 )and( not fstop ) do
      begin
      if ( dirq.name<>p ) and ( dirq.name<>pp ) then
        begin
        if ( assigned( fFileFindEvent ) ) then
          fFileFindEvent( fullpath, dirq );
        fFilesFound.Add( fullpath + dirq.Name ); // drh 4/6/98: Add filename to list of those found thus far
        end;
      doserror := findnext( dirq );
      if Synchronized then
        Application.processMessages;
      end;
    SysUtils.FindClose( dirq );
  end; // showq

  procedure ScanLDir( fdirName:string; fInfo:TSearchRec );
  var
    dirinfo : TSearchRec;
  begin
    showq( fDirName, fInfo );
    dosError := FindFirst( fDirName+fi, faAnyfile, dirInfo );

    while ( doserror = 0 ) and ( not fstop ) do
      begin
      if Synchronized then
        Application.processMessages;

      if ( dirInfo.name<>p ) and ( dirInfo.name<>pp ) then
        if ( dirInfo.attr and faDirectory <> 0 ) and ( frec ) then
           ScanLDir( fdirName+dirinfo.name+'\', dirInfo );

      dosError := FindNext( dirInfo );
      if Synchronized then
        Application.processMessages;
      end;
    SysUtils.FindClose( dirInfo );
  end; // ScanLDir
var
   fInfo : TSearchRec;
   fPath : string;
begin    // ScanDir
  Synchronized := ( Windows.GetCurrentThreadId = System.MainThreadID );
  path := ExtractFilePath( fDirName );
  sfi := ExtractFileName( fDirName );

  fPath := Copy( path, 1, length( Path ) - 1 );

  FindFirst( fPath, faAnyfile, fInfo );
  ScanLDir( Path, fInfo );
  SysUtils.FindClose( fInfo );
end; // ScanDir

function FileSearch( Path, Ext : String; RecurseSubFolders : boolean = false ): TStringList;
begin
  result := TStringList.Create;
  FileSearch( Path, Ext, Result, RecurseSubFolders );
end;

function FileSearch( Path, Ext : String; var StrL : TStringList; RecurseSubFolders : boolean = false ): boolean;
var
  Search : TFileSearch;
begin
  result := false;
  if ( StrL = nil ) or ( Path = '' ) or ( Ext = '' ) or ( Path = Ext ) then
    Exit;

  Search := TFileSearch.Create( nil );
  Search.RecurseSubFolders := RecurseSubFolders;
  Search.SearchFile := IncludeTrailingBackslash( Path ) + Ext;
  Search.Start;
  if ( Windows.GetCurrentThreadId = System.MainThreadID ) then
    begin
    while ( Search.Searching ) do
      begin
      sleep( 50 );
      Application.ProcessMessages;
      end;
    end;
  StrL.Assign( Search.FilesFound );
  Search.free;
  result := true;
end;

{$IFEND TLH_INTERFACESECTION}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

{$IFNDEF TLH_OMIT_SECTIONS}
end.
{$ENDIF TLH_OMIT_SECTIONS}
