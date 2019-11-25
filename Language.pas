unit Language;

{
  // MS
  Wildcard search for Components
}

{$WARN UNSAFE_CAST OFF}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}
{$IF CompilerVersion >= 17}
  {$LEGACYIFEND ON}
{$IFEND}

{$DEFINE HOOK_WINDOWSDIALOGS} // MessageBox(A/W) (NO Ex-Versions), TCommonDialogs(Open/Save/Print/Font/Color/Find/Replace)

interface

uses
  Windows, Controls, Classes, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls,
  Menus, Grids, CheckLst, AppEvnts, uLanguager, uCheckStringGrid;

type
  TFrmLanguage = class( TForm )
    PnlGround: TPanel;
    PageControl: TPageControl;
    tsLanguageSource: TTabSheet;
    TimerLanguage: TTimer;
    tsLanguageAutom: TTabSheet;
    PnlManualRight: TPanel;
    PanelSourceCodeControls: TPanel;
    Memo1: TMemo;
    PnlManualLeft: TPanel;
    GroupBoxManageManual: TGroupBox;
    lblSourceFileName: TLabel;
    btnOpenSourceFile: TButton;
    btnSaveSourceFile: TButton;
    PanelStringGridFileListCompsNotInRuntimeList: TPanel;
    PnlInCompFileButNotInAppHeader: TPanel;
    PanelstringGridRuntimeCompsNotInFileList: TPanel;
    PnlKompsNotInCompFileHeader: TPanel;
    PanelStringGridCompsInFileList: TPanel;
    PnlKomponentenfileHeader: TPanel;
    PanelStringGridCompsInRuntimeList: TPanel;
    PnlLaufzeitKomponentenHeader: TPanel;
    PanelHolderUp: TPanel;
    PanelHolderDown: TPanel;
    PanelStringGridSourceStrings: TPanel;
    PnlSourceStringsHeader: TPanel;
    ApplicationEventsFKeys: TApplicationEvents;
    tsLanguageTranslate: TTabSheet;
    GroupBoxTranslationGrid: TGroupBox;
    StringGridTranslationOutput: TStringGrid;
    SplitterManuelLeftRight: TSplitter;
    SplitterAutomaticUpLeft: TSplitter;
    SplitterAutomaticUpRight: TSplitter;
    SplitterAutomatikDown: TSplitter;
    StringGridTranslationSplitter2: TSplitter;
    StringGridTranslationComponents: TStringGrid;
    StringGridTranslationInput: TStringGrid;
    StringGridTranslationSplitter1: TSplitter;
    SplitterAutomatikUpDown: TSplitter;
    PanelLangProgressing: TPanel;
    ProgressBarLang: TProgressBar;
    LabelProgressing: TLabel;
    lblProcessing: TLabel;
    PanelControls: TPanel;
    btnFindNext: TButton;
    btnReplaceAndFindNext: TButton;
    cbxLeerStringsUeberspringen: TCheckBox;
    cbxKommentiertesUeberspringen: TCheckBox;
    btnCopyStrings: TButton;
    btnScanSources: TButton;
    GroupBoxManualOutput: TGroupBox;
    MemoGlobalPas: TMemo;
    btnSkipAndFindNext: TButton;
    GrpBox: TGroupBox;
    RadioBtnDublicatesYes: TRadioButton;
    RadioBtnDublicatesAsk: TRadioButton;
    RadioBtnDublicatesNo: TRadioButton;
    TabSheetExclusion: TTabSheet;
    PanelLangExclusionGround: TPanel;
    SplitterSeperator: TSplitter;
    PanelComponents: TPanel;
    SplitterComponents: TSplitter;
    pnlExclusionRuntime: TPanel;
    PanelBoxComponents: TPanel;
    ListBoxComponents: TListBox;
    PnlListComponentsHeader: TPanel;
    PnlOtherCompoents: TPanel;
    PnlFilteredComponentsHeader: TPanel;
    ListBoxComponentsFiltered: TListBox;
    PanelFilterComponents: TPanel;
    EditFilter: TEdit;
    PanelExclusions: TPanel;
    PnlExclusionHeader: TPanel;
    PanelTranslationTop: TPanel;
    PanelLegend: TPanel;
    LabelLegendHeader: TLabel;
    PanelTranslationControls: TPanel;
    LabelTranslateInputFile: TLabel;
    LabelTranslateOutputFile: TLabel;
    LabelUnfilledLinesCap: TLabel;
    LabelUnfilledLines: TLabel;
    GroupBoxInputLanguage: TGroupBox;
    ButtonLoadInputLanguage: TButton;
    GroupBoxOutputLanguage: TGroupBox;
    ButtonLoadOutputLanguage: TButton;
    ButtonSaveTranslatedLanguage: TButton;
    ButtonClearTranslatedLanguage: TButton;
    PanelExcluded: TPanel;
    PanelExcludedAll: TPanel;
    PanelExcludedFiltered: TPanel;
    SplitterExcluded: TSplitter;
    PanelExclusionAllHeader: TPanel;
    ListBoxExcludes: TListBox;
    PanelExcludedFilteredC: TPanel;
    PanelExcludedFilteredHeader: TPanel;
    EditExcludedFilter: TEdit;
    ListBoxExcludedFiltered: TListBox;
    ButtonImportOutputLanguageSK: TButton;
    pgcAutomatic: TPageControl;
    tsAutomaticForms: TTabSheet;
    tsAutomaticComponents: TTabSheet;
    SplitterAutomaticControls: TSplitter;
    PanelAutomaticControls: TPanel;
    GrpBoxLCID: TGroupBox;
    ComboBoxLCID: TComboBox;
    GrpBoxCharSet: TGroupBox;
    ComboBoxCharSet: TComboBox;
    GroupBoxForms: TGroupBox;
    chkLbxForms: TCheckListBox;
    PanelLegendOverSize: TPanel;
    PanelLegendAutoSize: TPanel;
    chklstPropertys: TCheckListBox;
    chkTranslateAutoFill: TCheckBox;
    btnTranslateNextEmpty: TButton;
    btnTranslatePrevEmpty: TButton;
    chkHighlightVCLDifference: TCheckBox;
    pnlLegendVCL: TPanel;
    pnlLegendVCLComponentMissing: TPanel;
    MemoSourcefile: TMemo;
    btnFindPrevious: TButton;
    lbledtFortlaufendeNr: TLabeledEdit;
    btnFontSizePlus: TButton;
    btnFontSizeMinus: TButton;
    btnSourceFilePrevious: TButton;
    btnSourceFileNext: TButton;
    btnAutoFill: TButton;
    procedure btnOpenSourceFileClick( Sender: TObject );
    procedure btnSaveSourceFileClick( Sender: TObject );
    procedure TimerLanguageTimer( Sender: TObject );
    procedure btnFindNextClick( Sender: TObject );
    procedure btnFindPreviousClick( Sender: TObject );
    procedure btnSkipAndFindNextClick( Sender: TObject );
    procedure FormClose( Sender: TObject; var Action: TCloseAction );
    procedure FormCreate( Sender: TObject );
    procedure FormDestroy( Sender: TObject );
    procedure FormShow( Sender: TObject );
    procedure MemoSourcefileClick( Sender: TObject );
    procedure btnReplaceAndFindNextClick( Sender: TObject );
    procedure cbxLeerStringsUeberspringenClick( Sender: TObject );
    procedure edtFortlaufendeNrKeyPress( Sender: TObject; var Key: Char );
    procedure cbxKommentiertesUeberspringenClick( Sender: TObject );

    procedure ExclusionListComponents;
    procedure LoadExcludes;
    procedure SaveExcludes;
    function  ExcludesChanged: Boolean;
    procedure AddToExclusion( item : string );

    procedure MenuItemRefreshComponentsClick( Sender: TObject );
    procedure MenuItemLoadExclusionsClick( Sender: TObject );
    procedure MenuItemAddExclusionFromListsClick( Sender: TObject );
    procedure MenuItemAddExclusionFromListsFilteredClick( Sender: TObject );
    procedure MenuItemAddExclusionFromFilteredClick( Sender: TObject );
    procedure MenuItemSaveExclusionsClick( Sender: TObject );
    procedure MenuItemDeleteExcludeClick( Sender: TObject );
    procedure MenuItemDeleteExcludeFilteredClick( Sender: TObject );
    procedure EditFilterChange( Sender: TObject );

    procedure StringGridObjectsSelectCell( Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean );
    procedure StringGridObjectsMouseWheelUp( Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean );
    procedure StringGridObjectsMouseWheelDown( Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean );
    procedure StringGridObjectsDblClick( Sender: TObject );
    procedure StringGridObjectsDblClickPreview( Sender: TObject );
    procedure StringGridObjectsDblClick_Translate( Sender: TObject );
    procedure btnKomponentenInDateiClick( Sender: TObject );
    procedure btnKomponentenAusDateiClick( Sender: TObject );
    procedure btnImportDRCClick( Sender: TObject );
    procedure btnCollectAndInsertCodeStrings( Sender : TObject );
    procedure btnRtCompsListToCompFileListClick( Sender: TObject );
    procedure btnFindRtCompsNotInCompFileListClick( Sender: TObject );
    procedure btnSaveCompFileListClick( Sender: TObject );
    procedure cbxNoDoublicateClick( Sender: TObject );
    procedure btnMenuRefreshRuntimeCompsClick( Sender: TObject );
    procedure btnFindCompsNotInAppClick( Sender: TObject );
    procedure CheckStringGridPopUpClick_AddToExclusion( Sender : TObject );
    procedure CheckStringGridPopUpClick_AddToCompFile( Sender : TObject );
    procedure CheckStringGridPopUpClick_DelFromCompFileNotInList( Sender : TObject );
    procedure CheckStringGridPopUpClick_DelFromCompFile( Sender : TObject );
    procedure CheckStringGridPopUpClick_DelFromSourceCodeStrings( Sender : TObject );
    procedure CheckStringGridcompsNotInFileList_FlashComponent( Sender : TObject );
    procedure CheckStringGridcompsInFileList_FlashComponent( Sender : TObject );
    procedure CheckStringGridcompsInFileList_HighlightDifferencesToVCL( Sender : TObject );
    procedure StringGridPopUpClick_FlashComponent( Sender : TObject );
    procedure StringGridPopUpClick_FlashComponentTranslation( Sender : TObject );
    procedure StringGridPopUpClick_FlashComponentWithNewText( Sender : TObject );
    procedure StringGridPopUpClick_DialogLocale( Sender : TObject );
    procedure editSprachnameChange( Sender: TObject );
    procedure ApplicationEventsMessage( var Msg: tagMSG; var Handled: Boolean );
    procedure btnCopyStringsClick( Sender: TObject );
    procedure MemoSourcefileMouseUp( Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer );
    procedure MemoSourcefileKeyUp( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure ZiffernEingabe( text : string; var Key: Char; mitKomma : Boolean );
    procedure edtFortlaufendeNrExit( Sender: TObject );
    procedure ButtonLoadInputLanguageClick( Sender: TObject );
    procedure ButtonLoadOutputLanguageClick( Sender: TObject );
    procedure ButtonSaveTranslatedLanguageClick( Sender: TObject );
    procedure ButtonClearTranslatedLanguageClick( Sender: TObject );
    procedure StringGridTranslationOutputSelectCell( Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean );
    procedure StringGridTranslationOutputEnter( Sender: TObject );
    procedure StringGridTranslationOutputDrawCell( Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState );
    procedure StringGridTranslationOutputTopLeftChanged( Sender: TObject );
    procedure StringGridTranslationSplitterMoved( Sender: TObject );
    procedure SplitterAutomaticMoved( Sender: TObject );
    procedure StringGridTranslationOutputKeyPress( Sender: TObject; var Key: Char );
    procedure btnScanSourcesClick( Sender: TObject );
    procedure FormResize( Sender: TObject );
    procedure tsLanguageTranslateEnter( Sender: TObject );
    procedure PageControlChange( Sender: TObject );
    procedure ComboBoxLCIDKeyPress( Sender: TObject; var Key: Char );
    procedure ComboBoxCharSetChange( Sender: TObject );
    procedure ComboBoxLCIDChange( Sender: TObject );
    procedure chkLbxFormsClickCheck( Sender: TObject );
    procedure chkLbxFormsMouseDown( Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer );
    procedure EditExcludedFilterChange( Sender: TObject );
    procedure ButtonImportOutputLanguageSKClick( Sender: TObject );
    procedure FindEmptyLinePrevClick( Sender: TObject );
    procedure FindEmptyLineClick( Sender: TObject );
    procedure PnlKomponentenfileHeaderClick( Sender: TObject );
    procedure StringGridTranslationInputDrawCell(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure StringGridTranslationComponentsDrawCell(Sender: TObject;
      ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure btnFontSizePlusClick(Sender: TObject);
    procedure btnFontSizeMinusClick(Sender: TObject);
    procedure btnSourceFilePreviousClick(Sender: TObject);
    procedure btnSourceFileNextClick(Sender: TObject);
    procedure chkHighlightVCLDifferenceClick(Sender: TObject);
    procedure btnAutoFillClick(Sender: TObject);
  private
    { Private-Deklarationen }
    fServiceMode : boolean;
    CompFlash_inUse : boolean;
    CompFlash_Cancel : Boolean;
    CompFlash_Count  : integer;

    StringGridCompsInRuntimeList                 : TStringGrid;
    CheckStringGridSourceCodeStrings,
    CheckStringGridcompsInFileList,
    CheckStringGridRuntimeCompsNotInFileList,
    CheckStringGridFileListCompsNotInRuntimeList : TCheckStringGrid;

    lActivePage    : string;
    lFormChange    : Cardinal;
    fSourceFiles   : TStringList;
    fSourceFilesInc: Word;
    procedure InitComboBoxes;
    procedure SetServiceMode( val: boolean );
    procedure SetSprachname( s: string );
    function  GetSprachname: string;
    procedure FindEmptyLine( Next : boolean = True );
  public
    { Public-Deklarationen }
    procedure SetComboBoxLCID( LCID : Cardinal );
    procedure SetComboBoxCharSet( CharSet : integer );    
    property  ServiceMode : boolean read fServiceMode  write SetServiceMode;
    property  Sprachname  : string  read GetSprachname write SetSprachname;
  end;

var
  FrmLanguage : TFrmLanguage;
  LangMessageDlg_SizeFactor : Double = 1.0;

function GetSourceCodeString( ID: integer ): string; overload;
function GetSourceCodeString( ID: integer; default : string ): string; overload;
function ListLanguageFiles( list : TComponent ): integer;
{$IFNDEF UNICODE}
function GetLanguageWideString( Str : AnsiString ) : WideString;
{$ENDIF}

implementation

uses
  TypInfo, Messages, MMSystem, Math, Graphics, StrUtils
  {$IF CompilerVersion >= 30}, Types{$IFEND}
  {$IF CompilerVersion >= 23},UiTypes{$IFEND} // Not expanding compiler-warning ..
  {$IFNDEF UNICODE},Unicode{$ELSE},WideStrings{$ENDIF}
  ,uTLH.Strings, uTLH.StringList, SysUtils
  ;

{$R *.dfm}

Type
  TranslatorTemp = Record
    LCIDIn      : Cardinal;
    CodePageIn  : Word;
    CharSetIn   : Word;
    LCIDOut     : Cardinal;
    CodePageOut : Word;
    CharSetOut  : Word;
    Changed     : boolean;
    LARow       : Integer;
    LText       : String;
    CellChanged : boolean;
  end;

var
  TranslatorTmp    : TranslatorTemp;
  justStarted_     : boolean = false;

Const
  Lang_Version_   : String = 'v1.46';
  FormSelWaitMS_  : WORD = 2500;

procedure TFrmLanguage.InitComboBoxes;
begin
  ComboBoxLCID.Items.clear;
  ComboBoxLCID.Items.Add( 'Afrikaans (1078)' );
  ComboBoxLCID.Items.Add( 'Albanian (1052)' );
  ComboBoxLCID.Items.Add( 'Amharic (1118)' );
  ComboBoxLCID.Items.Add( 'Arabic - Algeria (5121)' );
  ComboBoxLCID.Items.Add( 'Arabic - Bahrain (15361)' );
  ComboBoxLCID.Items.Add( 'Arabic - Egypt (3073)' );
  ComboBoxLCID.Items.Add( 'Arabic - Iraq (2049)' );
  ComboBoxLCID.Items.Add( 'Arabic - Jordan (11265)' );
  ComboBoxLCID.Items.Add( 'Arabic - Kuwait (13313)' );
  ComboBoxLCID.Items.Add( 'Arabic - Lebanon (12289)' );
  ComboBoxLCID.Items.Add( 'Arabic - Libya (4097)' );
  ComboBoxLCID.Items.Add( 'Arabic - Morocco (6145)' );
  ComboBoxLCID.Items.Add( 'Arabic - Oman (8193)' );
  ComboBoxLCID.Items.Add( 'Arabic - Qatar (16385)' );
  ComboBoxLCID.Items.Add( 'Arabic - Saudi Arabia (1025)' );
  ComboBoxLCID.Items.Add( 'Arabic - Syria (10241)' );
  ComboBoxLCID.Items.Add( 'Arabic - Tunisia (7169)' );
  ComboBoxLCID.Items.Add( 'Arabic - United Arab Emirates (14337)' );
  ComboBoxLCID.Items.Add( 'Arabic - Yemen (9217)' );
  ComboBoxLCID.Items.Add( 'Armenian (1067)' );
  ComboBoxLCID.Items.Add( 'Assamese (1101)' );
  ComboBoxLCID.Items.Add( 'Azeri - Cyrillic (2092)' );
  ComboBoxLCID.Items.Add( 'Azeri - Latin (1068)' );
  ComboBoxLCID.Items.Add( 'Basque (1069)' );
  ComboBoxLCID.Items.Add( 'Belarusian (1059)' );
  ComboBoxLCID.Items.Add( 'Bengali - Bangladesh (2117)' );
  ComboBoxLCID.Items.Add( 'Bengali - India (1093)' );
  ComboBoxLCID.Items.Add( 'Bosnian (5146)' );
  ComboBoxLCID.Items.Add( 'Bulgarian (1026)' );
  ComboBoxLCID.Items.Add( 'Burmese (1109)' );
  ComboBoxLCID.Items.Add( 'Catalan (1027)' );
  ComboBoxLCID.Items.Add( 'Chinese - China (2052)' );
  ComboBoxLCID.Items.Add( 'Chinese - Hong Kong SAR (3076)' );
  ComboBoxLCID.Items.Add( 'Chinese - Macau SAR (5124)' );
  ComboBoxLCID.Items.Add( 'Chinese - Singapore (4100)' );
  ComboBoxLCID.Items.Add( 'Chinese - Taiwan (1028)' );
  ComboBoxLCID.Items.Add( 'Croatian (1050)' );
  ComboBoxLCID.Items.Add( 'Czech (1029)' );
  ComboBoxLCID.Items.Add( 'Danish (1030)' );
  ComboBoxLCID.Items.Add( 'Divehi (dv)' );
  ComboBoxLCID.Items.Add( 'Dutch - Belgium (2067)' );
  ComboBoxLCID.Items.Add( 'Dutch - Netherlands (1043)' );
  ComboBoxLCID.Items.Add( 'Edo (1126)' );
  ComboBoxLCID.Items.Add( 'English - Australia (3081)' );
  ComboBoxLCID.Items.Add( 'English - Belize (10249)' );
  ComboBoxLCID.Items.Add( 'English - Canada (4105)' );
  ComboBoxLCID.Items.Add( 'English - Caribbean (9225)' );
  ComboBoxLCID.Items.Add( 'English - Great Britain (2057)' );
  ComboBoxLCID.Items.Add( 'English - India (16393)' );
  ComboBoxLCID.Items.Add( 'English - Ireland (6153)' );
  ComboBoxLCID.Items.Add( 'English - Jamaica (8201)' );
  ComboBoxLCID.Items.Add( 'English - New Zealand (5129)' );
  ComboBoxLCID.Items.Add( 'English - Phillippines (13321)' );
  ComboBoxLCID.Items.Add( 'English - Southern Africa (7177)' );
  ComboBoxLCID.Items.Add( 'English - Trinidad (11273)' );
  ComboBoxLCID.Items.Add( 'English - United States (1033)' );
  ComboBoxLCID.Items.Add( 'English - Zimbabwe (12297)' );
  ComboBoxLCID.Items.Add( 'Estonian (1061)' );
  ComboBoxLCID.Items.Add( 'FYRO Macedonia (1071)' );
  ComboBoxLCID.Items.Add( 'Faroese (1080)' );
  ComboBoxLCID.Items.Add( 'Farsi - Persian (1065)' );
  ComboBoxLCID.Items.Add( 'Filipino (1124)' );
  ComboBoxLCID.Items.Add( 'Finnish (1035)' );
  ComboBoxLCID.Items.Add( 'French - Belgium (2060)' );
  ComboBoxLCID.Items.Add( 'French - Cameroon (11276)' );
  ComboBoxLCID.Items.Add( 'French - Canada (3084)' );
  ComboBoxLCID.Items.Add( 'French - Congo (9228)' );
  ComboBoxLCID.Items.Add( 'French - Cote d''Ivoire (12300)' );
  ComboBoxLCID.Items.Add( 'French - France (1036)' );
  ComboBoxLCID.Items.Add( 'French - Luxembourg (5132)' );
  ComboBoxLCID.Items.Add( 'French - Mali (13324)' );
  ComboBoxLCID.Items.Add( 'French - Monaco (6156)' );
  ComboBoxLCID.Items.Add( 'French - Morocco (14348)' );
  ComboBoxLCID.Items.Add( 'French - Senegal (10252)' );
  ComboBoxLCID.Items.Add( 'French - Switzerland (4108)' );
  ComboBoxLCID.Items.Add( 'French - West Indies (7180)' );
  ComboBoxLCID.Items.Add( 'Frisian - Netherlands (1122)' );
  ComboBoxLCID.Items.Add( 'Gaelic - Ireland (2108)' );
  ComboBoxLCID.Items.Add( 'Gaelic - Scotland (1084)' );
  ComboBoxLCID.Items.Add( 'Galician (1110)' );
  ComboBoxLCID.Items.Add( 'Georgian (1079)' );
  ComboBoxLCID.Items.Add( 'German - Austria (3079)' );
  ComboBoxLCID.Items.Add( 'German - Germany (1031)' );
  ComboBoxLCID.Items.Add( 'German - Liechtenstein (5127)' );
  ComboBoxLCID.Items.Add( 'German - Luxembourg (4103)' );
  ComboBoxLCID.Items.Add( 'German - Switzerland (2055)' );
  ComboBoxLCID.Items.Add( 'Greek (1032)' );
  ComboBoxLCID.Items.Add( 'Guarani - Paraguay (1140)' );
  ComboBoxLCID.Items.Add( 'Gujarati (1095)' );
  ComboBoxLCID.Items.Add( 'HID (Human Interface Device) (1279)' );
  ComboBoxLCID.Items.Add( 'Hebrew (1037)' );
  ComboBoxLCID.Items.Add( 'Hindi (1081)' );
  ComboBoxLCID.Items.Add( 'Hungarian (1038)' );
  ComboBoxLCID.Items.Add( 'Icelandic (1039)' );
  ComboBoxLCID.Items.Add( 'Igbo - Nigeria (1136)' );
  ComboBoxLCID.Items.Add( 'Indonesian (1057)' );
  ComboBoxLCID.Items.Add( 'Italian - Italy (1040)' );
  ComboBoxLCID.Items.Add( 'Italian - Switzerland (2064)' );
  ComboBoxLCID.Items.Add( 'Japanese (1041)' );
  ComboBoxLCID.Items.Add( 'Kannada (1099)' );
  ComboBoxLCID.Items.Add( 'Kashmiri (1120)' );
  ComboBoxLCID.Items.Add( 'Kazakh (1087)' );
  ComboBoxLCID.Items.Add( 'Khmer (1107)' );
  ComboBoxLCID.Items.Add( 'Konkani (1111)' );
  ComboBoxLCID.Items.Add( 'Korean (1042)' );
  ComboBoxLCID.Items.Add( 'Kyrgyz - Cyrillic (1088)' );
  ComboBoxLCID.Items.Add( 'Lao (1108)' );
  ComboBoxLCID.Items.Add( 'Latin (1142)' );
  ComboBoxLCID.Items.Add( 'Latvian (1062)' );
  ComboBoxLCID.Items.Add( 'Lithuanian (1063)' );
  ComboBoxLCID.Items.Add( 'Malay - Brunei (2110)' );
  ComboBoxLCID.Items.Add( 'Malay - Malaysia (1086)' );
  ComboBoxLCID.Items.Add( 'Malayalam (1100)' );
  ComboBoxLCID.Items.Add( 'Maltese (1082)' );
  ComboBoxLCID.Items.Add( 'Manipuri (1112)' );
  ComboBoxLCID.Items.Add( 'Maori (1153)' );
  ComboBoxLCID.Items.Add( 'Marathi (1102)' );
  ComboBoxLCID.Items.Add( 'Mongolian (2128)' );
  ComboBoxLCID.Items.Add( 'Mongolian (1104)' );
  ComboBoxLCID.Items.Add( 'Nepali (1121)' );
  ComboBoxLCID.Items.Add( 'Norwegian - Bokml (1044)' );
  ComboBoxLCID.Items.Add( 'Norwegian - Nynorsk (2068)' );
  ComboBoxLCID.Items.Add( 'Oriya (1096)' );
  ComboBoxLCID.Items.Add( 'Polish (1045)' );
  ComboBoxLCID.Items.Add( 'Portuguese - Brazil (1046)' );
  ComboBoxLCID.Items.Add( 'Portuguese - Portugal (2070)' );
  ComboBoxLCID.Items.Add( 'Punjabi (1094)' );
  ComboBoxLCID.Items.Add( 'Raeto-Romance (1047)' );
  ComboBoxLCID.Items.Add( 'Romanian - Moldova (2072)' );
  ComboBoxLCID.Items.Add( 'Romanian - Romania (1048)' );
  ComboBoxLCID.Items.Add( 'Russian (1049)' );
  ComboBoxLCID.Items.Add( 'Russian - Moldova (2073)' );
  ComboBoxLCID.Items.Add( 'Sami Lappish (1083)' );
  ComboBoxLCID.Items.Add( 'Sanskrit (1103)' );
  ComboBoxLCID.Items.Add( 'Serbian - Cyrillic (3098)' );
  ComboBoxLCID.Items.Add( 'Serbian - Latin (2074)' );
  ComboBoxLCID.Items.Add( 'Sesotho (Sutu) (1072)' );
  ComboBoxLCID.Items.Add( 'Setsuana (1074)' );
  ComboBoxLCID.Items.Add( 'Sindhi (1113)' );
  ComboBoxLCID.Items.Add( 'Sinhala (si)' );
  ComboBoxLCID.Items.Add( 'Slovak (1051)' );
  ComboBoxLCID.Items.Add( 'Slovenian (1060)' );
  ComboBoxLCID.Items.Add( 'Somali (1143)' );
  ComboBoxLCID.Items.Add( 'Sorbian (1070)' );
  ComboBoxLCID.Items.Add( 'Spanish - Argentina (11274)' );
  ComboBoxLCID.Items.Add( 'Spanish - Bolivia (16394)' );
  ComboBoxLCID.Items.Add( 'Spanish - Chile (13322)' );
  ComboBoxLCID.Items.Add( 'Spanish - Colombia (9226)' );
  ComboBoxLCID.Items.Add( 'Spanish - Costa Rica (5130)' );
  ComboBoxLCID.Items.Add( 'Spanish - Dominican Republic (7178)' );
  ComboBoxLCID.Items.Add( 'Spanish - Ecuador (12298)' );
  ComboBoxLCID.Items.Add( 'Spanish - El Salvador (17418)' );
  ComboBoxLCID.Items.Add( 'Spanish - Guatemala (4106)' );
  ComboBoxLCID.Items.Add( 'Spanish - Honduras (18442)' );
  ComboBoxLCID.Items.Add( 'Spanish - Mexico (2058)' );
  ComboBoxLCID.Items.Add( 'Spanish - Nicaragua (19466)' );
  ComboBoxLCID.Items.Add( 'Spanish - Panama (6154)' );
  ComboBoxLCID.Items.Add( 'Spanish - Paraguay (15370)' );
  ComboBoxLCID.Items.Add( 'Spanish - Peru (10250)' );
  ComboBoxLCID.Items.Add( 'Spanish - Puerto Rico (20490)' );
  ComboBoxLCID.Items.Add( 'Spanish - Spain (Traditional) (1034)' );
  ComboBoxLCID.Items.Add( 'Spanish - Uruguay (14346)' );
  ComboBoxLCID.Items.Add( 'Spanish - Venezuela (8202)' );
  ComboBoxLCID.Items.Add( 'Swahili (1089)' );
  ComboBoxLCID.Items.Add( 'Swedish - Finland (2077)' );
  ComboBoxLCID.Items.Add( 'Swedish - Sweden (1053)' );
  ComboBoxLCID.Items.Add( 'Syriac (1114)' );
  ComboBoxLCID.Items.Add( 'Tajik (1064)' );
  ComboBoxLCID.Items.Add( 'Tamil (1097)' );
  ComboBoxLCID.Items.Add( 'Tatar (1092)' );
  ComboBoxLCID.Items.Add( 'Telugu (1098)' );
  ComboBoxLCID.Items.Add( 'Thai (1054)' );
  ComboBoxLCID.Items.Add( 'Tibetan (1105)' );
  ComboBoxLCID.Items.Add( 'Tsonga (1073)' );
  ComboBoxLCID.Items.Add( 'Turkish (1055)' );
  ComboBoxLCID.Items.Add( 'Turkmen (1090)' );
  ComboBoxLCID.Items.Add( 'Ukrainian (1058)' );
  ComboBoxLCID.Items.Add( 'Unicode (0)' );
  ComboBoxLCID.Items.Add( 'Urdu (1056)' );
  ComboBoxLCID.Items.Add( 'Uzbek - Cyrillic (2115)' );
  ComboBoxLCID.Items.Add( 'Uzbek - Latin (1091)' );
  ComboBoxLCID.Items.Add( 'Venda (1075)' );
  ComboBoxLCID.Items.Add( 'Vietnamese (1066)' );
  ComboBoxLCID.Items.Add( 'Welsh (1106)' );
  ComboBoxLCID.Items.Add( 'Xhosa (1076)' );
  ComboBoxLCID.Items.Add( 'Yiddish (1085)' );
  ComboBoxLCID.Items.Add( 'Zulu (1077)' );

  ComboBoxCharSet.Items.clear;
  ComboBoxCharSet.Items.Add( '000 (ANSI characters.)' );
  ComboBoxCharSet.Items.Add( '001 (Default charset)' );
  ComboBoxCharSet.Items.Add( '002 (Standard symbol set.)' );
  ComboBoxCharSet.Items.Add( '077 (Macintosh characters. Not available on NT 3.51.)' );
  ComboBoxCharSet.Items.Add( '128 (Japanese shift-JIS characters.)' );
  ComboBoxCharSet.Items.Add( '129 (Korean characters (Wansung).)' );
  ComboBoxCharSet.Items.Add( '130 (Korean characters (Johab). Not available on NT 3.51)' );
  ComboBoxCharSet.Items.Add( '134 (Simplified Chinese characters (mainland china).)' );
  ComboBoxCharSet.Items.Add( '136 (Traditional Chinese characters (Taiwanese).)' );
  ComboBoxCharSet.Items.Add( '161 (Greek characters. Not available on NT 3.51.)' );
  ComboBoxCharSet.Items.Add( '162 (Turkish characters. Not available on NT 3.51)' );
  ComboBoxCharSet.Items.Add( '163 (Vietnamese characters. Not available on NT 3.51.)' );
  ComboBoxCharSet.Items.Add( '177 (Hebrew characters. Not available on NT 3.51)' );
  ComboBoxCharSet.Items.Add( '178 (Arabic characters. Not available on NT 3.51)' );
  ComboBoxCharSet.Items.Add( '186 (Baltic characters. Not available on NT 3.51.)' );
  ComboBoxCharSet.Items.Add( '204 (Cyrillic characters. Not available on NT 3.51.)' );
  ComboBoxCharSet.Items.Add( '222 (Thai characters. Not available on NT 3.51)' );
  ComboBoxCharSet.Items.Add( '238 (Includes diacritical marks for eastern european countries. Not available on NT 3.51.)' );
  ComboBoxCharSet.Items.Add( '255 (Depends on the codepage of the operating system.)' );
end;

procedure TFrmLanguage.SetServiceMode( val: boolean );
begin
  if ( fServiceMode = val ) then
    Exit;

  fServiceMode := val;

  PageControl.HandleNeeded; // ReCreate Handle in order to workArround the "Index out of Bounds"-Bug caused internaly by WndReCreate

  tsLanguageAutom.TabVisible  := val;
  tsLanguageSource.TabVisible := val;
end;

procedure TFrmLanguage.SetSprachname( s: string );
begin
  Languager.LanguageSelectionPerName( s );
end;

function  TFrmLanguage.GetSprachname: string;
begin
  result := Languager.sprachname;
end;

procedure TFrmLanguage.btnOpenSourceFileClick( Sender: TObject );
var
  res  : integer;
  Open : TOpenDialog;
begin
  if languageReplacer.TextBoxChanged then
    begin
    res := MessageBox( Application.Handle, 'SourceCode-File has been changed! Save?', 'Warning', mb_YesNoCancel );
    case res of
      idNo     : ;
      idYes    : btnSaveSourceFileClick( self );
      idCancel : exit;
    end;
    end;

  Open := TOpenDialog.Create( Self );
  Open.Options := Open.Options+[ ofAllowMultiSelect ];
  Open.InitialDir := ExtractFileDir( application.exename );
  Open.Filter := 'pascal-Files |*.pas;*.inc';
  if Open.Execute then
    begin
    fSourceFiles.Clear;
    if ( Open.Files.Count > 1 ) then
      begin
      fSourceFiles.Assign( Open.Files );
      fSourceFilesInc := 0;
      end;

    btnSourceFilePrevious.Enabled := False;
    btnSourceFileNext.Enabled := ( fSourceFiles.Count > 1 );

    if languageReplacer.OpenFile( Open.Files[ 0 ] ) then
      lblSourceFileName.Caption := Open.Files[ 0 ];
    end;
  Open.free;
end;

procedure TFrmLanguage.btnSourceFilePreviousClick(Sender: TObject);
var
  res : Integer;
begin
  if languageReplacer.TextBoxChanged then
    begin
    res := MessageBox( Application.Handle, 'SourceCode-File has been changed! Save?', 'Warning', mb_YesNoCancel );
    case res of
      idNo     : ;
      idYes    : btnSaveSourceFileClick( self );
      idCancel : exit;
    end;
    end;

  Dec( fSourceFilesInc );
  if languageReplacer.OpenFile( fSourceFiles[ fSourceFilesInc ] ) then
    lblSourceFileName.Caption := fSourceFiles[ fSourceFilesInc ];

  btnSourceFilePrevious.Enabled := NOT ( 0 = fSourceFilesInc );
  btnSourceFileNext.Enabled     := NOT ( fSourceFiles.Count-1 = fSourceFilesInc );
end;

procedure TFrmLanguage.btnSourceFileNextClick(Sender: TObject);
var
  res : Integer;
begin
  if languageReplacer.TextBoxChanged then
    begin
    res := MessageBox( Application.Handle, 'SourceCode-File has been changed! Save?', 'Warning', mb_YesNoCancel );
    case res of
      idNo     : ;
      idYes    : btnSaveSourceFileClick( self );
      idCancel : exit;
    end;
    end;
    
  Inc( fSourceFilesInc );
  if languageReplacer.OpenFile( fSourceFiles[ fSourceFilesInc ] ) then
    lblSourceFileName.Caption := fSourceFiles[ fSourceFilesInc ];

  btnSourceFilePrevious.Enabled := NOT ( 0 = fSourceFilesInc );
  btnSourceFileNext.Enabled     := NOT ( fSourceFiles.Count-1 = fSourceFilesInc );
end;

procedure TFrmLanguage.btnSaveSourceFileClick( Sender: TObject );
var
  Save : TSaveDialog;
begin
  Save := TSaveDialog.Create( self );
  Save.InitialDir := ExtractFileDir( application.exename );
  Save.Filter := 'pascal-Files |*.pas;*.inc';
  Save.FileName := languageReplacer.filename;
  if Save.Execute then
    begin
    languageReplacer.CreateFileSik( 'source', languageReplacer.filename );
    languageReplacer.AddUses;

    MemoSourcefile.lines.SaveToFile( Save.FileName );
    lblSourceFileName.Caption := Save.FileName;
    end;

  MemoSourcefile.Modified := false;
  Save.free;
end;

procedure TFrmLanguage.chkLbxFormsClickCheck( Sender: TObject );
begin
  lFormChange := TimeGetTime;
end;

procedure TFrmLanguage.chkLbxFormsMouseDown( Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer );
var
  aIndex: Integer;
  form : TWinControl;
begin
  if NOT ( sender is TCheckListBox ) then
    Exit;

  if ( Button = mbLeft ) and ( ssDouble in Shift ) then
    begin
    aIndex := TCheckListBox( sender ).ItemAtPos( Point( X, Y ), True );
    if ( aIndex <> -1 ) then
      if ( Languager.FindFormByName( TCheckListBox( sender ).Items[ aIndex ], form ) ) then
        if NOT Form.Visible then
          Form.Show;
    end;
end;

procedure TFrmLanguage.TimerLanguageTimer( Sender: TObject );
const
  sUnicode  : string = {$IFDEF UNICODE}'UNICODE'{$ELSE}'NON UNICODE'{$ENDIF};
  sBitDepth : string = {$IFDEF Win64}'x64'{$ELSE}'x86'{$ENDIF};
var
  i : integer;
begin
  caption := Format( 'Languager %s (%s - %s) - %s - %s', [ Lang_Version_, sUnicode, sBitDepth, DateToStr( now ), TimeToStr( now ) ] );
  if ( justStarted_ ) then
    begin
    justStarted_ := false;
    Languager.ShowForms;
    LoadExcludes;
    ExclusionListComponents;
    end;

  if ( lFormChange <> 0 ) then
    if ( TimeGetTime >= lFormChange + FormSelWaitMS_ ) then
      begin
      lFormChange := 0;
      Languager.ShowObjectsInStringlist;
      end;

  if ( CompFlash_inUse ) then
    begin
    if ( Languager.TriggerComponentVisible( Languager.FlashComponent, false ) ) then
      begin
      Inc( CompFlash_Count );
      if ( CompFlash_Count = 16 ) OR CompFlash_Cancel then
        begin
        if ( CompFlash_Cancel ) AND ( CompFlash_Count mod 2 <> 0 ) then
          Languager.TriggerComponentVisible( Languager.FlashComponent, false );

        CompFlash_Cancel := false;
        CompFlash_inUse := false;

        Languager.TriggerComponentText( Languager.FlashComponent, '' );
        if ( Languager.FlashComponentForm <> nil ) then
          begin
          Languager.FlashComponentForm.Hide;
          Languager.FlashComponentForm := nil;
          end;

        if ( Languager.FlashComponentVisibles <> '' ) then
          begin
          for i := 1 to NumTok( Languager.FlashComponentVisibles, ' ' ) do
            SetPropValue( Languager.ReturnFormByName( GetTok( Languager.FlashComponent ,1 , '.' ) ).FindComponent( GetTok( Languager.FlashComponentVisibles, i, ' ' ) ), 'Visible', false );
          Languager.FlashComponentVisibles := '';
          end;
        end;
      end
    else
      CompFlash_inUse := false;
    end;
end;

procedure TFrmLanguage.FormClose( Sender: TObject; var Action: TCloseAction );
var res: integer;
begin
  if ( ExcludesChanged ) then // Exclusion
    begin
    res := MessageBox( Application.Handle, 'Excludes have been changed! Save?', 'Warning', mb_YesNoCancel );
    case res of
      idNo     : ;
      idYes    : SaveExcludes;
      idCancel : begin
                 action := caNone;
                 exit;
                 end;
    end;
    end;

  if languageReplacer.TextBoxChanged then // Manual
    begin
    res := MessageBox( Application.Handle, 'SourceCode-File has been changed! Save?', 'Warning', mb_YesNoCancel );
    case res of
      idNo     : ;
      idYes    : btnSaveSourceFileClick( self );
      idCancel : begin
                 action := caNone;
                 exit;
                 end;
    end;
    end;

  if Languager.changed then // Automatic
    begin
    res := MessageBox( Application.Handle, 'Component-File has been changed! Save?', 'Warning', mb_YesNoCancel );
    case res of
      idNo     : ;
      idYes    : btnSaveCompFileListClick( self );
      idCancel : begin
                 action := caNone;
                 exit;
                 end;
    end;
    end;

  if TranslatorTmp.Changed then // Translation
    begin
    res := MessageBox( Application.Handle, 'Translation was edited, save changes?', 'Warning', mb_YesNoCancel );
    case res of
      idNo     : ;
      idYes    : ButtonSaveTranslatedLanguageClick( self );
      idCancel : begin
                 action := caNone;
                 exit;
                 end;
    end;
    end;

  Languager.SaveForms;
end;

procedure TFrmLanguage.FormCreate( Sender: TObject );
  procedure D10;
  begin
  // Exclusion
  pnlExclusionRuntime.ParentBackground := false;
  PnlListComponentsHeader.ParentBackground := false;
  PnlFilteredComponentsHeader.ParentBackground := false;
  PnlExclusionHeader.ParentBackground := false;
  PanelExclusionAllHeader.ParentBackground := false;
  PanelExcludedFilteredHeader.ParentBackground := false;
  // Automatic
  PnlLaufzeitKomponentenHeader.ParentBackground := false;
  PnlKomponentenfileHeader.ParentBackground := false;
  PnlSourceStringsHeader.ParentBackground := false;
  PnlKompsNotInCompFileHeader.ParentBackground := false;
  PnlInCompFileButNotInAppHeader.ParentBackground := false;
  // Translate
//  PanelLegend.ParentBackground := false;
  PanelLegendOverSize.ParentBackground := false;
  PanelLegendAutoSize.ParentBackground := false;
  pnlLegendVCL.ParentBackground := false;
  pnlLegendVCLComponentMissing.ParentBackground := false;
  end;
var
  i    : Integer;
  Item : TMenuItem;
  Item2: TMenuItem;
  Menu : TPopUpMenu;
  Hint : String;
begin
  {$IF CompilerVersion >= 30 }D10;{$IFEND}

  InitComboBoxes;
  lActivePage := 'TabSheetExclusion';
  lFormChange := 0;

  self.ServiceMode := true;

  if ( languageReplacer = nil ) then
    begin
    languageReplacer := tLanguageReplacer.create;
    languageReplacer.Init( 0, StrToIntDef( lbledtFortlaufendeNr.Text, 1000 ), '''', MemoSourcefile, MemoGlobalPAS, true, true );
    end;

  //Exclusion
  Menu := TPopupMenu.Create( Self );
  Menu.Name := 'PopupMenuLanguageComponents';
  for i := 0 to 1 do
    begin
    Item := TMenuItem.Create( Menu );
    with Item do
      begin
      case i of
           0:
            begin
            Item.Name := Menu.Name + IntToStr( Menu.Items.Count+1 );
            Caption := 'Add Exclusion';
            OnClick := MenuItemAddExclusionFromListsClick;
            end;
           1:
            begin
            Item.Name := Menu.Name + IntToStr( Menu.Items.Count+1 );
            Caption := 'Refresh';
            OnClick := MenuItemRefreshComponentsClick;
            end;
      end; // case
      end; // with
    Menu.Items.Add( Item );
    end;
  ListBoxComponents.PopUpMenu := Menu;

  Menu := TPopupMenu.Create( Self );
  Menu.Name := 'PopupMenuLanguageComponentsFiltered';
  for i := 0 to 0 do
    begin
    Item := TMenuItem.Create( Menu );
    with Item do
      begin
      case i of
           0:
            begin
            Item.Name := Menu.Name + IntToStr( Menu.Items.Count+1 );
            Caption := 'Add Exclusion';
            OnClick := MenuItemAddExclusionFromListsFilteredClick;
            end;
      end; // case
      end; // with
    Menu.Items.Add( Item );
    end;
  ListBoxComponentsFiltered.PopUpMenu := Menu;

  Menu := TPopUpMenu.Create( self );
  Menu.Name := 'PopupMenuLanguageExclusions';
  for i := 0 to 2 do
    begin
    Item := TMenuItem.Create( Menu );
    with Item do
      begin
      case i of
           0:
            begin
            Item.Name := Menu.Name + IntToStr( Menu.Items.Count+1 );
            Caption := 'Delete';
            OnClick := MenuItemDeleteExcludeClick;
            end;
           1:
            begin
            Item.Name := Menu.Name + IntToStr( Menu.Items.Count+1 );
            Caption := 'Save';
            OnClick := MenuItemSaveExclusionsClick;
            end;
           2:
            begin
            Item.Name := Menu.Name + IntToStr( Menu.Items.Count+1 );
            Caption := 'Load';
            OnClick := MenuItemLoadExclusionsClick;
            end;
      end; // case
      end; // with
    Menu.Items.Add( Item );
    end;
  ListBoxExcludes.PopUpMenu := Menu;

  Menu := TPopUpMenu.Create( self );
  Menu.Name := 'PopupMenuLanguageExclusionsFiltered';
  for i := 0 to 2 do
    begin
    Item := TMenuItem.Create( Menu );
    with Item do
      begin
      case i of
           0:
            begin
            Item.Name := Menu.Name + IntToStr( Menu.Items.Count+1 );
            Caption := 'Delete';
            OnClick := MenuItemDeleteExcludeFilteredClick;
            end;
           1:
            begin
            Item.Name := Menu.Name + IntToStr( Menu.Items.Count+1 );
            Caption := 'Save';
            OnClick := MenuItemSaveExclusionsClick;
            end;
           2:
            begin
            Item.Name := Menu.Name + IntToStr( Menu.Items.Count+1 );
            Caption := 'Load';
            OnClick := MenuItemLoadExclusionsClick;
            end;
      end; // case
      end; // with
    Menu.Items.Add( Item );
    end;
  ListBoxExcludedFiltered.PopUpMenu := Menu;

  LoadExcludes;

  // RuntimeComps
  StringGridCompsInRuntimeList := TStringGrid.Create( self );
  StringGridCompsInRuntimeList.Parent := PanelstringGridCompsInRuntimeList;
  StringGridCompsInRuntimeList.Name := 'StringGridCompsInRuntimeList';
  StringGridCompsInRuntimeList.OnDblClick := StringGridObjectsDblClick;
  StringGridCompsInRuntimeList.OnMouseWheelUp := StringGridObjectsMouseWheelUp;
  StringGridCompsInRuntimeList.OnMouseWheelDown := StringGridObjectsMouseWheelDown;
  StringGridCompsInRuntimeList.OnSelectCell := StringGridObjectsSelectCell;

  Menu := TPopUpMenu.Create( self );
  Menu.Name := StringGridCompsInRuntimeList.Name + '_PopUpMenu';
  for i := 0 to 4 do
    begin
    Item := TMenuItem.Create( Menu );
    with Item do
      begin
      case i of
           0:
            begin
            Item.Name := Menu.Name + IntToStr( Menu.Items.Count+1 );
            Caption := 'Load CompFile';
            OnClick := btnKomponentenAusDateiClick;
            end;
           1:
            begin
            Item.Name := Menu.Name + IntToStr( Menu.Items.Count+1 );
            Caption := 'Import CompFile (DRC)';
            OnClick := btnImportDRCClick;
            end;
           2:
            begin
            Item.Name := Menu.Name + IntToStr( Menu.Items.Count+1 );
            Caption := 'Save CompFile';
            OnClick := btnSaveCompFileListClick;
            end;
           3:
            begin
            Item.Name := Menu.Name + IntToStr( Menu.Items.Count+1 );
            Caption := 'Dialog Locale';

            Item2 := TMenuItem.Create( Item );
            Item2.Name := Menu.Name + '_Locale_German';
            Item2.Caption := 'Deutsch';
            Item2.OnClick := StringGridPopUpClick_DialogLocale;
            Item.Add( Item2 );

            Item2 := TMenuItem.Create( Item );
            Item2.Name := Menu.Name + '_Locale_English';
            Item2.Caption := 'English';
            Item2.OnClick := StringGridPopUpClick_DialogLocale;
            Item.Add( Item2 );

            {$IFDEF HOOK_WINDOWSDIALOGS}
            Item2 := TMenuItem.Create( Item );
            Item2.Name := Menu.Name + '_Locale_Windows';
            Item2.Caption := 'Windows';
            Item2.OnClick := StringGridPopUpClick_DialogLocale;
            Item.Add( Item2 );

            Item2 := TMenuItem.Create( Item );
            Item2.Name := Menu.Name + '_Locale_ShowCurrent';
            Item2.Caption := 'Show Current';
            Item2.OnClick := StringGridPopUpClick_DialogLocale;
            Item.Add( Item2 );
            {$ENDIF}
            end;
           4:
            begin
            Item.Name := Menu.Name + IntToStr( Menu.Items.Count+1 );
            Caption := 'Flash Component';
            OnClick := StringGridPopUpClick_FlashComponent;
            end;
      end; // case
      end; // with
    Menu.Items.Add( Item );
    end;
  StringGridCompsInRuntimeList.PopUpMenu := Menu;

  //Comps in Compfile
  CheckStringGridcompsInFileList := TCheckStringGrid.Create( self );
  CheckStringGridcompsInFileList.Name := 'CheckStringGridcompsInFileList';
  CheckStringGridcompsInFileList.Parent := PanelstringGridcompsInFileList;
  CheckStringGridcompsInFileList.DeleteMenu := false;
  CheckStringGridcompsInFileList.OnDblClick := StringGridObjectsDblClick;

  Menu := CheckStringGridcompsInFileList.PopUpMenu; // Extend Menu
  Menu.Name := CheckStringGridcompsInFileList.Name + '_PopUpMenu';
  for i := 0 to 7 do
    begin
    Item := TMenuItem.Create( Menu );
    with Item do
      begin
      case i of
           0:
            begin
            Item.Name := Menu.Name + '_PopUpMenuItem_' + IntToStr( Menu.Items.Count+1 );
            Caption := 'Delete from CompFile';
            OnClick := CheckStringGridPopUpClick_DelFromCompFile;
            end;
           1:
            begin
            Item.Name := Menu.Name + '_PopUpMenuItem_' + IntToStr( Menu.Items.Count+1 );
            Caption := 'Add to Exclusions';
            OnClick := CheckStringGridPopUpClick_AddToExclusion;
            end;
           2:
            begin
            Item.Name := Menu.Name + IntToStr( Menu.Items.Count+1 );
            Caption := 'Load CompFile';
            OnClick := btnKomponentenAusDateiClick;
            end;
           3:
            begin
            Item.Name := Menu.Name + IntToStr( Menu.Items.Count+1 );
            Caption := 'Import Compfile (DRC)';
            OnClick := btnImportDRCClick;
            end;
           4:
            begin
            Item.Name := Menu.Name + IntToStr( Menu.Items.Count+1 );
            Caption := 'Save CompFile';
            OnClick := btnSaveCompFileListClick;
            end;
           5:
            begin
            Item.Name := Menu.Name + IntToStr( Menu.Items.Count+1 );
            Caption := 'Dialog Locale';

            Item2 := TMenuItem.Create( Item );
            Item2.Name := Menu.Name + '_Locale_German';
            Item2.Caption := 'Deutsch';
            Item2.OnClick := StringGridPopUpClick_DialogLocale;
            Item.Add( Item2 );

            Item2 := TMenuItem.Create( Item );
            Item2.Name := Menu.Name + '_Locale_English';
            Item2.Caption := 'English';
            Item2.OnClick := StringGridPopUpClick_DialogLocale;
            Item.Add( Item2 );

            {$IFDEF HOOK_WINDOWSDIALOGS}
            Item2 := TMenuItem.Create( Item );
            Item2.Name := Menu.Name + '_Locale_Windows';
            Item2.Caption := 'Windows';
            Item2.OnClick := StringGridPopUpClick_DialogLocale;
            Item.Add( Item2 );

            Item2 := TMenuItem.Create( Item );
            Item2.Name := Menu.Name + '_Locale_ShowCurrent';
            Item2.Caption := 'Show Current';
            Item2.OnClick := StringGridPopUpClick_DialogLocale;
            Item.Add( Item2 );
            {$ENDIF}
            end;
           6:
            begin
            Item.Name := Menu.Name + IntToStr( Menu.Items.Count+1 );
            Caption := 'Flash Component';
            OnClick := CheckStringGridcompsInFileList_FlashComponent;
            end;
           7:
            begin
            Item.Name := Menu.Name + IntToStr( Menu.Items.Count+1 );
            Caption := 'Highlight differences to VCL';
            OnClick := CheckStringGridcompsInFileList_HighlightDifferencesToVCL;
            end;

        end; // case
      end; // with
    Menu.Items.Add( Item );
    end;
  CheckStringGridcompsInFileList.PopUpMenu := Menu;

  //Strings
  CheckStringGridSourceCodeStrings := TCheckStringGrid.Create( self );
  CheckStringGridSourceCodeStrings.Name := 'CheckStringGridSourceCodeStrings';
  CheckStringGridSourceCodeStrings.Parent := PanelStringGridSourceStrings;
  CheckStringGridSourceCodeStrings.DeleteMenu := false;

//  CheckStringGridSourceCodeStrings.Cells[ 1, 0 ] := INTERNAL_GRID_HEADER_SOURCE_;
  Menu := CheckStringGridSourceCodeStrings.PopUpMenu; // Extend Menu
  Menu.Name := CheckStringGridSourceCodeStrings.Name + '_PopUpMenu';
  for i := 0 to 5 do
    begin
    Item := TMenuItem.Create( Menu );
    with Item do
      begin
      case i of
           0:
            begin
            Item.Name := Menu.Name + '_PopUpMenuItem_' + IntToStr( Menu.Items.Count+1 );
            Caption := 'Scan Source-Files';
            OnClick := btnCollectAndInsertCodeStrings;
            end;
           1:
            begin
            Item.Name := Menu.Name + '_PopUpMenuItem_' + IntToStr( Menu.Items.Count+1 );
            Caption := 'Delete from CompFile';
            OnClick := CheckStringGridPopUpClick_DelFromSourceCodeStrings;
            end;
           2:
            begin
            Item.Name := Menu.Name + '_PopUpMenuItem_' + IntToStr( Menu.Items.Count+1 );
            Caption := 'Load CompFile';
            OnClick := btnKomponentenAusDateiClick;
            end;
           3:
            begin
            Item.Name := Menu.Name + '_PopUpMenuItem_' + IntToStr( Menu.Items.Count+1 );
            Caption := 'Import CompFile (DRC)';
            OnClick := btnImportDRCClick;
            end;
           4:
            begin
            Item.Name := Menu.Name + '_PopUpMenuItem_' + IntToStr( Menu.Items.Count+1 );
            Caption := 'Save Compfile';
            OnClick := btnSaveCompFileListClick;
            end;
           5:
            begin
            Item.Name := Menu.Name + IntToStr( Menu.Items.Count+1 );
            Caption := 'Dialog Locale';

            Item2 := TMenuItem.Create( Item );
            Item2.Name := Menu.Name + '_Locale_German';
            Item2.Caption := 'Deutsch';
            Item2.OnClick := StringGridPopUpClick_DialogLocale;
            Item.Add( Item2 );

            Item2 := TMenuItem.Create( Item );
            Item2.Name := Menu.Name + '_Locale_English';
            Item2.Caption := 'English';
            Item2.OnClick := StringGridPopUpClick_DialogLocale;
            Item.Add( Item2 );

            {$IFDEF HOOK_WINDOWSDIALOGS}
            Item2 := TMenuItem.Create( Item );
            Item2.Name := Menu.Name + '_Locale_Windows';
            Item2.Caption := 'Windows';
            Item2.OnClick := StringGridPopUpClick_DialogLocale;
            Item.Add( Item2 );

            Item2 := TMenuItem.Create( Item );
            Item2.Name := Menu.Name + '_Locale_ShowCurrent';
            Item2.Caption := 'Show Current';
            Item2.OnClick := StringGridPopUpClick_DialogLocale;
            Item.Add( Item2 );
            {$ENDIF}
            end;
      end; // case
      end; // with
    Menu.Items.Add( Item );
    end;
  CheckStringGridSourceCodeStrings.PopUpMenu := Menu;

  // RuntimeComps not in Compfile
  CheckStringGridRuntimeCompsNotInFileList := TCheckStringGrid.Create( self );
  CheckStringGridRuntimeCompsNotInFileList.Name := 'CheckStringGridRuntimeCompsNotInFileList';
  CheckStringGridRuntimeCompsNotInFileList.Parent := PanelstringGridRuntimeCompsNotInFileList;
  CheckStringGridRuntimeCompsNotInFileList.DeleteMenu := false;
  CheckStringGridRuntimeCompsNotInFileList.OnDblClick := StringGridObjectsDblClick;
  Menu := CheckStringGridRuntimeCompsNotInFileList.PopUpMenu; // Extend Menu
  for i := 0 to 3 do
    begin
    Item := TMenuItem.Create( Menu );
    with Item do
      begin
      case i of
           0:
            begin
            Item.Name := Menu.Name + '_PopUpMenuItem_' + IntToStr( Menu.Items.Count+1 );
            Caption := 'Add to Exclusions';
            OnClick := CheckStringGridPopUpClick_AddToExclusion;
            end;
           1:
            begin
            Item.Name := CheckStringGridRuntimeCompsNotInFileList.name + '_PopUpMenuItem_' + IntToStr( Menu.Items.Count+1 );
            Caption := 'Refresh';
            OnClick := btnFindRtCompsNotInCompFileListClick;
            end;
           2:
            begin
            Item.Name := CheckStringGridRuntimeCompsNotInFileList.name + '_PopUpMenuItem_' + IntToStr( Menu.Items.Count+1 );
            Caption := 'Flash Component';
            OnClick := CheckStringGridcompsNotInFileList_FlashComponent;
            end;
           3:
            begin
            Item.Name := CheckStringGridRuntimeCompsNotInFileList.name + '_PopUpMenuItem_' + IntToStr( Menu.Items.Count+1 );
            Caption := 'Add to CompFile';
            OnClick := CheckStringGridPopUpClick_AddToCompFile;
            end;
        end; // case
      end; // with
    Menu.Items.Add( Item );
    end;

  // Compfile entrys not in RuntimeComps
  CheckStringGridFileListCompsNotInRuntimeList := TCheckStringGrid.Create( self );
  CheckStringGridFileListCompsNotInRuntimeList.Name := 'CheckStringGridFileListCompsNotInRuntimeList';
  CheckStringGridFileListCompsNotInRuntimeList.Parent := PanelstringGridFileListCompsNotInRuntimeList;
  CheckStringGridFileListCompsNotInRuntimeList.DeleteMenu := false;
  Menu := CheckStringGridFileListCompsNotInRuntimeList.PopUpMenu; // Extend Menu
  for i := 0 to 1 do
    begin
    Item := TMenuItem.Create( Menu );
    with Item do
      begin
      case i of
           0:
            begin
            Item.Name := CheckStringGridFileListCompsNotInRuntimeList.name + '_PopUpMenuItem_' + IntToStr( Menu.Items.Count+1 );
            Caption := 'Refresh';
            OnClick := btnFindCompsNotInAppClick;
            end;
           1:
            begin
            Item.Name := CheckStringGridFileListCompsNotInRuntimeList.name + '_PopUpMenuItem_' + IntToStr( Menu.Items.Count+1 );
            Caption := 'Delete from CompFile';
            OnClick := CheckStringGridPopUpClick_DelFromCompFileNotInList;
            end;
        end; // case
      end; // with
    Menu.Items.Add( Item );
    end;

  Languager.Init( chkLbxForms,
                                StringGridCompsInRuntimeList,
                                CheckStringGridCompsInFileList,
                                CheckStringGridRuntimeCompsNotInFileList,
                                CheckStringGridFileListCompsNotInRuntimeList,
                                CheckStringGridSourceCodeStrings );

  //Override Caption
  CheckStringGridSourceCodeStrings.Cells[ 1, 0 ] := INTERNAL_GRID_HEADER_SOURCE_;

  //Init TranslateGrid
  StringGridTranslationComponents.OnDblClick := StringGridObjectsDblClick;
  StringGridTranslationComponents.RowCount := 1;
  StringGridTranslationComponents.FixedCols := 0;
  StringGridTranslationInput.RowCount := 1;
  StringGridTranslationInput.FixedCols := 0;
  StringGridTranslationOutput.RowCount := 1;
  StringGridTranslationOutput.FixedCols := 0;

  StringGridTranslationComponents.Options := [ goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goRangeSelect,goColSizing,goTabs,goAlwaysShowEditor ];
  StringGridTranslationComponents.DefaultColWidth := ( StringGridTranslationComponents.Width-6 );
  StringGridTranslationInput.Options := [ goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goRangeSelect,goColSizing,goTabs,goAlwaysShowEditor ];
  StringGridTranslationInput.DefaultColWidth := ( StringGridTranslationInput.Width-6 );
  StringGridTranslationOutput.Options := [ goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goRangeSelect,goColSizing,goEditing,goTabs,goAlwaysShowEditor ];
  StringGridTranslationOutput.DefaultColWidth := ( StringGridTranslationOutput.Width-6 );

  StringGridTranslationComponents.cells[ 0, 0 ] := 'Component'; // Captions
  StringGridTranslationInput.cells[ 0, 0 ] := 'Text';
  StringGridTranslationOutput.cells[ 0, 0 ] := 'Translation';

  Menu := TPopUpMenu.Create( self );
  Menu.Name := 'StringGridTranslation_PopUpMenu';
  for i := 0 to 6 do
    begin
    Item := TMenuItem.Create( Menu );
    with Item do
      begin
      case i of
           0:
            begin
            Item.Name := 'StringGridTranslation_PopUpMenuItem_' + IntToStr( Menu.Items.Count+1 );
            Caption := 'Load Input LanguageFile';
            OnClick := ButtonLoadInputLanguageClick;
            end;
           1:
            begin
            Item.Name := 'StringGridTranslation_PopUpMenuItem_' + IntToStr( Menu.Items.Count+1 );
            Caption := 'Load Output LanguageFile';
            OnClick := ButtonLoadOutputLanguageClick;
            end;
           2:
            begin
            Item.Name := 'StringGridTranslation_PopUpMenuItem_' + IntToStr( Menu.Items.Count+1 );
            Caption := 'Clear Output';
            OnClick := ButtonClearTranslatedLanguageClick;
            end;
           3:
            begin
            Item.Name := 'StringGridTranslation_PopUpMenuItem_' + IntToStr( Menu.Items.Count+1 );
            Caption := 'Jump to next empty entry';
            OnClick := FindEmptyLineClick;
            end;
           4:
            begin
            Item.Name := 'StringGridTranslation_PopUpMenuItem_' + IntToStr( Menu.Items.Count+1 );
            Caption := 'Save Output LanguageFile';
            OnClick := ButtonSaveTranslatedLanguageClick;
            end;
           5:
            begin
            Item.Name := 'StringGridTranslation_PopUpMenuItem_' + IntToStr( Menu.Items.Count+1 );
            Caption := 'Flash Component';
            OnClick := StringGridPopUpClick_FlashComponentTranslation;
            end;
           6:
            begin
            Item.Name := 'StringGridTranslation_PopUpMenuItem_' + IntToStr( Menu.Items.Count+1 );
            Caption := 'Flash Component (Preview)';
            OnClick := StringGridPopUpClick_FlashComponentWithNewText;
            end;
      end; // case
      end; // with
    Menu.Items.Add( Item );
    end;
  StringGridTranslationComponents.PopUpMenu := Menu;
  StringGridTranslationInput.PopUpMenu := Menu;
  StringGridTranslationOutput.PopUpMenu := Menu;


  Hint := 'Hold SHIFT to select ranges' + #10#13 +
          'Hold CTRL to select/unselect single lines' + #10#13 +
          'Hold CTRL+SHIFT to invert range selection' + #10#13 +
          'DoubleClick a component to highlight/flash it';

  PnlKomponentenfileHeader.ShowHint := true;
  PnlKomponentenfileHeader.Hint := Hint;

  PnlSourceStringsHeader.ShowHint := true;
  PnlSourceStringsHeader.Hint := Hint;

  PnlKompsNotInCompFileHeader.ShowHint := true;
  PnlKompsNotInCompFileHeader.Hint := Hint;

  PnlInCompFileButNotInAppHeader.ShowHint := true;
  PnlInCompFileButNotInAppHeader.Hint := Hint;

  for i := 0 to chklstPropertys.Items.Count-1 do
    chklstPropertys.Checked[ i ] := ( i <> 2 ); // Text ( Edit )

  fSourceFiles := TStringList.Create;
  fSourceFilesInc := 0;

  fSourceFiles.Clear;
end;

procedure TFrmLanguage.FormDestroy( Sender: TObject );
begin
  if NOT Assigned( self ) then
    Exit;

  if Assigned( languageReplacer ) then
    languageReplacer.free;
  languageReplacer := nil;

  fSourceFiles.free;  
end;

procedure TFrmLanguage.FormShow( Sender: TObject );
var
  i : integer;
begin
  if ( FindWindow( 'TAppBuilder',nil ) > 0 ) AND NOT ( Application.MainForm = self ) then
    begin
    if Screen.MonitorCount > 1 then
      begin
      for i := 0 to screen.MonitorCount-1 do
          begin
          if NOT screen.Monitors[ i ].primary then
             Left := screen.Monitors[ i ].Left;
          end;
      end;
    end;

  // CodePage
  if ( LANGUAGE_CODEPAGE_ = 0 ) then
    LANGUAGE_CODEPAGE_ := GetACP;
  if ( LANGUAGE_LCID_ = 0 ) then
    LANGUAGE_LCID_ := SysLocale.DefaultLCID;
  SetComboBoxLCID( LANGUAGE_LCID_ );

  if ( Languager.GetCharSet <> -1 ) then
    begin
    LANGUAGE_CHARSET_ := Languager.GetCharSet;
    SetComboBoxCharSet( LANGUAGE_CHARSET_ );
    end
  else
    SetComboBoxCharSet( DEFAULT_CHARSET );

  languageReplacer.ChangeRunningCounter( languageReplacer.RunningCounter );
  CompFlash_Count := 16;

  TranslatorTmp.Changed := false;

  justStarted_ := true;
end;

procedure TFrmLanguage.PageControlChange( Sender: TObject );
var
  res : integer;
begin
  if ( lActivePage = 'TabSheetExclusion' ) then
    if ( ExcludesChanged ) then
      begin
      res := MessageBox( Application.Handle, 'Excludes have been changed! Save?', 'Warning', mb_YesNoCancel );
      case res of
        idNo     : ;
        idYes    : SaveExcludes;
        idCancel : exit;
      end;
      end;
  lActivePage := TPageControl( sender ).ActivePage.Name;
end;

procedure TFrmLanguage.btnFindPreviousClick( Sender: TObject );
begin
  if NOT languageReplacer.FindNextMark( True ) then
    ShowMessage( 'File start reached' );
end;

procedure TFrmLanguage.btnFindNextClick( Sender: TObject );
begin
  if NOT languageReplacer.FindNextMark then
    ShowMessage( 'End of File reached' );
end;

procedure TFrmLanguage.btnSkipAndFindNextClick( Sender: TObject );
begin
  languageReplacer.position := MemoSourcefile.SelStart-1;
  if NOT languageReplacer.FindNextMark then
    ShowMessage( 'End of File reached' );
end;

procedure TFrmLanguage.btnReplaceAndFindNextClick( Sender: TObject );
begin
  languageReplacer.ReplaceText;
  if NOT languageReplacer.FindNextMark then
    begin
    ShowMessage( 'End of File reached' );
    exit;
    end;
  lbledtFortlaufendeNr.text := IntToStr( languageReplacer.RunningCounter );
end;

procedure TFrmLanguage.MemoSourcefileClick( Sender: TObject );
begin
  MemoSourcefile.SetFocus;
  languageReplacer.position := MemoSourcefile.SelStart;
  languageReplacer.laenge   := 0;
end;

procedure TFrmLanguage.cbxLeerStringsUeberspringenClick( Sender: TObject );
begin
  languageReplacer.leerStringsUeberspringen := cbxLeerStringsUeberspringen.checked;
end;

procedure TFrmLanguage.edtFortlaufendeNrKeyPress( Sender: TObject; var Key: Char );
begin
  {if NOT ( key in [ '0' .. '9' ] ) then
     Exit;
  languageReplacer.RunningCounter := StrToIntDef( edtFortlaufendeNr.Text + Key, 1000 );}
  ZiffernEingabe( TEdit( Sender ).Text, Key, false );// true:= Komma erlaubt
end;

procedure TFrmLanguage.edtFortlaufendeNrExit( Sender: TObject );
begin
  languageReplacer.RunningCounter := StrToIntDef( lbledtFortlaufendeNr.Text, 1000 );
  lbledtFortlaufendeNr.Text   := IntToStr( languageReplacer.RunningCounter );
end;

procedure TFrmLanguage.ZiffernEingabe( text : string; var Key: Char; mitKomma : Boolean );
{ Bei der Eingabe nur Ziffern, Backspace zulassen.
  Komma ist nur erlaubt wenn der Parameter "mitKomma" = TRUE ist,
  Punkt wird in Komma umgewandelt, da die Konvertierungsfkt.
  als Dezimaltrennzeichen ein Komma erwartet.
  ( Cursortasten und Delete werden nicht an diese Fkt. übergeben. )
}
var
  DS : Char;
begin
  DS := {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}DecimalSeparator;
  if ( ( Key =  '.' ) or ( Key =  ',' ) ) AND ( DS <> Key ) then//  keine Punkte ( in Komma umwandeln )
    Key := DS;

  if not mitKomma and ( Key = DS ) then
    Key := #0;

  if ( ( Key = DS ) and ( Pos( DS, text ) <> 0 ) ) or// keine doppelten Kommata
     ( ( ( Key < #48 ) or ( Key > #57 ) ) and  //  Key nicht im  ASCII-Zahlenbereich
       ( Key <>  #8 ) and //  kein Backspace
       ( Key <> DS ) and//  kein Komma
       ( Key <> '-' ) and // kein Minus
       ( Key <> '\' ) ) then
    Key := #0; // Tastendruck rückgängig machen
end;

procedure TFrmLanguage.cbxKommentiertesUeberspringenClick( Sender: TObject );
begin
  languageReplacer.kommentiertesUeberspringen := cbxKommentiertesUeberspringen.checked;
end;

procedure TFrmLanguage.StringGridObjectsMouseWheelUp( Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean );
begin
  if NOT ( sender is TStringGrid ) then
    Exit;
  if TStringGrid( Sender ).TopRow > 1 then
    begin
    TStringGrid( Sender ).TopRow := TStringGrid( Sender ).TopRow-1;
    Handled := true;
    end;
end;

procedure TFrmLanguage.StringGridObjectsMouseWheelDown( Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean );
begin
  if NOT ( sender is TStringGrid ) then
    Exit;
  if TStringGrid( Sender ).TopRow+TStringGrid( Sender ).VisibleRowCount <= TStringGrid( Sender ).RowCount-1 then
    begin
    TStringGrid( Sender ).TopRow := TStringGrid( Sender ).TopRow+1;
    Handled := true;
    end;
end;

procedure TFrmLanguage.StringGridObjectsSelectCell( Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean );
begin
  if ( ACol <> 0 ) then
    CanSelect := false;
end;

procedure TFrmLanguage.StringGridObjectsDblClick_Translate( Sender: TObject );
begin
  StringGridObjectsDblClick( StringGridTranslationComponents );
end;

procedure TFrmLanguage.StringGridObjectsDblClick( Sender: TObject );
begin
  if CompFlash_inUse then
    if NOT ( Languager.TriggerComponentVisible( Languager.FlashComponent, true ) ) then
       Exit;

  if ( sender is TCheckStringGrid ) then
    begin
    Languager.FlashComponent := TCheckStringGrid( sender ).Cells[ 1, TCheckStringGrid( sender ).Row ];
    Languager.FlashComponentText := '';
    Languager.FlashComponentForm := nil;
    end
  else
    begin
    Languager.FlashComponent := TCheckStringGrid( sender ).Cells[ 0, TCheckStringGrid( sender ).Row ];
    Languager.FlashComponentText := '';
    Languager.FlashComponentForm := nil;
    end;

  CompFlash_Count := 0;
  CompFlash_Cancel := false;
  CompFlash_inUse := true;
end;

procedure TFrmLanguage.StringGridObjectsDblClickPreview( Sender: TObject );
begin
  if CompFlash_inUse then
    if NOT ( Languager.TriggerComponentVisible( Languager.FlashComponent, true ) ) then
       Exit;

  Languager.FlashComponent := TStringGrid( sender ).Cells[ 0, TStringGrid( sender ).Row ];
  Languager.FlashComponentText := '';
  Languager.FlashComponentForm := nil;
  Languager.FlashComponentVisibles := '';

  Languager.TriggerComponentText( Languager.FlashComponent, StringGridTranslationOutput.Cells[ 0, TStringGrid( sender ).Row ] );

  CompFlash_Count := 0;
  CompFlash_Cancel := false;
  CompFlash_inUse := true;
end;

procedure TFrmLanguage.btnKomponentenInDateiClick( Sender: TObject );
var
  Save : TSaveDialog;
begin
  Save := TSaveDialog.Create( Self );

  Save.InitialDir := LANGUAGE_DIRECTORY_;
  Save.Filter := 'imessVision Languagefiles|*.' + SPRACH_EXT_;
  if Languager.lastSaveFile <> '' then
    Save.FileName := Languager.lastSaveFile
  else
    Save.FileName := 'Default.' + SPRACH_EXT_;

  if Save.Execute then
     begin
     if NOT ( IsWm( Save.FileName, '*.' + SPRACH_EXT_ ) ) then
        Save.FileName := Save.FileName + '.' + SPRACH_EXT_;
     Languager.SaveLanguageFile( Save.FileName );
     end;
  Save.free;
end;

procedure TFrmLanguage.btnCollectAndInsertCodeStrings( Sender : TObject );
begin
  btnScanSourcesClick( Sender );
  btnCopyStringsClick( Sender );
end;

procedure TFrmLanguage.btnKomponentenAusDateiClick( Sender: TObject );
var
  res  : integer;
  Open : TOpenDialog;
begin
  Open := TOpenDialog.Create( self );
  if Languager.changed then
    begin
    res := MessageBox( Application.Handle, 'Component-File has been changed! Save?', 'Warning', mb_YesNoCancel );
    case res of
      idNo     : ;
      idYes    : btnSaveCompFileListClick( self );
      idCancel : exit;
    end;
    end;

  if NOT DirectoryExists( LANGUAGE_DIRECTORY_ ) then
    ForceDirectories( LANGUAGE_DIRECTORY_ );

  Open.InitialDir := LANGUAGE_DIRECTORY_;
  Open.Filter := 'imessVision Languagefiles|*.' + SPRACH_EXT_;
  if Open.Execute then
    Languager.LoadLanguageFile( Open.FileName );
  Open.free;
end;

procedure TFrmLanguage.btnImportDRCClick( Sender: TObject );
var
  res  : integer;
  Open : TOpenDialog;
begin
  Open := TOpenDialog.Create( self );
  if Languager.changed then
    begin
    res := MessageBox( Application.Handle, 'Component-File was changed! Save?', 'Warning', mb_YesNoCancel );
    case res of
      idNo     : ;
      idYes    : btnSaveCompFileListClick( self );
      idCancel : exit;
    end;
    end;

  if NOT DirectoryExists( LANGUAGE_DIRECTORY_ ) then
    ForceDirectories( LANGUAGE_DIRECTORY_ );

  Open.InitialDir := LANGUAGE_DIRECTORY_;
  Open.Filter := 'Ressource Languagefiles|*.' + 'DRC';
  if Open.Execute then
    if Open.FileName <> '' then
        Languager.LoadLanguageFile( Languager.ConvertDRC( Open.FileName ) );
  Open.free;
end;

procedure TFrmLanguage.btnRtCompsListToCompFileListClick( Sender: TObject );
var
  Save : TSaveDialog;
begin
  Save := TSaveDialog.Create( Self );
  if ( CheckStringGridcompsInFileList.RowCount > 1 ) then
     begin
     Save.InitialDir := LANGUAGE_DIRECTORY_;
     Save.Filter := 'imessVision Languagefiles|*.' + SPRACH_EXT_;

     if Languager.lastSaveFile <> '' then
        Save.FileName := Languager.lastSaveFile
     else
        Save.FileName := 'Default.' + SPRACH_EXT_;

     if Save.Execute then
        begin
        if NOT ( IsWm( Save.FileName, '*.' + SPRACH_EXT_ ) ) then
           Save.FileName := Save.FileName + '.' + SPRACH_EXT_;

        if ( CheckStringGridcompsInFileList.RowCount > 1 ) then
           Languager.SaveLanguageFile( Save.FileName );
        end;
     end;
  Save.free;
end;

procedure TFrmLanguage.btnSaveCompFileListClick( Sender: TObject );
var
  res  : Integer;
  Save : TSaveDialog;
begin
  Save := TSaveDialog.Create( self );
  if ( MemoGlobalPas.Text <> '' ) {AND languageReplacer.TextBoxChanged} then
    begin
    res := MessageBox( Application.Handle, 'New SourceCode-Strings not copied into CompFile! Copy now?', 'Warning', mb_YesNoCancel );
    case res of
      idNo     : ;
      idYes    : btnCopyStringsClick( self );
      idCancel : exit;
    end;
    end;

  if ( CheckStringGridcompsInFileList.RowCount > 1 ) then
     begin
     Save.InitialDir := LANGUAGE_DIRECTORY_;
     Save.Filter := 'imessVision Languagefiles|*.' + SPRACH_EXT_;

     if Languager.lastSaveFile <> '' then
        Save.FileName := Languager.lastSaveFile
     else
        Save.FileName := 'Default.' + SPRACH_EXT_;

     if Save.Execute then
        begin
        if NOT ( IsWm( Save.FileName, '*.' + SPRACH_EXT_ ) ) then
           Save.FileName := Save.FileName + '.' + SPRACH_EXT_;

        Languager.SaveLanguageFile( Save.FileName );
        end;
     end;
  Save.Free;
end;

procedure TFrmLanguage.cbxNoDoublicateClick( Sender: TObject );
begin
  if ( sender = RadioBtnDublicatesYes ) then
    languageReplacer.DublicateMode := 0
  else if ( sender = RadioBtnDublicatesNo ) then
    languageReplacer.DublicateMode := 1
  else if ( sender = RadioBtnDublicatesAsk ) then
    languageReplacer.DublicateMode := 2;
end;

procedure TFrmLanguage.btnMenuRefreshRuntimeCompsClick( Sender: TObject );
begin
  Languager.ShowObjectsInStringlist;
end;

procedure TFrmLanguage.btnFindCompsNotInAppClick( Sender: TObject );
begin
  {if ( Sender = btnFindCompsNotInApp ) then
    begin
    if ( StringGridCompsInRuntimeList.RowCount < 2 ) then
        begin
        ShowMessage( 'The Runtime-components arent cached yet, please cache them first' );
        Exit;
        end
    else if ( StringGridcompsInFileList.RowCount < 2 ) then
        begin
        ShowMessage( 'The Compfile isnt loaded/generated yet, please load or generate one first' );
        Exit;
        end;
  end; }
  Languager.FindRtFileListCompsNotInRuntimeList;
end;

procedure TFrmLanguage.btnFindRtCompsNotInCompFileListClick( Sender: TObject );
begin
  {if ( Sender = btnFindRtCompsNotInCompFileList ) then
    begin
    if ( StringGridCompsInRuntimeList.RowCount < 2 ) then
        begin
        ShowMessage( 'The Runtime-components arent cached yet, please cache them first' );
        Exit;
        end
  end;}
  Languager.FindRtCompsNotInCompFileList;
end;

procedure TFrmLanguage.CheckStringGridPopUpClick_AddToCompFile( Sender : TObject );
var
 i,j : integer;
begin
  PnlGround.Enabled                   := false;
  PanelLangProgressing.Visible        := True;
  ProgressBarLang.Min                 := 0;
  ProgressBarLang.Max                 := CheckStringGridRuntimeCompsNotInFileList.RowCount-1;

  CheckStringGridcompsInFileList.Font.Charset := LANGUAGE_CHARSET_;
  for i := 1 to CheckStringGridRuntimeCompsNotInFileList.RowCount-1 do
    begin
    ProgressBarLang.Position := i;
    Application.ProcessMessages;

    if ( CheckStringGridRuntimeCompsNotInFileList.Component[ 0, i ] = csChecked ) then
       begin
       Languager.changed := true;

       if ( Length( LANGUAGE_MANAGE_ARRAY_.Compfile ) = 0 ) then
         SetLength( LANGUAGE_MANAGE_ARRAY_.Compfile,Length( LANGUAGE_MANAGE_ARRAY_.Compfile )+1 )
       else if ( LANGUAGE_MANAGE_ARRAY_.Compfile[ Length( LANGUAGE_MANAGE_ARRAY_.Compfile )-1 ].ID <> '' ) then
         SetLength( LANGUAGE_MANAGE_ARRAY_.Compfile,Length( LANGUAGE_MANAGE_ARRAY_.Compfile )+1 );

       {$IFNDEF UNICODE}
       LANGUAGE_MANAGE_ARRAY_.Compfile[ Length( LANGUAGE_MANAGE_ARRAY_.Compfile )-1 ].ID := StringToWideString( CheckStringGridRuntimeCompsNotInFileList.cells[ 1, i ], LANGUAGE_CODEPAGE_ );
       LANGUAGE_MANAGE_ARRAY_.Compfile[ Length( LANGUAGE_MANAGE_ARRAY_.Compfile )-1 ].Value := StringToWideString( CheckStringGridRuntimeCompsNotInFileList.cells[ 2, i ], LANGUAGE_CODEPAGE_ );
       {$ELSE}
       LANGUAGE_MANAGE_ARRAY_.Compfile[ Length( LANGUAGE_MANAGE_ARRAY_.Compfile )-1 ].ID := CheckStringGridRuntimeCompsNotInFileList.cells[ 1, i ];
       LANGUAGE_MANAGE_ARRAY_.Compfile[ Length( LANGUAGE_MANAGE_ARRAY_.Compfile )-1 ].Value := CheckStringGridRuntimeCompsNotInFileList.cells[ 2, i ];
       {$ENDIF}

       j := Length( LANGUAGE_MANAGE_ARRAY_.Changes );
       SetLength( LANGUAGE_MANAGE_ARRAY_.Changes,j+1 );
       LANGUAGE_MANAGE_ARRAY_.Changes[ j ].ID    := CheckStringGridRuntimeCompsNotInFileList.cells[ 1, i ];
       LANGUAGE_MANAGE_ARRAY_.Changes[ j ].Value := CheckStringGridRuntimeCompsNotInFileList.cells[ 2, i ];
       end;
    end;

  if ( Length( LANGUAGE_MANAGE_ARRAY_.Compfile ) > 0 ) then
    begin
    if ( CheckStringGridcompsInFileList.RowCount > 1 ) then
      CheckStringGridcompsInFileList.Clear( True, False );    
    CheckStringGridcompsInFileList.RowCount := Length( LANGUAGE_MANAGE_ARRAY_.Compfile )+1;
    for i := 0 to Length( LANGUAGE_MANAGE_ARRAY_.Compfile )-1 do
      begin
      {$IFNDEF UNICODE}
      CheckStringGridcompsInFileList.Cells[ 1, i+1 ] := WideStringToString( LANGUAGE_MANAGE_ARRAY_.Compfile[ i ].ID, LANGUAGE_CODEPAGE_ );
      CheckStringGridcompsInFileList.Cells[ 2, i+1 ] := WideStringToString( LANGUAGE_MANAGE_ARRAY_.Compfile[ i ].Value, LANGUAGE_CODEPAGE_ );
      {$ELSE}
      CheckStringGridcompsInFileList.Cells[ 1, i+1 ] := LANGUAGE_MANAGE_ARRAY_.Compfile[ i ].ID;
      CheckStringGridcompsInFileList.Cells[ 2, i+1 ] := LANGUAGE_MANAGE_ARRAY_.Compfile[ i ].Value;
      {$ENDIF}
      end;
    end
  else
    CheckStringGridcompsInFileList.RowCount := 1;

  CorrectColumns( CheckStringGridcompsInFileList );

  PnlKomponentenfileHeader.Caption := CSGridcompsInFileList_Header + ' [' + IntToStr( CheckStringGridcompsInFileList.RowCount-1 ) + ']';

  PnlGround.Enabled                   := true;
  PanelLangProgressing.Visible        := false;

  Languager.FindRtCompsNotInCompFileList;
end;

procedure TFrmLanguage.CheckStringGridPopUpClick_AddToExclusion( Sender : TObject );
var
 i : integer;
 ChkStrGrid : TCheckStringGrid;
begin
  if NOT ( Sender is TMenuItem ) then
    Exit;

  if NOT ( TMenuItem(Sender).owner.owner is TCheckStringGrid ) then
    Exit;
  ChkStrGrid := TCheckStringGrid( TMenuItem(Sender).owner.owner );

  PnlGround.Enabled                   := false;
  PanelLangProgressing.Visible        := True;
  ProgressBarLang.Min                 := 0;
  ProgressBarLang.Max                 := CheckStringGridRuntimeCompsNotInFileList.RowCount-1;

  for i := 1 to ChkStrGrid.RowCount-1 do
    begin
    ProgressBarLang.Position := i;
    Application.ProcessMessages;

    if ( ChkStrGrid.Component[ 0, i ] = csChecked ) then
       AddToExclusion( ChkStrGrid.Cells[ 1, i ] );
    end;

  PnlGround.Enabled                   := true;
  PanelLangProgressing.Visible        := false;
  SaveExcludes;
end;

procedure TFrmLanguage.StringGridPopUpClick_FlashComponent( Sender : TObject );
begin
   if ( FindComponent( StringReplace( TMenu( FindComponent( TMenuItem( sender ).owner.name ) ).name,'_PopUpMenu','',[ rfReplaceAll ] ) ) is TStringGrid ) then
    StringGridObjectsDblClick( TStringGrid( FindComponent( StringReplace( TMenu( FindComponent( TMenuItem( sender ).owner.name ) ).name,'_PopUpMenu','',[ rfReplaceAll ] ) ) ) );
end;

procedure TFrmLanguage.StringGridPopUpClick_FlashComponentTranslation( Sender : TObject );
begin
  StringGridObjectsDblClick( StringGridTranslationComponents );
end;

procedure TFrmLanguage.StringGridPopUpClick_FlashComponentWithNewText( Sender : TObject );
begin
  StringGridObjectsDblClickPreview( StringGridTranslationComponents );
end;

procedure TFrmLanguage.StringGridPopUpClick_DialogLocale( Sender : TObject );
begin
  if NOT ( Sender is TMenuItem ) then
    Exit;

  if ( RightStr( LowerCase( TMenuItem( Sender ).Name ), 13 ) = LowerCase( 'Locale_German' ) ) then
    LangMessageDlgInitCaptions( 1 )
  else if ( RightStr( LowerCase( TMenuItem( Sender ).Name ), 14 ) = LowerCase( 'Locale_English' ) ) then
    LangMessageDlgInitCaptions( 2 )
  {$IFDEF HOOK_WINDOWSDIALOGS}
  else if ( RightStr( LowerCase( TMenuItem( Sender ).Name ), 14 ) = LowerCase( 'Locale_Windows' ) ) then
    Languager.ReadWindowsDlgStrings
  else if ( RightStr( LowerCase( TMenuItem( Sender ).Name ), 18 ) = LowerCase( 'Locale_ShowCurrent' ) ) then
    begin
    Languager.ReadWindowsDlgStrings( True );
    Exit;
    end
  {$ENDIF}
  else
    Exit;

  Languager.UpdateWDLG_Captions;
end;

procedure TFrmLanguage.CheckStringGridcompsNotInFileList_FlashComponent( Sender : TObject );
begin
  StringGridObjectsDblClick( CheckStringGridRuntimeCompsNotInFileList );
end;

procedure TFrmLanguage.CheckStringGridcompsInFileList_FlashComponent( Sender : TObject );
begin
  StringGridObjectsDblClick( CheckStringGridcompsInFileList );
end;

procedure TFrmLanguage.CheckStringGridcompsInFileList_HighlightDifferencesToVCL( Sender : TObject );
var
  form  : TWinControl;
  comp  : TComponent;
  prop  : String;
  ID    : Integer;
  i     : integer;
  s     : string;
  vText : String;
  Count : Cardinal;
begin
  Count := 0;
  for i := 1 to CheckStringGridcompsInFileList.RowCount-1 do
    begin
    form := nil;
    if NOT Languager.FindFormByName( GetTok( CheckStringGridcompsInFileList.Cells[ 1, i ], 1, '.' ), form ) then
      Continue;

    if NOT Languager.FindComponentByName( form, GetTok( CheckStringGridcompsInFileList.Cells[ 1, i ], 2, '.' ), comp ) then
      Continue;

    prop := GetTok( CheckStringGridcompsInFileList.Cells[ 1, i ], 3, '.' );
    ID := StrToIntDef( GetTok( CheckStringGridcompsInFileList.Cells[ 1, i ], 4, '.' ), 0 );

    Languager.GetProperty( form, comp, prop, ID, vText );

    s := CheckStringGridcompsInFileList.Cells[ 2, i ];
    s := StringReplace( s, INTERNAL_REPLACE_CR, #13, [ rfReplaceAll ] ); // CR
    s := StringReplace( s, INTERNAL_REPLACE_LF, #10, [ rfReplaceAll ] ); // LF

    if NOT ( CompareStr( vText, s ) = 0 ) then
      begin
      CheckStringGridcompsInFileList.CellColor[ i, 1 ] := clFuchsia;
      CheckStringGridcompsInFileList.CellColor[ i, 2 ] := clFuchsia;
      Inc( count );
      end;
    end;
  ShowMessage( Format( '%d differences to VCL-Texts were found.', [ Count ] ) );    
end;

procedure TFrmLanguage.CheckStringGridPopUpClick_DelFromSourceCodeStrings( Sender : TObject );
var
 i,j,k : integer;
begin
   PnlGround.Enabled                   := false;
   PanelLangProgressing.Visible        := True;
   ProgressBarLang.Min                 := 0;
   ProgressBarLang.Max                 := CheckStringGridSourceCodeStrings.RowCount-1;

   for i := CheckStringGridSourceCodeStrings.RowCount-1 DownTo 1 do
    begin
    ProgressBarLang.Position := i;
    Application.ProcessMessages;

    if ( CheckStringGridSourceCodeStrings.Component[ 0, i ] = csChecked ) then
       begin
       Languager.changed := true;

       for j := Length( LANGUAGE_MANAGE_ARRAY_.SourceCode )-1 DownTo 0 do
         begin
         //GetTok( TLANGUAGE_CODE_STRINGS_[ j ].ID, NumTok( TLANGUAGE_CODE_STRINGS_[ j ].ID, '.' )-1, NumTok( TLANGUAGE_CODE_STRINGS_[ j ].ID, '.' ), '.' )
         if ( LowerCase( LANGUAGE_MANAGE_ARRAY_.SourceCode[ j ].ID ) = LowerCase( INTERNAL_PREFIX_+'.'+INTERNAL_STRING_PREFIX_+'.'+CheckStringGridSourceCodeStrings.Cells[ 1,i ] ) ) then
           begin
           for k := j to Length( LANGUAGE_MANAGE_ARRAY_.SourceCode )-1 do
             begin
             if ( k < Length( LANGUAGE_MANAGE_ARRAY_.SourceCode )-1 ) then
               begin
               LANGUAGE_MANAGE_ARRAY_.SourceCode[ k ].ID := LANGUAGE_MANAGE_ARRAY_.SourceCode[ k+1 ].ID;
               LANGUAGE_MANAGE_ARRAY_.SourceCode[ k ].Value := LANGUAGE_MANAGE_ARRAY_.SourceCode[ k+1 ].Value;
               end;
             end; // for k
           if ( Length( LANGUAGE_MANAGE_ARRAY_.SourceCode )-1 >= 0 ) then
             SetLength( LANGUAGE_MANAGE_ARRAY_.SourceCode,Length( LANGUAGE_MANAGE_ARRAY_.SourceCode )-1 );
           end; // if
         end; // for Length-1 downTo 0

       for j := Length( LANGUAGE_MANAGE_ARRAY_.FileInput )-1 DownTo 0 do // Remove String from Compfile
         begin
         //GetTok( TLANGUAGE_CODE_STRINGS_[ j ].ID, NumTok( TLANGUAGE_CODE_STRINGS_[ j ].ID, '.' )-1, NumTok( TLANGUAGE_CODE_STRINGS_[ j ].ID, '.' ), '.' )
         if ( LowerCase( LANGUAGE_MANAGE_ARRAY_.FileInput[ j ].ID ) = LowerCase( INTERNAL_PREFIX_+'.'+INTERNAL_STRING_PREFIX_+'.'+CheckStringGridSourceCodeStrings.Cells[ 1,i ] ) ) then
           begin
           for k := j to Length( LANGUAGE_MANAGE_ARRAY_.FileInput )-1 do
             begin
             if ( k < Length( LANGUAGE_MANAGE_ARRAY_.FileInput )-1 ) then
               begin
               LANGUAGE_MANAGE_ARRAY_.FileInput[ k ].ID := LANGUAGE_MANAGE_ARRAY_.FileInput[ k+1 ].ID;
               LANGUAGE_MANAGE_ARRAY_.FileInput[ k ].Value := LANGUAGE_MANAGE_ARRAY_.FileInput[ k+1 ].Value;
               end;
             end; // for k
           if ( Length( LANGUAGE_MANAGE_ARRAY_.FileInput )-1 >= 0 ) then
             SetLength( LANGUAGE_MANAGE_ARRAY_.FileInput,Length( LANGUAGE_MANAGE_ARRAY_.FileInput )-1 );
           end; // if
         end; // for Length-1 downTo 0

       for j := Length( LANGUAGE_MANAGE_ARRAY_.Changes )-1 DownTo 0 do // Remove String from Changes
         begin
         //GetTok( TLANGUAGE_CODE_STRINGS_[ j ].ID, NumTok( TLANGUAGE_CODE_STRINGS_[ j ].ID, '.' )-1, NumTok( TLANGUAGE_CODE_STRINGS_[ j ].ID, '.' ), '.' )
         if ( LowerCase( LANGUAGE_MANAGE_ARRAY_.Changes[ j ].ID ) = LowerCase( INTERNAL_PREFIX_+'.'+INTERNAL_STRING_PREFIX_+'.'+CheckStringGridSourceCodeStrings.Cells[ 1,i ] ) ) then
           begin
           for k := j to Length( LANGUAGE_MANAGE_ARRAY_.Changes )-1 do
             begin
             if ( k < Length( LANGUAGE_MANAGE_ARRAY_.Changes )-1 ) then
               begin
               LANGUAGE_MANAGE_ARRAY_.Changes[ k ].ID := LANGUAGE_MANAGE_ARRAY_.Changes[ k+1 ].ID;
               LANGUAGE_MANAGE_ARRAY_.Changes[ k ].Value := LANGUAGE_MANAGE_ARRAY_.Changes[ k+1 ].Value;
               end;
             end; // for k
           if ( Length( LANGUAGE_MANAGE_ARRAY_.Changes )-1 >= 0 ) then
             SetLength( LANGUAGE_MANAGE_ARRAY_.Changes,Length( LANGUAGE_MANAGE_ARRAY_.Changes )-1 );
           end; // if
         end; // for Length-1 downTo 0

       CheckStringGridSourceCodeStrings.DelRow( i ); // Last StringGrid on DelRow-Base - not that many lines, ArrayMode innecessary...

       end; // if Checked
    end; // for RowCount-1 downTo 1

  CorrectColumns( CheckStringGridSourceCodeStrings );

  PnlSourceStringsHeader.Caption := CSGridSourceCodeStrings_Header + ' [' + IntToStr( CheckStringGridSourceCodeStrings.RowCount-1 ) + ']';

  PnlGround.Enabled                   := true;
  PanelLangProgressing.Visible        := false;
end;

procedure TFrmLanguage.CheckStringGridPopUpClick_DelFromCompFile( Sender : TObject );
var
 i,j,k : integer;
begin
   PnlGround.Enabled                   := false;
   PanelLangProgressing.Visible        := True;
   ProgressBarLang.Min                 := 0;
   ProgressBarLang.Max                 := CheckStringGridcompsInFileList.RowCount-1;

   for i := CheckStringGridcompsInFileList.RowCount-1 DownTo 1 do
    begin
    ProgressBarLang.Position := i;
    Application.ProcessMessages;

    if ( CheckStringGridcompsInFileList.Component[ 0, i ] = csChecked ) then
       begin
       Languager.changed := true;

       for j := Length( LANGUAGE_MANAGE_ARRAY_.FileInput )-1 DownTo 0 do
         begin
         if ( LANGUAGE_MANAGE_ARRAY_.FileInput[ j ].ID = CheckStringGridcompsInFileList.Cells[ 1,i ] ) then
           begin
           for k := j to Length( LANGUAGE_MANAGE_ARRAY_.FileInput )-1 do
             begin
             if ( k < Length( LANGUAGE_MANAGE_ARRAY_.FileInput )-1 ) then
               begin
               LANGUAGE_MANAGE_ARRAY_.FileInput[ k ].ID := LANGUAGE_MANAGE_ARRAY_.FileInput[ k+1 ].ID;
               LANGUAGE_MANAGE_ARRAY_.FileInput[ k ].Value := LANGUAGE_MANAGE_ARRAY_.FileInput[ k+1 ].Value;
               end;
             end; // for k
           if ( Length( LANGUAGE_MANAGE_ARRAY_.FileInput )-1 >= 0 ) then
             SetLength( LANGUAGE_MANAGE_ARRAY_.FileInput,Length( LANGUAGE_MANAGE_ARRAY_.FileInput )-1 );
           end; // if
         end; // for Length-1 downTo 0

       for j := Length( LANGUAGE_MANAGE_ARRAY_.Changes )-1 DownTo 0 do
         begin
         if ( LANGUAGE_MANAGE_ARRAY_.Changes[ j ].ID = CheckStringGridcompsInFileList.Cells[ 1,i ] ) then
           begin
           for k := j to Length( LANGUAGE_MANAGE_ARRAY_.Changes )-1 do
             begin
             if ( k < Length( LANGUAGE_MANAGE_ARRAY_.Changes )-1 ) then
               begin
               LANGUAGE_MANAGE_ARRAY_.Changes[ k ].ID := LANGUAGE_MANAGE_ARRAY_.Changes[ k+1 ].ID;
               LANGUAGE_MANAGE_ARRAY_.Changes[ k ].Value := LANGUAGE_MANAGE_ARRAY_.Changes[ k+1 ].Value;
               end;
             end; // for k
           if ( Length( LANGUAGE_MANAGE_ARRAY_.Changes )-1 >= 0 ) then
             SetLength( LANGUAGE_MANAGE_ARRAY_.Changes,Length( LANGUAGE_MANAGE_ARRAY_.Changes )-1 );
           end; // if
         end; // for Length-1 downTo 0

//       CheckStringGridcompsInFileList.DelRow( i );
       for j := Length( LANGUAGE_MANAGE_ARRAY_.Compfile )-1 DownTo 0 do
         begin
         if ( CheckStringGridcompsInFileList.Cells[ 1,i ] = LANGUAGE_MANAGE_ARRAY_.Compfile[ j ].ID ) then
           begin
           Languager.changed := true;

           for k := j to Length( LANGUAGE_MANAGE_ARRAY_.Compfile )-1 do
             begin
             if ( k < Length( LANGUAGE_MANAGE_ARRAY_.Compfile )-1 ) then
               begin
               LANGUAGE_MANAGE_ARRAY_.Compfile[ k ].ID := LANGUAGE_MANAGE_ARRAY_.Compfile[ k+1 ].ID;
               LANGUAGE_MANAGE_ARRAY_.Compfile[ k ].Value := LANGUAGE_MANAGE_ARRAY_.Compfile[ k+1 ].Value;
               end;
             end; // for k
           if ( Length( LANGUAGE_MANAGE_ARRAY_.Compfile )-1 >= 0 ) then
             SetLength( LANGUAGE_MANAGE_ARRAY_.Compfile, Length( LANGUAGE_MANAGE_ARRAY_.Compfile )-1 );
           end; // if
         end; // for Length-1 downTo 0

       end; // if Checked
    end; // for RowCount-1 downTo 1

  if ( Length( LANGUAGE_MANAGE_ARRAY_.Compfile ) > 0 ) then
    begin
    if ( CheckStringGridcompsInFileList.RowCount > 1 ) then
      CheckStringGridcompsInFileList.Clear( True, False );
    CheckStringGridcompsInFileList.RowCount := Length( LANGUAGE_MANAGE_ARRAY_.Compfile )+1;
    for i := 0 to Length( LANGUAGE_MANAGE_ARRAY_.Compfile )-1 do
      begin
      {$IFNDEF UNICODE}
      CheckStringGridcompsInFileList.Cells[ 1, i+1 ] := WideStringToString( LANGUAGE_MANAGE_ARRAY_.Compfile[ i ].ID, LANGUAGE_CODEPAGE_ );
      CheckStringGridcompsInFileList.Cells[ 2, i+1 ] := WideStringToString( LANGUAGE_MANAGE_ARRAY_.Compfile[ i ].Value, LANGUAGE_CODEPAGE_ );
      {$ELSE}
      CheckStringGridcompsInFileList.Cells[ 1, i+1 ] := LANGUAGE_MANAGE_ARRAY_.Compfile[ i ].ID;
      CheckStringGridcompsInFileList.Cells[ 2, i+1 ] := LANGUAGE_MANAGE_ARRAY_.Compfile[ i ].Value;
      {$ENDIF}
      end;
    end
  else
    CheckStringGridcompsInFileList.RowCount := 1;

  CorrectColumns( CheckStringGridcompsInFileList );

  PnlKomponentenfileHeader.Caption := CSGridcompsInFileList_Header + ' [' + IntToStr( CheckStringGridcompsInFileList.RowCount-1 ) + ']';

  PnlGround.Enabled                   := true;
  PanelLangProgressing.Visible        := false;

  Languager.FindRtCompsNotInCompFileList;
  Languager.FindRtFileListCompsNotInRuntimeList;
end;

procedure TFrmLanguage.CheckStringGridPopUpClick_DelFromCompFileNotInList( Sender : TObject );
var
 i,j,k : integer;
begin
   PnlGround.Enabled                   := false;
   PanelLangProgressing.Visible        := True;
   ProgressBarLang.Min                 := 0;
   ProgressBarLang.Max                 := CheckStringGridFileListCompsNotInRuntimeList.RowCount-1;

   for i := CheckStringGridFileListCompsNotInRuntimeList.RowCount-1 DownTo 1 do
    begin
    ProgressBarLang.Position := i;
    Application.ProcessMessages;

    if ( CheckStringGridFileListCompsNotInRuntimeList.Component[ 0, i ] = csChecked ) then
       begin
       Languager.changed := true;

       for j := Length( LANGUAGE_MANAGE_ARRAY_.FileInput )-1 DownTo 0 do
         begin
         if ( LANGUAGE_MANAGE_ARRAY_.FileInput[ j ].ID = CheckStringGridFileListCompsNotInRuntimeList.Cells[ 1,i ] ) then
           begin
           for k := j to Length( LANGUAGE_MANAGE_ARRAY_.FileInput )-1 do
             begin
             if ( k < Length( LANGUAGE_MANAGE_ARRAY_.FileInput )-1 ) then
               begin
               LANGUAGE_MANAGE_ARRAY_.FileInput[ k ].ID := LANGUAGE_MANAGE_ARRAY_.FileInput[ k+1 ].ID;
               LANGUAGE_MANAGE_ARRAY_.FileInput[ k ].Value := LANGUAGE_MANAGE_ARRAY_.FileInput[ k+1 ].Value;
               end;
             end; // for k
           if ( Length( LANGUAGE_MANAGE_ARRAY_.FileInput )-1 >= 0 ) then
             SetLength( LANGUAGE_MANAGE_ARRAY_.FileInput,Length( LANGUAGE_MANAGE_ARRAY_.FileInput )-1 );
           end; // if
         end; // for Length-1 downTo 0

       for j := Length( LANGUAGE_MANAGE_ARRAY_.Changes )-1 DownTo 0 do
         begin
         if ( LANGUAGE_MANAGE_ARRAY_.Changes[ j ].ID = CheckStringGridFileListCompsNotInRuntimeList.Cells[ 1,i ] ) then
           begin
           for k := j to Length( LANGUAGE_MANAGE_ARRAY_.Changes )-1 do
             begin
             if ( k < Length( LANGUAGE_MANAGE_ARRAY_.Changes )-1 ) then
               begin
               LANGUAGE_MANAGE_ARRAY_.Changes[ k ].ID := LANGUAGE_MANAGE_ARRAY_.Changes[ k+1 ].ID;
               LANGUAGE_MANAGE_ARRAY_.Changes[ k ].Value := LANGUAGE_MANAGE_ARRAY_.Changes[ k+1 ].Value;
               end;
             end; // for k
           if ( Length( LANGUAGE_MANAGE_ARRAY_.Changes )-1 >= 0 ) then
             SetLength( LANGUAGE_MANAGE_ARRAY_.Changes,Length( LANGUAGE_MANAGE_ARRAY_.Changes )-1 );
           end; // if
         end; // for Length-1 downTo 0

       for j := Length( LANGUAGE_MANAGE_ARRAY_.SourceCode )-1 DownTo 0 do
         begin
         if ( CheckStringGridFileListCompsNotInRuntimeList.Cells[ 1,i ] = LANGUAGE_MANAGE_ARRAY_.SourceCode[ j ].ID ) then
           begin
           Languager.changed := true;

           for k := j to Length( LANGUAGE_MANAGE_ARRAY_.SourceCode )-1 do
             begin
             if ( k < Length( LANGUAGE_MANAGE_ARRAY_.SourceCode )-1 ) then
               begin
               LANGUAGE_MANAGE_ARRAY_.SourceCode[ k ].ID := LANGUAGE_MANAGE_ARRAY_.SourceCode[ k+1 ].ID;
               LANGUAGE_MANAGE_ARRAY_.SourceCode[ k ].Value := LANGUAGE_MANAGE_ARRAY_.SourceCode[ k+1 ].Value;
               end;
             end; // for k
           if ( Length( LANGUAGE_MANAGE_ARRAY_.SourceCode )-1 >= 0 ) then
             SetLength( LANGUAGE_MANAGE_ARRAY_.SourceCode, Length( LANGUAGE_MANAGE_ARRAY_.SourceCode )-1 );
           end; // if
         end; // for Length-1 downTo 0

//       CheckStringGridFileListCompsNotInRuntimeList.DelRow( i );
       for j := Length( LANGUAGE_MANAGE_ARRAY_.Compfile )-1 DownTo 0 do
         begin
         if ( CheckStringGridFileListCompsNotInRuntimeList.Cells[ 1,i ] = LANGUAGE_MANAGE_ARRAY_.Compfile[ j ].ID ) then
           begin
           Languager.changed := true;

           for k := j to Length( LANGUAGE_MANAGE_ARRAY_.Compfile )-1 do
             begin
             if ( k < Length( LANGUAGE_MANAGE_ARRAY_.Compfile )-1 ) then
               begin
               LANGUAGE_MANAGE_ARRAY_.Compfile[ k ].ID := LANGUAGE_MANAGE_ARRAY_.Compfile[ k+1 ].ID;
               LANGUAGE_MANAGE_ARRAY_.Compfile[ k ].Value := LANGUAGE_MANAGE_ARRAY_.Compfile[ k+1 ].Value;
               end;
             end; // for k
           if ( Length( LANGUAGE_MANAGE_ARRAY_.Compfile )-1 >= 0 ) then
             SetLength( LANGUAGE_MANAGE_ARRAY_.Compfile, Length( LANGUAGE_MANAGE_ARRAY_.Compfile )-1 );
           end; // if
         end; // for Length-1 downTo 0

       end; // if Checked
    end; // for RowCount-1 downTo 1

  if ( Length( LANGUAGE_MANAGE_ARRAY_.Compfile ) > 0 ) then
    begin
    if ( CheckStringGridcompsInFileList.RowCount > 1 ) then
      CheckStringGridcompsInFileList.Clear( True, False );
    CheckStringGridcompsInFileList.RowCount := Length( LANGUAGE_MANAGE_ARRAY_.Compfile )+1;
    for i := 0 to Length( LANGUAGE_MANAGE_ARRAY_.Compfile )-1 do
      begin
      {$IFNDEF UNICODE}
      CheckStringGridcompsInFileList.Cells[ 1, i+1 ] := WideStringToString( LANGUAGE_MANAGE_ARRAY_.Compfile[ i ].ID, LANGUAGE_CODEPAGE_ );
      CheckStringGridcompsInFileList.Cells[ 2, i+1 ] := WideStringToString( LANGUAGE_MANAGE_ARRAY_.Compfile[ i ].Value, LANGUAGE_CODEPAGE_ );
      {$ELSE}
      CheckStringGridcompsInFileList.Cells[ 1, i+1 ] := LANGUAGE_MANAGE_ARRAY_.Compfile[ i ].ID;
      CheckStringGridcompsInFileList.Cells[ 2, i+1 ] := LANGUAGE_MANAGE_ARRAY_.Compfile[ i ].Value;
      {$ENDIF}
      end;
    end
  else
    CheckStringGridcompsInFileList.RowCount := 1;

  CorrectColumns( CheckStringGridcompsInFileList );

  PnlKomponentenfileHeader.Caption := CSGridcompsInFileList_Header + ' [' + IntToStr( CheckStringGridcompsInFileList.RowCount-1 ) + ']';

  PnlGround.Enabled                   := true;
  PanelLangProgressing.Visible        := false;

  Languager.RefreshCodeString;
  Languager.FindRtCompsNotInCompFileList;
  Languager.FindRtFileListCompsNotInRuntimeList;
end;

procedure TFrmLanguage.editSprachnameChange( Sender: TObject );
begin
  Languager.LanguageSelectionPerName( TEdit( sender ).text );
end;

procedure TFrmLanguage.ComboBoxLCIDKeyPress( Sender: TObject; var Key: Char );
begin
  Key := #0;
end;

procedure TFrmLanguage.ComboBoxCharSetChange( Sender: TObject );
begin
  if NOT ( sender is TComboBox ) then
    Exit;

  LANGUAGE_CHARSET_ := StrToIntDef( GetTok( TComboBox( sender ).Text, 1, 32 ), DEFAULT_CHARSET );
end;

procedure TFrmLanguage.ComboBoxLCIDChange( Sender: TObject );
begin
  if NOT ( sender is TComboBox ) then
    Exit;

  LANGUAGE_LCID_ := StrToIntDef( GetTok( GetTok( TComboBox( sender ).Text, 2, '(' ), 1, ')' ), 0 );
end;

procedure TFrmLanguage.ApplicationEventsMessage( var Msg: tagMSG; var Handled: Boolean );
begin
  if ( Msg.message = WM_KEYDOWN ) and ( Active ) then
   if ( CompFlash_inUse ) then
     CompFlash_Cancel := True

   else if ( Msg.wParam = VK_F2 ) then
      btnFindPreviousClick( nil )
   else if ( Msg.wParam = VK_F3 ) then
      btnFindNextClick( nil )
   else if ( Msg.wParam = VK_F4 ) then
      btnReplaceAndFindNextClick( nil )
   else if ( Msg.wParam = VK_F5 ) then
      btnSkipAndFindNextClick( nil );
end;

procedure TFrmLanguage.btnCopyStringsClick( Sender: TObject );
var
  i : integer;
begin
  for i := 0 to MemoGlobalPas.Lines.Count-1 do
    begin
    if ( MemoGlobalPas.Lines[ i ] = '' ) then
      continue;
    Languager.TSetCodeString( GetTok( MemoGlobalPas.Lines[ i ], 1, ';' ){ID}, GetTok( MemoGlobalPas.Lines[ i ], 2, NumTok( MemoGlobalPas.Lines[ i ], ';' ), ';' ){value} )
    end;
  Languager.RefreshCodeString;
  MemoGlobalPas.Text := '';
end;

procedure TFrmLanguage.MemoSourcefileMouseUp( Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer );
begin
  languageReplacer.ResetfoundAppearance;
end;

procedure TFrmLanguage.MemoSourcefileKeyUp( Sender: TObject; var Key: Word; Shift: TShiftState );
begin
  if NOT ( TMemo( Sender ).focused ) then
     Exit;
  if ( Key in [VK_F2..VK_F4] ) then
     Exit;
  languageReplacer.ResetfoundAppearance;
end;

procedure TFrmLanguage.ButtonLoadInputLanguageClick( Sender: TObject );
var
  cl           : TWideStringList;
  i            : integer;
  s, ID, Value : WideString;
  res          : Integer;
  Open         : TOpenDialog;
begin
  Open := TOpenDialog.Create( self );
  if TranslatorTmp.Changed then // Translation
    begin
    res := MessageBox( Application.Handle, 'Translation was edited, save changed now?', 'Warning', mb_YesNoCancel );
    case res of
      idNo     : ;
      idYes    : ButtonSaveTranslatedLanguageClick( self );
      idCancel : exit;
    end;
    end;

  Open.InitialDir := LANGUAGE_DIRECTORY_;
  Open.Filter := 'imessVision Languagefiles|*.' + SPRACH_EXT_;
  cl := TWideStringList.create;
  if Open.Execute then
    begin
    if Open.FileName <> '' then
      begin
      if FileExists( Open.FileName ) then
        begin
        cl.LoadFromFile( Open.FileName );
        StringGridTranslationComponents.RowCount := 1;
        StringGridTranslationInput.RowCount := 1;
        StringGridTranslationOutput.RowCount := 1;
        LabelTranslateOutputFile.Caption := '';

        TranslatorTmp.LCIDIn        := LANGUAGE_LCID_;
        TranslatorTmp.CodePageIn    := LANGUAGE_CODEPAGE_;
        TranslatorTmp.CharSetIn     := LANGUAGE_CHARSET_;

        TranslatorTmp.LCIDOut       := LANGUAGE_LCID_;
        TranslatorTmp.CodePageOut   := LANGUAGE_CODEPAGE_; // Init in case we are creating a NEW translation
        TranslatorTmp.CharSetOut    := LANGUAGE_CHARSET_;

        TranslatorTmp.Changed     := false;
        TranslatorTmp.LARow       := 0;
        TranslatorTmp.CellChanged := false;

        for i := 0 to cl.Count - 1 do
          begin
          s := cl[ i ];

          if ( s = '' ) OR ( StringReplace( s,';','',[ rfReplaceAll ] ) = '' ) OR ( LowerCase( s ) = LowerCase( INTERNAL_GRID_HEADER_1_+';'+INTERNAL_GRID_HEADER_2_+';' ) ) OR ( LowerCase( s ) = LowerCase( INTERNAL_GRID_HEADER_1_+';'+INTERNAL_GRID_HEADER_2_ ) ) then
            continue;
          if ( NumTok( s, ';' ) < 2 ) then
            Continue;

          ID := GetTok( s, 1, ';' );
          Value := GetTok( s, 2, NumTok( s, ';' ), WChar( ';' ) );

          if ( LowerCase( GetTok( ID, 1, '.' ) ) = LowerCase( INTERNAL_PREFIX_ ) ) AND NOT ( LowerCase( GetTok( ID, 2, '.' ) ) = LowerCase( INTERNAL_DLGCAPTION_PREFIX_ ) ) then
            begin
            if ( LowerCase( GetTok( ID, 2, '.' ) ) = LowerCase( INTERNAL_STRING_PREFIX_ ) ) then
              begin
              if ( StringGridTranslationComponents.cells[ 0, StringGridTranslationComponents.RowCount-1 ] <> '' ) then // Comps musst have Names
                 begin
                 StringGridTranslationComponents.RowCount := StringGridTranslationComponents.RowCount+1;
                 StringGridTranslationInput.RowCount := StringGridTranslationInput.RowCount+1;
                 StringGridTranslationOutput.RowCount := StringGridTranslationOutput.RowCount+1;
                 end;

              {$IFNDEF UNICODE}
              StringGridTranslationComponents.cells[ 0, StringGridTranslationComponents.RowCount-1 ] := WideStringToString( ID, TranslatorTmp.CodePageIn );
              StringGridTranslationInput.cells[ 0, StringGridTranslationInput.RowCount-1 ] := WideStringToString( Value, TranslatorTmp.CodePageIn );
              {$ELSE}
              StringGridTranslationComponents.cells[ 0, StringGridTranslationComponents.RowCount-1 ] := ID;
              StringGridTranslationInput.cells[ 0, StringGridTranslationInput.RowCount-1 ] := Value;
              {$ENDIF}
              StringGridTranslationOutPut.cells[ 0, StringGridTranslationOutPut.RowCount-1 ] := '';

              StringGridTranslationComponents.FixedRows := 1;
              StringGridTranslationInput.FixedRows := 1;
              StringGridTranslationOutput.FixedRows := 1;
              end
            else if ( LowerCase( GetTok( ID, 2, '.' ) ) = LowerCase( INTERNAL_CHARSET_PREFIX_ ) ) then
              begin
              TranslatorTmp.CharSetIn := StrToInt( Value );
              StringGridTranslationInput.Font.Charset := StrToInt( Value );
              end
            else if ( LowerCase( GetTok( ID, 2, '.' ) ) = LowerCase( INTERNAL_LCID_PREFIX_ ) ) then
              begin
              TranslatorTmp.LCIDIn := StrToIntDef( Value, 0 );
              if ( TranslatorTmp.LCIDIn <> 0 ) then
                TranslatorTmp.CodePageIn := LCIDtoCodePage( TranslatorTmp.LCIDIn );
              end
            else if ( LowerCase( GetTok( ID, 2, '.' ) ) = LowerCase( INTERNAL_CODEPAGE_PREFIX_ ) ) then
              begin
              if ( TranslatorTmp.LCIDIn = 0 ) then
                TranslatorTmp.CodePageIn := StrToIntDef( Value, 0 );
              end;
            end
          else
            begin
            if ( StringGridTranslationComponents.cells[ 0, StringGridTranslationComponents.RowCount-1 ] <> '' ) then // Comps musst have Names
               begin
               StringGridTranslationComponents.RowCount := StringGridTranslationComponents.RowCount+1;
               StringGridTranslationInput.RowCount := StringGridTranslationInput.RowCount+1;
               StringGridTranslationOutput.RowCount := StringGridTranslationOutput.RowCount+1;
               end;

            {$IFNDEF UNICODE}
            StringGridTranslationComponents.cells[ 0, StringGridTranslationComponents.RowCount-1 ] := WideStringToString( ID, TranslatorTmp.CodePageIn );
            StringGridTranslationInput.cells[ 0, StringGridTranslationInput.RowCount-1 ] := WideStringToString( Value, TranslatorTmp.CodePageIn );
            {$ELSE}
            StringGridTranslationComponents.cells[ 0, StringGridTranslationComponents.RowCount-1 ] := ID;
            StringGridTranslationInput.cells[ 0, StringGridTranslationInput.RowCount-1 ] := Value;
            {$ENDIF}
            StringGridTranslationOutPut.cells[ 0, StringGridTranslationOutPut.RowCount-1 ] := '';

            StringGridTranslationComponents.FixedRows := 1;
            StringGridTranslationInput.FixedRows := 1;
            StringGridTranslationOutPut.FixedRows := 1;
            end;
          end; // for
        end; // if exists
      LabelTranslateInputFile.Caption := Open.FileName;
      LabelUnfilledLines.Caption := IntToStr( StringGridTranslationComponents.RowCount-1 );
      StringGridTranslationOutput.SetFocus;
      end;
    end;
  cl.Free;
  Open.free;
end;

procedure TFrmLanguage.ButtonLoadOutputLanguageClick( Sender: TObject );
var
  cl           : TWideStringList;
  i, j         : integer;
  s, ID, Value : WideString;
  res          : Integer;
  Open         : TOpenDialog;
begin
  if TranslatorTmp.Changed then // Translation
    begin
    res := MessageBox( Application.Handle, 'Translation was edited, save changed now?', 'Warning', mb_YesNoCancel );
    case res of
      idNo     : ;
      idYes    : ButtonSaveTranslatedLanguageClick( self );
      idCancel : exit;
    end;
    end;

  if ( StringGridTranslationComponents.RowCount < 2 ) then
    begin
    MessageDlg( 'No Input-Language loaded!', mTError, [ mbOK ], 0 );
    Exit;
    end;

  Open := TOpenDialog.Create( self );
  Open.InitialDir := LANGUAGE_DIRECTORY_;
  Open.Filter := 'imessVision Languagefiles|*.' + SPRACH_EXT_;

  if NOT Open.Execute then
    begin
    Open.free;
    Exit;
    end;

  for i := 1 to StringGridTranslationComponents.RowCount-1 do
    StringGridTranslationOutput.cells[ 0, i ] := '';

  cl := TWideStringList.create;
  if NOT FileExists( Open.FileName ) then
    begin
    Open.free;
    Exit;
    end;

  cl.LoadFromFile( Open.FileName );

  TranslatorTmp.LCIDOut        := LANGUAGE_LCID_;
  TranslatorTmp.CodePageOut    := LANGUAGE_CODEPAGE_;
  TranslatorTmp.CharSetOut     := LANGUAGE_CHARSET_;

  TranslatorTmp.Changed     := false;
  TranslatorTmp.LARow       := 0;
  TranslatorTmp.CellChanged := false;
  for i := 0 to cl.Count - 1 do
    begin
    s := cl[ i ];

    if ( s = '' ) OR ( NumTok( s, ';' ) < 2 ) OR ( StringReplace( s,';','',[ rfReplaceAll ] ) = '' ) OR ( LowerCase( s ) = LowerCase( INTERNAL_GRID_HEADER_1_+';'+INTERNAL_GRID_HEADER_2_+';' ) ) OR ( LowerCase( s ) = LowerCase( INTERNAL_GRID_HEADER_1_+';'+INTERNAL_GRID_HEADER_2_ ) ) then
      continue;

    ID := GetTok( s, 1, ';' );
    Value := GetTok( s, 2, NumTok( s, ';' ), WChar( ';' ) );

    if ( LowerCase( GetTok( ID, 1, '.' ) ) = LowerCase( INTERNAL_PREFIX_ ) ) AND ( LowerCase( GetTok( ID, 2, '.' ) ) <> LowerCase( INTERNAL_STRING_PREFIX_ ) ) AND ( LowerCase( GetTok( ID, 2, '.' ) ) <> LowerCase( INTERNAL_DLGCAPTION_PREFIX_ ) ) then
      begin
      if ( LowerCase( GetTok( ID, 2, '.' ) ) = LowerCase( INTERNAL_CHARSET_PREFIX_ ) ) then
         begin
         TranslatorTmp.CharSetOut := StrToInt( Value );
         StringGridTranslationOutput.Font.Charset := StrToInt( Value );
         end
      else if ( LowerCase( GetTok( ID, 2, '.' ) ) = LowerCase( INTERNAL_LCID_PREFIX_ ) ) then
        begin
        TranslatorTmp.LCIDOut := StrToIntDef( Value, 0 );
        if ( TranslatorTmp.LCIDOut <> 0 ) then
          TranslatorTmp.CodePageOut := LCIDtoCodePage( TranslatorTmp.LCIDOut );
        end
      else if ( LowerCase( GetTok( ID, 2, '.' ) ) = LowerCase( INTERNAL_CODEPAGE_PREFIX_ ) ) then
        begin
        if ( TranslatorTmp.LCIDOut = 0 ) then
          TranslatorTmp.CodePageOut := StrToIntDef( Value, 0 );
        end;
      end;

    for j := 1 to StringGridTranslationComponents.RowCount-1 do
      begin
      if ( LowerCase( StringGridTranslationComponents.Cells[ 0, j ] ) = LowerCase( ID ) ) then
        begin
        //StringGridTranslationComponents.cells[ 0, j ] := WideStringToString( ID, TranslatorTmp.CodePage );
        {$IFNDEF UNICODE}
        StringGridTranslationOutput.cells[ 0, j ] := WideStringToString( Value, TranslatorTmp.CodePageOut );
        {$ELSE}
        StringGridTranslationOutput.cells[ 0, j ] := Value;
        {$ENDIF}
        break;
        end;
      end;
    end;

  LabelTranslateOutputFile.Caption := Open.FileName;

  j := 0;
  for i := 1 to StringGridTranslationComponents.RowCount-1 do
    begin
    if ( StringGridTranslationOutput.Cells[ 0, i ] = '' ) then
       Inc( j );
    end;
  LabelUnfilledLines.Caption := IntToStr( j );
  cl.Free;
  StringGridTranslationOutput.SetFocus;

  Open.free;
end;

procedure TFrmLanguage.ButtonImportOutputLanguageSKClick( Sender: TObject );
var
  cl              : TWideStringList;
  i, j            : integer;
  s, ID, Value    : WideString;
  res             : Integer;
  Open            : TOpenDialog;
begin
  if TranslatorTmp.Changed then // Translation
    begin
    res := MessageBox( Application.Handle, 'Translation was edited, save now?', 'Warning', mb_YesNoCancel );
    case res of
      idNo     : ;
      idYes    : ButtonSaveTranslatedLanguageClick( self );
      idCancel : exit;
    end;
    end;

  if ( StringGridTranslationComponents.RowCount < 2 ) then
    begin
    MessageDlg( 'No Input-Language loaded!', mTError, [ mbOK ], 0 );
    Exit;
    end;

  Open := TOpenDialog.Create( self );
  Open.InitialDir := LANGUAGE_DIRECTORY_;
  Open.Filter := 'imessVision Languagefiles|*.' + SPRACH_EXT_;

  if Open.Execute then
    begin
    cl := TWideStringList.create;
    if Open.FileName <> '' then
      begin
      if FileExists( Open.FileName ) then
        begin
        cl.LoadFromFile( Open.FileName );

        TranslatorTmp.LCIDOut        := LANGUAGE_LCID_;
        TranslatorTmp.CodePageOut    := LANGUAGE_CODEPAGE_;
        TranslatorTmp.CharSetOut     := LANGUAGE_CHARSET_;

        TranslatorTmp.Changed     := false;
        TranslatorTmp.LARow       := 0;
        TranslatorTmp.CellChanged := false;
        for i := 0 to cl.Count - 1 do
          begin
          s := cl[ i ];

          if ( s = '' ) OR ( NumTok( s, ';' ) < 2 ) OR ( StringReplace( s,';','',[ rfReplaceAll ] ) = '' ) OR ( LowerCase( s ) = LowerCase( INTERNAL_GRID_HEADER_1_+';'+INTERNAL_GRID_HEADER_2_+';' ) ) OR ( LowerCase( s ) = LowerCase( INTERNAL_GRID_HEADER_1_+';'+INTERNAL_GRID_HEADER_2_ ) ) then
            continue;

          if IsWm( GetTok( s, 1, ';' ), 'String.*' ) then
            begin

            end
          else if NumTok( GetTok( s, 1, ';' ), '.' ) > 1 then
            begin
            if GetTok( GetTok( s, 1, ';' ), 1, '.' ) = GetTok( GetTok( s, 1, ';' ), 2, '.' ) then
              s := GetTok( GetTok( s, 1, ';' ), 1, '.' ) + '.caption.;' + GetTok( s, 2, ';' ) + ';'
            else
              s := GetTok( s, 1, ';' ) + '.caption.;' + GetTok( s, 2, ';' ) + ';';
            end
          else
            s := GetTok( s, 1, ';' ) + '.caption.;' + GetTok( s, 2, ';' ) + ';';


          ID := GetTok( s, 1, ';' );
          Value := GetTok( s, 2, NumTok( s, ';' ), WChar( ';' ) );

          if ( LowerCase( GetTok( ID, 1, '.' ) ) = LowerCase( INTERNAL_PREFIX_ ) ) AND ( LowerCase( GetTok( ID, 2, '.' ) ) <> LowerCase( INTERNAL_STRING_PREFIX_ ) ) AND ( LowerCase( GetTok( ID, 2, '.' ) ) <> LowerCase( INTERNAL_DLGCAPTION_PREFIX_ ) ) then
            begin
            if ( LowerCase( GetTok( ID, 2, '.' ) ) = LowerCase( INTERNAL_CHARSET_PREFIX_ ) ) then
               begin
               TranslatorTmp.CharSetOut := StrToInt( Value );
               StringGridTranslationOutput.Font.Charset := StrToInt( Value );
               end
            else if ( LowerCase( GetTok( ID, 2, '.' ) ) = LowerCase( INTERNAL_LCID_PREFIX_ ) ) then
              begin
              TranslatorTmp.LCIDOut := StrToIntDef( Value, 0 );
              if ( TranslatorTmp.LCIDOut <> 0 ) then
                TranslatorTmp.CodePageOut := LCIDtoCodePage( TranslatorTmp.LCIDOut );
              end
            else if ( LowerCase( GetTok( ID, 2, '.' ) ) = LowerCase( INTERNAL_CODEPAGE_PREFIX_ ) ) then
              begin
              if ( TranslatorTmp.LCIDOut = 0 ) then
                TranslatorTmp.CodePageOut := StrToIntDef( Value, 0 );
              end;
            end;

          for j := 1 to StringGridTranslationComponents.RowCount-1 do
            begin
            if IsWM( ID, 'String.*' ) then
              begin
              if IsWM( StringGridTranslationComponents.Cells[ 0, j ], INTERNAL_PREFIX_ + '.' + INTERNAL_STRING_PREFIX_ + '.*:*.' + GetTok( ID, 2, '.' ) + '.' ) then
                begin
                {$IFNDEF UNICODE}
                StringGridTranslationOutput.cells[ 0, j ] := WideStringToString( Value, TranslatorTmp.CodePageOut );
                {$ELSE}
                StringGridTranslationOutput.cells[ 0, j ] := Value;
                {$ENDIF}
                break;
                end;
              end
            else if ( LowerCase( StringGridTranslationComponents.Cells[ 0, j ] ) = LowerCase( ID ) ) then
              begin
              //StringGridTranslationComponents.cells[ 0, j ] := WideStringToString( ID, TranslatorTmp.CodePage );
              {$IFNDEF UNICODE}
              StringGridTranslationOutput.cells[ 0, j ] := WideStringToString( Value, TranslatorTmp.CodePageOut );
              {$ELSE}
              StringGridTranslationOutput.cells[ 0, j ] := Value;
              {$ENDIF}
              break;
              end;
            end;
          end;
        end;

      LabelTranslateOutputFile.Caption := Open.FileName;

      j := 0;
      for i := 1 to StringGridTranslationComponents.RowCount-1 do
        begin
        if ( StringGridTranslationOutput.Cells[ 0, i ] = '' ) then
           Inc( j );
        end;
      LabelUnfilledLines.Caption := IntToStr( j );
      cl.Free;
      StringGridTranslationOutput.SetFocus;
      end;
    end;
  Open.free;
end;

procedure TFrmLanguage.ButtonSaveTranslatedLanguageClick( Sender: TObject );
var
    cl   : TWideStringList;
    i    : integer;
    Save : TSaveDialog;
begin
  Save := TSaveDialog.Create( self );
  Save.InitialDir := LANGUAGE_DIRECTORY_;
  Save.Filter := 'imessVision Languagefiles|*.' + SPRACH_EXT_;

  if LabelTranslateOutputFile.Caption <> '' then
    Save.FileName := ExtractFileName( LabelTranslateOutputFile.Caption )
  else
    Save.FileName := 'Default.' + SPRACH_EXT_;

  if Save.Execute then
     begin
     if NOT ( IsWm( Save.FileName, '*.' + SPRACH_EXT_ ) ) then
       Save.FileName := Save.FileName + '.' + SPRACH_EXT_;

     cl := TWideStringList.create;
     cl.Add( INTERNAL_GRID_HEADER_1_ + ';' + INTERNAL_GRID_HEADER_2_ + ';' ); // Header
     cl.Add( INTERNAL_PREFIX_ + '.' + INTERNAL_LCID_PREFIX_ + '.' + ';' + IntToStr( TranslatorTmp.LCIDOut ) + ';' );
     cl.Add( INTERNAL_PREFIX_ + '.' + INTERNAL_CHARSET_PREFIX_ + '.' + ';' + IntToStr( TranslatorTmp.CharSetOut ) + ';' );

     for i := 1 to StringGridTranslationComponents.RowCount-1 do
       begin
       if ( StringGridTranslationOutput.Cells[ 0, i ] = '' ) then
         continue;
       {$IFNDEF UNICODE}
       cl.Add( StringGridTranslationComponents.Cells[ 0, i ] + ';' + StringToWideString( StringGridTranslationOutput.Cells[ 0, i ], TranslatorTmp.CodePageOut ) + ';' );
       {$ELSE}
       cl.Add( StringGridTranslationComponents.Cells[ 0, i ] + ';' + StringGridTranslationOutput.Cells[ 0, i ] + ';' );
       {$ENDIF}
       end;

     {$IFNDEF UNICODE}
     cl.SaveUnicode := True; // set this RIGHT here, former trys setting b4 adding items caused problems loading them again (broke after 4 lines)
     {$ENDIF}
     cl.SaveToFile( Save.FileName );
     cl.Free;

     ListLanguageFiles( nil );
     TranslatorTmp.Changed     := false;
     TranslatorTmp.LARow       := 0;
     TranslatorTmp.CellChanged := false;
     if ( self.Visible ) then
       StringGridTranslationOutput.SetFocus;
     end;
  Save.free;
end;

procedure TFrmLanguage.FindEmptyLinePrevClick( Sender: TObject );
begin
  FindEmptyLine( false );
end;

procedure TFrmLanguage.FindEmptyLineClick( Sender: TObject );
begin
  FindEmptyLine( true );
end;

procedure TFrmLanguage.ButtonClearTranslatedLanguageClick( Sender: TObject );
var
  i : integer;
begin
  if TranslatorTmp.Changed then
    begin
    i := MessageBox( Application.Handle, 'Translation was edited, save now?', 'Warning', mb_YesNoCancel );
    case i of
      idNo     : ;
      idYes    : ButtonSaveTranslatedLanguageClick( self );
      idCancel : exit;
      end;
    end;

  for i := 1 to StringGridTranslationComponents.RowCount-1 do
      StringGridTranslationOutput.cells[ 0, i ] := '';
  TranslatorTmp.Changed     := false;
  TranslatorTmp.LARow       := 0;
  TranslatorTmp.CellChanged := false;

  LabelTranslateOutputFile.Caption := '---';
  LabelUnfilledLines.Caption := IntToStr( StringGridTranslationComponents.RowCount-1 );
end;

procedure TFrmLanguage.StringGridTranslationOutputSelectCell( Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean );
var
  i, empty : integer;
begin
  StringGridTranslationComponents.OnSelectCell := nil; // Prevent from selfcalling...
  StringGridTranslationInput.OnSelectCell := nil;
  StringGridTranslationOutput.OnSelectCell := nil;

  StringGridTranslationComponents.Row := ARow;
  StringGridTranslationInput.Row := ARow;
  StringGridTranslationOutput.Row := ARow;

  if ( TranslatorTmp.LARow <> 0 ) AND ( TranslatorTmp.LARow <> ARow ) AND ( TranslatorTmp.CellChanged = false ) then
    StringGridTranslationOutput.Cells[ 0, TranslatorTmp.LARow ] := TranslatorTmp.LText
  else
    TranslatorTmp.Changed     := true;

  if ( TranslatorTmp.LARow <> ARow ) then
    begin
    TranslatorTmp.LARow       := ARow;
    TranslatorTmp.LText       := StringGridTranslationOutput.Cells[ 0, ARow ];
    TranslatorTmp.CellChanged := false;
    end;

  if ( ARow > 0 ) AND ( ARow <= StringGridTranslationComponents.RowCount-1 ) AND ( StringGridTranslationOutput.Cells[ 0, ARow ] = '' ) AND ( StringGridTranslationInput.Cells[ 0, ARow ] <> '' ) then
    StringGridTranslationOutput.Cells[ 0, ARow ] := StringGridTranslationInput.Cells[ 0, ARow ];

  empty := 0;
  for i := 1 to StringGridTranslationComponents.RowCount-1 do
    begin
    if ( StringGridTranslationOutput.Cells[ 0, i ] = '' ) then
      Inc( empty );
    end;
  LabelUnfilledLines.Caption := IntToStr( empty );

  StringGridTranslationComponents.OnSelectCell := StringGridTranslationOutputSelectCell; // Restore events
  StringGridTranslationInput.OnSelectCell := StringGridTranslationOutputSelectCell;
  StringGridTranslationOutput.OnSelectCell := StringGridTranslationOutputSelectCell;

  StringGridTranslationOutput.SetFocus;
end;

procedure TFrmLanguage.StringGridTranslationOutputEnter( Sender: TObject );
var
  i, empty : integer;
begin
  if ( TranslatorTmp.LARow <> 0 ) AND ( TranslatorTmp.LARow <> StringGridTranslationOutput.Row ) AND ( TranslatorTmp.CellChanged = false ) then
    StringGridTranslationOutput.Cells[ 0, TranslatorTmp.LARow ] := TranslatorTmp.LText;

  if ( TranslatorTmp.LARow <> StringGridTranslationOutput.Row ) then
    begin
    TranslatorTmp.LARow       := StringGridTranslationOutput.Row;
    TranslatorTmp.LText       := StringGridTranslationOutput.Cells[ 0, StringGridTranslationOutput.Row ];
    TranslatorTmp.CellChanged := false;
    end;

  if ( StringGridTranslationOutput.Cells[ 0, StringGridTranslationOutput.Row ] = '' ) AND ( StringGridTranslationInput.Cells[ 0, StringGridTranslationInput.Row ] <> '' ) then
    StringGridTranslationOutput.Cells[ 0, StringGridTranslationOutput.Row ] := StringGridTranslationInput.Cells[ 0, StringGridTranslationInput.Row ];

  empty := 0;
  for i := 1 to StringGridTranslationComponents.RowCount-1 do
    begin
    if ( StringGridTranslationOutput.Cells[ 0, i ] = '' ) then
       Inc( empty );
    end;
  LabelUnfilledLines.Caption := IntToStr( empty );
end;

procedure TFrmLanguage.StringGridTranslationOutputTopLeftChanged( Sender: TObject );
begin
  StringGridTranslationComponents.TopRow := TStringGrid( sender ).TopRow;
  StringGridTranslationInput.TopRow      := TStringGrid( sender ).TopRow;
  StringGridTranslationOutput.TopRow     := TStringGrid( sender ).TopRow;
end;

procedure TFrmLanguage.StringGridTranslationComponentsDrawCell( Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  sg                 : TStringGrid;
  form               : TWinControl;
  comp               : TComponent;
  prop               : String;
begin
  sg    := TStringGrid( sender );
  form  := nil;

  if NOT Languager.FindFormByName( GetTok( StringGridTranslationComponents.Cells[ 0, ARow ], 1, '.' ), form ) then
    Exit;

  if NOT Languager.FindComponentByName( form, GetTok( StringGridTranslationComponents.Cells[ 0, ARow ], 2, '.' ), comp ) then
    Exit;

  prop := GetTok( StringGridTranslationComponents.Cells[ 0, ARow ], 3, '.' );
//  ID := StrToIntDef( GetTok( StringGridTranslationComponents.Cells[ 0, ARow ], 4, '.' ), 0 );

  sg.Canvas.Brush.Style := bsSolid;
  if ( ARow > 0 ) then
    begin
    if ( comp = nil ) AND NOT ( ( LowerCase( GetTok( StringGridTranslationComponents.Cells[ 0, ARow ], 2, '.' ) ) = 'self' ) AND ( LowerCase( prop ) = 'caption' ) ) then
      sg.Canvas.Brush.Color := clSilver;
    end;
  sg.Canvas.Fillrect( Rect );
  sg.Canvas.Brush.Style := bsClear;
  sg.Canvas.TextOut( Rect.Left+4, Rect.Top+4, sg.Cells[ ACol, ARow ] );
end;

procedure TFrmLanguage.StringGridTranslationInputDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  sg                 : TStringGrid;
  form               : TWinControl;
  comp               : TComponent;
  prop               : String;
  ID                 : Integer;
  s                  : string;
  vText              : String;
begin
  sg    := TStringGrid( sender );
  form  := nil;

  if NOT Languager.FindFormByName( GetTok( StringGridTranslationComponents.Cells[ 0, ARow ], 1, '.' ), form ) then
    Exit;
  if NOT Languager.FindComponentByName( form, GetTok( StringGridTranslationComponents.Cells[ 0, ARow ], 2, '.' ), comp ) then
    Exit;
  prop := GetTok( StringGridTranslationComponents.Cells[ 0, ARow ], 3, '.' );
  ID := StrToIntDef( GetTok( StringGridTranslationComponents.Cells[ 0, ARow ], 4, '.' ), 0 );

  sg.Canvas.Brush.Style := bsSolid;
  if ( ARow > 0 ) then
    begin
    Languager.GetProperty( form, comp, prop, ID, vText );

    s := sg.Cells[ 0, ARow ];
    s := StringReplace( s, INTERNAL_REPLACE_CR, #13, [ rfReplaceAll ] ); // CR
    s := StringReplace( s, INTERNAL_REPLACE_LF, #10, [ rfReplaceAll ] ); // LF
    
    if chkHighlightVCLDifference.Checked then
      begin
      if NOT ( CompareStr( vText, s ) = 0 ) then
        sg.Canvas.Brush.Color := clFuchsia;
      end;
    end;
  sg.Canvas.Fillrect( Rect );
  sg.Canvas.Brush.Style := bsClear;
  sg.Canvas.TextOut( Rect.Left+4, Rect.Top+4, sg.Cells[ ACol, ARow ] );
end;

procedure TFrmLanguage.StringGridTranslationOutputDrawCell( Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState );
var
  sg                 : TStringGrid;
  form               : TWinControl;
  comp               : TComponent;
  prop               : String;
  dummy              : TBitmap;
  CWidth, CHeight,
  TWidth, THeight    : integer;
  AutoSize, WordWrap : boolean;
  s                  : string;
  pi                 : PPropInfo;
begin
  dummy := TBitmap.Create;
  sg    := TStringGrid( sender );
  form  := nil;

  if NOT Languager.FindFormByName( GetTok( StringGridTranslationComponents.Cells[ 0, ARow ], 1, '.' ), form ) then
    Exit;
  if NOT Languager.FindComponentByName( form, GetTok( StringGridTranslationComponents.Cells[ 0, ARow ], 2, '.' ), comp ) then
    Exit;
  prop := GetTok( StringGridTranslationComponents.Cells[ 0, ARow ], 3, '.' );

  CWidth := -1;
  CHeight := -1;
  AutoSize := false;
  WordWrap := false;

  if      ( comp = nil           ) OR ( prop = '' ) then
    Exit
  else if ( LowerCase( prop ) = LowerCase( 'hint' ) ) then
    Exit
  else if ( prop = '' ) then // Don't know, don't care..
    Exit;

  if IsPublishedProp( comp, 'Width' ) then
    CWidth := GetPropValue( comp, 'Width' );
  if IsPublishedProp( comp, 'Height' ) then
    CHeight := GetPropValue( comp, 'Height' );
  if IsPublishedProp( comp, 'AutoSize' ) then
    AutoSize := GetPropValue( comp, 'AutoSize' );
  if IsPublishedProp( comp, 'WordWrap' ) then
    WordWrap := GetPropValue( comp, 'WordWrap' );
  if IsPublishedProp( comp, 'Font' ) then
    begin
    pi := GetPropInfo( comp, 'Font' );
    dummy.Canvas.Font.Assign( TFont( GetOrdProp( comp, pi ) ) );
    end;

  sg.Canvas.Brush.Style := bsSolid;
  if ( ARow > 0 ) then
    begin
    s := sg.Cells[ 0, ARow ];
    s := StringReplace( s, INTERNAL_REPLACE_CR, #13, [ rfReplaceAll ] ); // CR
    s := StringReplace( s, INTERNAL_REPLACE_LF, #10, [ rfReplaceAll ] ); // LF
    
    TWidth := dummy.Canvas.TextWidth( s );
    THeight := dummy.Canvas.TextHeight( s );
    if ( CWidth < 0 ) OR ( sg.Cells[ 0, ARow ] = '' ) then
      begin
      end
    else if AutoSize then
      begin
      sg.Canvas.Brush.color := clGray;
      end
    else if WordWrap AND ( TWidth > CWidth ) then
      begin
      if ( Ceil( TWidth / CWidth ){Lines we need} > Floor( CHeight / THeight ){Lines we can store} ) then
        sg.Canvas.Brush.color := clRed
      else
        sg.Canvas.Brush.color := clWhite;
      end
    else if ( TWidth > CWidth ) then
      sg.Canvas.Brush.color := clRed
    else
      sg.Canvas.Brush.color := clWhite;
    end;
  dummy.free;
  sg.Canvas.Fillrect( Rect );
  sg.Canvas.Brush.Style := bsClear;
  sg.Canvas.TextOut( Rect.Left+4, Rect.Top+4, sg.Cells[ ACol, ARow ] );
end;

procedure TFrmLanguage.StringGridTranslationSplitterMoved( Sender: TObject );
begin
  StringGridTranslationComponents.ColWidths[ 0 ] := StringGridTranslationComponents.Width-5;
  StringGridTranslationInput.ColWidths[ 0 ] := StringGridTranslationInput.Width-5;
  StringGridTranslationOutput.ColWidths[ 0 ] := StringGridTranslationOutput.Width-5;
end;

procedure TFrmLanguage.SplitterAutomaticMoved( Sender: TObject );
begin
  StringGridCompsInRuntimeList.ColWidths[ 0 ] := StringGridCompsInRuntimeList.width div 3;
  StringGridCompsInRuntimeList.ColWidths[ 1 ] := StringGridCompsInRuntimeList.width-StringGridCompsInRuntimeList.ColWidths[ 0 ]-10;

  CorrectColumns( CheckStringGridCompsInFileList );
  CorrectColumns( CheckStringGridRuntimeCompsNotInFileList );
  CorrectColumns( CheckStringGridFileListCompsNotInRuntimeList );
  CorrectColumns( CheckStringGridSourceCodeStrings );
end;

procedure TFrmLanguage.StringGridTranslationOutputKeyPress( Sender: TObject; var Key: Char );
var
  i : integer;
  s, s2 : String;
begin
  if NOT ( sender is TStringGrid ) then
    Exit;

  if ( TStringGrid( sender ).Row = TranslatorTmp.LARow ) AND ( Key = #13 ) then
    TranslatorTmp.CellChanged := true;

  if ( Key = #13 ) AND ( TStringGrid( sender ).RowCount-1 > 0 ) AND ( TStringGrid( sender ).Row+1 <= TStringGrid( sender ).RowCount-1 ) then
    begin
    if chkTranslateAutoFill.Checked then
      begin
      s  := StringGridTranslationInput.Cells[ 0, TranslatorTmp.LARow ];
//      s2 := StringReplace( TStringGrid( sender ).Cells[ 0, TranslatorTmp.LARow ], INTERNAL_REPLACE_CR, #13, [ rfReplaceAll ] ); // CR
//      s2 := StringReplace( s2, INTERNAL_REPLACE_LF, #10, [ rfReplaceAll ] ); // LF
      s2 := uTLH.Strings.Remove( TStringGrid( sender ).Cells[ 0, TranslatorTmp.LARow ], #13#10 );
      for i := 0 to TStringGrid( sender ).RowCount-1 do
        begin
        if ( i = TranslatorTmp.LARow ) then
          continue;
        if LowerCase( s ) = LowerCase( StringGridTranslationInput.Cells[ 0, i ] ) then
          begin
          if ( TStringGrid( Sender ).Cells[ 0, i ] = '' ) then
            TStringGrid( Sender ).Cells[ 0, i ] := s2;
          end;
        end;
      end;
    TStringGrid( Sender ).Row := TStringGrid( Sender ).Row+1;
    Key := #0;
    end;

  if ( TStringGrid( Sender ).Row = 0 ) then
    Key := #0;
end;

procedure TFrmLanguage.btnScanSourcesClick( Sender: TObject );
var
  res : integer;
begin
  if ( MemoGlobalPas.Text <> '' ) {AND languageReplacer.TextBoxChanged} then
    begin
    res := MessageBox( Application.Handle, 'New SourceCode-Strings not copied to CompFile! Copy now?', 'Warning', mb_YesNoCancel );
    case res of
      idNo     : ;
      idYes    : btnCopyStringsClick( self );
      idCancel : exit;
      end;
    end;

  Languager.CollectCodeString;
end;

procedure TFrmLanguage.FindEmptyLine( Next : boolean = True );
var
  Line : Integer;
  CanSelect : Boolean;
begin
  if Next then
    begin
    for Line := StringGridTranslationOutput.Row to StringGridTranslationComponents.RowCount-2 do
      begin
      if ( StringGridTranslationOutput.Cells[ 0, Line ] = '' ) then
        break;
      end;
    end
  else
    begin
    for Line := StringGridTranslationComponents.Row downTo 1 do
      begin
      if ( StringGridTranslationOutput.Cells[ 0, Line ] = '' ) then
        break;
      end;
    end;
  Line := Min( Max( 1, Line ), StringGridTranslationComponents.RowCount-1 );

  if ( Line < StringGridTranslationOutput.TopRow ) OR
     ( Line > StringGridTranslationOutput.TopRow+StringGridTranslationOutput.VisibleRowCount ) then
     begin
     if ( Line+StringGridTranslationOutput.VisibleRowCount > StringGridTranslationOutput.RowCount-1 ) then
       StringGridTranslationOutput.TopRow := Line-( Line+StringGridTranslationOutput.VisibleRowCount-StringGridTranslationOutput.RowCount-1 )
     else
       StringGridTranslationOutput.TopRow := Line;
     end;

  StringGridTranslationOutputSelectCell( StringGridTranslationOutput, 0, Line, CanSelect );
end;

procedure TFrmLanguage.FormResize( Sender: TObject );
begin
  SplitterAutomaticMoved( self );
  StringGridTranslationSplitterMoved( self );

  CorrectColumns( StringGridCompsInRuntimeList );
  CorrectColumns( CheckStringGridSourceCodeStrings );
  CorrectColumns( CheckStringGridcompsInFileList );
  CorrectColumns( CheckStringGridRuntimeCompsNotInFileList );
  CorrectColumns( CheckStringGridFileListCompsNotInRuntimeList );
end;

procedure TFrmLanguage.tsLanguageTranslateEnter( Sender: TObject );
begin
  StringGridTranslationOutput.SetFocus;
end;

procedure TFrmLanguage.ExclusionListComponents;
  procedure Recurse( chain : string; comp : TComponent; First : boolean );
  var
    i, j   : integer;
    c      : TComponent;
    nChain : string;
  begin
    for i := 0 to comp.ComponentCount - 1 do
      begin
      if First then
        begin
        ProgressBarLang.Position := i;
        Application.ProcessMessages;
        end;

      c := comp.Components[ i ];
      if NOT ( c is TWinControl ) then
        Continue;
      if ( TWinControl( c ).Name = '' ) then // Ignore ..
        Continue;

      nChain := IfThen( chain <> '', chain+'>', chain ) + TWinControl( c ).name;
      if ( c is TForm ) OR ( c is TFrame ) then
        begin
        ListBoxComponents.Items.Add( nChain + '.self.Caption.' );
        for j := 0 to c.ComponentCount - 1 do
          begin
          if ( c.Components[ j ].name = '' ) then
            Continue; // Dynamic Object - die silently.

          {if ( c.Name = FrmLanguage_.name ) then
             continue;
          else}
          ListBoxComponents.Items.Add( nChain + '.' + c.Components[ j ].name );
          end;
        end;
      Recurse( nChain, c, false );
      end;
  end;

var
  i, j     : integer;
begin
  ListBoxComponents.Items.Clear;
  ListBoxComponentsFiltered.Items.Clear;

  PnlGround.Enabled                   := false;
  PanelLangProgressing.Visible        := True;
  ProgressBarLang.Min                 := 0;
  ProgressBarLang.Max                 := application.ComponentCount-1;

  Recurse( '', application, True );

  if ( ListBoxExcludes.Items.Count-1 > 0 ) then
    ProgressBarLang.Max := ListBoxExcludes.Items.Count-1
  else
    ProgressBarLang.Max := 0;

  for i := 0 to ListBoxExcludes.Items.Count-1 do
    begin
    ProgressBarLang.Position := i;
    Application.ProcessMessages;

    for j := ListBoxComponents.Items.Count-1 downto 0 do
      begin
      if ( LowerCase( ListBoxComponents.Items[ j ] ) = LowerCase( ListBoxExcludes.Items[ i ] ) ) then
        ListBoxComponents.Items.Delete( j );
      end;
    end;

  PanelLangProgressing.Visible := false;
  PnlGround.Enabled := True;
end;

procedure TFrmLanguage.MenuItemRefreshComponentsClick( Sender: TObject );
begin
  ExclusionListComponents;
  EditFilterChange( EditFilter ); // Re-Filter..
end;


procedure TFrmLanguage.MenuItemLoadExclusionsClick( Sender: TObject );
begin
  LoadExcludes;

  ExclusionListComponents;
  EditFilterChange( EditFilter ); // Re-Filter..
end;

procedure TFrmLanguage.LoadExcludes;
var
  d : string;
  i : integer;
  l : TStringList;
begin
  d := LANGUAGE_DIRECTORY_ + INTERNAL_EXCLUSION_FILE;
  SetLength( LANGUAGE_MANAGE_ARRAY_.Exclusion, 0 );

  ListBoxExcludes.Items.Clear;

  l := TStringList.create;
  if ( FileExists( d ) ) then
    begin
    ListBoxExcludes.Items.LoadFromFile( d );
    l.LoadFromFile( d );
    SetLength( LANGUAGE_MANAGE_ARRAY_.Exclusion, l.Count );
    for i := 0 to l.Count-1 do
      LANGUAGE_MANAGE_ARRAY_.Exclusion[ i ] := l[ i ];
    end;
  l.free;
end;

procedure TFrmLanguage.SaveExcludes;
var
  d, sf : string;
  i     : integer;
begin
  sf := LANGUAGE_DIRECTORY_;
  d := sf + INTERNAL_EXCLUSION_FILE;

  if NOT DirectoryExists( sf ) then
    begin
    if ForceDirectories( sf ) then
      ListBoxExcludes.Items.SaveToFile( d );
    end
  else
    ListBoxExcludes.Items.SaveToFile( d );

  SetLength( LANGUAGE_MANAGE_ARRAY_.Exclusion, ListBoxExcludes.Items.Count );
  for i := 0 to ListBoxExcludes.Items.Count-1 do
    LANGUAGE_MANAGE_ARRAY_.Exclusion[ i ] := ListBoxExcludes.Items[ i ];

  if ( ListBoxExcludes.Count > 0 ) then
    Languager.ShowObjectsInStringlist;
end;

function TFrmLanguage.ExcludesChanged: boolean;
var
  i     : integer;
  StrL,
  StrL2  : TStringList;
begin
  StrL := TStringList.Create;
  StrL2 := TStringList.Create;

  for i := 0 to Length( LANGUAGE_MANAGE_ARRAY_.Exclusion )-1 do
    begin
    StrL.Add( LANGUAGE_MANAGE_ARRAY_.Exclusion[ i ] );
    end;

  StrL2.Assign( ListBoxExcludes.Items );

  result := NOT CompareStrings( StrL, StrL2 );
  StrL.free;
  StrL2.free;
end;

procedure TFrmLanguage.AddToExclusion( item : string );
var
  i : Integer;
begin
  if ( item = '' ) OR ( NumTok( item, '.' ) < 2 ) {OR ( GetTok( item, 2, '.' ) = 'self' )} then
    Exit;

  ListBoxExcludes.Items.Add( GetTok( item, 1, 2, '.' ) );
  ListBoxExcludes.Items.Assign( FilterDublicateEntries( ListBoxExcludes.Items ) );

  for i := ListBoxComponents.Items.Count-1 downTo 0 do
    if ( LowerCase( GetTok( item, 1, 2, '.' ) ) = LowerCase( ListBoxComponents.Items[ i ] ) ) then
      ListBoxComponents.Items.Delete( i );
end;

procedure TFrmLanguage.MenuItemAddExclusionFromListsClick( Sender: TObject );
var
  i : integer;
begin
  for i := ListBoxComponents.Items.Count-1 downto 0 do
    begin
    if ( ListBoxComponents.Selected[ i ] ) then
      begin
      ListBoxExcludes.Items.Add( ListBoxComponents.Items[ i ] );
      ListBoxComponents.Items.Delete( i );
      end;
    end;
end;

procedure TFrmLanguage.MenuItemAddExclusionFromListsFilteredClick( Sender: TObject );
var
  i : integer;
begin
  for i := ListBoxComponentsFiltered.Items.Count-1 downto 0 do
    begin
    if ListBoxComponentsFiltered.Selected[ i ] then
      begin
      ListBoxExcludes.Items.Add( ListBoxComponentsFiltered.Items[ i ] );
      ListBoxComponentsFiltered.Items.Delete( i );
      end;
    end;
end;

procedure TFrmLanguage.MenuItemAddExclusionFromFilteredClick( Sender: TObject );
var
  i,j  : integer;
begin
  for i := ListBoxComponentsFiltered.Items.Count-1 downto 0 do
    begin
    if ( ListBoxComponentsFiltered.Selected[ i ] ) then
      begin
      for j := ListBoxComponents.Items.Count-1 downto 0 do
        begin
        if ( ListBoxComponentsFiltered.Items[ i ] = ListBoxComponents.Items[ j ] ) then
          begin
          ListBoxComponents.Items.Delete( j );
          end;
        end;

      ListBoxExcludes.Items.Add( ListBoxComponentsFiltered.Items[ i ] );
      ListBoxComponentsFiltered.Items.Delete( i );
      end;
    end;
end;

procedure TFrmLanguage.MenuItemSaveExclusionsClick( Sender: TObject );
begin
  SaveExcludes;
end;

procedure TFrmLanguage.MenuItemDeleteExcludeClick( Sender: TObject );
var
  i : integer;
begin
  for i := ListBoxExcludes.Items.Count-1 downto 0 do
    begin
    if ( ListBoxExcludes.Selected[ i ] ) then
      ListBoxExcludes.Items.Delete( i );
    end;
  ExclusionListComponents;
  EditFilterChange( EditFilter );
  EditExcludedFilterChange( EditExcludedFilter );
end;

procedure TFrmLanguage.MenuItemDeleteExcludeFilteredClick( Sender: TObject );
var
  i, j : integer;
begin
  for i := 0 to ListBoxExcludedFiltered.Items.Count-1 do
    begin
    for j := ListBoxExcludes.Items.Count-1 downto 0 do
      begin
      if ( LowerCase( ListBoxExcludes.Items[ j ] ) = LowerCase( ListBoxExcludedFiltered.Items[ i ] ) ) then
        begin
        ListBoxExcludes.Items.Delete( j );
        break;
        end;
      end;
    end;

  ExclusionListComponents;
  EditFilterChange( EditFilter );
  EditExcludedFilterChange( EditExcludedFilter );
end;

procedure TFrmLanguage.EditFilterChange( Sender: TObject );
var
 i : integer;
begin
  ListBoxComponentsFiltered.Items.Clear;
  for i := 0 to ListBoxComponents.Items.Count-1 do
    begin
    if ( IsWm( ListBoxComponents.Items[ i ], ( sender as TEdit ).Text ) ) then
      ListBoxComponentsFiltered.Items.Add( ListBoxComponents.Items[ i ] );
    end;
end;

procedure TFrmLanguage.EditExcludedFilterChange( Sender: TObject );
var
 i : integer;
begin
  ListBoxExcludedFiltered.Items.Clear;
  for i := 0 to ListBoxExcludes.Items.Count-1 do
    begin
    if ( IsWm( ListBoxExcludes.Items[ i ], ( sender as TEdit ).Text ) ) then
      ListBoxExcludedFiltered.Items.Add( ListBoxExcludes.Items[ i ] );
    end;
end;

function GetSourceCodeString( ID: integer ): string;
begin
  result := Languager.GetSourceCodeString( ID );
end;

function GetSourceCodeString( ID: integer; default : string ): string;
begin
  result := Languager.GetSourceCodeString( ID, default );
end;

function ListLanguageFiles( list : TComponent ): integer;
begin
  result := Languager.ListLanguageFiles( list );
end;

{$IFNDEF UNICODE}
function GetLanguageWideString( Str : AnsiString ) : WideString;
begin
  result := StringToWideString( str, LANGUAGE_CODEPAGE_ );
end;
{$ENDIF}

procedure TFrmLanguage.PnlKomponentenfileHeaderClick( Sender: TObject ); // Standalone
var
  od : TOpenDialog;
begin
  if NOT ( Application.MainForm = self ) then
    Exit;

  od := TOpenDialog.Create( self );
  if od.Execute then
    Languager.ApplyLanguageFile( od.FileName );
  od.free;
end;

procedure TFrmLanguage.SetComboBoxLCID( LCID : Cardinal );
var
  i : integer;
begin
  if NOT Assigned( self ) then
    Exit;

  for i := 0 to ComboBoxLCID.Items.Count-1 do
    if ( StrToInt64Def( GetTok( GetTok( ComboBoxLCID.Items[ i ], 2, '(' ), 1, ')' ), -1 ) = LCID ) then
      ComboBoxLCID.ItemIndex := i;
end;

procedure TFrmLanguage.SetComboBoxCharSet( CharSet : integer );
var
  i : integer;
begin
  if NOT Assigned( self ) then
    Exit;

  for i := 0 to ComboBoxCharSet.Items.Count-1 do
    if ( StrToIntDef( GetTok( ComboBoxCharSet.Items[ i ], 1, 32 ), -1 ) = CharSet ) then
      ComboBoxCharSet.ItemIndex := i;
end;

procedure TFrmLanguage.btnFontSizePlusClick(Sender: TObject);
begin
  MemoSourcefile.Font.Size := MemoSourcefile.Font.Size+1;
end;

procedure TFrmLanguage.btnFontSizeMinusClick(Sender: TObject);
begin
  MemoSourcefile.Font.Size := Max( 8, MemoSourcefile.Font.Size-1 )
end;

procedure TFrmLanguage.chkHighlightVCLDifferenceClick(Sender: TObject);
begin
  StringGridTranslationInput.Invalidate;
end;

procedure TFrmLanguage.btnAutoFillClick(Sender: TObject);
var
  i, j : Integer;
begin
  for i := 1 to StringGridTranslationOutput.RowCount-1 do
    begin
    if ( StringGridTranslationOutput.Cells[ 0, i ] <> '' ) then
      Continue;
    if ( StringGridTranslationInput.Cells[ 0, i ] = '' ) then
      Continue;

    for j := 0 to StringGridTranslationInput.RowCount-1 do
      begin
      if ( LowerCase( StringGridTranslationInput.Cells[ 0, i ] ) <> LowerCase( StringGridTranslationInput.Cells[ 0, j ] ) ) then
        Continue;

      if ( StringGridTranslationOutput.Cells[ 0, j ] = '' ) then
        Continue;

      StringGridTranslationOutput.Cells[ 0, i ] := StringGridTranslationOutput.Cells[ 0, j ];
      break;
      end;
    end;
end;

end.
