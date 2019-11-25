{
  TetzkatLipHoka 2015-2019

  uTLH: StringList
  Last updated: 05/26/2019
}

{
CompareStrings                      - Compare two StringLists - True if content is equal
LowerCase                           - Convert to LowerCase
UpperCase                           - Convert to UpperCase
Remove                              - Remove all appearances of 'Text' in 'string', result is new string
Replace                             - Replace all appearances of 'Text' in 'string' with 'rText', result is new string
FusionStringList                    - Combine two Strings
FilterDublicateEntries              - Remove dublicate lines from TStrings
FilterEmptyEntries                  - Remove empty lines from TStrings
AppendRowsWithOpenBrackets          - Appends follow lines to previous as long as brackets ( ( , [ , { ) are opened
PrefixLineMatchingToNextLines       - Appends follow lines to a line matching 'text'
AppendLineMatchingToPreviousLines   - Appends a line matching 'text' to a number of previous lines
PrefixLineMatching                  - Prefix all lines matching 'mText' with 'Text'
PrefixLineNotMatching               - Prefix all lines not matching 'mText' with 'Text'
AppendToLineMatching                - Append 'Text' to all lines matching 'mText'
AppendToLineNotMatching             - Append 'Text' to all lines not matching 'mText'
ClearLineMatching                   - Clear all lines matching 'mText' with 'Text'
ClearLineNotMatching                - Clear all lines not matching 'mText' with 'Text'
AddLineNumbers                      - Append line numers to line start
PrefixLines                         - Append text to string-start
AppendToLines                       - Append text to string-end
ConvertSpacesToTabs                 - Convert TABs to given value of spaces
ConvertTabsToSpaces                 - Convert given value of spaces to TABs
RemoveTabsAndSpaces                 - Strip Tabs and ( dublicate ) spaces
TrimLineAfter                       - Remove any chars after amount of chars from start
TrimLineFromLeft                    - Remove amount of chars from start of the string( s )
TrimLineFromRight                   - Remove amount of chars from end of the string( s )
RemoveSpacesFromLineStart           - Remove any blanks/spaces from line start( s )
RemoveSpacesFromLineEnd             - Remove any blanks/spaces from line end( s )
BreakLine                           - Break lines/start new line before/after amount of chars
BreakLine                           - Break lines/start new line before/after happening of 'string'
RemoveLinesContaining               - Remove lines containing given string
RemoveLinesNOTContaining            - Remove lines not containing given string
RemoveLinesStartingWith             - Remove lines starting with 'text'
RemoveLinesEndingWith               - Remove lines ending with 'text'
ExtractFileName                     - Extracts Filename from String

FunctionsToInitVar                  - Convert function-declarations to InitVar-calls
FunctionsToRd_Functions             - Convert function-declarations to Redirect-Declaration + Redirect-Functions

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~TStringList Sorting~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
SortNaturalAscending                - Natural/Human sorting
SortNaturalDescending               - Natural/Human sorting
SortRegularAscending                - Delphi/Machinal sorting
SortRegularDescending               - Delphi/Machinal sorting
}

{$WARN GARBAGE OFF}

{$IFNDEF TLH_OMIT_SECTIONS}
unit uTLH.StringList;

{$I uTLH.inc}

interface

uses
  Classes
//  {$IFNDEF UNICDOE},WSDLIntf{$ENDIF}
  ;
{$ENDIF TLH_OMIT_SECTIONS}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
{$IF NOT Defined(TLH_IMPLEMENTATIONSECTION) AND NOT Defined(TLH_INITIALIZATIONSECTION) AND NOT Defined(TLH_FINALIZATIONSECTION)}
function CompareStrings( StrL, StrL2: TStrings; caseSensitive : boolean = false ):boolean; // True if similiar
function LowerCase( StrL : TStrings ): TStrings;
procedure LowerCase_( StrL : TStrings );
function UpperCase( StrL : TStrings ): TStrings; 
procedure UpperCase_( StrL : TStrings );
function Remove( StrL : TStrings; Text : String; WildCard : Boolean = false; CaseSensitive : Boolean = false ): TStrings; 
procedure Remove_( StrL : TStrings; Text : String; WildCard : Boolean = false; CaseSensitive : Boolean = false );
function Replace( StrL : TStrings; mText, RText : String; WildCard : Boolean = false; CaseSensitive : Boolean = false ): TStrings; 
procedure Replace_( StrL : TStrings; mText, RText : String; WildCard : Boolean = false; CaseSensitive : Boolean = false );
function FusionStrings( StrL1, StrL2 : TStrings; Prefix{orAppend} : Boolean = false ) : TStrings; 
procedure FusionStrings_( StrL1, StrL2 : TStrings; Prefix{orAppend} : Boolean = false ); 
function FilterDublicateEntries( StrL : TStrings; caseSensitive : boolean = False ) : TStrings; 
procedure FilterDublicateEntries_( StrL : TStrings; caseSensitive : boolean = False );
function FilterEmptyEntries( StrL : TStrings ) : TStrings; 
procedure FilterEmptyEntries_( StrL : TStrings );
procedure AppendRowsWithOpenBrackets( StrL : TStrings ); 
function PrefixLineMatchingToNextLines( StrL : TStrings; Text : String; FollowLines : integer; caseSensitive : boolean = false; WildCard : boolean = false ): TStrings; 
procedure PrefixLineMatchingToNextLines_( StrL : TStrings; Text : String; FollowLines : integer; caseSensitive : boolean = false; WildCard : boolean = false );
function AppendLineMatchingToPreviousLines( StrL : TStrings; Text : String; Lines : integer; caseSensitive : boolean = false; WildCard : boolean = false ): TStrings; 
procedure AppendLineMatchingToPreviousLines_( StrL : TStrings; Text : String; Lines : integer; caseSensitive : boolean = false; WildCard : boolean = false );
function PrefixLineMatching( StrL : TStrings; mText, text : string; WildCard : boolean = false; caseSensitive : boolean = false ): TStrings;
procedure PrefixLineMatching_( StrL : TStrings; mText, text : string; WildCard : boolean = false; caseSensitive : boolean = false );
function PrefixLineNotMatching( StrL : TStrings; mText, text : string; WildCard : boolean = false; caseSensitive : boolean = false ): TStrings;
procedure PrefixLineNotMatching_( StrL : TStrings; mText, text : string; WildCard : boolean = false; caseSensitive : boolean = false );
function ClearLineMatching( StrL : TStrings; mText : string; WildCard : boolean = false; caseSensitive : boolean = false ): TStrings;
procedure ClearLineMatching_( StrL : TStrings; mText : string; WildCard : boolean = false; caseSensitive : boolean = false );
function ClearLineNotMatching( StrL : TStrings; mText : string; WildCard : boolean = false; caseSensitive : boolean = false ): TStrings;
procedure ClearLineNotMatching_( StrL : TStrings; mText : string; WildCard : boolean = false; caseSensitive : boolean = false );
function AppendToLineMatching( StrL : TStrings; mText, text : string; WildCard : boolean = false; caseSensitive : boolean = false ): TStrings;
procedure AppendToLineMatching_( StrL : TStrings; mText, text : string; WildCard : boolean = false; caseSensitive : boolean = false );
function AppendToLineNotMatching( StrL : TStrings; mText, text : string; WildCard : boolean = false; caseSensitive : boolean = false ): TStrings; 
procedure AppendToLineNotMatching_( StrL : TStrings; mText, text : string; WildCard : boolean = false; caseSensitive : boolean = false );
function AddLineNumbers( StrL : TStrings ): TStrings; overload;
procedure AddLineNumbers_( StrL : TStrings ); overload;
function AddLineNumbers( StrL : TStrings; StartValue : Integer; Decreasing : boolean = false ): TStrings; overload;
procedure AddLineNumbers_( StrL : TStrings; StartValue : Integer; Decreasing : boolean = false ); overload;
function PrefixLines( StrL : TStrings; Text : string ): TStrings; 
procedure PrefixLines_( StrL : TStrings; Text : string );
function AppendToLines( StrL : TStrings; Text : string ): TStrings; 
procedure AppendToLines_( StrL : TStrings; Text : string );
function ConvertSpacesToTabs( StrL : TStrings; value : Byte ): TStrings; 
procedure ConvertSpacesToTabs_( StrL : TStrings; value : Byte );
function ConvertTabsToSpaces( StrL : TStrings; value : Byte ): TStrings; 
procedure ConvertTabsToSpaces_( StrL : TStrings; value : Byte );
function RemoveTabsAndSpaces( StrL : TStrings ): TStrings; 
procedure RemoveTabsAndSpaces_( StrL : TStrings );
function TrimLineAfter( StrL : TStrings; Value : Byte ): TStrings; 
procedure TrimLineAfter_( StrL : TStrings; Value : Byte );
function TrimLineFromLeft( StrL : TStrings; Value : Byte ): TStrings; 
procedure TrimLineFromLeft_( StrL : TStrings; Value : Byte );
function TrimLineFromRight( StrL : TStrings; Value : Byte ): TStrings; 
procedure TrimLineFromRight_( StrL : TStrings; Value : Byte );
function BreakLine( StrL : TStrings; Value : integer; EndLess : boolean = false ): TStrings; overload;
procedure BreakLine_( StrL : TStrings; Value : integer; EndLess : boolean = false ); overload;
function BreakLine( StrL : TStrings; text : string; CaseSensitive : boolean = false; Before : boolean = false; EndLess : boolean = false ): TStrings; overload;
procedure BreakLine_( StrL : TStrings; text : string; CaseSensitive : boolean = false; Before : boolean = false; EndLess : boolean = false ); overload;
function RemoveSpacesFromLineStart( StrL : TStrings ): TStrings;
procedure RemoveSpacesFromLineStart_( StrL : TStrings );
function RemoveSpacesFromLineEnd( StrL : TStrings ): TStrings;
procedure RemoveSpacesFromLineEnd_( StrL : TStrings );
function RemoveLinesContaining( StrL : TStrings; Text : string; WildCard : boolean = False; caseSensitive : boolean = false ): TStrings;
procedure RemoveLinesContaining_( StrL : TStrings; Text : string; WildCard : boolean = False; caseSensitive : boolean = false );
function RemoveLinesNOTContaining( StrL : TStrings; Text : string; WildCard : boolean = False; caseSensitive : boolean = false ): TStrings;
procedure RemoveLinesNOTContaining_( StrL : TStrings; Text : string; WildCard : boolean = False; caseSensitive : boolean = false );
function RemoveLinesStartingWith( StrL : TStrings; Text : string; caseSensitive : boolean = false ): TStrings;
procedure RemoveLinesStartingWith_( StrL : TStrings; Text : string; caseSensitive : boolean = false );
function RemoveLinesEndingWith( StrL : TStrings; Text : string; caseSensitive : boolean = false ): TStrings;
procedure RemoveLinesEndingWith_( StrL : TStrings; Text : string; caseSensitive : boolean = false );
function ExtractFileName( StrL : TStrings ): TStrings;
procedure ExtractFileName_( StrL : TStrings );

procedure FunctionsToInitVar( StrL : TStrings );
procedure FunctionsToRd_Functions( StrL : TStrings );

function ReplaceStringsAreal( Text : TStrings; start, endN : integer; rText : string ): TStrings; overload;
procedure ReplaceStringsAreal_( Text : TStrings; start, endN : integer; rText : string ); overload;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~TStringList Sorting~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function SortNaturalAscending( StrL : TStrings; caseSensitive : boolean = false ): TStrings; overload;
function SortNaturalDescending( StrL : TStrings; caseSensitive : boolean = false ): TStrings; overload;
function SortRegularAscending( StrL : TStrings ): TStrings; overload;
function SortRegularDescending( StrL : TStrings ): TStrings; overload;
function SortNaturalAscending( StrL : TStringList; caseSensitive : boolean = false ): TStringList; overload;
function SortNaturalDescending( StrL : TStringList; caseSensitive : boolean = false ): TStringList; overload;
function SortRegularAscending( StrL : TStringList ): TStringList; overload;
function SortRegularDescending( StrL : TStringList ): TStringList; overload;

procedure SortNaturalAscending_( StrL : TStrings; caseSensitive : boolean = false ); overload;
procedure SortNaturalDescending_( StrL : TStrings; caseSensitive : boolean = false ); overload;
procedure SortRegularAscending_( StrL : TStrings ); overload;
procedure SortRegularDescending_( StrL : TStrings ); overload;
procedure SortNaturalAscending_( StrL : TStringList; caseSensitive : boolean = false ); overload;
procedure SortNaturalDescending_( StrL : TStringList; caseSensitive : boolean = false ); overload;
procedure SortRegularAscending_( StrL : TStringList ); overload;
procedure SortRegularDescending_( StrL : TStringList ); overload;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Tokenize
function AddTok( const S: TStrings; T: String; const B: Byte; caseSensitive : boolean = False; AllowDuplicates : boolean = false ): TStrings; overload;
function AddTok( const S: TStrings; T: String; const C: Char; caseSensitive : boolean = False; AllowDuplicates : boolean = false ): TStrings; overload;
function DelTok( const S: TStrings; const N1, N2: Integer; const B: Byte ): TStrings; overload;
function DelTok( const S: TStrings; const N1, N2: Integer; const C: Char ): TStrings; overload;
function DelTok( const S: TStrings; const N: Integer; const B: Byte ): TStrings; overload;
function DelTok( const S: TStrings; const N: Integer; const C: Char ): TStrings; overload;
function GetTok( const S: TStrings; const N1, N2: Integer; const B: Byte; IgnoreEmpty : boolean = true ): TStrings; overload;
function GetTok( const S: TStrings; const N1, N2: Integer; const C: Char; IgnoreEmpty : boolean = true ): TStrings; overload;
function GetTok( const S: TStrings; const N: Integer; const B: Byte; IgnoreEmpty : boolean = true ): TStrings; overload;
function GetTok( const S: TStrings; const N: Integer; const C: Char; IgnoreEmpty : boolean = true ): TStrings; overload;
function InsTok( const S : TStrings; T : string; N: Integer; const B: Byte ): TStrings; overload;
function InsTok( const S : TStrings; T : string; N: Integer; const C: Char ): TStrings; overload;
function PutTok( const S : TStrings; T : string; N: Integer; const B: Byte ): TStrings; overload;
function PutTok( const S : TStrings; T : string; N: Integer; const C: Char ): TStrings; overload;
function ExTok( const S : TStrings; T1, T2: Integer; const B: Byte ): TStrings; overload;
function ExTok( const S : TStrings; T1, T2: Integer; const C: Char ): TStrings; overload;
function MoveTok( const S : TStrings; T1, T2: Integer; const B: Byte ): TStrings; overload;
function MoveTok( const S : TStrings; T1, T2: Integer; const C: Char ): TStrings; overload;
function CloneTok( const S : TStrings; T1, T2: Integer; const B: Byte ): TStrings; overload;
function CloneTok( const S : TStrings; T1, T2: Integer; const C: Char ): TStrings; overload;

procedure AddTok_( S: TStrings; T: String; const B: Byte; caseSensitive : boolean = False; AllowDuplicates : boolean = false ); overload;
procedure AddTok_( S: TStrings; T: String; const C: Char; caseSensitive : boolean = False; AllowDuplicates : boolean = false ); overload;
procedure DelTok_( S: TStrings; const N1, N2: Integer; const B: Byte ); overload;
procedure DelTok_( S: TStrings; const N1, N2: Integer; const C: Char ); overload;
procedure DelTok_( S: TStrings; const N: Integer; const B: Byte ); overload;
procedure DelTok_( S: TStrings; const N: Integer; const C: Char ); overload;
procedure GetTok_( S: TStrings; const N1, N2: Integer; const B: Byte; IgnoreEmpty : boolean = true ); overload;
procedure GetTok_( S: TStrings; const N1, N2: Integer; const C: Char; IgnoreEmpty : boolean = true ); overload;
procedure GetTok_( S: TStrings; const N: Integer; const B: Byte; IgnoreEmpty : boolean = true ); overload;
procedure GetTok_( S: TStrings; const N: Integer; const C: Char; IgnoreEmpty : boolean = true ); overload;
procedure InsTok_( S : TStrings; T : string; N: Integer; const B: Byte ); overload;
procedure InsTok_( S : TStrings; T : string; N: Integer; const C: Char ); overload;
procedure PutTok_( S : TStrings; T : string; N: Integer; const B: Byte ); overload;
procedure PutTok_( S : TStrings; T : string; N: Integer; const C: Char ); overload;
procedure ExTok_( S : TStrings; T1, T2: Integer; const B: Byte ); overload;
procedure ExTok_( S : TStrings; T1, T2: Integer; const C: Char ); overload;
procedure MoveTok_( S : TStrings; T1, T2: Integer; const B: Byte ); overload;
procedure MoveTok_( S : TStrings; T1, T2: Integer; const C: Char ); overload;
procedure CloneTok_( S : TStrings; T1, T2: Integer; const B: Byte ); overload;
procedure CloneTok_( S : TStrings; T1, T2: Integer; const C: Char ); overload;

{$IFEND TLH_IMPLEMENTATIONSECTION}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
{$IFNDEF TLH_OMIT_SECTIONS}
implementation

uses
  Math, StrUtils, SysUtils,
  uTLH.Strings;
{$ENDIF TLH_OMIT_SECTIONS}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
{$IF NOT Defined(TLH_INTERFACESECTION) AND NOT Defined(TLH_INITIALIZATIONSECTION) AND NOT Defined(TLH_FINALIZATIONSECTION)}
function CompareStrings( StrL, StrL2: TStrings; caseSensitive : boolean = false ):boolean; // True if similiar
var
  i : Integer;
begin
  result := False;
  if ( StrL.Count = StrL2.Count ) AND ( StrL.Count < 1 ) then
    begin
    result := true;
    Exit;
    end
  else if ( StrL.Count <> StrL2.Count ) OR ( StrL.Count < 1 ) then
    Exit;

  result := true;
  for i := 0 to StrL.Count-1 do
    begin
    if ( caseSensitive ) then
      begin
      if ( StrL[ i ] <> StrL2[ i ] ) then
        begin
        result := false;
        Break;
        end;
      end
    else
      begin
      if ( SysUtils.LowerCase( StrL[ i ] ) <> SysUtils.LowerCase( StrL2[ i ] ) ) then
        begin
        result := false;
        Break;
        end;
      end;
    end;
end;

function LowerCase( StrL : TStrings ): TStrings;
begin
  result := TStringList.Create;
  if ( StrL.Count = 0 ) then
    Exit;
  result.Assign( StrL );
  LowerCase_( result );
end;

procedure LowerCase_( StrL : TStrings );
var
  i : integer;
begin
  if ( StrL.Count = 0 ) then
    Exit;
	for i := 0 to StrL.Count-1 do
    StrL[ i ] := SysUtils.LowerCase( StrL[ i ] );
end;

function UpperCase( StrL : TStrings ): TStrings;
begin
  result := TStringList.Create;
  if ( StrL.Count = 0 ) then
    Exit;
  result.Assign( StrL );
  UpperCase_( result );
end;

procedure UpperCase_( StrL : TStrings );
var
  i : integer;
begin
  if ( StrL.Count = 0 ) then
    Exit;
	for i := 0 to StrL.Count-1 do
    StrL[ i ] := SysUtils.UpperCase( StrL[ i ] );
end;

function Remove( StrL : TStrings; Text : String; WildCard : Boolean = false; CaseSensitive : Boolean = false ): TStrings;
begin
  result := TStringList.Create;
  if ( StrL.Count = 0 ) or ( Text = '' ) then
    Exit;
  result.Assign( StrL );
  Remove_( result, Text, Wildcard, CaseSensitive );
end;

procedure Remove_( StrL : TStrings; Text : String; WildCard : Boolean = false; CaseSensitive : Boolean = false );
var
  i : integer;
begin
  if ( StrL.Count = 0 ) or ( Text = '' ) then
    Exit;

  for i := 0 to StrL.Count-1 do
    StrL[ i ] := uTLH.Strings.Remove( StrL[ i ], Text, WildCard, CaseSensitive );
end;

function Replace( StrL : TStrings; mText, RText : String; WildCard : Boolean = false; CaseSensitive : Boolean = false ): TStrings;
begin
  result := TStringList.Create;
  if ( StrL.Count = 0 ) or ( mText = '' ) then
    Exit;
  result.Assign( StrL );
  Replace_( result, mText, RText, Wildcard, CaseSensitive );
end;

procedure Replace_( StrL : TStrings; mText, RText : String; WildCard : Boolean = false; CaseSensitive : Boolean = false );
var
  i : integer;
begin
  if ( StrL.Count = 0 ) or ( mText = '' ) then
    Exit;

  for i := 0 to StrL.Count-1 do
    StrL[ i ] := uTLH.Strings.Replace( StrL[ i ], mText, RText, WildCard, CaseSensitive );
end;

function FusionStrings( StrL1, StrL2 : TStrings; Prefix{orAppend} : Boolean = false ) : TStrings;
begin
  result := TStringList.Create;
  result.Assign( StrL1 );
  FusionStrings_( result, StrL2, Prefix );
end;

procedure FusionStrings_( StrL1, StrL2 : TStrings; Prefix{orAppend} : Boolean = false );
var
  i : Integer;
  tmp : TStrings;
begin
  if ( StrL1.Count = 0 ) and ( StrL2.Count > 0 ) then
    begin
    StrL1.Assign( StrL2 );
    Exit;
    end
  else if ( StrL1.Count > 0 ) and ( StrL2.Count = 0 ) then
    begin
//    Result.Assign( StrL1 );
    Exit;
    end
  else if ( StrL1.Count = 0 ) and ( StrL2.Count = 0 ) then
    Exit;

  tmp := TStringList.Create;
  for i := 0 to Max( StrL1.Count, StrL2.Count )-1 do
    begin
    if ( i > Min( StrL1.Count, StrL2.Count )-1 ) then
      begin
      if ( i > StrL1.Count-1 ) then
        tmp.Add( StrL2[ i ] )
      else if ( i > StrL2.Count-1 ) then
        tmp.Add( StrL1[ i ] );
      end
    else
      begin
      if Prefix then
        begin
        if ( RightStr( StrL1[ i ], 1 ) <> ' ' ) AND ( LeftStr( StrL2[ i ], 1 ) <> ' ' ) then
          tmp.Add( StrL1[ i ] + ' ' + StrL2[ i ] )
        else
          tmp.Add( StrL1[ i ] + StrL2[ i ] );
        end
      else
        begin
        if ( RightStr( StrL2[ i ], 1 ) <> ' ' ) AND ( LeftStr( StrL1[ i ], 1 ) <> ' ' ) then
          tmp.Add( StrL2[ i ] + ' ' + StrL1[ i ] )
        else
          tmp.Add( StrL2[ i ] + StrL1[ i ] );
        end
      end;
    end;
  StrL1.Assign( tmp );
  tmp.free;
end;

function FilterDublicateEntries( StrL : TStrings; caseSensitive : boolean = False ) : TStrings;
begin
  result := TStringList.Create;
  result.Assign( StrL );
  FilterDublicateEntries_( result, caseSensitive );
end;

procedure FilterDublicateEntries_( StrL : TStrings; caseSensitive : boolean = False );
var
 a, b: integer;
begin
  for a := StrL.count-1 downTo 0 do
    begin
    if ( StrL[ a ] = '' ) then
      continue;

    for b := a-1 downTo 0 do
      begin
      if ( a > StrL.count-1 ) OR ( b > StrL.count-1 ) then
        continue;

      if ( caseSensitive ) then
        begin
        if StrL[ a ] = StrL[ b ] then
          StrL.Delete( b )
        end
      else if ( SysUtils.LowerCase( StrL[ a ] ) = SysUtils.LowerCase( StrL[ b ] ) ) then  
        StrL.Delete( b )
      end;
    end;
end;

function FilterEmptyEntries( StrL : TStrings ) : TStrings;
begin
  result := TStringList.Create;
  result.Assign( StrL );
  FilterEmptyEntries_( result );
end;

procedure FilterEmptyEntries_( StrL : TStrings );
var
 i : integer;
begin
  for i := StrL.count-1 downTo 0 do
    if ( StrL[ i ] = '' ) OR ( StrL[ i ] = DupeString( ' ', Length( StrL[ i ] ) ) ) then
      StrL.Delete( i )
end;

procedure AppendRowsWithOpenBrackets( StrL : TStrings );
var
  N, E, G, i : integer;
  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  procedure CountBrackets( text : string );
  var
    i : integer;
  begin
  for i := {$IF CompilerVersion >= 24}Low(text){$ELSE}1{$IFEND} to {$IF CompilerVersion >= 24}High(text){$ELSE}Length(text){$IFEND} do
    begin
    if ( text[ i ] = '(' ) then
      inc( N );
    if ( text[ i ] = '[ ' ) then
      inc( E );
    if ( text[ i ] = '{' ) then
      inc( G );

    if ( text[ i ] = ')' ) then
      dec( N );
    if ( text[ i ] = ' ]' ) then
      dec( E );
    if ( text[ i ] = '}' ) then
      dec( G );

    N := Max( 0, N );
    E := Max( 0, E );
    G := Max( 0, G );
    end;
  end;
  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  N := 0;
  E := 0;
  G := 0;

  if ( StrL.Text = '' ) or ( StrL.Count < 2 ) then
    Exit;

  for i := 0 to StrL.Count-1 do
    begin
    if ( i+1 > StrL.Count-1 ) then
      break;

    CountBrackets( StrL[ i ] );
    while ( ( N > 0 ) or ( E > 0 ) or ( G > 0 ) ) AND ( i+1 < StrL.Count-1 ) do
      begin
      if ( RightStr( StrL[ i ], 1 ) <> ' ' ) then
        StrL[ i ] := StrL[ i ] + ' ' + StrL[ i+1 ]
      else
        StrL[ i ] := StrL[ i ] + StrL[ i+1 ];

      CountBrackets( StrL[ i+1 ] );
      StrL.Delete( i+1 );
      end;
    end;
end;

function PrefixLineMatchingToNextLines( StrL : TStrings; Text : String; FollowLines : integer; caseSensitive : boolean = false; WildCard : boolean = false ): TStrings;
begin
  result := TStringList.Create;
  if ( StrL.Count = 0 ) then
    Exit;

  result.Assign( StrL );
  PrefixLineMatchingToNextLines_( result, Text, FollowLines, caseSensitive, WildCard );
end;

procedure PrefixLineMatchingToNextLines_( StrL : TStrings; Text : String; FollowLines : integer; caseSensitive : boolean = false; WildCard : boolean = false );
var
  i, j : integer;
begin
  if ( StrL.Count = 0 ) then
    Exit;

  if ( Text = '' ) or ( FollowLines < 1 ) then
    Exit;

  for i := 0 to StrL.Count-1 do
    begin
    if ( i+1 > StrL.Count-1 ) then
      break;

    if ( WildCard AND ( IsWm( StrL[ i ], Text, caseSensitive ) ) ) OR ( NOT WildCard AND uTLH.Strings.CompareStrings( StrL[ i ], Text, caseSensitive ) ) then
      begin
      for j := 1 to FollowLines do
        begin
        if ( i+1 > StrL.Count-1 ) then
          break;
        if ( RightStr( StrL[ i ], 1 ) <> ' ' ) AND ( LeftStr( StrL[ i+1 ], 1 ) <> ' ' ) then
          StrL[ i ] := StrL[ i ] + ' ' + StrL[ i+1 ]
        else
          StrL[ i ] := StrL[ i ] + StrL[ i+1 ];

        StrL.Delete( i+1 );
        end;
      end;
    end;
end;

function AppendLineMatchingToPreviousLines( StrL : TStrings; Text : String; Lines : integer; caseSensitive : boolean = false; WildCard : boolean = false ): TStrings;
begin
  result := TStringList.Create;
  if ( StrL.Count = 0 ) then
    Exit;

  result.Assign( StrL );
  AppendLineMatchingToPreviousLines_( result, Text, Lines, caseSensitive, WildCard );
end;

procedure AppendLineMatchingToPreviousLines_( StrL : TStrings; Text : String; Lines : integer; caseSensitive : boolean = false; WildCard : boolean = false );
var
  i, j  : integer;
  tStrL : TStrings;
  str   : string;
begin
  if ( StrL.Count = 0 ) then
    Exit;

  if ( Text = '' ) or ( Lines < 1 ) then
    Exit;

  tStrL := TStringList.Create;
  for i := StrL.Count-1 downTo 0 do
    begin
    if ( WildCard AND ( IsWm( StrL[ i ], Text, caseSensitive ) ) ) OR ( NOT WildCard AND uTLH.Strings.CompareStrings( StrL[ i ], Text, caseSensitive ) ) then
      begin
      str := StrL[ i ];
      for j := 1 to Lines do
        begin
        if ( i-j < 0 ) then
          break;
        if ( LeftStr( StrL[ i ], 1 ) <> ' ' ) AND ( RightStr( StrL[ i-j ], 1 ) <> ' ' ) then
          str := StrL[ i-j ] + ' ' + str
        else
          str := StrL[ i-j ] + str;
        end;

      tStrL.Insert( 0, str )
      end
    else
      tStrL.Insert( 0, StrL[ i ] );
    end;
  StrL.Assign( tStrL );
  tStrL.free;
end;

function PrefixLineMatching( StrL : TStrings; mText, Text : string; WildCard : boolean = False; caseSensitive : boolean = false ): TStrings;
begin
  result := TStringList.Create;
  if ( StrL.Count = 0 ) OR ( mText = '' ) OR ( Text = '' ) then
    Exit;

  result.Assign( StrL );
  PrefixLineMatching_( result, mText, text, WildCard, caseSensitive );
end;

procedure PrefixLineMatching_( StrL : TStrings; mText, Text : string; WildCard : boolean = False; caseSensitive : boolean = false );
var
  i : integer;
begin
  if ( StrL.Count = 0 ) OR ( mText = '' ) OR ( Text = '' ) then
    Exit;

  for i := 0 to StrL.Count-1 do
    begin
    if ( ( WildCard ) AND ( IsWm( StrL[ i ], mText, caseSensitive ) ) ) OR ( ( NOT WildCard ) AND ( uTLH.Strings.CompareStrings( StrL[ i ], mText, caseSensitive ) ) ) then
      StrL[ i ] := Text + StrL[ i ];
    end;
end;

function PrefixLineNotMatching( StrL : TStrings; mText, Text : string; WildCard : boolean = False; caseSensitive : boolean = false ): TStrings;
begin
  result := TStringList.Create;
  if ( StrL.Count = 0 ) OR ( mText = '' ) OR ( Text = '' ) then
    Exit;
  result.Assign( StrL );
  PrefixLineNotMatching_( result, mText, text, WildCard, caseSensitive );
end;

procedure PrefixLineNotMatching_( StrL : TStrings; mText, Text : string; WildCard : boolean = False; caseSensitive : boolean = false );
var
  i : integer;
begin
  if ( StrL.Count = 0 ) OR ( mText = '' ) OR ( Text = '' ) then
    Exit;

  for i := 0 to StrL.Count-1 do
    begin
    if ( ( WildCard ) AND ( NOT IsWm( StrL[ i ], mText, caseSensitive ) ) ) OR ( ( NOT WildCard ) AND ( NOT uTLH.Strings.CompareStrings( StrL[ i ], mText, caseSensitive ) ) ) then
      StrL[ i ] := Text + StrL[ i ];
    end;
end;

function ClearLineMatching( StrL : TStrings; mText : string; WildCard : boolean = False; caseSensitive : boolean = false ): TStrings;
begin
  result := TStringList.Create;
  if ( StrL.Count = 0 ) OR ( mText = '' ) then
    Exit;

  result.Assign( StrL );
  ClearLineMatching_( result, mText, WildCard, caseSensitive );
end;

procedure ClearLineMatching_( StrL : TStrings; mText : string; WildCard : boolean = False; caseSensitive : boolean = false );
var
  i : integer;
begin
  if ( StrL.Count = 0 ) OR ( mText = '' ) then
    Exit;

  for i := 0 to StrL.Count-1 do
    begin
    if ( ( WildCard ) AND ( IsWm( StrL[ i ], mText, caseSensitive ) ) ) OR ( ( NOT WildCard ) AND ( uTLH.Strings.CompareStrings( StrL[ i ], mText, caseSensitive ) ) ) then
      StrL[ i ] := '';
    end;
end;

function ClearLineNotMatching( StrL : TStrings; mText : string; WildCard : boolean = False; caseSensitive : boolean = false ): TStrings;
begin
  result := TStringList.Create;
  if ( StrL.Count = 0 ) OR ( mText = '' ) then
    Exit;

  result.Assign( StrL );
  ClearLineNotMatching_( result, mText, WildCard, caseSensitive );
end;

procedure ClearLineNotMatching_( StrL : TStrings; mText : string; WildCard : boolean = False; caseSensitive : boolean = false );
var
  i : integer;
begin
  if ( StrL.Count = 0 ) OR ( mText = '' ) then
    Exit;

  for i := 0 to StrL.Count-1 do
    begin
    if ( ( WildCard ) AND ( NOT IsWm( StrL[ i ], mText, caseSensitive ) ) ) OR ( ( NOT WildCard ) AND ( NOT uTLH.Strings.CompareStrings( StrL[ i ], mText, caseSensitive ) ) ) then
      StrL[ i ] := '';
    end;
end;

function AppendToLineMatching( StrL : TStrings; mText, Text : string; WildCard : boolean = False; caseSensitive : boolean = false ): TStrings;
begin
  result := TStringList.Create;
  if ( StrL.Count = 0 ) OR ( mText = '' ) OR ( Text = '' ) then
    Exit;

  result.Assign( StrL );
  AppendToLineMatching_( result, mText, text, WildCard, caseSensitive );
end;

procedure AppendToLineMatching_( StrL : TStrings; mText, Text : string; WildCard : boolean = False; caseSensitive : boolean = false );
var
  i : integer;
begin
  if ( StrL.Count = 0 ) OR ( mText = '' ) OR ( Text = '' ) then
    Exit;

  for i := 0 to StrL.Count-1 do
    begin
    if ( ( WildCard ) AND ( IsWm( StrL[ i ], mText, caseSensitive ) ) ) OR ( ( NOT WildCard ) AND ( uTLH.Strings.CompareStrings( StrL[ i ], mText, caseSensitive ) ) ) then
      StrL[ i ] := StrL[ i ] + Text;
    end;
end;

function AppendToLineNotMatching( StrL : TStrings; mText, Text : string; WildCard : boolean = False; caseSensitive : boolean = false ): TStrings;
begin
  result := TStringList.Create;
  if ( StrL.Count = 0 ) OR ( mText = '' ) OR ( Text = '' ) then
    Exit;

  result.Assign( StrL );
  AppendToLineNotMatching_( result, mText, text, WildCard, caseSensitive );
end;

procedure AppendToLineNotMatching_( StrL : TStrings; mText, Text : string; WildCard : boolean = False; caseSensitive : boolean = false );
var
  i : integer;
begin
  if ( StrL.Count = 0 ) OR ( mText = '' ) OR ( Text = '' ) then
    Exit;

  for i := 0 to StrL.Count-1 do
    begin
    if ( ( WildCard ) AND ( NOT IsWm( StrL[ i ], Text, caseSensitive ) ) ) OR ( ( NOT WildCard ) AND ( NOT uTLH.Strings.CompareStrings( StrL[ i ], mText, caseSensitive ) ) ) then
      StrL[ i ] := StrL[ i ] + Text;
    end;
end;

function AddLineNumbers( StrL : TStrings ): TStrings;
begin
  result := TStringList.Create;
  if ( StrL.Count = 0 ) then
    Exit;
  result.Assign( StrL );
  AddLineNumbers_( result );
end;

procedure AddLineNumbers_( StrL : TStrings );
begin
  if ( StrL.Count = 0 ) then
    Exit;
  AddLineNumbers_( StrL, 1 );
end;

function AddLineNumbers( StrL : TStrings; StartValue : integer; Decreasing : boolean = false ): TStrings;
begin
  result := TStringList.Create;
  if ( StrL.Count = 0 ) then
    Exit;
  result.Assign( StrL );
  AddLineNumbers_( result, StartValue, Decreasing );
end;

procedure AddLineNumbers_( StrL : TStrings; StartValue : integer; Decreasing : boolean = false );
var
  i : integer;
begin
  if ( StrL.Count = 0 ) then
    Exit;

	for i := 0 to StrL.Count-1 do
    begin
    if ( Decreasing ) then
      StrL[ i ] := IntToStr( StartValue - i ) + StrL[ i ]
    else
      StrL[ i ] := IntToStr( StartValue + i ) + StrL[ i ];
    end;
end;

function PrefixLines( StrL : TStrings; Text : string ): TStrings;

begin
  result := TStringList.Create;
  if ( StrL.Count = 0 ) or ( Text = '' ) then
    Exit;
  result.Assign( StrL );
  PrefixLines_( result, Text );
end;

procedure PrefixLines_( StrL : TStrings; Text : string );
var
  i : integer;
begin
  if ( StrL.Count = 0 ) or ( Text = '' ) then
    Exit;

	for i := 0 to StrL.Count-1 do
    StrL[ i ] := Text + StrL[ i ];
end;

function AppendToLines( StrL : TStrings; Text : string ): TStrings;
begin
  result := TStringList.Create;
  if ( StrL.Count = 0 ) or ( Text = '' ) then
    Exit;
  result.Assign( StrL );
  AppendToLines_( result, Text );
end;

procedure AppendToLines_( StrL : TStrings; Text : string );
var
  i : integer;
begin
  if ( StrL.Count = 0 ) or ( Text = '' ) then
    Exit;

	for i := 0 to StrL.Count-1 do
    StrL[ i ] := StrL[ i ] + Text;
end;

function ConvertSpacesToTabs( StrL : TStrings; value : Byte ): TStrings;
begin
  result := TStringList.Create;
  if ( StrL.Count = 0 ) then
    Exit;
  result.Assign( StrL );
  ConvertSpacesToTabs_( result, value );
end;

procedure ConvertSpacesToTabs_( StrL : TStrings; value : Byte );
var
  i : integer;
begin
  if ( StrL.Count = 0 ) then
    Exit;

	for i := 0 to StrL.Count-1 do
    StrL[ i ] := uTLH.Strings.ConvertSpacesToTabs( StrL[ i ], value );
end;

function ConvertTabsToSpaces( StrL : TStrings; value : Byte ): TStrings;
begin
  result := TStringList.Create;
  if ( StrL.Count = 0 ) then
    Exit;
  result.Assign( StrL );
  ConvertTabsToSpaces_( result, value );
end;

procedure ConvertTabsToSpaces_( StrL : TStrings; value : Byte );
var
  i : integer;
begin
  if ( StrL.Count = 0 ) then
    Exit;
	for i := 0 to StrL.Count-1 do
    StrL[ i ] := uTLH.Strings.ConvertTabsToSpaces( StrL[ i ], value );
end;

function RemoveTabsAndSpaces( StrL : TStrings ): TStrings;
begin
  result := TStringList.Create;
  if ( StrL.Count = 0 ) then
    Exit;
  result.Assign( StrL );
  RemoveTabsAndSpaces_( result );
end;

procedure RemoveTabsAndSpaces_( StrL : TStrings );
var
  i : integer;
begin
  if ( StrL.Count = 0 ) then
    Exit;

	for i := 0 to StrL.Count-1 do
    StrL[ i ] := uTLH.Strings.RemoveTabsAndSpaces( StrL[ i ] );
end;

function TrimLineAfter( StrL : TStrings; Value : Byte ): TStrings;
begin
  result := TStringList.Create;
  if ( StrL.Count = 0 ) then
    Exit;

  result.Assign( StrL );
  TrimLineAfter_( result, Value );
end;

procedure TrimLineAfter_( StrL : TStrings; Value : Byte );
var
  i : integer;
begin
  if ( StrL.Count = 0 ) then
    Exit;

  for i := 0 to StrL.Count-1 do
    StrL[ i ] := uTLH.Strings.TrimLineAfter( StrL[ i ], Value );
end;

function TrimLineFromLeft( StrL : TStrings; Value : Byte ): TStrings;
begin
  result := TStringList.Create;
  if ( StrL.Count = 0 ) then
    Exit;

  result.Assign( StrL );
  TrimLineFromLeft_( result, Value );
end;

procedure TrimLineFromLeft_( StrL : TStrings; Value : Byte );
var
  i : integer;
begin
  if ( StrL.Count = 0 ) then
    Exit;

  for i := 0 to StrL.Count-1 do
    StrL[ i ] := uTLH.Strings.TrimLineFromLeft( StrL[ i ], Value );
end;

function TrimLineFromRight( StrL : TStrings; Value : Byte ): TStrings;
begin
  result := TStringList.Create;
  if ( StrL.Count = 0 ) then
    Exit;

  result.Assign( StrL );
  TrimLineFromRight_( result, Value );
end;

procedure TrimLineFromRight_( StrL : TStrings; Value : Byte );
var
  i : integer;
begin
  if ( StrL.Count = 0 ) then
    Exit;

  for i := 0 to StrL.Count-1 do
    StrL[ i ] := uTLH.Strings.TrimLineFromRight( StrL[ i ], Value );
end;

function BreakLine( StrL : TStrings; Value : integer; EndLess : boolean = false ): TStrings;
begin
  result := TStringList.Create;
  if ( StrL.Count = 0 ) then
    Exit;

  result.Assign( StrL );
  BreakLine_( result, Value, EndLess );
end;

procedure BreakLine_( StrL : TStrings; Value : integer; EndLess : boolean = false );
var
  i : integer;
  s : string;
  tmp : TStrings;
begin
  if ( StrL.Count = 0 ) then
    Exit;

  if ( Value = 0 ) or ( StrL.Text = '' ) then
    Exit;

  tmp := TStringList.Create;
  for i := 0 to StrL.Count-1 do
    begin
    if ( Length( StrL[ i ] ) > Value ) then
      begin
      s := StrL[ i ];

      if ( EndLess ) then
        begin
        while ( Length( s ) > Value ) do
          begin
          tmp.Add( LeftStr( s, Value ) );
          s := uTLH.Strings.TrimLineFromLeft( s, Value );
          end;
        end
      else
        begin
        tmp.Add( LeftStr( s, Value ) );
        tmp.Add( uTLH.Strings.TrimLineFromLeft( s, Value ) );
        end;
      end
    else
      tmp.Add( StrL[ i ] );
    end;
  StrL.Assign( tmp );
  tmp.free;
end;

function BreakLine( StrL : TStrings; text : string; CaseSensitive : boolean = false; Before : boolean = false; EndLess : boolean = false ): TStrings;
begin
  result := TStringList.Create;
  if ( StrL.Count = 0 ) then
    Exit;

  result.Assign( StrL );
  BreakLine_( result, text, CaseSensitive, Before, EndLess );
end;

procedure BreakLine_( StrL : TStrings; text : string; CaseSensitive : boolean = false; Before : boolean = false; EndLess : boolean = false );
var
  i, p : integer;
  s : string;
  tmp : TStrings;
begin
  if ( StrL.Count = 0 ) then
    Exit;

  if ( text = '' ) or ( StrL.Text = '' ) then
    Exit;

  tmp := TStringList.Create;
  for i := StrL.Count-1 downTo 0 do
    begin
    if ( caseSensitive AND ( Pos( text, StrL[ i ] ) <> 0 ) ) or ( ( NOT CaseSensitive ) AND ( Pos( SysUtils.LowerCase( text ), SysUtils.LowerCase( StrL[ i ] ) ) <> 0 ) ) then
      begin
      s := StrL[ i ];

      if ( EndLess ) then
        begin
        while ( caseSensitive AND ( Pos( text, s ) <> 0 ) ) or ( ( NOT CaseSensitive ) AND ( Pos( SysUtils.LowerCase( text ), SysUtils.LowerCase( s ) ) <> 0 ) ) do
          begin
          if CaseSensitive then
            if before then
              p := Pos( text, s )-1
            else
              p := Pos( text, s )-1+Length( Text )
          else
            if before then
              p := Pos( SysUtils.LowerCase( text ), SysUtils.LowerCase( s ) )-1
            else
              p := Pos( SysUtils.LowerCase( text ), SysUtils.LowerCase( s ) )-1+Length( Text );
          tmp.Add( LeftStr( s, p ) );
          s := uTLH.Strings.TrimLineFromLeft( s, p );
          end;
        end
      else
        begin
        if CaseSensitive then
          if before then
            p := Pos( text, s )-1
          else
            p := Pos( text, s )-1+Length( Text )
        else
          if before then
            p := Pos( SysUtils.LowerCase( text ), SysUtils.LowerCase( s ) )-1
          else
            p := Pos( SysUtils.LowerCase( text ), SysUtils.LowerCase( s ) )-1+Length( Text );

        tmp.Add( LeftStr( s, p ) );
        tmp.Add( uTLH.Strings.TrimLineFromLeft( s, p ) );
        end;
      end
    else
      tmp.Add( StrL[ i ] );
    end;
  StrL.Assign( tmp );
  tmp.free;
end;

function RemoveSpacesFromLineStart( StrL : TStrings ): TStrings;
begin
  result := TStringList.Create;
  if ( StrL.Count = 0 ) then
    Exit;

  result.Assign( StrL );
  RemoveSpacesFromLineStart_( result );
end;

procedure RemoveSpacesFromLineStart_( StrL : TStrings );
var
  i : integer;
begin
  if ( StrL.Count = 0 ) then
    Exit;

  for i := 0 to StrL.Count-1 do
    StrL[ i ] := uTLH.Strings.RemoveSpacesFromLineStart( StrL[ i ] );
end;

function RemoveSpacesFromLineEnd( StrL : TStrings ): TStrings;
begin
  result := TStringList.Create;
  if ( StrL.Count = 0 ) then
    Exit;

  result.Assign( StrL );
  RemoveSpacesFromLineEnd_( result );
end;

procedure RemoveSpacesFromLineEnd_( StrL : TStrings );
var
  i : integer;
begin
  if ( StrL.Count = 0 ) then
    Exit;

  for i := 0 to StrL.Count-1 do
    StrL[ i ] := uTLH.Strings.RemoveSpacesFromLineEnd( StrL[ i ] );
end;

function RemoveLinesContaining( StrL : TStrings; Text : string; WildCard : boolean = False; caseSensitive : boolean = false ): TStrings;
begin
  result := TStringList.Create;
  if ( StrL.Count = 0 ) then
    Exit;

  result.Assign( StrL );
  RemoveLinesContaining_( result, Text, WildCard, caseSensitive );
end;

procedure RemoveLinesContaining_( StrL : TStrings; Text : string; WildCard : boolean = False; caseSensitive : boolean = false );
var
  i : integer;
begin
  if ( StrL.Count = 0 ) then
    Exit;

  for i := StrL.Count-1 downTo 0 do
    begin
    if ( ( WildCard ) AND ( IsWm( StrL[ i ], Text, caseSensitive ) ) ) OR ( ( NOT WildCard ) AND ( Isin( StrL[ i ], Text, caseSensitive ) ) ) then
      StrL.Delete( i );
    end;
end;

function RemoveLinesNOTContaining( StrL : TStrings; Text : string; WildCard : boolean = False; caseSensitive : boolean = false ): TStrings;
begin
  result := TStringList.Create;
  if ( StrL.Count = 0 ) then
    Exit;

  result.Assign( StrL );
  RemoveLinesNOTContaining_( result, Text, WildCard, caseSensitive );
end;

procedure RemoveLinesNOTContaining_( StrL : TStrings; Text : string; WildCard : boolean = False; caseSensitive : boolean = false );
var
  i : integer;
begin
  if ( StrL.Count = 0 ) then
    Exit;

  for i := StrL.Count-1 downTo 0 do
    begin
    if ( ( WildCard ) AND ( NOT IsWm( StrL[ i ], Text, caseSensitive ) ) ) OR ( ( NOT WildCard ) AND ( NOT Isin( StrL[ i ], Text, caseSensitive ) ) ) then
      StrL.Delete( i );
    end;
end;

function RemoveLinesStartingWith( StrL : TStrings; Text : string; caseSensitive : boolean = false ): TStrings;
begin
  result := TStringList.Create;
  if ( StrL.Count = 0 ) then
    Exit;

  result.Assign( StrL );
  RemoveLinesStartingWith_( result, Text, caseSensitive );
end;

procedure RemoveLinesStartingWith_( StrL : TStrings; Text : string; caseSensitive : boolean = false );
var
  i : integer;
begin
  if ( StrL.Count = 0 ) then
    Exit;

  if ( Text = '' ) then
    Exit;

  for i := StrL.Count-1 downTo 0 do
    begin
    if caseSensitive then
      begin
      if ( copy( StrL[ i ], 0, Length( Text ) ) = Text ) then
        StrL.Delete( i )
      end
    else
      begin
      if ( SysUtils.LowerCase( copy( StrL[ i ], 0, Length( Text ) ) ) = SysUtils.LowerCase( Text ) ) then
        StrL.Delete( i );
      end;
    end;
end;

function RemoveLinesEndingWith( StrL : TStrings; Text : string; caseSensitive : boolean = false ): TStrings;
begin
  result := TStringList.Create;
  if ( StrL.Count = 0 ) then
    Exit;

  result.Assign( StrL );
  RemoveLinesEndingWith_( result, Text, caseSensitive );
end;

procedure RemoveLinesEndingWith_( StrL : TStrings; Text : string; caseSensitive : boolean = false );
var
  i : integer;
begin
  if ( StrL.Count = 0 ) then
    Exit;

  if ( Text = '' ) then
    Exit;

  for i := StrL.Count-1 downTo 0 do
    begin
    if caseSensitive then
      begin
      if ( copy( StrL[ i ], Length( StrL[ i ] )-( Length( Text )-1 ), Length( Text ) ) = Text ) then
        StrL.Delete( i );
      end
    else
      begin
      if ( SysUtils.LowerCase( copy( StrL[ i ], Length( StrL[ i ] )-( Length( Text )-1 ), Length( Text ) ) ) = SysUtils.LowerCase( Text ) ) then
        StrL.Delete( i );
      end;
    end;
end;

function ExtractFileName( StrL : TStrings ): TStrings;
begin
  result := TStringList.Create;
  result.Assign( StrL );
  ExtractFileName_( result );
end;

procedure ExtractFileName_( StrL : TStrings );
var
  i : integer;
begin
  for i := 0 to StrL.Count-1 do
    StrL[ i ] := SysUtils.ExtractFileName( StrL[ i ] );
end;

procedure FunctionsToInitVar( StrL : TStrings );
var
  i : integer;
  s : string;
begin
  if NOT Assigned( StrL ) then
    Exit;

  for i := 0 to StrL.Count-1 do
    begin
    s := Trim( StrL[ i ] );
    if ( s = '' ) OR ( IsWm( s, '//*' ) ) then
      continue;
    if ( NOT IsWm( s, '*stdcall;*' ) ) AND ( NOT IsWm( s, '*cdecl;*' ) ) then
      continue;

    if ( IsWm( s, '* : function*' ) OR IsWm( s, '* : procedure*' ) ) then
      s := DelTok( s, 2, 99, 32 )
    else if ( IsWm( s, 'function *' ) OR IsWm( s, 'procedure *' ) ) then
      s := GetTok( GetTok( s, 2, 32 ), 1, '(' )
    else
      continue;

    StrL[ i ] := Format( '  InitVar( @%s, ''%s'', ID, StrL );', [ s, s ] );
    end;
end;

procedure FunctionsToRd_Functions( StrL : TStrings );
var
  i, j : integer;
  s : string;
  StrL_Declaration : TStrings;
  StrL_Implementation : TStrings;

  vDec : string;
  rDec : string;
  params : string;
  sResult : string;
begin
  if NOT Assigned( StrL ) then
    Exit;

  StrL_Declaration := TStringList.Create;
  StrL_Implementation := TStringList.Create;

  for i := 0 to StrL.Count-1 do
    begin
    s := Trim( StrL[ i ] );
    if ( s = '' ) OR ( IsWm( s, '//*' ) ) then
      continue;
    if ( NOT IsWm( s, '*stdcall;*' ) ) AND ( NOT IsWm( s, '*cdecl;*' ) ) then
      continue;
    if ( IsWm( s, 'rd_* : *(*' ) ) then
      continue;

    // Style
    s := uTLH.Strings.Replace( s, '(', '( ' );
    s := uTLH.Strings.Replace( s, ')', ' )' );
    s := uTLH.Strings.Replace( s, ';', '; ' );
    s := uTLH.Strings.Replace( s, ':', ' : ' );
    s := uTLH.Strings.RemoveTabsAndSpaces( s );

    // SysUtils.LowerCase
    s := uTLH.Strings.Replace( s, 'function', 'function' );
    s := uTLH.Strings.Replace( s, 'procedure', 'procedure' );
    s := uTLH.Strings.Replace( s, 'stdcall', 'stdcall' );
    s := uTLH.Strings.Replace( s, 'cdecl', 'cdecl' );
    s := uTLH.Strings.Replace( s, 'var ', 'var ' );

    s := uTLH.Strings.Replace( s, 'Byte', 'Byte' );
    s := uTLH.Strings.Replace( s, 'integer', 'Integer' );
    s := uTLH.Strings.Replace( s, 'Word', 'Word' );
    s := uTLH.Strings.Replace( s, 'DWord', 'DWord' );
    s := uTLH.Strings.Replace( s, 'Cardinal', 'Cardinal' );
    s := uTLH.Strings.Replace( s, 'Double', 'Double' );
    s := uTLH.Strings.Replace( s, 'Single', 'Single' );
    s := uTLH.Strings.Replace( s, 'Int64', 'Int64' );

    // Strip
    if ( MatchTok( s, 'external ', 0, ';', false ) > 0 ) then
      s := uTLH.Strings.Remove( s, MatchTok( s, 'external ', 1, ';', false ) + ';' );
    s := RemTok( s, ' far', 0, ';' );
    if ( RightStr( Trim( s ), 1 ) <> ';' ) then
      s := Trim( s ) + ';';

    if ( IsWm( s, '* : function*' ) OR IsWm( s, '* : procedure*' ) ) then
      begin
      vDec := '  rd_' + s;
      rDec := GetTok( s, 3, 99, 32 );
      rDec := uTLH.Strings.Replace( rDec, 'procedure;', 'procedure' );
      rDec := uTLH.Strings.Replace( rDec, 'procedure(', 'procedure (' );
      rDec := uTLH.Strings.Replace( rDec, 'function(', 'function (' );
      rDec := InsTok( rDec, GetTok( s, 1, 32 ), 2, 32 );

      rDec := uTLH.Strings.Remove( rDec, 'stdcall;' );
      rDec := uTLH.Strings.Remove( rDec, 'cdecl;' );
      end
    else if ( IsWm( s, 'function*' ) OR IsWm( s, 'procedure*' ) ) then
      begin
      rDec := GetTok( s, 1, NumTok( s, ';' )-1, ';' );
      vDec := GetTok( s, 1, '(' );

      if ( IsWm( s, 'function*(*' ) OR IsWm( s, 'procedure*(*' ) ) then
        vDec := Format( '  rd_%s : %s (%s', [ GetTok( vDec, 2, 32 ), GetTok( vDec, 1, 32 ), GetTok( s, 2, 99, '(' ) ] )
      else
        begin
        sResult := '';
        if IsWm( s, 'function*' ) then
          sResult := Trim( GetTok( s, 2, ':' ) )
        else
          sResult := Trim( GetTok( s, 2, ';' ) );

        vDec := uTLH.Strings.Remove( vDec, ';' );
        if IsWm( s, 'function*' ) then
          vDec := Format( '  rd_%s : %s : %s', [ GetTok( vDec, 2, 32 ), GetTok( vDec, 1, 32 ), sResult ] )
        else
          vDec := Format( '  rd_%s : %s; %s;', [ GetTok( vDec, 2, 32 ), GetTok( vDec, 1, 32 ), sResult ] );
        end;
      end
    else
      continue;

    StrL[ i ] := TrimRight( vDec );
    if ( RightStr( Trim( rDec ), 1 ) <> ';' ) then
      rDec := Trim( rDec ) + ';';
    StrL_Declaration.Add( rDec );

    params := '';
    s := GetTok( GetTok( s, 2, '(' ), 1, ')' );
    for j := 1 to NumTok( s, ';' ) do
      params := AddTok( params, Trim( GetTok( GetTok( s, j, ';' ), 1, ':' ) ), ',' );
    params := uTLH.Strings.Replace( params, ',', ', ' );
    params := uTLH.Strings.Remove( params, 'var ' );

    StrL_Implementation.Add( rDec );
    StrL_Implementation.Add( 'begin' );
    if IsWm( rDec, '*function*' ) then
      begin
      if IsWm( rDec, '*function*(*' ) then
        sResult := Trim( GetTok( GetTok( GetTok( rDec, 2, ')' ), 2, ':' ), 1, ';' ) )
      else
        sResult := Trim( GetTok( GetTok( rDec, 2, ':' ), 1, ';' ) );

      if ( SysUtils.LowerCase( 'String' ) = SysUtils.LowerCase( sResult ) ) OR ( SysUtils.LowerCase( 'ShortString' ) = SysUtils.LowerCase( sResult ) ) then
        StrL_Implementation.Add( '  result := '''';' )
      else if ( SysUtils.LowerCase( 'Boolean' ) = SysUtils.LowerCase( sResult ) ) OR ( SysUtils.LowerCase( 'Bool' ) = SysUtils.LowerCase( sResult ) ) OR ( SysUtils.LowerCase( 'LongBool' ) = SysUtils.LowerCase( sResult ) ) then
        StrL_Implementation.Add( '  result := false;' )
      else if ( SysUtils.LowerCase( 'Byte' ) = SysUtils.LowerCase( sResult ) ) then
        StrL_Implementation.Add( '  result := High( Byte );' )
      else if ( SysUtils.LowerCase( 'Pointer' ) = SysUtils.LowerCase( sResult ) ) then
        StrL_Implementation.Add( '  result := nil;' )

      else if ( SysUtils.LowerCase( 'ShortInt' ) = SysUtils.LowerCase( sResult ) ) then
        StrL_Implementation.Add( '  result := Low( ShortInt );' )
      else if ( SysUtils.LowerCase( 'SmallInt' ) = SysUtils.LowerCase( sResult ) ) then
        StrL_Implementation.Add( '  result := Low( SmallInt );' )
      else if ( SysUtils.LowerCase( 'Integer' ) = SysUtils.LowerCase( sResult ) ) OR ( SysUtils.LowerCase( 'LongInt' ) = SysUtils.LowerCase( sResult ) ) then
        StrL_Implementation.Add( '  result := -666;' )

      else if ( SysUtils.LowerCase( 'Word' ) = SysUtils.LowerCase( sResult ) ) then
        StrL_Implementation.Add( '  result := High( Word );' )
      else if ( SysUtils.LowerCase( 'Cardinal' ) = SysUtils.LowerCase( sResult ) ) OR ( SysUtils.LowerCase( 'DWord' ) = SysUtils.LowerCase( sResult ) ) then
        StrL_Implementation.Add( '  result := High( Cardinal );' )
      else if ( SysUtils.LowerCase( 'Int64' ) = SysUtils.LowerCase( sResult ) ) then
        StrL_Implementation.Add( '  result := High( Int64 );' )
      else if ( SysUtils.LowerCase( 'Single' ) = SysUtils.LowerCase( sResult ) ) then
        StrL_Implementation.Add( '  result := Low( Single );' )
      else if ( SysUtils.LowerCase( 'Double' ) = SysUtils.LowerCase( sResult ) ) then
        StrL_Implementation.Add( '  result := Low( Double );'  )
      else
        StrL_Implementation.Add( '  result := UNKNOWN_RESULT_TYPE;'  );
      end;
    StrL_Implementation.Add( Format( '  if NOT Assigned( %s ) then', [ GetTok( vDec, 1, 32 ) ] ) );
    StrL_Implementation.Add( '    Exit;' ) ;

    StrL_Implementation.Add( Format( IfThen( params = '', '  %s%s;','  %s%s( %s );' ), [ IfThen( IsWm( rDec, '*function*' ), 'result := ', '' ), GetTok( vDec, 1, 32 ), params ] ) );

    StrL_Implementation.Add( 'end;' );
    StrL_Implementation.Add( '' );
    end;

  StrL.Add( '' );
  StrL.Add( '// Declaration' );
  StrL.AddStrings( StrL_Declaration );

  StrL.Add( '' );
  StrL.Add( '// Implementation' );
  StrL.AddStrings( StrL_Implementation );

  StrL_Declaration.free;
  StrL_Implementation.free;
end;

function ReplaceStringsAreal( Text : TStrings; start, endN : integer; rText : String ): TStrings;
begin
  result := TStringList.Create;
  if NOT Assigned( Text ) then
    Exit;
  result.Text := Text.Text;

  if ( Text.Text = '' ) or ( start > endN ) or ( endN > Length( Text.Text ) ) then
    Exit;

  ReplaceStringsAreal_( result, start, endN, rText );
end;

procedure ReplaceStringsAreal_( Text : TStrings; start, endN : integer; rText : String );
begin
  if NOT Assigned( Text ) then
    Exit;
  if ( Text.Text = '' ) or ( start > endN ) or ( endN > Length( Text.Text ) ) then
    Exit;

  if ( Length( rText ) > 2 ) AND ( copy( rText, Length( rText )-1, 2 ) = #13#10 ) AND ( copy( Text.Text, endN-1, 2 ) <> #13#10 ) then
    rText := copy( rText, 0, Length( rText )-2 );

  Text.Text := copy( Text.Text, 0, Max( start-1,0 ) ) + rText + copy( Text.Text, endN+1, length( Text.Text )-endN );
end;


// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// StringList.CustomSort Call-functions
procedure SortNaturalAscending_( StrL : TStrings; caseSensitive : boolean = false );
var
  StrLT : TStringList;
begin
  if ( StrL = nil ) then
    Exit;

  StrLT := TStringList.Create;
  StrLT.Assign( StrL );
  if ( caseSensitive ) then
    StrLT.CustomSort( NaturalSortAscCS )
  else
    StrLT.CustomSort( NaturalSortAsc );
  StrL.Assign( StrLT );
  StrLT.Free;
end;

procedure SortNaturalDescending_( StrL : TStrings; caseSensitive : boolean = false );
var
  StrLT : TStringList;
begin
  if ( StrL = nil ) then
    Exit;

  StrLT := TStringList.Create;
  StrLT.Assign( StrL );
  if ( caseSensitive ) then
    StrLT.CustomSort( NaturalSortDescCS )
  else
    StrLT.CustomSort( NaturalSortDesc );
  StrL.Assign( StrLT );
  StrLT.Free;
end;

procedure SortRegularAscending_( StrL : TStrings );
var
  StrLT : TStringList;
begin
  if ( StrL = nil ) then
    Exit;

  StrLT := TStringList.Create;
  StrLT.Assign( StrL );
  StrLT.Sorted := True;
  StrL.Assign( StrLT );
  StrLT.Free;
end;

procedure SortRegularDescending_( StrL : TStrings );
var
  StrLT : TStringList;
  i     : Integer;  
begin
  if ( StrL = nil ) then
    Exit;

  StrLT := TStringList.Create;
  StrLT.Assign( StrL );
  StrLT.Sorted := True;
  StrL.Clear;
  for i := StrLT.Count-1 downto 0 do
    StrL.Add( StrLT[ i ] );
  StrLT.Free;
end;

procedure SortNaturalAscending_( StrL : TStringList; caseSensitive : boolean = false );
begin
  if ( caseSensitive ) then
    StrL.CustomSort( NaturalSortAscCS )
  else
    StrL.CustomSort( NaturalSortAsc );
end;

procedure SortNaturalDescending_( StrL : TStringList; caseSensitive : boolean = false );
begin
  if ( caseSensitive ) then
    StrL.CustomSort( NaturalSortDescCS )
  else
    StrL.CustomSort( NaturalSortDesc );
end;

procedure SortRegularAscending_( StrL : TStringList );
begin
  StrL.Sorted := True;
end;

procedure SortRegularDescending_( StrL : TStringList );
var
 List  : TStringList;
 i     : Integer;
begin
  StrL.Sorted := True;
  List := TStringList.Create;
  for i := StrL.Count-1 downto 0 do
    List.Add( StrL.Strings[ i ] );
  StrL.Assign( List );
  List.free;
end;

function SortNaturalAscending( StrL : TStrings; caseSensitive : boolean = false ): TStrings;
begin
  result := TStringList.Create;
  result.Assign( StrL );
  SortNaturalAscending_( result );
end;

function SortNaturalDescending( StrL : TStrings; caseSensitive : boolean = false ): TStrings;
begin
  result := TStringList.Create;
  result.Assign( StrL );
  SortNaturalDescending_( result );
end;

function SortRegularAscending( StrL : TStrings ): TStrings;
begin
  result := TStringList.Create;
  result.Assign( StrL );
  SortRegularAscending_( result );
end;

function SortRegularDescending( StrL : TStrings ): TStrings;
begin
  result := TStringList.Create;
  result.Assign( StrL );
  SortRegularDescending_( result );
end;

function SortNaturalAscending( StrL : TStringList; caseSensitive : boolean = false ): TStringList;
begin
  result := TStringList.Create;
  result.Assign( StrL );
  SortNaturalAscending_( result );
end;

function SortNaturalDescending( StrL : TStringList; caseSensitive : boolean = false ): TStringList;
begin
  result := TStringList.Create;
  result.Assign( StrL );
  SortNaturalDescending_( result );
end;

function SortRegularAscending( StrL : TStringList ): TStringList;
begin
  result := TStringList.Create;
  result.Assign( StrL );
  SortRegularAscending_( result );
end;

function SortRegularDescending( StrL : TStringList ): TStringList;
begin
  result := TStringList.Create;
  result.Assign( StrL );
  SortRegularDescending_( result );
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Tokenize
procedure AddTok_( S : TStrings; T: String; const B: Byte; caseSensitive : boolean = False; AllowDuplicates : boolean = false );
begin
  AddTok_( S, T, Chr( B ), caseSensitive, AllowDuplicates );
end;

procedure AddTok_( S : TStrings; T: String; const C: Char; caseSensitive : boolean = False; AllowDuplicates : boolean = false );
var
  i : integer;
begin
  if ( S.Count = 0 ) then
    Exit;

  for i := 0 to S.Count-1 do
    S[ i ] := AddTok( S[ i ], T, C, caseSensitive, AllowDuplicates );
end;

procedure DelTok_( S : TStrings; const N1, N2: Integer; const B: Byte );
begin
  DelTok_( S, N1, N2, Chr( B ) );
end;

procedure DelTok_( S : TStrings; const N1, N2: Integer; const C: Char );
var
  i : integer;
begin
  if ( S.Count = 0 ) then
    Exit;

  for i := S.Count-1 downTo 0 do
    S[ i ] := DelTok( S[ i ], N1, N2, C );
end;

procedure DelTok_( S : TStrings; const N: Integer; const B: Byte );
begin
  DelTok_( S, N, Chr( B ) );
end;

procedure DelTok_( S : TStrings; const N: Integer; const C: Char );
var
  i : integer;
begin
  if ( S.Count = 0 ) then
    Exit;

  for i := S.Count-1 downTo 0 do
    S[ i ] := DelTok( S[ i ], N, C );
end;

procedure GetTok_( S : TStrings; const N1, N2: Integer; const B: Byte; IgnoreEmpty : boolean = true );
begin
  GetTok_( S, N1, N2, Chr( B ), IgnoreEmpty );
end;

procedure GetTok_( S : TStrings; const N1, N2: Integer; const C: Char; IgnoreEmpty : boolean = true );
var
  i : integer;
begin
  if ( S.Count = 0 ) then
    Exit;

  for i := S.Count-1 downTo 0 do
    S[ i ] := GetTok( S[ i ], N1, N2, C, IgnoreEmpty );
end;

procedure GetTok_( S : TStrings; const N: Integer; const B: Byte; IgnoreEmpty : boolean = true );
begin
  GetTok_( S, N, Chr( B ), IgnoreEmpty );
end;

procedure GetTok_( S : TStrings; const N: Integer; const C: Char; IgnoreEmpty : boolean = true );
var
  i : integer;
begin
  if ( S.Count = 0 ) then
    Exit;

  for i := S.Count-1 downTo 0 do
    S[ i ] := GetTok( S[ i ], N, C, IgnoreEmpty );
end;

procedure InsTok_( S : TStrings; T : string; N: Integer; const B: Byte );
begin
  InsTok_( S, T, N, Chr( B ) );
end;

procedure InsTok_( S : TStrings; T : string; N: Integer; const C: Char );
var
  i : integer;
begin
  if ( S.Count = 0 ) then
    Exit;

  for i := 0 to S.Count-1 do
    S[ i ] := InsTok( S[ i ], T, N, C );
end;

procedure PutTok_( S : TStrings; T : string; N: Integer; const B: Byte );
begin
  PutTok_( S, T, N, Chr( B ) );
end;

procedure PutTok_( S : TStrings; T : string; N: Integer; const C: Char );
var
  i : integer;
begin
  if ( S.Count = 0 ) then
    Exit;

  for i := 0 to S.Count-1 do
    S[ i ] := PutTok( S[ i ], T, N, C );
end;

procedure ExTok_( S : TStrings; T1, T2: Integer; const B: Byte );
begin
  ExTok_( S, T1, T2, Chr( B ) );
end;

procedure ExTok_( S : TStrings; T1, T2: Integer; const C: Char );
var
  i : integer;
begin
  if ( S.Count = 0 ) then
    Exit;

  for i := 0 to S.Count-1 do
    S[ i ] := ExTok( S[ i ], T1, T2, C );
end;

procedure MoveTok_( S : TStrings; T1, T2: Integer; const B: Byte );
begin
  MoveTok_( S, T1, T2, Chr( B ) );
end;

procedure MoveTok_( S : TStrings; T1, T2: Integer; const C: Char );
var
  i : integer;
begin
  if ( S.Count = 0 ) then
    Exit;

  for i := 0 to S.Count-1 do
    S[ i ] := MoveTok( S[ i ], T1, T2, C );
end;

procedure CloneTok_( S : TStrings; T1, T2: Integer; const B: Byte );
begin
  CloneTok_( S, T1, T2, Chr( B ) );
end;

procedure CloneTok_( S : TStrings; T1, T2: Integer; const C: Char );
var
  i : integer;
begin
  if ( S.Count = 0 ) then
    Exit;

  for i := 0 to S.Count-1 do
    S[ i ] := CloneTok( S[ i ], T1, T2, C );
end;

function AddTok( const S: TStrings; T: String; const B: Byte; caseSensitive : boolean = False; AllowDuplicates : boolean = false ): TStrings;
begin
  result := TStringList.Create;
  result.Assign( S );
  AddTok_( result, T, B, caseSensitive, AllowDuplicates );
end;

function AddTok( const S: TStrings; T: String; const C: Char; caseSensitive : boolean = False; AllowDuplicates : boolean = false ): TStrings;
begin
  result := TStringList.Create;
  result.Assign( S );
  AddTok_( result, T, C, caseSensitive, AllowDuplicates );
end;

function DelTok( const S: TStrings; const N1, N2: Integer; const B: Byte ): TStrings;
begin
  result := TStringList.Create;
  result.Assign( S );
  DelTok_( result, N1, N2, B );
end;

function DelTok( const S: TStrings; const N1, N2: Integer; const C: Char ): TStrings;
begin
  result := TStringList.Create;
  result.Assign( S );
  DelTok_( result, N1, N2, C );
end;

function DelTok( const S: TStrings; const N: Integer; const B: Byte ): TStrings;
begin
  result := TStringList.Create;
  result.Assign( S );
  DelTok_( result, N, B );
end;

function DelTok( const S: TStrings; const N: Integer; const C: Char ): TStrings;
begin
  result := TStringList.Create;
  result.Assign( S );
  DelTok_( result, N, C );
end;

function GetTok( const S: TStrings; const N1, N2: Integer; const B: Byte; IgnoreEmpty : boolean = true ): TStrings;
begin
  result := TStringList.Create;
  result.Assign( S );
  GetTok_( result, N1, N2, B, IgnoreEmpty );
end;

function GetTok( const S: TStrings; const N1, N2: Integer; const C: Char; IgnoreEmpty : boolean = true ): TStrings;
begin
  result := TStringList.Create;
  result.Assign( S );
  GetTok_( result, N1, N2, C, IgnoreEmpty );
end;

function GetTok( const S: TStrings; const N: Integer; const B: Byte; IgnoreEmpty : boolean = true ): TStrings;
begin
  result := TStringList.Create;
  result.Assign( S );
  GetTok_( result, N, B, IgnoreEmpty );
end;

function GetTok( const S: TStrings; const N: Integer; const C: Char; IgnoreEmpty : boolean = true ): TStrings;
begin
  result := TStringList.Create;
  result.Assign( S );
  GetTok_( result, N, C, IgnoreEmpty );
end;

function InsTok( const S : TStrings; T : string; N: Integer; const B: Byte ): TStrings;
begin
  result := TStringList.Create;
  result.Assign( S );
  InsTok_( result, T, N, B );
end;

function InsTok( const S : TStrings; T : string; N: Integer; const C: Char ): TStrings;
begin
  result := TStringList.Create;
  result.Assign( S );
  InsTok_( result, T, N, C );
end;

function PutTok( const S : TStrings; T : string; N: Integer; const B: Byte ): TStrings;
begin
  result := TStringList.Create;
  result.Assign( S );
  PutTok_( result, T, N, B );
end;

function PutTok( const S : TStrings; T : string; N: Integer; const C: Char ): TStrings;
begin
  result := TStringList.Create;
  result.Assign( S );
  PutTok_( result, T, N, C );
end;

function ExTok( const S : TStrings; T1, T2: Integer; const B: Byte ): TStrings;
begin
  result := TStringList.Create;
  result.Assign( S );
  ExTok_( result, T1, T2, B );
end;

function ExTok( const S : TStrings; T1, T2: Integer; const C: Char ): TStrings;
begin
  result := TStringList.Create;
  result.Assign( S );
  ExTok_( result, T1, T2, C );
end;

function MoveTok( const S : TStrings; T1, T2: Integer; const B: Byte ): TStrings;
begin
  result := TStringList.Create;
  result.Assign( S );
  MoveTok_( result, T1, T2, B );
end;

function MoveTok( const S : TStrings; T1, T2: Integer; const C: Char ): TStrings;
begin
  result := TStringList.Create;
  result.Assign( S );
  MoveTok_( result, T1, T2, C );
end;

function CloneTok( const S : TStrings; T1, T2: Integer; const B: Byte ): TStrings;
begin
  result := TStringList.Create;
  result.Assign( S );
  CloneTok_( result, T1, T2, B );
end;

function CloneTok( const S : TStrings; T1, T2: Integer; const C: Char ): TStrings;
begin
  result := TStringList.Create;
  result.Assign( S );
  CloneTok_( result, T1, T2, C );
end;

{$IFEND TLH_INTERFACESECTION}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

{$IFNDEF TLH_OMIT_SECTIONS}
end.
{$ENDIF TLH_OMIT_SECTIONS}
