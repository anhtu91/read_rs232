unit uCheckStringGrid;

{
  uCheckStringGrid

  TetzkatLipHoka 2017-2019
}

{$DEFINE SORTING}
{$DEFINE CELLTYPES} // uses uTLH.ComponentTools

{.$DEFINE EXTENDED_STRINGGRID}

{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}

interface

uses
  Classes, Windows, Controls, Grids, Graphics, Menus, SysUtils, Messages
  {$IFDEF CELLTYPES},uTLH.ComponentTools{$ENDIF}
  ;

type
  {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF} = class;

  TCheckStringGridState = ( csNone, csInactiveUnchecked, csInactiveChecked, csUnchecked, csChecked );
  TCheckStringGridSortCompare = function ( Grid: {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}; ACol, Index1, Index2: Integer ): Integer;
  TCheckStringGridSortType = ( cstAscending, cstDescending, cstAscendingCaseSensitive, cstDescendingCaseSensitive, cstAscendingDate, cstDescendingDate, cstAscendingDateTime, cstDescendingDateTime );
  TCheckStringGridOnCheckBox = procedure( Sender : TObject; ACol, ARow : Integer; checkState : TCheckStringGridState ) of object;

  {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF} = class( Grids.TStringGrid )
  private
    { Private declarations }
    myPopUpMenu           : TPopUpMenu;
    fComponent            : Array of Array of TCheckStringGridState;
    fColor                : Array of Array of TColor;
    fFontColor            : Array of Array of TColor;
    fTextFormat           : Array of Array of Cardinal;
    fReadOnly             : Array of Array of Boolean;
    fCellHint             : Array of Array of String;
    fSelectable           : Array of Array of Boolean;
    {$IFDEF CELLTYPES}
    fCellType             : Array of Array of TOnKeyPressMode;
    {$ENDIF}

    fLastClickCol,
    fLastClickRow         : Integer;
    fSelectedRowColoring  : boolean;
    fSelectedRowColor     : TColor;
    fSelectedRowHeight    : Byte;
    fCheckedRowColoring   : boolean;
    fCheckedRowColor      : TColor;
    fSelectedCellColor    : TColor;
    fSelectedTextColor    : TColor;

    fModernScrolling      : Boolean;
    {$IFDEF SORTING}
    fSortCol              : Integer;
    fSortDescending       : Boolean;
    fSortColAllowed       : Array of Boolean;
    fSortColAsDate        : Array of Boolean;
    fDateFormat           : string;
    fTimeFormat           : string;
    fFloatFormat          : string;
    fLFS                  : TFormatSettings;
    fOnCheckBox           : TCheckStringGridOnCheckBox;
    fHint                 : String;
    fValueAsHint          : Boolean;

    procedure    QuickSort( ACol : Integer; StartId, EndId: Integer; SCompare: TCheckStringGridSortCompare );
    function     GetSortAllowedCol( ACol : Integer ) : Boolean;
    procedure    SetSortAllowedCol( ACol : Integer; value : Boolean );
    function     GetSortColAsDate( ACol : Integer ) : Boolean;
    procedure    SetSortColAsDate( ACol : Integer; value : Boolean );
    {$ENDIF}
    function     GetRowCount: Integer;
    procedure    SetRowCount( v: integer ); reintroduce;
    function     GetColCount: Integer;
    procedure    SetColCount( v: integer ); reintroduce;
    function     GetComponent( ACol, ARow: Integer ): TCheckStringGridState;
    procedure    SetComponent( ACol, ARow: Integer; value : TCheckStringGridState );
    function     GetDeleteMenu : boolean;
    procedure    SetDeleteMenu( value : boolean );
    function     GetMenuEnabled : boolean;
    procedure    SetMenuEnabled( value : boolean );
    function     GetCellColor( ACol, ARow : Integer ) : TColor;
    procedure    SetCellColor( ACol, ARow : Integer; value : TColor );
    function     GetFontColor( ACol, ARow : Integer ) : TColor;
    procedure    SetFontColor( ACol, ARow : Integer; value : TColor );
    function     GetTextFormat( ACol, ARow : Integer ) : Cardinal;
    procedure    SetTextFormat( ACol, ARow : Integer; value : Cardinal );

    function     GetReadOnly( ACol, ARow : Integer ) : Boolean;
    procedure    SetReadOnly( ACol, ARow : Integer; value : Boolean );
    function     GetCellHint( ACol, ARow : Integer ) : String;
    procedure    SetCellHint( ACol, ARow : Integer; value : String );
    function     GetReadOnlyCol( ACol : Integer ) : Boolean;
    procedure    SetReadOnlyCol( ACol : Integer; value : Boolean );
    function     GetReadOnlyRow( ARow : Integer ) : Boolean;
    procedure    SetReadOnlyRow( ARow : Integer; value : Boolean );
    function     GetSelectable( ACol, ARow : Integer ) : Boolean;
    procedure    SetSelectable( ACol, ARow : Integer; value : Boolean );
    function     GetSelectableCol( ACol : Integer ) : Boolean;
    procedure    SetSelectableCol( ACol : Integer; value : Boolean );
    function     GetSelectableRow( ARow : Integer ) : Boolean;
    procedure    SetSelectableRow( ARow : Integer; value : Boolean );

    function     GetCells( ACol, ARow: Integer ) : string; reintroduce;
    procedure    SetCells( ACol, ARow: Integer; const Value: string ); reintroduce;

    function     GetCellsAsBoolean( ACol, ARow: Integer ): Boolean;
    procedure    SetCellsAsBoolean( ACol, ARow: Integer; const Value: Boolean );
    function     GetCellsAsByte( ACol, ARow: Integer ): Byte;
    procedure    SetCellsAsByte( ACol, ARow: Integer; const Value: Byte );
    function     GetCellsAsShortInt( ACol, ARow: Integer ): ShortInt;
    procedure    SetCellsAsShortInt( ACol, ARow: Integer; const Value: ShortInt );
    function     GetCellsAsWord( ACol, ARow: Integer ): Word;
    procedure    SetCellsAsWord( ACol, ARow: Integer; const Value: Word );
    function     GetCellsAsSmallInt( ACol, ARow: Integer ): SmallInt;
    procedure    SetCellsAsSmallInt( ACol, ARow: Integer; const Value: SmallInt );
    function     GetCellsAsCardinal( ACol, ARow: Integer ): Cardinal;
    procedure    SetCellsAsCardinal( ACol, ARow: Integer; const Value: Cardinal );
    function     GetCellsAsInteger( ACol, ARow: Integer ): Integer;
    procedure    SetCellsAsInteger( ACol, ARow: Integer; const Value: Integer );
    function     GetCellsAsInt64( ACol, ARow: Integer ): Int64;
    procedure    SetCellsAsInt64( ACol, ARow: Integer; const Value: Int64 );
    {$IF CompilerVersion > 23}
    function     GetCellsAsUInt64( ACol, ARow: Integer ): UInt64;
    procedure    SetCellsAsUInt64( ACol, ARow: Integer; const Value: UInt64 );
    {$IFEND}
    function     GetCellsAsSingle( ACol, ARow: Integer ): Single;
    procedure    SetCellsAsSingle( ACol, ARow: Integer; const Value: Single );
    function     GetCellsAsDouble( ACol, ARow: Integer ): Double;
    procedure    SetCellsAsDouble( ACol, ARow: Integer; const Value: Double );
    function     GetCellsAsExtended( ACol, ARow: Integer ): Extended;
    procedure    SetCellsAsExtended( ACol, ARow: Integer; const Value: Extended );
    function     GetCellsAsDate( ACol, ARow: Integer ): TDate;
    procedure    SetCellsAsDate( ACol, ARow: Integer; const Value: TDate );
    function     GetCellsAsTime( ACol, ARow: Integer ): TTime;
    procedure    SetCellsAsTime( ACol, ARow: Integer; const Value: TTime );
    function     GetCellsAsDateTime( ACol, ARow: Integer ): TDateTime;
    procedure    SetCellsAsDateTime( ACol, ARow: Integer; const Value: TDateTime );
    {$IFDEF CELLTYPES}
    function     GetCellType( ACol, ARow : Integer ) : TOnKeyPressMode;
    procedure    SetCellType( ACol, ARow : Integer; value : TOnKeyPressMode );

    function     GetColType( ACol : Integer ) : TOnKeyPressMode;
    procedure    SetColType( ACol : Integer; value : TOnKeyPressMode );
    function     GetRowType( ARow : Integer ) : TOnKeyPressMode;
    procedure    SetRowType( ARow : Integer; value : TOnKeyPressMode );
    {$ENDIF}

    procedure    CheckStringGridPopUpClick( Sender : TObject );
    procedure    WMChar( var Message: TWMChar ); message WM_CHAR;
    procedure    SelectionChanged( OldCol, OldRow, NewCol, NewRow : Integer );
    procedure    SetSelectedRowHeight( value : Byte );
    function     GetRow : Integer;
    procedure    SetRow( Value: Integer ); reintroduce;

    function     GetScrollbarH : Boolean;
    function     GetScrollbarV : Boolean;
  protected
    { Protected declarations }
    procedure    DrawCell( ACol, ARow : LongInt; vRect : TRect; State : TGridDrawState ); override;
    procedure    ColumnMoved( FromIndex, ToIndex: Longint ); override;
    procedure    RowMoved( FromIndex, ToIndex: Longint ); override;
    procedure    MouseDown( Button: TMouseButton; Shift: TShiftState; X, Y: Integer ); override;
    procedure    KeyDown( var Key: Word; Shift: TShiftState ); override;
    procedure    DblClick; override;
    function     DoMouseWheelDown( Shift: TShiftState; MousePos: TPoint ): Boolean; override;
    function     DoMouseWheelUp( Shift: TShiftState; MousePos: TPoint ): Boolean; override;
    procedure    MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure    SetHint( value : string );
    {$IFDEF CELLTYPES}
    procedure    KeyPress(var Key: Char); override;
    {$ENDIF}
//    function     CreateEditor: TInplaceEdit; override;

    function     GetSelStart : Integer;
    procedure    SetSelStart( Value : Integer );
    function     GetSelEnd : Integer;
    procedure    SetSelEnd( Value : Integer );
    function     GetSelText : String;
    procedure    SetSelText( Value : String );
  public
    { Public declarations }
    constructor  Create( AOwner: TComponent ); reintroduce;
    destructor   Destroy; override;
    procedure    DelCol( v: integer );
    procedure    DelRow( v: integer );
    procedure    Clear( Full : boolean = True; IgnoreFixed : boolean = True );
    procedure    ClearCol( ACol : Integer; Full : boolean = True; IgnoreFixed : boolean = True );
    procedure    ClearRow( ARow : Integer; Full : boolean = True; IgnoreFixed : boolean = True );
    procedure    ClearCell( ACol, ARow : Integer; Full : boolean = True );    
    procedure    ExchangeItems( sCol, sRow, tCol, tRow : Integer );
    procedure    ExchangeCols( sCol, tCol : Integer );
    procedure    ExchangeRows( sRow, tRow : Integer );
    procedure    MoveCol( sCol, tCol : Integer );
    procedure    MoveRow( sRow, tRow : Integer );
    procedure    InflateColumns( DontShrink : boolean = false );
    procedure    SaveToFile( FileName : string; Separator : Char = ';' );
    procedure    GetSelection( var SelStart : Integer; var SelEnd : Integer );
    procedure    SetSelection( SelStart : Integer; SelEnd : Integer );

    {$IFDEF SORTING}
    procedure    Sort( ACol: Integer; Order : TCheckStringGridSortType );
    procedure    CustomSort( ACol : Integer; Compare: TCheckStringGridSortCompare );
    {$ENDIF}
    property     Component[ ACol, ARow : Integer ]     : TCheckStringGridState read GetComponent          write SetComponent;
    property     CellColor[ ACol, ARow : Integer ]     : TColor                read GetCellColor          write SetCellColor;
    property     FontColor[ ACol, ARow : Integer ]     : TColor                read GetFontColor          write SetFontColor;
    property     TextFormat[ ACol, ARow : Integer ]    : Cardinal              read GetTextFormat         write SetTextFormat;
    property     ReadOnly[ ACol, ARow : Integer ]      : Boolean               read GetReadOnly           write SetReadOnly;
    property     ReadOnlyCol[ ACol : Integer ]         : Boolean               read GetReadOnlyCol        write SetReadOnlyCol;
    property     ReadOnlyRow[ ACol : Integer ]         : Boolean               read GetReadOnlyRow        write SetReadOnlyRow;
    property     CellHint[ ACol, ARow : Integer ]      : String                read GetCellHint           write SetCellHint;
    property     Selectable[ ACol, ARow : Integer ]    : Boolean               read GetSelectable         write SetSelectable;
    property     SelectableCol[ ACol : Integer ]       : Boolean               read GetSelectableCol      write SetSelectableCol;
    property     SelectableRow[ ACol : Integer ]       : Boolean               read GetSelectableRow      write SetSelectableRow;
    {$IFDEF CELLTYPES}
    property     CellType[ ACol, ARow : Integer ]      : TOnKeyPressMode       read GetCellType           write SetCellType;
    property     ColType[ ACol : Integer ]             : TOnKeyPressMode       read GetColType            write SetColType;
    property     RowType[ ARow : Integer ]             : TOnKeyPressMode       read GetRowType            write SetRowType;
    {$ENDIF}
    {$IFDEF SORTING}
    property     SortColAllowed[ ACol : Integer ]      : Boolean               read GetSortAllowedCol     write SetSortAllowedCol;
    property     SortColAsDate[ ACol : Integer ]       : Boolean               read GetSortColAsDate      write SetSortColAsDate;
    {$ENDIF}
    property     Row                                   : integer               read GetRow                write SetRow;
    property     OnCheckBox                            : TCheckStringGridOnCheckBox read fOnCheckBox      write fOnCheckBox;    

    property     Cells[ ACol, ARow: Integer ]          : string                read GetCells              write SetCells;    
    property     CellsAsBoolean[ ACol, ARow: Integer ] : Boolean               read GetCellsAsBoolean     write SetCellsAsBoolean;
    property     CellsAsByte[ ACol, ARow: Integer ]    : Byte                  read GetCellsAsByte        write SetCellsAsByte;
    property     CellsAsShortInt[ ACol, ARow: Integer ]: ShortInt              read GetCellsAsShortInt    write SetCellsAsShortInt;
    property     CellsAsWord[ ACol, ARow: Integer ]    : Word                  read GetCellsAsWord        write SetCellsAsWord;
    property     CellsAsSmallInt[ ACol, ARow: Integer ]: SmallInt              read GetCellsAsSmallInt    write SetCellsAsSmallInt;
    property     CellsAsCardinal[ ACol, ARow: Integer ]: Cardinal              read GetCellsAsCardinal    write SetCellsAsCardinal;
    property     CellsAsInteger[ ACol, ARow: Integer]  : Integer               read GetCellsAsInteger     write SetCellsAsInteger;
    property     CellsAsInt64[ ACol, ARow: Integer ]   : Int64                 read GetCellsAsInt64       write SetCellsAsInt64;
    {$IF CompilerVersion > 23}
    property     CellsAsUInt64[ ACol, ARow: Integer ]  : UInt64                read GetCellsAsUInt64      write SetCellsAsUInt64;
    {$IFEND}
    property     CellsAsSingle[ ACol, ARow: Integer ]  : Single                read GetCellsAsSingle      write SetCellsAsSingle;
    property     CellsAsDouble[ ACol, ARow: Integer ]  : Double                read GetCellsAsDouble      write SetCellsAsDouble;
    property     CellsAsExtended[ ACol, ARow: Integer ]: Extended              read GetCellsAsExtended    write SetCellsAsExtended;
    property     CellsAsDate[ ACol, ARow: Integer ]    : TDate                 read GetCellsAsDate        write SetCellsAsDate;
    property     CellsAsTime[ ACol, ARow: Integer ]    : TTime                 read GetCellsAsTime        write SetCellsAsTime;
    property     CellsAsDateTime[ ACol, ARow: Integer ]: TDateTime             read GetCellsAsDateTime    write SetCellsAsDateTime;
  published
    { Published declarations }
    property     RowCount                              : integer               read GetRowCount           write SetRowCount;
    property     ColCount                              : integer               read GetColCount           write SetColCount;
    property     MenuEnabled                           : boolean               read GetMenuEnabled        write SetMenuEnabled;
    property     DeleteMenu                            : boolean               read GetDeleteMenu         write SetDeleteMenu;
    property     SelectedRowColoring                   : Boolean               read fSelectedRowColoring  write fSelectedRowColoring;
    property     SelectedRowColor                      : TColor                read fSelectedRowColor     write fSelectedRowColor;
    property     SelectedRowHeight                     : Byte                  read fSelectedRowHeight    write SetSelectedRowHeight;
    property     CheckedRowColoring                    : Boolean               read fCheckedRowColoring   write fCheckedRowColoring;
    property     CheckedRowColor                       : TColor                read fCheckedRowColor      write fCheckedRowColor;
    property     SelectedCellColor                     : TColor                read fSelectedCellColor    write fSelectedCellColor;
    property     SelectedTextColor                     : TColor                read fSelectedTextColor    write fSelectedTextColor;
    property     ModernScrolling                       : Boolean               read fModernScrolling      write fModernScrolling;
    property     DateFormat                            : string                read fDateFormat           write fDateFormat;
    property     TimeFormat                            : string                read fTimeFormat           write fTimeFormat;
    property     OnResize;
    property     Hint                                  : string                read fHint                 write SetHint;
    property     ValueAsHint                           : boolean               read fValueAsHint          write fValueAsHint;

    property     ScrollbarH                            : boolean               read GetScrollbarH;
    property     ScrollbarV                            : boolean               read GetScrollbarV;

    property     SelStart                              : Integer               read GetSelStart           write SetSelStart;
    property     SelEnd                                : Integer               read GetSelEnd             write SetSelEnd;
    property     SelText                               : String                read GetSelText            write SetSelText;
  end;

{$IFDEF EXTENDED_STRINGGRID}
  TCheckStringGrid = class( TStringGrid );
{$ENDIF}


// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
implementation

uses
  Math, Forms;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
const
  DEFAULT_SELECTED_LINE_COLOR_    : TColor = clBlue;
  DEFAULT_SELECTED_CELL_COLOR_    : TColor = clBlue;
  DEFAULT_SELECTED_TEXT_COLOR_    : TColor = clWhite;
  DEFAULT_CHECKED_LINE_COLOR_     : TColor = clGray;

  DEFAULT_TEXT_FORMAT_                     = DT_LEFT;
  DEFAULT_DATE_FORMAT_                     = 'yyyy/mm/dd';
  DEFAULT_TIME_FORMAT_                     = 'hh:nn:ss,zzz';
  DEFAULT_FLOAT_FORMAT_                    = '%.3f';

  CAPTION_SELECT_ALL_     : string = 'Select all';
  CAPTION_SELECT_NONE_    : string = 'Select none';
  CAPTION_SELECT_INVERSE_ : string = 'Inverse selection';
  CAPTION_DELETE_ROW_     : string = 'Delete Row';
  CAPTION_DELETE_COL_     : string = 'Delete Col';
//  CAPTION_SELECT_ALL_     : string = 'Alle auswählen';
//  CAPTION_SELECT_NONE_    : string = 'Keine auswählen';
//  CAPTION_SELECT_INVERSE_ : string = 'Auswahl umkehren';
//  CAPTION_DELETE_ROW_     : string = 'Zeile Löschen';
//  CAPTION_DELETE_COL_     : string = 'Spalte Löschen';

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
constructor {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.Create( AOwner: TComponent );
var
  i    : Integer;
  Item : TMenuItem;
begin
  inherited Create( AOwner );

  fLastClickCol         := 0;
  fLastClickRow         := 0;
  fSelectedRowColoring  := false;
  fSelectedRowColor     := DEFAULT_SELECTED_LINE_COLOR_;
  fSelectedRowHeight    := 0;
  fCheckedRowColoring   := false;
  fCheckedRowColor      := DEFAULT_CHECKED_LINE_COLOR_;
  fSelectedTextColor    := DEFAULT_SELECTED_TEXT_COLOR_;
  fSelectedCellColor    := DEFAULT_SELECTED_CELL_COLOR_;
  fModernScrolling      := True;
  fDateFormat           := DEFAULT_DATE_FORMAT_;
  fTimeFormat           := DEFAULT_TIME_FORMAT_;
  fFloatFormat          := DEFAULT_FLOAT_FORMAT_;
  fHint                 := '';
  fValueAsHint          := false;

  {$IFDEF SORTING}
  fSortCol              := -1;
  fSortDescending       := false;
  {$ENDIF}

  Options := [ goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goRangeSelect,goDrawFocusSelected,goColSizing,goTabs,goAlwaysShowEditor];
  DefaultDrawing := False; 

  SetLength( fComponent, ColCount, RowCount );
  SetLength( fColor, ColCount, RowCount );
  SetLength( fFontColor, ColCount, RowCount );
  SetLength( fTextFormat, ColCount, RowCount );
  SetLength( fReadOnly, ColCount, RowCount );
  SetLength( fCellHint, ColCount, RowCount );  
  SetLength( fSelectable, ColCount, RowCount );
  {$IFDEF CELLTYPES}
  SetLength( fCellType, ColCount, RowCount );
  {$ENDIF}

  {$IFDEF SORTING}
  SetLength( fSortColAllowed, ColCount );
  SetLength( fSortColAsDate, ColCount );
  {$ENDIF}
  Clear( True, True );

  myPopUpMenu := TPopUpMenu.Create( Self );
//  myPopUpMenu.Name := name + '_PopUpMenu';
  for i := 0 to 4 do
    begin
    Item := TMenuItem.Create( myPopUpMenu );
    with Item do
      begin
//      Item.Name := name + '_PopUpMenuItem_' + IntToStr( i+1 );
      OnClick := CheckStringGridPopUpClick;
      case i of
        0 : Caption := CAPTION_SELECT_ALL_;
        1 : Caption := CAPTION_SELECT_NONE_;
        2 : Caption := CAPTION_SELECT_INVERSE_;
        3 : Caption := CAPTION_DELETE_ROW_;
        4 : Caption := CAPTION_DELETE_COL_;
      end;
      end;
    myPopUpMenu.Items.Add( Item );
    end;

  PopUpMenu := myPopUpMenu;

  GetLocaleFormatSettings( 0, fLFS );  
end;

destructor {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.Destroy;
begin
  if NOT Assigned( self ) then
    Exit;

  SetLength( fComponent, 0 );
  SetLength( fColor, 0 );
  SetLength( fFontColor, 0 );
  SetLength( fTextFormat, 0 );
  SetLength( fReadOnly, 0 );
  SetLength( fCellHint, 0 );
  SetLength( fSelectable, 0 );
  {$IFDEF CELLTYPES}
  SetLength( fCellType, 0 );
  {$ENDIF}
  {$IFDEF SORTING}
  SetLength( fSortColAllowed, 0 );
  SetLength( fSortColAsDate, 0 );
  {$ENDIF}
  myPopUpMenu.Free;

  inherited;
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.DrawCell( ACol, ARow : LongInt; vRect : TRect; State : TGridDrawState );
  procedure DrawArrow( Canvas : TCanvas; vRect : TRect; Offset : Byte; Orientation : Byte = 0; Color : TColor = clBlack; FillColor : TColor = clBlack );
  var
    C1, C2 : TColor;
  begin
    C1 := Canvas.Pen.Color;
    C2 := Canvas.Brush.Color;
    Canvas.Pen.Color   := clBlack;
    Canvas.Brush.Color := clBlack;

    case Orientation of
      0 : begin // Up
          Canvas.Polygon( [
            Point( vRect.Left + ( ( vRect.Right-vRect.Left ) div 2 ), vRect.Top+Offset ),
            Point( vRect.Left+Offset, vRect.Bottom-Offset ),
            Point( vRect.Right-Offset, vRect.Bottom-Offset )
            ] );
          end;
      1 : begin // Down
          Canvas.Polygon( [
            Point( vRect.Left + ( ( vRect.Right-vRect.Left ) div 2 ), vRect.Bottom-Offset ),
            Point( vRect.Left+Offset, vRect.Top+Offset ),
            Point( vRect.Right-Offset, vRect.Top+Offset )
            ] );
          end;
    else
      Exit;
    end;

    Canvas.Pen.Color   := C1;
    Canvas.Brush.Color := C2;
  end;
var
  cs           : Cardinal;
  clr          : TColor;
  bs           : TBrushStyle;
  SelCellColor : boolean;
  FrameFlags1,
  FrameFlags2  : Cardinal;
  TempRect     : TRect;
  DrawInfo     : TGridDrawInfo;
begin
  if NOT Assigned( self ) then
    Exit;

  inherited DrawCell( ACol, ARow, vRect, State );

  Canvas.Font := Font;
  if ( fFontColor[ ACol, ARow ] <> -1 ) then
    Canvas.Font.Color := fFontColor[ ACol, ARow ];

  FrameFlags1 := 0;
  FrameFlags2 := 0;
  if goFixedVertLine in Options then
    begin
    FrameFlags1 := BF_RIGHT;
    FrameFlags2 := BF_LEFT;
    end;
  if goFixedHorzLine in Options then
    begin
    FrameFlags1 := FrameFlags1 or BF_BOTTOM;
    FrameFlags2 := FrameFlags2 or BF_TOP;
    end;
  SelCellColor := ( goDrawFocusSelected in Options );
  clr := -1;
  
  if ( fColor[ ACol, ARow ] <> -1 ) then
    begin
    clr := Canvas.Brush.Color;
    Canvas.Brush.Color := fColor[ ACol, ARow ];
    Canvas.FillRect( vRect );
    end
  else if ( gdFixed in State ) and Ctl3D and ( ( FrameFlags1 or FrameFlags2 ) <> 0 ) then
    begin
    Canvas.FillRect( vRect );
    CalcDrawInfo( DrawInfo );

    TempRect := vRect;
    if ( FrameFlags1 and BF_RIGHT ) = 0 then
      Inc( TempRect.Right, DrawInfo.Horz.EffectiveLineWidth )
    else if ( FrameFlags1 and BF_BOTTOM ) = 0 then
      Inc( TempRect.Bottom, DrawInfo.Vert.EffectiveLineWidth );
    DrawEdge( Canvas.Handle, TempRect, BDR_RAISEDINNER, FrameFlags1 );
    DrawEdge( Canvas.Handle, TempRect, BDR_RAISEDINNER, FrameFlags2 );
    end
  else if ( NOT ( gdFixed in State ) AND ( ARow = Row ) AND ( ( fSelectedRowColoring OR ( goRowSelect in Options ) ) OR ( ( ACol = Col ) AND SelCellColor ) ) ) or // SelectedRow
          ( ( goRangeSelect in Options ) AND ( ( ACol >= Selection.Left ) AND ( ACol <= Selection.Right ) AND ( ARow >= Selection.Top ) AND ( ARow <= Selection.Bottom ) ) ) then // Selected Range
    begin
    clr := Canvas.Brush.Color;
    if ( ACol = Col ) AND ( ARow = Row ) AND SelCellColor then
      Canvas.Brush.Color := fSelectedCellColor
    else
      Canvas.Brush.Color := fSelectedRowColor;

    Canvas.FillRect( vRect );
    Canvas.Font.Color := fSelectedTextColor
    end
  else if fCheckedRowColoring AND ( fComponent[ 0, ARow ] in [ csChecked, csInActiveChecked ] ) then // Checked
    begin
    clr := Canvas.Brush.Color;
    Canvas.Brush.Color := fCheckedRowColor;
    Canvas.FillRect( vRect );
    Canvas.Font.Color := fSelectedTextColor
    end
  else
    Canvas.FillRect( vRect );

  if ( fComponent[ ACol, aRow ] <> csNone ) then
    begin
    InflateRect( vRect, -1, -1 );
    case fComponent[ ACol, ARow ] of
      csNone              : cs := DFCS_INACTIVE;
      csInactiveUnchecked : cs := DFCS_BUTTONCHECK OR DFCS_MONO;
      csInactiveChecked   : cs := DFCS_BUTTONCHECK or DFCS_CHECKED OR DFCS_MONO;
      csUnChecked         : cs := DFCS_BUTTONCHECK;
      csChecked           : cs := DFCS_BUTTONCHECK or DFCS_CHECKED;
    else
      cs := DFCS_INACTIVE;
    end;

    if ( Cells[ ACol, ARow ] <> '' ) then
      begin
      TempRect := vRect;
      TempRect.Right := vRect.Left + ( vRect.Bottom - vRect.Top );
      DrawFrameControl( Canvas.Handle, TempRect, DFC_Button, cs );

      TempRect := vRect;
      TempRect.Left := vRect.Left + ( vRect.Bottom - vRect.Top ) + 2;
      DrawText( Canvas.Handle, PChar( Cells[ ACol, ARow ] ), Length( Cells[ ACol, ARow ] ), TempRect, fTextFormat[ ACol, ARow ] );
      end
    else
      DrawFrameControl( Canvas.Handle, vRect, DFC_Button, cs );
    end
  else
    begin
    vRect.Left := vRect.Left+2;
    vRect.Top := vRect.Top+2;

    bs := Canvas.Brush.Style;
    Canvas.Brush.Style := bsClear;

    DrawText( Canvas.Handle, PChar( Cells[ ACol, ARow ] ), Length( Cells[ ACol, ARow ] ), vRect, fTextFormat[ ACol, ARow ] );

    Canvas.Brush.Style := bs;
    end;

  if ( ARow = 0 ) AND ( ACol = fSortCol ) then
    DrawArrow( Canvas, Rect( vRect.Right-( ( vRect.Bottom-vRect.Top ) div 2 ), vRect.Top, vRect.Right, vRect.Top+( ( vRect.Bottom-vRect.Top ) div 2 ) ), 2, Byte( fSortDescending ) );

  if ( clr <> -1 ) then
    Canvas.Brush.Color := clr;

//  if SelCellColor AND ( gdFocused in State ) then
//    Canvas.DrawFocusRect( vRect ); // Fail if ( goRowSelect in Options )
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.ColumnMoved( FromIndex, ToIndex: Longint );
var
  i   : Integer;
  css : TCheckStringGridState;
  clr : TColor;
  tf  : Cardinal;
  b   : boolean;
  s   : string;
  {$IFDEF CELLTYPES}
  k   : TOnKeyPressMode;
  {$ENDIF}
begin
  if NOT Assigned( self ) then
    Exit;

  for i := 0 to RowCount-1 do
    begin
    css := fComponent[ ToIndex, i ];
    fComponent[ ToIndex, i ] := fComponent[ FromIndex, i ];
    fComponent[ FromIndex, i ] := css;

    clr := fColor[ ToIndex, i ];
    fColor[ ToIndex, i ] := fColor[ FromIndex, i ];
    fColor[ FromIndex, i ] := clr;

    clr := fFontColor[ ToIndex, i ];
    fFontColor[ ToIndex, i ] := fFontColor[ FromIndex, i ];
    fFontColor[ FromIndex, i ] := clr;

    tf := fTextFormat[ ToIndex, i ];
    fTextFormat[ ToIndex, i ] := fTextFormat[ FromIndex, i ];
    fTextFormat[ FromIndex, i ] := tf;

    b := fReadOnly[ ToIndex, i ];
    fReadOnly[ ToIndex, i ] := fReadOnly[ FromIndex, i ];
    fReadOnly[ FromIndex, i ] := b;

    {$IFDEF CELLTYPES}
    k := fCellType[ ToIndex, i ];
    fCellType[ ToIndex, i ] := fCellType[ FromIndex, i ];
    fCellType[ FromIndex, i ] := k;
    {$ENDIF}

    s := fCellHint[ ToIndex, i ];
    fCellHint[ ToIndex, i ] := fCellHint[ FromIndex, i ];
    fCellHint[ FromIndex, i ] := s;

    b := fSelectable[ ToIndex, i ];
    fSelectable[ ToIndex, i ] := fSelectable[ FromIndex, i ];
    fSelectable[ FromIndex, i ] := b;
    end;

  inherited;

  SelectionChanged( FromIndex, Row, ToIndex, Row );
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.RowMoved( FromIndex, ToIndex: Longint );
var
  i   : Integer;
  css : TCheckStringGridState;
  clr : TColor;
  tf  : Cardinal;
  b   : boolean;
  s   : String;
  {$IFDEF CELLTYPES}
  k   : TOnKeyPressMode;
  {$ENDIF}
begin
  if NOT Assigned( self ) then
    Exit;

  for i := 0 to ColCount-1 do
    begin
    css := fComponent[ i, ToIndex ];
    fComponent[ i, ToIndex ] := fComponent[ i, FromIndex ];
    fComponent[ i, FromIndex ] := css;

    clr := fColor[ i, ToIndex ];
    fColor[ i, ToIndex ] := fColor[ i, FromIndex ];
    fColor[ i, FromIndex ] := clr;

    clr := fFontColor[ i, ToIndex ];
    fFontColor[ i, ToIndex ] := fFontColor[ i, FromIndex ];
    fFontColor[ i, FromIndex ] := clr;

    tf := fTextFormat[ i, ToIndex ];
    fTextFormat[ i, ToIndex ] := fTextFormat[ i, FromIndex ];
    fTextFormat[ i, FromIndex ] := tf;

    b := fReadOnly[ i, ToIndex ];
    fReadOnly[ i, ToIndex ] := fReadOnly[ i, FromIndex ];
    fReadOnly[ i, FromIndex ] := b;

    {$IFDEF CELLTYPES}
    k := fCellType[ i, ToIndex ];
    fCellType[ i, ToIndex ] := fCellType[ i, FromIndex ];
    fCellType[ i, FromIndex ] := k;
    {$ENDIF}    

    s := fCellHint[ i, ToIndex ];
    fCellHint[ i, ToIndex ] := fCellHint[ i, FromIndex ];
    fCellHint[ i, FromIndex ] := s;

    b := fSelectable[ i, ToIndex ];
    fSelectable[ i, ToIndex ] := fSelectable[ i, FromIndex ];
    fSelectable[ i, FromIndex ] := b;
    end;

  inherited;    

  SelectionChanged( Col, FromIndex, Col, ToIndex );
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.MouseDown( Button: TMouseButton; Shift: TShiftState; X, Y: Integer );
var
  iCol, iRow   : Integer;
  sCol, eCol   : Integer;
  sRow, eRow   : Integer;
  i, j         : integer;
  R            : TRect;
  bCompClicked : boolean;
begin
  sCol := Col;
  sRow := Row;
//  inherited;

  if ( Button <> mbLeft ) then
    begin
    inherited;
    Exit;
    end;

  MouseToCell( x, y, iCol, iRow );
  if ( iCol < 0 ) or ( iRow < 0 ) then
    Exit;

  if NOT fSelectable[ iCol, iRow ] then 
    begin
    Col := sCol;
    Row := sRow;
    Exit;
    end;
    
  inherited;
  if ( iCol >= ColCount ) OR ( iRow >= RowCount ) then
    Exit;

  fLastClickCol := iCol;
  fLastClickRow := iRow;

  if ( ssShift in Shift ) then
    begin
    if ( sRow > Row ) then
      begin
      sRow := Row;
      eRow := sRow;
      end
    else
      begin
      sRow := sRow;
      eRow := Row;
      end;

    if ( goRowSelect in Options ) then
      begin
      sCol := 0;
      eCol := ColCount-1;
      end
    else
      begin
      if ( Col > iCol ) then
        begin
        sCol := iCol;
        eCol := Col;
        end
      else
        begin
        sCol := Col;
        eCol := iCol;
        end;
      end;

    for i := sCol to eCol do
      begin
      for j := sRow to eRow do
        begin
        if ( ssCTRL in Shift ) then
          begin
          if fComponent[ i, j ] = csUnchecked then
            begin
            if Assigned( fOnCheckBox ) AND ( fComponent[ i, j ] <> csChecked ) then
              fOnCheckBox( Self, i, j, csChecked );

            fComponent[ i, j ] := csChecked;
            if NOT fCheckedRowColoring then
              InvalidateCell( i, j );
            end
          else if fComponent[ i, j ] = csChecked then
            begin
            if Assigned( fOnCheckBox ) AND ( fComponent[ i, j ] <> csUnChecked ) then
              fOnCheckBox( Self, i, j, csUnchecked );

            fComponent[ i, j ] := csUnchecked;
            if NOT fCheckedRowColoring then
              InvalidateCell( i, j );
            end;
          end
        else
          begin
          if fComponent[ i, j ] = csUnchecked then
            begin
            if Assigned( fOnCheckBox ) AND ( fComponent[ i, j ] <> csChecked ) then
              fOnCheckBox( Self, i, j, csChecked );

            fComponent[ i, j ] := csChecked;
            if NOT fCheckedRowColoring then
              InvalidateCell( i, j );
            end;
          end;

        if fCheckedRowColoring then
          InvalidateRow( j );
        end;
      end;
    Exit;
    end
  else if ( ssCTRL in Shift ) then
    begin
    if ( goRowSelect in Options ) then
      begin
      for i := 0 to ColCount-1 do
        begin
        if fComponent[ i, iRow ] = csUnchecked then
          begin
          if Assigned( fOnCheckBox ) AND ( fComponent[ i, iRow ] <> csChecked ) then
            fOnCheckBox( Self, i, iRow, csChecked );

          fComponent[ i, iRow ] := csChecked;
          if NOT fCheckedRowColoring then
            InvalidateCell( i, iRow );
          end
        else if fComponent[ i, iRow ] = csChecked then
          begin
          if Assigned( fOnCheckBox ) AND ( fComponent[ i, iRow ] <> csUnChecked ) then
            fOnCheckBox( Self, i, iRow, csUnChecked );

          fComponent[ i, iRow ] := csUnchecked;
          if NOT fCheckedRowColoring then
            InvalidateCell( i, iRow );
          end;
        end;
      if fCheckedRowColoring then
        InvalidateRow( iRow );
      end
    else
      begin
      if fComponent[ iCol, iRow ] = csUnchecked then
        begin
        if Assigned( fOnCheckBox ) AND ( fComponent[ iCol, iRow ] <> csChecked ) then
          fOnCheckBox( Self, iCol, iRow, csChecked );

        fComponent[ iCol, iRow ] := csChecked;
        if NOT fCheckedRowColoring then
          InvalidateCell( iCol, iRow )
        else
          InvalidateRow( iRow );
        end
      else if fComponent[ iCol, iRow ] = csChecked then
        begin
        if Assigned( fOnCheckBox ) AND ( fComponent[ iCol, iRow ] <> csUnChecked ) then
          fOnCheckBox( Self, iCol, iRow, csUnChecked );

        fComponent[ iCol, iRow ] := csUnchecked;
        if NOT fCheckedRowColoring then
          InvalidateCell( iCol, iRow )
        else
          InvalidateRow( iRow );
        end;
      end;
    Exit;
    end;

  bCompClicked := false;
  if ( Cells[ iCol, iRow ] = '' ) then
    begin
    case fComponent[ iCol, iRow ] of
      csUnchecked  : begin
                     fComponent[ iCol, iRow ] := csChecked;
                     bCompClicked := True;
                     end;
      csChecked    : begin
                     fComponent[ iCol, iRow ] := csUnchecked;
                     bCompClicked := True;
                     end;
    end;

    if bCompClicked AND Assigned( fOnCheckBox ) then
      fOnCheckBox( Self, iCol, iRow, fComponent[ iCol, iRow ] );
    end
  else
    begin
    R := CellRect( iCol, iRow );
    if ( x <= R.Left + ( R.Bottom - R.Top ) ) then
      begin
      case fComponent[ iCol, iRow ] of
        csUnchecked  : begin
                       fComponent[ iCol, iRow ] := csChecked;
                       bCompClicked := True;
                       end;
        csChecked    : begin
                       fComponent[ iCol, iRow ] := csUnchecked;
                       bCompClicked := True;
                       end;
      end;

      if bCompClicked AND Assigned( fOnCheckBox ) then
        fOnCheckBox( Self, iCol, iRow, fComponent[ iCol, iRow ] );
      end;
    end;

  if bCompClicked AND ( ( iCol <= FixedCols-1 ) OR ( iRow <= FixedRows-1 ) ) then
    begin
    if NOT fCheckedRowColoring then
      InvalidateCell( iCol, iRow )
    else
      InvalidateRow( iRow );
    end;
  if ( goEditing in Options ) AND EditorMode AND ( fReadOnly[ iCol, iRow ] OR bCompClicked ) then
    HideEditor;

  SelectionChanged( sCol, sRow, Col, Row );
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.KeyDown(var Key: Word; Shift: TShiftState);
var
  i          : Integer;
  sCol, eCol : Integer;
  sRow       : Integer;
begin
  sCol := Col;
  sRow := Row;
  inherited;

  if ( Key in [ VK_SPACE ] ) then
    begin
    for i := 0 to ColCount-1 do
      begin
      if ( NOT ( goRowSelect in Options ) ) AND NOT ( i = Col ) then
        Continue;
      if fComponent[ i, Row ] = csUnchecked then
        begin
        fComponent[ i, Row ] := csChecked;
        if NOT fCheckedRowColoring then
          InvalidateCell( i, Row );
        end
      else if fComponent[ i, Row ] = csChecked then
        begin
        fComponent[ i, Row ] := csUnchecked;
        if NOT fCheckedRowColoring then
          InvalidateCell( i, Row );
        end;
      end;

    if fCheckedRowColoring then
      InvalidateRow( Row );
    Exit;
    end;

  if NOT fSelectable[ Col, Row ] then
    begin
    Col := sCol;
    Row := sRow;
    Exit;
    end;

  SelectionChanged( sCol, sRow, Col, Row );

  if NOT ( Key in [ VK_LEFT, VK_RIGHT, VK_UP, VK_DOWN ] ) then
    Exit;
  eCol := Col;

  if ( ssShift in Shift ) then
    begin
    if ( goRowSelect in Options ) then
      begin
      sCol := 0;
      eCol := ColCount-1;
      end
    else
      begin
      if ( sCol > Col ) then
        begin
        eCol := sCol;
        sCol := Col;
        end;
      end;

    for i := sCol to eCol do
      begin
      if fComponent[ i, Row ] = csUnchecked then
        begin
        fComponent[ i, Row ] := csChecked;
        InvalidateCell( i, Row );
        end
      else if fComponent[ i, Row ] = csChecked then
        begin
        fComponent[ i, Row ] := csUnchecked;
        InvalidateCell( i, Row );
        end;
      end;
    end;
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.DblClick;
var
  Order : TCheckStringGridSortType;
begin
  if ( fLastClickRow < FixedRows ) AND ( fLastClickCol >= FixedCols ) then
    begin
    {$IFDEF SORTING}
    if NOT fSortColAllowed[ fLastClickCol ] then
      Exit;

    if fSortColAsDate[ fLastClickCol ] then
      Order := cstAscendingDate
    else
      Order := cstAscending;

    if ( fSortCol = fLastClickCol ) AND NOT fSortDescending then
      begin
      if fSortColAsDate[ fLastClickCol ] then
        Order := cstDescendingDate
      else
        Order := cstDescending;
      end;

    Sort( fLastClickCol, Order );
    InvalidateRow( fLastClickRow ); // Sort-Arrow .. 
    {$ENDIF}

    Exit;
    end;

  if ( fLastClickCol <= FixedCols-1 ) then
    Exit;

  if fReadOnly[ fLastClickCol, fLastClickRow ] then
    Exit;                                          

  if NOT EditorMode then
    ShowEditor
  else
    InvalidateCell( fLastClickCol, fLastClickRow );

  inherited;    
end;

function {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  result := false;
  if fModernScrolling then
    begin
    if TopRow+VisibleRowCount <= RowCount-1 then
      begin
      TopRow := TopRow+1;
      result := True;
      InvalidateGrid;
      end;
    end
  else
    begin
    Result := inherited DoMouseWheelDown(Shift, MousePos);

    if result then
      SelectionChanged( Col, Row-1, Col, Row );
    end;
end;

function {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  result := false;
  if fModernScrolling then
    begin
    if TopRow > 1 then
      begin
      TopRow := TopRow-1;
      result := True;
      InvalidateGrid;
      end;
    end
  else
    begin
    Result := inherited DoMouseWheelUp(Shift, MousePos);

    if result then
      SelectionChanged( Col, Row+1, Col, Row );
    end;
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  ACol,
  ARow : Integer;
  iHint,
  tHint : string;
begin
  if NOT ShowHint then
    begin
    inherited;
    Exit;
    end;

  MouseToCell( X, Y, ACol, ARow );
  if ( ACol = -1 ) OR ( ARow = -1 ) then
    begin
    inherited;
    Exit;
    end;

  iHint := inherited Hint;
  tHint := fHint;
  if ( fCellHint[ ACol, ARow ] <> '' ) then
    tHint := fCellHint[ ACol, ARow ]
  else if fValueAsHint then
    tHint := Cells[ ACol, ARow ];

  if ( iHint <> tHint ) then
    begin
    inherited Hint := tHint;
    Application.CancelHint;
    Application.ActivateHint( Point( X, Y ) );
    end;

  inherited;
end;

{$IFDEF CELLTYPES}
procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.KeyPress( var Key: Char );
begin
  OnKeyPressCheckChar( Self, Key, fCellType[ Col, Row ] );
  inherited;
end;
{$ENDIF}

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.SetHint( value : string );
begin
  if ( fHint = Value ) then
    Exit;
  fHint       := Value;

  inherited Hint := value;
end;

//function {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.CreateEditor: TInplaceEdit;
//begin
//  Result := TDataGridInplaceEdit.Create( Self );
//end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.SelectionChanged( OldCol, OldRow, NewCol, NewRow : Integer );
begin
  if NOT ( OldRow <> NewRow ) then
    Exit;

  if ( fSelectedRowHeight <> 0 ) then
    begin
    RowHeights[ NewRow ] := fSelectedRowHeight;
    RowHeights[ OldRow ] := DefaultRowHeight;
    end;

  if fSelectedRowColoring then
    begin
    InvalidateRow( OldRow );
    InvalidateRow( NewRow );
    end
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.WMChar( var Message: TWMChar );
begin
  if fReadOnly[ Col, Row ] then
    Exit;

  if not DoKeyPress( Message ) then
   inherited;
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.CheckStringGridPopUpClick( Sender : TObject );
var
  i, j, idx : integer;
begin
  if NOT Assigned( self ) then
    Exit;

  if NOT ( Sender is TMenuItem ) then
    Exit;

  if ( Sender = myPopUpMenu.Items[ 0 ] ) then
    idx := 0
  else if ( Sender = myPopUpMenu.Items[ 1 ] ) then
    idx := 1
  else if ( Sender = myPopUpMenu.Items[ 2 ] ) then
    idx := 2
  else if ( Sender = myPopUpMenu.Items[ 3 ] ) then
    idx := 3
  else if ( Sender = myPopUpMenu.Items[ 4 ] ) then 
    idx := 4
  else
    Exit;

  for i := ColCount-1 downTo 0 do
    begin
    for j := RowCount-1 downTo 0 do
      begin
      case idx of 
        0 : begin
            if ( fComponent[ i, j ] = csUnchecked ) then
              begin
              fComponent[ i, j ] := csChecked;

              if Assigned( fOnCheckBox ) then
                fOnCheckBox( Sender, i, j, fComponent[ i, j ] );
              end;
//            else
//              Continue;
//
//            InvalidateCell( i, j );
            end;
        1 : begin
            if ( fComponent[ i, j ] = csChecked ) then
              begin
              fComponent[ i, j ] := csUnchecked;

              if Assigned( fOnCheckBox ) then
                fOnCheckBox( Sender, i, j, fComponent[ i, j ] );
              end;
//            else
//              Continue;
//
//            InvalidateCell( i, j );
            end;
        2 : begin
            if ( fComponent[ i, j ] = csUnchecked ) then
              begin
              fComponent[ i, j ] := csChecked;

              if Assigned( fOnCheckBox ) then
                fOnCheckBox( Sender, i, j, fComponent[ i, j ] );
              end
            else if ( fComponent[ i, j ] = csChecked ) then
              begin
              fComponent[ i, j ] := csUnchecked;

              if Assigned( fOnCheckBox ) then
                fOnCheckBox( Sender, i, j, fComponent[ i, j ] );
              end;
//            else
//              Continue;
//
//            InvalidateCell( i, j );
            end;
        3 : begin
            if ( fComponent[ i, j ] = csChecked ) then
              begin
              DelRow( j );
//              InvalidateGrid;
              break;
              end;
            end;
        4 : begin
            if ( fComponent[ i, j ] = csChecked ) then
              begin
              DelCol( i );
//              InvalidateGrid;
              break;
              end;
            end;
      end;
      end;
    end;
  InvalidateGrid;
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.GetRowCount: integer;
begin
  result := 0;
  if NOT Assigned( self ) then
    Exit;
  result := inherited RowCount;
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.SetRowCount( v: integer );
var
  old    : Integer;
  i, j   : Integer;
  ROCols : Array of Boolean;
begin
  if NOT Assigned( self ) then
    Exit;

  if ( v < 1 ) OR ( v = RowCount ) then
    Exit;

  SetLength( ROCols, ColCount );
  for i := 0 to ColCount-1 do
    ROCols[ i ] := GetReadOnlyCol( i );

  old := RowCount;
  SetLength( fComponent, ColCount, v );
  SetLength( fColor, ColCount, v );
  SetLength( fFontColor, ColCount, v );
  SetLength( fTextFormat, ColCount, v );
  SetLength( fReadOnly, ColCount, v );
  {$IFDEF CELLTYPES}
  SetLength( fCellType, ColCount, v );
  {$ENDIF}
  SetLength( fCellHint, ColCount, v );  
  SetLength( fSelectable, ColCount, v );

  for i := 0 to ColCount-1 do
    begin
    for j := old to v-1 do
      ClearCell( i, j );

    if ROCols[ i ] then
      SetReadOnlyCol( i, True );
    end;
  SetLength( ROCols, 0 );

  inherited RowCount := v;
  for i := 0 to ColCount-1 do
    begin
    for j := old to v-1 do
      ClearCell( i, j, false );
    end;
end;

function {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.GetScrollbarH : Boolean;
begin
  result := ( ( GetWindowlong( Handle, GWL_STYLE ) and WS_HSCROLL ) <> 0 );
end;

function {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.GetScrollbarV : Boolean;
begin
  result := ( ( GetWindowlong( Handle, GWL_STYLE ) and WS_VSCROLL ) <> 0 );
end;

function {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.GetColCount: integer;
begin
  result := 0;
  if NOT Assigned( self ) then
    Exit;
  result := inherited ColCount;
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.SetColCount( v: integer );
var
  old    : Integer;
  i, j   : Integer;
  RORows : Array of Boolean;
begin
  if NOT Assigned( self ) then
    Exit;

  if ( v < 1 ) OR ( v = ColCount ) then
    Exit;

  SetLength( RORows, RowCount );
  for i := 0 to RowCount-1 do
    RORows[ i ] := GetReadOnlyRow( i );

  old := ColCount;
  SetLength( fComponent, v, RowCount );
  SetLength( fColor, v, RowCount );
  SetLength( fFontColor, v, RowCount );
  SetLength( fTextFormat, v, RowCount );
  SetLength( fReadOnly, v, RowCount );
  SetLength( fCellHint, v, RowCount );  
  SetLength( fSelectable, v, RowCount );
  {$IFDEF CELLTYPES}
  SetLength( fCellType, v, RowCount );
  {$ENDIF}
  {$IFDEF SORTING}
  SetLength( fSortColAllowed, v );
  SetLength( fSortColAsDate, v );
  {$ENDIF}

  for j := 0 to RowCount-1 do
    begin
    for i := old to v-1 do
      begin
      ClearCell( i, j );
      {$IFDEF SORTING}
      fSortColAllowed[ i ] := false;
      fSortColAsDate[ i ]  := false;
      {$ENDIF}
      end;

    if RORows[ j ] then
      SetReadOnlyRow( j, True );
    end;
  SetLength( RORows, 0 );

  inherited ColCount := v;
  for j := 0 to RowCount-1 do
    begin
    for i := old to v-1 do
      ClearCell( i, j, false );
    end;
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.DelCol( v: integer );
var
  i,j : integer;
begin
  if NOT Assigned( self ) then
    Exit;

  if ( v = Col ) AND EditorMode then
    HideEditor;

  for i := 0 to RowCount-1 do
    begin
    for j := v to ColCount-2 do
      begin
      Cells[ j, i ] := Cells[ j+1, i ];
      Objects[ j, i ] := Objects[ j+1, i ];
      fComponent[ j, i ] := fComponent[ j+1, i ];
      fColor[ j, i ] := fColor[ j+1, i ];
      fFontColor[ j, i ] := fFontColor[ j+1, i ];
      fTextFormat[ j, i ] := fTextFormat[ j+1, i ];
      fReadOnly[ j, i ] := fReadOnly[ j+1, i ];
      {$IFDEF CELLTYPES}
      fCellType[ j, i ] := fCellType[ j+1, i ];
      {$ENDIF}
      fCellHint[ j, i ] := fCellHint[ j+1, i ];
      fSelectable[ j, i ] := fSelectable[ j+1, i ];
      {$IFDEF SORTING}
      fSortColAllowed[ j ] := fSortColAllowed[ j+1 ];
      fSortColAsDate[ j ] := fSortColAsDate[ j+1 ];
      {$ENDIF}
      end;
    end;

  if ( RowCount-1 >= 1 ) then
    RowCount := RowCount-1;
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.DelRow( v: integer );
var
  i,j : integer;
begin
  if NOT Assigned( self ) then
    Exit;

  if ( v = Row ) AND EditorMode then
    HideEditor;

  for i := v to RowCount-2 do
    begin
    for j := 0 to ColCount-1 do
      begin
      Cells[ j, i ] := Cells[ j, i+1 ];
      Objects[ j, i ] := Objects[ j, i+1 ];
      fComponent[ j, i ] := fComponent[ j, i+1 ];
      fColor[ j, i ] := fColor[ j, i+1 ];
      fFontColor[ j, i ] := fFontColor[ j, i+1 ];
      fTextFormat[ j, i ] := fTextFormat[ j, i+1 ];
      fReadOnly[ j, i ] := fReadOnly[ j, i+1 ];
      {$IFDEF CELLTYPES}
      fCellType[ j, i ] := fCellType[ j, i+1 ];
      {$ENDIF}
      fCellHint[ j, i ] := fCellHint[ j, i+1 ];
      fSelectable[ j, i ] := fSelectable[ j, i+1 ];
      end;
    end;

  if ( RowCount-1 >= 1 ) then
    RowCount := RowCount-1;
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.ClearCell( ACol, ARow : Integer; Full : boolean = True );
begin
  if NOT Assigned( self ) then
    Exit;

  if ( ACol < 0 ) OR ( ARow < 0 ) {OR ( ACol > ColCount-1 ) OR ( ARow > RowCount-1 )} then
    Exit;

  if ( ACol < ColCount ) OR ( ARow < RowCount ) then
    Cells[ ACol, ARow ]       := '';
  if ( ACol < ColCount ) OR ( ARow < RowCount ) then
    Objects[ ACol, ARow ]     := nil;
  if ( ACol < Length( fColor ) ) AND ( ARow < Length( fColor[ ACol ] ) ) then
    fColor[ ACol, ARow ]      := -1;

  if NOT Full then
    Exit;

  if ( ACol < Length( fComponent ) ) AND ( ARow < Length( fComponent[ ACol ] ) ) then
    fComponent[ ACol, ARow ]  := csNone;
  if ( ACol < Length( fFontColor ) ) AND ( ARow < Length( fFontColor[ ACol ] ) ) then
    fFontColor[ ACol, ARow ]  := -1;
  if ( ACol < Length( fTextFormat ) ) AND ( ARow < Length( fTextFormat[ ACol ] ) ) then
    fTextFormat[ ACol, ARow ] := DEFAULT_TEXT_FORMAT_;
  if ( ACol < Length( fReadOnly ) ) AND ( ARow < Length( fReadOnly[ ACol ] ) ) then
    fReadOnly[ ACol, ARow ]   := False;
  {$IFDEF CELLTYPES}
  if ( ACol < Length( fReadOnly ) ) AND ( ARow < Length( fCellType[ ACol ] ) ) then
    fCellType[ ACol, ARow ]   := kpmString;
  {$ENDIF}

  if ( ACol < Length( fCellHint ) ) AND ( ARow < Length( fCellHint[ ACol ] ) ) then
    fCellHint[ ACol, ARow ]   := '';
  if ( ACol < Length( fSelectable ) ) AND ( ARow < Length( fSelectable[ ACol ] ) ) then
    fSelectable[ ACol, ARow ] := True;
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.Clear( Full : boolean = True; IgnoreFixed : boolean = True );
var
  i, j : integer;
begin
  if NOT Assigned( self ) then
    Exit;

  for i := 0 to ColCount-1 do
    begin
    if ( i <= FixedCols-1 ) AND NOT IgnoreFixed then
      Continue;

    for j := 0 to RowCount-1 do
      begin
      if ( j <= FixedRows-1 ) AND NOT IgnoreFixed then
        Continue;

      ClearCell( i, j, Full );
      end;
    end;
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.ClearCol( ACol : Integer; Full : boolean = True; IgnoreFixed : boolean = True );
var
  i : integer;
begin
  if NOT Assigned( self ) then
    Exit;

  if ( ACol < 0 ) OR ( ACol > ColCount-1 ) then
    Exit;

  if ( ACol <= FixedCols-1 ) AND NOT IgnoreFixed then
    Exit;

  for i := 0 to RowCount-1 do
    begin
    if ( i <= FixedRows-1 ) AND NOT IgnoreFixed then
      Continue;

    ClearCell( ACol, i, Full );
    end;
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.ClearRow( ARow : Integer; Full : boolean = True; IgnoreFixed : boolean = True );
var
  i : integer;
begin
  if NOT Assigned( self ) then
    Exit;

  if ( ARow < 0 ) OR ( ARow > RowCount-1 ) then
    Exit;

  if ( ARow <= FixedRows-1 ) AND NOT IgnoreFixed then
    Exit;

  for i := 0 to ColCount-1 do
    begin
    if ( i <= FixedCols-1 ) AND NOT IgnoreFixed then
      Continue;

    ClearCell( i, ARow, Full );
    end;
end;

function {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.GetComponent( ACol, ARow: Integer ): TCheckStringGridState;
begin
  result := csNone;
  if NOT Assigned( self ) then
    Exit;

  if ( ACol > ColCount-1 ) OR ( ARow > RowCount-1 ) then
    Exit;

  result := fComponent[ ACol, ARow ];
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.SetComponent( ACol, ARow: Integer; value : TCheckStringGridState );
begin
  if NOT Assigned( self ) then
    Exit;
  if ( ACol > ColCount-1 ) OR ( ARow > RowCount-1 ) then
    Exit;
  if ( fComponent[ ACol, ARow ] = value ) then
    Exit;

  fComponent[ ACol, ARow ] := value;
  InvalidateCell( ACol, ARow );
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.ExchangeItems( sCol, sRow, tCol, tRow : Integer );
var
  tCaption : string;
  tObj     : TObject;
  tClr     : TColor;
  tComp    : TCheckStringGridState;
  tFClr    : TColor;
  tTFmt    : Cardinal;
  tRO      : Boolean;
  tS       : Boolean;
  tCH      : String;
  {$IFDEF CELLTYPES}
  tKPM     : TOnKeyPressMode;
  {$ENDIF}
begin
  if NOT Assigned( self ) then
    Exit;

  if ( sCol < 0 ) OR ( sRow < 0 ) OR ( sCol > ColCount-1 ) OR ( sRow > RowCount-1 ) then
    Exit;
  if ( tCol < 0 ) OR ( tRow < 0 ) OR ( tCol > ColCount-1 ) OR ( tRow > RowCount-1 ) then
    Exit;
  if ( sCol = tCol ) AND ( sRow = tRow ) then
    Exit;

  tCaption := Cells[ tCol, tRow ];
  tObj     := Objects[ tCol, tRow ];
  tClr     := fColor[ tCol, tRow ];
  tComp    := fComponent[ tCol, tRow ];
  tFClr    := fFontColor[ tCol, tRow ];
  tTFmt    := fTextFormat[ tCol, tRow ];
  tRO      := fReadOnly[ tCol, tRow ];
  {$IFDEF CELLTYPES}
  tKPM     := fCellType[ tCol, tRow ];
  {$ENDIF}
  tCH      := fCellHint[ tCol, tRow ];
  tS       := fSelectable[ tCol, tRow ];

  Cells[ tCol, tRow ]       := Cells[ SCol, sRow ];
  Objects[ tCol, tRow ]     := Objects[ SCol, sRow ];
  fColor[ tCol, tRow ]      := fColor[ SCol, sRow ];
  fComponent[ tCol, tRow ]  := fComponent[ SCol, sRow ];
  fFontColor[ tCol, tRow ]  := fFontColor[ SCol, sRow ];
  fTextFormat[ tCol, tRow ] := fTextFormat[ SCol, sRow ];
  fReadOnly[ tCol, tRow ]   := fReadOnly[ SCol, sRow ];
  {$IFDEF CELLTYPES}
  fCellType[ tCol, tRow ]   := fCellType[ SCol, sRow ];
  {$ENDIF}
  fCellHint[ tCol, tRow ]   := fCellHint[ SCol, sRow ];
  fSelectable[ tCol, tRow ] := fSelectable[ SCol, sRow ];

  Cells[ SCol, sRow ]       := tCaption;
  Objects[ SCol, sRow ]     := tObj;
  fColor[ SCol, sRow ]      := tClr;
  fComponent[ SCol, sRow ]  := tComp;
  fFontColor[ SCol, sRow ]  := tFClr;
  fTextFormat[ SCol, sRow ] := tTFmt;
  fReadOnly[ SCol, sRow ]   := tRO;
  {$IFDEF CELLTYPES}
  fCellType[ SCol, sRow ]   := tKPM;
  {$ENDIF}
  fCellHint[ SCol, sRow ]   := tCH;
  fSelectable[ SCol, sRow ] := tS;
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.ExchangeCols( sCol, tCol : Integer );
var
  i : integer;
  {$IFDEF SORTING}
  b : Boolean;
  {$ENDIF}
begin
  if NOT Assigned( self ) then
    Exit;

  if ( sCol < 0 ) OR ( sCol > ColCount-1 ) OR ( tCol < 0 ) OR ( tCol > ColCount-1 ) OR ( sCol = tCol ) then
    Exit;

  for i := 0 to RowCount-1 do
    ExchangeItems( sCol, i, tCol, i );

  {$IFDEF SORTING}
  b := fSortColAllowed[ sCol ];
  fSortColAllowed[ sCol ] := fSortColAllowed[ tCol ];
  fSortColAllowed[ tCol ] := b;

  b := fSortColAsDate[ sCol ];
  fSortColAsDate[ sCol ] := fSortColAsDate[ tCol ];
  fSortColAsDate[ tCol ] := b;
  {$ENDIF}
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.ExchangeRows( sRow, tRow : Integer );
var
  i : integer;
begin
  if NOT Assigned( self ) then
    Exit;

  if ( sRow < 0 ) OR ( sRow > RowCount-1 ) OR ( tRow < 0 ) OR ( tRow > RowCount-1 ) OR ( sRow = tRow ) then
    Exit;

  for i := 0 to ColCount-1 do
    ExchangeItems( i, sRow, i, tRow );
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.MoveCol( sCol, tCol : Integer );
var
  i : Integer;
begin
  if NOT Assigned( self ) then
    Exit;

  if ( sCol < 0 ) OR ( sCol > ColCount-1 ) OR ( tCol < 0 ) OR ( tCol > ColCount-1 ) OR ( sCol = tCol ) then
    Exit;

  if ( sCol > tCol ) then
    begin
    for i := sCol downTo tCol+1 do
      ExchangeCols( i, i-1 );
    end
  else
    begin
    for i := sCol To tCol-1 do
      ExchangeCols( i, i+1 );
    end;
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.MoveRow( sRow, tRow : Integer );
var
  i : Integer;
begin
  if NOT Assigned( self ) then
    Exit;

  if ( sRow < 0 ) OR ( sRow > RowCount-1 ) OR ( tRow < 0 ) OR ( tRow > RowCount-1 ) OR ( sRow = tRow ) then
    Exit;

  if ( sRow > tRow ) then
    begin
    for i := sRow downTo tRow+1 do
      ExchangeRows( i, i-1 );
    end
  else
    begin
    for i := sRow To tRow-1 do
      ExchangeRows( i, i+1 );
    end;
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.InflateColumns( DontShrink : boolean = false );
var
  x, y     : Integer;
  MaxWidth : Integer;
  Widths   : Array of Integer;
begin
  if NOT Assigned( self ) then
    Exit;

  SetLength( Widths, ColCount );
  FillChar( Widths[ 0 ], SizeOf( Integer )*Length( Widths ), 0 );
  for x := 0 to ColCount-1 do
    begin
    Widths[ x ] := 0;
    for y := 0 to RowCount-1 do
      Widths[ x ] := Max( Widths[ x ], Canvas.TextWidth( Cells[ x, y ] + ' ' ) )
    end;

  MaxWidth := ( Width - ( ColCount-1 )*2 );
  if VisibleRowCount < RowCount-1 then
    Dec( MaxWidth, 16 );

  if NOT DontShrink then
    begin
    while ( SumInt( Widths ) > MaxWidth ) do
      begin
      y := -1;
      for x := Low( Widths ) to High( Widths ) do
        begin
        if ( Widths[ x ] = MaxIntValue( Widths ) ) then
          y := x;
        end;
      if ( y = -1 ) then
        Break;
      Dec( Widths[ y ] );
      end;
    end;

  while ( SumInt( Widths ) < MaxWidth ) do
    begin
    y := -1;
    for x := Low( Widths ) to High( Widths ) do
      begin
      if ( Widths[ x ] = MinIntValue( Widths ) ) then
        y := x;
      end;
    if ( y = -1 ) then
      Break;
    Inc( Widths[ y ] );
    end;

  for x := 0 to ColCount-1 do
    ColWidths[ x ] := Widths[ x ];

  SetLength( Widths, 0 );
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.SaveToFile( FileName : string; Separator : Char = ';' );
var
  StrL : TStringList;
  s    : string;
  x, y : Integer;
begin
  if NOT Assigned( self ) then
    Exit;

  StrL := TStringList.Create;
  for y := 0 to RowCount-1 do
    begin
    s := '';
    for x := 0 to ColCount-1 do
      s := s + Cells[ x, y ] + Separator;
    StrL.Add( s );
    end;
  StrL.SaveToFile( FileName );
  StrL.Free;
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.GetMenuEnabled : boolean;
begin
  result := false;
  if NOT Assigned( self ) then
    Exit;
  result := Assigned( PopupMenu );
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.SetMenuEnabled( value : boolean );
begin
  if NOT Assigned( self ) then
    Exit;
  if ( Assigned( PopupMenu ) = value ) then
    Exit;

  if value then
    PopupMenu := myPopUpMenu
  else
    PopupMenu := nil;
end;

function {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.GetDeleteMenu : boolean;
begin
  result := false;
  if NOT Assigned( self ) then
    Exit;
  if NOT Assigned( PopupMenu ) then
    Exit;
  if ( PopupMenu.Items.Count < 3 ) then
    Exit;
  result := PopupMenu.Items[ 3 ].Visible;
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.SetDeleteMenu( value : boolean );
begin
  if NOT Assigned( self ) then
    Exit;
  if NOT Assigned( PopupMenu ) then
    Exit;
  if ( PopupMenu.Items.Count < 4 ) then
    Exit;
  PopupMenu.Items[ 3 ].Visible := value;
  PopupMenu.Items[ 4 ].Visible := value;
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.GetCellColor( ACol, ARow : Integer ) : TColor;
begin
  result := -1;
  if NOT Assigned( self ) then
    Exit;
  if ( ACol > ColCount-1 ) OR ( ARow > RowCount-1 ) then
    Exit;
  result := fColor[ ACol, ARow ];
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.SetCellColor( ACol, ARow : Integer; value : TColor );
begin
  if NOT Assigned( self ) then
    Exit;
  if ( ACol > ColCount-1 ) OR ( ARow > RowCount-1 ) then
    Exit;
  if ( fColor[ ACol, ARow ] = value ) then 
    Exit;
  fColor[ ACol, ARow ] := value;
  InvalidateCell( ACol, ARow );
end;

function {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.GetFontColor( ACol, ARow : Integer ) : TColor;
begin
  result := -1;
  if NOT Assigned( self ) then
    Exit;
  if ( ACol > ColCount-1 ) OR ( ARow > RowCount-1 ) then
    Exit;
  result := fFontColor[ ACol, ARow ];
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.SetFontColor( ACol, ARow : Integer; value : TColor );
begin
  if NOT Assigned( self ) then
    Exit;
  if ( ACol > ColCount-1 ) OR ( ARow > RowCount-1 ) then
    Exit;
  if ( fFontColor[ ACol, ARow ] = value ) then
    Exit;
  fFontColor[ ACol, ARow ] := value;
  InvalidateCell( ACol, ARow );
end;

function {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.GetTextFormat( ACol, ARow : Integer ) : Cardinal;
begin
  result := DT_LEFT;
  if NOT Assigned( self ) then
    Exit;
  if ( ACol > ColCount-1 ) OR ( ARow > RowCount-1 ) then
    Exit;
  result := fTextFormat[ ACol, ARow ];
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.SetTextFormat( ACol, ARow : Integer; value : Cardinal );
begin
  if NOT Assigned( self ) then
    Exit;
  if ( ACol > ColCount-1 ) OR ( ARow > RowCount-1 ) then
    Exit;
  if ( value > DT_WORD_ELLIPSIS ) then
    Exit;
  if ( fTextFormat[ ACol, ARow ] = value ) then
    Exit;
  fTextFormat[ ACol, ARow ] := value;
  InvalidateCell( ACol, ARow );
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.GetReadOnly( ACol, ARow : Integer ) : Boolean;
begin
  result := false;
  if NOT Assigned( self ) then
    Exit;

//  if NOT ( goEditing in Options ) then
//    begin
//    result := True;
//    Exit;
//    end;

  if ( ACol > ColCount-1 ) OR ( ARow > RowCount-1 ) then
    Exit;

  result := True;
  if ( ACol <= FixedCols-1 ) OR ( ARow <= FixedRows-1 ) then
    Exit;

  result := fReadOnly[ ACol, ARow ];
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.SetReadOnly( ACol, ARow : Integer; value : Boolean );
begin
  if NOT Assigned( self ) then
    Exit;
  if ( ACol > ColCount-1 ) OR( ARow > RowCount-1 ) then
    Exit;
  if ( ACol > High( fReadOnly ) ) then
    Exit;
  if ( ARow > High( fReadOnly[ ACol ] ) ) then
    Exit;
  if ( fReadOnly[ ACol, ARow ] = value ) then
    Exit;

  fReadOnly[ ACol, ARow ] := value;
  if ( fComponent[ ACol, ARow ] <> csNone ) then
    begin
    if Value then
      begin
      if ( fComponent[ ACol, ARow ] = csChecked ) then
        fComponent[ ACol, ARow ] := csInactiveChecked
      else if ( fComponent[ ACol, ARow ] = csUnchecked ) then
        fComponent[ ACol, ARow ] := csInactiveUnchecked;
      end
    else
      begin
      if ( fComponent[ ACol, ARow ] = csInactiveChecked ) then
        fComponent[ ACol, ARow ] := csChecked
      else if ( fComponent[ ACol, ARow ] = csInactiveUnchecked ) then
        fComponent[ ACol, ARow ] := csUnchecked;
      end;
    end;

  if ( Col = ACol ) AND ( Row = ARow ) AND EditorMode then
    EditorMode := False;

  InvalidateCell( ACol, ARow );
end;

function {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.GetCellHint( ACol, ARow : Integer ) : String;
begin
  result := '';
  if NOT Assigned( self ) then
    Exit;
  if ( ACol > ColCount-1 ) OR ( ARow > RowCount-1 ) then
    Exit;
  result := fCellHint[ ACol, ARow ];
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.SetCellHint( ACol, ARow : Integer; value : String );
begin
  if NOT Assigned( self ) then
    Exit;
  if ( ACol > ColCount-1 ) OR( ARow > RowCount-1 ) then
    Exit;
  if ( fCellHint[ ACol, ARow ] = value ) then
    Exit;
  fCellHint[ ACol, ARow ] := value;
end;

function {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.GetReadOnlyCol( ACol : Integer ) : Boolean;
var
  i : integer;
begin
  result := false;
  if NOT Assigned( self ) then
    Exit;

//  if NOT ( goEditing in Options ) then
//    begin
//    result := True;
//    Exit;
//    end;

  if ( ACol > ColCount-1 ) then
    Exit;

//  result := True;
//  if ( ACol <= FixedCols-1 ) then
//    Exit;

  result := True;
  for i := FixedRows to RowCount-1 do
    begin
    if ( i > High( fReadOnly ) ) then
      break;    
    if NOT fReadOnly[ ACol, i ] then
      begin
      result := false;
      break;
      end;
    end;
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.SetReadOnlyCol( ACol : Integer; value : Boolean );
var
  i : integer;
begin
  if NOT Assigned( self ) then
    Exit;
  if ( ACol > ColCount-1 ) then
    Exit;

  for i := 0 to RowCount-1 do
    ReadOnly[ ACol, i ] := value;
end;

function {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.GetReadOnlyRow( ARow : Integer ) : Boolean;
var
  i : integer;
begin
  result := false;
  if NOT Assigned( self ) then
    Exit;

//  if NOT ( goEditing in Options ) then
//    begin
//    result := True;
//    Exit;
//    end;

  if ( ARow > RowCount-1 ) then
    Exit;

//  result := True;
//  if ( ARow <= FixedRows-1 ) then
//    Exit;

  result := True;
  for i := FixedCols to ColCount-1 do
    begin
    if ( i > High( fReadOnly ) ) then
      break;
    if NOT fReadOnly[ i, ARow ] then
      begin
      result := false;
      break;
      end;
    end;
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.SetReadOnlyRow( ARow : Integer; value : Boolean );
var
  i : integer;
begin
  if NOT Assigned( self ) then
    Exit;
  for i := 0 to ColCount-1 do
    ReadOnly[ i, ARow ] := value;
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.GetSelectable( ACol, ARow : Integer ) : Boolean;
begin
  result := True;
  if NOT Assigned( self ) then
    Exit;

  if ( ACol > ColCount-1 ) OR ( ARow > RowCount-1 ) then
    Exit;

  result := True;
  if ( ACol <= FixedCols-1 ) OR ( ARow <= FixedRows-1 ) then
    Exit;

  result := fSelectable[ ACol, ARow ];
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.SetSelectable( ACol, ARow : Integer; value : Boolean );
begin
  if NOT Assigned( self ) then
    Exit;
  if ( ACol > ColCount-1 ) OR( ARow > RowCount-1 ) then
    Exit;
  if ( fSelectable[ ACol, ARow ] = value ) then
    Exit;
  fSelectable[ ACol, ARow ] := value;
  InvalidateCell( ACol, ARow );
end;

function {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.GetSelectableCol( ACol : Integer ) : Boolean;
var
  i : integer;
begin
  result := True;
  if NOT Assigned( self ) then
    Exit;

  if ( ACol > ColCount-1 ) then
    Exit;

  result := True;
  for i := FixedRows to RowCount-1 do
    begin
    if NOT fSelectable[ ACol, i ] then
      begin
      result := false;
      break;
      end;
    end;
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.SetSelectableCol( ACol : Integer; value : Boolean );
var
  i : integer;
begin
  if NOT Assigned( self ) then
    Exit;
  if ( ACol > ColCount-1 ) then
    Exit;

  for i := 0 to RowCount-1 do
    begin
//    if ( i <= FixedRows-1 ) then
//      continue;
    if ( fSelectable[ ACol, i ] = value ) then
      continue;
    fSelectable[ ACol, i ] := value;
    InvalidateCell( ACol, i );
    end;
end;

function {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.GetSelectableRow( ARow : Integer ) : Boolean;
var
  i : integer;
begin
  result := True;
  if NOT Assigned( self ) then
    Exit;

  if ( ARow > RowCount-1 ) then
    Exit;

  result := True;
  for i := FixedCols to ColCount-1 do
    begin
    if NOT fSelectable[ i, ARow ] then
      begin
      result := false;
      break;
      end;
    end;
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.SetSelectableRow( ARow : Integer; value : Boolean );
var
  i : integer;
begin
  if NOT Assigned( self ) then
    Exit;
  if ( ARow > RowCount-1 ) then
    Exit;

  for i := 0 to ColCount-1 do
    begin
//    if ( i <= FixedCols-1 ) then
//      continue;
    if ( fSelectable[ i, ARow ] = value ) then
      continue;

    fSelectable[ i, ARow ] := value;
    InvalidateCell( i, ARow );
    end;
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.SetSelectedRowHeight( value : Byte );
begin
  if NOT Assigned( self ) then
    Exit;
  if ( fSelectedRowHeight = value ) then
    Exit;
  fSelectedRowHeight := value;

  RowHeights[ Row ] := fSelectedRowHeight;
end;

function {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.GetRow : Integer;
begin
  result := inherited Row;
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.SetRow( Value: Integer );
var
  sRow : Integer;
begin
  if ( Row = Value ) then
    Exit;

  sRow := Row;
//  inherited Row := Value; // Bad idea, stackoverflow? Compiler looses track, ide freezing
  FocusCell( Col, Value, True );

  SelectionChanged( Col, sRow, Col, Row );
end;

function {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.GetCells( ACol, ARow: Integer ) : string;
begin
  if NOT Assigned( self ) then
    Exit;
  if ( ACol < 0 ) OR ( ARow < 0 ) OR ( ACol > ColCount-1 ) OR ( ARow > RowCount-1 ) then
    Exit;
  result := inherited Cells[ ACol, ARow ];
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.SetCells( ACol, ARow: Integer; const Value: string );
begin
  if NOT Assigned( self ) then
    Exit;
  if ( ACol < 0 ) OR ( ARow < 0 ) OR ( ACol > ColCount-1 ) OR ( ARow > RowCount-1 ) then
    Exit;
  if ( Cells[ ACol, ARow ] = Value ) then
    Exit;
  inherited Cells[ ACol, ARow ] := Value;
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.GetCellsAsBoolean( ACol, ARow: Integer ): Boolean;
begin
  result := false;
  if NOT Assigned( self ) then
    Exit;
  if ( ACol > ColCount-1 ) OR ( ARow > RowCount-1 ) then
    Exit;
  result := ( 'true' = LowerCase( Cells[ ACol, ARow ] ) );
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.SetCellsAsBoolean( ACol, ARow: Integer; const Value: Boolean );
begin
  if NOT Assigned( self ) then
    Exit;
  if ( ACol > ColCount-1 ) OR ( ARow > RowCount-1 ) then
    Exit;
  if Value then
    Cells[ ACol, ARow ] := 'True'
  else
    Cells[ ACol, ARow ] := 'False'
end;

function {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.GetCellsAsByte( ACol, ARow: Integer ): Byte;
begin
  result := 0;
  if NOT Assigned( self ) then
    Exit;
  if ( ACol > ColCount-1 ) OR ( ARow > RowCount-1 ) then
    Exit;
  result := StrToIntDef( Cells[ ACol, ARow ], 0 );
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.SetCellsAsByte( ACol, ARow: Integer; const Value: Byte );
begin
  if NOT Assigned( self ) then
    Exit;
  if ( ACol > ColCount-1 ) OR ( ARow > RowCount-1 ) then
    Exit;
  Cells[ ACol, ARow ] := IntToStr( Value );
end;

function {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.GetCellsAsShortInt( ACol, ARow: Integer ): ShortInt;
begin
  result := 0;
  if NOT Assigned( self ) then
    Exit;
  if ( ACol > ColCount-1 ) OR ( ARow > RowCount-1 ) then
    Exit;
  result := StrToIntDef( Cells[ ACol, ARow ], 0 );
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.SetCellsAsShortInt( ACol, ARow: Integer; const Value: ShortInt );
begin
  if NOT Assigned( self ) then
    Exit;
  if ( ACol > ColCount-1 ) OR ( ARow > RowCount-1 ) then
    Exit;
  Cells[ ACol, ARow ] := IntToStr( Value );
end;

function {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.GetCellsAsWord( ACol, ARow: Integer ): Word;
begin
  result := 0;
  if NOT Assigned( self ) then
    Exit;
  if ( ACol > ColCount-1 ) OR ( ARow > RowCount-1 ) then
    Exit;
  result := StrToIntDef( Cells[ ACol, ARow ], 0 );
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.SetCellsAsWord( ACol, ARow: Integer; const Value: Word );
begin
  if NOT Assigned( self ) then
    Exit;
  if ( ACol > ColCount-1 ) OR ( ARow > RowCount-1 ) then
    Exit;
  Cells[ ACol, ARow ] := IntToStr( Value );
end;

function {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.GetCellsAsSmallInt( ACol, ARow: Integer ): SmallInt;
begin
  result := 0;
  if NOT Assigned( self ) then
    Exit;
  if ( ACol > ColCount-1 ) OR ( ARow > RowCount-1 ) then
    Exit;
  result := StrToIntDef( Cells[ ACol, ARow ], 0 );
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.SetCellsAsSmallInt( ACol, ARow: Integer; const Value: SmallInt );
begin
  if NOT Assigned( self ) then
    Exit;
  if ( ACol > ColCount-1 ) OR ( ARow > RowCount-1 ) then
    Exit;
  Cells[ ACol, ARow ] := IntToStr( Value );
end;

function {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.GetCellsAsCardinal( ACol, ARow: Integer ): Cardinal;
begin
  result := 0;
  if NOT Assigned( self ) then
    Exit;
  if ( ACol > ColCount-1 ) OR ( ARow > RowCount-1 ) then
    Exit;
  result := StrToIntDef( Cells[ ACol, ARow ], 0 );
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.SetCellsAsCardinal( ACol, ARow: Integer; const Value: Cardinal );
begin
  if NOT Assigned( self ) then
    Exit;
  if ( ACol > ColCount-1 ) OR ( ARow > RowCount-1 ) then
    Exit;
  Cells[ ACol, ARow ] := IntToStr( Value );
end;


function {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.GetCellsAsInteger( ACol, ARow: Integer ): Integer;
begin
  result := 0;
  if NOT Assigned( self ) then
    Exit;
  if ( ACol > ColCount-1 ) OR ( ARow > RowCount-1 ) then
    Exit;
  result := StrToIntDef( Cells[ ACol, ARow ], 0 );
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.SetCellsAsInteger( ACol, ARow: Integer; const Value: Integer );
begin
  if NOT Assigned( self ) then
    Exit;
  if ( ACol > ColCount-1 ) OR ( ARow > RowCount-1 ) then
    Exit;
  Cells[ ACol, ARow ] := IntToStr( Value );
end;

{$IF CompilerVersion > 23}
function {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.GetCellsAsUInt64( ACol, ARow: Integer ): UInt64;
begin
  result := 0;
  if NOT Assigned( self ) then
    Exit;
  if ( ACol > ColCount-1 ) OR ( ARow > RowCount-1 ) then
    Exit;

  {$IF CompilerVersion < 23}{$RANGECHECKS OFF}{$IFEND} // RangeCheck might cause Internal-Error C1118
  result := {$IF CompilerVersion > 23}StrToUInt64Def{$ELSE}StrToInt64Def{$IFEND}( Cells[ ACol, ARow ], 0 );
  {$IF CompilerVersion < 23}{$RANGECHECKS ON}{$IFEND} // RangeCheck might cause Internal-Error C1118
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.SetCellsAsUInt64( ACol, ARow: Integer; const Value: UInt64 );
begin
  if NOT Assigned( self ) then
    Exit;
  if ( ACol > ColCount-1 ) OR ( ARow > RowCount-1 ) then
    Exit;
  Cells[ ACol, ARow ] := IntToStr( Value );
end;
{$IFEND}

function {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.GetCellsAsInt64( ACol, ARow: Integer ): Int64;
begin
  result := 0;
  if NOT Assigned( self ) then
    Exit;
  if ( ACol > ColCount-1 ) OR ( ARow > RowCount-1 ) then
    Exit;

  result := StrToInt64Def( Cells[ ACol, ARow ], 0 );
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.SetCellsAsInt64( ACol, ARow: Integer; const Value: Int64 );
begin
  if NOT Assigned( self ) then
    Exit;
  if ( ACol > ColCount-1 ) OR ( ARow > RowCount-1 ) then
    Exit;
  Cells[ ACol, ARow ] := IntToStr( Value );
end;

function {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.GetCellsAsSingle( ACol, ARow: Integer ): Single;
begin
  result := 0;
  if NOT Assigned( self ) then
    Exit;
  if ( ACol > ColCount-1 ) OR ( ARow > RowCount-1 ) then
    Exit;
  result := StrToFloatDef( Cells[ ACol, ARow ], 0 );
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.SetCellsAsSingle( ACol, ARow: Integer; const Value: Single );
begin
  if NOT Assigned( self ) then
    Exit;
  if ( ACol > ColCount-1 ) OR ( ARow > RowCount-1 ) then
    Exit;
  Cells[ ACol, ARow ] := Format( fFloatFormat, [ Value ] ); // FloatToStr( Value );
end;

    function {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.GetCellsAsDouble( ACol, ARow: Integer ): Double;
begin
  result := 0;
  if NOT Assigned( self ) then
    Exit;
  if ( ACol > ColCount-1 ) OR ( ARow > RowCount-1 ) then
    Exit;
  result := StrToFloatDef( Cells[ ACol, ARow ], 0 );
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.SetCellsAsDouble( ACol, ARow: Integer; const Value: Double );
begin
  if NOT Assigned( self ) then
    Exit;
  if ( ACol > ColCount-1 ) OR ( ARow > RowCount-1 ) then
    Exit;
  Cells[ ACol, ARow ] := Format( fFloatFormat, [ Value ] ); // FloatToStr( Value );
end;

function {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.GetCellsAsExtended( ACol, ARow: Integer ): Extended;
begin
  result := 0;
  if NOT Assigned( self ) then
    Exit;
  if ( ACol > ColCount-1 ) OR ( ARow > RowCount-1 ) then
    Exit;
  result := StrToFloatDef( Cells[ ACol, ARow ], 0 );
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.SetCellsAsExtended( ACol, ARow: Integer; const Value: Extended );
begin
  if NOT Assigned( self ) then
    Exit;
  if ( ACol > ColCount-1 ) OR ( ARow > RowCount-1 ) then
    Exit;
  Cells[ ACol, ARow ] := Format( fFloatFormat, [ Value ] ); // FloatToStr( Value );
end;

function {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.GetCellsAsDate( ACol, ARow: Integer ): TDate;
begin
  result := 0;
  if NOT Assigned( self ) then
    Exit;
  if ( ACol > ColCount-1 ) OR ( ARow > RowCount-1 ) then
    Exit;

  result := StrToDateDef( Cells[ ACol, ARow ], 0 );
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.SetCellsAsDate( ACol, ARow: Integer; const Value: TDate );
begin
  if NOT Assigned( self ) then
    Exit;
  if ( ACol > ColCount-1 ) OR ( ARow > RowCount-1 ) then
    Exit;
  Cells[ ACol, ARow ] := DateToStr( Value );
end;

function {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.GetCellsAsTime( ACol, ARow: Integer ): TTime;
begin
  result := 0;
  if NOT Assigned( self ) then
    Exit;
  if ( ACol > ColCount-1 ) OR ( ARow > RowCount-1 ) then
    Exit;

  result := StrToTimeDef( Cells[ ACol, ARow ], 0 );
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.SetCellsAsTime( ACol, ARow: Integer; const Value: TTime );
begin
  if NOT Assigned( self ) then
    Exit;
  if ( ACol > ColCount-1 ) OR ( ARow > RowCount-1 ) then
    Exit;
  Cells[ ACol, ARow ] := TimeToStr( Value );
end;

function {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.GetCellsAsDateTime( ACol, ARow: Integer ): TDateTime;
var
  F : TFormatSettings;
begin
  result := 0;
  if NOT Assigned( self ) then
    Exit;
  if ( ACol > ColCount-1 ) OR ( ARow > RowCount-1 ) then
    Exit;

  F := fLFS;
  F.ShortDateFormat := fDateFormat;
  F.LongTimeFormat  := fTimeFormat;
  result := StrToDateTimeDef( Cells[ ACol, ARow ], 0, F );
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.SetCellsAsDateTime( ACol, ARow: Integer; const Value: TDateTime );
begin
  if NOT Assigned( self ) then
    Exit;
  if ( ACol > ColCount-1 ) OR ( ARow > RowCount-1 ) then
    Exit;
  Cells[ ACol, ARow ] := FormatDateTime( fDateFormat + ' ' + fTimeFormat, Value ); // DateToStr( Value );
end;

{$IFDEF SORTING}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.GetSortAllowedCol( ACol : Integer ) : Boolean;
begin
  result := false;
  if NOT Assigned( self ) then
    Exit;

  if ( ACol < 0 ) OR ( ACol > ColCount-1 ) then
    Exit;

  result := fSortColAllowed[ ACol ];
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.SetSortAllowedCol( ACol : Integer; value : Boolean );
begin
  if NOT Assigned( self ) then
    Exit;

  if ( ACol < 0 ) OR ( ACol > ColCount-1 ) then
    Exit;

  fSortColAllowed[ ACol ] := value;
end;

function {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.GetSortColAsDate( ACol : Integer ) : Boolean;
begin
  result := false;
  if NOT Assigned( self ) then
    Exit;

  if ( ACol < 0 ) OR ( ACol > ColCount-1 ) then
    Exit;

  result := fSortColAsDate[ ACol ];
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.SetSortColAsDate( ACol : Integer; value : Boolean );
begin
  if NOT Assigned( self ) then
    Exit;

  if ( ACol < 0 ) OR ( ACol > ColCount-1 ) then
    Exit;

  fSortColAsDate[ ACol ] := value;
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function StrNatCompare( const Str1, Str2: string; const CaseSensitive: boolean = false ): integer;
  // helper function, check char for digit
  function nat_isDigit( const AChar: char ): boolean;
  var
    charCode: integer;
  begin
    charCode := ord( AChar );
    Result := ( charCode >= 48 ) and ( charCode <= 57 );
  end;

  // helper function, check for whitespace char ( space, CR, LF,... )
  function nat_isSpace( const AChar: char ): boolean;
  begin
    Result := ( aChar <> #0 ) and ( ord( AChar ) <= 32 );
  end;

  // helper function, returns uppercase'd char
  function nat_ToUpper( const AChar: char ): char;
  var
    str: string;
  begin
    str := AChar;
    Result := AnsiUpperCase( AChar )[1];
  end;

  // helper function to imitate zero-terminated strings
  function GetCharAt( const AStr: string; const APos: integer ): char;
  begin
    if ( APos > 0 ) and ( APos <= length( AStr ) ) then begin
      Result := AStr[APos];
    end else begin
      Result := #0;
    end;
  end;

  // number comparison, longest run
  function compare_right( const a,b: string ): integer;
  var bias: integer;
      ia, ib: integer; // counter for string-positions
			ca, cb: char; // current char
  begin
    bias := 0;
    ia := 0;
    ib := 0;
    {
      The longest run of digits wins.  That aside, the greatest
      value wins, but we can't know that it will until we've scanned
      both numbers to know that they have the same magnitude, so we
      remember it in BIAS
    }
    {$IF CompilerVersion < 30}result := 0;{$IFEND}
    while true do
      begin
      inc( ia );
      inc( ib );
      ca := GetCharAt( a,ia );
      cb := GetCharAt( b, ib );

      if ( not nat_isDigit( ca ) ) and ( not nat_isDigit( cb ) ) then
         begin
        Result := bias;
        break;
        end
      else if ( not nat_isDigit( ca ) ) then
        begin
        Result := -1;
        break;
        end
      else if ( not nat_isDigit( cb ) ) then
        begin
        Result := +1;
        break;
        end
      else if ( ca < cb ) then
        begin
        if ( bias <> 0 ) then
          begin
          bias := -1;
          end;
        end
      else if ( ca > cb ) then
        begin
        if ( bias <> 0 ) then
          begin
          bias := +1;
          end;
        end
      else if ( ca = #0 ) and ( cb = #0 ) then
        begin
        Result := bias;
        break;
        end;
      end;
  end;

  // number comparison, left-aligned
  function compare_left( const a,b: string ): integer;
  var ia, ib: integer;
      ca, cb: char;
  begin
    ia := 0;
    ib := 0;
    {
      Compare two left-aligned numbers: the first to have a
      different value wins.
    }
    {$IF CompilerVersion < 30}result := 0;{$IFEND}
    while true do
      begin
      inc( ia );
      inc( ib );
      ca := GetCharAt( a, ia );
      cb := GetCharAt( b, ib );

      if ( not nat_isDigit( ca ) ) and ( not nat_isDigit( cb ) ) then
        begin
        Result := 0;
        break;
        end
      else if ( not nat_isDigit( ca ) ) then
        begin
        Result := -1;
        break;
        end
      else if ( not nat_isDigit( cb ) ) then
        begin
        Result := +1;
        break;
        end
      else if ( ca < cb ) then
        begin
        Result := -1;
        break;
        end
      else if ( ca > cb ) then
        begin
        Result := +1;
        break;
        end;
      end;
  end;

  // compare function
  function strnatcmp0( const a, b: string; const fold_case: boolean ): integer;
  var ai, bi: integer;
      ca, cb: char;
      fractional: boolean; // is "misused" as boolean in the c-code ( original type: int )
  begin
    //assert( a && b ); // not used...
    ai := 0;
    bi := 0;

    {$IF CompilerVersion < 30}result := 0;{$IFEND}    
    while true do
      begin
      inc( ai );
      inc( bi );

      ca := GetCharAt( a,ai );
      cb := GetCharAt( b,bi );

      // skip over leading spaces or zeros
      while ( nat_isSpace( ca ) ) do
        begin
        inc( ai );
        ca := GetCharAt( a,ai );
        end;

      while ( nat_isSpace( cb ) ) do
        begin
        inc( bi );
        cb := GetCharAt( b,bi );
        end;

      // process run of digits
      if nat_isDigit( ca ) and nat_isDigit( cb ) then
        begin
        fractional := ( ca = '0' ) or ( cb = '0' );

        if fractional then
          begin
          Result := compare_left( Copy( a,ai,length( a ) ),Copy( b,bi,length( b ) ) );
          //Result := compare_left( a+ai, b+bi );
          if ( Result <> 0 ) then
            break;
          end
        else
          begin
          Result := compare_right( Copy( a,ai,length( a ) ),Copy( b,bi,length( b ) ) );
          //Result := compare_right( a+ai, b+bi );
          if ( Result <> 0 ) then
            break;
          end;
        end;

      if ( ca = #0 ) and ( cb = #0 ) then
        begin
        {
          The strings compare the same. Perhaps the caller
          will want to call strcmp to break the tie.
        }
        Result := 0;
        break;
        end;

      if not fold_case then
        begin
        ca := nat_toupper( ca );
        cb := nat_toupper( cb );
        end;

      if ( ca < cb ) then
        begin
        Result := -1;
        break;
        end
      else if ( ca > cb ) then
        begin
        Result := +1;
        break;
        end;
      end;
  end;
begin
  Result := strnatcmp0( Str1, Str2, CaseSensitive );
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// CustomSort functions
function NaturalSortAsc( Grid: {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}; ACol, Index1, Index2: Integer ): Integer;
begin
  result := StrNatCompare( Grid.Rows[ Index1 ].Strings[ ACol ], Grid.Rows[ Index2 ].Strings[ ACol ], false )
end;

function NaturalSortDesc( Grid: {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}; ACol, Index1, Index2: Integer ): Integer;
begin
  result := -NaturalSortAsc( Grid, Acol, Index1, Index2 );
end;

function NaturalSortAscCS( Grid: {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}; ACol, Index1, Index2: Integer ): Integer;
begin
  result := StrNatCompare( Grid.Rows[ Index1 ].Strings[ ACol ], Grid.Rows[ Index2 ].Strings[ ACol ], true )
end;

function NaturalSortDescCS( Grid: {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}; ACol, Index1, Index2: Integer ): Integer;
begin
  result := -NaturalSortAscCS( Grid, Acol, Index1, Index2 );
end;

function DateTimeSortAsc( Grid: {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}; ACol, Index1, Index2: Integer ): Integer;
  function LeftStr(const AText: AnsiString; const ACount: Integer): AnsiString; overload;
  begin
    Result := Copy(WideString(AText), 1, ACount);
  end;

  function LeftStr(const AText: WideString; const ACount: Integer): WideString; overload;
  begin
    Result := Copy(AText, 1, ACount);
  end;
var
  S1, S2 : String;
  D1, D2 : TDateTime;
begin
//  result := StrNatCompare( Grid.Rows[ Index1 ].Strings[ ACol ], Grid.Rows[ Index2 ].Strings[ ACol ], false )

  S1 := Grid.Rows[ Index1 ].Strings[ ACol ];
  D1 := StrToDateTimeDef( S1, 0 );
  if ( D1 <> 0 ) then
    S1 := FloatToStr( D1 );

  S2 := Grid.Rows[ Index2 ].Strings[ ACol ];
  D2 := StrToDateTimeDef( S1, 0 );
  if ( D2 <> 0 ) then
    S2 := FloatToStr( D2 );

  result := StrNatCompare( S1, S2, false )
end;

function DateTimeSortDesc( Grid: {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}; ACol, Index1, Index2: Integer ): Integer;
begin
  result := -DateTimeSortAsc( Grid, Acol, Index1, Index2 );
end;

function DateSortAsc( Grid: {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}; ACol, Index1, Index2: Integer ): Integer;
  function LeftStr(const AText: AnsiString; const ACount: Integer): AnsiString; overload;
  begin
    Result := Copy(WideString(AText), 1, ACount);
  end;

  function LeftStr(const AText: WideString; const ACount: Integer): WideString; overload;
  begin
    Result := Copy(AText, 1, ACount);
  end;
var
  S1, S2 : string;
  D1, D2 : TDateTime;
  c32    : Integer;
begin
//  result := StrNatCompare( Grid.Rows[ Index1 ].Strings[ ACol ], Grid.Rows[ Index2 ].Strings[ ACol ], false )

  S1 := Grid.Rows[ Index1 ].Strings[ ACol ];
  c32 := Pos( ' ', S1 );
  if ( c32 <> 0 ) then
    S1 := LeftStr( S1, c32 );
  D1 := StrToDateDef( S1, 0 );
  if ( D1 <> 0 ) then
    S1 := FloatToStr( D1 );

  S2 := Grid.Rows[ Index2 ].Strings[ ACol ];
  c32 := Pos( ' ', S2 );
  if ( c32 <> 0 ) then
    S2 := LeftStr( S2, c32 );
  D2 := StrToDateDef( S2, 0 );
  if ( D2 <> 0 ) then
    S2 := FloatToStr( D2 );

  result := StrNatCompare( S1, S2, false )
end;

function DateSortDesc( Grid: {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}; ACol, Index1, Index2: Integer ): Integer;
begin
  result := -DateSortAsc( Grid, Acol, Index1, Index2 );
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.Sort( ACol: Integer; Order : TCheckStringGridSortType );
var
  Compare : TCheckStringGridSortCompare;
begin
  if NOT Assigned( self ) then
    Exit;
  if ( ACol < 0 ) OR ( ACol > ColCount-1 ) then
    Exit;
  if ( RowCount-FixedRows < 1 ) then
    Exit;

  case Order of
    cstAscending               : Compare := NaturalSortAsc;
    cstDescending              : Compare := NaturalSortDesc;
    cstAscendingCaseSensitive  : Compare := NaturalSortAscCS;
    cstDescendingCaseSensitive : Compare := NaturalSortDescCS;
    cstAscendingDate           : Compare := DateSortAsc;
    cstDescendingDate          : Compare := DateSortDesc;
    cstAscendingDateTime       : Compare := DateTimeSortAsc;
    cstDescendingDateTime      : Compare := DateTimeSortDesc;
  else
    Exit;
  end;

  fSortCol        := ACol;
  fSortDescending := ( Order in [ cstDescending, cstDescendingCaseSensitive, cstDescendingDate ] );
  QuickSort( ACol, FixedRows, RowCount-1, Compare );
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.CustomSort( ACol : Integer; Compare: TCheckStringGridSortCompare );
begin
  if NOT Assigned( self ) then
    Exit;
  if ( ACol < 0 ) OR ( ACol > ColCount-1 ) then
    Exit;
  if ( RowCount-FixedRows < 1 ) then
    Exit;

  QuickSort( ACol, FixedRows, RowCount-1, Compare );
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.QuickSort( ACol : Integer; StartId, EndId: Integer; SCompare: TCheckStringGridSortCompare );
var
  I, J, P: Integer;
begin
  repeat
    I := StartId;
    J := EndId;
    P := (StartId + EndId) shr 1;
    repeat
      while SCompare( Self, ACol, I, P ) < 0 do
        Inc( I );
      while SCompare( Self, ACol, J, P ) > 0 do
        Dec( J );
      if ( I <= J ) then
        begin
        ExchangeRows( I, J );
        if P = I then
          P := J
        else if P = J then
          P := I;
        Inc( I );
        Dec( J );
        end;
    until ( I > J );
    if StartId < J then
      QuickSort( ACol, StartId, J, SCompare );
    StartId := I;
  until I >= EndId;
end;
{$ENDIF}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
{$IFDEF CELLTYPES}
function {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.GetCellType( ACol, ARow : Integer ) : TOnKeyPressMode;
begin
  result := kpmString;
  if NOT Assigned( self ) then
    Exit;

  if ( ACol > ColCount-1 ) OR ( ARow > RowCount-1 ) then
    Exit;

  if ( ACol <= FixedCols-1 ) OR ( ARow <= FixedRows-1 ) then
    Exit;

  result := fCellType[ ACol, ARow ];
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.SetCellType( ACol, ARow : Integer; value : TOnKeyPressMode );
begin
  if NOT Assigned( self ) then
    Exit;
  if ( ACol > ColCount-1 ) OR( ARow > RowCount-1 ) then
    Exit;
  if ( fCellType[ ACol, ARow ] = value ) then
    Exit;

  fCellType[ ACol, ARow ] := value;
  InvalidateCell( ACol, ARow );
end;

function {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.GetColType( ACol : Integer ) : TOnKeyPressMode;
var
  i : integer;
begin
  result := kpmString;
  if NOT Assigned( self ) then
    Exit;

  if ( ACol > ColCount-1 ) then
    Exit;

//  result := True;
//  if ( ACol <= FixedCols-1 ) then
//    Exit;

  result := fCellType[ ACol, FixedRows ];
  for i := FixedRows to RowCount-1 do
    begin
    if ( i > High( fCellType ) ) then
      break;
    if NOT ( fCellType[ ACol, i ] = result ) then
      begin
      result := kpmString;
      break;
      end;
    end;
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.SetColType( ACol : Integer; value : TOnKeyPressMode );
var
  i : integer;
begin
  if NOT Assigned( self ) then
    Exit;
  if ( ACol > ColCount-1 ) then
    Exit;

  for i := 0 to RowCount-1 do
    CellType[ ACol, i ] := value;
end;

function {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.GetRowType( ARow : Integer ) : TOnKeyPressMode;
var
  i : integer;
begin
  result := kpmString;
  if NOT Assigned( self ) then
    Exit;

  if ( ARow > RowCount-1 ) then
    Exit;

//  result := True;
//  if ( ARow <= FixedRows-1 ) then
//    Exit;

  result := fCellType[ FixedCols, ARow ];
  for i := FixedCols to ColCount-1 do
    begin
    if ( i > High( fCellType ) ) then
      break;
    if NOT ( fCellType[ i, ARow ] = result ) then
      begin
      result := kpmString;
      break;
      end;
    end;
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.SetRowType( ARow : Integer; value : TOnKeyPressMode );
var
  i : integer;
begin
  if NOT Assigned( self ) then
    Exit;
  for i := 0 to ColCount-1 do
    CellType[ i, ARow ] := value;
end;
{$ENDIF}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.GetSelStart : Integer;
var
  SelEnd : Integer;
begin
  GetSelection( result, SelEnd );
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.SetSelStart( Value : Integer );
var
  SelStart,
  SelEnd : Integer;
begin
  GetSelection( SelStart, SelEnd );
  SetSelection( Value, SelEnd );
end;

function {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.GetSelEnd : Integer;
var
  SelStart : Integer;
begin
  GetSelection( SelStart, result );
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.SetSelEnd( Value : Integer );
var
  SelStart,
  SelEnd : Integer;
begin
  GetSelection( SelStart, SelEnd );
  SetSelection( SelStart, Value );
end;

function {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.GetSelText : String;
var
  SelStart,
  SelEnd : Integer;
begin
  result := '';
  if NOT Assigned( self ) then
    Exit;
  GetSelection( SelStart, SelEnd );
  if ( SelStart = SelEnd ) then
    Exit;
  Result := Copy( Cells[ Col, Row ], SelStart+1, SelEnd-SelStart );
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.SetSelText( Value : String );
var
  SelStart,
  SelEnd : Integer;
begin
  if NOT Assigned( self ) then
    Exit;
  GetSelection( SelStart, SelEnd );
  if ( SelStart = SelEnd ) then
    Exit;

  Cells[ Col, Row ] := Copy( Cells[ Col, Row ], 1, SelStart ) + Value + Copy( Cells[ Col, Row ], SelEnd, Length( Cells[ Col, Row ] )-SelEnd );
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.GetSelection( var SelStart : Integer; var SelEnd : Integer );
begin
  SelStart := 0;
  SelEnd   := 0;
  if NOT Assigned( self ) then
    Exit;
  SendMessage( GetWindow( Handle, GW_CHILD ), EM_GETSEL, WPARAM( @SelStart ), LPARAM( @SelEnd ) );
end;

procedure {$IFDEF EXTENDED_STRINGGRID}TStringGrid{$ELSE}TCheckStringGrid{$ENDIF}.SetSelection( SelStart : Integer; SelEnd : Integer );
begin
  if NOT Assigned( self ) then
    Exit;
  SendMessage( GetWindow( Handle, GW_CHILD ), EM_SETSEL, WPARAM( @SelStart ), LPARAM( @SelEnd ) );
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

end.
