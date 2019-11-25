{
  TetzkatLipHoka 2015-2019

  uTLH: Graphics
  Last updated: 07/11/2019
}

{
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Graphics~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ReturnTextWidth                     - Returns Pixels required to draw given Text(Width)
ReturnTextHeight                    - Returns Pixels required to draw given Text(Height)
ReturnAutoWrapHeight                - Returns Pixels required to draw given Text within a WordWrap-Component
ReturnAutoWrapLines                 - Returns Lines of Text needed to draw given Text within a WordWrap-Component
ReturnMaxFontSize                   - Returns highest possible FontSize for given Text and Rect

BitMapAppend                        - Append one Bitmap to another
BitMapTile                          - Cuts tile from src-bitmap, Stretching possible
AspectRatioY                        - Returns Width for given Height using aspect ratio of given original X/Y
AspectRatioX                        - Returns Height for given Width using apsect ratio of given original X/Y
BitmapResize                        - Resize src-Bitmap into dest-Bitmap, able to keep the aspect ratio (Centre = True, Centres src-Bitmap in Dest-bitmap)
CanvasClone                         - Copy BMP-Canvas to another
BitmapScanLine                      - Write BitmapPixels using scanline (~50% faster)

Screenshot                          - Return Desktop- or WindowHandle-Screenshot as BMP
Window2BMP                          - Return BMP for given WindowHandle (musst be Visible)

BMP2JPG                             - Convert BMP to JPG
BMP2PNG                             - Convert BMP to PNG (Requires PNGLib or Delphi XE+)
WriteBitmapToTiff_1                 - Save 1-Bit-BMP as TIF (Requires TIFLib or Delphi XE+)
WriteBitmapToTiff_2432              - Save 24/32-Bit-BMP as TIF (Requires TIFLib or Delphi XE+)
ReadTiffToBitmap                    - Load 24/32-Bit-TIF as BMP (Requires TIFLib or Delphi XE+)

RAWToBuffer                         - RAW-File to ByteBuffer
BufferToRAW                         - ByteBuffer to RAW-File (Supports RGB&8-Bit)
BitmapToBuffer                      - BMP/BMP-File to ByteBuffer
BufferToBitmap                      - ByteBuffer to BMP/BMP-File (Supports RGB&8-Bit)
TIFFToBuffer                        - TIFF-File to ByteBuffer
BufferToTIFF                        - ByteBuffer to TIFF-File (Supports RGB&8-Bit)
PNGoBuffer                          - PNG/PNG-File to ByteBuffer
BufferToPNG                         - ByteBuffer to PNG/PNG-File (Supports RGB&8-Bit)

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
DrawImage                           - Draws given TBitmap on given canvas within Rect
PrintImage                          - Sends TImage to Printer with given Zoom

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
RotateBitmapSWT                     - Rotate Bitmap by given angle (SetWorldTransform)
RotateBitmapPLG                     - Rotate Bitmap by given angle (PlgBlt)
RotateBitmapGR32                    - Rotate Bitmap32 (Graphics32) by given angle

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
DrawArrow                           - Draw an filled Arrow on a Canvas into given Rect
DrawPoints                          - Draws TPoints on a Canvas by connection each points by Line
DrawRect                            - Draws Rect for given Points on a Canvas
DrawLine                            - Draws Line for given Points on a Canvas
DrawCross                           - Draws Cross with given Radius on a Canvas
DrawPlus                            - Draws Plus with given Radius on a Canvas

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
IconToBmp                           - Paint Icon from Executable or HIcon to given BMP (Streching support)

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Kyouzou                             - Creates a ScreenShot-Series for all forms of the Software
                                      Including recursive search for PageControls and displays any Page
                                      Kyouzou=Kyôzô=MirrorImage
KyouzouMode                         - Enables DoubleClick Events for each Form to save screenshots

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Colors~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ComplementaryColor                  - Calculate ComplementaryColor
RGB2TColor                          - Convert RGB-Values into TColor
RGB2TColorRec                       - Convert RGB-Values into TColorRec
TColor2RGB                          - Convert TColor into RGB-Values

ListRALs                            - List RALs (ID (Name)) into StringList
ListRAL_IDs                         - List RAL IDs into StringList
ListRAL_Names                       - List RAL Names into StringList

RGB2CMY                             - Convert RGB into CMY-Values
CMY2RGB                             - Convert CMY into RGB-Values
RGB2CMYK                            - Convert RGB into CMYK-Values
CMYK2RGB                            - Convert CMYK into RGB-Values
RGB2HSV                             - Convert RGB into HSV-Values
HSV2RGB                             - Convert HSV into RGB-Values
RGB2HSL                             - Convert RGB into HSL-Values
HSL2RGB                             - Convert HSL into RGB-Values
Color2CMY                           - Convert Color/ColorRec into CMY-Values
CMY2Color                           - Convert CMY into Color/ColorRec
Color2CMYK                          - Convert Color/ColorRec into CMYK-Values
CMYK2Color                          - Convert CMYK into Color/ColorRec
Color2HSV                           - Convert Color/ColorRec into HSV-Values
HSV2Color                           - Convert HSV into Color/ColorRec
Color2HSL                           - Convert Color/ColorRec into HSL-Values
HSL2Color                           - Convert HSL into Color/ColorRec
CMY2CMYK                            - Convert CMY into CMYK-Values
CMYK2CMY                            - Convert CMYK into CMY-Values
Color2RAL                           - Convert TColor/TColorRec into RAL-Values
RGB2RAL                             - Convert RGB into RAL-Values
RAL2RGB                             - Convert RAL into RGB-Values
RAL2Color                           - Convert RAL into TColor/TColorRec

nearestLutColor                     - Find nearest Color in Lut-Table
RGB_to_monochrome                   - Convert RGB24 to monochrome
monochrome_to_rgb                   - Convert monochrome to RGB24
RGB_to_gray2                        - Convert RGB24 to GrayScale 2Bit
gray2_to_RGB                        - Convert GrayScale 2Bit to RGB24
RGB_to_gray3                        - Convert RGB24 to GrayScale 3Bit
gray3_to_RGB                        - Convert GrayScale 3Bit to RGB24
RGB_to_gray4                        - Convert RGB24 to GrayScale 4Bit
gray4_to_RGB                        - Convert GrayScale 4Bit to RGB24
RGB_to_gray8_Lightness              - Convert RGB24 to GrayScale 8Bit using Lightness-Mode (The lightness method averages the most prominent and least prominent colors :  ( max( R, G, B ) + min( R, G, B ) ))
RGB_to_gray8_Average                - Convert RGB24 to GrayScale 8Bit using Average-Mode (( R + G + B ) / 3)
RGB_to_gray8_Luminosity             - Convert RGB24 to GrayScale 8Bit using Luminosity-Mode (The luminosity method is a more sophisticated version of the average method.
                                                                                             It also averages the values, but it forms a weighted average to account for human perception.
                                                                                             We’re more sensitive to green than other colors, so green is weighted most heavily.
                                                                                             The formula for luminosity is 0.2126 R + 0.7152 G + 0.0722 B.)
RGB_to_gray8_Red                    - Convert RGB24 to GrayScale 8Bit using Red-Channel
RGB_to_gray8_Green                  - Convert RGB24 to GrayScale 8Bit using Green-Channel
RGB_to_gray8_Blue                   - Convert RGB24 to GrayScale 8Bit using Blue-Channel
gray8_to_RGB                        - Convert GrayScale 8Bit to RGB24
RGB_to_rgb3                         - Convert RGB24 to RGB3
rgb3_to_RGB                         - Convert rgb3 to RGB24
RGB_to_rgbi                         - Convert RGB24 to rgbi
rgbi_to_RGB                         - Convert rgbi to RGB24
RGB_to_rgb6                         - Convert RGB24 to rgb6
rgb6_to_RGB                         - Convert rgb6 to RGB24
RGB_to_rgb8                         - Convert RGB24 to rgb8
rgb8_to_RGB                         - Convert rgb8 to RGB24
RGB_to_rgb9                         - Convert RGB24 to rgb9
rgb9_to_RGB                         - Convert rgb9 to RGB24
RGB_to_rgb12                        - Convert RGB24 to rgb12
rgb12_to_RGB                        - Convert rgb12 to RGB24
RGB_to_rgb15                        - Convert RGB24 to rgb15
rgb15_to_RGB                        - Convert rgb15 to RGB24
RGB_to_rgb16                        - Convert RGB24 to rgb16
rgb16_to_RGB                        - Convert rgb16 to RGB24
RGB_to_web216                       - Convert RGB24 to web216
web216_to_RGB                       - Convert web216 to RGB24   
RGB_to_ega4                         - Convert RGB24 to ega4
ega4_to_RGB                         - Convert ega4 to RGB24     
RGB_to_cga4                         - Convert RGB24 to cga4     
cga4_to_RGB                         - Convert cga4 to RGB24
RGB_to_cga2                         - Convert RGB24 to cga2
cga2_to_RGB                         - Convert cga2 to RGB24     
RGB_to_mswin4                       - Convert RGB24 to mswin4
mswin4_to_RGB                       - Convert mswin4 to RGB24
RGB_to_appleii                      - Convert RGB24 to appleii  
appleii4_to_RGB                     - Convert appleii4 to RGB24
RGB_to_vic20                        - Convert RGB24 to vic20    
vic20_to_RGB                        - Convert vic20 to RGB24
RGB_to_c64                          - Convert RGB24 to c64      
c64_to_RGB                          - Convert c64 to RGB24
RGB_to_amiga2                       - Convert RGB24 to amiga2
amiga2_to_RGB                       - Convert amiga2 to RGB24
RGB_to_amiga3                       - Convert RGB24 to amiga3   
amiga3_to_RGB                       - Convert amiga3 to RGB24
RGB_to_amiga4                       - Convert RGB24 to amiga4   
amiga4_to_RGB                       - Convert amiga4 to RGB24
RGB_to_amiga5                       - Convert RGB24 to amiga5
amiga5_to_RGB                       - Convert amiga5 to RGB24   
RGB_to_spectrum                     - Convert RGB24 to spectrum
spectrum_to_RGB                     - Convert spectrum to RGB24 
RGB_to_amstrad                      - Convert RGB24 to amstrad
amstrad5_to_RGB                     - Convert amstrad5 to RGB24 
RGB_to_gameboy                      - Convert RGB24 to gameboy
gameboy_to_RGB                      - Convert gameboy to RGB24
nes_to_RGB                          - Convert Nintendo Entertainment System to RGB24
}

{$IFNDEF TLH_OMIT_SECTIONS}
unit uTLH.Graphics;

{$I uTLH.inc}
(*
{$DEFINE usePNGLib}     // Kyouzou
{$DEFINE useTIFLib}     // Kyouzou
{.$DEFINE GR32}          // Graphics32 (CanvasClone & BitmapResize)
*)

interface

uses
  Windows, Graphics, Classes
  ,jpeg{BMP2JPG}
  ,Forms{Kyouzou}
  {$IF CompilerVersion >= 22}
    ,Vcl.Imaging.pngimage
  {$ELSE}
    {$IFDEF usePNGLib},PNGImage{$ENDIF}      // Kyouzou
    {$IFDEF useTIFLib},LibTiffDelphi, LibDelphi{$ENDIF} // Kyouzou
  {$IFEND}
  {$IFDEF ETYPES_FOR_GRAPHICS},uTLH.Math{$ENDIF}
  {$IFDEF MATHROUT},MathRout{$ENDIF}  
  ;
{$ENDIF TLH_OMIT_SECTIONS}

{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CAST OFF}
{$WARN COMPARING_SIGNED_UNSIGNED OFF}
{$WARN COMBINING_SIGNED_UNSIGNED OFF}
{$WARN GARBAGE OFF}
{$IF CompilerVersion >= 22}
  {$LEGACYIFEND ON}
{$IFEND}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
{$IF NOT Defined(TLH_IMPLEMENTATIONSECTION) AND NOT Defined(TLH_INITIALIZATIONSECTION) AND NOT Defined(TLH_FINALIZATIONSECTION)}
function ReturnTextWidth( text : string; vFont : TFont ): Integer;
function ReturnTextHeight( text : string; vFont : TFont ): Integer;
function ReturnAutoWrapHeight( text : string; vWidth : Integer; vFont : TFont ): Integer;
function ReturnAutoWrapLines( text : string; vWidth : Integer; vFont : TFont ): Integer;
function ReturnMaxFontSize( text : string; vFont : TFont; vRect : TRect ): Byte;

function BitMapAppend( var bmp : TBitmap; AppendBitmap : TBitmap; Side : Byte = 0 ): integer;
function BitMapTile( src : TBitmap; xStart, yStart, xEnd, yEnd : Cardinal; var bmp : TBitmap; Stretch : boolean = false ): integer; overload;
{$IFDEF GR32}
function BitMapTile( src : TBitmap32; xStart, yStart, xEnd, yEnd : Cardinal; var bmp : TBitmap32; Stretch : boolean = false ): integer; overload;
{$ENDIF}
function AspectRatioY( X, Y, newX : Cardinal ): Cardinal;
function AspectRatioX( X, Y, newY : Cardinal ): Cardinal;
function BitmapResize( src : TBitmap; var bmp : TBitmap; KeepAspectRatio : boolean = True; Centre : boolean = True ): boolean; overload;
function CanvasClone( src : TBitmap; vCanvas : TCanvas ): boolean; overload;
function CanvasClone( src : TCanvas; bmp : TBitmap ): boolean; overload;
function CanvasClone( src : TCanvas; vCanvas : TCanvas; Width, Height : Cardinal ): boolean; overload;
{$IFDEF GR32}
function BitmapResize( src : TBitmap32; var bmp : TBitmap32; KeepAspectRatio : boolean = True; Centre : boolean = True ): boolean; overload;
function CanvasClone( src : TBitmap32; vCanvas : TCanvas ): boolean; overload;
{$ENDIF}

function BitmapScanLine( var bmp : TBitmap; X, Y : Cardinal; Color : TColor ): boolean; overload;
function BitmapScanLine( var bmp : TBitmap; X, Y : Cardinal; R, G, B : Byte ): boolean; overload;

procedure ScreenShot( bmp: TBitmap; Window : HWND = INVALID_HANDLE_VALUE; HideOwnApplication : boolean = false );
Function Window2BMP(var bmp: TBitmap; windowHandle: HWND): boolean;

procedure BMP2JPG( bmp : TBitmap; var JPG : TJPEGImage ); overload;
function BMP2JPG( bmp : TBitmap ): TJPEGImage; overload;

type
  TByteArray = Array of BYTE;
  pByteArray = ^TByteArray;

function RAWToBuffer( Buffer : PByteArray; vDepth : Byte; FileName : string; X1 : Extended = 0; Y1 : Extended = 0 ): boolean;
function BufferToRAW( Buffer : PByteArray; vWidth, vHeight : Cardinal; vDepth : Byte; FileName : AnsiString; X1 : Extended = 0; Y1 : Extended = 0; X2 : Extended = 0; Y2 : Extended = 0 ): boolean; // MS
function BitmapToBuffer( Buffer : PByteArray; vDepth : Byte; FileName : string; X1 : Extended = 0; Y1 : Extended = 0 ): boolean; overload;
function BitmapToBuffer( Buffer : PByteArray; vDepth : Byte; bmp : TBitmap; X1 : Extended = 0; Y1 : Extended = 0 ): boolean; overload;
function BufferToBitmap( Buffer : PByteArray; vWidth, vHeight : Cardinal; vDepth : Byte; bmp : TBitmap; X1 : Extended = 0; Y1 : Extended = 0; X2 : Extended = 0; Y2 : Extended = 0; Stretch : boolean = false ): boolean; overload;
function BufferToBitmap( Buffer : PByteArray; vWidth, vHeight : Cardinal; vDepth : Byte; FileName : string; X1 : Extended = 0; Y1 : Extended = 0; X2 : Extended = 0; Y2 : Extended = 0; Stretch : boolean = false ): boolean; overload;

{$IF ( CompilerVersion >= 22 ) OR Defined(useTIFLib)}
procedure WriteBitmapToTiff_1(Bitmap: TBitmap; Filename: {$IF ( CompilerVersion < 22 )}AnsiString{$ELSE}String{$IFEND});
procedure WriteBitmapToTiff_2432(Bitmap: TBitmap; Filename: {$IF ( CompilerVersion < 22 )}AnsiString{$ELSE}String{$IFEND});
function ReadTiffToBitmap( Filename: {$IF ( CompilerVersion < 22 )}AnsiString{$ELSE}String{$IFEND}; var bmp : TBitmap ): boolean;
{$IFEND}

{$IF ( CompilerVersion < 22 ) AND Defined(useTIFLib)}
procedure LibTIFF_ErrorHandler(a: Pointer; b: Pointer; c: Pointer); cdecl;
function BufferToTIFF( Buffer : PByteArray; vWidth, vHeight : Cardinal; vDepth : Byte; FileName : AnsiString; X1 : Extended = 0; Y1 : Extended = 0; X2 : Extended = 0; Y2 : Extended = 0; vFileDepth : Byte = 0; vCompression : Cardinal = COMPRESSION_LZW ): boolean; // MS D10+ Version ...
function TiffToBuffer( Buffer : PByteArray; vDepth : Byte; FileName : string; X1 : Extended = 0; Y1 : Extended = 0 ): boolean;
{$IFEND}

{$IF ( CompilerVersion >= 22 ) OR Defined( usePNGLib )}
function PNGToBuffer( Buffer : PByteArray; vDepth : Byte; FileName : string; X1 : Extended = 0; Y1 : Extended = 0 ): boolean; overload;
function PNGToBuffer( Buffer : PByteArray; vDepth : Byte; PNG : {$IF CompilerVersion >= 22}TPNGImage{$ELSE}TPNGObject{$IFEND}; X1 : Extended = 0; Y1 : Extended = 0 ): boolean; overload;
function BufferToPNG( Buffer : PByteArray; vWidth, vHeight : Cardinal; vDepth : Byte; FileName : string; X1 : Extended = 0; Y1 : Extended = 0; X2 : Extended = 0; Y2 : Extended = 0; Stretch : boolean = false ): boolean; overload;
function BufferToPNG( Buffer : PByteArray; vWidth, vHeight : Cardinal; vDepth : Byte; PNG : {$IF CompilerVersion >= 22}TPNGImage{$ELSE}TPNGObject{$IFEND}; X1 : Extended = 0; Y1 : Extended = 0; X2 : Extended = 0; Y2 : Extended = 0; Stretch : boolean = false ): boolean; overload;

procedure BMP2PNG( bmp : TBitmap; var PNG : {$IF CompilerVersion >= 22}TPNGImage{$ELSE}TPNGObject{$IFEND} ); overload;
function BMP2PNG( bmp : TBitmap ): {$IF CompilerVersion >= 22}TPNGImage{$ELSE}TPNGObject{$IFEND}; overload;
{$IFEND}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure DrawImage( vCanvas: TCanvas; DestRect: TRect; ABitmap: TBitmap );
procedure PrintImage( bmp: TBitmap; ZoomPercent: Byte = 100 );

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure RotateBitmapSWT(Bmp: TBitmap; Rads: Single; AdjustSize: Boolean; BkColor: TColor = clNone);
procedure RotateBitmapPLG(Bmp: TBitmap; Rads: Single; AdjustSize: Boolean; BkColor: TColor = clNone);
{$IFDEF GR32}
procedure RotateBitmapGR32(Bmp: TBitmap32; Degs: Integer; AdjustSize: Boolean; BkColor: TColor = clNone; Transparent: Boolean = False); overload;
procedure RotateBitmapGR32(Bmp: TBitmap; Degs: Integer; AdjustSize: Boolean; BkColor: TColor = clNone); overload;
{$ENDIF}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure DrawArrow( vCanvas : TCanvas; vRect : TRect; Offset : Byte; Orientation : Byte = 0; Color : TColor = clBlack; FillColor : TColor = clBlack );
procedure DrawPoints( vCanvas : TCanvas; var Points : Array of TPoint ); overload;
{$IFDEF ETYPES_FOR_GRAPHICS}
procedure DrawPoints( vCanvas : TCanvas; var Points : Array of Typ_EPunkt ); overload;
{$ENDIF}

procedure DrawRect( vCanvas : TCanvas; TopLeft, TopRight, BottomLeft, BottomRight : TPoint ); overload;
procedure DrawRect( vCanvas : TCanvas; TopLeft, BottomRight : TPoint ); overload;
procedure DrawRect( vCanvas : TCanvas; x1, y1, x2, y2 : Extended ); overload;
procedure DrawRect( vCanvas : TCanvas; vRect : TRect ); overload;
procedure DrawRect( vCanvas : TCanvas; x1, y1, x2, y2, x3, y3, x4, y4 : Extended ); overload;
{$IFDEF ETYPES_FOR_GRAPHICS}
procedure DrawRect( vCanvas : TCanvas; TopLeft, TopRight, BottomLeft, BottomRight : TYP_ePunkt ); overload;
procedure DrawRect( vCanvas : TCanvas; vRect : tERect ); overload;
{$ENDIF}

procedure DrawLine( vCanvas : TCanvas; x1, y1, x2, y2 : Extended ); overload;
procedure DrawLine( vCanvas : TCanvas; P1, P2 : TPoint ); overload;
{$IFDEF ETYPES_FOR_GRAPHICS}
procedure DrawLine( vCanvas : TCanvas; P1, P2 : Typ_EPunkt ); overload;
procedure DrawLine( vCanvas : TCanvas; Line : TELine ); overload;
{$ENDIF}

procedure DrawCross( vCanvas : TCanvas; CenterX, CenterY : Extended; Radius : Word = 1 ); overload;
procedure DrawCross( vCanvas : TCanvas; Center : TPoint; Radius : Word = 1 ); overload;
{$IFDEF ETYPES_FOR_GRAPHICS}
procedure DrawCross( vCanvas : TCanvas; Center : TYP_ePunkt; Radius : Word = 1 ); overload;
{$ENDIF}

procedure DrawPlus( vCanvas : TCanvas; CenterX, CenterY : Extended; Radius : Word = 1 ); overload;
procedure DrawPlus( vCanvas : TCanvas; Center : TPoint; Radius : Word = 1 ); overload;
{$IFDEF ETYPES_FOR_GRAPHICS}
procedure DrawPlus( vCanvas : TCanvas; Center : TYP_ePunkt; Radius : Word = 1 ); overload;
{$ENDIF}

procedure DrawTriangle( vCanvas : TCanvas; x1, y1, x2, y2, x3, y3 : Extended ); overload;
procedure DrawTriangle( vCanvas : TCanvas; P1, P2, P3 : TPoint ); overload;
{$IFDEF ETYPES_FOR_GRAPHICS}
procedure DrawTriangle( vCanvas : TCanvas; P1, P2, P3 : TYP_ePunkt ); overload;
procedure DrawTriangle( vCanvas : TCanvas; vTriangle : tETriangle ); overload;
{$ENDIF}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function IconToBmp( FileName : string; var bmp : TBitmap; IconID : Word = 0 ) : Boolean; overload;
function IconToBmp( Icon : HIcon; var bmp : TBitmap ) : Boolean; overload;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
type
  tKyouzouPictureFormat = (
    pfBMP, pfJPG
    {$IF ( CompilerVersion >= 22 ) OR Defined( usePNGLib )}, pfPNG{$IFEND}
    {$IF ( CompilerVersion >= 22 ) OR Defined( useTIFLib )}, pfTIF{$IFEND}
  );
procedure Kyouzou( Folder : string = ''; PicFormat : tKyouzouPictureFormat = {$IF ( CompilerVersion >= 22 ) OR Defined( useTIFLib )}pfPNG{$ELSE}pfJPG{$IFEND}; ShowInvisibleTabs : boolean = false );
procedure KyouzouMode( PicFormat : tKyouzouPictureFormat = {$IF ( CompilerVersion >= 22 ) OR Defined( useTIFLib )}pfPNG{$ELSE}pfJPG{$IFEND} );
procedure FormOnDoubleClickBMP(Self: TForm; Sender: TObject);
procedure FormOnDoubleClickJPG(Self: TForm; Sender: TObject);
{$IFDEF usePNGLib}
procedure FormOnDoubleClickPNG(Self: TForm; Sender: TObject);
{$ENDIF}
{$IFDEF useTIFLib}
procedure FormOnDoubleClickTIF(Self: TForm; Sender: TObject);
{$ENDIF}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
type
  tColorRec = packed record
    case Integer of
      0 : (
          R     : byte;
          G     : byte;
          B     : byte;
          Alpha : Byte;
          );
      1 : ( Color : TColor );
  end;
  pColorRec = ^tColorRec;

function  ComplementaryColor( Color : TColor ): TColor;
function  RGB2TColor( const R, G, B : Byte ): TColor; 
procedure TColor2RGB( const Color: TColor; var R, G, B : Byte );

procedure RGB2CMY( R, G, B : byte; var C, M, Y : double );
function  CMY2RGB( C, M, Y : double; var R, G, B : byte ): boolean;
function  CMY2CMYK( var C, M, Y, K : double ): boolean;
function  CMYK2CMY( var C, M, Y : double; K : double ): boolean;
procedure RGB2CMYK( R, G, B : byte; var C, M, Y, K : double );
function  CMYK2RGB( C, M, Y, K : double; var R, G, B : byte ): boolean;
procedure RGB2HSV( R, G, B : byte; var H, S, V : double );
function  HSV2RGB( H, S, V : double; var R, G, B : byte ): boolean;
procedure RGB2HSL( R, G, B : byte; var H, S, L : double );
function  HSL2RGB( H, S, L : double; var R, G, B : byte ): boolean;

procedure Color2CMY( Color : tColorRec; var C, M, Y : double );
function  CMY2Color( C, M, Y : double; var Color : tColorRec ): boolean;
procedure Color2CMYK( Color : tColorRec; var C, M, Y, K : double );
function  CMYK2Color( C, M, Y, K : double; var Color : tColorRec ): boolean;
procedure Color2HSV( Color : tColorRec; var H, S, V : double );
function  HSV2Color( H, S, V : double; var Color : tColorRec ): boolean;
procedure Color2HSL( Color : tColorRec; var H, S, L : double );
function  HSL2Color( H, S, L : double; var Color : tColorRec ): boolean;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function nearestLutColor( const Color : TColorRec; pLut : pColorRec; uMax : word ) : word; overload;
function nearestLutColor( const R, G, B : Byte; pLut : pColorRec; uMax : word ) : word; overload;
function RGB_to_monochrome( const Color : TColorRec ) : byte; overload;
function RGB_to_monochrome( const R, G, B : Byte ) : byte; overload;
function monochrome_to_rgb( mono : byte ) : TColorRec;
function RGB_to_gray2( const Color : TColorRec ) : byte; overload;
function RGB_to_gray2( const R, G, B : Byte ) : byte; overload;
function gray2_to_RGB( gray2 : byte ) : TColorRec;
function RGB_to_gray3( const Color : TColorRec ) : byte; overload;
function RGB_to_gray3( const R, G, B : Byte ) : byte; overload;
function gray3_to_RGB( gray3 : byte ) : TColorRec;
function RGB_to_gray4( const Color : TColorRec ) : byte; overload;
function RGB_to_gray4( const R, G, B : Byte ) : byte; overload;
function gray4_to_RGB( gray4 : byte ) : TColorRec;
function RGB_to_gray8_Lightness( const Color : TColorRec ) : byte; overload;
function RGB_to_gray8_Lightness( const R, G, B : Byte ) : byte; overload;
function RGB_to_gray8_Average( const Color : TColorRec ) : byte; overload;
function RGB_to_gray8_Average( const R, G, B : Byte ) : byte; overload;
function RGB_to_gray8_Luminosity( const Color : TColorRec ) : byte; overload;
function RGB_to_gray8_Luminosity( const R, G, B : Byte ) : byte; overload;
function RGB_to_gray8_Red( const Color : TColorRec ) : byte; overload;
function RGB_to_gray8_Red( const R, G, B : Byte ) : byte; overload;
function RGB_to_gray8_Green( const Color : TColorRec ) : byte; overload;
function RGB_to_gray8_Green( const R, G, B : Byte ) : byte; overload;
function RGB_to_gray8_Blue( const Color : TColorRec ) : byte; overload;
function RGB_to_gray8_Blue( const R, G, B : Byte ) : byte; overload;
function gray8_to_RGB( gray8 : byte ) : TColorRec;
function RGB_to_rgb3( const Color : TColorRec ) : byte; overload;
function RGB_to_rgb3( const R, G, B : Byte ) : byte; overload;
function rgb3_to_RGB( rgb3 : byte ) : TColorRec;
function RGB_to_rgbi( const Color : TColorRec; scale : word = 300 ) : byte; overload;
function RGB_to_rgbi( const R, G, B : Byte; scale : word = 300 ) : byte; overload;
function rgbi_to_RGB( rgbi : byte ) : TColorRec;
function RGB_to_rgb6( const Color : TColorRec ) : byte; overload;
function RGB_to_rgb6( const R, G, B : Byte ) : byte; overload;
function rgb6_to_RGB( rgb6 : byte ) : TColorRec;
function RGB_to_rgb8( const Color : TColorRec ) : byte; overload;
function RGB_to_rgb8( const R, G, B : Byte ) : byte; overload;
function rgb8_to_RGB( rgb8 : byte ) : TColorRec;
function RGB_to_rgb9( const Color : TColorRec ) : word; overload;
function RGB_to_rgb9( const R, G, B : Byte ) : word;  overload;
function rgb9_to_RGB( rgb9 : word ) : TColorRec;
function RGB_to_rgb12( const Color : TColorRec ) : word; overload;
function RGB_to_rgb12( const R, G, B : Byte ) : word; overload;
function rgb12_to_RGB( n : word ) : TColorRec;
function RGB_to_rgb15( const Color : TColorRec ) : word; overload;
function RGB_to_rgb15( const R, G, B : Byte ) : word; overload;
function rgb15_to_RGB( rgb15 : word ) : TColorRec;
function RGB_to_rgb16( const Color : TColorRec ) : word; overload;
function RGB_to_rgb16( const R, G, B : Byte ) : word; overload;
function rgb16_to_RGB( rgb16 : word ) : TColorRec;
function RGB_to_web216( const Color : TColorRec ) : byte; overload;
function RGB_to_web216( const R, G, B : Byte ) : byte; overload;
function web216_to_RGB( n : byte ) : TColorRec;
function RGB_to_ega4( const Color : TColorRec ) : byte; overload;
function RGB_to_ega4( const R, G, B : Byte ) : byte; overload;
function ega4_to_RGB( ega4 : byte ) : TColorRec;
function RGB_to_cga4( const Color : TColorRec ) : byte; overload;
function RGB_to_cga4( const R, G, B : Byte ) : byte; overload;
function cga4_to_RGB( cga4 : byte ) : TColorRec;
function RGB_to_cga2( const Color : TColorRec ) : byte; overload;
function RGB_to_cga2( const R, G, B : Byte ) : byte; overload;
function cga2_to_RGB( cga2 : byte ) : TColorRec;
function RGB_to_mswin4( const Color : TColorRec ) : byte; overload;
function RGB_to_mswin4( const R, G, B : Byte ) : byte; overload;
function mswin4_to_RGB( win4 : byte ) : TColorRec;
function RGB_to_appleii( const Color : TColorRec ) : byte; overload;
function RGB_to_appleii( const R, G, B : Byte ) : byte; overload;
function appleii4_to_RGB( n : byte ) : TColorRec;
function RGB_to_vic20( const Color : TColorRec ) : byte; overload;
function RGB_to_vic20( const R, G, B : Byte ) : byte; overload;
function vic20_to_RGB( vic20 : byte ) : TColorRec;
function RGB_to_c64( const Color : TColorRec ) : byte; overload;
function RGB_to_c64( const R, G, B : Byte ) : byte; overload;
function c64_to_RGB( c64 : byte ) : TColorRec;
function RGB_to_amiga2( const Color : TColorRec ) : byte; overload;
function RGB_to_amiga2( const R, G, B : Byte ) : byte; overload;
function amiga2_to_RGB( amiga2 : byte ) : TColorRec;
function RGB_to_amiga3( const Color : TColorRec ) : byte; overload;
function RGB_to_amiga3( const R, G, B : Byte ) : byte; overload;
function amiga3_to_RGB( amiga3 : byte ) : TColorRec;
function RGB_to_amiga4( const Color : TColorRec ) : byte; overload;
function RGB_to_amiga4( const R, G, B : Byte ) : byte; overload;
function amiga4_to_RGB( amiga4 : byte ) : TColorRec;
function RGB_to_amiga5( const Color : TColorRec ) : byte; overload;
function RGB_to_amiga5( const R, G, B : Byte ) : byte; overload;
function amiga5_to_RGB( amiga5 : byte ) : TColorRec;
function RGB_to_spectrum( const Color : TColorRec ) : byte; overload;
function RGB_to_spectrum( const R, G, B : Byte ) : byte; overload;
function spectrum_to_RGB( const Color : TColorRec ) : byte; overload;
function spectrum_to_RGB( const R, G, B : Byte ) : byte; overload;
function RGB_to_amstrad( const Color : TColorRec ) : byte; overload;
function RGB_to_amstrad( const R, G, B : Byte ) : byte; overload;
function amstrad5_to_RGB( n : byte ) : TColorRec;
function RGB_to_gameboy( const Color : TColorRec ) : byte;  overload;
function RGB_to_gameboy( const R, G, B : Byte ) : byte;  overload;
function gameboy_to_RGB( n : byte ) : TColorRec;
function nes_to_RGB( nes6 : byte ) : TColorRec;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// RAL
type
  tRAL_Color = packed record
    ID    : SmallInt;
    Name  : string;
    case Integer of
      0 : (
          R     : byte;
          G     : byte;
          B     : byte;
          Alpha : Byte;
          );
      1 : ( Color : TColor );
  end;

  tRAL_Table = record
    Items : Array [0..212] of tRAL_Color;
    Inited : boolean;
  end;

var
  RAL_Table : tRAL_Table;

function  RAL2RGB( RAL : SmallInt; var R, G, B : byte ): boolean; overload;
function  RAL2RGB( RAL : string; var R, G, B : byte ): boolean; overload;
function  RAL2Color( RAL : SmallInt; var vColor : TColorRec ): boolean; overload;
function  RAL2Color( RAL : string; var vColor : TColorRec ): boolean; overload;
function  RAL2Color( RAL : SmallInt; var vColor : TColor ): boolean; overload;
function  RAL2Color( RAL : string; var vColor : TColor ): boolean; overload;
function  RGB2RAL( R, G, B : byte; var RAL : SmallInt; var RALName : string ): boolean; overload;
function  RGB2RAL( R, G, B : byte; var RAL : SmallInt ): boolean; overload;
function  RGB2RAL( R, G, B : byte; var RAL : string ): boolean; overload;
function  Color2RAL( vColor : TColorRec; var RAL : SmallInt; var RALName : string ): boolean; overload;
function  Color2RAL( vColor : TColorRec; var RAL : SmallInt ): boolean; overload;
function  Color2RAL( vColor : TColorRec; var RAL : string ): boolean; overload;
function  Color2RAL( vColor : TColor; var RAL : SmallInt; var RALName : string ): boolean; overload;
function  Color2RAL( vColor : TColor; var RAL : SmallInt ): boolean; overload;
function  Color2RAL( vColor : TColor; var RAL : string ): boolean; overload;

procedure ListRALs( var StrL : TStringList );
procedure ListRAL_IDs( var StrL : TStringList );
procedure ListRAL_Names( var StrL : TStringList );
procedure InitRALTable;
{$IFEND TLH_IMPLEMENTATIONSECTION}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
{$IFNDEF TLH_OMIT_SECTIONS}
implementation

uses
  Math, SysUtils,
  Controls,{Kyouzou:ControlHasClassOnIt}
  ShellAPI,{DrawIconEx}
  ComCtrls, Dialogs{Kyouzou}
  {$IFDEF GR32}, GR32{$ENDIF}
  ,Printers;
{$ENDIF TLH_OMIT_SECTIONS}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
{$IF NOT Defined(TLH_INTERFACESECTION) AND NOT Defined(TLH_INITIALIZATIONSECTION) AND NOT Defined(TLH_FINALIZATIONSECTION)}
function ReturnTextWidth( text : string; vFont : TFont ): Integer;
var
  bmp : TBitmap;
begin
  bmp := TBitmap.Create;
  bmp.Canvas.Font := vFont;
  result := bmp.Canvas.TextWidth( text );
  bmp.free;
end;

function ReturnTextHeight( text : string; vFont : TFont ): Integer;
var
  bmp : TBitmap;
begin
  bmp := TBitmap.Create;
  bmp.Canvas.Font := vFont;
  result := bmp.Canvas.TextHeight( text );
  bmp.free;
end;

function ReturnAutoWrapHeight( text : string; vWidth : Integer; vFont : TFont ): Integer;
var
  vRect : TRect;
  bmp   : TBitmap;
begin
  vRect.Left   := 0;
  vRect.Right  := vWidth;
  vRect.Top    := 0;
  vRect.Bottom := 0;

  bmp := TBitmap.Create;
  {$IF CompilerVersion < 17}
  DrawTextEx( bmp.Canvas.Handle, PChar(Text), Length(Text), vRect, ( DT_CALCRECT or DT_WORDBREAK ){Format}, nil);
  {$ELSE}
  bmp.Canvas.TextRect( vRect, Text, [ tfCalcRect, tfWordBreak ] ); //flags to say "compute text dimensions with line breaks"
  {$IFEND}
  bmp.Free;

  result := vRect.Bottom;
end;

function ReturnAutoWrapLines( text : string; vWidth : Integer; vFont : TFont ): Integer;
var
  vRect : TRect;
  bmp   : TBitmap;
begin
  vRect.Left   := 0;
  vRect.Right  := vWidth;
  vRect.Top    := 0;
  vRect.Bottom := 0;

  bmp := TBitmap.Create;

  {$IF CompilerVersion < 17}
  DrawTextEx( bmp.Canvas.Handle, PChar(Text), Length(Text), vRect, ( DT_CALCRECT or DT_WORDBREAK ){Format}, nil);
  {$ELSE}
  bmp.Canvas.TextRect( vRect, Text, [ tfCalcRect, tfWordBreak ] ); //flags to say "compute text dimensions with line breaks"
  {$IFEND}
  result := vRect.Bottom div bmp.Canvas.TextHeight( 'A' );
  bmp.Free;
end;

function ReturnMaxFontSize( text : string; vFont : TFont; vRect : TRect ): Byte;
var
  bmp : TBitmap;
  w, h : Integer;
begin
  result := 1;
  if ( text = '' ) OR ( vFont = nil ) then
    Exit;

  bmp := TBitmap.Create;
  bmp.Canvas.Font := vFont;

  w := 0;
  h := 0;
  while ( w < vRect.Right-vRect.Left{vRect.Width} ) AND ( h < vRect.Bottom-vRect.Top{vRect.Height} ) and ( result < 255 ) do
    begin
    bmp.Canvas.Font.Size := result;
    w := bmp.Canvas.TextWidth( text );
    h := bmp.Canvas.TextHeight( text );
    Inc( result );
    end;
  bmp.free;
end;

{$IFDEF GR32}
function BitMapTile( src : TBitmap32; xStart, yStart, xEnd, yEnd : Cardinal; var bmp : TBitmap32; Stretch : boolean = false ): integer;
var
  tmp : TBitmap;
  tmpOut : TBitmap;
begin
  tmp := TBitmap.Create;
  tmp.Width := src.Width;
  tmp.Height := src.Height;
  tmpOut := TBitmap.Create;
  CanvasClone( src, tmp.Canvas );
  result := BitMapTile( tmp, xStart, yStart, xEnd, yEnd, tmpOut, Stretch );
  bmp.Width := tmpOut.Width;
  bmp.Height := tmpOut.Height;
  CanvasClone( tmpOut, bmp.Canvas );
  tmp.free;
  tmpOut.free;
end;
{$ENDIF}

function BitMapTile( src : TBitmap; xStart, yStart, xEnd, yEnd : Cardinal; var bmp : TBitmap; Stretch : boolean = false ): integer;
var
  bmpR         : TBitmap;
begin
  result := -1;
  if ( src = nil ) OR ( bmp = nil ) then
    Exit;

  xEnd := Min( xEnd, src.Width );
  yEnd := Min( yEnd, src.Height );

  if ( xStart = 0 ) AND ( yStart = 0 ) AND ( xEnd = src.Width ) AND ( yEnd = src.Height ) then
    begin
    bmp.Assign( src );
    result := 0;
    Exit;
    end;

  bmpR := TBitmap.Create;
  bmpR.PixelFormat := src.PixelFormat;
  bmpR.Width  := xEnd-xStart;
  bmpR.Height := yEnd-yStart;

  bmpR.Canvas.CopyRect( Classes.Rect( 0, 0, bmpR.Width, bmpR.Height ), src.Canvas, Classes.Rect( xStart, yStart, xEnd, yEnd ) );

  if NOT Stretch then
    bmp.Assign( bmpR )
  else
    begin
    bmp.Width := src.Width;
    bmp.Height := src.Height;
    StretchBlt( bmp.Canvas.Handle, 0, 0, bmp.Width, bmp.Height, bmpR.Canvas.Handle, 0, 0, bmpR.Width, bmpR.Height, SRCCOPY );
    end;
  bmpR.free;
  result := 0;
end;

function BitMapAppend( var bmp : TBitmap; AppendBitmap : TBitmap; Side : Byte = 0 ): integer;
{
  Side
    0 : Left
    1 : Right
    2 : Top
    3 : Bottom
}
var
  bmpD : TBitmap;
begin
  result := -1;
  if ( bmp = nil ) OR ( AppendBitmap = nil ) then
    Exit;

  result := -2;
  bmpD := TBitmap.Create;
  case Side of
    0 : begin // Left
        bmpD.Width := bmp.Width + AppendBitmap.Width;
        bmpD.Height := Max( bmp.Height, AppendBitmap.Height );
        bmpD.Canvas.CopyRect( Classes.Rect( 0, 0, AppendBitmap.Width, AppendBitmap.Height ), AppendBitmap.Canvas, Classes.Rect( 0, 0, AppendBitmap.Width, AppendBitmap.Height ) );
        bmpD.Canvas.CopyRect( Classes.Rect( AppendBitmap.Width, 0, bmpD.Width, bmpD.Height ), bmp.Canvas, Classes.Rect( 0, 0, bmp.Width, bmp.Height ) );
        end;
    1 : begin // Top
        bmpD.Width := Max( bmp.Width, AppendBitmap.Width );
        bmpD.Height := bmp.Height + AppendBitmap.Height;
        bmpD.Canvas.CopyRect( Classes.Rect( 0, 0, AppendBitmap.Width, AppendBitmap.Height ), AppendBitmap.Canvas, Classes.Rect( 0, 0, AppendBitmap.Width, AppendBitmap.Height ) );
        bmpD.Canvas.CopyRect( Classes.Rect( 0, AppendBitmap.Height, bmpD.Width, bmpD.Height ), bmp.Canvas, Classes.Rect( 0, 0, bmp.Width, bmp.Height ) );
        end;
    2 : begin // Right
        bmpD.Width := bmp.Width + AppendBitmap.Width;
        bmpD.Height := Max( bmp.Height, AppendBitmap.Height );
        bmpD.Canvas.CopyRect( Classes.Rect( 0, 0, bmp.Width, bmp.Height ), bmp.Canvas, Classes.Rect( 0, 0, bmp.Width, bmp.Height ) );
        bmpD.Canvas.CopyRect( Classes.Rect( bmp.Width, 0, bmpD.Width, bmpD.Height ), AppendBitmap.Canvas, Classes.Rect( 0, 0, AppendBitmap.Width, AppendBitmap.Height ) );
        end;
    3 : begin // Bottom
        bmpD.Width := Max( bmp.Width, AppendBitmap.Width );
        bmpD.Height := bmp.Height + AppendBitmap.Height;
        bmpD.Canvas.CopyRect( Classes.Rect( 0, 0, bmp.Width, bmp.Height ), bmp.Canvas, Classes.Rect( 0, 0, bmp.Width, bmp.Height ) );
        bmpD.Canvas.CopyRect( Classes.Rect( 0, bmp.Height, bmpD.Width, bmpD.Height ), AppendBitmap.Canvas, Classes.Rect( 0, 0, AppendBitmap.Width, AppendBitmap.Height ) );
        end;
  else
    begin
    bmpD.Free;
    Exit;
    end;
  end;
  bmp.Assign( bmpD );
  bmpD.free;
  result := 0;
end;

function AspectRatioY( X, Y, newX : Cardinal ): Cardinal;
begin
  result := Y;
  if ( X = 0 ) OR ( Y = 0 ) then
    Exit;
  result := Trunc( newX * Y/X );
end;

function AspectRatioX( X, Y, newY : Cardinal ): Cardinal;
begin
  result := X;
  if ( X = 0 ) OR ( Y = 0 ) then
    Exit;
  result := Trunc( newY * X/Y );
end;

function BitmapResize( src : TBitmap; var bmp : TBitmap; KeepAspectRatio : boolean = True; Centre : boolean = True ): boolean;
var
  bmpR         : TBitmap;
  useX, useY   : Integer;
  EdgeX,
  EdgeY        : Word;
begin
  result := false;
  if ( src = nil ) OR ( bmp = nil ) then
    Exit;

  if ( src.Width = bmp.Width ) and ( src.Height = bmp.Height ) then
    begin
    bmp.Assign(src);
    result := true;
    Exit;
    end;

  useX := bmp.Width;
  useY := bmp.Height;
  if KeepAspectRatio then
    begin
    if ( bmp.Height > bmp.Width ) then
      begin
      useX := bmp.Width;
      useY := AspectRatioY( src.Width, src.Height, useX );
      end
    else
      begin
      useY := bmp.Height;
      useX := AspectRatioX( src.Width, src.Height, useY );
      end;
    end;

  bmpR             := TBitmap.Create;
  bmpR.PixelFormat := src.PixelFormat;
  bmpR.Width       := useX;
  bmpR.Height      := useY;
  StretchBlt( bmpR.Canvas.Handle, 0, 0, bmpR.Width, bmpR.Height, src.Canvas.Handle, 0, 0, src.Width, src.Height, SRCCOPY );

  EdgeX := 0;
  EdgeY := 0;
  if Centre AND ( bmp.Width > useX ) then
    EdgeX := (bmp.Width-useX) div 2;
  if Centre AND ( bmp.Height > useY ) then
    EdgeY := (bmp.Height-useY) div 2;

  if ( EdgeX+EdgeY <> 0 ) then
    begin
    bmp.Canvas.Brush.Color := clBlack;
    bmp.Canvas.Brush.Style := bsSolid;
    bmp.Canvas.FillRect( Classes.Rect( 0, 0, bmp.Width, bmp.Height ) );
    end;

  bmp.Canvas.CopyRect( Classes.Rect( EdgeX, EdgeY, bmp.Width-EdgeX, bmp.Height-EdgeY ), bmpR.Canvas, Classes.Rect( 0, 0, bmpR.Width, bmpR.Height ) );

  bmpR.free;
  result := true;
end;

function CanvasClone( src : TBitmap; vCanvas : TCanvas ): boolean;
begin
  result := false;
  if ( src = nil ) OR ( vCanvas = nil ) then
    Exit;
  vCanvas.CopyRect( Classes.Rect( 0, 0, src.Width, src.Height ), src.Canvas, Classes.Rect( 0, 0, src.Width, src.Height ) );
  result := true;
end;

function CanvasClone( src : TCanvas; bmp : TBitmap ): boolean;
begin
  result := false;
  if ( src = nil ) OR ( bmp = nil ) then
    Exit;
  bmp.Canvas.CopyRect( Classes.Rect( 0, 0, bmp.Width, bmp.Height ), src, Classes.Rect( 0, 0, bmp.Width, bmp.Height ) );
  result := true;
end;

function CanvasClone( src : TCanvas; vCanvas : TCanvas; Width, Height : Cardinal ): boolean;
begin
  result := false;
  if ( src = nil ) OR ( vCanvas = nil ) then
    Exit;
  vCanvas.CopyRect( Classes.Rect( 0, 0, Width, Height ), src, Classes.Rect( 0, 0, Width, Height ) );
  result := true;
end;

{$IFDEF GR32}
function BitmapResize( src : TBitmap32; var bmp : TBitmap32; KeepAspectRatio : boolean = True; Centre : boolean = True ): boolean;
var
  bmpR         : TBitmap;
  useX, useY   : Integer;
  EdgeX,
  EdgeY        : Word;
begin
  result := false;
  if ( src = nil ) OR ( bmp = nil ) then
    Exit;

  if ( src.Width = bmp.Width ) and ( src.Height = bmp.Height ) then
    begin
    bmp.Assign(src);
    result := true;
    Exit;
    end;

  useX := bmp.Width;
  useY := bmp.Height;
  if KeepAspectRatio then
    begin
    if ( bmp.Height > bmp.Width ) then
      begin
      useX := bmp.Width;
      useY := AspectRatioY( src.Width, src.Height, useX );
      end
    else
      begin
      useY := bmp.Height;
      useX := AspectRatioX( src.Width, src.Height, useY );
      end;
    end;

  bmpR             := TBitmap.Create;
  bmpR.Width       := useX;
  bmpR.Height      := useY;
  StretchBlt( bmpR.Canvas.Handle, 0, 0, bmpR.Width, bmpR.Height, src.Canvas.Handle, 0, 0, src.Width, src.Height, SRCCOPY );

  EdgeX := 0;
  EdgeY := 0;
  if Centre AND ( bmp.Width > useX ) then
    EdgeX := (bmp.Width-useX) div 2;
  if Centre AND ( bmp.Height > useY ) then
    EdgeY := (bmp.Height-useY) div 2;

  if ( EdgeX+EdgeY <> 0 ) then
    bmp.Clear( clBlack );

  bmp.Canvas.CopyRect( Classes.Rect( EdgeX, EdgeY, bmp.Width-EdgeX, bmp.Height-EdgeY ), bmpR.Canvas, Classes.Rect( 0, 0, bmpR.Width, bmpR.Height ) );

  bmpR.free;
  result := true;
end;

function CanvasClone( src : TBitmap32; vCanvas : TCanvas ): boolean;
begin
  result := false;
  if ( src = nil ) OR ( vCanvas = nil ) then
    Exit;
  vCanvas.CopyRect( Classes.Rect( 0, 0, src.Width, src.Height ), src.Canvas, Classes.Rect( 0, 0, src.Width, src.Height ) );
  result := true;
end;
{$ENDIF}

function BitmapScanLine( var bmp : TBitmap; X, Y : Cardinal; Color : TColor ): boolean;
var
  R,G,B : Byte;
begin
  TColor2RGB( Color, R, G, B );
  result := BitmapScanLine( bmp, X, Y, R, G, B );
end;

function BitmapScanLine( var bmp : TBitmap; X, Y : Cardinal; R, G, B : Byte ): boolean;
const
  Max_15   = 31; // each RGB component has 5 bits
  Max_R_16 = 31; // 5 bits
  Max_G_16 = 63; // 6 bits (eye is most sensitive to green)
  Max_B_16 = 31; // 5 bits
type
  TByteArray = Array [WORD] of BYTE; // 1 Bit
  pByteArray = ^TByteArray;
  TRGBTripleArray = Array [WORD] of TRGBTriple; // 24Bit
  pRGBTripleArray = ^TRGBTripleArray;
  TRGBQuadArray = Array [WORD] of TRGBQuad; // 32Bit
  pRGBQuadArray = ^TRGBQuadArray;
var
  scanLine8  : pByteArray;
  scanLine16 : pWordArray; // 15/16Bit
  val16      : WORD;
  scanLine24 : pRGBTripleArray;
  val24      : TRGBTriple;
  scanLine32 : pRGBQuadArray;
  val32      : TRGBQuad;
begin
  result := False;
  if NOT Assigned( bmp ) then
    Exit;
  if ( X > bmp.Width ) or ( Y > bmp.Height ) then
    Exit;

  case bmp.PixelFormat of
    pf8Bit  : begin
              scanLine8 := bmp.ScanLine[ Y ];
              scanLine8^[ X ] := R;
              end;

    pf15Bit : begin
              R := Min( R, Max_15 ); // 5 bits
              G := Min( G, Max_15 );
              B := Min( B, Max_15 );

              val16 := (R SHL 10) OR (G SHL 5) OR B;

              scanLine16 := bmp.ScanLine[ Y ];
              scanLine16^[ X ] := val16;
              end;

    pf16Bit : begin
              R := Min( R, Max_R_16 ); // 5 bits
              G := Min( G, Max_G_16 ); // 6 bits (eye is most sensitive to green)
              B := Min( B, Max_B_16 ); // 5 bits

              val16 := (R SHL 11) OR (G SHL 5) OR B;

              scanLine16 := bmp.ScanLine[ Y ];
              scanLine16^[ X ] := val16;
              end;

    pf24Bit : begin
              val24.rgbtRed   := R;
              val24.rgbtGreen := G;
              val24.rgbtBlue  := B;

              scanLine24 := bmp.ScanLine[ Y ];
              scanLine24^[ X ] := val24;
              end;

    pf32Bit : begin
              val32.rgbRed      := R;
              val32.rgbGreen    := G;
              val32.rgbBlue     := B;
              val32.rgbReserved := 0;

              scanLine32 := bmp.ScanLine[ Y ];
              scanLine32^[ X ] := val32;
              end;
  else
    Exit;
  end;
  result := true;
end;

Function Window2BMP(var bmp: TBitmap; windowHandle: HWND): boolean;
var
  rc : TRect;
  huser32 : THandle;
  PrintWindow : function(Hnd: HWND; HdcBlt: HDC; nFlags: UINT): BOOL; stdcall;
begin
 Result := False;
 huser32 := GetModuleHandle(user32);
  if huser32 = 0 then
    Exit;

  @PrintWindow := GetProcAddress(huser32, 'PrintWindow');
  if @PrintWindow = nil then
    Exit;

  GetWindowRect(windowHandle, rc);
  bmp.PixelFormat := pf32bit;
  bmp.Width := rc.Right - rc.Left;
  bmp.Height := rc.Bottom - rc.Top;
  bmp.Canvas.Lock;
  try
    Result := PrintWindow(windowHandle, bmp.Canvas.Handle, 0);
  finally
    bmp.Canvas.Unlock;
    if Result and ((bmp.Width = 0) or (bmp.Height = 0)) then
      Result := False;
  end;
end;

procedure ScreenShot( bmp: TBitmap; Window : HWND = INVALID_HANDLE_VALUE; HideOwnApplication : boolean = false );
var
  c    : TCanvas;
  r    : TRect;
  tAB  : Boolean;
  tABV : Byte;
  Dsk  : Boolean;
begin
  if NOT Assigned( bmp ) then
    Exit;

  Dsk := false;
  if ( Window = INVALID_HANDLE_VALUE ) then
    begin
    Dsk := True;
    Window := GetDesktopWindow;
    end;

  tAB  := false;
  tABV := 100;
  if HideOwnApplication AND Dsk then
    begin
    tAB := Application.MainForm.AlphaBlend;
    tABV := Application.MainForm.AlphaBlendValue;
    Application.MainForm.AlphaBlend := true;
    Application.MainForm.AlphaBlendValue := 0;
    end;

  c := TCanvas.Create;
  c.Handle := GetWindowDC( Window );
  if Dsk then
    r := Classes.Rect( 0, 0, Screen.DesktopWidth, Screen.DesktopHeight )
  else
    if NOT GetWindowRect( Window, R ) then
      Exit;

  try
    bmp.Width := R.Right-R.Left;
    bmp.Height := R.Bottom-R.Top;
    R := Classes.Rect( 0, 0, bmp.Width, bmp.Height );
    bmp.Canvas.CopyRect( r, c, r );
  finally
    ReleaseDC( 0, c.handle );
    c.Free;
    if HideOwnApplication and Dsk then
      begin
      Application.MainForm.AlphaBlend := tAB;
      Application.MainForm.AlphaBlendValue := tABV;
      end;
  end;
end;

{$IF CompilerVersion >= 22}
procedure WriteBitmapToTiff_1(Bitmap: TBitmap; Filename: String);
begin
  WriteBitmapToTiff_2432( Bitmap, FileName );
end;

procedure WriteBitmapToTiff_2432(Bitmap: TBitmap; Filename: String);
var
  Img : TWICImage;
begin
  Img := TWICImage.Create;
  Img.Assign(Bitmap);
  Img.ImageFormat := wifTiff;
  Img.SaveToFile( FileName );
end;

function ReadTiffToBitmap( Filename: String; var bmp : TBitmap ): boolean;
var
  Img : TWICImage;
begin
  result := false;
  if NOT Assigned( bmp ) or ( NOT FileExists( FileName ) ) then
    Exit;
  Img := TWICImage.Create;
  Img.ImageFormat := wifTiff;
  Img.LoadFromFile( FileName );
  bmp.Assign( img );
  result := True;
end;
{$ELSE}
  {$IFDEF useTIFLib}
procedure LibTIFF_ErrorHandler(a: Pointer; b: Pointer; c: Pointer); cdecl;
var
  m: Integer;
  n: String;
begin
  m := sprintfsec( nil,b,@c );
  SetLength( n,m );
  sprintfsec( Pointer(n), b, @c );
  ShowMessage( PChar(a) + ' - ' + n );
end;

procedure WriteBitmapToTiff_1(Bitmap: TBitmap; Filename: {$IF ( CompilerVersion < 22 )}AnsiString{$ELSE}String{$IFEND} );
var
  OpenTiff: PTIFF;
  RowSize: Longword;
  RowsPerStrip: Longword;
  StripMemory: Pointer;
  StripIndex: Longword;
  StripRowOffset: Longword;
  StripRowCount: Longword;
  mb: PByte;
  ny: Longword;
begin
//      if (Bitmap.PixelFormat<>pf1bit) then
//        raise Exception.Create('WriteBitmapToTiff is designed for singlebit bitmaps only');
  RowSize:=((Bitmap.Width+7) div 8);
  RowsPerStrip:=((256*1024) div RowSize);
  if RowsPerStrip>Bitmap.Height then
    RowsPerStrip:=Bitmap.Height
  else if RowsPerStrip=0 then
    RowsPerStrip:=1;
  StripMemory:=GetMemory(RowsPerStrip*RowSize);
  OpenTiff:=TIFFOpen(PAnsiChar(Filename),'w');
  if OpenTiff=nil then
    begin
    FreeMemory(StripMemory);
    raise Exception.Create('Unable to create file '''+Filename+'''');
    end;
  TIFFSetField( OpenTiff, TIFFTAG_IMAGEWIDTH, Bitmap.Width );
  TIFFSetField( OpenTiff, TIFFTAG_IMAGELENGTH, Bitmap.Height );
  TIFFSetField( OpenTiff, TIFFTAG_PHOTOMETRIC, PHOTOMETRIC_MINISWHITE );
  TIFFSetField( OpenTiff, TIFFTAG_SAMPLESPERPIXEL, 1 );
  TIFFSetField( OpenTiff, TIFFTAG_BITSPERSAMPLE, 1 );
  TIFFSetField( OpenTiff, TIFFTAG_COMPRESSION, COMPRESSION_CCITTFAX4 );
  TIFFSetField( OpenTiff, TIFFTAG_ROWSPERSTRIP, RowsPerStrip );
  StripIndex := 0;
  StripRowOffset := 0;
  while ( StripRowOffset < Bitmap.Height ) do
    begin
    StripRowCount := RowsPerStrip;
    if ( StripRowCount > Bitmap.Height-StripRowOffset ) then
      StripRowCount := Bitmap.Height-StripRowOffset;
    mb := StripMemory;
    for ny := StripRowOffset to StripRowOffset+StripRowCount-1 do
      begin
      CopyMemory( mb, Bitmap.ScanLine[ny], RowSize );
      Inc( mb,RowSize );
      end;
    if ( TIFFWriteEncodedStrip( OpenTiff, StripIndex, StripMemory, StripRowCount*RowSize ) = 0 ) then
      begin
      TIFFClose( OpenTiff );
      FreeMemory( StripMemory );
      raise Exception.Create( 'Failed to write ''' + Filename + '''' );
      end;
    Inc( StripIndex );
    Inc( StripRowOffset,StripRowCount );
    end;
  TIFFClose( OpenTiff );
  FreeMem( StripMemory );
end;

procedure WriteBitmapToTiff_2432(Bitmap: TBitmap; Filename: {$IF ( CompilerVersion < 22 )}AnsiString{$ELSE}String{$IFEND});
const
  SAMPLESPERPIXEL = 3;
var
  OpenTiff: PTIFF;
  RowsPerStrip: Longword;
  StripMemory: Pointer;
  StripIndex: Longword;
  StripRowOffset: Longword;
  StripRowCount: Longword;
  ma,mb: PByte;
  nx,ny: Longword;
begin
  if NOT ( Bitmap.PixelFormat in [ pf24bit, pf32bit ] ) then
    raise Exception.Create( 'WriteBitmapToTiff is designed for 24bit and 32bit bitmaps only' );
  RowsPerStrip := ( ( 256*1024 ) div ( Bitmap.Width*3 ) );
  if ( RowsPerStrip > Bitmap.Height ) then
    RowsPerStrip := Bitmap.Height
  else if ( RowsPerStrip = 0 ) then
    RowsPerStrip := 1;
  StripMemory := GetMemory( RowsPerStrip*Bitmap.Width*3 );
  OpenTiff := TIFFOpen( PAnsiChar( Filename ), 'w' );
  if ( OpenTiff = nil ) then
    begin
    FreeMemory( StripMemory );
    raise Exception.Create( 'Unable to create file ''' + Filename + '''' );
    end;
  TIFFSetField( OpenTiff, TIFFTAG_IMAGEWIDTH, Bitmap.Width );
  TIFFSetField( OpenTiff, TIFFTAG_IMAGELENGTH ,Bitmap.Height );
  TIFFSetField( OpenTiff, TIFFTAG_PHOTOMETRIC, PHOTOMETRIC_RGB );
  TIFFSetField( OpenTiff, TIFFTAG_SAMPLESPERPIXEL, SAMPLESPERPIXEL{3} );
  TIFFSetField( OpenTiff, TIFFTAG_BITSPERSAMPLE, 8 );
  TIFFSetField( OpenTiff, TIFFTAG_PLANARCONFIG, PLANARCONFIG_CONTIG );
  TIFFSetField( OpenTiff, TIFFTAG_COMPRESSION, COMPRESSION_LZW );
  TIFFSetField( OpenTiff, TIFFTAG_PREDICTOR, 2 );
  TIFFSetField( OpenTiff, TIFFTAG_ROWSPERSTRIP, RowsPerStrip );
  StripIndex := 0;
  StripRowOffset := 0;
  while ( StripRowOffset < Bitmap.Height ) do
    begin
    StripRowCount := RowsPerStrip;
    if ( StripRowCount > Bitmap.Height-StripRowOffset ) then
      StripRowCount := Bitmap.Height-StripRowOffset;

    mb := StripMemory;
    for ny := StripRowOffset to StripRowOffset+StripRowCount-1 do
      begin
      ma := Bitmap.ScanLine[ ny ];
      for nx:=0 to Bitmap.Width-1 do
        begin
        mb^ := PByte( Cardinal( ma )+2 )^;
        Inc( mb );
        mb^ := PByte( Cardinal( ma )+1 )^;
        Inc( mb );
        mb^ := PByte( Cardinal( ma )+0 )^;
        Inc( mb );
//        if ( SAMPLESPERPIXEL = 4 ) then
//          begin
//          mb^ := PByte( Cardinal( ma )+0 )^;
//          Inc( mb );
//          end;
        if ( Bitmap.PixelFormat = pf24bit ) then
          Inc( ma, 3 )
        else
          Inc( ma, 4 );
        end;
      end;

    if ( TIFFWriteEncodedStrip(OpenTiff,StripIndex, StripMemory,StripRowCount*Bitmap.Width*3 ) = 0 ) then
      begin
      TIFFClose( OpenTiff );
      FreeMemory( StripMemory );
      raise Exception.Create( 'Failed to write ''' + Filename + '''' );
      end;
      Inc( StripIndex);
      Inc( StripRowOffset, StripRowCount );
    end;
  TIFFClose( OpenTiff );
  FreeMem( StripMemory );
end;

function ReadTiffToBitmap( Filename: {$IF ( CompilerVersion < 22 )}AnsiString{$ELSE}String{$IFEND}; var bmp : TBitmap ): boolean;
  procedure TIFFReadRGBAImageSwapRB( Width, Height: Cardinal; Memory: Pointer );
  {$IFDEF DELPHI_5}
  type
    PCardinal = ^Cardinal;
  {$ENDIF}
  var
    m: PCardinal;
    n: Cardinal;
    o: Cardinal;
  begin
    m := Memory;
    for n := 0 to Width*Height-1 do
      begin
      o := m^;
      m^ := (o and $FF00FF00) or                {G and A}
           ((o and $00FF0000) shr 16) or        {B}
           ((o and $000000FF) shl 16);          {R}
      Inc( m );
      end;
  end;
var
  OpenTiff: PTIFF;
  FirstPageWidth, FirstPageHeight: Cardinal;
begin
  result := false;
  if NOT Assigned( bmp ) or ( FileName = '' ) then
    Exit;

  OpenTiff := TIFFOpen(Filename,'r');
  TIFFGetField( OpenTiff, TIFFTAG_IMAGEWIDTH, @FirstPageWidth );
  TIFFGetField( OpenTiff, TIFFTAG_IMAGELENGTH, @FirstPageHeight );

  if ( bmp.PixelFormat <> pf32bit ) then
    bmp.PixelFormat := pf32bit;
  if ( bmp.Width <> FirstPageWidth ) then
    bmp.Width := FirstPageWidth;
  if ( bmp.Height <> FirstPageHeight ) then
    bmp.Height := FirstPageHeight;

  TIFFReadRGBAImage( OpenTiff, FirstPageWidth, FirstPageHeight, bmp.Scanline[ FirstPageHeight-1 ], 0 );
  TIFFClose( OpenTiff );
  TIFFReadRGBAImageSwapRB( FirstPageWidth, FirstPageheight, bmp.Scanline[ FirstPageHeight-1 ] );

  Result := True;
end;

function BufferToTIFF( Buffer : PByteArray; vWidth, vHeight : Cardinal; vDepth : Byte; FileName : AnsiString; X1 : Extended = 0; Y1 : Extended = 0; X2 : Extended = 0; Y2 : Extended = 0; vFileDepth : Byte = 0; vCompression : Cardinal = COMPRESSION_LZW ): boolean;
var
  x, y         : Integer;
  OpenTiff     : PTIFF;
  ScanLine     : Array of Byte;
  OffsetI,
  OffsetO      : Integer;
  RowsPerStrip : Integer;
begin
  result := false;
  if ( vFileDepth = 0 ) then
    vFileDepth := vDepth;
  if ( buffer = nil ) OR ( FileName = '' ) OR ( vWidth = 0 ) or ( vHeight = 0 ) or NOT ( vDepth in [ 1, 3 ] ) or NOT ( vFileDepth in [ 1, 3 ] ) then
    Exit;

  if {( X1 = 0 ) AND ( Y1 = 0 ) AND }( X2 = 0 ) AND ( Y2 = 0 ) then
    begin
    X2 := vWidth;
    Y2 := vHeight;
    end;
  X2 := Min( X2, vWidth );
  Y2 := Min( Y2, vHeight );

  // TIFF-Lib
  OpenTiff := TIFFOpen( PAnsiChar( Filename ), 'w' );
  if ( OpenTiff = nil ) then
    raise Exception.Create( 'Unable to create file ''' + Filename + '''' );
  TIFFSetField( OpenTiff, TIFFTAG_IMAGEWIDTH, Trunc( X2-X1 ) );
  TIFFSetField( OpenTiff, TIFFTAG_IMAGELENGTH, Trunc( Y2-Y1 ) );
  if ( vFileDepth >= 3 ) then
    TIFFSetField( OpenTiff, TIFFTAG_PHOTOMETRIC, PHOTOMETRIC_RGB )
  else
    TIFFSetField( OpenTiff, TIFFTAG_PHOTOMETRIC, PHOTOMETRIC_MINISBLACK ); // PHOTOMETRIC_MINISWHITE=Inverted Grayscale

  TIFFSetField( OpenTiff, TIFFTAG_SAMPLESPERPIXEL, vFileDepth );
  TIFFSetField( OpenTiff, TIFFTAG_BITSPERSAMPLE, 8 );
  TIFFSetField( OpenTiff, TIFFTAG_PLANARCONFIG, PLANARCONFIG_CONTIG );
  TIFFSetField( OpenTiff, TIFFTAG_COMPRESSION, vCompression );
  TIFFSetField( OpenTiff, TIFFTAG_PREDICTOR, 2 );

  RowsPerStrip := ( ( 256*1024 ) div ( vWidth*vFileDepth ) );
  if ( RowsPerStrip > vHeight ) then
    RowsPerStrip := vHeight
  else if ( RowsPerStrip = 0 ) then
    RowsPerStrip := 1;
  TIFFSetField( OpenTiff, TIFFTAG_ROWSPERSTRIP, RowsPerStrip );

  SetLength( ScanLine, Trunc( X2-X1 )*vFileDepth );
  for y := Trunc( Y1 ) to Trunc( Y2 )-1 do
    begin
    OffsetI := ( y * vWidth * vDepth );
    OffsetO := 0;    
    if ( X1 > 0 ) AND ( vDepth > 1 ) then
      Inc( OffsetI, Trunc( X1*(vDepth-1) ) );

    if ( vDepth = vFileDepth ) then
      Move( buffer^[ OffsetI ], ScanLine[ OffsetO ], Trunc( X2-X1 )*vFileDepth )
    else
      begin
      for x := Trunc( X1 ) to Trunc( X2 )-1 do
        begin
        ScanLine[ OffsetO + X-Trunc( X1 ) ]     := buffer^[ OffsetI+x ]; // R
        if ( vFileDepth >= 3 ) then
          begin
          ScanLine[ OffsetO + X-Trunc( X1 )+1 ] := buffer^[ OffsetI+x+IfThen( vDepth = 3, 1, 0 ) ]; // G
          ScanLine[ OffsetO + X-Trunc( X1 )+2 ] := buffer^[ OffsetI+x+IfThen( vDepth = 3, 2, 0 ) ]; // B
          Inc( OffsetO, 2 );
          end;
        if ( vFileDepth = 4 ) then
          begin
          ScanLine[ OffsetO + X-Trunc( X1 )+4 ] := 0; // Alpha
          Inc( OffsetO, 1 )
          end;
        Inc( OffsetI, vDepth-1 );
        end;
      end;
    if ( TIFFWriteScanline( OpenTiff, @ScanLine[ 0 ], y-Trunc( Y1 ), 0 ) < 1 ) then
      break;
    end;
  TIFFClose( OpenTiff );
  SetLength( ScanLine, 0 );

  result := True;
end;

function TiffToBuffer( Buffer : PByteArray; vDepth : Byte; FileName : string; X1 : Extended = 0; Y1 : Extended = 0 ): boolean;
var
  OpenTiff: PTIFF;
  ScanLine : Array of Byte;
  BitsPerSampleValue : Word;
  vWidth,
  vHeight    : Cardinal;
  x, y,
  offsetI,
  offsetO    : integer;
begin
  result := false;
  if NOT ( vDepth in [ 1, 3 ] ) OR ( NOT FileExists( FileName ) ) then
    Exit;

  try
    OpenTiff := TIFFOpen( Filename, 'r' );
    TIFFGetField( OpenTiff, TIFFTAG_IMAGEWIDTH, @vWidth );
    TIFFGetField( OpenTiff, TIFFTAG_IMAGELENGTH, @vHeight );
    TIFFGetField( OpenTiff, TIFFTAG_BITSPERSAMPLE, @BitsPerSampleValue );
    if ( BitsPerSampleValue <> 8 ) then
      begin
      TIFFClose( OpenTiff );
      Exit;
      end;
    TIFFGetField( OpenTiff, TIFFTAG_SAMPLESPERPIXEL, @BitsPerSampleValue );
  except
  end;
//  if ( BitsPerSampleValue <> 3 ) then
//    begin
//    TIFFClose( OpenTiff );
//    Exit;
//    end;

//  if ( BitsPerSampleValue <> vDepth ) then
//    begin
//    TIFFClose( OpenTiff );
//    Exit;
//    end;

  if ( Buffer = nil ) OR ( Length( Buffer^ ) < vWidth*vHeight*vDepth ) then
    SetLength( Buffer^, vWidth*vHeight*vDepth );

  SetLength( ScanLine, BitsPerSampleValue*vWidth );
  for y := 0 to vHeight-1 do
    begin
    TIFFReadScanline( OpenTiff, @ScanLine[ 0 ], y, 0 );

    offsetO := Trunc( Y1*vWidth*vDepth ) + ( y*vWidth*vDepth );
    if ( X1 > 0 ) AND ( vDepth > 1 ) then
      Inc( offsetO, Trunc( X1*(vDepth-1) ) );

    if ( BitsPerSampleValue = vDepth ) then
      Move( ScanLine[ 0 ], Buffer^[ offsetO ], vWidth*vDepth )
    else
      begin
      offsetI := 0;
      for x := 0 to vWidth-1 do
        begin
        if ( vDepth = 3 ) then
          begin
          Buffer^[ offsetO+x   ] := ScanLine[ offsetI + X ];
          Buffer^[ offsetO+x+1 ] := ScanLine[ offsetI + X+IfThen( BitsPerSampleValue >= 3, 1, 0 ) ];
          Buffer^[ offsetO+x+2 ] := ScanLine[ offsetI + X+IfThen( BitsPerSampleValue >= 3, 2, 0 ) ];
          inc( offsetO, 2 )
          end
        else
          Buffer^[ offsetO+x ] := ScanLine[ offsetI + X ];
        inc( offsetI, BitsPerSampleValue-1 );
        end;
      end;
    end;

  SetLength( ScanLine, 0 );
  TIFFClose( OpenTiff );
  result := True;
end;
  {$ENDIF}
{$IFEND}

function RAWToBuffer( Buffer : PByteArray; vDepth : Byte; FileName : string; X1 : Extended = 0; Y1 : Extended = 0 ): boolean;
var
  f       : File;
  vWidth,
  vHeight : Cardinal;
  y       : Integer;
  offsetO : Integer;
begin
  result := false;
  if NOT ( vDepth in [ 1, 3 ] ) OR ( NOT FileExists( FileName ) ) then
    Exit;

  AssignFile( f, fileName );
  Reset( f, SizeOf( Byte ) );

  BlockRead( f, vWidth, SizeOf( vWidth ) );
  BlockRead( f, vHeight, SizeOf( vWidth ) );

  if ( Buffer = nil ) OR ( Length( Buffer^ ) < vWidth*vHeight*vDepth ) then
    SetLength( Buffer^, vWidth*vHeight*vDepth );

  for y := 0 to vHeight-1 do
    begin
    offsetO := Trunc( Y1*vWidth*vDepth ) + ( y*vWidth*vDepth );
    if ( X1 > 0 ) AND ( vDepth > 1 ) then
      Inc( offsetO, Trunc( X1*(vDepth-1) ) );

    BlockRead( f, Buffer^[ offsetO ], vWidth*vDepth );
    end;
  CloseFile( f );
  result := True;
end;

function BufferToRAW( Buffer : PByteArray; vWidth, vHeight : Cardinal; vDepth : Byte; FileName : AnsiString; X1 : Extended = 0; Y1 : Extended = 0; X2 : Extended = 0; Y2 : Extended = 0 ): boolean; // MS
var
  f        : File;
  OffsetI  : Integer;
  y        : Integer;
  t        : Cardinal;
begin
  result := false;
  if ( buffer = nil ) OR ( FileName = '' ) OR ( vWidth = 0 ) or ( vHeight = 0 ) or NOT ( vDepth in [ 1, 3 ] ) then
    Exit;

  if {( X1 = 0 ) AND ( Y1 = 0 ) AND }( X2 = 0 ) AND ( Y2 = 0 ) then
    begin
    X2 := vWidth;
    Y2 := vHeight;
    end;
  X2 := Min( X2, vWidth );
  Y2 := Min( Y2, vHeight );

  AssignFile( f, fileName );
  if FileExists( fileName ) then
    Reset( F, SizeOf( Byte ) )
  else
    Rewrite( F, SizeOf( Byte ) );

  t := Trunc( X2-X1 );
  BlockWrite( f, t, SizeOf( t ) );
  t := Trunc( Y2-Y1 );
  BlockWrite( f, t, SizeOf( t ) );
  for y := Trunc( Y1 ) to Trunc( Y2 )-1 do
    begin
    OffsetI := ( y * vWidth * vDepth );
    if ( X1 > 0 ) AND ( vDepth > 1 ) then
      Inc( OffsetI, Trunc( X1*(vDepth-1) ) );

    BlockWrite( f, buffer^[ OffsetI ], Trunc( X2-X1 )*vDepth );
    end;
  CloseFile( f );

  result := True;
end;

function BitmapToBuffer( Buffer : PByteArray; vDepth : Byte; FileName : string; X1 : Extended = 0; Y1 : Extended = 0 ): boolean;
var
  bmp : TBitmap;
begin
  result := false;
  if NOT FileExists( FileName ) then
    Exit;
  bmp := TBitmap.Create;
  bmp.LoadFromFile( FileName );
  result := BitmapToBuffer( Buffer, vDepth, bmp, X1, Y1 );
  bmp.free;
end;

function BitmapToBuffer( Buffer : PByteArray; vDepth : Byte; bmp : TBitmap; X1 : Extended = 0; Y1 : Extended = 0 ): boolean;
type
  TRGBTripleArray = Array [WORD] of TRGBTriple; // 24Bit
  pRGBTripleArray = ^TRGBTripleArray;
  TRGBQuadArray = Array [WORD] of TRGBQuad; // 32Bit
  pRGBQuadArray = ^TRGBQuadArray;
var
  scanLine24 : pRGBTripleArray;
  val24      : TRGBTriple;
  scanLine32 : pRGBQuadArray;
  val32      : TRGBQuad;
  R, G, B    : Byte;

  x, y,
  offset     : integer;
begin
  result := false;
  if ( buffer = nil ) OR NOT ( vDepth in [ 1, 3 ] ) OR ( bmp = nil ) then
    Exit;

  R := 0;
  G := 0;
  B := 0;

  scanLine24 := nil;
  scanLine32 := nil;

  if ( Length( Buffer^ ) = 0 ) then
    SetLength( Buffer^, bmp.Width*bmp.Height*vDepth );
  FillChar( Buffer^[ 0 ], Length( Buffer^ ), 0 );
  for y := 0 to bmp.Height-1 do
    begin
    case bmp.PixelFormat of
//      pf15Bit,
//      pf16Bit : scanLine16 := bmp.ScanLine[ Y ];
      pf24Bit : scanLine24 := bmp.ScanLine[ Y ];
      pf32Bit : scanLine32 := bmp.ScanLine[ Y ];
    end;

    offset := Trunc( Y1*bmp.Width*vDepth ) + ( y*bmp.Width*vDepth );
    if ( X1 > 0 ) AND ( vDepth > 1 ) then
      Inc( Offset, Trunc( X1*(vDepth-1) ) );

    if ( vDepth = 3 ) AND ( bmp.PixelFormat = pf24Bit ) then
      Move( scanLine24^[ 0 ], buffer^[ offset ], bmp.Width*vDepth )
    else
      begin
      for x := 0 to bmp.Width-1 do
        begin
        case bmp.PixelFormat of
          pf24Bit : begin
                    val24 := scanLine24^[ X ];
                    R     := val24.rgbtRed;
                    G     := val24.rgbtGreen;
                    B     := val24.rgbtBlue;
                    end;
          pf32Bit : begin
                    val32 := scanLine32^[ X ];
                    R     := val32.rgbRed;
                    G     := val32.rgbGreen;
                    B     := val32.rgbBlue;
                    end;
        end;

        if ( vDepth = 3 ) then
          begin
          Buffer^[ offset+x   ] := R;
          Buffer^[ offset+x+1 ] := G;
          Buffer^[ offset+x+2 ] := B;
  //        val32.rgbReserved := 0;
          inc(offset, 2)
          end
        else
          Buffer^[ offset+x ] := R;
        end;
      end;
    end;
  result := True;
end;

function BufferToBitmap( Buffer : PByteArray; vWidth, vHeight : Cardinal; vDepth : Byte; FileName : string; X1 : Extended = 0; Y1 : Extended = 0; X2 : Extended = 0; Y2 : Extended = 0; Stretch : boolean = false ): boolean;
var
  bmp : TBitmap;
begin
  bmp := TBitmap.Create;
  result := BufferToBitmap( Buffer, vWidth, vHeight, vDepth, bmp, X1, Y1, X2, Y2, Stretch );
  bmp.SaveToFile( FileName );
  bmp.free;
end;

function BufferToBitmap( Buffer : PByteArray; vWidth, vHeight : Cardinal; vDepth : Byte; bmp : TBitmap; X1 : Extended = 0; Y1 : Extended = 0; X2 : Extended = 0; Y2 : Extended = 0; Stretch : boolean = false ): boolean;
const
  Max_15   = 31; // each RGB component has 5 bits
  Max_R_16 = 31; // 5 bits
  Max_G_16 = 63; // 6 bits (eye is most sensitive to green)
  Max_B_16 = 31; // 5 bits
type
  TRGBTripleArray = Array [WORD] of TRGBTriple; // 24Bit
  pRGBTripleArray = ^TRGBTripleArray;
  TRGBQuadArray = Array [WORD] of TRGBQuad; // 32Bit
  pRGBQuadArray = ^TRGBQuadArray;
var
  scanLine16 : pWordArray; // 15/16Bit
  val16      : WORD;
  scanLine24 : pRGBTripleArray;
  val24      : TRGBTriple;
  scanLine32 : pRGBQuadArray;
  val32      : TRGBQuad;
  R, G, B    : Byte;

  x, y,
  offset     : Integer;
  bmpS       : TBitmap;
begin
  result := false;
  if ( buffer = nil ) OR ( bmp = nil ) OR ( vWidth = 0 ) or ( vHeight = 0 ) or NOT ( vDepth in [ 1, 3 ] ) then
    Exit;

  if {( X1 = 0 ) AND ( Y1 = 0 ) AND }( X2 = 0 ) AND ( Y2 = 0 ) then
    begin
    X2 := vWidth;
    Y2 := vHeight;
    end;
  X2 := Min( X2, vWidth );
  Y2 := Min( Y2, vHeight );

  if Stretch then
    begin
    if ( bmp.Width = 0 ) AND ( bmp.Height = 0 ) then
      Exit;
    bmpS := TBitmap.Create;
    bmpS.PixelFormat := bmp.PixelFormat;
    end
  else
    begin
    if ( bmp.Width = 0 ) AND ( bmp.Height = 0 ) then
      begin
      bmp.PixelFormat := pf32bit;
      bmp.Width       := vWidth;
      bmp.Height      := vHeight;
      end;
    bmpS := bmp;
    end;

  bmpS.Width       := Trunc( X2 ) - Trunc( X1 );
  bmpS.Height      := Trunc( Y2 ) - Trunc( Y1 );
  scanLine16       := nil;
  scanLine24       := nil;
  scanLine32       := nil;
  for y := Trunc( Y1 ) to Trunc( Y2 )-1 do
    begin
    case bmp.PixelFormat of
      pf15Bit,
      pf16Bit : scanLine16 := bmpS.ScanLine[ Y-Trunc( Y1 ) ];
      pf24Bit : scanLine24 := bmpS.ScanLine[ Y-Trunc( Y1 ) ];
      pf32Bit : scanLine32 := bmpS.ScanLine[ Y-Trunc( Y1 ) ];
    end;

    offset := 0;
    if ( X1 > 0 ) AND ( vDepth > 1 ) then
      Inc( Offset, Trunc( X1*(vDepth-1) ) );

    if ( vDepth = 3 ) AND ( bmpS.PixelFormat = pf24Bit ) then
      Move( buffer^[ offset + ( y * vWidth * vDepth ) ], scanLine24^[ 0 ], Trunc( X2-X1 )*vDepth )
    else
      begin
      for x := Trunc( X1 ) to Trunc( X2 )-1 do
        begin
        R := buffer^[ offset+x + ( y * vWidth * vDepth ) ];
        G := buffer^[ offset+x+IfThen( vDepth = 3, 1, 0 ) + ( y * vWidth * vDepth ) ];
        B := buffer^[ offset+x+IfThen( vDepth = 3, 2, 0 ) + ( y * vWidth * vDepth ) ];
        inc( offset, vDepth-1 );

        case bmpS.PixelFormat of
          pf15Bit : begin
                    R := Min( R, Max_15 ); // 5 bits
                    G := Min( G, Max_15 );
                    B := Min( B, Max_15 );

                    val16 := ( R SHL 10 ) OR ( G SHL 5 ) OR B;
                    scanLine16^[ X-Trunc( X1 ) ] := val16;
                    end;

          pf16Bit : begin
                    R := Min( R, Max_R_16 ); // 5 bits
                    G := Min( G, Max_G_16 ); // 6 bits (eye is most sensitive to green)
                    B := Min( B, Max_B_16 ); // 5 bits

                    val16 := ( R SHL 11 ) OR ( G SHL 5 ) OR B;
                    scanLine16^[ X-Trunc( X1 ) ] := val16;
                    end;

          pf24Bit : begin
                    val24.rgbtRed       := R;
                    val24.rgbtGreen     := G;
                    val24.rgbtBlue      := B;
                    scanLine24^[ X-Trunc( X1 ) ] := val24;
                    end;

          pf32Bit : begin
                    val32.rgbRed        := R;
                    val32.rgbGreen      := G;
                    val32.rgbBlue       := B;
                    val32.rgbReserved   := 0;
                    scanLine32^[ X-Trunc( X1 ) ] := val32;
                    end;
        end;
        end;
      end;
    end;

  if Stretch then
    begin
    StretchBlt( bmp.Canvas.Handle, 0, 0, bmp.Width, bmp.Height, bmpS.Canvas.Handle, 0, 0, bmpS.Width, bmpS.Height, SRCCOPY );
    bmpS.free;
    end;

  result := True;
end;

{$IF ( CompilerVersion >= 22 ) OR Defined( usePNGLib )}
function PNGToBuffer( Buffer : PByteArray; vDepth : Byte; FileName : string; X1 : Extended = 0; Y1 : Extended = 0 ): boolean;
var
  PNG : {$IF CompilerVersion >= 22}TPNGImage{$ELSE}TPNGObject{$IFEND};
begin
  result := false;
  if ( NOT FileExists( FileName ) ) then
    Exit;
  PNG := {$IF CompilerVersion >= 22}TPNGImage{$ELSE}TPNGObject{$IFEND}.Create;
  PNG.LoadFromFile( FileName );
  result := PNGToBuffer( Buffer, vDepth, PNG, X1, Y1 );
  PNG.free;
end;

function PNGToBuffer( Buffer : PByteArray; vDepth : Byte; PNG : {$IF CompilerVersion >= 22}TPNGImage{$ELSE}TPNGObject{$IFEND}; X1 : Extended = 0; Y1 : Extended = 0 ): boolean;
var
  scanLine24 : pRGBLine;
  val24      : tagRGBTRIPLE;
  x, y,
  offset     : integer;
begin
  result := false;
  if ( buffer = nil ) OR NOT ( vDepth in [ 1, 3 ] ) OR ( PNG = nil ) then
    Exit;

  if ( Length( Buffer^ ) = 0 ) then
    SetLength( Buffer^, PNG.Width*PNG.Height*vDepth );
  FillChar( Buffer^[ 0 ], Length( Buffer^ ), 0 );
  for y := 0 to PNG.Height-1 do
    begin
    scanLine24 := PNG.ScanLine[ Y ];

    offset := Trunc( Y1*PNG.Width*vDepth ) + ( y*PNG.Width*vDepth );
    if ( X1 > 0 ) AND ( vDepth > 1 ) then
      Inc( Offset, Trunc( X1*(vDepth-1) ) );

    if ( vDepth = 3 ) then
      Move( scanLine24^[ 0 ], Buffer^[ offset ], PNG.Width*vDepth )
    else
      begin
      for x := 0 to PNG.Width-1 do
        begin
        val24 := scanLine24^[ X ];
        if ( vDepth = 3 ) then
          begin
          Buffer^[ offset+x   ] := val24.rgbtRed;
          Buffer^[ offset+x+1 ] := val24.rgbtGreen;
          Buffer^[ offset+x+2 ] := val24.rgbtBlue;
          inc(offset, 2)
          end
        else
          Buffer^[ offset+x ] := val24.rgbtRed;
        end;
      end;
    end;
  result := True;
end;

function BufferToPNG( Buffer : PByteArray; vWidth, vHeight : Cardinal; vDepth : Byte; FileName : string; X1 : Extended = 0; Y1 : Extended = 0; X2 : Extended = 0; Y2 : Extended = 0; Stretch : boolean = false ): boolean;
var
  PNG : {$IF CompilerVersion >= 22}TPNGImage{$ELSE}TPNGObject{$IFEND};
begin
  PNG := {$IF CompilerVersion >= 22}TPNGImage{$ELSE}TPNGObject{$IFEND}.Create;
  result := BufferToPNG( Buffer, vWidth, vHeight, vDepth, PNG, X1, Y1, X2, Y2, Stretch );
  PNG.SaveToFile( FileName );
  PNG.free;
end;

function BufferToPNG( Buffer : PByteArray; vWidth, vHeight : Cardinal; vDepth : Byte; PNG : {$IF CompilerVersion >= 22}TPNGImage{$ELSE}TPNGObject{$IFEND}; X1 : Extended = 0; Y1 : Extended = 0; X2 : Extended = 0; Y2 : Extended = 0; Stretch : boolean = false ): boolean;
var
  scanLine24 : pRGBLine;
  val24      : tagRGBTRIPLE;
  x, y,
  offset     : Integer;
  PNGS       : {$IF CompilerVersion >= 22}TPNGImage{$ELSE}TPNGObject{$IFEND};
begin
  result := false;
  if ( buffer = nil ) OR ( PNG = nil ) OR ( vWidth = 0 ) or ( vHeight = 0 ) or NOT ( vDepth in [ 1, 3 ] ) then
    Exit;

  if {( X1 = 0 ) AND ( Y1 = 0 ) AND }( X2 = 0 ) AND ( Y2 = 0 ) then
    begin
    X2 := vWidth;
    Y2 := vHeight;
    end;
  X2 := Min( X2, vWidth );
  Y2 := Min( Y2, vHeight );

  if Stretch then
    begin
    if ( PNG.Width = 0 ) AND ( PNG.Height = 0 ) then
      Exit;
    PNGS := {$IF CompilerVersion >= 22}TPNGImage{$ELSE}TPNGObject{$IFEND}.Create;
    end
  else
    begin
    if ( PNG.Width = 0 ) AND ( PNG.Height = 0 ) then
      PNG.Resize( vWidth, vHeight );
    PNGS := PNG;
    end;

  PNGS.Resize( Trunc( X2 ) - Trunc( X1 ), Trunc( Y2 ) - Trunc( Y1 ) );
  for y := Trunc( Y1 ) to Trunc( Y2 )-1 do
    begin
    scanLine24 := PNGS.ScanLine[ Y-Trunc( Y1 ) ];
    offset := 0;
    if ( X1 > 0 ) AND ( vDepth > 1 ) then
      Inc( Offset, Trunc( X1*(vDepth-1) ) );

    if ( vDepth = 3 ) then
      Move( buffer^[ offset + ( y * vWidth * vDepth ) ], scanLine24^[ 0 ], Trunc( X2-X1 )*vDepth )
    else
      begin
      for x := Trunc( X1 ) to Trunc( X2 )-1 do
        begin
        val24.rgbtRed    := buffer^[ offset+x + ( y * vWidth * vDepth ) ];
        val24.rgbtGreen  := buffer^[ offset+x{+IfThen( vDepth = 3, 1, 0 )} + ( y * vWidth * vDepth ) ];
        val24.rgbtBlue   := buffer^[ offset+x{+IfThen( vDepth = 3, 2, 0 )} + ( y * vWidth * vDepth ) ];
        scanLine24^[ X-Trunc( X1 ) ] := val24;
        inc( offset, vDepth-1 );
        end;
      end;
    end;

  if Stretch then
    begin
    StretchBlt( PNG.Canvas.Handle, 0, 0, PNG.Width, PNG.Height, PNGS.Canvas.Handle, 0, 0, PNGS.Width, PNGS.Height, SRCCOPY );
    PNGS.free;
    end;

  result := True;
end;

procedure BMP2PNG( bmp : TBitmap; var PNG : {$IF CompilerVersion >= 22}TPNGImage{$ELSE}TPNGObject{$IFEND} );
begin
  if (BMP = nil) OR (PNG = nil) then
    Exit;

  PNG.Assign( bmp );
end;

function BMP2PNG( bmp : TBitmap ): {$IF CompilerVersion >= 22}TPNGImage{$ELSE}TPNGObject{$IFEND};
begin
  result := {$IF CompilerVersion >= 22}TPNGImage{$ELSE}TPNGObject{$IFEND}.Create;
  if (BMP = nil) then
    Exit;
  result.Assign( bmp );
end;
{$IFEND}

procedure BMP2JPG( bmp : TBitmap; var JPG : TJPEGImage );
begin
  if (BMP = nil) OR (JPG = nil) then
    Exit;
  JPG.Assign( bmp );
end;

function BMP2JPG( bmp : TBitmap ): TJPEGImage;
begin
  result := TJPEGImage.Create;
  if (BMP = nil) then
    Exit;
  result.Assign( bmp );
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure DrawImage( vCanvas: TCanvas; DestRect: TRect; ABitmap: TBitmap );
var
  Header, Bits: Pointer;
  HeaderSize: Cardinal;
  BitsSize: Cardinal;

  HInfo : HGLOBAL;
  HImage : HGLOBAL;
begin
  if NOT Assigned( vCanvas ) then
    Exit;
  if NOT Assigned( ABitmap ) then
    Exit;

  GetDIBSizes( ABitmap.Handle, HeaderSize, BitsSize );

  // This is the source of the problem. AllocMem allocates a memory block on the
  // heap but windows sometimes (expecially during slow down) needs to move to
  // another area. The pointer is not updated so quick report prints a black box.
  //
  // Header := AllocMem( HeaderSize );
  //
  // The GlobalAlloc function allocates memory on the heap(This Win32 API doesn't make difference between local and global heap)
  // The second line is the most important. We lock the memory allocated so that windows will never move it and our bitmap pointer will always point to the
  // right memory address.

//  Header := AllocMem( HeaderSize ); // Memory Alloc problem
  HInfo := GlobalAlloc( GMEM_MOVEABLE or GMEM_SHARE, HeaderSize );
  Header := GlobalLock( HInfo );

//  Bits := AllocMem( BitsSize );
  HImage := GlobalAlloc( GMEM_MOVEABLE or GMEM_SHARE, BitsSize );
  Bits := GlobalLock( HImage );

  try
    GetDIB( ABitmap.Handle, ABitmap.Palette, Header^, Bits^ );
    StretchDIBits( vCanvas.Handle,
                   DestRect.Left, DestRect.Top, DestRect.Right, DestRect.Bottom,
                   0, 0, ABitmap.Width, ABitmap.Height,
                   Bits, TBitmapInfo( Header^ ), DIB_RGB_COLORS, SRCCOPY );
  finally
//    FreeMem( Header, HeaderSize );
    GlobalUnlock( HImage );
    GlobalFree( HImage );
//    FreeMem( Bits, BitsSize );
    GlobalUnlock( HInfo );
    GlobalFree( HInfo );
  end;
end;

procedure PrintImage( bmp: TBitmap; ZoomPercent: Byte = 100 );
// if ZoomPercent=100, Image will be printed across the whole page
var
  relHeight, relWidth: Word;
begin
  ZoomPercent := Min(100, ZoomPercent);

  Printer.BeginDoc;
  with bmp do
    begin
    if ( ( Width / Height ) > ( Printer.PageWidth / Printer.PageHeight ) ) then
      begin
      // Stretch Bitmap to width of PrinterPage
      relWidth  := Printer.PageWidth;
      relHeight := MulDiv( Height, Printer.PageWidth, Width );
      end
    else
      begin
      // Stretch Bitmap to height of PrinterPage
      relWidth  := MulDiv( Width, Printer.PageHeight, Height );
      relHeight := Printer.PageHeight;
      end;
    relWidth  := Round( relWidth * ZoomPercent / 100 );
    relHeight := Round( relHeight * ZoomPercent / 100 );
    DrawImage( Printer.Canvas, Classes.Rect( 0, 0, relWidth, relHeight ), bmp );
    end;
  Printer.EndDoc;
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure RotateBitmapSWT(Bmp: TBitmap; Rads: Single; AdjustSize: Boolean; BkColor: TColor = clNone);
var
  C: Single;
  S: Single;
  XForm: TXForm;
  Tmp: TBitmap;
begin
  C := Cos(Rads);
  S := Sin(Rads);
  XForm.eM11 := C;
  XForm.eM12 := S;
  XForm.eM21 := -S;
  XForm.eM22 := C;
  Tmp := TBitmap.Create;
  try
    Tmp.TransparentColor := Bmp.TransparentColor;
    Tmp.TransparentMode := Bmp.TransparentMode;
    Tmp.Transparent := Bmp.Transparent;
    Tmp.Canvas.Brush.Color := BkColor;
    if AdjustSize then
    begin
      Tmp.Width := Round(Bmp.Width * Abs(C) + Bmp.Height * Abs(S));
      Tmp.Height := Round(Bmp.Width * Abs(S) + Bmp.Height * Abs(C));
      XForm.eDx := (Tmp.Width - Bmp.Width * C + Bmp.Height * S) / 2;
      XForm.eDy := (Tmp.Height - Bmp.Width * S - Bmp.Height * C) / 2;
    end
    else
    begin
      Tmp.Width := Bmp.Width;
      Tmp.Height := Bmp.Height;
      XForm.eDx := (Bmp.Width - Bmp.Width * C + Bmp.Height * S) / 2;
      XForm.eDy := (Bmp.Height - Bmp.Width * S - Bmp.Height * C) / 2;
    end;
    SetGraphicsMode(Tmp.Canvas.Handle, GM_ADVANCED);
    SetWorldTransform(Tmp.Canvas.Handle, XForm);
    BitBlt(Tmp.Canvas.Handle, 0, 0, Tmp.Width, Tmp.Height, Bmp.Canvas.Handle,
      0, 0, SRCCOPY);
    Bmp.Assign(Tmp);
  finally
    Tmp.Free;
  end;
end;

procedure RotateBitmapPLG(Bmp: TBitmap; Rads: Single; AdjustSize: Boolean; BkColor: TColor = clNone);
var
  C: Single;
  S: Single;
  Tmp: TBitmap;
  OffsetX: Single;
  OffsetY: Single;
  Points: array[0..2] of TPoint;
begin
  C := Cos(Rads);
  S := Sin(Rads);
  Tmp := TBitmap.Create;
  try
    Tmp.TransparentColor := Bmp.TransparentColor;
    Tmp.TransparentMode := Bmp.TransparentMode;
    Tmp.Transparent := Bmp.Transparent;
    Tmp.Canvas.Brush.Color := BkColor;
    if AdjustSize then
    begin
      Tmp.Width := Round(Bmp.Width * Abs(C) + Bmp.Height * Abs(S));
      Tmp.Height := Round(Bmp.Width * Abs(S) + Bmp.Height * Abs(C));
      OffsetX := (Tmp.Width - Bmp.Width * C + Bmp.Height * S) / 2;
      OffsetY := (Tmp.Height - Bmp.Width * S - Bmp.Height * C) / 2;
    end
    else
    begin
      Tmp.Width := Bmp.Width;
      Tmp.Height := Bmp.Height;
      OffsetX := (Bmp.Width - Bmp.Width * C + Bmp.Height * S) / 2;
      OffsetY := (Bmp.Height - Bmp.Width * S - Bmp.Height * C) / 2;
    end;
    Points[0].X := Round(OffsetX);
    Points[0].Y := Round(OffsetY);
    Points[1].X := Round(OffsetX + Bmp.Width * C);
    Points[1].Y := Round(OffsetY + Bmp.Width * S);
    Points[2].X := Round(OffsetX - Bmp.Height * S);
    Points[2].Y := Round(OffsetY + Bmp.Height * C);
    PlgBlt(Tmp.Canvas.Handle, Points, Bmp.Canvas.Handle, 0, 0, Bmp.Width,
      Bmp.Height, 0, 0, 0);
    Bmp.Assign(Tmp);
  finally
    Tmp.Free;
  end;
end;

{$IFDEF GR32}
procedure RotateBitmapGR32(Bmp: TBitmap32; Degs: Integer; AdjustSize: Boolean; BkColor: TColor = clNone; Transparent: Boolean = False); overload;
var
  Tmp: TBitmap32;
  Transformation: TAffineTransformation;
begin
  Tmp := TBitmap32.Create;
  Transformation := TAffineTransformation.Create;
  try
    Transformation.BeginUpdate;
    Transformation.SrcRect := FloatRect(0, 0, Bmp.Width, Bmp.Height);
    Transformation.Translate(-0.5 * Bmp.Width, -0.5 * Bmp.Height);
    Transformation.Rotate(0, 0, -Degs);
    if AdjustSize then
      with Transformation.GetTransformedBounds do
        Tmp.SetSize(Round(Right - Left), Round(Bottom - Top))
    else
      Tmp.SetSize(Bmp.Width, Bmp.Height);
    Transformation.Translate(0.5 * Tmp.Width, 0.5 * Tmp.Height);
    Transformation.EndUpdate;
    Tmp.Clear(Color32(BkColor));
    if not Transparent then
      Bmp.DrawMode := dmTransparent;
    Transform(Tmp, Bmp, Transformation);
    Bmp.Assign(Tmp);
    Bmp.OuterColor := Color32(BkColor);
    if Transparent then
      Bmp.DrawMode := dmTransparent;
  finally
    Transformation.Free;
    Tmp.Free;
  end;
end;

procedure RotateBitmapGR32(Bmp: TBitmap; Degs: Integer; AdjustSize: Boolean; BkColor: TColor = clNone); overload;
var
  Tmp: TBitmap32;
  Transparent: Boolean;
begin
  Tmp := TBitmap32.Create;
  try
    Transparent := Bmp.Transparent;
    Tmp.Assign(Bmp);
    RotateBitmapGR32(Tmp, Degs, AdjustSize, BkColor, Transparent);
    Bmp.Assign(Tmp);
    if Transparent then
      Bmp.Transparent := True;
  finally
    Tmp.Free;
  end;
end;
{$ENDIF}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure DrawArrow( vCanvas : TCanvas; vRect : TRect; Offset : Byte; Orientation : Byte = 0; Color : TColor = clBlack; FillColor : TColor = clBlack );
var
  C1, C2 : TColor;
begin
  if NOT Assigned( vCanvas ) then
    Exit;
  if ( Orientation > 3 ) then
    Exit;

  C1 := vCanvas.Pen.Color;
  C2 := vCanvas.Brush.Color;
  vCanvas.Pen.Color   := clBlack;
  vCanvas.Brush.Color := clBlack;

  case Orientation of
    0 : begin // Up
        vCanvas.Polygon( [
          Point( vRect.Left + ( ( vRect.Right-vRect.Left ) div 2 ), vRect.Top+Offset ),
          Point( vRect.Left+Offset, vRect.Bottom-Offset ),
          Point( vRect.Right-Offset, vRect.Bottom-Offset )
          ] );
        end;
    1 : begin // Down
        vCanvas.Polygon( [
          Point( vRect.Left + ( ( vRect.Right-vRect.Left ) div 2 ), vRect.Bottom-Offset ),
          Point( vRect.Left+Offset, vRect.Top+Offset ),
          Point( vRect.Right-Offset, vRect.Top+Offset )
          ] );
        end;
    2 : begin // Left
        vCanvas.Polygon( [
          Point( vRect.Left+Offset, vRect.Top + ( ( vRect.Bottom-vRect.Top ) div 2 ) ),
          Point( vRect.Right-Offset, vRect.Top+Offset ),
          Point( vRect.Right-Offset, vRect.Bottom-Offset )
          ] );
        end;
    3 : begin // Right
        vCanvas.Polygon( [
          Point( vRect.Right-Offset, vRect.Top + ( ( vRect.Bottom-vRect.Top ) div 2 ) ),
          Point( vRect.Left+Offset, vRect.Top+Offset ),
          Point( vRect.Left+Offset, vRect.Bottom-Offset )
          ] );
        end;
  else
    Exit;
  end;

  vCanvas.Pen.Color   := C1;
  vCanvas.Brush.Color := C2;
end;

procedure DrawPoints( vCanvas : TCanvas; var Points : Array of TPoint );
var
  i : Integer;
begin
  if ( High( Points ) < 1 ) then
    Exit;

  vCanvas.MoveTo( Points[ 0 ].X, Points[ 0 ].Y );
  for i := Low( Points )+1 to High( Points ) do
    vCanvas.LineTo( Points[ i ].X, Points[ i ].Y );
  vCanvas.LineTo( Points[ 0 ].X, Points[ 0 ].Y );
end;

{$IFDEF ETYPES_FOR_GRAPHICS}
procedure DrawPoints( vCanvas : TCanvas; var Points : Array of Typ_EPunkt );
var
  i : Integer;
begin
  if ( High( Points ) < 1 ) then
    Exit;

  vCanvas.MoveTo( Trunc( Points[ 0 ].X ), Trunc( Points[ 0 ].Y ) );
  for i := Low( Points )+1 to High( Points ) do
    vCanvas.LineTo( Trunc( Points[ i ].X ), Trunc( Points[ i ].Y ) );
  vCanvas.LineTo( Trunc( Points[ 0 ].X ), Trunc( Points[ 0 ].Y ) );
end;
{$ENDIF}

procedure DrawRect( vCanvas : TCanvas; TopLeft, TopRight, BottomLeft, BottomRight : TPoint );
begin
  DrawRect( vCanvas, TopLeft.X, TopLeft.Y, TopRight.X, TopRight.Y, BottomLeft.X, BottomLeft.Y, BottomRight.X, BottomRight.Y )
end;

procedure DrawRect( vCanvas : TCanvas; TopLeft, BottomRight : TPoint );
begin
  DrawRect( vCanvas, TopLeft.X, TopLeft.Y, BottomRight.X, BottomRight.Y );
end;

procedure DrawRect( vCanvas : TCanvas; x1, y1, x2, y2 : Extended );
begin
  DrawRect( vCanvas, x1, y1, x2, y1, x1, y2, x2, y2 );
end;

procedure DrawRect( vCanvas : TCanvas; vRect : TRect );
begin
  DrawRect( vCanvas, vRect.TopLeft.X, vRect.TopLeft.Y, vRect.BottomRight.X, vRect.TopLeft.Y, vRect.TopLeft.X, vRect.BottomRight.Y, vRect.BottomRight.X, vRect.BottomRight.Y );
end;

procedure DrawRect( vCanvas : TCanvas; x1, y1, x2, y2, x3, y3, x4, y4 : Extended );
begin
  vCanvas.MoveTo( Trunc( x1 ), Trunc( y1 ) ); // TL
  vCanvas.LineTo( Trunc( x2 ), Trunc( y2 ) ); // TR
  vCanvas.LineTo( Trunc( x4 ), Trunc( y4 ) ); // BR
  vCanvas.LineTo( Trunc( x3 ), Trunc( y3 ) ); // BL
  vCanvas.LineTo( Trunc( x1 ), Trunc( y1 ) ); // TL
end;

{$IFDEF ETYPES_FOR_GRAPHICS}
procedure DrawRect( vCanvas : TCanvas; TopLeft, TopRight, BottomLeft, BottomRight : TYP_ePunkt );
begin
  DrawRect( vCanvas, TopLeft.X, TopLeft.Y, TopRight.X, TopRight.Y, BottomLeft.X, BottomLeft.Y, BottomRight.X, BottomRight.Y );
end;

procedure DrawRect( vCanvas : TCanvas; vRect : tERect );
begin
  DrawRect( vCanvas, vRect.TopLeft, vRect.TopRight, vRect.BottomLeft, vRect.BottomRight );
end;
{$ENDIF}

procedure DrawLine( vCanvas : TCanvas; x1, y1, x2, y2 : Extended );
begin
  vCanvas.MoveTo( Trunc( x1 ), Trunc( y1 ) );
  vCanvas.LineTo( Trunc( x2 ), Trunc( y2 ) );
end;

procedure DrawLine( vCanvas : TCanvas; P1, P2 : TPoint );
begin
  DrawLine( vCanvas, P1.X, P1.Y, P2.X, P2.Y );
end;

{$IFDEF ETYPES_FOR_GRAPHICS}
procedure DrawLine( vCanvas : TCanvas; P1, P2 : Typ_EPunkt );
begin
  DrawLine( vCanvas, P1.X, P1.Y, P2.X, P2.Y );
end;

procedure DrawLine( vCanvas : TCanvas; Line : TELine );
begin
  DrawLine( vCanvas, Line.vStart.X, Line.vStart.Y, Line.vEnd.X, Line.vEnd.Y );
end;
{$ENDIF}

procedure DrawCross( vCanvas : TCanvas; CenterX, CenterY : Extended; Radius : Word = 1 );
begin
  DrawLine( vCanvas, CenterX-Radius, CenterY-Radius, CenterX+Radius, CenterY+Radius );
  DrawLine( vCanvas, CenterX+Radius, CenterY-Radius, CenterX-Radius, CenterY+Radius );
end;

procedure DrawCross( vCanvas : TCanvas; Center : TPoint; Radius : Word = 1 );
begin
  DrawCross( vCanvas, Center.X, Center.Y, Radius );
end;

{$IFDEF ETYPES_FOR_GRAPHICS}
procedure DrawCross( vCanvas : TCanvas; Center : TYP_ePunkt; Radius : Word = 1 );
begin
  DrawCross( vCanvas, Center.X, Center.Y, Radius );
end;
{$ENDIF}

procedure DrawPlus( vCanvas : TCanvas; CenterX, CenterY : Extended; Radius : Word = 1 );
begin
  DrawLine( vCanvas, CenterX-Radius, CenterY, CenterX+Radius, CenterY );
  DrawLine( vCanvas, CenterX, CenterY-Radius, CenterX, CenterY+Radius );
end;

procedure DrawPlus( vCanvas : TCanvas; Center : TPoint; Radius : Word = 1 );
begin
  DrawPlus( vCanvas, Center.X, Center.Y, Radius );
end;

{$IFDEF ETYPES_FOR_GRAPHICS}
procedure DrawPlus( vCanvas : TCanvas; Center : TYP_ePunkt; Radius : Word = 1 );
begin
  DrawPlus( vCanvas, Center.X, Center.Y, Radius );
end;
{$ENDIF}

procedure DrawTriangle( vCanvas : TCanvas; x1, y1, x2, y2, x3, y3 : Extended );
begin
  vCanvas.MoveTo( Trunc( x1 ), Trunc( y1 ) );
  vCanvas.LineTo( Trunc( x2 ), Trunc( y2 ) );
  vCanvas.LineTo( Trunc( x3 ), Trunc( y3 ) );
  vCanvas.LineTo( Trunc( x1 ), Trunc( y1 ) );

//  DrawLine( x1, y1, x2, y2 );
//  DrawLine( x2, y2, x3, y3 );
//  DrawLine( x3, y3, x1, y1 );
end;

procedure DrawTriangle( vCanvas : TCanvas; P1, P2, P3 : TPoint );
begin
  DrawTriangle( vCanvas, P1.X, P1.Y, P2.X, P2.Y, P3.X, P3.Y );
end;

{$IFDEF ETYPES_FOR_GRAPHICS}
procedure DrawTriangle( vCanvas : TCanvas; P1, P2, P3 : TYP_ePunkt );
begin
  DrawTriangle( vCanvas, P1.X, P1.Y, P2.X, P2.Y, P3.X, P3.Y );
end;

procedure DrawTriangle( vCanvas : TCanvas; vTriangle : tETriangle );
begin
  DrawTriangle( vCanvas, vTriangle.A, vTriangle.B, vTriangle.C );
end;
{$ENDIF}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function IconToBmp( FileName : string; var bmp : TBitmap; IconID : Word = 0 ) : Boolean;
var
  LIcon : Array of HIcon;
  SIcon : Array of HIcon;
begin
  result := false;
  if ( bmp = nil ) then
    Exit;
  if ( FileName = '' ) then
    FileName := Application.ExeName;
  if NOT FileExists( FileName ) then
    Exit;
  if ( bmp.Height = 0 ) then
    Bmp.Height := 16;
  if ( bmp.Width = 0 ) then
    Bmp.Width := 16;

  SetLength( LIcon, IconID+1 );
  SetLength( SIcon, IconID+1 );
  if ( ExtractIconEx( PChar( Application.ExeName ), 0, LIcon[ 0 ], SIcon[ 0 ], IconID+1 ) < IconID+1 ) then // ExtractIconEx gets the small (16x16) and Large (32x32) icon handles
    begin
    SetLength( LIcon, 0 );
    SetLength( SIcon, 0 );
    Exit;
    end;

  if ( SIcon[ IconID ] < 1 ) then
    begin
    SetLength( LIcon, 0 );
    SetLength( SIcon, 0 );
    Exit;
    end;

  Bmp.Canvas.Brush.Color := GetSysColor( COLOR_BTNFACE );
  DrawIconEx( Bmp.Canvas.Handle, 0, 0, SIcon[ IconID ], Bmp.Width, Bmp.Height, 0, GetSysColorBrush( COLOR_BTNFACE ), DI_NORMAL ); // Bmp can be any size but the DrawIconEx( ) with the cxWidth := 0 and the cyWidth := 0 will draw the small Icon as a 16x16 with it's transparent area

  SetLength( LIcon, 0 );
  SetLength( SIcon, 0 );
  result := True;
end;

function IconToBmp( Icon : HIcon; var bmp : TBitmap ) : Boolean;
begin
  result := false;
  if ( bmp = nil ) then
    Exit;
  if ( bmp.Height = 0 ) then
    Bmp.Height := 16;
  if ( bmp.Width = 0 ) then
    Bmp.Width := 16;

  Bmp.Canvas.Brush.Color := GetSysColor( COLOR_BTNFACE );
  DrawIconEx( Bmp.Canvas.Handle, 0, 0, Icon, Bmp.Width, Bmp.Height, 0, GetSysColorBrush( COLOR_BTNFACE ), DI_NORMAL ); // Bmp can be any size but the DrawIconEx( ) with the cxWidth := 0 and the cyWidth := 0 will draw the small Icon as a 16x16 with it's transparent area
  result := True;
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure Kyouzou( Folder : string = ''; PicFormat : tKyouzouPictureFormat = {$IF ( CompilerVersion >= 22 ) OR Defined( usePNGLib )}pfPNG{$ELSE}pfJPG{$IFEND}; ShowInvisibleTabs : boolean = false );
var
  i   : integer;

  bmp : TBitmap;
  jpg : TJPEGImage;
  {$IF ( CompilerVersion >= 22 ) OR Defined( usePNGLib )}
  png : {$IF CompilerVersion >= 22}TPNGImage{$ELSE}TPNGObject{$IFEND};
  {$IFEND}

  procedure Recursive( c : TComponent );
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    procedure Save( Hnd : THandle; FileName : string );
    begin
      if Window2BMP( bmp, Hnd ) then
        begin
        case PicFormat of
          pfBMP : bmp.SaveToFile( FileName + '.bmp' );
          pfJPG : begin
                  jpg.Assign( bmp );
                  jpg.SaveToFile( FileName + '.jpg' );
                  end;
          {$IFDEF usePNGLib}
          pfPNG : begin
                  png.Assign( bmp );
                  png.SaveToFile( FileName + '.png' );
                  end;
          {$ENDIF}
          {$IFDEF useTIFLib}
          pfTIF : WriteBitmapToTiff_2432( bmp, FileName + '.tif' );
          {$ENDIF}
        end;
        end;
    end;
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    procedure RecursivePGC( PGC : TPageControl );
      function ControlHasClassOnIt( c : TWinControl; ClassName : string ) : TComponent;
      var
        i : Integer;
      begin
        result := nil;
        if ( c = nil ) OR ( ClassName = '' ) then
          Exit;

        for i := 0 to C.ControlCount-1 do
          begin
          if ( LowerCase( C.Controls[ i ].ClassName ) = LowerCase( ClassName ) ) then
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
    var
      i, tIdx : Integer;
      tVisible: Boolean;
      tC      : TComponent;
    begin
      tIdx := PGC.ActivePageIndex;
      for i := 0 to PGC.PageCount-1 do
        begin
        tVisible := PGC.Pages[ i ].TabVisible;
        if NOT tVisible then
          begin
          if ShowInvisibleTabs then
            PGC.Pages[ i ].TabVisible := True
          else
            Continue;
          end;

        PGC.ActivePageIndex := i;
        if Assigned( PGC.OnChange ) then
          PGC.OnChange( PGC );

        tC := ControlHasClassOnIt( PGC.Pages[ i ], TPageControl.ClassName );
        if ( tC <> nil ) then
          RecursivePGC( TPageControl( tC ) )
        else
          Save( TForm( c ).Handle, Folder + TForm( c ).Name + ' ' + PGC.Pages[ i ].Name );

        if ShowInvisibleTabs AND ( NOT tVisible ) then
          PGC.Pages[ i ].TabVisible := tVisible;
        end;
      PGC.ActivePageIndex := tIdx;
    end;
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
        if ( LowerCase( Result.ClassName ) = LowerCase( ClassName ) ) then
          break;
        end;
    end;
  var
    i       : Integer;
    tVisible: boolean;
    hasPGC  : Boolean;
  begin
    tVisible := false;
    if ( c is TForm ) then
      begin
      tVisible := TForm( c ).Visible;
      if NOT tVisible then
        TForm( c ).Show;
      end
    else if ( c is TFrame ) then
      begin
      tVisible := TFrame( c ).Visible;
      if NOT tVisible then
        TFrame( c ).Show;
      end;

    hasPGC := false;
    for i := 0 to c.ComponentCount-1 do
      begin
      if ( c.Components[ i ] is TPageControl ) then
        begin
        hasPGC := True;
        if ( ComponentIsOnClass( c.Components[ i ], TPageControl.ClassName ) <> nil ) then
          Continue;

        RecursivePGC( TPageControl( c.Components[ i ] ) );
        end;

      if ( c.Components[ i ] is TForm ) then
        Recursive( c.Components[ i ] );
      end;

    if NOT hasPGC then
      begin
      if ( c is TForm ) then
        Save( TForm( c ).Handle, Folder + TForm( c ).Name )
      else if ( c is TFrame ) then
        Save( TFrame( c ).Handle, Folder + TFrame( c ).Name );
      end;

    if NOT tVisible then
      begin
      if ( c is TForm ) then
        TForm( c ).Hide
      else if ( c is TForm ) then
        TFrame( c ).Hide;
      end;
  end;
begin
  if ( Folder = '' ) then
    Folder := ExtractFilePath( ParamStr( 0 ) ) + 'Kyouzou\';

//  DelDir( Folder );
  if NOT DirectoryExists( Folder ) then
    {$IF CompilerVersion >= 22}SysUtils.{$IFEND}ForceDirectories( Folder );

  bmp := TBitmap.Create;
  jpg := TJPEGImage.Create;
  {$IF ( CompilerVersion >= 22 ) OR Defined( usePNGLib )}
  png := {$IF CompilerVersion >= 22}TPNGImage{$ELSE}TPNGObject{$IFEND}.Create;
  {$IFEND}
  for i := 0 to Application.ComponentCount-1 do
    begin
    if ( Application.Components[ i ] is TForm ) OR ( Application.Components[ i ] is TFrame ) then
      Recursive( Application.Components[ i ] );
    end;
  bmp.free;
  jpg.free;
  {$IF ( CompilerVersion >= 22 ) OR Defined( usePNGLib )}
  png.free;
  {$IFEND}
end;

procedure KyouzouMode( PicFormat : tKyouzouPictureFormat = {$IF ( CompilerVersion >= 22 ) OR Defined( usePNGLib )}pfPNG{$ELSE}pfJPG{$IFEND} );
var
  Event: TNotifyEvent;
  i : integer;
begin
  for i := 0 to Application.ComponentCount-1 do
    begin
    if ( Application.Components[i] is TForm ) then
      begin
      with TMethod(Event) do
        begin
        case PicFormat of
          pfBMP : Code := @FormOnDoubleClickBMP;
          pfJPG : Code := @FormOnDoubleClickJPG;
          {$IF ( CompilerVersion >= 22 ) OR Defined( usePNGLib )}
          pfPNG : Code := @FormOnDoubleClickPNG;
          {$IFEND}
          {$IF ( CompilerVersion >= 22 ) OR Defined( useTIFLib )}
          pfTIF : Code := @FormOnDoubleClickTIF;
          {$IFEND}
        end;
        Data := Application.Components[i];
        end;
      (Application.Components[i] as TForm).OnDblClick := Event;
      end;
    end;
end;

procedure FormOnDoubleClickBMP(Self: TForm; Sender: TObject);
var
  bmp : TBitmap;
  Folder : string;
begin
  Folder := ExtractFilePath( ParamStr( 0 ) ) + 'Kyouzou\';

  if NOT (Sender is TForm) then
    Exit;

  if NOT {$IF CompilerVersion >= 22}SysUtils.{$IFEND}DirectoryExists( Folder ) then
    {$IF CompilerVersion >= 22}SysUtils.{$IFEND}ForceDirectories( Folder );

  bmp := TBitmap.Create;
  if Window2BMP( bmp, (Sender as TForm).Handle ) then
    begin
    bmp.SaveToFile( Folder + FormatDateTime( 'yyyy-mm-dd hh-nn-ss', NOW )+  ' ' + (Sender as TForm).Name + '.bmp' );
    ShowMessage( 'OK' );
    end;
  bmp.free;
end;

procedure FormOnDoubleClickJPG(Self: TForm; Sender: TObject);
var
  bmp : TBitmap;
  jpg : TJPEGImage;
  Folder : string;
begin
  Folder := ExtractFilePath( ParamStr( 0 ) ) + 'Kyouzou\';

  if NOT ( Sender is TForm ) then
    Exit;

  if NOT {$IF CompilerVersion >= 22}SysUtils.{$IFEND}DirectoryExists( Folder ) then
    {$IF CompilerVersion >= 22}SysUtils.{$IFEND}ForceDirectories( Folder );

  bmp := TBitmap.Create;
  jpg := TJPEGImage.Create;
  if Window2BMP( bmp, TForm( Sender ).Handle ) then
    begin
    jpg.Assign(bmp);
    jpg.SaveToFile( Folder + FormatDateTime( 'yyyy-mm-dd hh-nn-ss', NOW )+  ' ' + (Sender as TForm).Name + '.jpg' );
    ShowMessage( 'OK' );
    end;
  jpg.Free;
  bmp.free;
end;

{$IFDEF usePNGLib}
procedure FormOnDoubleClickPNG(Self: TForm; Sender: TObject);
var
  bmp : TBitmap;
  png : {$IF CompilerVersion >= 22}TPNGImage{$ELSE}TPNGObject{$IFEND};
  Folder : string;
begin
  Folder := ExtractFileDir( Application.ExeName ) + 'Kyouzou\';

  if NOT ( Sender is TForm ) then
    Exit;

  if NOT DirectoryExists( Folder ) then
    ForceDirectories( Folder );

  bmp := TBitmap.Create;
  png := {$IF CompilerVersion >= 22}TPNGImage{$ELSE}TPNGObject{$IFEND}.Create;
  if Window2BMP( bmp, TForm( Sender ).Handle ) then
    begin
    png.Assign(bmp);
    png.SaveToFile( Folder + FormatDateTime( 'yyyy-mm-dd hh-nn-ss', NOW )+  ' ' + (Sender as TForm).Name + '.png' );
    ShowMessage( 'OK' );
    end;
  png.Free;
  bmp.free;
end;
{$ENDIF}

{$IFDEF useTIFLib}
procedure FormOnDoubleClickTIF( Self: TForm; Sender: TObject );
var
  bmp : TBitmap;
  Folder : string;
begin
  Folder := ExtractFileDir( Application.ExeName ) + 'Kyouzou\';

  if NOT (Sender is TForm) then
    Exit;

  if NOT DirectoryExists( Folder ) then
    ForceDirectories( Folder );

  bmp := TBitmap.Create;
  if Window2BMP( bmp, TForm( Sender ).Handle ) then
    begin
    WriteBitmapToTiff_2432( bmp, Folder + FormatDateTime( 'yyyy-mm-dd hh-nn-ss', NOW )+  ' ' + (Sender as TForm).Name + '.tif' );
    ShowMessage( 'OK' );
    end;
  bmp.free;
end;
{$ENDIF}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function ComplementaryColor( Color : TColor ): TColor;
begin
  result := clWhite{16777215} - Color;
end;

function RGB2TColor( const R, G, B: Byte ): TColor;
begin
  Result := R + G shl 8 + B shl 16;
end;

procedure TColor2RGB( const Color: TColor; var R, G, B: Byte );
begin
{
  R := GetRValue( Color );
  G := GetGValue( Color );
  B := GetBValue( Color );
}
  R := Color and $FF;
  G := ( Color shr 8 ) and $FF;
  B := ( Color shr 16 ) and $FF;
end;

procedure Color2CMY( Color : tColorRec; var C, M, Y : double );
begin
  C := 1 - ( Color.R / 255 );
  M := 1 - ( Color.G / 255 );
  Y := 1 - ( Color.B / 255 );
end;

function CMY2Color( C, M, Y : double; var Color : tColorRec ): boolean;
begin
  result := true;
  if ( ( C < 0 ) OR ( C > 1 ) ) OR ( ( M < 0 ) OR ( M > 1 ) ) OR ( ( Y < 0 ) OR ( Y > 1 ) ) then
    begin
    result := false;
    Exit;
    end;

  Color.R := Round( ( 1 - C ) * 255 );
  Color.G := Round( ( 1 - M ) * 255 );
  Color.B := Round( ( 1 - Y ) * 255 );
  Color.Alpha := 0;
end;

function CMY2CMYK( var C, M, Y, K : double ): boolean;
begin
  result := true;
  if ( ( C < 0 ) OR ( C > 1 ) ) OR ( ( M < 0 ) OR ( M > 1 ) ) OR ( ( Y < 0 ) OR ( Y > 1 ) ) then
    begin
    result := false;
    Exit;
    end;

  K := 1;
  if ( C < K ) then
    K := C;
  if ( M < K ) then
    K := M;
  if ( Y < K ) then
    K := Y;
  if ( K = 1 ) then //Black
     begin
     C := 0;
     M := 0;
     Y := 0;
     end
  else
    begin
    C := ( C - K ) / ( 1 - K );
    M := ( M - K ) / ( 1 - K );
    Y := ( Y - K ) / ( 1 - K );
    end;
end;

function CMYK2CMY( var C, M, Y : double; K : double ): boolean;
begin
  result := true;
  if ( ( C < 0 ) OR ( C > 1 ) ) OR ( ( M < 0 ) OR ( M > 1 ) ) OR ( ( Y < 0 ) OR ( Y > 1 ) ) OR ( ( K < 0 ) OR ( K > 1 ) ) then
    begin
    result := false;
    Exit;
    end;

  C := ( C * ( 1 - K ) + K );
  M := ( M * ( 1 - K ) + K );
  Y := ( Y * ( 1 - K ) + K );
end;

procedure Color2CMYK( Color : tColorRec; var C, M, Y, K : double );
begin
  Color2CMY( Color, C, M, Y );
  CMY2CMYK( C, M, Y, K );
end;

function CMYK2Color( C, M, Y, K : double; var Color : tColorRec ): boolean;
begin
  result := CMYK2CMY( C, M, Y, K );
  Result := result AND CMY2Color( C, M, Y, Color );
end;

procedure Color2HSV( Color : tColorRec; var H, S, V : double );
var
  vR, vG, vB,
  vdR, vdG, vdB : double;
  vMax, vDMax : double;
begin
  vR := Color.R / 255;
  vG := Color.G / 255;
  vB := Color.B / 255;

  vMax := MaxValue( [vR, vG, vB] );
  vDMax := vMax - MinValue( [vR, vG, vB] );
  V := vMax;

  if ( vDmax = 0 ) then // This is a gray, no chroma...
    begin
    H := 0;
    S := 0;
    end
  else //Chromatic data...
    begin
    S := vDmax / vMax;

    vdR := ( ( ( vMax - vR ) / 6 ) + ( vDmax / 2 ) ) / vDmax;
    vdG := ( ( ( vMax - vG ) / 6 ) + ( vDmax / 2 ) ) / vDmax;
    vdB := ( ( ( vMax - vB ) / 6 ) + ( vDmax / 2 ) ) / vDmax;

    if ( vR = vMax ) then
      H := vdB - vdG
    else if ( vG = vMax ) then
      H := ( 1 / 3 ) + vdR - vdB
    else if ( vB = vMax ) then
      H := ( 2 / 3 ) + vdG - vdR;

     if ( H < 0 ) then
      H := H+1;
    if ( H > 1 ) then
      H := H-1;
    end;
end;

function HSV2Color( H, S, V : double; var Color : tColorRec ): boolean;
var
  i : integer;
  vR, vG, vB, vH,
  v1, v2, v3 : double;
begin
  result := false;
  if ( ( H < 0 ) OR ( H > 1 ) ) OR ( ( S < 0 ) OR ( S > 1 ) ) OR ( ( V < 0 ) OR ( V > 1 ) ) then
    Exit;

  if ( S = 0 ) then //HSV from 0 to 1
    begin
    Color.R := Round( V * 255 );
    Color.G := Round( V * 255 );
    Color.B := Round( V * 255 );
    Color.Alpha := 0;
    end
  else
    begin
    vh := H * 6;
    if ( vh = 6 ) then
      vh := 0;      //H must be < 1
    i := floor( vh );
    v1 := V * ( 1 - S );
    v2 := V * ( 1 - S * ( vh - i ) );
    v3 := V * ( 1 - S * ( 1 - ( vh - i ) ) );

    if ( i = 0 ) then
      begin
      vR := V;
      vG := v3;
      vb := v1;
      end
    else if ( i = 1 ) then
      begin
      vR := v2;
      vG := V;
      vb := v1;
      end
    else if ( i = 2 ) then
      begin
      vR := v1;
      vG := V;
      vb := v3;
      end
    else if ( i = 3 ) then
      begin
      vR := v1;
      vG := v2;
      vb := V;
      end
    else if ( i = 4 ) then
      begin
      vR := v3;
      vG := v1;
      vb := V;
      end
    else
      begin
      vR := V;
      vG := v1;
      vb := v2;
      end;

    Color.R := Round( vR * 255 );
    Color.G := Round( vG * 255 );
    Color.B := Round( vB * 255 );
    Color.Alpha := 0;    
    end;
  result := true;
end;

procedure Color2HSL( Color : tColorRec; var H, S, L : double );
var
  vR, vG, vB,
  vdR, vdG, vdB,
  vMin, vMax, vDMax : double;
begin
  vR := ( Color.R / 255 );
  vG := ( Color.G / 255 );
  vB := ( Color.B / 255 );

  vMin := MinValue( [vR, vG, vB] );
  vMax := MaxValue( [vR, vG, vB] );
  vdMax := vMax - vMin; //Delta RGB value

  L := ( vMax + vMin ) / 2;

  if ( vdMax = 0 ) then // This is a gray, no chroma...
    begin
    H := 0;
    S := 0;
    end
  else  //Chromatic data...
    begin
    if ( L < 0.5 ) then
      S := vdMax / ( vMax + vMin )
    else
      S := vdMax / ( 2 - vMax - vMin );

    vdR := ( ( ( vMax - vR ) / 6 ) + ( vdMax / 2 ) ) / vdMax;
    vdG := ( ( ( vMax - vG ) / 6 ) + ( vdMax / 2 ) ) / vdMax;
    vdB := ( ( ( vMax - vB ) / 6 ) + ( vdMax / 2 ) ) / vdMax;

    if ( vR = vMax ) then
      H := vdB - vdG
    else if ( vG = vMax ) then
      H := ( 1 / 3 ) + vdR - vdB
    else if ( vB = vMax ) then
      H := ( 2 / 3 ) + vdG - vdR;

    if ( H < 0 ) then
      H := H+1;
    if ( H > 1 ) then
      H := H-1;
    end;
end;

function HSL2Color( H, S, L : double; var Color : tColorRec ): boolean;
  function Hue2RGB( v1, v2, vH : double ): double;
  begin
    if ( vH < 0 ) then
      vH := VH+1;
    if ( vH > 1 ) then
      vH := vH-1;
    if ( ( 6 * vH ) < 1 ) then
      begin
      result := v1 + ( v2 - v1 ) * 6 * vH;
      Exit;
      end;
    if ( ( 2 * vH ) < 1 ) then
      begin
      result := v2;
      Exit;
      end;
    if ( ( 3 * vH ) < 2 ) then
      begin
      result := v1 + ( v2 - v1 ) * ( ( 2 / 3 ) - vH ) * 6;
      Exit;
      end;
    result := v1;
  end;
var
  v : double;
begin
  result := true;
  if ( ( H < 0 ) OR ( H > 1 ) ) OR ( ( S < 0 ) OR ( S > 1 ) ) OR ( ( L < 0 ) OR ( L > 1 ) ) then
    begin
    result := false;
    Exit;
    end;

  if ( S = 0 ) then
    begin
    Color.R := Round( L * 255 );
    Color.G := Round( L * 255 );
    Color.B := Round( L * 255 );
    Color.Alpha := 0;    
    end
  else
    begin
    if ( L < 0.5 ) then
      v := L * ( 1 + S )
    else
      v := ( L + S ) - ( S * L );

    Color.R := Round( 255 * Hue2RGB( 2*L-v, v, H + ( 1 / 3 ) ) );
    Color.G := Round( 255 * Hue2RGB( 2*L-v, v, H ) );
    Color.B := Round( 255 * Hue2RGB( 2*L-v, v, H - ( 1 / 3 ) ) );
    Color.Alpha := 0;    
    end;
end;

procedure RGB2CMY( R, G, B : byte; var C, M, Y : double );
begin
  C := 1 - ( R / 255 );
  M := 1 - ( G / 255 );
  Y := 1 - ( B / 255 );
end;

function CMY2RGB( C, M, Y : double; var R, G, B : byte ): boolean;
begin
  result := true;
  if ( ( C < 0 ) OR ( C > 1 ) ) OR ( ( M < 0 ) OR ( M > 1 ) ) OR ( ( Y < 0 ) OR ( Y > 1 ) ) then
    begin
    result := false;
    Exit;
    end;

  R := Round( ( 1 - C ) * 255 );
  G := Round( ( 1 - M ) * 255 );
  B := Round( ( 1 - Y ) * 255 );
end;

procedure RGB2CMYK( R, G, B : byte; var C, M, Y, K : double );
begin
  RGB2CMY( R, G, B, C, M, Y );
  CMY2CMYK( C, M, Y, K );
end;

function CMYK2RGB( C, M, Y, K : double; var R, G, B : byte ): boolean;
begin
  result := CMYK2CMY( C, M, Y, K );
  Result := result AND CMY2RGB( C, M, Y, R, G, B );
end;

procedure RGB2HSV( R, G, B : byte; var H, S, V : double );
var
  vColor : TColorRec;
begin
  vColor.Color := RGB( R, G, B );
  Color2HSV( vColor, H, S, V );
end;

function HSV2RGB( H, S, V : double; var R, G, B : byte ): boolean;
var
  vColor : TColorRec;
begin
  result := HSV2Color( H, S, V, vColor );
  R := vColor.R;
  G := vColor.G;
  B := vColor.B;
end;

procedure RGB2HSL( R, G, B : byte; var H, S, L : double );
var
  vColor : TColorRec;
begin
  vColor.Color := RGB( R, G, B ); 
  Color2HSL( vColor, H, S, L );
end;

function HSL2RGB( H, S, L : double; var R, G, B : byte ): boolean;
var
  vColor : TColorRec;
begin
  result := HSL2Color( H, S, L, vColor );
  R := vColor.R;
  G := vColor.G;
  B := vColor.B;
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
const
  LUT_2BIT_TO_8BIT : array[ 0..3 ] of byte = ( 0, $55, $AA, $FF );
  LUT_3BIT_TO_8BIT : array[ 0..7 ] of byte = ( 0, $24, $49, $6D, $92, $B6, $DB, $FF );

//find nearest color from a palette
function nearestLutColor( const Color : TColorRec; pLut : pColorRec; uMax : word ) : word;
begin
  result := nearestLutColor( Color.R, Color.G, Color.B, pLut, uMax );
end;

function nearestLutColor( const R, G, B : Byte; pLut : pColorRec; uMax : word ) : word;
var
  i, c, v : longword;
  tLut    : pColorRec;
begin
  result := 0;
  if ( uMax = 0 ) then
    exit;

  tLut := pLut;
  v := $1000000;
  for i := 0 to uMax do
    begin
    c := sqr( tLut^.b-b )+sqr( tLut^.g-g )+sqr( tLut^.r-r );
    if ( c < v ) then
      begin
      v := c;
      result := i;
      end;
    inc( tLut );
    end;
end;

// Monochrone 1-Bit
// Each bit defines the color for a pixel ( 8 pixels per byte ).
// Total 2 different colors possible, in this case black and white.
function RGB_to_monochrome( const Color : TColorRec ) : byte;
begin
  result := RGB_to_monochrome( Color.R, Color.G, Color.B );
end;

function RGB_to_monochrome( const R, G, B : Byte ) : byte;
begin
  result := Byte( r+g+b > 382 ); // Method 2 :  Sum R+G+B value, then check if value is greater than 382 ( $FF*3 div 2 ).
end;

function monochrome_to_rgb( mono : byte ) : TColorRec;
const //Monochrome 1-Bit lookup table ( LUT )
  LUT_MONOCHROME_1BIT : array[ boolean ] of TColorRec = ( //[ 0..1 ] -> [ 0..255 ]
    ( r : $00; g : $00; b : $00; Alpha : $00 ),   //00. #000000    MONO_BLACK
    ( r : $FF; g : $FF; b : $FF; Alpha : $00 )    //01. #FFFFFF    MONO_WHITE
  );
begin
  if ( mono > 1 ) then
    mono := 1;
  result := LUT_MONOCHROME_1BIT[ mono <> 0 ]; //a value of [ 0..1 ]
end;

// Grayscale 2-Bit
// Total 4 shades of gray possible ( 4 pixels per byte ).
function RGB_to_gray2( const Color : TColorRec ) : byte;
begin
  result := RGB_to_gray2( Color.R, Color.G, Color.B );
end;

function RGB_to_gray2( const R, G, B : Byte ) : byte;
var
  gray8 : byte;
begin
  gray8 := ( r+g+b ) div 3; //first convert to gray8
  result := gray8 shr 6; //shr 6 :  get rid of 6 bits
end;

function gray2_to_RGB( gray2 : byte ) : TColorRec;
const //Grayscale 2-Bit lookup table ( LUT )
  LUT_GRAY_2BIT : array[ 0..3 ] of TColorRec = ( //Grayscale 2-Bit, 4 colors
    ( r : $00; g : $00; b : $00; Alpha : $00 ), //00. #000000   GRAY2_BLACK
    ( r : $55; g : $55; b : $55; Alpha : $00 ), //01. #555555   GRAY2_DARK
    ( r : $AA; g : $AA; b : $AA; Alpha : $00 ), //02. #AAAAAA   GRAY2_LIGHT
    ( r : $FF; g : $FF; b : $FF; Alpha : $00 )  //03. #FFFFFF   GRAY2_WHITE
  );
begin
  if gray2 > 3 then
    gray2 := 0;
  result := LUT_GRAY_2BIT[ gray2 ]; //a value of [ 0..3 ]
end;

// Grayscale 3-Bit
// Total 8 shades of gray possible ( ~2.67 pixels per byte ).
function RGB_to_gray3( const Color : TColorRec ) : byte;
begin
  result := RGB_to_gray3( Color.R, Color.G, Color.B );
end;

function RGB_to_gray3( const R, G, B : Byte ) : byte;
var gray8 : byte;
begin
  gray8 := ( r+g+b ) div 3; //first convert to gray8
  result := gray8 shr 5; //shr 5 :  get rid of 5 bits
end;

function gray3_to_RGB( gray3 : byte ) : TColorRec;
const //Grayscale 3-Bit lookup table ( LUT )
  LUT_GRAY_3BIT : array[ 0..7 ] of TColorRec = (
    ( r : $00; g : $00; b : $00; Alpha : $00 ), //00. #000000   GRAY3_BLACK
    ( r : $24; g : $24; b : $24; Alpha : $00 ), //01. #242424   GRAY3_DARKEST
    ( r : $49; g : $49; b : $49; Alpha : $00 ), //02. #494949   GRAY3_DARKER
    ( r : $6D; g : $6D; b : $6D; Alpha : $00 ), //03. #6D6D6D   GRAY3_DARK
    ( r : $92; g : $92; b : $92; Alpha : $00 ), //04. #929292   GRAY3_LIGHT
    ( r : $B6; g : $B6; b : $B6; Alpha : $00 ), //05. #B6B6B6   GRAY3_LIGHTER
    ( r : $DB; g : $DB; b : $DB; Alpha : $00 ), //06. #DBDBDB   GRAY3_LIGHTEST
    ( r : $FF; g : $FF; b : $FF; Alpha : $00 )  //07. #FFFFFF   GRAY3_WHITE
  );
begin
  if ( gray3 > 7 ) then
    gray3 := 0;
  result := LUT_GRAY_3BIT[ gray3 ]; //a value of [ 0..7 ]
end;

// Grayscale 4-Bit
// Total 16 shades of gray possible ( 2 pixels per byte ).
function RGB_to_gray4( const Color : TColorRec ) : byte;
begin
  result := RGB_to_gray4( Color.R, Color.G, Color.B );
end;

function RGB_to_gray4( const R, G, B : Byte ) : byte;
var
  gray8 : byte;
begin
  gray8 := ( r+g+b ) div 3; //first convert to gray8
  result := gray8 shr 4; //shr 4 :  get rid of 4 bits
end;

function gray4_to_RGB( gray4 : byte ) : TColorRec;
const //Grayscale 4-Bit lookup table ( LUT )
  LUT_GRAY_4BIT : array[ 0..$F ] of TColorRec = ( //Grayscale 4-Bit, 16 colors
    ( r : $00; g : $00; b : $00; Alpha : $00 ), //00. #000000   GRAY4_BLACK
    ( r : $11; g : $11; b : $11; Alpha : $00 ), //01. #111111   GRAY4_DARKER_4
    ( r : $22; g : $22; b : $22; Alpha : $00 ), //02. #222222   GRAY4_DARKER_3
    ( r : $33; g : $33; b : $33; Alpha : $00 ), //03. #333333   GRAY4_DARKER_2
    ( r : $44; g : $44; b : $44; Alpha : $00 ), //04. #444444   GRAY4_DARKER_1
    ( r : $55; g : $55; b : $55; Alpha : $00 ), //05. #555555   GRAY4_DARK
    ( r : $66; g : $66; b : $66; Alpha : $00 ), //06. #666666   GRAY4_MEDIUM_LOW_2
    ( r : $77; g : $77; b : $77; Alpha : $00 ), //07. #777777   GRAY4_MEDIUM_LOW_1
    ( r : $88; g : $88; b : $88; Alpha : $00 ), //08. #888888   GRAY4_MEDIUM_HIGH_1
    ( r : $99; g : $99; b : $99; Alpha : $00 ), //09. #999999   GRAY4_MEDIUM_HIGH_2
    ( r : $AA; g : $AA; b : $AA; Alpha : $00 ), //10. #AAAAAA   GRAY4_LIGHT
    ( r : $BB; g : $BB; b : $BB; Alpha : $00 ), //11. #BBBBBB   GRAY4_LIGHTER_1
    ( r : $CC; g : $CC; b : $CC; Alpha : $00 ), //12. #CCCCCC   GRAY4_LIGHTER_2
    ( r : $DD; g : $DD; b : $DD; Alpha : $00 ), //13. #DDDDDD   GRAY4_LIGHTER_3
    ( r : $EE; g : $EE; b : $EE; Alpha : $00 ), //14. #EEEEEE   GRAY4_LIGHTER_4
    ( r : $FF; g : $FF; b : $FF; Alpha : $00 )  //15. #FFFFFF   GRAY4_WHITE
  );
begin
  if ( gray4 > 15 ) then
    gray4 := 0;
  result := LUT_GRAY_4BIT[ gray4 ]; //a value of [ 0..15 ]
end;

// Grayscale 8-Bit
// Total 256 shades of gray possible ( 1 pixel per byte ).
function RGB_to_gray8_Red( const Color : TColorRec ) : byte;
begin
  result := RGB_to_gray8_Red( Color.R, Color.G, Color.B );
end;

function RGB_to_gray8_Red( const R, G, B : Byte ) : byte;
begin
  result := R;
end;

function RGB_to_gray8_Green( const Color : TColorRec ) : byte;
begin
  result := RGB_to_gray8_Green( Color.R, Color.G, Color.B );
end;

function RGB_to_gray8_Green( const R, G, B : Byte ) : byte;
begin
  result := G;
end;

function RGB_to_gray8_Blue( const Color : TColorRec ) : byte;
begin
  result := RGB_to_gray8_Blue( Color.R, Color.G, Color.B );
end;

function RGB_to_gray8_Blue( const R, G, B : Byte ) : byte;
begin
  result := B;
end;

function RGB_to_gray8_Lightness( const Color : TColorRec ) : byte;
begin
  result := RGB_to_gray8_Average( Color.R, Color.G, Color.B );
end;

function RGB_to_gray8_Lightness( const R, G, B : Byte ) : byte;
var
  vMin,
  vMax : Byte;
begin
  vMin := R;
  vMin := Min( vMin, G );
  vMin := Min( vMin, B );

  vMax := R;
  vMax := Max( vMax, G );
  vMax := Max( vMax, B );

  result := ( vMax + vMin ) div 2;
end;

function RGB_to_gray8_Average( const Color : TColorRec ) : byte;
begin
  result := RGB_to_gray8_Average( Color.R, Color.G, Color.B );
end;

function RGB_to_gray8_Average( const R, G, B : Byte ) : byte;
begin
  result := ( r+g+b ) div 3;
end;

function RGB_to_gray8_Luminosity( const Color : TColorRec ) : byte;
begin
  result := RGB_to_gray8_Luminosity( Color.R, Color.G, Color.B );
end;

function RGB_to_gray8_Luminosity( const R, G, B : Byte ) : byte;
begin
  result := Min( 255, Trunc( 0.2126*R + 0.7152*G + 0.0722*B ) );
end;

function gray8_to_RGB( gray8 : byte ) : TColorRec;
begin
  result.r := gray8;
  result.g := gray8;
  result.b := gray8;
  result.Alpha := 0;  
end;

// RGB 3-Bit
// Total 8 different colors possible ( ~2.67 pixels per byte ).
// A single bit for each R, G, B values ( 3 bits ).
function RGB_to_rgb3( const Color : TColorRec ) : byte;
begin
  result := RGB_to_rgb3( Color.R, Color.G, Color.B );
end;

function RGB_to_rgb3( const R, G, B : Byte ) : byte;
begin
  result := ( r shr 7 ) shl 2 //shl 2 :  put at 3rd bit.
         or ( g shr 7 ) shl 1 //shl 1 :  put at 2nd bit.
         or ( b shr 7 );      //shr 7 :  get rid of 7 bits
end;

function rgb3_to_RGB( rgb3 : byte ) : TColorRec;
const //RGB 3-Bit lookup table ( LUT )
  LUT_RGB_3BIT : array[ 0..7 ] of TColorRec = ( //RGB 3-Bit, 8 colors.
    ( r : $00; g : $00; b : $00; Alpha : $00 ), //00. #000000   RGB3_BLACK
    ( r : $00; g : $00; b : $FF; Alpha : $00 ), //01. #0000FF   RGB3_BLUE
    ( r : $00; g : $FF; b : $00; Alpha : $00 ), //02. #00FF00   RGB3_GREEN
    ( r : $00; g : $FF; b : $FF; Alpha : $00 ), //03. #00FFFF   RGB3_CYAN
    ( r : $FF; g : $00; b : $00; Alpha : $00 ), //04. #FF0000   RGB3_RED
    ( r : $FF; g : $00; b : $FF; Alpha : $00 ), //05. #FF00FF   RGB3_MAGENTA
    ( r : $FF; g : $FF; b : $00; Alpha : $00 ), //06. #FFFF00   RGB3_YELLOW
    ( r : $FF; g : $FF; b : $FF; Alpha : $00 )  //07. #FFFFFF   RGB3_WHITE
  );
begin
  if ( rgb3 > 7 ) then
    rgb3 := 0;
  result := LUT_RGB_3BIT[ rgb3 ]; //a value of [ 0..7 ]
end;

// RGBi 4-Bit
// Total 16 different colors possible ( 2 pixels per byte ).
// A single bit for each R, G, B values + I intensity ( 4 bits ).
function RGB_to_rgbi( const Color : TColorRec; scale : word = 300 ) : byte; //[ 0..15 ]
begin
  result := RGB_to_rgbi( Color.R, Color.G, Color.B, Scale );
end;

function RGB_to_rgbi( const R, G, B : Byte; scale : word = 300 ) : byte; //[ 0..15 ]
begin
  result := byte( r+g+b>scale ) shl 3 //shl 3 :  put at 4th bit.
             or ( r shr 7 ) shl 2     //shl 2 :  put at 3rd bit.
             or ( g shr 7 ) shl 1     //shl 1 :  put at 2nd bit.
             or ( b shr 7 );          //shr 7 :  get rid of 7 bits
end;

function rgbi_to_RGB( rgbi : byte ) : TColorRec;
const //RGBi 4-Bit lookup table ( LUT )
  LUT_RGBI_4BIT : array[ 0..$F ] of TColorRec = ( //RGBI 4-Bit, 16 colors.
    ( r : $00; g : $00; b : $00; Alpha : $00 ), //00. #000000   RGBI_BLACK
    ( r : $00; g : $00; b : $91; Alpha : $00 ), //01. #000091   RGBI_BLUE_DARK
    ( r : $00; g : $91; b : $00; Alpha : $00 ), //02. #009100   RGBI_GREEN_DARK
    ( r : $00; g : $91; b : $91; Alpha : $00 ), //03. #009191   RGBI_CYAN_DARK
    ( r : $91; g : $00; b : $00; Alpha : $00 ), //04. #910000   RGBI_RED_DARK
    ( r : $91; g : $00; b : $91; Alpha : $00 ), //05. #910091   RGBI_MAGENTA_DARK
    ( r : $91; g : $91; b : $00; Alpha : $00 ), //06. #919100   RGBI_YELLOW_DARK
    ( r : $B7; g : $B7; b : $B7; Alpha : $00 ), //07. #B7B7B7   RGBI_GRAY_LIGHT
    ( r : $68; g : $68; b : $68; Alpha : $00 ), //08. #686868   RGBI_GRAY_DARK
    ( r : $00; g : $00; b : $FF; Alpha : $00 ), //09. #0000FF   RGBI_BLUE
    ( r : $00; g : $FF; b : $00; Alpha : $00 ), //10. #00FF00   RGBI_GREEN
    ( r : $00; g : $FF; b : $FF; Alpha : $00 ), //11. #00FFFF   RGBI_CYAN
    ( r : $FF; g : $00; b : $00; Alpha : $00 ), //12. #FF0000   RGBI_RED
    ( r : $FF; g : $00; b : $FF; Alpha : $00 ), //13. #FF00FF   RGBI_MAGENTA
    ( r : $FF; g : $FF; b : $00; Alpha : $00 ), //14. #FFFF00   RGBI_YELLOW
    ( r : $FF; g : $FF; b : $FF; Alpha : $00 )  //15. #FFFFFF   RGBI_WHITE
  );
begin
  if ( rgbi > $F ) then
    rgbi := 0;
  result := LUT_RGBI_4BIT[ rgbi ]; //a value of [ 0..15 ]
end;

// RGB 6-Bit
// Total 64 different colors possible ( ~1.34 pixels per byte ).
// Two bits for each R, G, B values ( 6 bits ).
function RGB_to_rgb6( const Color : TColorRec ) : byte;
begin
  result := RGB_to_rgb6( Color.R, Color.G, Color.B );
end;

function RGB_to_rgb6( const R, G, B : Byte ) : byte;
begin
  result := ( r shr 6 ) shl 4  //shl 4 :  put at 5th bit.
         or ( g shr 6 ) shl 2  //shl 2 :  put at 3rd bit.
         or ( b shr 6 );  //shr 6 :  get rid of 6 bits
end;

function rgb6_to_RGB( rgb6 : byte ) : TColorRec;
{
const //RGB 6-Bit lookup table ( LUT )
  LUT_RGB_6BIT : array[ 0..63 ] of TColorRec = ( //RGB 6-Bit, 64 colors.
    ( Alpha : $00; b : $00; g : $00; r : $00 ), ( Alpha : $00; b : $55; g : $00; r : $00 ), ( Alpha : $00; b : $AA; g : $00; r : $00 ),
    ( Alpha : $00; b : $FF; g : $00; r : $00 ), ( Alpha : $00; b : $00; g : $55; r : $00 ), ( Alpha : $00; b : $55; g : $55; r : $00 ), 
    ( Alpha : $00; b : $AA; g : $55; r : $00 ), ( Alpha : $00; b : $FF; g : $55; r : $00 ), ( Alpha : $00; b : $00; g : $AA; r : $00 ), 
    ( Alpha : $00; b : $55; g : $AA; r : $00 ), ( Alpha : $00; b : $AA; g : $AA; r : $00 ), ( Alpha : $00; b : $FF; g : $AA; r : $00 ), 
    ( Alpha : $00; b : $00; g : $FF; r : $00 ), ( Alpha : $00; b : $55; g : $FF; r : $00 ), ( Alpha : $00; b : $AA; g : $FF; r : $00 ), 
    ( Alpha : $00; b : $FF; g : $FF; r : $00 ), ( Alpha : $00; b : $00; g : $00; r : $55 ), ( Alpha : $00; b : $55; g : $00; r : $55 ), 
    ( Alpha : $00; b : $AA; g : $00; r : $55 ), ( Alpha : $00; b : $FF; g : $00; r : $55 ), ( Alpha : $00; b : $00; g : $55; r : $55 ), 
    ( Alpha : $00; b : $55; g : $55; r : $55 ), ( Alpha : $00; b : $AA; g : $55; r : $55 ), ( Alpha : $00; b : $FF; g : $55; r : $55 ), 
    ( Alpha : $00; b : $00; g : $AA; r : $55 ), ( Alpha : $00; b : $55; g : $AA; r : $55 ), ( Alpha : $00; b : $AA; g : $AA; r : $55 ), 
    ( Alpha : $00; b : $FF; g : $AA; r : $55 ), ( Alpha : $00; b : $00; g : $FF; r : $55 ), ( Alpha : $00; b : $55; g : $FF; r : $55 ), 
    ( Alpha : $00; b : $AA; g : $FF; r : $55 ), ( Alpha : $00; b : $FF; g : $FF; r : $55 ), ( Alpha : $00; b : $00; g : $00; r : $AA ), 
    ( Alpha : $00; b : $55; g : $00; r : $AA ), ( Alpha : $00; b : $AA; g : $00; r : $AA ), ( Alpha : $00; b : $FF; g : $00; r : $AA ), 
    ( Alpha : $00; b : $00; g : $55; r : $AA ), ( Alpha : $00; b : $55; g : $55; r : $AA ), ( Alpha : $00; b : $AA; g : $55; r : $AA ), 
    ( Alpha : $00; b : $FF; g : $55; r : $AA ), ( Alpha : $00; b : $00; g : $AA; r : $AA ), ( Alpha : $00; b : $55; g : $AA; r : $AA ), 
    ( Alpha : $00; b : $AA; g : $AA; r : $AA ), ( Alpha : $00; b : $FF; g : $AA; r : $AA ), ( Alpha : $00; b : $00; g : $FF; r : $AA ), 
    ( Alpha : $00; b : $55; g : $FF; r : $AA ), ( Alpha : $00; b : $AA; g : $FF; r : $AA ), ( Alpha : $00; b : $FF; g : $FF; r : $AA ), 
    ( Alpha : $00; b : $00; g : $00; r : $FF ), ( Alpha : $00; b : $55; g : $00; r : $FF ), ( Alpha : $00; b : $AA; g : $00; r : $FF ), 
    ( Alpha : $00; b : $FF; g : $00; r : $FF ), ( Alpha : $00; b : $00; g : $55; r : $FF ), ( Alpha : $00; b : $55; g : $55; r : $FF ), 
    ( Alpha : $00; b : $AA; g : $55; r : $FF ), ( Alpha : $00; b : $FF; g : $55; r : $FF ), ( Alpha : $00; b : $00; g : $AA; r : $FF ), 
    ( Alpha : $00; b : $55; g : $AA; r : $FF ), ( Alpha : $00; b : $AA; g : $AA; r : $FF ), ( Alpha : $00; b : $FF; g : $AA; r : $FF ), 
    ( Alpha : $00; b : $00; g : $FF; r : $FF ), ( Alpha : $00; b : $55; g : $FF; r : $FF ), ( Alpha : $00; b : $AA; g : $FF; r : $FF ),
    ( Alpha : $00; b : $FF; g : $FF; r : $FF )
  );
}
begin
//  if ( rgb6 > 63 ) then
//    rgb6 := 0;
//  result := LUT_RGB_6BIT[ rgb6 ]; //a value of [ 0..63 ]

  //conversion of each RGB value from 2-Bit to 8-Bit
  result.r := LUT_2BIT_TO_8BIT[ rgb6 shr 4 and 3 ]; //shr 4 :  get rid of 5 bits
  result.g := LUT_2BIT_TO_8BIT[ rgb6 shr 2 and 3 ]; //and 3 :  keep only 2 bits
  result.b := LUT_2BIT_TO_8BIT[ rgb6 and 3 ]; //and 3 :  keep only 2 bits
  result.Alpha := 0;
end;

// RGB 8-Bit ( True color )
// Total 256 different colors possible ( 1 pixel per byte ).
// 3 bits of red, 3 bits of green, 2 bits of blue. ( RRRGGGBB )
function RGB_to_rgb8( const Color : TColorRec ) : byte;
begin
  result := RGB_to_rgb8( Color.R, Color.G, Color.B );
end;

function RGB_to_rgb8( const R, G, B : Byte ) : byte;
begin
  result := ( r shr 5 ) shl 5 //shl 5 :  put at 6th bit.
         or ( g shr 5 ) shl 2 //shl 2 :  put at 3th bit.
         or ( b shr 6 );      //shr 6 :  get rid of 6 bits
end;

function rgb8_to_RGB( rgb8 : byte ) : TColorRec;
begin
  result.r := LUT_3BIT_TO_8BIT[ rgb8 shr 5 ];       //Red :    3 bits
  result.g := LUT_3BIT_TO_8BIT[ rgb8 shr 2 and 7 ]; //Green :  3 bits
  result.b := LUT_2BIT_TO_8BIT[ rgb8 and 3 ];       //Blue :   2 bits
  result.Alpha := 0;  
end;

// RGB 9-Bit
// Total 512 different colors possible.
// Three bits for each R, G, B values ( 9 bits ).
function RGB_to_rgb9( const Color : TColorRec ) : word; //8*8*8 = 512
begin
  result := RGB_to_rgb9( Color.R, Color.G, Color.B );
end;

function RGB_to_rgb9( const R, G, B : Byte ) : word; //8*8*8 = 512
begin
  result := ( r shr 5 ) shl 6 //shl 6 :  put at 7th bit.
         or ( g shr 5 ) shl 3 //shl 3 :  put at 4th bit.
         or ( b shr 5 );      //shr 5 :  get rid of 5 bits
end;

function rgb9_to_RGB( rgb9 : word ) : TColorRec;
begin
  result.r := LUT_3BIT_TO_8BIT[ rgb9 shr 6 and 7 ]; //shr 6 :  get rid of 6 bits
  result.g := LUT_3BIT_TO_8BIT[ rgb9 shr 3 and 7 ]; //and 7 :  keep only 3 bits
  result.b := LUT_3BIT_TO_8BIT[ rgb9 and 7 ]; //and 7 :  keep only 3 bits
  result.Alpha := 0;  
end;

// RGB 12-Bit
// Total 4096 different colors possible.
// Four bits for each R, G, B values ( 12 bits ).
function RGB_to_rgb12( const Color : TColorRec ) : word;
begin
  result := RGB_to_rgb12( Color.R, Color.G, Color.B );
end;

function RGB_to_rgb12( const R, G, B : Byte ) : word;
begin
  result := ( r shr 4 ) shl 8 //shl 8 :  put at 9th bit.
         or ( g shr 4 ) shl 4 //shl 4 :  put at 5th bit.
         or ( b shr 4 );      //shr 4 :  get rid of 4 bits
end;

function rgb12_to_RGB( n : word ) : TColorRec;
const
  LUT_4BIT_TO_8BIT : array[ 0..$F ] of byte = ( 0, $11, $22, $33, $44, $55, $66, $77, $88, $99, $AA, $BB, $CC, $DD, $EE, $FF );
begin
  result.r := LUT_4BIT_TO_8BIT[ n shr 8 and $F ]; //shr 8 :  get rid of 8 bits
  result.g := LUT_4BIT_TO_8BIT[ n shr 4 and $F ]; //and $F :  keep only 4 bits
  result.b := LUT_4BIT_TO_8BIT[ n and $F ]; //and $F :  keep only 4 bits
  result.Alpha := 0;  
end;

// RGB 15-Bit
// Total 32768 different colors possible.
// Five bits for each R, G, B values ( 15 bits ).
function RGB_to_rgb15( const Color : TColorRec ) : word;
begin
  result := RGB_to_rgb15( Color.R, Color.G, Color.B );
end;

function RGB_to_rgb15( const R, G, B : Byte ) : word;
begin
  result := ( r shr 3 ) shl 10  //shl 10 :  put at 11th bit.
         or ( g shr 3 ) shl 5   //shl 5 :  put at 6th bit.
         or ( b shr 3 );        //shr 3 :  get rid of 3 bits
end;

function rgb15_to_RGB( rgb15 : word ) : TColorRec;
begin
  result.b := ( rgb15 and $1F ) shl 3;
  result.g := ( ( rgb15 shr 5 ) and $1F ) shl 3;
  result.r := ( ( rgb15 shr 10 ) and $1F ) shl 3;
  result.Alpha := 0;  
end;

// RGB 16-Bit ( High Color )
// Total 65536 different colors possible.
// 5 bits of red, 6 bits of green, 5 bits of blue.
function RGB_to_rgb16( const Color : TColorRec ) : word;
begin
  result := RGB_to_rgb16( Color.R, Color.G, Color.B );
end;

function RGB_to_rgb16( const R, G, B : Byte ) : word;
begin
  result := ( r shr 3 ) shl 11  //shl 11 :  put at 12th bit.
         or ( g shr 2 ) shl 5   //shl 5 :  put at 6th bit.
         or ( b shr 3 );        //shr 3 :  get rid of 3 bits
end;

function rgb16_to_RGB( rgb16 : word ) : TColorRec;
begin
  result.r := ( ( rgb16 and $F800 ) shr 11 ) shl 3;
  result.g := ( ( rgb16 and $07E0 ) shr 5 ) shl 2;
  result.b := ( rgb16 and $1F ) shl 3;
  result.Alpha := 0;  
end;

// Web-safe 216, 8-Bit
// Web-safe colors of 6 steps for each R, G, B value.
// Total 216 colors possible.
function RGB_to_web216( const Color : TColorRec ) : byte;
begin
  result := RGB_to_web216( Color.R, Color.G, Color.B );
end;

function RGB_to_web216( const R, G, B : Byte ) : byte;
begin
  result := b div $33*$24 +( g div $33*6 ) +( r div $33 );
end;

function web216_to_RGB( n : byte ) : TColorRec;
begin
  if ( n > $D7 ) then
    n := $D7;
  result.b := n div $24*$33;
  n := n mod $24;
  result.g := n div 6*$33;
  n := n mod 6;
  result.r := n*$33;
  result.Alpha := 0;  
end;

// EGA 4-Bit
// Total 16 colors possible ( 2 pixels per byte ).
const //EGA 4-Bit lookup table ( LUT )
  LUT_EGA_4BIT : array[ 0..$F ] of TColorRec = ( //EGA 4-Bit, 16 colors
    ( r : $00; g : $00; b : $00; Alpha : $00 ), //00. #000000   EGA4_BLACK
    ( r : $68; g : $00; b : $00; Alpha : $00 ), //01. #680000   EGA4_RED_DARKER
    ( r : $00; g : $68; b : $00; Alpha : $00 ), //02. #006800   EGA4_GREEN_DARK
    ( r : $B7; g : $00; b : $00; Alpha : $00 ), //03. #B70000   EGA4_RED_DARK
    ( r : $68; g : $68; b : $00; Alpha : $00 ), //04. #686800   EGA4_YELLOW_DARK
    ( r : $FF; g : $00; b : $00; Alpha : $00 ), //05. #FF0000   EGA4_RED
    ( r : $68; g : $68; b : $68; Alpha : $00 ), //06. #686868   EGA4_GRAY_DARK
    ( r : $68; g : $68; b : $B7; Alpha : $00 ), //07. #6868B7   EGA4_BLUE
    ( r : $B7; g : $68; b : $00; Alpha : $00 ), //08. #B76800   EGA4_BROWN
    ( r : $B7; g : $68; b : $68; Alpha : $00 ), //09. #B76868   EGA4_RED_LIGHT
    ( r : $B7; g : $68; b : $B7; Alpha : $00 ), //10. #B768B7   EGA4_PURPLE
    ( r : $68; g : $B7; b : $00; Alpha : $00 ), //11. #68B700   EGA4_GREEN_LIGHT
    ( r : $FF; g : $68; b : $00; Alpha : $00 ), //12. #FF6800   EGA4_ORANGE
    ( r : $B7; g : $B7; b : $B7; Alpha : $00 ), //13. #B7B7B7   EGA4_GRAY_LIGHT
    ( r : $FF; g : $B7; b : $68; Alpha : $00 ), //14. #FFB768   EGA4_YELLOW
    ( r : $FF; g : $FF; b : $FF; Alpha : $00 )  //15. #FFFFFF   EGA4_WHITE
  );

function RGB_to_ega4( const Color : TColorRec ) : byte;
begin
  result := RGB_to_ega4( Color.R, Color.G, Color.B );
end;

function RGB_to_ega4( const R, G, B : Byte ) : byte;
begin
  result := nearestLutColor( R, G, B, @LUT_EGA_4BIT[ 0 ], High( LUT_EGA_4BIT ) ); 
end;

function ega4_to_RGB( ega4 : byte ) : TColorRec;
begin
  if ( ega4 > $F ) then
    ega4 := 0;
  result := LUT_EGA_4BIT[ ega4 ]; //a value of [ 0..15 ]
end;

// CGA 4-Bit ( RGBi )
// Total 16 colors possible ( 2 pixels per byte ).
// Based on RGBi as described above.
function RGB_to_cga4( const Color : TColorRec ) : byte;
begin
  result := RGB_to_cga4( Color.R, Color.G, Color.B );
end;

function RGB_to_cga4( const R, G, B : Byte ) : byte;
begin
  result := RGB_to_rgbi( R, G, B ); //RGBi variation...
end;

function cga4_to_RGB( cga4 : byte ) : TColorRec;
const //CGA 4-Bit ( RGBi ) lookup table ( LUT )
  LUT_CGA_RGBI_4BIT : array[ 0..$F ] of TColorRec = ( //CGA RGBI 4-Bit, 16 colors
    ( r : $00; g : $00; b : $00; Alpha : $00 ), //00. #000000   CGA4_BLACK
    ( r : $00; g : $00; b : $AA; Alpha : $00 ), //01. #0000AA   CGA4_BLUE_LOW
    ( r : $00; g : $AA; b : $00; Alpha : $00 ), //02. #00AA00   CGA4_GREEN_LOW
    ( r : $00; g : $AA; b : $AA; Alpha : $00 ), //03. #00AAAA   CGA4_CYAN_LOW
    ( r : $AA; g : $00; b : $00; Alpha : $00 ), //04. #AA0000   CGA4_RED_LOW
    ( r : $AA; g : $00; b : $AA; Alpha : $00 ), //05. #AA00AA   CGA4_MAGENTA_LOW
    ( r : $AA; g : $55; b : $00; Alpha : $00 ), //06. #AA5500   CGA4_BROWN
    ( r : $AA; g : $AA; b : $AA; Alpha : $00 ), //07. #AAAAAA   CGA4_GRAY_LIGHT
    ( r : $55; g : $55; b : $55; Alpha : $00 ), //08. #555555   CGA4_GRAY_DARK
    ( r : $55; g : $55; b : $FF; Alpha : $00 ), //09. #5555FF   CGA4_BLUE_HIGH
    ( r : $55; g : $FF; b : $55; Alpha : $00 ), //10. #55FF55   CGA4_GREEN_HIGH
    ( r : $55; g : $FF; b : $FF; Alpha : $00 ), //11. #55FFFF   CGA4_CYAN_HIGH
    ( r : $FF; g : $55; b : $55; Alpha : $00 ), //12. #FF5555   CGA4_RED_HIGH
    ( r : $FF; g : $55; b : $FF; Alpha : $00 ), //13. #FF55FF   CGA4_MAGENTA_HIGH
    ( r : $FF; g : $FF; b : $55; Alpha : $00 ), //14. #FFFF55   CGA4_YELLOW
    ( r : $FF; g : $FF; b : $FF; Alpha : $00 )  //15. #FFFFFF   CGA4_WHITE
  );
begin
  if ( cga4 > $F ) then
    cga4 := 0;
  result := LUT_CGA_RGBI_4BIT[ cga4 ]; //a value of [ 0..15 ]
end;

// CGA 2-Bit ( Mode 5 )
// Total 4 colors possible ( 4 pixels per byte ).
function RGB_to_cga2( const Color : TColorRec ) : byte;
begin
  result := RGB_to_cga2( Color.R, Color.G, Color.B );
end;

function RGB_to_cga2( const R, G, B : Byte ) : byte;
const
  CGA4_TO_CGA2 : array[ 0..$F ] of byte = ( 0, 0, 1, 1, 2, 2, 0, 0, 0, 1, 1, 1, 2, 2, 3, 3 );
var
  cga4 : byte;
begin
  cga4   := RGB_to_cga4( R, G, B ); //first convert to cga 4-Bit
  result := CGA4_TO_CGA2[ cga4 ]; //then pick related color from array
end;

function cga2_to_RGB( cga2 : byte ) : TColorRec;
const //CGA 2-Bit Mode 5 lookup table ( LUT )
  LUT_CGA_2BIT_MODE5 : array[ 0..3 ] of TColorRec = ( //CGA 2-Bit A, 4 colors.
    ( r : $00; g : $00; b : $00; Alpha : $00 ), //00. #000000   CGA2A_BLACK
    ( r : $55; g : $FF; b : $55; Alpha : $00 ), //01. #55FF55   CGA2A_GREEN_BRIGHT
    ( r : $FF; g : $55; b : $55; Alpha : $00 ), //02. #FF5555   CGA2A_RED_BRIGHT
    ( r : $FF; g : $FF; b : $55; Alpha : $00 )  //03. #FFFF55   CGA2A_YELLOW
  );
begin
  if ( cga2 > 3 ) then
    cga2 := 0;
  result := LUT_CGA_2BIT_MODE5[ cga2 ]; //a value of [ 0..3 ]
end;

// Windows 4-Bit
// Total 16 colors possible ( 2 pixels per byte ).
// The 16 default color palette from Microsoft Windows.
// RGBi variation, colors in different order.
function RGB_to_mswin4( const Color : TColorRec ) : byte;
begin
  result := RGB_to_mswin4( Color.R, Color.G, Color.B );
end;

function RGB_to_mswin4( const R, G, B : Byte ) : byte;
const
  RGBI_TO_MSWIN4 : array[ 0..$F ] of byte = ( 0, 4, 2, 6, 1, 5, 3, 7, 8, 12, 10, 14, 9, 13, 11, 15 );
var
  rgbi : byte;
begin
  rgbi   := RGB_to_rgbi( R, G, B ); //first convert to RGBi ( 4-Bit )
  result := RGBI_TO_MSWIN4[ rgbi ]; //then pick related color from array
end;

// Windows 4-Bit to RGB 24-Bit
function mswin4_to_RGB( win4 : byte ) : TColorRec;
const //MSWIN 4-Bit lookup table ( LUT )
  LUT_MSWIN_4BIT : array[ 0..$F ] of TColorRec = ( //16 default color palette ( 4-Bit )
    ( r : $00; g : $00; b : $00; Alpha : $00 ), //00. #000000   WIN_BLACK
    ( r : $80; g : $00; b : $00; Alpha : $00 ), //01. #800000   WIN_MAROON
    ( r : $00; g : $80; b : $00; Alpha : $00 ), //02. #008000   WIN_GREEN
    ( r : $80; g : $80; b : $00; Alpha : $00 ), //03. #808000   WIN_OLIVE
    ( r : $00; g : $00; b : $80; Alpha : $00 ), //04. #000080   WIN_NAVY
    ( r : $80; g : $00; b : $80; Alpha : $00 ), //05. #800080   WIN_PURPLE
    ( r : $00; g : $80; b : $80; Alpha : $00 ), //06. #008080   WIN_TEAL
    ( r : $C0; g : $C0; b : $C0; Alpha : $00 ), //07. #C0C0C0   WIN_SILVER
    ( r : $80; g : $80; b : $80; Alpha : $00 ), //08. #808080   WIN_GRAY
    ( r : $FF; g : $00; b : $00; Alpha : $00 ), //09. #FF0000   WIN_RED
    ( r : $00; g : $FF; b : $00; Alpha : $00 ), //10. #00FF00   WIN_LIME
    ( r : $FF; g : $FF; b : $00; Alpha : $00 ), //11. #FFFF00   WIN_YELLOW
    ( r : $00; g : $00; b : $FF; Alpha : $00 ), //12. #0000FF   WIN_BLUE
    ( r : $FF; g : $00; b : $FF; Alpha : $00 ), //13. #FF00FF   WIN_FUCHSIA
    ( r : $00; g : $FF; b : $FF; Alpha : $00 ), //14. #00FFFF   WIN_AQUA
    ( r : $FF; g : $FF; b : $FF; Alpha : $00 )  //15. #FFFFFF   WIN_WHITE
  );
begin
  if ( win4 > $F ) then
    win4 := 0;
  result := LUT_MSWIN_4BIT[ win4 ]; //a value of [ 0..15 ]
end;

// Apple II 4-Bit
// Total 16 colors possible ( 2 pixels per byte ).
// A duplicate gray results in 15 colors instead of 16...
const //Apple II 4-Bit lookup table ( LUT )
  LUT_APPLEII_4BIT : array[ 0..$F ] of TColorRec = ( //Apple II, 4-Bit
    ( r : $00; g : $00; b : $00; Alpha : $00 ), //00. #000000   APPLE_II_BLACK
    ( r : $72; g : $26; b : $40; Alpha : $00 ), //01. #722640   APPLE_II_MAGENTA
    ( r : $40; g : $33; b : $7F; Alpha : $00 ), //02. #40337F   APPLE_II_BLUE_DARK
    ( r : $E4; g : $34; b : $FE; Alpha : $00 ), //03. #E434FE   APPLE_II_PURPLE
    ( r : $0E; g : $59; b : $40; Alpha : $00 ), //04. #0E5940   APPLE_II_GREEN_DARK
    ( r : $80; g : $80; b : $80; Alpha : $00 ), //05. #808080   APPLE_II_GRAY
    ( r : $1B; g : $9A; b : $FE; Alpha : $00 ), //06. #1B9AFE   APPLE_II_BLUE_MEDIUM
    ( r : $BF; g : $B3; b : $FF; Alpha : $00 ), //07. #BFB3FF   APPLE_II_BLUE_LIGHT
    ( r : $40; g : $4C; b : $00; Alpha : $00 ), //08. #404C00   APPLE_II_BROWN
    ( r : $E4; g : $65; b : $01; Alpha : $00 ), //09. #E46501   APPLE_II_ORANGE
    ( r : $80; g : $80; b : $80; Alpha : $00 ), //10. #808080   APPLE_II_GRAY_DUPL
    ( r : $F1; g : $A6; b : $BF; Alpha : $00 ), //11. #F1A6BF   APPLE_II_PINK
    ( r : $1B; g : $CB; b : $01; Alpha : $00 ), //12. #1BCB01   APPLE_II_GREEN
    ( r : $BF; g : $CC; b : $80; Alpha : $00 ), //13. #BFCC80   APPLE_II_YELLOW
    ( r : $8D; g : $D9; b : $BF; Alpha : $00 ), //14. #8DD9BF   APPLE_II_AQUA
    ( r : $FF; g : $FF; b : $FF; Alpha : $00 )  //15. #FFFFFF   APPLE_II_WHITE
  );

function RGB_to_appleii( const Color : TColorRec ) : byte;
begin
  result := RGB_to_appleii( Color.R, Color.G, Color.B );
end;

function RGB_to_appleii( const R, G, B : Byte ) : byte;
begin
  result := nearestLutColor( R, G, B, @LUT_APPLEII_4BIT[ 0 ], High( LUT_APPLEII_4BIT ) ); 
end;

function appleii4_to_RGB( n : byte ) : TColorRec;
begin
  if ( n > $F ) then
    n := 0;
  result := LUT_APPLEII_4BIT[ n ]; //a value of [ 0..15 ]
end;

// Commodore VIC-20 palette, 4-Bit.
// Total 16 colors possible ( 2 pixels per byte ).
const //Commodore VIC-20 4-Bit lookup table ( LUT )
  LUT_VIC20_4BIT : array[ 0..$F ] of TColorRec = ( //VIC20 4-Bit, 16 colors
    ( r : $00; g : $00; b : $00; Alpha : $00 ), //00. #000000   VIC20_BLACK
    ( r : $FF; g : $FF; b : $FF; Alpha : $00 ), //01. #FFFFFF   VIC20_WHITE
    ( r : $8D; g : $3E; b : $37; Alpha : $00 ), //02. #8D3E37   VIC20_RED
    ( r : $72; g : $C1; b : $C8; Alpha : $00 ), //03. #72C1C8   VIC20_CYAN
    ( r : $80; g : $34; b : $8B; Alpha : $00 ), //04. #80348B   VIC20_PURPLE
    ( r : $55; g : $A0; b : $49; Alpha : $00 ), //05. #55A049   VIC20_GREEN
    ( r : $40; g : $31; b : $8D; Alpha : $00 ), //06. #40318D   VIC20_BLUE
    ( r : $AA; g : $B9; b : $5D; Alpha : $00 ), //07. #AAB95D   VIC20_YELLOW
    ( r : $8B; g : $54; b : $29; Alpha : $00 ), //08. #8B5429   VIC20_ORANGE
    ( r : $D5; g : $9F; b : $74; Alpha : $00 ), //09. #D59F74   VIC20_ORANGE_LIGHT
    ( r : $B8; g : $69; b : $62; Alpha : $00 ), //10. #B86962   VIC20_RED_LIGHT
    ( r : $87; g : $D6; b : $DD; Alpha : $00 ), //11. #87D6DD   VIC20_CYAN_LIGHT
    ( r : $AA; g : $5F; b : $B6; Alpha : $00 ), //12. #AA5FB6   VIC20_PURPLE_LIGHT
    ( r : $94; g : $E0; b : $89; Alpha : $00 ), //13. #94E089   VIC20_GREEN_LIGHT
    ( r : $80; g : $71; b : $CC; Alpha : $00 ), //14. #8071CC   VIC20_BLUE_LIGHT
    ( r : $BF; g : $CE; b : $72; Alpha : $00 )  //15. #BFCE72   VIC20_YELLOW_LIGHT
  );

function RGB_to_vic20( const Color : TColorRec ) : byte;
begin
  result := RGB_to_vic20( Color.R, Color.G, Color.B );
end;

function RGB_to_vic20( const R, G, B : Byte ) : byte;
begin
  result := nearestLutColor( R, G, B, @LUT_VIC20_4BIT[ 0 ], High( LUT_VIC20_4BIT ) ); 
end;

function vic20_to_RGB( vic20 : byte ) : TColorRec;
begin
  if ( vic20 > $F ) then
    vic20 := 0;
  result := LUT_VIC20_4BIT[ vic20 ]; //a value of [ 0..15 ]
end;

// Commodore 64 palette, 4-Bit.
// Total 16 colors possible ( 2 pixels per byte ).
const //Commodore 64 4-Bit lookup table ( LUT )
  LUT_C64_4BIT : array[ 0..$F ] of TColorRec = ( //C64 4-Bit, 16 colors.
    ( r : $00; g : $00; b : $00; Alpha : $00 ), //00. #000000   C64_BLACK
    ( r : $FF; g : $FF; b : $FF; Alpha : $00 ), //01. #FFFFFF   C64_WHITE
    ( r : $88; g : $39; b : $32; Alpha : $00 ), //02. #883932   C64_RED
    ( r : $67; g : $B6; b : $BD; Alpha : $00 ), //03. #67B6BD   C64_CYAN
    ( r : $8B; g : $3F; b : $96; Alpha : $00 ), //04. #8B3F96   C64_PURPLE
    ( r : $55; g : $A0; b : $49; Alpha : $00 ), //05. #55A049   C64_GREEN
    ( r : $40; g : $31; b : $8D; Alpha : $00 ), //06. #40318D   C64_BLUE
    ( r : $BF; g : $CE; b : $72; Alpha : $00 ), //07. #BFCE72   C64_YELLOW
    ( r : $8B; g : $54; b : $29; Alpha : $00 ), //08. #8B5429   C64_ORANGE
    ( r : $57; g : $42; b : $00; Alpha : $00 ), //09. #574200   C64_BROWN
    ( r : $B8; g : $69; b : $62; Alpha : $00 ), //10. #B86962   C64_RED_LIGHT
    ( r : $50; g : $50; b : $50; Alpha : $00 ), //11. #505050   C64_GRAY_DARK
    ( r : $78; g : $78; b : $78; Alpha : $00 ), //12. #787878   C64_GRAY
    ( r : $94; g : $E0; b : $89; Alpha : $00 ), //13. #94E089   C64_GREEN_LIGHT
    ( r : $78; g : $69; b : $C4; Alpha : $00 ), //14. #7869C4   C64_BLUE_LIGHT
    ( r : $9F; g : $9F; b : $9F; Alpha : $00 )  //15. #9F9F9F   C64_GRAY_LIGHT
  );

function RGB_to_c64( const Color : TColorRec ) : byte;
begin
  result := RGB_to_c64( Color.R, Color.G, Color.B );
end;

function RGB_to_c64( const R, G, B : Byte ) : byte;
begin
  result := nearestLutColor( R, G, B, @LUT_C64_4BIT[ 0 ], High( LUT_C64_4BIT ) ); 
end;

function c64_to_RGB( c64 : byte ) : TColorRec;
begin
  if ( c64 > $F ) then
    c64 := 0;
  result := LUT_C64_4BIT[ c64 ]; //a value of [ 0..15 ]
end;


// Commodore Amiga 2-Bit palette.
// Total 4 different colors possible ( 4 pixels per byte ).
const //Commodore Amiga 2-Bit lookup table ( LUT )
  LUT_AMIGA_2BIT : array[ 0..3 ] of TColorRec = ( //Amiga 2-Bit, 4 colors
    ( r : $00; g : $00; b : $00; Alpha : $00 ), //00. #000000   AMIGA_2BIT_BLACK
    ( r : $EE; g : $33; b : $22; Alpha : $00 ), //01. #EE3322   AMIGA_2BIT_RED
    ( r : $66; g : $66; b : $55; Alpha : $00 ), //02. #666655   AMIGA_2BIT_GRAY
    ( r : $EE; g : $CC; b : $99; Alpha : $00 )  //03. #EECC99   AMIGA_2BIT_YELLOW
  );

function RGB_to_amiga2( const Color : TColorRec ) : byte;
begin
  result := RGB_to_amiga2( Color.R, Color.G, Color.B );
end;

function RGB_to_amiga2( const R, G, B : Byte ) : byte;
begin
  result := nearestLutColor( R, G, B, @LUT_AMIGA_2BIT[ 0 ], High( LUT_AMIGA_2BIT ) ); 
end;

function amiga2_to_RGB( amiga2 : byte ) : TColorRec;
begin
  if amiga2>3 then
    amiga2 := 0;
  result := LUT_AMIGA_2BIT[ amiga2 ]; //a value of [ 0..3 ]
end;

// Commodore Amiga 3-Bit palette.
// Total 8 different colors possible ( ~2.67 pixels per byte ).
const //Commodore Amiga 3-Bit lookup table ( LUT )
  LUT_AMIGA_3BIT : array[ 0..7 ] of TColorRec = ( //Amiga 3-Bit, 8 colors
    ( r : $00; g : $00; b : $00; Alpha : $00 ), //00. #000000   AMIGA_3BIT_BLACK
    ( r : $A8; g : $00; b : $00; Alpha : $00 ), //01. #A80000   AMIGA_3BIT_RED_DARK
    ( r : $44; g : $78; b : $00; Alpha : $00 ), //02. #447800   AMIGA_3BIT_GREEN
    ( r : $FF; g : $56; b : $31; Alpha : $00 ), //03. #FF5631   AMIGA_3BIT_RED_LIGHT
    ( r : $78; g : $89; b : $98; Alpha : $00 ), //04. #788998   AMIGA_3BIT_GRAY
    ( r : $FF; g : $89; b : $56; Alpha : $00 ), //05. #FF8956   AMIGA_3BIT_ORANGE
    ( r : $FF; g : $C6; b : $78; Alpha : $00 ), //06. #FFC678   AMIGA_3BIT_YELLOW
    ( r : $F1; g : $F1; b : $D4; Alpha : $00 )  //07. #F1F1D4   AMIGA_3BIT_WHITE
  );

function RGB_to_amiga3( const Color : TColorRec ) : byte;
begin
  result := RGB_to_amiga3( Color.R, Color.G, Color.B );
end;

function RGB_to_amiga3( const R, G, B : Byte ) : byte;
begin
  result := nearestLutColor( R, G, B, @LUT_AMIGA_3BIT[ 0 ], High( LUT_AMIGA_3BIT ) ); 
end;

function amiga3_to_RGB( amiga3 : byte ) : TColorRec;
begin
  if ( amiga3 > 7 ) then
    amiga3 := 0;
  result := LUT_AMIGA_3BIT[ amiga3 ]; //a value of [ 0..7 ]
end;

// Commodore Amiga 4-Bit palette.
// Total 16 different colors possible ( 2 pixels per byte ).
const //Commodore Amiga 4-Bit lookup table ( LUT )
  LUT_AMIGA_4BIT : array[ 0..$F ] of TColorRec = ( //Amiga 4-Bit, 16 colors
    ( r : $00; g : $00; b : $00; Alpha : $00 ), //00. #000000   AMIGA_4BIT_BLACK
    ( r : $56; g : $1C; b : $1C; Alpha : $00 ), //01. #561C1C   AMIGA_4BIT_BROWN_DARK
    ( r : $31; g : $56; b : $00; Alpha : $00 ), //02. #315600   AMIGA_4BIT_GREEN_DARK
    ( r : $B7; g : $00; b : $00; Alpha : $00 ), //03. #B70000   AMIGA_4BIT_RED_DARK
    ( r : $68; g : $68; b : $1C; Alpha : $00 ), //04. #68681C   AMIGA_4BIT_YELLOW_DARK
    ( r : $E3; g : $1C; b : $1C; Alpha : $00 ), //05. #E31C1C   AMIGA_4BIT_RED
    ( r : $68; g : $68; b : $68; Alpha : $00 ), //06. #686868   AMIGA_4BIT_GRAY
    ( r : $A8; g : $56; b : $31; Alpha : $00 ), //07. #A85631   AMIGA_4BIT_BROWN
    ( r : $78; g : $89; b : $98; Alpha : $00 ), //08. #788998   AMIGA_4BIT_BLUE
    ( r : $78; g : $A8; b : $31; Alpha : $00 ), //09. #78A831   AMIGA_4BIT_GREEN_LIGHT
    ( r : $FF; g : $56; b : $31; Alpha : $00 ), //10. #FF5631   AMIGA_4BIT_RED_LIGHT
    ( r : $B7; g : $89; b : $68; Alpha : $00 ), //11. #B78968   AMIGA_4BIT_BROWN_LIGHT
    ( r : $98; g : $A8; b : $B7; Alpha : $00 ), //12. #98A8B7   AMIGA_4BIT_BLUE_LIGHT
    ( r : $FF; g : $89; b : $56; Alpha : $00 ), //13. #FF8956   AMIGA_4BIT_ORANGE
    ( r : $FF; g : $C6; b : $78; Alpha : $00 ), //14. #FFC678   AMIGA_4BIT_YELLOW
    ( r : $F1; g : $E3; b : $D4; Alpha : $00 )  //15. #F1E3D4   AMIGA_4BIT_WHITE
  );

function RGB_to_amiga4( const Color : TColorRec ) : byte;
begin
  result := RGB_to_amiga4( Color.R, Color.G, Color.B );
end;

function RGB_to_amiga4( const R, G, B : Byte ) : byte;
begin
  result := nearestLutColor( R, G, B, @LUT_AMIGA_4BIT[ 0 ], High( LUT_AMIGA_4BIT ) ); 
end;

function amiga4_to_RGB( amiga4 : byte ) : TColorRec;
begin
  if amiga4>15 then
    amiga4 := 0;
  result := LUT_AMIGA_4BIT[ amiga4 ]; //a value of [ 0..15 ]
end;

// Commodore Amiga 5-Bit
// Total 32 different colors possible ( 1.6 pixels per byte ).
const //Commodore Amiga 5-Bit lookup table ( LUT )
  LUT_AMIGA_5BIT : array[ 0..31 ] of TColorRec = ( //Amiga 5-Bit, 32 colors
    ( r : $00; g : $00; b : $00; Alpha : $00 ), //00. #000000   AMIGA_5BIT_BLACK
    ( r : $33; g : $11; b : $00; Alpha : $00 ), //01. #331100   AMIGA_5BIT_BROWN_DARK
    ( r : $11; g : $22; b : $00; Alpha : $00 ), //02. #112200   AMIGA_5BIT_GREEN_DARKER
    ( r : $99; g : $00; b : $00; Alpha : $00 ), //03. #990000   AMIGA_5BIT_RED_DARKER
    ( r : $33; g : $33; b : $33; Alpha : $00 ), //04. #333333   AMIGA_5BIT_GRAY_DARKER
    ( r : $66; g : $33; b : $11; Alpha : $00 ), //05. #663311   AMIGA_5BIT_BROWN
    ( r : $33; g : $55; b : $00; Alpha : $00 ), //06. #335500   AMIGA_5BIT_GREEN_DARK
    ( r : $DD; g : $11; b : $11; Alpha : $00 ), //07. #DD1111   AMIGA_5BIT_RED_DARK
    ( r : $66; g : $55; b : $55; Alpha : $00 ), //08. #665555   AMIGA_5BIT_GRAY_DARK
    ( r : $AA; g : $33; b : $22; Alpha : $00 ), //09. #AA3322   AMIGA_5BIT_RED
    ( r : $44; g : $88; b : $11; Alpha : $00 ), //10. #448811   AMIGA_5BIT_GREEN
    ( r : $66; g : $66; b : $88; Alpha : $00 ), //11. #666688   AMIGA_5BIT_BLUE
    ( r : $AA; g : $66; b : $44; Alpha : $00 ), //12. #AA6644   AMIGA_5BIT_BROWN_LIGHT
    ( r : $FF; g : $44; b : $22; Alpha : $00 ), //13. #FF4422   AMIGA_5BIT_RED_LIGHT
    ( r : $99; g : $77; b : $88; Alpha : $00 ), //14. #997788   AMIGA_5BIT_PURPLE
    ( r : $77; g : $99; b : $33; Alpha : $00 ), //15. #779933   AMIGA_5BIT_GREEN_LIGHT
    ( r : $77; g : $99; b : $99; Alpha : $00 ), //16. #779999   AMIGA_5BIT_CYAN_DARK
    ( r : $FF; g : $66; b : $44; Alpha : $00 ), //17. #FF6644   AMIGA_5BIT_RED_LIGHTER
    ( r : $CC; g : $88; b : $66; Alpha : $00 ), //18. #CC8866   AMIGA_5BIT_ORANGE_DARK
    ( r : $88; g : $99; b : $DD; Alpha : $00 ), //19. #8899DD   AMIGA_5BIT_BLUE_LIGHT
    ( r : $99; g : $AA; b : $AA; Alpha : $00 ), //20. #99AAAA   AMIGA_5BIT_GRAY
    ( r : $88; g : $BB; b : $77; Alpha : $00 ), //21. #88BB77   AMIGA_5BIT_GREEN_LIGHT2
    ( r : $FF; g : $99; b : $44; Alpha : $00 ), //22. #FF9944   AMIGA_5BIT_ORANGE
    ( r : $AA; g : $CC; b : $33; Alpha : $00 ), //23. #AACC33   AMIGA_5BIT_GREEN_LIME
    ( r : $BB; g : $BB; b : $BB; Alpha : $00 ), //24. #BBBBBB   AMIGA_5BIT_GRAY_LIGHT
    ( r : $FF; g : $BB; b : $55; Alpha : $00 ), //25. #FFBB55   AMIGA_5BIT_YELLOW_DARK
    ( r : $FF; g : $AA; b : $88; Alpha : $00 ), //26. #FFAA88   AMIGA_5BIT_ORANGE_LIGHT
    ( r : $BB; g : $DD; b : $EE; Alpha : $00 ), //27. #BBDDEE   AMIGA_5BIT_CYAN_LIGHT
    ( r : $EE; g : $CC; b : $CC; Alpha : $00 ), //28. #EECCCC   AMIGA_5BIT_GRAY_LIGHTER
    ( r : $FF; g : $DD; b : $66; Alpha : $00 ), //29. #FFDD66   AMIGA_5BIT_YELLOW
    ( r : $FF; g : $FF; b : $99; Alpha : $00 ), //30. #FFFF99   AMIGA_5BIT_YELLOW_LIGHT
    ( r : $FF; g : $EE; b : $DD; Alpha : $00 )  //31. #FFEEDD   AMIGA_5BIT_WHITE
  );

function RGB_to_amiga5( const Color : TColorRec ) : byte;
begin
  result := RGB_to_amiga5( Color.R, Color.G, Color.B );
end;

function RGB_to_amiga5( const R, G, B : Byte ) : byte;
begin
  result := nearestLutColor( R, G, B, @LUT_AMIGA_5BIT[ 0 ], High( LUT_AMIGA_5BIT ) ); 
end;

function amiga5_to_RGB( amiga5 : byte ) : TColorRec;
begin
  if amiga5 > 31 then
    amiga5 := 0;
  result := LUT_AMIGA_5BIT[ amiga5 ]; //a value of [ 0..31 ]
end;


// ZX Spectrum palette, 4-Bit.
// Total 16 colors possible ( 2 pixels per byte ).
// RGBi variation ( 15 colors and a duplicate black ).
const //ZX Spectrum lookup table ( LUT )
  LUT_SPECTRUM_4BIT : array[ 0..$F ] of TColorRec = ( //ZX Spectrum, 4-Bit
    ( r : $00; g : $00; b : $00; Alpha : $00 ), //00. #000000   SPECTRUM_BLACK
    ( r : $00; g : $00; b : $AA; Alpha : $00 ), //01. #0000AA   SPECTRUM_BLUE_DARK
    ( r : $AA; g : $00; b : $00; Alpha : $00 ), //02. #AA0000   SPECTRUM_RED_DARK
    ( r : $AA; g : $00; b : $AA; Alpha : $00 ), //03. #AA00AA   SPECTRUM_MAGENTA_DARK
    ( r : $00; g : $AA; b : $00; Alpha : $00 ), //04. #00AA00   SPECTRUM_GREEN_DARK
    ( r : $00; g : $AA; b : $AA; Alpha : $00 ), //05. #00AAAA   SPECTRUM_CYAN_DARK
    ( r : $AA; g : $AA; b : $00; Alpha : $00 ), //06. #AAAA00   SPECTRUM_YELLOW_DARK
    ( r : $AA; g : $AA; b : $AA; Alpha : $00 ), //07. #AAAAAA   SPECTRUM_GRAY
    ( r : $00; g : $00; b : $00; Alpha : $00 ), //08. #000000   SPECTRUM_BLACK_DUPL
    ( r : $00; g : $00; b : $FF; Alpha : $00 ), //09. #0000FF   SPECTRUM_BLUE
    ( r : $FF; g : $00; b : $00; Alpha : $00 ), //10. #FF0000   SPECTRUM_RED
    ( r : $FF; g : $00; b : $FF; Alpha : $00 ), //11. #FF00FF   SPECTRUM_MAGENTA
    ( r : $00; g : $FF; b : $00; Alpha : $00 ), //12. #00FF00   SPECTRUM_GREEN
    ( r : $00; g : $FF; b : $FF; Alpha : $00 ), //13. #00FFFF   SPECTRUM_CYAN
    ( r : $FF; g : $FF; b : $00; Alpha : $00 ), //14. #FFFF00   SPECTRUM_YELLOW
    ( r : $FF; g : $FF; b : $FF; Alpha : $00 )  //15. #FFFFFF   SPECTRUM_WHITE
  );

// RGB 24-Bit to ZX Spectrum 4-Bit
function RGB_to_spectrum( const Color : TColorRec ) : byte;
begin
  result := RGB_to_spectrum( Color.R, Color.G, Color.B );
end;

function RGB_to_spectrum( const R, G, B : Byte ) : byte;
const
  RGBI_TO_SPECTRUM : array[ 0..$F ] of byte = ( 0, 1, 4, 5, 2, 3, 6, 7, 8, 9, 12, 13, 10, 11, 14, 15 );
var
  rgbi : byte;
begin
  rgbi   := RGB_to_rgbi( R, G, B ); //first convert to RGBi ( 4-Bit )
  result := RGBI_TO_SPECTRUM[ rgbi ]; //then pick related color from array
end;

function spectrum_to_RGB( const Color : TColorRec ) : byte;
begin
  result := spectrum_to_RGB( Color.R, Color.G, Color.B );
end;

function spectrum_to_RGB( const R, G, B : Byte ) : byte;
begin
  result := nearestLutColor( R, G, B, @LUT_SPECTRUM_4BIT[ 0 ], High( LUT_SPECTRUM_4BIT ) ); 
end;

// Amstrad CPC palette, 5-Bit.
// Total 27 colors used.
const //Amstrad CPC 5-Bit lookup table ( LUT )
  LUT_AMSTRAD_5BIT : array[ 0..26 ] of TColorRec = ( //Amstrad CPC
    ( r : $00; g : $00; b : $00; Alpha : $00 ), //00. #000000   AMSTRAD_BLACK
    ( r : $00; g : $00; b : $80; Alpha : $00 ), //01. #000080   AMSTRAD_BLUE
    ( r : $00; g : $00; b : $FF; Alpha : $00 ), //02. #0000FF   AMSTRAD_BLUE_BRIGHT
    ( r : $80; g : $00; b : $00; Alpha : $00 ), //03. #800000   AMSTRAD_RED
    ( r : $80; g : $00; b : $80; Alpha : $00 ), //04. #800080   AMSTRAD_MAGENTA
    ( r : $80; g : $00; b : $FF; Alpha : $00 ), //05. #8000FF   AMSTRAD_VIOLET
    ( r : $FF; g : $00; b : $00; Alpha : $00 ), //06. #FF0000   AMSTRAD_RED_BRIGHT
    ( r : $FF; g : $00; b : $80; Alpha : $00 ), //07. #FF0080   AMSTRAD_PURPLE
    ( r : $FF; g : $00; b : $FF; Alpha : $00 ), //08. #FF00FF   AMSTRAD_MAGENTA_BRIGHT
    ( r : $00; g : $80; b : $00; Alpha : $00 ), //09. #008000   AMSTRAD_GREEN
    ( r : $00; g : $80; b : $80; Alpha : $00 ), //10. #008080   AMSTRAD_CYAN
    ( r : $00; g : $80; b : $FF; Alpha : $00 ), //11. #0080FF   AMSTRAD_BLUE_SKY
    ( r : $80; g : $80; b : $00; Alpha : $00 ), //12. #808000   AMSTRAD_YELLOW
    ( r : $80; g : $80; b : $80; Alpha : $00 ), //13. #808080   AMSTRAD_GRAY
    ( r : $80; g : $80; b : $FF; Alpha : $00 ), //14. #8080FF   AMSTRAD_BLUE_PALE
    ( r : $FF; g : $80; b : $00; Alpha : $00 ), //15. #FF8000   AMSTRAD_ORANGE
    ( r : $FF; g : $80; b : $80; Alpha : $00 ), //16. #FF8080   AMSTRAD_PINK
    ( r : $FF; g : $80; b : $FF; Alpha : $00 ), //17. #FF80FF   AMSTRAD_MAGENTA_PALE
    ( r : $00; g : $FF; b : $00; Alpha : $00 ), //18. #00FF00   AMSTRAD_GREEN_BRIGHT
    ( r : $00; g : $FF; b : $80; Alpha : $00 ), //19. #00FF80   AMSTRAD_GREEN_SEA
    ( r : $00; g : $FF; b : $FF; Alpha : $00 ), //20. #00FFFF   AMSTRAD_CYAN_BRIGHT
    ( r : $80; g : $FF; b : $00; Alpha : $00 ), //21. #80FF00   AMSTRAD_GREEN_LIME
    ( r : $80; g : $FF; b : $80; Alpha : $00 ), //22. #80FF80   AMSTRAD_GREEN_PALE
    ( r : $80; g : $FF; b : $FF; Alpha : $00 ), //23. #80FFFF   AMSTRAD_CYAN_PALE
    ( r : $FF; g : $FF; b : $00; Alpha : $00 ), //24. #FFFF00   AMSTRAD_YELLOW_BRIGHT
    ( r : $FF; g : $FF; b : $80; Alpha : $00 ), //25. #FFFF80   AMSTRAD_YELLOW_PALE
    ( r : $FF; g : $FF; b : $FF; Alpha : $00 )  //26. #FFFFFF   AMSTRAD_WHITE
  );

// RGB 24-Bit to Amstrad CPC 5-Bit
function RGB_to_amstrad( const Color : TColorRec ) : byte;
begin
  result := RGB_to_amstrad( Color.R, Color.G, Color.B );
end;

function RGB_to_amstrad( const R, G, B : Byte ) : byte;
begin
  result := nearestLutColor( R, G, B, @LUT_AMSTRAD_5BIT[ 0 ], High( LUT_AMSTRAD_5BIT ) ); 
end;

// Amstrad CPC 5-Bit to RGB 24-Bit
function amstrad5_to_RGB( n : byte ) : TColorRec;
begin
  if ( n > 26 ) then
    n := 0;
  result := LUT_AMSTRAD_5BIT[ n ]; //a value of [ 0..26 ]
end;

// Nintendo GameBoy 2-Bit
// Total 4 shades of green possible ( 4 pixels per byte ).
// Similar to Grayscale 2-Bit with green palette colors.
function RGB_to_gameboy( const Color : TColorRec ) : byte; //same thing as :  RGB_to_gray2
begin
  result := RGB_to_gameboy( Color.R, Color.G, Color.B );
end;

function RGB_to_gameboy( const R, G, B : Byte ) : byte; //same thing as :  RGB_to_gray2
var
  gray8 : byte;
begin
  gray8  := ( r+g+b ) div 3; //first convert to gray8
  result := gray8 shr 6; //shr 6 :  get rid of 6 bits
end;

// GameBoy 2-Bit to RGB 24-Bit
function gameboy_to_RGB( n : byte ) : TColorRec;
const //Nintendo GameBoy 2-Bit lookup table ( LUT )
  LUT_GAMEBOY_2BIT : array[ 0..3 ] of TColorRec = ( //GameBoy 2-Bit
    ( r : $0F; g : $38; b : $0F; Alpha : $00 ), //00. #0F380F   GAMEBOY_DARKEST
    ( r : $30; g : $62; b : $30; Alpha : $00 ), //01. #306230   GAMEBOY_DARK
    ( r : $7D; g : $A1; b : $14; Alpha : $00 ), //02. #7DA114   GAMEBOY_BRIGHT
    ( r : $9B; g : $BC; b : $0F; Alpha : $00 )  //03. #9BBC0F   GAMEBOY_BRIGHTEST
  );
begin
  if ( n > 3 ) then
    n := 0;
  result := LUT_GAMEBOY_2BIT[ n ]; //a value of [ 0..3 ]
end;

// Nintendo Entertainment System palette, 6-Bit.
// Total 64 colors of which 8 colors are unused.
// NES 6-Bit to RGB 24-Bit
function nes_to_RGB( nes6 : byte ) : TColorRec;
const
  LUT_NES_6BIT : array[ 0..$3F ] of TColorRec = ( //Nintendo NES 6-Bit
    ( r : $7C; g : $7C; b : $7C; Alpha : $00 ), // 00 7C7C7C Gray
    ( r : $FC; g : $00; b : $00; Alpha : $00 ), // 01 0000FC Blue
    ( r : $BC; g : $00; b : $00; Alpha : $00 ), // 02 0000BC Dark blue
    ( r : $BC; g : $28; b : $44; Alpha : $00 ), // 03 4428BC Viola
    ( r : $84; g : $00; b : $94; Alpha : $00 ), // 04 940084 Dark magenta
    ( r : $20; g : $00; b : $A8; Alpha : $00 ), // 05 A80020 Dark red
    ( r : $00; g : $10; b : $A8; Alpha : $00 ), // 06 A81000 Dark orange
    ( r : $00; g : $14; b : $88; Alpha : $00 ), // 07 881400 Darker red
    ( r : $00; g : $30; b : $50; Alpha : $00 ), // 08 503000 Brown
    ( r : $00; g : $78; b : $00; Alpha : $00 ), // 09 007800 Medium green
    ( r : $00; g : $68; b : $00; Alpha : $00 ), // 0A 006800 Dark green
    ( r : $00; g : $58; b : $00; Alpha : $00 ), // 0B 005800 Darker green
    ( r : $58; g : $40; b : $00; Alpha : $00 ), // 0C 004058 Darkest cyan
    ( r : $00; g : $00; b : $00; Alpha : $00 ), // 0D 000000 Black
    ( r : $00; g : $00; b : $00; Alpha : $00 ), // 0E 000000 Unused 1
    ( r : $00; g : $00; b : $00; Alpha : $00 ), // 0F 000000 Unused 2
    ( r : $BC; g : $BC; b : $BC; Alpha : $00 ), // 10 BCBCBC Gray
    ( r : $F8; g : $78; b : $00; Alpha : $00 ), // 11 0078F8 Light blue
    ( r : $F8; g : $58; b : $00; Alpha : $00 ), // 12 0058F8 Medium blue
    ( r : $FC; g : $44; b : $68; Alpha : $00 ), // 13 6844FC Light viola
    ( r : $CC; g : $00; b : $D8; Alpha : $00 ), // 14 D800CC Magenta
    ( r : $58; g : $00; b : $E4; Alpha : $00 ), // 15 E40058 Pink
    ( r : $00; g : $38; b : $F8; Alpha : $00 ), // 16 F83800 Medium red
    ( r : $10; g : $5C; b : $E4; Alpha : $00 ), // 17 E45C10 Orange
    ( r : $00; g : $7C; b : $AC; Alpha : $00 ), // 18 AC7C00 Dark yellow
    ( r : $00; g : $B8; b : $00; Alpha : $00 ), // 19 00B800 Green
    ( r : $00; g : $A8; b : $00; Alpha : $00 ), // 1A 00A800 Medium green 1
    ( r : $44; g : $A8; b : $00; Alpha : $00 ), // 1B 00A844 Medium green 2
    ( r : $88; g : $88; b : $00; Alpha : $00 ), // 1C 008888 Darker cyan
    ( r : $00; g : $00; b : $00; Alpha : $00 ), // 1D 000000 Duplicate black
    ( r : $00; g : $00; b : $00; Alpha : $00 ), // 1E 000000 Unused 3
    ( r : $00; g : $00; b : $00; Alpha : $00 ), // 1F 000000 Unused 4
    ( r : $F8; g : $F8; b : $F8; Alpha : $00 ), // 20 F8F8F8 Lightest gray
    ( r : $FC; g : $BC; b : $3C; Alpha : $00 ), // 21 3CBCFC Sky blue
    ( r : $FC; g : $88; b : $68; Alpha : $00 ), // 22 6888FC Medium blue
    ( r : $F8; g : $78; b : $98; Alpha : $00 ), // 23 9878F8 Lighter viola
    ( r : $F8; g : $78; b : $F8; Alpha : $00 ), // 24 F878F8 Light magenta
    ( r : $98; g : $58; b : $F8; Alpha : $00 ), // 25 F85898 Light pink
    ( r : $58; g : $78; b : $F8; Alpha : $00 ), // 26 F87858 Light red
    ( r : $44; g : $A0; b : $FC; Alpha : $00 ), // 27 FCA044 Light orange
    ( r : $00; g : $B8; b : $F8; Alpha : $00 ), // 28 F8B800 Yellow
    ( r : $18; g : $F8; b : $B8; Alpha : $00 ), // 29 B8F818 Lime green
    ( r : $54; g : $D8; b : $58; Alpha : $00 ), // 2A 58D854 Light green
    ( r : $98; g : $F8; b : $58; Alpha : $00 ), // 2B 58F898 Turquoise
    ( r : $D8; g : $E8; b : $00; Alpha : $00 ), // 2C 00E8D8 Dark cyan
    ( r : $78; g : $78; b : $78; Alpha : $00 ), // 2D 787878 Darker gray
    ( r : $00; g : $00; b : $00; Alpha : $00 ), // 2E 000000 Unused 5
    ( r : $00; g : $00; b : $00; Alpha : $00 ), // 2F 000000 Unused 6
    ( r : $FC; g : $FC; b : $FC; Alpha : $00 ), // 30 FCFCFC White
    ( r : $FC; g : $E4; b : $A4; Alpha : $00 ), // 31 A4E4FC Light cyan
    ( r : $F8; g : $B8; b : $B8; Alpha : $00 ), // 32 B8B8F8 Lighter blue
    ( r : $F8; g : $B8; b : $D8; Alpha : $00 ), // 33 D8B8F8 Light purple
    ( r : $F8; g : $B8; b : $F8; Alpha : $00 ), // 34 F8B8F8 Lighter magenta
    ( r : $C0; g : $A4; b : $F8; Alpha : $00 ), // 35 F8A4C0 Lighter pink
    ( r : $B0; g : $D0; b : $F0; Alpha : $00 ), // 36 F0D0B0 Lighter orange
    ( r : $A8; g : $E0; b : $FC; Alpha : $00 ), // 37 FCE0A8 Lighter yellow
    ( r : $78; g : $D8; b : $F8; Alpha : $00 ), // 38 F8D878 Light yellow
    ( r : $78; g : $F8; b : $D8; Alpha : $00 ), // 39 D8F878 Light lime green
    ( r : $B8; g : $F8; b : $B8; Alpha : $00 ), // 3A B8F8B8 Lighter green
    ( r : $D8; g : $F8; b : $B8; Alpha : $00 ), // 3B B8F8D8 Light turquoise
    ( r : $FC; g : $FC; b : $00; Alpha : $00 ), // 3C 00FCFC Cyan
    ( r : $D8; g : $D8; b : $D8; Alpha : $00 ), // 3D D8D8D8 Light gray
    ( r : $00; g : $00; b : $00; Alpha : $00 ), // 3E 000000 Unused 7
    ( r : $00; g : $00; b : $00; Alpha : $00 )  // 3F 000000 Unused 8
  );
begin
  if ( nes6 > 63 ) then
    nes6 := 0;
  result := LUT_NES_6BIT[ nes6 ]; //a value of [ 0..63 ]
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// RAL
function RAL2Color( RAL : SmallInt; var vColor : TColorRec ): boolean;
begin
  result := RAL2RGB( RAL, vColor.R, vColor.G, vColor.B );
end;

function RAL2Color( RAL : string; var vColor : TColorRec ): boolean;
begin
  result := RAL2RGB( RAL, vColor.R, vColor.G, vColor.B );
end;

function RAL2Color( RAL : SmallInt; var vColor : TColor ): boolean;
begin
  result := RAL2RGB( RAL, TColorRec( vColor ).R, TColorRec( vColor ).G, TColorRec( vColor ).B );
end;

function RAL2Color( RAL : string; var vColor : TColor ): boolean;
begin
  result := RAL2RGB( RAL, TColorRec( vColor ).R, TColorRec( vColor ).G, TColorRec( vColor ).B );
end;

function RAL2RGB( RAL : SmallInt; var R, G, B : byte ): boolean;
var
  i : integer;
begin
  InitRALTable;

  result := false;
  for i := Low( RAL_Table.Items ) to High( RAL_Table.Items ) do
    begin
    if ( RAL_Table.Items[i].ID = RAL ) then
      begin
      R := RAL_Table.Items[i].R;
      G := RAL_Table.Items[i].G;
      B := RAL_Table.Items[i].B;
      result := true;
      end;
    end;
end;

function RAL2RGB( RAL : string; var R, G, B : byte ): boolean;
var
  i : integer;
begin
  InitRALTable;

  result := false;
  for i := Low( RAL_Table.Items ) to High( RAL_Table.Items ) do
    begin
    if ( CompareText( RAL_Table.Items[i].Name, RAL ) = 0 ) then
      begin
      R := RAL_Table.Items[i].R;
      G := RAL_Table.Items[i].G;
      B := RAL_Table.Items[i].B;
      result := true;
      end;
    end;
end;

function Color2RAL( vColor : TColorRec; var RAL : SmallInt; var RALName : string ): boolean;
begin
  result := RGB2RAL( vColor.R, vColor.G, vColor.B, RAL, RALName );
end;

function Color2RAL( vColor : TColorRec; var RAL : SmallInt ): boolean;
var
  Name : String;
begin
  result := RGB2RAL( vColor.R, vColor.G, vColor.B, RAL, Name );
end;

function Color2RAL( vColor : TColorRec; var RAL : string ): boolean;
var
  ID : SmallInt;
begin
  result := RGB2RAL( vColor.R, vColor.G, vColor.B, ID, RAL );
end;

function Color2RAL( vColor : TColor; var RAL : SmallInt; var RALName : string ): boolean;
begin

  result := Color2RAL( TColorRec( vColor ), RAL, RALName );
end;

function Color2RAL( vColor : TColor; var RAL : SmallInt ): boolean;
var
  Name : String;
begin
  result := Color2RAL( TColorRec( vColor ), RAL, Name );
end;

function Color2RAL( vColor : TColor; var RAL : string ): boolean;
var
  ID : SmallInt;
begin
  result := Color2RAL( TColorRec( vColor ), ID, RAL );
end;

function RGB2RAL( R, G, B : byte; var RAL : SmallInt ): boolean;
var
  Name : String;
begin
  result := RGB2RAL( R, G, B, RAL, Name );
end;

function RGB2RAL( R, G, B : byte; var RAL : string ): boolean;
var
  ID : SmallInt;
begin
  result := RGB2RAL( R, G, B, ID, RAL );
end;

function RGB2RAL( R, G, B : byte; var RAL : SmallInt; var RALName : string ): boolean;
var
  i : integer;
begin
  InitRALTable;

  result := false;
  for i := Low( RAL_Table.Items ) to High( RAL_Table.Items ) do
    begin
    if ( RAL_Table.Items[ i ].R = R ) AND ( RAL_Table.Items[ i ].G = G ) AND ( RAL_Table.Items[ i ].B = B ) then
      begin
      RAL     := RAL_Table.Items[i].ID;
      RALName := RAL_Table.Items[i].Name;
      result  := true;
      end;
    end;
end;

procedure ListRALs( var StrL : TStringList );
var
  i : integer;
begin
  InitRALTable;
  if NOT Assigned( StrL ) then
    Exit;

  for i := Low( RAL_Table.Items ) to High( RAL_Table.Items ) do
    StrL.Add( Format( '%d ( %s )', [ RAL_Table.Items[i].ID, RAL_Table.Items[i].Name ] ) );
end;

procedure ListRAL_IDs( var StrL : TStringList );
var
  i : integer;
begin
  InitRALTable;
  if NOT Assigned( StrL ) then
    Exit;

  for i := Low( RAL_Table.Items ) to High( RAL_Table.Items ) do
    StrL.Add( Format( '%d', [ RAL_Table.Items[i].ID ] ) );
end;

procedure ListRAL_Names( var StrL : TStringList );
var
  i : integer;
begin
  InitRALTable;
  if NOT Assigned( StrL ) then
    Exit;

  for i := Low( RAL_Table.Items ) to High( RAL_Table.Items ) do
    StrL.Add( Format( '%s', [  RAL_Table.Items[i].Name ] ) );
end;

procedure InitRALTable;
var
  Cnt : Byte;

  procedure SetRalColor( vRAL : SmallInt; vR, vG, vB : Byte; Name : String );
  begin
    RAL_Table.Items[ Cnt ].ID    := vRal;
    RAL_Table.Items[ Cnt ].R     := vR;
    RAL_Table.Items[ Cnt ].G     := vG;
    RAL_Table.Items[ Cnt ].B     := vB;
    RAL_Table.Items[ Cnt ].Alpha := 0;
//    RAL_Table.Items[ vID-1 ].Color := RGB2TColor( vR, vG, vB );
    RAL_Table.Items[ Cnt ].Name  := Name;
    Inc( Cnt );
  end;
begin
  if RAL_Table.Inited then
    Exit;

  Cnt := 0;
  SetRalColor( 1000, 190, 189, 127, 'Green beige' );
  SetRalColor( 1001, 194, 176, 120, 'Beige' );
  SetRalColor( 1002, 198, 166, 100, 'Sand yellow' );
  SetRalColor( 1003, 229, 190, 001, 'Signal yellow' );
  SetRalColor( 1004, 205, 164, 052, 'Golden yellow' );
  SetRalColor( 1005, 169, 131, 007, 'Honey yellow' );
  SetRalColor( 1006, 228, 160, 016, 'Maize yellow' );
  SetRalColor( 1007, 220, 156, 000, 'Daffodil yellow' );
  SetRalColor( 1011, 138, 102, 066, 'Brown beige' );
  SetRalColor( 1012, 199, 180, 070, 'Lemon yellow' );
  SetRalColor( 1013, 234, 230, 202, 'Oyster white' );
  SetRalColor( 1014, 225, 204, 079, 'Ivory' );
  SetRalColor( 1015, 230, 214, 144, 'Light ivory' );
  SetRalColor( 1016, 237, 255, 033, 'Sulfur yellow' );
  SetRalColor( 1017, 245, 208, 051, 'Saffron yellow' );
  SetRalColor( 1018, 248, 243, 053, 'Zinc yellow' );
  SetRalColor( 1019, 158, 151, 100, 'Grey beige' );
  SetRalColor( 1020, 153, 153, 080, 'Olive yellow' );
  SetRalColor( 1021, 243, 218, 011, 'Rape yellow' );
  SetRalColor( 1023, 250, 210, 001, 'Traffic yellow' );
  SetRalColor( 1024, 174, 160, 075, 'Ochre yellow' );
  SetRalColor( 1026, 255, 255, 000, 'Luminous yellow' );
  SetRalColor( 1027, 157, 145, 001, 'Curry' );
  SetRalColor( 1028, 244, 169, 000, 'Melon yellow' );
  SetRalColor( 1032, 214, 174, 001, 'Broom yellow' );
  SetRalColor( 1033, 243, 165, 005, 'Dahlia yellow' );
  SetRalColor( 1034, 239, 169, 074, 'Pastel yellow' );
  SetRalColor( 1035, 106, 093, 077, 'Pearl beige' );
  SetRalColor( 1036, 112, 083, 053, 'Pearl gold' );
  SetRalColor( 1037, 243, 159, 024, 'Sun yellow' );
  SetRalColor( 2000, 237, 118, 014, 'Yellow orange' );
  SetRalColor( 2001, 201, 060, 032, 'Red orange' );
  SetRalColor( 2002, 203, 040, 033, 'Vermilion' );
  SetRalColor( 2003, 255, 117, 020, 'Pastel orange' );
  SetRalColor( 2004, 244, 070, 017, 'Pure orange' );
  SetRalColor( 2005, 255, 035, 001, 'Luminous orange' );
  SetRalColor( 2007, 255, 164, 032, 'Luminous bright orange' );
  SetRalColor( 2008, 247, 094, 037, 'Bright red orange' );
  SetRalColor( 2009, 245, 064, 033, 'Traffic orange' );
  SetRalColor( 2010, 216, 075, 032, 'Signal orange' );
  SetRalColor( 2011, 236, 124, 038, 'Deep orange' );
  SetRalColor( 2012, 235, 106, 014, 'Salmon range' );
  SetRalColor( 2013, 195, 088, 049, 'Pearl orange' );
  SetRalColor( 3000, 175, 043, 030, 'Flame red' );
  SetRalColor( 3001, 165, 032, 025, 'Signal red' );
  SetRalColor( 3002, 162, 035, 029, 'Carmine red' );
  SetRalColor( 3003, 155, 017, 030, 'Ruby red' );
  SetRalColor( 3004, 117, 021, 030, 'Purple red' );
  SetRalColor( 3005, 094, 033, 041, 'Wine red' );
  SetRalColor( 3007, 065, 034, 039, 'Black red' );
  SetRalColor( 3009, 100, 036, 036, 'Oxide red' );
  SetRalColor( 3011, 120, 031, 025, 'Brown red' );
  SetRalColor( 3012, 193, 135, 107, 'Beige red' );
  SetRalColor( 3013, 161, 035, 018, 'Tomato red' );
  SetRalColor( 3014, 211, 110, 112, 'Antique pink' );
  SetRalColor( 3015, 234, 137, 154, 'Light pink' );
  SetRalColor( 3016, 179, 040, 033, 'Cored' );
  SetRalColor( 3017, 230, 050, 068, 'Rose' );
  SetRalColor( 3018, 213, 048, 050, 'Strawberry red' );
  SetRalColor( 3020, 204, 006, 005, 'Traffic red' );
  SetRalColor( 3022, 217, 080, 048, 'Salmon pink' );
  SetRalColor( 3024, 248, 000, 000, 'Luminous red' );
  SetRalColor( 3026, 254, 000, 000, 'Luminous bright red' );
  SetRalColor( 3027, 197, 029, 052, 'Raspberry red' );
  SetRalColor( 3028, 203, 050, 052, 'Pure red' );
  SetRalColor( 3031, 179, 036, 040, 'Orient red' );
  SetRalColor( 3032, 114, 020, 034, 'Pearl ruby red' );
  SetRalColor( 3033, 180, 076, 067, 'Pearl pink' );
  SetRalColor( 4001, 222, 076, 138, 'Red lilac' );
  SetRalColor( 4002, 146, 043, 062, 'Red violet' );
  SetRalColor( 4003, 222, 076, 138, 'Heather violet' );
  SetRalColor( 4004, 110, 028, 052, 'Claret violet' );
  SetRalColor( 4005, 108, 070, 117, 'Blue lilac' );
  SetRalColor( 4006, 160, 052, 114, 'Traffic purple' );
  SetRalColor( 4007, 074, 025, 044, 'Purple violet' );
  SetRalColor( 4008, 125, 078, 146, 'Signal violet' );
  SetRalColor( 4009, 164, 125, 144, 'Pastel violet' );
  SetRalColor( 4010, 215, 045, 109, 'Telemagenta' );
  SetRalColor( 4011, 134, 115, 161, 'Pearl violet' );
  SetRalColor( 4012, 108, 104, 129, 'Pearl black berry' );
  SetRalColor( 5000, 042, 046, 075, 'Violet blue' );
  SetRalColor( 5001, 031, 052, 056, 'Green blue' );
  SetRalColor( 5002, 032, 033, 079, 'Ultramarine blue' );
  SetRalColor( 5003, 029, 030, 051, 'Saphire blue' );
  SetRalColor( 5004, 032, 033, 079, 'Black blue' );
  SetRalColor( 5005, 030, 045, 110, 'Signal blue' );
  SetRalColor( 5007, 062, 095, 138, 'Brillant blue' );
  SetRalColor( 5008, 038, 037, 045, 'Grey blue' );
  SetRalColor( 5009, 002, 086, 105, 'Azure blue' );
  SetRalColor( 5010, 014, 041, 075, 'Gentian blue' );
  SetRalColor( 5011, 035, 026, 036, 'Steel blue' );
  SetRalColor( 5012, 059, 131, 189, 'Light blue' );
  SetRalColor( 5013, 037, 041, 074, 'Cobalt blue' );
  SetRalColor( 5014, 096, 111, 140, 'Pigeon blue' );
  SetRalColor( 5015, 034, 113, 179, 'Sky blue' );
  SetRalColor( 5017, 006, 057, 113, 'Traffic blue' );
  SetRalColor( 5018, 063, 136, 143, 'Turquoise blue' );
  SetRalColor( 5019, 027, 085, 131, 'Capri blue' );
  SetRalColor( 5020, 029, 051, 074, 'Ocean blue' );
  SetRalColor( 5021, 037, 109, 123, 'Water blue' );
  SetRalColor( 5022, 037, 040, 080, 'Night blue' );
  SetRalColor( 5023, 073, 103, 141, 'Distant blue' );
  SetRalColor( 5024, 093, 155, 155, 'Pastel blue' );
  SetRalColor( 5025, 042, 100, 120, 'Pearl gentian blue' );
  SetRalColor( 5026, 016, 044, 084, 'Pearl night blue' );
  SetRalColor( 6000, 049, 102, 080, 'Patina green' );
  SetRalColor( 6001, 040, 114, 051, 'Emerald green' );
  SetRalColor( 6002, 045, 087, 044, 'Leaf green' );
  SetRalColor( 6003, 066, 070, 050, 'Olive green' );
  SetRalColor( 6004, 031, 058, 061, 'Blue green' );
  SetRalColor( 6005, 047, 069, 056, 'Moss green' );
  SetRalColor( 6006, 062, 059, 050, 'Grey olive' );
  SetRalColor( 6007, 052, 059, 041, 'Bottle green' );
  SetRalColor( 6008, 057, 053, 042, 'Brown green' );
  SetRalColor( 6009, 049, 055, 043, 'Fir green' );
  SetRalColor( 6010, 053, 104, 045, 'Grass green' );
  SetRalColor( 6011, 088, 114, 070, 'Reseda green' );
  SetRalColor( 6012, 052, 062, 064, 'Black green' );
  SetRalColor( 6013, 108, 113, 086, 'Reed green' );
  SetRalColor( 6014, 071, 064, 046, 'Yellow olive' );
  SetRalColor( 6015, 059, 060, 054, 'Black olive' );
  SetRalColor( 6016, 030, 089, 069, 'Turquoise green' );
  SetRalColor( 6017, 076, 145, 065, 'May green' );
  SetRalColor( 6018, 087, 166, 057, 'Yellow green' );
  SetRalColor( 6019, 189, 236, 182, 'Pastel green' );
  SetRalColor( 6020, 046, 058, 035, 'Chrome green' );
  SetRalColor( 6021, 137, 172, 118, 'Pale green' );
  SetRalColor( 6022, 037, 034, 027, 'Olive drab' );
  SetRalColor( 6024, 048, 132, 070, 'Traffic green' );
  SetRalColor( 6025, 061, 100, 045, 'Fern green' );
  SetRalColor( 6026, 001, 093, 082, 'Opal green' );
  SetRalColor( 6027, 132, 195, 190, 'Light green' );
  SetRalColor( 6028, 044, 085, 069, 'Pine green' );
  SetRalColor( 6029, 032, 096, 061, 'Mint green' );
  SetRalColor( 6032, 049, 127, 067, 'Signal green' );
  SetRalColor( 6033, 073, 126, 118, 'Mint turquoise' );
  SetRalColor( 6034, 127, 181, 181, 'Pastel turquoise' );
  SetRalColor( 6035, 028, 084, 045, 'Pearl green' );
  SetRalColor( 6036, 022, 053, 055, 'Pearl opal green' );
  SetRalColor( 6037, 000, 143, 057, 'Pure green' );
  SetRalColor( 6038, 000, 187, 045, 'Luminous green' );
  SetRalColor( 7000, 120, 133, 139, 'Squirrel grey' );
  SetRalColor( 7001, 138, 149, 151, 'Silver grey' );
  SetRalColor( 7002, 126, 123, 082, 'Olive grey' );
  SetRalColor( 7003, 108, 112, 089, 'Moss grey' );
  SetRalColor( 7004, 150, 153, 146, 'Signal grey' );
  SetRalColor( 7005, 100, 107, 099, 'Mouse grey' );
  SetRalColor( 7006, 109, 101, 082, 'Beige grey' );
  SetRalColor( 7008, 106, 095, 049, 'Khaki grey' );
  SetRalColor( 7009, 077, 086, 069, 'Green grey' );
  SetRalColor( 7010, 076, 081, 074, 'Tarpaulin grey' );
  SetRalColor( 7011, 067, 075, 077, 'Iron grey' );
  SetRalColor( 7012, 078, 087, 084, 'Basalt grey' );
  SetRalColor( 7013, 070, 069, 049, 'Brown grey' );
  SetRalColor( 7015, 067, 071, 080, 'Slate grey' );
  SetRalColor( 7016, 041, 049, 051, 'Anthracite grey' );
  SetRalColor( 7021, 035, 040, 043, 'Black grey' );
  SetRalColor( 7022, 051, 047, 044, 'Umbra grey' );
  SetRalColor( 7023, 104, 108, 094, 'Concrete grey' );
  SetRalColor( 7024, 071, 074, 081, 'Graphite grey' );
  SetRalColor( 7026, 047, 053, 059, 'Granite grey' );
  SetRalColor( 7030, 139, 140, 122, 'Stone grey' );
  SetRalColor( 7031, 071, 075, 078, 'Blue grey' );
  SetRalColor( 7032, 184, 183, 153, 'Pebble grey' );
  SetRalColor( 7033, 125, 132, 113, 'Cement grey' );
  SetRalColor( 7034, 143, 139, 102, 'Yellow grey' );
  SetRalColor( 7035, 215, 215, 215, 'Light grey' );
  SetRalColor( 7036, 127, 118, 121, 'Platinum grey' );
  SetRalColor( 7037, 125, 127, 120, 'Dusty grey' );
  SetRalColor( 7038, 195, 195, 195, 'Agate grey' );
  SetRalColor( 7039, 108, 105, 096, 'Quartz grey' );
  SetRalColor( 7040, 157, 161, 170, 'Window grey' );
  SetRalColor( 7042, 141, 148, 141, 'Traffic grey A' );
  SetRalColor( 7043, 078, 084, 082, 'Traffic grey B' );
  SetRalColor( 7044, 202, 196, 176, 'Silk grey' );
  SetRalColor( 7045, 144, 144, 144, 'Telegrey 1' );
  SetRalColor( 7046, 130, 137, 143, 'Telegrey 2' );
  SetRalColor( 7047, 208, 208, 208, 'Telegrey 4' );
  SetRalColor( 7048, 137, 129, 118, 'Pearl mouse grey' );
  SetRalColor( 8000, 130, 108, 052, 'Green brown' );
  SetRalColor( 8001, 149, 095, 032, 'Ochre brown' );
  SetRalColor( 8002, 108, 059, 042, 'Signal brown' );
  SetRalColor( 8003, 115, 066, 034, 'Clay brown' );
  SetRalColor( 8004, 142, 064, 042, 'Copper brown' );
  SetRalColor( 8007, 089, 053, 031, 'Fawn brown' );
  SetRalColor( 8008, 111, 079, 040, 'Olive brown' );
  SetRalColor( 8011, 091, 058, 041, 'Nut brown' );
  SetRalColor( 8012, 089, 035, 033, 'Red brown' );
  SetRalColor( 8014, 056, 044, 030, 'Sepia brown' );
  SetRalColor( 8015, 099, 058, 052, 'Chestnut brown' );
  SetRalColor( 8016, 076, 047, 039, 'Mahogany brown' );
  SetRalColor( 8017, 069, 050, 046, 'Chocolate brown' );
  SetRalColor( 8019, 064, 058, 058, 'Grey brown' );
  SetRalColor( 8022, 033, 033, 033, 'Black brown' );
  SetRalColor( 8023, 166, 094, 046, 'Orange brown' );
  SetRalColor( 8024, 121, 085, 061, 'Beige brown' );
  SetRalColor( 8025, 117, 092, 072, 'Pale brown' );
  SetRalColor( 8028, 078, 059, 049, 'Terra brown' );
  SetRalColor( 8029, 118, 060, 040, 'Pearl copper' );
  SetRalColor( 9001, 250, 244, 227, 'Cream' );
  SetRalColor( 9002, 231, 235, 218, 'Grey white' );
  SetRalColor( 9003, 244, 244, 244, 'Signal white' );
  SetRalColor( 9004, 040, 040, 040, 'Signal black' );
  SetRalColor( 9005, 010, 010, 010, 'Jet black' );
  SetRalColor( 9006, 165, 165, 165, 'White aluminium' );
  SetRalColor( 9007, 143, 143, 143, 'Grey aluminium' );
  SetRalColor( 9010, 255, 255, 255, 'Pure white' );
  SetRalColor( 9011, 028, 028, 028, 'Graphite black' );
  SetRalColor( 9016, 246, 246, 246, 'Traffic white' );
  SetRalColor( 9017, 030, 030, 030, 'Traffic black' );
  SetRalColor( 9018, 215, 215, 215, 'Papyrus white' );
  SetRalColor( 9022, 156, 156, 156, 'Pearl light grey' );
  SetRalColor( 9023, 130, 130, 130, 'Pearl dark grey' ); // 212
  RAL_Table.Inited := true;
end;

{$IFEND TLH_INTERFACESECTION}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

{$IFNDEF TLH_OMIT_SECTIONS}
initialization
{$ENDIF TLH_OMIT_SECTIONS}
{$IF NOT Defined(TLH_INTERFACESECTION) AND NOT Defined(TLH_IMPLEMENTATIONSECTION) AND NOT Defined(TLH_FINALIZATIONSECTION)}
  InitRALTable;
{$IFEND}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

{$IFNDEF TLH_OMIT_SECTIONS}
end.
{$ENDIF TLH_OMIT_SECTIONS}
