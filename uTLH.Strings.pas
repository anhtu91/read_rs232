{
  TetzkatLipHoka 2015-2019

  uTLH: Strings
  Last updated: 07/04/2019
}

{
IsLower                             - Returns true if string is lowercase
IsUpper                             - Returns true if string is uppercase
IsAlpha                             - Returns true if string contains only chars ( A-Z,a-z )
IsAlNum                             - Returns true if string contains only chars ( A-Z, a-z, 0-9 )
IsNum                               - Check if string is a number
IsFloat                             - Check if string is a float
IsNumIn                             - Check if string is a number and within min/max
IsIn                                - Check if string contains 'text'
IsInNum                             - Similiar to IsIn but returns amount of appearances of 'text' in string
IsInNumPos                          - Child of IsInNum, returns start-position of apperance X in string
IsWm                                - Check if string contains 'wildcard'
Remove                              - Remove all appearances of 'Text' in 'string', result is new string
Replace                             - Replace all appearances of 'Text' in 'string' with 'rText', result is new string
ConvertSpacesToTabs                 - Convert TABs to given value of spaces
ConvertTabsToSpaces                 - Convert given value of spaces to TABs
RemoveTabsAndSpaces                 - Strip Tabs and ( dublicate ) spaces
TrimLineAfter                       - Remove any chars after amount of chars from start
TrimLineFromLeft                    - Remove amount of chars from start of the string( s )
TrimLineFromRight                   - Remove amount of chars from end of the string( s )
RemoveSpacesFromLineStart           - Remove any blanks/spaces from line start( s )
RemoveSpacesFromLineEnd             - Remove any blanks/spaces from line end( s )
ReturnWildCardPositionInString      - Returns start to end char of a string matching a wildcard
ReplaceStringAreal                  - Replace Text in a String from 'start' to 'end' with 'rText'
WildcardToRegEx                     - Convert Wildcard to RegExp
GetCharFromVirtualKey               - Convert VirtualKey (VK_) to Char
CompareVersion                      - Compares 2 Versions (1.0.0.0 format), can check for: =, <>, >, <, >=, <=
                                      Extends missing Tokens and less-Unit-Values (1.22 >= 1.2.1.1 --> 1.22.0.0 >= 1.02.1.1)

IsIPv4                              - Returns true if given value is a possible IP
IPToNum                             - IP address to decimal coded address
NumToIP                             - Coded IP address to IP address in the format %d.%d.%d.%d where %d is a byte

GetCurrencyValue                    - Converts a currency string to currency, even with '£', ',' etc. in the string
CountCharInString                   - Returns count of given char in given string
CountSubStringInString              - Returns count of given SubStrings in given string
Roman_To_Integer                    - Roman( V ) to Integer( 5 )
Integer_To_Roman                    - Integer( 10 ) to Roman( X )
StrToFloat_Int                      - ( Try to ) Convert string to FloatNumber, trying '.' & ',' DecimalSeperators
StrToDate_Int                       - ( Try to ) Convert string to TDateTime, trying '/' & '.' DateSeperators
                                      possible to exchange Day and Month

ScanFile                            - Search in binary file for string, returns position in file
CompareStrings                      - Compare two Strings - True if content is equal
StrNatCompare                       - Compare two strings (Internaly used (StringList.CustomSort))
StringToStringList                  - Converts a string into a TStringList

RandomString                        - Returns RandomString of given length
NumberToWord                        - Converts Float to words (123.5 -> 'One Hundred and Twenty Three point Five')

TextStatistics                      - Returns Char-, Word-, Sentence-, Paragraph-Count for given Text

GetLineSeperator                    - Returns Line-Seperator-Char(s) for given Text (#13, #10, #1310)
GetLineSeperatorAsText              - Returns Line-Seperator-Char(s) for given Text as Text (CR, LF, CR-LF)

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Bin/Hex Conversion~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ByteToHex                           - Convert Byte to HexChars
HexToByte                           - Convert HexChars to Byte
StrToHexA/W                         - Convert String to HexString
HexToStrA/W                         - Convert HexString to String
HexToInt                            - Convert HexString to Integer (Int64)
HexToUInt                           - Convert HexString to UInt (UInt64)
HexToTypedStr                       - Convert HextString to Typed-String (Integer would be same as 'IntToStr( HexToInt( INPUT ) )')
TypedStrToHex                       - Convert Typed-String to HextString
HexToByteString                     - Convert HexString to ByteString
IncDecNumberChar                    - Increase or Decrease Hex- or Number-Char
StrToBin                            - Convert String to BinaryString
BinToStr                            - Convert BinaryString to String
IntToBin                            - Convert Integer to Binary
StrToUInt64Def                      - Convert String to UInt64
UIntToStr                           - Convert Cardinal/UInt64 to String

IsHex                               - Returns true if given string is hex
IsHexChar                           - Returns true if given char is hex
FormatHex                           - Returns Group-Formated Hex-String (FF00FAFE -> FF-00-FA-FE)
ProperHex                           - Returns proper HexString (Removes Space, Leading '$' or '0x')
TrimHex                             - Trim unneeded 0's from Hex-String
HexToBinaryString                   - Hex to 0111...
PointerToHex                        - Returns PointerBytes as Hex (Max 10 Bytes)
HexToPointer                        - Write Hex to PointerBytes (Max 10 Bytes)
FloatToHex                          - Returns HexString for given Float

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~String/File Checksums~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
HashDigestAsString                  - Convert Hash-Digest to String
Hash                                - Returns -see below-Checksum for String or File
HMAC                                - Returns HMAC-see below-Hashes for String or File (No CRC32)
CRC32                               - Returns CRC32 for String or File
MD5                                 - Returns MD5 for String or File    (D10S+ or Indy9)
SHA1                                - Returns SHA1 for String or File   (D10S+ or Indy10)
SHA224                              - Returns SHA224 for String or File (D10S+ or Indy10)
SHA256                              - Returns SHA256 for String or File (D10S+ or Indy10)
SHA384                              - Returns SHA384 for String or File (D10S+ or Indy10)
SHA512                              - Returns SHA512 for String or File (D10S+ or Indy10)
SHA512_256                          - Returns SHA512-256 for String or File (D10S+ or Indy10)

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Base64~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
EncodeBase64                        - Converts Data to a base64 string using Alphabet. if Pad is True, the result will be padded with PadChar to be a multiple of PadMultiple.
DecodeBase64                        - Converts a base64 string using Alphabet (64 characters for values 0-63) to Data.
EncodeBase64A/W                     - Converts a String to a base64 string using Alphabet. if Pad is True, the result will be padded with PadChar to be a multiple of PadMultiple.
DecodeBase64A/W                     - Converts a base64 string using Alphabet (64 characters for values 0-63) to a String.

Base64MIMEDecode                    - Encode using Base64 with MIME-Alphabet
Base64MIMEEncode                    - Decode using Base64 with MIME-Alphabet
Base64UUEncode                      - Encode using Base64 with UU-Alphabet
Base64UUDecode                      - Decode using Base64 with UU-Alphabet
Base64XXEncode                      - Encode using Base64 with XX-Alphabet
Base64XXDecode                      - Decode using Base64 with XX-Alphabet

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Tokens~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Tokenize( text, C ) : TStringDynArray       Deconstructs the string in 'text' to its tokens seperated by 'C'
Tokenize( TStringDynArray, C ): string;     The output is a 'TStringDynArray' of Type 'Array of String'

                                            Also reconstructs a TStringDynArray to a string seperated by 'C'

                                            The C parameter is the ascii value of the character separating the Tokens.


AddTok( text,Token,C )                      Adds a Token to the end of text but only if it's not already in text.
                                            AddTok( a.b.c,d,46 )        returns a.b.c.d
                                            AddTok( a.b.c.d,c,46 )      returns a.b.c.d

DelTok( text,N,C )                          Deletes the Nth Token from text.
                                            DelTok( a.b.c.d,3,46 )        returns a.b.d
                                            DelTok( a.b.c.d,2,3,46 )      returns a.d

FindTok( text,Token,N,C )                   Returns the position of the Nth matching Token in text.
                                            FindTok( a.b.c.d,c,1,46 )     returns 3
                                            FindTok( a.b.c.d,e,1,46 )     returns $null

GetTok( text,N[ ,N2 ],C, IgnoreEmpty )      Returns the Nth Token in text.
                                            GetTok( a.b.c.d.e,3,46 )      returns c
                                            GetTok( a.b.c.d.e,9,46 )      returns $null
                                            GetTok( a.b.c.d.e,2,4,46 )    returns Tokens 2 through 4 b.c.d
                                            If N2 is specified a range of Tokens is returned
                                            IgnoreEmpty is TRUE by default, means 'abc;;def' will split as 2 Tokens: 'abc;' and 'def'
                                            IgnoreEmpty on FALSE would act like this: 'abc;;def' will split as 3 Tokens: 'abc', '' and 'def'

InsTok( text,Token,N,C )                    Inserts Token into the Nth position in text, even if it already exists in text.
                                            InsTok( a.b.d,c,3,46 )        returns a.b.c.d
                                            InsTok( a.b.d,c,9,46 )        returns a.b.d.c

IsTok( text,Token,C )                       Returns $true if Token exists, otherwise returns $false.

MatchTok( Tokens,string,N,C )               Returns Tokens that contain the specified string.
                                            MatchTok( one two three, e, 0, 32 ) returns 2
                                            MatchTok( one two three, e, 2, 32 ) returns three

NumTok( text,C,IgnoreEmpty )                Returns number of Tokens in text.
                                            IgnoreEmpty is TRUE by default, means 'abc;;def' will return 2 Tokens: 'abc;' and 'def'
                                            IgnoreEmpty on FALSE would act like this: 'abc;;def' will return 3 Tokens: 'abc', '' and 'def'

PutTok( text,Token,N,C )                    Overwrites the Nth Token in text with a new Token.
                                            PutTok( a.b.c.d,e,2,46 )        returns a.e.c.d

RemTok( text,Token,N,C )                      Removes the Nth matching Token from text. If N = 0, applies to all matching items.
                                            RemTok( a.b.c.d,b,1,46 )        returns a.c.d
                                            RemTok( a.b.c.d,e,1,46 )        returns a.b.c.d
                                            RemTok( a.c.c.d,c,1,46 )        returns a.c.d

RepTok( text,Token,new,N,C )                Replaces the Nth matching Token in text with a new Token. If N = 0, applies to all matching items.
                                            RepTok( a.b.c.d,b,e,1,46 )        returns a.e.c.d
                                            RepTok( a.b.c.d,f,e,1,46 )        returns a.b.c.d
                                            RepTok( a.b.a.c,a,e,2,46 )        returns a.b.e.c

WildTok( Tokens,wildstring,N,C )            Returns the Nth Token that matches the wildcard string.
                                            WildTok( one two three, t*, 0, 32 )  returns 2
                                            WildTok( one two three, t*e, 1, 32 ) returns three


SortTok( text,C,( rnadc ) )                 Sorts the Tokens in text.
                                            SortTok( e.d.c.b.a,46 )        returns a.b.c.d.e
 Options:                                   SortTok( 1.3.5.2.4,46,nd )     returns 5.4.3.2.1
   R = Regular sorting -|
   N = Natural sorting -| Can't be combined
                                                             
   A = Ascending       -|                                     
   D = Descending      -| Can't be combined                   
                                                             
   C = CaseSensitive   - Can't be used with Regular-sorting   
   Default/no options = Natural, Descending case insensitive

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~TStringList.CustomSort~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NaturalSortAsc                      - Natural/Human sorting, case inSensitive
NaturalSortDesc                     - Natural/Human sorting, case inSensitive
NaturalSortAscCS                    - Natural/Human sorting, case Sensitive
NaturalSortDescCS                   - Natural/Human sorting, case Sensitive   
}

{$IFNDEF TLH_OMIT_SECTIONS}
unit uTLH.Strings;

{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CAST OFF}
{$IF CompilerVersion >= 23}
  {$WARN IMPLICIT_STRING_CAST OFF}
  {$WARN SYMBOL_PLATFORM OFF}
  {$LEGACYIFEND ON}
{$IFEND}
{$WARN GARBAGE OFF}

{$I uTLH.inc}

interface

uses
  Windows, Classes, Types{TStringDynArray},
  SysUtils,
  Controls{StrToDate_Int}
  {$IFNDEF UNICODE}
  {$IFDEF USE_UNICODE}
  ,Unicode
  {$ENDIF}
  {$IFDEF USE_SYNUNICODE}
  ,SynUnicode
  {$ENDIF}
  {$ENDIF}
  ;
{$ENDIF TLH_OMIT_SECTIONS}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
{$IF NOT Defined( TLH_IMPLEMENTATIONSECTION ) AND NOT Defined( TLH_INITIALIZATIONSECTION ) AND NOT Defined( TLH_FINALIZATIONSECTION )}
function CompareStrings( Str, Str2: String; caseSensitive : boolean = false ):boolean; overload; // True if similiar
function IsLower( value: string ): Boolean;
function IsUpper( value: string ): Boolean;
function IsAlpha( value: string ): Boolean;
function IsAlNum( value: string ): Boolean;
function IsNum( Number: string; Signed : boolean = True ): Boolean;
function IsFloat( Number: string; Signed : boolean = True ): Boolean;
function IsNumIn( Number: string; Min, Max : integer ): Boolean; overload;
function IsIn( Text, Wild: string; caseSensitive : boolean = false ): boolean;
function IsInNum( Text, Wild: string; caseSensitive : boolean = false ): integer;
function IsinNumPos( Text, Wild: string; N : integer; caseSensitive : boolean = false ): integer;
function IsWm( Text, MatchText: String; caseSensitive : boolean = false ): Boolean; //Text Matches wildcard
function Remove( Text, RText: string; WildCard : Boolean = false; caseSensitive : boolean = false ):string; overload; //Removes RText from Text
function Replace( Text, mText, rText: string; WildCard : Boolean = false; caseSensitive : boolean = false ): string; overload //Replace any occurence of Item on Text by NewItem
function StrNatCompare( const Str1, Str2: string; const CaseSensitive: boolean = false ): integer;
function ConvertSpacesToTabs( text : string; value : Byte ): string; overload;
function ConvertTabsToSpaces( text : string; value : Byte ): string; overload;
function RemoveTabsAndSpaces( text : string ): string; overload;
function StringToStringList( text : string ): TStringList;
function StringToStrings( text : string ): TStrings; overload;
{$IFNDEF UNICODE}
{$IFDEF USE_UNICODE}
function StringToStrings( text : WideString ): TWideStrings;
{$ENDIF}
{$IFDEF USE_SYNUNICODE}
function StringToStrings( text : UnicodeString ): TUnicodeStrings; overload;
{$ENDIF}
{$ENDIF}
function TrimLineAfter( str : string; Value : Byte ): string; overload;
function TrimLineFromLeft( str : string; Value : Byte ): string; overload;
function TrimLineFromRight( str : string; Value : Byte ): string; overload;
function RemoveSpacesFromLineStart( str : string ): string; overload;
function RemoveSpacesFromLineEnd( str : string ): string; overload;
function ReturnWildCardPositionInString( Text, WildCard : string; var start, endN : integer; caseSensitive : boolean = false ): boolean;
function WildcardToRegEx( Wildcard : string ): string;
function IsIPv4( IP : string ): boolean;
function IPToNum( IP: string ): string;
function NumToIP( Num: string ): string;
function Roman_To_Integer( Roman: String ): Integer;
function Integer_To_Roman( number: integer ): String;
function StrToFloat_Int( pText : string; default : Extended = 0 ): Extended;
function StrToDate_Int( value : string; changeMonthAndDay : boolean = false ): TDate;
function GetCurrencyValue( S : string ) : extended;
function CountCharInString( c: char; s: string ):integer;
function CountSubStringInString( const Text: string; const SubText: string ) : Cardinal;
function ScanFile( const FileName: string; const forString: string; caseSensitive: Boolean = false ): Longint;
function GetCharFromVirtualKey( Key: Word ): String;
function RandomString( const Len: Byte = 16 ): string;
function NumberToWord( ChkER: boolean; ER: string; D: double ): string;
procedure TextStatistics( Text : string; Chars : PCardinal; Words : PCardinal = nil; Sentences : PCardinal = nil; Paragraphs : PCardinal = nil; Lines : PCardinal = nil );
function ReplaceStringAreal( InString : string; start, endN : integer; rText : string ): string; overload;
procedure ReplaceStringAreal_( var InString : string; start, endN : integer; rText : string ); overload;
{$IFNDEF UNICODE}
function ReplaceStringAreal( InString : WideString; start, endN : integer; rText : string ): WideString; overload;
procedure ReplaceStringAreal_( var InString : WideString; start, endN : integer; rText : WideString ); overload;
{$ENDIF}

function GetLineSeperator( Text : string ) : string;
function GetLineSeperatorAsText( Text : string ) : string;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
type
  tCompareVersionMode = ( cvmEqual, cvmUnequal, cvmAbove, cvmBelow, cvmAboveOrEqual, cvmBelowOrEqual );
function CompareVersion( v1, v2 : string; vMode : tCompareVersionMode = cvmAboveOrEqual ) : boolean;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function HexToByte( sHex : string ) : Byte;
function ByteToHex( B : Byte ) : ShortString;
function StrToHex( sHex: string ): string;
function StrToHexA( sHex: AnsiString ): string;
function StrToHexW( sHex: WideString ): string;
function HexToStrA( sHex: String ): AnsiString;
function HexToStrW( sHex: String ): WideString;

function HexToInt( sHex : string ): Int64;
function HexToUInt( sHex : string; BigEndian : boolean = false ): UInt64;

type
  tHexToTypedStrTypes = ( httsByte, httsShortInt, httsWord, httsSmallInt, httsCardinal, httsInteger, httsUINT64, httsInt64, httsReal48, httsSingle,
                          httsDouble, httsExtended, httsComp, httsCurrency, httsDateTime, httsCTime, httsAnsiString, httsWideString );
function HexToTypedStr( sHex : string; vType : tHexToTypedStrTypes; BigEndian : boolean = false ) : String;
function TypedStrToHex( s : string; vType : tHexToTypedStrTypes; BigEndian : boolean = false ) : String;

function HexToByteString( sHex : string; SeperatorChar : Char = #32 ) : string;

function IncDecNumberChar( C : Char; Increase : Boolean = True; Hex : boolean = false ) : Char;

function StrToBin( aStr: string ): string;
function BinToStr( aStr: string ): string;
function IntToBin( Value: Cardinal ): string;

{$IF CompilerVersion <= 23}
function StrToUInt64Def( const s: string; Default : UInt64 ): UInt64;
{$IFEND}

{$IF CompilerVersion <= 23}
function UIntToStr( UInt : Cardinal ): string; overload;
function UIntToStr( UInt : UInt64 ): string; overload; // D7 is still unable to Handle it properly as unsigned
{$IFEND}

function IsHexChar( c : char ): boolean;
function IsHex( sHex : String ):Boolean;
function ProperHex( sHex : String ) : String;
function FormatHex( sHex : String; GroupLen : Byte = 2 ) : String;
function TrimHex( sHex : string; BigEndian : boolean = false ) : string;
function HexToBinaryString( sHex : string; ByteCount : Cardinal = 0; BigEndian : Boolean = False ) : string;

function PointerToHex( P : Pointer; TypeSize : Byte; BigEndian : boolean = false ): string;
function HexToPointer( sHex : string; P : Pointer; TypeSize : Byte; BigEndian : boolean = false ) : Boolean;
function FloatToHex( f : real48; BigEndian : boolean = false ): string; overload;
function FloatToHex( f : single; BigEndian : boolean = false ): string; overload;
function FloatToHex( f : double; BigEndian : boolean = false ): string; overload;
function FloatToHex( f : extended; BigEndian : boolean = false ): string; overload;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//Checksum
function CRC32( const Bytes : {$IF CompilerVersion >= 30}TBytes{$ELSE}TByteDynArray{$IFEND} ): string; overload;
function CRC32( const TextOrFileName: string ): string; overload;
{$IF ( CompilerVersion >= 30 ) OR Defined( INDY90 ) OR Defined( INDY100 )}
type
  tHashType = ( htCRC32, htMD5, htSHA1, htSHA224, htSHA256, htSHA384, htSHA512, htSHA512_224, htSHA512_256 );
function HMAC( const TextOrFileName, Key : string; HashType : tHashType = htMD5 ) : string; overload;
function HMAC( const Bytes : {$IF CompilerVersion >= 30}TBytes{$ELSE}TByteDynArray{$IFEND}; Key : string; HashType : tHashType = htMD5 ) : string; overload;
function Hash( const Bytes : {$IF CompilerVersion >= 30}TBytes{$ELSE}TByteDynArray{$IFEND}; HashType : tHashType = htMD5 ) : string; overload;
function Hash( const TextOrFileName : string; HashType : tHashType = htMD5 ) : string; overload;
function HashDigestAsString(const ADigest: {$IF CompilerVersion >= 30}TBytes{$ELSE}TByteDynArray{$IFEND}): string;
function MD5( const TextOrFileName : string ) : string;
{$IFEND}
{$IF ( CompilerVersion >= 30 ) OR Defined( INDY100 )}
function SHA1( const TextOrFileName : string ) : string;
function SHA224( const TextOrFileName : string ) : string;
function SHA256( const TextOrFileName : string ) : string;
function SHA384( const TextOrFileName : string ) : string;
function SHA512( const TextOrFileName : string ) : string;
{$IFEND}
{$IF CompilerVersion >= 30}
function SHA512_256( const TextOrFileName : string ) : string;
{$IFEND}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
const
//  ValidURLChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789$-_@.&+-!*"''(),;/#?:';
  ValidURLChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789$-_@.&+-!*"''(),;#?';
function URLEncode( const Value: AnsiString; ValidChars : AnsiString = ValidURLChars ): AnsiString;
function URLDecode( const Value: AnsiString ): AnsiString;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
type
  ByteCharSet = set of AnsiChar;
  PByteChar = ^AnsiChar;
function  EncodeBase64( const Data : Pointer; const Len : Int64; const Alphabet: AnsiString; const Pad: Boolean = False; const PadMultiple: Integer = 4; const PadChar: AnsiChar = AnsiChar( Ord( '=' ) ) ): AnsiString; overload;
function  EncodeBase64( const S : string; const Alphabet: AnsiString; const Pad: Boolean = False; const PadMultiple: Integer = 4; const PadChar: AnsiChar = AnsiChar( Ord( '=' ) ) ): AnsiString; overload;
function  EncodeBase64A( const S, Alphabet: AnsiString; const Pad: Boolean = False; const PadMultiple: Integer = 4; const PadChar: AnsiChar = AnsiChar( Ord( '=' ) ) ): AnsiString;
function  EncodeBase64W( const S : WideString; const Alphabet: AnsiString; const Pad: Boolean = False; const PadMultiple: Integer = 4; const PadChar: AnsiChar = AnsiChar( Ord( '=' ) ) ): AnsiString;

procedure DecodeBase64( const S, Alphabet: AnsiString; var OutByteArray : TByteDynArray; const PadSet: ByteCharSet ); overload;
function  DecodeBase64( const S, Alphabet: AnsiString; const PadSet: ByteCharSet ) : string; overload;
function  DecodeBase64A( const S, Alphabet: AnsiString; const PadSet: ByteCharSet ) : AnsiString;
function  DecodeBase64W( const S, Alphabet: AnsiString; const PadSet: ByteCharSet ) : WideString;

const
  b64_MIMEBase64 = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
  b64_UUEncode   = ' !"#$%&''()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_';
  b64_XXEncode   = '+-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';

// MIME
function  Base64MIMEEncode( const P: Pointer; const Len : Int64 ): AnsiString; overload;
function  Base64MIMEEncode( const S: String ): String; overload;
function  Base64MIMEEncodeA( const S: AnsiString ): AnsiString;
function  Base64MIMEEncodeW( const S: WideString ): WideString;
procedure Base64MIMEDecode( const S: AnsiString; var OutByteArray : TByteDynArray ); overload;
function  Base64MIMEDecode( const S: AnsiString ): String; overload;
function  Base64MIMEDecodeA( const S: AnsiString ): AnsiString;
function  Base64MIMEDecodeW( const S: AnsiString ): WideString;

// UU
function  Base64UUEncode( const P: Pointer; const Len : Int64 ): AnsiString; overload;
function  Base64UUEncode( const S: String ): String; overload;
function  Base64UUEncodeA( const S: AnsiString ): AnsiString;
function  Base64UUEncodeW( const S: WideString ): WideString;
procedure  Base64UUDecode( const S: AnsiString; var OutByteArray : TByteDynArray ); overload;
function  Base64UUDecode( const S: AnsiString ): String; overload;
function  Base64UUDecodeA( const S: AnsiString ): AnsiString;
function  Base64UUDecodeW( const S: AnsiString ): WideString;

// XX
function  Base64XXEncode( const P: Pointer; const Len : Int64 ): AnsiString; overload;
function  Base64XXEncode( const S: String ): String; overload;
function  Base64XXEncodeA( const S: AnsiString ): AnsiString;
function  Base64XXEncodeW( const S: WideString ): WideString;
procedure  Base64XXDecode( const S: AnsiString; var OutByteArray : TByteDynArray ); overload;
function  Base64XXDecode( const S: AnsiString ): String; overload;
function  Base64XXDecodeA( const S: AnsiString ): AnsiString;
function  Base64XXDecodeW( const S: AnsiString ): WideString;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Tokenize
type
  TWStringDynArray = Array of WideString;

function AddTok( const S, T: string; const C: Char; caseSensitive : boolean = False; AllowDuplicates : boolean = false ): string; overload;
function AddTok( const S, T: string; const B: Byte; caseSensitive : boolean = False; AllowDuplicates : boolean = false ): string; overload;
function DelTok( const S: string; const N: Integer; const B: Byte ): string; overload;
function DelTok( const S: string; const N: Integer; const C: Char ): string; overload;
function DelTok( const S: string; const N1, N2: Integer; const B: Byte ): string; overload;
function DelTok( const S: string; const N1, N2: Integer; const C: Char ): string; overload;
function FindTok( const S, T: string; N: Integer; const B: Byte; caseSensitive : boolean = False ): Integer; overload;
function FindTok( const S, T: string; N: Integer; const C: Char; caseSensitive : boolean = False ): Integer; overload;
function GetTok( const S: string; const N1, N2: Integer; const B: Byte; IgnoreEmpty : boolean = true ): string; overload;
function GetTok( const S: string; const N1, N2: Integer; const C: Char; IgnoreEmpty : boolean = true ): string; overload;
function GetTok( const S: string; N: Integer; const B: Byte; IgnoreEmpty : boolean = true ): string; overload;
function GetTok( const S: string; N: Integer; const C: Char; IgnoreEmpty : boolean = true ): string; overload;
function InsTok( const S, T: string; N: Integer; const B: Byte ): string; overload;
function InsTok( const S, T: string; N: Integer; const C: Char ): string; overload;
function PutTok( const S, T: string; N: Integer; const B: Byte ): string; overload;
function PutTok( const S, T: string; N: Integer; const C: Char ): string; overload;
function IsTok( const S, T: string; const C: Char; caseSensitive : boolean = False ): Boolean; overload;
function IsTok( const S, T: string; const B: Byte; caseSensitive : boolean = False ): Boolean; overload;
function MatchTok( const S, T: string; N: Integer; const B: Byte; caseSensitive : boolean = False ): Variant; overload;
function MatchTok( const S, T: string; N: Integer; const C: Char; caseSensitive : boolean = False ): Variant; overload;
function NumTok( const S: string; const C: Char; IgnoreEmpty : boolean = true ): Integer; overload;
function NumTok( const S: string; const B: Byte; IgnoreEmpty : boolean = true ): Integer; overload;
function RemTok( const S, T: string; N: Integer; const C: Char; const caseSensitive : boolean = False ): string; overload;
function RemTok( const S, T: string; N: Integer; const B: Byte; const caseSensitive : boolean = False ): string; overload;
function ExTok( const S : string; T1, T2: Integer; const B: Byte ): string; overload;
function ExTok( const S : string; T1, T2: Integer; const C: Char ): string; overload;
function MoveTok( const S : string; T1, T2: Integer; const B: Byte ): string; overload;
function MoveTok( const S : string; T1, T2: Integer; const C: Char ): string; overload;
function CloneTok( const S : string; T1, T2: Integer; const B: Byte ): string; overload;
function CloneTok( const S : string; T1, T2: Integer; const C: Char ): string; overload;
function RepTok( const S, T, T2: string; N: Integer; const B: Byte; const caseSensitive : boolean = False ): string; overload;
function RepTok( const S, T, T2: string; N: Integer; const C: Char; const caseSensitive : boolean = False ): string; overload;
function Tokenize( const S: string; const B: Byte; IgnoreEmpty : boolean = true ): TStringDynArray; overload;
function Tokenize( const S: string; const C: Char; IgnoreEmpty : boolean = true ): TStringDynArray; overload;
function Tokenize( const S: TStringDynArray; const B: Byte; caseSensitive : boolean = False; AllowDuplicates : boolean = false ): string; overload;
function Tokenize( const S: TStringDynArray; const C: Char; caseSensitive : boolean = False; AllowDuplicates : boolean = false ): string; overload;
function WildTok( const S, T: string; N: Integer; const C: Char ): Variant; overload;
function WildTok( const S, T: string; N: Integer; const B: Byte ): Variant; overload;
function SortTok( const S : string; C : Char ): string; overload;
function SortTok( const S : string; B : Byte ): string; overload;
function SortTok( const S, Options : string; C : Char ): string; overload;
function SortTok( const S, Options : string; B : Byte ): string; overload;

// WideString Versions
{$IFNDEF UNICODE}
{$IF NOT Defined( USE_UNICODE ) AND NOT Defined( USE_SYNUNICODE )}
function WStrComp(Str1, Str2: PWideChar): Integer;
function WStrLComp(Str1, Str2: PWideChar; MaxLen: Cardinal): Integer;
{$IFEND}

function AddTok( const S, T: WideString; const C: WideChar; caseSensitive : boolean = False; AllowDuplicates : boolean = false ): WideString; overload;
function AddTok( const S, T: WideString; const B: Byte; caseSensitive : boolean = False; AllowDuplicates : boolean = false ): WideString; overload;
function DelTok( const S: WideString; const N: Integer; const B: Byte ): WideString; overload;
function DelTok( const S: WideString; const N: Integer; const C: WideChar ): WideString; overload;
function DelTok( const S: WideString; const N1, N2: Integer; const B: Byte ): WideString; overload;
function DelTok( const S: WideString; const N1, N2: Integer; const C: WideChar ): WideString; overload;
function FindTok( const S, T: WideString; N: Integer; const B: Byte; caseSensitive : boolean = False ): Integer; overload;
function FindTok( const S, T: WideString; N: Integer; const C: WideChar; caseSensitive : boolean = False ): Integer; overload;
function GetTok( const S: WideString; const N1, N2: Integer; const B: Byte; IgnoreEmpty : boolean = true ): WideString; overload;
function GetTok( const S: WideString; const N1, N2: Integer; const C: WideChar; IgnoreEmpty : boolean = true ): WideString; overload;
function GetTok( const S: WideString; N: Integer; const B: Byte; IgnoreEmpty : boolean = true ): WideString; overload;
function GetTok( const S: WideString; N: Integer; const C: WideChar; IgnoreEmpty : boolean = true ): WideString; overload;
function InsTok( const S, T: WideString; N: Integer; const B: Byte ): WideString; overload;
function InsTok( const S, T: WideString; N: Integer; const C: WideChar ): WideString; overload;
function PutTok( const S, T: WideString; N: Integer; const B: Byte ): WideString; overload;
function PutTok( const S, T: WideString; N: Integer; const C: WideChar ): WideString; overload;
function IsTok( const S, T: WideString; const C: WideChar; caseSensitive : boolean = False ): Boolean; overload;
function IsTok( const S, T: WideString; const B: Byte; caseSensitive : boolean = False ): Boolean; overload;
function MatchTok( const S, T: WideString; N: Integer; const B: Byte; caseSensitive : boolean = False ): Variant; overload;
function MatchTok( const S, T: WideString; N: Integer; const C: WideChar; caseSensitive : boolean = False ): Variant; overload;
function NumTok( const S: WideString; const C: WideChar; IgnoreEmpty : boolean = true ): Integer; overload;
function NumTok( const S: WideString; const B: Byte; IgnoreEmpty : boolean = true ): Integer; overload;
function RemTok( const S, T: WideString; N: Integer; const C: WideChar; const caseSensitive : boolean = False ): WideString; overload;
function RemTok( const S, T: WideString; N: Integer; const B: Byte; const caseSensitive : boolean = False ): WideString; overload;
function ExTok( const S : WideString; T1, T2: Integer; const B: Byte ): WideString; overload;
function ExTok( const S : WideString; T1, T2: Integer; const C: WideChar ): WideString; overload;
function MoveTok( const S : WideString; T1, T2: Integer; const B: Byte ): WideString; overload;
function MoveTok( const S : WideString; T1, T2: Integer; const C: WideChar ): WideString; overload;
function CloneTok( const S : WideString; T1, T2: Integer; const B: Byte ): WideString; overload;
function CloneTok( const S : WideString; T1, T2: Integer; const C: WideChar ): WideString; overload;
function RepTok( const S, T, T2: WideString; N: Integer; const B: Byte; const caseSensitive : boolean = False ): WideString; overload;
function RepTok( const S, T, T2: WideString; N: Integer; const C: WideChar; const caseSensitive : boolean = False ): WideString; overload;
function Tokenize( const S: WideString; const B: Byte; IgnoreEmpty : boolean = true ): TStringDynArray; overload;
function Tokenize( const S: WideString; const C: WideChar; IgnoreEmpty : boolean = true ): TStringDynArray; overload;
function Tokenize( const S: TWStringDynArray; const B: Byte; caseSensitive : boolean = False; AllowDuplicates : boolean = false ): WideString; overload;
function Tokenize( const S: TWStringDynArray; const C: WideChar; caseSensitive : boolean = False; AllowDuplicates : boolean = false ): WideString; overload;
function WildTok( const S, T: WideString; N: Integer; const C: WideChar ): Variant; overload;
function WildTok( const S, T: WideString; N: Integer; const B: Byte ): Variant; overload;
function SortTok( const S : WideString; C : WideChar ): WideString; overload;
function SortTok( const S : WideString; B : Byte ): WideString; overload;
function SortTok( const S, Options : WideString; C : WideChar ): WideString; overload;
function SortTok( const S, Options : WideString; B : Byte ): WideString; overload;
{$ENDIF UNICODE}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~TStringList.CustomSort~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function NaturalSortAsc( List: TStringList; Index1, Index2: Integer ): Integer;{$IFNDEF UNICODE} overload;{$ENDIF}
function NaturalSortDesc( List: TStringList; Index1, Index2: Integer ): Integer;{$IFNDEF UNICODE} overload;{$ENDIF}
function NaturalSortAscCS( List: TStringList; Index1, Index2: Integer ): Integer;{$IFNDEF UNICODE} overload;{$ENDIF}
function NaturalSortDescCS( List: TStringList; Index1, Index2: Integer ): Integer;{$IFNDEF UNICODE} overload;{$ENDIF}
function DateSortAsc( List: TStringList; Index1, Index2: Integer ): Integer;{$IFNDEF UNICODE} overload;{$ENDIF}
function DateSortDesc( List: TStringList; Index1, Index2: Integer ): Integer;{$IFNDEF UNICODE} overload;{$ENDIF}

{$IFNDEF UNICODE}
{$IFDEF USE_UNICODE}
function NaturalSortAsc( List: TWideStringList; Index1, Index2: Integer ): Integer; overload;
function NaturalSortDesc( List: TWideStringList; Index1, Index2: Integer ): Integer; overload;
function NaturalSortAscCS( List: TWideStringList; Index1, Index2: Integer ): Integer; overload;
function NaturalSortDescCS( List: TWideStringList; Index1, Index2: Integer ): Integer; overload;
function DateSortAsc( List: TWideStringList; Index1, Index2: Integer ): Integer; overload;
function DateSortDesc( List: TWideStringList; Index1, Index2: Integer ): Integer; overload;
{$ENDIF}
{$IFDEF USE_SYNUNICODE}
function NaturalSortAscU( String1, String2 : UnicodeString ): Integer; overload;
function NaturalSortDescU( String1, String2 : UnicodeString): Integer; overload;
function NaturalSortAscCSU( String1, String2 : UnicodeString ): Integer; overload;
function NaturalSortDescCSU( String1, String2 : UnicodeString ): Integer; overload;
function DateSortAscU( String1, String2 : UnicodeString ): Integer; overload;
function DateSortDescU( String1, String2 : UnicodeString ): Integer; overload;
{$ENDIF}
{$ENDIF}

{$IFEND TLH_IMPLEMENTATIONSECTION}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
{$IFNDEF TLH_OMIT_SECTIONS}
implementation

uses
  Math, StrUtils, Variants
  {$IF CompilerVersion >= 30}
    ,System.Hash
  {$ELSE}
    {$IFDEF USE_EXTERNAL_HASH}
      ,uHash
      {$IFDEF USE_MD5},MD5{$ENDIF}
      {$IFDEF USE_SHA1},SHA1{$ENDIF}
      {$IFDEF USE_SHA224},SHA224{$ENDIF}
      {$IFDEF USE_SHA256},SHA256{$ENDIF}
      {$IFDEF USE_SHA384},SHA384{$ENDIF}
      {$IFDEF USE_SHA512},SHA512{$ENDIF}
      {$IFDEF USE_SHA5_224},SHA5_224{$ENDIF}
      {$IFDEF USE_SHA5_256},SHA5_256{$ENDIF}
    {$ENDIF}
    {$IF Defined( INDY90 ) OR Defined( INDY100 )},IdHashMessageDigest{$IFEND} // MD5 - Indy9/10
    {$IFDEF INDY100},IdHash, IdHashSHA, IdSSLOpenSSLHeaders, IdGlobal{$ENDIF} // SHA1/SHA256 - Indy10+
  {$IFEND}
  ;
{$ENDIF TLH_OMIT_SECTIONS}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
{$IF NOT Defined( TLH_INTERFACESECTION ) AND NOT Defined( TLH_INITIALIZATIONSECTION ) AND NOT Defined( TLH_FINALIZATIONSECTION )}
// Regular
function CompareStrings( Str, Str2: String; caseSensitive : boolean = false ):boolean; // True if similiar
begin
  if caseSensitive then
    Result := CompareStr( Str, Str2 ) = 0
  else
    result := CompareText( Str, Str2 ) = 0;
end;

function IsLower( value: string ): Boolean;
begin
  result := CompareStrings( value, LowerCase( value ), true );
end;

function IsUpper( value: string ): Boolean;
begin
  result := CompareStrings( value, UpperCase( value ), true );
end;

function IsAlpha( value: string ): Boolean;
var
  i: Integer;
begin
  Result := True;
  value := Trim( value );
  for i := {$IF CompilerVersion >= 24}Low( value ){$ELSE}1{$IFEND} to {$IF CompilerVersion >= 24}High( value ){$ELSE}Length( value ){$IFEND} do
    if NOT {$IF CompilerVersion >= 22}CharInSet( value[ i ],{$ELSE}( value[ i ] in{$IFEND} [ 'a'..'z','A'..'Z' ] ) then
      begin
      Result := false;
      break;
      end;
end;

function IsAlNum( value: string ): Boolean;
var
  i : integer;
begin
  Result := True;
  value := Trim( value );
  for i := {$IF CompilerVersion >= 24}Low( value ){$ELSE}1{$IFEND} to {$IF CompilerVersion >= 24}High( value ){$ELSE}Length( value ){$IFEND} do
    if NOT {$IF CompilerVersion >= 22}CharInSet( value[ i ],{$ELSE}( value[ i ] in{$IFEND}[ {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}DecimalSeparator, '-', 'a'..'z','A'..'Z','0'..'9' ] ) then
    begin
    Result := false;
    break;
    end;
end;

function IsNum( Number: string; Signed : boolean = True ): Boolean;
var
  i     : integer;
begin
  for i := {$IF CompilerVersion >= 24}Low( number ){$ELSE}1{$IFEND} to {$IF CompilerVersion >= 24}High( number ){$ELSE}Length( number ){$IFEND} do
    begin
    if ( ( Number[ i ] = '-' ) OR ( Number[ i ] = '+' ) ) then
      begin
      if ( ( NOT Signed ) AND ( ( Number[ i ] = '-' ) ) ) OR ( i > {$IF CompilerVersion >= 24}Low( number ){$ELSE}1{$IFEND} ) then
        begin
        result := false;
        Exit;
        end;
      end
    else if NOT {$IF CompilerVersion >= 22}CharInSet( Number[ i ],{$ELSE}( Number[ i ] in{$IFEND} [ '0'..'9' ] ) then
      begin
      Result := False;
      Exit;
      end;
    end;
  Result := True;
end;

function IsFloat( Number: string; Signed : boolean = True ): Boolean;
var
  i     : integer;
  hasDS : Boolean;
  hasE  : Boolean;
begin
  hasDS := false;
  hasE  := false;

  for i := {$IF CompilerVersion >= 24}Low( number ){$ELSE}1{$IFEND} to {$IF CompilerVersion >= 24}High( number ){$ELSE}Length( number ){$IFEND} do
    begin
    if ( Number[ i ] = '-' ) OR ( Number[ i ] = '+' ) then
      begin
      if ( ( NOT Signed ) AND ( ( Number[ i ] = '-' ) ) ) OR ( ( i > {$IF CompilerVersion >= 24}Low( number ){$ELSE}1{$IFEND} ) AND ( NOT {$IF CompilerVersion >= 22}CharInSet( Number[ i-1 ],{$ELSE}( Number[ i-1 ] in{$IFEND} [ 'E', 'e' ] ) ) ) then
        begin
        result := false;
        Exit;
        end;
      end

    else if ( {$IF CompilerVersion >= 22}CharInSet( Number[ i ],{$ELSE}( Number[ i ] in{$IFEND} [ 'E', 'e' ] ) ) then
      begin
      if ( i > {$IF CompilerVersion >= 24}Low( number ){$ELSE}1{$IFEND} ) AND ( NOT hasE ) then
        hasE := True
      else
        begin
        result := false;
        Exit;
        end;
      end

    else if ( Number[ i ] = {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}DecimalSeparator ) then
      begin
      if ( i > {$IF CompilerVersion >= 24}Low( number ){$ELSE}1{$IFEND} ) AND ( NOT hasDS ) then
        hasDS := True
      else
        begin
        result := false;
        Exit;
        end;
      end

    else if NOT {$IF CompilerVersion >= 22}CharInSet( Number[ i ],{$ELSE}( Number[ i ] in{$IFEND} [ '0'..'9' ] ) then
      begin
      Result := False;
      Exit;
      end;
    end;
  Result := True;
end;

function IsNumIn( Number: string; Min, Max : integer ): Boolean;
begin
  result := false;
  if IsNum( Number ) then
    result := ( StrToInt( Number ) >= min ) and ( StrToInt( Number ) <= Max );
end;

function Isin( Text, Wild: string; caseSensitive : boolean = false ): Boolean;
begin
  if ( caseSensitive ) then
    Result := StrPos( PChar( Text ), PChar( Wild ) ) <> Nil
  else
    Result := StrPos( PChar( UpperCase( Text ) ), PChar( UpperCase( Wild ) ) ) <> Nil;
end;

function IsinNum( Text, Wild: string; caseSensitive : boolean = false ): integer;
var
  i : integer;
begin
  result := 0;
  i := 0;

  if ( caseSensitive ) then
    begin
    while ( i <= Length( Text ) ) AND ( PosEx( PChar( Wild ), PChar( Text ), i ) <> 0 ) do
      begin
      i := PosEx( PChar( Wild ), PChar( Text ), i )+1;
      inc( result );
      end;
    end
  else
    begin
    while ( i <= Length( Text ) ) AND ( PosEx( LowerCase( PChar( Wild ) ), LowerCase( PChar( Text ) ), i ) <> 0 ) do
      begin
      i := PosEx( LowerCase( PChar( Wild ) ), LowerCase( PChar( Text ) ), i )+1;
      inc( result );
      end;
    end;
end;

function IsinNumPos( Text, Wild: string; N : integer; caseSensitive : boolean = false ): integer;
var
  i : integer;
begin
  result := 0;

  if ( Text = '' ) OR ( Wild = '' ) OR ( N <= 0 ) OR ( N > IsInNum( Text, Wild, caseSensitive ) ) then
    Exit;

  i := 0;
  if ( caseSensitive ) then
    begin
    while ( result <= Length( Text ) ) AND ( i <> N ) do
      begin
      result := PosEx( PChar( Wild ), PChar( Text ), result )+1;
      inc( i );
      end;
    end
  else
    begin
    while ( result <= Length( Text ) ) AND ( i <> N ) do
      begin
      result := PosEx( LowerCase( PChar( Wild ) ), LowerCase( PChar( Text ) ), result )+1;
      inc( i );
      end;
    end;
end;

function IsWm( Text, MatchText: String; caseSensitive : boolean = false ): Boolean;
var
  StringPtr: PChar;
  PatternPtr: PChar;
  StringRes: PChar;
  PatternRes: PChar;
  tText,
  tMatchText : String;
begin
  Result := False;

  if ( Text = '' ) or ( MatchText = '' ) then
    Exit;

  if ( caseSensitive ) then
    begin
    tText := Text;
    tMatchText := MatchText;
    end
  else
    begin
    tText := UpperCase( Text );
    tMatchText := UpperCase( MatchText );
    end;

  StringPtr := PChar( tText );
  PatternPtr := PChar( tMatchText );
  StringRes := nil;
  PatternRes := nil;

  repeat
    repeat
      case PatternPtr^ of
        #0:
            begin
            Result := StringPtr^ = #0;
            if Result or ( StringRes = nil ) or ( PatternRes = nil ) then
              Exit;

            StringPtr := StringRes;
            PatternPtr := PatternRes;
            Break;
            end;
        '*':
            begin
            Inc( PatternPtr );
            PatternRes := PatternPtr;
            Break;
            end;
        '?':
            begin
            if StringPtr^ = #0 then
              Exit;
            Inc( StringPtr );
            Inc( PatternPtr );
            end;
      else
          begin
            if StringPtr^ = #0 then
              Exit;
            if StringPtr^ <> PatternPtr^ then
              begin
              if ( StringRes = nil ) or ( PatternRes = nil ) then
                Exit;
              StringPtr := StringRes;
              PatternPtr := PatternRes;
              Break;
              end
            else
              begin
              Inc( StringPtr );
              Inc( PatternPtr );
              end;
          end;
      end;
    until False;

    repeat
      case PatternPtr^ of
        #0:
            begin
            Result := True;
            Exit;
            end;
        '*':
            begin
            Inc( PatternPtr );
            PatternRes := PatternPtr;
            end;
        '?':
            begin
            if StringPtr^ = #0 then
              Exit;
            Inc( StringPtr );
            Inc( PatternPtr );
            end;
      else
            begin
            repeat
              if StringPtr^ = #0 then
                Exit;
              if StringPtr^ = PatternPtr^ then
                Break;
              Inc( StringPtr );
            until False;
            Inc( StringPtr );
            StringRes := StringPtr;
            Inc( PatternPtr );
            Break;
            end;
      end;
    until False;
  until False;
end;
{
uses Masks

function IsWM( const S,Wildcard: String ): Boolean;
var
  Mask: TMask;
begin
  Mask := TMask.Create( Wildcard );
  Result := Mask.Matches( S );
  Mask.Free;
end;
}

function Remove( Text, RText: string; WildCard : Boolean = false; caseSensitive : boolean = false ):string;
begin
  Result := Replace( Text, RText, '', WildCard, caseSensitive );
end;

function Replace( text, mText, rText : string; WildCard : Boolean = false; caseSensitive : boolean = false ): string;
var
 start,
 endN : integer;
begin
  result := text;
  if ( text = '' ) or ( mText = '' ) then
   Exit;

  if WildCard then
    begin
    if NOT IsWm( Text, '*'+mText+'*', caseSensitive ) then
      Exit;
    if ( ReturnWildCardPositionInString( text, mText, start, endN, caseSensitive ) ) then
      result := copy( text, 0, Max( start-1,0 ) ) + rText + copy( text, endN, length( text )-endN+1 );
    end
  else
    begin
    if ( caseSensitive ) then
      Result := StringReplace( Text, mText, rText, [ rfReplaceAll ] )
    else
      Result := StringReplace( Text, mText, rText, [ rfReplaceAll, rfIgnoreCase ] );
    end;
end;

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
    Result := AnsiUpperCase( AChar )[ 1 ];
  end;

  // helper function to imitate zero-terminated strings
  function GetCharAt( const AStr: string; const APos: integer ): char;
  begin
    if ( APos > 0 ) and ( APos <= length( AStr ) ) then begin
      Result := AStr[ APos ];
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

function ConvertTabsToSpaces( text : string; value : Byte ): string;
begin
  result := text;
  if ( text = '' ) then
    Exit;
  result := Replace( text , #9, DupeString( ' ', value ) );
end;

function ConvertSpacesToTabs( text : string; value : Byte ): string;
begin
  result := text;
  if ( text = '' ) then
    Exit;
  result := Replace( text , DupeString( ' ', value ), #9 );
end;

function RemoveTabsAndSpaces( text : string ): string;
begin
  result := Replace( text, #9, #32 );
  while ( Replace( result, '  ', ' ' ) <> result ) do
   result := Replace( result, '  ', ' ' );
end;

function StringToStringList( text : string ): TStringList;
begin
  result := TStringList.Create;
  result.Text := text;
end;

function StringToStrings( text : string ): TStrings;
begin
  result := TStrings.Create;
  result.Text := text;
end;

{$IFNDEF UNICODE}
{$IFDEF USE_UNICODE}
function StringToStrings( text : WideString ): TWideStrings;
begin
  result := TWideStringList.Create;
  result.Text := text;
end;
{$ENDIF}

{$IFDEF USE_SYNUNICODE}
function StringToStrings( text : UnicodeString ): TUnicodeStrings;
begin
  result := TUnicodeStringList.Create;
  result.Text := text;
end;
{$ENDIF}
{$ENDIF}

function TrimLineAfter( str : string; Value : Byte ): string;
begin
  result := LeftStr( str, Value );
end;

function TrimLineFromLeft( str : string; Value : Byte ): string;
begin
  result := RightStr( str, Length( str )-Value );
end;

function TrimLineFromRight( str : string; Value : Byte ): string;
begin
  result := LeftStr( str, Length( str )-Value );
end;

function RemoveSpacesFromLineStart( str : string ): string;
begin
  result := str;
  while ( LeftStr( result, 1 ) = ' ' ) do
    result := RightStr( result, Length( result )-1 );
end;

function RemoveSpacesFromLineEnd( str : string ): string;
begin
  result := str;
  while ( RightStr( result, 1 ) = ' ' ) do
    result := LeftStr( result, Length( result )-1 );
end;

function ReturnWildCardPositionInString( Text, WildCard : string; var start, endN : integer; caseSensitive : boolean = false ): boolean;
begin
  result := false;
  if ( text = '' ) or ( WildCard = '' ) then
   Exit;

  start := 0;
  if ( LeftStr( WildCard, 1 ) <> '*' ) then
    begin
    if ( RightStr( WildCard, 1 ) <> '*' ) AND ( Isin( WildCard,'*' ) ) then
      begin
      start := 0;
      while ( copy( WildCard, start, 1 ) <> '*' ) and ( start <= Length( WildCard ) ) do
        inc( start );

      start := pos( LeftStr( WildCard, start-1 ), text );
      while ( NOT ( IsWm( copy( text, start, length( text )-start ), WildCard, caseSensitive ) ) ) AND ( start < Length( text ) ) do
        begin
        endN := 0;
        while ( NOT IsWm( copy( text, start, endN ), WildCard, caseSensitive ) ) AND ( endN <= length( text ) ) do
          inc( endN );

        if ( endN <> length( text ) ) then
          begin
          endN := endN+start;
          result := true;
          exit;
          end;
        inc( start );
        end;
      end
    else
      while ( NOT ( IsWm( copy( text, start, length( WildCard ) ), WildCard, caseSensitive ) ) ) AND ( start < Length( text ) ) do
       inc( start );
    end;

  if ( start = length( text ) ) then
    begin
    start := 0;
    endN := length( text );
    result := false;
    Exit;
    end;

  endN := length( text );
  if ( RightStr( WildCard, 1 ) <> '*' ) then
    while ( NOT ( IsWm( copy( text, start, endN ), WildCard, caseSensitive ) ) ) AND ( endN >= 0 ) do
     dec( endN );

  if ( endN <> 0 ) then
    begin
    endN := endN+start;
    result := true;
    end
  else
    begin
    endN := length( text );
    result := false;
    end;
end;

function WildcardToRegEx( Wildcard : string ): string;
var
  i : integer;
begin
  result := '^';
  for i := 0 to Length( Wildcard )-1 do
    begin
    if ( Wildcard[ i ] = '*' ) then
      result := result + '.*'
    else if ( Wildcard[ i ] = '?' ) then
      result := result + '.'
    // escape special regexp-characters
    else if ( ( Wildcard[ i ] = '( ' ) or ( Wildcard[ i ] = ' )' ) or ( Wildcard[ i ] = '[ ' ) or ( Wildcard[ i ] = ' ]' ) or
             ( Wildcard[ i ] = '{' ) or ( Wildcard[ i ] = '}' ) or ( Wildcard[ i ] = '$' ) or ( Wildcard[ i ] = '^' ) or
             ( Wildcard[ i ] = '.' ) or ( Wildcard[ i ] = '|' ) or ( Wildcard[ i ] = '\\' ) ) then
      result := result + '\\' + Wildcard[ i ]
    else
      result := result + Wildcard[ i ];
    end;
  result := result + '$';
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function IsIPv4( IP : string ): boolean;
var
  Par: TStringDynArray;
begin
  result := false;
  Par := Tokenize( IP, '.' );
  if length( Par ) = 4 then
    result := IsNumIn( Par[ 0 ], 0, 255 ) and IsNumIn( Par[ 1 ], 0, 255 ) and IsNumIn( Par[ 2 ], 0, 255 ) and IsNumIn( Par[ 3 ], 0, 255 );
end;

function IPToNum( IP: string ): string;
var
  Par: TStringDynArray;
begin
  Par := Tokenize( IP, '.' );
  if length( Par ) = 5 then
    begin
     if IsNum( Par[ 1 ] ) and IsNum( Par[ 2 ] ) and IsNum( Par[ 3 ] ) and IsNum( Par[ 4 ] ) then
       Result := IntToStr( 256 * 256 * 256 * StrToInt( Par[ 1 ] ) + 256 * 256 * StrToInt( Par[ 2 ] ) + 256 * StrToInt( Par[ 3 ] ) + StrToInt( Par[ 4 ] ) )
     else
       Result := IP;
    end
  else
       Result := IP;
end;

function NumToIP( Num: string ): string;
var
  N, I1, I2, I3, I4: Int64;
begin
  if IsNum( Num ) then
  begin
    N := StrToInt64( Num );
    I1 := N div ( 256 * 256 * 256 );
    I2 := ( N - I1 * 256 * 256 * 256 ) div ( 256 * 256 );
    I3 := ( N - I1 * 256 * 256 * 256 - I2 * 256 * 256 ) div 256;
    I4 := N - I1 * 256 * 256 * 256 - I2 * 256 * 256 - I3 * 256;
    Result := Format( '%d.%d.%d.%d', [ I1, I2, I3, I4 ] );
  end
  else
  begin
    Result := Num;
  end;
end;

function Integer_To_Roman( number: integer ): String;
begin
  result := '';
  while ( number > 0 ) do
    begin
      if ( number >= 1000 ) then
        begin
        result := result + 'M';
        dec( number,1000 );
        end
      else if ( number >= 500 ) then
        begin
        result := result + 'D';
        dec( number,500 );
        end
      else if ( number >= 100 ) then
        begin
        result := result + 'C';
        dec( number,100 );
        end
      else if ( number >= 50 ) then
        begin
        result := result + 'L';
        dec( number,50 );
        end
      else if ( number >= 10 ) then
        begin
        result := result + 'X';
        dec( number,10 );
        end
      else if ( number >= 5 ) then
        begin
        result := result + 'V';
        dec( number,5 );
        end
      else if ( number = 4 ) then
        begin
        result := result + 'IV';
        dec( number,4 );
        end
      else if ( number >= 1 ) then
        begin
        result := result + 'I';
        dec( number,1 );
        end
      else
        begin
        result := 'error';
        number := 0;
        end;
    end;
end;

function Roman_To_Integer( Roman: String ): Integer;
  function Decode_Roman_Digit( A_Char: Char ): Integer;
    begin
    result := 0;
    if ( LowerCase( A_Char ) = 'm' ) then
      result := 1000
    else if ( LowerCase( A_Char ) = 'd' ) then
      result := 500
    else if ( LowerCase( A_Char ) = 'c' ) then
      result := 100
    else if ( LowerCase( A_Char ) = 'l' ) then
      result := 50
    else if ( LowerCase( A_Char ) = 'x' ) then
      result := 10
    else if ( LowerCase( A_Char ) = 'v' ) then
      result := 5
    else if ( LowerCase( A_Char ) = 'i' ) then
      result := 1;
    end;
var
  i, Curr_Val, Last_Val : Integer;
begin
  Result := 0;
  Last_Val := 0;

  for i := Length( Roman ) downto 0 do
     begin
     Curr_Val := Decode_Roman_Digit( Roman[ i ] );
     if Curr_Val < Last_Val then
        Result := Result - Curr_Val
     else
        Result := Result + Curr_Val;
     Last_Val := Curr_Val;
     end
end;

function StrToFloat_Int( pText : string; default : Extended = 0 ): Extended;
const
  EUROPEAN_ST = ',';
  AMERICAN_ST = '.';
var
  lformatSettings : TFormatSettings;
  i               : Byte;
  IsAmerican      : Boolean;
  IsEuropean      : Boolean;
begin
  IsAmerican := False;
  IsEuropean := False;

  for i := {$IF CompilerVersion >= 24}High( pText ){$ELSE}Length( pText ){$IFEND} downTo {$IF CompilerVersion >= 24}Low( pText ){$ELSE}1{$IFEND} do
    begin
    if ( pText[ i ] = AMERICAN_ST ) then
      begin
      IsAmerican := True;
      pText := StringReplace( pText, ',', '', [ rfIgnoreCase, rfReplaceAll ] );  //get rid of thousand incidental separators
      Break;
      end
    else if ( pText[ i ] = EUROPEAN_ST ) then
      begin
      IsEuropean := True;
      pText := StringReplace( pText, '.', '', [ rfIgnoreCase, rfReplaceAll ] );  //get rid of thousand incidental separators
      Break;
      end;
    end;

  {$IF CompilerVersion >= 30}
  {$WARN SYMBOL_PLATFORM OFF}
  lformatSettings := TFormatSettings.Create( LOCALE_SYSTEM_DEFAULT );
  {$WARN SYMBOL_PLATFORM ON}
  {$ELSE}
  GetLocaleFormatSettings( LOCALE_SYSTEM_DEFAULT, lformatSettings );
  {$IFEND}

  if ( lformatSettings.DecimalSeparator = EUROPEAN_ST ) AND IsAmerican then
    pText := StringReplace( pText, '.', ',', [ rfIgnoreCase, rfReplaceAll ] )
  else if ( lformatSettings.DecimalSeparator = AMERICAN_ST ) AND IsEuropean then
    pText := StringReplace( pText, ',', '.', [ rfIgnoreCase, rfReplaceAll ] );

  Result := StrToFloatDef( pText, default, lformatSettings );
end;

function StrToDate_Int( value : string; changeMonthAndDay : boolean = false ): TDate;
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  function ExchangeMonthAndDay ( value: string; Seperator : Char ) : string;
    begin
    result := value;
    if ( Seperator = '' ) OR ( NumTok( Value, Seperator ) <> 3 ) then
      Exit;

    if ( changeMonthAndDay ) OR ( ( StrToIntDef( GetTok( Value, 1, Seperator ), 0 ) > 12 ) AND ( IsWm( GetTok( Replace( {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}ShortDateFormat, '/', '.' ), 1, '.' ), '*M*' ) ) ) or
                                ( ( StrToIntDef( GetTok( Value, 2, Seperator ), 0 ) > 12 ) AND ( IsWm( GetTok( Replace( {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}ShortDateFormat, '/', '.' ), 2, '.' ), '*M*' ) ) ) then
      begin
      result := PutTok( Value, GetTok( Value, 2, Seperator ), 1, Seperator );
      result := PutTok( result, GetTok( Value, 1, Seperator ), 2, Seperator );
      end;
    end;
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if ( {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}DateSeparator = '/' ) then //Eng
    result := StrToDate( ExchangeMonthAndDay( Replace( value, '.', {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}DateSeparator ), {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}DateSeparator ) )
  else if ( {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}DateSeparator = '-' ) then //Swe
    result := StrToDate( ExchangeMonthAndDay( Replace( value, '.', {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}DateSeparator ), {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}DateSeparator ) )
  else//if DateSeperator = '.' then //Ger
    result := StrToDate( ExchangeMonthAndDay( Replace( value, '/', {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}DateSeparator ), {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}DateSeparator ) );
end;

function GetCurrencyValue( S : string ) : extended;
begin
  while POS( {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}Currencystring, S ) > 0 do // Remove any currency symbols, ie £, $ etc.
    Delete( S, POS( {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}Currencystring, S ), LENGTH( {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}Currencystring ) );
  while POS( {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}ThousandSeparator, S ) > 0 do // Delete all ThousandSeparator's
    Delete( S, POS( {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}ThousandSeparator, S ), 1 );
  if ( S = '.' ) OR ( S = '-' ) OR ( S = '-.' ) OR ( S = '' ) then // if nothing left, then make it 0
    S := '0';
  GetCurrencyValue := StrToFloat( S )
end;

function CountCharInString( c: char; s: string ):integer;
var i : integer;
begin
  result := 0;
  for i := {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} to {$IF CompilerVersion >= 24}High( s ){$ELSE}Length( s ){$IFEND} do
    begin
    if s[ i ] = c then
      Inc( result );
    end;
end;

function CountSubStringInString( const Text: string; const SubText: string ) : Cardinal;
begin
  Result := Pos( SubText, Text );
  if Result > 0 then
    Result := ( Length( Text ) - Length( StringReplace( Text, SubText, '', [ rfReplaceAll ] ) ) ) div  Length( subtext );
end;

function ScanFile( const FileName: string; const forString: string; caseSensitive: Boolean = false ): Longint;
const
  BufferSize = $8001;  { 32K+1 bytes }
var
  pBuf, pEnd, pScan, pPos: PChar;
  filesize: LongInt;
  bytesRemaining: LongInt;
  bytesToRead: Integer;
  F: file;
  SearchFor: PChar;
  oldMode: Word;
begin
  { assume failure }
  Result := -1;
  if ( Length( forString ) = 0 ) or ( Length( FileName ) = 0 ) then
    Exit;
  SearchFor := nil;
  pBuf      := nil;
  { open file as binary, 1 byte recordsize }
  AssignFile( F, FileName );
  oldMode  := FileMode;
  FileMode := 0;    { read-only access }
  Reset( F, 1 );
  FileMode := oldMode;
  try { allocate memory for buffer and PAnsiChar search string }
    SearchFor := StrAlloc( Length( forString ) + 1 );
    if not caseSensitive then  { convert to upper case }
      StrPCopy( SearchFor, UpperCase( forString ) )
    else
      StrPCopy( SearchFor, forString );
    GetMem( pBuf, BufferSize );
    filesize       := System.Filesize( F );
    bytesRemaining := filesize;
    pPos           := nil;
    while bytesRemaining > 0 do
      begin
      { calc how many bytes to read this round }
      if bytesRemaining >= BufferSize then
        bytesToRead := Pred( BufferSize )
      else
        bytesToRead := bytesRemaining;
      { read a buffer full and zero-terminate the buffer }
      BlockRead( F, pBuf^, bytesToRead, bytesToRead );
      pEnd  := @pBuf[ bytesToRead ];
      pEnd^ := #0;
      pScan := pBuf;
      while pScan < pEnd do
        begin
        pPos := StrPos( pScan, SearchFor );  { search for substring }
        if pPos <> nil then
        begin
          Result := FileSize - bytesRemaining +
            Longint( pPos ) - Longint( pBuf );
          Break;
        end;
        pScan := StrEnd( pScan );
        Inc( pScan, SizeOf( Char ) );
        end;
      if pPos <> nil then
        Break;
      bytesRemaining := bytesRemaining - bytesToRead;
      if bytesRemaining > 0 then
        begin
        Seek( F, FilePos( F ) - Length( forString )*SizeOf( Char ) );
        bytesRemaining := bytesRemaining + Length( forString )*SizeOf( Char );
        end;
      end;
  finally
    CloseFile( F );
    if SearchFor <> nil then StrDispose( SearchFor );
    if pBuf <> nil then FreeMem( pBuf, BufferSize );
  end;
end;

function GetCharFromVirtualKey( Key: Word ): String;
var
  keyboardState : TKeyboardState;
  asciiResult : Integer;
begin
  GetKeyboardState( keyboardState ) ;

  SetLength( Result, 2 ) ;
  asciiResult := ToAscii( key, MapVirtualKey( key, 0 ), keyboardState, @Result[ 1 ], 0 ) ;
  case asciiResult of
    0: Result := '';
    1: SetLength( Result, 1 );
    2:;
  else
      Result := '';
  end;
end;

function RandomString( const Len: Byte = 16 ): string;
var
  i : Integer;
begin
  SetLength( Result, Len );
  for i := 1 to len DO
    begin
    case RandomRange( 0, 2 ) of
      0 : Result[ i ] := Chr( ord( 'a' ) + RandomRange( 0, 26 ) );
      1 : Result[ i ] := Chr( ord( 'A' ) + RandomRange( 0, 26 ) );
    else
      Result[ i ] := Chr( ord( '0' ) + RandomRange( 0, 10 ) );
    end;
    end;
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function CompareVersion( v1, v2 : string; vMode : tCompareVersionMode = cvmAboveOrEqual ) : boolean;
var
  Tok1,
  Tok2     : Byte;
  tPos,
  tPosOld  : Integer;
  Token1,
  Token2   : Array of Word;
begin
  result := False;
  if ( v1 = '' ) OR ( v2 = '' ) then
    Exit;

//  if ( v1 = '' ) then
//    v1 := '0';
//  if ( v2 = '' ) then
//    v2 := '0';

  v1 := StringReplace( v1, ',', '.', [ rfReplaceAll ] );
  v2 := StringReplace( v2, ',', '.', [ rfReplaceAll ] );
  v1 := StringReplace( v1, ' ', '', [ rfReplaceAll ] );
  v2 := StringReplace( v2, ' ', '', [ rfReplaceAll ] );

  Tok1 := 1;
  tPos := PosEx( '.', v1, 1 );
  while ( tPos <> 0 ) do
    begin
    tPos := PosEx( '.', v1, tPos+1 );
    Inc( Tok1 );
    end;

  Tok2 := 1;
  tPos := PosEx( '.', v2, 1 );
  while ( tPos <> 0 ) do
    begin
    tPos := PosEx( '.', v2, tPos+1 );
    Inc( Tok2 );
    end;

  if ( Tok1 > Tok2 ) then
    v2 := v2 + DupeString( '.0', Tok1-Tok2 )
  else if ( Tok2 > Tok1 ) then
    v1 := v1 + DupeString( '.0', Tok2-Tok1 );

  Tok1 := Max( Tok1, Tok2 );
  SetLength( Token1, Tok1 );
  SetLength( Token2, Tok1 );

  tPos    := PosEx( '.', v1, 1 );
  tPosOld := 0;
  Tok2    := 0;
  while ( tPos <> 0 ) do
    begin
    Token1[ Tok2 ] := StrToIntDef( RightStr( LeftStr( v1, tPos-1 ), tPos-tPosOld-1 ), 0 );
    tPosOld := tPos;
    tPos := PosEx( '.', v1, tPos+1 );
    Inc( Tok2 );
    end;
  Token1[ Tok2 ] := StrToIntDef( RightStr( v1, Length( v1 )-tPosOld ), 0 );

  tPos    := PosEx( '.', v2, 1 );
  tPosOld := 0;
  Tok2    := 0;
  while ( tPos <> 0 ) do
    begin
    Token2[ Tok2 ] := StrToIntDef( RightStr( LeftStr( v2, tPos-1 ), tPos-tPosOld-1 ), 0 );
    tPosOld := tPos;
    tPos := PosEx( '.', v2, tPos+1 );
    Inc( Tok2 );
    end;
  Token2[ Tok2 ] := StrToIntDef( RightStr( v2, Length( v2 )-tPosOld ), 0 );

  v1 := '';
  v2 := '';
  for tPos := Low( Token1 ) to High( Token1 ) do
    begin
    tPosOld := Max( Length( IntToStr( Token1[ tPos ] ) ), Length( IntToStr( Token2[ tPos ] ) ) );
    v1 := Format( '%s%s%.' + IntToStr( tPosOld ) + 'd', [ v1, IfThen( tPos <> Low( Token1 ), '.', '' ), Token1[ tPos ] ] );
    v2 := Format( '%s%s%.' + IntToStr( tPosOld ) + 'd', [ v2, IfThen( tPos <> Low( Token1 ), '.', '' ), Token2[ tPos ] ] );
    end;
  SetLength( Token1, 0 );
  SetLength( Token2, 0 );

  case vMode of
    cvmEqual        : result := Variant( v1 ) =  Variant( v2 );
    cvmUnequal      : result := Variant( v1 ) <> Variant( v2 );
    cvmAbove        : result := Variant( v1 ) >  Variant( v2 );
    cvmBelow        : result := Variant( v1 ) <  Variant( v2 );
    cvmAboveOrEqual : result := Variant( v1 ) >= Variant( v2 );
    cvmBelowOrEqual : result := Variant( v1 ) <= Variant( v2 );
  else
    Exit;
  end;
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function HexToByte( sHex : string ) : Byte;
const
  HexTable : Array[ 0..15 ] of Char = ( '0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F' );
var
  i : integer;
  A, B : SmallInt;
begin
  result := 0;
  if ( sHex = '' ) then
    Exit;
  if ( LeftStr( sHex, 1 ) = '$' ) then
    sHex := RightStr( sHex, Length( sHex )-1 )
  else if ( LeftStr( sHex, 2 ) = '0x' ) then
    sHex := RightStr( sHex, Length( sHex )-2 );
  if Odd( Length( sHex ) ) then
    sHex := '0' + sHex;
  sHex := UpperCase( sHex );

  A := -1;
  B := -1;
  for i := Low( HexTable ) to High( HexTable ) do
    begin
    if ( HexTable[ i ] = sHex[ {$IF CompilerVersion >= 24}Low( sHex ){$ELSE}1{$IFEND} ] ) then
      A := 16 * i;
    if ( HexTable[ i ] = sHex[ {$IF CompilerVersion >= 24}Low( sHex ){$ELSE}1{$IFEND}+1 ] ) then
      B := i;
    end;
  if ( A < 0 ) or ( B < 0 ) then
    Exit;

  result := A + B;
end;

function ByteToHex( B : Byte ) : ShortString;
const
  HexTable : Array[ 0..15 ] of AnsiChar = ( '0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F' );
begin
  result := HexTable[ b div 16 ] + HexTable[ b mod 16 ];
end;

function StrToHex( sHex: string ): string;
begin
  {$IFDEF UNICODE}
  result := HexToStrW( sHex );
  {$ELSE}
  result := HexToStrA( sHex );
  {$ENDIF}
end;

function StrToHexA( sHex: AnsiString ): string;
var
  i   : Integer;
begin
  Result := '';
  for i := {$IF CompilerVersion >= 24}Low( sHex ){$ELSE}1{$IFEND} to {$IF CompilerVersion >= 24}High( sHex ){$ELSE}Length( sHex ){$IFEND} do
    Result := Result + ByteToHex( Byte( sHex[ I ] ) );

  i := Pos( ' ', Result );
  while ( i <> 0 ) do
    begin
    Result[ I ] := '0';
    i := Pos( ' ', Result );
    end;
end;

function StrToHexW( sHex: WideString ): string;
var
  i  : Integer;
  c  : WideChar;
  Bytes : Array [ 0..1 ] of Byte absolute c;
begin
  Result := '';
  for i := {$IF CompilerVersion >= 24}Low( sHex ){$ELSE}1{$IFEND} to {$IF CompilerVersion >= 24}High( sHex ){$ELSE}Length( sHex ){$IFEND} do
    begin
    c := sHex[ i ];
    result := result + ByteToHex( Bytes[ 0 ] ) + ByteToHex( Bytes[ 1 ] );
    end;

  i := Pos( ' ', Result );
  while ( i <> 0 ) do
    begin
    Result[ I ] := '0';
    i := Pos( ' ', Result );
    end;
end;

function HexToStrA( sHex: String ): AnsiString;
var
  i : Integer;
  s : AnsiString;
begin
  Result := '';

  if ( LeftStr( sHex, 1 ) = '$' ) then
    sHex := RightStr( sHex, Length( sHex )-1 )
  else if ( LeftStr( sHex, 2 ) = '0x' ) then
    sHex := RightStr( sHex, Length( sHex )-2 );

  if Odd( Length( sHex ) ) then
    sHex := '0' + sHex;
  if NOT IsHex( sHex ) then
    Exit;

  s := AnsiString( sHex );
  i := {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND};
  while ( i < {$IF CompilerVersion >= 24}High( s ){$ELSE}Length( s ){$IFEND} ) do
    begin
    Result := Result + AnsiChar( HexToByte( s[ i ] + s[ i+1 ] ) );
    Inc( i, 2 );
    end;
end;

function HexToStrW( sHex: String ): WideString;
var
  i : Integer;
  c : WideChar;
  Bytes : Array [ 0..1 ] of Byte absolute C;
  s : AnsiString;
begin
  Result := '';
  if NOT IsHex( sHex ) then
    Exit;
  sHex := ProperHex( sHex );

  s := AnsiString( sHex );
  i := {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND};
  while ( i < {$IF CompilerVersion >= 24}High( s ){$ELSE}Length( s ){$IFEND} ) do
    begin
    Bytes[ 0 ] := HexToByte( s[ i ] + s[ i+1 ] );
    Bytes[ 1 ] := HexToByte( s[ i+2 ] + s[ i+3 ] );

    Inc( i, 4 );
    Result := Result + c;
    end;
end;

function HexToInt( sHex : string ): Int64;
begin
  sHex := ProperHex( sHex );
  result := StrToInt64Def( '$' + sHex, 0 );
end;

{$IF CompilerVersion < 23}{$RANGECHECKS OFF}{$IFEND} // RangeCheck might cause Internal-Error C1118
function HexToUInt( sHex : string; BigEndian : boolean = false ): UInt64;
begin
  sHex := ProperHex( sHex );
  if NOT HexToPointer( sHex, @result, SizeOf( result ), BigEndian ) then
    result := 0;
end;
{$IF CompilerVersion < 23}{$RANGECHECKS ON}{$IFEND}

function HexToTypedStr( sHex : string; vType : tHexToTypedStrTypes; BigEndian : boolean = false ) : String;
  function IncSecond( const AValue: TDateTime; // DateUtils
    const ANumberOfSeconds: Int64 ): TDateTime;
  begin
    Result := ( ( AValue * SecsPerDay ) + ANumberOfSeconds ) / SecsPerDay;
  end;
const
  LARGEST_TYPE = 10;
var
  Bytes   : Array [ 0..LARGEST_TYPE-1 ] of Byte;
  ByteCnt : Byte;
  i1      : Integer;

  SH      : ShortInt absolute Bytes;
  SM      : SmallInt absolute Bytes;
  i       : Integer  absolute Bytes;
  i64     : Int64    absolute Bytes;
  ui      : UInt64   absolute Bytes;

  r48     : Real48   absolute Bytes;
  r       : Real     absolute Bytes;
  si      : Single   absolute Bytes;
  d       : Double   absolute Bytes;
  e       : Extended absolute Bytes;
  co      : Comp     absolute Bytes;
  cu      : Currency absolute Bytes;

  s       : AnsiString;
  ws      : WideString;
  wc      : WideChar;
  wcb     : Array [ 0..1 ] of Byte absolute wc;
begin
  result := '';
  if ( sHex = '' ) then
    Exit;

  sHex := ProperHex( sHex );
  if NOT IsHex( sHex ) then
    Exit;
  if Odd( Length( sHex ) ) then
    sHex := '0' + sHex;

  s := '';
  ws := '';

  ByteCnt := 0;
  case vType of
     httsByte,
     httsShortInt  : ByteCnt := 1;
     httsWord,
     httsSmallInt  : ByteCnt := 2;
     httsCardinal,
     httsInteger,
     httsSingle,
     httsCTime     : ByteCnt := 4;
     httsUINT64,
     httsInt64,
     httsDouble,
     httsComp,
     httsCurrency,
     httsDateTime  : ByteCnt := 8;
     httsReal48    : ByteCnt := 6;
     httsExtended  : ByteCnt := 10;
  end;

  if ( ByteCnt > 0 ) AND ( Length( sHex ) div 2 > ByteCnt ) then
    Exit;

  FillChar( Bytes[ 0 ], SizeOf( Bytes ), 0 );
  i1 := {$IF CompilerVersion >= 24}Low( sHex ){$ELSE}1{$IFEND};
  while ( i1 < {$IF CompilerVersion >= 24}High( sHex ){$ELSE}Length( sHex ){$IFEND} ) do
    begin
    if ( vType = httsAnsiString ) then
      s := s + AnsiChar( HexToByte( sHex[ i1 ] + sHex[ i1+1 ] ) )

    else if ( vType = httsWideString ) then
      begin
      if ( i1 > {$IF CompilerVersion >= 24}High( sHex ){$ELSE}Length( sHex ){$IFEND}-3 ) then
        break;
      wcb[ 0 ] := HexToByte( sHex[ i1 ] + sHex[ i1+1 ] );
      wcb[ 1 ] := HexToByte( sHex[ i1+2 ] + sHex[ i1+3 ] );
      Inc( i1, 2 );

      ws := ws + wc;
      end

    else if BigEndian then
      Bytes[ ( ByteCnt-1 )-( ( ( {$IF CompilerVersion >= 24}High( sHex )-Low( sHex ){$ELSE}Length( sHex )-1{$IFEND} ) div 2 )-( ( i1-{$IF CompilerVersion >= 24}Low( sHex ){$ELSE}1{$IFEND} ) div 2 ) ) ] := HexToByte( sHex[ i1 ] + sHex[ i1+1 ] )
    else
      Bytes[ ( ( {$IF CompilerVersion >= 24}High( sHex )-Low( sHex ){$ELSE}Length( sHex )-1{$IFEND} ) div 2 )-( ( i1-{$IF CompilerVersion >= 24}Low( sHex ){$ELSE}1{$IFEND} ) div 2 ) ] := HexToByte( sHex[ i1 ] + sHex[ i1+1 ] );

    Inc( i1, 2 );
    end;

  try
    case vType of
      httsByte,
      httsWord,
      httsCardinal,
      httsUINT64     : result := UIntToStr( ui );
      httsShortInt   : result := IntToStr( SH );
      httsSmallInt   : result := IntToStr( SM );
      httsInteger    : result := IntToStr( i );
      httsInt64      : result := IntToStr( i64 );
      httsReal48     : result := FloatToStr( r48 );
      httsSingle     : result := FloatToStr( si );
      httsDouble     : result := FloatToStr( d );
      httsExtended   : result := FloatToStr( e );
      httsComp       : result := FloatToStr( co );
      httsCurrency   : result := FloatToStr( cu );
      httsDateTime   : result := FormatDateTime( {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}ShortDateFormat + ' ' + {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}LongTimeFormat + {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}DecimalSeparator+'zzz', d ); // DateTimeToStr( d );
      httsCTime      : result := FormatDateTime( {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}ShortDateFormat + ' ' + {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}LongTimeFormat + {$IF CompilerVersion >= 30}FormatSettings.{$ELSE}SysUtils.{$IFEND}DecimalSeparator+'zzz', IncSecond( EncodeDate( 1970, 1, 1 ), ui ){CTimeToDateTime( ui )} ); // DateTimeToStr( IncSecond( EncodeDate( 1970, 1, 1 ), ui ){CTimeToDateTime( ui )} );
      httsAnsiString : result := s;
      httsWideString : result := ws;
    end;
  except
  end;
end;

function TypedStrToHex( s : string; vType : tHexToTypedStrTypes; BigEndian : boolean = false ) : string;
  function SecondsBetween_( ANow, AThen : TDateTime ) : Int64; // DateUtils
  begin
    Result := Trunc( SecsPerDay * ifThen( ANow < AThen, AThen - ANow, ANow - AThen ) );
  end;
var
  ByteCnt : Byte;
  s2      : string;
  i64     : Int64;
  ui      : UInt64;
  r48     : Real48;
  si      : Single;
  d       : Double;
  e       : Extended;
  co      : Comp;
  cu      : Currency;
begin
  result := '';
  if ( s = '' ) then
    Exit;

  ByteCnt := 0;
  case vType of
     httsByte,
     httsShortInt  : ByteCnt := 1;
     httsWord,
     httsSmallInt  : ByteCnt := 2;
     httsCardinal,
     httsInteger,
     httsSingle,
     httsCTime     : ByteCnt := 4;
     httsUINT64,
     httsInt64,
     httsDouble,
     httsComp,
     httsCurrency,
     httsDateTime  : ByteCnt := 8;
     httsReal48    : ByteCnt := 6;
     httsExtended  : ByteCnt := 10;
  end;

  try
    case vType of
        {$IF CompilerVersion < 23}{$RANGECHECKS OFF}{$IFEND} // RangeCheck might cause Internal-Error C1118
        httsByte,
        httsWord,
        httsCardinal,
        httsUINT64 : begin
                     if NOT IsNum( s, false ) then
                       Exit;
                     ui := StrToUInt64Def( s, 0 );
                     case vType of
                       httsByte     : if ( ui > High( Byte ) ) then Exit;
                       httsWord     : if ( ui > High( Word ) ) then Exit;
                       httsCardinal : if ( ui > High( Cardinal ) ) then Exit;
  //                     httsUINT64 : if ( ui > High( UInt64 ) ) then Exit;
                     end;
                     result := RightStr( IntToHex( ui, SizeOf( UInt64 )*2 ), ByteCnt*2 );
                     end;
        {$IF CompilerVersion < 23}{$RANGECHECKS ON}{$IFEND}
        httsShortInt,
        httsSmallInt,
        httsInteger,
        httsInt64  : begin
                     if NOT IsNum( s, True ) then
                       Exit;
                     i64 := StrToInt64Def( s, 0 );
                     case vType of
                       httsShortInt : if ( i64 < Low( ShortInt ) ) OR ( i64 > High( ShortInt ) ) then Exit;
                       httsSmallInt : if ( i64 < Low( SmallInt ) ) OR ( i64 > High( SmallInt ) ) then Exit;
                       httsInteger  : if ( i64 < Low( Integer ) ) OR ( i64 > High( Integer ) ) then Exit;
  //                     httsInt64 : if ( i64 < Low( Int64 ) ) OR ( i64 > High( Int64 ) ) then Exit;
                     end;
                     result := RightStr( IntToHex( i64, SizeOf( Int64 )*2 ), ByteCnt*2 );
                     end;
        httsReal48 : begin
                     r48 := StrToFloatDef( s, MinSingle );
                     if ( r48 = MinSingle ) then
                       Exit;
                     result := PointerToHex( @r48, SizeOf( r48 ) );
                     end;
        httsSingle : begin
                     si := StrToFloatDef( s, MinSingle );
                     if ( si = MinSingle ) then
                       Exit;
                     result := PointerToHex( @si, SizeOf( si ) );
                     end;
        httsDouble : begin
                     d := StrToFloatDef( s, MinDouble );
                     if ( d = MinDouble ) then
                       Exit;
                     result := PointerToHex( @d, SizeOf( d ) );
                     end;
      httsExtended : begin
                     e := StrToFloatDef( s, MinExtended );
                     if ( e = MinExtended ) then
                       Exit;
                     result := PointerToHex( @e, SizeOf( e ) );
                     end;
          httsComp : begin
                     co := StrToFloatDef( s, MinComp );
                     if ( co = MinComp ) then
                       Exit;
                     result := PointerToHex( @co, SizeOf( co ) );
                     end;
      httsCurrency : begin
                     cu := StrToFloatDef( s, MinCurrency );
                     if ( cu = MinCurrency ) then
                       Exit;
                     result := PointerToHex( @cu, SizeOf( cu ) );
                     end;
      httsDateTime : begin
                     d := StrToDateTimeDef( s, MinDateTime );
                     if ( d = MinDateTime ) then
                       Exit;
                     result := PointerToHex( @d, SizeOf( d ) );
                     end;
         httsCTime : begin
                     d := StrToDateTimeDef( s, MinDateTime );
                     if ( d = MinDateTime ) then
                       Exit;

                     {$IF CompilerVersion < 23}{$RANGECHECKS OFF}{$IFEND} // RangeCheck might cause Internal-Error C1118
                     ui := SecondsBetween_( d, EncodeDate( 1970, 1, 1 ) ){DateTimeToCTime( d )};
                     if ( ui > High( Cardinal ) ) then
                       Exit;
                     result := RightStr( IntToHex( ui, SizeOf( UInt64 )*2 ), ByteCnt*2 );
                     {$IF CompilerVersion < 23}{$RANGECHECKS ON}{$IFEND} // RangeCheck might cause Internal-Error C1118
                     end;
    httsAnsiString : result := StrToHexA( AnsiString( S ) );
    httsWideString : result := StrToHexW( s );
    else
      Exit;
    end;
  except
    Exit;
  end;

  if BigEndian then
    begin
    s2 := '';

    while ( result <> '' ) do
      begin
      s2 := s2 + RightStr( result, 2 );
      result := LeftStr( result, Length( result )-2 );
      end;
    result := s2;
    end;
end;

function HexToByteString( sHex : string; SeperatorChar : Char = #32 ) : string;
var
  i : Integer;
begin
  result := '';
  if ( sHex = '' ) then
    Exit;
  if NOT IsHex( sHex ) then
    Exit;
  sHex := ProperHex( sHex );

  i := {$IF CompilerVersion >= 24}Low( sHex ){$ELSE}1{$IFEND};
  while ( i < {$IF CompilerVersion >= 24}High( sHex ){$ELSE}Length( sHex ){$IFEND} ) do
    begin
    if ( result <> '' ) then
      result := result + SeperatorChar + IntToStr( HexToByte( sHex[ i ] + sHex[ i+1 ] ) )
    else
      result := IntToStr( HexToByte( sHex[ i ] + sHex[ i+1 ] ) );
    Inc( i, 2 );
    end;
end;

function IncDecNumberChar( C : Char; Increase : Boolean = True; Hex : boolean = false ) : Char;
begin
  result := C;

  if {$IF CompilerVersion >= 22}CharInSet( C,{$ELSE}( C in{$IFEND} [ 'a'..'f' ] ) then
    C := Char( Ord( C )-32 ); // UpperCase

  if Increase then
    begin
    case C of
      '0'..'8' : result := Char( Ord( C )+1 );
           '9' : begin
                 if Hex then
                   result := 'A'
                 else
                   result := '0';
                 end;
      'a'..'e',
      'A'..'E' : begin
                 if Hex then
                   result := Char( Ord( C )+1 );
                 end;
      'f', 'F' : begin
                 if Hex then
                   result  := '0';
                 end;
    end;
    end
  else
    begin
    case C of
           '0' : begin
                 if Hex then
                   result := 'F'
                 else
                   result := '9';
                 end;
      '1'..'9' : result := Char( Ord( C )-1 );
      'A', 'a' : begin
                 if Hex then
                   result := '9';
                 end;
      'b'..'f',
      'B'..'F' : begin
                 if Hex then
                   result := Char( Ord( C )-1 );
                 end;
    end;
    end;
end;

function StrToBin( aStr: string ): string;
type
  TBitsPerChar = 1..8;
var
  iChar, iBit: Integer;
begin
  for iChar := {$IF CompilerVersion >= 24}Low( aStr ){$ELSE}1{$IFEND} to {$IF CompilerVersion >= 24}High( aStr ){$ELSE}Length( aStr ){$IFEND} do
    for iBit := High( TBitsPerChar ) downto Low( TBitsPerChar ) do
      Result := Result + IntToStr( ( Byte( aStr[ iChar ] ) shr ( iBit - 1 ) ) and 1 )[ 1 ];
end;

function BinToStr( aStr: string ): string;
var
  s        : string;
  iChar, i : Integer;
begin
  result := '';
  s := aStr;
  while ( Length( s ) > 0 ) do
    begin
    iChar := 0; //re init
    for i := 1 to 8 do
      iChar := ( iChar shl 1 ) + ord( s[ i ] ) - 48;

    result := result + Chr( iChar );
    Delete( s, 1, 8 );
    end;
end;

function IntToBin( Value: Cardinal ): string;
var
  I: Integer;
begin
  SetLength( Result, 32 );
  for I := {$IF CompilerVersion >= 24}Low( result ){$ELSE}1{$IFEND} to {$IF CompilerVersion >= 24}High( result ){$ELSE}Length( result ){$IFEND} do
    begin
    Result[ I ] := Char( Ord( '0' ) + ( Value shr 31 ) );
    Inc( Value, Value );
    end;
end;

{$IF CompilerVersion <= 23}
{$IF CompilerVersion < 23}{$RANGECHECKS OFF}{$IFEND} // RangeCheck might cause Internal-Error C1118
function StrToUInt64Def( const s: string; Default : UInt64 ): UInt64;
var
  Error: Integer;
begin
  Val( S, result, Error );
  if Error <> 0 then
    result := Default;
end;
{$IF CompilerVersion < 23}{$RANGECHECKS ON}{$IFEND}
{$IFEND}

{$IF CompilerVersion <= 23}
function UIntToStr( UInt : Cardinal ): string;
begin
  result := VarToStr( UInt );
end;

function UIntToStr( UInt : UInt64 ): string;
begin
  result := VarToStr( UInt );
end;
{$IFEND}

function IsHexChar( c : char ): boolean;
begin
  result := {$IF CompilerVersion >= 22}CharInSet( c,{$ELSE}( c in{$IFEND} [ '0'..'9' ,'a'..'f', 'A'..'F' ] );
end;

function IsHex( sHex : String ):Boolean;
var
  i : Integer;
Begin
  Result := false;
  if ( sHex = '' ) Then
    Exit;
  sHex := ProperHex( sHex );

  for i := {$IF CompilerVersion >= 24}Low( sHex ){$ELSE}1{$IFEND} to {$IF CompilerVersion >= 24}High( sHex ){$ELSE}Length( sHex ){$IFEND} do
    begin
    if NOT IsHexChar( sHex[ i ] ) then
      Exit;
    end;

  Result := true;
End;

function ProperHex( sHex : String ) : String;
begin
  result := sHex;
  result := Remove( result, ' ' );
  result := Remove( result, '-' );
  if ( LeftStr( result, 1 ) = '$' ) then
    result := RightStr( result, Length( result )-1 )
  else if ( LeftStr( result, 2 ) = '0x' ) then
    result := RightStr( result, Length( result )-2 );

  if Odd( Length( result ) ) then
    result := '0' + result;
end;

function FormatHex( sHex : String; GroupLen : Byte = 2 ) : String;
var
  i : Integer;
begin
  sHex := ProperHex( sHex );
  result := sHex;
  if ( sHex = '' ) OR ( GroupLen = 0 ) OR ( GroupLen > Length( sHex ) ) then
    Exit;

  result := '';
  i := {$IF CompilerVersion >= 24}Low( sHex ){$ELSE}1{$IFEND};
  while ( i < {$IF CompilerVersion >= 24}High( sHex ){$ELSE}Length( sHex ){$IFEND} ) do
    begin
    result := result + Copy( sHex, i, GroupLen );
    Inc( i, GroupLen );
    if ( i < {$IF CompilerVersion >= 24}High( sHex ){$ELSE}Length( sHex ){$IFEND} ) then
      result := result + '-';
    end;
end;

function TrimHex( sHex : string; BigEndian : boolean = false ) : string;
begin
  result := ProperHex( sHex );
  if BigEndian then
    while ( RightStr( result, 2 ) = '00' ) AND ( Length( result ) > 2 ) do
      result := LeftStr( result, Length( result )-2 )
  else
    while ( LeftStr( result, 2 ) = '00' ) AND ( Length( result ) > 2 ) do
      result := RightStr( result, Length( result )-2 );
end;

function HexToBinaryString( sHex : string; ByteCount : Cardinal = 0; BigEndian : Boolean = False ) : string;
var
  Bytes : Array [ 0..9 ] of Byte;
  bC    : Byte;
  biC   : Byte;
  i     : Integer;
  bCnt  : Cardinal;
begin
  result := '';
  if NOT IsHex( SHex ) then
    Exit;
  sHex := ProperHex( sHex );

  BCnt := Length( sHex ) div 2;
  FillChar( Bytes, SizeOf( Bytes ), 0 );
  if NOT HexToPointer( sHex, @Bytes, BCnt, BigEndian ) then
    Exit;

  bC := 0;
  biC := 7;
  for i := 0 to ( bCnt * 8 )-1 do
    begin
    if BigEndian then
      result := result + IntToStr( Byte( ( Bytes[ bC ] shr biC ) and $0001 ) )
    else
      result := result + IntToStr( Byte( ( Bytes[ ( BCnt-1 )-bC ] shr biC ) and $0001 ) );

    if ( biC = 0 ) then
      begin
      Inc( bC );
      biC := 7;
      end
    else
      Dec( biC );
    end;

  if ( ByteCount = 0 ) OR ( Integer( ByteCount )*8 < Length( result ) ) then
    Exit;

  if BigEndian then
    result := result + DupeString( '0', Integer( ByteCount )*8 - Length( result )  )
  else
    result := DupeString( '0', Integer( ByteCount )*8 - Length( result ) ) + result;
end;

function PointerToHex( P : Pointer; TypeSize : Byte; BigEndian : boolean = false ): string;
type
  TBytes = Array [ 0..9 ] of Byte;
  PBytes = ^TBytes;
var
  Bytes : PBytes absolute P;
  i     : Integer;
begin
  result := '';
  if ( P = nil ) then
    Exit;
  if ( TypeSize > SizeOf( TBytes ) ) then
    Exit;

  if BigEndian then
    begin
    for i := Low( Bytes^ ) To TypeSize-1 do
      result := result + ByteToHex( Bytes^[ i ] );
    end
  else
    begin
    for i := TypeSize-1 downTo Low( Bytes^ ) do
      result := result + ByteToHex( Bytes^[ i ] );
    end;

  i := Pos( ' ', Result );
  while ( i <> 0 ) do
    begin
    Result[ I ] := '0';
    i := Pos( ' ', Result );
    end;
end;

function HexToPointer( sHex : string; P : Pointer; TypeSize : Byte; BigEndian : boolean = false ) : Boolean;
type
  TBytes = Array [ 0..9 ] of Byte;
  PBytes = ^TBytes;
var
  Bytes : PBytes absolute P;
  i     : Integer;
begin
  result := False;
  if ( P = nil ) then
    Exit;
  if ( TypeSize > SizeOf( TBytes ) ) then
    Exit;

  sHex := ProperHex( sHex );
  if ( sHex = '' ) OR ( NOT IsHex( sHex ) ) then
    Exit;
  if ( Length( sHex ) > TypeSize*2 ) then
    Exit;

  FillChar( Bytes[ 0 ], TypeSize, 0 );
  i := {$IF CompilerVersion >= 24}Low( sHex ){$ELSE}1{$IFEND};
  while ( i < {$IF CompilerVersion >= 24}High( sHex ){$ELSE}Length( sHex ){$IFEND} ) do
    begin
    if BigEndian then
      Bytes[ ( TypeSize-1 )-( ( ( {$IF CompilerVersion >= 24}High( sHex )-Low( sHex ){$ELSE}Length( sHex )-1{$IFEND} ) div 2 )-( ( i-{$IF CompilerVersion >= 24}Low( sHex ){$ELSE}1{$IFEND} ) div 2 ) ) ] := HexToByte( sHex[ i ] + sHex[ i+1 ] )
    else
      Bytes[ ( ( {$IF CompilerVersion >= 24}High( sHex )-Low( sHex ){$ELSE}Length( sHex )-1{$IFEND} ) div 2 )-( ( i-{$IF CompilerVersion >= 24}Low( sHex ){$ELSE}1{$IFEND} ) div 2 ) ] := HexToByte( sHex[ i ] + sHex[ i+1 ] );

    Inc( i, 2 );
    end;

  result := True;
end;

function FloatToHex( f : real48; BigEndian : boolean = false ): string;
begin
  result := PointerToHex( @f, SizeOf( f ), BigEndian );
end;

function FloatToHex( f : single; BigEndian : boolean = false ): string;
begin
  result := PointerToHex( @f, SizeOf( f ), BigEndian );
end;

function FloatToHex( f : double; BigEndian : boolean = false ): string;
begin
  result := PointerToHex( @f, SizeOf( f ), BigEndian );
end;

function FloatToHex( f : extended; BigEndian : boolean = false ): string;
begin
  result := PointerToHex( @f, SizeOf( f ), BigEndian );
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//Checksum
var
  CRCTable_Inited : boolean = false;
  CRCTable: array[ 0..255 ] Of Cardinal;

function CRC32( const Bytes : {$IF CompilerVersion >= 30}TBytes{$ELSE}TByteDynArray{$IFEND} ): string;
type
  HiLoWord = packed record
    LoWord: Word;
    HiWord: Word;
  end;
var
//  CRCTable: array[ 0..255 ] Of Cardinal;
  CRC: Cardinal;
  i: Integer;

  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  procedure BuildCRCTable;
  const
    CRCPOLY = $EDB88320;
  var
    i, j: Word;
    r: Cardinal;
  begin
    FillChar( CRCTable, SizeOf( CRCTable ), 0 );
    {$R-}
    for i := 0 to 255 do
    begin
      r := i shl 1;
      for j := 8 downto 0 do
        if ( r and 1 ) <> 0 then
          r := ( r Shr 1 ) xor CRCPOLY
        else
          r := r shr 1;
      CRCTable[ i ] := r;
    end;
    {$R+}
  end;
  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  function HextW( w: Word ): string;
  const
    h: array[ 0..15 ] Of char = '0123456789ABCDEF';
  begin
    result := '';
    result := h[ Hi( w ) shr 4 ] + h[ Hi( w ) and $F ] + h[ Lo( w ) shr 4 ]+h[ Lo( w ) and $F ];
  end;
  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if NOT CRCTable_Inited then
    begin
    BuildCRCTable;
    CRCTable_Inited := True;
    end;
  CRC := $FFFFFFFF;
  for i := Low( Bytes ) to High( Bytes ) do
    CRC := CRCTable[ byte( CRC xor Cardinal( Bytes[ i ] ) ) ] xor ( ( CRC shr 8 ) and $00FFFFFF );

  CRC := Not CRC;
  with HiLoWord( CRC ) do
    result := {'$' + } HextW( HiWord ) + HextW( LoWord );

  Result := UpperCase( result );
end;

function CRC32( const TextOrFileName : string ) : string;
var
  B  : {$IF CompilerVersion >= 30}TBytes{$ELSE}TByteDynArray{$IFEND};
  fs : TFileStream;
  {$IFDEF UNICODE}
  S  : AnsiString;
  {$ENDIF}
begin
  result := '';
  fs     := nil;  
  if FileExists( TextOrFileName ) then
    begin
    try
      fs := TFileStream.Create( TextOrFileName, fmOpenRead OR fmShareDenyWrite );
      SetLength( B, fs.Size );
      fs.ReadBuffer( B[ 0 ], fs.Size );
    except
      SetLength( B, 0 );
      fs.free;
      Exit;
    end;
    fs.Free;
    end
  else
    begin
    SetLength( B, Length( TextOrFileName ) );
    {$IFDEF UNICODE}
    S := AnsiString( TextOrFileName );
    if ( Length( S ) > 0 ) then
      Move( S[ {$IF CompilerVersion >= 24}Low( S ){$ELSE}1{$IFEND} ], B[ 0 ], Length( S ) );
    {$ELSE}
    if ( Length( TextOrFileName ) > 0 ) then
      Move( TextOrFileName[ {$IF CompilerVersion >= 24}Low( TextOrFileName ){$ELSE}1{$IFEND} ], B[ 0 ], Length( TextOrFileName ) );
    {$ENDIF}
    end;
  result := CRC32( B );
  SetLength( B, 0 );
end;

{$IF ( CompilerVersion >= 30 ) OR Defined( INDY90 ) OR Defined( INDY100 )}
function HMAC( const Bytes : {$IF CompilerVersion >= 30}TBytes{$ELSE}TByteDynArray{$IFEND}; Key : string; HashType : tHashType = htMD5 ) : string;
const
  CInnerPad : Byte = $36;
  COuterPad : Byte = $5C;
var
  BlockSize : Byte;
  vBytes    : {$IF CompilerVersion >= 30}TBytes{$ELSE}TByteDynArray{$IFEND};
  i, j      : Integer;
begin
  result := '';

  case HashType of
    htCRC32,
    htMD5,
    htSHA1,
    htSHA224,
    htSHA256     : BlockSize := 64;
    htSHA384,
    htSHA512,
    htSHA512_224,
    htSHA512_256 : BlockSize := 128;
  else
    Exit;
  end;

  if ( Length( Key ) > BlockSize ) then // Keys longer than blockSize are shortened by hashing them
    Key := Hash( Key, HashType )
  else if ( Length( Key ) < BlockSize ) then // Keys shorter than blockSize are padded to blockSize by padding with zeros on the right
    Key := Key + DupeString( #0, BlockSize-Length( Key ) );

  SetLength( vBytes, BlockSize + Length( Bytes ) );
  for i := {$IF CompilerVersion >= 24}Low( Key ){$ELSE}1{$IFEND} to {$IF CompilerVersion >= 24}High( Key ){$ELSE}Length( Key ){$IFEND} do
    vBytes[ i-{$IF CompilerVersion >= 24}Low( Key ){$ELSE}1{$IFEND} ] := Byte( Key[ i ] ) xor CInnerPad;

  if ( Length( Bytes ) > 0 ) then
    Move( Bytes[ 0 ], vBytes[ Length( Key ) ], Length( Bytes ) );
  result := Hash( vBytes, HashType );

  SetLength( vBytes, BlockSize+Length( result ) div 2 );
  for i := {$IF CompilerVersion >= 24}Low( Key ){$ELSE}1{$IFEND} to {$IF CompilerVersion >= 24}High( Key ){$ELSE}Length( Key ){$IFEND} do
    vBytes[ i-{$IF CompilerVersion >= 24}Low( Key ){$ELSE}1{$IFEND} ] := Byte( Key[ I ] ) xor COuterPad;

  i := 1;
  j := Length( Key );
  while ( i <= Length( result ) ) do
    begin
    vBytes[ j ] := HexToByte( result[ i ] + result[ i+1 ] );
    Inc( i, 2 );
    Inc( j );
    end;

  result := Hash( vBytes, HashType );
  SetLength( vBytes, 0 );
end;

function HMAC( const TextOrFileName, Key : String; HashType : tHashType = htMD5 ) : string;
var
  B  : {$IF CompilerVersion >= 30}TBytes{$ELSE}TByteDynArray{$IFEND};
  fs : TFileStream;
  {$IFDEF UNICODE}
  S  : AnsiString;
  {$ENDIF}
begin
  result := '';
  fs     := nil;
  if FileExists( TextOrFileName ) then
    begin
    try
      fs := TFileStream.Create( TextOrFileName, fmOpenRead OR fmShareDenyWrite );
      SetLength( B, fs.Size );
      fs.ReadBuffer( B[ 0 ], fs.Size );
    except
      SetLength( B, 0 );
      fs.free;
      Exit;
    end;
    fs.Free;
    end
  else
    begin
    SetLength( B, Length( TextOrFileName ) );
    {$IFDEF UNICODE}
    S := AnsiString( TextOrFileName );
    if ( Length( S ) > 0 ) then
      Move( S[ {$IF CompilerVersion >= 24}Low( S ){$ELSE}1{$IFEND} ], B[ 0 ], Length( S ) );
    {$ELSE}
    if ( Length( TextOrFileName ) > 0 ) then
      Move( TextOrFileName[ {$IF CompilerVersion >= 24}Low( TextOrFileName ){$ELSE}1{$IFEND} ], B[ 0 ], Length( TextOrFileName ) );
    {$ENDIF}
    end;
  result := HMAC( B, Key, HashType );
  SetLength( B, 0 );
end;

function Hash( const Bytes : {$IF CompilerVersion >= 30}TBytes{$ELSE}TByteDynArray{$IFEND}; HashType : tHashType = htMD5 ) : string;
var
  {$IF CompilerVersion >= 30}
  vMD5    : THashMD5;
  vSHA1   : THashSHA1;
  vSHA2   : THashSHA2;
  {$ELSE}
  {$IFDEF USE_EXTERNAL_HASH}
  vHash   : PHashDesc;
  {$ENDIF}
  IdBytes : TIdBytes absolute Bytes;
  vMD5    : TIdHashMessageDigest5;
  {$IFDEF INDY100}
  vSHA1   : TIdHashSHA1;
  vSHA2   : TIdHashSHA224;
  vSHA256 : TIdHashSHA256;
  vSHA384 : TIdHashSHA384;
  vSHA512 : TIdHashSHA512;
  {$ENDIF}
  {$IFEND}
begin
  result := '';
  {$IF CompilerVersion >= 30}
  case HashType of
    htCRC32      : ;
    htMD5        : begin
                   vMD5  := THashMD5.Create;
                   vMD5.Reset;
                   end;
    {$IFDEF INDY100}
    htSHA1       : begin
                   vSHA1 := THashSHA1.Create;
                   vSHA1.Reset;
                   end;
    htSHA224     : begin
                   vSHA2 := THashSHA2.Create( THashSHA2.TSHA2Version.SHA224 );
                   vSHA2.Reset;
                   end;
    htSHA256     : begin
                   vSHA2 := THashSHA2.Create( THashSHA2.TSHA2Version.SHA256 );
                   vSHA2.Reset;
                   end;
    htSHA384     : begin
                   vSHA2 := THashSHA2.Create( THashSHA2.TSHA2Version.SHA384 );
                   vSHA2.Reset;
                   end;
    htSHA512     : begin
                   vSHA2 := THashSHA2.Create( THashSHA2.TSHA2Version.SHA512 );
                   vSHA2.Reset;
                   end;
    htSHA512_224 : begin
                   vSHA2 := THashSHA2.Create( THashSHA2.TSHA2Version.SHA512_224 );
                   vSHA2.Reset;
                   end;
    htSHA512_256 : begin
                   vSHA2 := THashSHA2.Create( THashSHA2.TSHA2Version.SHA512_256 );
                   vSHA2.Reset;
                   end;
    {$ENDIF}
  else
    Exit;
  end;
  {$ELSE}

  {$IFDEF USE_EXTERNAL_HASH}
  case HashType of
    htSHA224 : begin
               {$IFNDEF USE_SHA224}
               {$IFNDEF INDY100}
               Exit;
               {$ELSE}
               if IdSSLOpenSSLHeaders.Load then
                 Exit;
               {$ENDIF}
               {$ENDIF}
               end;
    htSHA256 : begin
               {$IFNDEF USE_SHA256}
               {$IFNDEF INDY100}
               Exit;
               {$ELSE}
               if IdSSLOpenSSLHeaders.Load then
                 Exit;
               {$ENDIF}
               {$ENDIF}
               end;
    htSHA384 : begin
               {$IFNDEF USE_SHA256}
               {$IFNDEF INDY100}
               Exit;
               {$ELSE}
               if IdSSLOpenSSLHeaders.Load then
                 Exit;
               {$ENDIF}
               {$ENDIF}
               end;
    htSHA512 : begin
               {$IFNDEF USE_SHA512}
               {$IFNDEF INDY100}
               Exit;
               {$ELSE}
               if IdSSLOpenSSLHeaders.Load then
                 Exit;
               {$ENDIF}
               {$ENDIF}
               end;
    htSHA512_224 : begin
               {$IFNDEF USE_SHA5_224}
               {$IFNDEF INDY100}
               Exit;
               {$ELSE}
               if IdSSLOpenSSLHeaders.Load then
                 Exit;
               {$ENDIF}
               {$ENDIF}
               end;
    htSHA512_256 : begin
               {$IFNDEF USE_SHA5_256}
               {$IFNDEF INDY100}
               Exit;
               {$ELSE}
               if IdSSLOpenSSLHeaders.Load then
                 Exit;
               {$ENDIF}
               {$ENDIF}
               end;
  end;
  {$ELSE}
  {$IFDEF INDY100}
  if ( HashType in [ htSHA224, htSHA256, htSHA384, htSHA512, htSHA512_224, htSHA512_256 ] ) AND not IdSSLOpenSSLHeaders.Load then
    Exit; // raise Exception.Create( 'IdSSLOpenSSL not loaded' );
  {$ENDIF}
  {$ENDIF}

  vMD5    := nil;
  {$IFDEF INDY100}
  vSHA1   := nil;
  vSHA2   := nil;
  vSHA256 := nil;
  vSHA384 := nil;
  vSHA512 := nil;
  {$ENDIF}
  case HashType of
    htCRC32      : ;
    htMD5        : vMD5    := TIdHashMessageDigest5.Create;
    {$IFDEF INDY100}
    htSHA1       : vSHA1   := TIdHashSHA1.Create;
    htSHA224     : vSHA2   := TIdHashSHA224.Create;
    htSHA256     : vSHA256 := TIdHashSHA256.Create;
    htSHA384     : vSHA384 := TIdHashSHA384.Create;
    htSHA512     : vSHA512 := TIdHashSHA512.Create;
    {$ENDIF}
  {$IFNDEF USE_EXTERNAL_HASH}
  else
    Exit;
  {$ENDIF}
  end;
  {$IFEND}

  {$IF CompilerVersion >= 30}
    case HashType of
      htCRC32      : result := CRC32( Bytes );
      htMD5        : begin
                     if ( Length( Bytes ) > 0 ) then
                       vMD5.Update( Bytes[ 0 ], Length( Bytes ) );
                     result := vMD5.HashAsString;
                     end;
      {$IFDEF INDY100}
      htSHA1       : begin
                     if ( Length( Bytes ) > 0 ) then
                       vSHA1.Update( Bytes, Length( Bytes ) );
                     result := vSHA1.HashAsString;
                     end;
      htSHA224     : begin
                     if ( Length( Bytes ) > 0 ) then
                       vSHA2.Update( Bytes, Length( Bytes ) );
                     result := vSHA2.HashAsString;
                     end;
      htSHA256     : begin
                     if ( Length( Bytes ) > 0 ) then
                       vSHA2.Update( Bytes, Length( Bytes ) );
                     result := vSHA2.HashAsString;
                     end;
      htSHA384     : begin
                     if ( Length( Bytes ) > 0 ) then
                       vSHA2.Update( Bytes, Length( Bytes ) );
                     result := vSHA2.HashAsString;
                     end;
      htSHA512     : begin
                     if ( Length( Bytes ) > 0 ) then
                       vSHA2.Update( Bytes, Length( Bytes ) );
                     result := vSHA2.HashAsString;
                     end;
      htSHA512_224 : begin
                     if ( Length( Bytes ) > 0 ) then
                       vSHA2.Update( Bytes, Length( Bytes ) );
                     result := vSHA2.HashAsString;
                     end;
      htSHA512_256 : begin
                     if ( Length( Bytes ) > 0 ) then
                       vSHA2.Update( Bytes, Length( Bytes ) );
                     result := vSHA2.HashAsString;
                     end;
      {$ENDIF}
    end;
  {$ELSE}
    case HashType of
      htCRC32      : result := CRC32( Bytes );
      htMD5        : begin
                     {$IF Defined( USE_EXTERNAL_HASH ) AND Defined( USE_MD5 )}
                     vHash := FindHash_by_Name( 'MD5' );
                     if ( vHash = nil ) then
                       Exit;
                     HashFullXL( vHash, result, @Bytes[ 0 ], Length( Bytes ) );
                     {$ELSE}
                     {$IFDEF INDY100}
                     result := vMD5.HashBytesAsHex( IdBytes ); // D9/Indy10
                     {$ELSE}
                     result := vMD5.AsHex( vMD5.HashValue( IdBytes ) ); // D7/Indy9
                     {$ENDIF}
                     {$IFEND}
                     end;

      htSHA1       : begin
                     {$IF Defined( USE_EXTERNAL_HASH ) AND Defined( USE_SHA1 )}
                     vHash := FindHash_by_Name( 'SHA1' );
                     if ( vHash = nil ) then
                       Exit;
                     HashFullXL( vHash, result, @Bytes[ 0 ], Length( Bytes ) );
                     {$ELSE}
                     {$IFDEF INDY100}
                     result := vSHA1.HashBytesAsHex( IdBytes );
                     {$ENDIF}
                     {$IFEND}
                     end;
      htSHA224     : begin
                     {$IF Defined( USE_EXTERNAL_HASH ) AND Defined( USE_SHA224 )}
                     vHash := FindHash_by_Name( 'SHA224' );
                     if ( vHash = nil ) then
                       Exit;
                     HashFullXL( vHash, result, @Bytes[ 0 ], Length( Bytes ) );
                     {$ELSE}
                     {$IFDEF INDY100}
                     result := vSHA2.HashBytesAsHex( IdBytes );
                     {$ENDIF}
                     {$IFEND}
                     end;
      htSHA256     : begin
                     {$IF Defined( USE_EXTERNAL_HASH ) AND Defined( USE_SHA256 )}
                     vHash := FindHash_by_Name( 'SHA256' );
                     if ( vHash = nil ) then
                       Exit;
                     HashFullXL( vHash, result, @Bytes[ 0 ], Length( Bytes ) );
                     {$ELSE}
                     {$IFDEF INDY100}
                     result := vSHA256.HashBytesAsHex( IdBytes );
                     {$ENDIF}
                     {$IFEND}
                     end;
      htSHA384     : begin
                     {$IF Defined( USE_EXTERNAL_HASH ) AND Defined( USE_SHA384 )}
                     vHash := FindHash_by_Name( 'SHA384' );
                     if ( vHash = nil ) then
                       Exit;
                     HashFullXL( vHash, result, @Bytes[ 0 ], Length( Bytes ) );
                     {$ELSE}
                     {$IFDEF INDY100}
                     result := vSHA384.HashBytesAsHex( IdBytes );
                     {$ENDIF}
                     {$IFEND}
                     end;
      htSHA512     : begin
                     {$IF Defined( USE_EXTERNAL_HASH ) AND Defined( USE_SHA512 )}
                     vHash := FindHash_by_Name( 'SHA512' );
                     if ( vHash = nil ) then
                       Exit;
                     HashFullXL( vHash, result, @Bytes[ 0 ], Length( Bytes ) );
                     {$ELSE}
                     {$IFDEF INDY100}
                     result := vSHA512.HashBytesAsHex( IdBytes );
                     {$ENDIF}
                     {$IFEND}
                     end;
      htSHA512_224 : begin
                     {$IF Defined( USE_EXTERNAL_HASH ) AND Defined( USE_SHA5_224 )}
                     vHash := FindHash_by_Name( 'SHA512/224' );
                     if ( vHash = nil ) then
                       Exit;
                     HashFullXL( vHash, result, @Bytes[ 0 ], Length( Bytes ) );
                     {$ELSE}

                     {$IFEND}
                     end;
      htSHA512_256 : begin
                     {$IF Defined( USE_EXTERNAL_HASH ) AND Defined( USE_SHA5_256 )}
                     vHash := FindHash_by_Name( 'SHA512/256' );
                     if ( vHash = nil ) then
                       Exit;
                     HashFullXL( vHash, result, @Bytes[ 0 ], Length( Bytes ) );
                     {$ELSE}

                     {$IFEND}
                     end;
    end;
  {$IFEND}

  {$IF CompilerVersion < 30}
  case HashType of
    htCRC32  : ;
    htMD5    : vMD5.free;
    {$IFDEF INDY100}
    htSHA1   : vSHA1.free;
    htSHA224 : vSHA2.free;
    htSHA256 : vSHA256.free;
    htSHA384 : vSHA384.free;
//      htSHA512_224,
//      htSHA512_256,
    htSHA512 : vSHA512.free;
    {$ENDIF}    
  end;
  {$IFEND}

  result := LowerCase( result );
end;

function Hash( const TextOrFileName : string; HashType : tHashType = htMD5 ) : string;
var
  B  : {$IF CompilerVersion >= 30}TBytes{$ELSE}TByteDynArray{$IFEND};
  fs : TFileStream;
  {$IFDEF UNICODE}
  S  : AnsiString;
  {$ENDIF}
begin
  result := '';
  fs     := nil;  
  if FileExists( TextOrFileName ) then
    begin
    try
      fs := TFileStream.Create( TextOrFileName, fmOpenRead OR fmShareDenyWrite );
      SetLength( B, fs.Size );
      fs.ReadBuffer( B[ 0 ], fs.Size );
    except
      SetLength( B, 0 );
      fs.free;
      Exit;
    end;
    fs.Free;
    end
  else
    begin
    SetLength( B, Length( TextOrFileName ) );
    {$IFDEF UNICODE}
    S := AnsiString( TextOrFileName );
    if ( Length( S ) > 0 ) then
      Move( S[ {$IF CompilerVersion >= 24}Low( S ){$ELSE}1{$IFEND} ], B[ 0 ], Length( S ) );
    {$ELSE}
    if ( Length( TextOrFileName ) > 0 ) then
      Move( TextOrFileName[ {$IF CompilerVersion >= 24}Low( TextOrFileName ){$ELSE}1{$IFEND} ], B[ 0 ], Length( TextOrFileName ) );
    {$ENDIF}
    end;
  result := Hash( B, HashType );
  SetLength( B, 0 );
end;

function HashDigestAsString(const ADigest: {$IF CompilerVersion >= 30}TBytes{$ELSE}TByteDynArray{$IFEND}): string;
const
  XD: array[0..15] of char = ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f');
var
  I: Integer;
begin
  Result := '';
  for I := 0 to Length(ADigest) - 1 do
    Result := Result + XD[(ADigest[I] shr 4) and $0f] + XD[ADigest[I] and $0f];
end;

function MD5( const TextOrFileName : string ) : string;
begin
  result := Hash( TextOrFileName, htMD5 );
end;
{$IFEND}

{$IF ( CompilerVersion >= 30 ) OR Defined( INDY100 )}
function SHA1( const TextOrFileName : string ) : string;
begin
  result := Hash( TextOrFileName, htSHA1 );
end;

function SHA224( const TextOrFileName : string ) : string;
begin
  result := Hash( TextOrFileName, htSHA224 );
end;

function SHA256( const TextOrFileName : string ) : string;
begin
  result := Hash( TextOrFileName, htSHA256 );
end;

function SHA384( const TextOrFileName : string ) : string;
begin
  result := Hash( TextOrFileName, htSHA384 );
end;

function SHA512( const TextOrFileName : string ) : string;
begin
  result := Hash( TextOrFileName, htSHA512 );
end;
{$IFEND}

{$IF CompilerVersion >= 30}
function SHA512_256( const TextOrFileName : string ) : string;
begin
  result := Hash( TextOrFileName, htSHA512_256 );
end;
{$IFEND}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function URLEncode( const Value: AnsiString; ValidChars : AnsiString = ValidURLChars ): AnsiString;
//const
//  ValidURLChars : AnsiString = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789$-_@.&+-!*"''(),;/#?:';
//  ValidURLChars : AnsiString = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789$-_@.&+-!*"''(),;#?';
var
  I: Integer;
begin
  Result := '';
  for I := {$IF CompilerVersion >= 24}Low( Value ){$ELSE}1{$IFEND} to {$IF CompilerVersion >= 24}High( Value ){$ELSE}Length( Value ){$IFEND} do
    begin
    if Pos( UpperCase( Value[ I ] ), ValidURLChars ) > 0 then
      Result := Result + Value[ I ]
    else
      begin
      if Value[ I ] = ' ' then
        Result := Result + '+'
      else
        begin
        Result := Result + '%';
        Result := Result + AnsiString( IntToHex( Byte( Value[ I ] ), 2 ) );
        end;
      end;
    end;
end;

function URLDecode( const Value: AnsiString ): AnsiString;
const
  HexChars : AnsiString = '0123456789ABCDEF';
  CRLF     : AnsiString = #13#10;
var
  I: Integer;
  Ch, H1, H2: AnsiChar;
  Len: Integer;
begin
  Result := '';
  Len := {$IF CompilerVersion >= 24}High( Value ){$ELSE}Length( Value ){$IFEND};
  I := {$IF CompilerVersion >= 24}Low( Value ){$ELSE}1{$IFEND};
  while I <= Len do
    begin
    Ch := Value[ I ];
    case Ch of
      '%': begin
           H1 := Value[ I + 1 ];
           H2 := Value[ I + 2 ];
           Inc( I, 2 );
           Result := Result + AnsiChar( Chr( ( ( {$IFDEF SUPPORTS_UNICODE}AnsiPos{$ELSE}Pos{$ENDIF SUPPORTS_UNICODE}( H1, HexChars ) - 1 ) * 16 ) +
                                            ( {$IFDEF SUPPORTS_UNICODE}AnsiPos{$ELSE}Pos{$ENDIF SUPPORTS_UNICODE}( H2, HexChars ) - 1 ) ) );
           end;
      '+' : Result := Result + ' ';
      '&' : Result := Result + CrLf;
    else
      Result := Result + Ch;
    end;
    Inc( I );
    end;
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function EncodeBase64( const Data : Pointer; const Len : Int64; const Alphabet: AnsiString; const Pad: Boolean = False; const PadMultiple: Integer = 4; const PadChar: AnsiChar = AnsiChar( Ord( '=' ) ) ): AnsiString;
var R, C : Byte;
    F, M, N, U : Integer;
    P : PByteChar;
    T : Boolean;
    pB : PByte;
begin
  Result := '';
  if Length( Alphabet ) <> 64 then
    exit;
  if Len = 0 then
    exit;

  M := Len mod 3;
  N := ( Len  div 3 ) * 4 + M;
  if M > 0 then
    Inc( N );
  T := Pad and ( PadMultiple > 1 );
  if T then
    begin
    U := N mod PadMultiple;
    if U > 0 then
      begin
      U := PadMultiple - U;
      Inc( N, U );
      end;
    end
  else
    U := 0;
  SetLength( Result, N );
  P := Pointer( Result );
  R := 0;
  for F := 0 to Len - 1 do
    begin
    pB := Data;
    Inc( pB, F );
    C := pB^;
    case F mod 3 of
      0 : begin
          P^ := Alphabet[ C shr 2 + 1 ];
          Inc( P );
          R := ( C and 3 ) shl 4;
          end;
      1 : begin
          P^ := Alphabet[ C shr 4 + R + 1 ];
          Inc( P );
          R := ( C and $0F ) shl 2;
          end;
      2 : begin
          P^ := Alphabet[ C shr 6 + R + 1 ];
          Inc( P );
          P^ := Alphabet[ C and $3F + 1 ];
          Inc( P );
          end;
    end;
    end;
  if M > 0 then
    begin
    P^ := Alphabet[ R + 1 ];
    Inc( P );
    end;
  for F := 1 to U do
    begin
    P^ := PadChar;
    Inc( P );
    end;
end;

function EncodeBase64A( const S, Alphabet: AnsiString; const Pad: Boolean = False; const PadMultiple: Integer = 4; const PadChar: AnsiChar = AnsiChar( Ord( '=' ) ) ): AnsiString;
begin
  result := '';
  if ( S = '' ) then
    Exit;
  result := EncodeBase64( @S[ {$IF CompilerVersion >= 24}Low( S ){$ELSE}1{$IFEND} ], Length( S ), Alphabet, Pad, PadMultiple, PadChar );
end;

function EncodeBase64W( const S : WideString; const Alphabet: AnsiString; const Pad: Boolean = False; const PadMultiple: Integer = 4; const PadChar: AnsiChar = AnsiChar( Ord( '=' ) ) ): AnsiString;
begin
  result := '';
  if ( S = '' ) then
    Exit;
  result := EncodeBase64( @S[ {$IF CompilerVersion >= 24}Low( S ){$ELSE}1{$IFEND} ], Length( S )*2, Alphabet, Pad, PadMultiple, PadChar );
end;

function EncodeBase64( const S : string; const Alphabet: AnsiString; const Pad: Boolean = False; const PadMultiple: Integer = 4; const PadChar: AnsiChar = AnsiChar( Ord( '=' ) ) ): AnsiString;
begin
  {$IFDEF UNICODE}
  result := EncodeBase64W( S, Alphabet, Pad, PadMultiple, PadChar );
  {$ELSE}
  result := EncodeBase64A( S, Alphabet, Pad, PadMultiple, PadChar );
  {$ENDIF}
end;

procedure DecodeBase64( const S, Alphabet: AnsiString; var OutByteArray : TByteDynArray; const PadSet: ByteCharSet );
var
  F, L, M, P : Integer;
  B, OutPos  : Byte;
  OutB       : array[ 1..3 ] of Byte;
  Lookup     : array[ AnsiChar ] of Byte;
  R          : PByteChar;
begin
  SetLength( OutByteArray, 0 );
  if Length( Alphabet ) <> 64 then
    exit;
  L := Length( S );
  P := 0;
  if PadSet <> [ ] then
    while ( L - P > 0 ) and ( S[ L - P ] in PadSet ) do
      Inc( P );
  M := L - P;
  if M = 0 then
    exit;
  SetLength( OutByteArray, ( M * 3 ) div 4 );
  FillChar( Lookup, Sizeof( Lookup ), #0 );
  for F := 0 to 63 do
    Lookup[ Alphabet[ F + 1 ] ] := Byte( F );
  R := Pointer( OutByteArray );
  OutPos := 0;
  for F := 1 to L - P do
    begin
    B := Lookup[ S[ F ] ];
    case OutPos of
        0 : OutB[ 1 ] := B shl 2;
        1 : begin
            OutB[ 1 ] := OutB[ 1 ] or ( B shr 4 );
            R^ := AnsiChar( OutB[ 1 ] );
            Inc( R );
            OutB[ 2 ] := ( B shl 4 ) and $FF;
            end;
        2 : begin
            OutB[ 2 ] := OutB[ 2 ] or ( B shr 2 );
            R^ := AnsiChar( OutB[ 2 ] );
            Inc( R );
            OutB[ 3 ] := ( B shl 6 ) and $FF;
            end;
        3 : begin
            OutB[ 3 ] := OutB[ 3 ] or B;
            R^ := AnsiChar( OutB[ 3 ] );
            Inc( R );
            end;
    end;
      OutPos := ( OutPos + 1 ) mod 4;
    end;
  if ( OutPos > 0 ) and ( P = 0 ) then // incomplete encoding, add the partial byte if not 0
    begin
    if OutB[ OutPos ] <> 0 then
      begin
      SetLength( OutByteArray, Length( OutByteArray )+1 );
      OutByteArray[ High( OutByteArray ) ] := OutB[ OutPos ];
      end;
    end;
end;

function DecodeBase64A( const S, Alphabet: AnsiString; const PadSet: ByteCharSet ) : AnsiString;
var
  Bytes : TByteDynArray;
  i     : Integer;
begin
  result := '';
  if ( S = '' ) then
    Exit;

  SetLength( Bytes, Length( S ) );
  DecodeBase64( S, Alphabet, Bytes, PadSet );
  for i := Low( Bytes ) to High( Bytes ) do
    result := result + AnsiChar( Bytes[ i ] );
  SetLength( Bytes, 0 );
end;

function DecodeBase64W( const S, Alphabet: AnsiString; const PadSet: ByteCharSet ) : WideString;
begin
  result := DecodeBase64A( S, Alphabet, PadSet );
end;

function DecodeBase64( const S, Alphabet: AnsiString; const PadSet: ByteCharSet ) : string;
begin
  result := DecodeBase64A( S, Alphabet, PadSet );
end;

// MIME
function Base64MIMEEncode( const P: Pointer; const Len : Int64 ): AnsiString;
begin
  Result := EncodeBase64( P, Len, b64_MIMEBase64, True, 4, AnsiChar( Ord( '=' ) ) );
end;

function Base64MIMEEncode( const S: String ): String;
begin
  {$IFDEF UNICODE}
  Result := EncodeBase64W( S, b64_MIMEBase64, True, 4, AnsiChar( Ord( '=' ) ) );
  {$ELSE}
  Result := EncodeBase64A( S, b64_MIMEBase64, True, 4, AnsiChar( Ord( '=' ) ) );
  {$ENDIF}
end;

function Base64MIMEEncodeA( const S: AnsiString ): AnsiString;
begin
  Result := EncodeBase64A( S, b64_MIMEBase64, True, 4, AnsiChar( Ord( '=' ) ) );
end;

function Base64MIMEEncodeW( const S: WideString ): WideString;
begin
  Result := EncodeBase64W( S, b64_MIMEBase64, True, 4, AnsiChar( Ord( '=' ) ) );
end;

procedure Base64MIMEDecode( const S: AnsiString; var OutByteArray : TByteDynArray );
begin
  DecodeBase64( S, b64_MIMEBase64, OutByteArray, [ AnsiChar( Ord( '=' ) ) ] );
end;

function Base64MIMEDecode( const S: AnsiString ): String;
begin
  {$IFDEF UNICODE}
  Result := DecodeBase64W( S, b64_MIMEBase64, [ AnsiChar( Ord( '=' ) ) ] );
  {$ELSE}
  Result := DecodeBase64A( S, b64_MIMEBase64, [ AnsiChar( Ord( '='  ) ) ] );
  {$ENDIF}
end;

function Base64MIMEDecodeA( const S: AnsiString ): AnsiString;
begin
  Result := DecodeBase64A( S, b64_MIMEBase64, [ AnsiChar( Ord( '=' ) ) ] );
end;

function Base64MIMEDecodeW( const S: AnsiString ): WideString;
begin
  Result := DecodeBase64W( S, b64_MIMEBase64, [ AnsiChar( Ord( '=' ) ) ] ) ;
end;

// UU
function Base64UUEncode( const P: Pointer; const Len : Int64 ): AnsiString;
begin
  Result := EncodeBase64( P, Len, b64_UUEncode, True, 4, AnsiChar( Ord( '=' ) ) );
end;

function Base64UUEncode( const S: String ): String;
begin
  {$IFDEF UNICODE}
  Result := EncodeBase64W( S, b64_UUEncode, True, 4, AnsiChar( Ord( '=' ) ) );
  {$ELSE}
  Result := EncodeBase64A( S, b64_UUEncode, True, 4, AnsiChar( Ord( '=' ) ) );
  {$ENDIF}
end;

function Base64UUEncodeA( const S: AnsiString ): AnsiString;
begin
  Result := EncodeBase64A( S, b64_UUEncode, True, 4, AnsiChar( Ord( '=' ) ) );
end;

function Base64UUEncodeW( const S: WideString ): WideString;
begin
  Result := EncodeBase64W( S, b64_UUEncode, True, 4, AnsiChar( Ord( '=' ) ) );
end;

procedure Base64UUDecode( const S: AnsiString; var OutByteArray : TByteDynArray );
begin
  DecodeBase64( S, b64_UUEncode, OutByteArray, [ AnsiChar( Ord( '=' ) ) ] );
end;

function Base64UUDecode( const S: AnsiString ): String;
begin
  {$IFDEF UNICODE}
  Result := DecodeBase64W( S, b64_UUEncode, [ AnsiChar( Ord( '=' ) ) ] );
  {$ELSE}
  Result := DecodeBase64A( S, b64_UUEncode, [ AnsiChar( Ord( '=' ) ) ] );
  {$ENDIF}
end;

function Base64UUDecodeA( const S: AnsiString ): AnsiString;
begin
  // Line without size indicator ( first byte = length + 32 )
  Result := DecodeBase64A( S, b64_UUEncode, [ AnsiChar( Ord( '=' ) ) ] );
end;

function Base64UUDecodeW( const S: AnsiString ): WideString;
begin
  Result := DecodeBase64W( S, b64_UUEncode, [ AnsiChar( Ord( '=' ) ) ] );
end;

// XX
function Base64XXEncode( const P: Pointer; const Len : Int64 ): AnsiString;
begin
  Result := EncodeBase64( P, Len, b64_XXEncode, True, 4, AnsiChar( Ord( '=' ) ) );
end;

function Base64XXEncode( const S: String ): String;
begin
  {$IFDEF UNICODE}
  Result := EncodeBase64W( S, b64_XXEncode, True, 4, AnsiChar( Ord( '=' ) ) );
  {$ELSE}
  Result := EncodeBase64A( S, b64_XXEncode, True, 4, AnsiChar( Ord( '=' ) ) );
  {$ENDIF}
end;

function Base64XXEncodeA( const S: AnsiString ): AnsiString;
begin
  Result := EncodeBase64A( S, b64_XXEncode, True, 4, AnsiChar( Ord( '=' ) ) );
end;

function Base64XXEncodeW( const S: WideString ): WideString;
begin
  Result := EncodeBase64W( S, b64_XXEncode, True, 4, AnsiChar( Ord( '=' ) ) );
end;

procedure Base64XXDecode( const S: AnsiString; var OutByteArray : TByteDynArray );
begin
  DecodeBase64( S, b64_XXEncode, OutByteArray, [ AnsiChar( Ord( '=' ) ) ] );
end;

function Base64XXDecode( const S: AnsiString ): String;
begin
  {$IFDEF UNICODE}
  Result := DecodeBase64W( S, b64_XXEncode, [ AnsiChar( Ord( '=' ) ) ] );
  {$ELSE}
  Result := DecodeBase64A( S, b64_XXEncode, [ AnsiChar( Ord( '=' ) ) ] );
  {$ENDIF}
end;

function Base64XXDecodeA( const S: AnsiString ): AnsiString;
begin
  Result := DecodeBase64A( S, b64_XXEncode, [ AnsiChar( Ord( '=' ) ) ] );
end;

function Base64XXDecodeW( const S: AnsiString ): WideString;
begin
  Result := DecodeBase64W( S, b64_XXEncode, [ AnsiChar( Ord( '=' ) ) ] );
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Tokenize
function AddTok( const S, T: string; const B: Byte; caseSensitive : boolean = False; AllowDuplicates : boolean = false ): string;
begin
  result := AddTok( S,T,Chr( B ), caseSensitive, AllowDuplicates );
end;

function AddTok( const S, T: string; const C: Char; caseSensitive : boolean = False; AllowDuplicates : boolean = false ): string;
var
  SLen, SIdx, ResIdx, TokStart, TokLen: Integer;
  TokExists: Boolean;
  CurrentTok: string;
begin
  if T <> '' then
    begin
    SLen := {$IF CompilerVersion >= 24}High( s ){$ELSE}Length( s ){$IFEND};
    SetLength( Result, SLen+Length( T )+1 );
    ResIdx := 0;
    TokExists := False;
    TokStart := 0;
    TokLen := 0;
    for SIdx := {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} to SLen do
      begin
      if ( S[ SIdx ] <> C ) or ( ( ResIdx > 0 ) and ( Result[ ResIdx ] <> C ) ) then
        begin
        Inc( ResIdx );
        Result[ ResIdx ] := S[ SIdx ];
        end;
      if S[ SIdx ] <> C then
        begin
        if TokStart = 0 then
          TokStart := SIdx;
        Inc( TokLen );
        end;
      if ( ( S[ SIdx ] = C ) or ( SIdx = SLen ) ) and ( TokStart > 0 ) then
        begin
        CurrentTok := Copy( S, TokStart, TokLen );
        if not TokExists then
        TokExists := ( ( caseSensitive ) and ( strcomp( PChar( CurrentTok ), PChar( T ) ) = 0 ) ) or
          ( ( not caseSensitive ) and ( strlcomp( PChar( CurrentTok ), PChar( T ), Max( Length( CurrentTok ), Length( T ) ) ) = 0 ) );
        TokStart := 0;
        TokLen := 0;
        end;
      end;

    if ( ResIdx > 0 ) and ( Result[ ResIdx ] = C ) then
      SetLength( Result, ResIdx-1 )
    else
      SetLength( Result, ResIdx );
    if ( NOT TokExists ) or AllowDuplicates then
      if Result <> '' then
        Result := Result + C + T
      else
        Result := Result + T;
    end
  else
    Result := S;
end;

function DelTok( const S: string; const N: Integer; const B: Byte ): string;
begin
  Result := DelTok( S,N,Chr( B ) );
end;

function DelTok( const S: string; const N: Integer; const C: Char ): string;
var
  SLen, SIdx, NTok, ResIdx: Integer;
begin
  if ( S <> '' ) then
    begin
    SLen := {$IF CompilerVersion >= 24}High( s ){$ELSE}Length( s ){$IFEND};
    SetLength( Result, SLen );
    NTok := 0;
    ResIdx := 0;
    for SIdx := {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} to SLen do
      begin
      if ( ( SIdx = {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} ) and ( S[ SIdx ] <> C ) ) or ( ( SIdx > 1 ) and ( S[ SIdx ] <> C ) and ( S[ SIdx-1 ] = C ) ) then
        Inc( NTok );
      if ( NTok <> N ) and ( NTok > 0 ) and ( ( S[ SIdx ] <> C ) or ( S[ SIdx-1 ] <> C ) ) then
        begin
        Inc( ResIdx );
        Result[ ResIdx ] := S[ SIdx ];
        end;
      end;
    if ( ResIdx > 0 ) AND ( Result[ ResIdx ] = C ) then
      SetLength( Result, ResIdx-1 )
    else
      SetLength( Result, ResIdx );
    end
  else
    Result := '';
end;

function DelTok( const S: string; const N1, N2: Integer; const B: Byte ): string;
begin
  Result := DelTok( S,N1, N2,Chr( B ) );
end;

function DelTok( const S: string; const N1, N2: Integer; const C: Char ): string;
var
  SLen, SIdx, NTok, ResIdx: Integer;
begin
  if ( S <> '' ) then
    begin
    if N2 <= N1 then
      Result := DelTok( S, N1, C )
    else
      begin
      SLen := {$IF CompilerVersion >= 24}High( s ){$ELSE}Length( s ){$IFEND};
      SetLength( Result, SLen );
      NTok := 0;
      ResIdx := 0;
      for SIdx := {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} to SLen do
        begin
        if ( ( SIdx = {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} ) and ( S[ SIdx ] <> C ) ) or ( ( SIdx > 1 ) and ( S[ SIdx ] <> C ) and ( S[ SIdx-1 ] = C ) ) then
          Inc( NTok );
        if ( ( NTok < N1 ) or ( NTok > N2 ) ) and ( NTok > 0 ) and ( ( S[ SIdx ] <> C ) or ( S[ SIdx-1 ] <> C ) ) then
          begin
          Inc( ResIdx );
          Result[ ResIdx ] := S[ SIdx ];
          end;
        end;
      if ( ResIdx > 0 ) AND ( Result[ ResIdx ] = C ) then
        SetLength( Result, ResIdx-1 )
      else
        SetLength( Result, ResIdx );
      end;
    end
  else
    Result := '';
end;

function FindTok( const S, T: string; N: Integer; const B: Byte; caseSensitive : boolean = False ): Integer;
begin
  Result := FindTok( S,T,N,chr( B ),caseSensitive );
end;

function FindTok( const S, T: string; N: Integer; const C: Char; caseSensitive : boolean = False ): Integer;
var
  SIdx, SLen, TokStart, TokLen, NTok, TokMatches: Integer;
  CurrentTok: string;
begin
  Result := 0;
  if ( S <> '' ) and ( T <> '' ) then
  begin
    SLen := {$IF CompilerVersion >= 24}High( s ){$ELSE}Length( s ){$IFEND};
    TokStart := 0;
    TokLen := 0;
    NTok := 0;
    TokMatches := 0;
    for SIdx := {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} to SLen do
    begin
      if S[ SIdx ] <> C then
      begin
        if TokStart = 0 then
          TokStart := SIdx;
        Inc( TokLen );
      end;
      if ( ( SIdx = SLen ) or ( S[ SIdx ] = C ) ) and ( TokStart > 0 ) then
      begin
        Inc( NTok );
        CurrentTok := Copy( S, TokStart, TokLen );
        if ( ( caseSensitive ) and ( strcomp( PChar( CurrentTok ), PChar( T ) ) = 0 ) ) or
          ( ( not caseSensitive ) and ( strlcomp( PChar( CurrentTok ), PChar( T ), Max( Length( CurrentTok ), Length( T ) ) ) = 0 ) ) then
        begin
          Inc( TokMatches );
          if N = 0 then
            Inc( Result )
          else if TokMatches = N then
          begin
            Result := NTok;
            Exit;
          end;
        end;
        TokStart := 0;
        TokLen := 0;
      end;
    end;
  end;
end;

function GetTok( const S: string; N: Integer; const B: Byte; IgnoreEmpty : boolean = true ): string;
begin
  Result := GetTok( S, N, Chr( B ), IgnoreEmpty );
end;

function GetTok( const S: string; N: Integer; const C: Char; IgnoreEmpty : boolean = true ): string;
var
  SLen, SIdx, NTok, ResIdx: Integer;
begin
  Result := '';
  if ( S = '' ) OR ( N <= 0 ) then
    Exit;

  SLen := {$IF CompilerVersion >= 24}High( s ){$ELSE}Length( s ){$IFEND};
  SetLength( Result, SLen );
  NTok := 0;
  ResIdx := 0;
  for SIdx := {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} to SLen do
    begin
    if IgnoreEmpty then
      begin
      if ( ( SIdx = {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} ) and ( S[ SIdx ] <> C ) ) then
        Inc( NTok )
      else if ( sIdx > {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} ) then
        begin
        if ( ( S[ SIdx ] <> C ) and ( ( S[ SIdx-1 ] = C ) ) ) then
          Inc( NTok );
        end;
      end
    else
      begin
      if ( ( ( SIdx = {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} ) and ( S[ SIdx ] <> C ) ) or ( S[ SIdx ] = C ) ) then
        Inc( NTok );
      end;

    if ( NTok = N ) and ( S[ SIdx ] <> C ) then
      begin
      Inc( ResIdx );
      Result[ ResIdx ] := S[ SIdx ];
      end;
    end;
  SetLength( Result, ResIdx );
end;

function GetTok( const S: string; const N1, N2: Integer; const B: Byte; IgnoreEmpty : boolean = true ): string;
begin
  Result := GetTok( S, N1, N2, Chr( B ), IgnoreEmpty );
end;

function GetTok( const S: string; const N1, N2: Integer; const C: Char; IgnoreEmpty : boolean = true ): string;
var
  SLen, SIdx, NTok, ResIdx: Integer;
begin
  Result := '';
  if ( S = '' ) OR ( N1 <= 0 ) then
    Exit;

  if N2 <= N1 then
    begin
    Result := GetTok( S, N1, C, IgnoreEmpty ); 
    Exit;
    end;

  SLen := {$IF CompilerVersion >= 24}High( s ){$ELSE}Length( s ){$IFEND};
  SetLength( Result, SLen );
  NTok := 0;
  ResIdx := 0;
  for SIdx := {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} to SLen do
    begin
    if IgnoreEmpty then
      begin
      if ( SIdx = {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} ) and ( S[ SIdx ] <> C ) then
        Inc( NTok )
      else if ( SIdx > 1 ) then
        begin
        if ( S[ SIdx ] <> C ) and ( S[ SIdx-1 ] = C ) then
          Inc( NTok );
        end;
      end
    else
      begin
      if ( SIdx = {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} ) and ( S[ SIdx ] <> C ) then
        Inc( NTok )
      else if ( SIdx > {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} ) then
        begin
        if ( S[ SIdx ] = C ) then
          Inc( NTok );
        end;
      end;

    if ( NTok < N1 ) then
      Continue;
    if ( NTok > N2 ) then
      break;

    if ( SIdx > 1 ) then
      begin
      if ( S[ SIdx ] = C ) and ( S[ SIdx-1 ] = C ) then
        Continue;
      end;

    Inc( ResIdx );
    Result[ ResIdx ] := S[ SIdx ];
    end;

  if ( ResIdx > 0 ) then
    begin
    if ( Result[ ResIdx ] = C ) then
      SetLength( Result, ResIdx-1 )
    else
      SetLength( Result, ResIdx );
    end
  else
    SetLength( Result, ResIdx );
end;

function InsTok( const S, T: string; N: Integer; const B: Byte ): string;
begin
  Result := InsTok( S, T, N, Chr( B ) );
end;

function InsTok( const S, T: string; N: Integer; const C: Char ): string;
var
  SLen, SIdx, ResIdx, NTok, TokLen: Integer;
  Inserted: Boolean;
begin
  if ( T = '' ) or ( N <= 0 ) then
    Result := S
  else if S = '' then
    Result := T
  else
    begin
    SLen := {$IF CompilerVersion >= 24}High( s ){$ELSE}Length( s ){$IFEND};
    ResIdx := 0;
    NTok := 0;
    TokLen := Length( T );
    Inserted := False;
    SetLength( Result, SLen+TokLen+2 );
    for SIdx := {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} to SLen+1 do
      begin
      if ( SIdx <> SLen+1 ) then
        begin
        if ( ( SIdx = {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} ) and ( S[ SIdx ] <> C ) ) or ( ( SIdx > 1 ) and ( S[ SIdx ] <> C ) and ( S[ SIdx-1 ] = C ) ) then
          Inc( NTok );
        end;
      if ( ( SIdx = SLen+1 ) or ( N = NTok ) ) and not Inserted then
        begin
        if ( ResIdx > 0 ) and ( Result[ ResIdx ] <> C ) then
          begin
          Inc( ResIdx );
          Result[ ResIdx ] := C;
          end;
        Inc( ResIdx );
        CopyMemory( @Result[ ResIdx ], PChar( T ), TokLen*SizeOf( Char ) );
        Inc( ResIdx, TokLen );
        Result[ ResIdx ] := C;
        Inserted := True;
        end;
      if ( SIdx <> SLen+1 ) then
        if ( ( S[ SIdx ] <> C ) or ( ( ResIdx > 0 ) and ( Result[ ResIdx ] <> C ) ) ) then
          begin
          Inc( ResIdx );
          Result[ ResIdx ] := S[ SIdx ];
          end;
      end;
    if ( ResIdx > 0 ) AND ( Result[ ResIdx ] = C ) then
      SetLength( Result, ResIdx-1 )
    else
      SetLength( Result, ResIdx );
    end;
end;

function IsTok( const S, T: string; const B: Byte; caseSensitive : boolean = False ): Boolean;
begin
  Result := IsTok( S, T, Chr( B ), caseSensitive );
end;

function IsTok( const S, T: string; const C: Char; caseSensitive : boolean = False ): Boolean;
var
  SLen, SIdx, TokStart, TokLen: Integer;
  CurrentTok: string;
begin
  Result := False;
  if ( S <> '' ) and ( T <> '' ) then
    begin
    SLen := {$IF CompilerVersion >= 24}High( s ){$ELSE}Length( s ){$IFEND};
    TokStart := 0;
    TokLen := 0;
    for SIdx := {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} to SLen do
      begin
      if S[ SIdx ] <> C then
        begin
        if TokStart = 0 then
          TokStart := SIdx;
        Inc( TokLen );
        end;
      if ( ( S[ SIdx ] = C ) or ( SIdx = SLen ) ) and ( TokStart > 0 ) then
        begin
        CurrentTok := Copy( S, TokStart, TokLen );
        if ( ( caseSensitive ) and ( strcomp( PChar( CurrentTok ), PChar( T ) ) = 0 ) ) or
          ( ( not caseSensitive ) and ( strlcomp( PChar( CurrentTok ), PChar( T ), Max( Length( CurrentTok ), Length( T ) ) ) = 0 ) ) then
          begin
          Result := True;
          Exit;
          end;
        TokStart := 0;
        TokLen := 0;
        end;
      end;
    end;
end;

function MatchTok( const S, T: string; N: Integer; const B: Byte; caseSensitive : boolean = False ): Variant;
begin
  result := MatchTok( S, T, N, Chr( B ), caseSensitive );
end;

function MatchTok( const S, T: string; N: Integer; const C: Char; caseSensitive : boolean = False ): Variant;
var
  SIdx, SLen, TokStart, TokLen, TokMatches: Integer;
begin
  Result := 0;
  if ( S <> '' ) and ( T <> '' ) then
  begin
    SLen := {$IF CompilerVersion >= 24}High( s ){$ELSE}Length( s ){$IFEND};
    TokStart := 0;
    TokLen := 0;
    TokMatches := 0;
    for SIdx := {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} to SLen do
    begin
      if S[ SIdx ] <> C then
        begin
        if TokStart = 0 then
          TokStart := SIdx;
        Inc( TokLen );
        end;
      if ( ( SIdx = SLen ) or ( S[ SIdx ] = C ) ) and ( TokStart > 0 ) then
        begin
        if ( ( caseSensitive AND ( Pos( T, Copy( S, TokStart, TokLen ) ) > 0 ) ) or ( NOT caseSensitive AND ( Pos( LowerCase( T ), LowerCase( Copy( S, TokStart, TokLen ) ) ) > 0 ) ) ) then
          begin
          Inc( TokMatches );
          if N = 0 then
            Inc( Result )
          else if TokMatches = N then
            Result := Copy( S, TokStart, TokLen );
          end;
        TokStart := 0;
        TokLen := 0;
        end;
    end;
  end;
end;

function NumTok( const S: string; const B: Byte; IgnoreEmpty : boolean = true ): Integer;
begin
  Result := NumTok( S, Chr( B ), IgnoreEmpty );
end;

function NumTok( const S: string; const C: Char; IgnoreEmpty : boolean = true ): Integer;
var
  SIdx: Integer;
begin
  Result := 0;
  for SIdx := {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} to {$IF CompilerVersion >= 24}High( s ){$ELSE}Length( s ){$IFEND} do
    begin
    if IgnoreEmpty then
      begin
      if ( ( SIdx = {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} ) and ( S[ SIdx ] <> C ) ) then
        Inc( Result )
      else if ( SIdx > {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} ) then
        begin
        if ( ( S[ SIdx ] <> C ) and ( ( S[ SIdx-1 ] = C ) ) ) then
          Inc( Result )
        end;
      end
    else
      begin
      if ( ( ( SIdx = {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} ) and ( S[ SIdx ] <> C ) ) or ( S[ SIdx ] = C ) ) then
        Inc( Result );
      end;
    end;
end;

function PutTok( const S, T: string; N: Integer; const B: Byte ): string;
begin
  Result := PutTok( S, T, N, Chr( B ) );
end;

function PutTok( const S, T: string; N: Integer; const C: Char ): string;
var
  SLen, SIdx, ResIdx, NTok, TokLen: Integer;
  Replaced: Boolean;
begin
  if ( T = '' ) or ( N <= 0 ) then
    Result := S
  else if S = '' then
    Result := T
  else
    begin
    SLen := {$IF CompilerVersion >= 24}High( s ){$ELSE}Length( s ){$IFEND};
    ResIdx := 0;
    NTok := 0;
    TokLen := Length( T );
    Replaced := False;
    SetLength( Result, SLen+TokLen+2 );
    for SIdx := {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} to SLen+1 do
      begin
      if ( SIdx <> SLen+1 ) then
        begin
        if ( ( SIdx = {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} ) and ( S[ SIdx ] <> C ) ) or ( ( SIdx > 1 ) and ( S[ SIdx ] <> C ) and ( S[ SIdx-1 ] = C ) ) then
          Inc( NTok );
        end;
      if ( ( SIdx = SLen+1 ) or ( N = NTok ) ) and not Replaced then
        begin
        if ( ResIdx > 0 ) and ( Result[ ResIdx ] <> C ) then
          begin
          Inc( ResIdx );
          Result[ ResIdx ] := C;
          end;
        Inc( ResIdx );
        CopyMemory( @Result[ ResIdx ], PChar( T ), TokLen*SizeOf( Char ) );
        Inc( ResIdx, TokLen );
        Result[ ResIdx ] := C;
        Replaced := True;
        end
      else
        begin
        if ( N <> NTok ) and ( SIdx <> SLen+1 ) then
          begin
          if ( ( S[ SIdx ] <> C ) or ( ( ResIdx > 0 ) and ( Result[ ResIdx ] <> C ) ) ) then
            begin
            Inc( ResIdx );
            Result[ ResIdx ] := S[ SIdx ];
            end;
          end;
        end;
      end;
    if ( ResIdx > 0 ) AND ( Result[ ResIdx ] = C ) then
      SetLength( Result, ResIdx-1 )
    else
      SetLength( Result, ResIdx );
    end;
end;

function RemTok( const S, T: string; N: Integer; const B: Byte; const caseSensitive : boolean = False ): string;
begin
  result := RemTok( S,T,N,Chr( B ), caseSensitive );
end;

function RemTok( const S, T: string; N: Integer; const C: Char; const caseSensitive : boolean = False ): string;
var
  SLen, SIdx, ResIdx, TokStart, TokLen, TokMatches: Integer;
  CurrentTok: string;
  Removed: Boolean;
begin
  result := '';
  if ( S = '' ) OR ( T = '' ) then
    Exit;
  SLen := {$IF CompilerVersion >= 24}High( s ){$ELSE}Length( s ){$IFEND};
  ResIdx := 0;
  TokStart := 0;
  TokLen := 0;
  Removed := False;
  TokMatches := 0;
  SetLength( Result, SLen+1 );
  for SIdx := {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} to SLen do
    begin
    if S[ SIdx ] <> C then
      begin
      if TokStart = 0 then
        TokStart := SIdx;
      Inc( TokLen );
      end;
    if ( ( SIdx = SLen ) or ( S[ SIdx ] = C ) ) and ( TokStart > 0 ) then
    try
      CurrentTok := Copy( S, TokStart, TokLen );
      if ( caseSensitive and ( CurrentTok = T ) ) or ( NOT caseSensitive and ( LowerCase( CurrentTok ) = LowerCase( T ) ) ) then
        begin
        if N > 0 then
          Inc( TokMatches )
        else
          Continue;
        end;
      if ( N > 0 ) and ( TokMatches = N ) and not Removed then
        Removed := True
      else
        begin
        Inc( ResIdx );
        CopyMemory( @Result[ ResIdx ], @CurrentTok[ 1 ], TokLen*SizeOf( Char ) );
        Inc( ResIdx, TokLen );
        Result[ ResIdx ] := C;
        end;
    finally
      TokStart := 0;
      TokLen := 0;
    end;
    end;
  if ( ResIdx > 0 ) AND ( Result[ ResIdx ] = C ) then
    SetLength( Result, ResIdx-1 )
  else
    SetLength( Result, ResIdx );
end;

function ExTok( const S : string; T1, T2: Integer; const B: Byte ): string;
begin
  result := ExTok( S, T1, T2, Chr( B ) );
end;

function ExTok( const S : string; T1, T2: Integer; const C: Char ): string;
var
  help : string;
begin
  help := GetTok( s, T1, C );
  result := PutTok( s, GetTok( s, T2, C ), T1, C );
  result := PutTok( result, help, T2, C );
end;

function MoveTok( const S : string; T1, T2: Integer; const B: Byte ): string;
begin
  result := MoveTok( S, T1, T2, Chr( B ) );
end;

function MoveTok( const S : string; T1, T2: Integer; const C: Char ): string;
var
  help : string;
begin
  help := GetTok( s, T1, C );
  result := DelTok( s, T1, C );
  result := InsTok( result, help, T2, C );
end;

function CloneTok( const S : string; T1, T2: Integer; const B: Byte ): string;
begin
  result := CloneTok( S, T1, T2, Chr( B ) );
end;

function CloneTok( const S : string; T1, T2: Integer; const C: Char ): string;
var
  help : string;
begin
  help := GetTok( s, T1, C );
  result := InsTok( s, help, T2, C );
end;

function RepTok( const S, T, T2: string; N: Integer; const B: Byte; const caseSensitive : boolean = False ): string;
begin
  result := RepTok( S, T, T2, N, Chr( B ), caseSensitive );
end;

function RepTok( const S, T, T2: string; N: Integer; const C: Char; const caseSensitive : boolean = False ): string;
var
  SLen, SIdx, ResIdx, TokStart, TokLen, TokMatches, TLen: Integer;
  CurrentTok: string;
begin
  if ( S <> '' ) and ( T <> '' ) and ( T2 <> '' ) then
  begin
    SLen := {$IF CompilerVersion >= 24}High( s ){$ELSE}Length( s ){$IFEND};
    ResIdx := 0;
    TokStart := 0;
    TokLen := 0;
    TokMatches := 0;
    TLen := Length( T2 );
    SetLength( Result, SLen*Length( T2 ) );
    for SIdx := {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} to SLen do
    begin
      if S[ SIdx ] <> C then
      begin
        if TokStart = 0 then
          TokStart := SIdx;
        Inc( TokLen );
      end;
      if ( ( SIdx = SLen ) or ( S[ SIdx ] = C ) ) and ( TokStart > 0 ) then
      try
        CurrentTok := Copy( S, TokStart, TokLen );
        if ( ( caseSensitive ) and ( strcomp( PChar( CurrentTok ), PChar( T ) ) = 0 ) ) or
          ( ( not caseSensitive ) and ( strlcomp( PChar( CurrentTok ), PChar( T ), Max( Length( CurrentTok ), Length( T ) ) ) = 0 ) ) then
        begin
          Inc( TokMatches );
          if ( N = 0 ) or ( N = TokMatches ) then
          begin
            Inc( ResIdx );
            CopyMemory( @Result[ ResIdx ], @T2[ 1 ], TLen*SizeOf( Char ) );
            Inc( ResIdx, TLen );
            Result[ ResIdx ] := C;
            Continue;
          end;
        end;
        Inc( ResIdx );
        CopyMemory( @Result[ ResIdx ], @CurrentTok[ 1 ], TokLen*SizeOf( Char ) );
        Inc( ResIdx, TokLen );
        Result[ ResIdx ] := C;
      finally
        TokStart := 0;
        TokLen := 0;
      end;
    end;
    if ( ResIdx > 0 ) AND ( Result[ ResIdx ] = C ) then
      SetLength( Result, ResIdx-1 )
    else
      SetLength( Result, ResIdx );
  end;
end;

function Tokenize( const S: TStringDynArray; const B: Byte; caseSensitive : boolean = False; AllowDuplicates : boolean = false ): string;
begin
  result := Tokenize( S, Chr( B ), caseSensitive, AllowDuplicates );
end;

function Tokenize( const S: TStringDynArray; const C: Char; caseSensitive : boolean = False; AllowDuplicates : boolean = false ): string;
var
  i : integer;
begin
  result := '';

  for i := 0 to Length( S )-1 do
    result := AddTok( result, S[ i ], C, caseSensitive, AllowDuplicates );
end;

function Tokenize( const S: string; const B: Byte; IgnoreEmpty : boolean = true ): TStringDynArray;
begin
  result := Tokenize( S, Chr( B ), IgnoreEmpty );
end;

function Tokenize( const S: string; const C: Char; IgnoreEmpty : boolean = true ): TStringDynArray;
var
  SLen, SIdx, NTok, TokStart, TokLen: Integer;
begin
  SetLength( Result, 0 );
  if ( S = '' ) then
    Exit;

  SLen := {$IF CompilerVersion >= 24}High( s ){$ELSE}Length( s ){$IFEND};
  SetLength( Result, SLen );
  TokStart := 0;
  NTok := 0;
  TokLen := 0;

  for SIdx := {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} to SLen do
    begin
    if S[ SIdx ] <> C then
      begin
      if TokStart = 0 then
        TokStart := SIdx;
      Inc( TokLen );
      end;
    if ( ( SIdx = SLen ) or ( S[ SIdx ] = C ) ) and ( ( NOT IgnoreEmpty ) OR ( TokStart > 0 ) ) then
      begin
      Inc( NTok );
      if ( TokStart > 0 ) then
        Result[ NTok-1 ] := Copy( S, TokStart, TokLen );
      TokStart := 0;
      TokLen := 0;
      end;
    end;
  SetLength( Result, NTok );
end;

function WildTok( const S, T: string; N: Integer; const B: Byte ): Variant;
begin
  result := WildTok( S,T,N,Chr( B ) );
end;

function WildTok( const S, T: string; N: Integer; const C: Char ): Variant;
var
  SIdx, SLen, TokStart, TokLen, TokMatches: Integer;
  CurrentTok: string;
begin
  Result := 0;
  if ( S <> '' ) and ( T <> '' ) then
    begin
    SLen := {$IF CompilerVersion >= 24}High( s ){$ELSE}Length( s ){$IFEND};
    TokStart := 0;
    TokLen := 0;
    TokMatches := 0;
    for SIdx := {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} to SLen do
      begin
      if S[ SIdx ] <> C then
        begin
        if TokStart = 0 then
          TokStart := SIdx;
        Inc( TokLen );
        end;
      if ( ( SIdx = SLen ) or ( S[ SIdx ] = C ) ) and ( TokStart > 0 ) then
        begin
        CurrentTok := Copy( S, TokStart, TokLen );
        if IsWm( CurrentTok, T ) then
          begin
          Inc( TokMatches );
          if N = 0 then
            Inc( Result )
          else if TokMatches = N then
            Result := CurrentTok;
          end;
        TokStart := 0;
        TokLen := 0;
        end;
      end;
    end;
end;

function SortTok( const S : string; B : Byte ): string;
begin
  result := SortTok( S, '', Chr( B ) );
end;

function SortTok( const S : string; C : Char ): string;
begin
  result := SortTok( S, '', C );
end;

function SortTok( const S, Options : string; B : Byte ): string;
begin
  result := SortTok( S, Options, Chr( B ) );
end;

function SortTok( const S, Options : string; C : Char ): string;
var
  i     : integer;
  StrL  : TStringList;
  StrLS : TStringList;
begin
  Result := '';
  if ( S = '' ) then
    Exit;
  StrL := TStringList.Create;
  for i := 1 to NumTok( S, C ) do
    StrL.Add( GetTok( S, i, C ) );

  if ( Isin( Options, 'r' ) ) then
    begin
    if ( Isin( Options, 'd' ) ) then
      begin
      StrL.Sorted := True;
      StrLS := TStringList.Create;
      for i := StrL.Count-1 downto 0 do
        StrLS.Add( StrL.Strings[ i ] );
      StrL.Assign( StrLS );
      StrLS.free;
      end
    else // if ( Isin( Options, 'a' ) ) then
      StrL.Sorted := True;
    end
  else //if ( Isin( Options, 'n' ) ) then
    begin

    StrL.CustomSort( NaturalSortDesc );

    if ( Isin( Options, 'd' ) ) then
      begin
      if Isin( Options, 'c' ) then
        StrL.CustomSort( NaturalSortDescCS )
      else
        StrL.CustomSort( NaturalSortDesc );
      end
    else // if ( Isin( Options, 'a' ) ) then
      begin
      if Isin( Options, 'c' ) then
        StrL.CustomSort( NaturalSortAscCS )
      else
        StrL.CustomSort( NaturalSortAsc );
      end;
    end;

  for i := 0 to StrL.Count-1 do
    result := AddTok( Result, StrL[ i ], C );

  StrL.free;
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// WideString Versions
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
{$IFNDEF UNICODE}
{$IF NOT Defined( USE_UNICODE ) AND NOT Defined( USE_SYNUNICODE )}
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
{$IFEND}

function AddTok( const S, T: WideString; const B: Byte; caseSensitive : boolean = False; AllowDuplicates : boolean = false ): WideString;
begin
  result := AddTok( S,T,WideChar( Chr( B ) ), caseSensitive, AllowDuplicates );
end;

function AddTok( const S, T: WideString; const C: WideChar; caseSensitive : boolean = False; AllowDuplicates : boolean = false ): WideString;
var
  SLen, SIdx, ResIdx, TokStart, TokLen: Integer;
  TokExists: Boolean;
  CurrentTok: WideString;
begin
  if T <> '' then
    begin
    SLen := {$IF CompilerVersion >= 24}High( s ){$ELSE}Length( s ){$IFEND};
    SetLength( Result, SLen+Length( T )+1 );
    ResIdx := 0;
    TokExists := False;
    TokStart := 0;
    TokLen := 0;
    for SIdx := {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} to SLen do
      begin
      if ( S[ SIdx ] <> C ) or ( ( ResIdx > 0 ) and ( Result[ ResIdx ] <> C ) ) then
        begin
        Inc( ResIdx );
        Result[ ResIdx ] := S[ SIdx ];
        end;
      if S[ SIdx ] <> C then
        begin
        if TokStart = 0 then
          TokStart := SIdx;
        Inc( TokLen );
        end;
      if ( ( S[ SIdx ] = C ) or ( SIdx = SLen ) ) and ( TokStart > 0 ) then
        begin
        CurrentTok := Copy( S, TokStart, TokLen );
        if not TokExists then
        TokExists := ( ( caseSensitive ) and ( wstrcomp( PWideChar( CurrentTok ), PWideChar( T ) ) = 0 ) ) or
          ( ( not caseSensitive ) and ( wstrlcomp( PWideChar( CurrentTok ), PWideChar( T ), Max( Length( CurrentTok ), Length( T ) ) ) = 0 ) );
        TokStart := 0;
        TokLen := 0;
        end;
      end;

    if ( ResIdx > 0 ) and ( Result[ ResIdx ] = C ) then
      SetLength( Result, ResIdx-1 )
    else
      SetLength( Result, ResIdx );
    if ( NOT TokExists ) or AllowDuplicates then
      if Result <> '' then
        Result := Result + C + T
      else
        Result := Result + T;
    end
  else
    Result := S;
end;

function DelTok( const S: WideString; const N: Integer; const B: Byte ): WideString;
begin
  Result := DelTok( S,N,WChar( B ) );
end;

function DelTok( const S: WideString; const N: Integer; const C: WideChar ): WideString;
var
  SLen, SIdx, NTok, ResIdx: Integer;
begin
  if ( S <> '' ) then
    begin
    SLen := {$IF CompilerVersion >= 24}High( s ){$ELSE}Length( s ){$IFEND};
    SetLength( Result, SLen );
    NTok := 0;
    ResIdx := 0;
    for SIdx := {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} to SLen do
      begin
      if ( ( SIdx = {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} ) and ( S[ SIdx ] <> C ) ) or ( ( SIdx > 1 ) and ( S[ SIdx ] <> C ) and ( S[ SIdx-1 ] = C ) ) then
        Inc( NTok );
      if ( NTok <> N ) and ( NTok > 0 ) and ( ( S[ SIdx ] <> C ) or ( S[ SIdx-1 ] <> C ) ) then
        begin
        Inc( ResIdx );
        Result[ ResIdx ] := S[ SIdx ];
        end;
      end;
    if ( ResIdx > 0 ) AND ( Result[ ResIdx ] = C ) then
      SetLength( Result, ResIdx-1 )
    else
      SetLength( Result, ResIdx );
    end
  else
    Result := '';
end;

function DelTok( const S: WideString; const N1, N2: Integer; const B: Byte ): WideString;
begin
  Result := DelTok( S,N1, N2,WChar( B ) );
end;

function DelTok( const S: WideString; const N1, N2: Integer; const C: WideChar ): WideString;
var
  SLen, SIdx, NTok, ResIdx: Integer;
begin
  if ( S <> '' ) then
    begin
    if N2 <= N1 then
      Result := DelTok( S, N1, C )
    else
      begin
      SLen := {$IF CompilerVersion >= 24}High( s ){$ELSE}Length( s ){$IFEND};
      SetLength( Result, SLen );
      NTok := 0;
      ResIdx := 0;
      for SIdx := {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} to SLen do
        begin
        if ( ( SIdx = {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} ) and ( S[ SIdx ] <> C ) ) or ( ( SIdx > 1 ) and ( S[ SIdx ] <> C ) and ( S[ SIdx-1 ] = C ) ) then
          Inc( NTok );
        if ( ( NTok < N1 ) or ( NTok > N2 ) ) and ( NTok > 0 ) and ( ( S[ SIdx ] <> C ) or ( S[ SIdx-1 ] <> C ) ) then
          begin
          Inc( ResIdx );
          Result[ ResIdx ] := S[ SIdx ];
          end;
        end;
      if ( ResIdx > 0 ) AND ( Result[ ResIdx ] = C ) then
        SetLength( Result, ResIdx-1 )
      else
        SetLength( Result, ResIdx );
      end;
    end
  else
    Result := '';
end;

function FindTok( const S, T: WideString; N: Integer; const B: Byte; caseSensitive : boolean = False ): Integer;
begin
  Result := FindTok( S,T,N,WideChar( Chr( B ) ),caseSensitive );
end;

function FindTok( const S, T: WideString; N: Integer; const C: WideChar; caseSensitive : boolean = False ): Integer;
var
  SIdx, SLen, TokStart, TokLen, NTok, TokMatches: Integer;
  CurrentTok: WideString;
begin
  Result := 0;
  if ( S <> '' ) and ( T <> '' ) then
  begin
    SLen := {$IF CompilerVersion >= 24}High( s ){$ELSE}Length( s ){$IFEND};
    TokStart := 0;
    TokLen := 0;
    NTok := 0;
    TokMatches := 0;
    for SIdx := {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} to SLen do
    begin
      if S[ SIdx ] <> C then
      begin
        if TokStart = 0 then
          TokStart := SIdx;
        Inc( TokLen );
      end;
      if ( ( SIdx = SLen ) or ( S[ SIdx ] = C ) ) and ( TokStart > 0 ) then
      begin
        Inc( NTok );
        CurrentTok := Copy( S, TokStart, TokLen );
        if ( ( caseSensitive ) and ( wstrcomp( PWideChar( CurrentTok ), PWideChar( T ) ) = 0 ) ) or
          ( ( not caseSensitive ) and ( wstrlcomp( PWideChar( CurrentTok ), PWideChar( T ), Max( Length( CurrentTok ), Length( T ) ) ) = 0 ) ) then
        begin
          Inc( TokMatches );
          if N = 0 then
            Inc( Result )
          else if TokMatches = N then
          begin
            Result := NTok;
            Exit;
          end;
        end;
        TokStart := 0;
        TokLen := 0;
      end;
    end;
  end;
end;

function GetTok( const S: WideString; N: Integer; const B: Byte; IgnoreEmpty : boolean = true ): WideString;
begin
  Result := GetTok( S, N, WideChar( Chr( B ) ), IgnoreEmpty );
end;

function GetTok( const S: WideString; N: Integer; const C: WideChar; IgnoreEmpty : boolean = true ): WideString;
var
  SLen, SIdx, NTok, ResIdx: Integer;
begin
  Result := '';
  if ( S = '' ) OR ( N <= 0 ) then
    Exit;

  SLen := {$IF CompilerVersion >= 24}High( s ){$ELSE}Length( s ){$IFEND};
  SetLength( Result, SLen );
  NTok := 0;
  ResIdx := 0;
  for SIdx := {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} to SLen do
    begin
    if IgnoreEmpty then
      begin
      if ( ( SIdx = {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} ) and ( S[ SIdx ] <> C ) ) then
        Inc( NTok )
      else if ( sIdx > {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} ) then
        begin
        if ( ( S[ SIdx ] <> C ) and ( ( S[ SIdx-1 ] = C ) ) ) then
          Inc( NTok );
        end;
      end
    else
      begin
      if ( ( ( SIdx = {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} ) and ( S[ SIdx ] <> C ) ) or ( S[ SIdx ] = C ) ) then
        Inc( NTok );
      end;

    if ( NTok = N ) and ( S[ SIdx ] <> C ) then
      begin
      Inc( ResIdx );
      Result[ ResIdx ] := S[ SIdx ];
      end;
    end;
  SetLength( Result, ResIdx );
end;

function GetTok( const S: WideString; const N1, N2: Integer; const B: Byte; IgnoreEmpty : boolean = true ): WideString;
begin
  Result := GetTok( S, N1, N2, WideChar( Chr( B ) ), IgnoreEmpty );
end;

function GetTok( const S: WideString; const N1, N2: Integer; const C: WideChar; IgnoreEmpty : boolean = true ): WideString;
var
  SLen, SIdx, NTok, ResIdx: Integer;
begin
  Result := '';
  if ( S = '' ) OR ( N1 <= 0 ) then
    Exit;

  if N2 <= N1 then
    begin
    Result := GetTok( S, N1, C, IgnoreEmpty ); 
    Exit;
    end;

  SLen := {$IF CompilerVersion >= 24}High( s ){$ELSE}Length( s ){$IFEND};
  SetLength( Result, SLen );
  NTok := 0;
  ResIdx := 0;
  for SIdx := {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} to SLen do
    begin
    if IgnoreEmpty then
      begin
      if ( SIdx = {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} ) and ( S[ SIdx ] <> C ) then
        Inc( NTok )
      else if ( SIdx > 1 ) then
        begin
        if ( S[ SIdx ] <> C ) and ( S[ SIdx-1 ] = C ) then
          Inc( NTok );
        end;
      end
    else
      begin
      if ( SIdx = {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} ) and ( S[ SIdx ] <> C ) then
        Inc( NTok )
      else if ( SIdx > {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} ) then
        begin
        if ( S[ SIdx ] = C ) then
          Inc( NTok );
        end;
      end;

    if ( NTok < N1 ) then
      Continue;
    if ( NTok > N2 ) then
      break;

    if ( SIdx > 1 ) then
      begin
      if ( S[ SIdx ] = C ) and ( S[ SIdx-1 ] = C ) then
        Continue;
      end;

    Inc( ResIdx );
    Result[ ResIdx ] := S[ SIdx ];
    end;

  if ( ResIdx > 0 ) then
    begin
    if ( Result[ ResIdx ] = C ) then
      SetLength( Result, ResIdx-1 )
    else
      SetLength( Result, ResIdx );
    end
  else
    SetLength( Result, ResIdx );
end;

function InsTok( const S, T: WideString; N: Integer; const B: Byte ): WideString;
begin
  Result := InsTok( S, T, N, WChar( B ) );
end;

function InsTok( const S, T: WideString; N: Integer; const C: WideChar ): WideString;
var
  SLen, SIdx, ResIdx, NTok, TokLen: Integer;
  Inserted: Boolean;
begin
  if ( T = '' ) or ( N <= 0 ) then
    Result := S
  else if S = '' then
    Result := T
  else
    begin
    SLen := {$IF CompilerVersion >= 24}High( s ){$ELSE}Length( s ){$IFEND};
    ResIdx := 0;
    NTok := 0;
    TokLen := Length( T );
    Inserted := False;
    SetLength( Result, SLen+TokLen+2 );
    for SIdx := {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} to SLen+1 do
      begin
      if ( SIdx <> SLen+1 ) then
        begin
        if ( ( SIdx = {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} ) and ( S[ SIdx ] <> C ) ) or ( ( SIdx > 1 ) and ( S[ SIdx ] <> C ) and ( S[ SIdx-1 ] = C ) ) then
          Inc( NTok );
        end;
      if ( ( SIdx = SLen+1 ) or ( N = NTok ) ) and not Inserted then
        begin
        if ( ResIdx > 0 ) and ( Result[ ResIdx ] <> C ) then
          begin
          Inc( ResIdx );
          Result[ ResIdx ] := C;
          end;
        Inc( ResIdx );
        CopyMemory( @Result[ ResIdx ], PWideChar( T ), TokLen*SizeOf( WideChar ) );
        Inc( ResIdx, TokLen );
        Result[ ResIdx ] := C;
        Inserted := True;
        end;
      if ( SIdx <> SLen+1 ) then
        if ( ( S[ SIdx ] <> C ) or ( ( ResIdx > 0 ) and ( Result[ ResIdx ] <> C ) ) ) then
          begin
          Inc( ResIdx );
          Result[ ResIdx ] := S[ SIdx ];
          end;
      end;
    if ( ResIdx > 0 ) AND ( Result[ ResIdx ] = C ) then
      SetLength( Result, ResIdx-1 )
    else
      SetLength( Result, ResIdx );
    end;
end;

function IsTok( const S, T: WideString; const B: Byte; caseSensitive : boolean = False ): Boolean;
begin
  Result := IsTok( S, T, WideChar( Chr( B ) ), caseSensitive );
end;

function IsTok( const S, T: WideString; const C: WideChar; caseSensitive : boolean = False ): Boolean;
var
  SLen, SIdx, TokStart, TokLen: Integer;
  CurrentTok: WideString;
begin
  Result := False;
  if ( S <> '' ) and ( T <> '' ) then
    begin
    SLen := {$IF CompilerVersion >= 24}High( s ){$ELSE}Length( s ){$IFEND};
    TokStart := 0;
    TokLen := 0;
    for SIdx := {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} to SLen do
      begin
      if S[ SIdx ] <> C then
        begin
        if TokStart = 0 then
          TokStart := SIdx;
        Inc( TokLen );
        end;
      if ( ( S[ SIdx ] = C ) or ( SIdx = SLen ) ) and ( TokStart > 0 ) then
        begin
        CurrentTok := Copy( S, TokStart, TokLen );
        if ( ( caseSensitive ) and ( wstrcomp( PWideChar( CurrentTok ), PWideChar( T ) ) = 0 ) ) or
          ( ( not caseSensitive ) and ( wstrlcomp( PWideChar( CurrentTok ), PWideChar( T ), Max( Length( CurrentTok ), Length( T ) ) ) = 0 ) ) then
          begin
          Result := True;
          Exit;
          end;
        TokStart := 0;
        TokLen := 0;
        end;
      end;
    end;
end;

function MatchTok( const S, T: WideString; N: Integer; const B: Byte; caseSensitive : boolean = False ): Variant;
begin
  result := MatchTok( S, T, N, WideChar( Chr( B ) ), caseSensitive );
end;

function MatchTok( const S, T: WideString; N: Integer; const C: WideChar; caseSensitive : boolean = False ): Variant;
var
  SIdx, SLen, TokStart, TokLen, TokMatches: Integer;
begin
  Result := 0;
  if ( S <> '' ) and ( T <> '' ) then
  begin
    SLen := {$IF CompilerVersion >= 24}High( s ){$ELSE}Length( s ){$IFEND};
    TokStart := 0;
    TokLen := 0;
    TokMatches := 0;
    for SIdx := {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} to SLen do
    begin
      if S[ SIdx ] <> C then
        begin
        if TokStart = 0 then
          TokStart := SIdx;
        Inc( TokLen );
        end;
      if ( ( SIdx = SLen ) or ( S[ SIdx ] = C ) ) and ( TokStart > 0 ) then
        begin
        if ( ( caseSensitive AND ( Pos( T, Copy( S, TokStart, TokLen ) ) > 0 ) ) or ( NOT caseSensitive AND ( Pos( LowerCase( T ), LowerCase( Copy( S, TokStart, TokLen ) ) ) > 0 ) ) ) then
          begin
          Inc( TokMatches );
          if N = 0 then
            Inc( Result )
          else if TokMatches = N then
            Result := Copy( S, TokStart, TokLen );
          end;
        TokStart := 0;
        TokLen := 0;
        end;
    end;
  end;
end;

function NumTok( const S: WideString; const B: Byte; IgnoreEmpty : boolean = true ): Integer;
begin
  Result := NumTok( S, WideChar( Chr( B ) ), IgnoreEmpty );
end;

function NumTok( const S: WideString; const C: WideChar; IgnoreEmpty : boolean = true ): Integer;
var
  SIdx: Integer;
begin
  Result := 0;
  for SIdx := {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} to {$IF CompilerVersion >= 24}High( s ){$ELSE}Length( s ){$IFEND} do
    begin
    if IgnoreEmpty then
      begin
      if ( ( SIdx = {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} ) and ( S[ SIdx ] <> C ) ) then
        Inc( Result )
      else if ( SIdx > {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} ) then
        begin
        if ( ( S[ SIdx ] <> C ) and ( ( S[ SIdx-1 ] = C ) ) ) then
          Inc( Result )
        end;
      end
    else
      begin
      if ( ( ( SIdx = {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} ) and ( S[ SIdx ] <> C ) ) or ( S[ SIdx ] = C ) ) then
        Inc( Result );
      end;
    end;
end;

function PutTok( const S, T: WideString; N: Integer; const B: Byte ): WideString;
begin
  Result := PutTok( S, T, N, WChar( B ) );
end;

function PutTok( const S, T: WideString; N: Integer; const C: WideChar ): WideString;
var
  SLen, SIdx, ResIdx, NTok, TokLen: Integer;
  Replaced: Boolean;
begin
  if ( T = '' ) or ( N <= 0 ) then
    Result := S
  else if S = '' then
    Result := T
  else
    begin
    SLen := {$IF CompilerVersion >= 24}High( s ){$ELSE}Length( s ){$IFEND};
    ResIdx := 0;
    NTok := 0;
    TokLen := Length( T );
    Replaced := False;
    SetLength( Result, SLen+TokLen+2 );
    for SIdx := {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} to SLen+1 do
      begin
      if ( SIdx <> SLen+1 ) then
        begin
        if ( ( SIdx = {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} ) and ( S[ SIdx ] <> C ) ) or ( ( SIdx > 1 ) and ( S[ SIdx ] <> C ) and ( S[ SIdx-1 ] = C ) ) then
          Inc( NTok );
        end;
      if ( ( SIdx = SLen+1 ) or ( N = NTok ) ) and not Replaced then
        begin
        if ( ResIdx > 0 ) and ( Result[ ResIdx ] <> C ) then
          begin
          Inc( ResIdx );
          Result[ ResIdx ] := C;
          end;
        Inc( ResIdx );
        CopyMemory( @Result[ ResIdx ], PWideChar( T ), TokLen*SizeOf( WideChar ) );
        Inc( ResIdx, TokLen );
        Result[ ResIdx ] := C;
        Replaced := True;
        end
      else
        begin
        if ( N <> NTok ) and ( SIdx <> SLen+1 ) then
          begin
          if ( ( S[ SIdx ] <> C ) or ( ( ResIdx > 0 ) and ( Result[ ResIdx ] <> C ) ) ) then
            begin
            Inc( ResIdx );
            Result[ ResIdx ] := S[ SIdx ];
            end;
          end;
        end;
      end;
    if ( ResIdx > 0 ) AND ( Result[ ResIdx ] = C ) then
      SetLength( Result, ResIdx-1 )
    else
      SetLength( Result, ResIdx );
    end;
end;

function RemTok( const S, T: WideString; N: Integer; const B: Byte; const caseSensitive : boolean = False ): WideString;
begin
  result := RemTok( S,T,N,WideChar( Chr( B ) ), caseSensitive );
end;

function RemTok( const S, T: WideString; N: Integer; const C: WideChar; const caseSensitive : boolean = False ): WideString;
var
  SLen, SIdx, ResIdx, TokStart, TokLen, TokMatches: Integer;
  CurrentTok: WideString;
  Removed: Boolean;
begin
  result := '';
  if ( S = '' ) OR ( T = '' ) then
    Exit;
  SLen := {$IF CompilerVersion >= 24}High( s ){$ELSE}Length( s ){$IFEND};
  ResIdx := 0;
  TokStart := 0;
  TokLen := 0;
  Removed := False;
  TokMatches := 0;
  SetLength( Result, SLen+1 );
  for SIdx := {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} to SLen do
    begin
    if S[ SIdx ] <> C then
      begin
      if TokStart = 0 then
        TokStart := SIdx;
      Inc( TokLen );
      end;
    if ( ( SIdx = SLen ) or ( S[ SIdx ] = C ) ) and ( TokStart > 0 ) then
    try
      CurrentTok := Copy( S, TokStart, TokLen );
      if ( caseSensitive and ( CurrentTok = T ) ) or ( NOT caseSensitive and ( LowerCase( CurrentTok ) = LowerCase( T ) ) ) then
        begin
        if N > 0 then
          Inc( TokMatches )
        else
          Continue;
        end;
      if ( N > 0 ) and ( TokMatches = N ) and not Removed then
        Removed := True
      else
        begin
        Inc( ResIdx );
        CopyMemory( @Result[ ResIdx ], @CurrentTok[ 1 ], TokLen*SizeOf( WideChar ) );
        Inc( ResIdx, TokLen );
        Result[ ResIdx ] := C;
        end;
    finally
      TokStart := 0;
      TokLen := 0;
    end;
    end;
  if ( ResIdx > 0 ) AND ( Result[ ResIdx ] = C ) then
    SetLength( Result, ResIdx-1 )
  else
    SetLength( Result, ResIdx );
end;

function ExTok( const S : WideString; T1, T2: Integer; const B: Byte ): WideString;
begin
  result := ExTok( S, T1, T2, WChar( B ) );
end;

function ExTok( const S : WideString; T1, T2: Integer; const C: WideChar ): WideString;
var
  help : WideString;
begin
  help := GetTok( s, T1, C );
  result := PutTok( s, GetTok( s, T2, C ), T1, C );
  result := PutTok( result, help, T2, C );
end;

function MoveTok( const S : WideString; T1, T2: Integer; const B: Byte ): WideString;
begin
  result := MoveTok( S, T1, T2, WChar( B ) );
end;

function MoveTok( const S : WideString; T1, T2: Integer; const C: WideChar ): WideString;
var
  help : WideString;
begin
  help := GetTok( s, T1, C );
  result := DelTok( s, T1, C );
  result := InsTok( result, help, T2, C );
end;

function CloneTok( const S : WideString; T1, T2: Integer; const B: Byte ): WideString;
begin
  result := CloneTok( S, T1, T2, WChar( B ) );
end;

function CloneTok( const S : WideString; T1, T2: Integer; const C: WideChar ): WideString;
var
  help : WideString;
begin
  help := GetTok( s, T1, C );
  result := InsTok( s, help, T2, C );
end;

function RepTok( const S, T, T2: WideString; N: Integer; const B: Byte; const caseSensitive : boolean = False ): WideString;
begin
  result := RepTok( S, T, T2, N, WideChar( Chr( B ) ), caseSensitive );
end;

function RepTok( const S, T, T2: WideString; N: Integer; const C: WideChar; const caseSensitive : boolean = False ): WideString;
var
  SLen, SIdx, ResIdx, TokStart, TokLen, TokMatches, TLen: Integer;
  CurrentTok: WideString;
begin
  if ( S <> '' ) and ( T <> '' ) and ( T2 <> '' ) then
  begin
    SLen := {$IF CompilerVersion >= 24}High( s ){$ELSE}Length( s ){$IFEND};
    ResIdx := 0;
    TokStart := 0;
    TokLen := 0;
    TokMatches := 0;
    TLen := Length( T2 );
    SetLength( Result, SLen*Length( T2 ) );
    for SIdx := {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} to SLen do
    begin
      if S[ SIdx ] <> C then
      begin
        if TokStart = 0 then
          TokStart := SIdx;
        Inc( TokLen );
      end;
      if ( ( SIdx = SLen ) or ( S[ SIdx ] = C ) ) and ( TokStart > 0 ) then
      try
        CurrentTok := Copy( S, TokStart, TokLen );
        if ( ( caseSensitive ) and ( wstrcomp( PWideChar( CurrentTok ), PWideChar( T ) ) = 0 ) ) or
          ( ( not caseSensitive ) and ( wstrlcomp( PWideChar( CurrentTok ), PWideChar( T ), Max( Length( CurrentTok ), Length( T ) ) ) = 0 ) ) then
        begin
          Inc( TokMatches );
          if ( N = 0 ) or ( N = TokMatches ) then
          begin
            Inc( ResIdx );
            CopyMemory( @Result[ ResIdx ], @T2[ 1 ], TLen*SizeOf( WideChar ) );
            Inc( ResIdx, TLen );
            Result[ ResIdx ] := C;
            Continue;
          end;
        end;
        Inc( ResIdx );
        CopyMemory( @Result[ ResIdx ], @CurrentTok[ 1 ], TokLen*SizeOf( WideChar ) );
        Inc( ResIdx, TokLen );
        Result[ ResIdx ] := C;
      finally
        TokStart := 0;
        TokLen := 0;
      end;
    end;
    if ( ResIdx > 0 ) AND ( Result[ ResIdx ] = C ) then
      SetLength( Result, ResIdx-1 )
    else
      SetLength( Result, ResIdx );
  end;
end;

function Tokenize( const S: TWStringDynArray; const B: Byte; caseSensitive : boolean = False; AllowDuplicates : boolean = false ): WideString;
begin
  result := Tokenize( S, WideChar( Chr( B ) ), caseSensitive, AllowDuplicates );
end;

function Tokenize( const S: TWStringDynArray; const C: WideChar; caseSensitive : boolean = False; AllowDuplicates : boolean = false ): WideString;
var
  i : integer;
begin
  result := '';

  for i := 0 to Length( S )-1 do
    result := AddTok( result, S[ i ], C, caseSensitive, AllowDuplicates );
end;

function Tokenize( const S: WideString; const B: Byte; IgnoreEmpty : boolean = true ): TStringDynArray;
begin
  result := Tokenize( S, WideChar( Chr( B ) ), IgnoreEmpty );
end;

function Tokenize( const S: WideString; const C: WideChar; IgnoreEmpty : boolean = true ): TStringDynArray;
var
  SLen, SIdx, NTok, TokStart, TokLen: Integer;
begin
  SetLength( Result, 0 );
  if ( S = '' ) then
    Exit;

  SLen := {$IF CompilerVersion >= 24}High( s ){$ELSE}Length( s ){$IFEND};
  SetLength( Result, SLen );
  TokStart := 0;
  NTok := 0;
  TokLen := 0;

  for SIdx := {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} to SLen do
    begin
    if S[ SIdx ] <> C then
      begin
      if TokStart = 0 then
        TokStart := SIdx;
      Inc( TokLen );
      end;
    if ( ( SIdx = SLen ) or ( S[ SIdx ] = C ) ) and ( ( NOT IgnoreEmpty ) OR ( TokStart > 0 ) ) then
      begin
      Inc( NTok );
      if ( TokStart > 0 ) then
        Result[ NTok-1 ] := Copy( S, TokStart, TokLen );
      TokStart := 0;
      TokLen := 0;
      end;
    end;
  SetLength( Result, NTok );
end;

function WildTok( const S, T: WideString; N: Integer; const B: Byte ): Variant;
begin
  result := WildTok( S,T,N,WChar( B ) );
end;

function WildTok( const S, T: WideString; N: Integer; const C: WideChar ): Variant;
var
  SIdx, SLen, TokStart, TokLen, TokMatches: Integer;
  CurrentTok: WideString;
begin
  Result := 0;
  if ( S <> '' ) and ( T <> '' ) then
    begin
    SLen := {$IF CompilerVersion >= 24}High( s ){$ELSE}Length( s ){$IFEND};
    TokStart := 0;
    TokLen := 0;
    TokMatches := 0;
    for SIdx := {$IF CompilerVersion >= 24}Low( s ){$ELSE}1{$IFEND} to SLen do
      begin
      if S[ SIdx ] <> C then
        begin
        if TokStart = 0 then
          TokStart := SIdx;
        Inc( TokLen );
        end;
      if ( ( SIdx = SLen ) or ( S[ SIdx ] = C ) ) and ( TokStart > 0 ) then
        begin
        CurrentTok := Copy( S, TokStart, TokLen );
        if IsWm( CurrentTok, T ) then
          begin
          Inc( TokMatches );
          if N = 0 then
            Inc( Result )
          else if TokMatches = N then
            Result := CurrentTok;
          end;
        TokStart := 0;
        TokLen := 0;
        end;
      end;
    end;
end;

function SortTok( const S : WideString; B : Byte ): WideString;
begin
  result := SortTok( S, '', WChar( B ) );
end;

function SortTok( const S : WideString; C : WideChar ): WideString;
begin
  result := SortTok( S, '', C );
end;

function SortTok( const S, Options : WideString; B : Byte ): WideString;
begin
  result := SortTok( S, Options, WChar( B ) );
end;

function SortTok( const S, Options : WideString; C : WideChar ): WideString;
var
  i     : integer;
  StrL  : TStringList;
  StrLS : TStringList;
begin
  Result := '';
  if ( S = '' ) then
    Exit;
  StrL := TStringList.Create;
  for i := 1 to NumTok( S, C ) do
    StrL.Add( GetTok( S, i, C ) );

  if ( Isin( Options, 'r' ) ) then
    begin
    if ( Isin( Options, 'd' ) ) then
      begin
      StrL.Sorted := True;
      StrLS := TStringList.Create;
      for i := StrL.Count-1 downto 0 do
        StrLS.Add( StrL.Strings[ i ] );
      StrL.Assign( StrLS );
      StrLS.free;
      end
    else // if ( Isin( Options, 'a' ) ) then
      StrL.Sorted := True;
    end
  else //if ( Isin( Options, 'n' ) ) then
    begin

    StrL.CustomSort( NaturalSortDesc );

    if ( Isin( Options, 'd' ) ) then
      begin
      if Isin( Options, 'c' ) then
        StrL.CustomSort( NaturalSortDescCS )
      else
        StrL.CustomSort( NaturalSortDesc );
      end
    else // if ( Isin( Options, 'a' ) ) then
      begin
      if Isin( Options, 'c' ) then
        StrL.CustomSort( NaturalSortAscCS )
      else
        StrL.CustomSort( NaturalSortAsc );
      end;
    end;

  for i := 0 to StrL.Count-1 do
    result := AddTok( Result, StrL[ i ], C );

  StrL.free;
end;
{$ENDIF UNICODE}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// StringList.CustomSort functions
function NaturalSortAsc( List: TStringList; Index1, Index2: Integer ): Integer;
begin
  result := StrNatCompare( List.Strings[ Index1 ], List.Strings[ Index2 ], false )
end;

function NaturalSortDesc( List: TStringList; Index1, Index2: Integer ): Integer;
begin
  result := -NaturalSortAsc( List, Index1, Index2 );
end;

function NaturalSortAscCS( List: TStringList; Index1, Index2: Integer ): Integer;
begin
  result := StrNatCompare( List.Strings[ Index1 ], List.Strings[ Index2 ], true )
end;

function NaturalSortDescCS( List: TStringList; Index1, Index2: Integer ): Integer;
begin
  result := -NaturalSortAscCS( List, Index1, Index2 );
end;

function DateSortAsc( List: TStringList; Index1, Index2: Integer ): Integer;
  function LeftStr( const AText: AnsiString; const ACount: Integer ): AnsiString; overload;
  begin
    Result := Copy( WideString( AText ), 1, ACount );
  end;

  function LeftStr( const AText: WideString; const ACount: Integer ): WideString; overload;
  begin
    Result := Copy( AText, 1, ACount );
  end;
var
  S1, S2 : string;
  D1, D2 : TDateTime;
  c32    : Integer;
begin
//  result := StrNatCompare( Grid.Rows[ Index1 ].Strings[ ACol ], Grid.Rows[ Index2 ].Strings[ ACol ], false )

  S1 := List.Strings[ Index1 ];
  c32 := Pos( ' ', S1 );
  if ( c32 <> 0 ) then
    S1 := LeftStr( S1, c32 );
  D1 := StrToDateDef( S1, 0 );
  if ( D1 <> 0 ) then
    S1 := FloatToStr( D1 );

  S2 := List.Strings[ Index2 ];
  c32 := Pos( ' ', S2 );
  if ( c32 <> 0 ) then
    S2 := LeftStr( S2, c32 );
  D2 := StrToDateDef( S2, 0 );
  if ( D2 <> 0 ) then
    S2 := FloatToStr( D2 );

  result := StrNatCompare( S1, S2, false )
end;

function DateSortDesc( List: TStringList; Index1, Index2: Integer ): Integer;
begin
  result := -DateSortAsc( List, Index1, Index2 );
end;

{$IFNDEF UNICODE}
{$IFDEF USE_UNICODE}
function NaturalSortAsc( List: TWideStringList; Index1, Index2: Integer ): Integer;
begin
  result := StrNatCompare( List.Strings[ Index1 ], List.Strings[ Index2 ], false )
end;

function NaturalSortDesc( List: TWideStringList; Index1, Index2: Integer ): Integer;
begin
  result := -NaturalSortAsc( List, Index1, Index2 );
end;

function NaturalSortAscCS( List: TWideStringList; Index1, Index2: Integer ): Integer;
begin
  result := StrNatCompare( List.Strings[ Index1 ], List.Strings[ Index2 ], true )
end;

function NaturalSortDescCS( List: TWideStringList; Index1, Index2: Integer ): Integer;
begin
  result := -NaturalSortAscCS( List, Index1, Index2 );
end;

function DateSortAsc( List: TWideStringList; Index1, Index2: Integer ): Integer;
  function LeftStr( const AText: AnsiString; const ACount: Integer ): AnsiString; overload;
  begin
    Result := Copy( WideString( AText ), 1, ACount );
  end;

  function LeftStr( const AText: WideString; const ACount: Integer ): WideString; overload;
  begin
    Result := Copy( AText, 1, ACount );
  end;
var
  S1, S2 : string;
  D1, D2 : TDateTime;
  c32    : Integer;
begin
//  result := StrNatCompare( Grid.Rows[ Index1 ].Strings[ ACol ], Grid.Rows[ Index2 ].Strings[ ACol ], false )

  S1 := List.Strings[ Index1 ];
  c32 := Pos( ' ', S1 );
  if ( c32 <> 0 ) then
    S1 := LeftStr( S1, c32 );
  D1 := StrToDateDef( S1, 0 );
  if ( D1 <> 0 ) then
    S1 := FloatToStr( D1 );

  S2 := List.Strings[ Index2 ];
  c32 := Pos( ' ', S2 );
  if ( c32 <> 0 ) then
    S2 := LeftStr( S2, c32 );
  D2 := StrToDateDef( S2, 0 );
  if ( D2 <> 0 ) then
    S2 := FloatToStr( D2 );

  result := StrNatCompare( S1, S2, false )
end;

function DateSortDesc( List: TWideStringList; Index1, Index2: Integer ): Integer;
begin
  result := -DateSortAsc( List, Index1, Index2 );
end;
{$ENDIF}
{$IFDEF USE_SYNUNICODE}
function NaturalSortAscU( String1, String2 : UnicodeString ): Integer;
begin
  result := StrNatCompare( String1, String2, false )
end;

function NaturalSortDescU( String1, String2 : UnicodeString ): Integer;
begin
  result := -NaturalSortAscU( String1, String2 );
end;

function NaturalSortAscCSU( String1, String2 : UnicodeString ): Integer;
begin
  result := StrNatCompare( String1, String2, true )
end;

function NaturalSortDescCSU( String1, String2 : UnicodeString ): Integer;
begin
  result := -NaturalSortAscCSU( String1, String2 );
end;

function DateSortAscU( String1, String2 : UnicodeString ): Integer;
  function LeftStr( const AText: AnsiString; const ACount: Integer ): AnsiString; overload;
  begin
    Result := Copy( WideString( AText ), 1, ACount );
  end;

  function LeftStr( const AText: WideString; const ACount: Integer ): WideString; overload;
  begin
    Result := Copy( AText, 1, ACount );
  end;
var
  S1, S2 : string;
  D1, D2 : TDateTime;
  c32    : Integer;
begin
//  result := StrNatCompare( Grid.Rows[ Index1 ].Strings[ ACol ], Grid.Rows[ Index2 ].Strings[ ACol ], false )

  S1 := String1;
  c32 := Pos( ' ', S1 );
  if ( c32 <> 0 ) then
    S1 := LeftStr( S1, c32 );
  D1 := StrToDateDef( S1, 0 );
  if ( D1 <> 0 ) then
    S1 := FloatToStr( D1 );

  S2 := String2;
  c32 := Pos( ' ', S2 );
  if ( c32 <> 0 ) then
    S2 := LeftStr( S2, c32 );
  D2 := StrToDateDef( S2, 0 );
  if ( D2 <> 0 ) then
    S2 := FloatToStr( D2 );

  result := StrNatCompare( S1, S2, false )
end;

function DateSortDescU( String1, String2 : UnicodeString ): Integer;
begin
  result := -DateSortAscU( String1, String2 );
end;
{$ENDIF}
{$ENDIF}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function NumberToWord( ChkER: boolean; ER: string; D: double ): string;
const
  Ones: array[ 0..9 ] of string = ( 'Zero', 'One', 'Two', 'Three', 'Four', 'Five', 'Six', 'Seven', 'Eight', 'Nine' );
  Teens: array[ 10..19 ] of string = ( 'Ten', 'Eleven', 'Twelve', 'Thirteen', 'Fourteen', 'Fifteen', 'Sixteen', 'Seventeen', 'Eighteen', 'Nineteen' );
  Tens: array[ 2..9 ] of string = ( 'Twenty', 'Thirty', 'Forty', 'Fifty', 'Sixty', 'Seventy', 'Eighty', 'Ninety' );
  Suffix: array[ 0..5 ] of string = ( 'Hundred', 'Thousand', 'Million', 'Billion', 'Trillion', 'Quadrillion' );
var
  RStr, sDec, sFrac: string;
  vFrac: double;
  I, vDec : integer;
  TruncTens, TruncHund, TruncThou, TruncMio, TruncBio, TruncTril, iD: Int64;
  ReadFrac: boolean;

    function fTensENG( xD: integer ): string;
    var
      BTStr: string;
    begin
       if ( xD >= 0 ) and ( xD <= 9 ) then
         BTStr := Ones[ xD ]
       else if ( xD >= 10 ) and ( xD <= 19 ) then
         BTStr := Teens[ xD ]
       else if ( xD >= 20 ) and ( xD <= 99 ) then
         begin
         if ( StrToInt( RightStr( IntToStr( xD ), 1 ) ) = 0 ) then
           BTStr := Tens[ StrToInt( LeftStr( IntToStr( xD ), 1 ) ) ]
         else
           BTStr := Tens[ StrToInt( LeftStr( IntToStr( xD ), 1 ) ) ] + ' ' +
                    Ones[ StrToInt( RightStr( IntToStr( xD ), 1 ) ) ]
         end;
       Result := BTStr;
    end; 
    function fHundENG( xD: integer ): string;
    var BTStr: string;
    begin
       BTStr := Ones[ StrToInt( LeftStr( IntToStr( xD ), 1 ) ) ] + ' ' + Suffix[ 0 ];
       TruncTens := StrToInt( RightStr( IntToStr( xD ), 2 ) );
       if ( TruncTens <> 0 ) then
          BTStr := BTStr + ' and ' + fTensENG( TruncTens );
       Result := BTStr;
    end; 
    function fThouENG( xD: Integer ): string;
    var
      BTStr: string;
    begin
       if ( xD >= 1000 ) and ( xD <= 9999 ) then
         begin
         BTStr := Ones[ StrToInt( LeftStr( IntToStr( xD ), 1 ) ) ] + ' ' + Suffix[ 1 ];
         TruncHund := StrToInt( RightStr( IntToStr( xD ), 3 ) );
         TruncTens := StrToInt( RightStr( IntToStr( xD ), 2 ) );
         if ( TruncHund <> 0 ) and ( TruncTens = 0 ) then
           BTStr := BTStr + 'and ' + Ones[ StrToInt( LeftStr( IntToStr( xD ), 1 ) ) ] + ' ' + Suffix[ 0 ]
         else if ( TruncHund <> 0 ) and ( TruncTens <> 0 ) then
           BTStr := BTStr + ', ' + fHundENG( TruncHund );
         end
       else if ( Trunc( xD ) >= 10000 ) and ( Trunc( xD ) <= 19999 ) then
         begin
         BTStr := Teens[ StrToInt( LeftStr( IntToStr( xD ), 2 ) ) ] + ' ' + Suffix[ 1 ];
         TruncHund := StrToInt( RightStr( IntToStr( xD ), 3 ) );
         TruncTens := StrToInt( RightStr( IntToStr( xD ), 2 ) );
         if ( TruncHund <> 0 ) and ( TruncTens = 0 ) then
           BTStr := BTStr + ' and ' + Ones[ StrToInt( LeftStr( IntToStr( TruncHund ), 1 ) ) ] + ' ' + Suffix[ 0 ]
         else if ( TruncHund <> 0 ) and ( TruncTens <> 0 ) then
           BTStr := BTStr + ', ' + fHundENG( TruncHund );
         end
       else if ( Trunc( xD ) >= 20000 ) and ( Trunc( xD ) <= 99999 ) then
         begin
         if ( StrToInt( MidStr( IntToStr( xD ), 2, 1 ) ) = 0 ) then
           BTStr := Tens[ StrToInt( LeftStr( IntToStr( xD ), 1 ) ) ] + ' ' + Suffix[ 1 ]
         else
           BTStr := Tens[ StrToInt( LeftStr( IntToStr( xD ), 1 ) ) ] + ' ' +
                    Ones[ StrToInt( MidStr( IntToStr( xD ), 2, 1 ) ) ] + ' ' + Suffix[ 1 ];
         TruncHund := StrToInt( RightStr( IntToStr( xD ), 3 ) );
         TruncTens := StrToInt( RightStr( IntToStr( xD ), 2 ) );
         if ( TruncHund <> 0 ) and ( TruncTens = 0 ) then
           BTStr := BTStr + 'and ' + Ones[ StrToInt( LeftStr( IntToStr( TruncHund ), 1 ) ) ] + ' ' + Suffix[ 0 ]
         else if ( TruncHund <> 0 ) and ( TruncTens <> 0 ) then
           BTStr := BTStr + ', ' + fHundENG( TruncHund );
         end
       else if ( xD >= 100000 ) and ( xD <= 9999999 ) then
         begin
         BTStr := fHundENG( StrToInt( LeftStr( IntToStr( xD ), 3 ) ) ) + ' ' + Suffix[ 1 ];
         TruncHund := StrToInt( RightStr( IntToStr( xD ), 3 ) );
         TruncTens := StrToInt( RightStr( IntToStr( xD ), 2 ) );
         if ( TruncHund <> 0 ) and ( TruncTens = 0 ) then
           BTStr := BTStr + 'and ' + Ones[ StrToInt( LeftStr( IntToStr( xD ), 1 ) ) ] + ' ' + Suffix[ 0 ]
         else if ( TruncHund <> 0 ) and ( TruncTens <> 0 ) then
           BTStr := BTStr + ', ' + fHundENG( TruncHund );
         end;
       Result := BTStr;
    end; 
    function fMioENG( xD: Int64 ): string;
    var
      BTStr: string;
    begin
       if ( xD >= 1000000 ) and ( xD <= 9999999 ) then
         begin
         BTStr := Ones[ StrToInt( LeftStr( IntToStr( xD ), 1 ) ) ] + ' ' + Suffix[ 2 ];
         TruncThou := StrToInt( RightStr( IntToStr( xD ), 6 ) );
         if ( TruncThou <> 0 ) then
           BTStr := BTStr + ', ' + fThouENG( TruncThou );
         end
       else if ( xD >= 10000000 ) and ( xD <= 19999999 ) then
         begin
         BTStr := Teens[ StrToInt( LeftStr( IntToStr( xD ), 2 ) ) ] + ' ' + Suffix[ 2 ];
         TruncThou := StrToInt( RightStr( IntToStr( xD ), 6 ) );
         if ( TruncThou <> 0 ) then
           BTStr := BTStr + ', ' + fThouENG( TruncThou );
         end
       else if ( xD >= 20000000 ) and ( xD <= 99999999 ) then
         begin
         if ( StrToInt( LeftStr( IntToStr( xD ), 2 ) ) = 0 ) then
           BTStr := Tens[ StrToInt( LeftStr( IntToStr( xD ), 2 ) ) ] + ' ' + Suffix[ 2 ]
         else
           BTStr := Tens[ StrToInt( LeftStr( IntToStr( xD ), 2 ) ) ] + ' ' +
                    Ones[ StrToInt( LeftStr( IntToStr( xD ), 2 ) ) ] + ' ' + Suffix[ 2 ];
         TruncThou := StrToInt( RightStr( IntToStr( xD ), 6 ) );
         if ( TruncThou <> 0 ) then
           BTStr := BTStr + ', ' + fThouENG( TruncThou );
         end
       else if ( xD >= 100000000 ) and ( xD <= 999999999 ) then
         begin
         BTStr := fHundENG( StrToInt( LeftStr( IntToStr( xD ), 3 ) ) ) + ' ' + Suffix[ 2 ];
         TruncThou := StrToInt( RightStr( IntToStr( xD ), 6 ) );
         if ( TruncThou <> 0 ) then
           BTStr := BTStr + ', ' + fThouENG( TruncThou );
         end
       else
         begin
         TruncThou := StrToInt( RightStr( IntToStr( xD ), 6 ) );
         if ( TruncThou <> 0 ) then
           BTStr := BTStr + fThouENG( TruncThou );
         end;
       Result := BTStr;
    end; 
    function fBioENG( xD: Int64 ): string;
    var
      BTStr: string;
    begin
       if ( xD >= 1000000000 ) and ( xD <= 9999999999 ) then
         begin
         BTStr := Ones[ StrToInt64( LeftStr( IntToStr( xD ), 1 ) ) ] + ' ' + Suffix[ 3 ];
         TruncMio := StrToInt64( RightStr( IntToStr( xD ), 9 ) );
         if ( TruncMio <> 0 ) then
           BTStr := BTStr + ', ' + fMioENG( TruncMio );
         end
       else if ( xD >= 10000000000 ) and ( xD <= 19999999999 ) then
         begin
         BTStr := Teens[ StrToInt64( LeftStr( IntToStr( xD ), 2 ) ) ] + ' ' + Suffix[ 3 ];
         TruncMio := StrToInt64( RightStr( IntToStr( xD ), 9 ) );
         if ( TruncMio <> 0 ) then
           BTStr := BTStr + ', ' + fMioENG( TruncMio );
         end
       else if ( xD >= 20000000000 ) and ( xD <= 99999999999 ) then
         begin
         if ( StrToInt64( LeftStr( IntToStr( xD ), 2 ) ) = 0 ) then
           BTStr := Tens[ StrToInt64( LeftStr( IntToStr( xD ), 2 ) ) ] + ' ' + Suffix[ 3 ]
         else
           BTStr := Tens[ StrToInt64( LeftStr( IntToStr( xD ), 2 ) ) ] + ' ' +
                    Ones[ StrToInt64( LeftStr( IntToStr( xD ), 2 ) ) ] + ' ' + Suffix[ 3 ];
         TruncMio := StrToInt64( RightStr( IntToStr( xD ), 9 ) );
         if ( TruncMio <> 0 ) then
            BTStr := BTStr + ', ' + fMioENG( TruncMio );
         end
       else if ( xD >= 100000000000 ) and ( xD <= 999999999999 ) then
         begin
         BTStr := fHundENG( StrToInt64( LeftStr( IntToStr( xD ), 3 ) ) ) + ' ' + Suffix[ 3 ];
         TruncMio := StrToInt64( RightStr( IntToStr( xD ), 9 ) );
         if ( TruncMio <> 0 ) then
           BTStr := BTStr + ', ' + fMioENG( TruncMio );
         end
       else
         begin
         TruncMio := StrToInt64( RightStr( IntToStr( xD ), 9 ) );
         if ( TruncMio <> 0 ) then
           BTStr := BTStr + fMioENG( TruncMio );
         end;
       Result := BTStr;
    end; 
    function fTrilENG( xD: Int64 ): string;
    var
      BTStr: string;
    begin
       if ( xD >= 1000000000000 ) and ( xD <= 9999999999999 ) then
         begin
         BTStr := Ones[ StrToInt( LeftStr( IntToStr( xD ), 1 ) ) ] + ' ' + Suffix[ 4 ];
         TruncBio := StrToInt64( RightStr( IntToStr( xD ), 12 ) );
         if ( TruncBio <> 0 ) then
           BTStr := BTStr + ', ' + fBioENG( TruncBio );
         end
       else if ( xD >= 10000000000000 ) and ( xD <= 19999999999999 ) then
         begin
         BTStr := Teens[ StrToInt( LeftStr( IntToStr( xD ), 2 ) ) ] + ' ' + Suffix[ 4 ];
         TruncBio := StrToInt64( RightStr( IntToStr( xD ), 12 ) );
         if ( TruncBio <> 0 ) then
           BTStr := BTStr + ', ' + fBioENG( TruncBio );
         end
       else if ( xD >= 20000000000000 ) and ( xD <= 99999999999999 ) then
         begin
         if ( StrToInt64( LeftStr( IntToStr( xD ), 2 ) ) = 0 ) then
           BTStr := Tens[ StrToInt64( LeftStr( IntToStr( xD ), 2 ) ) ] + ' ' + Suffix[ 4 ]
         else
           BTStr := Tens[ StrToInt64( LeftStr( IntToStr( xD ), 2 ) ) ] + ' ' +
                    Ones[ StrToInt64( LeftStr( IntToStr( xD ), 2 ) ) ] + ' ' + Suffix[ 4 ];
         TruncBio := StrToInt64( RightStr( IntToStr( xD ), 12 ) );
         if ( TruncBio <> 0 ) then
           BTStr := BTStr + ', ' + fBioENG( TruncBio );
         end
       else if ( xD >= 100000000000000 ) and ( xD <= 999999999999999 ) then
         begin
         BTStr := fHundENG( StrToInt64( LeftStr( IntToStr( xD ), 3 ) ) ) + ' ' + Suffix[ 4 ];
         TruncBio := StrToInt64( RightStr( IntToStr( xD ), 12 ) );
         if ( TruncBio <> 0 ) then
           BTStr := BTStr + ', ' + fBioENG( TruncBio );
         end
       else
         begin
         TruncBio := StrToInt64( RightStr( IntToStr( xD ), 12 ) );
         if ( TruncBio <> 0 ) then
           BTStr := BTStr + fBioENG( TruncBio );
         end;
       Result := BTStr;
    end; 
    function fQuadENG( xD: Int64 ): string;
    var
      BTStr: string;
    begin
       if ( xD >= 1000000000000000 ) and ( xD <= 9999999999999999 ) then
         begin
         BTStr := Ones[ StrToInt( LeftStr( IntToStr( xD ), 1 ) ) ] + ' ' + Suffix[ 5 ];
         TruncTril := StrToInt64( RightStr( IntToStr( xD ), 15 ) );
         if ( TruncTril <> 0 ) then
           BTStr := BTStr + ', ' + fTrilENG( TruncTril );
         end
       else
       if ( xD >= 10000000000000000 ) and ( xD <= 19999999999999999 ) then
         begin
         BTStr := Teens[ StrToInt( LeftStr( IntToStr( xD ), 2 ) ) ] + ' ' + Suffix[ 5 ];
         TruncTril := StrToInt64( RightStr( IntToStr( xD ), 15 ) );
         if ( TruncTril <> 0 ) then
           BTStr := BTStr + ', ' + fTrilENG( TruncTril );
         end
       else if ( xD >= 20000000000000000 ) and ( xD <= 99999999999999999 ) then
         begin
         if ( StrToInt64( LeftStr( IntToStr( xD ), 2 ) ) = 0 ) then
           BTStr := Tens[ StrToInt64( LeftStr( IntToStr( xD ), 2 ) ) ] + ' ' + Suffix[ 5 ]
         else
            BTStr := Tens[ StrToInt64( LeftStr( IntToStr( xD ), 2 ) ) ] + ' ' +
                     Ones[ StrToInt64( LeftStr( IntToStr( xD ), 2 ) ) ] + ' ' + Suffix[ 5 ];
         TruncTril := StrToInt64( RightStr( IntToStr( xD ), 15 ) );
         if ( TruncTril <> 0 ) then
           BTStr := BTStr + ', ' + fTrilENG( TruncTril );
         end
       else if ( xD >= 100000000000000000 ) and ( xD <= 999999999999999999 ) then
         begin
         BTStr := fHundENG( StrToInt64( LeftStr( IntToStr( xD ), 3 ) ) ) + ' ' + Suffix[ 5 ];
         TruncTril := StrToInt64( RightStr( IntToStr( xD ), 15 ) );
         if ( TruncTril <> 0 ) then
           BTStr := BTStr + ', ' + fTrilENG( TruncTril );
         end;
       Result := BTStr;
    end; 
begin
  iD := abs( Trunc( D ) );
  if ( iD >= 0 ) and ( iD <= 99 ) then
    RStr := fTensENG( iD )
  else if ( iD >= 100 ) and ( iD <= 999 ) then
    Rstr := RStr + fHundENG( iD )
  else if ( iD >= 1000 ) and ( iD <= 999999 ) then
    RStr := RStr + fThouENG( iD )
  else if ( iD >= 1000000 ) and ( iD <= 999999999 ) then
    RStr := RStr + fMioENG( iD )
  else if ( iD >= 1000000000 ) and ( iD <= 999999999999 ) then
    RStr := RStr + fBioENG( iD )
  else if ( iD >= 1000000000000 ) and ( iD <= 999999999999999 ) then
    RStr := RStr + fTrilENG( iD )
  else if ( iD >= 1000000000000000 ) and ( iD <= 999999999999999999 ) then
    RStr := RStr + fQuadENG( iD );
  if ChkER then
    RStr := RStr + ' ' + ER;
  vFrac := Frac( D );
  if ( vFrac <> 0 ) then
    begin
    sDec := FormatFloat( '0.000000', vFrac );
    if ChkER then
      begin
      sDec := MidStr( sDec, 3, 2 );
      vDec := StrToInt( sDec );
      if ( vDec > 0 ) then
      RStr := RStr + ' and ' + fTensENG( vDec ) + ' cents.';
      end
    else
      begin
      RStr := RStr + ' point ';
      ReadFrac := False;
      sFrac := '';
      for I := Length( sDec ) downto 3 do
        begin
        if ( sDec[ I ] <> '0' ) then
          ReadFrac := True;
        if ReadFrac then
          sFrac := Ones[ StrToInt( sDec[ I ] ) ] + ' ' + sFrac;
        end;
      RStr := RStr + sFrac;
      end;
    end;
  Result := RStr;
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TextStatistics( Text : string; Chars : PCardinal; Words : PCardinal = nil; Sentences : PCardinal = nil; Paragraphs : PCardinal = nil; Lines : PCardinal = nil );
const
  BreakChars = [ '.', '?', '!', #191, #161 ];
var
  i      : Integer;
  IsCRLF : Boolean;
begin
  if ( Chars <> nil ) then
    Chars^      := Length( Text );
  if ( Words <> nil ) then
    Words^      := 0;
  if ( Sentences <> nil ) then
    Sentences^  := 0;
  if ( Paragraphs <> nil ) then
    Paragraphs^ := 0;
  if ( Lines <> nil ) then
    Lines^      := 0;

  if ( Text = '' ) OR ( ( Chars = nil ) AND ( Words = nil ) AND ( Sentences = nil ) AND ( Paragraphs = nil ) AND ( Lines = nil ) ) then
    Exit;

  IsCRLF := ( Pos( #13#10, Text ) > 0 );
  i := {$IF CompilerVersion >= 24}Low( Text ){$ELSE}1{$IFEND};
  while ( i <= {$IF CompilerVersion >= 24}High( Text ){$ELSE}Length( Text ){$IFEND} ) do
    begin
    if ( i = {$IF CompilerVersion >= 24}High( Text ){$ELSE}Length( Text ){$IFEND} ) then
      begin
      if ( Text[ i ] <> #13 ) AND ( Text[ i ] <> #10 ) AND ( Text[ i ] <> #32 ) then
        begin
        Inc( Words^ );
        Inc( Sentences^ );
        Inc( Paragraphs^ );
        Inc( Lines^ );
        end;
      end
    else if ( i = {$IF CompilerVersion >= 24}Low( Text ){$ELSE}1{$IFEND} ) then
      begin
      Inc( i );
      Continue;
      end;

    if ( Text[ i ] = #32 ) and ( Text[ i-1 ] <> #32 ) then
      begin
      if ( Words <> nil ) then
        Inc( Words^ );
      end
    else if {$IF CompilerVersion >= 22}CharInSet( Text[ i ],{$ELSE}( Text[ i ] in{$IFEND} BreakChars ) and
            not {$IF CompilerVersion >= 22}CharInSet( Text[ i-1 ],{$ELSE}( Text[ i-1 ] in{$IFEND} BreakChars )
            and ( Text[ i-1 ] <> #32 )then
      begin
      if ( Sentences <> nil ) then
        Inc( Sentences^ );
      end
    else if ( Text[ i ] = #13 ) OR ( Text[ i ] = #10 ) then
      begin
      if ( Text[ i ] = #13 ) AND IsCRLF then
        begin
        Inc( i );
        Continue;
        end;
      if IsCRLF then
        begin
        if ( i > {$IF CompilerVersion >= 24}Low( Text ){$ELSE}1{$IFEND}+2 ) then
          begin
          if ( Text[ i-2 ] <> #10 ) then
            begin
            if ( Paragraphs <> nil ) then
              Inc( Paragraphs^ );
            if ( Text[ i-2 ] <> #32 ) then
              begin
              if ( Words <> nil ) then
                Inc( Words^ );
              if NOT {$IF CompilerVersion >= 22}CharInSet( Text[ i-2 ],{$ELSE}( Text[ i-2 ] in{$IFEND} BreakChars ) then
                begin
                if ( Sentences <> nil ) then
                  Inc( Sentences^ );
                end;
              end;
            end;
          end;
        end
      else
        begin
        if ( Text[ i-1 ] <> Text[ i ] ) then
          begin
          if ( Paragraphs <> nil ) then
            Inc( Paragraphs^ );
          if ( Text[ i-1 ] <> #32 ) then
            begin
            if ( Words <> nil ) then
              Inc( Words^ );
            if NOT {$IF CompilerVersion >= 22}CharInSet( Text[ i-1 ],{$ELSE}( Text[ i-1 ] in{$IFEND} BreakChars ) then
              begin
              if ( Sentences <> nil ) then
                Inc( Sentences^ );
              end;
            end;
          end;
        end;
      if ( Lines <> nil ) then
        Inc( Lines^ );
      end;
    Inc( i );
    end;
end;

function ReplaceStringAreal( InString : string; start, endN : integer; rText : string ): string;
begin
  result := InString;
  if ( InString = '' ) or ( start > endN ) or ( endN > Length( InString ) ) then
    Exit;

  ReplaceStringAreal_( result, start, endN, rText );
end;

procedure ReplaceStringAreal_( var InString : string; start, endN : integer; rText : string );
begin
  if ( InString = '' ) or ( start > endN ) or ( endN > Length( InString ) ) then
    Exit;

  if ( Length( rText ) > 2 ) AND ( copy( rText, Length( rText )-1, 2 ) = #13#10 ) AND ( copy( InString, endN-1, 2 ) <> #13#10 ) then
    rText := copy( rText, 0, Length( rText )-2 );

  InString := copy( InString, 0, Max( start-1,0 ) ) + rText + copy( InString, endN+1, length( InString )-endN );
end;

{$IFNDEF UNICODE}
function ReplaceStringAreal( InString : WideString; start, endN : integer; rText : string ): WideString;
begin
  result := InString;
  if ( InString = '' ) or ( start > endN ) or ( endN > Length( InString ) ) then
    Exit;

  ReplaceStringAreal_( result, start, endN, rText );
end;

procedure ReplaceStringAreal_( var InString : WideString; start, endN : integer; rText : WideString );
begin
  if ( InString = '' ) or ( start > endN ) or ( endN > Length( InString ) ) then
    Exit;

  if ( Length( rText ) > 2 ) AND ( copy( rText, Length( rText )-1, 2 ) = #13#10 ) AND ( copy( InString, endN-1, 2 ) <> #13#10 ) then
    rText := copy( rText, 0, Length( rText )-2 );

  InString := copy( InString, 0, Max( start-1,0 ) ) + rText + copy( InString, endN+1, length( InString )-endN );
end;
{$ENDIF}

function GetLineSeperator( Text : string ) : string;
begin
  result := '';
  if ( Pos( #13#10, Text ) > 0 ) then
    result := #13#10
  else if ( Pos( #13, Text ) > 0 ) then
    result := #13
  else if ( Pos( #10, Text ) > 0 ) then
    result := #10;
end;

function GetLineSeperatorAsText( Text : string ) : string;
begin
  result := GetLineSeperator( Text );
  if ( result = #13#10 ) then
    result := 'CR-LF'
  else if ( result = #13 ) then
    result := 'CR'
  else if ( result = #10 ) then
    result := 'LF';
//  else
//    result := '';
end;

{$IFEND TLH_INTERFACESECTION}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

{$IFNDEF TLH_OMIT_SECTIONS}
end.
{$ENDIF TLH_OMIT_SECTIONS}

