{
  TetzkatLipHoka 2015-2020

  uTLH: ComponentTools
  Last updated: 10/16/2019
}

{
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~TCheckListBox~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CheckListBoxCheckCount              - Returns count of checked entrys
CheckListBoxReturnRandomChecked     - Returns random checked item-index
CheckListBoxReturnCheckedIndex      - Returns itemindex of checked item
CheckListBoxReturnSelectedIndex     - Returns itemindex of selected item

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~TListBox~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ListBoxUnselectAll                  - UnSelect all Items
ListBoxSelectIndex                  - Select specific Item
AddHorizontalScrollbar              - Add Horizontal Scrollbars to TListBox/TDirectoryListBox & TFileListBox

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Other~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
WinControlColor                     - Change TTrackBar BackgroundColor (only unThemed)
TopControlAtPos                     - Return TopMost TControl for given ClientCoordinates
ClassIsOrIsDescendent               - Returns true is Class is of type ClassName or is descended of it
ComponentIsOnClass                  - Returns the ParentComponent of ClassType 'ClassName' for given Component if there is one
ControlHasClassOnIt                 - Returns the ChildComponent of ClassType 'ClassName' for given Component if there is one

ScaledPixelToUnscaledPixel          - Returns unscaled Pixel-Cordinate from Scaled-TImage
ScaleFactorsFromImage               - Returns X/Y scalefactors for Scaled-TImage

SortTMonitors                       - Returns ID-List for TMonitor in logical order (Left->Right & Top->Bottom)

IncDecNumberAsString                - Increase or Decrease Number (Int/Float/Hex) as String starting at given Position

OnKeyPressCheckChar                 - Check if Char is suitable for given type (Signed, Unsigned, Float, Extended, Hex, Date)
OnKeyDownManipulateNumbersViaUpDown - Increase/decrease Numbers with UP/DOWN-Keys depending to CursorPosition

JumpLines                           - Calculate Jump-Lines for Keystone/Capstone
ShowTextPopupMenu                   - Show System-PopupMenu for TextEdits

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~TScrollBox~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Add Scrolling-Events
Add MouseWheel/MouseHWheel-Events (Message, for relay)
Add KeyDown/KeyUp-Events (Message, for relay)

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~TRichEdit/TMemo~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Add Scrolling-Events
Add OnBeforePaste/OnAfterPaste-Events
Add MouseWheel/MouseHWheel-Events (Message, for relay)
Add KeyDown/KeyUp-Events (Message, for relay)
Add FirstVisibleLine/LastVisibleLine/CurrentLine-Propertys
Add TextPopupMenu-Property

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~TEdit/TLabeledEdit~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Add OnBeforePaste/OnAfterPaste-Events
Add KeyDown/KeyUp-Events (Message, for relay)

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~TSynEdit~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Add VCLStyle-Property (CompilerVersion >= 30)
Add TextPopupMenu-Property
Add HighlightMatchingBrackets-Property
}

{$IFNDEF TLH_OMIT_SECTIONS}
unit uTLH.ComponentTools;

{$I uTLH.inc}

interface

uses
  CheckLst, StdCtrls, Classes, Graphics, Controls, ComCtrls, Types, ExtCtrls, Forms, Messages,
  Windows, Menus
  {$IFDEF SynEdit}
    ,SynEdit
    ,SynEditTypes
    ,SynEditHighlighter
    ,SynEditSearch
    {$IFNDEF UNICODE},SynUnicode{$ENDIF}
    {$IFDEF SYNEDIT_CUSTOM_TEXTPOPUP},ActnList{$ENDIF}
    {$IF Defined( SynEdit_VCLStyles ) AND ( CompilerVersion >= 30 )},Themes{$IFEND}
  {$ENDIF}
  ;
{$ENDIF TLH_OMIT_SECTIONS}

{$WARN UNIT_PLATFORM OFF}
{$WARN GARBAGE OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_CAST OFF}
{$WARN UNSAFE_TYPE OFF}

{$IF CompilerVersion >= 22}
  {$LEGACYIFEND ON}
{$IFEND}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
{$IF NOT Defined(TLH_IMPLEMENTATIONSECTION) AND NOT Defined(TLH_INITIALIZATIONSECTION) AND NOT Defined(TLH_FINALIZATIONSECTION)}

{$IF NOT Declared( WM_MOUSEHWHEEL )}
const
  WM_MOUSEHWHEEL = $020E;
{$IFEND}

type
  TCTScrollEvent      = procedure( Sender : TObject; ScrollCode : SmallInt ) of object;
  TWMScrollEvent      = procedure( Sender : TObject; Msg : TWMScroll ) of object;
  TCNNotifyEvent      = procedure( Sender : TObject; Msg : TWMNotify ) of object;
  TMouseWheelEventMsg = procedure( Sender : TObject; Msg : TWMMouseWheel ) of object;
  TKeyEvent           = procedure( Sender : TObject; Msg : TMessage ) of object;
  TBeforePasteEvent   = procedure( Sender: TObject; var s: String; var StopPaste : boolean ) of object;

  TScrollBox = Class( Forms.TScrollBox )
    procedure WMHScroll( var Message: TWMScroll ); message WM_HSCROLL;
    procedure WMVScroll( var Message: TWMScroll ); message WM_VSCROLL;
    procedure WMMouseWheel( var Message: TWMMouseWheel ); message WM_MOUSEWHEEL;
    procedure WMMouseHWheel( var Message: TWMMouseWheel ); message WM_MOUSEHWHEEL;
    procedure WMKeyDown( var Message: TMessage ); message WM_KEYDOWN;
    procedure WMKeyUp( var Message: TMessage ); message WM_KEYUP;
  private
    FOnScrollVert     : TCTScrollEvent;
    FOnScrollHorz     : TCTScrollEvent;
    FOnWMScrollVert   : TWMScrollEvent;
    FOnWMScrollHorz   : TWMScrollEvent;
    FOnMouseWheelVert : TMouseWheelEventMsg;
    FOnMouseWheelHorz : TMouseWheelEventMsg;
    FOnKeyDownMsg     : TKeyEvent;
    FOnKeyUpMsg       : TKeyEvent;
  public
    Property  OnScrollVertical       : TCTScrollEvent      read FOnScrollVert       write FonScrollVert;
    Property  OnScrollHorizontal     : TCTScrollEvent      read FOnScrollHorz       write FonScrollHorz;
    Property  OnWMScrollVertical     : TWMScrollEvent      read FOnWMScrollVert     write FOnWMScrollVert;
    Property  OnWMScrollHorizontal   : TWMScrollEvent      read FOnWMScrollHorz     write FOnWMScrollHorz;
    Property  OnMouseWheelVertical   : TMouseWheelEventMsg read FOnMouseWheelVert   write FOnMouseWheelVert;
    Property  OnMouseWheelHorizontal : TMouseWheelEventMsg read FOnMouseWheelHorz   write FOnMouseWheelHorz;
    Property  OnKeyDownMsg           : TKeyEvent           read FOnKeyDownMsg       write FOnKeyDownMsg;
    Property  OnKeyUpMsg             : TKeyEvent           read FOnKeyUpMsg         write FOnKeyUpMsg;
  end;

  TEdit = class( StdCtrls.TEdit ) 
  private
    FOnBeforePaste    : TBeforePasteEvent;
    FOnAfterPaste     : TNotifyEvent;
    FOnKeyDownMsg     : TKeyEvent;
    FOnKeyUpMsg       : TKeyEvent;
    FOnScrollVert     : TCTScrollEvent;
    FOnScrollHorz     : TCTScrollEvent;
    FOnWMScrollVert   : TWMScrollEvent;
    FOnWMScrollHorz   : TWMScrollEvent;
    FOnMouseWheelVert : TMouseWheelEventMsg;
    FOnMouseWheelHorz : TMouseWheelEventMsg;
    procedure WMHScroll( var Message: TWMScroll ); message WM_HSCROLL;
    procedure WMVScroll( var Message: TWMScroll ); message WM_VSCROLL;
    procedure WMMouseWheel( var Message: TWMMouseWheel ); message WM_MOUSEWHEEL;
    procedure WMMouseHWheel( var Message: TWMMouseWheel ); message WM_MOUSEHWHEEL;
    procedure WMPaste( var Message: TMessage ); message WM_PASTE;
    procedure WMKeyDown( var Message: TMessage ); message WM_KEYDOWN;
    procedure WMKeyUp( var Message: TMessage ); message WM_KEYUP;
  protected
  public
  published
    Property  OnScrollVertical       : TCTScrollEvent      read FOnScrollVert       write FonScrollVert;
    Property  OnScrollHorizontal     : TCTScrollEvent      read FOnScrollHorz       write FonScrollHorz;
    Property  OnWMScrollVertical     : TWMScrollEvent      read FOnWMScrollVert     write FOnWMScrollVert;
    Property  OnWMScrollHorizontal   : TWMScrollEvent      read FOnWMScrollHorz     write FOnWMScrollHorz;
    Property  OnMouseWheelVertical   : TMouseWheelEventMsg read FOnMouseWheelVert   write FOnMouseWheelVert;
    Property  OnMouseWheelHorizontal : TMouseWheelEventMsg read FOnMouseWheelHorz   write FOnMouseWheelHorz;
    property  OnBeforePaste          : TBeforePasteEvent   read FOnBeforePaste      write FOnBeforePaste;
    property  OnAfterPaste           : TNotifyEvent        read FOnAfterPaste       write FOnAfterPaste;
    Property  OnKeyDownMsg           : TKeyEvent           read FOnKeyDownMsg       write FOnKeyDownMsg;
    Property  OnKeyUpMsg             : TKeyEvent           read FOnKeyUpMsg         write FOnKeyUpMsg;
  end;

  TLabeledEdit = class( ExtCtrls.TLabeledEdit )
  private
    FOnBeforePaste    : TBeforePasteEvent;
    FOnAfterPaste     : TNotifyEvent;
    FOnKeyDownMsg     : TKeyEvent;
    FOnKeyUpMsg       : TKeyEvent;
    FOnScrollVert     : TCTScrollEvent;
    FOnScrollHorz     : TCTScrollEvent;
    FOnWMScrollVert   : TWMScrollEvent;
    FOnWMScrollHorz   : TWMScrollEvent;
    FOnMouseWheelVert : TMouseWheelEventMsg;
    FOnMouseWheelHorz : TMouseWheelEventMsg;    
    procedure WMHScroll( var Message: TWMScroll ); message WM_HSCROLL;
    procedure WMVScroll( var Message: TWMScroll ); message WM_VSCROLL;
    procedure WMMouseWheel( var Message: TWMMouseWheel ); message WM_MOUSEWHEEL;
    procedure WMMouseHWheel( var Message: TWMMouseWheel ); message WM_MOUSEHWHEEL;
    procedure WMPaste( var Message: TMessage ); message WM_PASTE;
    procedure WMKeyDown( var Message: TMessage ); message WM_KEYDOWN;
    procedure WMKeyUp( var Message: TMessage ); message WM_KEYUP;
  protected
  public
  published
    Property  OnScrollVertical       : TCTScrollEvent      read FOnScrollVert       write FonScrollVert;
    Property  OnScrollHorizontal     : TCTScrollEvent      read FOnScrollHorz       write FonScrollHorz;
    Property  OnWMScrollVertical     : TWMScrollEvent      read FOnWMScrollVert     write FOnWMScrollVert;
    Property  OnWMScrollHorizontal   : TWMScrollEvent      read FOnWMScrollHorz     write FOnWMScrollHorz;
    Property  OnMouseWheelVertical   : TMouseWheelEventMsg read FOnMouseWheelVert   write FOnMouseWheelVert;
    Property  OnMouseWheelHorizontal : TMouseWheelEventMsg read FOnMouseWheelHorz   write FOnMouseWheelHorz;
    property  OnBeforePaste          : TBeforePasteEvent   read FOnBeforePaste      write FOnBeforePaste;
    property  OnAfterPaste           : TNotifyEvent        read FOnAfterPaste       write FOnAfterPaste;
    Property  OnKeyDownMsg           : TKeyEvent           read FOnKeyDownMsg       write FOnKeyDownMsg;
    Property  OnKeyUpMsg             : TKeyEvent           read FOnKeyUpMsg         write FOnKeyUpMsg;
  end;

  TRichEdit = class( ComCtrls.TRichEdit )
  private
    FOnBeforePaste    : TBeforePasteEvent;
    FOnAfterPaste     : TNotifyEvent;
    FOnScrollVert     : TCTScrollEvent;
    FOnScrollHorz     : TCTScrollEvent;
    FOnWMScrollVert   : TWMScrollEvent;
    FOnWMScrollHorz   : TWMScrollEvent;
    FOnMouseWheelVert : TMouseWheelEventMsg;
    FOnMouseWheelHorz : TMouseWheelEventMsg;
    FOnCNNotify       : TCNNotifyEvent;
    FOnKeyDownMsg     : TKeyEvent;
    FOnKeyUpMsg       : TKeyEvent;
    fTextPopupMenu    : Boolean;
    fPasteAsPlainText : Boolean;
    procedure WMHScroll( var Message: TWMScroll ); message WM_HSCROLL;
    procedure WMVScroll( var Message: TWMScroll ); message WM_VSCROLL;
    procedure WMMouseWheel( var Message: TWMMouseWheel ); message WM_MOUSEWHEEL;
    procedure WMMouseHWheel( var Message: TWMMouseWheel ); message WM_MOUSEHWHEEL;
    procedure WMPaste( var Message: TMessage ); message WM_PASTE;
    procedure WMKeyDown( var Message: TMessage ); message WM_KEYDOWN;
    procedure WMKeyUp( var Message: TMessage ); message WM_KEYUP;
    procedure CNNotify( var Message: TWMNotify ); message CN_NOTIFY;
    function  GetFirstVisibleLine : LRESULT;
    procedure SetFirstVisibleLine( Line : LRESULT );
    function  GetLastVisibleLine : LRESULT;
    function  GetCurrentLine : LRESULT;
  protected
    procedure DoContextPopup( MousePos: TPoint; var Handled: Boolean ); override;
  public
    procedure ScrollToText( sText : string );
    constructor Create( AOwner: TComponent ); override;
    procedure   PasteFromClipboardAsPlainText;
  published
    property  OnBeforePaste          : TBeforePasteEvent   read FOnBeforePaste      write FOnBeforePaste;
    property  OnAfterPaste           : TNotifyEvent        read FOnAfterPaste       write FOnAfterPaste;
    Property  OnScrollVertical       : TCTScrollEvent      read FOnScrollVert       write FonScrollVert;
    Property  OnScrollHorizontal     : TCTScrollEvent      read FOnScrollHorz       write FonScrollHorz;
    Property  OnWMScrollVertical     : TWMScrollEvent      read FOnWMScrollVert     write FOnWMScrollVert;
    Property  OnWMScrollHorizontal   : TWMScrollEvent      read FOnWMScrollHorz     write FOnWMScrollHorz;
    Property  OnMouseWheelVertical   : TMouseWheelEventMsg read FOnMouseWheelVert   write FOnMouseWheelVert;
    Property  OnMouseWheelHorizontal : TMouseWheelEventMsg read FOnMouseWheelHorz   write FOnMouseWheelHorz;
    Property  OnKeyDownMsg           : TKeyEvent           read FOnKeyDownMsg       write FOnKeyDownMsg;
    Property  OnKeyUpMsg             : TKeyEvent           read FOnKeyUpMsg         write FOnKeyUpMsg;
    Property  OnCNNotify             : TCNNotifyEvent      read FOnCNNotify         write FOnCNNotify;
    property  FirstVisibleLine       : LRESULT             read GetFirstVisibleLine write SetFirstVisibleLine;
    property  LastVisibleLine        : LRESULT             read GetLastVisibleLine;
    property  CurrentLine            : LRESULT             read GetCurrentLine;
    property  TextPopupMenu          : boolean             read fTextPopupMenu      write fTextPopupMenu;
    property  PasteAsPlainText       : boolean             read fPasteAsPlainText   write fPasteAsPlainText;
  end;

  TMemo = class( StdCtrls.TMemo )
  private
    FOnBeforePaste    : TBeforePasteEvent;
    FOnAfterPaste     : TNotifyEvent;
    FOnScrollVert     : TCTScrollEvent;
    FOnScrollHorz     : TCTScrollEvent;
    FOnWMScrollVert   : TWMScrollEvent;
    FOnWMScrollHorz   : TWMScrollEvent;
    FOnMouseWheelVert : TMouseWheelEventMsg;
    FOnMouseWheelHorz : TMouseWheelEventMsg;
    FOnCNNotify       : TCNNotifyEvent;
    FOnKeyDownMsg     : TKeyEvent;
    FOnKeyUpMsg       : TKeyEvent;
    procedure WMHScroll( var Message: TWMScroll ); message WM_HSCROLL;
    procedure WMVScroll( var Message: TWMScroll ); message WM_VSCROLL;
    procedure WMMouseWheel( var Message: TWMMouseWheel ); message WM_MOUSEWHEEL;
    procedure WMMouseHWheel( var Message: TWMMouseWheel ); message WM_MOUSEHWHEEL;
    procedure WMPaste( var Message: TMessage ); message WM_PASTE;
    procedure WMKeyDown( var Message: TMessage ); message WM_KEYDOWN;
    procedure WMKeyUp( var Message: TMessage ); message WM_KEYUP;
    procedure CNNotify( var Message: TWMNotify ); message CN_NOTIFY;
    function  GetFirstVisibleLine : LRESULT;
    procedure SetFirstVisibleLine( Line : LRESULT );
    function  GetLastVisibleLine : LRESULT;
    function  GetCurrentLine : LRESULT;
  protected
  public
  published
    property  OnBeforePaste          : TBeforePasteEvent   read FOnBeforePaste      write FOnBeforePaste;
    property  OnAfterPaste           : TNotifyEvent        read FOnAfterPaste       write FOnAfterPaste;
    Property  OnScrollVertical       : TCTScrollEvent      read FOnScrollVert       write FonScrollVert;
    Property  OnScrollHorizontal     : TCTScrollEvent      read FOnScrollHorz       write FonScrollHorz;
    Property  OnWMScrollVertical     : TWMScrollEvent      read FOnWMScrollVert     write FOnWMScrollVert;
    Property  OnWMScrollHorizontal   : TWMScrollEvent      read FOnWMScrollHorz     write FOnWMScrollHorz;
    Property  OnMouseWheelVertical   : TMouseWheelEventMsg read FOnMouseWheelVert   write FOnMouseWheelVert;
    Property  OnMouseWheelHorizontal : TMouseWheelEventMsg read FOnMouseWheelHorz   write FOnMouseWheelHorz;
    Property  OnKeyDownMsg           : TKeyEvent           read FOnKeyDownMsg       write FOnKeyDownMsg;
    Property  OnKeyUpMsg             : TKeyEvent           read FOnKeyUpMsg         write FOnKeyUpMsg;
    Property  OnCNNotify             : TCNNotifyEvent      read FOnCNNotify         write FOnCNNotify;
    property  FirstVisibleLine       : LRESULT             read GetFirstVisibleLine write SetFirstVisibleLine;
    property  LastVisibleLine        : LRESULT             read GetLastVisibleLine;
    property  CurrentLine            : LRESULT             read GetCurrentLine;
  end;

  TPageControl = class( ComCtrls.TPageControl )
  published
    property OnDblClick;
  public
    constructor Create(aOwner: TComponent); override;
  end;

  TTabSheet = class( ComCtrls.TTabSheet )
  published
    property OnDblClick;
  end;

  {$IFDEF SynEdit}
  {$IF Defined( SynEdit_VCLStyles ) AND ( CompilerVersion >= 30 )}
  tVCLStyleBackUp = record
    Color                    : TColor;
    FontColor                : TColor;

    GutterGradientEndColor   : TColor;
    GutterGradientStartColor : TColor;
    GutterFontColor          : TColor;
    GutterBorderColor        : TColor;

    ActiveLineColor          : TColor;
  end;
  {$IFEND}

  tBracketInfo = record
    vStart  : TBufferCoord;
    vEnd    : TBufferCoord;
    Bracket : Boolean;
  end;
  tBracketInfos = Array [ 0..1 ] of tBracketInfo;

  TSynEdit = class( SynEdit.TSynEdit )
  private
    {$IFDEF SYNEDIT_CUSTOM_TEXTPOPUP}
    FActnList                             : TActionList;
    FPopupMenu                            : TPopupMenu;
    {$ELSE}
    fTextPopupMenu                        : Boolean;
    {$ENDIF}
    fPopupMenuGutter                      : TPopupMenu;
    fPopupMenuGutterLine                  : Integer;
    fPopupMenuGutterRealLine              : Integer;

    // VCL-Styles
    {$IF Defined( SynEdit_VCLStyles ) AND ( CompilerVersion >= 30 )}
    LStyle                                : TCustomStyleServices;
    fVCLStyles                            : boolean;
    fVCLStyleBackup                       : tVCLStyleBackUp;
    {$IFEND}

    fHighlightMatchingBrackets            : boolean;
    fHighlightMatchingBracketsOnlySymbols : boolean;
    fHighlightMatchingBracketsColorOutFG  : TColor;
    fHighlightMatchingBracketsColorOutBG  : TColor;
    fHighlightMatchingBracketsColorInFG   : TColor;
    fHighlightMatchingBracketsColorInBG   : TColor;
    fHighlightMatchingBracketsResult      : tBracketInfos;
    fHighlightMatchingBracketsNoOutBound  : Boolean;

    {$IFDEF SYNEDIT_CUSTOM_TEXTPOPUP}
    procedure CreateActns;
    procedure FillPopupMenu( APopupMenu : TPopupMenu );
    procedure CutExecute( Sender: TObject );
    procedure CutUpdate( Sender: TObject );
    procedure CopyExecute( Sender: TObject );
    procedure CopyUpdate( Sender: TObject );
    procedure PasteExecute( Sender: TObject );
    procedure PasteUpdate( Sender: TObject );
    procedure DeleteExecute( Sender: TObject );
    procedure DeleteUpdate( Sender: TObject );
    procedure SelectAllExecute( Sender: TObject );
    procedure SelectAllUpdate( Sender: TObject );
    procedure RedoExecute( Sender: TObject );
    procedure RedoUpdate( Sender: TObject );
    procedure UndoExecute( Sender: TObject );
    procedure UndoUpdate( Sender: TObject );
    procedure SetPopupMenu_( const Value: TPopupMenu );
    function  GetPopupMenu_: TPopupMenu;
    {$ENDIF}
    // HighLight
    procedure SearchMatchingBrackets;
    procedure DoHighlightMatchingBrackets( TransientType: TTransientType );
    procedure SetHighlightMatchingBrackets( Value : boolean );
    // VCL-Styles
    {$IF Defined( SynEdit_VCLStyles ) AND ( CompilerVersion >= 30 )}
    procedure UpdateStyle;
    procedure SetVCLStyles( value : boolean );
    procedure VCLStylesBackup( Restore : boolean );
    {$IFEND}

    function GetSelStartLine : Integer;
    function GetSelEndLine : Integer;
  protected
    // VCL-Styles
    {$IF Defined( SynEdit_VCLStyles ) AND ( CompilerVersion >= 30 )}
     procedure CMSTYLECHANGED( var Message:TMessage );message CM_STYLECHANGED;
     procedure Loaded; override;
    {$IFEND}
    // Highlight
    procedure DoOnStatusChange( Changes: TSynStatusChanges ); override;
    procedure DoOnPaintTransientEx( TransientType: TTransientType; Lock: Boolean ); override;
    {$IFNDEF SYNEDIT_CUSTOM_TEXTPOPUP}
    procedure DoContextPopup( MousePos: TPoint; var Handled: Boolean ); override;
    {$ENDIF}
  public
    constructor Create( AOwner: TComponent ); override;
    destructor  Destroy; override;
    procedure SetSelTextPrimitiveEx(PasteMode: TSynSelectionMode; Value: PWideChar; AddToUndoList: Boolean);    
  published
    {$IFDEF SYNEDIT_CUSTOM_TEXTPOPUP}
    property  PopupMenu                            : TPopupMenu read GetPopupMenu_                         write SetPopupMenu_;
    {$ELSE}
    property  TextPopupMenu                        : boolean    read fTextPopupMenu                        write fTextPopupMenu;
    {$ENDIF}
    property  PopupMenuGutter                      : TPopupMenu read fPopupMenuGutter                      write fPopupMenuGutter;
    property  PopupMenuGutterLine                  : Integer    read fPopupMenuGutterLine;
    property  PopupMenuGutterRealLine              : Integer    read fPopupMenuGutterRealLine;

    {$IF Defined( SynEdit_VCLStyles ) AND ( CompilerVersion >= 30 )}
    property  VCLStyles                            : boolean    read fVCLStyles                            write SetVCLStyles;
    {$IFEND}

    property  HighlightMatchingBrackets            : boolean    read fHighlightMatchingBrackets            write SetHighlightMatchingBrackets;
    property  HighlightMatchingBracketsOnlySymbols : boolean    read fHighlightMatchingBracketsOnlySymbols write fHighlightMatchingBracketsOnlySymbols;
    property  HighlightMatchingBracketsColorOutFG  : TColor     read fHighlightMatchingBracketsColorOutFG  write fHighlightMatchingBracketsColorOutFG;
    property  HighlightMatchingBracketsColorOutBG  : TColor     read fHighlightMatchingBracketsColorOutBG  write fHighlightMatchingBracketsColorOutBG;
    property  HighlightMatchingBracketsColorInFG   : TColor     read fHighlightMatchingBracketsColorInFG   write fHighlightMatchingBracketsColorInFG;
    property  HighlightMatchingBracketsColorInBG   : TColor     read fHighlightMatchingBracketsColorInBG   write fHighlightMatchingBracketsColorInBG;
    property  HighlightMatchingBracketsNoOutBound  : Boolean    read fHighlightMatchingBracketsNoOutBound  write fHighlightMatchingBracketsNoOutBound;
    property  SelStartLine                         : Integer    read GetSelStartLine;
    property  SelEndLine                           : Integer    read GetSelEndLine;
  end;

  TSynMatchTextHighlighterPlugin = class( TSynEditPlugin )
  private
    FAttribute  : TSynHighlighterAttributes;
    fEnabled    : Boolean;
    fFrameColor : TColor;
    fEngine     : TSynEditSearch;
  protected
    procedure  AfterPaint( ACanvas: TCanvas; const AClip: TRect; FirstLine, LastLine: Integer ); override;
    // VCL-Styles
    {$IF Defined( SynEdit_VCLStyles ) AND ( CompilerVersion >= 30 )}
     procedure CMSTYLECHANGED( var Message:TMessage );message CM_STYLECHANGED;
    {$IFEND}
  public
    procedure  AfterConstruction; override;
    destructor Destroy; override;
    property   Attribute               : TSynHighlighterAttributes read FAttribute               write FAttribute;
    property   Enabled                 : Boolean                   read fEnabled                 write fEnabled;
    property   FrameColor              : TColor                    read fFrameColor              write fFrameColor;
    property   SearchEngine            : TSynEditSearch            read fEngine                  write fEngine;
  end;  
  {$ENDIF}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// TCheckListBox
function CheckListBoxCheckCount( ChkListBox : TCheckListBox ): Integer;
function CheckListBoxSelectCount( ChkListBox : TCheckListBox ): Integer;
function CheckListBoxReturnRandomChecked( ChkListBox : TCheckListBox ): Integer;
function CheckListBoxReturnCheckedIndex( ChkListBox : TCheckListBox; index : integer ): Integer;
function CheckListBoxReturnSelectedIndex( ChkListBox : TCheckListBox; index : integer ): Integer;

//TListBox
procedure ListBoxUnselectAll( lst : TListBox );
procedure ListBoxSelectIndex( lst : TListBox; Index : integer );

procedure AddHorizontalScrollbar( Lst : TCustomListBox );

// Other
procedure WinControlColor( Comp : TComponent; Color : TColor );
function TopControlAtPos( StartCtrl : TWinControl; ClientCords : TPoint ) : TControl;
function ClassIsOrIsDescendent( comp : TObject; Name : string ) : boolean;

function ComponentIsOnClass( c : TComponent; ClassName : string ) : TComponent; overload;
function ComponentIsOnClass( c : TComponent; ClassName : TClass ) : TComponent; overload;
function ControlHasClassOnIt( c : TWinControl; ClassName : string ) : TComponent; overload;
function ControlHasClassOnIt( c : TWinControl; ClassName : TClass ) : TComponent; overload;

procedure ScaledPixelToUnscaledPixel( Sender : TImage; var P : TPoint );
procedure ScaleFactorsFromImage( Sender : TImage; var X, Y : Double );
procedure SortTMonitors( var OrderedByIDs : TByteDynArray; Primary : PByte = nil );

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
type
  TOnKeyPressMode = ( kpmString, kpmSigned, kpmUnsigned, kpmFloat, kpmFloatUnsigned, kpmExtended, kpmExtendedUnsigned, kpmDateTime, kpmHex, kpmHexBigEndian, kpmDirectoryOrFileName, kpmAlpha, kpmAlphaNumeric );
procedure OnKeyPressCheckChar( Sender: TObject; var Key: Char; vMode : TOnKeyPressMode );
procedure OnKeyDownManipulateNumbersViaUpDown( Sender: TObject; var Key: Word; Shift: TShiftState; vMode : TOnKeyPressMode );

function IncDecNumberAsString( Text : string; vMode : TOnKeyPressMode; var Position : Integer; Increase : boolean = True ) : string;
{$IFNDEF STANDALONE}
function ShiftStateToKeys( AShiftState: TShiftState ): Word;
{$ENDIF}
function ShowTextPopupMenu( Handle : THandle; MousePosClient: TPoint; CanUndo, ReadOnly, HasSelText, HasText : boolean; BiDiMode : TBiDiMode ) : Cardinal;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
type
  tJumpLine = record
    Line        : Integer;
    Destination : Integer;
    Offset      : Byte;
    Broken      : Boolean;
    Intersected : Boolean;
  end;
  tJumpLines = Array of tJumpLine;

function JumpLines( Code, Offsets : {$IFNDEF UNICODE}{$IFDEF SynEdit}TUnicodeStrings{$ELSE}TStrings{$ENDIF}{$ELSE}TStrings{$ENDIF}; var JumpLines : tJumpLines ) : boolean;

{$IFEND TLH_IMPLEMENTATIONSECTION}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
{$IFNDEF TLH_OMIT_SECTIONS}
implementation

uses
  Math, Clipbrd, SysUtils, RichEdit,
  Grids,
  StrUtils{OnKeyDownManipulateNumbersViaUpDown},
  TypInfo{OnKeyPressCheckChar}
  {$IFDEF SynEdit}
  ,SynEditMiscClasses
  {$ENDIF}
  ;
{$ENDIF TLH_OMIT_SECTIONS}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
{$IF NOT Defined( TLH_INTERFACESECTION ) AND NOT Defined( TLH_INITIALIZATIONSECTION ) AND NOT Defined( TLH_FINALIZATIONSECTION )}
// TCheckListBox
function CheckListBoxCheckCount( ChkListBox : TCheckListBox ): Integer;
var
  i : integer;
begin
  result := 0;

  for i := 0 to ChkListBox.Items.Count-1 do
    if ChkListBox.Checked[ i ] then
      Inc( result );
end;

function CheckListBoxSelectCount( ChkListBox : TCheckListBox ): Integer;
var
  i : integer;
begin
  result := 0;

  for i := 0 to ChkListBox.Items.Count-1 do
    if ChkListBox.Selected[ i ] then
      Inc( result );
end;

function CheckListBoxReturnRandomChecked( ChkListBox : TCheckListBox ): Integer;
var
  No   : integer;
  i, j : integer;
begin
  Result := -1;
  if ( CheckListBoxCheckCount( ChkListBox ) < 1 ) then
    Exit;

  No := RandomRange( 1, CheckListBoxCheckCount( ChkListBox ) );
  j := 0;
  for i := 0 to ChkListBox.Items.Count-1 do
    begin
    if ChkListBox.Checked[ i ] then
      Inc( j );

    if ( No = j ) then
      begin
      result := i;
      break;
      end;
    end;
end;

function CheckListBoxReturnCheckedIndex( ChkListBox : TCheckListBox; index : integer ): Integer;
var
  i, j : integer;
begin
  Result := -1;
  if ( CheckListBoxCheckCount( ChkListBox ) < 1 ) then
    Exit;

  index := Min( index, CheckListBoxCheckCount( ChkListBox )-1 );
  j := 0;
  for i := 0 to ChkListBox.Items.Count-1 do
    begin
    if ChkListBox.Checked[ i ] then
      begin
      if ( index = j ) then
        begin
        result := i;
        break;
        end;
      Inc( j );
      end;
    end;
end;

function CheckListBoxReturnSelectedIndex( ChkListBox : TCheckListBox; index : integer ): Integer;
var
  i, j : integer;
begin
  Result := -1;
  if ( CheckListBoxSelectCount( ChkListBox ) < 1 ) then
    Exit;

  index := Min( index, CheckListBoxSelectCount( ChkListBox )-1 );
  j := 0;
  for i := 0 to ChkListBox.Items.Count-1 do
    begin
    if ChkListBox.Selected[ i ] then
      begin
      if ( index = j ) then
        begin
        result := i;
        break;
        end;
      Inc( j );
      end;
    end;
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure ListBoxUnselectAll( lst : TListBox );
var
  i : integer;
begin
  for i := 0 to lst.Items.Count-1 do
    lst.Selected[ i ] := false;
end;

procedure ListBoxSelectIndex( lst : TListBox; Index : integer );
begin
  ListBoxUnselectAll( lst );

  if ( index < 0 ) OR ( index > lst.Items.Count-1 ) then
    Exit;

  lst.Selected[ index ] := True;
end;

procedure AddHorizontalScrollbar( Lst : TCustomListBox );
var
  i, MaxWidth : Integer;
begin
  if NOT Assigned( Lst ) then
    Exit;

  MaxWidth := Lst.Width-1;
  for i := 0 to Lst.Count-1 do
    MaxWidth := Max( MaxWidth, Lst.Canvas.TextWidth( Lst.Items[ i ] ) );

  if ( MaxWidth = Lst.Width-1 ) then
    Lst.Perform( LB_SETHORIZONTALEXTENT, 0, 0 )
  else
    Lst.Perform( LB_SETHORIZONTALEXTENT, MaxWidth+4, 0 );  
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// TScrollBox
procedure TScrollBox.WMHScroll( var Message: TWMHScroll );
begin
  inherited;
  if Assigned( FOnWMScrollHorz ) then
    FOnWMScrollHorz( Self, Message );
  if Assigned( FOnScrollHorz ) then
    FOnScrollHorz( Self, Message.ScrollCode );
end;

procedure TScrollBox.WMVScroll( var Message: TWMVScroll );
begin
  inherited;
  if Assigned( FOnWMScrollVert ) then
    FOnWMScrollVert( Self, Message );
  if Assigned( FOnScrollVert ) then
    FOnScrollVert( Self, Message.ScrollCode );
end;

procedure TScrollBox.WMMouseHWheel( var Message: TWMMouseWheel );
begin
  inherited;
  // Workaround for : https://code.google.com/p/dscintilla/issues/detail?id=5
  //
  // TControl.WMMouseWheel changes WM_MOUSEWHEEL parameters,
  // but doesn't revert then when passing message down.
  //
  // As a workaround try to revert damage done by TControl.WMMouseWheel:
  //   TCMMouseWheel( Message ).ShiftState := KeysToShiftState( Message.Keys );
  // Message might not be complete, because of missing MK_XBUTTON1/MK_XBUTTON2
  // flags, however Scintilla doesn't use them as of today.
  Message.Keys := ShiftStateToKeys( TCMMouseWheel( Message ).ShiftState );

  if Assigned( FOnMouseWheelHorz ) then
    FOnMouseWheelHorz( Self, Message );
end;

procedure TScrollBox.WMMouseWheel( var Message: TWMMouseWheel );
begin
  inherited;
  // Workaround for : https://code.google.com/p/dscintilla/issues/detail?id=5
  //
  // TControl.WMMouseWheel changes WM_MOUSEWHEEL parameters,
  // but doesn't revert then when passing message down.
  //
  // As a workaround try to revert damage done by TControl.WMMouseWheel:
  //   TCMMouseWheel( Message ).ShiftState := KeysToShiftState( Message.Keys );
  // Message might not be complete, because of missing MK_XBUTTON1/MK_XBUTTON2
  // flags, however Scintilla doesn't use them as of today.
  Message.Keys := ShiftStateToKeys( TCMMouseWheel( Message ).ShiftState );

  if Assigned( FOnMouseWheelVert ) then
    FOnMouseWheelVert( Self, Message );
end;

procedure TScrollBox.WMKeyDown( var Message: TMessage );
begin
  if Assigned( FOnKeyDownMsg ) then
    FOnKeyDownMsg( Self, Message );
  inherited;
end;

procedure TScrollBox.WMKeyUp( var Message: TMessage );
begin
  if Assigned( FOnKeyUpMsg ) then
    FOnKeyUpMsg( Self, Message );
  inherited;
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// TEdit/LabeledEdit/RichEdit/Memo
procedure TEdit.WMHScroll( var Message: TWMHScroll );
begin
  inherited;
  if Assigned( FOnWMScrollHorz ) then
    FOnWMScrollHorz( Self, Message );
  if Assigned( FOnScrollHorz ) then
    FOnScrollHorz( Self, Message.ScrollCode );
end;

procedure TEdit.WMVScroll( var Message: TWMVScroll );
begin
  inherited;
  if Assigned( FOnWMScrollVert ) then
    FOnWMScrollVert( Self, Message );
  if Assigned( FOnScrollVert ) then
    FOnScrollVert( Self, Message.ScrollCode );
end;

procedure TEdit.WMMouseHWheel( var Message: TWMMouseWheel );
begin
  inherited;
  // Workaround for : https://code.google.com/p/dscintilla/issues/detail?id=5
  //
  // TControl.WMMouseWheel changes WM_MOUSEWHEEL parameters,
  // but doesn't revert then when passing message down.
  //
  // As a workaround try to revert damage done by TControl.WMMouseWheel:
  //   TCMMouseWheel( Message ).ShiftState := KeysToShiftState( Message.Keys );
  // Message might not be complete, because of missing MK_XBUTTON1/MK_XBUTTON2
  // flags, however Scintilla doesn't use them as of today.
  Message.Keys := ShiftStateToKeys( TCMMouseWheel( Message ).ShiftState );

  if Assigned( FOnMouseWheelHorz ) then
    FOnMouseWheelHorz( Self, Message );
end;

procedure TEdit.WMMouseWheel( var Message: TWMMouseWheel );
begin
  inherited;
  // Workaround for : https://code.google.com/p/dscintilla/issues/detail?id=5
  //
  // TControl.WMMouseWheel changes WM_MOUSEWHEEL parameters,
  // but doesn't revert then when passing message down.
  //
  // As a workaround try to revert damage done by TControl.WMMouseWheel:
  //   TCMMouseWheel( Message ).ShiftState := KeysToShiftState( Message.Keys );
  // Message might not be complete, because of missing MK_XBUTTON1/MK_XBUTTON2
  // flags, however Scintilla doesn't use them as of today.
  Message.Keys := ShiftStateToKeys( TCMMouseWheel( Message ).ShiftState );

  if Assigned( FOnMouseWheelVert ) then
    FOnMouseWheelVert( Self, Message );
end;

procedure TEdit.WMPaste( var Message: TMessage );
var
  sOrg,
  sVar  : String;
  sRes  : boolean;
  Stop  : Boolean;
begin
  sRes := false;
  Stop := False;
  if Assigned( FOnBeforePaste ) and ( Clipboard.HasFormat( CF_TEXT ) ) then
    begin
    sOrg := ClipBoard.AsText;
    sVar := sOrg;
    FOnBeforePaste( self, sVar, Stop );
    sRes := ( sVar <> sOrg );
    end;

  if STOP then
    begin
    Message.Result := 1;
    Exit;
    end;

  if sRes then
    SetSelTextBuf( PChar( IfThen( sRes, sVar, ClipBoard.AsText ) ) )
  else
    inherited;

  if Assigned( FOnAfterPaste ) then
    FOnAfterPaste( self );
end;

procedure TEdit.WMKeyDown( var Message: TMessage );
begin
  if Assigned( FOnKeyDownMsg ) then
    FOnKeyDownMsg( Self, Message );
  inherited;
end;

procedure TEdit.WMKeyUp( var Message: TMessage );
begin
  if Assigned( FOnKeyUpMsg ) then
    FOnKeyUpMsg( Self, Message );
  inherited;
end;

procedure TLabeledEdit.WMHScroll( var Message: TWMHScroll );
begin
  inherited;
  if Assigned( FOnWMScrollHorz ) then
    FOnWMScrollHorz( Self, Message );
  if Assigned( FOnScrollHorz ) then
    FOnScrollHorz( Self, Message.ScrollCode );
end;

procedure TLabeledEdit.WMVScroll( var Message: TWMVScroll );
begin
  inherited;
  if Assigned( FOnWMScrollVert ) then
    FOnWMScrollVert( Self, Message );
  if Assigned( FOnScrollVert ) then
    FOnScrollVert( Self, Message.ScrollCode );
end;

procedure TLabeledEdit.WMMouseHWheel( var Message: TWMMouseWheel );
begin
  inherited;
  // Workaround for : https://code.google.com/p/dscintilla/issues/detail?id=5
  //
  // TControl.WMMouseWheel changes WM_MOUSEWHEEL parameters,
  // but doesn't revert then when passing message down.
  //
  // As a workaround try to revert damage done by TControl.WMMouseWheel:
  //   TCMMouseWheel( Message ).ShiftState := KeysToShiftState( Message.Keys );
  // Message might not be complete, because of missing MK_XBUTTON1/MK_XBUTTON2
  // flags, however Scintilla doesn't use them as of today.
  Message.Keys := ShiftStateToKeys( TCMMouseWheel( Message ).ShiftState );

  if Assigned( FOnMouseWheelHorz ) then
    FOnMouseWheelHorz( Self, Message );
end;

procedure TLabeledEdit.WMMouseWheel( var Message: TWMMouseWheel );
begin
  inherited;
  // Workaround for : https://code.google.com/p/dscintilla/issues/detail?id=5
  //
  // TControl.WMMouseWheel changes WM_MOUSEWHEEL parameters,
  // but doesn't revert then when passing message down.
  //
  // As a workaround try to revert damage done by TControl.WMMouseWheel:
  //   TCMMouseWheel( Message ).ShiftState := KeysToShiftState( Message.Keys );
  // Message might not be complete, because of missing MK_XBUTTON1/MK_XBUTTON2
  // flags, however Scintilla doesn't use them as of today.
  Message.Keys := ShiftStateToKeys( TCMMouseWheel( Message ).ShiftState );

  if Assigned( FOnMouseWheelVert ) then
    FOnMouseWheelVert( Self, Message );
end;

procedure TLabeledEdit.WMPaste( var Message: TMessage );
var
  sOrg,
  sVar  : String;
  sRes  : boolean;
  Stop  : Boolean;
begin
  sRes := false;
  Stop := False;
  if Assigned( FOnBeforePaste ) and ( Clipboard.HasFormat( CF_TEXT ) ) then
    begin
    sOrg := ClipBoard.AsText;
    sVar := sOrg;
    FOnBeforePaste( self, sVar, Stop );
    sRes := ( sVar <> sOrg );
    end;

  if STOP then
    begin
    Message.Result := 1;
    Exit;
    end;

  if sRes then
    SetSelTextBuf( PChar( IfThen( sRes, sVar, ClipBoard.AsText ) ) )
  else
    inherited;

  if Assigned( FOnAfterPaste ) then
    FOnAfterPaste( self );
end;

procedure TLabeledEdit.WMKeyDown( var Message: TMessage );
begin
  if Assigned( FOnKeyDownMsg ) then
    FOnKeyDownMsg( Self, Message );
  inherited;
end;

procedure TLabeledEdit.WMKeyUp( var Message: TMessage );
begin
  if Assigned( FOnKeyUpMsg ) then
    FOnKeyUpMsg( Self, Message );
  inherited;
end;

procedure TRichEdit.WMPaste( var Message: TMessage );
var
  sOrg,
  sVar  : String;
  sRes  : boolean;
  Stop  : Boolean;
begin
  sRes := false;
  Stop := False;
  if Assigned( FOnBeforePaste ) and ( Clipboard.HasFormat( CF_TEXT ) ) then
    begin
    sOrg := ClipBoard.AsText;
    sVar := sOrg;
    FOnBeforePaste( self, sVar, Stop );
    sRes := ( sVar <> sOrg );
    end;

  if STOP then
    begin
    Message.Result := 1;
    Exit;
    end;

  if ( sRes or fPasteAsPlainText ) and ( Clipboard.HasFormat( CF_TEXT ) ) then
    SetSelTextBuf( PChar( IfThen( sRes, sVar, ClipBoard.AsText ) ) )
  else
    inherited;

  if Assigned( FOnAfterPaste ) then
    FOnAfterPaste( self );
end;

procedure TRichEdit.WMHScroll( var Message: TWMHScroll );
begin
  inherited;
  if Assigned( FOnWMScrollHorz ) then
    FOnWMScrollHorz( Self, Message );
  if Assigned( FOnScrollHorz ) then
    FOnScrollHorz( Self, Message.ScrollCode );
end;

procedure TRichEdit.WMVScroll( var Message: TWMVScroll );
begin
  inherited;
  if Assigned( FOnWMScrollVert ) then
    FOnWMScrollVert( Self, Message );
  if Assigned( FOnScrollVert ) then
    FOnScrollVert( Self, Message.ScrollCode );
end;

procedure TRichEdit.WMMouseHWheel( var Message: TWMMouseWheel );
begin
  inherited;
  // Workaround for : https://code.google.com/p/dscintilla/issues/detail?id=5
  //
  // TControl.WMMouseWheel changes WM_MOUSEWHEEL parameters,
  // but doesn't revert then when passing message down.
  //
  // As a workaround try to revert damage done by TControl.WMMouseWheel:
  //   TCMMouseWheel( Message ).ShiftState := KeysToShiftState( Message.Keys );
  // Message might not be complete, because of missing MK_XBUTTON1/MK_XBUTTON2
  // flags, however Scintilla doesn't use them as of today.
  Message.Keys := ShiftStateToKeys( TCMMouseWheel( Message ).ShiftState );

  if Assigned( FOnMouseWheelHorz ) then
    FOnMouseWheelHorz( Self, Message );
end;

procedure TRichEdit.WMMouseWheel( var Message: TWMMouseWheel );
begin
  inherited;
  // Workaround for : https://code.google.com/p/dscintilla/issues/detail?id=5
  //
  // TControl.WMMouseWheel changes WM_MOUSEWHEEL parameters,
  // but doesn't revert then when passing message down.
  //
  // As a workaround try to revert damage done by TControl.WMMouseWheel:
  //   TCMMouseWheel( Message ).ShiftState := KeysToShiftState( Message.Keys );
  // Message might not be complete, because of missing MK_XBUTTON1/MK_XBUTTON2
  // flags, however Scintilla doesn't use them as of today.
  Message.Keys := ShiftStateToKeys( TCMMouseWheel( Message ).ShiftState );

  if Assigned( FOnMouseWheelVert ) then
    FOnMouseWheelVert( Self, Message );
end;

procedure TRichEdit.CNNotify( var Message: TWMNotify );
begin
  inherited;
  if Assigned( FOnCNNotify ) then
    FOnCNNotify( Self, Message );
end;

procedure TRichEdit.WMKeyDown( var Message: TMessage );
var
  ShiftState : TShiftState;
begin
  if fPasteAsPlainText then
    begin
    ShiftState := KeyDataToShiftState( TWMKey( Message ).KeyData );
    if ( ShiftState = [ ssCtrl ] ) and ( {$IF CompilerVersion >= 22}CharInSet( Char( TWMKey( Message ).CharCode ),{$ELSE}( Char( TWMKey( Message ).CharCode ) in{$IFEND} [ 'V', 'v' ] ) ) then
      begin
      WMPaste( Message );
      Message.Result := 1;
      end;
    end;

  if NOT ( Message.Result = 1 ) then
    begin
    if Assigned( FOnKeyDownMsg ) then
      FOnKeyDownMsg( Self, Message );
    inherited;
    end;
end;

procedure TRichEdit.WMKeyUp( var Message: TMessage );
begin
  if Assigned( FOnKeyUpMsg ) then
    FOnKeyUpMsg( Self, Message );
  inherited;
end;

function TRichEdit.GetFirstVisibleLine : LRESULT;
begin
  result := 0;
  if NOT Assigned( self ) then
    Exit;
  Result := Perform( EM_GETFIRSTVISIBLELINE, 0, 0 );
end;

procedure TRichEdit.SetFirstVisibleLine( Line : LRESULT );
var
  FirstLine : LRESULT;
begin
  if NOT Assigned( self ) then
    Exit;
  FirstLine := Perform( EM_GETFIRSTVISIBLELINE, 0, 0 );
  if ( Line = FirstLine ) then
    Exit;
  Perform( EM_LineScroll, 0, Line - FirstLine );
end;

function TRichEdit.GetLastVisibleLine : LRESULT;
var
  r : TRect;
  i : Integer;
begin
  result := 0;
  if NOT Assigned( self ) then
    Exit;

  Perform( EM_GETRECT, 0, Longint( @r ) ); // The EM_GETRECT message retrieves the formatting rectangle of an edit control.
  r.Left := r.Left + 1;
  r.Top  := r.Bottom - 2;

  i := Perform( EM_CHARFROMPOS, 0, Integer( @r.topleft ) ); // The EM_CHARFROMPOS message retrieves information about the character closest to a specified point in the client area of an edit control
  Result := Perform( EM_EXLINEFROMCHAR, 0, i ); // The EM_EXLINEFROMCHAR message determines which line contains the specified character in a rich edit control
end;

function TRichEdit.GetCurrentLine : LRESULT;
begin
  result := 0;
  if NOT Assigned( self ) then
    Exit;
  result := Perform( em_LineFromChar, $FFFF, 0 );
end;

procedure TRichEdit.ScrollToText( sText : string );
var
  I, L : Integer;
begin
  LockwindowUpdate( Handle );

  //Find KeyWord
  I := FindText( sText, 0, length( text ), [ ] );
  if I > 0 then
    begin
    L := Perform( EM_ExLineFromChar, 0, I );
    Perform( EM_LineScroll, 0, -Lines.Count );
    Perform( EM_LineScroll, 0, L );
    SelStart := I;
    end;
  LockwindowUpdate( 0 );
end;

constructor TRichEdit.Create( AOwner: TComponent );
begin
  inherited;
  fTextPopupMenu   := True;
  PasteAsPlainText := False;
end;

procedure TRichEdit.PasteFromClipboardAsPlainText;
var
  old : Boolean;
begin
  old := fPasteAsPlainText;
  fPasteAsPlainText := True;
  SendMessage( Handle, WM_PASTE, 0, 0 );
  fPasteAsPlainText := old;
end;

procedure TRichEdit.DoContextPopup( MousePos: TPoint; var Handled: Boolean );
const
  IDM_RTL    = $8000; // WM_APP ?
var
  State : TKeyboardState;
  IsCTRL : Boolean;
begin
  inherited;
  if NOT {( NOT ReadOnly ) AND} fTextPopupMenu then
    Exit;

  if Assigned( PopupMenu ) then
    begin
    GetKeyboardState( State );
    IsCTRL := ( ( State[ vk_Control ] And 128 ) <> 0 );
    if IsCTRL then
      Exit;
    end;

  case ShowTextPopupMenu( Handle, MousePos, CanUndo, ReadOnly, ( Length( SelText ) <> 0 ), ( Length( Text ) <> 0 ), BiDiMode ) of
    0         : ;
    WM_UNDO   : Undo;
    WM_CUT    : CutToClipboard;
    WM_COPY   : CopyToClipboard;
    WM_PASTE  : PasteFromClipboard;
    WM_CLEAR  : ClearSelection;
    EM_SETSEL : SelectAll;
    IDM_RTL   : begin
                ParentBiDiMode := false;
                if ( BiDiMode = bdLeftToRight ) then
                  BiDiMode := bdRightToLeft
                else
                  BiDiMode := bdLeftToRight;
                end;
  end;
end;

procedure TMemo.WMPaste( var Message: TMessage );
var
  sOrg,
  sVar  : String;
  sRes  : boolean;
  Stop  : Boolean;
begin
  sRes := false;
  Stop := False;
  if Assigned( FOnBeforePaste ) and ( Clipboard.HasFormat( CF_TEXT ) ) then
    begin
    sOrg := ClipBoard.AsText;
    sVar := sOrg;
    FOnBeforePaste( self, sVar, Stop );
    sRes := ( sVar <> sOrg );
    end;

  if STOP then
    begin
    Message.Result := 1;
    Exit;
    end;

  if sRes then
    SetSelTextBuf( PChar( IfThen( sRes, sVar, ClipBoard.AsText ) ) )
  else
    inherited;

  if Assigned( FOnAfterPaste ) then
    FOnAfterPaste( self );
end;

procedure TMemo.WMHScroll( var Message: TWMHScroll );
begin
  inherited;
  if Assigned( FOnWMScrollHorz ) then
    FOnWMScrollHorz( Self, Message );
  if Assigned( FOnScrollHorz ) then
    FOnScrollHorz( Self, Message.ScrollCode );
end;

procedure TMemo.WMVScroll( var Message: TWMVScroll );
begin
  inherited;
  if Assigned( FOnWMScrollVert ) then
    FOnWMScrollVert( Self, Message );
  if Assigned( FOnScrollVert ) then
    FOnScrollVert( Self, Message.ScrollCode );
end;

procedure TMemo.WMMouseHWheel( var Message: TWMMouseWheel );
begin
  inherited;
  // Workaround for : https://code.google.com/p/dscintilla/issues/detail?id=5
  //
  // TControl.WMMouseWheel changes WM_MOUSEWHEEL parameters,
  // but doesn't revert then when passing message down.
  //
  // As a workaround try to revert damage done by TControl.WMMouseWheel:
  //   TCMMouseWheel( Message ).ShiftState := KeysToShiftState( Message.Keys );
  // Message might not be complete, because of missing MK_XBUTTON1/MK_XBUTTON2
  // flags, however Scintilla doesn't use them as of today.
  Message.Keys := ShiftStateToKeys( TCMMouseWheel( Message ).ShiftState );

  if Assigned( FOnMouseWheelHorz ) then
    FOnMouseWheelHorz( Self, Message );
end;

procedure TMemo.WMMouseWheel( var Message: TWMMouseWheel );
begin
  inherited;
  // Workaround for : https://code.google.com/p/dscintilla/issues/detail?id=5
  //
  // TControl.WMMouseWheel changes WM_MOUSEWHEEL parameters,
  // but doesn't revert then when passing message down.
  //
  // As a workaround try to revert damage done by TControl.WMMouseWheel:
  //   TCMMouseWheel( Message ).ShiftState := KeysToShiftState( Message.Keys );
  // Message might not be complete, because of missing MK_XBUTTON1/MK_XBUTTON2
  // flags, however Scintilla doesn't use them as of today.
  Message.Keys := ShiftStateToKeys( TCMMouseWheel( Message ).ShiftState );

  if Assigned( FOnMouseWheelVert ) then
    FOnMouseWheelVert( Self, Message );
end;

procedure TMemo.CNNotify( var Message: TWMNotify );
begin
  inherited;
  if Assigned( FOnCNNotify ) then
    FOnCNNotify( Self, Message );
end;

procedure TMemo.WMKeyDown( var Message: TMessage );
begin
  if Assigned( FOnKeyDownMsg ) then
    FOnKeyDownMsg( Self, Message );
  inherited;
end;

procedure TMemo.WMKeyUp( var Message: TMessage );
begin
  if Assigned( FOnKeyUpMsg ) then
    FOnKeyUpMsg( Self, Message );
  inherited;
end;

function TMemo.GetFirstVisibleLine : LRESULT;
begin
  result := 0;
  if NOT Assigned( self ) then
    Exit;
  Result := Perform( EM_GETFIRSTVISIBLELINE, 0, 0 );
end;

procedure TMemo.SetFirstVisibleLine( Line : LRESULT );
var
  FirstLine : LRESULT;
begin
  if NOT Assigned( self ) then
    Exit;
  FirstLine := Perform( EM_GETFIRSTVISIBLELINE, 0, 0 );
  if ( Line = FirstLine ) then
    Exit;
  Perform( EM_LineScroll, 0, Line - FirstLine );
end;

function TMemo.GetLastVisibleLine : LRESULT;
const
  EM_EXLINEFROMCHAR = WM_USER + 54;
var
  r : TRect;
  i : Integer;
begin
  result := 0;
  if NOT Assigned( self ) then
    Exit;

  Perform( EM_GETRECT, 0, Longint( @r ) ); // The EM_GETRECT message retrieves the formatting rectangle of an edit control.
  r.Left := r.Left + 1;
  r.Top  := r.Bottom - 2;

  i := Perform( EM_CHARFROMPOS, 0, Integer( @r.topleft ) ); // The EM_CHARFROMPOS message retrieves information about the character closest to a specified point in the client area of an edit control
  Result := Perform( EM_EXLINEFROMCHAR, 0, i ); // The EM_EXLINEFROMCHAR message determines which line contains the specified character in a rich edit control
end;

function TMemo.GetCurrentLine : LRESULT;
begin
  result := 0;
  if NOT Assigned( self ) then
    Exit;
  result := Perform( em_LineFromChar, $FFFF, 0 );
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
constructor TPageControl.Create(aOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle + [ csClickEvents ];
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
type
  TColorWinControl = class( TWinControl )
     public
      property Color;
  end;
procedure WinControlColor( Comp : TComponent; Color : TColor );
begin
  if NOT Assigned( Comp ) then
    Exit;
  if NOT ( Comp is TWinControl ) then
    Exit;
  TColorWinControl( Comp ).Color := Color;
  TWinControl( Comp ).Perform( CM_RECREATEWND, 0, 0 );
end;

function TopControlAtPos( StartCtrl : TWinControl; ClientCords : TPoint ) : TControl;
var
  Ctrl : TControl;
  P, P2 : TPoint;
begin
  result := NIL;
  if ( StartCtrl = nil ) then
    Exit;

  P := StartCtrl.ClientToScreen( ClientCords );
  Ctrl := StartCtrl.ControlAtPos( ClientCords, True{AllowDisabled}, True{AllowWinControl} );
  while NOT ( Ctrl = nil ) do
    begin
    result := Ctrl;
    P2 := Ctrl.ScreenToClient( P );
    if ( Ctrl is TWinControl ) then
      Ctrl := TWinControl( Ctrl ).ControlAtPos( P2, True{AllowDisabled}, True{AllowWinControl} )
    else
      break;
    end;
end;

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

function ComponentIsOnClass( c : TComponent; ClassName : string ) : TComponent;
begin
  result := C;
  if ( c = nil ) OR ( ClassName = '' ) then
    Exit;  
  while NOT ( result = nil ) do
    begin
    result := Result.GetParentComponent;
    if ( result = nil ) then
      Break;
    if ( {$IFDEF STANDALONE}SysUtils.{$ENDIF}LowerCase( Result.ClassName ) = {$IFDEF STANDALONE}SysUtils.{$ENDIF}LowerCase( ClassName ) ) then
      break;
    end;
end;

function ComponentIsOnClass( c : TComponent; ClassName : TClass ) : TComponent;
begin
  result := ComponentIsOnClass( c, ClassName.ClassName );
end;

function ControlHasClassOnIt( c : TWinControl; ClassName : string ) : TComponent;
var
  i : Integer;
begin
  result := nil;
  if ( c = nil ) OR ( ClassName = '' ) then
    Exit;

  for i := 0 to C.ControlCount-1 do
    begin
    if ( {$IFDEF STANDALONE}SysUtils.{$ENDIF}LowerCase( C.Controls[ i ].ClassName ) = {$IFDEF STANDALONE}SysUtils.{$ENDIF}LowerCase( ClassName ) ) then
      begin
      result := C.Controls[ i ];
      Break;
      end
    else
      begin
      if ( C.Controls[ i ] is TWinControl ) then
        result := ControlHasClassOnIt( TWinControl( C.Controls[ i ] ), ClassName );
      end;
    end;
end;

function ControlHasClassOnIt( c : TWinControl; ClassName : TClass ) : TComponent;
begin
  result := ControlHasClassOnIt( c, ClassName.ClassName );
end;

procedure ScaledPixelToUnscaledPixel( Sender : TImage; var P : TPoint );
var
  w, h, cw, ch, ox, oy: Integer;
  xyaspect: Double;
begin
//  if NOT ( Sender is TImage ) then
//    Exit;

  w  := Sender.Picture.Width;
  h  := Sender.Picture.Height;
  cw := Sender.ClientWidth;
  ch := Sender.ClientHeight;

  if Sender.Stretch or ( Sender.Proportional and ( ( w > cw ) or ( h > ch ) ) ) then
    begin
    if Sender.Proportional and ( w > 0 ) and ( h > 0 ) then
      begin
      xyaspect := w / h;
      if w > h then
        begin
        w := cw;
        h := Trunc( cw / xyaspect );
        if h > ch then  // woops, too big
          begin
          h := ch;
          w := Trunc( ch * xyaspect );
          end;
        end
      else
        begin
        h := ch;
        w := Trunc( ch * xyaspect );
        if w > cw then  // woops, too big
          begin
          w := cw;
          h := Trunc( cw / xyaspect );
          end;
        end;
      end
    else
      begin
      w := cw;
      h := ch;
      end;
    end;

  oX := 0;
  oY := 0;
  if Sender.Center then
    begin
  	oX := ( cw - w ) div 2;
    oY := ( ch - h ) div 2;
    end;

  P.X := Trunc( ( P.X - oX ) * ( Sender.Picture.Width / w ) );
  P.Y := Trunc( ( P.Y - oY ) * ( Sender.Picture.Height / h ) );
end;

procedure ScaleFactorsFromImage( Sender : TImage; var X, Y : Double );
var
  w, h, cw, ch : Integer;
  xyaspect: Double;
begin
//  if NOT ( Sender is TImage ) then
//    Exit;

  w  := Sender.Picture.Width;
  h  := Sender.Picture.Height;
  cw := Sender.ClientWidth;
  ch := Sender.ClientHeight;

  if Sender.Stretch or ( Sender.Proportional and ( ( w > cw ) or ( h > ch ) ) ) then
    begin
    if Sender.Proportional and ( w > 0 ) and ( h > 0 ) then
      begin
      xyaspect := w / h;
      if w > h then
        begin
        w := cw;
        h := Trunc( cw / xyaspect );
        if h > ch then  // woops, too big
          begin
          h := ch;
          w := Trunc( ch * xyaspect );
          end;
        end
      else
        begin
        h := ch;
        w := Trunc( ch * xyaspect );
        if w > cw then  // woops, too big
          begin
          w := cw;
          h := Trunc( cw / xyaspect );
          end;
        end;
      end
    else
      begin
      w := cw;
      h := ch;
      end;
    end;

  X := ( w / Sender.Picture.Width );
  Y := ( h / Sender.Picture.Height );
end;

procedure SortTMonitors( var OrderedByIDs : TByteDynArray; Primary : PByte = nil );
var
  i, j      : Integer;
  Cnt       : Byte;
  tDisplays : Array of boolean;
  P         : TPoint;
  ID        : Integer;    
begin
  // Sort Displays
  SetLength( OrderedByIDs, Screen.MonitorCount );
  SetLength( tDisplays, Screen.MonitorCount );
  for i := Low( tDisplays ) to High( tDisplays ) do
    tDisplays[ i ] := True;

  Cnt := 0;
  for j := Low( tDisplays ) to High( tDisplays ) do
    begin
    P := Point( High( Integer ), High( Integer ) );
    ID := -1;
    for i := Low( tDisplays ) to High( tDisplays ) do
      begin
      if NOT tDisplays[ i ] then
        Continue;

      if ( Screen.Monitors[ i ].Top < P.Y ) then
        begin
        P.X := Screen.Monitors[ i ].Left;
        P.Y := Screen.Monitors[ i ].Top;
        ID := i;
        end;
      if ( Screen.Monitors[ i ].Left <= P.X ) AND ( Screen.Monitors[ i ].Top <= P.Y ) then
        begin
        P.X := Screen.Monitors[ i ].Left;
        P.Y := Screen.Monitors[ i ].Top;
        ID := i;
        end;
      end;
    if ( ID >= 0 ) then
      begin
      OrderedByIDs[ Cnt ] := ID;
      Inc( Cnt );
      tDisplays[ ID ] := false;
      end;
    end;
  SetLength( tDisplays, 0 );

  if ( Primary <> nil ) then
    begin
    for i := Low( OrderedByIDs ) to High( OrderedByIDs ) do
      begin
      if ( Screen.Monitors[ OrderedByIDs[ i ] ].Primary ) then
        begin
        Primary^ := i;
        break;
        end;
      end;
    end;
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure OnKeyPressCheckChar( Sender: TObject; var Key: Char; vMode : TOnKeyPressMode );
var
  P        : Integer;
  Text     : string;
  SelStart : Integer;
  SelEnd   : Integer;
  DS       : Integer;
begin
  if ( Key = #0 ) then
    Exit;
  if ( vMode = kpmString ) then
    Exit;
  if ( {$IF CompilerVersion >= 22}CharInSet( Key,{$ELSE}( Key in{$IFEND} [ #1{SelectAll}, #3{Copy}, #8{Backspace}, #$16{Paste}, #24{Cut} ] ) ) then
    Exit;

  if ( vMode = kpmDirectoryOrFileName ) then
    begin
    if ( {$IF CompilerVersion >= 22}CharInSet( Key,{$ELSE}( Key in{$IFEND} [ #0..#31, '<', '>', ':', '"', '/', '\', '|', '?', '*' ] ) ) then
      Key := #0;
    Exit;
    end
  else if ( vMode = kpmAlpha ) then
    begin
    if NOT ( {$IF CompilerVersion >= 22}CharInSet( Key,{$ELSE}( Key in{$IFEND} [ 'a'..'z', 'A'..'Z' ] ) ) then
      Key := #0;
    Exit;
    end
  else if ( vMode = kpmAlphaNumeric ) then
    begin
    if NOT ( {$IF CompilerVersion >= 22}CharInSet( Key,{$ELSE}( Key in{$IFEND} [ '0'..'9', 'a'..'z', 'A'..'Z' ] ) ) then
      Key := #0;
    Exit;
    end;

  if ( {$IF CompilerVersion >= 22}CharInSet( Key,{$ELSE}( Key in{$IFEND} [ '1'..'9' ] ) ) then
    Exit;

  Text := '';
  if ( Sender <> nil ) then
    begin
    if IsPublishedProp( Sender, 'caption' ) then
      Text := GetPropValue( Sender, 'caption' )
    else if IsPublishedProp( Sender, 'text' ) then
      Text := GetPropValue( Sender, 'text' )
    else if ( Sender is TStringGrid ) then
      Text := TStringGrid( Sender ).Cells[ TStringGrid( Sender ).Col, TStringGrid( Sender ).Row ];
    end;
  // SelStart
  SelStart := 0;
  if ( Sender <> nil ) then
    begin
    if ( Sender is TStringGrid ) then
      SendMessage( GetWindow( TStringGrid( Sender ).Handle, GW_CHILD ), EM_GETSEL, WPARAM( @SelStart ),LPARAM( @SelEnd ) )
    else if ( Sender is TWinControl ) then
      TWinControl( Sender ).Perform( EM_GETSEL, WPARAM( @SelStart ), LPARAM( @SelEnd ) );
    end;

  if ( Key = '0' ) then
    begin
    if NOT ( vMode in [ kpmHex, kpmHexBigEndian ] ) then
      begin
      DS := Pos( {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}DecimalSeparator, Text );
      if ( SelEnd-SelStart <> Length( Text ) ) AND
       ( ( ( SelStart = 0 ) AND ( Length( Text ) > 0 ) AND NOT ( DS = 1 ) ) OR
         ( ( SelStart > 1 ) AND ( LeftStr( Text, SelStart ) = DupeString( '-0', SelStart-1 ) ) ) OR
         ( ( SelStart > 0 ) AND ( LeftStr( Text, SelStart ) = DupeString( '0', SelStart ) ) ) ) then
        Key := #0;
      end;
    Exit;
    end;

  if ( vMode in [ kpmHex, kpmHexBigEndian ] ) then
    begin
    if NOT ( {$IF CompilerVersion >= 22}CharInSet( Key,{$ELSE}( Key in{$IFEND} [ 'a'..'f', 'A'..'F', '0'..'9' ] ) ) then
      Key := #0;
    Exit;
    end;

  if ( Key = '-' ) then
    begin
    if ( vMode = kpmUnsigned ) then
      begin
      Key := #0;
      Exit;
      end
    else if ( SelEnd-SelStart = Length( Text ) ) then
      begin
      if ( vMode = kpmFloatUnsigned ) OR ( vMode = kpmExtendedUnsigned ) then
        begin
        Key := #0;
        Exit;
        end;
      Exit;
      end
    else if ( SelStart = 0 ) then
      begin
      if ( vMode = kpmFloatUnsigned ) OR ( vMode = kpmExtendedUnsigned ) then
        begin
        Key := #0;
        Exit;
        end;

      if ( Length( Text ) > 0 ) then
        begin
        if ( Text[ SelStart+1 ] = '-' ) then
          begin
          Key := #0;
          Exit;
          end
        else
          Exit;
        end
      else
        Exit;
      end
    else
      begin
      if ( vMode = kpmExtended ) OR ( vMode = kpmExtendedUnsigned ) then
        begin
        if NOT ( {$IF CompilerVersion >= 22}CharInSet( Text[ SelStart ],{$ELSE}( Text[ SelStart ] in{$IFEND} [ 'e', 'E' ] ) ) then
          begin
          Key := #0;
          Exit;
          end
        else
          Exit;
        end
      else
        begin
        Key := #0;
        Exit;
        end;
      end;
    end;

  if ( vMode = kpmDateTime ) then
    begin
    if NOT ( {$IF CompilerVersion >= 22}CharInSet( Key,{$ELSE}( Key in{$IFEND} [ ' ', {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}DateSeparator, {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}TimeSeparator, {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}DecimalSeparator ] ) ) then
      Key := #0;
    end

  else if ( vMode = kpmExtended ) OR ( vMode = kpmExtendedUnsigned ) then
    begin
    if ( Key = {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}DecimalSeparator ) then
      begin
      P := Pos( Key, Text );
      if ( P > 0 ) OR ( SelStart = 0 ) then
        Key := #0;
      end
    else if ( {$IF CompilerVersion >= 22}CharInSet( Key,{$ELSE}( Key in{$IFEND} [ 'e', 'E' ] ) ) then
      begin
      P := Pos( Key, Text );
      if ( P > 0 ) OR ( SelStart = 0 ) then
        Key := #0;
      end
    else
      Key := #0;
    end
  else if ( vMode = kpmFloat ) OR ( vMode = kpmFloatUnsigned ) then
    begin
    if ( Key = {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}DecimalSeparator ) then
      begin
      P := Pos( Key, Text );
      if ( P > 0 ) OR ( SelStart = 0 ) then
        Key := #0;
      end
    else
      Key := #0;
    end
  else
    Key := #0;
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function IncDecNumberAsString( Text : string; vMode : TOnKeyPressMode; var Position : Integer; Increase : boolean = True ) : string;
  function IncDecNumberChar( C : Char; Increase : Boolean = True; Hex : boolean = false ) : Char;
  begin
    if {$IF CompilerVersion >= 22}CharInSet( C,{$ELSE}( C in{$IFEND} [ 'a'..'f' ] ) then
      C := Char( Ord( C )-32 ); // UpperCase
    result := C;

    if Increase then
      begin
      case result of
        '0'..'8' : result := Char( Ord( result )+1 );
             '9' : begin
                   if Hex then
                     result := 'A'
                   else
                     result := '0';
                   end;
        'a'..'e',
        'A'..'E' : begin
                   if Hex then
                     result := Char( Ord( result )+1 );
                   end;
        'f', 'F' : begin
                   if Hex then
                     result  := '0';
                   end;
      end;
      end
    else
      begin
      case result of
             '0' : begin
                   if Hex then
                     result := 'F'
                   else
                     result := '9';
                   end;
        '1'..'9' : result := Char( Ord( result )-1 );
        'A', 'a' : begin
                   if Hex then
                     result := '9';
                   end;
        'b'..'f',
        'B'..'F' : begin
                   if Hex then
                     result := Char( Ord( result )-1 );
                   end;
      end;
      end;
  end;

  procedure GetDSandEPos( Text : string; var DS : Integer; var EPos : Integer; var bNeg : boolean );
  begin
    DS   := Pos( {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}DecimalSeparator, Text );
    EPos := Pos( 'E', Text );
    if ( EPos <= 0 ) then
      EPos := Pos( 'e', Text );

    if ( EPos > 0 ) AND ( Position > EPos ) AND ( Text[ {$IF CompilerVersion >= 24}Low( Text ){$ELSE}1{$IFEND} + ePos ] = '-' ) then
      bNeg := True;
  end;
var
  DS   : Integer;
  EPos : Integer;
  bNeg : Boolean;
  oC   : Char;
  C    : Char;
  i    : Integer;
  sIdx : Integer;
begin
  result := Text;
  if ( vMode = kpmString ) then
    Exit;
  if ( Position < 0 ) then
    Position := 0
  else if ( Position > {$IF CompilerVersion >= 24}High( Text ){$ELSE}Length( Text ){$IFEND} ) then
    Position := {$IF CompilerVersion >= 24}High( Text ){$ELSE}Length( Text ){$IFEND};

  if ( Text <> '' ) then
    bNeg  := ( Text[ {$IF CompilerVersion >= 24}Low( Text ){$ELSE}1{$IFEND} ] = '-' )
  else
    bNeg  := false;

  EPos := -1;
  DS   := -1;
  if ( vMode in [ kpmFloat, kpmFloatUnsigned, kpmExtended, kpmExtendedUnsigned ] ) then
    GetDSandEPos( Text, DS, EPos, bNeg );

  if ( EPos > 0 ) AND ( Position > EPos ) then
    sIdx := EPos+1
  else
    sIdx := {$IF CompilerVersion >= 24}Low( Text ){$ELSE}1{$IFEND};
  if bNeg then
    Inc( sIdx );

  // Add initial '1'  
  if ( Position = 0 ) then
    begin
    if Increase then
      begin
      if ( vMode = kpmHex ) then
        begin
        if Odd( Length( result ) ) then
          result := '1' + result
        else
          begin
          result := '01' + result;
          Inc( Position );
          end;
        end
      else if ( vMode = kpmHexBigEndian ) then
        Exit
      else
        result := '1' + Text;
      Inc( Position );
      end;
    end
  else if ( bNeg AND ( Position = 1 ) ) then // After initial '-'
    begin
    if NOT Increase then
      begin
      result := '-1' + RightStr( result, Length( result )-1 );
      Inc( Position );
      end;
    end
  else if ( EPos > 0 ) AND ( ( NOT bNeg AND ( Position = EPos ) ) OR ( bNeg AND ( Position = EPos+1 ) ) ) then // After 'E' or 'E-'
    begin
    if ( Increase AND ( NOT bNeg ) ) OR ( ( NOT Increase ) AND bNeg ) then
      begin
      if bNeg then
        result := LeftStr( Text, EPos+1 ) + '1' + RightStr( Text, Length( Text )-EPos-1 )
      else
        result := LeftStr( Text, EPos ) + '1' + RightStr( Text, Length( Text )-EPos );
      Inc( Position );
      end;
    end
  else if ( NOT Increase ) AND ( NOT bNeg ) AND ( Position = sIdx ) AND ( Length( result ) > 0 ) AND ( result[ sIdx ] = '0' ) AND NOT ( vMode in [ kpmHex, kpmHexBigEndian ] ) then // Positive->Negative-Switch
    begin
    if ( vMode = kpmSigned ) then
      result := LeftStr( result, sIdx-1 ) + '-1' + RightStr( result, Length( result )-sIdx )
    else if ( vMode in [ kpmFloat, kpmExtended ] ) then
      begin
      if ( DS > 0 ) then
        result := LeftStr( result, sIdx-1 ) + '-0' + RightStr( result, Length( result )-sIdx ) // 0.1 -> -0.1
      else
        result := LeftStr( result, sIdx-1 ) + '-1' + RightStr( result, Length( result )-sIdx );
      end;
    Inc( Position );
    end
  else if Increase AND bNeg AND ( Position = 2 ) AND ( Length( result ) > 2 ) AND ( Text[ 2 ] = '0' ) then // -0.1 -> 0.1
    begin
    result := RightStr( result, Length( result )-1 );
    Dec( Position );
    end
  else // Increase/Decrease
    begin
    if NOT Increase AND ( vMode in [ kpmHex, kpmHexBigEndian ] ) then // Prevent decrease when there are no more Bytes
      begin
      if ( vMode = kpmHex ) AND ( LeftStr( result, Position ) = DupeString( '0', Position ) ) then
        Exit
      else if ( vMode = kpmHexBigEndian ) AND ( Length( result ) > 2 ) AND ( RightStr( result, Length( result )-Position ) = DupeString( '0', Length( result )-Position ) ) AND
              ( ( Odd( Position ) AND ( ( result[ Position ] = '0' ) AND ( result[ Position+1 ] = '0' ) ) ) OR
                ( NOT Odd( Position ) AND ( ( result[ Position-1 ] = '0' ) AND ( result[ Position ] = '0' ) ) ) ) then 
        Exit;
      end;

    C := #0;
    if ( vMode = kpmHexBigEndian ) then
      begin
      i := Max( 1, Position );
      while ( i <= {$IF CompilerVersion >= 24}High( result ){$ELSE}Length( result ){$IFEND} ) do
        begin
        oC          := Text[ i ];
        C           := IncDecNumberChar( oC, Increase, ( vMode in [ kpmHex, kpmHexBigEndian ] ) );
        result[ i ] := C;
        if ( ( Increase AND ( C <> '0' ) ) OR ( ( NOT Increase ) AND ( C <> 'F' ) ) ) then
          Break;

        if Odd( i ) then
          Inc( i, 3 )
        else
          Dec( i );

        if ( i = Length( result )+2 ) then
          begin
          result := result + '01';
          break;
          end;
        end;
      end
    else
      begin
      for i := Position downTo sIdx do
        begin
        if ( Text[ i ] = {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}DecimalSeparator ) then
          Continue;
        oC := Text[ i ];
        if bNeg then
          C := IncDecNumberChar( oC, NOT Increase, ( vMode in [ kpmHex, kpmHexBigEndian ] ) )
        else
          C := IncDecNumberChar( oC, Increase, ( vMode in [ kpmHex, kpmHexBigEndian ] ) );
        result[ i ] := C;
        if ( ( Increase AND ( ( ( NOT bNeg ) AND ( C <> '0' ) ) OR ( bNeg AND ( C <> IfThen( ( vMode = kpmHex ), 'F', '9' ) ) ) ) ) OR
           ( ( NOT Increase ) AND ( ( bNeg AND ( C <> '0' ) ) OR ( NOT bNeg AND ( C <> IfThen( ( vMode = kpmHex ), 'F', '9' ) ) ) ) ) ) then
          Break;
        end;

      if ( i = sIdx-1 ) AND ( C = '0' ) then
        begin
        // Add initial '1'
        if ( EPos > 0 ) AND ( ( NOT bNeg AND ( i = EPos ) ) OR ( bNeg AND ( i = EPos+1 ) ) ) then
          begin
          if bNeg then
            result := LeftStr( result, EPos+1 ) + '1' + RightStr( result, Length( result )-EPos-1 )
          else
            result := LeftStr( result, EPos ) + '1' + RightStr( result, Length( result )-EPos );
          Inc( Position );
          end
        else
          begin
          if ( vMode = kpmHex ) then
            begin
            if Odd( Length( result ) ) then
              result := '1' + result
            else
              begin
              result := '01' + result;
              Inc( Position );
              end;
            end
          else
            begin
            if bNeg then
              result := '-1' + RightStr( result, Length( result )-1 )
            else
              result := '1' + result;
            end;
          Inc( Position );
          end;
        end;
      end;
    end;

  // Clean additional '0'
  if ( vMode in [ kpmFloat, kpmFloatUnsigned, kpmExtended, kpmExtendedUnsigned ] ) then
    GetDSandEPos( result, DS, EPos, bNeg );
  if ( Length( Result ) > 0 ) AND NOT ( vMode in [ kpmHex, kpmHexBigEndian ] ) then
    begin
    if bNeg then
      begin
      while ( Result[ {$IF CompilerVersion >= 24}Low( Result ){$ELSE}1{$IFEND}+1 ] = '0' ) AND ( Length( Result ) > 2 ) AND NOT ( Result[ {$IF CompilerVersion >= 24}Low( Result ){$ELSE}1{$IFEND}+2 ] = {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}DecimalSeparator ) do
        begin
        Result := '-' + RightStr( Result, Length( Result )-2 );
        Dec( Position );
        end;
      if ( LeftStr( Result, 2 ) = '-0' ) AND NOT ( DS > 0 ) then
        begin
        Result := RightStr( Result, Length( Result )-1 );
        Dec( Position );
        end;

      if ( EPos > 0 ) AND ( Length( result ) > EPos ) then
        begin
        while ( Result[ {$IF CompilerVersion >= 24}Low( Result ){$ELSE}1{$IFEND}+EPos+1 ] = '0' ) AND ( Length( Result )-EPos > 2 )  do
          begin
          Result   := LeftStr( Result, EPos ) + '-' + RightStr( Result, Length( Result )-EPos-2 );
          Dec( Position );
          end;
        if ( RightStr( Result, Length( Result )-EPos ) = '-0' ) then
          begin
          Result   := LeftStr( Result, EPos ) + RightStr( Result, Length( Result )-EPos-1 );
          Dec( Position );
          end;
        end;
      end
    else
      begin
      while ( Result[ {$IF CompilerVersion >= 24}Low( Result ){$ELSE}1{$IFEND} ] = '0' ) AND ( Length( Result ) > 1 ) AND NOT ( Result[ {$IF CompilerVersion >= 24}Low( Result ){$ELSE}1{$IFEND}+1 ] = {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}DecimalSeparator ) do
        begin
        result := RightStr( Result, Length( Result )-1 );
        Dec( Position );
        end;

      if ( EPos > 0 ) then
        begin
        while ( Result[ {$IF CompilerVersion >= 24}Low( Result ){$ELSE}1{$IFEND}+EPos ] = '0' ) AND ( Length( Result )-EPos > 1 ) do
          begin
          result := LeftStr( Result, EPos ) + RightStr( Result, Length( Result )-EPos-1 );
          Dec( Position );
          end;
        end;
      end;
    end;
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure OnKeyDownManipulateNumbersViaUpDown( Sender: TObject; var Key: Word; Shift: TShiftState; vMode : TOnKeyPressMode );
var
  S        : String;
  SelStart : Integer;
  Seltmp   : Integer;
  SelEnd   : Integer;
  i        : Integer;
begin
  if NOT ( Key in [ VK_UP, VK_DOWN ] ) then
    Exit;
  if NOT Assigned( Sender ) then
    Exit;

  SelStart := 0;
  S        := '';
  if IsPublishedProp( Sender, 'caption' ) then
    S := GetPropValue( Sender, 'caption' )
  else if IsPublishedProp( Sender, 'text' ) then
    S := GetPropValue( Sender, 'text' );

  if ( Sender is TWinControl ) then
    TWinControl( Sender ).Perform( EM_GETSEL, WPARAM( @SelStart ), WPARAM( @SelEnd ) );

  SelTmp := SelEnd;
  S := IncDecNumberAsString( S, vMode, SelEnd, ( Key = VK_UP ) );
  if ( SelTmp > SelEnd ) then
    Dec( SelStart, SelTmp-SelEnd )
  else if ( SelTmp < SelEnd ) then
    Inc( SelStart, SelEnd-SelTmp );

  if IsPublishedProp( Sender, 'MaxLength' ) then
    i := GetPropValue( Sender, 'MaxLength' )
  else
    i := 0;

  if ( i > 0 ) AND ( Length( S ) > i ) then
    Exit;

  if IsPublishedProp( Sender, 'caption' ) then
    SetPropValue( Sender, 'caption', S )
  else if IsPublishedProp( Sender, 'text' ) then
    SetPropValue( Sender, 'text', S );

  if ( Sender is TWinControl ) then
    TWinControl( Sender ).Perform( EM_SETSEL, SelStart, SelEnd );

  Key := 0;
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
{$IFNDEF STANDALONE}
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
{$ENDIF}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function ShowTextPopupMenu( Handle : THandle; MousePosClient: TPoint; CanUndo, ReadOnly, HasSelText, HasText : boolean; BiDiMode : TBiDiMode ) : Cardinal;
{
Results
  0          : ;
  WM_UNDO   : Undo;
  WM_CUT    : CutToClipboard;
  WM_COPY   : CopyToClipboard;
  WM_PASTE  : PasteFromClipboard;
  WM_CLEAR  : ClearSelection;
  EM_SETSEL : SelectAll;
  IDM_RTL   : begin
              ParentBiDiMode := false;
              if ( BiDiMode = bdLeftToRight ) then
                BiDiMode := bdRightToLeft
              else
                BiDiMode := bdLeftToRight;
              end;
}
const
  Enables : array[ Boolean ] of Cardinal = ( MF_DISABLED or MF_GRAYED, MF_ENABLED );
  IDM_RTL    = $8000; // WM_APP ?
  Checks  : array[ Boolean ] of Cardinal = ( MF_UNCHECKED, MF_CHECKED );

//  WM_PASTE2 = $0299;
var
  hUser32         : HMODULE;
  hmnu,
  hmenuTrackPopup : HMENU;
begin
  result := 0;
  hUser32 := LoadLibraryEx( user32, 0, LOAD_LIBRARY_AS_DATAFILE );
  if ( hUser32 = 0 ) then
    Exit;
  try
    hmnu := LoadMenu( hUser32, MAKEINTRESOURCE( 1 ) );
    if ( hmnu <> 0 ) then
    try
      hmenuTrackPopup := GetSubMenu( hmnu, 0 );

      EnableMenuItem( hmnu, WM_UNDO,   Enables[ CanUndo ] );
      EnableMenuItem( hmnu, WM_CUT,    Enables[ NOT ReadOnly AND HasSelText ] );
      EnableMenuItem( hmnu, WM_COPY,   Enables[ HasSelText ] );
      EnableMenuItem( hmnu, WM_PASTE,  Enables[ NOT ReadOnly AND Clipboard.HasFormat( CF_TEXT ) ] );
      EnableMenuItem( hmnu, WM_CLEAR,  Enables[ NOT ReadOnly AND HasSelText ] );
      EnableMenuItem( hmnu, EM_SETSEL, Enables[ HasText ] );
//      EnableMenuItem( hmnu, EM_SETSEL, Enables[ Length( Text ) <> 0 ] );

      // There options of right-click menu of search input field are disable
//      DeleteMenu( hmnu, 32768, MF_BYCOMMAND );  // delete menu item : Right to left Reading order
      EnableMenuItem( hmnu, IDM_RTL, Enables[ True ] );
      CheckMenuItem( hmnu, IDM_RTL, Checks[ ( BiDiMode = bdRightToLeft ) ] );

      RemoveMenu( hmnu, 32769, MF_BYCOMMAND );  // delete menu item : Show Unicode control characters
      RemoveMenu( hmnu, 11, MF_BYPOSITION );    // delete menu item : Insert Unicode control character
(*
      MousePosClient := ClientToScreen( MousePosClient );
      case Cardinal( TrackPopupMenu( hmenuTrackPopup, TPM_LEFTALIGN or TPM_RIGHTBUTTON or TPM_NONOTIFY or TPM_RETURNCMD{Flags}, MousePosClient.X, MousePosClient.Y, {Mouse.CursorPos.X, Mouse.CursorPos.Y,} 0, Handle, nil ) ) of
        0          : ;
        WM_UNDO   : Undo;
        WM_CUT    : CutToClipboard;
        WM_COPY   : CopyToClipboard;
        WM_PASTE  : PasteFromClipboard;
        WM_CLEAR  : ClearSelection;
        EM_SETSEL : SelectAll;
        IDM_RTL   : begin
                    ParentBiDiMode := false;
                    if ( BiDiMode = bdLeftToRight ) then
                      BiDiMode := bdRightToLeft
                    else
                      BiDiMode := bdLeftToRight;
                    end;
      end;
*)
      ClientToScreen( Handle, MousePosClient );
      result := Cardinal( TrackPopupMenu( hmenuTrackPopup, TPM_LEFTALIGN or TPM_RIGHTBUTTON or TPM_NONOTIFY or TPM_RETURNCMD{Flags}, MousePosClient.X, MousePosClient.Y, {Mouse.CursorPos.X, Mouse.CursorPos.Y,} 0, Handle, nil ) );
    finally
      DestroyMenu( hmnu );
    end;
  finally
    FreeLibrary( hUser32 );
  end;
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function JumpLines( Code, Offsets : {$IFNDEF UNICODE}{$IFDEF SynEdit}TUnicodeStrings{$ELSE}TStrings{$ENDIF}{$ELSE}TStrings{$ENDIF}; var JumpLines : tJumpLines ) : boolean;
const
  KeyWords : Array [ 0..36 ] of String = ( 'jmp', 'call', 'ja', 'jae', 'jb', 'jbe', 'jc', 'jcxz', 'je', 'jecxz', 'jg', 'jge', 'jl', 'jle', 'jna', 'jnae', 'jnb', 'jnbe', 'jnc', 'jne', 'jng', 'jnge', 'jnl', 'jnle', 'jno', 'jnp', 'jns', 'jnz', 'jo', 'jp', 'jpe', 'jpo', 'js', 'jz', 'loop', 'loope', 'loopne' );
var
  i, j, k, P,
  Off, tOff,
  lOff       : Integer;
  S, S1, S2  : String;
  Cnt        : Cardinal;
  t1, t2     : TJumpLine;
begin
  result := false;
  if NOT Assigned( Code ) OR NOT Assigned( Offsets ) then
    Exit;
  if ( Code.Count <> Offsets.Count ) then
    Exit;
  SetLength( JumpLines, Code.Count );
  Cnt := 0;
  for i := 0 to Code.Count-1 do
    begin
    S := Code[ i ];
    P := Pos( ' ', S );
    if ( P <= 0 ) then
      Continue;
    S1  := Copy( S, {$IF CompilerVersion >= 24}Low( S ){$ELSE}1{$IFEND}, P-1 );
    lOff := -1;

    for j := Low( KeyWords ) to High( KeyWords ) do
      begin
      if ( {$IFDEF STANDALONE}SysUtils.{$ENDIF}LowerCase( S1 ) = KeyWords[ j ] ) then
        begin
        S2 := Copy( S, P+1, Length( S )-P );
        if ( LeftStr( S2, 2 ) = '0x' ) then
          S2 := RightStr( S2, Length( S2 )-2 );

        Off := StrToIntDef( '$' + S2, -1 );
        if ( Off = -1 ) then
          Continue;

        for k := 0 to Offsets.Count-1 do
          begin
          tOff := StrToIntDef( '$' + Offsets[ k ], -1 );
          if ( tOff < 0 ) then
            Continue;

          if ( tOff = Off ) then
            begin
            if ( i = k ) then
              break;
            JumpLines[ Cnt ].Line        := i;
            JumpLines[ Cnt ].Destination := k;
            JumpLines[ Cnt ].Offset      := 0;
            JumpLines[ Cnt ].Broken      := false;
            JumpLines[ Cnt ].Intersected := false;
            Inc( Cnt );
            Break;
            end
          else if ( lOff >= 0 ) AND ( ( Off > lOff ) AND ( Off < tOff ) ) then
            begin
            if ( i = k ) then
              break;
            JumpLines[ Cnt ].Line        := i;
            JumpLines[ Cnt ].Destination := k;
            JumpLines[ Cnt ].Offset      := 0;
            JumpLines[ Cnt ].Broken      := True;
            JumpLines[ Cnt ].Intersected := false;
            Inc( Cnt );
            Break;
            end;
          lOff := tOff;
          end;
        break;
        end;
      end;
    end;
  SetLength( JumpLines, Cnt );

  for i := Low( JumpLines ) to High( JumpLines ) do
    begin
    t1 := JumpLines[ i ];
    if ( t1.Line > t1.Destination ) then
      begin
      t1.Line := t1.Destination;
      t1.Destination := JumpLines[ i ].Line;
      end;

    for j := Low( JumpLines ) to High( JumpLines ) do
      begin
      t2 := JumpLines[ j ];
      if ( t2.Line > t2.Destination ) then
        begin
        t2.Line := t2.Destination;
        t2.Destination := JumpLines[ j ].Line;
        end;

      if ( t2.Line > t1.Line ) AND ( t2.Destination < t1.Destination ) then
        begin
        Inc( JumpLines[ i ].Offset );
        JumpLines[ i ].Intersected := False;
        end

      else if ( t2.Line >= t1.Line ) AND ( t2.Line <= t1.Destination ) or
              ( t2.Destination >= t1.Line ) AND ( t2.Destination <= t1.Destination ) then
        JumpLines[ i ].Intersected := True;
      end;
    end;
  result := True;
end;


// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
{$IFDEF SynEdit}
{$IFDEF SYNEDIT_CUSTOM_TEXTPOPUP}
const
  MenuName = 'uSynEditPopupMenu';
{$ENDIF}
{$IF Defined( SynEdit_VCLStyles ) AND ( CompilerVersion >= 30 )}
var
  SynEditStyleHookRegistered : boolean = False;
{$IFEND}

constructor TSynEdit.Create( AOwner: TComponent );
begin
  inherited;

  {$IFDEF SYNEDIT_CUSTOM_TEXTPOPUP}
  FActnList                                := TActionList.Create( Self );
  FPopupMenu                               := TPopupMenu.Create( Self );
  FPopupMenu.Name                          := MenuName;
  CreateActns;
  FillPopupMenu( FPopupMenu );
  PopupMenu                                := FPopupMenu;
  {$ELSE}
  fTextPopupMenu                           := True;
  {$ENDIF}
  fPopupMenuGutterLine                     := 0;
  fPopupMenuGutterRealLine                 := 0;

  fHighlightMatchingBrackets               := false;
  fHighlightMatchingBracketsOnlySymbols    := false;
  fHighlightMatchingBracketsColorOutFG     := clNone;
  fHighlightMatchingBracketsColorOutBG     := $FFAA7F;
  fHighlightMatchingBracketsColorInFG      := clNone;
  fHighlightMatchingBracketsColorInBG      := clAqua;
  fHighlightMatchingBracketsNoOutBound     := false;
  FillChar( fHighlightMatchingBracketsResult[ 0 ], SizeOf( tBracketInfos ), 0 );

  {$IF Defined( SynEdit_VCLStyles ) AND ( CompilerVersion >= 30 )}
  fVCLStyles                               := false;
  VCLStylesBackup( False ); // Backup
  {$IFEND}
end;

destructor TSynEdit.Destroy;
begin
  {$IFDEF SYNEDIT_CUSTOM_TEXTPOPUP}
  FPopupMenu.Free;
  FActnList.Free;
  {$ENDIF}
  inherited;
end;

{$IF Defined( SynEdit_VCLStyles ) AND ( CompilerVersion >= 30 )}
procedure TSynEdit.Loaded;
begin
  inherited;
  UpdateStyle;
end;

procedure TSynEdit.CMSTYLECHANGED( var Message: TMessage );
begin
  UpdateStyle;
  Invalidate;
end;

procedure TSynEdit.UpdateStyle;
begin
  LStyle := TStyleManager.ActiveStyle;

  if NOT fVCLStyles then
    Exit;

  if LStyle.IsSystemStyle then
    VCLStylesBackup( True ) // Restore
  else
    begin
    if ( seFont in StyleElements ) then
      begin
      Font.Color                := LStyle.GetSystemColor( clWindowText );
      Gutter.Font.Color         := LStyle.GetSystemColor( clWindowText );
      end;

    if ( seClient in StyleElements ) then
      begin
      Color                     := LStyle.GetStyleColor( scEdit );
      ActiveLineColor           := LStyle.GetSystemColor( clHighlight );
      Gutter.GradientStartColor := LStyle.GetSystemColor( clWindow );
      Gutter.GradientEndColor   := LStyle.GetSystemColor( clBtnFace );
      end;

    if ( seBorder in StyleElements ) then
      Gutter.BorderColor        := LStyle.GetStyleColor( scSplitter );
    end;
end;

procedure TSynEdit.VCLStylesBackup( Restore : boolean );
begin
  if Restore then
    begin
    // Restore
    Color                                    := fVCLStyleBackup.Color;
    Font.Color                               := fVCLStyleBackup.FontColor;
    Gutter.GradientEndColor                  := fVCLStyleBackup.GutterGradientEndColor;
    Gutter.GradientStartColor                := fVCLStyleBackup.GutterGradientStartColor;
    Gutter.Font.Color                        := fVCLStyleBackup.GutterFontColor;
    Gutter.BorderColor                       := fVCLStyleBackup.GutterBorderColor;
    ActiveLineColor                          := fVCLStyleBackup.ActiveLineColor;
    end
  else
    begin
    // Backup
    fVCLStyleBackup.Color                    := Color;
    fVCLStyleBackup.FontColor                := Font.Color;
    fVCLStyleBackup.GutterGradientEndColor   := Gutter.GradientEndColor;
    fVCLStyleBackup.GutterGradientStartColor := Gutter.GradientStartColor;
    fVCLStyleBackup.GutterFontColor          := Gutter.Font.Color;
    fVCLStyleBackup.GutterBorderColor        := Gutter.BorderColor;
    fVCLStyleBackup.ActiveLineColor          := ActiveLineColor;
    end;
end;

procedure TSynEdit.SetVCLStyles( value : boolean );
begin
  if NOT Assigned( self ) then
    Exit;
  if ( fVCLStyles = Value ) then
    Exit;
  fVCLStyles := Value;

  if Value then
    begin
    VCLStylesBackup( false );

    Gutter.Gradient           := True;
    Gutter.BorderStyle        := gbsRight;
    UpdateStyle;

    if NOT SynEditStyleHookRegistered then
      begin
      TStyleManager.Engine.RegisterStyleHook( TSynEdit, TScrollingStyleHook );
      SynEditStyleHookRegistered := True;
      end;
    end
  else
    VCLStylesBackup( True ); // Restore
end;
{$IFEND}

{$IFDEF SYNEDIT_CUSTOM_TEXTPOPUP}
procedure TSynEdit.CopyExecute( Sender: TObject );
begin
  Self.CopyToClipboard;
end;

procedure TSynEdit.CopyUpdate( Sender: TObject );
begin
  TAction( Sender ).Enabled := Self.SelAvail;
end;

procedure TSynEdit.CutExecute( Sender: TObject );
begin
  Self.CutToClipboard;
end;

procedure TSynEdit.CutUpdate( Sender: TObject );
begin
  TAction( Sender ).Enabled := Self.SelAvail and not Self.ReadOnly;
end;

procedure TSynEdit.DeleteExecute( Sender: TObject );
begin
  Self.SelText := '';
end;

procedure TSynEdit.DeleteUpdate( Sender: TObject );
begin
  TAction( Sender ).Enabled := Self.SelAvail and not Self.ReadOnly;
end;

procedure TSynEdit.PasteExecute( Sender: TObject );
begin
  Self.PasteFromClipboard;
end;

procedure TSynEdit.PasteUpdate( Sender: TObject );
begin
  TAction( Sender ).Enabled := Self.CanPaste;
end;

procedure TSynEdit.RedoExecute( Sender: TObject );
begin
  Self.Redo;
end;

procedure TSynEdit.RedoUpdate( Sender: TObject );
begin
  TAction( Sender ).Enabled := Self.CanRedo;
end;

procedure TSynEdit.SelectAllExecute( Sender: TObject );
begin
  Self.SelectAll;
end;

procedure TSynEdit.SelectAllUpdate( Sender: TObject );
begin
  TAction( Sender ).Enabled := ( Self.Lines.Text <> '' );
end;

procedure TSynEdit.UndoExecute( Sender: TObject );
begin
  Self.Undo;
end;

procedure TSynEdit.UndoUpdate( Sender: TObject );
begin
  TAction( Sender ).Enabled := Self.CanUndo;
end;

procedure TSynEdit.CreateActns;
 procedure AddActItem( const AText:string;AShortCut : TShortCut;AEnabled:Boolean;OnExecute,OnUpdate:TNotifyEvent );
 Var
    ActionItem : TAction;
  begin
    ActionItem            := TAction.Create( FActnList );
    ActionItem.ActionList := FActnList;
    ActionItem.Caption    := AText;
    ActionItem.ShortCut   := AShortCut;
    ActionItem.Enabled    := AEnabled;
    ActionItem.OnExecute  := OnExecute;
    ActionItem.OnUpdate   := OnUpdate;
  end;
begin
  AddActItem( '&Undo',Menus.ShortCut( Word( 'Z' ), [ ssCtrl ] ),False,UndoExecute, UndoUpdate );
  AddActItem( '&Redo',Menus.ShortCut( Word( 'Z' ), [ ssCtrl,ssShift ] ),False,RedoExecute, RedoUpdate );
  AddActItem( '-',0,False,nil,nil );
  AddActItem( 'Cu&t',Menus.ShortCut( Word( 'X' ), [ ssCtrl ] ),False,CutExecute, CutUpdate );
  AddActItem( '&Copy',Menus.ShortCut( Word( 'C' ), [ ssCtrl ] ),False,CopyExecute, CopyUpdate );
  AddActItem( '&Paste',Menus.ShortCut( Word( 'V' ), [ ssCtrl ] ),False,PasteExecute, PasteUpdate );
  AddActItem( 'De&lete',0,False,DeleteExecute, DeleteUpdate );
  AddActItem( '-',0,False,nil,nil );
  AddActItem( 'Select &All',Menus.ShortCut( Word( 'A' ), [ ssCtrl ] ),False,SelectAllExecute, SelectAllUpdate );
end;

procedure TSynEdit.SetPopupMenu_( const Value: TPopupMenu );
Var
  MenuItem : TMenuItem;
begin
  SynEdit.TSynEdit( Self ).PopupMenu := Value;
  if ( CompareText( MenuName, Value.Name ) <> 0 ) then
    begin
    MenuItem         := TMenuItem.Create( Value );
    MenuItem.Caption := '-';
    Value.Items.Add( MenuItem );
    FillPopupMenu( Value );
    end;
end;

function TSynEdit.GetPopupMenu_ :  TPopupMenu;
begin
  Result := SynEdit.TSynEdit( Self ).PopupMenu;
end;

procedure TSynEdit.FillPopupMenu( APopupMenu : TPopupMenu );
var
  i        : integer;
  MenuItem : TMenuItem;
begin
  if Assigned( FActnList ) then
    begin
    for i := 0 to FActnList.ActionCount-1 do
      begin
      MenuItem        := TMenuItem.Create( APopupMenu );
      MenuItem.Action := FActnList.Actions[ i ];
      APopupMenu.Items.Add( MenuItem );
      end;
    end;
end;
{$ELSE}

procedure TSynEdit.DoContextPopup( MousePos: TPoint; var Handled: Boolean );
const
  IDM_RTL    = $8000; // WM_APP ?
var
  State  : TKeyboardState;
  IsCTRL : Boolean;
  i      : Integer;
begin
  inherited;
  if NOT {( NOT ReadOnly ) AND} fTextPopupMenu then
    Exit;

  if Assigned( PopupMenu ) then
    begin
    GetKeyboardState( State );
    IsCTRL := ( ( State[ vk_Control ] And 128 ) <> 0 );
    if IsCTRL then
      Exit;
    end;

  fPopupMenuGutterLine     := 0;
  fPopupMenuGutterRealLine := 0;
  if ( MousePos.X < Gutter.RealGutterWidth( CharWidth ) ) then
    begin
    if NOT Assigned( fPopupMenuGutter ) then
      Exit;
    for i := TopLine to TopLine+LinesInWindow do
      begin
      if ( ( i-TopLine )*LineHeight <= MousePos.Y ) then
        begin
        fPopupMenuGutterRealLine := i-1;
        fPopupMenuGutterLine     := i-TopLine;
        end;
      end;

    MousePos := ClientToScreen( MousePos );
    fPopupMenuGutter.PopupComponent := Self;
    fPopupMenuGutter.Popup( MousePos.X, MousePos.Y );

    Exit;
    end;

  case ShowTextPopupMenu( Handle, MousePos, CanUndo, ReadOnly, ( Length( SelText ) <> 0 ), ( Length( Text ) <> 0 ), BiDiMode ) of
    0          : ;
    WM_UNDO   : Undo;
    WM_CUT    : CutToClipboard;
    WM_COPY   : CopyToClipboard;
    WM_PASTE  : PasteFromClipboard;
    WM_CLEAR  : ClearSelection;
    EM_SETSEL : SelectAll;
    IDM_RTL   : begin
                ParentBiDiMode := false;
                if ( BiDiMode = bdLeftToRight ) then
                  BiDiMode := bdRightToLeft
                else
                  BiDiMode := bdLeftToRight;
                end;
  end;
end;
{$ENDIF}

function TSynEdit.GetSelStartLine : Integer;
begin
  result := -1;
  if ( Length( SelText ) = 0 ) then
    Exit;

  result := CharIndexToRowCol( SelStart ).Line;
end;

function TSynEdit.GetSelEndLine : Integer;
begin
  result := -1;
  if ( Length( SelText ) = 0 ) then
    Exit;

  result := CharIndexToRowCol( SelStart+SelLength ).Line;
end;

// Highlight
procedure TSynEdit.SetHighlightMatchingBrackets( Value : boolean );
begin
  if NOT Assigned( self ) then
    Exit;
  if ( fHighlightMatchingBrackets = Value ) then
    Exit;
  fHighlightMatchingBrackets := Value;
  Invalidate;
end;

procedure TSynEdit.DoOnStatusChange( Changes: TSynStatusChanges );
begin
  inherited;

  if ( scCaretX in Changes ) OR ( scCaretY in Changes ) OR ( scTopLine in Changes ) then
    begin
    SearchMatchingBrackets;
    Invalidate; // MS Matching word highlight .. 
    end;
end;

procedure TSynEdit.SearchMatchingBrackets;
const
  MAX_CHARS = 1000;
//  Brackets : Array [ 0..3 ] of Array [ 0..1 ] of WideChar = ( ( '(', ')' ), ( '{', '}' ), ( '[', ']' ), ( '<', '>' ) );
  Brackets : Array [ 0..5 ] of Array [ 0..1 ] of WideString = ( ( '(', ')' ), ( '{', '}' ), ( '[', ']' ), ( '<', '>' ), ( 'begin', 'end' ), ( 'case', 'end' ) );
var
  S     : {$IFDEF UNICODE}String{$ELSE}WideString{$ENDIF};
  j, i  : Integer;
  k     : Integer;
  SS    : Integer;
  Cnt   : Array of Int64;
  tB    : tBracketInfos;
  oB    : tBracketInfos;
  Attri : TSynHighlighterAttributes;
  vText : WideString;
  tTok  : WideString;
begin
  if SelAvail then
    exit;

  if NOT fHighlightMatchingBrackets OR NOT Assigned( Highlighter ) then
    Exit;

  for i := Low( fHighlightMatchingBracketsResult ) to High( fHighlightMatchingBracketsResult ) do
    begin
    oB[ i ].vStart.Char := fHighlightMatchingBracketsResult[ i ].vStart.Char;
    oB[ i ].vStart.Line := fHighlightMatchingBracketsResult[ i ].vStart.Line;
    oB[ i ].vEnd.Char := fHighlightMatchingBracketsResult[ i ].vEnd.Char;
    oB[ i ].vEnd.Line := fHighlightMatchingBracketsResult[ i ].vEnd.Line;
    oB[ i ].Bracket   := fHighlightMatchingBracketsResult[ i ].Bracket;
    end;

  SS := SelStart;
  if ( CaretX > Length( Lines[ CaretY-1 ] ) ) then
    SS := SS-( CaretX-Length( Lines[ CaretY-1 ] ) )+1;

  if ( SS <= 0 ) OR ( SS > Length( Text ) ) then
    begin
    for i := Low( fHighlightMatchingBracketsResult ) to High( fHighlightMatchingBracketsResult ) do
      begin
      if ( fHighlightMatchingBracketsResult[ i ].vStart.Line >= 0 ) then
        begin
        InvalidateLine( fHighlightMatchingBracketsResult[ i ].vStart.Line );
        fHighlightMatchingBracketsResult[ i ].vStart.Char := -1;
        fHighlightMatchingBracketsResult[ i ].vStart.Line := -1;
        end;
      if ( fHighlightMatchingBracketsResult[ i ].vEnd.Line >= 0 ) then
        begin
        InvalidateLine( fHighlightMatchingBracketsResult[ i ].vEnd.Line );
        fHighlightMatchingBracketsResult[ i ].vEnd.Char := -1;
        fHighlightMatchingBracketsResult[ i ].vEnd.Line := -1;
        end;
      fHighlightMatchingBracketsResult[ i ].Bracket     := false;        
      end;
    Exit;
    end;

  for i := Low( fHighlightMatchingBracketsResult ) to High( fHighlightMatchingBracketsResult ) do
    begin
    fHighlightMatchingBracketsResult[ i ].vStart.Char := -1;
    fHighlightMatchingBracketsResult[ i ].vStart.Line := -1;
    fHighlightMatchingBracketsResult[ i ].vEnd.Char := -1;
    fHighlightMatchingBracketsResult[ i ].vEnd.Line := -1;
    fHighlightMatchingBracketsResult[ i ].Bracket   := false;

    tB[ i ].vStart.Char := -1;
    tB[ i ].vStart.Line := -1;
    tB[ i ].vEnd.Char := -1;
    tB[ i ].vEnd.Line := -1;
    tB[ i ].Bracket   := false;
    end;

  vText := Text;
  for j := 0 to 1 do
    begin
    tB[ j ].vStart := CaretXY;
    S := #0;
    case j of
      0 : begin // Outside
          for i := Low( Brackets ) to High( Brackets ) do
            begin
            tTok := Copy( vText, SS, Length( Brackets[ i, 1 ] ) );
            if ( {$IFDEF STANDALONE}SysUtils.{$ENDIF}LowerCase( tTok ) = Brackets[ i, 1 ] ) then
              begin
              if ( i > 3 ) AND ( SS > 1 ) AND NOT ( AnsiChar( vText[ SS-1 ] ) in [ ' ', #10, #13, #9 ] ) then
                Continue;
              S := tTok;
              tB[ j ].vStart.Char := tB[ j ].vStart.Char-1;
              tB[ j ].Bracket := ( i < 4 );
              break;
              end
            else if ( SS > 1 ) then
              begin
              tTok := Copy( vText, SS+1, Length( Brackets[ i, 0 ] ) );
              if ( {$IFDEF STANDALONE}SysUtils.{$ENDIF}LowerCase( tTok ) = Brackets[ i, 0 ] ) then
                begin
                if ( i > 3 ) AND NOT ( AnsiChar( vText[ SS ] ) in [ ' ', #10, #13, #9 ] ) then
                  Continue;
                S := tTok;
                tB[ j ].Bracket := ( i < 4 );
                break;
                end;
              end;
            end;
          end;

      1 : begin
          SetLength( Cnt, Length( Brackets ) );
          FillChar( Cnt[ 0 ], Length( Cnt )*SizeOf( Int64 ), 0 );
          for k := SS downTo {1} Max( 1, SS-MAX_CHARS ) do
            begin
//            if ( SS-k > MAX_CHARS ) then
//              break;
            if ( S <> #0 ) then
              break;

            for i := Low( Brackets ) to High( Brackets ) do
              begin
              if ( S <> #0 ) then
                break;
              tTok := Copy( vText, k, Length( Brackets[ i, 1 ] ) );
              if ( {$IFDEF STANDALONE}SysUtils.{$ENDIF}LowerCase( tTok ) = Brackets[ i, 1{Close} ] ) then
                Inc( Cnt[ i ] )
              else
                begin
                tTok := Copy( vText, k, Length( Brackets[ i, 0 ] ) );
                if ( {$IFDEF STANDALONE}SysUtils.{$ENDIF}LowerCase( tTok ) = Brackets[ i, 0{Open} ] ) then
                  begin
                  if ( i > 3 ) AND ( k > 1 ) AND NOT ( AnsiChar( vText[ k-1 ] ) in [ ' ', #10, #13, #9 ] ) then
                    Continue;
                  if ( Cnt[ i ] > 0 ) then
                    Dec( Cnt[ i ] )
                  else
                    begin
                    S := tTok;
                    tB[ j ].vStart := CharIndexToRowCol( k-1 );
                    tB[ j ].Bracket := ( i < 4 );
                    break;
                    end;
                  end;
                end;
              end;
            end;
          SetLength( Cnt, 0 );            
          end;
    else
      break;
    end;

    if ( S = #0 ) then
      begin
      if ( oB[ j ].vStart.Line >= 0 ) then
        InvalidateLine( oB[ j ].vStart.Line );
      if ( oB[ j ].vEnd.Line >= 0 ) then
        InvalidateLine( oB[ j ].vEnd.Line );
      Continue;
      end;

    GetHighlighterAttriAtRowCol( tB[ j ].vStart, S, Attri );
    if ( NOT fHighlightMatchingBracketsOnlySymbols ) OR ( fHighlightMatchingBracketsOnlySymbols AND ( Highlighter.SymbolAttribute = Attri ) ) then
      begin
      if tB[ j ].Bracket then
        tB[ j ].vEnd := GetMatchingBracketEx( tB[ j ].vStart )
      else
        begin
        Attri := Attri; // MS Find matching keyword ...
        Continue;
        end;
      if NOT ( ( tB[ j ].vEnd.Char > 0 ) and ( tB[ j ].vEnd.Line > 0 ) ) then // No MatchingBracket
        Continue;

      Move( tB[ j ], fHighlightMatchingBracketsResult[ j ], SizeOf( tBracketInfo ) );

      InvalidateLine( tB[ j ].vStart.Line );
      if ( tB[ j ].vStart.Line <> tB[ j ].vEnd.Line ) then
        InvalidateLine( tB[ j ].vEnd.Line );

      // Unset Old
      if ( oB[ j ].vStart.Line >= 0 ) AND ( oB[ j ].vStart.Line <> tB[ j ].vStart.Line ) AND ( oB[ j ].vStart.Line <> tB[ j ].vEnd.Line ) then
        InvalidateLine( oB[ j ].vStart.Line );
      if ( oB[ j ].vEnd.Line >= 0 ) AND ( oB[ j ].vEnd.Line <> tB[ j ].vStart.Line ) AND ( oB[ j ].vEnd.Line <> tB[ j ].vEnd.Line ) then
        InvalidateLine( oB[ j ].vEnd.Line );
      end;
    end;
end;

procedure TSynEdit.DoOnPaintTransientEx( TransientType: TTransientType; Lock: Boolean );
begin
  inherited;

  if NOT fHighlightMatchingBrackets OR NOT Assigned( Highlighter ) then
    Exit;

  Canvas.Font.Assign( Font );
  Canvas.Brush.Color := Color;
  HideCaret;
  DoHighlightMatchingBrackets( TransientType );
  ShowCaret;
end;

procedure TSynEdit.SetSelTextPrimitiveEx(PasteMode: TSynSelectionMode; Value: PWideChar; AddToUndoList: Boolean);
begin
  inherited;
end;

procedure TSynEdit.DoHighlightMatchingBrackets( TransientType : TTransientType );
  procedure SetColor( Attri: TSynHighlighterAttributes; ColorFG : TColor; ColorBG : TColor );
  begin
//    Canvas.Brush.Style := bsSolid;
    Canvas.Font.Style := Attri.Style;

    if ( TransientType = ttAfter ) then
      begin
      Canvas.Font.Color := ColorFG;
//      if ( ActiveLineColor <> clBlack ) then
//        Canvas.Brush.Color := ActiveLineColor
//      else
        Canvas.Brush.Color := ColorBG;
      end
    else
      begin
      Canvas.Font.Color := Attri.Foreground;
      if ( ActiveLineColor <> clBlack ) then
        Canvas.Brush.Color := ActiveLineColor
      else
        Canvas.Brush.Color := Attri.Background;
      end;
    if ( Canvas.Font.Color = clNone ) then
      Canvas.Font.Color := Font.Color;
    if ( Canvas.Brush.Color = clNone ) then
      Canvas.Brush.Color := Color;
  end;
var
  P     : TPoint;
  S     : {$IFDEF UNICODE}String{$ELSE}WideString{$ENDIF};
  i, j  : Integer;
  cFG,
  cBG   : TColor;
  Attri : TSynHighlighterAttributes;
begin
  if SelAvail then
    exit;

  if NOT fHighlightMatchingBrackets OR NOT Assigned( Highlighter ) then
    Exit;

  cFG := fHighlightMatchingBracketsColorOutFG;
  cBG := fHighlightMatchingBracketsColorOutBG;
  for i := Low( fHighlightMatchingBracketsResult ) to High( fHighlightMatchingBracketsResult ) do
    begin
    if ( fHighlightMatchingBracketsResult[ i ].vStart.Char = fHighlightMatchingBracketsResult[ i ].vEnd.Char ) AND ( fHighlightMatchingBracketsResult[ i ].vStart.Line = fHighlightMatchingBracketsResult[ i ].vEnd.Line ) then
      Continue;

    if fHighlightMatchingBracketsNoOutBound AND
       ( ( ( fHighlightMatchingBracketsResult[ i ].vStart.Line < RowToLine( TopLine ) ) OR ( fHighlightMatchingBracketsResult[ i ].vEnd.Line > RowToLine( TopLine )+Self.LinesInWindow ) ) OR
         ( ( fHighlightMatchingBracketsResult[ i ].vStart.Char < LeftChar ) OR ( fHighlightMatchingBracketsResult[ i ].vEnd.Char > LeftChar+CharsInWindow ) ) ) then
      Continue;

    case i of
//      0 : begin
//          cFG := fHighlightMatchingBracketsColorOutFG;
//          cBG := fHighlightMatchingBracketsColorOutBG;
//          end;
      1 : begin
          cFG := fHighlightMatchingBracketsColorInFG;
          cBG := fHighlightMatchingBracketsColorInBG;
          end;
    end;

    for j := 0 to 1 do
      begin
      case j of
        0 : GetHighlighterAttriAtRowCol( fHighlightMatchingBracketsResult[ i ].vStart, S, Attri );
        1 : GetHighlighterAttriAtRowCol( fHighlightMatchingBracketsResult[ i ].vEnd, S, Attri );
      else
        Break;
      end;
      if ( S = '' ) OR ( NOT Assigned( Attri ) ) then
        Continue;
      case j of
        0 : P := RowColumnToPixels( BufferToDisplayPos( fHighlightMatchingBracketsResult[ i ].vStart ) ); // CharToPixels
        1 : P := RowColumnToPixels( BufferToDisplayPos( fHighlightMatchingBracketsResult[ i ].vEnd ) ); // CharToPixels
      else
        Break;
      end;
      if ( P.X < Gutter.RealGutterWidth( CharWidth )-4 ) then
        begin
        if fHighlightMatchingBracketsNoOutBound then
          break
        else
          Continue;
        end;

      SetColor( Attri, cFG, cBG );
      Canvas.TextOut( P.X, P.Y, S );
      end;
    end;
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
{ TEditorFrameSynEditPlugin }
procedure TSynMatchTextHighlighterPlugin.AfterConstruction;
begin
  inherited;
  FAttribute  := TSynHighlighterAttributes.Create( 'MatchText', 'Match Text Highlighter' );
  fFrameColor := clNone;
end;

destructor TSynMatchTextHighlighterPlugin.Destroy;
begin
  FAttribute.Free;
  inherited;
end;

{$IF Defined( SynEdit_VCLStyles ) AND ( CompilerVersion >= 30 )}
procedure TSynMatchTextHighlighterPlugin.CMSTYLECHANGED( var Message: TMessage );
begin
  if NOT TSynEdit( Editor ).VCLStyles then
    Exit;

  if ( seFont in Editor.StyleElements ) then
    Attribute.Foreground := TStyleManager.ActiveStyle.GetSystemColor( clWindowText );

  if ( seClient in Editor.StyleElements ) then
    begin
//    Color                     := LStyle.GetStyleColor( scEdit );
    Attribute.Background := TStyleManager.ActiveStyle.GetSystemColor( clHighlight );
    end;
end;
{$IFEND}

procedure TSynMatchTextHighlighterPlugin.AfterPaint( ACanvas: TCanvas; const AClip: TRect; FirstLine, LastLine: Integer );
var
  SearchResultText: string;
  Pt: TPoint;
  Rct: TRect;
  OldFont: TFont;
  LineIndex, Count, ItemIndex: Integer;
  CurrCoord: TBufferCoord;
  PBak : string;
  bCS : Boolean;
  bWW : Boolean;
  tmp : TSynEditSearchCustom;
begin
  inherited;

  if not Assigned( Editor ) then
    Exit;

  if not Assigned( Editor.SearchEngine ) then
    Exit;

  if NOT fEnabled OR ( Editor.WordAtCursor = '' ) then
    Exit;

  tmp := nil;
  if NOT ( Editor.SearchEngine is TSynEditSearch ) then
    begin
    if Assigned( fEngine ) then
      begin
      tmp := Editor.SearchEngine;
      Editor.SearchEngine := fEngine;
      end
    else
      Exit;
    end;

  PBak := Editor.SearchEngine.Pattern;
  bCS := TSynEditSearch( Editor.SearchEngine ).CaseSensitive;
  bWW := TSynEditSearch( Editor.SearchEngine ).Whole;

  Editor.SearchEngine.Pattern := Editor.WordAtCursor;
  Editor.SearchEngine.Options := [ ssoWholeWord ];

  OldFont := TFont.Create;
  try
    OldFont.Assign( ACanvas.Font );

    for LineIndex := FirstLine to LastLine do
      begin
      Count := Editor.SearchEngine.FindAll( Editor.Lines[ LineIndex - 1 ] );
      for ItemIndex := 0 to Count - 1 do
        begin
        CurrCoord := BufferCoord( Editor.SearchEngine.Results[ ItemIndex ], LineIndex );
        if ( CurrCoord.Char = Editor.BlockBegin.Char ) AND ( CurrCoord.Line = Editor.BlockBegin.Line ) AND ( Editor.SelText <> '' ) then
          Continue;

        SearchResultText := Copy( Editor.Lines[ LineIndex - 1 ], Editor.SearchEngine.Results[ ItemIndex ], Editor.SearchEngine.Lengths[ ItemIndex ] );

        Pt := Editor.RowColumnToPixels( Editor.BufferToDisplayPos( CurrCoord ) );
        Rct := {$IFDEF STANDALONE}Types.{$ENDIF}Rect( Pt.X, Pt.Y, Pt.X + Editor.CharWidth * Length( SearchResultText ), Pt.Y + Editor.LineHeight );

        if Attribute.Background <> clNone then
          begin
          ACanvas.Brush.Color := Attribute.Background;
          ACanvas.Brush.Style := bsSolid;
          end
        else
          begin
          if ( LineIndex = Editor.CharIndexToRowCol( Editor.SelStart ).Line ) AND ( Editor.ActiveLineColor <> clNone ) then
            begin
            ACanvas.Brush.Color := Editor.Color;
            ACanvas.Brush.Style := bsSolid;
            end
          else
            ACanvas.Brush.Style := bsClear;
          end;

        if Attribute.Foreground <> clNone then
          begin
          ACanvas.Pen.Color := Attribute.Foreground;
          ACanvas.Pen.Style := psSolid;

          ACanvas.Font.Color:= Attribute.Foreground;
          ACanvas.Font.Style:= Attribute.Style;      
          end
        else
          ACanvas.Pen.Style := psClear;

        if ( ACanvas.Brush.Style <> bsClear ) then
          begin
          ACanvas.FillRect( Rct );
          ACanvas.TextRect( Rct, Pt.X, Pt.Y, SearchResultText );
          end;

        if ( fFrameColor <> clNone ) AND ( fFrameColor <> Attribute.Background ) then
          begin
          ACanvas.Pen.Color := fFrameColor;
          ACanvas.Pen.Style := psSolid;
          ACanvas.Pen.Width := 2;
          ACanvas.MoveTo( Rct.Left, Rct.Top );
          ACanvas.LineTo( Rct.Right, Rct.Top );
          ACanvas.LineTo( Rct.Right, Rct.Bottom );
          ACanvas.LineTo( Rct.Left, Rct.Bottom );
          ACanvas.LineTo( Rct.Left, Rct.Top );
          ACanvas.Pen.Width := 1;
          end;
        end
      end;

    ACanvas.Font.Assign( OldFont );
  finally
    OldFont.Free;
  end;
  if Assigned( tmp ) then
    Editor.SearchEngine := tmp;
  if ( Editor.SearchEngine is TSynEditSearch ) then
    begin
    TSynEditSearch( Editor.SearchEngine ).CaseSensitive := bCS;
    TSynEditSearch( Editor.SearchEngine ).Whole         := bWW;
    end;
  if Assigned( Editor.SearchEngine ) then
    Editor.SearchEngine.Pattern := PBak;
end;
{$ENDIF}

{$IFEND TLH_INTERFACESECTION}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

{$IFNDEF TLH_OMIT_SECTIONS}
end.
{$ENDIF TLH_OMIT_SECTIONS}
