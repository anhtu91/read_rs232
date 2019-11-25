unit Unicode;

{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}

interface

uses
  Windows, Classes;

const
  // definitions of often used characters:
  // Note: Use them only for tests of a certain character not to determine character classes like
  //       white spaces as in Unicode are often many code points defined being in a certain class.
  //       Hence your best option is to use the various UnicodeIs* functions.

  // can't use identifier "Null" here as this is already in a special Variant identifier
  WideNull = WideChar(#0);
  Tabulator = WideChar(#9);
  Space = WideChar(#32);

  // logical line breaks
  LF = WideChar($A);
  LineFeed = WideChar($A);
  VerticalTab = WideChar($B);
  FormFeed = WideChar($C);
  CR = WideChar($D);
  CarriageReturn = WideChar($D);
  CRLF: WideString = #$D#$A;
  LineSeparator = WideChar($2028);
  ParagraphSeparator = WideChar($2029);

  // byte order marks for strings
  // Unicode text files should contain $FFFE as first character to identify such a file clearly. Depending on the system
  // where the file was created on this appears either in big endian or little endian style.
  BOM_LSB_FIRST = WideChar($FEFF); // this is how the BOM appears on x86 systems when written by a x86 system
  BOM_MSB_FIRST = WideChar($FFFE);

type
  // Unicode transformation formats (UTF) data types
  UTF7 = Char;
  UTF8 = Char;
  UTF16 = WideChar;
  UTF32 = Cardinal;

  // UTF conversion schemes (UCS) data types
  PUCS4 = ^UCS4;
  UCS4 = Cardinal;
  PUCS2 = PWideChar;
  UCS2 = WideChar;

const
  ReplacementCharacter: UCS4 = $0000FFFD;
  MaximumUCS2: UCS4 = $0000FFFF;
  MaximumUTF16: UCS4 = $0010FFFF;
  MaximumUCS4: UCS4 = $7FFFFFFF;
                          
  SurrogateHighStart: UCS4 = $D800;
  SurrogateHighEnd: UCS4 = $DBFF;
  SurrogateLowStart: UCS4 = $DC00;
  SurrogateLowEnd: UCS4 = $DFFF;

type
  PCardinal = ^Cardinal;

  TWideStrings = class;

  // Event used to give the application a chance to switch the way of how to save the text in TWideStrings
  // if the text contains characters not only from the ANSI block but the save type is
  // ANSI. On triggering the event the application can change the property SaveUnicode
  // as needed. This property is again checked after the callback returns. 
  TConfirmConversionEvent = procedure(Sender: TWideStrings; var Allowed: Boolean) of object;

  TWideStrings = class(TPersistent)
  private
    FUpdateCount: Integer;
    FLanguage: LCID;                   // language can usually left alone, the system's default is used
    FSaved,                            // set in SaveToStream, True in case saving was successfull otherwise False
    FSaveUnicode: Boolean;             // flag set on loading to keep track in which format to save
                                       // (can be set explicitely, but expect losses if there's true Unicode content
                                       // and this flag is set to False)
    FOnConfirmConversion: TConfirmConversionEvent;
    function GetCommaText: WideString;
    function GetName(Index: Integer): WideString;
    function GetValue(const Name: WideString): WideString;
    procedure ReadData(Reader: TReader);
    procedure SetCommaText(const Value: WideString);
    procedure SetValue(const Name, Value: WideString);
    procedure WriteData(Writer: TWriter);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure Error(const Msg: String; Data: Integer);
    function Get(Index: Integer): WideString; virtual; abstract;
    function GetCapacity: Integer; virtual;
    function GetCount: Integer; virtual; abstract;
    function GetObject(Index: Integer): TObject; virtual;
    function GetTextStr: WideString; virtual;
    procedure Put(Index: Integer; const S: WideString); virtual;
    procedure PutObject(Index: Integer; AObject: TObject); virtual;
    procedure SetCapacity(NewCapacity: Integer); virtual;
    procedure SetTextStr(const Value: WideString); virtual;
    procedure SetUpdateState(Updating: Boolean); virtual;
    procedure SetLanguage(Value: LCID); virtual;
    function CompareStrings(const S1, S2: WideString): Integer; virtual;
  public
    constructor Create;
    destructor Destroy; override;

    function Add(const S: WideString): Integer; virtual;
    function AddObject(const S: WideString; AObject: TObject): Integer; virtual;
    procedure Append(const S: WideString);
    procedure AddStrings(Strings: TStrings); overload; virtual;
    procedure AddStrings(Strings: TWideStrings); overload; virtual; 
    procedure Assign(Source: TPersistent); override;
    procedure AssignTo(Dest: TPersistent); override;
    procedure BeginUpdate;
    procedure Clear; virtual; abstract;
    procedure Delete(Index: Integer); virtual; abstract;
    procedure EndUpdate;
    function Equals(Strings: TWideStrings): Boolean;
    procedure Exchange(Index1, Index2: Integer); virtual;
    function GetText: PWideChar; virtual;
    function IndexOf(const S: WideString): Integer; virtual;
    function IndexOfName(const Name: WideString): Integer;
    function IndexOfObject(AObject: TObject): Integer;
    procedure Insert(Index: Integer; const S: WideString); virtual; abstract;
    procedure InsertObject(Index: Integer; const S: WideString; AObject: TObject);
    procedure LoadFromFile(const FileName: String); virtual;
    procedure LoadFromStream(Stream: TStream); virtual;
    procedure Move(CurIndex, NewIndex: Integer); virtual;
    procedure SaveToFile(const FileName: String); virtual;
    procedure SaveToStream(Stream: TStream); virtual;
    procedure SetText(Text: PWideChar); virtual;

    property Capacity: Integer read GetCapacity write SetCapacity;
    property CommaText: WideString read GetCommaText write SetCommaText;
    property Count: Integer read GetCount;
    property Language: LCID read FLanguage write SetLanguage;
    property Names[Index: Integer]: WideString read GetName;
    property Objects[Index: Integer]: TObject read GetObject write PutObject;
    property Values[const Name: WideString]: WideString read GetValue write SetValue;
    property Saved: Boolean read FSaved;
    property SaveUnicode: Boolean read FSaveUnicode write FSaveUnicode;
    property Strings[Index: Integer]: WideString read Get write Put; default;
    property Text: WideString read GetTextStr write SetTextStr;

    property OnConfirmConversion: TConfirmConversionEvent read FOnConfirmConversion write FOnConfirmConversion;
  end;

  // TWideStringList class
  TWideStringList = class;

  TWideStringItem = record
    FString: WideString;
    FObject: TObject;
  end;

  TWideStringItemList = array of TWideStringItem;
  TWideStringListSortCompare = function(List: TWideStringList; Index1, Index2: Integer): Integer;

  TWideStringList = class(TWideStrings)
  private
    FList: TWideStringItemList;
    FCount: Integer;
    FSorted: Boolean;
    FDuplicates: TDuplicates;
    FCaseSensitive: Boolean;
    FOnChange: TNotifyEvent;
    FOnChanging: TNotifyEvent;
    procedure ExchangeItems(Index1, Index2: Integer);
    procedure Grow;
    procedure QuickSort(L, R: Integer; SCompare: TWideStringListSortCompare);
    procedure InsertItem(Index: Integer; const S: WideString);
    procedure SetSorted(Value: Boolean);
    procedure SetCaseSensitive(const Value: Boolean);
  protected
    procedure Changed; virtual;
    procedure Changing; virtual;
    function Get(Index: Integer): WideString; override;
    function GetCapacity: Integer; override;
    function GetCount: Integer; override;
    function GetObject(Index: Integer): TObject; override;
    procedure Put(Index: Integer; const S: WideString); override;
    procedure PutObject(Index: Integer; AObject: TObject); override;
    procedure SetCapacity(NewCapacity: Integer); override;
    procedure SetUpdateState(Updating: Boolean); override;
    procedure SetLanguage(Value: LCID); override;
    function CompareStrings(const S1, S2: WideString): Integer; override;
  public
    destructor Destroy; override;

    function Add(const S: WideString): Integer; override;
    procedure Clear; override;
    procedure Delete(Index: Integer); override;
    procedure Exchange(Index1, Index2: Integer); override;
    function Find(const S: WideString; var Index: Integer): Boolean; virtual;
    function IndexOf(const S: WideString): Integer; override;
    procedure Insert(Index: Integer; const S: WideString); override;
    procedure Sort; virtual;

    procedure CustomSort(Compare: TWideStringListSortCompare); virtual;
    property Duplicates: TDuplicates read FDuplicates write FDuplicates;
    property Sorted: Boolean read FSorted write SetSorted;
    property CaseSensitive: Boolean read FCaseSensitive write SetCaseSensitive;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnChanging: TNotifyEvent read FOnChanging write FOnChanging;
  end;


// utility functions
function StrNewW(Str: PWideChar): PWideChar;
function StrEndW(Str: PWideChar): PWideChar;

function StrLenW(Str: PWideChar): Cardinal;
function StrMoveW(Dest, Source: PWideChar; Count: Cardinal): PWideChar;
function StrScanW(Str: PWideChar; Chr: WideChar): PWideChar; overload;
function StrScanW(Str: PWideChar; Chr: WideChar; StrLen: Cardinal): PWideChar; overload;
function StrAllocW(Size: Cardinal): PWideChar;
procedure StrSwapByteOrder(Str: PWideChar);

function UnicodeIsWhiteSpace(C: UCS4): Boolean;
function UnicodeIsNonSpacing(C: UCS4): Boolean;
function UnicodeIsHangul(C: UCS4): Boolean;
function UnicodeIsControl(C: UCS4): Boolean;
function UnicodeIsComposite(C: UCS4): Boolean;


function CodePageFromLocale(Language: LCID): Integer;

function WideQuotedStr(const S: WideString; Quote: WideChar): WideString;
function WideExtractQuotedStr(var Src: PWideChar; Quote: WideChar): WideString;

function WideStringToString(var ws: WideString; codePage: Word): AnsiString;
function StringToWideString(const s: AnsiString; codePage: Word): WideString;
function GetDefaultAnsiCodepage(LangID: LCID; defCP: integer): word;

{ functions taken from JCLUnicode.pas }
function WStrComp(Str1, Str2: PWideChar): Integer;
function WStrLComp(Str1, Str2: PWideChar; MaxLen: Cardinal): Integer;
function UnicodeStringOfChar(C: WideChar; Count: Cardinal): WideString;
function WideTrim(const S: WideString): WideString;
function WideTrimLeft(const S: WideString): WideString;
function WideTrimRight(const S: WideString): WideString;

{$IFNDEF UNICODE}
var
  DefaultSystemCodePage: Cardinal; // implicitly used when converting AnsiString <--> WideString.
{$ENDIF}
{$IFNDEF Win64}
var
  Win32PlatformIsUnicode: Boolean;

function WCharUpper(lpsz: PWideChar): PWideChar;
function WCharUpperBuff(lpsz: PWideChar; cchLength: DWORD): DWORD;
function WCharLower(lpsz: PWideChar): PWideChar;
function WCharLowerBuff(lpsz: PWideChar; cchLength: DWORD): DWORD;

function IsWideCharMappableToAnsi(const WC: WideChar): Boolean;
function IsUnicodeStringMappableToAnsi(const WS: WideString): Boolean;

function UnicodeToUtf8(Dest: PAnsiChar; MaxDestBytes: Cardinal;
  Source: PWideChar; SourceChars: Cardinal): Cardinal;
function Utf8ToUnicode(Dest: PWideChar; MaxDestChars: Cardinal;
  Source: PAnsiChar; SourceBytes: Cardinal): Cardinal;
function UTF8Encode(const WS: WideString): UTF8String;
function UTF8Decode(const S: UTF8String): WideString;
function AnsiToUtf8(const S: string): UTF8String;
function Utf8ToAnsi(const S: UTF8String): string;

function WideCompareStr(const S1, S2: WideString): Integer;
function WideCompareText_(const S1, S2: WideString): Integer;
{$ENDIF}

//----------------------------------------------------------------------------------------------------------------------

implementation

// ~67K Unicode data for case mapping, decomposition, numbers etc.
// This data is loaded on demand which means only those parts will be put in memory which are needed
// by one of the lookup functions.
{$IfDEF QR4}
  {$R Unicode.res}
{$endif}

uses
  SyncObjs, SysUtils;

resourcestring
  SUREBaseString = 'Error in regular expression: %s' + #13;
  SUREUnexpectedEOS = 'Unexpected end of pattern.';
  SURECharacterClassOpen = 'Character class not closed, '']'' is missing.';
  SUREUnbalancedGroup = 'Unbalanced group expression, '')'' is missing.';
  SUREInvalidCharProperty = 'A character property is invalid';
  SUREInvalidRepeatRange = 'Invalid repeation range.';
  SURERepeatRangeOpen = 'Repeation range not closed, ''}'' is missing.';
  SUREExpressionEmpty = 'Expression is empty.';

type
  TCompareFunc = function (W1, W2: WideString; Locale: LCID): Integer;

var
  WideCompareText: TCompareFunc;

//----------------- Loader routines for resource data ------------------------------------------------------------------

const
  // Values that can appear in the Mask1 parameter of the IsProperty function.
  UC_MN = $00000001; // Mark, Non-Spacing
  UC_MC = $00000002; // Mark, Spacing Combining
  UC_ME = $00000004; // Mark, Enclosing
  UC_ND = $00000008; // Number, Decimal Digit
  UC_NL = $00000010; // Number, Letter
  UC_NO = $00000020; // Number, Other
  UC_ZS = $00000040; // Separator, Space
  UC_ZL = $00000080; // Separator, Line
  UC_ZP = $00000100; // Separator, Paragraph
  UC_CC = $00000200; // Other, Control
  UC_CF = $00000400; // Other, Format
  UC_OS = $00000800; // Other, Surrogate
  UC_CO = $00001000; // Other, private use
  UC_CN = $00002000; // Other, not assigned
  UC_LU = $00004000; // Letter, Uppercase
  UC_LL = $00008000; // Letter, Lowercase
  UC_LT = $00010000; // Letter, Titlecase
  UC_LM = $00020000; // Letter, Modifier
  UC_LO = $00040000; // Letter, Other
  UC_PC = $00080000; // Punctuation, Connector
  UC_PD = $00100000; // Punctuation, Dash
  UC_PS = $00200000; // Punctuation, Open
  UC_PE = $00400000; // Punctuation, Close
  UC_PO = $00800000; // Punctuation, Other
  UC_SM = $01000000; // Symbol, Math
  UC_SC = $02000000; // Symbol, Currency
  UC_SK = $04000000; // Symbol, Modifier
  UC_SO = $08000000; // Symbol, Other
  UC_L  = $10000000; // Left-To-Right
  UC_R  = $20000000; // Right-To-Left
  UC_EN = $40000000; // European Number
  UC_ES = $80000000; // European Number Separator

  // Values that can appear in the Mask2 parameter of the IsProperty function
  UC_ET = $00000001; // European Number Terminator
  UC_AN = $00000002; // Arabic Number
  UC_CS = $00000004; // Common Number Separator
  UC_B  = $00000008; // Block Separator
  UC_S  = $00000010; // Segment (unit) Separator (this includes tab and vertical tab)
  UC_WS = $00000020; // Whitespace
  UC_ON = $00000040; // Other Neutrals

  // Implementation specific character properties.
  UC_CM = $00000080; // Composite
  UC_NB = $00000100; // Non-Breaking
  UC_SY = $00000200; // Symmetric
  UC_HD = $00000400; // Hex Digit
  UC_QM = $00000800; // Quote Mark
  UC_MR = $00001000; // Mirroring
  UC_SS = $00002000; // Space, other

  UC_CP = $00004000; // Defined

  // Added for UnicodeData-2.1.3.
  UC_PI = $00008000; // Punctuation, Initial
  UC_PF = $00010000; // Punctuation, Final

type
  TUHeader = record
    BOM: WideChar;
    Count: Word;
    case Boolean of
      True:
        (Bytes: Cardinal);
      False:
        (Len: array[0..1] of Word);
  end;

  TWordArray = array of Word;
  TCardinalArray = array of Cardinal;

var
  // As the global data can be accessed by several threads it should be guarded
  // while the data is loaded.
  LoadInProgress: TCriticalSection;

//----------------- internal support routines --------------------------------------------------------------------------

function SwapCardinal(C: Cardinal): Cardinal;

// swaps all bytes in C from MSB to LSB order
// EAX contains both parameter as well as result

asm
              BSWAP EAX
end;

//----------------- support for character properties -------------------------------------------------------------------

var
  PropertyOffsets: TWordArray;
  PropertyRanges: TCardinalArray;

procedure LoadUnicodeTypeData;

// loads the character property data (as saved by the Unicode database extractor into the ctype.dat file)

var
  I, Size: Integer;
  Header: TUHeader;
  Stream: TResourceStream;

begin
  // make sure no other code is currently modifying the global data area
  if LoadInProgress = nil then LoadInProgress := TCriticalSection.Create;
  LoadInProgress.Enter;

  // Data already loaded?
  if PropertyOffsets = nil then
  begin
    Stream := TResourceStream.Create(HInstance, 'TYPE', 'UNICODE');
    Stream.Read(Header, SizeOf(Header));

    if Header.BOM = BOM_MSB_FIRST then
    begin
      Header.Count := Swap(Header.Count);
      Header.Bytes := SwapCardinal(Header.Bytes);
    end;

    // Calculate the offset into the storage for the ranges.  The offsets
    // array is on a 4-byte boundary and one larger than the value provided in
    // the header count field. This means the offset to the ranges must be
    // calculated after aligning the count to a 4-byte boundary.
    Size := (Header.Count + 1) * SizeOf(Word);
    if (Size and 3) <> 0 then Inc(Size, 4 - (Size and 3));

    // fill offsets array
    SetLength(PropertyOffsets, Size div SizeOf(Word));
    Stream.Read(PropertyOffsets[0], Size);

    // Do an endian swap if necessary.  Don't forget there is an extra node on the end with the final index.
    if Header.BOM = BOM_MSB_FIRST then
    begin
      for I := 0 to Header.Count do
          PropertyOffsets[I] := Swap(PropertyOffsets[I]);
    end;

    // Load the ranges.  The number of elements is in the last array position of the offsets.
    SetLength(PropertyRanges, PropertyOffsets[Header.Count]);
    Stream.Read(PropertyRanges[0], PropertyOffsets[Header.Count] * SizeOf(Cardinal));

    // Do an endian swap if necessary.
    if Header.BOM = BOM_MSB_FIRST then
    begin
      for I := 0 to PropertyOffsets[Header.Count] - 1 do
        PropertyRanges[I] := SwapCardinal(PropertyRanges[I]);
    end;
    Stream.Free;
  end;
  LoadInProgress.Leave;
end;

//----------------------------------------------------------------------------------------------------------------------

function PropertyLookup(Code, N: Cardinal): Boolean;

var
  L, R, M: Integer;

begin
  // load property data if not already done
  if PropertyOffsets = nil then LoadUnicodeTypeData;
  
  Result := False;
  // There is an extra node on the end of the offsets to allow this routine
  // to work right.  If the index is 0xffff, then there are no nodes for the property.
  L := PropertyOffsets[N];
  if L <> $FFFF then
  begin
    // Locate the next offset that is not 0xffff.  The sentinel at the end of
    // the array is the max index value.
    M := 1;
    while ((Integer(N) + M) < High(PropertyOffsets)) and (PropertyOffsets[Integer(N) + M] = $FFFF) do Inc(M);

    R := PropertyOffsets[Integer(N) + M] - 1;

    while L <= R do
    begin
      // Determine a "mid" point and adjust to make sure the mid point is at
      // the beginning of a range pair.
      M := (L + R) shr 1;
      Dec(M, M and 1);
      if Code > PropertyRanges[M + 1] then L := M + 2
                                      else
        if Code < PropertyRanges[M] then R := M - 2
                                    else
          if (Code >= PropertyRanges[M]) and (Code <= PropertyRanges[M + 1]) then
          begin
            Result := True;
            Break;
          end;
    end;
  end;
end;

//----------------------------------------------------------------------------------------------------------------------

function IsProperty(Code, Mask1, Mask2: Cardinal): Boolean;

var
  I: Cardinal;
  Mask: Cardinal;
  
begin
  Result := False;
  if Mask1 <> 0 then
  begin
    Mask := 1;
    for I := 0 to 31 do
    begin
      if ((Mask1 and Mask) <> 0) and PropertyLookup(Code, I) then
      begin
        Result := True;
        Exit;
      end;
      Mask := Mask shl 1;
    end;
  end;

  if Mask2 <> 0 then
  begin
    I := 32;
    Mask := 1;
    while I < Cardinal(High(PropertyOffsets)) do
    begin
      if ((Mask2 and Mask) <> 0) and PropertyLookup(Code, I) then
      begin
        Result := True;
        Exit;
      end;
      Inc(I);
      Mask := Mask shl 1;
    end;
  end;
end;

//----------------- TWideStrings ---------------------------------------------------------------------------------------

constructor TWideStrings.Create;

begin
  inherited;
  // there should seldom be the need to use a language other than the one of the system
  FLanguage := GetUserDefaultLCID;
end;

//----------------------------------------------------------------------------------------------------------------------

destructor TWideStrings.Destroy;

begin
  inherited;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TWideStrings.SetLanguage(Value: LCID);

begin
  FLanguage := Value;
end;

function TWideStrings.CompareStrings(const S1, S2: WideString): Integer;
begin
  Result := WideCompareText(S1, S2, FLanguage);
end;

//----------------------------------------------------------------------------------------------------------------------

function TWideStrings.Add(const S: WideString): Integer;

begin
  Result := GetCount;
  Insert(Result, S);
end;

//----------------------------------------------------------------------------------------------------------------------

function TWideStrings.AddObject(const S: WideString; AObject: TObject): Integer;

begin
  Result := Add(S);
  PutObject(Result, AObject);
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TWideStrings.Append(const S: WideString);

begin
  Add(S);
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TWideStrings.AddStrings(Strings: TStrings);

var
  I: Integer;

begin
  BeginUpdate;
  try
    for I := 0 to Strings.Count - 1 do AddObject(Strings[I], Strings.Objects[I]);
  finally
    EndUpdate;
  end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TWideStrings.AddStrings(Strings: TWideStrings);

var
  I: Integer;

begin
  BeginUpdate;
  try
    for I := 0 to Strings.Count - 1 do AddObject(Strings[I], Strings.Objects[I]);
  finally
    EndUpdate;
  end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TWideStrings.Assign(Source: TPersistent);

// usual assignment routine, but able to assign wide and small strings

var
  I: Integer;

begin
  if Source is TWideStrings then
  begin
    BeginUpdate;
    try
      Clear;
      AddStrings(TWideStrings(Source));
    finally
      EndUpdate;
    end;
  end
  else
    if Source is TStrings then
    begin
      BeginUpdate;
      try
        Clear;
        for I := 0 to TStrings(Source).Count - 1 do AddObject(TStrings(Source)[I], TStrings(Source).Objects[I]);
      finally
        EndUpdate;
      end;
    end
    else inherited Assign(Source);
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TWideStrings.AssignTo(Dest: TPersistent);

// need to do also assignment to old style TStrings, but this class doesn't know TWideStrings, so
// we need to do it from here

var
  I: Integer;

begin
  if Dest is TStrings then
    with Dest as TStrings do
    begin
      BeginUpdate;
      try
        Clear;
        for I := 0 to Self.Count - 1 do AddObject(Self[I], Self.Objects[I]);
      finally
        EndUpdate;
      end;
    end
    else
      if Dest is TWideStrings then
        with Dest as TWideStrings do
        begin
          BeginUpdate;
          try
            Clear;
            AddStrings(Self);
          finally
            EndUpdate;
          end;
        end
        else inherited;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TWideStrings.BeginUpdate;

begin
  if FUpdateCount = 0 then SetUpdateState(True);
  Inc(FUpdateCount);
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TWideStrings.DefineProperties(Filer: TFiler);

  function DoWrite: Boolean;

  begin
    if Filer.Ancestor <> nil then
    begin
      Result := True;
      if Filer.Ancestor is TWideStrings then Result := not Equals(TWideStrings(Filer.Ancestor))
    end
    else Result := Count > 0;
  end;

begin
  Filer.DefineProperty('WideStrings', ReadData, WriteData, DoWrite);
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TWideStrings.EndUpdate;

begin
  Dec(FUpdateCount);
  if FUpdateCount = 0 then SetUpdateState(False);
end;

//----------------------------------------------------------------------------------------------------------------------

function TWideStrings.Equals(Strings: TWideStrings): Boolean;

var
  I, Count: Integer;

begin
  Result := False;
  Count := GetCount;
  if Count <> Strings.GetCount then Exit;
  for I := 0 to Count - 1 do
    if Get(I) <> Strings.Get(I) then Exit;
  Result := True;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TWideStrings.Error(const Msg: String; Data: Integer);

  function ReturnAddr: Pointer;

  asm
          MOV EAX, [EBP + 4]
  end;

begin
  raise EStringListError.CreateFmt(Msg, [Data]) at ReturnAddr;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TWideStrings.Exchange(Index1, Index2: Integer);

var
  TempObject: TObject;
  TempString: WideString;

begin
  BeginUpdate;
  try
    TempString := Strings[Index1];
    TempObject := Objects[Index1];
    Strings[Index1] := Strings[Index2];
    Objects[Index1] := Objects[Index2];
    Strings[Index2] := TempString;
    Objects[Index2] := TempObject;
  finally
    EndUpdate;
  end;
end;

//----------------------------------------------------------------------------------------------------------------------

function TWideStrings.GetCapacity: Integer;

begin  // descendants may optionally override/replace this default implementation
  Result := Count;
end;

//----------------------------------------------------------------------------------------------------------------------

function TWideStrings.GetCommaText: WideString;

var
  S: WideString;
  P: PWideChar;
  I,
  Count: Integer;

begin
  Count := GetCount;
  if (Count = 1) and (Get(0) = '') then Result := '""'
                                   else
  begin
    Result := '';
    for I := 0 to Count - 1 do
    begin
      S := Get(I);
      P := PWideChar(S);
      while not (P^ in [WideNull..Space, WideChar('"'), WideChar(',')]) do Inc(P);
      if (P^ <> WideNull) then S := WideQuotedStr(S, '"');
      Result := Result + S + ', ';
    end;
    System.Delete(Result, Length(Result), 1);
  end;
end;

//----------------------------------------------------------------------------------------------------------------------

function TWideStrings.GetName(Index: Integer): WideString;

var
  P: Integer;

begin
  Result := Get(Index);
  P := Pos('=', Result);
  if P > 0 then SetLength(Result, P - 1)
           else Result := '';
end;

//----------------------------------------------------------------------------------------------------------------------

function TWideStrings.GetObject(Index: Integer): TObject;

begin
  Result := nil;
end;

//----------------------------------------------------------------------------------------------------------------------

function TWideStrings.GetText: PWideChar;

begin
  Result := StrNewW(PWideChar(GetTextStr));
end;

//----------------------------------------------------------------------------------------------------------------------

function TWideStrings.GetTextStr: WideString;

var
  I, L,
  Size,
  Count: Integer;
  P: PWideChar;
  S: WideString;

begin
  Count := GetCount;
  Size := 0;
  for I := 0 to Count - 1 do Inc(Size, Length(Get(I)) + 2);
  SetLength(Result, Size);
  P := Pointer(Result);
  for I := 0 to Count - 1 do
  begin
    S := Get(I);
    L := Length(S);
    if L <> 0 then
    begin
      System.Move(Pointer(S)^, P^, 2 * L);
      Inc(P, L);
    end;
    P^ := CarriageReturn;
    Inc(P);
    P^ := LineFeed;
    Inc(P);
  end;
end;

//----------------------------------------------------------------------------------------------------------------------

function TWideStrings.GetValue(const Name: WideString): WideString;

var
  I: Integer;

begin
  I := IndexOfName(Name);
  if I >= 0 then Result := Copy(Get(I), Length(Name) + 2, MaxInt)
            else Result := '';
end;

//----------------------------------------------------------------------------------------------------------------------

function TWideStrings.IndexOf(const S: WideString): Integer;

begin
  for Result := 0 to GetCount - 1 do
    if WideCompareText(Get(Result), S, FLanguage) = 0 then Exit;
  Result := -1;
end;

//----------------------------------------------------------------------------------------------------------------------

function TWideStrings.IndexOfName(const Name: WideString): Integer;

var
  P: Integer;
  S: WideString;

begin
  for Result := 0 to GetCount - 1 do
  begin
    S := Get(Result);
    P := Pos('=', S);
    if (P > 0) and (WideCompareText(Copy(S, 1, P - 1), Name, FLanguage) = 0) then Exit;
  end;
  Result := -1;
end;

//----------------------------------------------------------------------------------------------------------------------

function TWideStrings.IndexOfObject(AObject: TObject): Integer;

begin
  for Result := 0 to GetCount - 1 do
    if GetObject(Result) = AObject then Exit;
  Result := -1;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TWideStrings.InsertObject(Index: Integer; const S: WideString; AObject: TObject);

begin
  Insert(Index, S);
  PutObject(Index, AObject);
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TWideStrings.LoadFromFile(const FileName: String);

var
  Stream: TStream;

begin
  try
    Stream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyNone);
    try
      LoadFromStream(Stream);
    finally
      Stream.Free;
    end;
  except
    RaiseLastOSError;
  end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TWideStrings.LoadFromStream(Stream: TStream);

// usual loader routine, but enhanced to handle byte order marks in stream

var
  Size,
  BytesRead: Integer;
  Order: WideChar;
  SW: WideString;
  SA: String;
begin
  BeginUpdate;
  try
    Size := Stream.Size - Stream.Position;
    BytesRead := Stream.Read(Order, 2);
    if (Order = BOM_LSB_FIRST) or (Order = BOM_MSB_FIRST) then
    begin
      FSaveUnicode := True;
      SetLength(SW, (Size - 2) div 2);
      Stream.Read(PWideChar(SW)^, Size - 2);
      if Order = BOM_MSB_FIRST then StrSwapByteOrder(PWideChar(SW));
      SetTextStr(SW);
    end
    else
    begin
      // without byte order mark it is assumed that we are loading ANSI text
      FSaveUnicode := False;
      Stream.Seek(-BytesRead, soFromCurrent);
      SetLength(SA, Size);
      Stream.Read(PChar(SA)^, Size);
      SetTextStr(SA);
    end;
  finally
    EndUpdate;
  end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TWideStrings.Move(CurIndex, NewIndex: Integer);

var
  TempObject: TObject;
  TempString: WideString;

begin
  if CurIndex <> NewIndex then
  begin
    BeginUpdate;
    try
      TempString := Get(CurIndex);
      TempObject := GetObject(CurIndex);
      Delete(CurIndex);
      InsertObject(NewIndex, TempString, TempObject);
    finally
      EndUpdate;
    end;
  end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TWideStrings.Put(Index: Integer; const S: WideString);

var
  TempObject: TObject;

begin
  TempObject := GetObject(Index);
  Delete(Index);
  InsertObject(Index, S, TempObject);
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TWideStrings.PutObject(Index: Integer; AObject: TObject);

begin
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TWideStrings.ReadData(Reader: TReader);

begin
  Reader.ReadListBegin;
  BeginUpdate;
  try
    Clear;
    while not Reader.EndOfList do
    Add(Reader.ReadWideString);
  finally
    EndUpdate;
  end;
  Reader.ReadListEnd;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TWideStrings.SaveToFile(const FileName: String);

var
  Stream: TStream;

begin
  Stream := TFileStream.Create(FileName, fmCreate);
  try
    SaveToStream(Stream);
  finally
    Stream.Free;
  end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TWideStrings.SaveToStream(Stream: TStream);

var
  SW, BOM: WideString;
  SA: String;
  Allowed: Boolean;
  Run: PWideChar;

begin
  // The application can decide in which format to save the content.
  // If FSaveUnicode is False then all strings are saved in standard ANSI format
  // which is also loadable by TStrings but you should be aware that all Unicode
  // strings are then converted to ANSI based on the current system locale.
  // An extra event is supplied to ask the user about the potential loss of information
  // when converting Unicode to ANSI strings.
  SW := GetTextStr;
  Allowed := True;
  FSaved := False; // be pessimistic
  // check for potential information loss makes only sense if the application has set
  // an event to be used as call back to ask about the conversion
  if not FSaveUnicode and Assigned(FOnConfirmConversion) then
  begin
    // application requests to save only ANSI characters, so check the text and
    // call back in case information could be lost
    Run := PWideChar(SW);
    // only ask if there's at least one Unicode character in the text
    while Run^ in [WideChar(#1)..WideChar(#255)] do Inc(Run);
    // Note: The application can still set FSaveUnicode to True in the callback.
    if Run^ <> WideNull then FOnConfirmConversion(Self, Allowed);
  end;

  if Allowed then
  begin
    // only save if allowed
    if FSaveUnicode then
    begin
      BOM := BOM_LSB_FIRST;
      Stream.WriteBuffer(PWideChar(BOM)^, 2);
      // SW has already been filled
      Stream.WriteBuffer(PWideChar(SW)^, 2 * Length(SW));
    end
    else
    begin
      // implicit conversion to ANSI
      SA := SW;
      {$WARN SUSPICIOUS_TYPECAST OFF}
      if Allowed then Stream.WriteBuffer(PWideChar(SA)^, Length(SA));
      {$WARN SUSPICIOUS_TYPECAST ON}
    end;
    FSaved := True;
  end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TWideStrings.SetCapacity(NewCapacity: Integer);

begin
  // do nothing - descendants may optionally implement this method
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TWideStrings.SetCommaText(const Value: WideString);

var
  P, P1: PWideChar;
  S: WideString;

begin
  BeginUpdate;
  try
    Clear;
    P := PWideChar(Value);
    while P^ in [WideChar(#1)..Space] do Inc(P);
    while P^ <> WideNull do
    begin
      if P^ = '"' then  S := WideExtractQuotedStr(P, '"')
                  else
      begin
        P1 := P;
        while (P^ > Space) and (P^ <> ', ') do Inc(P);
        SetString(S, P1, P - P1);
      end;
      Add(S);

      while P^ in [WideChar(#1)..Space] do Inc(P);
      if P^ = ', ' then
        repeat
          Inc(P);
        until not (P^ in [WideChar(#1)..Space]);
    end;
  finally
    EndUpdate;
  end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TWideStrings.SetText(Text: PWideChar);

begin
  SetTextStr(Text);
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TWideStrings.SetTextStr(const Value: WideString);

var
  Head,
  Tail: PWideChar;
  S: WideString;

begin
  BeginUpdate;
  try
    Clear;
    Head := PWideChar(Value);
    while Head^ <> WideNull do
    begin
      Tail := Head;
      while not (Tail^ in [WideNull, LineFeed, CarriageReturn, VerticalTab, FormFeed]) and
            (Tail^ <> LineSeparator) and
            (Tail^ <> ParagraphSeparator) do Inc(Tail);
      SetString(S, Head, Tail - Head);
      Add(S);
      Head := Tail;
      if Head^ <> WideNull then
      begin
        Inc(Head);
        if (Tail^ = CarriageReturn) and
           (Head^ = LineFeed) then Inc(Head);
      end;
    end;
  finally
    EndUpdate;
  end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TWideStrings.SetUpdateState(Updating: Boolean);

begin
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TWideStrings.SetValue(const Name, Value: WideString);

var
  I : Integer;

begin
  I := IndexOfName(Name);
  if Value <> '' then
  begin
    if I < 0 then I := Add('');
    Put(I, Name + '=' + Value);
  end
  else
    if I >= 0 then Delete(I);
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TWideStrings.WriteData(Writer: TWriter);

var
  I: Integer;

begin
  Writer.WriteListBegin;
  for I := 0 to Count-1 do
  Writer.WriteWideString(Get(I));
  Writer.WriteListEnd;
end;

//----------------- TWideStringList ------------------------------------------------------------------------------------

destructor TWideStringList.Destroy;

begin
  FOnChange := nil;
  FOnChanging := nil;
  FCount := 0;
  FList := nil;
  inherited Destroy;
end;

//----------------------------------------------------------------------------------------------------------------------

function TWideStringList.Add(const S: WideString): Integer;

begin
  if not Sorted then Result := FCount
                else
    if Find(S, Result) then
      case Duplicates of
        dupIgnore:
          Exit;
        dupError:
          Error({SDuplicateString}'Dupe', 0);
      end;
  InsertItem(Result, S);
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TWideStringList.Changed;

begin
  if (FUpdateCount = 0) and Assigned(FOnChange) then FOnChange(Self);
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TWideStringList.Changing;

begin
  if (FUpdateCount = 0) and Assigned(FOnChanging) then FOnChanging(Self);
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TWideStringList.Clear;

begin
  if FCount <> 0 then
  begin
    Changing;
    // this will automatically finalize the array
    FList := nil;
    FCount := 0;
    SetCapacity(0);
    Changed;
  end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TWideStringList.Delete(Index: Integer);

begin
  if (Index < 0) or (Index >= FCount) then Error({SListIndexError}'Unknown', Index);
  Changing;
  FList[Index].FString := '';
  Dec(FCount);
  if Index < FCount then System.Move(FList[Index + 1], FList[Index], (FCount - Index) * SizeOf(TWideStringItem));
  Changed;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TWideStringList.Exchange(Index1, Index2: Integer);

begin
  if (Index1 < 0) or (Index1 >= FCount) then Error({SListIndexError}'Unknown', Index1);
  if (Index2 < 0) or (Index2 >= FCount) then Error({SListIndexError}'Unknown', Index2);
  Changing;
  ExchangeItems(Index1, Index2);
  Changed;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TWideStringList.ExchangeItems(Index1, Index2: Integer);

var
  Temp: TWideStringItem;

begin
  Temp := FList[Index1];
  FList[Index1] := FList[Index2];
  FList[Index2] := Temp;
end;

//----------------------------------------------------------------------------------------------------------------------

function TWideStringList.Find(const S: WideString; var Index: Integer): Boolean;

var
  L, H, I, C: Integer;

begin
  Result := False;
  L := 0;
  H := FCount - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    C := WideCompareText(FList[I].FString, S, FLanguage);
    if C < 0 then L := I+1
             else
    begin
      H := I - 1;
      if C = 0 then
      begin
        Result := True;
        if Duplicates <> dupAccept then L := I;
      end;
    end;
  end;
  Index := L;
end;

//----------------------------------------------------------------------------------------------------------------------

function TWideStringList.Get(Index: Integer): WideString;

begin
  if (Index < 0) or (Index >= FCount) then Error({SListIndexError}'Unknown', Index);
  Result := FList[Index].FString;
end;

//----------------------------------------------------------------------------------------------------------------------

function TWideStringList.GetCapacity: Integer;

begin
  Result := Length(FList);
end;

//----------------------------------------------------------------------------------------------------------------------

function TWideStringList.GetCount: Integer;

begin
  Result := FCount;
end;

//----------------------------------------------------------------------------------------------------------------------

function TWideStringList.GetObject(Index: Integer): TObject;

begin
  if (Index < 0) or (Index >= FCount) then Error({SListIndexError}'Unknown', Index);
  Result := FList[Index].FObject;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TWideStringList.Grow;

var
  Delta,
  Len: Integer;

begin
  Len := Length(FList);
  if Len > 64 then Delta := Len div 4
              else
    if Len > 8 then Delta := 16
               else Delta := 4;
  SetCapacity(Len + Delta);
end;

//----------------------------------------------------------------------------------------------------------------------

function TWideStringList.IndexOf(const S: WideString): Integer;

begin
  if not Sorted then Result := inherited IndexOf(S)
                else
    if not Find(S, Result) then Result := -1;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TWideStringList.Insert(Index: Integer; const S: WideString);

begin
  if Sorted then Error({SSortedListError}'Sort-Error', 0);
  if (Index < 0) or (Index > FCount) then Error({SSortedListError}'Sort-Error', Index);
  InsertItem(Index, S);
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TWideStringList.InsertItem(Index: Integer; const S: WideString);

begin
  Changing;
  if FCount = Length(FList) then Grow;
  if Index < FCount then
    System.Move(FList[Index], FList[Index + 1], (FCount - Index) * SizeOf(TWideStringItem));
  with FList[Index] do
  begin
    Pointer(FString) := nil;
    FObject := nil;
    FString := S;
  end;
  Inc(FCount);
  Changed;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TWideStringList.Put(Index: Integer; const S: WideString);

begin
  if Sorted then Error({SSortedListError}'Sort-Error', 0);
  if (Index < 0) or (Index >= FCount) then Error({SSortedListError}'Sort-Error', Index);
  Changing;
  FList[Index].FString := S;
  Changed;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TWideStringList.PutObject(Index: Integer; AObject: TObject);

begin
  if (Index < 0) or (Index >= FCount) then Error({SListIndexError}'Error', Index);
  Changing;
  FList[Index].FObject := AObject;
  Changed;
end;

//----------------------------------------------------------------------------------------------------------------------
{
procedure TWideStringList.QuickSort(L, R: Integer);
var
  I, J: Integer;
  P: WideString;
begin
  repeat
    I := L;
    J := R;
    P := FList[(L + R) shr 1].FString;
    repeat
      while WideCompareText(FList[I].FString, P, FLanguage) < 0 do Inc(I);
      while WideCompareText(FList[J].FString, P, FLanguage) > 0 do Dec(J);
      if I <= J then
      begin
        ExchangeItems(I, J);
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then QuickSort(L, J);
    L := I;
  until I >= R;
end;
}
procedure TWideStringList.QuickSort(L, R: Integer; SCompare: TWideStringListSortCompare);
var
  I, J, P: Integer;
begin
  repeat
    I := L;
    J := R;
    P := (L + R) shr 1;
    repeat
      while SCompare(Self, I, P) < 0 do Inc(I);
      while SCompare(Self, J, P) > 0 do Dec(J);
      if I <= J then
      begin
        ExchangeItems(I, J);
        if P = I then
          P := J
        else if P = J then
          P := I;
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then QuickSort(L, J, SCompare);
    L := I;
  until I >= R;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TWideStringList.SetCapacity(NewCapacity: Integer);

begin
  SetLength(FList, NewCapacity);
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TWideStringList.SetSorted(Value: Boolean);

begin
  if FSorted <> Value then
  begin
    if Value then Sort;
    FSorted := Value;
  end;
end;

procedure TWideStringList.SetCaseSensitive(const Value: Boolean);
begin
  if Value <> FCaseSensitive then
  begin
    FCaseSensitive := Value;
    if Sorted then Sort;
  end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TWideStringList.SetUpdateState(Updating: Boolean);

begin
  if Updating then Changing
              else Changed;
end;

//----------------------------------------------------------------------------------------------------------------------
{procedure TWideStringList.Sort;
begin
  if not Sorted and (FCount > 1) then
  begin
    Changing;
    QuickSort(0, FCount - 1, );
    Changed;
  end;
end;
}
function StringListCompareStrings(List: TWideStringList; Index1, Index2: Integer): Integer;
begin
  Result := List.CompareStrings(List.FList[Index1].FString,
                                List.FList[Index2].FString);
end;

procedure TWideStringList.Sort;
begin
  CustomSort(StringListCompareStrings);
end;

procedure TWideStringList.CustomSort(Compare: TWideStringListSortCompare);
begin
  if not Sorted and (FCount > 1) then
  begin
    Changing;
    QuickSort(0, FCount - 1, Compare);
    Changed;
  end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TWideStringList.SetLanguage(Value: LCID);

begin
  inherited;
  if Sorted then Sort;
end;

function TWideStringList.CompareStrings(const S1, S2: WideString): Integer;
begin
  if CaseSensitive then
    Result := WideCompareStr(S1, S2)
  else
    Result := WideCompareText(S1, S2, FLanguage);
end;

//----------------------------------------------------------------------------------------------------------------------

function CodePageFromLocale(Language: LCID): Integer;

// determines the code page for a given locale

var
  Buf: array[0..6] of Char;

begin
  GetLocaleInfo(Language, LOCALE_IDefaultAnsiCodePage, Buf, 6);
  Result := StrToIntDef(Buf, GetACP);
end;

//----------------------------------------------------------------------------------------------------------------------

function CompareTextWin95(W1, W2: WideString; Locale: LCID): Integer;

// special comparation function for Win9x since there's no system defined comparation function,
// returns -1 if W1 < W2, 0 if W1 = W2 or 1 if W1 > W2

var
  S1, S2: String;
  CP: Integer;
  L1, L2: Integer;

begin
  L1 := Length(W1);
  L2 := Length(W2);
  SetLength(S1, L1);
  SetLength(S2, L2);
  CP := CodePageFromLocale(Locale);
  WideCharToMultiByte(CP, 0, PWideChar(W1), L1, PChar(S1), L1, nil, nil);
  WideCharToMultiByte(CP, 0, PWideChar(W2), L2, PChar(S2), L2, nil, nil);
  Result := CompareStringA(Locale, NORM_IGNORECASE, PChar(S1), Length(S1), PChar(S2), Length(S2)) - 2;
end;
                                              
//----------------------------------------------------------------------------------------------------------------------

function CompareTextWinNT(W1, W2: WideString; Locale: LCID): Integer;
// Wrapper function for WinNT since there's no system defined comparation function in Win9x and
// we need a central comparation function for TWideStringList.
// Returns -1 if W1 < W2, 0 if W1 = W2 or 1 if W1 > W2

begin
  Result := CompareStringW(Locale, NORM_IGNORECASE, PWideChar(W1), Length(W1), PWideChar(W2), Length(W2)) - 2;
end;

//----------------------------------------------------------------------------------------------------------------------
// Is the character a white space character (same as UnicodeIsSpace plus tabulator, new line etc.)?
function UnicodeIsWhiteSpace(C: UCS4): Boolean; begin Result := IsProperty(C, UC_ZS or UC_SS, UC_WS or UC_S); end;
// Is the character non-spacing?
function UnicodeIsNonSpacing(C: UCS4): Boolean; begin Result := IsProperty(C, UC_MN, 0); end;
// Is the character a pre-composed Hangul syllable?
function UnicodeIsHangul(C: UCS4): Boolean; begin Result := (C >= $AC00) and (C <= $D7FF); end;
// Is the character a control character?
function UnicodeIsControl(C: UCS4): Boolean; begin Result := IsProperty(C, UC_CC or UC_CF, 0); end;
// Can the character be decomposed into a set of other characters?
function UnicodeIsComposite(C: UCS4): Boolean; begin Result := IsProperty(C, 0, UC_CM); end;

//----------------------------------------------------------------------------------------------------------------------
function StrScanW(Str: PWideChar; Chr: WideChar): PWideChar;
// returns a pointer to first occurrence of a specified character in a string

asm
         PUSH EDI
         PUSH EAX
         MOV EDI, Str
         MOV ECX, 0FFFFFFFFH
         XOR AX, AX
         REPNE SCASW
         NOT ECX
         POP EDI
         MOV AX, Chr
         REPNE SCASW
         MOV EAX, 0
         JNE @@1
         MOV EAX, EDI
         SUB EAX, 2
@@1:     POP EDI
end;

//----------------------------------------------------------------------------------------------------------------------
function StrScanW(Str: PWideChar; Chr: WideChar; StrLen: Cardinal): PWideChar;

// returns a pointer to first occurrence of a specified character in a string
// or nil if not found
// Note: this is just a binary search for the specified character and there's no check for
//       a terminating null. Instead at most StrLen characters are searched. This makes
//       this function extremly fast.
//
// on enter EAX contains Str, EDX contains Chr and ECX StrLen
// on exit EAX contains result pointer or nil

asm
         TEST EAX, EAX
         JZ @@Exit                 // get out if the string is nil or StrLen is 0
         JCXZ @@Exit
@@Loop:
         CMP [EAX], DX             // this unrolled loop is actually faster on modern processors
         JE @@Exit                 // than REP SCASW
         INC EAX
         DEC ECX
         JNZ @@Loop
         XOR EAX, EAX
@@Exit:
end;

//----------------------------------------------------------------------------------------------------------------------
function StrAllocW(Size: Cardinal): PWideChar;

// Allocates a buffer for a null-terminated wide string and returns a pointer
// to the first character of the string.

begin
  Size := SizeOf(WideChar) * Size + SizeOf(Cardinal);
  GetMem(Result, Size);
  FillChar(Result^, Size, 0);
  Cardinal(Pointer(Result)^) := Size;
  Inc(Result, SizeOf(Cardinal) div SizeOf(WideChar));
end;

//----------------------------------------------------------------------------------------------------------------------
function WideExtractQuotedStr(var Src: PWideChar; Quote: WideChar): WideString;

// extracts a string enclosed in quote characters given by Quote

var
  P, Dest: PWideChar;
  DropCount: Integer;
    
begin
  Result := '';
  if (Src = nil) or (Src^ <> Quote) then Exit;

  Inc(Src);
  DropCount := 1;
  P := Src;
  Src := StrScanW(Src, Quote);

  while Assigned(Src) do   // count adjacent pairs of quote chars
  begin
    Inc(Src);
    if Src^ <> Quote then Break;
    Inc(Src);
    Inc(DropCount);
    Src := StrScanW(Src, Quote);
  end;

  if Src = nil then Src := StrEndW(P);
  if (Src - P) <= 1 then Exit;
  
  if DropCount = 1 then SetString(Result, P, Src - P - 1)
                   else
  begin
    SetLength(Result, Src - P - DropCount);
    Dest := PWideChar(Result);
    Src := StrScanW(P, Quote);
    while Assigned(Src) do
    begin
      Inc(Src);
      if Src^ <> Quote then Break;
      Move(P^, Dest^, Src - P);
      Inc(Dest, Src - P);
      Inc(Src);
      P := Src;
      Src := StrScanW(Src, Quote);
    end;
    if Src = nil then Src := StrEndW(P);
    Move(P^, Dest^, Src - P - 1);
  end;
end;

//----------------------------------------------------------------------------------------------------------------------
function StrLenW(Str: PWideChar): Cardinal;

// returns number of characters in a string excluding the null terminator

asm
         MOV EDX, EDI
         MOV EDI, EAX
         MOV ECX, 0FFFFFFFFH
         XOR AX, AX
         REPNE SCASW
         MOV EAX, 0FFFFFFFEH
         SUB EAX, ECX
         MOV EDI, EDX
end;

//----------------------------------------------------------------------------------------------------------------------
function StrMoveW(Dest, Source: PWideChar; Count: Cardinal): PWideChar; 

// Copies the specified number of characters to the destination string and returns Dest 
// also as result. Dest must have enough room to store at least Count characters.

asm
         PUSH ESI
         PUSH EDI
         MOV ESI, EDX
         MOV EDI, EAX
         MOV EDX, ECX
         CMP EDI, ESI
         JG @@1
         JE @@2
         SHR ECX, 1
         REP MOVSD
         MOV ECX, EDX
         AND ECX, 1
         REP MOVSW
         JMP @@2

@@1:     LEA ESI, [ESI + 2 * ECX - 2]
         LEA EDI, [EDI + 2 * ECX - 2]
         STD
         AND ECX, 1
         REP MOVSW
         SUB EDI, 2
         SUB ESI, 2
         MOV ECX, EDX
         SHR ECX, 1
         REP MOVSD
         CLD
@@2:     POP EDI
         POP ESI
end;

//----------------------------------------------------------------------------------------------------------------------
procedure StrSwapByteOrder(Str: PWideChar);
// exchanges in each character of the given string the low order and high order
// byte to go from LSB to MSB and vice versa.
// EAX contains address of string

asm
         PUSH ESI
         PUSH EDI
         MOV ESI, EAX
         MOV EDI, ESI
         XOR EAX, EAX  // clear high order byte to be able to use 32bit operand below
@@1:     LODSW
         OR EAX, EAX
         JZ @@2
         XCHG AL, AH
         STOSW
         JMP @@1
         
@@2:     POP EDI
         POP ESI
end;

//----------------------------------------------------------------------------------------------------------------------
function StrNewW(Str: PWideChar): PWideChar;
// Duplicates the given string (if not nil) and returns the address of the new string.
var
  Size: Cardinal;

begin
  if Str = nil then Result := nil
               else
  begin
    Size := StrLenW(Str) + 1;
    Result := StrMoveW(StrAllocW(Size), Str, Size);
  end;
end;

function StrEndW(Str: PWideChar): PWideChar; 

// returns a pointer to the end of a null terminated string

asm
         MOV EDX, EDI
         MOV EDI, EAX
         MOV ECX, 0FFFFFFFFH
         XOR AX, AX
         REPNE SCASW
         LEA EAX, [EDI - 2]
         MOV EDI, EDX
end;

//----------------------------------------------------------------------------------------------------------------------
function WideQuotedStr(const S: WideString; Quote: WideChar): WideString;
// works like QuotedStr from SysUtils.pas but can insert any quotation character

var
  P, Src,
  Dest: PWideChar;
  AddCount: Integer;

begin
  AddCount := 0;
  P := StrScanW(PWideChar(S), Quote);
  while Assigned(P) do
  begin
    Inc(P);
    Inc(AddCount);
    P := StrScanW(P, Quote);
  end;

  if AddCount = 0 then Result := Quote + S + Quote
                  else
  begin
    SetLength(Result, Length(S) + AddCount + 2);
    Dest := PWideChar(Result);
    Dest^ := Quote;
    Inc(Dest);
    Src := PWideChar(S);
    P := StrScanW(Src, Quote);
    repeat
      Inc(P);
      Move(Src^, Dest^, P - Src);
      Inc(Dest, P - Src);
      Dest^ := Quote;
      Inc(Dest);
      Src := P;
      P := StrScanW(Src, Quote);
    until P = nil;
    P := StrEndW(Src);
    Move(Src^, Dest^, P - Src);
    Inc(Dest, P - Src);
    Dest^ := Quote;
  end;  
end;

{:Converts Unicode string to Ansi string using specified code page.
  @param   ws       Unicode string.
  @param   codePage Code page to be used in conversion.
  @returns Converted ansi string.
}

//----------------------------------------------------------------------------------------------------------------------
function WideStringToString(var ws: WideString; codePage: Word): AnsiString;
var
  l: integer;
begin
  if ws = '' then
    Result := ''
  else
  begin
    l := WideCharToMultiByte(codePage,
      WC_COMPOSITECHECK or WC_DISCARDNS or WC_SEPCHARS or WC_DEFAULTCHAR,
      @ws[1], - 1, nil, 0, nil, nil);
    SetLength(Result, l - 1);
    if l > 1 then
      WideCharToMultiByte(codePage,
        WC_COMPOSITECHECK or WC_DISCARDNS or WC_SEPCHARS or WC_DEFAULTCHAR,
        @ws[1], - 1, @Result[1], l - 1, nil, nil)
    else { Dumpcode page to system default and try again }
      codePage := 0;
      l := WideCharToMultiByte(codePage,
        WC_COMPOSITECHECK or WC_DISCARDNS or WC_SEPCHARS or WC_DEFAULTCHAR,
        @ws[1], - 1, nil, 0, nil, nil);
      SetLength(Result, l - 1);
      if l > 1 then
        WideCharToMultiByte(codePage,
          WC_COMPOSITECHECK or WC_DISCARDNS or WC_SEPCHARS or WC_DEFAULTCHAR,
          @ws[1], - 1, @Result[1], l - 1, nil, nil);
  end;
end;

//----------------------------------------------------------------------------------------------------------------------
{:Converts Ansi string to Unicode string using specified code page.
  @param   s        Ansi string.
  @param   codePage Code page to be used in conversion.
  @returns Converted wide string.
}
function StringToWideString(const s: AnsiString; codePage: Word): WideString;
var
  l: integer;
begin
  if s = '' then
    Result := ''
  else 
  begin
    l := MultiByteToWideChar(codePage, MB_PRECOMPOSED, PChar(@s[1]), - 1, nil, 0);
    SetLength(Result, l - 1);
    if l > 1 then
      MultiByteToWideChar(CodePage, MB_PRECOMPOSED, PChar(@s[1]),
        - 1, PWideChar(@Result[1]), l - 1);
  end;
end;
//----------------------------------------------------------------------------------------------------------------------
function GetDefaultAnsiCodepage(LangID: LCID; defCP: integer): word;
var
  p: array [0..255] of char;
begin
  if GetLocaleInfo(LangID, 4100, p, High (p)) > 0 then
    Result := StrToIntDef(p,defCP)
  else
    Result := defCP;
end;

const
  // data used to bring UTF-16 coded strings into correct UTF-32 order for correct comparation
  UTF16Fixup: array[0..31] of Word = (
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    $2000, $F800, $F800, $F800, $F800
  );

// Binary comparation of Str1 and Str2 with surrogate fix-up.
// Returns < 0 if Str1 is smaller in binary order than Str2, = 0 if both strings are
// equal and > 0 if Str1 is larger than Str2.
//
// This code is based on an idea of Markus W. Scherer (IBM).
// Note: The surrogate fix-up is necessary because some single value code points have
//       larger values than surrogates which are in UTF-32 actually larger.
function WStrComp(Str1, Str2: PWideChar): Integer;
var
  C1, C2: Word;
  Run1, Run2: PWideChar;
begin
  Run1 := Str1;
  Run2 := Str2;
  repeat
    C1 := Word(Run1^);
    C1 := Word(C1 + UTF16Fixup[C1 shr 11]);
    C2 := Word(Run2^);
    C2 := Word(C2 + UTF16Fixup[C2 shr 11]);

    // now C1 and C2 are in UTF-32-compatible order
    Result := Integer(C1) - Integer(C2);
    if(Result <> 0) or (C1 = 0) or (C2 = 0) then
      Break;
    Inc(Run1);
    Inc(Run2);
  until False;

  // If the strings have different lengths but the comparation returned equity so far
  // then adjust the result so that the longer string is marked as the larger one.
  if Result = 0 then
    Result := (Run1 - Str1) - (Run2 - Str2);
end;

// compares strings up to MaxLen code points
// see also StrCompW
function WStrLComp(Str1, Str2: PWideChar; MaxLen: Cardinal): Integer;
var
  C1, C2: Word;
begin
  if MaxLen > 0 then
  begin
    repeat
      C1 := Word(Str1^);
      C1 := Word(C1 + UTF16Fixup[C1 shr 11]);
      C2 := Word(Str2^);
      C2 := Word(C2 + UTF16Fixup[C2 shr 11]);

      // now C1 and C2 are in UTF-32-compatible order
      { TODO : surrogates take up 2 words and are counted twice here, count them only once }
      Result := Integer(C1) - Integer(C2);
      Dec(MaxLen);
      if(Result <> 0) or (C1 = 0) or (C2 = 0) or (MaxLen = 0) then
        Break;
      Inc(Str1);
      Inc(Str2);
    until False;
  end
  else
    Result := 0;
end;

// returns a string of Count characters filled with C
function UnicodeStringOfChar(C: WideChar; Count: Cardinal): WideString;
var
  I: Integer;
begin
  SetLength(Result, Count);
  for I := 1 to Count do
    Result[I] := C;
end;

// returns a string of Count characters filled with C
function WideStringOfChar(C: WideChar; Count: Cardinal): WideString;
var
  I: Integer;
begin
  SetLength(Result, Count);
  for I := 1 to Count do
    Result[I] := C;
end;

function WideTrim(const S: WideString): WideString;
var
  I, L: Integer;
begin
  L := Length(S);
  I := 1;
  while (I <= L) and (S[I] <= ' ') do Inc(I);
  if I > L then
    Result := ''
  else
  begin
    while S[L] <= ' ' do Dec(L);
    Result := Copy(S, I, L - I + 1);
  end;
end;

function WideTrimLeft(const S: WideString): WideString;
var
  I, L: Integer;
begin
  L := Length(S);
  I := 1;
  while (I <= L) and (S[I] <= ' ') do Inc(I);
  Result := Copy(S, I, Maxint);
end;

function WideTrimRight(const S: WideString): WideString;
var
  I: Integer;
begin
  I := Length(S);
  while (I > 0) and (S[I] <= ' ') do Dec(I);
  Result := Copy(S, 1, I);
end;

{$IFNDEF Win64}
// The Win9X fix for SynWideUpperCase and SynWideLowerCase was taken
// from Troy Wolbrinks, TntUnicode-package.

function WCharUpper(lpsz: PWideChar): PWideChar;
var
  AStr: AnsiString;
  WStr: WideString;
begin
  if Win32PlatformIsUnicode then
    Result := Windows.CharUpperW(lpsz)
  else
  begin
    if HiWord(Cardinal(lpsz)) = 0 then
    begin
      // literal char mode
      Result := lpsz;
      if IsWideCharMappableToAnsi(WideChar(lpsz)) then
      begin
        AStr := AnsiString(WideChar(lpsz)); // single character may be more than one byte
        Windows.CharUpperA(PAnsiChar(AStr));
        WStr := WideString(AStr); // should always be single wide char
        if Length(WStr) = 1 then
          Result := PWideChar(WStr[1]);
      end
    end
    else
    begin
      // null-terminated string mode
      Result := lpsz;
      while lpsz^ <> #0 do
      begin
        lpsz^ := WideChar(WCharUpper(PWideChar(lpsz^)));
        Inc(lpsz);
      end;
    end;
  end;
end;

function WCharUpperBuff(lpsz: PWideChar; cchLength: DWORD): DWORD;
var
  i: Integer;
begin
  if Win32PlatformIsUnicode then
    Result := Windows.CharUpperBuffW(lpsz, cchLength)
  else
  begin
    Result := cchLength;
    for i := 1 to cchLength do
    begin
      lpsz^ := WideChar(WCharUpper(PWideChar(lpsz^)));
      Inc(lpsz);
    end;
  end;
end;

function WCharLower(lpsz: PWideChar): PWideChar;
var
  AStr: AnsiString;
  WStr: WideString;
begin
  if Win32PlatformIsUnicode then
    Result := Windows.CharLowerW(lpsz)
  else
  begin
    if HiWord(Cardinal(lpsz)) = 0 then
    begin
      // literal char mode
      Result := lpsz;
      if IsWideCharMappableToAnsi(WideChar(lpsz)) then
      begin
        AStr := AnsiString(WideChar(lpsz)); // single character may be more than one byte
        Windows.CharLowerA(PAnsiChar(AStr));
        WStr := WideString(AStr); // should always be single wide char
        if Length(WStr) = 1 then
          Result := PWideChar(WStr[1]);
      end
    end
    else
    begin
      // null-terminated string mode
      Result := lpsz;
      while lpsz^ <> #0 do
      begin
        lpsz^ := WideChar(WCharLower(PWideChar(lpsz^)));
        Inc(lpsz);
      end;
    end;
  end;
end;

function WCharLowerBuff(lpsz: PWideChar; cchLength: DWORD): DWORD;
var
  i: Integer;
begin
  if Win32PlatformIsUnicode then
    Result := Windows.CharLowerBuffW(lpsz, cchLength)
  else
  begin
    Result := cchLength;
    for i := 1 to cchLength do
    begin
      lpsz^ := WideChar(WCharLower(PWideChar(lpsz^)));
      Inc(lpsz);
    end;
  end;
end;

function IsWideCharMappableToAnsi(const WC: WideChar): Boolean;
var
  UsedDefaultChar: BOOL;
begin
  WideCharToMultiByte(DefaultSystemCodePage, 0, PWideChar(@WC), 1, nil, 0, nil,
    @UsedDefaultChar);
  Result := not UsedDefaultChar;
end;

function IsUnicodeStringMappableToAnsi(const WS: WideString): Boolean;
var
  UsedDefaultChar: BOOL;
begin
  WideCharToMultiByte(DefaultSystemCodePage, 0, PWideChar(WS), Length(WS), nil, 0,
    nil, @UsedDefaultChar);
  Result := not UsedDefaultChar;
end;

function UnicodeToUtf8(Dest: PAnsiChar; MaxDestBytes: Cardinal;
  Source: PWideChar; SourceChars: Cardinal): Cardinal;
var
  i, count: Cardinal;
  c: Cardinal;
begin
  Result := 0;
  if Source = nil then Exit;
  count := 0;
  i := 0;
  if Dest <> nil then
  begin
    while (i < SourceChars) and (count < MaxDestBytes) do
    begin
      c := Cardinal(Source[i]);
      Inc(i);
      if c <= $7F then
      begin
        Dest[count] := Char(c);
        Inc(count);
      end
      else if c > $7FF then
      begin
        if count + 3 > MaxDestBytes then
          Break;
        Dest[count] := Char($E0 or (c shr 12));
        Dest[count+1] := Char($80 or ((c shr 6) and $3F));
        Dest[count+2] := Char($80 or (c and $3F));
        Inc(count,3);
      end
      else //  $7F < Source[i] <= $7FF
      begin
        if count + 2 > MaxDestBytes then
          Break;
        Dest[count] := Char($C0 or (c shr 6));
        Dest[count+1] := Char($80 or (c and $3F));
        Inc(count,2);
      end;
    end;
    if count >= MaxDestBytes then count := MaxDestBytes-1;
    Dest[count] := #0;
  end
  else
  begin
    while i < SourceChars do
    begin
      c := Integer(Source[i]);
      Inc(i);
      if c > $7F then
      begin
        if c > $7FF then
          Inc(count);
        Inc(count);
      end;
      Inc(count);
    end;
  end;
  Result := count+1;  // convert zero based index to byte count
end;

function Utf8ToUnicode(Dest: PWideChar; MaxDestChars: Cardinal;
  Source: PAnsiChar; SourceBytes: Cardinal): Cardinal;
var
  i, count: Cardinal;
  c: Byte;
  wc: Cardinal;
begin
  if Source = nil then
  begin
    Result := 0;
    Exit;
  end;
  Result := Cardinal(-1);
  count := 0;
  i := 0;
  if Dest <> nil then
  begin
    while (i < SourceBytes) and (count < MaxDestChars) do
    begin
      wc := Cardinal(Source[i]);
      Inc(i);
      if (wc and $80) <> 0 then
      begin
        if i >= SourceBytes then Exit;          // incomplete multibyte char
        wc := wc and $3F;
        if (wc and $20) <> 0 then
        begin
          c := Byte(Source[i]);
          Inc(i);
          if (c and $C0) <> $80 then Exit;      // malformed trail byte or out of range char
          if i >= SourceBytes then Exit;        // incomplete multibyte char
          wc := (wc shl 6) or (c and $3F);
        end;
        c := Byte(Source[i]);
        Inc(i);
        if (c and $C0) <> $80 then Exit;       // malformed trail byte

        Dest[count] := WideChar((wc shl 6) or (c and $3F));
      end
      else
        Dest[count] := WideChar(wc);
      Inc(count);
    end;
    if count >= MaxDestChars then count := MaxDestChars-1;
    Dest[count] := #0;
  end
  else
  begin
    while (i < SourceBytes) do
    begin
      c := Byte(Source[i]);
      Inc(i);
      if (c and $80) <> 0 then
      begin
        if i >= SourceBytes then Exit;          // incomplete multibyte char
        c := c and $3F;
        if (c and $20) <> 0 then
        begin
          c := Byte(Source[i]);
          Inc(i);
          if (c and $C0) <> $80 then Exit;      // malformed trail byte or out of range char
          if i >= SourceBytes then Exit;        // incomplete multibyte char
        end;
        c := Byte(Source[i]);
        Inc(i);
        if (c and $C0) <> $80 then Exit;       // malformed trail byte
      end;
      Inc(count);
    end;
  end;
  Result := count+1;
end;

function Utf8Encode(const WS: WideString): UTF8String;
var
  L: Integer;
  Temp: UTF8String;
begin
  Result := '';
  if WS = '' then Exit;
  SetLength(Temp, Length(WS) * 3); // SetLength includes space for null terminator

  L := UnicodeToUtf8(PAnsiChar(Temp), Length(Temp)+1, PWideChar(WS), Length(WS));
  if L > 0 then
    SetLength(Temp, L-1)
  else
    Temp := '';
  Result := Temp;
end;

function Utf8Decode(const S: UTF8String): WideString;
var
  L: Integer;
  Temp: WideString;
begin
  Result := '';
  if S = '' then Exit;
  SetLength(Temp, Length(S));

  L := Utf8ToUnicode(PWideChar(Temp), Length(Temp)+1, PAnsiChar(S), Length(S));
  if L > 0 then
    SetLength(Temp, L-1)
  else
    Temp := '';
  Result := Temp;
end;

function AnsiToUtf8(const S: string): UTF8String;
begin
  Result := Utf8Encode(S);
end;

function Utf8ToAnsi(const S: UTF8String): string;
begin
  Result := Utf8Decode(S);
end;

function DumbItDownFor95(const S1, S2: WideString; CmpFlags: Integer): Integer;
var
  a1, a2: AnsiString;
begin
  a1 := s1;
  a2 := s2;
  Result := CompareStringA(LOCALE_USER_DEFAULT, CmpFlags, PAnsiChar(a1),
    Length(a1), PAnsiChar(a2), Length(a2)) - 2;
end;

function WideCompareStr(const S1, S2: WideString): Integer;
begin
  SetLastError(0);
  Result := CompareStringW(LOCALE_USER_DEFAULT, 0, PWideChar(S1), Length(S1),
    PWideChar(S2), Length(S2)) - 2;
  case GetLastError of
    0: ;
    ERROR_CALL_NOT_IMPLEMENTED: Result := DumbItDownFor95(S1, S2, 0);
  else
    RaiseLastWin32Error;
  end;
end;

function WideCompareText_(const S1, S2: WideString): Integer;
begin
  SetLastError(0);
  Result := CompareStringW(LOCALE_USER_DEFAULT, NORM_IGNORECASE, PWideChar(S1),
    Length(S1), PWideChar(S2), Length(S2)) - 2;
  case GetLastError of
    0: ;
    ERROR_CALL_NOT_IMPLEMENTED: Result := DumbItDownFor95(S1, S2, NORM_IGNORECASE);
  else
    RaiseLastWin32Error;
  end;
end;
{$ENDIF}

//----------------------------------------------------------------------------------------------------------------------

initialization
  if (Win32Platform and VER_PLATFORM_WIN32_NT) <> 0 then @WideCompareText := @CompareTextWinNT
                                                    else @WideCompareText := @CompareTextWin95;
{$IFNDEF Win64}
  Win32PlatformIsUnicode := (Win32Platform = VER_PLATFORM_WIN32_NT);
  {$IFNDEF UNICODE}
  DefaultSystemCodePage := GetACP;
  {$ENDIF}
{$ENDIF}
finalization
  LoadInProgress.Free;
end.
