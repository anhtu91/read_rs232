unit uLanguager;

{$WARN UNSAFE_CAST OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_TYPE OFF}
{$IF CompilerVersion >= 17}
  {$LEGACYIFEND ON}
{$IFEND}

{$DEFINE ENFORCE_CHARSET}           // Enforces Languagefile specific Charset on all components during Load/Apply of Languagefiles
{$DEFINE HOOK_RESOURCESTRINGS}      // Delphi own: InputBox/Query, MessageDlg, ShowMessage
{$DEFINE HOOK_MessageDlg}           // Usualy not required, MessageDlg is translated via ResourceStrings but hooking allows resizing
                                    // If not defined MessageBox will resize but MessageDlgs wont

{$DEFINE HOOK_WINDOWSDIALOGS}       // MessageBox(A/W) (NO Ex-Versions), TCommonDialogs(Open/Save/Print/Font/Color/Find/Replace)
{$DEFINE HOOK_WindowsFunctions}     // TextOutEx, Only NON-Unicode

{$DEFINE HOOK_InitSysLocale}        // Actualy we dont need to Hook this on a virgin Delphi, but since nonUnicode Delphi is semi-bugged
                                    // which faces on Windows Vista+ by corrupting TGroupBox/TRadioGroup-Captions: we hook InitSysLocale
                                    // to ensure there is no BugFix - which bases on SetThreadLocale and therefore destroys our logic - for
                                    // the issue. (Non-Unicode only)

{$DEFINE HOOK_TControlSetTextBuf}   // Workarround: TLabel on Child-/MDI-Forms dont repaint when Text is changed
                                    // If not defined this will be fixed in SetProperty but other changes during runtime wont be corrected
                                    // NOTE: They do if there is also a GroupBox, LabeledEdit.. some WindowsMessage probably works too

interface

uses
  Windows, Controls, Classes, StdCtrls, Grids, CheckLst,
  uCheckStringGrid
  {$IFNDEF UNICODE},Unicode{$ELSE},WideStrings{$ENDIF}
  ;

type
  tLanguageChangeEvent = procedure( LanguageFile : string );

  tLanguager = class
  protected
  private
    CompsInRuntimeList     : TStringGrid;

    compsInFileList,
    RuntimeCompsNotInFileList,
    FileListCompsNotInRuntimeList,
    SourceCodeStrings      : TCheckStringGrid;

    formsList              : tCheckListBox;
    fFilename              : string;
    fSprachname            : string;
    speechcomponent        : TComponent;
    fOnChangeCopy          : TNotifyEvent;
    fOnChange              : tLanguageChangeEvent;
    procedure LoadForms;
    procedure FormsListOnDblClick( Sender: TObject );
  public
    lastSaveFile           : String;
    FlashComponent,
    FlashComponentText     : String;
    FlashComponentForm     : TWinControl;
    FlashComponentVisibles : String;
    changed                : boolean;
    property sprachname    : string read fSprachname;
    constructor Create;
    procedure LoadSavedLanguage;    
    procedure Init( fl: tCheckListBox;
                                       _compsInRuntimeList           : TStringGrid;
                                       _compsInFileList,
                                       _runtimeCompsNotInFileList,
                                       _fileListCompsNotInRuntimeList,
                                       _sourceStrings                : TCheckStringGrid );

    procedure SaveForms;
    procedure ShowForms;
    procedure ShowObjectsInStringlist;
    function  GetCharSet:integer;
    function  ReturnFormByName( formName: string ): TWinControl;
    function  FindFormByName( formName: string; var form: TWinControl ): boolean;
    function  FindComponentByName( form: TWinControl; compoName: string; var comp: tComponent ): boolean;
    function  TriggerComponentVisible( component: String; onlyVisible: boolean ): boolean;
    function  TriggerComponentText( component, text : String ): boolean;
    function  SetProperty( form: TWinControl; comp: tComponent; prop: string; ID: integer; value: WideString ): boolean;
    function  GetProperty( form: TWinControl; comp: tComponent; prop: string; ID : integer; var value: String ): boolean;
    function  SetCharSet( charSet : Cardinal; Base : TComponent = nil ): boolean;
    function  SetCodeString( ID: string; value: WideString ): boolean;
    function  TSetCodeString( ID: string; value: WideString ): boolean; // Temp one for internals
    function  GetSourceCodeString( ID: integer ): string; overload;
    function  GetSourceCodeString( ID: integer; default : string ): string; overload;
    function  CheckCodeString( ID: string ): boolean;
    function  CollectCodeString: boolean;
    procedure RefreshCodeString;
    procedure LoadLanguageFile( fn: string ); overload;
    procedure LoadLanguageFile( cl : TWideStringList ); overload;
    procedure SaveLanguageFile( fn: string );
    function  ConvertDRC( FileName : string ) : TWideStringList;
    function  ApplyLanguageFile( fn : string ): integer;
    function  EnableForm( form : string ): boolean;
    procedure FindRtCompsNotInCompFileList;
    procedure FindRtFileListCompsNotInRuntimeList;
    function  ListLanguageFiles( list : TComponent ): integer;
    procedure LanguageSelectionClick( Sender: TObject );
    function  LanguageSelectionPerName( lang: string ):integer;
    procedure UpdateWDLG_Captions;
    {$IFDEF HOOK_WINDOWSDIALOGS}
    procedure ReadWindowsDlgStrings( ShowOnly : boolean = false );
    {$ENDIF}
    property  OnChangeCopy : TNotifyEvent         read fOnChangeCopy write fOnChangeCopy;
    property  OnChange     : tLanguageChangeEvent read fOnChange     write fOnChange;
  end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  tLanguageReplacer = class
  private
    inData, outDataPAS: tMemo;
    foundAppearance : boolean;
    function FindNextChar( var varPos: integer; Reverse : boolean = false ): boolean;
  protected
    ch       : char;
  public
    position,
    laenge,
    RunningCounter : integer;
    LeerStringsUeberspringen,
    kommentiertesUeberspringen : boolean;
    DublicateMode : Integer;
    filename : string;
    constructor Create;
    procedure Init( p, gsCounter : integer; c: char; iData, oDataPAS: tMemo; lsu, ku: boolean );
    procedure ChangeRunningCounter( newValue: integer );
    function  FindNextMark( Reverse : boolean = false ): boolean;
    function  ReplaceText: boolean;
    function  TextBoxChanged: boolean;
    procedure ResetfoundAppearance;
    function  OpenFile( fn: string ): boolean;
    procedure CreateFileSik( ftype, fn: string );
    function  AddUses : Boolean;
  end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
const
  INTERNAL_GRID_HEADER_1_          : string = 'Form.Component.Property';
  INTERNAL_GRID_HEADER_SOURCE_     : string = 'FileName:Ext.ID';
  INTERNAL_GRID_HEADER_2_          : string = 'Value';

  SPRACH_EXT_                      : string = 'csv';
  INTERNAL_PREFIX_                 : string = 'program';
  INTERNAL_STRING_PREFIX_          : string = 'STRING';
  INTERNAL_DLGCAPTION_PREFIX_      : string = 'DIALOGCAPTION';

  INTERNAL_UPDATE_PREFIX_          : string = 'Update';
  INTERNAL_LCID_PREFIX_            : string = 'LCID';
  INTERNAL_CHARSET_PREFIX_         : string = 'CharSet';
  INTERNAL_CODEPAGE_PREFIX_        : string = 'CodePage';

  INTERNAL_GET_CODESTRING_         : string = 'GetSourceCodeString(';
  INTERNAL_GET_CODESTRING_MASK_    : string = 'GetSourceCodeString(*' + #39 + '*' + #39 + '*)';
  INTERNAL_REPLACE_LF              : string = '[{#10}]';
  INTERNAL_REPLACE_CR              : string = '[{#13}]';

  INTERNAL_FORMS_FILE              : string = 'forms.dat';
  INTERNAL_EXCLUSION_FILE          : string = 'exclusion.dat';
  INTERNAL_LANGUAGE_FILE           : string = 'Language.dat';

  CSGridCompsInRuntimeList_Header            : string = 'RunTime-Components';
  CSGridcompsInFileList_Header               : string = 'Components in Component-File';
  CSGridSourceCodeStrings_Header             : string = 'SourceCode Strings';
  CSGridRuntimeCompsNotInFileList_Header     : string = 'RunTime-Components not found in Component-File';
  CSGridFileListCompsNotInRuntimeList_Header : string = 'In Component-File but not found as RunTime-Component';

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
type
  LanguageItem = Record
    ID     : WideString;
    Value  : WideString;
  end;
  
  ManageArray = Record
    FileInput        : Array of LanguageItem;
    Changes          : Array of LanguageItem;

    Exclusion        : Array of String;

    Runtime          : Array of LanguageItem;
    Compfile         : Array of LanguageItem;
    SourceCode       : Array of LanguageItem;
    RuntimeNotInFile : Array of LanguageItem;
    FileNotInRuntime : Array of LanguageItem;
  end;

var
  LANGUAGE_DIRECTORY_    : string = 'LANGUAGES\';
  LANGUAGE_LCID_         : Cardinal = 0;
  LANGUAGE_CODEPAGE_     : Word = 0;
  LANGUAGE_CHARSET_      : Word = DEFAULT_CHARSET; //0 - ANSII; 1 - DefaultCharset; 255 - OEM( SystemDefault )
  LANGUAGE_MANAGE_ARRAY_ : ManageArray;

  Languager              : tLanguager;
  languageReplacer       : tLanguageReplacer;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure LangMessageDlgInitCaptions( Mode : Byte = 1 );
procedure LangHookResourceStrings;
function SetWindowsDlgString( ID: string; value: WideString ): boolean;
function GetWindowsDlgString( ID: integer ): string;
function GetWindowsDlgStringW( ID: integer ): WideString;
procedure CorrectColumns( Grid : TStringGrid );
function LCIDToCodePage( LCID : Cardinal ) : Word;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

implementation

uses
  Forms, TypInfo, ComCtrls, StrUtils, Consts, Graphics, ExtCtrls,
  Dialogs, Menus, Types{DynStringArray}, Math,
  Language,
  {$IF Defined( HOOK_WINDOWSDIALOGS ) OR Defined( HOOK_MessageDlg ) OR ( NOT Defined( UNICODE ) AND ( Defined( HOOK_WindowsFunctions ) OR Defined( HOOK_InitSysLocale ) ) )}madCodeHook,{$IFEND}
  {$IF NOT Defined( UNICODE ) AND Defined( HOOK_InitSysLocale )}madMapFile,{$IFEND}
  {$IF CompilerVersion >= 23}UiTypes,{$IFEND} // Not expanding compiler-warning ..
  uTLH.StringList, uTLH.Strings, SysUtils;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
var
  LANGUAGE_CODE_STRINGS_   : Array of LanguageItem;
  LANGUAGE_DLG_CAPTIONS_   : Array [ 0..12+4 ] of WideString; // LangMessageDlgInitCaptions
  LANGUAGE_DLG_CAPTIONS_R_ : Array [ 0..12+4 ] of String; // ResourceStrings, Compilerbased
  LANGUAGE_WDLG_CAPTIONS_  : Array of LanguageItem;
  IsFirstListLanguageFiles : boolean = True;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
{$IFDEF HOOK_MessageDlg}
  MessageDlgPosHelpNext      : function ( const Msg: string; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer; const HelpFileName: string ): Integer;
{$ENDIF}

{$IF NOT Defined( UNICODE ) AND Defined( HOOK_WindowsFunctions )}
  ExtTextOutNext             : function ( DC: HDC; X, Y: Integer; Options: Longint; Rect: PRect; Str: PChar; Count: Longint; Dx: PInteger ): BOOL; stdcall;
  DrawTextNext               : function ( hDC: HDC; lpString: PChar; nCount: Integer; var lpRect: TRect; uFormat: UINT ): Integer; stdcall;
{$IFEND}

{$IF NOT Defined( UNICODE ) AND Defined( HOOK_InitSysLocale )}
  InitSysLocaleNext          : procedure;
{$IFEND}

{$IFDEF HOOK_TControlSetTextBuf}
  TControlSetTextBufNext     : procedure( Self : TObject; Buffer: PChar );
{$ENDIF}

{$IFDEF HOOK_WINDOWSDIALOGS}
  MessageBoxNext             : function ( Handle : HWND; ACaption, FCaption : PChar; DlgButtons: UINT ): TModalResult; stdcall;
  MessageBoxANext            : function ( Handle : HWND; ACaption, FCaption : PAnsiChar; DlgButtons: UINT ): TModalResult; stdcall;
  MessageBoxWNext            : function ( Handle : HWND; ACaption, FCaption : PWideChar; DlgButtons: UINT ): TModalResult; stdcall;
  TCommonDialogDoShowNext    : procedure ( Self : TObject );

type
  TOpenCommonDialog = class( TCommonDialog );
{$ENDIF}
{$IF Defined( HOOK_WINDOWSDIALOGS ) OR Defined( HOOK_MessageDlg )}
type
  TOpenControl = class( TControl ); // TControl().Font -> Resize Windows-Dialogs
{$IFEND}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function ClassIsOrIsDescendent( comp : TObject; Name : string ) : boolean;
var
  c : TClass;
begin
  result := comp.ClassNameIs( Name );
  if NOT result then
    begin
    c := comp.ClassParent;
    while NOT result AND Assigned( c ) do
      begin
      result := c.ClassNameIs( Name );
      c      := c.ClassParent;
      end;
    end;
end;

function LCIDToCodePage( LCID : Cardinal ) : Word;
var
  buf : Array [0..4] of Char;
begin
  GetLocaleInfo( LCID, LOCALE_IDEFAULTANSICODEPAGE, buf, SizeOf( buf ) );
  result := StrToIntDef( buf, 0 );
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure tLanguager.FindRtFileListCompsNotInRuntimeList;
var rtc, cfc, i : integer;
    dum         : string;
begin
  FileListCompsNotInRuntimeList.Font.Charset := LANGUAGE_CHARSET_;
  SetLength( LANGUAGE_MANAGE_ARRAY_.FileNotInRuntime, 0 );

  FrmLanguage.PnlGround.Enabled                   := false;
  FrmLanguage.PanelLangProgressing.Visible        := True;
  FrmLanguage.ProgressBarLang.Min                 := 0;
  FrmLanguage.ProgressBarLang.Max                 := compsInFileList.RowCount-1;

  for cfc := 1 to compsInFileList.RowCount-1 do
    begin
    FrmLanguage.ProgressBarLang.Position := cfc;
    Application.ProcessMessages;

    dum := compsInFileList.cells[ 1, cfc ];
    if ( GetTok( dum, 1, '.' ) <> INTERNAL_PREFIX_ ) AND ( GetTok( dum, 2, '.' ) <> INTERNAL_STRING_PREFIX_ ) then
      begin
      for rtc := 1 to compsInRuntimeList.RowCount - 1 do
        begin
        if LowerCase( compsInRuntimeList.cells[ 0, rtc ] ) = LowerCase( dum ) then
          break;
        end;
      if LowerCase( compsInRuntimeList.cells[ 0, rtc ] ) <> LowerCase( dum ) then
        begin
        if ( Length( LANGUAGE_MANAGE_ARRAY_.FileNotInRuntime ) = 0 ) then
          SetLength( LANGUAGE_MANAGE_ARRAY_.FileNotInRuntime,Length( LANGUAGE_MANAGE_ARRAY_.FileNotInRuntime )+1 )
        else if ( LANGUAGE_MANAGE_ARRAY_.FileNotInRuntime[ Length( LANGUAGE_MANAGE_ARRAY_.FileNotInRuntime )-1 ].ID <> '' ) then
          SetLength( LANGUAGE_MANAGE_ARRAY_.FileNotInRuntime,Length( LANGUAGE_MANAGE_ARRAY_.FileNotInRuntime )+1 );

        LANGUAGE_MANAGE_ARRAY_.FileNotInRuntime[ Length( LANGUAGE_MANAGE_ARRAY_.FileNotInRuntime )-1 ].ID := dum;
        LANGUAGE_MANAGE_ARRAY_.FileNotInRuntime[ Length( LANGUAGE_MANAGE_ARRAY_.FileNotInRuntime )-1 ].Value := compsInFileList.cells[ 2, cfc ];
        end;
      end;
    end;

  for cfc := SourceCodeStrings.RowCount-1 downTo 1 do
    begin
    if NOT CheckCodeString( SourceCodeStrings.cells[ 1, cfc ] ) then
      begin
      if ( Length( LANGUAGE_MANAGE_ARRAY_.FileNotInRuntime ) = 0 ) then
        SetLength( LANGUAGE_MANAGE_ARRAY_.FileNotInRuntime,Length( LANGUAGE_MANAGE_ARRAY_.FileNotInRuntime )+1 )
      else if ( LANGUAGE_MANAGE_ARRAY_.FileNotInRuntime[ Length( LANGUAGE_MANAGE_ARRAY_.FileNotInRuntime )-1 ].ID <> '' ) then
        SetLength( LANGUAGE_MANAGE_ARRAY_.FileNotInRuntime,Length( LANGUAGE_MANAGE_ARRAY_.FileNotInRuntime )+1 );

      LANGUAGE_MANAGE_ARRAY_.FileNotInRuntime[ Length( LANGUAGE_MANAGE_ARRAY_.FileNotInRuntime )-1 ].ID := INTERNAL_PREFIX_ + '.' + INTERNAL_STRING_PREFIX_ + '.' + SourceCodeStrings.cells[ 1, cfc ];
      LANGUAGE_MANAGE_ARRAY_.FileNotInRuntime[ Length( LANGUAGE_MANAGE_ARRAY_.FileNotInRuntime )-1 ].Value := SourceCodeStrings.cells[ 2, cfc ];

//      SourceCodeStrings.DelRow( cfc );
      end;
    end;

  if ( Length( LANGUAGE_MANAGE_ARRAY_.FileNotInRuntime ) > 0 ) then
    begin
    FileListCompsNotInRuntimeList.RowCount := Length( LANGUAGE_MANAGE_ARRAY_.FileNotInRuntime )+1;
    for i := 0 to Length( LANGUAGE_MANAGE_ARRAY_.FileNotInRuntime )-1 do
      begin
      FileListCompsNotInRuntimeList.Cells[ 1, i+1 ] := LANGUAGE_MANAGE_ARRAY_.FileNotInRuntime[ i ].ID;
      FileListCompsNotInRuntimeList.Cells[ 2, i+1 ] := LANGUAGE_MANAGE_ARRAY_.FileNotInRuntime[ i ].Value;
      end;
    end
  else
    FileListCompsNotInRuntimeList.RowCount := 1;

  CorrectColumns( FileListCompsNotInRuntimeList );

  FrmLanguage.PnlInCompFileButNotInAppHeader.Caption := CSGridFileListCompsNotInRuntimeList_Header + ' [' + IntToStr( FileListCompsNotInRuntimeList.RowCount-1 ) + ']';

  FrmLanguage.PnlGround.Enabled := True;
  FrmLanguage.PanelLangProgressing.Visible := false;
end;


procedure tLanguager.FindRtCompsNotInCompFileList;
var rtc, cfc, i : integer;
    dum         : string;
begin
  RuntimeCompsNotInFileList.Font.Charset := LANGUAGE_CHARSET_;
  SetLength( LANGUAGE_MANAGE_ARRAY_.RuntimeNotInFile, 0 );

  FrmLanguage.PnlGround.Enabled                   := false;
  FrmLanguage.PanelLangProgressing.Visible        := True;
  FrmLanguage.ProgressBarLang.Min                 := 0;
  FrmLanguage.ProgressBarLang.Max                 := compsInRuntimeList.RowCount-1;

  for rtc := 1 to compsInRuntimeList.RowCount-1 do
    begin
    FrmLanguage.ProgressBarLang.Position := rtc;
    Application.ProcessMessages;

    dum := compsInRuntimeList.cells[ 0, rtc ];
    for cfc := 1 to compsInFileList.RowCount - 1 do
      begin
      if LowerCase( compsInFileList.cells[ 1, cfc ] ) = LowerCase( dum ) then
        break;
      end;
      if LowerCase( compsInFileList.cells[ 1, cfc ] ) <> LowerCase( dum ) then
        begin
        if ( Length( LANGUAGE_MANAGE_ARRAY_.RuntimeNotInFile ) = 0 ) then
          SetLength( LANGUAGE_MANAGE_ARRAY_.RuntimeNotInFile,Length( LANGUAGE_MANAGE_ARRAY_.RuntimeNotInFile )+1 )
        else if ( LANGUAGE_MANAGE_ARRAY_.RuntimeNotInFile[ Length( LANGUAGE_MANAGE_ARRAY_.RuntimeNotInFile )-1 ].ID <> '' ) then
          SetLength( LANGUAGE_MANAGE_ARRAY_.RuntimeNotInFile,Length( LANGUAGE_MANAGE_ARRAY_.RuntimeNotInFile )+1 );

        LANGUAGE_MANAGE_ARRAY_.RuntimeNotInFile[ Length( LANGUAGE_MANAGE_ARRAY_.RuntimeNotInFile )-1 ].ID := dum;
        LANGUAGE_MANAGE_ARRAY_.RuntimeNotInFile[ Length( LANGUAGE_MANAGE_ARRAY_.RuntimeNotInFile )-1 ].Value := compsInRuntimeList.cells[ 1, rtc ];
        end;
    end;

  if ( Length( LANGUAGE_MANAGE_ARRAY_.RuntimeNotInFile ) > 0 ) then
    begin
    RuntimeCompsNotInFileList.RowCount := Length( LANGUAGE_MANAGE_ARRAY_.RuntimeNotInFile )+1;
    for i := 0 to Length( LANGUAGE_MANAGE_ARRAY_.RuntimeNotInFile )-1 do
      begin
      RuntimeCompsNotInFileList.Cells[ 1, i+1 ] := LANGUAGE_MANAGE_ARRAY_.RuntimeNotInFile[ i ].ID;
      RuntimeCompsNotInFileList.Cells[ 2, i+1 ] := LANGUAGE_MANAGE_ARRAY_.RuntimeNotInFile[ i ].Value;
      end;
    end
  else
    RuntimeCompsNotInFileList.RowCount := 1;
  CorrectColumns( RuntimeCompsNotInFileList );

  FrmLanguage.PnlKompsNotInCompFileHeader.Caption := CSGridRuntimeCompsNotInFileList_Header + ' [' + IntToStr( RuntimeCompsNotInFileList.RowCount-1 ) + ']';

  FrmLanguage.PnlGround.Enabled := True;
  FrmLanguage.PanelLangProgressing.Visible := false;
end;


//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
procedure tLanguager.SaveLanguageFile( fn: string );
var cl  : TWideStringList;
    i, j : integer;
    found : array [ 0..81 ] of Boolean;
begin
  cl := TWideStringList.create;
  cl.Clear;
  cl.Add( INTERNAL_GRID_HEADER_1_ + ';' + INTERNAL_GRID_HEADER_2_ + ';' ); // Header

  for i := Low( found ) to High( found ) do
    found[ i ] := False;

  if ( LANGUAGE_MANAGE_ARRAY_.FileInput <> nil ) then
    begin
    for i := 0 to Length( LANGUAGE_MANAGE_ARRAY_.FileInput )-1 do
      begin
      if ( LowerCase( LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].ID ) = LowerCase( INTERNAL_PREFIX_ + '.' + INTERNAL_LCID_PREFIX_ + '.' ) ) then
        begin
        found[ 0 ] := true;
        LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].Value := IntToStr( LANGUAGE_LCID_ );
        end
      else if ( LowerCase( LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].ID ) = LowerCase( INTERNAL_PREFIX_ + '.' + INTERNAL_CHARSET_PREFIX_ + '.' ) ) then
        begin
        found[ 1 ] := true;
        LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].Value := IntToStr( LANGUAGE_CHARSET_ );
        end

      else if ( LowerCase( LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].ID ) = LowerCase( INTERNAL_PREFIX_ + '.' + INTERNAL_DLGCAPTION_PREFIX_ + '.' + 'mbYes' + '.' ) ) then found[ 2 ] := true
      else if ( LowerCase( LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].ID ) = LowerCase( INTERNAL_PREFIX_ + '.' + INTERNAL_DLGCAPTION_PREFIX_ + '.' + 'mbNo' + '.' ) ) then found[ 3 ] := true
      else if ( LowerCase( LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].ID ) = LowerCase( INTERNAL_PREFIX_ + '.' + INTERNAL_DLGCAPTION_PREFIX_ + '.' + 'mbOK' + '.' ) ) then found[ 4 ] := true
      else if ( LowerCase( LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].ID ) = LowerCase( INTERNAL_PREFIX_ + '.' + INTERNAL_DLGCAPTION_PREFIX_ + '.' + 'mbCancel' + '.' ) ) then found[ 5 ] := true
      else if ( LowerCase( LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].ID ) = LowerCase( INTERNAL_PREFIX_ + '.' + INTERNAL_DLGCAPTION_PREFIX_ + '.' + 'mbAbort' + '.' ) ) then found[ 6 ] := true
      else if ( LowerCase( LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].ID ) = LowerCase( INTERNAL_PREFIX_ + '.' + INTERNAL_DLGCAPTION_PREFIX_ + '.' + 'mbRetry' + '.' ) ) then found[ 7 ] := true
      else if ( LowerCase( LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].ID ) = LowerCase( INTERNAL_PREFIX_ + '.' + INTERNAL_DLGCAPTION_PREFIX_ + '.' + 'mbIgnore' + '.' ) ) then found[ 8 ] := true
      else if ( LowerCase( LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].ID ) = LowerCase( INTERNAL_PREFIX_ + '.' + INTERNAL_DLGCAPTION_PREFIX_ + '.' + 'mbAll' + '.' ) ) then found[ 9 ] := true
      else if ( LowerCase( LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].ID ) = LowerCase( INTERNAL_PREFIX_ + '.' + INTERNAL_DLGCAPTION_PREFIX_ + '.' + 'mbNoToAll' + '.' ) ) then found[ 10 ] := true
      else if ( LowerCase( LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].ID ) = LowerCase( INTERNAL_PREFIX_ + '.' + INTERNAL_DLGCAPTION_PREFIX_ + '.' + 'mbYesToAll' + '.' ) ) then found[ 11 ] := true
      else if ( LowerCase( LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].ID ) = LowerCase( INTERNAL_PREFIX_ + '.' + INTERNAL_DLGCAPTION_PREFIX_ + '.' + 'mbHelp' + '.' ) ) then found[ 12 ] := true
      else if ( LowerCase( LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].ID ) = LowerCase( INTERNAL_PREFIX_ + '.' + INTERNAL_DLGCAPTION_PREFIX_ + '.' + 'mbClose' + '.' ) ) then found[ 13 ] := true
      else if ( LowerCase( LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].ID ) = LowerCase( INTERNAL_PREFIX_ + '.' + INTERNAL_DLGCAPTION_PREFIX_ + '.' + 'msgWarning' + '.' ) ) then found[ 14 ] := true
      else if ( LowerCase( LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].ID ) = LowerCase( INTERNAL_PREFIX_ + '.' + INTERNAL_DLGCAPTION_PREFIX_ + '.' + 'msgError' + '.' ) ) then found[ 15 ] := true
      else if ( LowerCase( LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].ID ) = LowerCase( INTERNAL_PREFIX_ + '.' + INTERNAL_DLGCAPTION_PREFIX_ + '.' + 'msgInformation' + '.' ) ) then found[ 16 ] := true
      else if ( LowerCase( LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].ID ) = LowerCase( INTERNAL_PREFIX_ + '.' + INTERNAL_DLGCAPTION_PREFIX_ + '.' + 'msgConfirm' + '.' ) ) then found[ 17 ] := true
      end;

    for i := Low( LANGUAGE_WDLG_CAPTIONS_ ) to High( LANGUAGE_WDLG_CAPTIONS_ ) do
      begin
      for j := 0 to Length( LANGUAGE_MANAGE_ARRAY_.FileInput )-1 do
        begin
        if ( LowerCase( LANGUAGE_MANAGE_ARRAY_.FileInput[ j ].ID ) = LowerCase( INTERNAL_PREFIX_ + '.' + INTERNAL_DLGCAPTION_PREFIX_ + '.' + LANGUAGE_WDLG_CAPTIONS_[ i ].ID + '.' ) ) then
          begin
          found[ 18+i ] := True;
          break;
          end;
        end;
      end;
    end;

  //    if ( GetCharSet <> -1 ) then // CharSet
  //      if NOT ( found[ 1 ] ) then cl.Add( INTERNAL_PREFIX_ + '.' + INTERNAL_CHARSET_PREFIX_ + '.' + ';' + IntToStr( GetCharSet ) + ';' );

  if NOT ( found[ 0 ] ) then cl.Add( INTERNAL_PREFIX_ + '.' + INTERNAL_LCID_PREFIX_ + '.' + ';' + IntToStr( LANGUAGE_LCID_ ) + ';' );
  if NOT ( found[ 1 ] ) then cl.Add( INTERNAL_PREFIX_ + '.' + INTERNAL_CHARSET_PREFIX_ + '.' + ';' + IntToStr( LANGUAGE_CHARSET_ ) + ';' );
  if NOT ( found[ 2 ] ) then cl.Add( INTERNAL_PREFIX_ + '.' + INTERNAL_DLGCAPTION_PREFIX_ + '.' + 'mbYes'          + '.' + ';' + LANGUAGE_DLG_CAPTIONS_[ Integer( mbYes ) ] + ';' );
  if NOT ( found[ 3 ] ) then cl.Add( INTERNAL_PREFIX_ + '.' + INTERNAL_DLGCAPTION_PREFIX_ + '.' + 'mbNo'           + '.' + ';' + LANGUAGE_DLG_CAPTIONS_[ Integer( mbNo ) ] + ';' );
  if NOT ( found[ 4 ] ) then cl.Add( INTERNAL_PREFIX_ + '.' + INTERNAL_DLGCAPTION_PREFIX_ + '.' + 'mbOK'           + '.' + ';' + LANGUAGE_DLG_CAPTIONS_[ Integer( mbOK ) ] + ';' );
  if NOT ( found[ 5 ] ) then cl.Add( INTERNAL_PREFIX_ + '.' + INTERNAL_DLGCAPTION_PREFIX_ + '.' + 'mbCancel'       + '.' + ';' + LANGUAGE_DLG_CAPTIONS_[ Integer( mbCancel ) ] + ';' );
  if NOT ( found[ 6 ] ) then cl.Add( INTERNAL_PREFIX_ + '.' + INTERNAL_DLGCAPTION_PREFIX_ + '.' + 'mbAbort'        + '.' + ';' + LANGUAGE_DLG_CAPTIONS_[ Integer( mbAbort ) ] + ';' );
  if NOT ( found[ 7 ] ) then cl.Add( INTERNAL_PREFIX_ + '.' + INTERNAL_DLGCAPTION_PREFIX_ + '.' + 'mbRetry'        + '.' + ';' + LANGUAGE_DLG_CAPTIONS_[ Integer( mbRetry ) ] + ';' );
  if NOT ( found[ 8 ] ) then cl.Add( INTERNAL_PREFIX_ + '.' + INTERNAL_DLGCAPTION_PREFIX_ + '.' + 'mbIgnore'       + '.' + ';' + LANGUAGE_DLG_CAPTIONS_[ Integer( mbIgnore ) ] + ';' );
  if NOT ( found[ 9 ] ) then cl.Add( INTERNAL_PREFIX_ + '.' + INTERNAL_DLGCAPTION_PREFIX_ + '.' + 'mbAll'          + '.' + ';' + LANGUAGE_DLG_CAPTIONS_[ Integer( mbAll ) ] + ';' );
  if NOT ( found[ 10 ] ) then cl.Add( INTERNAL_PREFIX_ + '.' + INTERNAL_DLGCAPTION_PREFIX_ + '.' + 'mbNoToAll'      + '.' + ';' + LANGUAGE_DLG_CAPTIONS_[ Integer( mbNoToAll ) ] + ';' );
  if NOT ( found[ 11 ] ) then cl.Add( INTERNAL_PREFIX_ + '.' + INTERNAL_DLGCAPTION_PREFIX_ + '.' + 'mbYesToAll'     + '.' + ';' + LANGUAGE_DLG_CAPTIONS_[ Integer( mbYesToAll ) ] + ';' );
  if NOT ( found[ 12 ] ) then cl.Add( INTERNAL_PREFIX_ + '.' + INTERNAL_DLGCAPTION_PREFIX_ + '.' + 'mbHelp'         + '.' + ';' + LANGUAGE_DLG_CAPTIONS_[ Integer( mbHelp ) ] + ';' );
  {$IF CompilerVersion >= 30}
  if NOT ( found[ 13 ] ) then cl.Add( INTERNAL_PREFIX_ + '.' + INTERNAL_DLGCAPTION_PREFIX_ + '.' + 'mbClose'        + '.' + ';' + LANGUAGE_DLG_CAPTIONS_[ Integer( mbClose ) ] + ';' );
  {$IFEND}
  if NOT ( found[ 14 ] ) then cl.Add( INTERNAL_PREFIX_ + '.' + INTERNAL_DLGCAPTION_PREFIX_ + '.' + 'msgWarning'     + '.' + ';' + LANGUAGE_DLG_CAPTIONS_[ Integer( mbHelp )+2 ] + ';' );
  if NOT ( found[ 15 ] ) then cl.Add( INTERNAL_PREFIX_ + '.' + INTERNAL_DLGCAPTION_PREFIX_ + '.' + 'msgError'       + '.' + ';' + LANGUAGE_DLG_CAPTIONS_[ Integer( mbHelp )+3 ] + ';' );
  if NOT ( found[ 16 ] ) then cl.Add( INTERNAL_PREFIX_ + '.' + INTERNAL_DLGCAPTION_PREFIX_ + '.' + 'msgInformation' + '.' + ';' + LANGUAGE_DLG_CAPTIONS_[ Integer( mbHelp )+4 ] + ';' );
  if NOT ( found[ 17 ] ) then cl.Add( INTERNAL_PREFIX_ + '.' + INTERNAL_DLGCAPTION_PREFIX_ + '.' + 'msgConfirm'     + '.' + ';' + LANGUAGE_DLG_CAPTIONS_[ Integer( mbHelp )+5 ] + ';' );

  for j := Low( LANGUAGE_WDLG_CAPTIONS_ ) to High( LANGUAGE_WDLG_CAPTIONS_ ) do
  begin
  if NOT found[ 18+j ] then
  cl.Add( INTERNAL_PREFIX_ + '.' + INTERNAL_DLGCAPTION_PREFIX_ + '.' + LANGUAGE_WDLG_CAPTIONS_[ j ].ID + '.' + ';' + LANGUAGE_WDLG_CAPTIONS_[ j ].Value + ';' );
  end;

  for i := 0 to Length( LANGUAGE_MANAGE_ARRAY_.FileInput )-1 do // Regular Compfile as it is...
    cl.Add( LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].ID + ';' + LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].Value + ';' );

  if ( Length( LANGUAGE_MANAGE_ARRAY_.FileInput ) > 0 ) AND ( Length( LANGUAGE_MANAGE_ARRAY_.Changes ) > 0 ) then
    cl.Add( INTERNAL_PREFIX_ + '.' + INTERNAL_UPDATE_PREFIX_ + ' ############################## ' + FormatDateTime( 'dd.mm.yyyy - hh:nn:ss', now ) + ' ##############################' );

  for i := 0 to Length( LANGUAGE_MANAGE_ARRAY_.Changes )-1 do
    cl.Add( LANGUAGE_MANAGE_ARRAY_.Changes[ i ].ID + ';' + LANGUAGE_MANAGE_ARRAY_.Changes[ i ].Value + ';' );

  {$IFNDEF UNICODE}
  cl.SaveUnicode := True; // set this RIGHT here, former trys setting b4 adding items caused problems loading them again ( broke after 4 lines )
  {$ENDIF}
  try
    if FileExists( fn ) then
      languageReplacer.CreateFileSik( 'compfile', fn );
    cl.SaveToFile( fn );
  finally
    lastSaveFile := fn;
    changed := false;
    ListLanguageFiles( speechcomponent );
  end;
  FreeAndNil( cl );
end;

procedure tLanguager.UpdateWDLG_Captions;
var
  i, j : integer;
begin
  for i := 0 to Length( LANGUAGE_MANAGE_ARRAY_.FileInput )-1 do
    begin
    if ( LowerCase( LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].ID ) = LowerCase( INTERNAL_PREFIX_ + '.' + INTERNAL_DLGCAPTION_PREFIX_ + '.' + 'mbYes' + '.' ) ) then
      LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].Value := LANGUAGE_DLG_CAPTIONS_[ Integer( mbYes ) ]
    else if ( LowerCase( LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].ID ) = LowerCase( INTERNAL_PREFIX_ + '.' + INTERNAL_DLGCAPTION_PREFIX_ + '.' + 'mbNo' + '.' ) ) then
      LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].Value := LANGUAGE_DLG_CAPTIONS_[ Integer( mbNo ) ]
    else if ( LowerCase( LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].ID ) = LowerCase( INTERNAL_PREFIX_ + '.' + INTERNAL_DLGCAPTION_PREFIX_ + '.' + 'mbOK' + '.' ) ) then
      LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].Value := LANGUAGE_DLG_CAPTIONS_[ Integer( mbOK ) ]
    else if ( LowerCase( LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].ID ) = LowerCase( INTERNAL_PREFIX_ + '.' + INTERNAL_DLGCAPTION_PREFIX_ + '.' + 'mbCancel' + '.' ) ) then
      LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].Value := LANGUAGE_DLG_CAPTIONS_[ Integer( mbCancel ) ]
    else if ( LowerCase( LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].ID ) = LowerCase( INTERNAL_PREFIX_ + '.' + INTERNAL_DLGCAPTION_PREFIX_ + '.' + 'mbAbort' + '.' ) ) then
      LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].Value := LANGUAGE_DLG_CAPTIONS_[ Integer( mbAbort ) ]
    else if ( LowerCase( LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].ID ) = LowerCase( INTERNAL_PREFIX_ + '.' + INTERNAL_DLGCAPTION_PREFIX_ + '.' + 'mbRetry' + '.' ) ) then
      LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].Value := LANGUAGE_DLG_CAPTIONS_[ Integer( mbRetry ) ]
    else if ( LowerCase( LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].ID ) = LowerCase( INTERNAL_PREFIX_ + '.' + INTERNAL_DLGCAPTION_PREFIX_ + '.' + 'mbIgnore' + '.' ) ) then
      LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].Value := LANGUAGE_DLG_CAPTIONS_[ Integer( mbIgnore ) ]
    else if ( LowerCase( LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].ID ) = LowerCase( INTERNAL_PREFIX_ + '.' + INTERNAL_DLGCAPTION_PREFIX_ + '.' + 'mbAll' + '.' ) ) then
      LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].Value := LANGUAGE_DLG_CAPTIONS_[ Integer( mbAll ) ]
    else if ( LowerCase( LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].ID ) = LowerCase( INTERNAL_PREFIX_ + '.' + INTERNAL_DLGCAPTION_PREFIX_ + '.' + 'mbNoToAll' + '.' ) ) then
      LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].Value := LANGUAGE_DLG_CAPTIONS_[ Integer( mbNoToAll ) ]
    else if ( LowerCase( LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].ID ) = LowerCase( INTERNAL_PREFIX_ + '.' + INTERNAL_DLGCAPTION_PREFIX_ + '.' + 'mbYesToAll' + '.' ) ) then
      LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].Value := LANGUAGE_DLG_CAPTIONS_[ Integer( mbYesToAll ) ]
    else if ( LowerCase( LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].ID ) = LowerCase( INTERNAL_PREFIX_ + '.' + INTERNAL_DLGCAPTION_PREFIX_ + '.' + 'mbHelp' + '.' ) ) then
      LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].Value := LANGUAGE_DLG_CAPTIONS_[ Integer( mbHelp ) ]
    {$IF CompilerVersion >= 30}
    else if ( LowerCase( LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].ID ) = LowerCase( INTERNAL_PREFIX_ + '.' + INTERNAL_DLGCAPTION_PREFIX_ + '.' + 'mbClose' + '.' ) ) then
      LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].Value := LANGUAGE_DLG_CAPTIONS_[ Integer( mbClose ) ]
    {$IFEND}
    else if ( LowerCase( LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].ID ) = LowerCase( INTERNAL_PREFIX_ + '.' + INTERNAL_DLGCAPTION_PREFIX_ + '.' + 'msgWarning' + '.' ) ) then
      LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].Value := LANGUAGE_DLG_CAPTIONS_[ Integer( mbHelp )+2 ]
    else if ( LowerCase( LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].ID ) = LowerCase( INTERNAL_PREFIX_ + '.' + INTERNAL_DLGCAPTION_PREFIX_ + '.' + 'msgError' + '.' ) ) then
      LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].Value := LANGUAGE_DLG_CAPTIONS_[ Integer( mbHelp )+3 ]
    else if ( LowerCase( LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].ID ) = LowerCase( INTERNAL_PREFIX_ + '.' + INTERNAL_DLGCAPTION_PREFIX_ + '.' + 'msgInformation' + '.' ) ) then
      LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].Value := LANGUAGE_DLG_CAPTIONS_[ Integer( mbHelp )+4 ]
    else if ( LowerCase( LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].ID ) = LowerCase( INTERNAL_PREFIX_ + '.' + INTERNAL_DLGCAPTION_PREFIX_ + '.' + 'msgConfirm' + '.' ) ) then
      LANGUAGE_MANAGE_ARRAY_.FileInput[ i ].Value := LANGUAGE_DLG_CAPTIONS_[ Integer( mbHelp )+5 ]
    end;

  for i := Low( LANGUAGE_WDLG_CAPTIONS_ ) to High( LANGUAGE_WDLG_CAPTIONS_ ) do
    begin
    for j := 0 to Length( LANGUAGE_MANAGE_ARRAY_.FileInput )-1 do
      begin
      if ( LowerCase( LANGUAGE_MANAGE_ARRAY_.FileInput[ j ].ID ) = LowerCase( INTERNAL_PREFIX_ + '.' + INTERNAL_DLGCAPTION_PREFIX_ + '.' + LANGUAGE_WDLG_CAPTIONS_[ i ].ID + '.' ) ) then
        begin
        LANGUAGE_MANAGE_ARRAY_.FileInput[ j ].Value := LANGUAGE_WDLG_CAPTIONS_[ i ].Value;
        break;
        end;
      end;
    end;
end;

procedure tLanguager.LoadLanguageFile( fn: string );
var
  StrL : TWideStringList;
begin
  StrL := TWideStringList.create;
  if NOT FileExists( fn ) then
    Exit;

  lastSaveFile := fn;
  StrL.LoadFromFile( fn );
  LoadLanguageFile( StrL );
  StrL.free;
  changed := false;  
end;

procedure tLanguager.LoadLanguageFile( cl : TWideStringList );
var
  i: integer;
  s, ID, Value: WideString;
  reloadComps : boolean;
begin
  reloadComps := False;

  SetLength( LANGUAGE_MANAGE_ARRAY_.FileInput, 0 );
  SetLength( LANGUAGE_MANAGE_ARRAY_.SourceCode, 0 );
  SetLength( LANGUAGE_MANAGE_ARRAY_.Compfile, 0 );

  SetLength( LANGUAGE_MANAGE_ARRAY_.RunTime, 0 );
  SetLength( LANGUAGE_MANAGE_ARRAY_.RunTimeNotInFile, 0 );
  SetLength( LANGUAGE_MANAGE_ARRAY_.FileNotInRunTime, 0 );

  LANGUAGE_LCID_     := 0;
  LANGUAGE_CODEPAGE_ := 0;
  LANGUAGE_CHARSET_  := DEFAULT_CHARSET;
  FrmLanguage.SetComboBoxLCID( LANGUAGE_LCID_ );
  FrmLanguage.SetComboBoxCharSet( LANGUAGE_CHARSET_ );

  for i := 0 to cl.Count - 1 do
    begin
    s := cl[ i ];

    if ( s = '' ) OR ( StringReplace( s,';','',[ rfReplaceAll ] ) = '' ) OR ( LowerCase( s ) = LowerCase( INTERNAL_GRID_HEADER_1_+';'+INTERNAL_GRID_HEADER_2_+';' ) ) OR ( LowerCase( s ) = LowerCase( INTERNAL_GRID_HEADER_1_+';'+INTERNAL_GRID_HEADER_2_ ) ) then
      continue;

    ID := GetTok( s, 1, ';' );
    Value := GetTok( s, 2, NumTok( s, ';' ), WChar( ';' ) );

    SetLength( LANGUAGE_MANAGE_ARRAY_.FileInput,Length( LANGUAGE_MANAGE_ARRAY_.FileInput )+1 );
    LANGUAGE_MANAGE_ARRAY_.FileInput[ Length( LANGUAGE_MANAGE_ARRAY_.FileInput )-1 ].ID    := ID;
    LANGUAGE_MANAGE_ARRAY_.FileInput[ Length( LANGUAGE_MANAGE_ARRAY_.FileInput )-1 ].Value := Value;

    if ( LowerCase( GetTok( ID, 1, '.' ) ) = LowerCase( INTERNAL_PREFIX_ ) ) then
      begin
      if ( LowerCase( GetTok( ID, 2, '.' ) ) = LowerCase( INTERNAL_STRING_PREFIX_ ) ) then
        begin
        {if ( SourceCodeStrings.cells[ 1, SourceCodeStrings.RowCount-1 ] <> '' ) then // Comps musst have Names
           SourceCodeStrings.RowCount := SourceCodeStrings.RowCount + 1;
        SourceCodeStrings.cells[ 1, SourceCodeStrings.RowCount-1 ] := WideStringToString( s1, LANGUAGE_CODEPAGE_ );
        SourceCodeStrings.cells[ 2, SourceCodeStrings.RowCount-1 ] := WideStringToString( s2, LANGUAGE_CODEPAGE_ );
        SourceCodeStrings.FixedRows := 1;
        FrmLanguage.PnlSourceStringsHeader.Caption := CSGridSourceCodeStrings_Header + ' [' + IntToStr( SourceCodeStrings.RowCount-1 ) + ']';}

        // Keep internal arrays Up2Date
        TSetCodeString( ID, Value );

        //Keep Stringfinder Up2Date
        if ( StrToIntDef( GetTok( GetTok( ID, 1, ';' ), 4, '.' ),0 ) > ( StrToIntDef( FrmLanguage.lbledtFortlaufendeNr.Text,0 )-1 ) ) then
           begin
           languageReplacer.RunningCounter := StrToInt( GetTok( GetTok( ID, 1, ';' ), 4, '.' ) )+1;
           FrmLanguage.lbledtFortlaufendeNr.Text := IntToStr( StrToInt( GetTok( GetTok( ID, 1, ';' ), 4, '.' ) )+1 );
           end;
        end
      else if ( LowerCase( GetTok( ID, 2, '.' ) ) = LowerCase( INTERNAL_LCID_PREFIX_ ) ) then
        begin
        LANGUAGE_LCID_ := StrToIntDef( Value, 0 );
        if ( LANGUAGE_LCID_ <> 0 ) then // Backward compatiblity, if there is no LCID we need the CodePage
          LANGUAGE_CODEPAGE_ := LCIDtoCodePage( LANGUAGE_LCID_ );
        FrmLanguage.SetComboBoxLCID( LANGUAGE_LCID_ );
        end
      else if ( LowerCase( GetTok( ID, 2, '.' ) ) = LowerCase( INTERNAL_CODEPAGE_PREFIX_ ) ) then
        begin
        if ( LANGUAGE_LCID_ = 0 ) then
          LANGUAGE_CODEPAGE_ := StrToIntDef( Value, 0 );
        end
      else if ( LowerCase( GetTok( ID, 2, '.' ) ) = LowerCase( INTERNAL_CHARSET_PREFIX_ ) ) then
        begin
        LANGUAGE_CHARSET_ := StrToIntDef( GetTok( s, 2, NumTok( s, ';' ), ';' ), DEFAULT_CHARSET ){value};
        {$IFDEF ENFORCE_CHARSET}
        SetCharSet( LANGUAGE_CHARSET_ );
        {$ENDIF}
        FrmLanguage.SetComboBoxCharSet( LANGUAGE_CHARSET_ );
        end;
      end
    else
      begin
      if ( LowerCase( GetTok( ID, 1, '.' ) ) = LowerCase( INTERNAL_PREFIX_ ) ) then
         continue;

      if ( Length( LANGUAGE_MANAGE_ARRAY_.Compfile ) = 0 ) then
        SetLength( LANGUAGE_MANAGE_ARRAY_.Compfile,Length( LANGUAGE_MANAGE_ARRAY_.Compfile )+1 )
      else if ( LANGUAGE_MANAGE_ARRAY_.Compfile[ Length( LANGUAGE_MANAGE_ARRAY_.Compfile )-1 ].ID <> '' ) then
        SetLength( LANGUAGE_MANAGE_ARRAY_.Compfile,Length( LANGUAGE_MANAGE_ARRAY_.Compfile )+1 );

      LANGUAGE_MANAGE_ARRAY_.Compfile[ Length( LANGUAGE_MANAGE_ARRAY_.Compfile )-1 ].ID := ID;
      LANGUAGE_MANAGE_ARRAY_.Compfile[ Length( LANGUAGE_MANAGE_ARRAY_.Compfile )-1 ].Value := Value;

      if ( EnableForm( GetTok( ID, 1, '.' ) ) ) then
        reloadComps := true;
      end;
    end; // for

  if ( Length( LANGUAGE_MANAGE_ARRAY_.Compfile ) > 0 ) then
    begin
    if ( compsInFileList.RowCount > 1 ) then
      compsInFileList.Clear( True, False );
    compsInFileList.RowCount := Length( LANGUAGE_MANAGE_ARRAY_.Compfile )+1;
    for i := 0 to Length( LANGUAGE_MANAGE_ARRAY_.Compfile )-1 do
      begin
      {$IFNDEF UNICODE}
      compsInFileList.Cells[ 1, i+1 ] := WideStringToString( LANGUAGE_MANAGE_ARRAY_.Compfile[ i ].ID, LANGUAGE_CODEPAGE_ );
      compsInFileList.Cells[ 2, i+1 ] := WideStringToString( LANGUAGE_MANAGE_ARRAY_.Compfile[ i ].Value, LANGUAGE_CODEPAGE_ );
      {$ELSE}
      compsInFileList.Cells[ 1, i+1 ] := LANGUAGE_MANAGE_ARRAY_.Compfile[ i ].ID;
      compsInFileList.Cells[ 2, i+1 ] := LANGUAGE_MANAGE_ARRAY_.Compfile[ i ].Value;
      {$ENDIF}
      end;
    end
  else
    compsInFileList.RowCount := 1;

  CorrectColumns( compsInFileList );

  FrmLanguage.PnlKomponentenfileHeader.Caption := CSGridcompsInFileList_Header + ' [' + IntToStr( compsInFileList.RowCount-1 ) + ']';

  SetLength( LANGUAGE_MANAGE_ARRAY_.Changes, 0 ); // Reset changes
  if ( reloadComps ) then
    ShowObjectsInStringlist;

  RefreshCodeString;

//  if ( compsInRuntimeList.RowCount > 1 ) AND ( compsInFileList.RowCount > 1 ) then // As long as both necessary Grids are already filled ..
//    begin
    FindRtCompsNotInCompFileList;
    FindRtFileListCompsNotInRuntimeList;
//    end;
end;

function tLanguager.EnableForm( form : string ): boolean;
var
  i : integer;
begin
  result := false;
  for i := 0 to FrmLanguage.chkLbxForms.Count-1 do
    begin
    if ( CompareText( FrmLanguage.chkLbxForms.Items[ i ],form ) = 0 ) AND ( FrmLanguage.chkLbxForms.checked[ i ] <> true ) then
       begin
       result := true;
       FrmLanguage.chkLbxForms.checked[ i ] := true;
       end;
    end;
end;

function tLanguager.ApplyLanguageFile( fn : string ): integer;
  procedure SaveLanguage;
  var
    StrL : TWideStringList;
  begin
    StrL := TWideStringList.Create;
    StrL.Text := ExtractFileName( fn );
    StrL.SaveToFile( LANGUAGE_DIRECTORY_ + INTERNAL_LANGUAGE_FILE );
    StrL.free;
  end;

var
  cl    : TWideStringList;
  i     : integer;
  s     : WideString;

  ID,
  Value : WideString;

  Form  : TWinControl;
  Comp  : TComponent;
begin
  result := -1;

  if ( fn = '' ) then
    fn := 'none';

  if ( LowerCase( fn ) = 'none' ) then
    begin
    result := 1;
    fSprachname := fn;
    fFileName := '';
    SaveLanguage;
    Exit;
    end;
  if NOT FileExists( fn ) then
    begin
    fn := LANGUAGE_DIRECTORY_ + fn;
    fn := ChangeFileExt( fn, '.' + SPRACH_EXT_ );
    end;

  if NOT FileExists( fn ) then
     Exit;

  cl := TWideStringList.create;

  SetLength( LANGUAGE_CODE_STRINGS_, 0 );
  LangMessageDlgInitCaptions;

  cl.LoadFromFile( fn );
  LANGUAGE_LCID_     := 0;
  LANGUAGE_CODEPAGE_ := 0;
  LANGUAGE_CHARSET_  := DEFAULT_CHARSET;

  for i := 0 to cl.Count - 1 do
    begin
    s := cl[ i ];
    if ( s = '' ) OR ( StringReplace( s,';','',[ rfReplaceAll ] ) = '' ) OR ( LowerCase( s ) = LowerCase( INTERNAL_GRID_HEADER_1_+';'+INTERNAL_GRID_HEADER_2_+';' ) ) OR ( LowerCase( s ) = LowerCase( INTERNAL_GRID_HEADER_1_+';'+INTERNAL_GRID_HEADER_2_ ) ) then
      continue;

    ID := GetTok( s, 1, ';' );
    Value := GetTok( s, 2, NumTok( s, ';' ), WChar( ';' ) );

    if ( LowerCase( GetTok( ID, 1, '.' ) ) = LowerCase( INTERNAL_PREFIX_ ) ) then // Internal?
      begin
      if ( LowerCase( GetTok( ID, 2, '.' ) ) = LowerCase( INTERNAL_UPDATE_PREFIX_ ) ) then
        continue

      else if ( LowerCase( GetTok( ID, 2, '.' ) ) = LowerCase( INTERNAL_DLGCAPTION_PREFIX_ ) ) then
        begin
        if ( LowerCase( GetTok( ID, 3, '.' ) ) = LowerCase( 'mbYes' ) ) then
          begin
          LANGUAGE_DLG_CAPTIONS_[ Integer( mbYes ) ] := Value;
          LANGUAGE_DLG_CAPTIONS_R_[ Integer( mbYes ) ] := {$IFNDEF UNICODE}WideStringToString( Value, LANGUAGE_CODEPAGE_ ){$ELSE}Value{$ENDIF};
          end
        else if ( LowerCase( GetTok( ID, 3, '.' ) ) = LowerCase( 'mbNo' ) ) then
          begin
          LANGUAGE_DLG_CAPTIONS_[ Integer( mbNo ) ] := Value;
          LANGUAGE_DLG_CAPTIONS_R_[ Integer( mbNo ) ] := {$IFNDEF UNICODE}WideStringToString( Value, LANGUAGE_CODEPAGE_ ){$ELSE}Value{$ENDIF};
          end
        else if ( LowerCase( GetTok( ID, 3, '.' ) ) = LowerCase( 'mbOK' ) ) then
          begin
          LANGUAGE_DLG_CAPTIONS_[ Integer( mbOK ) ] := Value;
          LANGUAGE_DLG_CAPTIONS_R_[ Integer( mbOK ) ] := {$IFNDEF UNICODE}WideStringToString( Value, LANGUAGE_CODEPAGE_ ){$ELSE}Value{$ENDIF};
          end
        else if ( LowerCase( GetTok( ID, 3, '.' ) ) = LowerCase( 'mbCancel' ) ) then
          begin
          LANGUAGE_DLG_CAPTIONS_[ Integer( mbCancel ) ] := Value;
          LANGUAGE_DLG_CAPTIONS_R_[ Integer( mbCancel ) ] := {$IFNDEF UNICODE}WideStringToString( Value, LANGUAGE_CODEPAGE_ ){$ELSE}Value{$ENDIF};
          end
        else if ( LowerCase( GetTok( ID, 3, '.' ) ) = LowerCase( 'mbAbort' ) ) then
          begin
          LANGUAGE_DLG_CAPTIONS_[ Integer( mbAbort ) ] := Value;
          LANGUAGE_DLG_CAPTIONS_R_[ Integer( mbAbort ) ] := {$IFNDEF UNICODE}WideStringToString( Value, LANGUAGE_CODEPAGE_ ){$ELSE}Value{$ENDIF};
          end
        else if ( LowerCase( GetTok( ID, 3, '.' ) ) = LowerCase( 'mbRetry' ) ) then
          begin
          LANGUAGE_DLG_CAPTIONS_[ Integer( mbRetry ) ] := Value;
          LANGUAGE_DLG_CAPTIONS_R_[ Integer( mbRetry ) ] := {$IFNDEF UNICODE}WideStringToString( Value, LANGUAGE_CODEPAGE_ ){$ELSE}Value{$ENDIF};
          end
        else if ( LowerCase( GetTok( ID, 3, '.' ) ) = LowerCase( 'mbIgnore' ) ) then
          begin
          LANGUAGE_DLG_CAPTIONS_[ Integer( mbIgnore ) ] := Value;
          LANGUAGE_DLG_CAPTIONS_R_[ Integer( mbIgnore ) ] := {$IFNDEF UNICODE}WideStringToString( Value, LANGUAGE_CODEPAGE_ ){$ELSE}Value{$ENDIF};
          end
        else if ( LowerCase( GetTok( ID, 3, '.' ) ) = LowerCase( 'mbAll' ) ) then
          begin
          LANGUAGE_DLG_CAPTIONS_[ Integer( mbAll ) ] := Value;
          LANGUAGE_DLG_CAPTIONS_R_[ Integer( mbAll ) ] := {$IFNDEF UNICODE}WideStringToString( Value, LANGUAGE_CODEPAGE_ ){$ELSE}Value{$ENDIF};
          end
        else if ( LowerCase( GetTok( ID, 3, '.' ) ) = LowerCase( 'mbNoToAll' ) ) then
          begin
          LANGUAGE_DLG_CAPTIONS_[ Integer( mbNoToAll ) ] := Value;
          LANGUAGE_DLG_CAPTIONS_R_[ Integer( mbNoToAll ) ] := {$IFNDEF UNICODE}WideStringToString( Value, LANGUAGE_CODEPAGE_ ){$ELSE}Value{$ENDIF};
          end
        else if ( LowerCase( GetTok( ID, 3, '.' ) ) = LowerCase( 'mbYesToAll' ) ) then
          begin
          LANGUAGE_DLG_CAPTIONS_[ Integer( mbYesToAll ) ] := Value;
          LANGUAGE_DLG_CAPTIONS_R_[ Integer( mbYesToAll ) ] := {$IFNDEF UNICODE}WideStringToString( Value, LANGUAGE_CODEPAGE_ ){$ELSE}Value{$ENDIF};
          end
        else if ( LowerCase( GetTok( ID, 3, '.' ) ) = LowerCase( 'mbHelp' ) ) then
          begin
          LANGUAGE_DLG_CAPTIONS_[ Integer( mbHelp ) ] := Value;
          LANGUAGE_DLG_CAPTIONS_R_[ Integer( mbHelp ) ] := {$IFNDEF UNICODE}WideStringToString( Value, LANGUAGE_CODEPAGE_ ){$ELSE}Value{$ENDIF};
          end
        {$IF CompilerVersion >= 30}
        else if ( LowerCase( GetTok( ID, 3, '.' ) ) = LowerCase( 'mbClose' ) ) then
          begin
          LANGUAGE_DLG_CAPTIONS_[ Integer( mbClose ) ] := Value;
          LANGUAGE_DLG_CAPTIONS_R_[ Integer( mbClose ) ] := {$IFNDEF UNICODE}WideStringToString( Value, LANGUAGE_CODEPAGE_ ){$ELSE}Value{$ENDIF};
          end
        {$IFEND}
        else if ( LowerCase( GetTok( ID, 3, '.' ) ) = LowerCase( 'msgWarning' ) ) then
          begin
          LANGUAGE_DLG_CAPTIONS_[ Integer( mbHelp )+2 ] := Value;
          LANGUAGE_DLG_CAPTIONS_R_[ Integer( mbHelp )+2 ] := {$IFNDEF UNICODE}WideStringToString( Value, LANGUAGE_CODEPAGE_ ){$ELSE}Value{$ENDIF};
          end
        else if ( LowerCase( GetTok( ID, 3, '.' ) ) = LowerCase( 'msgError' ) ) then
          begin
          LANGUAGE_DLG_CAPTIONS_[ Integer( mbHelp )+3 ] := Value;
          LANGUAGE_DLG_CAPTIONS_R_[ Integer( mbHelp )+3 ] := {$IFNDEF UNICODE}WideStringToString( Value, LANGUAGE_CODEPAGE_ ){$ELSE}Value{$ENDIF};
          end
        else if ( LowerCase( GetTok( ID, 3, '.' ) ) = LowerCase( 'msgInformation' ) ) then
           begin
           LANGUAGE_DLG_CAPTIONS_[ Integer( mbHelp )+4 ] := Value;
           LANGUAGE_DLG_CAPTIONS_R_[ Integer( mbHelp )+4 ] := {$IFNDEF UNICODE}WideStringToString( Value, LANGUAGE_CODEPAGE_ ){$ELSE}Value{$ENDIF};
           end
        else if ( LowerCase( GetTok( ID, 3, '.' ) ) = LowerCase( 'msgConfirm' ) ) then
          begin
          LANGUAGE_DLG_CAPTIONS_[ Integer( mbHelp )+5 ] := Value;
          LANGUAGE_DLG_CAPTIONS_R_[ Integer( mbHelp )+5 ] := {$IFNDEF UNICODE}WideStringToString( Value, LANGUAGE_CODEPAGE_ ){$ELSE}Value{$ENDIF};
          end
        else if ( IsNum( GetTok( ID, 3, '.' ) ) ) then
          SetWindowsDlgString( GetTok( ID, 3, '.' ), Value )
        else
          Continue;
        end
      else if ( LowerCase( GetTok( ID, 2, '.' ) ) = LowerCase( INTERNAL_STRING_PREFIX_ ) ) then
        SetCodeString( ID, Value )
      else if ( LowerCase( GetTok( ID, 2, '.' ) ) = LowerCase( INTERNAL_LCID_PREFIX_ ) ) then
        begin
        LANGUAGE_LCID_ := StrToIntDef( Value, 0 );
        SetThreadLocale( LANGUAGE_LCID_ );
        if ( LANGUAGE_LCID_ <> 0 ) then // Backward compatiblity, if there is no LCID we need the CodePage
          begin
          LANGUAGE_CODEPAGE_ := LCIDtoCodePage( LANGUAGE_LCID_ );
          GetFormatSettings;
          end;
        FrmLanguage.SetComboBoxLCID( LANGUAGE_LCID_ );
        end
      else if ( LowerCase( GetTok( ID, 2, '.' ) ) = LowerCase( INTERNAL_CODEPAGE_PREFIX_ ) ) then
        begin
        if ( LANGUAGE_LCID_ = 0 ) then
          LANGUAGE_CODEPAGE_ := StrToIntDef( Value, 0 );
        end
      else if ( LowerCase( GetTok( ID, 2, '.' ) ) = LowerCase( INTERNAL_CHARSET_PREFIX_ ) ) then
        begin
        LANGUAGE_CHARSET_ := StrToIntDef( GetTok( s, 2, NumTok( s, ';' ), ';' ), DEFAULT_CHARSET ){value};
        {$IFDEF ENFORCE_CHARSET}
        SetCharSet( LANGUAGE_CHARSET_ );
        {$ENDIF}
        end;
      end
    else if NOT FindFormByName( GetTok( ID, 1, '.' ){Form}, form ) then // Form exists?
//      result := 0
    else if ( LowerCase( GetTok( ID, 2, '.' ) ){compString} = 'self' ) then
      SetProperty( Form, nil, GetTok( ID, 3, '.' ){prop}, 0{ID}, Value )
    else if NOT FindComponentByName( form, GetTok( ID, 2, '.' ){compString}, comp ) then // component exists?
//      result := 0
    else
      begin
      if ( LowerCase( GetTok( ID, 3, '.' ) ) = LowerCase( 'Items' ) ) then // Comp-Item
        SetProperty( Form, comp, GetTok( ID, 3, '.' ){prop}, StrToInt( GetTok( ID, 4, '.' ) ){itemID}, Value )
      else if ( LowerCase( GetTok( ID, 3, '.' ) ) = LowerCase( 'SeriesList' ) ) then // Comp-Item
        SetProperty( Form, comp, GetTok( ID, 3, '.' ){prop}, StrToInt( GetTok( ID, 4, '.' ) ){itemID}, Value )
      else if ( LowerCase( GetTok( ID, 3, '.' ) ) = LowerCase( 'TitleText' ) ) then // Comp-Item
        SetProperty( Form, comp, GetTok( ID, 3, '.' ){prop}, StrToInt( GetTok( ID, 4, '.' ) ){itemID}, Value )
      else
        SetProperty( Form, comp, GetTok( ID, 3, '.' ){prop}, 0{ID}, Value );
      end;
    end;
  FreeAndNil( cl );    

  {$IFDEF HOOK_RESOURCESTRINGS}
  LangHookResourceStrings;
  {$ENDIF}

  if ( LANGUAGE_LCID_ = 0 ) then
    GetFormatSettings;

  result := 1;
  fSprachname := ChangeFileExt( ExtractFileName( fn ), '' );
  fFileName := ExtractFileName( fn );
  SaveLanguage;

  if ( GetACP <> LANGUAGE_CODEPAGE_ ) AND ( LANGUAGE_CODEPAGE_ <> 0 ) then
    result := 2;
  if Assigned( fOnChangeCopy ) then
    fOnChangeCopy( self );

  if Assigned( fOnChangeCopy ) then
    fOnChange( fn );

  if NOT IsFirstListLanguageFiles then
    begin
    if ( result < 0 ) then
      MessageDlg( 'Error loading languagefile', mTError, [ mbOK ], 0 )
    else
      begin
      if ( result = 2 ) then
        MessageDlg(
//                   Format( 'Die SystemCodePage ( %d ) entspricht nicht der für die Sprache "%s" vorgesehen CodePage ( %d )' + #13 + 'Die Sprache wird möglicherweise nicht korrekt Dargestellt.', [ GetACP, Sprachname, LANGUAGE_CODEPAGE_ ] ),
                   Format( 'The SystemCodePage ( %d ) doensn''t match the required CodePage ( %d ) for the Language "%s"' + #13 + 'The language may not be displayed correctly', [ GetACP, LANGUAGE_CODEPAGE_, Sprachname ] ),
                   mtWarning, [ mbOK ], 0 );
      end;
    end;
end;

function tLanguager.ListLanguageFiles( list : TComponent ): integer;
var
  Notify    : TNotifyEvent;
  Method    : System.TMethod absolute Notify;
  searchRec : TSearchRec;
  StrL      : TStringList;
  v         : Variant;
  ti        : Integer;
begin
  if IsFirstListLanguageFiles then
    begin
    IsFirstListLanguageFiles := false;
    LoadSavedLanguage; // This time for the Forms
    end;

  result := -1;

  if ( list = nil ) AND ( speechcomponent <> nil ) then
    List := speechcomponent;

  if NOT Assigned( List ) then
    Exit;

  if NOT IsPublishedProp( list, 'Items' ) then // TComboBox, TComboBoxEx, TRadioGroup, TListBox
    Exit; // Unsupported Component
  speechcomponent := list;

  v := GetPropValue( list, 'Items' );
  StrL := TStringList.Create;
  StrL.Add( 'None' );
  StrL.Sorted := false;

  tI := 0;
  result := 0;
  if FindFirst( LANGUAGE_DIRECTORY_ + '*.' + SPRACH_EXT_, faAnyFile, SearchRec ) = 0 then
    Repeat
    StrL.Add( ChangeFileExt( SearchRec.Name, '' ) );
    inc( result );

    if ( {LANGUAGE_DIRECTORY_ + }SearchRec.Name = fFileName ) then
      tI := Result;
    Until ( FindNext( SearchRec ) <> 0 );
  SysUtils.FindClose( SearchRec );

  TPersistent( Integer( v ) ).Assign( StrL );
  FreeAndNil( StrL );
  if IsPublishedProp( list, 'ItemIndex' ) then
    SetPropValue( list, 'ItemIndex', tI );

  if IsPublishedProp( list, 'OnClick' ) then
    begin
    Method := GetMethodProp( list, 'OnClick' );
    Languager.OnChangeCopy := Notify;

    Notify := LanguageSelectionClick;
    SetMethodProp( list, 'OnClick', Method );
    end;
end;

procedure tLanguager.LanguageSelectionClick( Sender: TObject );
var
  StrL : TStringList;
  v    : Variant;
  ID   : Integer;
begin
  if NOT IsPublishedProp( Sender, 'Items' ) then // TComboBox, TComboBoxEx, TRadioGroup, TListBox
    Exit; // Unsupported Component
  if IsPublishedProp( Sender, 'ItemIndex' ) then // TComboBox, TComboBoxEx, TRadioGroup, TListBox
    ID := GetPropValue( Sender, 'ItemIndex' )
  else
    Exit;

  v := GetPropValue( Sender, 'Items' );
  StrL := TStringList.Create;
  StrL.Assign( TPersistent( Integer( v ) ) );

  ApplyLanguageFile( StrL[ ID ] );
  FreeAndNil( StrL );
end;

function tLanguager.LanguageSelectionPerName( lang: string ):integer;
var
  i    : integer;
  s    : string;
  StrL : TStringList;
  v    : Variant;
  ID   : Integer;
begin
  result := -2;
  if NOT Assigned( Self ) then
    Exit;
  if ( speechcomponent = nil ) then
    Exit;

  result := -1;
  s := StringReplace( lang,'.' + SPRACH_EXT_,'',[ rfIgnoreCase ] );
  if NOT IsPublishedProp( speechcomponent, 'Items' ) then // TComboBox, TComboBoxEx, TRadioGroup, TListBox
    Exit; // Unsupported Component
  if IsPublishedProp( speechcomponent, 'ItemIndex' ) then // TComboBox, TComboBoxEx, TRadioGroup, TListBox
    ID := GetPropValue( speechcomponent, 'ItemIndex' )
  else
    Exit;

  v := GetPropValue( speechcomponent, 'Items' );
  StrL := TStringList.Create;
  StrL.Assign( TPersistent( Integer( v ) ) );
  if ( LowerCase( StrL[ ID ] ) = LowerCase( s ) ) then
    begin
    StrL.free;
    Exit;
    end;
  for i := 0 to StrL.Count-1 do
    begin
    if ( LowerCase( StrL[ i ] ) = LowerCase( s ) ) then
      begin
      SetPropValue( speechcomponent, 'ItemIndex', i );
      result := 0;
      break;
      end;
    end;
  FreeAndNil( StrL );

  ID := GetPropValue( speechcomponent, 'ItemIndex' );
  if ( ID < 0 ) then
    SetPropValue( speechcomponent, 'ItemIndex', 0 );

  if result = 0 then
    LanguageSelectionClick( speechcomponent );
end;

function tLanguager.SetProperty( form: TWinControl; comp: tComponent; prop: string; ID : integer; value: WideString ): boolean;
var
  aStr     : String;
  Obj      : TObject;
  v        : Variant;
  StrL     : TStringList;
  tIndex   : Integer;
{$IFNDEF HOOK_TControlSetTextBuf}
  tComp    : TWinControl;
  bIsChild : Boolean;
  vRect    : TRect;
{$ENDIF}
begin
  result := false;
  {$IFNDEF UNICODE}
  aStr := WideStringToString( value, LANGUAGE_CODEPAGE_ );
  {$ELSE}
  aStr := value;
  {$ENDIF}
  // Replace String-Versions with CR/LF
  aStr := StringReplace( aStr,INTERNAL_REPLACE_LF, #10, [ rfReplaceAll ] ); // LF
  aStr := StringReplace( aStr,INTERNAL_REPLACE_CR, #13, [ rfReplaceAll ] ); // CR

  if ( comp <> nil ) then
    begin
    if ( comp.ClassNameIs( 'TChart' ) ) then
      begin
      end
    else if ( LowerCase( prop ) = 'items' ) then
      begin
      if NOT ( IsPublishedProp( comp, 'items' ) OR IsPublishedProp( comp, 'lines' ) OR IsPublishedProp( comp, 'tabs' ) ) then
        Exit; // Property doesnt exist for given Comp
      end
    else if ( LowerCase( prop ) = 'caption' ) then
      begin
      if ( NOT ClassIsOrIsDescendent( comp, 'TLabeledEdit' ) ) AND ( NOT IsPublishedProp( comp, prop ) ) then
        Exit; // Property doesnt exist for given Comp
      end
    else if NOT IsPublishedProp( comp, prop ) then
      Exit; // Property doesnt exist for given Comp

    if ( IsPublishedProp( comp, 'Font' ) ) then // Set CharSet for all Objects
      begin
      Obj := GetObjectProp( comp, 'FONT' ); // Cast 'comp.Font' in Obj
      SetPropValue( Obj, 'CHARSET', LANGUAGE_CHARSET_ ); // Set comp.Font.Charset
      end;
    end;

  if ( LowerCase( prop ) = LowerCase( 'text' ) ) then
     begin
     result := true;

     if IsPublishedProp( comp, prop ) then
       SetPropValue( comp, prop, aStr )
     else
       result := false;
     end // text

  else if ( LowerCase( prop ) = LowerCase( 'caption' ) ) then
    begin
    result := true;
    if ( comp = NIL ) then
      begin
      if ( form is TForm ) then
        TForm( form ).caption := aStr
      else
        Exit;
      end

    else if ClassIsOrIsDescendent( comp, 'TLabeledEdit' ) then
      begin
      if IsPublishedProp( comp, 'EditLabel' ) then
        begin
        obj := GetObjectProp( comp, 'EditLabel' );
        TLabel( obj ).Caption := aStr;
        end;
      end

    else if IsPublishedProp( comp, prop ) then
      SetPropValue( comp, prop, aStr )
    else
      result := false;
    end // caption

  else if ( LowerCase( prop ) = LowerCase( 'items' ) ) then
    begin
    result := true;

    if ( comp = Languager.speechcomponent ) then
      begin
      end

    else if IsPublishedProp( comp, 'Items' ) then
      begin
      v := GetPropValue( comp, 'Items' );
      StrL := TStringList.Create;
      StrL.Assign( TPersistent( Integer( v ) ) );
//      if ( ID = 0 ) then
//        StrL.Clear;
//      StrL.Add( aStr );

      while ( ID >= StrL.Count ) do
        StrL.Add( '' );
      StrL[ ID ] := aStr;

      tIndex := -1;      
      if IsPublishedProp( comp, 'ItemIndex' ) then
        tIndex := GetPropValue( comp, 'ItemIndex' );

      TPersistent( Integer( v ) ).Assign( StrL );
      FreeAndNil( StrL );

      if IsPublishedProp( comp, 'ItemIndex' ) then
        SetPropValue( comp, 'ItemIndex', tIndex );
      end
    else if IsPublishedProp( comp, 'Lines' ) then
      begin
      v := GetPropValue( comp, 'Lines' );
      StrL := TStringList.Create;
      StrL.Assign( TPersistent( Integer( v ) ) );
//      if ( ID = 0 ) then
//        StrL.Clear;
//      StrL.Add( aStr );

      while ( ID >= StrL.Count ) do
        StrL.Add( '' );
      StrL[ ID ] := aStr;

      tIndex := -1;
      if IsPublishedProp( comp, 'ItemIndex' ) then
        tIndex := GetPropValue( comp, 'ItemIndex' );

      TPersistent( Integer( v ) ).Assign( StrL );
      FreeAndNil( StrL );

      if IsPublishedProp( comp, 'ItemIndex' ) then
        SetPropValue( comp, 'ItemIndex', tIndex );
      end
    else if IsPublishedProp( comp, 'Tabs' ) then
      begin
      v := GetPropValue( comp, 'Tabs' );
      StrL := TStringList.Create;
      StrL.Assign( TPersistent( Integer( v ) ) );
//      if ( ID = 0 ) then
//        StrL.Clear;
//      StrL.Add( aStr );

      while ( ID >= StrL.Count ) do
        StrL.Add( '' );
      StrL[ ID ] := aStr;

      tIndex := -1;
      if IsPublishedProp( comp, 'TabIndex' ) then
        tIndex := GetPropValue( comp, 'TabIndex' );

      TPersistent( Integer( v ) ).Assign( StrL );
      FreeAndNil( StrL );

      if IsPublishedProp( comp, 'TabIndex' ) then
        SetPropValue( comp, 'TabIndex', tIndex );
      end
    else
      result := false;
    end // Items

  else if ( LowerCase( prop ) = LowerCase( 'hint' ) ) then
    begin
    result := true;
    if IsPublishedProp( comp, prop ) then
      SetPropValue( comp, prop, aStr )
    else
      result := false;
    end // hint

  // TeeChart
  else if ( LowerCase( prop ) = LowerCase( 'TitleText' ) ) then
    begin
    result := true;
    if ( comp.ClassNameIs( 'TChart' ) ) then
      begin
      if IsPublishedProp( comp, 'Title' ) then
        begin
        Obj := GetObjectProp( comp, 'Title' );
        if IsPublishedProp( Obj, 'Text' ) then
          begin
          v := GetPropValue( Obj, 'Text' );
          StrL := TStringList.Create;
          StrL.Assign( TPersistent( Integer( v ) ) );

//          if ( ID = 0 ) then
//            StrL.Clear;
//          StrL.Add( aStr );

          while ( ID >= StrL.Count ) do
            StrL.Add( '' );
          StrL[ ID ] := aStr;

          TPersistent( Integer( v ) ).Assign( StrL );
          FreeAndNil( StrL );
          end
        end;
      end
    else
      result := false;
    end // TitleText ( TChart )

  else if ( LowerCase( prop ) = LowerCase( 'Title' ) ) then
    begin
    result := true;
    if IsPublishedProp( comp, prop ) then
      SetPropValue( comp, prop, aStr )
    else
      result := false;
    end // TLineSeries ( TChart )

  // TeeChart
  else if ( LowerCase( prop ) = LowerCase( 'LeftAxisCaption' ) ) then
    begin
    if IsPublishedProp( comp, 'LeftAxis' ) then
      begin
      Obj := GetObjectProp( comp, 'LeftAxis' );
      if IsPublishedProp( Obj, 'Title' ) then
        begin
        Obj := GetObjectProp( Obj, 'Title' );
        if IsPublishedProp( Obj, 'Caption' ) then
          SetPropValue( Obj, 'Caption', AStr );
        end;
      end;
    end
  else if ( LowerCase( prop ) = LowerCase( 'RightAxisCaption' ) ) then
    begin
    if IsPublishedProp( comp, 'RightAxis' ) then
      begin
      Obj := GetObjectProp( comp, 'RightAxis' );
      if IsPublishedProp( Obj, 'Title' ) then
        begin
        Obj := GetObjectProp( Obj, 'Title' );
        if IsPublishedProp( Obj, 'Caption' ) then
          SetPropValue( Obj, 'Caption', AStr );
        end;
      end;
    end
  else if ( LowerCase( prop ) = LowerCase( 'TopAxisCaption' ) ) then
    begin
    if IsPublishedProp( comp, 'TopAxis' ) then
      begin
      Obj := GetObjectProp( comp, 'TopAxis' );
      if IsPublishedProp( Obj, 'Title' ) then
        begin
        Obj := GetObjectProp( Obj, 'Title' );
        if IsPublishedProp( Obj, 'Caption' ) then
          SetPropValue( Obj, 'Caption', AStr );
        end;
      end;
    end
  else if ( LowerCase( prop ) = LowerCase( 'BottomAxisCaption' ) ) then
    begin
    if IsPublishedProp( comp, 'BottomAxis' ) then
      begin
      Obj := GetObjectProp( comp, 'BottomAxis' );
      if IsPublishedProp( Obj, 'Title' ) then
        begin
        Obj := GetObjectProp( Obj, 'Title' );
        if IsPublishedProp( Obj, 'Caption' ) then
          SetPropValue( Obj, 'Caption', AStr );
        end;
      end;
    end
  else
    result := false; // unknown input

  {$IFNDEF HOOK_TControlSetTextBuf}
  if ( comp is TLabel ) AND Result AND ( form is TForm ) then
    begin
    bIsChild := False;
    tComp    := form.Parent;
    while Assigned( tComp ) do
      begin
      if ( ( tComp is TForm ) OR ( tComp is TFrame ) ) then
        begin
        bIsChild := True;
        Break;
        end;
      tComp := tComp.Parent;
      end;

    if bIsChild AND Assigned( TControl( comp ).Parent ) then
      begin
      vRect := TControl( comp ).BoundsRect;
      RedrawWindow( TControl( comp ).Parent.Handle, @vRect, 0, RDW_ERASE or RDW_FRAME or RDW_INVALIDATE or RDW_ALLCHILDREN );
      end;
    end;
  {$ENDIF}
end;

function tLanguager.GetProperty( form: TWinControl; comp: tComponent; prop: string; ID : integer; var value: String ): boolean;
var
  Obj  : TObject;
  v    : Variant;
  StrL : TStringList;
begin
  result := false;
  Value := '';

  if ( comp <> nil ) then
    begin
    if ( comp.ClassNameIs( 'TChart' ) ) then
      begin
      end
    else if ( LowerCase( prop ) = 'items' ) then
      begin
      if NOT ( IsPublishedProp( comp, 'items' ) OR IsPublishedProp( comp, 'lines' ) OR IsPublishedProp( comp, 'tabs' ) ) then
        Exit; // Property doesnt exist for given Comp
      end
    else if ( LowerCase( prop ) = 'caption' ) then
      begin
      if ( NOT ClassIsOrIsDescendent( comp, 'TLabeledEdit' ) ) AND ( NOT IsPublishedProp( comp, prop ) ) then
        Exit; // Property doesnt exist for given Comp
      end
    else if NOT IsPublishedProp( comp, prop ) then
      Exit; // Property doesnt exist for given Comp
    end;

  if ( LowerCase( prop ) = LowerCase( 'text' ) ) then
     begin
     result := true;

     if IsPublishedProp( comp, prop ) then
       value := GetPropValue( comp, prop )
     else
       result := false;
     end // text

  else if ( LowerCase( prop ) = LowerCase( 'caption' ) ) then
     begin
     result := true;
     if ( comp = NIL ) then
       begin
       if ( form is TForm ) then
         value := TForm( form ).Caption
       else
         Exit;
       end

     else if ClassIsOrIsDescendent( comp, 'TLabeledEdit' ) then
       begin
       if IsPublishedProp( comp, 'EditLabel' ) then
         begin
         obj := GetObjectProp( comp, 'EditLabel' );
         value := TLabel( obj ).Caption;
         end;
       end
       
     else if IsPublishedProp( comp, prop ) then
       value := GetPropValue( comp, prop )
     else
       result := false;
     end // caption

  else if ( LowerCase( prop ) = LowerCase( 'items' ) ) then
    begin
    result := true;

    if IsPublishedProp( comp, 'Items' ) then
      begin
      v := GetPropValue( comp, 'Items' );
      StrL := TStringList.Create;
      StrL.Assign( TPersistent( Integer( v ) ) );
      if ( ID < StrL.Count ) then
        value := StrL[ ID ];
      FreeAndNil( StrL );
      end
    else if IsPublishedProp( comp, 'Lines' ) then
      begin
      v := GetPropValue( comp, 'Lines' );
      StrL := TStringList.Create;
      StrL.Assign( TPersistent( Integer( v ) ) );
      if ( ID < StrL.Count ) then
        value := StrL[ ID ];
      FreeAndNil( StrL );
      end
    else if IsPublishedProp( comp, 'Tabs' ) then
      begin
      v := GetPropValue( comp, 'Tabs' );
      StrL := TStringList.Create;
      StrL.Assign( TPersistent( Integer( v ) ) );
      if ( ID < StrL.Count ) then
        value := StrL[ ID ];
      FreeAndNil( StrL );
      end
    else
      result := false;
    end // Items

  else if ( LowerCase( prop ) = LowerCase( 'hint' ) ) then
    begin
    result := true;
    if IsPublishedProp( comp, prop ) then
      value := GetPropValue( comp, prop )
    else
      result := false;
    end // hint

  // TeeChart
  else if ( LowerCase( prop ) = LowerCase( 'TitleText' ) ) then
    begin
    result := true;
    if ( comp.ClassNameIs( 'TChart' ) ) then
      begin
      if IsPublishedProp( comp, 'Title' ) then
        begin
        Obj := GetObjectProp( comp, 'Title' );
        if IsPublishedProp( Obj, 'Text' ) then
          begin
          v := GetPropValue( Obj, 'Text' );
          StrL := TStringList.Create;
          StrL.Assign( TPersistent( Integer( v ) ) );
          if ( ID < StrL.Count ) then
            value := StrL[ ID ];
          FreeAndNil( StrL );
          end
        end;
      end
    else
      result := false;
    end // TitleText ( TChart )

  else if ( LowerCase( prop ) = LowerCase( 'Title' ) ) then
    begin
    result := true;
    if IsPublishedProp( comp, prop ) then
      value := GetPropValue( comp, prop )
    else
      result := false;
    end // TLineSeries ( TChart )

  // TeeChart
  else if ( LowerCase( prop ) = LowerCase( 'LeftAxisCaption' ) ) then
    begin
    if IsPublishedProp( comp, 'LeftAxis' ) then
      begin
      Obj := GetObjectProp( comp, 'LeftAxis' );
      if IsPublishedProp( Obj, 'Title' ) then
        begin
        Obj := GetObjectProp( Obj, 'Title' );
        if IsPublishedProp( Obj, 'Caption' ) then
          value := GetPropValue( Obj, 'Caption' );
        end;
      end;
    end
  else if ( LowerCase( prop ) = LowerCase( 'RightAxisCaption' ) ) then
    begin
    if IsPublishedProp( comp, 'RightAxis' ) then
      begin
      Obj := GetObjectProp( comp, 'RightAxis' );
      if IsPublishedProp( Obj, 'Title' ) then
        begin
        Obj := GetObjectProp( Obj, 'Title' );
        if IsPublishedProp( Obj, 'Caption' ) then
          value := GetPropValue( Obj, 'Caption' );
        end;
      end;
    end
  else if ( LowerCase( prop ) = LowerCase( 'TopAxisCaption' ) ) then
    begin
    if IsPublishedProp( comp, 'TopAxis' ) then
      begin
      Obj := GetObjectProp( comp, 'TopAxis' );
      if IsPublishedProp( Obj, 'Title' ) then
        begin
        Obj := GetObjectProp( Obj, 'Title' );
        if IsPublishedProp( Obj, 'Caption' ) then
          value := GetPropValue( Obj, 'Caption' );
        end;
      end;
    end
  else if ( LowerCase( prop ) = LowerCase( 'BottomAxisCaption' ) ) then
    begin
    if IsPublishedProp( comp, 'BottomAxis' ) then
      begin
      Obj := GetObjectProp( comp, 'BottomAxis' );
      if IsPublishedProp( Obj, 'Title' ) then
        begin
        Obj := GetObjectProp( Obj, 'Title' );
        if IsPublishedProp( Obj, 'Caption' ) then
          value := GetPropValue( Obj, 'Caption' );
        end;
      end;
    end
  else
    result := false; // unknown input

  // Replace String-Versions with CR/LF
  value := StringReplace( value,INTERNAL_REPLACE_LF, #10, [ rfReplaceAll ] ); // LF
  value := StringReplace( value,INTERNAL_REPLACE_CR, #13, [ rfReplaceAll ] ); // CR
end;

function tLanguager.SetCharSet( charSet : Cardinal; Base : TComponent = nil ): boolean;
var
  appI  : Integer;
  comp  : TComponent;
  Obj   : TObject;
begin
  if ( Base = nil ) then
    Base := Application;

  result := false;
  for appI := 0 to Base.ComponentCount - 1 do
    begin
    comp := Base.Components[ appI ];
    if ( comp = nil ) then
      Continue;
    if ( IsPublishedProp( comp, 'Font' ) ) then // Set CharSet for all Objects
      begin
      Obj := GetObjectProp( comp, 'FONT' ); // Cast 'comp.Font' in Obj
      SetPropValue( Obj, 'CHARSET', charSet ); // Set comp.Font.Charset
      result := true;
      end; // comp <> nil AND IsPublished
    SetCharSet( charSet, comp );
    end; //for appI
end;

function tLanguager.SetCodeString( ID: string; value: WideString ): boolean;
var
  i : integer;
begin
   result := false;
   for i := 0 to Length( LANGUAGE_CODE_STRINGS_ )-1 do
     begin
     if ( LANGUAGE_CODE_STRINGS_[ i ].ID = ID ) OR ( GetTok( LANGUAGE_CODE_STRINGS_[ i ].ID, 4, '.' ) = GetTok( ID, 4, '.' ) ) then
        begin
        LANGUAGE_CODE_STRINGS_[ i ].ID    := ID;
        LANGUAGE_CODE_STRINGS_[ i ].Value := value;
        result := true;
        break;
        end;
     end;
   if NOT result then
     begin
     if ( Length( LANGUAGE_CODE_STRINGS_ ) = 0 ) then
       SetLength( LANGUAGE_CODE_STRINGS_,Length( LANGUAGE_CODE_STRINGS_ )+1 )
     else if ( LANGUAGE_CODE_STRINGS_[ Length( LANGUAGE_CODE_STRINGS_ )-1 ].ID <> '' ) then
       SetLength( LANGUAGE_CODE_STRINGS_,Length( LANGUAGE_CODE_STRINGS_ )+1 );

     LANGUAGE_CODE_STRINGS_[ Length( LANGUAGE_CODE_STRINGS_ )-1 ].ID := ID;
     LANGUAGE_CODE_STRINGS_[ Length( LANGUAGE_CODE_STRINGS_ )-1 ].Value := value;
     end;

   result := true;
end;

function tLanguager.TSetCodeString( ID: string; value: WideString ): boolean;
var
  i, j, k  : integer;
begin
   result := false;
   for i := 0 to Length( LANGUAGE_MANAGE_ARRAY_.SourceCode )-1 do
     begin
     if ( LANGUAGE_MANAGE_ARRAY_.SourceCode[ i ].ID = ID ) OR ( GetTok( LANGUAGE_MANAGE_ARRAY_.SourceCode[ i ].ID, 4, '.' ) = GetTok( ID, 4, '.' ) ) then
        begin
        LANGUAGE_MANAGE_ARRAY_.SourceCode[ i ].ID    := ID;
        LANGUAGE_MANAGE_ARRAY_.SourceCode[ i ].Value := value;

        for k := 0 to Length( LANGUAGE_MANAGE_ARRAY_.FileInput )-1 do
           begin
           if ( GetTok( LANGUAGE_MANAGE_ARRAY_.FileInput[ k ].ID, 1, '.' ) <> INTERNAL_PREFIX_ ) AND ( GetTok( LANGUAGE_MANAGE_ARRAY_.FileInput[ k ].ID, 2, '.' ) <> INTERNAL_STRING_PREFIX_ ) then
              continue;

            if ( LANGUAGE_MANAGE_ARRAY_.FileInput[ k ].ID = ID ) OR ( GetTok( LANGUAGE_MANAGE_ARRAY_.FileInput[ k ].ID, 4, '.' ) = GetTok( ID, 4, '.' ) ) then
              begin
              LANGUAGE_MANAGE_ARRAY_.FileInput[ k ].ID := '';
              LANGUAGE_MANAGE_ARRAY_.FileInput[ k ].Value := '';
              for j := k to Length( LANGUAGE_MANAGE_ARRAY_.FileInput )-2 do
                  begin
                  LANGUAGE_MANAGE_ARRAY_.FileInput[ j ].ID := LANGUAGE_MANAGE_ARRAY_.FileInput[ j+1 ].ID;
                  LANGUAGE_MANAGE_ARRAY_.FileInput[ j ].Value := LANGUAGE_MANAGE_ARRAY_.FileInput[ j+1 ].Value;
                  end;
              SetLength( LANGUAGE_MANAGE_ARRAY_.FileInput,Length( LANGUAGE_MANAGE_ARRAY_.FileInput )-1 );
              break;
              end;
           end;
        result := true;
        break;
        end;
     end;
   if NOT result then
     begin
     if ( Length( LANGUAGE_MANAGE_ARRAY_.SourceCode ) = 0 ) then
       SetLength( LANGUAGE_MANAGE_ARRAY_.SourceCode,Length( LANGUAGE_MANAGE_ARRAY_.SourceCode )+1 )
     else if ( LANGUAGE_MANAGE_ARRAY_.SourceCode[ Length( LANGUAGE_MANAGE_ARRAY_.SourceCode )-1 ].ID <> '' ) then
       SetLength( LANGUAGE_MANAGE_ARRAY_.SourceCode,Length( LANGUAGE_MANAGE_ARRAY_.SourceCode )+1 );

     LANGUAGE_MANAGE_ARRAY_.SourceCode[ Length( LANGUAGE_MANAGE_ARRAY_.SourceCode )-1 ].ID := ID;
     LANGUAGE_MANAGE_ARRAY_.SourceCode[ Length( LANGUAGE_MANAGE_ARRAY_.SourceCode )-1 ].Value := value;
     end;

   //Keep changes file Up2Date
   i := Length( LANGUAGE_MANAGE_ARRAY_.Changes );
   SetLength( LANGUAGE_MANAGE_ARRAY_.Changes,i+1 );
   LANGUAGE_MANAGE_ARRAY_.Changes[ i ].ID    := ID;
   LANGUAGE_MANAGE_ARRAY_.Changes[ i ].Value := Value;

   result := true;
   changed := true; // Set here to keep track of new SourceCodeString, is called during ( Re )Load of compfile but falsed after finish load...
end;

function tLanguager.GetSourceCodeString( ID: integer ): string;
var
  i     : integer;
begin
   result := '';
   for i := 0 to Length( LANGUAGE_CODE_STRINGS_ )-1 do
     begin
     if ( GetTok( LANGUAGE_CODE_STRINGS_[ i ].ID, 4, '.' ) = IntToStr( ID ) ) then
        begin
        {$IFNDEF UNICODE}
        result := WideStringToString( LANGUAGE_CODE_STRINGS_[ i ].value, LANGUAGE_CODEPAGE_ );
        {$ELSE}
        result := LANGUAGE_CODE_STRINGS_[ i ].value;
        {$ENDIF}
        Exit;
        end;
     end;
end;

function tLanguager.GetSourceCodeString( ID: integer; default : string ): string;
begin
   result := GetSourceCodeString( ID );
   if ( result = '' ) then
     result := default;
end;

function tLanguager.CheckCodeString( ID: string ): boolean;
var
//  SearchRec         : TSearchRec;
  fname             : String;
  data              : TStringList;
  i                 : integer;
begin
  result := false;

  if ( NumTok( GetTok( ID, 1, '.' ), ':' ) <> 2 ) OR ( NOT IsNum( GetTok( ID, 2, '.' ) ) ) OR ( NumTok( ID, '.' ) <> 2 ) then
    Exit;

  fname := ExtractFileDir( application.exename ) + '\' + StringReplace( GetTok( ID, 1, '.' ), ':', '.', [ rfReplaceAll ] );

  if FileExists( fname ) then
    begin
    data := TStringList.create;
    data.LoadFromFile( fname );

    for i := 0 to data.Count-1 do
      begin
      if ( IsWm( data.Strings[ i ], '*' + INTERNAL_GET_CODESTRING_ + '*' + GetTok( ID, 2, '.' ) + '*)*' ) ) then
        begin
        result := true;
        break;
        end;
      end;
    data.free;
    end;

  {if FindFirst( ExtractFileDir( application.exename ) + '\' + '*.pas', faAnyFile, SearchRec ) = 0 then
    Repeat
    fname := ExtractFileDir( application.exename ) + '\' + SearchRec.Name;

    if FileExists( fname ) then
      begin
      data := TStringList.create;
      data.LoadFromFile( fname );

      for i := 0 to data.Count-1 do
        begin
        if ( IsWm( data.Strings[ i ], '*' + INTERNAL_GET_CODESTRING_ + '*' + GetTok( ID, 2, '.' ) + '* )*' ) ) then
          begin
          result := true;
          break;
          end;
        end;
      data.free;
      end;
    Until ( FindNext( SearchRec ) <> 0 );
  SysUtils.FindClose( SearchRec );}
end;

function tLanguager.CollectCodeString: boolean;
var
  SearchRec         : TSearchRec;
  fname, helpStr    : String;
  data              : TStringList;
  i, j              : integer;
  Line,
  ID, Value         : {Wide}String;
begin
  result := false;
//  SetLength( LANGUAGE_MANAGE_ARRAY_.SourceCode, 0 );
  FrmLanguage.MemoGlobalPas.Lines.Clear;

  if FindFirst( ExtractFileDir( application.exename ) + '\' + '*.pas', faAnyFile, SearchRec ) = 0 then
    Repeat
    fname := ExtractFileDir( application.exename ) + '\' + SearchRec.Name;
    if ( LowerCase( ExtractFileName( fName ) ) = LowerCase( 'Language.pas' ) ) then
      continue;

    if FileExists( fname ) then
      begin
      data := TStringList.create;
      data.LoadFromFile( fname );

      for i := 0 to data.Count-1 do
        begin
        Line := data.Strings[ i ];
        while IsWm( Line, '*' + INTERNAL_GET_CODESTRING_ + '*, * )*' ) AND ( Length( Line )-1 > Length( INTERNAL_GET_CODESTRING_ )+7-1 ) do
          begin
          helpStr := copy( Line, pos( INTERNAL_GET_CODESTRING_, Line ){Start}, Length( Line )-1 );
          j := 1;
          while ( NOT IsWm( copy( helpStr, 1, j ), INTERNAL_GET_CODESTRING_MASK_ ) ) AND ( j < 255 ) do
            inc( j );
          if j <> 255 then
            helpStr := copy( helpStr, 1, j-1 );
          helpStr := copy( helpStr, Length( INTERNAL_GET_CODESTRING_ )+1, Length( helpStr ) );
          Line := copy( Line, pos( INTERNAL_GET_CODESTRING_, Line ) + Length( INTERNAL_GET_CODESTRING_ ) + Length( helpStr ), Length( Line ) );

          ID := {StringToWideString( }INTERNAL_PREFIX_ + '.' + INTERNAL_STRING_PREFIX_ + '.' + StringReplace( SearchRec.Name, '.', ':', [ rfReplaceAll ] ) + '.' + StringReplace( GetTok( helpStr, 1, ',' ), ' ', '', [ rfReplaceAll ] ) + '.'{, LANGUAGE_CODEPAGE_ )};
          Value := {StringToWideString( }GetTok( helpStr, 2, NumTok( helpStr, ',' ), ',' ){, LANGUAGE_CODEPAGE_ )};
          Value := Trim( Value );

          if ( LeftStr( Value, 1 ) = #39 ) AND ( RightStr( Value, 1 ) = #39 ) then
            Value := TrimLineFromLeft( TrimLineFromRight( Value, 1 ), 1 )
          else if NumTok( Value, #39 ) > 1 then
            Value := GetTok( value, 2, NumTok( Value, #39 ), #39 );

          FrmLanguage.MemoGlobalPas.Lines.Add( ID + ';' + Value );

          //Keep Stringfinder Up2Date
          if ( StrToIntDef( GetTok( ID, 4, '.' ),0 ) > ( StrToIntDef( FrmLanguage.lbledtFortlaufendeNr.Text,0 )-1 ) ) then
             begin
             languageReplacer.RunningCounter := StrToInt( GetTok( ID, 4, '.' ) )+1;
             FrmLanguage.lbledtFortlaufendeNr.Text := IntToStr( languageReplacer.RunningCounter );
             end;
          end;
        result := true;
        end;
      data.free;
      end;
    Until ( FindNext( SearchRec ) <> 0 );
  SysUtils.FindClose( SearchRec );
  FrmLanguage.MemoGlobalPas.Lines.Assign( FilterDublicateEntries( FrmLanguage.MemoGlobalPas.Lines ) );
end;

procedure tLanguager.RefreshCodeString;
var
  i,j   : integer;
  s     : WideString;
begin
  for i := 1 to SourceCodeStrings.RowCount-1 do
    begin
    for j := 1 to SourceCodeStrings.ColCount-1 do
      SourceCodeStrings.Cells[ j, i ] := ''
    end;
  SourceCodeStrings.RowCount := Length( LANGUAGE_MANAGE_ARRAY_.SourceCode )+1;

  for i := 0 to Length( LANGUAGE_MANAGE_ARRAY_.SourceCode )-1 do
    begin
    s := GetTok( LANGUAGE_MANAGE_ARRAY_.SourceCode[ i ].ID, 3, 4, '.' ) + '.';
//    SourceCodeStrings.cells[ 1, SourceCodeStrings.RowCount-1 ] := WideStringToString( LANGUAGE_MANAGE_ARRAY_.SourceCode[ i ].ID, LANGUAGE_CODEPAGE_ );
    {$IFNDEF UNICODE}
    SourceCodeStrings.cells[ 1, i+1 ] := WideStringToString( s, LANGUAGE_CODEPAGE_ );
    SourceCodeStrings.cells[ 2, i+1 ] := WideStringToString( LANGUAGE_MANAGE_ARRAY_.SourceCode[ i ].Value, LANGUAGE_CODEPAGE_ );
    {$ELSE}
    SourceCodeStrings.cells[ 1, i+1 ] := s;
    SourceCodeStrings.cells[ 2, i+1 ] := LANGUAGE_MANAGE_ARRAY_.SourceCode[ i ].Value;
    {$ENDIF}
    end;
  CorrectColumns( SourceCodeStrings );

  FrmLanguage.PnlSourceStringsHeader.Caption := CSGridSourceCodeStrings_Header + ' [' + IntToStr( SourceCodeStrings.RowCount-1 ) + ']';
end;

function tLanguager.TriggerComponentVisible( component: String; onlyVisible: boolean ): boolean;
var
    sub1, sub2, sub3 : string;
    form             : TWinControl;
    comp,
    pComp            : tComponent;
begin
  result := false;

  if ( component = '' ) Or ( NumTok( component, '.' ) < 3 ) then
    Exit;

  sub1{=formular} := GetTok( component, 1, '.' );
  sub2{=object}   := GetTok( component, 2, '.' );
  sub3{=property} := GetTok( component, 3, '.' );

  if ( LowerCase( sub1 ) = LowerCase( INTERNAL_PREFIX_ ) ) then
    Exit;

  if FindFormByName( sub1, form ) then
    begin
    if sub2{=object} = 'Self' then// is Form
      begin
//      Languager.SetProperty( form, NIL, sub3 );
      end
    else if FindComponentByName( form, sub2, comp ) then
      begin
      if NOT form.Visible then
        begin
        FlashComponentForm := form;
        form.Show;
        end;

      pComp := comp;
      while NOT ( ( pComp is TForm ) OR ( pComp is TFrame ) ) AND Assigned( pComp ) do
        begin
        if ( pComp is TTabSheet ) then
          if ( ( pComp as TTabSheet ).parent is TPageControl ) then
            if ( ( ( pComp as TTabSheet ).parent as TPageControl ).ActivePage <> ( pComp as TTabSheet ) ) then
               begin
               ( ( pComp as TTabSheet ).parent as TPageControl ).ActivePage := ( pComp as TTabSheet );
               break;
               end;

        pComp := pComp.GetParentComponent;
        if pComp = nil then
          break;
        end;

      pComp := comp.GetParentComponent;
      while NOT ( ( pComp is TForm ) OR ( pComp is TFrame ) ) AND Assigned( pComp ) do
        begin
        if IsPublishedProp( pComp, 'Visible' ) then
          begin
          if NOT ( GetPropValue( pComp, 'Visible' ) ) then
            begin
            FlashComponentVisibles := FlashComponentVisibles + ' ' + pComp.Name;
            SetPropValue( pComp, 'Visible', true );
            end;
          end;
        pComp := pComp.GetParentComponent;
        if pComp = nil then
          break;
        end;

      result := true;
      if onlyVisible then
        begin
        if IsPublishedProp( comp, 'Visible' ) then
          SetPropValue( comp, 'Visible', True )
        else
          result := false;
        end
      else
        begin
        if IsPublishedProp( comp, 'Visible' ) then
          SetPropValue( comp, 'Visible', NOT GetPropValue( comp, 'Visible' ) )
        else
          result := false;
        end;
      end;
    end;
end;

function tLanguager.TriggerComponentText( component, text : String ): boolean;
var
  sub1 : string;
  sub2 : string;
  sub3 : string;
  form : TWinControl;
  comp : tComponent;
  v    : Variant;
  StrL : TStringList;
  Obj  : TObject;
begin
  result := false;

  if ( FlashComponentText = '' ) and ( text = '' ) then
    Exit;

  if ( component = '' ) Or ( NumTok( component, '.' ) < 3 ) then
    Exit;

  sub1{=formular} := GetTok( component, 1, '.' );
  sub2{=object}   := GetTok( component, 2, '.' );
  sub3{=property} := GetTok( component, 3, '.' );

  if ( LowerCase( sub1 ) = LowerCase( INTERNAL_PREFIX_ ) ) then
    Exit;

  if FindFormByName( sub1, form ) then
    begin
    if sub2{=object} = 'Self' then// is Form
      begin
//      Languager.SetProperty( form, NIL, sub3 );
      end
    else if FindComponentByName( form, sub2, comp ) then
      begin
      result := true;

      if ( Text <> '' ) then
        begin
        // TeeChart
        if ( comp.ClassNameIs( 'TChart' ) ) then
          begin
          if IsPublishedProp( comp, 'Title' ) then
            begin
            Obj := GetObjectProp( comp, 'Title' );
            if IsPublishedProp( Obj, 'Text' ) then
              begin
              v := GetPropValue( Obj, 'Text' );
              StrL := TStringList.Create;
              StrL.Assign( TPersistent( Integer( v ) ) );
              FlashComponentText := StrL.Text;
              StrL.Text := Text;
              TPersistent( Integer( v ) ).Assign( StrL );
              FreeAndNil( StrL );
              end;
            end;
          end

        else if IsPublishedProp( comp, 'caption' ) then
          begin
          FlashComponentText := GetPropValue( comp, 'caption' );
          SetPropValue( comp, 'caption', text );
          end
        else if IsPublishedProp( comp, 'text' ) then
          begin
          FlashComponentText := GetPropValue( comp, 'text' );
          SetPropValue( comp, 'text', text );
          end
        else if IsPublishedProp( comp, 'Lines' ) then
          begin
          StrL := TStringList.Create;

          v := GetPropValue( comp, 'Lines' );
          StrL.Assign( TPersistent( Integer( v ) ) );
          FlashComponentText := StrL.Text;

          StrL.Text := text;
          TPersistent( Integer( v ) ).Assign( StrL );

          FreeAndNil( StrL );
          end
        else if IsPublishedProp( comp, 'Items' ) then
          begin
          StrL := TStringList.Create;

          v := GetPropValue( comp, 'Items' );
          StrL.Assign( TPersistent( Integer( v ) ) );
          FlashComponentText := StrL.Text;

          StrL.Text := text;
          TPersistent( Integer( v ) ).Assign( StrL );

          FreeAndNil( StrL );
          end
        else
          result := false;
        end
      else
        begin
        // TeeChart
        if ( comp.ClassNameIs( 'TChart' ) ) then
          begin
          if IsPublishedProp( comp, 'Title' ) then
            begin
            Obj := GetObjectProp( comp, 'Title' );
            if IsPublishedProp( Obj, 'Text' ) then
              begin
              v := GetPropValue( Obj, 'Text' );
              StrL := TStringList.Create;
              StrL.Assign( TPersistent( Integer( v ) ) );
              StrL.Text := FlashComponentText;
              TPersistent( Integer( v ) ).Assign( StrL );
              FreeAndNil( StrL );
              end;
            end;
          end

        else if IsPublishedProp( comp, 'caption' ) then
          SetPropValue( comp, 'caption', FlashComponentText )
        else if IsPublishedProp( comp, 'text' ) then
          SetPropValue( comp, 'text', FlashComponentText )
        else if IsPublishedProp( comp, 'Lines' ) then
          begin
          StrL := TStringList.Create;
          v := GetPropValue( comp, 'Lines' );
          StrL.Text := FlashComponentText;
          TPersistent( Integer( v ) ).Assign( StrL );
          FreeAndNil( StrL );
          end
        else if IsPublishedProp( comp, 'Items' ) then
          begin
          StrL := TStringList.Create;
          v := GetPropValue( comp, 'Items' );
          StrL.Text := FlashComponentText;
          TPersistent( Integer( v ) ).Assign( StrL );
          FreeAndNil( StrL );
          end
        else
          result := false;
        end;
      end;
    end;
end;

function tLanguager.ReturnFormByName( formName: string ): TWinControl;
begin
  result := nil;
  FindFormByName( formName, result );
end;

function tLanguager.FindFormByName( formName: string; var form: TWinControl ): boolean;
var
  i, j  : integer;
  chain : TStringDynArray;
  c     : TComponent;
  found : Boolean;
begin
  result := false;
  if ( formName = '' ) then
    Exit;

  chain := Tokenize( formName, '>' );
  c := Application;
  for i := Low( chain ) to High( chain ) do
    begin
    found := false;
    for j := 0 to c.ComponentCount - 1 do
      begin
      if NOT ( LowerCase( c.Components[ j ].Name ) = LowerCase( chain[ i ] ) ) then
        Continue;
      c := c.Components[ j ];
      found := True;

      if ( c is TWinControl ) AND ( i = High( chain ) ) then // Form or Frame
        begin
        form := TWinControl( c );
        result := true;
        end;
      break;
      end;
    if not found then
      break;
    end;
  SetLength( chain, 0 );
end;

function tLanguager.FindComponentByName( form: TWinControl; compoName: string; var comp: tComponent ): boolean;
//var
//  compI : integer;
begin
  comp := form.FindComponent( compoName );
  result := ( comp <> nil );

//  result := false;
//  for compI := 0 to form.ComponentCount - 1 do
//    begin
//    if NOT ( LowerCase( form.Components[ compI ].Name ) = LowerCase( compoName ) ) then
//      Continue;
//
//    comp := form.Components[ compI ];
//    result := true;
//    break;
//    end;
end;

procedure tLanguager.ShowObjectsInStringlist;
var
  formI, compI, rgI, i                 : integer;//counter
  form                                 : TWinControl;
  comp                                 : TObject;
  formName, compName                   : string;
  excluded                             : boolean;
  v                                    : Variant;
  StrL                                 : TStringList;
  Obj                                  : TObject;
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  procedure AddObjectProperty( bez, val : string );
    begin
    if ( val = '' ) then
      Exit;

    // Replace CR/LF with String-Versions
    Val := StringReplace( Val, #10, INTERNAL_REPLACE_LF, [ rfReplaceAll ] ); // LF
    Val := StringReplace( Val, #13, INTERNAL_REPLACE_CR, [ rfReplaceAll ] ); // CR

    if ( Length( LANGUAGE_MANAGE_ARRAY_.Runtime ) = 0 ) then
      SetLength( LANGUAGE_MANAGE_ARRAY_.Runtime,Length( LANGUAGE_MANAGE_ARRAY_.Runtime )+1 )
    else if ( LANGUAGE_MANAGE_ARRAY_.Runtime[ Length( LANGUAGE_MANAGE_ARRAY_.Runtime )-1 ].ID <> '' ) then
      SetLength( LANGUAGE_MANAGE_ARRAY_.Runtime,Length( LANGUAGE_MANAGE_ARRAY_.Runtime )+1 );

    LANGUAGE_MANAGE_ARRAY_.Runtime[ Length( LANGUAGE_MANAGE_ARRAY_.Runtime )-1 ].ID := LowerCase( bez );
    LANGUAGE_MANAGE_ARRAY_.Runtime[ Length( LANGUAGE_MANAGE_ARRAY_.Runtime )-1 ].Value := Val;
    end;
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  function AllowedProperty( value : string ) : Boolean;
  var
    i : integer;
  begin
    Result := false;
    for i := 0 to FrmLanguage.chklstPropertys.Items.Count-1 do
      begin
      if ( LowerCase( FrmLanguage.chklstPropertys.Items.Strings[ i ] ) = LowerCase( value ) ) AND FrmLanguage.chklstPropertys.Checked[ i ] then
        begin
        result := true;
        break;
        end;
      end;
  end;
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
begin
  if not assigned( formsList ) then
    exit;
  Application.ProcessMessages;

  if ( RuntimeCompsNotInFileList.RowCount > 1 ) then
    RuntimeCompsNotInFileList.Clear( True, False );
  RuntimeCompsNotInFileList.RowCount := 1;
  SetLength( LANGUAGE_MANAGE_ARRAY_.Runtime, 0 );

  compsInRuntimeList.Font.Charset := LANGUAGE_CHARSET_;
  for formI := 0 to formslist.Items.Count - 1 do
    begin
    //ein Formular nach dem anderen abfragen
    if NOT formslist.Checked[ formI ] then//nur markierte forms abfragen
      Continue;

    formName := formslist.items[ formI ];
    if NOT FindFormByName( formName, form ) then
      Continue;

    excluded := false;
    for i := 0 to Length( LANGUAGE_MANAGE_ARRAY_.Exclusion )-1 do // Excluded
      begin
      if ( LowerCase( formName + '.Self'{.caption} ) = LowerCase( LANGUAGE_MANAGE_ARRAY_.Exclusion[ i ] ) ) then
        begin
        excluded := true;
        break;
        end;
      end;
    if NOT excluded AND AllowedProperty( 'Self.Caption' ) then
      begin
      if ( form is TForm ) then
        AddObjectProperty( formName + '.Self.caption.', TForm( form ).Caption )
      end;

    for compI := 0 to form.ComponentCount - 1 do
      begin
      excluded := false;
      comp := form.Components[ compI ];

      if ( comp = speechcomponent ) then
        Continue;

      if ( ( comp as tComponent ).name = '' ) then
         Continue; // Dynamic Object - die silently.

      {if ( formName = FrmLanguage.name ) then
         begin
         if ( LowerCase( ( comp as tComponent ).name ) = LowerCase( 'MemoSourcefile' ) ) OR ( LowerCase( ( comp as tComponent ).name ) = LowerCase( 'MemoGlobalPas' ) ) then
            continue; // No need ..
         end;}
      compName := formName + '.' + ( comp as tComponent ).name;

      if ( comp.ClassNameIs( 'TRadioGroup' ) OR comp.ClassNameIs( 'TRadioGroup' ) ) AND ( comp = speechcomponent ) then
        Continue;

      for i := 0 to Length( LANGUAGE_MANAGE_ARRAY_.Exclusion )-1 do // Excluded
        begin
        if ( LowerCase( compName ) = LowerCase( LANGUAGE_MANAGE_ARRAY_.Exclusion[ i ] ) ) then
          begin
          excluded := true;
          break;
          end;
        end;
      if ( excluded ) then
        continue;

      if IsPublishedProp( comp, 'Caption' ) AND AllowedProperty( 'Caption' ) then
        AddObjectProperty( compName + '.caption.', GetPropValue( comp, 'Caption' ) );
      if IsPublishedProp( comp, 'Text' ) AND AllowedProperty( 'Text' ) then
        AddObjectProperty( compName + '.text.', GetPropValue( comp, 'Text' ) );
      if IsPublishedProp( comp, 'Hint' ) AND AllowedProperty( 'Hint' ) then
        AddObjectProperty( compName + '.hint.', GetPropValue( comp, 'Hint' ) );
//              if IsPublishedProp( comp, 'Title' ) AND AllowedProperty( 'Title' ) then
//                AddObjectProperty( compName + '.title.', GetPropValue( comp, 'Title' ) );

      if IsPublishedProp( comp, 'Items' ) AND AllowedProperty( 'Items' ) then // TRadioGroup, TListBox, TComboBox, TComboBoxEx
        begin
        if ( comp.ClassType = TMenu ) OR ( comp.ClassType = TPopupMenu ) then
          begin

          end
        else
          begin
          v := GetPropValue( comp, 'Items' );
          StrL := TStringList.Create;
          StrL.Assign( TPersistent( Integer( v ) ) );
          for rgI := 0 to StrL.Count - 1 do
            AddObjectProperty( compName + '.items.' + IntToStr( rgI ) + '.', StrL[ rgI ] );
          FreeAndNil( StrL );
          end;
        end
      else if IsPublishedProp( comp, 'Lines' ) AND AllowedProperty( 'Lines' ) then // TMemo
        begin
        v := GetPropValue( comp, 'Lines' );
        StrL := TStringList.Create;
        StrL.Assign( TPersistent( Integer( v ) ) );
        for rgI := 0 to StrL.Count - 1 do
          AddObjectProperty( compName + '.items.' + IntToStr( rgI ) + '.', StrL[ rgI ] );
        FreeAndNil( StrL );
        end
      else if IsPublishedProp( comp, 'Tabs' ) AND AllowedProperty( 'Tabs' ) then // TTabControl
        begin
        v := GetPropValue( comp, 'Tabs' );
        StrL := TStringList.Create;
        StrL.Assign( TPersistent( Integer( v ) ) );
        for rgI := 0 to StrL.Count - 1 do
          AddObjectProperty( compName + '.items.' + IntToStr( rgI ) + '.', StrL[ rgI ] );
        FreeAndNil( StrL );
        end;

      if ClassIsOrIsDescendent( comp, 'TLabeledEdit' ) AND AllowedProperty( 'Caption' ) then
        begin
        if IsPublishedProp( comp, 'EditLabel' ) then
          begin
          obj := GetObjectProp( comp, 'EditLabel' );
          if IsPublishedProp( Obj, 'Caption' ) then
            AddObjectProperty( compName + '.caption.', GetPropValue( Obj, 'Caption' ) );
          end;
        end

      // TeeChart
      else if comp.ClassNameIs( 'TChart' ) then
        begin
        if IsPublishedProp( comp, 'LeftAxis' ) AND AllowedProperty( 'LeftAxis.Title.Caption' ) then
          begin
          Obj := GetObjectProp( comp, 'LeftAxis' );
          if IsPublishedProp( Obj, 'Title' ) then
            begin
            Obj := GetObjectProp( Obj, 'Title' );
            if IsPublishedProp( Obj, 'Caption' ) then
              AddObjectProperty( compName + '.LeftAxisCaption.', GetPropValue( Obj, 'Caption' ) );
            end;
          end;
        if IsPublishedProp( comp, 'RightAxis' ) AND AllowedProperty( 'RightAxis.Title.Caption' ) then
          begin
          Obj := GetObjectProp( comp, 'RightAxis' );
          if IsPublishedProp( Obj, 'Title' ) then
            begin
            Obj := GetObjectProp( Obj, 'Title' );
            if IsPublishedProp( Obj, 'Caption' ) then
              AddObjectProperty( compName + '.RightAxisCaption.', GetPropValue( Obj, 'Caption' ) );
            end;
          end;
        if IsPublishedProp( comp, 'TopAxis' ) AND AllowedProperty( 'TopAxis.Title.Caption' ) then
          begin
          Obj := GetObjectProp( comp, 'TopAxis' );
          if IsPublishedProp( Obj, 'Title' ) then
            begin
            Obj := GetObjectProp( Obj, 'Title' );
            if IsPublishedProp( Obj, 'Caption' ) then
              AddObjectProperty( compName + '.TopAxisCaption.', GetPropValue( Obj, 'Caption' ) );
            end;
          end;
        if IsPublishedProp( comp, 'BottomAxis' ) AND AllowedProperty( 'BottomAxis.Title.Caption' ) then
          begin
          Obj := GetObjectProp( comp, 'BottomAxis' );
          if IsPublishedProp( Obj, 'Title' ) then
            begin
            Obj := GetObjectProp( Obj, 'Title' );
            if IsPublishedProp( Obj, 'Caption' ) then
              AddObjectProperty( compName + '.BottomAxisCaption.', GetPropValue( Obj, 'Caption' ) );
            end;
          end;
        if IsPublishedProp( comp, 'Title' ) AND AllowedProperty( 'Title.Text' ) then
          begin
          Obj := GetObjectProp( comp, 'Title' );
          if IsPublishedProp( Obj, 'Text' ) then
            begin
            v := GetPropValue( Obj, 'Text' );
            StrL := TStringList.Create;
            StrL.Assign( TPersistent( Integer( v ) ) );
            for rgI := 0 to StrL.Count - 1 do
              AddObjectProperty( compName + '.TitleText.' + IntToStr( rgI ) + '.', StrL[ rgI ] );
            FreeAndNil( StrL );
            end;
          end;
        end
      end;
    end;


  if ( Length( LANGUAGE_MANAGE_ARRAY_.Runtime ) > 0 ) then
    begin
    compsInRuntimeList.RowCount := Length( LANGUAGE_MANAGE_ARRAY_.Runtime )+1;
    for i := 0 to Length( LANGUAGE_MANAGE_ARRAY_.Runtime )-1 do
      begin
      compsInRuntimeList.Cells[ 0, i+1 ] := LANGUAGE_MANAGE_ARRAY_.Runtime[ i ].ID;
      compsInRuntimeList.Cells[ 1, i+1 ] := LANGUAGE_MANAGE_ARRAY_.Runtime[ i ].Value;
      end;
    end
  else
    compsInRuntimeList.RowCount := 1;

  CorrectColumns( compsInRuntimeList );
  FindRtCompsNotInCompFileList;
  FindRtFileListCompsNotInRuntimeList;

  FrmLanguage.PnlLaufzeitKomponentenHeader.Caption := CSGridCompsInRuntimeList_Header + ' [' + IntToStr( compsInRuntimeList.RowCount-1 ) + ']';
end;

procedure tLanguager.FormsListOnDblClick( Sender: TObject );
//das geklickte Formular anzeigen
var dum: string;
    form: TWinControl;
begin
  dum := formsList.items[ formsList.ItemIndex ];
  if FindFormByName( dum, form ) then
    begin
    if ( form is TForm ) then
      TForm( form ).Show
    else if ( form is TFrame ) then
      TFrame( form ).Show;
    end;
end;

procedure tLanguager.LoadForms;
//setzt Haken bei den Formularen der application, die in forms.dat gespeichert wurden
var i, j : integer;
    cl : TWideStringList;
    d : string;
begin
  if not assigned( formsList ) then
    exit;

  d := LANGUAGE_DIRECTORY_ + INTERNAL_FORMS_FILE;
  cl := TWideStringList.create;

  if FileExists( d ) then
    cl.LoadFromFile( d )
  else
    exit;
  for i := 0 to formsList.items.Count - 1 do
    begin
    for j := 0 to cl.count - 1 do
      begin
      if cl[ j ] = formsList.items[ i ] then
        formsList.Checked[ i ] := true;
      end;
    end;
  FreeAndNil( cl );
end;

procedure tLanguager.SaveForms;
var i : integer;
    cl : TWideStringList;
    d : string;
begin
  if not assigned( formsList ) then
    exit;
  d := LANGUAGE_DIRECTORY_ + INTERNAL_FORMS_FILE;
  cl := TWideStringList.create;

  for i := 0 to formsList.items.Count - 1 do
    begin
    if formsList.Checked[ i ] then
      cl.Add( formsList.items[ i ] );
    end;

  try
  if NOT DirectoryExists( LANGUAGE_DIRECTORY_ ) then
    begin
    if ForceDirectories( LANGUAGE_DIRECTORY_ ) then
      cl.SaveToFile( d );
    end
  else
    cl.SaveToFile( d );
  finally
    FreeAndNil( cl );
  end;
end;

procedure tLanguager.ShowForms;
  procedure Recurse( chain : string; comp : TComponent );
  var
    i : integer;
    c : TComponent;
    nChain : string;
  begin
    for i := 0 to comp.ComponentCount - 1 do
      begin
      c := comp.Components[ i ];
      if NOT ( c is TWinControl ) then
        Continue;
      if ( TWinControl( c ).Name = '' ) then // Ignore ..
        Continue;

      nChain := IfThen( chain <> '', chain+'>', chain ) + TWinControl( c ).name;
      if ( c is TForm ) OR ( c is TFrame ) then
        formsList.items.Add( nChain );
      Recurse( nChain, c );
      end;
  end;

  procedure AddHorizontalScrollbar( Lst : TCustomListBox );
  var
    i, MaxWidth : Integer;
  begin
    MaxWidth := Lst.Width-1;
    for i := 0 to Lst.Count-1 do
      MaxWidth := Max( MaxWidth, Lst.Canvas.TextWidth( Lst.Items[i] ) );

    if ( MaxWidth = Lst.Width-1 ) then
      Lst.Perform( $0194{LB_SETHORIZONTALEXTENT}, 0, 0 )
    else
      Lst.Perform( $0194{LB_SETHORIZONTALEXTENT}, MaxWidth+4, 0 );  
  end;

begin
  if not assigned( formsList ) then
    exit;

  formsList.items.clear;
  Recurse( '', Application );
  AddHorizontalScrollbar( formsList );
  LoadForms;
  ShowObjectsInStringlist;
end;

procedure tLanguager.Init( fl: tCheckListBox;
                                       _compsInRuntimeList : TStringGrid;
                                       _compsInFileList,
                                       _runtimeCompsNotInFileList,
                                       _fileListCompsNotInRuntimeList,
                                       _sourceStrings       : TCheckStringGrid );

     procedure InitGrids( sg: TStringGrid );
     begin
       if NOT Assigned( sg ) then
         Exit;

       sg.Align := AlClient;
       sg.DefaultRowHeight := 18;
       sg.Options := [ goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goColSizing,goTabs,goRowSelect ];
       sg.RowCount := 1;
       sg.FixedRows := 0; // Setup later.. since Fixeds can't be equal or above RowCount
       if sg.ClassNameIs( 'TCheckStringGrid' ) then
         begin
         sg.ColCount := 3;
         sg.FixedCols := 1;
         sg.ColWidths[ 0 ] := 18;
         sg.cells[ 1, 0 ] := INTERNAL_GRID_HEADER_1_;
         sg.cells[ 2, 0 ] := INTERNAL_GRID_HEADER_2_;
         TCheckStringGrid( sg ).SelectedRowColoring := True;
         TCheckStringGrid( sg ).CheckedRowColoring := True;          
         end
       else
         begin
         sg.ColCount := 2;
         sg.FixedCols := 0;
         sg.cells[ 0, 0 ] := INTERNAL_GRID_HEADER_1_;
         sg.cells[ 1, 0 ] := INTERNAL_GRID_HEADER_2_;
         end;
       CorrectColumns( sg );
     end;
begin
  formsList  := fl;
  if Assigned( formsList ) then
    formsList.OnDblClick := FormsListOnDblClick;

  compsInRuntimeList := _compsInRuntimeList; // Runtime comps
  InitGrids( compsInRuntimeList );
  compsInFileList := _compsInFileList; // Compfile
  InitGrids( compsInFileList );
  SourceCodeStrings := _sourceStrings; // SourceStrings
  InitGrids( SourceCodeStrings );
  runtimeCompsNotInFileList := _runtimeCompsNotInFileList; // Runtimes not in compfile
  InitGrids( runtimeCompsNotInFileList );
  fileListCompsNotInRuntimeList := _fileListCompsNotInRuntimeList; // Compfile entrys not as Runtime
  InitGrids( fileListCompsNotInRuntimeList );
end;

constructor tLanguager.create;
begin
  inherited Create;
  fFileName := '';
  fSprachname := '';
    
  Init( NIL, NIL, NIL, NIL, NIL, NIL );
  LoadSavedLanguage; // No Forms created yet but there are still MessageDlgs and SourceCodeStrings .. 
end;

procedure tLanguager.LoadSavedLanguage;
var
  StrL : TWideStringList;
begin
  if NOT FileExists( LANGUAGE_DIRECTORY_ + INTERNAL_LANGUAGE_FILE ) then
    Exit;

  StrL := TWideStringList.Create;
  StrL.LoadFromFile( LANGUAGE_DIRECTORY_ + INTERNAL_LANGUAGE_FILE );
  if ( StrL.Count > 0 ) then
    ApplyLanguageFile( StrL[ 0 ] );
  StrL.free;
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

procedure tLanguageReplacer.CreateFileSik( ftype, fn: string );
var
  pfad, fn2 : string;
begin
  if ( ftype = 'source' ) then
    pfad := LANGUAGE_DIRECTORY_ + 'source-backup\'
  else
    pfad := LANGUAGE_DIRECTORY_ + 'compfile-backup\';

  if NOT ForceDirectories( pfad ) then
    begin
    MessageBox( Application.Handle, 'Unable to create backup-file: error during directory-creation',  'Warnung', mb_OK );
    exit;
    end;
  fn2 := ExtractFileName( fn ) + FormatDateTime( 'hh-nn-ss+dd-mm-yyyy', NOW ) + '.sik';
  if NOT CopyFile( PChar( fn ), PChar( pfad + fn2 ), True ) then
    MessageBox( Application.Handle, 'Unable to create backup-file: error during copy.', 'Warnung', mb_OK );
end;

function tLanguageReplacer.OpenFile( fn: string ): boolean;
begin
  result := false;

  if fileExists( fn ) then
    begin
//    CreateFileSik( 'source', fn );
    inData.lines.LoadFromFile( fn );
    filename := fn;
    position := 0;
    laenge   := 0;
    result   := true;
    end;
end;

function tLanguageReplacer.TextBoxChanged: boolean;
begin
  foundAppearance := false;
  result := languageReplacer.inData.Modified;
end;

procedure tLanguageReplacer.ResetfoundAppearance;
begin
  foundAppearance := false;
end;

function tLanguageReplacer.ReplaceText: boolean;
var
  cutText, cutTextC, insText, outText, spltLineStr : string;
  spltLineNum, i                                   : integer;
  wideStrHlp                                       : WideString;
begin
  if NOT foundAppearance then
    begin
    result := false;
    exit;
    end;
  spltLineNum := -1;
  cutText := inData.SelText;
  cutTextC := copy( cutText, 2, Length( cutText )-2 );

  if ( DublicateMode > 0 ) then
     begin
     for i := 0 to outDataPAS.Lines.Count-1 do // Current selection in Memo
         begin
         if ( GetTok( outDataPAS.Lines[ i ], 2, Numtok( spltLineStr, ';' ), ';' ) = cutTextC ) then
           begin
           wideStrHlp := GetTok( outDataPAS.Lines[ i ], 1, ';' );
           wideStrHlp := GetTok( wideStrHlp, Numtok( wideStrHlp, '.' ), '.' );
           {$IFNDEF UNICODE}
           spltLineNum := StrToInt( WideStringToString( wideStrHlp, LANGUAGE_CODEPAGE_ ) );
           {$ELSE}
           spltLineNum := StrToInt( wideStrHlp );
           {$ENDIF}
           end;
         end;

     for i := 0 to Length( LANGUAGE_MANAGE_ARRAY_.SourceCode )-1 do // Already known/saved selection
       begin
       if ( LANGUAGE_MANAGE_ARRAY_.SourceCode[ i ].Value = cutTextC ) then
         begin
         wideStrHlp := GetTok( LANGUAGE_MANAGE_ARRAY_.SourceCode[ i ].ID, NumTok( LANGUAGE_MANAGE_ARRAY_.SourceCode[ i ].ID, '.' ), '.' );
         {$IFNDEF UNICODE}
         spltLineNum := StrToInt( WideStringToString( wideStrHlp, LANGUAGE_CODEPAGE_ ) );
         {$ELSE}
         spltLineNum := StrToInt( wideStrHlp );
         {$ENDIF}
         end;
       end;
     end;


  if ( DublicateMode = 1 ) AND ( spltLineNum <> -1 ) Then
     begin
     insText := INTERNAL_GET_CODESTRING_ + ' ' + IntToStr( spltLineNum ) + ', ' + cutText + ' )';
     end
  else if ( DublicateMode = 2 ) AND ( spltLineNum <> -1 ) Then
     begin
     if ( MessageDlg( 'Dublikat erstellen von: "' + cutTextC + '"?' , mTConfirmation, [ mbYes, mbNo ], 0 ) = mrNo ) then
        begin
        insText := INTERNAL_GET_CODESTRING_ + ' ' + IntToStr( spltLineNum ) + ', ' + cutText + ' )';
        end
     else
        begin
        insText := INTERNAL_GET_CODESTRING_ + ' ' + IntToStr( RunningCounter ) + ', ' + cutText + ' )';
        outText := INTERNAL_PREFIX_ + '.' + INTERNAL_STRING_PREFIX_ + '.' + StringReplace( ExtractFileName( Filename ),'.',':',[ rfReplaceAll ] ) + '.' + IntToStr( RunningCounter ) + '.;' + copy( cutText, 2, length( cutText )-2 ) + ';';
        outDataPAS.Lines.Add( outText );
        Inc( RunningCounter );
        end;
     end
  else
     begin
     insText := INTERNAL_GET_CODESTRING_ + ' ' + IntToStr( RunningCounter ) + ', ' + cutText + ' )';
     outText := INTERNAL_PREFIX_ + '.' + INTERNAL_STRING_PREFIX_ + '.' + StringReplace( ExtractFileName( Filename ),'.',':',[ rfReplaceAll ] ) + '.' + IntToStr( RunningCounter ) + '.;' + copy( cutText, 2, length( cutText )-2 ) + ';';
     outDataPAS.Lines.Add( outText );
     Inc( RunningCounter );
     end;

  inData.SelText := insText;
  foundAppearance := false;
  position := position + Length( insText );
  laenge := 0;
  result := true;
end;

function tLanguageReplacer.FindNextChar( var varPos: integer; Reverse : boolean = false ): boolean;
var c: integer;
    data : string;
begin
  result := false;
  c      := varPos;
  data   := inData.lines.text;

  if ( Length( data ) = 0 ) then
    Exit;

  if ( c < 0 ) then // Nothing found yet
    Exit;

  if Reverse then
    begin
    while ( c > 1 ) AND ( data[ c ] <> ch ) do
      Dec( c );
    end
  else
    begin
    while ( c <= Length( data ) ) AND ( data[ c ] <> ch ) do
      Inc( c );
    end;

  if ( c > Length( data ) ) then
    Exit;
  if data[ c ] = ch then
    begin
    result := true;
    varPos := c;
    end;
end;

function tLanguageReplacer.AddUses : Boolean;
const
  UNIT_Name_ = 'Language';
var
  s, s2 : string;
  iUses1, iUses1End : Integer;
  iUses2, iUses2End : Integer;
  iImpl : Integer;
  i : Integer;
  StrL : TStrings;
  cI : Cardinal;
begin
  result := false;
  
  iImpl := -1;
  for i := 0 to inData.Lines.Count-1 do
    begin
    if ( StrNatCompare( 'implementation', Trim( inData.Lines[ i ] ), false ) = 0 ) then
      begin
      iImpl := i;
      break;
      end;
    end;
  if ( iImpl = -1 ) then
    Exit;

  iUses1 := 0;
  iUses2 := 0;
  cI := 1;
  for i := 0 to inData.Lines.Count-1 do
    begin
    if ( NOT ( StrNatCompare( 'uses', Trim( inData.Lines[ i ] ), false ) = 0 ) ) AND ( NOT IsWm( Trim( inData.Lines[ i ] ), 'uses *', false ) ) then
      begin
      Inc( cI, Length( inData.Lines[ i ] )+2 );
      Continue;
      end;

    if ( i < iImpl ) then
      iUses1 := cI
    else
      iUses2 := cI;

    Inc( cI, Length( inData.Lines[ i ] )+2 )
    end;

  if ( iUses1 = 0 ) AND ( iUses2 = 0 ) then
    Exit;
  s := LowerCase( inData.lines.Text );

  if ( iUses1 > 0 ) then
    begin
    iUses1 := PosEx( 'uses', s, iUses1 );
    if ( iUses1 = 0 ) then
      Exit;
    iUses1End := PosEx( ';', s, iUses1 );
    if ( iUses1End = 0 ) then
      Exit;

    s2 := Copy( s, iUses1, iUses1End-iUses1+1 );
    s2 := Remove( s2, #32 );
    s2 := Remove( s2, #13#10 );
    if IsIn( s2, UNIT_Name_ + ',', false ) or IsIn( s2, UNIT_Name_ + ';', false ) then 
      begin
      result := True;
      Exit;
      end
    end;

  if ( iUses2 > 0 ) then
    begin
    iUses2 := PosEx( 'uses', s, iUses2 );
    if ( iUses2 = 0 ) then
      Exit;
    iUses2End := PosEx( ';', s, iUses2 );
    if ( iUses2End = 0 ) then
      Exit;

    s2 := Copy( s, iUses2, iUses2End-iUses2+1 );
    s2 := Remove( s2, #32 );
    s2 := Remove( s2, #13#10 );    
    if IsIn( s2, UNIT_Name_ + ',', false ) or IsIn( s2, UNIT_Name_ + ';', false ) then
      begin
      result := True;
      Exit;
      end;

    s2 := Copy( inData.lines.Text, iUses2, iUses2End-iUses2+1 );
    s2 := TrimLineFromRight( s2, 1 );
    s2 := Format( '%s, %s;', [ s2, Unit_Name_ ] );

    StrL := ReplaceStringsAreal( inData.Lines, iUses2, iUses2End, s2 );
    inData.Lines.Assign( StrL );
    StrL.free;
    end
  else
    begin // No Implementation-Uses yet
    inData.Lines.Insert( iImpl+1, '  Languager;' ); // Inverse ..
    inData.Lines.Insert( iImpl+1, 'uses' );
    inData.Lines.Insert( iImpl+1, '' );
    end;
  result := True;
end;

function tLanguageReplacer.FindNextMark( Reverse : boolean = false ): boolean;
var p, p1, p2: integer;
    weitersuchen: boolean;
    kommentText : boolean;
    s : string;
    offset : Byte;
begin
  result := false;
  offset := ( Length( INTERNAL_GET_CODESTRING_ ) + 10{' 9999999, '} );

  repeat
    if Reverse then
      begin
      p := position - laenge - 1;
      laenge := 0;
      if NOT FindNextChar( p, Reverse ) then
        exit;

      p2 := p;
      p  := p - 1;

      if NOT FindNextChar( p, Reverse ) then
        exit;
      p1 := p;

      Position := p1 - 1;
      Laenge   := ( p2 - p1 ) + 1;
      end
    else
      begin
      p := position + laenge + 1;
      laenge := 0;
      if NOT FindNextChar( p, Reverse ) then
        exit;

      p1 := p;
      p  := p + 1;

      if NOT FindNextChar( p, Reverse ) then
        exit;
      p2 := p;

      Position := p1 - 1;
      Laenge   := ( p2 - p1 ) + 1;
      end;

    inData.SetFocus;
    inData.SelStart  := position;
    inData.SelLength := laenge;

    s := Copy( inData.Text, position - offset, laenge + offset + 5 );
    s := StringReplace( s, ' ', '', [ rfReplaceAll ] );
    kommentText := ( pos( INTERNAL_GET_CODESTRING_, s ) <> 0 );

    foundAppearance := true;
    weitersuchen := false;
    if LeerStringsUeberspringen AND ( ( inData.SelText = '''''' ) OR ( inData.SelText = ''' ''' ) ) then
      weitersuchen := true
    else
    if {schon}kommentiertesUeberspringen AND ( kommentText ) then
      weitersuchen := true;

    if weitersuchen then
      inData.SelLength := 0;

  until NOT weitersuchen;

  result := true;
end;

procedure tLanguageReplacer.Init( p, gsCounter : integer; c: char; iData, oDataPAS: tMemo; lsu, ku: boolean );
begin
  position   := p;
  ChangeRunningCounter( gsCounter );
  laenge     := 0;
  ch         := c;
  inData     := iData;
  outDataPAS := oDataPAS;
  LeerStringsUeberspringen := lsu;
  kommentiertesUeberspringen := ku;
  foundAppearance := false;
  DublicateMode := 2;

  filename := '';
end;

procedure tLanguageReplacer.ChangeRunningCounter( newValue: integer );
begin
  RunningCounter := newValue;
  if Assigned( FrmLanguage ) then
    FrmLanguage.lbledtFortlaufendeNr.Text := IntToStr( newValue );
end;

constructor tLanguageReplacer.create;
begin
  inherited Create;
  Init( 0, 1000, '''', NIL, NIL, true, true );
end;

function tLanguager.GetCharSet:integer;
var
  i : integer;
begin
  result := -1;
  for i := 0 to application.ComponentCount-1 do
    begin
    if ( NOT ( application.Components[ i ] is TForm ) ) AND NOT ( NOT ( application.Components[ i ] is TFrame ) ) then
      Continue;

    if ( IsPublishedProp( application.Components[ i ], 'Font' ) ) then
      begin
      result := ( GetObjectProp( application.Components[ i ], 'FONT' ) as TFont ).Charset;
      break;
      end;
    end;
end;

function tLanguager.ConvertDRC( FileName : string ) : TWideStringList;
var
  StrL    : TStringList;
  i, j, k : integer;
  ID      : Integer;
  Val     : String;
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  function CompToForm( comp : TComponent ) : TComponent;
    begin
    result := comp;
    while not ( ( Result is tForm ) OR ( Result is tFrame ) ) AND Assigned( result ) do
      Result := Result.Owner;
    end;
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
begin
  result := TWideStringList.Create;
  if NOT FileExists( fileName ) then
    Exit;

  StrL   := TStringList.Create;
  StrL.LoadFromFile( FileName );

  for i := 0 to StrL.Count-1 do
    begin
    if ( StrL[ i ] = '' ) then
      Continue;
    StrL[ i ] := Replace( StrL[ i ], #9, #32 ); // Tab to Space

    // Format 1 ( Direct )
    if ( IsWm( StrL[ i ], 'OFFSET_SPRACHE + *,*"*"' ) ) then
      begin
      ID  := StrToIntDef( Remove( Remove( GetTok( GetTok( StrL[ i ], 2, '+' ), 1, '"' ), ',' ), ' ' ), -1 );
      Val := GetTok( StrL[ i ], 2, '"' );
      Val := StringReplace( Val, #10, INTERNAL_REPLACE_LF, [ rfReplaceAll ] ); // LF
      Val := StringReplace( Val, #13, INTERNAL_REPLACE_CR, [ rfReplaceAll ] ); // CR
      if ( ID < 0 ) OR ( Val = '' ) then
        Continue;

      for j := 0 to application.ComponentCount - 1 do 
        begin
        if ( Application.Components[ j ].Tag = ID ) then
          result.Add( Format( '%s.Self.caption.;%s;', [ LowerCase( Application.Components[ j ].Name ), val ] ) )
        else
          begin
          for k := 0 to Application.Components[ j ].ComponentCount-1 do
            if ( Application.Components[ j ].Components[ k ].Tag = ID ) then
              result.Add( Format( '%s.%s.caption.;%s;', [ LowerCase( CompToForm( Application.Components[ j ] ).Name ), LowerCase( Application.Components[ j ].Components[ k ].Name ), val ] ) )
          end;
        end;
      end
    else if ( IsWm( StrL[ i ], 'OFFSETTEXTSTRINGS + OFFSET_SPRACHE + *,*"*"' ) ) then
      begin
      ID  := StrToIntDef( Remove( Remove( GetTok( GetTok( StrL[ i ], 3, '+' ), 1, '"' ), ',' ), ' ' ), -1 );
      Val := GetTok( StrL[ i ], 2, '"' );
      Val := StringReplace( Val, #10, INTERNAL_REPLACE_LF, [ rfReplaceAll ] ); // LF
      Val := StringReplace( Val, #13, INTERNAL_REPLACE_CR, [ rfReplaceAll ] ); // CR
      if ( ID < 0 ) OR ( Val = '' ) then
        Continue;

      result.Add( Format( '%s.%s.%s.%d.;%s;', [ INTERNAL_PREFIX_, INTERNAL_STRING_PREFIX_, 'unkown', ID, val ] ) );
      end

    // Format 2 ( Constantes )
    else if ( IsWm( StrL[ i ], 'Consts_string_*, *' ) ) then
      begin
      ID := -1;
      for j := 0 to StrL.Count-1 do
        begin
        if ( StrL[ j ] = '' ) then
          Continue;

        if ( IsWm( StrL[ j ], '#define ' + TrimLineFromRight( GetTok( StrL[ i ], 1, 32 ), 1 ) + ' *' ) ) then
          begin
          ID := StrToIntDef( GetTok( StrL[ j ], 3, 32 ), -1 );
          Break;
          end;
        end;

      Val := GetTok( StrL[ i ], 2, '"' );
      Val := StringReplace( Val, #10, INTERNAL_REPLACE_LF, [ rfReplaceAll ] ); // LF
      Val := StringReplace( Val, #13, INTERNAL_REPLACE_CR, [ rfReplaceAll ] ); // CR
      if ( ID < 0 ) OR ( Val = '' ) then
        Continue;

      result.Add( Format( '%s.%s.%s.%d.;%s;', [ INTERNAL_PREFIX_, INTERNAL_STRING_PREFIX_, 'unkown', ID, val ] ) );
      end

    else if ( IsWm( StrL[ i ], 'Consts_*, *' ) ) then
      begin
      ID := -1;      
      for j := 0 to StrL.Count-1 do
        begin
        if ( StrL[ j ] = '' ) then
          Continue;

        if ( IsWm( StrL[ j ], '#define ' + TrimLineFromRight( GetTok( StrL[ i ], 1, 32 ), 1 ) + ' *' ) ) then
          begin
          ID := StrToIntDef( GetTok( StrL[ j ], 3, 32 ), -1 );
          Break;
          end;
        end;

      Val := GetTok( StrL[ i ], 2, '"' );
      Val := StringReplace( Val, #10, INTERNAL_REPLACE_LF, [ rfReplaceAll ] ); // LF
      Val := StringReplace( Val, #13, INTERNAL_REPLACE_CR, [ rfReplaceAll ] ); // CR
      if ( ID < 0 ) OR ( Val = '' ) then
        Continue;

      for j := 0 to application.ComponentCount - 1 do
        begin
        if ( Application.Components[ j ].Tag = ID ) then
          result.Add( Format( '%s.Self.caption.;%s;', [ LowerCase( Application.Components[ j ].Name ), val ] ) )
        else
          begin
          for k := 0 to Application.Components[ j ].ComponentCount-1 do
            if ( Application.Components[ j ].Components[ k ].Tag = ID ) then
              result.Add( Format( '%s.%s.caption.;%s;', [ LowerCase( CompToForm( Application.Components[ j ] ).Name ), LowerCase( Application.Components[ j ].Components[ k ].Name ), val ] ) )
          end;
        end;
      end;
    end;
  FreeAndNil( StrL );
end;

procedure CorrectColumns( Grid : TStringGrid );
var
  i : integer;
begin
  if ( Grid.RowCount > 1 ) then
    Grid.FixedRows := 1; // ( re )Set here.. Fixeds cant be equal or above RowCount ( RowCount = 1 removed FixedRow aswell )

  if ( Grid is TCheckStringGrid ) then
    begin
    for i := 1 to Grid.RowCount-1 do
      TCheckStringGrid( Grid ).Component[ 0, i ] := csUnchecked;

    if Grid.ColCount < 3 then
      Exit;
    Grid.ColWidths[ 1 ] := ( Grid.width-Grid.ColWidths[ 0 ] ) div 2;
    if ( Grid.RowCount-1 > Grid.VisibleRowCount ) then // IsScrollBarVisible
      Grid.ColWidths[ 2 ] := Grid.width-( Grid.ColWidths[ 0 ]+Grid.ColWidths[ 1 ] )-24
    else
      Grid.ColWidths[ 2 ] := Grid.width-( Grid.ColWidths[ 0 ]+Grid.ColWidths[ 1 ] )-8;
    end
  else
    begin
    if Grid.ColCount < 2 then
      Exit;
    Grid.ColWidths[ 0 ] := Grid.width div 3;
    if ( Grid.RowCount-1 > Grid.VisibleRowCount ) then // IsScrollbarVisible
      Grid.ColWidths[ 1 ] := Grid.width-Grid.ColWidths[ 0 ]-24
    else
      Grid.ColWidths[ 1 ] := Grid.width-Grid.ColWidths[ 0 ]-10;
    end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function GetWindowsDlgString( ID: integer ): string;
{$IFNDEF UNICODE}
var
  ws : WideString;
{$ENDIF}
begin
  {$IFNDEF UNICODE}
  ws := GetWindowsDlgStringW( ID );
  result := WideStringToString( ws, LANGUAGE_CODEPAGE_ );
  {$ELSE}
  result := GetWindowsDlgStringW( ID );
  {$ENDIF}
end;

function GetWindowsDlgStringW( ID: integer ): WideString;
var
  i     : integer;
begin
  result := '';
  for i := Low( LANGUAGE_WDLG_CAPTIONS_ ) to High( LANGUAGE_WDLG_CAPTIONS_ ) do
    begin
    if ( LANGUAGE_WDLG_CAPTIONS_[ i ].ID = IntToStr( ID ) ) then
      begin
      result := LANGUAGE_WDLG_CAPTIONS_[ i ].value;
      Exit;
      end;
    end;
end;

function SetWindowsDlgString( ID: string; value: WideString ): boolean;
var
  i : integer;
begin
   result := false;
   for i := 0 to Length( LANGUAGE_WDLG_CAPTIONS_ )-1 do
     begin
     if ( LANGUAGE_WDLG_CAPTIONS_[ i ].ID = ID ) then
        begin
        LANGUAGE_WDLG_CAPTIONS_[ i ].ID    := ID;
        LANGUAGE_WDLG_CAPTIONS_[ i ].Value := value;
        result := true;
        break;
        end;
     end;
   if NOT result then
     begin
     if ( Length( LANGUAGE_WDLG_CAPTIONS_ ) = 0 ) then
       SetLength( LANGUAGE_WDLG_CAPTIONS_,Length( LANGUAGE_WDLG_CAPTIONS_ )+1 )
     else if ( LANGUAGE_WDLG_CAPTIONS_[ Length( LANGUAGE_WDLG_CAPTIONS_ )-1 ].ID <> '' ) then
       SetLength( LANGUAGE_WDLG_CAPTIONS_,Length( LANGUAGE_WDLG_CAPTIONS_ )+1 );
       
     LANGUAGE_WDLG_CAPTIONS_[ Length( LANGUAGE_WDLG_CAPTIONS_ )-1 ].ID := ID;
     LANGUAGE_WDLG_CAPTIONS_[ Length( LANGUAGE_WDLG_CAPTIONS_ )-1 ].Value := value;
     end;

   result := true;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure LangHookResourceStrings;
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
    ResStringRec^.Identifier := NativeUInt( NewStr );
    {$IFEND}
    VirtualProtect( ResStringRec, SizeOf( ResStringRec^ ), OldProtect, @OldProtect );
  end;
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  HookResourceString( @SYesButton, PChar( LANGUAGE_DLG_CAPTIONS_R_[ Integer( mbYes ) ] ) );
  HookResourceString( @SMsgDlgYes, PChar( LANGUAGE_DLG_CAPTIONS_R_[ Integer( mbYes ) ] ) );
  HookResourceString( @SNoButton, PChar( LANGUAGE_DLG_CAPTIONS_R_[ Integer( mbNo ) ] ) );
  HookResourceString( @SMsgDlgNo, PChar( LANGUAGE_DLG_CAPTIONS_R_[ Integer( mbNo ) ] ) );
  HookResourceString( @SOKButton, PChar( LANGUAGE_DLG_CAPTIONS_R_[ Integer( mbOk ) ] ) );
  HookResourceString( @SMsgDlgOK, PChar( LANGUAGE_DLG_CAPTIONS_R_[ Integer( mbOk ) ] ) );
  HookResourceString( @SCancelButton, PChar( LANGUAGE_DLG_CAPTIONS_R_[ Integer( mbCancel ) ] ) );
  HookResourceString( @SMsgDlgCancel, PChar( LANGUAGE_DLG_CAPTIONS_R_[ Integer( mbCancel ) ] ) );
  HookResourceString( @SAbortButton, PChar( LANGUAGE_DLG_CAPTIONS_R_[ Integer( mbAbort ) ] ) );
  HookResourceString( @SMsgDlgAbort, PChar( LANGUAGE_DLG_CAPTIONS_R_[ Integer( mbAbort ) ] ) );
  HookResourceString( @SRetryButton, PChar( LANGUAGE_DLG_CAPTIONS_R_[ Integer( mbRetry ) ] ) );
  HookResourceString( @SMsgDlgRetry, PChar( LANGUAGE_DLG_CAPTIONS_R_[ Integer( mbRetry ) ] ) );
  HookResourceString( @SIgnoreButton, PChar( LANGUAGE_DLG_CAPTIONS_R_[ Integer( mbIgnore ) ] ) );
  HookResourceString( @SMsgDlgIgnore, PChar( LANGUAGE_DLG_CAPTIONS_R_[ Integer( mbIgnore ) ] ) );
  HookResourceString( @SAllButton, PChar( LANGUAGE_DLG_CAPTIONS_R_[ Integer( mbAll ) ] ) );
  HookResourceString( @SMsgDlgAll, PChar( LANGUAGE_DLG_CAPTIONS_R_[ Integer( mbAll ) ] ) );
  HookResourceString( @SMsgDlgNoToAll, PChar( LANGUAGE_DLG_CAPTIONS_R_[ Integer( mbNoToAll ) ] ) );
  HookResourceString( @SMsgDlgYesToAll, PChar( LANGUAGE_DLG_CAPTIONS_R_[ Integer( mbYesToAll ) ] ) );
  HookResourceString( @SHelpButton, PChar( LANGUAGE_DLG_CAPTIONS_R_[ Integer( mbHelp ) ] ) );
  HookResourceString( @SMsgDlgHelp, PChar( LANGUAGE_DLG_CAPTIONS_R_[ Integer( mbHelp ) ] ) );
  HookResourceString( @SMsgDlgHelpHelp, PChar( LANGUAGE_DLG_CAPTIONS_R_[ Integer( mbHelp ) ] ) );
  {$IF CompilerVersion >= 30}
  HookResourceString( @SCloseButton, PChar( LANGUAGE_DLG_CAPTIONS_R_[ Integer( mbClose ) ] ) );
  HookResourceString( @SMsgDlgClose, PChar( LANGUAGE_DLG_CAPTIONS_R_[ Integer( mbClose ) ] ) );
  {$IFEND}
  HookResourceString( @SMsgDlgWarning, PChar( LANGUAGE_DLG_CAPTIONS_R_[ Integer( mbHelp )+2 ] ) );
  HookResourceString( @SMsgDlgError, PChar( LANGUAGE_DLG_CAPTIONS_R_[ Integer( mbHelp )+3 ] ) );
  HookResourceString( @SMsgDlgInformation, PChar( LANGUAGE_DLG_CAPTIONS_R_[ Integer( mbHelp )+4 ] ) );
  HookResourceString( @SMsgDlgConfirm, PChar( LANGUAGE_DLG_CAPTIONS_R_[ Integer( mbHelp )+5 ] ) );
end;

procedure LangMessageDlgInitCaptions( Mode : Byte = 1 );
var
  i : integer;
begin
  case Mode of
    0 : begin
        LANGUAGE_DLG_CAPTIONS_[ Integer( mbYes ) ]      := LoadResString( @SMsgDlgYes         );
        LANGUAGE_DLG_CAPTIONS_[ Integer( mbNo ) ]       := LoadResString( @SMsgDlgNo          );
        LANGUAGE_DLG_CAPTIONS_[ Integer( mbOK ) ]       := LoadResString( @SMsgDlgOK          );
        LANGUAGE_DLG_CAPTIONS_[ Integer( mbCancel ) ]   := LoadResString( @SMsgDlgCancel      );
        LANGUAGE_DLG_CAPTIONS_[ Integer( mbAbort ) ]    := LoadResString( @SMsgDlgAbort       );
        LANGUAGE_DLG_CAPTIONS_[ Integer( mbRetry ) ]    := LoadResString( @SMsgDlgRetry       );
        LANGUAGE_DLG_CAPTIONS_[ Integer( mbIgnore ) ]   := LoadResString( @SMsgDlgIgnore      );
        LANGUAGE_DLG_CAPTIONS_[ Integer( mbAll ) ]      := LoadResString( @SMsgDlgAll         );
        LANGUAGE_DLG_CAPTIONS_[ Integer( mbNoToAll ) ]  := LoadResString( @SMsgDlgNoToAll     );
        LANGUAGE_DLG_CAPTIONS_[ Integer( mbYesToAll ) ] := LoadResString( @SMsgDlgYesToAll    );
        LANGUAGE_DLG_CAPTIONS_[ Integer( mbHelp ) ]     := LoadResString( @SMsgDlgHelp        );
        {$IF CompilerVersion >= 30}
        LANGUAGE_DLG_CAPTIONS_[ Integer( mbClose ) ]    := LoadResString( @SMsgDlgClose       );
        {$IFEND}
        LANGUAGE_DLG_CAPTIONS_[ Integer( mbHelp )+2 ]   := LoadResString( @SMsgDlgWarning     );
        LANGUAGE_DLG_CAPTIONS_[ Integer( mbHelp )+3 ]   := LoadResString( @SMsgDlgError       );
        LANGUAGE_DLG_CAPTIONS_[ Integer( mbHelp )+4 ]   := LoadResString( @SMsgDlgInformation );
        LANGUAGE_DLG_CAPTIONS_[ Integer( mbHelp )+5 ]   := LoadResString( @SMsgDlgConfirm     );
        end;
    1 : begin
        LANGUAGE_DLG_CAPTIONS_[ Integer( mbYes ) ]      := '&Ja';
        LANGUAGE_DLG_CAPTIONS_[ Integer( mbNo ) ]       := '&Nein';
        LANGUAGE_DLG_CAPTIONS_[ Integer( mbOK ) ]       := 'OK';
        LANGUAGE_DLG_CAPTIONS_[ Integer( mbCancel ) ]   := 'Abbrechen';
        LANGUAGE_DLG_CAPTIONS_[ Integer( mbAbort ) ]    := '&Abbrechen';
        LANGUAGE_DLG_CAPTIONS_[ Integer( mbRetry ) ]    := '&Wiederholen';
        LANGUAGE_DLG_CAPTIONS_[ Integer( mbIgnore ) ]   := '&Ignorieren';
        LANGUAGE_DLG_CAPTIONS_[ Integer( mbAll ) ]      := '&Alle';
        LANGUAGE_DLG_CAPTIONS_[ Integer( mbNoToAll ) ]  := 'N&ein für alle';
        LANGUAGE_DLG_CAPTIONS_[ Integer( mbYesToAll ) ] := 'Ja für &alle';
        LANGUAGE_DLG_CAPTIONS_[ Integer( mbHelp ) ]     := '&Hilfe';
        {$IF CompilerVersion >= 30}
        LANGUAGE_DLG_CAPTIONS_[ Integer( mbClose ) ]    := '&Schließen';
        {$IFEND}
        LANGUAGE_DLG_CAPTIONS_[ Integer( mbHelp )+2 ]   := 'Warnung';
        LANGUAGE_DLG_CAPTIONS_[ Integer( mbHelp )+3 ]   := 'Fehler';
        LANGUAGE_DLG_CAPTIONS_[ Integer( mbHelp )+4 ]   := 'Informationen';
        LANGUAGE_DLG_CAPTIONS_[ Integer( mbHelp )+5 ]   := 'Bestätigung';
        end;
    2 : begin
        LANGUAGE_DLG_CAPTIONS_[ Integer( mbYes ) ]      := '&Yes';
        LANGUAGE_DLG_CAPTIONS_[ Integer( mbNo ) ]       := '&No';
        LANGUAGE_DLG_CAPTIONS_[ Integer( mbOK ) ]       := 'OK';
        LANGUAGE_DLG_CAPTIONS_[ Integer( mbCancel ) ]   := 'Cancel';
        LANGUAGE_DLG_CAPTIONS_[ Integer( mbAbort ) ]    := '&Abort';
        LANGUAGE_DLG_CAPTIONS_[ Integer( mbRetry ) ]    := '&Retry';
        LANGUAGE_DLG_CAPTIONS_[ Integer( mbIgnore ) ]   := '&Ignore';
        LANGUAGE_DLG_CAPTIONS_[ Integer( mbAll ) ]      := '&All';
        LANGUAGE_DLG_CAPTIONS_[ Integer( mbNoToAll ) ]  := 'N&o to All';
        LANGUAGE_DLG_CAPTIONS_[ Integer( mbYesToAll ) ] := 'Yes to &All';
        LANGUAGE_DLG_CAPTIONS_[ Integer( mbHelp ) ]     := '&Help';
        {$IF CompilerVersion >= 30}
        LANGUAGE_DLG_CAPTIONS_[ Integer( mbClose ) ]    := '&Close';
        {$IFEND}
        LANGUAGE_DLG_CAPTIONS_[ Integer( mbHelp )+2 ]   := 'Warning';
        LANGUAGE_DLG_CAPTIONS_[ Integer( mbHelp )+3 ]   := 'Error';
        LANGUAGE_DLG_CAPTIONS_[ Integer( mbHelp )+4 ]   := 'Information';
        LANGUAGE_DLG_CAPTIONS_[ Integer( mbHelp )+5 ]   := 'Confirm';
        SetWindowsDlgString( '9001', '&Open' ); // OpenDialog ID1
        SetWindowsDlgString( '9002', '&Save' ); // SaveDialog ID1
        SetWindowsDlgString( '9003', '&Find Next' ); // FindDialog / ReplaceDialog ID1
        SetWindowsDlgString( '9004', 'Open' ); // OpenDialog Caption
        SetWindowsDlgString( '9005', 'Save As' ); // SaveDialog Caption
        SetWindowsDlgString( '9006', 'Print' ); // PrintDialog Caption
        SetWindowsDlgString( '9007', 'Find' ); // FindDialog Caption
        SetWindowsDlgString( '9008', 'Replace' ); // ReplaceDialog Caption
        SetWindowsDlgString( '9009', 'Color' ); // ColorDialog Caption
        SetWindowsDlgString( '9010', 'Font' ); // FontDialog Caption
        SetWindowsDlgString( '1040', 'Open as &read-only' );
        SetWindowsDlgString( '1089', 'Files of &type:' );
        SetWindowsDlgString( '1090', 'File &name:' );
        SetWindowsDlgString( '1091', 'Look &in:' ); // OpenDialog
        SetWindowsDlgString( '10912', 'Save &in:' ); // SaveDialog
        SetWindowsDlgString( '1075', 'Printer' ); // PrintDialog
        SetWindowsDlgString( '1093', '&Name:' ); // PrintDialog
        SetWindowsDlgString( '1025', '&Properties...' ); // PrintDialog
        SetWindowsDlgString( '1095', 'Status:' ); // PrintDialog
        SetWindowsDlgString( '1094', 'Type:' ); // PrintDialog
        SetWindowsDlgString( '1097', 'Where:' ); // PrintDialog
        SetWindowsDlgString( '1096', 'Comment:' ); // PrintDialog
        SetWindowsDlgString( '10402', 'Print to fi&le' ); // PrintDialog
        SetWindowsDlgString( '1072', 'Print range' ); // PrintDialog
        SetWindowsDlgString( '1056', '&All' ); // PrintDialog
        SetWindowsDlgString( '1058', 'Pa&ges' ); // PrintDialog
        SetWindowsDlgString( '1057', '&Selection' ); // PrintDialog
        SetWindowsDlgString( '10892', '&from:' ); // PrintDialog
        SetWindowsDlgString( '10902', '&to:' ); // PrintDialog
        SetWindowsDlgString( '1073', 'Copies' ); // PrintDialog
        SetWindowsDlgString( '1092', 'Number of &copies:' ); // PrintDialog
        SetWindowsDlgString( '1041', 'C&ollate' ); // PrintDialog

        SetWindowsDlgString( '1088', '&Font:' ); // FontDialog
        SetWindowsDlgString( '10893', 'Font st&yle:' ); // FontDialog
        SetWindowsDlgString( '10903', '&Size:' ); // FontDialog
        SetWindowsDlgString( '10722', 'Effects' ); // FontDialog
        SetWindowsDlgString( '10403', 'Stri&keout' ); // FontDialog
        SetWindowsDlgString( '10412', '&Underline' ); // FontDialog
        SetWindowsDlgString( '10913', '&Color:' ); // FontDialog
        SetWindowsDlgString( '10732', 'Sample' ); // FontDialog
        SetWindowsDlgString( '10942', 'Sc&ript:' ); // FontDialog
        SetWindowsDlgString( '1026', '&Apply' ); // FontDialog

        SetWindowsDlgString( '9011', 'Fi&nd what:' ); // FindDialog / ReplaceDialog (Non Static)
        SetWindowsDlgString( '10404', 'Match &whole word only' ); // FindDialog / ReplaceDialog
        SetWindowsDlgString( '10413', 'Match &case' ); // FindDialog / ReplaceDialog
        SetWindowsDlgString( '10723', 'Direction' ); // FindDialog
        SetWindowsDlgString( '10562', '&Up' ); // FindDialog
        SetWindowsDlgString( '10572', '&Down' ); // FindDialog

        SetWindowsDlgString( '9012', 'Re&place with:' ); // ReplaceDialog (Non Static)
        SetWindowsDlgString( '1024', '&Replace' ); // ReplaceDialog
        SetWindowsDlgString( '10252', 'Replace &All' ); // ReplaceDialog

        SetWindowsDlgString( '9013', '&Basic colors:' ); // ColorDialog (Non Static)
        SetWindowsDlgString( '9014', '&Custom colors:' ); // ColorDialog (Non Static)
        SetWindowsDlgString( '719', '&Define Custom Colors >>' ); // ColorDialog 
        SetWindowsDlgString( '713', '&o' ); // ColorDialog
        SetWindowsDlgString( '730', 'Color' ); // ColorDialog
        SetWindowsDlgString( '731', '|S&olid' ); // ColorDialog
        SetWindowsDlgString( '723', 'Hu&e:' ); // ColorDialog
        SetWindowsDlgString( '724', '&Sat:' ); // ColorDialog
        SetWindowsDlgString( '725', '&Lum:' ); // ColorDialog
        SetWindowsDlgString( '726', '&Red:' ); // ColorDialog
        SetWindowsDlgString( '727', '&Green:' ); // ColorDialog
        SetWindowsDlgString( '728', 'Bl&ue:' ); // ColorDialog
        SetWindowsDlgString( '712', '&Add to Custom Colors' ); // ColorDialog
        end;
  end;
  if ( Mode in [ 0..1 ] ) then // Resource or German
    begin
    SetWindowsDlgString( '9001', 'Ö&ffnen' ); // OpenDialog ID1
    SetWindowsDlgString( '9002', '&Speichern' ); // SaveDialog ID1
    SetWindowsDlgString( '9003', '&Weitersuchen' ); // FindDialog / ReplaceDialog ID1
    SetWindowsDlgString( '9004', 'Öffnen' ); // OpenDialog Caption
    SetWindowsDlgString( '9005', 'Speichern unter' ); // SaveDialog Caption
    SetWindowsDlgString( '9006', 'Drucken' ); // PrintDialog Caption
    SetWindowsDlgString( '9007', 'Suchen' ); // FindDialog Caption
    SetWindowsDlgString( '9008', 'Ersetzen' ); // ReplaceDialog Caption
    SetWindowsDlgString( '9009', 'Farbe' ); // ColorDialog Caption
    SetWindowsDlgString( '9010', 'Schriftart' ); // FontDialog Caption
    SetWindowsDlgString( '1040', 'Sch&reibgeschützt öffnen' );
    SetWindowsDlgString( '1089', 'Datei&typ:' );
    SetWindowsDlgString( '1090', 'Datei&name:' );
    SetWindowsDlgString( '1091', '&Suchen in:' ); // OpenDialog
    SetWindowsDlgString( '10912', 'Speic&hern in:' ); // SaveDialog
    SetWindowsDlgString( '1075', 'Drucker' ); // PrintDialog
    SetWindowsDlgString( '1093', '&Name:' ); // PrintDialog
    SetWindowsDlgString( '1025', '&Eigenschaften...' ); // PrintDialog
    SetWindowsDlgString( '1095', 'Status:' ); // PrintDialog
    SetWindowsDlgString( '1094', 'Typ:' ); // PrintDialog
    SetWindowsDlgString( '1097', 'Standort:' ); // PrintDialog
    SetWindowsDlgString( '1096', 'Kommentar:' ); // PrintDialog
    SetWindowsDlgString( '10402', 'Ausgabe in &Datei' ); // PrintDialog
    SetWindowsDlgString( '1072', 'Druckbereich' ); // PrintDialog
    SetWindowsDlgString( '1056', 'A&lles' ); // PrintDialog
    SetWindowsDlgString( '1058', '&Seiten' ); // PrintDialog
    SetWindowsDlgString( '1057', '&Markierung' ); // PrintDialog
    SetWindowsDlgString( '10892', '&von:' ); // PrintDialog
    SetWindowsDlgString( '10902', '&bis:' ); // PrintDialog
    SetWindowsDlgString( '1073', 'Exemplare' ); // PrintDialog
    SetWindowsDlgString( '1092', 'An&zahl Exemplare:' ); // PrintDialog
    SetWindowsDlgString( '1041', 'S&ortieren' ); // PrintDialog

    SetWindowsDlgString( '1088', '&Schriftart:' ); // FontDialog
    SetWindowsDlgString( '10893', 'S&chriftschnitt:' ); // FontDialog
    SetWindowsDlgString( '10903', 'Schriftg&rad:' ); // FontDialog
    SetWindowsDlgString( '10722', 'Effekte' ); // FontDialog
    SetWindowsDlgString( '10403', '&Durchgestrichen' ); // FontDialog
    SetWindowsDlgString( '10412', '&Unterstrichen' ); // FontDialog
    SetWindowsDlgString( '10913', '&Farbe:' ); // FontDialog
    SetWindowsDlgString( '10732', 'Beispiel' ); // FontDialog
    SetWindowsDlgString( '10942', 'S&kript:' ); // FontDialog
    SetWindowsDlgString( '1026', 'Ü&bernehmen' ); // FontDialog

    SetWindowsDlgString( '9011', '&Suchen nach:' ); // FindDialog / ReplaceDialog (Non Static)
    SetWindowsDlgString( '10404', 'Nu&r ganzes Wort suchen' ); // FindDialog / ReplaceDialog
    SetWindowsDlgString( '10413', 'Groß-/Kleins&chreibung' ); // FindDialog / ReplaceDialog
    SetWindowsDlgString( '10723', 'Suchrichtung' ); // FindDialog
    SetWindowsDlgString( '10562', 'Nach &oben' ); // FindDialog
    SetWindowsDlgString( '10572', 'Nach &unten' ); // FindDialog

    SetWindowsDlgString( '9012', 'Ersetzen &durch:' ); // ReplaceDialog (Non Static)
    SetWindowsDlgString( '1024', '&Ersetzen' ); // ReplaceDialog
    SetWindowsDlgString( '10252', 'A&lle ersetzen' ); // ReplaceDialog

    SetWindowsDlgString( '9013', '&Grundfarben:' ); // ColorDialog (Non Static)
    SetWindowsDlgString( '9014', 'Benut&zerdefinierte Farben:' ); // ColorDialog (Non Static)
    SetWindowsDlgString( '719', 'Farben &definieren >>' ); // ColorDialog
    SetWindowsDlgString( '713', '&i' ); // ColorDialog
    SetWindowsDlgString( '730', 'Farbe' ); // ColorDialog
    SetWindowsDlgString( '731', '|&Basis' ); // ColorDialog
    SetWindowsDlgString( '723', '&Farbt.:' ); // ColorDialog
    SetWindowsDlgString( '724', '&Sätt.:' ); // ColorDialog
    SetWindowsDlgString( '725', 'H&ell.:' ); // ColorDialog
    SetWindowsDlgString( '726', '&Rot:' ); // ColorDialog
    SetWindowsDlgString( '727', 'Grü&n:' ); // ColorDialog
    SetWindowsDlgString( '728', 'B&lau:' ); // ColorDialog
    SetWindowsDlgString( '712', 'Farben hinzuf&ügen' ); // ColorDialog
    end;

  for i := Low( LANGUAGE_DLG_CAPTIONS_ ) to High( LANGUAGE_DLG_CAPTIONS_ ) do
    LANGUAGE_DLG_CAPTIONS_R_[ i ] := {$IFNDEF UNICODE}WideStringToString( LANGUAGE_DLG_CAPTIONS_[ i ], LANGUAGE_CODEPAGE_ ){$ELSE}LANGUAGE_DLG_CAPTIONS_[ i ]{$ENDIF};
end;

{$IF Defined( HOOK_WINDOWSDIALOGS ) OR Defined( HOOK_MessageDlg )}
function LangMessageDlg( const aCaption, fCaption: string; DlgType: TMsgDlgType; DlgButtons: TMsgDlgButtons; HelpCtx: Longint = 0; X: Integer = -1; Y: Integer = -1; HelpFileName: string = ''; DefButton: TMsgDlgBtn = mbHelp ): TModalResult;
const
  ModalResults : array[ TMsgDlgBtn ] of integer = ( mrYes, mrNo, mrOk, mrCancel, mrAbort, mrRetry, mrIgnore, mrAll, mrNoToAll, mrYesToAll, 0{$IF CompilerVersion >= 30}, mrClose{$IFEND} );
  ButtonCaptions: array[ TMsgDlgBtn ] of Pointer = ( @SMsgDlgYes, @SMsgDlgNo, @SMsgDlgOK, @SMsgDlgCancel, @SMsgDlgAbort, @SMsgDlgRetry, @SMsgDlgIgnore, @SMsgDlgAll, @SMsgDlgNoToAll, @SMsgDlgYesToAll, @SMsgDlgHelp {$IF CompilerVersion >= 30}, @SMsgDlgClose{$IFEND} );
var
  dlgBtn     : TMsgDlgBtn;
  buttons    : TList;
  R          : TRect;
  i, w,
  btnGap,
  btnWidth,
  Aleft      : integer;
  SizeFactor : Double;
  Bmp        : TBitmap;
begin
  result := -1;
  SizeFactor := Max( 1, Min( 5, LangMessageDlg_SizeFactor ) );
  with CreateMessageDialog( aCaption, DlgType, DlgButtons ) do
    begin
    HelpContext := HelpCtx;
    HelpFile := HelpFileName;

    if ( fCaption <> '' ) then
      Caption := fCaption;

    // Factored Size
    if ( SizeFactor > 1 ) then
      begin
      Width  := Trunc( Width * SizeFactor );
      Height := Trunc( Height * SizeFactor );
      Left   := Trunc( Left * SizeFactor );
      Top    := Trunc( Top * SizeFactor );
      end;

    buttons := TList.Create;
    for i := 0 to ControlCount - 1 do
      begin
      // Factored Size
      if ( SizeFactor > 1 ) then
        begin
//        TOpenControl( Controls[ i ] ).AutoSize := false;
        TControl( Controls[ i ] ).Width  := Trunc( TControl( Controls[ i ] ).Width * SizeFactor );
        TControl( Controls[ i ] ).Height := Trunc( TControl( Controls[ i ] ).Height * SizeFactor );
        TControl( Controls[ i ] ).Left   := Trunc( TControl( Controls[ i ] ).Left * SizeFactor );
        TControl( Controls[ i ] ).Top    := Trunc( TControl( Controls[ i ] ).Top * SizeFactor );
        TOpenControl( Controls[ i ] ).Font.Size := Trunc( TOpenControl( Controls[ i ] ).Font.Size * ( SizeFactor-0.01 ) ); // MS

        if ( Controls[ i ] is TImage ) then
          begin
          Bmp := TBitmap.Create;
          Bmp.Canvas.Brush.Color := GetSysColor( COLOR_BTNFACE );
          Bmp.Height := TImage( Controls[ i ] ).Height;
          Bmp.Width := TImage( Controls[ i ] ).Width;
          try
            DrawIconEx( Bmp.Canvas.Handle, 0, 0, TImage( Controls[ i ] ).Picture.Icon.Handle, Bmp.Width, Bmp.Height, 0, GetSysColorBrush( COLOR_BTNFACE ), DI_NORMAL );
          finally
            TImage( Controls[ i ] ).Picture.Bitmap.Assign( Bmp );
          end;
          Bmp.Free;
          end;
        end;

      if ( Controls[ i ] is TButton ) then
        begin
        buttons.Add( Controls[ i ] );

        TButton( Controls[ i ] ).Default := TButton( Controls[ i ] ).ModalResult = ModalResults[ DefButton ];
        if TButton( Controls[ i ] ).Default then
          ActiveControl := TButton( Controls[ i ] );

        for dlgBtn := Low( dlgBtn ) to High( dlgBtn ) do
          begin
          if ModalResults[ dlgBtn ] = TButton( Controls[ i ] ).Modalresult then
//            TButton( Controls[ i ] ).Caption := PChar( LoadResString( ButtonCaptions[ dlgBtn ] ) );
            TButton( Controls[ i ] ).Caption := LANGUAGE_DLG_CAPTIONS_R_[ Integer( dlgBtn ) ];
          end;
        end;
      end;

    //AdjustButtons
    if buttons.Count = 0 then
      begin
      buttons.free;
      Release;
      Exit;
      end;

    //MeasureButtons
    btnWidth := TButton( buttons[ 0 ] ).Width;
    Canvas.Font := Font;
    for i := 0 to buttons.Count - 1 do
      begin
      R := Rect( 0, 0, 0, 0 );
      {$WARN SUSPICIOUS_TYPECAST OFF}
      {$IF CompilerVersion >= 30}{$WARN IMPLICIT_STRING_CAST OFF}{$IFEND}
      Windows.DrawText( canvas.handle, PAnsiChar( TButton( buttons[ i ] ).Caption ), - 1, R, DT_CALCRECT or DT_LEFT or DT_SINGLELINE );
      {$IF CompilerVersion >= 30}{$WARN IMPLICIT_STRING_CAST ON}{$IFEND}
      {$WARN SUSPICIOUS_TYPECAST ON}
      w := R.Right - R.Left + 16;
      if w > btnWidth then
        btnWidth := w;
      end; { For }
    if buttons.Count > 1 then
      btnGap := TButton( buttons[ 1 ] ).Left - TButton( buttons[ 0 ] ).Left - TButton( buttons[ 0 ] ).Width
    else
      btnGap := 0;

    //Size
    for i := 0 to buttons.Count - 1 do
      TButton( buttons[ i ] ).Width := btnWidth;

    //Arrange
    Aleft{Total} := ( buttons.Count - 1 ) * btnGap;
    for i := 0 to buttons.Count - 1 do
      Inc( Aleft{Total}, TButton( buttons[ i ] ).Width );
    Aleft := ( ClientWidth - Aleft{Total} ) div 2;
    if ALeft < 0 then
      begin
      Width := Width + 2 * Abs( Aleft ) + 16;
      Aleft := 8;
      end; { If }
    for i := 0 to buttons.Count - 1 do
      begin
      TButton( buttons[ i ] ).Left := Aleft;
      Inc( Aleft, btnWidth + btnGap );
      end;
    buttons.Free;

    if X >= 0 then
      Left := X;
    if Y >= 0 then
      Top := Y;
    if ( Y < 0 ) and ( X < 0 ) then
      Position := poScreenCenter;
    try
      Result := ShowModal;
    finally
      Release;
    end;
    end;
end;
{$IFEND}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
{$IFDEF HOOK_WINDOWSDIALOGS}
function EnumProcWrite( AHandle: HWND; PARAM: LPARAM ): BOOL; stdcall;
var
  ClassName, Caption: Array [ 0..255 ] of Char;
  ID : Integer;
  Dlg, New : HWND;
begin
//  result := false;
  GetClassname( AHandle, ClassName, 256 );
  GetWindowText( AHandle, Caption, 256 );

  if ( Caption[ 0 ] <> #0 ) then
    begin
    ID := GetDlgCtrlID( AHandle );

    if ( ID = High( Word ) ) then
      begin
      Dlg := 0;
      New := 0;
      if ( TStringList( PARAM ).Count > 0 ) then
        Dlg := StrToIntDef( TStringList( PARAM )[ 0 ], 0 );
      if ( Dlg <> 0 ) then
        New := FindWindowEx( Dlg, 0, ClassName, Caption );
      if ( New <> 0 ) then
        ID := New;

      TStringList( PARAM ).add( Format( '%d', [ ID ] ) );
      end;
//    TStringList( PARAM ).Add( Format( 'ID: %d, class: %s, caption: %s', [ ID, ClassName, Caption ] ) );
    end;
  result := true;
end;

var
  DialogsTaskModalDialogCritSect : TRTLCriticalSection;

procedure TCommonDialogDoShow( Self: TObject );
var
  handle : THandle;
  StrL   : TStringList;
  i      : integer;
begin
  if NOT ( Self is TCommonDialog ) then
    Exit;

  EnterCriticalSection( DialogsTaskModalDialogCritSect );
  try
    Handle := TCommonDialog( Self ).Handle;
    if Self.ClassNameIs( 'TOpenDialog' ) OR Self.ClassNameIs( 'TSaveDialog' ) then
      Handle := GetParent( Handle );

    StrL := TStringList.Create;
    StrL.Add( Format( '%d', [ Handle ] ) ); // ENumeration
//    EnumChildWindows( Handle, @EnumProcWrite, LPARAM( StrL ) );
//    StrL.SaveToFile( Format( '%s.enum', [ Self.ClassName ] ) );

    //All
    SetDlgItemTextW( handle, 2, PWideChar( LANGUAGE_DLG_CAPTIONS_[ Integer( mbCancel ) ] ) );
    SetDlgItemTextW( handle, 1038, PWideChar( LANGUAGE_DLG_CAPTIONS_[ Integer( mbHelp ) ] ) );

    if Self.ClassNameIs( 'TOpenDialog' ) or Self.ClassNameIs( 'TSaveDialog' ) then
      begin
      SetDlgItemTextW( handle, 1040, PWideChar( GetWindowsDlgStringW( 1040 ) ) ); 
      SetDlgItemTextW( handle, 1089, PWideChar( GetWindowsDlgStringW( 1089 ) ) );
      SetDlgItemTextW( handle, 1090, PWideChar( GetWindowsDlgStringW( 1090 ) ) );
      end;

    if  Self.ClassNameIs( 'TOpenDialog' ) then
      begin
      SetWindowTextW( handle, PWideChar( GetWindowsDlgStringW( 9004 ) ) );
      SetDlgItemTextW( handle, 1, PWideChar( GetWindowsDlgStringW( 9001 ) ) );
//      SendMessageW( Handle, 1128{CDM_SETCONTROLTEXT}, ID_OK{1}, LPARAM( GetWindowsDlgStringW( 9001, 'Ö&ffnen' ) ) );
      SetDlgItemTextW( handle, 1091, PWideChar( GetWindowsDlgStringW( 1091 ) ) );
      end
    else if Self.ClassNameIs( 'TSaveDialog' ) then
      begin
      SetWindowTextW( handle, PWideChar( GetWindowsDlgStringW( 9005 ) ) );
//      SetDlgItemTextW( handle, 1, PWideChar( GetWindowsDlgStringW( 9002 ) ) );
      SendMessage( Handle, 1128{CDM_SETCONTROLTEXT}, ID_OK{1}, LPARAM( GetWindowsDlgString( 9002 ) ) ); // SaveDialog resists IDOK change
//      SendMessageW( Handle, 1128{CDM_SETCONTROLTEXT}, ID_OK{1}, LPARAM( GetWindowsDlgStringW( 9002 ) ) ); // SaveDialog resists IDOK change // MS WideVersion not working :(
      SetDlgItemTextW( handle, 1091, PWideChar( GetWindowsDlgStringW( 10912 ) ) );
      end
    else if Self.ClassNameIs( 'TPrintDialog' ) then
      begin
      SetWindowTextW( handle, PWideChar( GetWindowsDlgStringW( 9006 ) ) );
      SetDlgItemTextW( handle, 1, PWideChar( LANGUAGE_DLG_CAPTIONS_[ Integer( mbOK ) ] ) );
      SetDlgItemTextW( handle, 1075, PWideChar( GetWindowsDlgStringW( 1075 ) ) );
      SetDlgItemTextW( handle, 1093, PWideChar( GetWindowsDlgStringW( 1093 ) ) );
      SetDlgItemTextW( handle, 1025, PWideChar( GetWindowsDlgStringW( 1025 ) ) );
      SetDlgItemTextW( handle, 1095, PWideChar( GetWindowsDlgStringW( 1095 ) ) );
      SetDlgItemTextW( handle, 1094, PWideChar( GetWindowsDlgStringW( 1094 ) ) );
      SetDlgItemTextW( handle, 1097, PWideChar( GetWindowsDlgStringW( 1097 ) ) );
      SetDlgItemTextW( handle, 1096, PWideChar( GetWindowsDlgStringW( 1096 ) ) );
      SetDlgItemTextW( handle, 1040, PWideChar( GetWindowsDlgStringW( 10402 ) ) );
      SetDlgItemTextW( handle, 1072, PWideChar( GetWindowsDlgStringW( 1072 ) ) );
      SetDlgItemTextW( handle, 1056, PWideChar( GetWindowsDlgStringW( 1056 ) ) );
      SetDlgItemTextW( handle, 1058, PWideChar( GetWindowsDlgStringW( 1058 ) ) );
      SetDlgItemTextW( handle, 1057, PWideChar( GetWindowsDlgStringW( 1057 ) ) );
      SetDlgItemTextW( handle, 1089, PWideChar( GetWindowsDlgStringW( 10892 ) ) );
      SetDlgItemTextW( handle, 1090, PWideChar( GetWindowsDlgStringW( 10902 ) ) );
      SetDlgItemTextW( handle, 1073, PWideChar( GetWindowsDlgStringW( 1073 ) ) );
      SetDlgItemTextW( handle, 1092, PWideChar( GetWindowsDlgStringW( 1092 ) ) );
      SetDlgItemTextW( handle, 1041, PWideChar( GetWindowsDlgStringW( 1041 ) ) );
      end
    else if Self.ClassNameIs( 'TFontDialog' ) then
      begin
      SetWindowTextW( handle, PWideChar( GetWindowsDlgStringW( 9010 ) ) );
      SetDlgItemTextW( handle, 1, PWideChar( LANGUAGE_DLG_CAPTIONS_[ Integer( mbOK ) ] ) );
      SetDlgItemTextW( handle, 1088, PWideChar( GetWindowsDlgStringW( 1088 ) ) );
      SetDlgItemTextW( handle, 1089, PWideChar( GetWindowsDlgStringW( 10893 ) ) );
      SetDlgItemTextW( handle, 1090, PWideChar( GetWindowsDlgStringW( 10903 ) ) );
      SetDlgItemTextW( handle, 1072, PWideChar( GetWindowsDlgStringW( 10722 ) ) );
      SetDlgItemTextW( handle, 1040, PWideChar( GetWindowsDlgStringW( 10403 ) ) );
      SetDlgItemTextW( handle, 1041, PWideChar( GetWindowsDlgStringW( 10412 ) ) );
      SetDlgItemTextW( handle, 1091, PWideChar( GetWindowsDlgStringW( 10913 ) ) );
      SetDlgItemTextW( handle, 1073, PWideChar( GetWindowsDlgStringW( 10732 ) ) );
      SetDlgItemTextW( handle, 1094, PWideChar( GetWindowsDlgStringW( 10942 ) ) );
      SetDlgItemTextW( handle, 1026, PWideChar( GetWindowsDlgStringW( 1026 ) ) );
      end
    else if Self.ClassNameIs( 'TColorDialog' ) then
      begin
      SetWindowTextW( handle, PWideChar( GetWindowsDlgStringW( 9009 ) ) );
      SetDlgItemTextW( handle, 1, PWideChar( LANGUAGE_DLG_CAPTIONS_[ Integer( mbOK ) ] ) );
      SetDlgItemTextW( handle, 719,  PWideChar( GetWindowsDlgStringW( 719 ) ) );
      SetDlgItemTextW( handle, 713,  PWideChar( GetWindowsDlgStringW( 713 ) ) );
      SetDlgItemTextW( handle, 730,  PWideChar( GetWindowsDlgStringW( 730 ) ) );
      SetDlgItemTextW( handle, 731,  PWideChar( GetWindowsDlgStringW( 731 ) ) );
      SetDlgItemTextW( handle, 723,  PWideChar( GetWindowsDlgStringW( 723 ) ) );
      SetDlgItemTextW( handle, 724,  PWideChar( GetWindowsDlgStringW( 724 ) ) );
      SetDlgItemTextW( handle, 725,  PWideChar( GetWindowsDlgStringW( 725 ) ) );
      SetDlgItemTextW( handle, 726,  PWideChar( GetWindowsDlgStringW( 726 ) ) );
      SetDlgItemTextW( handle, 727,  PWideChar( GetWindowsDlgStringW( 727 ) ) );
      SetDlgItemTextW( handle, 728,  PWideChar( GetWindowsDlgStringW( 728 ) ) );
      SetDlgItemTextW( handle, 712,  PWideChar( GetWindowsDlgStringW( 712 ) ) );

      EnumChildWindows( Handle, @EnumProcWrite, LPARAM( StrL ) );
      for i := 1 to StrL.Count-1 do // Translate non-constant Items
        SetWindowTextW( StrToIntDef( StrL[ i ], 0 ), PWideChar( GetWindowsDlgStringW( 9013+i-1 ) ) );
      end
    else if Self.ClassNameIs( 'TReplaceDialog' ) then
      begin
      SetWindowTextW( handle, PWideChar( GetWindowsDlgStringW( 9008 ) ) );
      SetDlgItemTextW( handle, 1, PWideChar( GetWindowsDlgStringW( 9003 ) ) );
      SetDlgItemTextW( handle, 1040,  PWideChar( GetWindowsDlgStringW( 10404 ) ) );
      SetDlgItemTextW( handle, 1041,  PWideChar( GetWindowsDlgStringW( 10413 ) ) );
      SetDlgItemTextW( handle, 1024,  PWideChar( GetWindowsDlgStringW( 1024 ) ) );
      SetDlgItemTextW( handle, 1025,  PWideChar( GetWindowsDlgStringW( 10252 ) ) );

      EnumChildWindows( Handle, @EnumProcWrite, LPARAM( StrL ) );
      for i := 1 to StrL.Count-1 do // Translate non-constant Items
        SetWindowTextW( StrToIntDef( StrL[ i ], 0 ), PWideChar( GetWindowsDlgStringW( 9011+i-1 ) ) );
      end
    else if Self.ClassNameIs( 'TFindDialog' ) then
      begin
      SetWindowTextW( handle, PWideChar( GetWindowsDlgStringW( 9007 ) ) );
      SetDlgItemTextW( handle, 1, PWideChar( GetWindowsDlgStringW( 9003 ) ) );
      SetDlgItemTextW( handle, 1040, PWideChar( GetWindowsDlgStringW( 10404 ) ) );
      SetDlgItemTextW( handle, 1041, PWideChar( GetWindowsDlgStringW( 10413 ) ) );
      SetDlgItemTextW( handle, 1072, PWideChar( GetWindowsDlgStringW( 10723 ) ) );
      SetDlgItemTextW( handle, 1056, PWideChar( GetWindowsDlgStringW( 10562 ) ) );
      SetDlgItemTextW( handle, 1057, PWideChar( GetWindowsDlgStringW( 10572 ) ) );

      EnumChildWindows( Handle, @EnumProcWrite, LPARAM( StrL ) );
      for i := 1 to StrL.Count-1 do // Translate non-constant Items
        SetWindowTextW( StrToIntDef( StrL[ i ], 0 ), PWideChar( GetWindowsDlgStringW( 9011+i-1 ) ) );
      end;
    StrL.free;

    TCommonDialogDoShowNext( Self );
  finally
    LeaveCriticalSection( DialogsTaskModalDialogCritSect );
  end;
end;

// Read Windows-Captions
function EnumProcRead( AHandle: HWND; PARAM: LPARAM ): BOOL; stdcall;
var
  Caption: Array [ 0..255 ] of WideChar; 
begin
//  result := false;
  GetWindowTextW( AHandle, Caption, 256 );
  if ( Caption[ 0 ] <> #0 ) then
    TWideStringList( PARAM ).Add( Format( '%d %s', [ GetDlgCtrlID( AHandle ), Caption ] ) );
  result := true;
end;

procedure TCommonDialogDoShowRead( Self: TObject );
var
  handle : THandle;
  StrL   : TWideStringList;
  i      : integer;

  ID     : string;
  Value  : WideString;
  Caption: Array [ 0..255 ] of WideChar;
  Cnt    : Byte;
begin
  if NOT ( Self is TCommonDialog ) then
    Exit;

  EnterCriticalSection( DialogsTaskModalDialogCritSect );
  try
    Handle := TCommonDialog( Self ).Handle;
    if Self.ClassNameIs( 'TOpenDialog' ) OR Self.ClassNameIs( 'TSaveDialog' ) then
      Handle := GetParent( Handle );
      
    StrL := TWideStringList.Create;
    StrL.Add( Format( '%d', [ Handle ] ) ); // ENumeration
    EnumChildWindows( Handle, @EnumProcRead, LPARAM( StrL ) );
//    StrL.SaveToFile( Format( '%s.enum', [ Self.ClassName ] ) );

    GetWindowTextW( Handle, Caption, 256 );
    Cnt := 0;
    for i := 1 to StrL.Count-1 do
      begin
      ID    := GetTok( StrL[ i ], 1, 32 );
      Value := GetTok( StrL[ i ], 2, 99, 32 );

      //All
      case StrToIntDef( ID, 0 ) of
        0    : continue;
        1139 : continue;
        1099, 1098, 1101, 1151, 1154 : continue; // Printer
        1136, 1137, 1138, 1140, 1001 : continue; // Font
        2    : begin
               LANGUAGE_DLG_CAPTIONS_[ Integer( mbCancel ) ] := Value;
               LANGUAGE_DLG_CAPTIONS_R_[ Integer( mbCancel ) ] := {$IFNDEF UNICODE}WideStringToString( Value, LANGUAGE_CODEPAGE_ ){$ELSE}Value{$ENDIF};
               Continue;
               end;
        1038 : begin
               LANGUAGE_DLG_CAPTIONS_[ Integer( mbHelp ) ] := Value;
               LANGUAGE_DLG_CAPTIONS_R_[ Integer( mbHelp ) ] := {$IFNDEF UNICODE}WideStringToString( Value, LANGUAGE_CODEPAGE_ ){$ELSE}Value{$ENDIF};
               Continue;
               end;
      end;

      if Self.ClassNameIs( 'TOpenDialog' ) then
        begin
        SetWindowsDlgString( '9004', Caption );

        case StrToIntDef( ID, 0 ) of
          0 : ;
          1 : SetWindowsDlgString( '9001', Value );
        else
          SetWindowsDlgString( ID, Value );
        end;
        end
      else if Self.ClassNameIs( 'TSaveDialog' ) then
        begin
        SetWindowsDlgString( '9005', Caption );

        case StrToIntDef( ID, 0 ) of
          0    : ;
          1    : SetWindowsDlgString( '9002', Value );
          1091 : SetWindowsDlgString( '10912', Value );
        end;
        end
      else if Self.ClassNameIs( 'TPrintDialog' ) then
        begin
        SetWindowsDlgString( '9006', Caption );

        case StrToIntDef( ID, 0 ) of
          0 : ;
          1 : begin
              LANGUAGE_DLG_CAPTIONS_[ Integer( mbOK ) ] := Value;
              LANGUAGE_DLG_CAPTIONS_R_[ Integer( mbOK ) ] := {$IFNDEF UNICODE}WideStringToString( Value, LANGUAGE_CODEPAGE_ ){$ELSE}Value{$ENDIF};
              end;
          1040 : SetWindowsDlgString( '10402', Value );
          1089 : SetWindowsDlgString( '10892', Value );
          1090 : SetWindowsDlgString( '10902', Value );
        else // 1075, 1093, 1025, 1095, 1094, 1097, 1096, 1072, 1056, 1058, 1057, 1073, 1092, 1041
          SetWindowsDlgString( ID, Value );
        end;
        end
      else if Self.ClassNameIs( 'TFontDialog' ) then
        begin
        SetWindowsDlgString( '9010', Caption );

        case StrToIntDef( ID, 0 ) of
          0 : ;
          1 : begin
              LANGUAGE_DLG_CAPTIONS_[ Integer( mbOK ) ] := Value;
              LANGUAGE_DLG_CAPTIONS_R_[ Integer( mbOK ) ] := {$IFNDEF UNICODE}WideStringToString( Value, LANGUAGE_CODEPAGE_ ){$ELSE}Value{$ENDIF};
              end;
          1040 : SetWindowsDlgString( '10403', Value );
          1041 : SetWindowsDlgString( '10412', Value );
          1072 : SetWindowsDlgString( '10722', Value );
          1073 : SetWindowsDlgString( '10732', Value );
          1089 : SetWindowsDlgString( '10893', Value );
          1090 : SetWindowsDlgString( '10903', Value );
          1091 : SetWindowsDlgString( '10913', Value );
          1092 : ; // Text Sample ..
          1094 : SetWindowsDlgString( '10942', Value );
        else // 1088, 1026
          SetWindowsDlgString( ID, Value );
        end;
        end
      else if Self.ClassNameIs( 'TColorDialog' ) then
        begin
        SetWindowsDlgString( '9009', Caption );

        case StrToIntDef( ID, 0 ) of
          0 : ;
          1 : begin
              LANGUAGE_DLG_CAPTIONS_[ Integer( mbOK ) ] := Value;
              LANGUAGE_DLG_CAPTIONS_R_[ Integer( mbOK ) ] := {$IFNDEF UNICODE}WideStringToString( Value, LANGUAGE_CODEPAGE_ ){$ELSE}Value{$ENDIF};
              end;
          High( Word ) : begin
                         SetWindowsDlgString( IntToStr( 9013+Cnt ), Value );
                         Inc( Cnt );
                         end;          
        else // 719, 713, 730, 731, 723, 724, 725, 726, 727, 728, 712
          SetWindowsDlgString( ID, Value );
        end;
        end
      else if Self.ClassNameIs( 'TReplaceDialog' ) then
        begin
        SetWindowsDlgString( '9008', Caption );

        case StrToIntDef( ID, 0 ) of
          0    : ;
          1    : SetWindowsDlgString( '9003', Value );
          1025 : SetWindowsDlgString( '10252', Value );
          1040 : SetWindowsDlgString( '10404', Value );
          1041 : SetWindowsDlgString( '10413', Value );
          High( Word ) : begin
                         SetWindowsDlgString( IntToStr( 9011+Cnt ), Value );
                         Inc( Cnt );
                         end;
        else // 1024
          SetWindowsDlgString( ID, Value );
        end;
        end
      else if Self.ClassNameIs( 'TFindDialog' ) then
        begin
        SetWindowsDlgString( '9007', Caption );

        case StrToIntDef( ID, 0 ) of
          0    : ;
          1    : SetWindowsDlgString( '9003', Value );
          1040 : SetWindowsDlgString( '10404', Value );
          1041 : SetWindowsDlgString( '10413', Value );
          1056 : SetWindowsDlgString( '10562', Value );
          1057 : SetWindowsDlgString( '10572', Value );
          1072 : SetWindowsDlgString( '10723', Value );
          High( Word ) : begin
                         SetWindowsDlgString( IntToStr( 9011+Cnt ), Value );
                         Inc( Cnt );
                         end;
        end;
        end;

      end;
    StrL.free;

    {$IFDEF HOOK_RESOURCESTRINGS}
    LangHookResourceStrings;
    {$ENDIF}

    TCommonDialogDoShowNext( Self );
  finally
    LeaveCriticalSection( DialogsTaskModalDialogCritSect );
  end;
end;

procedure tLanguager.ReadWindowsDlgStrings( ShowOnly : boolean = false );
var
  od  : TOpenDialog;
  sd  : TSaveDialog;
  pd  : TPrintDialog;
  fd  : TFontDialog;
  cd  : TColorDialog;
  fid : TFindDialog;
  rd  : TReplaceDialog;
begin
  if NOT Assigned( self ) then
    Exit;

  {$IFNDEF UNICODE}
  ShowMessage( 'NON-Unicode build is unable to read Dialog-Captions of: TPrint-, TFind-, TReplace-, TColor-, TFont-Dialog' );
  {$ENDIF}

  // Hook read-Version
  if NOT ShowOnly then
    begin
    madCodeHook.UnHookCode( @TCommonDialogDoShowNext );
    madCodeHook.HookCode( @TOpenCommonDialog.DoShow, @TCommonDialogDoShowRead, @TCommonDialogDoShowNext );
    end;

  od := TOpenDialog.Create( nil );
  sd := TSaveDialog.Create( nil );
  pd := TPrintDialog.Create( nil );
  fd := TFontDialog.Create( nil );
  cd := TColorDialog.Create( nil );
  fid := TFindDialog.Create( nil );
  rd := TReplaceDialog.Create( nil );

  od.Execute;
  sd.Execute;
  pd.Execute;
  fd.Execute;
  cd.Execute;
  fid.Execute;
  if NOT ShowOnly then
    begin
    fid.CloseDialog;
    Application.ProcessMessages;
    end;
  rd.Execute;
  if NOT ShowOnly then
    begin
    rd.CloseDialog;
    Application.ProcessMessages;
    end;

  od.free;
  sd.free;
  pd.free;
  fd.free;
  cd.free;
  if NOT ShowOnly then // ShowOnly memory leak ... 
    begin
    fid.free;
    rd.free;
    end;

  // Restore to Write
  if NOT ShowOnly then
    begin
    madCodeHook.UnHookCode( @TCommonDialogDoShowNext );
    madCodeHook.HookCode( @TOpenCommonDialog.DoShow, @TCommonDialogDoShow, @TCommonDialogDoShowNext );
    end;
end;
{$ENDIF}

{$IF NOT Defined( UNICODE ) AND Defined( HOOK_WindowsFunctions )}
function ExtTextOut( DC: HDC; X, Y: Integer; Options: Longint; Rect: PRect; Str: PChar; Count: Longint; Dx: PInteger ): BOOL; stdcall; // StringGrid/TCanvas
var
  wText : WideString;
begin
  wText  := StringToWideString( Str, LANGUAGE_CODEPAGE_ );
  result := Windows.ExtTextOutW( DC, X, Y, Options, Rect, PWideChar( wText ), Length( wText ){Count}, Dx );
end;

function DrawText( hDC: HDC; lpString: PChar; nCount: Integer; var lpRect: TRect; uFormat: UINT ): Integer; stdcall;
var
  wText   : WideString;
  tmpRect : TRect;
begin
  wText   := StringToWideString( lpString, LANGUAGE_CODEPAGE_ );
  tmpRect := lpRect;
  result  := Windows.DrawTextW( hDC, PWideChar( wText ), Length( wText ), tmpRect, uFormat );
  lpRect  := tmpRect;
end;
{$IFEND}

{$IF NOT Defined( UNICODE ) AND Defined( HOOK_InitSysLocale )}
procedure InitSysLocale;
{$IFDEF MSWINDOWS}
var
  DefaultLCID: LCID;
  DefaultLangID: LANGID;
  AnsiCPInfo: TCPInfo;
  I: Integer;
  BufferA: array [128..255] of Char;
  BufferW: array [128..256] of Word;
  PCharA: PChar;

  (*
  {$IFDEF MSWINDOWS}
  function LCIDToCodePage(ALcid: LCID): Integer;
  var
    Buffer: array [0..6] of Char;
  begin
    GetLocaleInfo(ALcid, LOCALE_IDEFAULTANSICODEPAGE, Buffer, SizeOf(Buffer));
    Result:= StrToIntDef(Buffer, GetACP);
  end;
  {$ENDIF}
  *)

  procedure InitLeadBytes;
  var
    I: Integer;
    J: Byte;
  begin
    GetCPInfo(LCIDToCodePage(SysLocale.DefaultLCID), AnsiCPInfo);
    with AnsiCPInfo do
    begin
      I := 0;
      while (I < MAX_LEADBYTES) and ((LeadByte[I] or LeadByte[I + 1]) <> 0) do
      begin
        for J := LeadByte[I] to LeadByte[I + 1] do
          Include(LeadBytes, Char(J));
        Inc(I, 2);
      end;
    end;
  end;

  function IsWesternGroup: Boolean;
  type
    TLangGroup = $00..$1D;
    TLangGroups = set of TLangGroup;
  const
    lgNeutral = TLangGroup($00);
    lgDanish = TLangGroup($06);
    lgDutch = TLangGroup($13);
    lgEnglish  = TLangGroup($09);
    lgFinnish = TLangGroup($0B);
    lgFrench = TLangGroup($0C);
    lgGerman = TLangGroup($07);
    lgItalian  = TLangGroup($10);
    lgNorwegian = TLangGroup($14);
    lgPortuguese = TLangGroup($16);
    lgSpanish  = TLangGroup($0A);
    lgSwedish  = TLangGroup($1D);

    WesternGroups: TLangGroups = [
      lgNeutral,
      lgDanish,
      lgDutch,
      lgEnglish,
      lgFinnish,
      lgFrench,
      lgGerman,
      lgItalian,
      lgNorwegian,
      lgPortuguese,
      lgSpanish,
      lgSwedish
    ];
  begin
    Result := SysLocale.PriLangID in WesternGroups;
  end;
begin
  if ( LANGUAGE_LCID_ <> 0 ) then
    DefaultLCID := LANGUAGE_LCID_
  else
    DefaultLCID := GetSystemDefaultLangID; // Adjust to Non-Unicode-Application-Language

  SetThreadLocale( DefaultLCID );

  if DefaultLCID <> 0 then SysLocale.DefaultLCID := DefaultLCID;

  DefaultLangID := Word(DefaultLCID);
  if DefaultLangID <> 0 then
  begin
    SysLocale.PriLangID := DefaultLangID and $3ff;
    SysLocale.SubLangID := DefaultLangID shr 10;
  end;

  LeadBytes := [];
  if Win32Platform = VER_PLATFORM_WIN32_NT then
  begin
    if IsWesternGroup then
    begin
      SysLocale.MiddleEast := False;
      SysLocale.FarEast    := False;
    end
    else
    begin
      { Far East (aka MBCS)? - }
      InitLeadBytes;
      SysLocale.FarEast := LeadBytes <> [];
      if SysLocale.FarEast then
      begin
        SysLocale.MiddleEast := False;
        Exit;
      end;

      { Middle East? }
      for I := Low(BufferA) to High(BufferA) do
        BufferA[I] := Char(I);
      PCharA := @BufferA; { not null terminated: include length in GetStringTypeExA call }
      GetStringTypeEx(SysLocale.DefaultLCID, CT_CTYPE2, PCharA, High(BufferA) - Low(BufferA) + 1, BufferW);
      for I := Low(BufferA) to High(BufferA) do
      begin
        SysLocale.MiddleEast := BufferW[I] = C2_RIGHTTOLEFT;
        if SysLocale.MiddleEast then
          Exit;
      end;
    end;
  end
  else
  begin
    SysLocale.MiddleEast := GetSystemMetrics(SM_MIDEASTENABLED) <> 0;
    SysLocale.FarEast    := GetSystemMetrics(SM_DBCSENABLED) <> 0;
    if SysLocale.FarEast then
      InitLeadBytes;
  end;
end;
{$ENDIF}
{$IFDEF LINUX}
var
  I: Integer;
  buf: array [0..3] of char;
begin
  FillChar(SysLocale, sizeof(SysLocale), 0);
  SysLocale.FarEast := MB_CUR_MAX <> 1;
  if not SysLocale.FarEast then Exit;

  buf[1] := #0;
  for I := 1 to 255 do
  begin
    buf[0] := Chr(I);
    if mblen(buf, 1) <> 1 then Include(LeadBytes, Char(I));
  end;
end;
{$ENDIF}

{$IFEND}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Hook
{$IFDEF HOOK_WINDOWSDIALOGS}
function MessageBoxA( Handle : HWND; ACaption, FCaption : PAnsiChar; DlgButtons: UINT ): TModalResult; stdcall;
begin
  {$IFDEF UNICODE}
  result := MessageBox( Handle, PWideChar( WideString( ACaption ) ), PWideChar( WideString( FCaption ) ), DlgButtons );
  {$ELSE}
  result := MessageBox( Handle, ACaption, FCaption, DlgButtons );
  {$ENDIF}
end;

function MessageBoxW( Handle : HWND; ACaption, FCaption : PWideChar; DlgButtons: UINT ): TModalResult; stdcall;
begin
  {$IFDEF UNICODE}
  result := MessageBox( Handle, ACaption, FCaption, DlgButtons );
  {$ELSE}
  result := MessageBox( Handle, PAnsiChar( AnsiString( ACaption ) ), PAnsiChar( AnsiString( FCaption ) ), DlgButtons );
  {$ENDIF}
end;

function MessageBox( Handle : HWND; ACaption, FCaption : PChar; DlgButtons: UINT ): TModalResult; {$IF CompilerVersion > 21}stdcall;{$IFEND}
var
  Btns : TMsgDlgButtons;
  DlgType: TMsgDlgType;
begin
  case DlgButtons - ( DlgButtons mod 16 ) of
    16 : DlgType := mtError;
    32 : DlgType := mtConfirmation;
    48 : DlgType := mtWarning;
    64 : DlgType := mtInformation;
  else
    DlgType := mtCustom;
  end;

  case ( DlgButtons mod 16 ) of
    0 : Btns := [ mbOK ];
    1 : Btns := [ mbOK, mbCancel ];
    2 : Btns := [ mbAbort, mbRetry, mbIgnore ];
    3 : Btns := [ mbYes, mbNo, mbCancel ];
    4 : Btns := [ mbYes, mbNo ];
    5 : Btns := [ mbRetry, mbCancel ];
  end;

  result := LangMessageDlg( ACaption, FCaption, DlgType, Btns );
end;

{$IF CompilerVersion < 21}
function MessageBox_( Handle : HWND; ACaption, FCaption : PChar; DlgButtons: UINT ): TModalResult; stdcall;
begin
  result := MessageBox( Handle, ACaption, FCaption, DlgButtons );
end;
{$IFEND}
{$ENDIF}

{$IFDEF HOOK_MessageDlg}
function MessageDlgPosHelp( const Msg: string; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer; const HelpFileName: string ): Integer;
begin
  result := LangMessageDlg( Msg, '', DlgType, Buttons, HelpCtx, X, Y, HelpFileName );
end;
{$ENDIF}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
{$IF NOT Defined( UNICODE ) AND Defined( HOOK_InitSysLocale )}
procedure InitSysLocaleHook;
var
  M : TMapFile;
  P : Pointer;
begin
  M := FindMapFile;
  if M.IsValid then
    begin
    P := M.FindAddress( 'SysUtils', 'InitSysLocale' );
    if Assigned( P ) then
      madCodeHook.HookCode( P,   @InitSysLocale,          @InitSysLocaleNext );
    end
  else
    M.free
end;
{$IFEND}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
{$IFDEF HOOK_TControlSetTextBuf}
procedure TControlSetTextBuf( Self : TObject; Buffer: PChar );
var
  vRect    : TRect;
  comp     : TWinControl;
  bParent  : Boolean;
  bIsChild : Boolean;
begin
  TControlSetTextBufNext( Self, Buffer );

  if NOT ( Self is TLabel ) then
    Exit;

  if NOT Assigned( TControl( Self ).Parent ) then
    Exit;

  bParent  := False;
  bIsChild := False;
  comp     := TControl( Self ).Parent;
  while Assigned( comp ) do
    begin
    if NOT bParent then
      begin
      if ( comp is TFrame ) then // Frames work
        Exit
      else if ( comp is TForm ) then
        bParent := True;
      end
    else
      begin
      if ( ( comp is TForm ) OR ( comp is TFrame ) ) then
        begin
        bIsChild := True;
        Break;
        end;
      end;
    comp := comp.Parent;
    end;

  if not bIsChild then
    Exit;
  vRect := TControl( Self ).BoundsRect;
  RedrawWindow( TControl( Self ).Parent.Handle, @vRect, 0, RDW_ERASE or RDW_FRAME or RDW_INVALIDATE or RDW_ALLCHILDREN );
end;
{$ENDIF}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
initialization
  LANGUAGE_DIRECTORY_ := ExtractFileDir( application.exename ) + '\' + LANGUAGE_DIRECTORY_;
  Languager := tLanguager.Create;

  LangMessageDlgInitCaptions;
{$IFDEF HOOK_RESOURCESTRINGS}
  LangHookResourceStrings;
{$ENDIF}
{$IFDEF HOOK_WINDOWSDIALOGS}
  InitializeCriticalSection( DialogsTaskModalDialogCritSect );
{$IF CompilerVersion < 21}
  madCodeHook.HookCode( @Windows.MessageBox,       @MessageBox_,            @MessageBoxNext );
{$ELSE}
  madCodeHook.HookCode( @Windows.MessageBox,       @MessageBox,             @MessageBoxNext );
  Dialogs.UseLatestCommonDialogs := false;
{$IFEND}
  madCodeHook.HookCode( @Windows.MessageBoxA,      @MessageBoxA,            @MessageBoxANext );
  madCodeHook.HookCode( @Windows.MessageBoxW,      @MessageBoxW,            @MessageBoxWNext );
  madCodeHook.HookCode( @TOpenCommonDialog.DoShow, @TCommonDialogDoShow,    @TCommonDialogDoShowNext );
{$ENDIF}

{$IFDEF HOOK_MessageDlg}
  madCodeHook.HookCode( @Dialogs.MessageDlgPosHelp,@MessageDlgPosHelp,      @MessageDlgPosHelpNext );
{$ENDIF}

{$IF NOT Defined( UNICODE ) AND Defined( HOOK_WindowsFunctions )}
  madCodeHook.HookCode( @Windows.ExtTextOut,       @ExtTextOut,             @ExtTextOutNext );
  madCodeHook.HookCode( @Windows.DrawText,         @DrawText,               @DrawTextNext );
{$IFEND}

{$IF NOT Defined( UNICODE ) AND Defined( HOOK_InitSysLocale )}
  InitSysLocaleHook;
{$IFEND}

{$IFDEF HOOK_TControlSetTextBuf}
  madCodeHook.HookCode( @TControl.SetTextBuf,      @TControlSetTextBuf,     @TControlSetTextBufNext );
{$ENDIF}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
finalization
  If Assigned( Languager ) then
    FreeAndNil( Languager );

{$IFDEF HOOK_WINDOWSDIALOGS}
  madCodeHook.UnHookCode( @MessageBoxNext );
  madCodeHook.UnHookCode( @MessageBoxANext );
  madCodeHook.UnHookCode( @MessageBoxWNext );
  madCodeHook.UnHookCode( @TCommonDialogDoShowNext );
  DeleteCriticalSection( DialogsTaskModalDialogCritSect );
{$ENDIF}

{$IFDEF HOOK_MessageDlg}
  madCodeHook.UnHookCode( @MessageDlgPosHelpNext );
{$ENDIF}

{$IF NOT Defined( UNICODE ) AND Defined( HOOK_WindowsFunctions )}
  madCodeHook.UnHookCode( @ExtTextOutNext );
  madCodeHook.UnHookCode( @DrawTextNext );
{$IFEND}

{$IF NOT Defined( UNICODE ) AND Defined( HOOK_InitSysLocale )}
  if Assigned( InitSysLocaleNext ) then
    madCodeHook.UnHookCode( @InitSysLocaleNext );
{$IFEND}

{$IFDEF HOOK_TControlSetTextBuf}
  madCodeHook.UnHookCode( @TControlSetTextBufNext );
{$ENDIF}

end.
