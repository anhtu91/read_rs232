{
  TetzkatLipHoka 2015-2019

  uTLH: Numeral
  Last updated: 03/13/2019
}

{
Random( Min, Max )                  - Random within Min and Max (Integer, Float & Cardinal)
SplitFloat                          - Returns Float splitted into 2 integers
CalcBitValue                        - Calculate a X-Bit Value according to given Total-Min,-Max and Value
                                      Can be used to Calculate DAC Output, likely 12-Bit Value scaled to 0-20ma with offset of 4ma
                                      TotalMin, TotalMax, Value, 12, 20, 4
Equal                               - Compare two types, True if they're equal
IsNumIn                             - Check if number is within min/max
LengthNum                           - Similiar to regular Length but for integers
RoundNumber                         - Return rounded number
RoundNumberUp                       - Returns up-rounded Number (1=1, 1.1=2, ...)
Swap                                - Exchange the given Values
IsPrimeNumber                       - Returns true if given Number is a Prime-Number

ReadBitFromByte                     - Read single Bit from Byte         ( 8Bit )
WriteBitInByte                      - Exchange Bit in Byte              ( 8Bit )
ReadBitFromWord                     - Read single Bit from Word        ( 16Bit )
WriteBitInWord                      - Exchange Bit in Word             ( 16Bit )
ReadBitFromDWord                    - Read single Bit from DWord       ( 32Bit )
WriteBitInDWord                     - Exchange single Bit from DWord   ( 32Bit )
ReadBitFromInteger                  - Read single Bit from Integer     ( 32Bit )
WriteBitInInteger                   - Exchange single Bit from Integer ( 32Bit )
ReadBitFromInt64                    - Read single Bit from Int64       ( 64Bit )
WriteBitInInt64                     - Exchange single Bit from Int64   ( 64Bit )
ReadBitFromUInt64                   - Read single Bit from UInt64      ( 64Bit )
WriteBitInUInt64                    - Exchange single Bit from UInt64  ( 64Bit )

HiLoByteToSmallInt                  - SmallInt from Hi/Lo-Byte
HiLoWordFromSmallInt                - Hi/Lo-Byte from SmallInt
HiLoWordToInteger                   - Integer from Hi/Lo-Word
HiLoWordFromInteger                 - Hi/Lo-Word from Integer
HiLoDWordToInt64                    - Int64 from Hi/Lo-DWord
HiLoDWordFromInt64                  - Hi/Lo-DWord from Int64

SmallIntToBytes                     - Convert SmallInt to ByteArray
BytesToSmallInt                     - Convert ByteArray to SmallInt
WordToBytes                         - Convert Word to ByteArray
BytesToWord                         - Convert ByteArray to Word
DWordToBytes                        - Convert DWord to ByteArray
BytesToDWord                        - Convert ByteArray to DWord
IntegerToBytes                      - Convert Integer to ByteArray
BytesToInteger                      - Convert ByteArray to Integer
CardinalToBytes                     - Convert Cardinal to ByteArray
BytesToCardinal                     - Convert ByteArray to Cardinal
Int64ToBytes                        - Convert Int64 to ByteArray
BytesToInt64                        - Convert ByteArray to Int64
SingleToBytes                       - Convert Single to ByteArray
BytesToSingle                       - Convert ByteArray to Single
DoubleToBytes                       - Convert Double to ByteArray
BytesToDouble                       - Convert ByteArray to Double
ExtendedToBytes                     - Convert Extended to ByteArray
BytesToExtended                     - Convert ByteArray to Extended

DWordToLongInt                      - Convert DWord( unsigned 32Bit ) to LongInt( signed 32Bit )
LongIntToDWord                      - Convert LongInt( signed 32Bit ) to DWord( unsigned 32Bit )
WordToSmallInt                      - Convert Word( unsigned 16Bit ) to SmallInt( signed 16Bit )
SmallIntToWord                      - Convert SmallInt( signed 16Bit ) to Word( unsigned 16Bit )
ByteToShortInt                      - Convert Word( unsigned 8Bit ) to ShortInt( signed 8Bit )
ShortIntToByte                      - Convert ShortInt( signed 8Bit ) to Word( unsigned 8Bit )

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Temperature Conversion~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CelsiusToFahrenheit                 - Convert °Celsius to °Fahrenheit
CelsiusToKelvin                     - Convert °Celsius to Kelvin
CelsiusToReaumur                    - Convert °Celsius to Reaumur
CelsiusToRankine                    - Convert °Celsius to Rankine
CelsiusToRomer                      - Convert °Celsius to Romer
CelsiusToDelisle                    - Convert °Celsius to Delisle
CelsiusToNewton                     - Convert °Celsius to Newton

FahrenheitToCelsius                 - Convert °Fahrenheit to °Celsius
KelvinToCelsius                     - Convert Kelvin to °Celsius
ReaumurToCelsius                    - Convert Reaumur to °Celsius
RankineToCelsius                    - Convert Rankine to °Celsius
RomerToCelsius                      - Convert Romer to °Celsius
DelisleToCelsius                    - Convert Delisle to °Celsius
NewtonToCelsius                     - Convert Newton to °Celsius
}

{$WARN UNSAFE_CODE OFF}
{$WARN COMBINING_SIGNED_UNSIGNED OFF}
{$WARN COMPARING_SIGNED_UNSIGNED OFF}
{$WARN GARBAGE OFF}

{$IFNDEF TLH_OMIT_SECTIONS}
unit uTLH.Numeral;

{$I uTLH.inc}

interface

uses
  {$IFDEF MATHROUT}Mathrout,{$ENDIF}
  Types;

{$ENDIF TLH_OMIT_SECTIONS}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
{$IF NOT Defined(TLH_IMPLEMENTATIONSECTION) AND NOT Defined(TLH_INITIALIZATIONSECTION) AND NOT Defined(TLH_FINALIZATIONSECTION)}
function Random( vLow, vHigh : Integer ): Integer; overload;
function Random( vHigh : Integer ): Integer; overload;
function Random( vHigh : extended ): extended; overload;
function Random( vLow, vHigh : extended ): extended; overload;
function Random( vLow, vHigh : Cardinal ): Cardinal; overload;
function Random( vHigh : Cardinal ): Cardinal; overload;
function Random : boolean; overload;

procedure Swap( var a,b : Byte ); overload;
procedure Swap( var a,b : Word ); overload;
procedure Swap( var a,b : Cardinal ); overload;
procedure Swap( var a,b : UInt64 ); overload;
procedure Swap( var a,b : ShortInt ); overload;
procedure Swap( var a,b : SmallInt ); overload;
procedure Swap( var a,b : Integer ); overload;
procedure Swap( var a,b : Int64 ); overload;
procedure Swap( var a,b : Double ); overload;
procedure Swap( var a,b : Extended ); overload;
procedure Swap( var a,b : TPoint ); overload;
{$IFDEF MATHROUT}
procedure Swap( var a,b : Typ_EPunkt ); overload;
{$ENDIF}

function Equal( a,b : UInt64 ): Boolean; overload;
function Equal( a,b : Int64 ): Boolean; overload;
function Equal( a,b : Extended; const EPS : Extended = 1.0E-8 ): Boolean; overload;

procedure SplitFloat( value : Extended; var Large : Integer; var Small : String );
function CalcBitValue( TotalMin, TotalMax : extended; Value : extended; bitDepth : integer = 12; ScalingMaxVal : integer = 0; Offset : integer = 0 ): integer;

function IsNumIn( Number: Integer; Min, Max : integer ): Boolean; overload;
function LengthNum( i : integer ): integer;
function RoundNumber( R : extended; Decimals : byte ) : extended;
function RoundNumberUp( value : Double ) : Int64;

function isPrimeNumber( Number : Cardinal ) : boolean;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
type
  SmallIntByteArray = Array [0..1] of Byte;
  WordByteArray = Array [0..1] of Byte;
  DWordByteArray = Array [0..3] of Byte;
  IntegerByteArray = Array [0..3] of Byte;
  CardinalByteArray = Array [0..3] of Byte;
  Int64ByteArray = Array [0..7] of Byte;
  SingleByteArray = Array [0..3] of Byte;
  DoubleByteArray = Array [0..7] of Byte;
  ExtendedByteArray = Array [0..9] of Byte;

function ReadBitFromByte( value : byte; posBit : byte ) : byte;
function WriteBitInByte( value : byte; wertBit, posBit : byte ) : byte;
function ReadBitFromWord( value : Word; posBit : byte ) : byte;
function WriteBitInWord( value : Word; wertBit, posBit : byte ) : Word;
function ReadBitFromDWord( value : Cardinal; posBit : byte ) : byte;
function WriteBitInDWord( value : Cardinal; wertBit, posBit : byte ) : Cardinal;
function ReadBitFromInteger( value : Integer; posBit : byte ) : byte;
function WriteBitInInteger( value : Integer; wertBit, posBit : byte ) : Integer;
function ReadBitFromInt64( value : Int64; posBit : byte ) : byte;
function WriteBitInInt64( value : Int64; wertBit, posBit : byte ) : Int64;
function ReadBitFromUInt64( value : UInt64; posBit : byte ) : byte;
function WriteBitInUInt64( value : UInt64; wertBit, posBit : byte ) : UInt64;
function HiLoByteToSmallInt( Lo, Hi: Byte ): SmallInt;
procedure HiLoByteFromSmallInt( Value : SmallInt; var Lo : Byte; var Hi: Byte );
function HiLoWordToInteger( Lo, Hi: Word ): Integer;
procedure HiLoWordFromInteger( Value : Integer; var Lo : Word; var Hi: Word );
function HiLoDWordToInt64( Lo, Hi: Cardinal ): Int64;
procedure HiLoDWordFromInt64( Value : Int64; var Lo : Cardinal; var Hi: Cardinal );
function ShortIntToByte( value : ShortInt ): Byte;
function ByteToShortInt( value : Byte ): ShortInt;
function SmallIntToBytes( value : SmallInt ): SmallIntByteArray;
function BytesToSmallInt( value : SmallIntByteArray ): SmallInt;
function WordToBytes( value : Word ): WordByteArray;
function BytesToWord( value : WordByteArray ): Word;
function DWordToBytes( value : Cardinal ): DWordByteArray;
function BytesToDWord( value : DWordByteArray ): Cardinal;
function IntegerToBytes( value : integer ): IntegerByteArray;
function BytesToInteger( value : IntegerByteArray ): Integer;
function CardinalToBytes( value : Cardinal ): CardinalByteArray;
function BytesToCardinal( value : CardinalByteArray ): Cardinal;
function Int64ToBytes( value : Int64 ): Int64ByteArray;
function BytesToInt64( value : Int64ByteArray ): Int64;
function SingleToBytes( value: Single ): SingleByteArray;
function BytesToSingle( value: SingleByteArray ): Single;
function DoubleToBytes( value: Double ): DoubleByteArray;
function BytesToDouble( value: DoubleByteArray ): Double;
function ExtendedToBytes( value: Extended ): ExtendedByteArray;
function BytesToExtended( value: ExtendedByteArray ): Extended;
function WordToSmallInt( value : Word ): SmallInt;
function SmallIntToWord( value : SmallInt ): Word;
function DWordToLongInt( value : Cardinal ): LongInt;
function LongIntToDWord( value : LongInt ): Cardinal;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Temperature Conversion
function CelsiusToFahrenheit( value : extended ): extended;
function CelsiusToKelvin( value : extended ): extended;
function CelsiusToReaumur( value : extended ): extended;
function CelsiusToRankine( value : extended ): extended;
function CelsiusToRomer( value : extended ): extended;
function CelsiusToDelisle( value : extended ): extended;
function CelsiusToNewton( value : extended ): extended;

function FahrenheitToCelsius( value : extended ): extended;
function KelvinToCelsius( value : extended ): extended;
function ReaumurToCelsius( value : extended ): extended;
function RankineToCelsius( value : extended ): extended;
function RomerToCelsius( value : extended ): extended;
function DelisleToCelsius( value : extended ): extended;
function NewtonToCelsius( value : extended ): extended;
{$IFEND TLH_IMPLEMENTATIONSECTION}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
{$IFNDEF TLH_OMIT_SECTIONS}
implementation

uses
  Math, SysUtils, StrUtils;
{$ENDIF TLH_OMIT_SECTIONS}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
{$IF NOT Defined(TLH_INTERFACESECTION) AND NOT Defined(TLH_INITIALIZATIONSECTION) AND NOT Defined(TLH_FINALIZATIONSECTION)}
function Random( vLow, vHigh : Integer ): Integer;
begin
  Result := Math.RandomRange( vLow, vHigh )
end;

function Random( vHigh : Integer ): Integer;
begin
  result := System.Random( vHigh );
end;

function Random( vLow, vHigh : extended ): extended;
var
  t : extended;
begin
  if ( vLow = vHigh ) then
    begin
    result := vHigh;
    Exit;
    end
  else if ( vLow > vHigh ) then
    begin
    t := vLow;
    vLow := vHigh;
    vHigh := t;
    end;
  Result := vLow + Random( vHigh );
end;

function Random( vLow, vHigh : Cardinal ): Cardinal;
var
  Lo : Cardinal;
begin
  if ( vHigh > High( Integer ) ) then
    begin
    Lo := vHigh-High( Integer );
    result := Lo+Math.RandomRange( Lo*-1, High( Integer ) );
    end
  else
    result := Math.RandomRange( 0, vHigh );
end;

function Random( vHigh : Cardinal ): Cardinal;
begin
  result := Random( 0, vHigh );
end;
     
function Random( vHigh : extended ): extended;
begin
  vHigh := Max( Low( Integer ), Min( High( Integer ), vHigh ) );
  result := System.Random( Trunc( vHigh ) ) + RandomRange( 0, 99 ) * 0.01;
end;

function Random : boolean;
begin
  result := ( System.Random(1) = 1 );
end;

procedure Swap( var a,b : Byte );
var
  x : Byte;
begin
  x := a;
  a := b;
  b := x;
end;

procedure Swap( var a,b : Word );
var
  x : Word;
begin
  x := a;
  a := b;
  b := x;
end;

procedure Swap( var a,b : Cardinal );
var
  x : Cardinal;
begin
  x := a;
  a := b;
  b := x;
end;

procedure Swap( var a,b : UInt64 );
var
  x : UInt64;
begin
  {$IF CompilerVersion < 23}{$RANGECHECKS OFF}{$IFEND} // RangeCheck might cause Internal-Error C1118
  x := a;
  a := b;
  b := x;
  {$IF CompilerVersion < 23}{$RANGECHECKS ON}{$IFEND} // RangeCheck might cause Internal-Error C1118
end;

procedure Swap( var a,b : ShortInt );
var
  x : ShortInt;
begin
  x := a;
  a := b;
  b := x;
end;

procedure Swap( var a,b : SmallInt );
var
  x : SmallInt;
begin
  x := a;
  a := b;
  b := x;
end;

procedure Swap( var a,b : Integer );
var
  x : Integer;
begin
  x := a;
  a := b;
  b := x;
end;

procedure Swap( var a,b : Int64 );
var
  x : Int64;
begin
  x := a;
  a := b;
  b := x;
end;

procedure Swap( var a,b : Double );
var
  x : Double;
begin
  x := a;
  a := b;
  b := x;
end;

procedure Swap( var a,b : Extended );
var
  x : Extended;
begin
  x := a;
  a := b;
  b := x;
end;

procedure Swap( var a,b : TPoint );
var
  x : TPoint;
begin
  x := a;
  a := b;
  b := x;
end;

{$IFDEF MATHROUT}
procedure Swap( var a,b : Typ_EPunkt );
var
  x : Typ_EPunkt;
begin
  x := a;
  a := b;
  b := x;
end;
{$ENDIF}

function Equal( a,b : UInt64 ): Boolean;
begin
  result := ( a = b );
end;

function Equal( a,b : Int64 ): Boolean;
begin
  result := ( a = b );
end;

function Equal( a,b : Extended; const EPS : Extended = 1.0E-8 ): Boolean;
begin
  result := ( Abs( a - b ) < EPS );
end;

procedure SplitFloat( value : Extended; var Large : Integer; var Small : String );
begin
  Large := Trunc( value );
  Small := FloatToStr( Frac( value ) );
  Small := RightStr( Small, Length( Small )-2 )
//  Small := Trunc( Frac( value ) * Power( 10, Length( FloatToStr( Frac( value ) ) )-2 ) );
end;

function CalcBitValue( TotalMin, TotalMax : extended; Value : extended; bitDepth : integer = 12; ScalingMaxVal : integer = 0; Offset : integer = 0 ): integer;
var
  Total : integer;
  dOffset : double;
begin
  bitDepth := Min( 64, Max( 1, bitDepth ) );
  Total := Trunc( Power( 2, bitDepth ) );
  ScalingMaxVal := Min( Total, Max( 0, ScalingMaxVal ) );
  if ( ScalingMaxVal = 0 ) then
    ScalingMaxVal := Total;

  Offset := Min( ScalingMaxVal, Max( 0, Offset ) );
  dOffset := ( ( Total / ScalingMaxVal ) * Offset );

  result := Trunc( dOffset );
  Value := Min( TotalMax, Max( TotalMin, Value ) );

  if ( TotalMax <= TotalMin ) {or ( ( Value < TotalMin ) or ( Value > TotalMax ) )} then
    Exit;

  result := Trunc( dOffset + ( ( Total-dOffset ) / ( TotalMax-TotalMin ) ) * ( Value-TotalMin ) );
end;

function IsNumIn( Number: Integer; Min, Max : integer ): Boolean;
begin
  result := ( Number >= min ) and ( Number <= Max );
end;

function LengthNum( i : integer ): integer;
begin
  result := Length( IntToStr( i ) );
end;

function RoundNumber( R : extended; Decimals : byte ) : extended;
//var S : string;
begin
  result := RoundTo( R, -Decimals );

//  STR( R:255:Decimals, S );
//  while S[1] = #32 do // Delete any leading spaces
//   Delete( S, 1, 1 );
//
//  Result := Int( R * Power( 10, Decimals ) + 0.5 ) / Power( 10, Decimals );
end;

function RoundNumberUp( value : Double ) : Int64;
begin
  result := IfThen( Trunc( value ) = value, Trunc( Value ), Round( Value+0.5 ) );
end;

function isPrimeNumber( Number : Cardinal ) : boolean;
var
 i, k : Cardinal;
begin
 k := 0;
 for i := 1 to Number do
   begin
   if ( Number mod i = 0 ) then
     inc( k );
   if ( k > 2 ) then
     break;
   end;
 result := k = 2;
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function ReadBitFromByte( value : byte; posBit : byte ) : byte;
//var
//  maske : byte;
begin
   result := 0;
   if ( posBit > 7 ) then
     exit;
   {
   maske := 0;
   case posBit of
     0 : maske := 1;
     1 : maske := 2;
     2 : maske := 4;
     3 : maske := 8;
     4 : maske := 16;
     5 : maske := 32;
     6 : maske := 64;
     7 : maske := 128;
   end;

   result := value and maske;

   if result = maske then
     result := 1
   else
     result := 0;
   }
   result := ( value shr posBit ) and $0001;
end;

function WriteBitInByte( value : byte; wertBit, posBit : byte ) : byte;
//var
//  byte_arr : array [1..8] of byte;
//  i        : integer;
begin
  result := 0;
  if not ( wertBit in [0, 1] ) then
    exit;
  if ( posBit > 7 ) then
    exit;

  {
  for i := 1 to 8 do
    byte_arr[i] := ReadBitFromByte( value, i );
  byte_arr[posBit] := wertBit;
  result :=  1* byte_arr[1]+
             2* byte_arr[2]+
             4* byte_arr[3]+
             8* byte_arr[4]+
             16*byte_arr[5]+
             32*byte_arr[6]+
             64*byte_arr[7]+
             128*byte_arr[8];
  }

  if wertBit = 0 then// also Bit löschen, wenn es zuvor gesetzt war
    result := value AND ( High( value ) xor ( 1 shl posBit ) )
  else
    result := value OR ( wertBit shl posBit );
end;

function ReadBitFromWord( value : Word; posBit : byte ) : byte;
begin
   result := 0;
   if ( posBit > 15 ) then
     exit;

   result := ( value shr posBit ) and $0001;
end;

function WriteBitInWord( value : Word; wertBit, posBit : byte ) : Word;
begin
  result := 0;
  if not ( wertBit in [0, 1] ) then
    exit;
  if ( posBit > 15 ) then
    exit;

  if wertBit = 0 then
    result := value AND ( High( value ) xor ( 1 shl posBit ) )
  else
    result := value OR ( wertBit shl posBit );
end;

function ReadBitFromDWord( value : Cardinal; posBit : byte ) : byte;
begin
   result := 0;
   if ( posBit > 31 ) then
     exit;

   result := ( value shr posBit ) and $0001;
end;

function WriteBitInDWord( value : Cardinal; wertBit, posBit : byte ) : Cardinal;
begin
  result := 0;
  if not ( wertBit in [0, 1] ) then
    exit;
  if ( posBit > 31 ) then
    exit;

  if wertBit = 0 then
    result := value AND ( High( value ) xor ( 1 shl posBit ) )
  else
    result := value OR ( wertBit shl posBit );
end;

function ReadBitFromInteger( value : Integer; posBit : byte ) : byte;
begin
   result := 0;
   if ( posBit > 31 ) then
     exit;

   result := ( value shr posBit ) and $0001;
end;

function WriteBitInInteger( value : Integer; wertBit, posBit : byte ) : Integer;
begin
  result := 0;
  if not ( wertBit in [0, 1] ) then
    exit;
  if ( posBit > 31 ) then
    exit;

  if wertBit = 0 then
    result := value AND ( High( value ) xor ( 1 shl posBit ) )
  else
    result := value OR ( wertBit shl posBit );
end;

function ReadBitFromInt64( value : Int64; posBit : byte ) : byte;
begin
   result := 0;
   if ( posBit > 63 ) then
     exit;

   result := ( value shr posBit ) and $0001;
end;

function WriteBitInInt64( value : Int64; wertBit, posBit : byte ) : Int64;
begin
  result := 0;
  if not ( wertBit in [0, 1] ) then
    exit;
  if ( posBit > 63 ) then
    exit;

  if wertBit = 0 then
    result := value AND ( High( value ) xor ( 1 shl posBit ) )
  else
    result := value OR ( wertBit shl posBit );
end;

function ReadBitFromUInt64( value : UInt64; posBit : byte ) : byte;
begin
   result := 0;
   if ( posBit > 63 ) then
     exit;

   result := ( value shr posBit ) and $0001;
end;

{$IF CompilerVersion < 23}{$RANGECHECKS OFF}{$IFEND} // RangeCheck might cause Internal-Error C1118
function WriteBitInUInt64( value : UInt64; wertBit, posBit : byte ) : UInt64;
begin
  result := 0;
  if not ( wertBit in [0, 1] ) then
    exit;
  if ( posBit > 63 ) then
    exit;

  if wertBit = 0 then
    result := value AND ( High( value ) xor ( 1 shl posBit ) )
  else
    result := value OR ( wertBit shl posBit );
end;
{$IF CompilerVersion < 23}{$RANGECHECKS ON}{$IFEND}

function HiLoByteToSmallInt( Lo, Hi: Byte ): SmallInt;
begin
  result := SmallInt(Hi);
  result := ((result shl 8) Or Lo);
End;

procedure HiLoByteFromSmallInt( Value : SmallInt; var Lo : Byte; var Hi: Byte );
begin
  Lo := Value And $FF;
  Hi := ( value shr 8 ) and $FF;
End;

function HiLoWordToInteger( Lo, Hi: Word ): Integer;
begin
  result := Integer(Hi);
  result := ((result shl 16) Or Lo);
End;

procedure HiLoWordFromInteger( Value : Integer; var Lo : Word; var Hi: Word );
begin
  Lo := Value And $FFFF;
  Hi := ( value shr 16 ) and $FFFF;
End;

function HiLoDWordToInt64( Lo, Hi: Cardinal ): Int64;
begin
  result := Int64(Hi);
  result := ((result shl 32) Or Lo);
End;

procedure HiLoDWordFromInt64( Value : Int64; var Lo : Cardinal; var Hi: Cardinal );
begin
  Lo := Value And $FFFFFFFF;
  Hi := ( value shr 32 ) and $FFFFFFFF;
End;

function ShortIntToByte( value : ShortInt ): Byte;
var
  Bytes: Byte absolute value;
begin
  result := Bytes;
end;

function ByteToShortInt( value : Byte ): ShortInt;
var
  S: ShortInt absolute value;
begin
  result := S;
end;

function SmallIntToBytes( value : SmallInt ): SmallIntByteArray;
var
  Bytes: SmallIntByteArray absolute value;
begin
  result := Bytes;
end;

function BytesToSmallInt( value : SmallIntByteArray ): SmallInt;
var
  S: SmallInt absolute value;
begin
  result := S;
end;

function WordToBytes( value : Word ): WordByteArray;
var
  Bytes: WordByteArray absolute value;
begin
  result := Bytes;
end;

function BytesToWord( value : WordByteArray ): Word;
var
  S: Word absolute value;
begin
  result := S;
end;

function DWordToBytes( value : Cardinal ): DWordByteArray;
var
  Bytes: DWordByteArray absolute value;
begin
  result := Bytes;
end;

function BytesToDWord( value : DWordByteArray ): Cardinal;
var
  S: Cardinal absolute value;
begin
  result := S;
end;

function IntegerToBytes( value : integer ): IntegerByteArray;
var
  Bytes: IntegerByteArray absolute value;
begin
  result := Bytes;
end;

function BytesToInteger( value : IntegerByteArray ): Integer;
var
  I: Integer absolute value;
begin
  result := I;
end;

function CardinalToBytes( value : Cardinal ): CardinalByteArray;
var
  Bytes: CardinalByteArray absolute value;
begin
  result := Bytes;
end;

function BytesToCardinal( value : CardinalByteArray ): Cardinal;
var
  C: Cardinal absolute value;
begin
  result := C;
end;

function Int64ToBytes( value : Int64 ): Int64ByteArray;
var
  Bytes: Int64ByteArray absolute value;
begin
  result := Bytes;
end;

function BytesToInt64( value : Int64ByteArray ): Int64;
var
  I: Int64 absolute value;
begin
  result := I;
end;

function SingleToBytes( value: Single ): SingleByteArray;
var
  Bytes: SingleByteArray absolute value;
begin
  Result := Bytes;
end;

function BytesToSingle( value: SingleByteArray ): Single;
var
  S: Single absolute value;
begin
  Result := S;
end;

function DoubleToBytes( value: Double ): DoubleByteArray;
var
  Bytes: DoubleByteArray absolute value;
begin
  Result := Bytes;
end;

function BytesToDouble( value: DoubleByteArray ): Double;
var
  D: Double absolute value;
begin
  Result := D;
end;

function ExtendedToBytes( value: Extended ): ExtendedByteArray;
var
  Bytes: ExtendedByteArray absolute value;
begin
  Result := Bytes;
end;

function BytesToExtended( value: ExtendedByteArray ): Extended;
var
  E: Extended absolute value;
begin
  Result := E;
end;

function WordToSmallInt( value : Word ): SmallInt;
var
  E: SmallInt absolute value;
begin
  Result := E;
end;

function SmallIntToWord( value : SmallInt ): Word;
var
  E: Word absolute value;
begin
  Result := E;
end;

function DWordToLongInt( value : Cardinal ): LongInt;
var
  E: LongInt absolute value;
begin
  Result := E;
end;

function LongIntToDWord( value : LongInt ): Cardinal;
var
  E: Cardinal absolute value;
begin
  Result := E;
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function CelsiusToFahrenheit( value : extended ): extended;
begin
  result := Value * 1.8 + 32;
end;
function FahrenheitToCelsius( value : extended ): extended;
begin
  result := ( Value - 32 ) * 5/9;
end;

function CelsiusToKelvin( value : extended ): extended;
begin
  result := Value + 273.15;
end;
function KelvinToCelsius( value : extended ): extended;
begin
  result := Value - 273.15;
end;

function CelsiusToReaumur( value : extended ): extended;
begin
  result := Value * 0.8;
end;
function ReaumurToCelsius( value : extended ): extended;
begin
  result := Value * 1.25;
end;

function CelsiusToRankine( value : extended ): extended;
begin
  result := Value * 1.8 + 491.67;
end;
function RankineToCelsius( value : extended ): extended;
begin
  result := Value * 5/9 - 273.15;
end;

function CelsiusToRomer( value : extended ): extended;
begin
  result := Value * 21/40 + 7.5;
end;
function RomerToCelsius( value : extended ): extended;
begin
  result := ( Value - 7.5 ) * 40/21;
end;

function CelsiusToDelisle( value : extended ): extended;
begin
  result := ( 100 - Value ) * 1.5;
end;
function DelisleToCelsius( value : extended ): extended;
begin
  result := 100 - Value * 2/3;
end;

function CelsiusToNewton( value : extended ): extended;
begin
  result := Value * 0.33;
end;
function NewtonToCelsius( value : extended ): extended;
begin
  result := Value * 100/33;
end;

{$IFEND TLH_INTERFACESECTION}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

{$IFNDEF TLH_OMIT_SECTIONS}
initialization
{$ENDIF TLH_OMIT_SECTIONS}
{$IF NOT Defined(TLH_INTERFACESECTION) AND NOT Defined(TLH_IMPLEMENTATIONSECTION) AND NOT Defined(TLH_FINALIZATIONSECTION)}
  Randomize;
{$IFEND}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
{$IFNDEF TLH_OMIT_SECTIONS}
end.
{$ENDIF TLH_OMIT_SECTIONS}
