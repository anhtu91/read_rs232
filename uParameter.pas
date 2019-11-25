unit uParameter;

(*
  C.Gülker, M. Schmidt

  Basisunit für die komfortable Verwaltung von Programmparametern:
  Diese Unit "uParameter" muss in FrmOptionen (und in Global.pas wenn die Parameter dort deklariert sind) eingebunden werden.

  *****************************************************************************************************************
  *****************************************************************************************************************
  26.09.2019 - ms - ParameterSynchronizer: Update Parameter-Inis w/o fully loading them (Logging/MD5 Support)
                    Structural Remake
                    T_PARAM_INT64
                    Check for used/inaccessable Files

  18.09.2019 - ms - Change: Additional Parameter for STR_PARAM, indicating the Value will be a Folder (Auto-Enforcing of Folder-Structures)

  26.06.2019 - ms - Change: ParameterUebernehmen CleanUp (14.01.2015) not automatic anymore, CleanUp-Switch for 'ParameterUebernehmen'

  12.06.2019 - ms - FrmParameterBackup.ExecuteAndLoad

  26.03.2019 - ms - uTiming Additions

  04.02.2019 - ms - Internal ValueExists to speed things up with regular Ini
                    Change: EPS 1.0E-15 to 1.0E-8
                    RegistryIniFile Support

  05.10.2018 - ms - BugFix T_INI_DATEI.Create: Empty FileName caused ForceDirectories-Exception

  04.09.2018 - ms - BugFix: T_PARAM_STR: not default-initialized if not Password-type
                    BugFix: T_PARAM_STR_List: Save behaves like other parameter-types (was auto-saved in OnExit .. (Kamplade))
                    BugFix: T_PARAM_*.Save: result not initialized when using un-initialized instances

  10.08.2018 - ms - BugFix: RangeCheckError on empty Parameter-Record
                    INIT_CHECK define

  03.07.2018 - ms - BugFix: missing Exceptions for unsupported Propertys
                    T_PARAM_REAL/T_PARAM_INT: min/max 0 uses MinDouble/Low( Integer ) to MaxDouble/High( Integer ) (full range)
                    T_PARAM_REAL: Date-/Time-Property Support (JvDateEdit, JvTimeEdit)
                    Removed: anzParameterInited
                    CloseIniDatei: returns Name(D2006+) or Number(Logical Order in Record) of not initialized Parameters
                    BugFix: fLoaded false since IniSection, IniName need to be trimmed to work same as Ini.Read...

  16.05.2018 - ms - BugFix: MD5 didn't work without FastIniFiles

  23.03.2018 - ms - GetIsAllDefault-property shows if INI was fully loaded

  06.03.2018 - ms - BugFix: ForceDirectorys for new ParameterFiles/Paths

  04.10.2017 - ms - BugFix: missing fChanged:=false in Load-procedures

  05.04.2017 - ms - BugFix: EGerade/EPunkt Load/Save: now using uParam_StrToFloat_Int
                    Change: Real Load/Save: now using uParam_StrToFloat_Int

  23.03.2017 - ms - DUPECHECK added (Check for duplicate use of same VCL-Objects)
  
  12.03.2017 - ms - BugFix: UnHighlightChangedValues only called if there are changes to unhighlight ..
                    BugFix: HighlightItem only executed if called by MainThread

  09.01.2017 - ms - BugFix: BackupList crashed on empty MD5-Files
                    BugFix: Backup Cleanup ignored MD5-Files
                    BugFix: Backup Cleanup: delete-exception showed wrong filenames

  22.11.2016 - ms - BugFix: 'Changed' isnt set during Init-Phase

  10.11.2016 - ms - BugFix: Exception if MAXPARAMETER_ is exceeded
                    BugFix: Calling Init_Param's not creating array-dups anymore
                    MasterBackup not bound to 'AutoBackup' define anymore
                    Backup Formular (On MD5 Fail & ListBackups)
                    Reload-procedure (INI->Array&VCL)
                    SetValue checks for NoVCL
                    BugFix: OnChange sets 'changed' before calling follow events
                    SetValue raises OnChange (if SetValueRaiseOnChange is defined)
                    StrToFloat_Int improved

  04.10.2016 - ms - BugFix: BackUp MD5 wasnt checked, not found/missing folder
  
  12.09.2016 - ms - BugFix: ePunkt X not saved, logging format-exception
                            eGerade X/Y not saved
                            StrList filesection desynch

  28.08.2016 - ms - BugFix: Param_Bool.Save partialy ignored TRadioButton-Changes (passive)

  08.08.2016 - ms - ParameterUebernehmen: UserName & Comment for Logging

  01.07.2016 - ms - During Application.Terminate 'Save' doesnt refresh from Propertys

  24.06.2016 - ms - StringList Param BugFix (FastIniFiles)

  06.06.2016 - ms - BugFix: AutoBackup CleanUp
                    MD5-Check Stream-based / Support for LARGE Inis

  02.05.2016 - ms - AutoBackup (CompilerSwitch)
                      Creates one backup per day (IniName_yyyy_mm_dd.bak) with max of PARAMETER_MAX_BACKUPS_
                    MD5-Check Final/Bugfixes
                    ParameterUebernehmen MasterBackup switch
                      Creates backup (IniName_Master.bak) which is seperated from AutoBackUp

  19.02.2016 - ms - Inited-Flag verhindert speichern während Parameter-Laden (Zwischen OpenFile und CloseFile)
                    BugFix: WriteLog
                    MD5-Check (Beta)

  01.02.2016 - ms - SetValue löst keine OnChanges mehr aus
  
  28.01.2016 - ms - BugFix: NoVCL
                    BugFix: BackUp-Values: EPunkt
                    BackUp-Values in PARAM-Objekte verschoben
                    BugFix: StackOverflow (RestoreEvents (T_PARAM_STR))

  05.12.2015 - ms - Delphi 10 Seattle support
                    Komponentenabhängigkeit gelöst, alles property basiert

  21.10.2015 - ms - PARAM_INT & PARAM_STR: TLabeledEdit support
                    SerialDialog support (TSerComboBox, TSerPortComboBox, TSerBaudComboBox, TSerDataBitsComboBox, TSerStopBitsComboBox, TSerParityBitComboBox, TSerHandshakeComboBox)
                    JvIPAddress support

  07.09.2015 - ms - Logging: Passwörter werden nicht mehr geloggt, nur änderungshinweis

  18.06.2015 - ms - Object-Descendant-Support

  19.05.2015 - ms - BugFix: Stackoverflow (Parameter mehrfach neu laden: OnChange->OriginalOnChange->OnChange ...)

  07.04.2015 - ms - Unnötige Get-Funktionen entfernt
                    Parameterstruktur Optimiert
                    StringList-ParamTyp debuggt (Destroy/OnExit-Redirect)
                    Typecasts Debugger-Freundlich umgestellt
                    Propertys für Default-/Min-/Max-Werte (Direktzugriff, keine Plausibilitätsprüfungen)
                    Werte_geandert basiert jetzt auf BackUp-Werten
                    
  14.01.2015 - ms - ParameterUebernehmen CleanUp (Entfernt beim Speichern nicht mehr benötigte Einträge aus der INI)

  18.12.2014 - ms - HighlightChangedValues/HighlightChangedValuesFromOtherIni jetzt funktionen mit ÄnderungsCount als rückgabe

  16.12.2014 - ms - TMemIniFile/FastIniFiles support
                    Doppelte Section-Var entfernt
                    Section übergabe-Parameter aus den Save-proceduren entfernt

  09.09.2014 - ms - PARAM_AOI implementiert
                    BugFix: Clone/Log/Highlight ROIs wurden ignoriert

  31.07.2014 - ms - BugFix: Overflow im Real/Integer OnKeyPress // ePunkt OnKeyPress hinzugefügt

  04.07.2014 - ms - Destructor erweitert (SpeicherLeak)

  27.06.2014 - ms - MathRout per Compilerdirektive
                    OnExit / OnKeyPress weiterleiten zu ggf vorhandenen OriginalEvents
                    BugFix: Copy/Paste fehler in Destroy

  27.05.2014 - ms - Dateiname als public property
                    NoVCL property um beim Mehrfach-Instanz-Laden ohne weitere Lade-funktion die VCL abzukoppeln

  20.05.2014 - ms - Destroy eingeführt um StackOverflow/Loop beim mehrfachen erstellen von Parametern mit VCL zugriff zu beheben
                    Compilerwarnungen verschwinden lassen
                    fCountInt & fCountROI getrennt
                    GetTok, NumTok, StrToFloat int mit uParam_ prefixed (Kompatibilität mit uStrUtil)

  02.04.2014 - ms - Werte_noch_nicht_gespeichert wieder entfernt, werte_geandert boolean wieder private, property werte_geandert (readOnly) als ersatz
                    Logging funktion beim Parameter_Uebernehmen (NUR beim Speichern in Datei)
                    HighlightChangedValues( showOldValuesAsHint ) Färbt alle komponenten deren Werte sich seit dem letzten Speichern geändert haben (Übernommen aber NICHT gespeichert) (Alter wert als Hint falls gewünscht)
                    HighlightChangedValuesFromOtherIni( parameter_compare, showOldValuesAsHint ) Färbt alle komponenten deren Werte sich gegenüber der alternativen INI geändert haben (Alter wert als Hint falls gewünscht)
                    T_PARAM_STR_LIST.StringsUebernehmen - Assign stat 0..Count-1 Durchlauf, schneller..
                    T_PARAM_BOOL - OnChange(Click) hinzugefügt um änderungen zu bemerken
                    SetValue: Setzt überall bei änderung werte_geandert auf True, damit auch non-VCL änderungen bemerkt werden

  29.10.2013 - ms - Erweiterung um TColorBox.Selected

  11.09.2013 - ms - ReImplementation von änderung '16.08.2005'

  11.06.2013 - ms - Kleinere übergabe-absicherungen
                  - SectionLoeschen hinzugefügt
                  - Bugfix: StrToFloat bei Sprachumstellung(Inkl. Dezimalseperator) problematisch, auf StrToFloat_Int umgestellt

  09.05.2013 - ms - PARAM_REAL/PARAM_EPUNKT StrToFloatDEF stat StrToFloat verwendet um exceptions - auch mit compiler - zu dezimieren

  30.11.2012 - ms - PARAM_REAL try/error mode beim parsen um support für . , als Dezimalseperator hinzuzufügen
            ms/rk - List/ComboBoxen hinzugefügt
               rk - ParamReal hat nachKomma-Stellen-Value

  16.08.2005 - mw - Erweiterung um T_PARAM_eGerade

  21.04.2005 - cg - Verwaltung von verschlüsselten Strings für z.B. Passworte bei T_PARAM_STR. Automatische Aktivierung
                    durch die Zuweisung eines EditFelds mit der Eigenschaft PasswordChar <> ''.
                    Die Strings werden in der IniDatei verschlüsselt -Asciikodiert gespeichert.
                    z.B. aus Passwort "meer" wird "108100100113018000024020023021017006021018029019030007020009"

  04.04.2005 - cg - T_PARAM_BOOL können jetzt auch als RadioButton verwendet werden ( nicht nur Checkbox )

  07.03.2005 - cg - Der "Wert" der Parameter kann wieder direkt gelesen und geschrieben werden,
                    da er jetzt intern als Property deklariert ist.
                  - Unterstüung von Typ_ePunkt

  04.03.2005 - cg - Abfragemöglichkeit für PARAMETER_TYP "Werte_noch_nicht_gespeichert": gibt true zurück, wenn
                    Parameter geändert worden sind, aber noch nicht gespeichert wurden.
                    (z.B. Sinnvoll beim Umschalten von mehreren Parametersätzen oder beim Verlassen
                    der Parametermaske mit einem Abbrechen-Button)

  03.03.2005 - cg - Umstellung des records PARAMETER_TYP in eine Instanz der Classe T_INI_DATEI
                    Dadurch sind jetzt mehrere Parameter-Dateien in einem Programm verwendbar ( z.B. Parameter+ Kopfdaten )
                  - Mehrfaches einladen der ini-Datei möglich ( um z.B. die geänderten Parameter zu verwerfen )
                  - Der Name der Inidatei kann durch die Methode ".DateinameAendern( '...' )" zu Laufzeit noch geändert werden,
                    um andere Parametersätze nachzuladen
                    z.B. verschiedene Parameter für Kalt- Warmteile. oder ältere Parameter
                  - Der "Wert" der Parameter kann nur noch über Methoden gelesen und geschrieben werden
                    z.B.  Lesen:  x:=testparam.Wert / Schreiben: testparam.Wert( 1234 )

  28.2.2005 - cg - Initialisierung der Zähler (fCountInt_ ...) bei jedem Aufruf von uPARAM_OpenIniDatei
                 - uPARAM_OpenIniDatei kann nicht mehrfach aufgerufen werden -> Exception!

  21.2.2005 - cg - Typ T_PARAM_NR kann jetzt neben RadioGroup auch SpinEdit und Scrollbar Objekte
                 - Überprüfung nach Initialisierung der Parameter, ob keiner vergessen wurde

  18.2.2005 - cg - Basisversion

  *****************************************************************************************************************
  *****************************************************************************************************************

   Unterstützt werden folgende Parameter - Typen:
     Integer           für EditFelder      mit zusätzlicher Kontrolle auf Zeichen-Gültigkeit und Wertebereich
     Floatingpoint     für EditFelder      mit zusätzlicher Kontrolle auf Zeichen-Gültigkeit und Wertebereich
     Aufzählungstypen  für Radiogroup / Spinedit / Scrollbar / Trackbar 
     Boolsche          für CheckBoxen oder Radiobuttons
     Strings           für EditFelder
     String-Liste      für Comboboxen oder Listboxen
     Rechtecktypen     für RECHTECK_TYP = 4 Integer/EditFelder  (Es werden intern automatisch 4 Integertypen definiert)
     ePunktTypen       für Typ_ePunkt   = 2-Extended Werte      (Es werden intern automatisch 2 Doubletypen definiert)
     ROI               für ( alte ) ROIs  = 4-Integer Werte (TopLeft, BottomRight jeweils X/Y )
     AOI               für ( neue ) ROIs  = 8-Extended Werte (TopLeft, TopRight, BottomLeft, BottomRight jeweils X/Y)

  Beispiel:
  1 ) z.B. in Unit "global.pas"  werden im Interface-Teil die Parameter deklariert:

    interface
    uses uParameter;
    type
      PARAMETER_TYP = class( T_INI_DATEI )   // globale Instanz  der T_INI_Datei-Class
        intParam    : T_PARAM_INT;
        boolParam   : T_PARAM_BOOL;
        doubleParam : T_PARAM_REAL;
        roi         : T_PARAM_ROI;
        index       : T_PARAM_NR;
        strList     : T_PARAM_STR_LIST;
        ePunkt      : T_PARAM_ePunkt;
        eGerade     : T_PARAM_eGerade;
        AOI         : T_PARAM_AOI;
        end;

  2 ) in Unit "global.pas"  einen Zeiger auf die globalen Parameter erzeugen:
     var
      parameter__ : PARAMETER_TYP; // (muss noch in z.B. Main.FrmShow initialisiert werden)

  3 ) in z.B. Unit "main.pas"  den Zeiger mit Pfad und Dateiname der ini-Datei initialisieren
     und anschließend den Befehl zum Laden aufrufen.   siehe 4 )

       parameter__ := PARAMETER_TYP.Create( programPfad__ +  PARAMETER_DIR__ + PROGRAMM_PARAMETER_DATEI__ );
       FrmOptionen.Parameter_laden;


  4 ) Im Formular mit den Parametern z.B. FrmOptionen werden die Parameter mit Defaultwerten initialisiert
     oder falls schon vorhanden aus der Ini-datei geladen.
     (Der Aufruf dieser Funktion sollte z.B. in FrmMain.FormShow erfolgen, siehe 3)

     Jeder Parameter erhält:
     - einen Defaultwert
     - bei Integer und Float-Typen zusätzlich Minimum und Maximum
     - eine Bezeichnung unter der er in der Ini-Datei geführt wird
     - ein Objekt ( TEdit, TCheckBox, TRadiogroup ) aus dem Formular mit dem er geändert werden kann.
       ( Nur der Rechteck-Typ erhält 4 EditFelder, da hier auf einmal eine ROI angelegt werden kann )
     - Wird optional als Objekt "nil" übergeben, so kann der Parameter nur in der Ini-Datei mit
       einem Texteditor oder direkt vom Programm aus geändert werden.

     Procedure TFrmOptionen.Parameter_laden;
     begin
       with parameter__ do
         begin
         OpenIniDatei;  // WICHTIG !
         SetzteSection( 'Allgemein' );
         Init_StrParam( name, 'Testkopfdaten','name', EditKopfdatenName );
         Init_RealParam( durchmesserInnenkreis,  50,   30, 200,  'durchmesserInnenkreis', EditKopfdatenParam1 );
         SetzteSection( 'BV' );
         Init_IntParam( anzPunkteModelle, 4,  3, 4,  'anzPunkteModelle', EditKopfdatenAnzMessp );
         for i := 0 to 3 do
           Init_ROIParam( roi[ i ], 0,0, uVH_IMAGE_SIZE_X-1, uVH_IMAGE_SIZE_Y-1,  'roi'+IntToStr( i ),nil, nil, nil, nil );
         CloseIniDatei;    // WICHTIG !
         if IsDefault then
           ShowMessage( 'Warnung, INI mit default-parametern initialisiert' )
         end;
      end;

  5 ) Jetzt müssen die Parameter nur noch gespeichert werden:
     z.B. in  procedure TFrmOptionen.BitBtnCloseClick beim Verlassen des Formulars
     Dazu braucht man nur EINEN EINZIGEN Aufruf:

     parameter__.ParameterUebernehmen( true{Save}, false{logging} );
       Save
        true  = Werte aus Maske in globale-Parameter-Struktur übernehmen und in Ini-datei speichern
        false = Werte aus Maske nur in globale-Parameter-Struktur übernehmen ( nicht speichern )
       Logging
        true  = Änderungen werden als ParameterDateiName.log gespeichert ( NUR WENN SAVE=TRUE )
        false = Kein logging

  6 ) Der Lese-Zugriff im Programm auf die Parameter erfolgt wie gewohnt,
     nur ".Wert" muss angehängt werden (.Wert ist eine Methode!)
     z.B:
       parameter__.intParam.Wert
       parameter__.boolParam.Wert
       parameter__.doubleParam.Wert
       parameter__.roi.x1.Wert
       parameter__.roi.x2.Wert
       parameter__.index.Wert

  7 ) Der Schreib-Zugriff im Programm auf die Parameter erfolgt durch direkte Zuweisung
     Die Werte werden bei Bedarf auf Grenzwerte geprüft und in die entsprechenden z.B. EditFelder geschrieben
     z.B:
       parameter__.intParam.Wert :=  45
       parameter__.boolParam.Wert := true
       parameter__.doubleParam.Wert := 1.234


  8 ) Im FormCloseQuery oder ähnlichem kann abgefangen werden ob die änderungen gespeichert werden sollen:
       ..
       if parameter__.Werte_geandert then
         begin
         if ( Messagedlg( 'Werte wurden geändert! Abspeichern?', mtConfirmation, [ mbYES, mbNO ], 0 ) = mrYes ) then
           parameter__.ParameterUebernehmen( true{Save}, false{Log} )
         else
           parameter_laden;
         end;
*)

interface

{.$i *.inc} // MS

// IniType
{.$DEFINE useFastIni} // Requires FastIniFiles.pas
{.$DEFINE useMemIni}
{.$DEFINE useRegistryIni} // Not done

{.$DEFINE useTLH_Math} // eRect, [ePunkt, eGerade]
{$DEFINE useMATHROUT} // ePunkt, eGerade

{$DEFINE JVCL} // JvTimeEdit hasnt published 'Time' ..

// Config
{$DEFINE AutoBackup}
{.$DEFINE MD5}
{$IFDEF MD5} // Better with FastIni
  {.$DEFINE INDY90}
  {$DEFINE INDY100}
{$ENDIF}

{$DEFINE SetValueRaiseOnChange}
{$DEFINE DUPECHECK} // Check for already used VCL-Objects
{$DEFINE INIT_CHECK} // Raise Exception on not initialized Parameters
{.$DEFINE ASSIGN_VCL} // Assign involves VCL
{.$DEFINE CriticalSections}

{$WARN UNSAFE_CAST OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_TYPE OFF}
{$WARN SYMBOL_PLATFORM OFF}
{$IF CompilerVersion >= 17}
  {$LEGACYIFEND ON}
{$IFEND}

uses
  Classes, SysUtils, Graphics, Math,
  Forms, StdCtrls
{$IF Defined( useFastIni )}
  ,FastIniFiles
{$ELSEIF Defined( useRegistryIni )}
  ,Registry
{$ELSE}
  ,IniFiles
{$IFEND}
  {$IFDEF useTLH_Math}, uTLH.Math{$ENDIF}
  {$IFDEF useMATHROUT}, MathRout{$ENDIF}
  {$IFDEF CriticalSections}, SyncObjs{$ENDIF}
  ;

type
  TKeyPressEvent = procedure( Sender: TObject; var Key: Char ) of object;
{$IF Defined( useFastIni )}
  TIniFileType = TFIniFile;
{$ELSEIF Defined( useMemIni )}
  TIniFileType = TMemIniFile;
{$ELSEIF Defined( useRegistryIni )}
  TIniFileType = TRegistryIniFile;
{$ELSE}
  TIniFileType = TIniFile;
{$IFEND}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
type
  TOnKeyPressMode_ = ( kpmString, kpmSigned, kpmUnsigned, kpmFloat, kpmFloatUnsigned, kpmExtended, kpmExtendedUnsigned, kpmDateTime, kpmHex, kpmHexBigEndian, kpmDirectoryOrFileName, kpmAlpha, kpmAlphaNumeric );

  T_INI_DATEI = class;

  tHighLightBackup = Record
    Color       : TColor;
    Hint        : String;
    ParentFont  : boolean;
    ParentColor : boolean;
    Inited      : boolean;
    end;

  T_PARAM_BASE = class
  end;
  P_PARAM_BASE = ^T_PARAM_BASE;  

  T_PARAM_ALLGEMEIN = class( T_PARAM_BASE )
  private
    fSection         : string;
    fName            : string;
    originalOnChange : TNotifyEvent;
    fObject          : TObject;
    fChanged         : Boolean;
    fOwner           : T_INI_DATEI;
    fLoaded          : Boolean;
    HighLight        : tHighLightBackup;
    {$IFDEF CriticalSections}
    fCrit            : TCriticalSection;
    {$ENDIF}
    Procedure   OnChange( Sender: TObject );
    function    GetNoVCL : boolean;
    function    GetID : Integer;
    function    ValueExists( IniFile : TIniFileType; const Section, Ident: string ) : boolean;
    function    IsMyObject( aObject : TObject ) : Boolean;
    {$IFNDEF SetValueRaiseOnChange}
    Procedure   UnsetOnChange( var Method : System.TMethod );
    Procedure   ResetOnChange( Method : System.TMethod );
    {$ENDIF}
    procedure   OnKeyPressCheckChar( Sender: TObject; var Key: Char; vMode : TOnKeyPressMode_ );
    function    MethodIsEqual( const MethodPointer1, MethodPointer2 ) : Boolean;
    function    VCLAccessAllowed : Boolean;
    procedure   Save;    
  public
    constructor Create( AOwner : T_INI_DATEI; iniSection: string; iniName: string; vObject: TObject = nil );
    destructor  Destroy; override;
    procedure   Assign( Param : T_PARAM_ALLGEMEIN );
    property    Changed : boolean     read fChanged default False;
    property    Owner   : T_INI_DATEI read fOwner;
    property    NoVCL   : boolean     read GetNoVCL;
    property    Name    : string      read fName;
    property    Section : string      read fSection;
    property    ID      : Integer     read GetID;
  end;
  P_PARAM_ALLGEMEIN = ^T_PARAM_ALLGEMEIN;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  T_PARAM_INT = class( T_PARAM_ALLGEMEIN )
  private
    fMinimum           : integer;
    fMaximum           : integer;
    fDefault           : integer;
    fValue             : integer;
    fBackupValue       : integer;
    originalOnExit     : TNotifyEvent;
    originalOnKeyPress : TKeyPressEvent;
    Procedure   CheckGrenzwerte( Sender:TObject );
    Procedure   EditIntZahlKeyPress( Sender:TObject; var Key:char );
    function    GetValue : Integer;
    Procedure   SetValue( Value: Integer );
    procedure   Load;
    function    Save : string;
  public
    Constructor Create( AOwner : T_INI_DATEI; iniSection: string; def, min, max: integer; iniName: string; vObject: TObject = nil );
    destructor  Destroy; override;
    procedure   Assign( Param : T_PARAM_ALLGEMEIN );
    procedure   VCLToValue;
    procedure   ValueToVCL;
    property    Wert   : integer read GetValue write SetValue;
    property    Default: Integer read fDefault write fDefault;
    property    Minimum: Integer read fMinimum write fMinimum;
    property    Maximum: Integer read fMaximum write fMaximum;
    end;
  P_PARAM_INT = ^T_PARAM_INT;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  T_PARAM_INT64 = class( T_PARAM_ALLGEMEIN )
  private
    fMinimum           : Int64;
    fMaximum           : Int64;
    fDefault           : Int64;
    fValue             : Int64;
    fBackupValue       : Int64;
    originalOnExit     : TNotifyEvent;
    originalOnKeyPress : TKeyPressEvent;
    Procedure   CheckGrenzwerte( Sender:TObject );
    Procedure   EditIntZahlKeyPress( Sender:TObject; var Key:char );
    function    GetValue : Int64;
    Procedure   SetValue( Value: Int64 );
    procedure   Load;
    function    Save : string;
  public
    Constructor Create( AOwner : T_INI_DATEI; iniSection: string; def, min, max: Int64; iniName: string; vObject: TObject = nil );
    destructor  Destroy; override;
    procedure   Assign( Param : T_PARAM_ALLGEMEIN );
    procedure   VCLToValue;
    procedure   ValueToVCL;
    property    Wert   : Int64 read GetValue write SetValue;
    property    Default: Int64 read fDefault write fDefault;
    property    Minimum: Int64 read fMinimum write fMinimum;
    property    Maximum: Int64 read fMaximum write fMaximum;
    end;
  P_PARAM_INT64 = ^T_PARAM_INT64;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  T_PARAM_NR = class( T_PARAM_ALLGEMEIN )
  private
    fDefault      : integer;
    fValue        : integer;
    fBackupValue  : integer;
    function    GetValue : Integer;
    Procedure   SetValue( Value: Integer );
    procedure   Load;
    function    Save : string;
  public
    Constructor Create( AOwner : T_INI_DATEI; iniSection: string; def: integer; iniName: string; vObject: TObject = nil );
    procedure   Assign( Param : T_PARAM_ALLGEMEIN );
    procedure   VCLToValue;
    procedure   ValueToVCL;
    property    Wert   : integer read GetValue write SetValue;
    property    Default: Integer read fDefault write fDefault;
    end;
  P_PARAM_NR = ^T_PARAM_NR;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  T_PARAM_REAL = class( T_PARAM_ALLGEMEIN )
  private
    fDecimalPlaces     : Byte;
    fMinimum           : double;
    fMaximum           : double;
    fDefault           : double;
    fValue             : double;
    fBackupValue       : double;
    originalOnExit     : TNotifyEvent;
    originalOnKeyPress : TKeyPressEvent;
    Procedure   CheckGrenzwerte( Sender:TObject );
    Procedure   EditFloatZahlKeyPress( Sender:TObject; var Key:char );
    function    GetValue : double;
    Procedure   SetValue( Value: double );
    procedure   Load;
    function    Save : string;
    procedure   SetDecimalPlaces( Value : Byte );
  public
    Constructor Create( AOwner : T_INI_DATEI; iniSection: string; def, min, max: double; iniName: string; vObject: TObject = nil );
    destructor  Destroy; override;
    procedure   Assign( Param : T_PARAM_ALLGEMEIN );
    procedure   VCLToValue;
    procedure   ValueToVCL;
    property    Wert          : double read GetValue       write SetValue;
    property    Default       : Double read fDefault       write fDefault;
    property    Minimum       : Double read fMinimum       write fMinimum;
    property    Maximum       : Double read fMaximum       write fMaximum;
    property    DecimalPlaces : Byte   read fDecimalPlaces write SetDecimalPlaces;
    end;
  P_PARAM_REAL = ^T_PARAM_REAL;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  T_PARAM_BOOL = class( T_PARAM_ALLGEMEIN )
  private
    fDefault     : Boolean;
    fValue       : Boolean;
    fBackupValue : Boolean;
    function    GetValue : Boolean;
    Procedure   SetValue( Value: Boolean );
    procedure   Load;
    function    Save : string;
  public
    Constructor Create( AOwner : T_INI_DATEI; iniSection: string; def: Boolean; iniName: string; vObject: TObject = nil );
    procedure   Assign( Param : T_PARAM_ALLGEMEIN );
    procedure   VCLToValue;
    procedure   ValueToVCL;
    property    Wert   : Boolean read GetValue write SetValue;
    property    Default: boolean read fDefault write fDefault;
    end;
  P_PARAM_BOOL = ^T_PARAM_BOOL;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  T_PARAM_ROI = class( T_PARAM_BASE )
  private
    function    IsMyObject( aObject : TObject ) : Boolean;
    {$IFDEF useTLH_Math}
    function    GetValue : tERect;
    Procedure   SetValue( Value: tERect );
    {$ENDIF}    
    {$IF Defined( useMATHROUT ) OR Defined( useTLH_Math )}
    function    GetTopLeft : TYP_ePunkt;
    Procedure   SetTopLeft( Value: TYP_ePunkt );
    function    GetTopRight : TYP_ePunkt;
    Procedure   SetTopRight( Value: TYP_ePunkt );
    function    GetBottomLeft : TYP_ePunkt;
    Procedure   SetBottomLeft( Value: TYP_ePunkt );
    function    GetBottomRight : TYP_ePunkt;
    Procedure   SetBottomRight( Value: TYP_ePunkt );
    {$IFEND}
  public
    x1 : T_PARAM_INT;
    y1 : T_PARAM_INT;
    x2 : T_PARAM_INT;
    y2 : T_PARAM_INT;
    Constructor Create( AOwner : T_INI_DATEI; iniSection: string; minX, minY, maxX, maxY: Integer; iniName: string; editX1 : TObject = nil; editY1 : TObject = nil; editX2 : TObject = nil; editY2: TObject = nil );
    destructor  Destroy; override;
    procedure   Assign( Param : T_PARAM_ROI );
    function    GetSection : String;
    procedure   Load;
    function    Save : String;
    {$IFDEF useTLH_Math}
    property    Wert        : tERect     read GetValue       write SetValue;
    {$ENDIF}
    {$IF Defined( useMATHROUT ) OR Defined( useTLH_Math )}
    property    TopLeft     : TYP_ePunkt read GetTopLeft     write SetTopLeft;
    property    TopRight    : TYP_ePunkt read GetTopRight    write SetTopRight;
    property    BottomLeft  : TYP_ePunkt read GetBottomLeft  write SetBottomLeft;
    property    BottomRight : TYP_ePunkt read GetBottomRight write SetBottomRight;
    {$IFEND}
    property    Section     : String     read GetSection;
    procedure   VCLToValue;
    procedure   ValueToVCL;
    end;
  P_PARAM_ROI = ^T_PARAM_ROI;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  T_PARAM_AOI = class( T_PARAM_BASE )
  private
    function    IsMyObject( aObject : TObject ) : Boolean;
    {$IFDEF useTLH_Math}
    function    GetValue : tERect;
    Procedure   SetValue( Value: tERect );
    {$ENDIF}
    {$IF Defined( useMATHROUT ) OR Defined( useTLH_Math )}
    function    GetTopLeft : TYP_ePunkt;
    Procedure   SetTopLeft( Value: TYP_ePunkt );
    function    GetTopRight : TYP_ePunkt;
    Procedure   SetTopRight( Value: TYP_ePunkt );
    function    GetBottomLeft : TYP_ePunkt;
    Procedure   SetBottomLeft( Value: TYP_ePunkt );
    function    GetBottomRight : TYP_ePunkt;
    Procedure   SetBottomRight( Value: TYP_ePunkt );
    {$IFEND}
    function    GetDecimalPlaces : Byte;
    procedure   SetDecimalPlaces( Value : Byte );
    function    GetSection : String;
    procedure   Load;
    function    Save : String;
  public
    TopLeftX, TopLeftY         : T_PARAM_REAL;
    TopRightX, TopRightY       : T_PARAM_REAL;
    BottomLeftX, BottomLeftY   : T_PARAM_REAL;
    BottomRightX, BottomRightY : T_PARAM_REAL;
    Constructor Create( AOwner : T_INI_DATEI; iniSection: string; minX, minY, maxX, maxY: Double; iniName: string; editTopLeftX : TObject = nil; editTopLeftY : TObject = nil; editTopRightX : TObject = nil; editTopRightY : TObject = nil; editBottomLeftX : TObject = nil; editBottomLeftY : TObject = nil; editBottomRightX : TObject = nil; editBottomRightY : TObject = nil );
    destructor  Destroy; override;
    procedure   Assign( Param : T_PARAM_AOI );
    {$IFDEF useTLH_Math}
    property    Wert          : tERect     read GetValue         write SetValue;
    {$ENDIF}
    {$IF Defined( useMATHROUT ) OR Defined( useTLH_Math )}
    property    TopLeft       : TYP_ePunkt read GetTopLeft       write SetTopLeft;
    property    TopRight      : TYP_ePunkt read GetTopRight      write SetTopRight;
    property    BottomLeft    : TYP_ePunkt read GetBottomLeft    write SetBottomLeft;
    property    BottomRight   : TYP_ePunkt read GetBottomRight   write SetBottomRight;
    {$IFEND}
    property    Section       : String     read GetSection;
    property    DecimalPlaces : Byte       read GetDecimalPlaces write SetDecimalPlaces;
    procedure   VCLToValue;
    procedure   ValueToVCL;
    end;
  P_PARAM_AOI = ^T_PARAM_AOI;

{$IF Defined( useMATHROUT ) OR Defined( useTLH_Math )}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  T_PARAM_ePunkt = class( T_PARAM_ALLGEMEIN )
  private
    fDefault            : Typ_ePunkt;
    fObjectY            : TObject;
    fValue              : Typ_ePunkt;
    fBackupValue        : Typ_ePunkt;
    originalOnChangeY   : TNotifyEvent;
    originalOnKeyPressX,
    originalOnKeyPressY : TKeyPressEvent;
    HighLightY          : tHighLightBackup;
    Procedure   EditFloatZahlKeyPress( Sender:TObject; var Key:char );
    function    GetValue : Typ_ePunkt;
    Procedure   SetValue( Value: Typ_ePunkt );
    function    IsMyObject( aObject : TObject ) : Boolean; reintroduce;
    procedure   Load;
    function    Save : string;
  public
    Constructor Create( AOwner : T_INI_DATEI; iniSection: string; defX, defY: double; iniName: string; editX : TObject = nil; editY : TObject = nil ); overload;
    Constructor Create( AOwner : T_INI_DATEI; iniSection: string; def: TYP_ePunkt; iniName: string; editX : TObject = nil; editY : TObject = nil ); overload;
    destructor  Destroy; override;
    procedure   Assign( Param : T_PARAM_ALLGEMEIN );
    procedure   VCLToValue;
    procedure   ValueToVCL;
    property    Wert   : Typ_ePunkt read GetValue write SetValue;
    property    Default: Typ_ePunkt read fDefault write fDefault;
    end;
  P_PARAM_ePUNKT = ^T_PARAM_ePunkt;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  T_PARAM_eGerade = class( T_PARAM_ALLGEMEIN )
  private
    fDefault            : Typ_eGerade;
    fObjectNY           : TObject;
    fObjectC            : TObject;
    fValue              : Typ_eGerade;
    fBackupValue        : Typ_eGerade;
    originalOnChangeY,
    originalOnChangeC   : TNotifyEvent;
    originalOnKeyPressX,
    originalOnKeyPressY,
    originalOnKeyPressC : TKeyPressEvent;
    HighLightY          : tHighLightBackup;
    HighLightC          : tHighLightBackup;
    Procedure   EditFloatZahlKeyPress( Sender:TObject; var Key:char );
    function    GetValue : Typ_eGerade;
    Procedure   SetValue( Value: Typ_eGerade );
    function    IsMyObject( aObject : TObject ) : Boolean; reintroduce;
    procedure   Load;
    function    Save : string;
  public
    Constructor Create( AOwner : T_INI_DATEI; iniSection: string; defNX, defNY, defC : double; iniName: string; editNX : TObject = nil; editNY: TObject = nil; editC : TObject = nil ); overload;
    Constructor Create( AOwner : T_INI_DATEI; iniSection: string; def : Typ_eGerade; iniName: string; editNX : TObject = nil; editNY: TObject = nil; editC : TObject = nil ); overload;
    destructor  Destroy; override;
    procedure   Assign( Param : T_PARAM_ALLGEMEIN );
    procedure   VCLToValue;
    procedure   ValueToVCL;
    property    Wert   : Typ_eGerade read GetValue write SetValue;
    property    Default: Typ_eGerade read fDefault write fDefault;
    end;
  P_PARAM_eGerade = ^T_PARAM_eGerade;
{$IFEND}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  T_PARAM_STR = class( T_PARAM_ALLGEMEIN )
  private
    fDefault     : String;
    fValue       : string;
    fBackupValue : string;
    fPassword    : Boolean;
    fIsPath      : Boolean;
    function    GetValue : string;
    Procedure   SetValue( Value: String );
    function    CheckPath( var Value : string; Changed : PBoolean = nil ) : boolean;
    procedure   Load;
    function    Save : string;
  public
    Constructor Create( AOwner : T_INI_DATEI; iniSection: string; Default: string; iniName: string; vObject: TObject = nil; IsPath : boolean = false );
    procedure   Assign( Param : T_PARAM_ALLGEMEIN );
    procedure   VCLToValue;
    procedure   ValueToVCL;
    property    Wert   : String read GetValue write SetValue;
    property    Default: string read fDefault write fDefault;
    end;
  P_PARAM_STR = ^T_PARAM_STR;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  T_PARAM_STR_LIST = class( T_PARAM_ALLGEMEIN )
  private
    originalOnExit : TNotifyEvent;
    fValue         : TStringList;
    fBackupValue   : TStringList;
    function    GetValue : TStringList;
    Procedure   SetValue( StrL: TStringList );
    procedure   Load;
    function    Save : string;
  public
    Constructor Create( AOwner : T_INI_DATEI; iniSection: string; vObject: TObject = nil );
    destructor  Destroy; override;
    procedure   Assign( Param : T_PARAM_ALLGEMEIN );
    procedure   VCLToValue;
    procedure   ValueToVCL;
    property    Wert   : TStringList read GetValue write SetValue;
    end;
  P_PARAM_STR_LIST = ^T_PARAM_STR_LIST;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  T_INI_DATEI = Class
  private
    fIniFile     : TIniFileType;
    {$IF NOT Defined( useMemIni ) AND NOT Defined( useFastIni ) }
    fValueExists : TStringList;
    {$IFEND}
    fFileName    : string;
    fSection     : string;  // aktuell eingestellte Ini-Datei Sektion
    fInited      : Boolean;
    fNoVCL       : Boolean;
    fHighlighted : Boolean;
    fCount       : Integer;
    function    GetID( Param : T_PARAM_BASE ): Integer;
    Function    GetItemPointer( ID : Cardinal ) : P_PARAM_BASE;
    Function    GetItem( ID : Cardinal ) : T_PARAM_BASE;
//    procedure   SetItem( ID : Cardinal; Value : T_PARAM_BASE );
    {$IF CompilerVersion >= 18}
    function    GetParameterName( ID : Cardinal ) : string;
    {$IFEND}
    function    GetChanged : boolean;
    procedure   BackupLog( val : string );
    function    IsComponentInUse( vObject: TObject ) : boolean;
    function    GetIsAllDefault : boolean;
    function    GetInited : boolean;
    Procedure   SetFileName( Value: string );
    function    HasVCL : Boolean;
  public
    Constructor Create( pfad_datname: string );
    destructor  Destroy; override;
    procedure   Assign( Source: T_INI_DATEI );

    Procedure   OpenIniDatei;
    Function    CloseIniDatei: boolean;
    Procedure   SetzteSection( sectionName: string );
    Procedure   SectionLoeschen( sectionName: string );
    Procedure   ListBackups;
    procedure   Reload;
    procedure   VCLToValue;
    procedure   ValueToVCL;

    Function    ParameterUebernehmen( save: boolean = false; logging : boolean = false; vCleanUp : boolean = false; UserName : String = ''; Comment : String = ''; MasterBackup : boolean = false{$IFDEF AutoBackup}; NoAutoBackup : boolean = false{$ENDIF} ): integer;

    function    HighlightChangedValues( showOldValuesAsHint : Boolean = false ): Cardinal; overload;
    function    HighlightChangedValues( FileName : string; showOldValuesAsHint : Boolean = false ): Cardinal; overload;
    procedure   UnHighlightChangedValues;    
    function    Compare( FileName : string; ColorObjects : boolean = false; showOldValuesAsHint : Boolean = false; StrL : TStringList = nil ): Cardinal; overload;
    function    Compare( params : T_INI_DATEI = NIL; ColorObjects : boolean = false; showOldValuesAsHint : Boolean = false; StrL : TStringList = nil ): Cardinal; overload;

    property    Werte_geandert         : boolean       read GetChanged;
    property    Dateiname              : string        read fFileName         write SetFileName;
    property    NoVCL                  : boolean       read fNoVCL            write fNoVCL Default false;
    property    IsDefault              : boolean       read GetIsAllDefault;
    property    Inited                 : boolean       read GetInited;

    // Instance-Items
    property    Count                  : Integer       read fCount;
    property    Items[ ID : Cardinal ] : T_PARAM_BASE  read GetItem;          {write  SetItem;} default;
    {$IF CompilerVersion >= 18}
    property    Names[ ID : Cardinal ] : string        read GetParameterName;
    {$IFEND}

    // Init/Create
    Procedure   Init_IntParam( var param : T_PARAM_INT; def, min, max: integer; iniName: string; vObject: TObject = nil );
    Procedure   Init_Int64Param( var param : T_PARAM_INT64; def, min, max: Int64; iniName: string; vObject: TObject = nil );
    Procedure   Init_NrParam( var param : T_PARAM_NR;  def: integer; iniName: string; vObject: TObject = nil );
    Procedure   Init_RealParam( var param : T_PARAM_REAL;def, min, max: double; iniName: string; vObject: TObject = nil );
    {$IF Defined( useMATHROUT ) OR Defined( useTLH_Math )}
    Procedure   Init_ePunktParam( var param : T_PARAM_ePunkt; defX, defY: double; iniName: string; editX : TObject = nil; editY : TObject = nil );
    Procedure   Init_eGeradeParam( var param : T_PARAM_eGerade; defNX, defNY, defC : double; iniName: string; editNX : TObject = nil; editNY : TObject = nil; editC : TObject = nil );
    {$IFEND}
    Procedure   Init_BoolParam( var param : T_PARAM_BOOL;def: boolean; iniName: string; vObject : TObject = nil );
    Procedure   Init_ROIParam( var param : T_PARAM_ROI; minX, minY, maxX, maxY: Integer; iniName: string; editX1 : TObject = nil; editY1 : TObject = nil; editX2 : TObject = nil; editY2 : TObject = nil );
    Procedure   Init_AOIParam( var param : T_PARAM_AOI; minX, minY, maxX, maxY: Integer; iniName: string; editTopLeftX : TObject = nil; editTopLeftY : TObject = nil; editTopRightX : TObject = nil; editTopRightY : TObject = nil; editBottomLeftX : TObject = nil; editBottomLeftY : TObject = nil; editBottomRightX : TObject = nil; editBottomRightY : TObject = nil );
    Procedure   Init_StrParam( var param : T_PARAM_STR; def: string; iniName: string; vObject : TObject = nil; IsPath : boolean = false );
    Procedure   Init_StrListParam( var param : T_PARAM_STR_LIST; fSection: string; vObject : TObject = nil );
  end;
  P_INI_DATEI = ^T_INI_DATEI;  

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TFrmParameterBackup = class(TForm)
    lblFileName: TLabel;
    lblText: TLabel;
    lblAction: TLabel;
    btnIgnore: TButton;
    grpBackups: TGroupBox;
    cbbBackups: TComboBox;
    btnLoadDifferent: TButton;
    btnCompare: TButton;
    mmoCompare: TMemo;
    procedure btnLoadDifferentClick(Sender: TObject);
    procedure cbbBackupsOnChange(Sender : TObject);
    procedure btnCompareClick(Sender: TObject);
  private
    { Private-Deklarationen }
    fSender   : T_INI_DATEI;
    fFilePath : String;
  public
    { Public-Deklarationen }
    constructor CreateNew( AOwner: TComponent ); reintroduce;
    function Execute( Sender : T_INI_DATEI; MD5Fail : boolean = True ) : string;
    function ExecuteAndLoad( Sender : T_INI_DATEI ) : string;
  end;

var
  FrmParameterBackup: TFrmParameterBackup;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
type
  tParameterSynchronizer = class
  private
    fIni     : TIniFileType;
    fLog     : TStringList;
    fStrL    : TStringList;    
    fLogging : Boolean;
  public
    function    Open( FileName : string; Logging : boolean = false ) : boolean;
    function    Close : boolean;
    function    Update( Parameter : T_INI_DATEI; Section : string; Create : boolean = false ) : boolean; overload;
    function    Update( Parameter : T_PARAM_BASE; Create : boolean = false ) : boolean; overload;
    constructor Create;
    destructor  Destroy; override;
  end;

var
  ParameterSynchronizer : tParameterSynchronizer;

const
  PARAMETER_LOGDATEI_EXT_                     = 'log';  

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
{$IFDEF MD5}
{$IF Defined(INDY90) OR Defined(INDY100)}
function GetMD5( const StrL : TStringList ) : string;
{$IFEND}
{$ENDIF}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
implementation

uses
  TypInfo, StrUtils, Windows, Dialogs, Controls
  {$IF CompilerVersion >= 18},Rtti{$IFEND}
  {$IFDEF JVCL},JvSpin{$ENDIF} // JvTimeEdit
{$IFDEF MD5}
  {$IF Defined(INDY90) OR Defined(INDY100)},IdHashMessageDigest{$IFEND} // MD5 - Indy9/10
{$ENDIF}
  ;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
const
  PASSWORT_VERSCHLUESSELUNGS_WERT_            = 31;
  PASSWORT_SPEICHERLAENGE_                    = 20;//Anzahl Zeichen in Datei ( mit "PASSWORT_AUFFUELL_ZEICHEN_" aufgefüllt )

  PARAMETER_LOGDATEI_MAX_LINES_               = 1000;
  PARAMETER_MAX_SAVE_ATTEMP_                  = 5;
  {$IFDEF AutoBackup}
  PARAMETER_MAX_BACKUPS_                      = 10;
  {$ENDIF}
  DEFAULT_SECTION_                   : string = 'Verschiedene Parameter';

  EPUNKT_SUB_EXTENSION_1_            : string = '.X';
  EPUNKT_SUB_EXTENSION_2_            : string = '.Y';
  EGERADE_SUB_EXTENSION_1_           : string = '.NX';
  EGERADE_SUB_EXTENSION_2_           : string = '.NY';
  EGERADE_SUB_EXTENSION_3_           : string = '.C';

  PARAMETER_BackupCaption_           : string = 'BackupList';
  PARAMETER_BackupText_              : string = 'BackupList for: ';
  PARAMETER_BackupActionLabel_       : string = 'Action:';
  PARAMETER_BackupButtonCaption_     : string = '&Cancel';
  PARAMETER_BackupFailCaption_       : string = 'MD5 Missmatch';
  PARAMETER_BackupFailText_          : string = 'MD5 check failed for: ';
  PARAMETER_BackupFailButtonCaption_ : string = '&Ignore';
  PARAMETER_BackupButtonLoad_        : string = '&Load';
  PARAMETER_BackupButtonCompare_     : string = 'C&ompare';

  LOG_FORMAT_                        : string = '[ %s ] %s';
  LOG_INTEGER_                       : string = '%s: %s from %d to %d';
  LOG_STRING_                        : string = '%s: %s from "%s" to "%s"';
  LOG_PASSWORD_1_                    : string = 'Password: %s';
  LOG_PASSWORD_2_                    : string = 'Passwort: %s was changed';
  LOG_REAL_                          : string = 'Real: %s from %.8f to %.8f';
  {$IF Defined( useMATHROUT ) OR Defined( useTLH_Math )}
  LOG_EPUNKT_                        : string = 'EPunkt: %s from X/Y %.8f/%.8f to %.8f/%.8f';
  LOG_EGERADE_                       : string = 'EGerade: %s from NX/NY/C %.8f/%.8f/%.8f to %.8f/%.8f/%.8f';
  {$IFEND}
  LOG_BACKUP_                        : string = 'Loaded BackUp: %s';
  LOG_USERNAME_                      : string = 'UserName: %s';
  LOG_COMMENT_                       : string = 'Comment: %s';

  BEAUTIFIED_NAME_NR_                : string = 'Nr';
  BEAUTIFIED_NAME_BOOL_              : string = 'Boolean';
  BEAUTIFIED_NAME_INT_               : string = 'Integer';
  BEAUTIFIED_NAME_INT64_             : string = 'Int64';
  BEAUTIFIED_NAME_REAL_              : string = 'Real';
  BEAUTIFIED_NAME_STR_               : string = 'String';
  BEAUTIFIED_NAME_STR_LIST_          : string = 'StringList';
  BEAUTIFIED_NAME_ROI_               : string = 'ROI';
  BEAUTIFIED_NAME_AOI_               : string = 'AOI';
  BEAUTIFIED_NAME_ePunkt_            : string = 'EPunkt';
  BEAUTIFIED_NAME_eGerade_           : string = 'EGerade';

  ERROR_NOT_INITIALIZED_1_           : string = #13#10 + '    Fehler bei Init / Laden der Datei:' + #13#10;
  ERROR_NOT_INITIALIZED_2_           : string = '    "%s" (Typ: %s)' + #13#10;
  ERROR_NOT_INITIALIZED_3_           : string = '    %d Wert(e) wurde(n) nicht initialisiert:' + #13#10;
  ERROR_NOT_INITIALIZED_ITEM_1_      : string = '%s      %d (%s), ' + #13#10;
  EEROR_NOT_INITIALIZED_ITEM_2_      : string = 'nach "%s" (%s)';
  ERROR_NOT_INITIALIZED_ITEM_3_      : string = '%s      %d, ' + #13#10;
  ERROR_NOT_INITIALIZED_ITEM_4_      : string = '%s      %s, ' + #13#10;
  ERROR_RECORD_ENUMERATION_1_        : string = #13#10 + '    Fehler bei Recordenumeration:' + #13#10;
  ERROR_RECORD_ENUMERATION_2_        : string = '    "%s" (Typ: %s)' + #13#10;
  ERROR_WRONG_PROPERTY_1_            : string = #13#10#13#10 + 'Fehler bei "%s.Create":' + #13#10;
  ERROR_WRONG_PROPERTY_2_            : string = 'Für Parameter vom Typ "%s" sind nur' + #13#10;
  ERROR_WRONG_PROPERTY_3_            : string = 'Objekttypen mit %sProperty erlaubt!'+ #13#10#13#10;
  ERROR_DUPE_CHECK_                  : string = #13#10 + '%s: %s (%s) is using an already used VCL-Object (%s)' + #13#10;
  ERROR_CHECKSUM_MISMATCH_           : string = 'Failed loading: %s (MD5 mismatch)';
  ERROR_BACKUP_CLEANUP_              : string = 'BackupCleanup failed on file:'+ #13#10 + '%s' + #13#10#13#10 + '%s';
  ERROR_NO_BACKUP_SELECTED_          : string = 'You need to select a backup!';
  ERROR_FILE_IN_USE_                 : string = 'Error: Unable to Save to File: "%s". It''s currently in use by another Process.';

  BACKUP_COMPARE_1_                  : string = 'Backup -> Current';
  BACKUP_COMPARE_2_                  : string = '%s -> %s';
  COMPARE_NO_CHANGES_                : string = 'no changes';
  FIND_BACKUPS_FORMAT_               : string = '%s (%s)';
  FIND_BACKUPS_FORMAT_NOSTATE_       : string = '%s';  
  FIND_BACKUPS_OK_                   : string = 'OK';
  FIND_BACKUPS_NOK_                  : string = 'NOK';
  FIND_BACKUPS_NONE_                 : string = '---';

  FILE_EXT_BACKUP_                            = '.bak';
  FILE_EXT_CHECKSUM_                          = '.md5';
  FILE_EXT_MASTER_                   : string = '%s_Master' + FILE_EXT_BACKUP_;
  FILE_EXT_MASTER_MD5_               : string = '_Master' + FILE_EXT_CHECKSUM_;

  FILE_FORMAT_MD5_                   : string = '%s *%s';

  PARAMETER_HIGHLIGHT_COLOR_CHANGED_ : TColor = clFuchsia;
  PARAMETER_HIGHLIGHT_HINT_TEXT_     : string = 'Old Value: ';

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function StrToFloat_Int( pText : string; default : Extended ): Extended;
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
      pText := StringReplace( pText, ',', '', [ rfIgnoreCase, rfReplaceAll ]);  //get rid of thousand incidental separators
      Break;
      end
    else if ( pText[ i ] = EUROPEAN_ST ) then
      begin
      IsEuropean := True;
      pText := StringReplace( pText, '.', '', [ rfIgnoreCase, rfReplaceAll ]);  //get rid of thousand incidental separators
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

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
constructor T_PARAM_ALLGEMEIN.Create( AOwner : T_INI_DATEI; iniSection: string; iniName: string; vObject: TObject = nil );
var
  Notify : TNotifyEvent;
  Method : System.TMethod absolute Notify;
{$IFDEF DUPECHECK}
  ObjName : string;
{$ENDIF}
begin
  {$IFDEF DUPECHECK}
  if AOwner.IsComponentInUse( vObject ) then
    begin
    ObjName := FIND_BACKUPS_NONE_;
    if IsPublishedProp( vObject, 'Name' ) then
      ObjName := GetPropValue( vObject, 'Name' );
    Raise Exception.Create( Format( ERROR_DUPE_CHECK_, [ ClassName, iniName, iniSection, objName ] ) );
    end;
  {$ENDIF}

  inherited Create;
  originalOnChange := nil;
  fChanged         := false;
  fOwner           := AOwner;
  fLoaded          := false;
  fObject          := vObject;

  Highlight.Color  := clWhite;
  HighLight.Hint   := '';
  HighLight.Inited := false;

  fSection         := Trim( iniSection );
  fName            := Trim( iniName );

  if Assigned( vObject ) then
    begin
    if IsPublishedProp( vObject, 'OnChange' ) then
      begin
      Method := GetMethodProp( vObject, 'OnChange' );
      if NOT MethodIsEqual( Method, originalOnChange ) then
        originalOnChange := Notify;
      Notify := OnChange;
      SetMethodProp( vObject, 'OnChange', Method );
      end
    else if IsPublishedProp( vObject, 'OnClick' ) then
      begin
      Method := GetMethodProp( vObject, 'OnClick' );
      if NOT MethodIsEqual( Method, originalOnChange ) then
        originalOnChange := Notify;
      Notify := OnChange;
      SetMethodProp( vObject, 'OnClick', Method );
      end;
    end;

  {$IFDEF CriticalSections}
  fCrit := TCriticalSection.Create;
  {$ENDIF}
end;

destructor T_PARAM_ALLGEMEIN.Destroy;
var
  Event  : TNotifyEvent;
  Method : System.TMethod absolute Event;
begin
  if Assigned( fObject ) then
    begin
    if ( NOT Application.Terminated ) then
      begin
      Event := originalOnChange;
      if IsPublishedProp( fObject, 'OnChange' ) then
        SetMethodProp( fObject, 'OnChange', Method )
      else if IsPublishedProp( fObject, 'OnClick' ) then
        SetMethodProp( fObject, 'OnClick', Method );
      end;
    fObject := nil;
    end;

  {$IFDEF CriticalSections}
  fCrit.free;
  {$ENDIF}

  inherited;
end;

procedure T_PARAM_ALLGEMEIN.Assign( Param : T_PARAM_ALLGEMEIN );
begin
  if NOT Assigned( Self ) then
    Exit;
  if NOT Assigned( Param ) then
    Exit;

  fSection         := Param.fSection;
  fName            := Param.fName;
  fChanged         := Param.fChanged;
  fOwner           := Param.fOwner;
  fLoaded          := Param.fLoaded;
  {$IFDEF ASSIGN_VCL}
  originalOnChange := Param.originalOnChange;
  fObject          := Param.fObject;
  HighLight        := Param.HighLight;
  {$ENDIF}
end;

Procedure T_PARAM_ALLGEMEIN.Save;
begin
  if NOT Assigned( self ) then
    Exit;
  fChanged := false;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Procedure T_PARAM_ALLGEMEIN.OnChange( Sender:TObject );
begin
  if NOT Assigned( self ) then
    Exit;

  if fOwner.fInited then
    fChanged := True;

  if Assigned( originalOnChange ) then
    originalOnChange( Sender );  
end;

function T_PARAM_ALLGEMEIN.GetNoVCL : boolean;
begin
  result := false;
  if NOT Assigned( self ) then
    Exit;
  if NOT Assigned( Owner ) then
    Exit;

  result := Owner.NoVCL;
end;

function T_PARAM_ALLGEMEIN.GetID : Integer;
begin
  result := -1;
  if NOT Assigned( self ) then
    Exit;
  if NOT Assigned( Owner ) then
    Exit;

  result := Owner.GetID( self );
end;

function T_PARAM_ALLGEMEIN.ValueExists( IniFile : TIniFileType; const Section, Ident: string ) : boolean;
begin
  result := false;
  if NOT Assigned( IniFile ) then
    Exit;
  if ( Section = '' ) OR ( Ident = '' ) then
    Exit;

  {$IF Defined( useMemIni ) OR Defined( useFastIni ) }
  result := IniFile.ValueExists( Section, Ident );
  {$ELSE}
  if Assigned( Owner.fValueExists ) then
    begin
    if ( Owner.fValueExists.Count > 0 ) then
      result := ( Owner.fValueExists.IndexOf( Ident ) > -1 )
    else
      result := IniFile.ValueExists( Section, Ident );
    end
  else
    result := IniFile.ValueExists( Section, Ident );
  {$IFEND}
end;

function T_PARAM_ALLGEMEIN.IsMyObject( aObject : TObject ) : Boolean;
begin
  result := false;
  if NOT Assigned( Self ) then
    Exit;

  result := ( fObject = aObject );
end;

{$IFNDEF SetValueRaiseOnChange}
Procedure T_PARAM_ALLGEMEIN.UnsetOnChange( var Method : System.TMethod );
var
  tNotify : TNotifyEvent;
  tMethod : System.TMethod absolute tNotify;
begin
  if IsPublishedProp( fObject, 'OnClick' ) then
    begin
    Method := GetMethodProp( fObject, 'OnClick' );
    tNotify := nil;
    SetMethodProp( fObject, 'OnClick', tMethod );
    end
  else if IsPublishedProp( fObject, 'OnChange' ) then
    begin
    Method := GetMethodProp( fObject, 'OnChange' );
    tNotify := nil;
    SetMethodProp( fObject, 'OnChange', tMethod );
    end;
end;

Procedure T_PARAM_ALLGEMEIN.ResetOnChange( Method : System.TMethod );
begin
  if IsPublishedProp( fObject, 'OnClick' ) then
    SetMethodProp( fObject, 'OnClick', Method )
  else if IsPublishedProp( fObject, 'OnChange' ) then
    SetMethodProp( fObject, 'OnChange', Method );
end;
{$ENDIF}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure T_PARAM_ALLGEMEIN.OnKeyPressCheckChar( Sender: TObject; var Key: Char; vMode : TOnKeyPressMode_ );
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
//    else if ( Sender is TStringGrid ) then
//      Text := TStringGrid( Sender ).Cells[ TStringGrid( Sender ).Col, TStringGrid( Sender ).Row ];
    end;
  // SelStart
  SelStart := 0;
  if ( Sender <> nil ) then
    begin
//    if ( Sender is TStringGrid ) then
//      SendMessage( GetWindow( TStringGrid( Sender ).Handle, GW_CHILD ), EM_GETSEL, WPARAM( @SelStart ),LPARAM( @SelEnd ) )
//    else
    if ( Sender is TWinControl ) then
      TWinControl( Sender ).Perform( {EM_GETSEL}$00B0, WPARAM( @SelStart ), LPARAM( @SelEnd ) );
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
    if NOT ( {$IF CompilerVersion >= 22}CharInSet( Key,{$ELSE}( Key in{$IFEND} [ 'a'..'f', 'A'..'F' ] ) ) then
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

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function T_PARAM_ALLGEMEIN.MethodIsEqual( const MethodPointer1, MethodPointer2 ): Boolean;
var
  Method1: System.TMethod absolute MethodPointer1;
  Method2: System.TMethod absolute MethodPointer2;
begin
  result := False;

  if ( Method1.Data = nil ) OR ( Method2.Data = nil ) then
    Exit;
  Result := ( Method1.Code = Method2.Code ) and ( Method1.Data = Method2.Data );
end;

function T_PARAM_ALLGEMEIN.VCLAccessAllowed : Boolean;
begin
  result := NOT Application.Terminated;
  if result AND Assigned( fObject ) then
    begin
    if ( fObject is TComponent ) then
      result := result and ( NOT ( csDestroying in TComponent( fObject ).ComponentState ) );
    end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//***  T_INI_DATEI  ************************************************************
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Procedure T_INI_DATEI.OpenIniDatei;
{$IFDEF MD5}
var
  StrL   : TStringList;
  MD5    : Array [0..1] of ShortString;
  BackUp : String;
{$ENDIF}
begin
  if NOT Assigned( self ) then
    Exit;
  if Assigned( fIniFile ) then
    exit;

  fInited             := false;
  fIniFile            := TIniFileType.Create( fFileName );
  {$IF NOT Defined( useMemIni ) AND NOT Defined( useFastIni ) }
  fValueExists        := TStringList.Create;
  {$IFEND}

  {$IFDEF MD5}
  MD5[ 0 ] := '';
  if FileExists( ChangeFileExt( fFileName, FILE_EXT_CHECKSUM_ ) ) then
    begin
    StrL := TStringList.Create;
    StrL.LoadFromFile( ChangeFileExt( fFileName, FILE_EXT_CHECKSUM_ ) );
    if ( StrL.Count = 0 ) then
      Exit;

    MD5[ 0 ] := Copy( StrL[0], 1, Pos( '*', StrL[0] )-2 );
    {$IFDEF useFastIni}
    fIniFile.GetStringList( StrL );
    {$ELSE}
    StrL.LoadFromFile( fFileName );
    {$ENDIF}
    MD5[ 1 ] := GetMD5( StrL );
    if ( MD5[ 1 ] <> MD5[ 0 ] ) then
      begin
      BackupLog( Format( ERROR_CHECKSUM_MISMATCH_, [ ExtractFileName( fFileName ) ] ) );

      BackUp := FrmParameterBackup.Execute( self, True );
      if LowerCase( fFileName ) = LowerCase( BackUp ) then // Ignore...
        begin
        StrL.Text := Format( FILE_FORMAT_MD5_, [ MD5[ 1 ], ExtractFileName( fFileName ) ] );
        try
          if FileExists( ChangeFileExt( fFileName, FILE_EXT_CHECKSUM_ ) ) then
            SysUtils.DeleteFile( ChangeFileExt( fFileName, FILE_EXT_CHECKSUM_ ) );
          StrL.SaveToFile( ChangeFileExt( fFileName, FILE_EXT_CHECKSUM_ ) );
        except
        end;
        end
      else
        begin
        fIniFile.free;
        fIniFile := TIniFileType.Create( BackUp );
        BackupLog( Format( LOG_BACKUP_, [ ExtractFileName( Backup ) ] ) );

        {$IFDEF useFastIni}
        fIniFile.Save( fFileName );
        {$ELSE}
        if FileExists( Backup ) then
          begin
          try
            if FileExists( fFileName ) then
              DeleteFile( PChar( fFileName ) );
            CopyFile( PChar( BackUp ), PChar( fFileName ), True );
          except
          end;
          end;
        {$ENDIF}

        // MD5
        {$IFDEF useFastIni}
        fIniFile.GetStringList( StrL );
        {$ELSE}
        StrL.LoadFromFile( fFileName );
        {$ENDIF}
        StrL.Text := Format( FILE_FORMAT_MD5_, [ GetMD5( StrL ), ExtractFileName( fFileName ) ] );
        try
          if FileExists( ChangeFileExt( fFileName, FILE_EXT_CHECKSUM_ ) ) then
            SysUtils.DeleteFile( ChangeFileExt( fFileName, FILE_EXT_CHECKSUM_ ) );
          StrL.SaveToFile( ChangeFileExt( fFileName, FILE_EXT_CHECKSUM_ ) );
        except
        end;
        end;
      end;
    StrL.free;
    end;
  {$ENDIF}
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Function T_INI_DATEI.CloseIniDatei: boolean;
{ Abschließen der Parameter -Definition.
  Hier wird jetzt kontrolliert, ob alle Parameter, die definiert sind,
  auch wirklich initialisiert worden sind.
  Fehlen welche, so wird hier eine Exception ausgelöst
}
var
  Cnt   : Integer;
  i     : Integer;
  S     : String;
  CP    : T_PARAM_BASE;
  LP    : T_PARAM_BASE;

  {$IF CompilerVersion >= 18}
  ctx   : TRttiContext;
  rType : TRttiType;
  rProp : TRttiField;
  PB    : PByte;
  P     : ^TObject absolute PB;
  {$IFEND}
begin
  result := false;
  if NOT Assigned( self ) then
    Exit;
  if Assigned( fIniFile ) then
    fIniFile.Free;
  fIniFile := nil;

  {$IF NOT Defined( useMemIni ) AND NOT Defined( useFastIni ) }
  if Assigned( fValueExists ) then
    fValueExists.free;
  fValueExists := nil;
  {$IFEND}

  S   := '';
  Cnt := 0;
  LP  := nil;
  for i := 0 to fCount-1 do
    begin
    CP := Items[ i ];
    if NOT Assigned( CP ) then
      begin
      if Assigned( LP ) then
        begin
        if ( LP is T_PARAM_ROI ) then
          S := Format( ERROR_NOT_INITIALIZED_ITEM_1_, [ S, i+1, Format( EEROR_NOT_INITIALIZED_ITEM_2_, [ T_PARAM_ROI( LP ).x1.fName, T_PARAM_ROI( LP ).x1.fSection ] ) ] )
        else if ( LP is T_PARAM_AOI ) then
          S := Format( ERROR_NOT_INITIALIZED_ITEM_1_, [ S, i+1, Format( EEROR_NOT_INITIALIZED_ITEM_2_, [ T_PARAM_AOI( LP ).TopLeftX.fName, T_PARAM_AOI( LP ).TopLeftX.fSection ] ) ] )
        else if ( LP is T_PARAM_ALLGEMEIN ) then
          S := Format( ERROR_NOT_INITIALIZED_ITEM_1_, [ S, i+1, Format( EEROR_NOT_INITIALIZED_ITEM_2_, [ T_PARAM_ALLGEMEIN( LP ).fName, T_PARAM_ALLGEMEIN( LP ).fSection ] ) ] )
        else
          begin
          Raise Exception.Create( ERROR_RECORD_ENUMERATION_1_ + Format( ERROR_RECORD_ENUMERATION_2_, [ fFileName, ClassName ] ) );
          Break;
          end;
        end
      else
        S := Format( ERROR_NOT_INITIALIZED_ITEM_3_, [ S, i+1 ] );
      end
    else
      begin
      LP := CP;
      Inc( Cnt );
      end;
    end;

  {$IFDEF INIT_CHECK}
  if ( fCount <> Cnt ) then
    begin
    {$IF CompilerVersion >= 18}
    ctx := TRttiContext.Create;
    rType := ctx.GetType( ClassInfo );
    S := '';

    for rProp in rType.GetFields do
      begin
      if ( rProp.Offset < ClassParent.InstanceSize-SizeOf( Pointer ) ) then
        break;

      PB := Pointer( self );
      Inc( PB, rProp.Offset );
      if ( P^ = nil ) then
        S := Format( ERROR_NOT_INITIALIZED_ITEM_4_, [ S, rProp.Name ] );
      end;
    ctx.Free;
    {$IFEND}

    Raise Exception.Create(         ERROR_NOT_INITIALIZED_1_ +
                            Format( ERROR_NOT_INITIALIZED_2_, [ fFileName, ClassName ] ) +
                            Format( ERROR_NOT_INITIALIZED_3_, [ fCount-Cnt ] ) +
                                    LeftStr( s, Length( s )-4 ) + #13#10 );
    end
  else
  {$ENDIF}
    fInited := True;
  result := True;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Function T_INI_DATEI.GetItemPointer( ID : Cardinal ) : P_PARAM_BASE;
var
  PB : PByte;
begin
  result := nil;
  if NOT Assigned( self ) then
    Exit;

  if ( Integer( ID ) > fCount-1 ) then
    Exit;

  PB := Pointer( self );
  Inc( PB, ClassParent.InstanceSize );
  {$IF CompilerVersion >= 18} // Actualy no clue which Version added the padding ..
  Dec( PB, SizeOf( Pointer ) );
  {$IFEND}

  Inc( PB, ID*SizeOf( Pointer ) );
  result := P_PARAM_BASE( PB );
end;

Function T_INI_DATEI.GetItem( ID : Cardinal ) : T_PARAM_BASE;
var
  P : P_PARAM_BASE;
begin
  result := nil;
  P := GetItemPointer( ID );
  if Assigned( P^ ) then
    result := P^;
end;

{
procedure T_INI_DATEI.SetItem( ID : Cardinal; Value : T_PARAM_BASE );
begin
  if NOT Assigned( Self ) then
    Exit;
  GetItemPointer( ID )^ := Value;
end;
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function BeautifyClassName( Param : T_PARAM_BASE ) : string;
begin
{
var
  i : Integer;
begin
  result := '';

  i := Pos( '_', Param.ClassName );
  if ( i < 0 ) then
    Exit;
  i := PosEx( '_', Param.ClassName, i+1 );
  if ( i < 0 ) then
    Exit;

  result := RightStr( Param.ClassName, Length( Param.ClassName ) - i );
}
  if ( Param is T_PARAM_NR ) then
    result := BEAUTIFIED_NAME_NR_
  else if ( Param is T_PARAM_BOOL ) then
    result := BEAUTIFIED_NAME_BOOL_
  else if ( Param is T_PARAM_INT ) then
    result := BEAUTIFIED_NAME_INT_
  else if ( Param is T_PARAM_INT64 ) then
    result := BEAUTIFIED_NAME_INT64_
  else if ( Param is T_PARAM_REAL ) then
    result := BEAUTIFIED_NAME_REAL_
  else if ( Param is T_PARAM_STR ) then
    result := BEAUTIFIED_NAME_STR_
  else if ( Param is T_PARAM_STR_LIST ) then
    result := BEAUTIFIED_NAME_STR_LIST_
  else if ( Param is T_PARAM_ROI ) then
    result := BEAUTIFIED_NAME_ROI_
  else if ( Param is T_PARAM_AOI ) then
    result := BEAUTIFIED_NAME_AOI_
  {$IF Defined( useMATHROUT ) OR Defined( useTLH_Math )}
  else if ( Param is T_PARAM_ePunkt ) then
    result := BEAUTIFIED_NAME_ePunkt_
  else if ( Param is T_PARAM_eGerade ) then
    result := BEAUTIFIED_NAME_eGerade_
  {$IFEND}
  else
    result := '';
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure T_INI_DATEI.UnHighlightChangedValues;
begin
  if NOT Assigned( self ) then
    Exit;
  if NOT fHighlighted then
    Exit;
  Compare( nil, false, false, nil );
  fHighlighted := false;
end;

function T_INI_DATEI.HighlightChangedValues( showOldValuesAsHint : Boolean = false ): Cardinal;
begin
  result := 0;
  if NOT Assigned( self ) then
    Exit;
  result := Compare( nil, True, showOldValuesAsHint, nil );
  fHighlighted := result <> 0;
end;

function T_INI_DATEI.HighlightChangedValues( FileName : string; showOldValuesAsHint : Boolean = false ): Cardinal;
begin
  result := 0;
  if NOT Assigned( self ) then
    Exit;
  result := Compare( FileName, True, showOldValuesAsHint, nil );
  fHighlighted := result <> 0;
end;

function T_INI_DATEI.Compare( FileName : string; ColorObjects : boolean = false; showOldValuesAsHint : Boolean = false; StrL : TStringList = nil ): Cardinal;
var
  params : T_INI_DATEI;
begin
  result := 0;
  if NOT Assigned( self ) then
    Exit;
  if NOT FileExists( FileName ) then
    Exit;

  params := T_INI_DATEI.Create( FileName );
  params.Assign( self );
  params.fFileName := FileName;
  params.Reload;

  result := Compare( params, ColorObjects, showOldValuesAsHint, StrL );
  params.free;
end;

type
  TColorWinControl = class(TWinControl)
     public
      property Color;
  end;
function T_INI_DATEI.Compare( params : T_INI_DATEI = NIL; ColorObjects : boolean = false; showOldValuesAsHint : Boolean = false; StrL : TStringList = nil ): Cardinal;
  procedure HighlightItem( vObject : TObject; var HighlightBak : tHighLightBackup; HL : boolean; Hint : Boolean; HintS : string );
  var
    FontObj : TObject;
  begin
    if NOT Assigned( self ) then
      Exit;
    if NOT Assigned( vObject ) then
      Exit;
    if NOT ( Windows.GetCurrentThreadId = System.MainThreadID ) then
      Exit;

    if ( vObject is TComponent ) then
      begin
      if ( csDestroying in TComponent( vObject ).ComponentState ) then
        Exit;
      end;

    if NOT HighlightBak.Inited then
      begin
      if IsPublishedProp( vObject, 'ParentColor' ) then
        HighlightBak.ParentColor := GetPropValue( vObject, 'ParentColor' );
      if IsPublishedProp( vObject, 'ParentFont' ) then
        HighlightBak.ParentFont := GetPropValue( vObject, 'ParentFont' );

      if ( vObject is TWinControl ) then
        HighlightBak.Color := TColorWinControl( vObject ).Color
      else if IsPublishedProp( vObject, 'Color' ) then
        HighlightBak.Color := GetPropValue( vObject, 'Color' )
      else if IsPublishedProp( vObject, 'Font' ) then
        begin
        FontObj := GetObjectProp( vObject, 'FONT' );
        HighlightBak.Color := GetPropValue( FontObj, 'Color' )
        end;

      if IsPublishedProp( vObject, 'Hint' ) then
        HighlightBak.Hint := GetPropValue( vObject, 'Hint' );
      HighlightBak.Inited := True;
      end;

    HL := HL AND ColorObjects;
    if HL then
      begin
      if ( vObject is TWinControl ) then
        begin
        TColorWinControl( vObject ).Color := PARAMETER_HIGHLIGHT_COLOR_CHANGED_;
        SendMessage( TWinControl( vObject ).Handle, CM_RECREATEWND, 0, 0 );
        end
      else if IsPublishedProp( vObject, 'Color' ) then
        begin
        if IsPublishedProp( vObject, 'ParentColor' ) then
          SetPropValue( vObject, 'ParentColor', false );

        SetPropValue( vObject, 'Color', PARAMETER_HIGHLIGHT_COLOR_CHANGED_ )
        end
      else if IsPublishedProp( vObject, 'Font' ) then
        begin
        if IsPublishedProp( vObject, 'ParentFont' ) then
          SetPropValue( vObject, 'ParentFont', false );

        FontObj := GetObjectProp( vObject, 'FONT' );
        SetPropValue( FontObj, 'Color', PARAMETER_HIGHLIGHT_COLOR_CHANGED_ );
        SetObjectProp( vObject, 'FONT', FontObj );
        end;

      if Hint then
        begin
        if IsPublishedProp( vObject, 'ParentShowHint' ) then
          SetPropValue( vObject, 'ParentShowHint', false );
        if IsPublishedProp( vObject, 'ShowHint' ) then
          SetPropValue( vObject, 'ShowHint', true );

        if IsPublishedProp( vObject, 'Hint' ) then
          SetPropValue( vObject, 'Hint', HintS );
        end;
      end
    else
      begin
      if IsPublishedProp( vObject, 'ParentColor' ) then
        SetPropValue( vObject, 'ParentColor', HighlightBak.ParentColor );
      if IsPublishedProp( vObject, 'ParentFont' ) then
        SetPropValue( vObject, 'ParentFont', HighlightBak.ParentFont );

      if ( vObject is TWinControl ) then
        begin
        TColorWinControl( vObject ).Color := HighlightBak.Color;
        SendMessage( TWinControl( vObject ).Handle, CM_RECREATEWND, 0, 0 );
        end
      else if IsPublishedProp( vObject, 'Color' ) then 
        SetPropValue( vObject, 'Color', HighlightBak.Color )
      else if IsPublishedProp( vObject, 'Font' ) then
        begin
        FontObj := GetObjectProp( vObject, 'FONT' );
        SetPropValue( FontObj, 'Color', HighlightBak.Color );
        SetObjectProp( vObject, 'FONT', FontObj );
        end;
        
      if IsPublishedProp( vObject, 'Hint' ) then
        begin
        if HighlightBak.Inited then
          SetPropValue( vObject, 'Hint', HighlightBak.Hint )
        else
          SetPropValue( vObject, 'Hint', '' );
        end;
      end;
  end;

  function CompareInteger( Param : T_PARAM_INT; ParamC : T_PARAM_INT; var Count : Cardinal; var sHint : String ) : Boolean;
  var
    oldValueI : Integer;
  begin
    oldValueI := T_PARAM_INT( Param ).fBackupValue;
    if Assigned( ParamC ) then
      oldValueI := T_PARAM_INT( ParamC ).fValue;

    result := ( oldValueI <> T_PARAM_INT( Param ).fValue );
    if result then
      begin
      if Assigned( StrL ) then
        StrL.Add( Format( LOG_INTEGER_, [ BeautifyClassName( Param ), T_PARAM_ALLGEMEIN( Param ).fName, oldValueI, T_PARAM_INT( Param ).fValue ] ) );
      Inc( Count );
      sHint := Format( PARAMETER_HIGHLIGHT_HINT_TEXT_ + '%d', [ oldValueI ] );
      end
    else
      sHint := '';
  end;
  
const
  EPS : extended = 1.0E-8;

  function CompareFloat( Param : T_PARAM_REAL; ParamC : T_PARAM_REAL; var Count : Cardinal; var sHint : String ) : Boolean;
  var
    oldValueF : Extended;
  begin
    oldValueF := T_PARAM_REAL( Param ).fBackupValue;
    if Assigned( ParamC ) then
      oldValueF := T_PARAM_REAL( ParamC ).fValue;

    result := ( Abs( oldValueF - T_PARAM_REAL( Param ).fValue ) > EPS );
    if result then
      begin
      if Assigned( StrL ) then
        StrL.Add( Format( LOG_REAL_, [ T_PARAM_ALLGEMEIN( Param ).fName, oldValueF, T_PARAM_REAL( Param ).fValue ] ) );
      Inc( Count );
      sHint := Format( PARAMETER_HIGHLIGHT_HINT_TEXT_ + '%f', [ oldValueF ] );
      end
    else
      sHint := '';
  end;
var
  i         : integer;
  Param     : T_PARAM_BASE;
  ParamC    : T_PARAM_BASE;
  changed   : boolean;
  sHint     : string;
  {$IF Defined( useMATHROUT ) OR Defined( useTLH_Math )}
  changed2,
  changed3  : Boolean;
  oldValueF : Extended;  
  {$IFEND}
  oldValueI : Integer;
  oldValueI6: System.Int64;
  oldValueB : Boolean;
  oldValueS : String;
begin
  result := 0;
  if NOT Assigned( self ) then
    Exit;

  if Application.Terminated then
    Exit;

  if Assigned( params ) AND ( InstanceSize <> params.InstanceSize ) then
    Exit;

  if Assigned( StrL ) then
    begin
    if Assigned( params ) then
      StrL.Add( Format( BACKUP_COMPARE_2_, [ ExtractFileName( params.fFileName ), ExtractFileName( fFileName ) ] ) )
    else
      StrL.Add( BACKUP_COMPARE_1_ );
    end;

  for i := 0 to fCount-1 do
    begin
    Param   := Items[ i ];
    if Assigned( params ) then
      begin
      ParamC := params.Items[ i ];
      if ( ParamC = NIL ) then
        continue;
      end
    else
      ParamC := nil;

    Changed := false;      
    if ( Param is T_PARAM_NR ) then
      begin
      oldValueI := T_PARAM_NR( Param ).fBackupValue;
      if Assigned( ParamC ) then
        oldValueI := T_PARAM_NR( ParamC ).fValue;

      changed := ( oldValueI <> T_PARAM_NR( Param ).fValue );
      if changed then
        begin
        if Assigned( StrL ) then
          StrL.Add( Format( LOG_INTEGER_, [ T_PARAM_ALLGEMEIN( Param ).fName, oldValueI, T_PARAM_NR( Param ).fValue ] ) );
        Inc( Result );
        sHint := Format( PARAMETER_HIGHLIGHT_HINT_TEXT_ + '%d', [ oldValueI ] );
        end
      else
        sHint := Format( PARAMETER_HIGHLIGHT_HINT_TEXT_ + '%d', [ oldValueI ] );
      end
    else if ( Param is T_PARAM_BOOL ) then
      begin
      oldValueB := T_PARAM_BOOL( Param ).fBackupValue;
      if Assigned( ParamC ) then
        oldValueB := T_PARAM_BOOL( ParamC ).fValue;

      changed := ( oldValueB <> T_PARAM_BOOL( Param ).fValue );
      if changed then
        begin
        if Assigned( StrL ) then
          StrL.Add( Format( LOG_STRING_, [ BeautifyClassName( Param ), T_PARAM_ALLGEMEIN( Param ).fName, BoolToStr( oldValueB, True ), BoolToStr( T_PARAM_BOOL( Param ).fValue, True )  ] ) );
        Inc( Result );
        sHint := Format( PARAMETER_HIGHLIGHT_HINT_TEXT_ + '%s', [ BoolToStr( oldValueB, True ) ] );
        end
      else
        sHint := '';
      end
    else if ( Param is T_PARAM_INT ) then
      changed := CompareInteger( T_PARAM_INT( Param ), T_PARAM_INT( ParamC ), Result, sHint )
    else if ( Param is T_PARAM_INT64 ) then
      begin
      oldValueI6 := T_PARAM_INT64( Param ).fBackupValue;
      if Assigned( ParamC ) then
        oldValueI6 := T_PARAM_INT64( ParamC ).fValue;

      changed := ( oldValueI6 <> T_PARAM_INT64( Param ).fValue );
      if changed then
        begin
        if Assigned( StrL ) then
          StrL.Add( Format( LOG_INTEGER_, [ BeautifyClassName( Param ), T_PARAM_ALLGEMEIN( Param ).fName, oldValueI6, T_PARAM_INT64( Param ).fValue ] ) );
        Inc( Result );
        sHint := Format( PARAMETER_HIGHLIGHT_HINT_TEXT_ + '%d', [ oldValueI6 ] );
        end
      else
        sHint := '';
      end
    else if ( Param is T_PARAM_STR ) then
      begin
      oldValueS := T_PARAM_STR( Param ).fBackupValue;
      if Assigned( ParamC ) then
        oldValueS := T_PARAM_STR( ParamC ).fValue;

      changed := ( LowerCase( oldValueS ) <> LowerCase( T_PARAM_STR( Param ).fValue ) );
      if changed then
        begin
        if Assigned( StrL ) then
          begin
          if T_PARAM_STR( Param ).fPassword then
            StrL.Add( Format( LOG_PASSWORD_1_, [ T_PARAM_ALLGEMEIN( Param ).fName ] ) )
          else
            StrL.Add( Format( LOG_STRING_, [ BeautifyClassName( Param ), T_PARAM_ALLGEMEIN( Param ).fName, oldValueS, T_PARAM_STR( Param ).fValue ] ) );
          end;
        Inc( Result );
        sHint := Format( PARAMETER_HIGHLIGHT_HINT_TEXT_ + '%s', [ oldValueS ] );
        end
      else
        sHint := '';
      end
    else if ( Param is T_PARAM_STR_LIST ) then
      begin
      oldValueS := T_PARAM_STR_LIST( Param ).fBackupValue.Text;
      if Assigned( ParamC ) then
        oldValueS := T_PARAM_STR_LIST( ParamC ).fValue.Text;

      changed := ( LowerCase( oldValueS ) <> LowerCase( T_PARAM_STR_LIST( Param ).fValue.Text ) );
      if changed then
        begin
        if Assigned( StrL ) then
          StrL.Add( Format( LOG_STRING_, [ BeautifyClassName( Param ), T_PARAM_ALLGEMEIN( Param ).fName, oldValueS, T_PARAM_STR_LIST( Param ).fValue ] ) );
        Inc( Result );
        sHint := Format( PARAMETER_HIGHLIGHT_HINT_TEXT_ + '%s', [ oldValueS ] );
        end
      else
        sHint := '';
      end
    else if ( Param is T_PARAM_REAL ) then
      changed := CompareFloat( T_PARAM_REAL( Param ), T_PARAM_REAL( ParamC ), Result, sHint )
    else if ( Param is T_PARAM_ROI ) then
      begin
      changed := CompareInteger( T_PARAM_ROI( Param ).x1, T_PARAM_ROI( ParamC ).x1, Result, sHint );
      HighlightItem( T_PARAM_ROI( Param ).x1.fObject, T_PARAM_ROI( Param ).x1.HighLight, changed{HL}, showOldValuesAsHint, sHint );

      changed := CompareInteger( T_PARAM_ROI( Param ).y1, T_PARAM_ROI( ParamC ).y1, Result, sHint );
      HighlightItem( T_PARAM_ROI( Param ).y1.fObject, T_PARAM_ROI( Param ).y1.HighLight, changed{HL}, showOldValuesAsHint, sHint );

      changed := CompareInteger( T_PARAM_ROI( Param ).x2, T_PARAM_ROI( ParamC ).x2, Result, sHint );
      HighlightItem( T_PARAM_ROI( Param ).x2.fObject, T_PARAM_ROI( Param ).x2.HighLight, changed{HL}, showOldValuesAsHint, sHint );

      changed := CompareInteger( T_PARAM_ROI( Param ).y2, T_PARAM_ROI( ParamC ).y2, Result, sHint );
      HighlightItem( T_PARAM_ROI( Param ).y2.fObject, T_PARAM_ROI( Param ).y2.HighLight, changed{HL}, showOldValuesAsHint, sHint );
      end
    else if ( Param is T_PARAM_AOI ) then 
      begin
      changed := CompareFloat( T_PARAM_AOI( Param ).TopLeftX, T_PARAM_AOI( ParamC ).TopLeftX, Result, sHint );
      HighlightItem( T_PARAM_AOI( Param ).TopLeftX.fObject, T_PARAM_AOI( Param ).TopLeftX.HighLight, changed{HL}, showOldValuesAsHint, sHint );

      changed := CompareFloat( T_PARAM_AOI( Param ).TopLeftY, T_PARAM_AOI( ParamC ).TopLeftY, Result, sHint );
      HighlightItem( T_PARAM_AOI( Param ).TopLeftY.fObject, T_PARAM_AOI( Param ).TopLeftY.HighLight, changed{HL}, showOldValuesAsHint, sHint );

      changed := CompareFloat( T_PARAM_AOI( Param ).TopRightX, T_PARAM_AOI( ParamC ).TopRightX, Result, sHint );
      HighlightItem( T_PARAM_AOI( Param ).TopRightX.fObject, T_PARAM_AOI( Param ).TopRightX.HighLight, changed{HL}, showOldValuesAsHint, sHint );

      changed := CompareFloat( T_PARAM_AOI( Param ).TopRightY, T_PARAM_AOI( ParamC ).TopRightY, Result, sHint );
      HighlightItem( T_PARAM_AOI( Param ).TopRightY.fObject, T_PARAM_AOI( Param ).TopRightY.HighLight, changed{HL}, showOldValuesAsHint, sHint );

      changed := CompareFloat( T_PARAM_AOI( Param ).BottomLeftX, T_PARAM_AOI( ParamC ).BottomLeftX, Result, sHint );
      HighlightItem( T_PARAM_AOI( Param ).BottomLeftX.fObject, T_PARAM_AOI( Param ).BottomLeftX.HighLight, changed{HL}, showOldValuesAsHint, sHint );

      changed := CompareFloat( T_PARAM_AOI( Param ).BottomLeftY, T_PARAM_AOI( ParamC ).BottomLeftY, Result, sHint );
      HighlightItem( T_PARAM_AOI( Param ).BottomLeftY.fObject, T_PARAM_AOI( Param ).BottomLeftY.HighLight, changed{HL}, showOldValuesAsHint, sHint );

      changed := CompareFloat( T_PARAM_AOI( Param ).BottomRightX, T_PARAM_AOI( ParamC ).BottomRightX, Result, sHint );
      HighlightItem( T_PARAM_AOI( Param ).BottomRightX.fObject, T_PARAM_AOI( Param ).BottomRightX.HighLight, changed{HL}, showOldValuesAsHint, sHint );

      changed := CompareFloat( T_PARAM_AOI( Param ).BottomRightY, T_PARAM_AOI( ParamC ).BottomRightY, Result, sHint );
      HighlightItem( T_PARAM_AOI( Param ).BottomRightY.fObject, T_PARAM_AOI( Param ).BottomRightY.HighLight, changed{HL}, showOldValuesAsHint, sHint );
      end
    {$IF Defined( useMATHROUT ) OR Defined( useTLH_Math )}
    else if ( Param is T_PARAM_ePunkt ) then
      begin
      // X
      oldValueF := T_PARAM_ePunkt( Param ).fBackupValue.X;
      if Assigned( ParamC ) then
        oldValueF := T_PARAM_ePunkt( ParamC ).fValue.X;

      changed := Abs( oldValueF - T_PARAM_ePunkt( Param ).fValue.X ) > EPS;
      if changed then
        begin
        Inc( Result );
        sHint := Format( PARAMETER_HIGHLIGHT_HINT_TEXT_ + '%f', [ oldValueF ] );
        end
      else
        sHint := '';

      // Y
      oldValueF := T_PARAM_ePunkt( Param ).fBackupValue.Y;
      if Assigned( ParamC ) then
        oldValueF := T_PARAM_ePunkt( ParamC ).fValue.Y;
      changed2 := Abs( oldValueF - T_PARAM_ePunkt( Param ).fValue.Y ) > EPS;
      if changed2 then
        Inc( Result );
      HighlightItem( T_PARAM_ePunkt( Param ).fObjectY, T_PARAM_ePunkt( Param ).HighLightY, changed2{HL}, showOldValuesAsHint, IfThen( changed2, Format( PARAMETER_HIGHLIGHT_HINT_TEXT_ + '%f', [ oldValueF ] ), '' ) );

      if ( changed or changed2 ) AND Assigned( StrL ) then
        begin
        if Assigned( ParamC ) then
          StrL.Add( Format( LOG_EPUNKT_, [ T_PARAM_ALLGEMEIN( Param ).fName, T_PARAM_ePunkt( ParamC ).fValue.x, T_PARAM_ePunkt( ParamC ).fValue.y, T_PARAM_ePunkt( Param ).fValue.x, T_PARAM_ePunkt( Param ).fValue.y ] ) )
        else
          StrL.Add( Format( LOG_EPUNKT_, [ T_PARAM_ALLGEMEIN( Param ).fName, T_PARAM_ePunkt( Param ).fBackupValue.x, T_PARAM_ePunkt( Param ).fBackupValue.y, T_PARAM_ePunkt( Param ).fValue.x, T_PARAM_ePunkt( Param ).fValue.y ] ) );
        end;
      end
    else if ( Param is T_PARAM_eGerade ) then
      begin
      // X
      oldValueF := T_PARAM_eGerade( Param ).fBackupValue.NX;
      if Assigned( ParamC ) then
        oldValueF := T_PARAM_eGerade( ParamC ).fValue.NX;
      changed := Abs( oldValueF - T_PARAM_eGerade( Param ).fValue.NX ) > EPS;
      if changed then
        begin
        Inc( Result );
        sHint := Format( PARAMETER_HIGHLIGHT_HINT_TEXT_ + '%f', [ oldValueF ] );
        end
      else
        sHint := '';

      // Y
      oldValueF := T_PARAM_eGerade( Param ).fBackupValue.NY;
      if Assigned( ParamC ) then
        oldValueF := T_PARAM_eGerade( ParamC ).fValue.NY;
      changed2 := Abs( oldValueF - T_PARAM_eGerade( Param ).fValue.NY ) > EPS;
      if changed2 then
        Inc( Result );
      HighlightItem( T_PARAM_eGerade( Param ).fObjectNY, T_PARAM_eGerade( Param ).HighLightY, changed2{HL}, showOldValuesAsHint, IfThen( changed2, Format( PARAMETER_HIGHLIGHT_HINT_TEXT_ + '%f', [ oldValueF ] ), '' ) );

      // C
      oldValueF := T_PARAM_eGerade( Param ).fBackupValue.C;
      if Assigned( ParamC ) then
        oldValueF := T_PARAM_eGerade( ParamC ).fValue.C;
      changed3 := Abs( oldValueF - T_PARAM_eGerade( Param ).fValue.C ) > EPS;
      if changed3 then
        Inc( Result );
      HighlightItem( T_PARAM_eGerade( Param ).fObjectC, T_PARAM_eGerade( Param ).HighLightC, changed3{HL}, showOldValuesAsHint, IfThen( changed3, Format( PARAMETER_HIGHLIGHT_HINT_TEXT_ + '%f', [ oldValueF ] ), '' ) );

      if ( changed or changed2 or changed3 ) AND Assigned( StrL ) then
        begin
        if Assigned( ParamC ) then
          StrL.Add( Format( LOG_EGERADE_, [ T_PARAM_ALLGEMEIN( Param ).fName, T_PARAM_eGerade( ParamC ).fValue.nx, T_PARAM_eGerade( ParamC ).fValue.ny, T_PARAM_eGerade( ParamC ).fValue.c, T_PARAM_eGerade( Param ).fValue.nx, T_PARAM_eGerade( Param ).fValue.ny, T_PARAM_eGerade( Param ).fValue.c ] ) )
        else
          StrL.Add( Format( LOG_EGERADE_, [ T_PARAM_ALLGEMEIN( Param ).fName, T_PARAM_eGerade( Param ).fBackupValue.nx, T_PARAM_eGerade( Param ).fBackupValue.ny, T_PARAM_eGerade( Param ).fBackupValue.c, T_PARAM_eGerade( Param ).fValue.nx, T_PARAM_eGerade( Param ).fValue.ny, T_PARAM_eGerade( Param ).fValue.c ] ) );
        end;
      end
    {$IFEND}
    else
      Continue;

    if ( Param is T_PARAM_ALLGEMEIN ) then
      HighlightItem( T_PARAM_ALLGEMEIN( Param ).fObject, T_PARAM_ALLGEMEIN( Param ).HighLight, changed{HL}, showOldValuesAsHint, sHint );
    end;

  if Assigned( StrL ) then
    begin
    if ( StrL.Count = 1 ) then
      StrL.Add( COMPARE_NO_CHANGES_ );
    end;
end;

{$IF CompilerVersion >= 18}
function T_INI_DATEI.GetParameterName( ID : Cardinal ) : string;
var
  ctx   : TRttiContext;
  rType : TRttiType;
  rProp : TRttiField;
  Cnt   : Cardinal;
begin
  result := '';
  if NOT Assigned( self ) then
    Exit;
  if ( ID > fCount-1 ) then
    Exit;
  ctx := TRttiContext.Create;
  rType := ctx.GetType( ClassInfo );
  Cnt := 0;
  for rProp in rType.GetFields do
    begin
    if ( rProp.Offset < ClassParent.InstanceSize-SizeOf( Pointer ) ) then
      break;

    if ( Cnt = ID ) then
      begin
      result := rProp.Name;
      Break;
      end;
    Inc( Cnt );
    end;
  ctx.Free;
end;
{$IFEND}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Constructor T_INI_DATEI.Create( pfad_datname: string );
begin
  inherited Create;
  fInited          := false;
  fFileName        := pfad_datname;
  fCount           := ( ( instancesize - ClassParent.InstanceSize ) div SizeOf( pointer ) );
  fSection         := DEFAULT_SECTION_;
  fHighlighted     := false;

  if ( pfad_datname = '' ) then
    Exit;

  if NOT FileExists( pfad_datname ) then
    begin
    if NOT DirectoryExists( ExtractFilePath( fFileName ) ) then
      ForceDirectories( ExtractFilePath( fFileName ) );  
    end;
end;

destructor T_INI_DATEI.Destroy;
var
  i    : integer;
  Item : P_PARAM_BASE;
begin
  if NOT Assigned( self ) then
    Exit;
  fInited := false;

  for i := 0 to fCount-1 do
    begin
    Item := GetItemPointer( i );
    if NOT Assigned( Item^ ) then
      Continue;
    Item^.free;
    Item := nil;
    end;

  fCount := 0;
  inherited;
end;

procedure T_INI_DATEI.Assign( Source: T_INI_DATEI );
var
  i    : Integer;
  Item : P_PARAM_BASE;
  Item2: P_PARAM_BASE;
begin
  if NOT Assigned( self ) then
    Exit;
  if NOT Assigned( source ) then
    Exit;

  if ( InstanceSize <> Source.InstanceSize ) then
    Exit;

//    fIniFile          := source.fIniFile;
//    fIniFile.Assign( source.fIniFile );

  fFileName        := source.fFileName;
  fSection         := source.fSection;
  fInited          := source.fInited;
  fNoVCL           := source.fNoVCL;

  for i := 0 to fCount-1 do
    begin
    Item := GetItemPointer( i );
    Item2 := Source.GetItemPointer( i );
//    if Assigned( Item^ ) then
//      begin
//      Item^.free;
//      Item := nil;
//      end;
    if NOT Assigned( Item2 ) then
      Continue;
    if ( Item^.ClassType <> Item2^.ClassType ) then
      Break;

    if ( Item^ is T_PARAM_NR ) then
      begin
      if Assigned( Item^ ) then
        T_PARAM_NR( Item^ ).Assign( T_PARAM_NR( Item2^ ) )
      else
        Item^ := T_PARAM_NR.Create( self, T_PARAM_NR( Item2^ ).fSection, T_PARAM_NR( Item2^ ).fDefault, T_PARAM_NR( Item2^ ).fName{$IFDEF ASSIGN_VCL}, T_PARAM_NR( Item2^ ).fObject{$ENDIF} );
      end
    else if ( Item^ is T_PARAM_BOOL ) then
      begin
      if Assigned( Item^ ) then
        T_PARAM_BOOL( Item^ ).Assign( T_PARAM_BOOL( Item2^ ) )
      else
        Item^ := T_PARAM_BOOL.Create( self, T_PARAM_BOOL( Item2^ ).fSection, T_PARAM_BOOL( Item2^ ).fDefault, T_PARAM_BOOL( Item2^ ).fName{$IFDEF ASSIGN_VCL}, T_PARAM_BOOL( Item2^ ).fObject{$ENDIF} );
      end
    else if ( Item^ is T_PARAM_INT ) then
      begin
      if Assigned( Item^ ) then
        T_PARAM_INT( Item^ ).Assign( T_PARAM_INT( Item2^ ) )
      else
        Item^ := T_PARAM_INT.Create( self, T_PARAM_INT( Item2^ ).fSection, T_PARAM_INT( Item2^ ).fDefault, T_PARAM_INT( Item2^ ).fMinimum, T_PARAM_INT( Item2^ ).fMaximum, T_PARAM_INT( Item2^ ).fName{$IFDEF ASSIGN_VCL}, T_PARAM_INT( Item2^ ).fObject{$ENDIF} );
      end
    else if ( Item^ is T_PARAM_INT64 ) then
      begin
      if Assigned( Item^ ) then
        T_PARAM_INT64( Item^ ).Assign( T_PARAM_INT64( Item2^ ) )
      else
        Item^ := T_PARAM_INT64.Create( self, T_PARAM_INT64( Item2^ ).fSection, T_PARAM_INT64( Item2^ ).fDefault, T_PARAM_INT64( Item2^ ).fMinimum, T_PARAM_INT64( Item2^ ).fMaximum, T_PARAM_INT64( Item2^ ).fName{$IFDEF ASSIGN_VCL}, T_PARAM_INT64( Item2^ ).fObject{$ENDIF} );
      end
    else if ( Item^ is T_PARAM_REAL ) then
      begin
      if Assigned( Item^ ) then
        T_PARAM_REAL( Item^ ).Assign( T_PARAM_REAL( Item2^ ) )
      else
        begin
        Item^ := T_PARAM_REAL.Create( self, T_PARAM_REAL( Item2^ ).fSection, T_PARAM_REAL( Item2^ ).fDefault, T_PARAM_REAL( Item2^ ).fMinimum, T_PARAM_REAL( Item2^ ).fMaximum, T_PARAM_REAL( Item2^ ).fName{$IFDEF ASSIGN_VCL}, T_PARAM_REAL( Item2^ ).fObject{$ENDIF} );
        T_PARAM_REAL( Item^ ).fDecimalPlaces := T_PARAM_REAL( Item2^ ).fDecimalPlaces;
        end;
      end
    else if ( Item^ is T_PARAM_STR ) then
      begin
      if Assigned( Item^ ) then
        T_PARAM_STR( Item^ ).Assign( T_PARAM_STR( Item2^ ) )
      else
        Item^ := T_PARAM_STR.Create( self, T_PARAM_STR( Item2^ ).fSection, T_PARAM_STR( Item2^ ).fDefault, T_PARAM_STR( Item2^ ).fName{$IFDEF ASSIGN_VCL}, T_PARAM_STR( Item2^ ).fObject{$ENDIF} );
      end
    else if ( Item^ is T_PARAM_STR_LIST ) then
      begin
      if Assigned( Item^ ) then
        T_PARAM_STR_LIST( Item^ ).Assign( T_PARAM_STR_LIST( Item2^ ) )
      else
        Item^ := T_PARAM_STR_LIST.Create( self, T_PARAM_STR_LIST( Item2^ ).fSection{$IFDEF ASSIGN_VCL}, T_PARAM_STR_LIST( Item2^ ).fObject{$ENDIF} );
      end
    else if ( Item^ is T_PARAM_ROI ) then
      begin
      if Assigned( Item^ ) then
        T_PARAM_ROI( Item^ ).Assign( T_PARAM_ROI( Item2^ ) )
      else
        begin
        if NOT ( Assigned( T_PARAM_ROI( Item2^ ).x1 ) AND Assigned( T_PARAM_ROI( Item2^ ).y1 ){$IFDEF ASSIGN_VCL} AND Assigned( T_PARAM_ROI( Item2^ ).x2 ) AND Assigned( T_PARAM_ROI( Item2^ ).y2 ) {$ENDIF}) then
          Continue;
        Item^ := T_PARAM_ROI.Create( self, T_PARAM_ROI( Item2^ ).x1.fSection, T_PARAM_ROI( Item2^ ).x1.fMinimum, T_PARAM_ROI( Item2^ ).y1.fMinimum, T_PARAM_ROI( Item2^ ).x1.fMaximum, T_PARAM_ROI( Item2^ ).y1.fMaximum, LeftStr( T_PARAM_ROI( Item2^ ).x1.fName, Length( T_PARAM_ROI( Item2^ ).x1.fName )-2 ){$IFDEF ASSIGN_VCL}, T_PARAM_ROI( Item2^ ).x1.fObject, T_PARAM_ROI( Item2^ ).y1.fObject, T_PARAM_ROI( Item2^ ).x2.fObject, T_PARAM_ROI( Item2^ ).y1.fObject{$ENDIF} )
        end;
      end
    else if ( Item^ is T_PARAM_AOI ) then
      begin
      if Assigned( Item^ ) then
        T_PARAM_AOI( Item^ ).Assign( T_PARAM_AOI( Item2^ ) )
      else
        begin
        if NOT ( Assigned( T_PARAM_AOI( Item2^ ).TopLeftX ) AND Assigned( T_PARAM_AOI( Item2^ ).TopLeftY ){$IFDEF ASSIGN_VCL} AND Assigned( T_PARAM_AOI( Item2^ ).TopRightX ) AND Assigned( T_PARAM_AOI( Item2^ ).TopRightY ) AND Assigned( T_PARAM_AOI( Item2^ ).BottomLeftX ) AND Assigned( T_PARAM_AOI( Item2^ ).BottomLeftY ) AND Assigned( T_PARAM_AOI( Item2^ ).BottomRightX ) AND Assigned( T_PARAM_AOI( Item2^ ).BottomRightY ){$ENDIF} ) then
          Continue;
        Item^ := T_PARAM_AOI.Create( self, T_PARAM_AOI( Item2^ ).TopLeftX.fSection, T_PARAM_AOI( Item2^ ).TopLeftX.fMinimum, T_PARAM_AOI( Item2^ ).TopLeftY.fMinimum, T_PARAM_AOI( Item2^ ).TopLeftX.fMaximum, T_PARAM_AOI( Item2^ ).TopLeftY.fMaximum, LeftStr( T_PARAM_AOI( Item2^ ).TopLeftX.fName, Length( T_PARAM_AOI( Item2^ ).TopLeftX.fName )-8 ){$IFDEF ASSIGN_VCL}, T_PARAM_AOI( Item2^ ).TopLeftX.fObject, T_PARAM_AOI( Item2^ ).TopLeftY.fObject, T_PARAM_AOI( Item2^ ).TopRightX.fObject, T_PARAM_AOI( Item2^ ).TopRightY.fObject, T_PARAM_AOI( Item2^ ).BottomLeftX.fObject, T_PARAM_AOI( Item2^ ).BottomLeftY.fObject, T_PARAM_AOI( Item2^ ).BottomRightX.fObject, T_PARAM_AOI( Item2^ ).BottomRightY.fObject{$ENDIF} )
        end;
      end
    {$IF Defined( useMATHROUT ) OR Defined( useTLH_Math )}
    else if ( Item^ is T_PARAM_ePunkt ) then
      begin
      if Assigned( Item^ ) then
        T_PARAM_ePunkt( Item^ ).Assign( T_PARAM_ePunkt( Item2^ ) )
      else
        Item^ := T_PARAM_ePunkt.Create( self, T_PARAM_ePunkt( Item2^ ).fSection, T_PARAM_ePunkt( Item2^ ).fDefault, T_PARAM_ePunkt( Item2^ ).fName{$IFDEF ASSIGN_VCL}, T_PARAM_ePunkt( Item2^ ).fObject, T_PARAM_ePunkt( Item2^ ).fObjectY{$ENDIF} );
      end
    else if ( Item^ is T_PARAM_eGerade ) then
      begin
      if Assigned( Item^ ) then
        T_PARAM_eGerade( Item^ ).Assign( T_PARAM_eGerade( Item2^ ) )
      else
        Item^ := T_PARAM_eGerade.Create( self, T_PARAM_eGerade( Item2^ ).fSection, T_PARAM_eGerade( Item2^ ).fDefault, T_PARAM_eGerade( Item2^ ).fName{$IFDEF ASSIGN_VCL}, T_PARAM_eGerade( Item2^ ).fObject, T_PARAM_eGerade( Item2^ ).fObjectNY, T_PARAM_eGerade( Item2^ ).fObjectC{$ENDIF} );
      end
    {$IFEND}
    else
      Continue;
    end;
end;

function T_INI_DATEI.IsComponentInUse( vObject: TObject ) : boolean;
var
  i     : integer;
  Param : T_PARAM_BASE;
begin
  result := false;
  if NOT Assigned( self ) then
    Exit;
  if NOT Assigned( vObject ) then
    Exit;

  for i := 0 to fCount-1 do
    begin
    Param := Items[ i ];

    if ( Param is T_PARAM_AOI ) then
      result := T_PARAM_AOI( Param ).IsMyObject( vObject )
    else if ( Param is T_PARAM_ROI ) then
      result := T_PARAM_ROI( Param ).IsMyObject( vObject )
    {$IF Defined( useMATHROUT ) OR Defined( useTLH_Math )}
    else if ( Param is T_PARAM_eGerade ) then
      result := T_PARAM_eGerade( Param ).IsMyObject( vObject )
    else if ( Param is T_PARAM_ePunkt ) then
      result := T_PARAM_ePunkt( Param ).IsMyObject( vObject )
    {$IFEND}
    else
      result := T_PARAM_ALLGEMEIN( Param ).IsMyObject( vObject );

    if result then
      break;
    end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Procedure T_INI_DATEI.SetzteSection( sectionName: string );
begin
  if NOT Assigned( self ) then
    Exit;

  if ( sectionName = '' ) OR ( fIniFile = nil ) {OR ( NOT fIniFile.SectionExists( sectionName ) )} then
    Exit;
  fSection := Trim( sectionName );

  {$IF NOT Defined( useMemIni ) AND NOT Defined( useFastIni ) }
  if Assigned( fValueExists ) then
    begin
    fValueExists.Clear;
    try
      fIniFile.ReadSection( SectionName, fValueExists );
    finally
    end;
    end;
  {$IFEND}
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Procedure T_INI_DATEI.SetFileName( Value: string );
begin
  if NOT Assigned( self ) then
    Exit;

  if ( Value = '' ) {OR ( fFileName = Value )} then
    Exit;
  fFileName := Value;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Procedure T_INI_DATEI.SectionLoeschen( sectionName: string );
begin
  if NOT Assigned( self ) then
    Exit;

  if ( sectionName = '' ) OR ( fIniFile = nil ) OR ( NOT fIniFile.SectionExists( sectionName ) ) then
    Exit;

  fIniFile.EraseSection( sectionName );
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure T_INI_DATEI.ListBackups;
var
  Backup : string;
begin
  if NOT Assigned( self ) then
    Exit;

  BackUp := FrmParameterBackup.Execute( Self, false );
  if ( LowerCase( fFileName ) = LowerCase( BackUp ) ) then // Ignore...
    Exit
  else
    begin
    BackupLog( Format( LOG_BACKUP_, [ ExtractFileName( Backup ) ] ) );
    if Assigned( fIniFile ) then
      fIniFile.free;
    fIniFile := TIniFileType.Create( BackUp );
    Reload;
    end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure T_INI_DATEI.VCLToValue;
var
  i    : Integer;
  Item : T_PARAM_BASE;
begin
  if ( GetCurrentThreadID <> MainThreadID ) then
    Exit;
  for i := 0 to fCount-1 do
    begin
    Item := Items[ i ];
    if NOT Assigned( Item ) then
      Continue;

    if ( Item is T_PARAM_NR ) then
      T_PARAM_NR( Item ).VCLToValue
    else if ( Item is T_PARAM_BOOL ) then
      T_PARAM_BOOL( Item ).VCLToValue
    else if ( Item is T_PARAM_INT ) then
      T_PARAM_INT( Item ).VCLToValue
    else if ( Item is T_PARAM_INT64 ) then
      T_PARAM_INT64( Item ).VCLToValue
    else if ( Item is T_PARAM_REAL ) then
      T_PARAM_REAL( Item ).VCLToValue
    else if ( Item is T_PARAM_STR ) then
      T_PARAM_STR( Item ).VCLToValue
    else if ( Item is T_PARAM_STR_LIST ) then
      T_PARAM_STR_LIST( Item ).VCLToValue
    else if ( Item is T_PARAM_ROI ) then
      T_PARAM_ROI( Item ).VCLToValue
    else if ( Item is T_PARAM_AOI ) then
      T_PARAM_AOI( Item ).VCLToValue
    {$IF Defined( useMATHROUT ) OR Defined( useTLH_Math )}
    else if ( Item is T_PARAM_ePunkt ) then
      T_PARAM_ePunkt( Item ).VCLToValue
    else if ( Item is T_PARAM_eGerade ) then
      T_PARAM_eGerade( Item ).VCLToValue
    {$IFEND}
    else
      Continue;
    end;
end;

procedure T_INI_DATEI.ValueToVCL;
var
  i    : Integer;
  Item : T_PARAM_BASE;
begin
  if ( GetCurrentThreadID <> MainThreadID ) then
    Exit;
  for i := 0 to fCount-1 do
    begin
    Item := Items[ i ];
    if NOT Assigned( Item ) then
      Continue;

    if ( Item is T_PARAM_NR ) then
      T_PARAM_NR( Item ).ValueToVCL
    else if ( Item is T_PARAM_BOOL ) then
      T_PARAM_BOOL( Item ).ValueToVCL
    else if ( Item is T_PARAM_INT ) then
      T_PARAM_INT( Item ).ValueToVCL
    else if ( Item is T_PARAM_INT64 ) then
      T_PARAM_INT64( Item ).ValueToVCL
    else if ( Item is T_PARAM_REAL ) then
      T_PARAM_REAL( Item ).ValueToVCL
    else if ( Item is T_PARAM_STR ) then
      T_PARAM_STR( Item ).ValueToVCL
    else if ( Item is T_PARAM_STR_LIST ) then
      T_PARAM_STR_LIST( Item ).ValueToVCL
    else if ( Item is T_PARAM_ROI ) then
      T_PARAM_ROI( Item ).ValueToVCL
    else if ( Item is T_PARAM_AOI ) then
      T_PARAM_AOI( Item ).ValueToVCL
    {$IF Defined( useMATHROUT ) OR Defined( useTLH_Math )}
    else if ( Item is T_PARAM_ePunkt ) then
      T_PARAM_ePunkt( Item ).ValueToVCL
    else if ( Item is T_PARAM_eGerade ) then
      T_PARAM_eGerade( Item ).ValueToVCL
    {$IFEND}
    else
      Continue;
    end;
end;

procedure T_INI_DATEI.Reload;
var
  i     : integer;
  Param : T_PARAM_BASE;
begin
  if NOT Assigned( self ) then
    Exit;

  if NOT Assigned( fIniFile ) then
    begin
    if NOT FileExists( fFileName ) then
      Exit;
    fIniFile := TIniFileType.Create( fFileName );
    end;

  fInited := false;
  for i := 0 to fCount-1 do
    begin
    Param := Items[ i ];
    if ( Param is T_PARAM_ROI ) then
      T_PARAM_ROI( Param ).Load
    else if ( Param is T_PARAM_AOI ) then
      T_PARAM_AOI( Param ).Load
    else
      begin
      if ( Param is T_PARAM_NR ) then
        T_PARAM_NR( Param ).Load
      else if ( Param is T_PARAM_BOOL ) then
        T_PARAM_BOOL( Param ).Load
      else if ( Param is T_PARAM_INT ) then
        T_PARAM_INT( Param ).Load
      else if ( Param is T_PARAM_INT64 ) then
        T_PARAM_INT64( Param ).Load
      else if ( Param is T_PARAM_REAL ) then
        T_PARAM_REAL( Param ).Load
      else if ( Param is T_PARAM_STR ) then
        T_PARAM_STR( Param ).Load
      else if ( Param is T_PARAM_STR_LIST ) then
        T_PARAM_STR_LIST( Param ).Load
      {$IF Defined( useMATHROUT ) OR Defined( useTLH_Math )}
      else if ( Param is T_PARAM_ePunkt ) then
        T_PARAM_REAL( Param ).Load
      else if ( Param is T_PARAM_eGerade ) then
        T_PARAM_REAL( Param ).Load
      {$IFEND}
      else
        Continue;
      end;
    end;
  fInited := True;

  fIniFile.free;
  fIniFile := nil;

  UnHighlightChangedValues;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure T_INI_DATEI.BackupLog( val : string );
var
  StrL_Log : TStringList;
  LogFileName : string;
begin
  if NOT Assigned( self ) then
    Exit;
  if ( val = '' ) then
    Exit;
  StrL_Log := TStringList.Create;

  LogFileName := ExtractFilePath( fFileName ) + ChangeFileExt( ExtractFileName( fFileName ), '.' + PARAMETER_LOGDATEI_EXT_ );
  if FileExists( LogFileName ) then
    StrL_Log.LoadFromFile( LogFileName );
  StrL_Log.Add( Format( LOG_FORMAT_, [ DateTimeToStr( NOW ), val ] ) );
  try
    StrL_Log.SaveToFile( LogFileName );
  except
  end;
  StrL_Log.free;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Function T_INI_DATEI.ParameterUebernehmen( save: boolean = false; logging : boolean = false; vCleanUp : boolean = false; UserName : String = ''; Comment : String = ''; MasterBackup : boolean = false {$IFDEF AutoBackup}; NoAutoBackup : boolean = false{$ENDIF} ): integer;
  {$IFDEF AutoBackup}
  procedure CleanUp;
  var
    rDirInfo   : TSearchRec;
    iError     : boolean;
    dt         : Cardinal;
    dtOldest   : Cardinal;
    cnt        : Word;
    nOldest    : String;
  begin
    iError    := NOT ( FindFirst( Format( '%s_????-??-??' + FILE_EXT_BACKUP_, [ ChangeFileExt( fFileName, '' ) ] ), faAnyFile, rDirInfo) = 0 );
    dtOldest  := High( Cardinal );
    cnt       := 0;
    nOldest   := '';
    while ( NOT iError ) do
      begin
      if ( rDirInfo.Name <> '.' ) AND ( rDirInfo.Name <> '..' ) then
        begin
        dt := StrToIntDef( StringReplace( RightStr( ChangeFileExt( rDirInfo.Name, '' ), 10 ), '-', '', [rfReplaceAll] ), 0 );
        if ( dt <> 0 ) AND ( dt < dtOldest ) then
          begin
          dtOldest := dt;
          nOldest  := ExtractFilePath( fFileName ) + rDirInfo.Name;
          end;
        inc( cnt );

        iError := ( FindNext(rDirInfo) <> 0 );
        if iError then
          SysUtils.FindClose(rDirInfo);
        end;
      end;
    if ( cnt > PARAMETER_MAX_BACKUPS_ ) and ( nOldest <> '' ) then
      begin
      if FileExists( ChangeFileExt( nOldest, FILE_EXT_CHECKSUM_ ) ) then
        begin
        try
          if not SysUtils.DeleteFile( ChangeFileExt( nOldest, FILE_EXT_CHECKSUM_ ) ) then
            raise Exception.Create( Format( ERROR_BACKUP_CLEANUP_, [ ChangeFileExt( nOldest, FILE_EXT_CHECKSUM_ ), SysErrorMessage( GetLastError ) ] ) );
        except
        end;
        end;
      try
        if not SysUtils.DeleteFile( nOldest ) then
          raise Exception.Create( Format( ERROR_BACKUP_CLEANUP_, [ ERROR_BACKUP_CLEANUP_, nOldest, SysErrorMessage( GetLastError ) ] ) );
      except
      end;
      end;
  end;
  {$ENDIF}
// Parameter werden vollautomatisch in das ini-File gespeichert
var
  i        : integer;
  bFailed  : Byte;
  bCopy    : Boolean;
  LogFile  : string;
  StrL_Log : TStringList;
  sTime    : String;
  Param    : T_PARAM_BASE;
 {$IFDEF MD5}
  StrL     : TStringList;
  MD5      : ShortString;
  {$ENDIF}
  MD5File  : string;
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  procedure AddLog( val : string );
  begin
    if ( val = '' ) then
      Exit;

    StrL_Log.Add( Format( LOG_FORMAT_, [ sTime, val ] ) );
  end;
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  result := -11;
  if NOT Assigned( self ) then
    Exit;
  result := -10;
  if NOT fInited then
    Exit;

  if HasVCL then
    begin
    result := -9;
    if ( GetCurrentThreadID <> MainThreadID ) then
      Exit;
    end;

  result := -8;
  if Application.Terminated then
    Exit;

  result := -7;
  MD5File := ChangeFileExt( fFileName, FILE_EXT_CHECKSUM_ );
  LogFile := ExtractFilePath( fFileName ) + ChangeFileExt( ExtractFileName( fFileName ), '.' + PARAMETER_LOGDATEI_EXT_ );
  {$IFDEF MD5}
  if IsFileInUse( MD5File ) then
    begin
    if ( GetCurrentThreadID = MainThreadID ) then
      ShowMessage( Format( ERROR_FILE_IN_USE_, [ MD5File ] ) );
    Exit;
    end;
  {$ENDIF}
  if Logging then
    begin
    if IsFileInUse( LogFile ) then
      begin
      if ( GetCurrentThreadID = MainThreadID ) then
        ShowMessage( Format( ERROR_FILE_IN_USE_, [ LogFile ] ) );
      Exit;
      end;
    end;
  if IsFileInUse( fFileName ) then
    begin
    if ( GetCurrentThreadID = MainThreadID ) then
      ShowMessage( Format( ERROR_FILE_IN_USE_, [ fFileName ] ) );
    Exit;
    end;

//  result := -7;
//  if NOT GetChanged then
//    begin
//    result := 0;
//    Exit;
//    end;

  bFailed  := 0;
  StrL_Log := TStringList.Create;
  sTime    := DateTimeToStr( NOW );
  {$IFDEF MD5}
  StrL     := nil;
  {$ENDIF}
  if logging then
    begin
    if FileExists( LogFile ) then
      StrL_Log.LoadFromFile( LogFile );

    if ( UserName <> '' ) then
      AddLog( Format( LOG_USERNAME_, [ UserName ] ) );
    if ( Comment <> '' ) then
      AddLog( Format( LOG_COMMENT_, [ Comment ] ) );
    end;

  while ( bFailed < PARAMETER_MAX_SAVE_ATTEMP_ ) do
    begin
    if save then
      begin
      if vCleanUp AND FileExists( fFileName ) then
        begin
        try
          SysUtils.DeleteFile( fFileName );
        except
          Inc( bFailed );
          Continue;
        end;
        end;
      fIniFile := TIniFileType.Create( fFileName );
      end
    else
      fIniFile := nil;

    for i := 0 to fCount-1 do
      begin
      Param := Items[ i ];
      if ( Param is T_PARAM_NR ) then
        AddLog( T_PARAM_NR( Param ).Save )
      else if ( Param is T_PARAM_BOOL ) then
        AddLog( T_PARAM_BOOL( Param ).Save )
      else if ( Param is T_PARAM_INT ) then
        AddLog( T_PARAM_INT( Param ).Save )
      else if ( Param is T_PARAM_INT64 ) then
        AddLog( T_PARAM_INT64( Param ).Save )
      else if ( Param is T_PARAM_REAL ) then
        AddLog( T_PARAM_REAL( Param ).Save )
      else if ( Param is T_PARAM_STR ) then
        AddLog( T_PARAM_STR( Param ).Save )
      else if ( Param is T_PARAM_STR_LIST ) then
        AddLog( T_PARAM_STR_LIST( Param ).Save )
      else if ( Param is T_PARAM_ROI ) then
        AddLog( T_PARAM_ROI( Param ).Save )
      else if ( Param is T_PARAM_AOI ) then
        AddLog( T_PARAM_AOI( Param ).Save )
      {$IF Defined( useMATHROUT ) OR Defined( useTLH_Math )}
      else if ( Param is T_PARAM_ePunkt ) then
        AddLog( T_PARAM_ePunkt( Param ).Save )
      else if ( Param is T_PARAM_eGerade ) then
        AddLog( T_PARAM_eGerade( Param ).Save )
      {$IFEND}
      else
        Continue;
      end;

    if save then
      begin
      {$IF Defined( useFastIni ) OR Defined( useMemIni ) }
      try
        {$IF Defined( useFastIni )}
        fIniFile.Save;
        {$ELSE IF Defined( useMemIni )}
        fIniFile.UpdateFile;
        {$IFEND}
      except
        Inc( bFailed );
        Continue;
      end;
      {$IFEND}

      {$IFNDEF MD5}
      if FileExists( MD5File ) then
        begin
        try
          SysUtils.DeleteFile( MD5File );
        except
          Inc( bFailed );
          Continue;
        end;
        end;
      {$ENDIF}
      {$IFDEF MD5}
      StrL    := TStringList.Create;

      {$IFDEF useFastIni}
      fIniFile.GetStringList( StrL );
      {$ELSE}
      StrL.LoadFromFile( fFileName );
      {$ENDIF}

      MD5 := GetMD5( StrL );
      StrL.Text := Format( FILE_FORMAT_MD5_, [ MD5, ExtractFileName( fFileName ) ] );
      try
        StrL.SaveToFile( MD5File );
      except
        Inc( bFailed );
        Continue;
      end;
      {$ENDIF}
      fIniFile.free;
      fIniFile := nil;

      if FileExists( fFileName ) then
        begin
        {$IFDEF MD5}
        StrL.LoadFromFile( fFileName );
        if ( GetMD5( StrL ) = MD5 ) then
        {$ENDIF}
          begin
          if MasterBackup then
            begin
            try
              bCopy := CopyFile( PChar( fFileName ), PChar( ChangeFileExt( fFileName, RightStr( FILE_EXT_MASTER_, Length( FILE_EXT_MASTER_ )-2 ) ) ), false );
            except
              bCopy := false;
              Inc( bFailed );
              Continue;
            end;
            if bCopy then
              begin
              {$IFDEF MD5}
              StrL.LoadFromFile( ChangeFileExt( fFileName, RightStr( FILE_EXT_MASTER_, Length( FILE_EXT_MASTER_ )-2 ) ) );
              if ( GetMD5( StrL ) = MD5 ) then
                begin
                try
                if NOT CopyFile( PChar( MD5File ), PChar( ChangeFileExt( fFileName, FILE_EXT_MASTER_MD5_ ) ), false ) then
                  result := -6;
                except
                  result := -6;
                  Inc( bFailed );
                  Continue;
                end;
                end
              else
                result := -5;
              {$ENDIF}
              end
            else
              result := -4;
            end{$IFNDEF AutoBackup};{$ENDIF}
          {$IFDEF AutoBackup}
          else
            begin
            if NOT NoAutoBackup then
              begin
              try
                bCopy := CopyFile( PChar( fFileName ), PChar( ChangeFileExt( fFileName, Format( '_%s' + FILE_EXT_BACKUP_, [ FormatDateTime( 'yyyy-mm-dd', NOW ) ] ) ) ), false );
              except
                bCopy := false;
                Inc( bFailed );
                Continue;
              end;
              if bCopy then
                begin
                {$IFDEF MD5}
                StrL.LoadFromFile( ChangeFileExt( fFileName, Format( '_%s' + FILE_EXT_BACKUP_, [ FormatDateTime( 'yyyy-mm-dd', NOW ) ] ) ) );
                if ( GetMD5( StrL ) = MD5 ) then
                  begin
                  try
                  if NOT CopyFile( PChar( MD5File ), PChar( ChangeFileExt( fFileName, Format( '_%s' + FILE_EXT_CHECKSUM_, [ FormatDateTime( 'yyyy-mm-dd', NOW ) ] ) ) ), false ) then
                    result := -3;
                  except
                    result := -3;
                    Inc( bFailed );
                    Continue;
                  end;
                  end
                else
                  result := -2;
                {$ENDIF}
                end
              else
                result := -1;
              end;

            CleanUp;
            end;
          {$ENDIF}
          break;
          end;
        end;
      Inc( bFailed );
      end
    else
      break;
    end;
  if NOT ( bFailed >= PARAMETER_MAX_SAVE_ATTEMP_ ) then
    begin
    if logging then
      begin
      while StrL_Log.Count > Max( 1, PARAMETER_LOGDATEI_MAX_LINES_ ) do
        StrL_Log.Delete( 0 );

      if ( StrL_Log.Text <> '' ) then
        begin
        try
          StrL_Log.SaveToFile( LogFile );
        except
        end;
        end;
      end;
    Result := 0;
    end;
  StrL_Log.free;
  {$IFDEF MD5}
  if Save then
    StrL.free;
  {$ENDIF}

  UnHighlightChangedValues;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function T_INI_DATEI.GetChanged : boolean;
  function FloatIsNotEqual( value1, value2 : Extended ): boolean;
  const
    EPS : extended = 1.0E-8;
  begin
    result := Abs( value1 - value2 ) > EPS
  end;
var
  i     : integer;
  Param : T_PARAM_BASE;
begin
  result := False;
  if NOT Assigned( self ) then
    Exit;

  for i := 0 to fCount-1 do
    begin
    if result then
      Break;
    Param := Items[ i ];
    if ( Param is T_PARAM_ROI ) then
      begin
      if Assigned( T_PARAM_ROI( Param ).x1 ) then
        begin
        result := result OR T_PARAM_ROI( Param ).x1.Changed;
        result := result OR ( T_PARAM_ROI( Param ).x1.fBackupValue <> T_PARAM_ROI( Param ).x1.fValue );
        end;
      if Assigned( T_PARAM_ROI( Param ).y1 ) then
        begin
        result := result OR T_PARAM_ROI( Param ).y1.Changed;
        result := result OR ( T_PARAM_ROI( Param ).y1.fBackupValue <> T_PARAM_ROI( Param ).y1.fValue );
        end;

      if Assigned( T_PARAM_ROI( Param ).x2 ) then
        begin
        result := result OR T_PARAM_ROI( Param ).x2.Changed;
        result := result OR ( T_PARAM_ROI( Param ).x2.fBackupValue <> T_PARAM_ROI( Param ).x2.fValue );
        end;
      if Assigned( T_PARAM_ROI( Param ).y2 ) then
        begin
        result := result OR T_PARAM_ROI( Param ).y2.Changed;
        result := result OR ( T_PARAM_ROI( Param ).y2.fBackupValue <> T_PARAM_ROI( Param ).y2.fValue );
        end;
      end
    else if ( Param is T_PARAM_AOI ) then
      begin
      if Assigned( T_PARAM_AOI( Param ).TopLeftX ) then
        begin
        result := result OR T_PARAM_AOI( Param ).TopLeftX.Changed;
        result := result OR FloatIsNotEqual( T_PARAM_AOI( Param ).TopLeftX.fBackupValue, T_PARAM_AOI( Param ).TopLeftX.fValue );
        end;
      if Assigned( T_PARAM_AOI( Param ).TopLeftY ) then
        begin
        result := result OR T_PARAM_AOI( Param ).TopLeftY.Changed;
        result := result OR FloatIsNotEqual( T_PARAM_AOI( Param ).TopLeftY.fBackupValue, T_PARAM_AOI( Param ).TopLeftY.fValue );
        end;

      if Assigned( T_PARAM_AOI( Param ).TopRightX ) then
        begin
        result := result OR T_PARAM_AOI( Param ).TopRightX.Changed;
        result := result OR FloatIsNotEqual( T_PARAM_AOI( Param ).TopRightX.fBackupValue, T_PARAM_AOI( Param ).TopRightX.fValue );
        end;
      if Assigned( T_PARAM_AOI( Param ).TopRightY ) then
        begin
        result := result OR T_PARAM_AOI( Param ).TopRightY.Changed;
        result := result OR FloatIsNotEqual( T_PARAM_AOI( Param ).TopRightY.fBackupValue, T_PARAM_AOI( Param ).TopRightY.fValue );
        end;

      if Assigned( T_PARAM_AOI( Param ).BottomLeftX ) then
        begin
        result := result OR T_PARAM_AOI( Param ).BottomLeftX.Changed;
        result := result OR FloatIsNotEqual( T_PARAM_AOI( Param ).BottomLeftX.fBackupValue, T_PARAM_AOI( Param ).BottomLeftX.fValue );
        end;
      if Assigned( T_PARAM_AOI( Param ).BottomLeftY ) then
        begin
        result := result OR T_PARAM_AOI( Param ).BottomLeftY.Changed;
        result := result OR FloatIsNotEqual( T_PARAM_AOI( Param ).BottomLeftY.fBackupValue, T_PARAM_AOI( Param ).BottomLeftY.fValue );
        end;

      if Assigned( T_PARAM_AOI( Param ).BottomRightX ) then
        begin
        result := result OR T_PARAM_AOI( Param ).BottomRightX.Changed;
        result := result OR FloatIsNotEqual( T_PARAM_AOI( Param ).BottomRightX.fBackupValue, T_PARAM_AOI( Param ).BottomRightX.fValue );
        end;
      if Assigned( T_PARAM_AOI( Param ).BottomRightY ) then
        begin
        result := result OR T_PARAM_AOI( Param ).BottomRightY.Changed;
        result := result OR FloatIsNotEqual( T_PARAM_AOI( Param ).BottomRightY.fBackupValue, T_PARAM_AOI( Param ).BottomRightY.fValue );
        end;
      end
    else
      begin
      result := T_PARAM_ALLGEMEIN( Param ).Changed;
      if result then
        Break;

      if ( Param is T_PARAM_NR ) then
        result := ( T_PARAM_NR( Param ).fBackupValue <> T_PARAM_NR( Param ).fValue )
      else if ( Param is T_PARAM_BOOL ) then
        result := ( T_PARAM_BOOL( Param ).fBackupValue <> T_PARAM_BOOL( Param ).fValue )
      else if ( Param is T_PARAM_INT ) then
        result := ( T_PARAM_INT( Param ).fBackupValue <> T_PARAM_INT( Param ).fValue )
      else if ( Param is T_PARAM_INT64 ) then
        result := ( T_PARAM_INT64( Param ).fBackupValue <> T_PARAM_INT64( Param ).fValue )
      else if ( Param is T_PARAM_REAL ) then
        result := FloatIsNotEqual( T_PARAM_REAL( Param ).fBackupValue, T_PARAM_REAL( Param ).fValue )
      else if ( Param is T_PARAM_STR ) then
        result := ( T_PARAM_STR( Param ).fBackupValue <> T_PARAM_STR( Param ).fValue )
      else if ( Param is T_PARAM_STR_LIST ) then
        result := ( T_PARAM_STR_LIST( Param ).fBackupValue.Text <> T_PARAM_STR_LIST( Param ).fValue.Text )
      {$IF Defined( useMATHROUT ) OR Defined( useTLH_Math )}
      else if ( Param is T_PARAM_ePunkt ) then
        result := FloatIsNotEqual( T_PARAM_ePunkt( Param ).fBackupValue.X, T_PARAM_ePunkt( Param ).fValue.X ) OR FloatIsNotEqual( T_PARAM_ePunkt( Param ).fBackupValue.Y, T_PARAM_ePunkt( Param ).fValue.Y )
      else if ( Param is T_PARAM_eGerade ) then
        result := FloatIsNotEqual( T_PARAM_eGerade( Param ).fBackupValue.NX, T_PARAM_eGerade( Param ).fValue.NX ) OR FloatIsNotEqual( T_PARAM_eGerade( Param ).fBackupValue.NY, T_PARAM_eGerade( Param ).fValue.NY ) OR FloatIsNotEqual( T_PARAM_eGerade( Param ).fBackupValue.C, T_PARAM_eGerade( Param ).fValue.C )
      {$IFEND}
      else
        Continue;
      end;
    end;
end;

function T_INI_DATEI.GetInited : boolean;
begin
  result := false;
  if NOT Assigned( self ) then
    Exit;
  result := fInited;
end;

function T_INI_DATEI.HasVCL : Boolean;
var
  i     : integer;
  Param : T_PARAM_BASE;
begin
  result := false;
  for i := 0 to fCount-1 do
    begin
    if result then
      Break;
    Param := Items[ i ];
    if ( Param is T_PARAM_ROI ) then
      begin
      if Assigned( T_PARAM_ROI( Param ).x1 ) then
        result := result OR Assigned( T_PARAM_ROI( Param ).x1.fObject );
      if Assigned( T_PARAM_ROI( Param ).y1 ) then
        result := result OR Assigned( T_PARAM_ROI( Param ).y1.fObject );

      if Assigned( T_PARAM_ROI( Param ).x2 ) then
        result := result OR Assigned( T_PARAM_ROI( Param ).x2.fObject );
      if Assigned( T_PARAM_ROI( Param ).y2 ) then
        result := result OR Assigned( T_PARAM_ROI( Param ).y2.fObject );
      end
    else if ( Param is T_PARAM_AOI ) then
      begin
      if Assigned( T_PARAM_AOI( Param ).TopLeftX ) then
        result := result OR Assigned( T_PARAM_AOI( Param ).TopLeftX.fObject );
      if Assigned( T_PARAM_AOI( Param ).TopLeftY ) then
        result := result OR Assigned( T_PARAM_AOI( Param ).TopLeftY.fObject );

      if Assigned( T_PARAM_AOI( Param ).TopRightX ) then
        result := result OR Assigned( T_PARAM_AOI( Param ).TopRightX.fObject );
      if Assigned( T_PARAM_AOI( Param ).TopRightY ) then
        result := result OR Assigned( T_PARAM_AOI( Param ).TopRightY.fObject );

      if Assigned( T_PARAM_AOI( Param ).BottomLeftX ) then
        result := result OR Assigned( T_PARAM_AOI( Param ).BottomLeftX.fObject );
      if Assigned( T_PARAM_AOI( Param ).BottomLeftY ) then
        result := result OR Assigned( T_PARAM_AOI( Param ).BottomLeftY.fObject );

      if Assigned( T_PARAM_AOI( Param ).BottomRightX ) then
        result := result OR Assigned( T_PARAM_AOI( Param ).BottomRightX.fObject );
      if Assigned( T_PARAM_AOI( Param ).BottomRightY ) then
        result := result OR Assigned( T_PARAM_AOI( Param ).BottomRightY.fObject );
      end
    {$IF Defined( useMATHROUT ) OR Defined( useTLH_Math )}
    else if ( Param is T_PARAM_ePunkt ) then
      result := result OR Assigned( T_PARAM_ePunkt( Param ).fObject ) OR Assigned( T_PARAM_ePunkt( Param ).fObjectY )
    else if ( Param is T_PARAM_eGerade ) then
      result := result OR Assigned( T_PARAM_eGerade( Param ).fObject ) OR Assigned( T_PARAM_eGerade( Param ).fObjectNY ) OR Assigned( T_PARAM_eGerade( Param ).fObjectC )
    {$IFEND}
    else if ( Param is T_PARAM_ALLGEMEIN ) then
      result := result OR Assigned( T_PARAM_ALLGEMEIN( Param ).fObject );
    end;
end;

function T_INI_DATEI.GetIsAllDefault : boolean;
var
  i     : integer;
  Param : T_PARAM_BASE;
begin
  result := True;
  if NOT Assigned( self ) then
    Exit;

  for i := 0 to fCount-1 do
    begin
    if NOT result then
      Break;
    Param := Items[ i ];
    if ( Param is T_PARAM_ROI ) then
      begin
      if Assigned( T_PARAM_ROI( Param ).x1 ) then
        result := result AND NOT T_PARAM_ROI( Param ).x1.fLoaded;
      if Assigned( T_PARAM_ROI( Param ).y1 ) then
        result := result AND NOT T_PARAM_ROI( Param ).y1.fLoaded;

      if Assigned( T_PARAM_ROI( Param ).x2 ) then
        result := result AND NOT T_PARAM_ROI( Param ).x2.fLoaded;
      if Assigned( T_PARAM_ROI( Param ).y2 ) then
        result := result AND NOT T_PARAM_ROI( Param ).y2.fLoaded;
      end
    else if ( Param is T_PARAM_AOI ) then
      begin
      if Assigned( T_PARAM_AOI( Param ).TopLeftX ) then
        result := result AND NOT T_PARAM_AOI( Param ).TopLeftX.fLoaded;
      if Assigned( T_PARAM_AOI( Param ).TopLeftY ) then
        result := result AND NOT T_PARAM_AOI( Param ).TopLeftY.fLoaded;

      if Assigned( T_PARAM_AOI( Param ).TopRightX ) then
        result := result AND NOT T_PARAM_AOI( Param ).TopRightX.fLoaded;
      if Assigned( T_PARAM_AOI( Param ).TopRightY ) then
        result := result AND NOT T_PARAM_AOI( Param ).TopRightY.fLoaded;

      if Assigned( T_PARAM_AOI( Param ).BottomLeftX ) then
        result := result AND NOT T_PARAM_AOI( Param ).BottomLeftX.fLoaded;
      if Assigned( T_PARAM_AOI( Param ).BottomLeftY ) then
        result := result AND NOT T_PARAM_AOI( Param ).BottomLeftY.fLoaded;

      if Assigned( T_PARAM_AOI( Param ).BottomRightX ) then
        result := result AND NOT T_PARAM_AOI( Param ).BottomRightX.fLoaded;
      if Assigned( T_PARAM_AOI( Param ).BottomRightY ) then
        result := result AND NOT T_PARAM_AOI( Param ).BottomRightY.fLoaded;
      end
    else
      result := result AND NOT T_PARAM_ALLGEMEIN( Param ).fLoaded;
    end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//***  T_PARAM_INT  ************************************************************
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Procedure T_INI_DATEI.Init_IntParam( var param : T_PARAM_INT; def, min, max: integer; iniName: string; vObject: TObject = nil );
begin
  if NOT Assigned( self ) then
    Exit;

  if NoVCL then
    vObject := nil;

  if NOT Assigned( param ) then
    param := T_PARAM_INT.Create( self, fSection, def, min, max, iniName, vObject );

  param.Load;
end;
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Constructor T_PARAM_INT.Create( AOwner : T_INI_DATEI; iniSection: string; def, min, max: integer; iniName: string; vObject: TObject = nil );
var
  Notify   : TNotifyEvent;
  Method   : System.TMethod absolute Notify;
  KeyPress : TKeyPressEvent;
  KMethod  : System.TMethod absolute KeyPress;
begin
  if ( vObject <> nil ) then
    begin
    if ( NOT IsPublishedProp( vObject, 'Text' ) ) then
      Raise Exception.Create( Format( ERROR_WRONG_PROPERTY_1_, [ ClassName ] ) +
                              Format( ERROR_WRONG_PROPERTY_2_, [ ClassName ] ) +
                              Format( ERROR_WRONG_PROPERTY_3_, [ 'Text-' ] )
                            );
    end;

  inherited Create( AOwner, iniSection, iniName, vObject );

  if Assigned( vObject ) then
    begin
    if IsPublishedProp( vObject, 'OnKeyPress' ) then
      begin
      KMethod := GetMethodProp( vObject, 'OnKeyPress' );
      if NOT MethodIsEqual( KMethod, originalOnKeyPress ) then
        originalOnKeyPress := KeyPress;
      KeyPress := EditIntZahlKeyPress;
      SetMethodProp( vObject, 'OnKeyPress', KMethod );
      end;
    if IsPublishedProp( vObject, 'OnExit' ) then
      begin
      Method := GetMethodProp( vObject, 'OnExit' );
      if NOT MethodIsEqual( Method, originalOnExit ) then
        originalOnExit := Notify;
      Notify := CheckGrenzwerte;
      SetMethodProp( vObject, 'OnExit', Method );
      end;
    end;

  if ( min = 0 ) AND ( max = 0 ) then
    begin
    fMinimum := Low( Integer );
    fMaximum := High( Integer );
    end
  else
    begin
    fMinimum := min;
    fMaximum := max;
    end;

  fDefault := def;
end;

destructor T_PARAM_INT.Destroy;
var
  KEvent  : TKeyPressEvent;
  KMethod : System.TMethod absolute KEvent;
  Event   : TNotifyEvent;
  Method  : System.TMethod absolute Event;
begin
  if Assigned( fObject ) then
    begin
    if ( NOT Application.Terminated ) then
      begin
      KEvent := originalOnKeyPress;
      if IsPublishedProp( fObject, 'OnKeyPress' ) then
        SetMethodProp( fObject, 'OnKeyPress', KMethod );

      Event := originalOnExit;
      if IsPublishedProp( fObject, 'OnExit' ) then
        SetMethodProp( fObject, 'OnExit', Method );
      end;
    end;

  inherited;
end;

procedure T_PARAM_INT.Assign( Param : T_PARAM_ALLGEMEIN );
begin
  if NOT Assigned( Self ) then
    Exit;
  if NOT Assigned( Param ) then
    Exit;
  if NOT ( Param is T_PARAM_INT ) then
    Exit;
  inherited;

  fMinimum           := T_PARAM_INT( Param ).fMinimum;
  fMaximum           := T_PARAM_INT( Param ).fMaximum;
  fDefault           := T_PARAM_INT( Param ).fDefault;
  fValue             := T_PARAM_INT( Param ).fValue;
  fBackupValue       := T_PARAM_INT( Param ).fBackupValue;

  {$IFDEF ASSIGN_VCL}
  originalOnExit     := T_PARAM_INT( Param ).originalOnExit;
  originalOnKeyPress := T_PARAM_INT( Param ).originalOnKeyPress;
  ValueToVCL;
  {$ENDIF}
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Procedure T_PARAM_INT.CheckGrenzwerte( Sender:TObject );
var
  x : integer;
begin
  if NOT Assigned( self ) then
    Exit;

  if IsPublishedProp( Sender, 'Text' ) then
    begin
    x := StrToIntDef( GetPropValue( Sender, 'Text' ), fDefault );
    if x < fMinimum  then
      x := fMinimum
    else if x > fMaximum  then
      x := fMaximum;
    SetPropValue( Sender, 'Text', IntToStr( x ) );
    end;

  if Assigned( originalOnExit ) then
    originalOnExit( Sender );
end;
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure T_PARAM_INT.Load;
begin
  if NOT Assigned( self ) then
    Exit;
  if NOT Assigned( fOwner ) then
    Exit;

  fValue := fDefault;
  fLoaded := Assigned( fOwner.fIniFile ) AND ValueExists( fOwner.fIniFile, fSection, fName );
  if fLoaded then
    fValue := fOwner.fIniFile.ReadInteger( fSection, fName, fDefault );
  fBackupValue := fValue;
  fChanged := false;

  ValueToVCL;
end;

function T_PARAM_INT.Save : string;
begin
  result := '';
  if NOT Assigned( self ) then
    Exit;
  if NOT Assigned( fOwner ) then
    Exit;

  if fChanged AND VCLAccessAllowed then
    VCLToValue;

  if Assigned( fOwner.fIniFile ) then
    begin
    {$IF NOT Defined( useFastIni ) AND NOT Defined( useMemIni ) AND NOT Defined( useRegistryIni ) }
    try
    {$IFEND}
      fOwner.fIniFile.WriteInteger( fSection, fName, fValue );    
    {$IF NOT Defined( useFastIni ) AND NOT Defined( useMemIni ) AND NOT Defined( useRegistryIni ) }
    except
    end;
    {$IFEND}
    if ( fBackupValue <> fValue ) then
      result := Format( LOG_INTEGER_, [ BeautifyClassName( Self ), fName, fBackupValue, fValue ] );
    fBackupValue := fValue;
    end;

  inherited Save;
end;

procedure T_PARAM_INT.VCLToValue;
begin
  if NOT Assigned( fObject ) then
    Exit;
  if ( GetCurrentThreadID <> MainThreadID ) then
    Exit;

  if IsPublishedProp( fObject, 'text' ) then
    fValue := StrToIntDef( GetPropValue( fObject, 'Text' ), fDefault );
end;

procedure T_PARAM_INT.ValueToVCL;
{$IFNDEF SetValueRaiseOnChange}
var
  Method : System.TMethod;
{$ENDIF}
begin
  if NOT Assigned( fObject ) then
    Exit;
  if ( GetCurrentThreadID <> MainThreadID ) then
    Exit;

  {$IFNDEF SetValueRaiseOnChange}
  UnsetOnChange( fObject, Method );
  {$ENDIF}

  if IsPublishedProp( fObject, 'text' ) then
    SetPropValue( fObject, 'text', IntToStr( fValue ) );

  {$IFNDEF SetValueRaiseOnChange}
  ResetOnChange( fObject, Method );
  {$ENDIF}
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Procedure T_PARAM_INT.EditIntZahlKeyPress( Sender:TObject; var Key:char );
begin
  if Assigned( originalOnKeyPress ) then
    originalOnKeyPress( Sender, Key );

  if IsPublishedProp( fObject, 'text' ) then
    OnKeyPressCheckChar( Sender, Key, kpmSigned );
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function T_PARAM_INT.GetValue : Integer;
begin
  result := 0;
  if NOT Assigned( self ) then
    Exit;

  {$IFDEF CriticalSections}
  fCrit.Enter;
  {$ENDIF}
  result := fValue;
  {$IFDEF CriticalSections}
  fCrit.Leave;
  {$ENDIF}
end;

Procedure T_PARAM_INT.SetValue( Value: Integer );
begin
  if NOT Assigned( self ) then
    Exit;

  {$IFDEF CriticalSections}
  fCrit.Enter;
  {$ENDIF}
  fValue := Min( fMaximum, Max( fMinimum, Value ) );
  {$IFDEF CriticalSections}
  fCrit.Leave;
  {$ENDIF}
  if NoVCL then
    Exit;
  ValueToVCL;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//***  T_PARAM_INT64  **********************************************************
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Procedure T_INI_DATEI.Init_INT64Param( var param : T_PARAM_INT64; def, min, max: Int64; iniName: string; vObject: TObject = nil );
begin
  if NOT Assigned( self ) then
    Exit;

  if NoVCL then
    vObject := nil;

  if NOT Assigned( param ) then
    param := T_PARAM_INT64.Create( self, fSection, def, min, max, iniName, vObject );

  param.Load;
end;
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Constructor T_PARAM_INT64.Create( AOwner : T_INI_DATEI; iniSection: string; def, min, max: Int64; iniName: string; vObject: TObject = nil );
var
  Notify   : TNotifyEvent;
  Method   : System.TMethod absolute Notify;
  KeyPress : TKeyPressEvent;
  KMethod  : System.TMethod absolute KeyPress;
begin
  if ( vObject <> nil ) then
    begin
    if ( NOT IsPublishedProp( vObject, 'Text' ) ) then
      Raise Exception.Create( Format( ERROR_WRONG_PROPERTY_1_, [ ClassName ] ) +
                              Format( ERROR_WRONG_PROPERTY_2_, [ ClassName ] ) +
                              Format( ERROR_WRONG_PROPERTY_3_, [ 'Text-' ] )
                            );
    end;

  inherited Create( AOwner, iniSection, iniName, vObject );
  if Assigned( vObject ) then
    begin
    if IsPublishedProp( vObject, 'OnKeyPress' ) then
      begin
      KMethod := GetMethodProp( vObject, 'OnKeyPress' );
      if NOT MethodIsEqual( KMethod, originalOnKeyPress ) then
        originalOnKeyPress := KeyPress;
      KeyPress := EditIntZahlKeyPress;
      SetMethodProp( vObject, 'OnKeyPress', KMethod );
      end;
    if IsPublishedProp( vObject, 'OnExit' ) then
      begin
      Method := GetMethodProp( vObject, 'OnExit' );
      if NOT MethodIsEqual( Method, originalOnExit ) then
        originalOnExit := Notify;
      Notify := CheckGrenzwerte;
      SetMethodProp( vObject, 'OnExit', Method );
      end;
    end;

  if ( min = 0 ) AND ( max = 0 ) then
    begin
    fMinimum := Low( Int64 );
    fMaximum := High( Int64 );
    end
  else
    begin
    fMinimum := min;
    fMaximum := max;
    end;

  fDefault := def;
end;

destructor T_PARAM_INT64.Destroy;
var
  KEvent  : TKeyPressEvent;
  KMethod : System.TMethod absolute KEvent;
  Event   : TNotifyEvent;
  Method  : System.TMethod absolute Event;
begin
  if Assigned( fObject ) then
    begin
    if ( NOT Application.Terminated ) then
      begin
      KEvent := originalOnKeyPress;
      if IsPublishedProp( fObject, 'OnKeyPress' ) then
        SetMethodProp( fObject, 'OnKeyPress', KMethod );

      Event := originalOnExit;
      if IsPublishedProp( fObject, 'OnExit' ) then
        SetMethodProp( fObject, 'OnExit', Method );
      end;
    end;

  inherited;
end;

procedure T_PARAM_INT64.Assign( Param : T_PARAM_ALLGEMEIN );
begin
  if NOT Assigned( Self ) then
    Exit;
  if NOT Assigned( Param ) then
    Exit;
  if NOT ( Param is T_PARAM_INT64 ) then
    Exit;
  inherited;

  fMinimum           := T_PARAM_INT64( Param ).fMinimum;
  fMaximum           := T_PARAM_INT64( Param ).fMaximum;
  fDefault           := T_PARAM_INT64( Param ).fDefault;
  fValue             := T_PARAM_INT64( Param ).fValue;
  fBackupValue       := T_PARAM_INT64( Param ).fBackupValue;

  {$IFDEF ASSIGN_VCL}
  originalOnExit     := T_PARAM_INT( Param ).originalOnExit;
  originalOnKeyPress := T_PARAM_INT( Param ).originalOnKeyPress;
  ValueToVCL;
  {$ENDIF}
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Procedure T_PARAM_INT64.CheckGrenzwerte( Sender:TObject );
var
  x : Int64;
begin
  if NOT Assigned( self ) then
    Exit;

  if IsPublishedProp( Sender, 'Text' ) then
    begin
    x := StrToInt64Def( GetPropValue( Sender, 'Text' ), fDefault );
    if x < fMinimum  then
      x := fMinimum
    else if x > fMaximum  then
      x := fMaximum;
    SetPropValue( Sender, 'Text', IntToStr( x ) );
    end;

  if Assigned( originalOnExit ) then
    originalOnExit( Sender );
end;
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure T_PARAM_INT64.Load;
begin
  if NOT Assigned( self ) then
    Exit;
  if NOT Assigned( fOwner ) then
    Exit;

  fValue := fDefault;
  fLoaded := Assigned( fOwner.fIniFile ) AND ValueExists( fOwner.fIniFile, fSection, fName );
  if fLoaded then
    fValue := StrToInt64Def( fOwner.fIniFile.ReadString( fSection, fName, IntToStr( fDefault ) ), fDefault );
  fBackupValue := fValue;
  fChanged := false;

  ValueToVCL;
end;

function T_PARAM_INT64.Save : string;
begin
  result := '';
  if NOT Assigned( self ) then
    Exit;
  if NOT Assigned( fOwner ) then
    Exit;

  if fChanged AND VCLAccessAllowed then
    VCLToValue;

  if Assigned( fOwner.fIniFile ) then
    begin
    {$IF NOT Defined( useFastIni ) AND NOT Defined( useMemIni ) AND NOT Defined( useRegistryIni ) }
    try
    {$IFEND}
      fOwner.fIniFile.WriteInteger( fSection, fName, fValue );
    {$IF NOT Defined( useFastIni ) AND NOT Defined( useMemIni ) AND NOT Defined( useRegistryIni ) }
    except
    end;
    {$IFEND}
    if ( fBackupValue <> fValue ) then
      result := Format( LOG_INTEGER_, [ BeautifyClassName( Self ), fName, fBackupValue, fValue ] );
    fBackupValue := fValue;
    end;

  inherited Save;
end;

procedure T_PARAM_INT64.VCLToValue;
begin
  if NOT Assigned( fObject ) then
    Exit;
  if ( GetCurrentThreadID <> MainThreadID ) then
    Exit;

  if IsPublishedProp( fObject, 'text' ) then
    fValue := StrToInt64Def( GetPropValue( fObject, 'Text' ), fDefault );
end;

procedure T_PARAM_INT64.ValueToVCL;
{$IFNDEF SetValueRaiseOnChange}
var
  Method : System.TMethod;
{$ENDIF}
begin
  if NOT Assigned( fObject ) then
    Exit;
  if ( GetCurrentThreadID <> MainThreadID ) then
    Exit;

  {$IFNDEF SetValueRaiseOnChange}
  UnsetOnChange( fObject, Method );
  {$ENDIF}

  if IsPublishedProp( fObject, 'text' ) then
    SetPropValue( fObject, 'text', IntToStr( fValue ) );

  {$IFNDEF SetValueRaiseOnChange}
  ResetOnChange( fObject, Method );
  {$ENDIF}
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Procedure T_PARAM_INT64.EditIntZahlKeyPress( Sender:TObject; var Key:char );
begin
  if Assigned( originalOnKeyPress ) then
    originalOnKeyPress( Sender, Key );

  if IsPublishedProp( fObject, 'text' ) then
    OnKeyPressCheckChar( Sender, Key, kpmSigned );
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function T_PARAM_INT64.GetValue : Int64;
begin
  result := 0;
  if NOT Assigned( self ) then
    Exit;

  {$IFDEF CriticalSections}
  fCrit.Enter;
  {$ENDIF}
  result := fValue;
  {$IFDEF CriticalSections}
  fCrit.Leave;
  {$ENDIF}
end;

Procedure T_PARAM_INT64.SetValue( Value: Int64 );
begin
  if NOT Assigned( self ) then
    Exit;

  {$IFDEF CriticalSections}
  fCrit.Enter;
  {$ENDIF}
  fValue := Min( fMaximum, Max( fMinimum, Value ) );
  {$IFDEF CriticalSections}
  fCrit.Leave;
  {$ENDIF}
  if NoVCL then
    Exit;
  ValueToVCL;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//***  T_PARAM_NR  *************************************************************
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Procedure T_INI_DATEI.Init_NrParam( var param : T_PARAM_NR; def: integer; iniName: string; vObject: TObject = nil );
begin
  if NOT Assigned( self ) then
    Exit;

  if NoVCL then
    vObject := nil;

  if NOT Assigned( param ) then
    param := T_PARAM_NR.Create( self, fSection, def, iniName, vObject );

  param.Load;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Constructor T_PARAM_NR.Create( AOwner : T_INI_DATEI; iniSection: string; def: integer; iniName: string; vObject: TObject = nil );
begin
  if ( vObject <> nil ) then
    begin
    if ( ( NOT IsPublishedProp( vObject, 'ItemIndex' ) ) AND
       ( NOT IsPublishedProp( vObject, 'Position'  ) ) AND
       ( NOT IsPublishedProp( vObject, 'Value'     ) ) AND
       ( NOT IsPublishedProp( vObject, 'Selected'  ) ) ) AND
         NOT ( vObject is TListBox ) AND NOT ( vObject is TComboBox ) AND NOT ( vObject is TCustomComboBox ) then
      Raise Exception.Create( Format( ERROR_WRONG_PROPERTY_1_, [ ClassName ] ) +
                              Format( ERROR_WRONG_PROPERTY_2_, [ ClassName ] ) +
                              Format( ERROR_WRONG_PROPERTY_3_, [ 'ItemIndex-, Position-, Value- oder Selected-' ] )
                            );
    end;

  inherited Create( AOwner, iniSection, iniName, vObject );
  fDefault := def;
end;

procedure T_PARAM_NR.Assign( Param : T_PARAM_ALLGEMEIN );
begin
  if NOT Assigned( Self ) then
    Exit;
  if NOT Assigned( Param ) then
    Exit;
  if NOT ( Param is T_PARAM_NR ) then
    Exit;
  inherited;

  fDefault      := T_PARAM_NR( Param ).fDefault;
  fValue        := T_PARAM_NR( Param ).fValue;
  fBackupValue  := T_PARAM_NR( Param ).fBackupValue;

  {$IFDEF ASSIGN_VCL}
  ValueToVCL;
  {$ENDIF}
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure T_PARAM_NR.Load;
begin
  if NOT Assigned( self ) then
    Exit;
  if NOT Assigned( fOwner ) then
    Exit;

  fValue := fDefault;
  fLoaded := Assigned( fOwner.fIniFile ) AND ValueExists( fOwner.fIniFile, fSection, fName );
  if fLoaded then
    fValue := fOwner.fIniFile.ReadInteger( fSection, fName, fDefault );
  fBackupValue := fValue;
  fChanged := false;

  ValueToVCL;
end;

function T_PARAM_NR.Save : string;
begin
  result := '';
  if NOT Assigned( self ) then
    Exit;
  if NOT Assigned( fOwner ) then
    Exit;

  if fChanged AND VCLAccessAllowed then
    VCLToValue;

  if Assigned( fOwner.fIniFile ) then
    begin
    {$IF NOT Defined( useFastIni ) AND NOT Defined( useMemIni ) AND NOT Defined( useRegistryIni ) }
    try
    {$IFEND}
      fOwner.fIniFile.WriteInteger( fSection, fName, fValue );    
    {$IF NOT Defined( useFastIni ) AND NOT Defined( useMemIni ) AND NOT Defined( useRegistryIni ) }
    except
    end;
    {$IFEND}
    if fBackupValue <> fValue then
      result := Format( LOG_INTEGER_, [ BeautifyClassName( Self ), fName, fBackupValue, fValue ] );
    fBackupValue := fValue;
    end;

  inherited Save;
end;

procedure T_PARAM_NR.VCLToValue;
begin
  if NOT Assigned( fObject ) then
    Exit;
  if ( GetCurrentThreadID <> MainThreadID ) then
    Exit;

  if ( fObject is TListBox ) then
    fValue := TListBox( fObject ).ItemIndex
  else if ( fObject is TCustomComboBox ) then
    fValue := TCustomComboBox( fObject ).ItemIndex

  else if IsPublishedProp( fObject, 'ItemIndex' ) then
    fValue := GetPropValue( fObject, 'ItemIndex' )
  else if IsPublishedProp( fObject, 'Position'  ) then
    fValue := GetPropValue( fObject, 'Position' )
  else if IsPublishedProp( fObject, 'Value'     ) then
    fValue := GetPropValue( fObject, 'Value' )
  else if IsPublishedProp( fObject, 'Selected'  ) then
    fValue := GetPropValue( fObject, 'Selected' );
end;

procedure T_PARAM_NR.ValueToVCL;
{$IFNDEF SetValueRaiseOnChange}
var
  Method : System.TMethod;
{$ENDIF}
begin
  if NOT Assigned( fObject ) then
    Exit;
  if ( GetCurrentThreadID <> MainThreadID ) then
    Exit;

  {$IFNDEF SetValueRaiseOnChange}
  UnsetOnChange( fObject, Method );
  {$ENDIF}

  if ( fObject is TListBox ) then
    TListBox( fObject ).ItemIndex := fValue
  else if ( fObject is TCustomComboBox ) then
    TCustomComboBox( fObject ).ItemIndex := fValue

  else if IsPublishedProp( fObject, 'ItemIndex' ) then
    SetPropValue( fObject, 'ItemIndex', fValue )
  else if IsPublishedProp( fObject, 'Position'  ) then
    SetPropValue( fObject, 'Position', fValue )
  else if IsPublishedProp( fObject, 'Value'     ) then
    SetPropValue( fObject, 'Value', fValue )
  else if IsPublishedProp( fObject, 'Selected'  ) then
    SetPropValue( fObject, 'Selected', fValue );

  {$IFNDEF SetValueRaiseOnChange}
  ResetOnChange( fObject, Method );
  {$ENDIF}
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function T_PARAM_NR.GetValue : Integer;
begin
  result := 0;
  if NOT Assigned( self ) then
    Exit;

  {$IFDEF CriticalSections}
  fCrit.Enter;
  {$ENDIF}
  result := fValue;
  {$IFDEF CriticalSections}
  fCrit.Leave;
  {$ENDIF}
end;

Procedure T_PARAM_NR.SetValue( Value: Integer );
begin
  if NOT Assigned( self ) then
    Exit;

  {$IFDEF CriticalSections}
  fCrit.Enter;
  {$ENDIF}
  fValue := Value;
  {$IFDEF CriticalSections}
  fCrit.Leave;
  {$ENDIF}
  if NoVCL then
    Exit;
  ValueToVCL;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//***  T_PARAM_REAL  ***********************************************************
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Procedure T_INI_DATEI.Init_RealParam( var param : T_PARAM_REAL; def, min, max: double; iniName: string; vObject: TObject = nil );
begin
  if NOT Assigned( self ) then
    Exit;

  if NoVCL then
    vObject := nil;

  if NOT Assigned( param ) then
    param := T_PARAM_REAL.Create( self, fSection, def, min, max, iniName, vObject );

  param.Load;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Constructor T_PARAM_REAL.Create( AOwner : T_INI_DATEI; iniSection: string; def, min, max: double; iniName: string; vObject: TObject = nil );
var
  Notify   : TNotifyEvent;
  Method   : System.TMethod absolute Notify;
  KeyPress : TKeyPressEvent;
  KMethod  : System.TMethod absolute KeyPress;
begin
  if ( vObject <> nil ) then
    begin
    if ( NOT ( IsPublishedProp( vObject, 'Text' ) OR IsPublishedProp( vObject, 'Date' ) OR IsPublishedProp( vObject, 'Time' ) ) )
                    AND NOT vObject.ClassNameIs( 'TJvTimeEdit' ) then // Time isn't published ...
      Raise Exception.Create( Format( ERROR_WRONG_PROPERTY_1_, [ ClassName ] ) +
                              Format( ERROR_WRONG_PROPERTY_2_, [ ClassName ] ) +
                              Format( ERROR_WRONG_PROPERTY_3_, [ 'Text-, Date- oder Time-' ] )
                            );
    end;

  inherited Create( AOwner, iniSection, iniName, vObject );

  if Assigned( vObject ) then
    begin
    if IsPublishedProp( vObject, 'OnKeyPress' ) then
      begin
      KMethod := GetMethodProp( vObject, 'OnKeyPress' );
      if NOT MethodIsEqual( KMethod, originalOnKeyPress ) then
        originalOnKeyPress := KeyPress;
      KeyPress := EditFloatZahlKeyPress;
      SetMethodProp( vObject, 'OnKeyPress', KMethod );
      end;
    if IsPublishedProp( vObject, 'OnExit' ) then
      begin
      Method := GetMethodProp( vObject, 'OnExit' );
      if NOT MethodIsEqual( Method, originalOnExit ) then
        originalOnExit := Notify;
      Notify := CheckGrenzwerte;
      SetMethodProp( vObject, 'OnExit', Method );
      end;
    end;

  fDecimalPlaces := 255;

  if ( min = 0 ) AND ( max = 0 ) then
    begin
    fMinimum := MinDouble;
    fMaximum := MaxDouble;
    end
  else
    begin
    fMinimum := min;
    fMaximum := max;
    end;

  fDefault := def;
end;

destructor T_PARAM_REAL.Destroy;
var
  KEvent  : TKeyPressEvent;
  KMethod : System.TMethod absolute KEvent;
  Event   : TNotifyEvent;
  Method  : System.TMethod absolute Event;
begin
  if Assigned( fObject ) then
    begin
    if ( NOT Application.Terminated ) then
      begin
      KEvent := originalOnKeyPress;
      if IsPublishedProp( fObject, 'OnKeyPress' ) then
        SetMethodProp( fObject, 'OnKeyPress', KMethod );

      Event := originalOnExit;
      if IsPublishedProp( fObject, 'OnExit' ) then
        SetMethodProp( fObject, 'OnExit', Method );
      end;
    end;

  inherited;
end;

procedure T_PARAM_REAL.Assign( Param : T_PARAM_ALLGEMEIN );
begin
  if NOT Assigned( Self ) then
    Exit;
  if NOT Assigned( Param ) then
    Exit;
  if NOT ( Param is T_PARAM_REAL ) then
    Exit;
  inherited;

  fMinimum           := T_PARAM_REAL( Param ).fMinimum;
  fMaximum           := T_PARAM_REAL( Param ).fMaximum;
  fDefault           := T_PARAM_REAL( Param ).fDefault;
  fValue             := T_PARAM_REAL( Param ).fValue;
  fBackupValue       := T_PARAM_REAL( Param ).fBackupValue;
  fDecimalPlaces  := T_PARAM_REAL( Param ).fDecimalPlaces;

  {$IFDEF ASSIGN_VCL}
  originalOnExit     := T_PARAM_REAL( Param ).originalOnExit;
  originalOnKeyPress := T_PARAM_REAL( Param ).originalOnKeyPress;
  ValueToVCL;
  {$ENDIF}
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Procedure T_PARAM_REAL.CheckGrenzwerte( Sender:TObject );
var
  x   : double;
  erg : string;
  D   : Double;
begin
  if NOT Assigned( self ) then
    Exit;

  {$IFDEF JVCL}
  if ( Sender.ClassName = 'TJvTimeEdit' ) then // Time isn't published ...
    TJvTimeEdit( Sender ).Time := Max( fMinimum, Min( fMaximum, TJvTimeEdit( Sender ).Time ) )
  else {$ENDIF}if IsPublishedProp( Sender, 'Time' ) then // JvTimeEdit
    begin
    D := GetPropValue( Sender, 'Time' );
    SetPropValue( Sender, 'Time', Max( fMinimum, Min( fMaximum, D ) ) )
    end
  else if IsPublishedProp( Sender, 'Date' ) then // JvDateEdit
    begin
    D := GetPropValue( Sender, 'Date' );
    SetPropValue( Sender, 'Date', Max( fMinimum, Min( fMaximum, D ) ) )
    end
  else if IsPublishedProp( Sender, 'Text' ) then
    begin
    x := StrToFloat_Int( GetPropValue( Sender, 'Text' ), fDefault );
    x := Max( fMinimum, Min( fMaximum, x ) );

    if DecimalPlaces = 0 then
      erg := IntToStr( Trunc( x ) )
    else if DecimalPlaces = 255 then
      erg := FloatToStr( x )
    else
      erg := Format( '%.' + IntToStr( fDecimalPlaces ) + 'f', [ x ] );

    SetPropValue( Sender, 'Text', erg );
    end;

  if Assigned( originalOnExit ) then
    originalOnExit( Sender );
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Procedure T_PARAM_REAL.EditFloatZahlKeyPress( Sender:TObject; var Key:char );
begin
  if Assigned( originalOnKeyPress ) then
    originalOnKeyPress( Sender, Key );

  if IsPublishedProp( Sender, 'Text' ) then
    OnKeyPressCheckChar( Sender, Key, kpmFloat );
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure T_PARAM_REAL.Load;
begin
  if NOT Assigned( self ) then
    Exit;
  if NOT Assigned( fOwner ) then
    Exit;

  fValue := fDefault;
  fLoaded := Assigned( fOwner.fIniFile ) AND ValueExists( fOwner.fIniFile, fSection, fName );
  if fLoaded then
//    fValue := fOwner.fIniFile.ReadFloat( fSection, iniName, def );
    fValue := StrToFloat_Int( fOwner.fIniFile.ReadString( fSection, fName, '-err' ), fDefault );
  fBackupValue := fValue;
  fChanged := false;

  ValueToVCL;
end;

function T_PARAM_REAL.Save : string;
begin
  result := '';
  if NOT Assigned( self ) then
    Exit;
  if NOT Assigned( fOwner ) then
    Exit;

  if fChanged AND VCLAccessAllowed then
    VCLToValue;

  if Assigned( fOwner.fIniFile ) then
    begin
    {$IF NOT Defined( useFastIni ) AND NOT Defined( useMemIni ) AND NOT Defined( useRegistryIni ) }
    try
    {$IFEND}
      fOwner.fIniFile.WriteFloat( fSection, fName, fValue );    
    {$IF NOT Defined( useFastIni ) AND NOT Defined( useMemIni ) AND NOT Defined( useRegistryIni ) }
    except
    end;
    {$IFEND}
    if ( fBackupValue <> fValue ) then
      result := Format( LOG_REAL_, [ fName, fBackupValue, fValue ] );
    fBackupValue := fValue;
    end;

  inherited Save;
end;

procedure T_PARAM_REAL.VCLToValue;
begin
  if NOT Assigned( fObject ) then
    Exit;
  if ( GetCurrentThreadID <> MainThreadID ) then
    Exit;

  {$IFDEF JVCL}
  if ( fObject.ClassName = 'TJvTimeEdit' ) then // Time isn't published ...
    fValue := TJvTimeEdit( fObject ).Time
  else {$ENDIF}if IsPublishedProp( fObject, 'Time' ) then // JvTimeEdit
    fValue := GetPropValue( fObject, 'Time' )
  else if IsPublishedProp( fObject, 'Date' ) then // JvDateEdit
    fValue := GetPropValue( fObject, 'Date' )
  else if IsPublishedProp( fObject, 'Text' ) then
    fValue := StrToFloat_Int( GetPropValue( fObject, 'Text' ), fDefault );
end;

procedure T_PARAM_REAL.ValueToVCL;
var
  S : string;
{$IFNDEF SetValueRaiseOnChange}
  Method : System.TMethod;
{$ENDIF}
begin
  if NOT Assigned( fObject ) then
    Exit;
  if ( GetCurrentThreadID <> MainThreadID ) then
    Exit;
    
  if fDecimalPlaces = 0 then
    s := IntToStr( Trunc( fValue ) )
  else if fDecimalPlaces = 255 then
    s := FloatToStr( fValue )
  else
    s := Format( '%.' + IntToStr( fDecimalPlaces ) + 'f', [ fValue ] );

  {$IFNDEF SetValueRaiseOnChange}
  UnsetOnChange( fObject, Method );
  {$ENDIF}

  {$IFDEF JVCL}
  if ( fObject.ClassName = 'TJvTimeEdit' ) then // Time isn't published ...
    TJvTimeEdit( fObject ).Time := fValue
  else {$ENDIF}if IsPublishedProp( fObject, 'Time' ) then // JvTimeEdit
    SetPropValue( fObject, 'Time', fValue )
  else if IsPublishedProp( fObject, 'Date' ) then // JvDateEdit
    SetPropValue( fObject, 'Date', fValue )
  else if IsPublishedProp( fObject, 'text' ) then
    SetPropValue( fObject, 'text', s );

  {$IFNDEF SetValueRaiseOnChange}
  ResetOnChange( fObject, Method );
  {$ENDIF}
end;

procedure T_PARAM_REAL.SetDecimalPlaces( Value : Byte );
begin
  if NOT Assigned( Self ) then
    Exit;
  if ( fDecimalPlaces = Value ) then
    Exit;
  fDecimalPlaces := Value;
  ValueToVCL;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function T_PARAM_REAL.GetValue : double;
begin
  result := 0;
  if NOT Assigned( self ) then
    Exit;

  {$IFDEF CriticalSections}
  fCrit.Enter;
  {$ENDIF}
  result := fValue;
  {$IFDEF CriticalSections}
  fCrit.Leave;
  {$ENDIF}
end;

Procedure T_PARAM_REAL.SetValue( Value: double );
begin
  if NOT Assigned( self ) then
    Exit;

  {$IFDEF CriticalSections}
  fCrit.Enter;
  {$ENDIF}
  fValue := Min( fMaximum, Max( fMinimum, Value ) );
  {$IFDEF CriticalSections}
  fCrit.Leave;
  {$ENDIF}
  if NoVCL then
    Exit;
  ValueToVCL;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//***  T_PARAM_BOOL  ***********************************************************
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Procedure T_INI_DATEI.Init_BoolParam( var param : T_PARAM_BOOL; def: boolean; iniName: string; vObject : TObject = nil );
begin
  if NOT Assigned( self ) then
    Exit;

  if NoVCL then
    vObject := nil;

  if NOT Assigned( param ) then
    param := T_PARAM_BOOL.Create( self, fSection, def, iniName, vObject );

  param.Load;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Constructor T_PARAM_BOOL.Create( AOwner : T_INI_DATEI; iniSection: string; def: Boolean; iniName: string; vObject: TObject = nil );
begin
  if ( vObject <> nil ) then
    begin
    if ( NOT IsPublishedProp( vObject, 'Checked' ) ) then
      Raise Exception.Create( Format( ERROR_WRONG_PROPERTY_1_, [ ClassName ] ) +
                              Format( ERROR_WRONG_PROPERTY_2_, [ ClassName ] ) +
                              Format( ERROR_WRONG_PROPERTY_3_, [ 'Checked-' ] )
                            );
    end;

  inherited Create( AOwner, iniSection, iniName, vObject );
  fDefault := def;
end;

procedure T_PARAM_BOOL.Assign( Param : T_PARAM_ALLGEMEIN );
begin
  if NOT Assigned( Self ) then
    Exit;
  if NOT Assigned( Param ) then
    Exit;
  if NOT ( Param is T_PARAM_BOOL ) then
    Exit;
  inherited;

  fDefault      := T_PARAM_BOOL( Param ).fDefault;
  fValue        := T_PARAM_BOOL( Param ).fValue;
  fBackupValue  := T_PARAM_BOOL( Param ).fBackupValue;
  {$IFDEF ASSIGN_VCL}
  ValueToVCL;
  {$ENDIF}
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure T_PARAM_BOOL.Load;
  function IfThenS( AValue: Boolean; const ATrue: String; const AFalse: String ): String;
  begin
    if AValue then
      Result := 'True'
    else
      Result := 'false';
  end;
begin
  if NOT Assigned( self ) then
    Exit;
  if NOT Assigned( fOwner ) then
    Exit;

  fValue := fDefault;
  fLoaded := Assigned( fOwner.fIniFile ) AND ValueExists( fOwner.fIniFile, fSection, fName );
  if fLoaded then
    fValue := ( LowerCase( fOwner.fIniFile.ReadString( fSection, fName, IfThenS( fDefault, 'true', 'false' ) ) ) = 'true' );
  fBackupValue := fValue;
  fChanged := false;

  ValueToVCL;
end;

function T_PARAM_BOOL.Save : string;
begin
  result := '';
  if NOT Assigned( self ) then
    Exit;
  if NOT Assigned( fOwner ) then
    Exit;

  if {fChanged AND}VCLAccessAllowed then
    VCLToValue;

  if Assigned( fOwner.fIniFile ) then
    begin
    {$IF NOT Defined( useFastIni ) AND NOT Defined( useMemIni ) AND NOT Defined( useRegistryIni ) }
    try
    {$IFEND}
      fOwner.fIniFile.WriteString( fSection, fName, BoolToStr( fValue, True ) );    
    {$IF NOT Defined( useFastIni ) AND NOT Defined( useMemIni ) AND NOT Defined( useRegistryIni ) }
    except
    end;
    {$IFEND}
    if fBackupValue <> fValue then
      result := Format( LOG_STRING_, [ BeautifyClassName( Self ), fName, BoolToStr( fBackupValue, True ), BoolToStr( fValue, True ) ] );
    fBackupValue := fValue;
    end;

  inherited Save;
end;

procedure T_PARAM_BOOL.VCLToValue;
begin
  if NOT Assigned( fObject ) then
    Exit;
  if ( GetCurrentThreadID <> MainThreadID ) then
    Exit;

  if ( fChanged OR ( fObject is TRadioButton ) ) then
    begin
    if IsPublishedProp( fObject, 'Checked' ) then
      fValue := GetPropValue( fObject, 'Checked' )
    end;
end;

procedure T_PARAM_BOOL.ValueToVCL;
{$IFNDEF SetValueRaiseOnChange}
var
  Method : System.TMethod;
{$ENDIF}
begin
  if NOT Assigned( fObject ) then
    Exit;
  if ( GetCurrentThreadID <> MainThreadID ) then
    Exit;

  {$IFNDEF SetValueRaiseOnChange}
  UnsetOnChange( fObject, Method );
  {$ENDIF}

  if IsPublishedProp( fObject, 'Checked' ) then
    SetPropValue( fObject, 'Checked', fValue );

  {$IFNDEF SetValueRaiseOnChange}
  ResetOnChange( fObject, Method );
  {$ENDIF}
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function T_PARAM_BOOL.GetValue : Boolean;
begin
  result := false;
  if NOT Assigned( self ) then
    Exit;

  {$IFDEF CriticalSections}
  fCrit.Enter;
  {$ENDIF}
  result := fValue;
  {$IFDEF CriticalSections}
  fCrit.Leave;
  {$ENDIF}
end;

Procedure T_PARAM_BOOL.SetValue( Value: Boolean );
begin
  if NOT Assigned( self ) then
    Exit;

  {$IFDEF CriticalSections}
  fCrit.Enter;
  {$ENDIF}
  fValue := Value;
  {$IFDEF CriticalSections}
  fCrit.Leave;
  {$ENDIF}
  if NoVCL then
    Exit;
  ValueToVCL;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//***  T_PARAM_ROI     *********************************************************
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Procedure T_INI_DATEI.Init_ROIParam( var param : T_PARAM_ROI; minX, minY, maxX, maxY: Integer; iniName: string; editX1 : TObject = nil; editY1 : TObject = nil; editX2 : TObject = nil; editY2 : TObject = nil );
begin
  if NOT Assigned( self ) then
    Exit;

  if NOT Assigned( param ) then
    param := T_PARAM_ROI.Create( Self, fSection, minX, minY, maxX, maxY, iniName, editX1, editY1, editX2, editY2 );

end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Constructor T_PARAM_ROI.Create( AOwner : T_INI_DATEI; iniSection: string; minX, minY, maxX, maxY: Integer; iniName: string; editX1 : TObject = nil; editY1 : TObject = nil; editX2 : TObject = nil; editY2 : TObject = nil );
begin
  inherited Create;
  if NOT Assigned( AOwner ) then
    Exit;

  AOwner.Init_IntParam( x1, 0,    minX, maxX, iniName + '.x1', editX1 );
  AOwner.Init_IntParam( y1, 0,    minY, maxY, iniName + '.y1', editY1 );
  AOwner.Init_IntParam( x2, maxX, minX, maxX, iniName + '.x2', editX2 );
  AOwner.Init_IntParam( y2, maxY, minY, maxY, iniName + '.y2', editY2 );
end;

destructor T_PARAM_ROI.Destroy;
begin
  if Assigned( x1 ) then
    begin
    x1.free;
    x1 := nil
    end;
  if Assigned( y1 ) then
    begin
    y1.free;
    y1 := nil
    end;

  if Assigned( x2 ) then
    begin
    x2.free;
    x2 := nil
    end;
  if Assigned( y2 ) then
    begin
    y2.free;
    y2 := nil
    end;
  inherited;
end;

procedure T_PARAM_ROI.Assign( Param : T_PARAM_ROI );
begin
  if NOT Assigned( Self ) then
    Exit;
  if NOT Assigned( Param ) then
    Exit;

  x1.Assign( param.x1 );
  y1.Assign( param.y1 );
  x2.Assign( param.x2 );
  y2.Assign( param.y2 );
end;

function T_PARAM_ROI.GetSection : String;
begin
  result := '';
  if NOT Assigned( Self ) then
    Exit;
  if Assigned( x1 ) then
    result := x1.fSection
  else if Assigned( y1 ) then
    result := y1.fSection

  else if Assigned( x2 ) then
    result := x2.fSection
  else if Assigned( y2 ) then
    result := y2.fSection
end;

function T_PARAM_ROI.IsMyObject( aObject : TObject ) : Boolean;
begin
  result := false;
  if NOT Assigned( Self ) then
    Exit;

  if Assigned( x1 ) then
    result := result OR x1.IsMyObject( aObject );
  if Assigned( y1 ) then
    result := result OR y1.IsMyObject( aObject );

  if Assigned( x2 ) then
    result := result OR x2.IsMyObject( aObject );
  if Assigned( y2 ) then
    result := result OR y2.IsMyObject( aObject );
end;

procedure T_PARAM_ROI.Load;
begin
  if NOT Assigned( self ) then
    Exit;
  if Assigned( x1 ) then
    x1.Load;
  if Assigned( y1 ) then
    y1.Load;

  if Assigned( x2 ) then
    x2.Load;
  if Assigned( y2 ) then
    y2.Load;
end;

function T_PARAM_ROI.Save : string;
  procedure UpdateResult( var S : string );
  begin
    if ( s <> '' ) then
      begin
      result := result + s + #13#10;
      S := '';
      end;
  end;
var
  s : string;
begin
  result := '';
  if NOT Assigned( self ) then
    Exit;
  s := '';
  if Assigned( x1 ) then
    s := x1.Save;
  UpdateResult( s );

  if Assigned( y1 ) then
    s := y1.Save;
  UpdateResult( s );

  if Assigned( x2 ) then
    s := x2.Save;
  UpdateResult( s );

  if Assigned( y2 ) then
    s := y2.Save;
  UpdateResult( s );
end;

{$IFDEF useTLH_Math}
function T_PARAM_ROI.GetValue : tERect;
begin
  FillChar( result, SizeOf( result ), 0 );
  if NOT Assigned( Self ) then
    Exit;

  if Assigned( x1 ) then
    result.TopLeft.X := x1.Wert;
  if Assigned( y1 ) then
    result.TopLeft.Y := y1.Wert;
  if Assigned( x2 ) then
    result.TopRight.X := x2.Wert;
  if Assigned( y1 ) then
    result.TopRight.Y := y1.Wert;
  if Assigned( x1 ) then
    result.BottomLeft.X := x1.Wert;
  if Assigned( y2 ) then
    result.BottomLeft.Y := y2.Wert;
  if Assigned( x2 ) then
    result.BottomRight.X := x2.Wert;
  if Assigned( y2 ) then
    result.BottomRight.Y := y2.Wert;
end;

Procedure T_PARAM_ROI.SetValue( Value: tERect );
begin
  if NOT Assigned( Self ) then
    Exit;

  if Assigned( x1 ) then
    x1.Wert := Trunc( Value.TopLeft.X );
  if Assigned( y1 ) then
    y1.Wert := Trunc( Value.TopLeft.Y );
  if Assigned( x2 ) then
    x2.Wert := Trunc( Value.TopRight.X );
  if Assigned( y1 ) then
    y1.Wert := Trunc( Value.TopRight.Y );
  if Assigned( x1 ) then
    x1.Wert := Trunc( Value.BottomLeft.X );
  if Assigned( y2 ) then
    y2.Wert := Trunc( Value.BottomLeft.Y );
  if Assigned( x2 ) then
    x2.Wert := Trunc( Value.BottomRight.X );
  if Assigned( y2 ) then
    y2.Wert := Trunc( Value.BottomRight.Y );
end;
{$ENDIF}

{$IF Defined( useMATHROUT ) OR Defined( useTLH_Math )}
function T_PARAM_ROI.GetTopLeft : TYP_ePunkt;
begin
  FillChar( result, SizeOf( result ), 0 );
  if NOT Assigned( Self ) then
    Exit;

  if Assigned( x1 ) then
    result.X := x1.Wert;
  if Assigned( y1 ) then
    result.Y := y1.Wert;
end;

Procedure T_PARAM_ROI.SetTopLeft( Value: TYP_ePunkt );
begin
  if NOT Assigned( Self ) then
    Exit;

  if Assigned( x1 ) then
    x1.Wert := Trunc( Value.X );
  if Assigned( y1 ) then
    y1.Wert := Trunc( Value.Y );
end;

function T_PARAM_ROI.GetTopRight : TYP_ePunkt;
begin
  FillChar( result, SizeOf( result ), 0 );
  if NOT Assigned( Self ) then
    Exit;

  if Assigned( x2 ) then
    result.X := x2.Wert;
  if Assigned( y1 ) then
    result.Y := y1.Wert;
end;

Procedure T_PARAM_ROI.SetTopRight( Value: TYP_ePunkt );
begin
  if NOT Assigned( Self ) then
    Exit;

  if Assigned( x2 ) then
    x2.Wert := Trunc( Value.X );
  if Assigned( y1 ) then
    y1.Wert := Trunc( Value.Y );
end;

function T_PARAM_ROI.GetBottomLeft : TYP_ePunkt;
begin
  FillChar( result, SizeOf( result ), 0 );
  if NOT Assigned( Self ) then
    Exit;

  if Assigned( x1 ) then
    result.X := x1.Wert;
  if Assigned( y2 ) then
    result.Y := y2.Wert;
end;

Procedure T_PARAM_ROI.SetBottomLeft( Value: TYP_ePunkt );
begin
  if NOT Assigned( Self ) then
    Exit;

  if Assigned( x1 ) then
    x1.Wert := Trunc( Value.X );
  if Assigned( y2 ) then
    y2.Wert := Trunc( Value.Y );
end;

function T_PARAM_ROI.GetBottomRight : TYP_ePunkt;
begin
  FillChar( result, SizeOf( result ), 0 );
  if NOT Assigned( Self ) then
    Exit;

  if Assigned( x2 ) then
    result.X := x2.Wert;
  if Assigned( y2 ) then
    result.Y := y2.Wert;
end;

Procedure T_PARAM_ROI.SetBottomRight( Value: TYP_ePunkt );
begin
  if NOT Assigned( Self ) then
    Exit;

  if Assigned( x2 ) then
    x2.Wert := Trunc( Value.X );
  if Assigned( y2 ) then
    y2.Wert := Trunc( Value.Y );
end;
{$IFEND}

procedure T_PARAM_ROI.VCLToValue;
begin
  if ( GetCurrentThreadID <> MainThreadID ) then
    Exit;

  if Assigned( x1 ) then
    x1.VCLToValue;
  if Assigned( y1 ) then
    y1.VCLToValue;

  if Assigned( x2 ) then
    x2.VCLToValue;
  if Assigned( y2 ) then
    y2.VCLToValue;
end;

procedure T_PARAM_ROI.ValueToVCL;
begin
  if ( GetCurrentThreadID <> MainThreadID ) then
    Exit;

  if Assigned( x1 ) then
    x1.ValueToVCL;
  if Assigned( y1 ) then
    y1.ValueToVCL;

  if Assigned( x2 ) then
    x2.ValueToVCL;
  if Assigned( y2 ) then
    y2.ValueToVCL;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//***  T_PARAM_AOI     *********************************************************
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Procedure T_INI_DATEI.Init_AOIParam( var param : T_PARAM_AOI; minX, minY, maxX, maxY: Integer; iniName: string; editTopLeftX : TObject = nil; editTopLeftY : TObject = nil; editTopRightX : TObject = nil; editTopRightY : TObject = nil; editBottomLeftX : TObject = nil; editBottomLeftY : TObject = nil; editBottomRightX : TObject = nil; editBottomRightY : TObject = nil );
begin
  if NOT Assigned( self ) then
    Exit;

  if NOT Assigned( param ) then
    param := T_PARAM_AOI.Create( Self, fSection, minX, minY, maxX, maxY,  iniName, editTopLeftX, editTopLeftY, editTopRightX, editTopRightY, editBottomLeftX, editBottomLeftY, editBottomRightX, editBottomRightY );
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Constructor T_PARAM_AOI.Create( AOwner : T_INI_DATEI; iniSection: string; minX, minY, maxX, maxY: Double; iniName: string; editTopLeftX : TObject = nil; editTopLeftY : TObject = nil; editTopRightX : TObject = nil; editTopRightY : TObject = nil; editBottomLeftX : TObject = nil; editBottomLeftY : TObject = nil; editBottomRightX : TObject = nil; editBottomRightY : TObject = nil );
begin
  inherited Create;
  if NOT Assigned( AOwner ) then
    Exit;

  AOwner.Init_RealParam( TopLeftX,        0, minX, maxX, iniName + '.TopLeftX', editTopLeftX );
  AOwner.Init_RealParam( TopLeftY,        0, minY, maxY, iniName + '.TopLeftY', editTopLeftY );
  AOwner.Init_RealParam( TopRightX,    maxX, minX, maxX, iniName + '.TopRightX', editTopRightX );
  AOwner.Init_RealParam( TopRightY,       0, minY, maxY, iniName + '.TopRightY', editTopRightY );
  AOwner.Init_RealParam( BottomLeftX,     0, minX, maxX, iniName + '.BottomLeftX', editBottomLeftX );
  AOwner.Init_RealParam( BottomLeftY,  maxY, minY, maxY, iniName + '.BottomLeftY', editBottomLeftY );
  AOwner.Init_RealParam( BottomRightX, maxX, minX, maxX, iniName + '.BottomRightX', editBottomRightX );
  AOwner.Init_RealParam( BottomRightY, maxY, minY, maxY, iniName + '.BottomRightY', editBottomRightY );
end;

destructor T_PARAM_AOI.Destroy;
begin
  if Assigned( TopLeftX ) then
    begin
    TopLeftX.free;
    TopLeftX := nil
    end;
  if Assigned( TopLeftY ) then
    begin
    TopLeftY.free;
    TopLeftY := nil
    end;

  if Assigned( TopRightX ) then
    begin
    TopRightX.free;
    TopRightX := nil
    end;
  if Assigned( TopRightY ) then
    begin
    TopRightY.free;
    TopRightY := nil
    end;

  if Assigned( BottomLeftX ) then
    begin
    BottomLeftX.free;
    BottomLeftX := nil
    end;
  if Assigned( BottomLeftY ) then
    begin
    BottomLeftY.free;
    BottomLeftY := nil
    end;

  if Assigned( BottomRightX ) then
    begin
    BottomRightX.free;
    BottomRightX := nil
    end;
  if Assigned( BottomRightY ) then
    begin
    BottomRightY.free;
    BottomRightY := nil
    end;
  inherited;
end;

procedure T_PARAM_AOI.Assign( Param : T_PARAM_AOI );
begin
  if NOT Assigned( Self ) then
    Exit;
  if NOT Assigned( Param ) then
    Exit;

  TopLeftX.Assign( param.TopLeftX );
  TopLeftY.Assign( param.TopLeftY );

  TopRightX.Assign( param.TopRightX );
  TopRightY.Assign( param.TopRightY );

  BottomLeftX.Assign( param.BottomLeftX );
  BottomLeftY.Assign( param.BottomLeftY );

  BottomRightX.Assign( param.BottomRightX );
  BottomRightY.Assign( param.BottomRightY );
end;

function T_PARAM_AOI.IsMyObject( aObject : TObject ) : Boolean;
begin
  result := false;
  if NOT Assigned( Self ) then
    Exit;

  if Assigned( TopLeftX ) then
    result := result OR TopLeftX.IsMyObject( aObject );
  if Assigned( TopLeftY ) then
    result := result OR TopLeftY.IsMyObject( aObject );

  if Assigned( TopRightX ) then
    result := result OR TopRightX.IsMyObject( aObject );
  if Assigned( TopRightY ) then
    result := result OR TopRightY.IsMyObject( aObject );

  if Assigned( BottomLeftX ) then
    result := result OR BottomLeftX.IsMyObject( aObject );
  if Assigned( BottomLeftY ) then
    result := result OR BottomLeftY.IsMyObject( aObject );

  if Assigned( BottomRightX ) then
    result := result OR BottomRightX.IsMyObject( aObject );
  if Assigned( BottomRightY ) then
    result := result OR BottomRightY.IsMyObject( aObject );
end;

procedure T_PARAM_AOI.Load;
begin
  if NOT Assigned( self ) then
    Exit;

  if Assigned( TopLeftX ) then
    TopLeftX.Load;
  if Assigned( TopLeftY ) then
    TopLeftY.Load;

  if Assigned( TopRightX ) then
    TopRightX.Load;
  if Assigned( TopRightY ) then
    TopRightY.Load;

  if Assigned( BottomLeftX ) then
    BottomLeftX.Load;
  if Assigned( BottomLeftY ) then
    BottomLeftY.Load;

  if Assigned( BottomRightX ) then
    BottomRightX.Load;
  if Assigned( BottomRightY ) then
    BottomRightY.Load;
end;

function T_PARAM_AOI.Save : String;
  procedure UpdateResult( var S : string );
  begin
    if ( s <> '' ) then
      begin
      result := result + s + #13#10;
      S := '';
      end;
  end;
var
  S : String;  
begin
  result := '';
  if NOT Assigned( self ) then
    Exit;

  if Assigned( TopLeftX ) then
    S := TopLeftX.Save;
  UpdateResult( s );
  if Assigned( TopLeftY ) then
    S := TopLeftY.Save;
  UpdateResult( s );

  if Assigned( TopRightX ) then
    S := TopRightX.Save;
  UpdateResult( s );
  if Assigned( TopRightY ) then
    S := TopRightY.Save;
  UpdateResult( s );

  if Assigned( BottomLeftX ) then
    S := BottomLeftX.Save;
  UpdateResult( s );
  if Assigned( BottomLeftY ) then
    S := BottomLeftY.Save;
  UpdateResult( s );

  if Assigned( BottomRightX ) then
    S := BottomRightX.Save;
  UpdateResult( s );
  if Assigned( BottomRightY ) then
    S := BottomRightY.Save;
  UpdateResult( s );
end;

{$IFDEF useTLH_Math}
function T_PARAM_AOI.GetValue : tERect;
begin
  FillChar( result, SizeOf( result ), 0 );
  if NOT Assigned( Self ) then
    Exit;

  if Assigned( TopLeftX ) then
    result.TopLeft.X := TopLeftX.Wert;
  if Assigned( TopLeftY ) then
    result.TopLeft.Y := TopLeftY.Wert;
  if Assigned( TopRightX ) then
    result.TopRight.X := TopRightX.Wert;
  if Assigned( TopRightY ) then
    result.TopRight.Y := TopRightY.Wert;
  if Assigned( BottomLeftX ) then
    result.BottomLeft.X := BottomLeftX.Wert;
  if Assigned( BottomLeftY ) then
    result.BottomLeft.Y := BottomLeftY.Wert;
  if Assigned( BottomRightX ) then
    result.BottomRight.X := BottomRightX.Wert;
  if Assigned( BottomRightY ) then
    result.BottomRight.Y := BottomRightY.Wert;
end;

Procedure T_PARAM_AOI.SetValue( Value: tERect );
begin
  if NOT Assigned( Self ) then
    Exit;

  if Assigned( TopLeftX ) then
    TopLeftX.Wert := Value.TopLeft.X;
  if Assigned( TopLeftY ) then
    TopLeftY.Wert := Value.TopLeft.Y;
  if Assigned( TopRightX ) then
    TopRightX.Wert := Value.TopRight.X;
  if Assigned( TopRightY ) then
    TopRightY.Wert := Value.TopRight.Y;
  if Assigned( BottomLeftX ) then
    BottomLeftX.Wert := Value.BottomLeft.X;
  if Assigned( BottomLeftY ) then
    BottomLeftY.Wert := Value.BottomLeft.Y;
  if Assigned( BottomRightX ) then
    BottomRightX.Wert := Value.BottomRight.X;
  if Assigned( BottomRightY ) then
    BottomRightY.Wert := Value.BottomRight.Y;
end;
{$ENDIF}

{$IF Defined( useMATHROUT ) OR Defined( useTLH_Math )}
function T_PARAM_AOI.GetTopLeft : TYP_ePunkt;
begin
  FillChar( result, SizeOf( result ), 0 );
  if NOT Assigned( Self ) then
    Exit;

  if Assigned( TopLeftX ) then
    result.X := TopLeftX.Wert;
  if Assigned( TopLeftY ) then
    result.Y := TopLeftY.Wert;
end;

Procedure T_PARAM_AOI.SetTopLeft( Value: TYP_ePunkt );
begin
  if NOT Assigned( Self ) then
    Exit;

  if Assigned( TopLeftX ) then
    TopLeftX.Wert := Value.X;
  if Assigned( TopLeftY ) then
    TopLeftY.Wert := Value.Y;
end;

function T_PARAM_AOI.GetTopRight : TYP_ePunkt;
begin
  FillChar( result, SizeOf( result ), 0 );
  if NOT Assigned( Self ) then
    Exit;

  if Assigned( TopRightX ) then
    result.X := TopRightX.Wert;
  if Assigned( TopRightY ) then
    result.Y := TopRightY.Wert;
end;

Procedure T_PARAM_AOI.SetTopRight( Value: TYP_ePunkt );
begin
  if NOT Assigned( Self ) then
    Exit;

  if Assigned( TopRightX ) then
    TopRightX.Wert := Value.X;
  if Assigned( TopRightY ) then
    TopRightY.Wert := Value.Y;
end;

function T_PARAM_AOI.GetBottomLeft : TYP_ePunkt;
begin
  FillChar( result, SizeOf( result ), 0 );
  if NOT Assigned( Self ) then
    Exit;

  if Assigned( BottomLeftX ) then
    result.X := BottomLeftX.Wert;
  if Assigned( BottomLeftY ) then
    result.Y := BottomLeftY.Wert;
end;

Procedure T_PARAM_AOI.SetBottomLeft( Value: TYP_ePunkt );
begin
  if NOT Assigned( Self ) then
    Exit;

  if Assigned( BottomLeftX ) then
    BottomLeftX.Wert := Value.X;
  if Assigned( BottomLeftY ) then
    BottomLeftY.Wert := Value.Y;
end;

function T_PARAM_AOI.GetBottomRight : TYP_ePunkt;
begin
  FillChar( result, SizeOf( result ), 0 );
  if NOT Assigned( Self ) then
    Exit;

  if Assigned( BottomRightX ) then
    result.X := BottomRightX.Wert;
  if Assigned( BottomRightY ) then
    result.Y := BottomRightY.Wert;
end;

Procedure T_PARAM_AOI.SetBottomRight( Value: TYP_ePunkt );
begin
  if NOT Assigned( Self ) then
    Exit;

  if Assigned( BottomRightX ) then
    BottomRightX.Wert := Value.X;
  if Assigned( BottomRightY ) then
    BottomRightY.Wert := Value.Y;
end;
{$IFEND}

function T_PARAM_AOI.GetDecimalPlaces : Byte;
begin
  result := 0;
  if NOT Assigned( Self ) then
    Exit;
  if Assigned( TopLeftX ) then
    result := TopLeftX.DecimalPlaces
  else if Assigned( TopLeftY ) then
    result := TopLeftY.DecimalPlaces

  else if Assigned( TopRightX ) then
    result := TopRightX.DecimalPlaces
  else if Assigned( TopRightY ) then
    result := TopRightY.DecimalPlaces

  else if Assigned( BottomLeftX ) then
    result := BottomLeftX.DecimalPlaces
  else if Assigned( BottomLeftY ) then
    result := BottomLeftY.DecimalPlaces

  else if Assigned( BottomRightX ) then
    result := BottomRightX.DecimalPlaces
  else if Assigned( BottomRightY ) then
    result := BottomRightY.DecimalPlaces;
end;

procedure T_PARAM_AOI.SetDecimalPlaces( Value : Byte );
begin
  if NOT Assigned( Self ) then
    Exit;
  if Assigned( TopLeftX ) then
    TopLeftX.DecimalPlaces := Value;
  if Assigned( TopLeftY ) then
    TopLeftY.DecimalPlaces := Value;

  if Assigned( TopRightX ) then
    TopRightX.DecimalPlaces := Value;
  if Assigned( TopRightY ) then
    TopRightY.DecimalPlaces := Value;

  if Assigned( BottomLeftX ) then
    BottomLeftX.DecimalPlaces := Value;
  if Assigned( BottomLeftY ) then
    BottomLeftY.DecimalPlaces := Value;

  if Assigned( BottomRightX ) then
    BottomRightX.DecimalPlaces := Value;
  if Assigned( BottomRightY ) then
    BottomRightY.DecimalPlaces := Value;
end;

function T_PARAM_AOI.GetSection : String;
begin
  result := '';
  if NOT Assigned( Self ) then
    Exit;
  if Assigned( TopLeftX ) then
    result := TopLeftX.fSection
  else if Assigned( TopLeftY ) then
    result := TopLeftY.fSection

  else if Assigned( TopRightX ) then
    result := TopRightX.fSection
  else if Assigned( TopRightY ) then
    result := TopRightY.fSection

  else if Assigned( BottomLeftX ) then
    result := BottomLeftX.fSection
  else if Assigned( BottomLeftY ) then
    result := BottomLeftY.fSection

  else if Assigned( BottomRightX ) then
    result := BottomRightX.fSection
  else if Assigned( BottomRightY ) then
    result := BottomRightY.fSection;
end;

procedure T_PARAM_AOI.VCLToValue;
begin
  if ( GetCurrentThreadID <> MainThreadID ) then
    Exit;

  if Assigned( TopLeftX ) then
    TopLeftX.VCLToValue;
  if Assigned( TopLeftY ) then
    TopLeftY.VCLToValue;

  if Assigned( TopRightX ) then
    TopRightX.VCLToValue;
  if Assigned( TopRightY ) then
    TopRightY.VCLToValue;

  if Assigned( BottomLeftX ) then
    BottomLeftX.VCLToValue;
  if Assigned( BottomLeftY ) then
    BottomLeftY.VCLToValue;

  if Assigned( BottomRightX ) then
    BottomRightX.VCLToValue;
  if Assigned( BottomRightY ) then
    BottomRightY.VCLToValue;
end;

procedure T_PARAM_AOI.ValueToVCL;
begin
  if ( GetCurrentThreadID <> MainThreadID ) then
    Exit;

  if Assigned( TopLeftX ) then
    TopLeftX.ValueToVCL;
  if Assigned( TopLeftY ) then
    TopLeftY.ValueToVCL;

  if Assigned( TopRightX ) then
    TopRightX.ValueToVCL;
  if Assigned( TopRightY ) then
    TopRightY.ValueToVCL;

  if Assigned( BottomLeftX ) then
    BottomLeftX.ValueToVCL;
  if Assigned( BottomLeftY ) then
    BottomLeftY.ValueToVCL;

  if Assigned( BottomRightX ) then
    BottomRightX.ValueToVCL;
  if Assigned( BottomRightY ) then
    BottomRightY.ValueToVCL;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//***  T_PARAM_STR  ************************************************************
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Procedure T_INI_DATEI.Init_StrParam( var param : T_PARAM_STR; def: string; iniName: string; vObject : TObject = nil; IsPath : boolean = false );
begin
  if NOT Assigned( self ) then
    Exit;

  if NoVCL then
    vObject := nil;

  if NOT Assigned( param ) then
    param  := T_PARAM_STR.Create( self, fSection, def, iniName, vObject, IsPath );

  param.Load;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Constructor T_PARAM_STR.Create( AOwner : T_INI_DATEI; iniSection: string; Default: string; iniName: string; vObject: TObject = nil; IsPath : boolean = false );
begin
  if ( vObject <> nil ) then
    begin
    if ( NOT IsPublishedProp( vObject, 'Text' ) ) then
      Raise Exception.Create( Format( ERROR_WRONG_PROPERTY_1_, [ ClassName ] ) +
                              Format( ERROR_WRONG_PROPERTY_2_, [ ClassName ] ) +
                              Format( ERROR_WRONG_PROPERTY_3_, [ 'Text-' ] )
                            );
    end;

  inherited Create( AOwner, iniSection, iniName, vObject );
  if IsPath then
    fDefault  := IncludeTrailingBackslash( Default )
  else
    fDefault  := Default;
  fPassword   := false;
  fIsPath     := IsPath;

  if Assigned( vObject ) then
    begin
    if IsPublishedProp( vObject, 'PasswordChar' ) then
      fPassword := ( GetPropValue( vObject, 'PasswordChar' ) <> 0 );
    end;
end;

procedure T_PARAM_STR.Assign( Param : T_PARAM_ALLGEMEIN );
begin
  if NOT Assigned( Self ) then
    Exit;
  if NOT Assigned( Param ) then
    Exit;
  if NOT ( Param is T_PARAM_STR ) then
    Exit;
  inherited;

  fDefault     := T_PARAM_STR( Param ).fDefault;
  fValue       := T_PARAM_STR( Param ).fValue;
  fBackupValue := T_PARAM_STR( Param ).fBackupValue;
  fPassword    := T_PARAM_STR( Param ).fPassword;
  fIsPath      := T_PARAM_STR( Param ).fIsPath;

  {$IFDEF ASSIGN_VCL}
  ValueToVCL;
  {$ENDIF}
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure T_PARAM_STR.Load;
var
  str              : string;
  i, x, str_laenge : integer;
begin
  if NOT Assigned( self ) then
    Exit;
  if NOT Assigned( fOwner ) then
    Exit;

  fValue := fDefault;
  fLoaded := Assigned( fOwner.fIniFile ) AND ValueExists( fOwner.fIniFile, fSection, fName );
  if fLoaded then
    fValue := fOwner.fIniFile.ReadString( fSection, fName, fDefault );

  if ( fValue <> fDefault ) and fPassword then // ist Passwort noch nicht gesetzt, darf nicht dekodiert werden
    begin // dieses Feld ist ein Passwortfeld und muss beim Lesen dekodiert werden
    SetLength( str, Length( fValue ) );
    str_laenge := 0;
    for i := 1 to Length( fValue ) div 3 do // Zeichen werden als 3stellige Dezimal-ASCII-werte gespeichert
      begin
      x := Ord( StrToIntDef( Copy( fValue, ( i-1 )*3 +1, 3 ), 0 ) );
      if ( x < PASSWORT_VERSCHLUESSELUNGS_WERT_ ) then// Passwort ist auf 20 Stellen mit einem Zufallszeichen < "PASSWORT_VERSCHLUESSELUNGS_WERT_" aufgefüllt
        Continue;

      str[ i ] := Char( x - PASSWORT_VERSCHLUESSELUNGS_WERT_ );
      Inc( str_laenge );
      end;
    // Passwortlänge anpassen
    SetLength( str, str_laenge );
    fValue := str;
    SetLength( str, 0 );
    end;
  fBackupValue := fValue;
  fChanged := false;

  ValueToVCL;
end;

function T_PARAM_STR.CheckPath( var Value : string; Changed : PBoolean = nil ) : boolean;
begin
  result := false;
  if NOT Assigned( self ) then
    Exit;

  if NOT fIsPath then
    Exit;

  if ( Value = '' ) then
    Value := fDefault;

  if ( RightStr( Value, 1 ) <> '\' ) then
    begin
    Value := IncludeTrailingBackslash( Value );
    if Assigned( Changed ) then
      Changed^ := True;
    end;

  result := DirectoryExists( Value );
  if result then
    Exit;

  result := ForceDirectories( Value );
  if result then
    Exit;

  if ( LowerCase( Value ) = LowerCase( fDefault ) ) then
    Exit;

  Value := fDefault;
  if Assigned( Changed ) then
    Changed^ := True;
  result := DirectoryExists( Value );
  if result then
    Exit;
  result := ForceDirectories( Value );
end;

function T_PARAM_STR.Save : string;
var
  s : string;
  i : integer;
begin
  result := '';
  if NOT Assigned( self ) then
    Exit;
  if NOT Assigned( fOwner ) then
    Exit;

  if fChanged AND VCLAccessAllowed then
    VCLToValue;

  if fPassword then
    begin  // dieses Feld ist ein Passwortfeld und muss beim Schreiben kodiert werden
    s := '';
    for i := 1 to Length( fValue ) do
      s := s + Format( '%.3d',[ Ord( fValue[ i ] )+ PASSWORT_VERSCHLUESSELUNGS_WERT_ ] );
    for i := Length( fValue )+1 to PASSWORT_SPEICHERLAENGE_  do
      s := s + Format( '%.3d',[ Random( PASSWORT_VERSCHLUESSELUNGS_WERT_ ) ] );
    end
  else
    s := fValue;

  if Assigned( fOwner.fIniFile ) then
    begin
    {$IF NOT Defined( useFastIni ) AND NOT Defined( useMemIni ) AND NOT Defined( useRegistryIni ) }
    try
    {$IFEND}
      fOwner.fIniFile.WriteString( fSection, fName, s );
    {$IF NOT Defined( useFastIni ) AND NOT Defined( useMemIni ) AND NOT Defined( useRegistryIni ) }
    except
    end;
    {$IFEND}
    if fBackupValue <> fValue then
      begin
      if fPassword then
        result := Format( LOG_PASSWORD_2_, [ fName ] )
      else
        result := Format( LOG_STRING_, [ BeautifyClassName( Self ), fName, fBackupValue, fValue ] );
      end;
    fBackupValue := fValue;
    end;

  inherited Save;
end;

procedure T_PARAM_STR.VCLToValue;
var
  vChanged : Boolean;
begin
  if NOT Assigned( fObject ) then
    Exit;
  if ( GetCurrentThreadID <> MainThreadID ) then
    Exit;

  if IsPublishedProp( fObject, 'Text' ) then
    begin
    fValue := GetPropValue( fObject, 'Text' );
    if fIsPath then
      begin
      CheckPath( fValue, @vChanged );
      if vChanged then
        ValueToVCL;
      end;
    end;
end;

procedure T_PARAM_STR.ValueToVCL;
{$IFNDEF SetValueRaiseOnChange}
var
  Method : System.TMethod;
{$ENDIF}
begin
  if NOT Assigned( fObject ) then
    Exit;
  if ( GetCurrentThreadID <> MainThreadID ) then
    Exit;

  {$IFNDEF SetValueRaiseOnChange}
  UnsetOnChange( fObject, Method );
  {$ENDIF}

  if IsPublishedProp( fObject, 'text' ) then
    SetPropValue( fObject, 'text', fValue );

  {$IFNDEF SetValueRaiseOnChange}
  ResetOnChange( fObject, Method );
  {$ENDIF}
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function T_PARAM_STR.GetValue : string;
begin
  result := '';
  if NOT Assigned( self ) then
    Exit;

  {$IFDEF CriticalSections}
  fCrit.Enter;
  {$ENDIF}
  result := fValue;
  {$IFDEF CriticalSections}
  fCrit.Leave;
  {$ENDIF}
end;

Procedure T_PARAM_STR.SetValue( Value: string );
begin
  if NOT Assigned( self ) then
    Exit;

  if fIsPath then
    CheckPath( Value );
  {$IFDEF CriticalSections}
  fCrit.Enter;
  {$ENDIF}
  fValue := Value;
  {$IFDEF CriticalSections}
  fCrit.Leave;
  {$ENDIF}

  if NoVCL then
    Exit;
  ValueToVCL;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//***  T_PARAM_STR_LIST  *******************************************************
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Procedure T_INI_DATEI.Init_StrListParam( var param : T_PARAM_STR_LIST; fSection: string; vObject : TObject = nil );
begin
  if NOT Assigned( self ) then
    Exit;

  if NoVCL then
    vObject := nil;

  if NOT Assigned( param ) then
    param := T_PARAM_STR_LIST.Create( self, fSection, vObject );

  param.Load;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Constructor T_PARAM_STR_LIST.Create( AOwner : T_INI_DATEI; iniSection: string; vObject: TObject = nil );
begin
  if ( vObject <> nil ) then
    begin
    if ( IsPublishedProp( vObject, 'Items' ) ) AND NOT ( vObject is TListBox ) AND NOT ( vObject is TComboBox ) AND NOT ( vObject is TCustomComboBox ) then
      Raise Exception.Create( Format( ERROR_WRONG_PROPERTY_1_, [ ClassName ] ) +
                              Format( ERROR_WRONG_PROPERTY_2_, [ ClassName ] ) +
                              Format( ERROR_WRONG_PROPERTY_3_, [ 'Items.' ] )
                            );
    end;

  inherited Create( AOwner, iniSection, iniSection, vObject );
  fValue          := TStringList.Create;
  fBackupValue    := TStringList.Create;
end;

destructor T_PARAM_STR_LIST.Destroy;
var
  Event  : TNotifyEvent;
  Method : System.TMethod absolute Event;
begin
  if Assigned( fObject ) then
    begin
    if ( NOT Application.Terminated ) then
      begin
      Event := originalOnExit;
      if IsPublishedProp( fObject, 'OnExit' ) then
        SetMethodProp( fObject, 'OnExit', Method );
      end;
    end;

  fValue.free;
  fBackupValue.free;

  inherited;
end;

procedure T_PARAM_STR_LIST.Assign( Param : T_PARAM_ALLGEMEIN );
begin
  if NOT Assigned( Self ) then
    Exit;
  if NOT Assigned( Param ) then
    Exit;
  if NOT ( Param is T_PARAM_STR_LIST ) then
    Exit;
  inherited;

  fValue         := T_PARAM_STR_LIST( Param ).fValue;
  fBackupValue   := T_PARAM_STR_LIST( Param ).fBackupValue;

  {$IFDEF ASSIGN_VCL}
  originalOnExit := T_PARAM_STR_LIST( Param ).originalOnExit;
  ValueToVCL;
  {$ENDIF}
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function T_PARAM_STR_LIST.GetValue : TStringList;
begin
  result := NIL;
  if NOT Assigned( self ) then
    Exit;

  {$IFDEF CriticalSections}
  fCrit.Enter;
  {$ENDIF}
  result := fValue;
  {$IFDEF CriticalSections}
  fCrit.Leave;
  {$ENDIF}
end;

Procedure T_PARAM_STR_LIST.SetValue( StrL: TStringList );
begin
  if NOT Assigned( self ) then
    Exit;
  if NOT Assigned( StrL ) then
    Exit;

  {$IFDEF CriticalSections}
  fCrit.Enter;
  {$ENDIF}
  if ( fValue <> StrL ) then
    fValue.Assign( StrL );
  {$IFDEF CriticalSections}
  fCrit.Leave;
  {$ENDIF}

  if NoVCL then
    Exit;
  ValueToVCL;
end;

procedure T_PARAM_STR_LIST.Load;
var
  i, x : integer;
begin
  if NOT Assigned( self ) then
    Exit;
  if NOT Assigned( fOwner ) then
    Exit;

  // ( Schlüsselname + "=" +  Werte ) laden
  fValue.Clear;
  fLoaded := fOwner.fIniFile.SectionExists( fSection );
  if fLoaded then
    fOwner.fIniFile.ReadSectionValues( fSection, TStrings( fValue ) );

  // Schlüsselnamen ausblenden
  for i := 0 to fValue.Count-1 do
    begin
    x := Pos( '=', fValue[ i ] );
    fValue[ i ] := Copy( fValue[ i ], x+1, Length( fValue[ i ] )-x );
    end;
  fBackupValue.Assign( fValue );
  fChanged := false;  

  ValueToVCL;
end;

function T_PARAM_STR_LIST.Save : string;
var
  i : integer;
begin
  result := '';
  if NOT Assigned( self ) then
    Exit;
  if NOT Assigned( fOwner ) then
    Exit;

  if fChanged AND VCLAccessAllowed then
    VCLToValue;

  if Assigned( fOwner.fIniFile ) then
    begin
    {$IFDEF useFastIni}
    fOwner.fIniFile.EnterSection( fSection );
    fOwner.fIniFile.ClearSection;
    {$ELSE}
    fOwner.fIniFile.EraseSection( fSection );
    {$ENDIF}
    for i := 0 to fValue.Count-1 do
      {$IF NOT Defined( useFastIni ) AND NOT Defined( useMemIni ) AND NOT Defined( useRegistryIni ) }
      try
      {$IFEND}
        fOwner.fIniFile.WriteString( fSection, fName + IntToStr( i ), fValue[ i ] );
      {$IF NOT Defined( useFastIni ) AND NOT Defined( useMemIni ) AND NOT Defined( useRegistryIni ) }
      except
      end;
      {$IFEND}

    if fBackupValue.Text <> fValue.Text then
      result := Format( LOG_STRING_, [ BeautifyClassName( Self ), fName, fBackupValue.Text, fValue.Text ] );
    fBackupValue.Assign( fValue );
    end;

  inherited Save;
end;

procedure T_PARAM_STR_LIST.VCLToValue;
var
  v : Variant;
begin
  if NOT Assigned( fObject ) then
    Exit;
  if ( GetCurrentThreadID <> MainThreadID ) then
    Exit;    

  if ( fObject is TListBox ) then
    fValue.Assign( TListBox( fObject ).Items )
  else if ( fObject is TCustomComboBox ) then
    fValue.Assign( TCustomComboBox( fObject ).Items )
  else if IsPublishedProp( fObject, 'Items' ) then
    begin
    v := GetPropValue( fObject, 'Items' );
    fValue.Assign( TPersistent( Integer( v ) ) );
    end
  else if IsPublishedProp( fObject, 'Lines' ) then
    begin
    v := GetPropValue( fObject, 'Lines' );
    fValue.Assign( TPersistent( Integer( v ) ) );
    end;
end;

procedure T_PARAM_STR_LIST.ValueToVCL;
var
  v : Variant;
{$IFNDEF SetValueRaiseOnChange}
  Method : System.TMethod;
{$ENDIF}
begin
  if NOT Assigned( fObject ) then
    Exit;
  if ( GetCurrentThreadID <> MainThreadID ) then
    Exit;

  {$IFNDEF SetValueRaiseOnChange}
  UnsetOnChange( fObject, Method );
  {$ENDIF}

  if IsPublishedProp( fObject, 'Items' ) then
    begin
    v := GetPropValue( fObject, 'Items' );
    TPersistent( Integer( v ) ).Assign( fValue );
    end
  else if IsPublishedProp( fObject, 'Lines' ) then
    begin
    v := GetPropValue( fObject, 'Lines' );
    TPersistent( Integer( v ) ).Assign( fValue );
    end;

  {$IFNDEF SetValueRaiseOnChange}
  ResetOnChange( fObject, Method );
  {$ENDIF}
end;

{$IF Defined( useMATHROUT ) OR Defined( useTLH_Math )}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//***  T_PARAM_ePunkt  *********************************************************
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Procedure T_INI_DATEI.Init_ePunktParam( var param : T_PARAM_ePunkt; defX, defY: double; iniName: string; editX : TObject = nil; editY : TObject = nil );
begin
  if NOT Assigned( self ) then
    Exit;

  if NoVCL then
    begin
    editX := nil;
    editY := nil;
    end;

  if NOT Assigned( param ) then
    param  := T_PARAM_ePunkt.Create( self, fSection, defX, defY, iniName, editX, editY );

  param.Load;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Constructor T_PARAM_ePunkt.Create( AOwner : T_INI_DATEI; iniSection: string; def: TYP_ePunkt; iniName: string; editX : TObject = nil; editY : TObject = nil );
begin
  Create( AOwner, iniSection, def.X, def.Y, iniName, editX, editY );
end;

Constructor T_PARAM_ePunkt.Create( AOwner : T_INI_DATEI; iniSection: string; defX, defY: double; iniName: string; editX : TObject = nil; editY : TObject = nil );
var
  i        : Integer;
  Notify   : TNotifyEvent;
  Method   : System.TMethod absolute Notify;
  KeyPress : TKeyPressEvent;
  KMethod  : System.TMethod absolute KeyPress;
{$IFDEF DUPECHECK}
  vObject  : TObject;
  ObjName  : string;
{$ENDIF}
begin
  for i := 0 to 1 do
    begin
    case i of
      0 : vObject := editX;
      1 : vObject := editY;
    else
      break;
    end;
    if ( vObject <> nil ) then
      begin
      if ( NOT IsPublishedProp( vObject, 'Text' ) ) then
        Raise Exception.Create( Format( ERROR_WRONG_PROPERTY_1_, [ ClassName ] ) +
                                Format( ERROR_WRONG_PROPERTY_2_, [ ClassName ] ) +
                                Format( ERROR_WRONG_PROPERTY_3_, [ 'Text.' ] )
                              );
      end;
    end;

  {$IFDEF DUPECHECK}
  for i := 1 to 1 do
    begin
    case i of
      0 : vObject := editX;
      1 : vObject := editY;
    else
      break;
    end;
    if fOwner.IsComponentInUse( vObject ) then
      begin
      ObjName := FIND_BACKUPS_NONE_;
      if IsPublishedProp( vObject, 'Name' ) then
        ObjName := GetPropValue( vObject, 'Name' );
      Raise Exception.Create( Format( ERROR_DUPE_CHECK_, [ ClassName, iniName, iniSection, objName ] ) );
      end;
    end;
  {$ENDIF}

  inherited Create( AOwner, iniSection, iniName, editX );
  fObjectY   := editY;
  fDefault.X := defX;
  fDefault.Y := defY;

  if ( editX <> nil ) then
    begin
    // X
    if IsPublishedProp( editX, 'OnKeyPress' ) then
      begin
      KMethod := GetMethodProp( editX, 'OnKeyPress' );
      if NOT MethodIsEqual( KMethod, originalOnKeyPressX ) then
        originalOnKeyPressX := KeyPress;
      KeyPress := EditFloatZahlKeyPress;
      SetMethodProp( editX, 'OnKeyPress', KMethod );
      end;
    end;
  if ( editY <> nil ) then
    begin
    // Y
    if IsPublishedProp( editY, 'OnChange' ) then
      begin
      Method := GetMethodProp( editY, 'OnChange' );
      if NOT MethodIsEqual( Method, originalOnChangeY ) then
        originalOnChangeY := Notify;
      Notify := OnChange;
      SetMethodProp( editY, 'OnChange', Method );
      end;
    if IsPublishedProp( editY, 'OnKeyPress' ) then
      begin
      KMethod := GetMethodProp( editY, 'OnKeyPress' );
      if NOT MethodIsEqual( KMethod, originalOnKeyPressY ) then
        originalOnKeyPressY := KeyPress;
      KeyPress := EditFloatZahlKeyPress;
      SetMethodProp( editY, 'OnKeyPress', KMethod );
      end;
    end;
end;

destructor T_PARAM_ePunkt.Destroy;
var
  Event   : TNotifyEvent;
  Method  : System.TMethod absolute Event;
  KEvent  : TKeyPressEvent;
  KMethod : System.TMethod absolute KEvent;
begin
  if Assigned( fObject ) then
    begin
    if ( NOT Application.Terminated ) then
      begin
      KEvent := originalOnKeyPressX;
      if IsPublishedProp( fObject, 'OnKeyPress' ) then
        SetMethodProp( fObject, 'OnKeyPress', KMethod );
      end;
    end;
  if Assigned( fObjectY ) then
    begin
    if ( NOT Application.Terminated ) then
      begin
      KEvent := originalOnKeyPressY;
      if IsPublishedProp( fObjectY, 'OnKeyPress' ) then
        SetMethodProp( fObjectY, 'OnKeyPress', KMethod );

      // 2nd (not present in inherrit)
      Event := originalOnChange;
      if IsPublishedProp( fObjectY, 'OnChange' ) then
        SetMethodProp( fObjectY, 'OnChange', Method )
      else if IsPublishedProp( fObjectY, 'OnClick' ) then
        SetMethodProp( fObjectY, 'OnClick', Method );
      end;

    fObjectY := nil;
    end;

  inherited;
end;

procedure T_PARAM_ePunkt.Assign( Param : T_PARAM_ALLGEMEIN );
begin
  if NOT Assigned( Self ) then
    Exit;
  if NOT Assigned( Param ) then
    Exit;
  if NOT ( Param is T_PARAM_ePunkt ) then
    Exit;
  inherited;

  fDefault           := T_PARAM_ePunkt( Param ).fDefault;
  fValue             := T_PARAM_ePunkt( Param ).fValue;
  fBackupValue       := T_PARAM_ePunkt( Param ).fBackupValue;

  {$IFDEF ASSIGN_VCL}
  fObjectY           := T_PARAM_ePunkt( Param ).fObjectY;
  originalOnChangeY  := T_PARAM_ePunkt( Param ).originalOnChangeY;
  originalOnKeyPressX:= T_PARAM_ePunkt( Param ).originalOnKeyPressX;
  originalOnKeyPressY:= T_PARAM_ePunkt( Param ).originalOnKeyPressY;
  HighLightY         := T_PARAM_ePunkt( Param ).HighLightY;
  ValueToVCL;
  {$ENDIF}
end;

function T_PARAM_ePunkt.IsMyObject( aObject : TObject ) : Boolean;
begin
  result := false;
  if NOT Assigned( Self ) then
    Exit;

  result := inherited IsMyObject( aObject ) OR ( fObjectY = aObject );
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Procedure T_PARAM_ePunkt.EditFloatZahlKeyPress( Sender:TObject; var Key:char );
begin
  if ( fObject = Sender ) AND Assigned( originalOnKeyPressX ) then
    originalOnKeyPressX( Sender, Key )
  else if ( fObjectY = Sender ) AND Assigned( originalOnKeyPressY ) then
    originalOnKeyPressY( Sender, Key );

  if IsPublishedProp( Sender, 'Text' ) then
    OnKeyPressCheckChar( Sender, Key, kpmFloat );
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure T_PARAM_ePunkt.Load;
begin
  if NOT Assigned( self ) then
    Exit;
  if NOT Assigned( fOwner ) then
    Exit;

  fValue := fDefault;
  fLoaded := Assigned( fOwner.finiFile ) AND ValueExists( fOwner.finiFile, fSection, fName + EPUNKT_SUB_EXTENSION_1_ ) AND ValueExists( fOwner.finiFile, fSection, fName + EPUNKT_SUB_EXTENSION_2_ );
  if fLoaded then
    begin
//    fValue.x := fOwner.finiFile.ReadFloat( fSection, fName + EPUNKT_SUB_EXTENSION_1_, Default.x );
//    fValue.y := fOwner.finiFile.ReadFloat( fSection, fName + EPUNKT_SUB_EXTENSION_2_, Default.Y );
    fValue.X := StrToFloat_Int( fOwner.finiFile.ReadString( fSection, fName + EPUNKT_SUB_EXTENSION_1_, '-err' ), fDefault.X );
    fValue.Y := StrToFloat_Int( fOwner.finiFile.ReadString( fSection, fName + EPUNKT_SUB_EXTENSION_2_, '-err' ), fDefault.Y );
    end;
  fBackupValue := fValue;
  fChanged := false;

  ValueToVCL;
end;

function T_PARAM_ePunkt.Save : string;
var
  allow : Boolean;
begin
  result := '';
  if NOT Assigned( self ) then
    Exit;
  if NOT Assigned( fOwner ) then
    Exit;

  allow := VCLAccessAllowed;
  if Allow AND Assigned( fObjectY ) then
    begin
    if ( fObjectY is TComponent ) then
      allow := Allow and ( NOT ( csDestroying in TComponent( fObjectY ).ComponentState ) );
    end;

  if fChanged AND Allow then
    VCLToValue;

  if Assigned( fOwner.fIniFile ) then
    begin
    {$IF NOT Defined( useFastIni ) AND NOT Defined( useMemIni ) AND NOT Defined( useRegistryIni ) }
    try
    {$IFEND}
      fOwner.fIniFile.WriteFloat( fSection, fName + EPUNKT_SUB_EXTENSION_1_, fValue.x );
      fOwner.fIniFile.WriteFloat( fSection, fName + EPUNKT_SUB_EXTENSION_2_, fValue.y );
    {$IF NOT Defined( useFastIni ) AND NOT Defined( useMemIni ) AND NOT Defined( useRegistryIni ) }
    except
    end;
    {$IFEND}
    if ( fBackupValue.x <> fValue.x ) OR ( fBackupValue.y <> fValue.y ) then
      result := Format( LOG_EPUNKT_, [ fName, fBackupValue.x, fBackupValue.y, fValue.x, fValue.y ] );
    fBackupValue := fValue;
    end;
  inherited Save;
end;

procedure T_PARAM_ePunkt.VCLToValue;
begin
  if ( GetCurrentThreadID <> MainThreadID ) then
    Exit;

  if fObject <> nil then
    begin
    if IsPublishedProp( fObject, 'Text' ) then
      fValue.x := StrToFloat_Int( GetPropValue( fObject, 'Text' ), fDefault.X );
    end;

  if fObjectY <> nil then
    begin
    if IsPublishedProp( fObjectY, 'Text' ) then
      fValue.y := StrToFloat_Int( GetPropValue( fObjectY, 'Text' ), fDefault.Y );
    end;
end;

procedure T_PARAM_ePunkt.ValueToVCL;
{$IFNDEF SetValueRaiseOnChange}
var
  Method : System.TMethod;
{$ENDIF}
begin
  if ( GetCurrentThreadID <> MainThreadID ) then
    Exit;

  if fObject <> nil then
    begin
    {$IFNDEF SetValueRaiseOnChange}
    UnsetOnChange( fObject, Method );
    {$ENDIF}

    if IsPublishedProp( fObject, 'text' ) then
      SetPropValue( fObject, 'text', FloatToStr( fValue.x ) );

    {$IFNDEF SetValueRaiseOnChange}
    ResetOnChange( fObject, Method );
    {$ENDIF}
    end;
  if fObjectY <> nil then
    begin
    {$IFNDEF SetValueRaiseOnChange}
    UnsetOnChange( fObjectY, Method );
    {$ENDIF}

    if IsPublishedProp( fObjectY, 'text' ) then
      SetPropValue( fObjectY, 'text', FloatToStr( fValue.y ) );

    {$IFNDEF SetValueRaiseOnChange}
    ResetOnChange( fObjectY, Method );
    {$ENDIF}
    end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function T_PARAM_ePunkt.GetValue : Typ_ePunkt;
begin
  result.X := 0;
  result.Y := 0;
  if NOT Assigned( self ) then
    Exit;

  {$IFDEF CriticalSections}
  fCrit.Enter;
  {$ENDIF}
  result := fValue;
  {$IFDEF CriticalSections}
  fCrit.Leave;
  {$ENDIF}
end;

Procedure T_PARAM_ePunkt.SetValue( Value: Typ_ePunkt );
begin
  if NOT Assigned( self ) then
    Exit;

  {$IFDEF CriticalSections}
  fCrit.Enter;
  {$ENDIF}
  fValue := Value;
  {$IFDEF CriticalSections}
  fCrit.Leave;
  {$ENDIF}
  if NoVCL then
    Exit;
  ValueToVCL;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//***  T_PARAM_eGerade  ********************************************************
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Procedure T_INI_DATEI.Init_eGeradeParam( var param : T_PARAM_eGerade; defNX, defNY, defC: double; iniName: string; editNX : TObject = nil; editNY : TObject = nil; editC : TObject = nil );
begin
  if NOT Assigned( self ) then
    Exit;

  if NoVCL then
    begin
    editNX := nil;
    editNY := nil;
    editC  := nil;
    end;

  if NOT Assigned( param ) then
    param := T_PARAM_eGerade.Create( self, fSection, defNX, defNY, defC, iniName, editNX, editNY, editC );

  param.Load;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Constructor T_PARAM_eGerade.Create( AOwner : T_INI_DATEI; iniSection: string; def : Typ_eGerade; iniName: string; editNX : TObject = nil; editNY: TObject = nil; editC : TObject = nil );
begin
  Create( AOwner, iniSection, def.NX, def.NY, def.C, iniName, editNX, editNY, editC );
end;

Constructor T_PARAM_eGerade.Create( AOwner : T_INI_DATEI; iniSection: string; defNX, defNY, defC : double; iniName: string; editNX: TObject = nil; editNY: TObject = nil; editC : TObject = nil  );
var
  i        : Integer;
  vObject  : TObject;
var
  Notify   : TNotifyEvent;
  Method   : System.TMethod absolute Notify;
  KeyPress : TKeyPressEvent;
  KMethod  : System.TMethod absolute KeyPress;
{$IFDEF DUPECHECK}
  ObjName  : string;
{$ENDIF}
begin
  for i := 0 to 2 do
    begin
    vObject := nil;
    case i of
      0 : vObject := editNX;
      1 : vObject := editNY;
      2 : vObject := editC;
    else
      break;
    end;
    if ( vObject <> nil ) then
      begin
      if ( NOT IsPublishedProp( vObject, 'Text' ) ) then
        Raise Exception.Create( Format( ERROR_WRONG_PROPERTY_1_, [ ClassName ] ) +
                                Format( ERROR_WRONG_PROPERTY_2_, [ ClassName ] ) +
                                Format( ERROR_WRONG_PROPERTY_3_, [ 'Text-' ] )
                              );
      end;
    end;

  {$IFDEF DUPECHECK}
  for i := 1 to 2 do
    begin
    case i of
      0 : vObject := editNX;
      1 : vObject := editNY;
      2 : vObject := editC;
    else
      break;
    end;
    if fOwner.IsComponentInUse( vObject ) then
      begin
      ObjName := FIND_BACKUPS_NONE_;
      if IsPublishedProp( vObject, 'Name' ) then
        ObjName := GetPropValue( vObject, 'Name' );
      Raise Exception.Create( Format( ERROR_DUPE_CHECK_, [ ClassName, iniName, iniSection, objName ] ) );
      end;
    end;
  {$ENDIF}    

  inherited Create( AOwner, iniSection, iniName, vObject );
  fObjectNY   := editNY;
  fObjectC    := editC;
  fDefault.NX := defNX;
  fDefault.NY := defNY;
  fDefault.C  := defC;

  if ( editNX <> nil ) then
    begin
    // X
    if IsPublishedProp( editNX, 'OnKeyPress' ) then
      begin
      KMethod := GetMethodProp( editNX, 'OnKeyPress' );
      if NOT MethodIsEqual( KMethod, originalOnKeyPressX ) then
        originalOnKeyPressX := KeyPress;
      KeyPress := EditFloatZahlKeyPress;
      SetMethodProp( editNX, 'OnKeyPress', KMethod );
      end;
    end;
  if ( editNY <> nil ) then
    begin
    // Y
    if IsPublishedProp( editNY, 'OnChange' ) then
      begin
      Method := GetMethodProp( editNY, 'OnChange' );
      if NOT MethodIsEqual( Method, originalOnChangeY ) then
        originalOnChangeY := Notify;
      Notify := OnChange;
      SetMethodProp( editNY, 'OnChange', Method );
      end;
    if IsPublishedProp( editNY, 'OnKeyPress' ) then
      begin
      KMethod := GetMethodProp( editNY, 'OnKeyPress' );
      if NOT MethodIsEqual( KMethod, originalOnKeyPressY ) then
        originalOnKeyPressY := KeyPress;
      KeyPress := EditFloatZahlKeyPress;
      SetMethodProp( editNY, 'OnKeyPress', KMethod );
      end;
    end;
  if ( editC <> nil ) then
    begin
    // C
    if IsPublishedProp( editC, 'OnChange' ) then
      begin
      Method := GetMethodProp( editC, 'OnChange' );
      if NOT MethodIsEqual( Method, originalOnChangeC ) then
        originalOnChangeC := Notify;
      Notify := OnChange;
      SetMethodProp( editC, 'OnChange', Method );
      end;
    if IsPublishedProp( editC, 'OnKeyPress' ) then
      begin
      KMethod := GetMethodProp( editC, 'OnKeyPress' );
      if NOT MethodIsEqual( KMethod, originalOnKeyPressC ) then
        originalOnKeyPressC := KeyPress;
      KeyPress := EditFloatZahlKeyPress;
      SetMethodProp( editC, 'OnKeyPress', KMethod );
      end;
    end;
end;

destructor T_PARAM_eGerade.Destroy;
  procedure PreInherrit( aObject : TObject );
  var
    Event   : TNotifyEvent;
    Method  : System.TMethod absolute Event;
  begin
    // 2nd (not present in inherrit)
    Event := originalOnChange;
    if IsPublishedProp( aObject, 'OnChange' ) then
      SetMethodProp( aObject, 'OnChange', Method )
    else if IsPublishedProp( aObject, 'OnClick' ) then
      SetMethodProp( aObject, 'OnClick', Method );
  end;
var
  KEvent  : TKeyPressEvent;
  KMethod : System.TMethod absolute KEvent;
begin
  if Assigned( fObject ) then
    begin
    if ( NOT Application.Terminated ) then
      begin
      KEvent := originalOnKeyPressX;
      if IsPublishedProp( fObject, 'OnKeyPress' ) then
        SetMethodProp( fObject, 'OnKeyPress', KMethod );
      end;
    end;

  if Assigned( fObjectNY ) then
    begin
    if ( NOT Application.Terminated ) then
      begin
      KEvent := originalOnKeyPressY;
      if IsPublishedProp( fObjectNY, 'OnKeyPress' ) then
        SetMethodProp( fObjectNY, 'OnKeyPress', KMethod );

      PreInherrit( fObjectNY );
      end;

    fObjectNY := nil;
    end;

  if Assigned( fObjectC ) then
    begin
    if ( NOT Application.Terminated ) then
      begin
      KEvent := originalOnKeyPressY;
      if IsPublishedProp( fObjectC, 'OnKeyPress' ) then
        SetMethodProp( fObjectC, 'OnKeyPress', KMethod );

      PreInherrit( fObjectC );
      end;

    fObjectC := nil;
    end;

  inherited;
end;

procedure T_PARAM_eGerade.Assign( Param : T_PARAM_ALLGEMEIN );
begin
  if NOT Assigned( Self ) then
    Exit;
  if NOT Assigned( Param ) then
    Exit;
  if NOT ( Param is T_PARAM_eGerade ) then
    Exit;
  inherited;

  fDefault           := T_PARAM_eGerade( Param ).fDefault;
  fValue             := T_PARAM_eGerade( Param ).fValue;
  fBackupValue       := T_PARAM_eGerade( Param ).fBackupValue;
  {$IFDEF ASSIGN_VCL}
  fObjectNY          := T_PARAM_eGerade( Param ).fObjectNY;
  fObjectC           := T_PARAM_eGerade( Param ).fObjectC;
  originalOnChangeY  := T_PARAM_eGerade( Param ).originalOnChangeY;
  originalOnChangeC  := T_PARAM_eGerade( Param ).originalOnChangeC;
  originalOnKeyPressX:= T_PARAM_eGerade( Param ).originalOnKeyPressX;
  originalOnKeyPressY:= T_PARAM_eGerade( Param ).originalOnKeyPressY;
  originalOnKeyPressC:= T_PARAM_eGerade( Param ).originalOnKeyPressC;
  HighLightY         := T_PARAM_eGerade( Param ).HighLightY;
  HighLightC         := T_PARAM_eGerade( Param ).HighLightC;
  ValueToVCL;
  {$ENDIF}
end;

function T_PARAM_eGerade.IsMyObject( aObject : TObject ) : Boolean;
begin
  result := false;
  if NOT Assigned( Self ) then
    Exit;

  result := inherited IsMyObject( aObject ) OR ( fObjectNY = aObject ) OR ( fObjectC = aObject );
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Procedure T_PARAM_eGerade.EditFloatZahlKeyPress( Sender:TObject; var Key:char );
begin
  if ( fObject = Sender ) AND Assigned( originalOnKeyPressX ) then
    originalOnKeyPressX( Sender, Key )
  else if ( fObjectNY = Sender ) AND Assigned( originalOnKeyPressY ) then
    originalOnKeyPressY( Sender, Key )
  else if ( fObjectC = Sender ) AND Assigned( originalOnKeyPressC ) then
    originalOnKeyPressC( Sender, Key );

  if IsPublishedProp( Sender, 'Text' ) then
    OnKeyPressCheckChar( Sender, Key, kpmFloat );
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure T_PARAM_eGerade.Load;
begin
  if NOT Assigned( self ) then
    Exit;
  if NOT Assigned( fOwner ) then
    Exit;

  fValue := fDefault;
  fLoaded := Assigned( fOwner.fIniFile ) AND ValueExists( fOwner.fIniFile, fSection, fName + EGERADE_SUB_EXTENSION_1_ ) and ValueExists( fOwner.fIniFile, fSection, fName + EGERADE_SUB_EXTENSION_2_ ) and ValueExists( fOwner.fIniFile, fSection, fName + EGERADE_SUB_EXTENSION_3_ );
  if fLoaded then
    begin
//    fValue.nx := fOwner.fIniFile.ReadFloat( fSection, fName + EGERADE_SUB_EXTENSION_1_, fDefault.NX );
//    fValue.ny := fOwner.fIniFile.ReadFloat( fSection, fName + EGERADE_SUB_EXTENSION_2_, fDefault.NY );
//    fValue.c  := fOwner.fIniFile.ReadFloat( fSection, fName + EGERADE_SUB_EXTENSION_3_, fDefault.C );
    fValue.NX := StrToFloat_Int( fOwner.fIniFile.ReadString( fSection, fName + EGERADE_SUB_EXTENSION_1_, '-err' ), fDefault.NX );
    fValue.NY := StrToFloat_Int( fOwner.fIniFile.ReadString( fSection, fName + EGERADE_SUB_EXTENSION_2_, '-err' ), fDefault.NY );
    fValue.C  := StrToFloat_Int( fOwner.fIniFile.ReadString( fSection, fName + EGERADE_SUB_EXTENSION_3_, '-err' ), fDefault.C );
    end;
  fBackupValue := fValue;
  fChanged := false;

  ValueToVCL;
end;

function T_PARAM_eGerade.Save : string;
var
  allow : Boolean;
begin
  result := '';
  if NOT Assigned( self ) then
    Exit;
  if NOT Assigned( fOwner ) then
    Exit;

  allow := VCLAccessAllowed;
  if Allow AND Assigned( fObjectNY ) then
    begin
    if ( fObjectNY is TComponent ) then
      allow := Allow and ( NOT ( csDestroying in TComponent( fObjectNY ).ComponentState ) );
    end;
  if Allow AND Assigned( fObjectC ) then
    begin
    if ( fObjectC is TComponent ) then
      allow := Allow and ( NOT ( csDestroying in TComponent( fObjectC ).ComponentState ) );
    end;

  if fChanged AND Allow then
    VCLToValue;

  if Assigned( fOwner.fIniFile ) then
    begin
    {$IF NOT Defined( useFastIni ) AND NOT Defined( useMemIni ) AND NOT Defined( useRegistryIni ) }
    try
    {$IFEND}
      fOwner.fIniFile.WriteFloat( fSection, fName + EGERADE_SUB_EXTENSION_1_, fValue.nx );
      fOwner.fIniFile.WriteFloat( fSection, fName + EGERADE_SUB_EXTENSION_2_, fValue.ny );
      fOwner.fIniFile.WriteFloat( fSection, fName + EGERADE_SUB_EXTENSION_3_, fValue.c );
    {$IF NOT Defined( useFastIni ) AND NOT Defined( useMemIni ) AND NOT Defined( useRegistryIni ) }
    except
    end;
    {$IFEND}
    if ( fBackupValue.nx <> fValue.nx ) OR ( fBackupValue.ny <> fValue.ny ) OR ( fBackupValue.c <> fValue.c ) then
      result := Format( LOG_EGERADE_, [ fName, fBackupValue.nx, fBackupValue.ny, fBackupValue.c, fValue.nx, fValue.ny, fValue.c ] );

    fBackupValue := fValue;
    end;

  inherited Save;
end;

procedure T_PARAM_eGerade.VCLToValue;
begin
  if ( GetCurrentThreadID <> MainThreadID ) then
    Exit;

  if fObject <> nil then
    begin
    if IsPublishedProp( fObject, 'Text' ) then
      fValue.nx := StrToFloat_Int( GetPropValue( fObject, 'Text' ), fDefault.nx );
    end;

  if fObjectNY <> nil then
    begin
    if IsPublishedProp( fObjectNY, 'Text' ) then
      fValue.ny := StrToFloat_Int( GetPropValue( fObjectNY, 'Text' ), fDefault.ny );
    end;

  if fObjectC <> nil then
    begin
    if IsPublishedProp( fObjectC, 'Text' ) then
      fValue.c := StrToFloat_Int( GetPropValue( fObjectC, 'Text' ), fDefault.C );
    end;
end;

procedure T_PARAM_eGerade.ValueToVCL;
{$IFNDEF SetValueRaiseOnChange}
var
  Method : System.TMethod;
{$ENDIF}
begin
  if ( GetCurrentThreadID <> MainThreadID ) then
    Exit;

  if fObject <> nil then
    begin
    {$IFNDEF SetValueRaiseOnChange}
    UnsetOnChange( fObject, Method );
    {$ENDIF}

    if IsPublishedProp( fObject, 'text' ) then
      SetPropValue( fObject, 'text', FloatToStr( fValue.nx ) );

    {$IFNDEF SetValueRaiseOnChange}
    if IsPublishedProp( fObject, 'OnChange' ) then
      SetMethodProp( fObject, 'OnChange', Method );
    {$ENDIF}
    end;

  if fObjectNY <> nil then
    begin
    {$IFNDEF SetValueRaiseOnChange}
    UnsetOnChange( fObjectNY, Method );
    {$ENDIF}

    if IsPublishedProp( fObjectNY, 'text' ) then
      SetPropValue( fObjectNY, 'text', FloatToStr( fValue.ny ) );

    {$IFNDEF SetValueRaiseOnChange}
    ResetOnChange( fObjectNY, Method );
    {$ENDIF}
    end;

  if fObjectC <> nil then
    begin
    {$IFNDEF SetValueRaiseOnChange}
    UnsetOnChange( fObjectC, Method );
    {$ENDIF}

    if IsPublishedProp( fObjectC, 'text' ) then
      SetPropValue( fObjectC, 'text', FloatToStr( fValue.c ) );

    {$IFNDEF SetValueRaiseOnChange}
    ResetOnChange( fObjectC, Method );
    {$ENDIF}
    end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function T_PARAM_eGerade.GetValue : Typ_eGerade;
begin
  result.NX := 0;
  result.NY := 0;
  result.C := 0;
  if NOT Assigned( self ) then
    Exit;

  {$IFDEF CriticalSections}
  fCrit.Enter;
  {$ENDIF}
  result := fValue;
  {$IFDEF CriticalSections}
  fCrit.Leave;
  {$ENDIF}
end;

Procedure T_PARAM_eGerade.SetValue( Value: Typ_eGerade );
begin
  if NOT Assigned( self ) then
    Exit;

  {$IFDEF CriticalSections}
  fCrit.Enter;
  {$ENDIF}
  fValue := Value;
  {$IFDEF CriticalSections}
  fCrit.Leave;
  {$ENDIF}
  if NoVCL then
    Exit;
  ValueToVCL;
end;
{$IFEND}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function T_INI_DATEI.GetID( Param : T_PARAM_BASE ): Integer;
var
  i : Integer;
begin
  result := -1;
  if NOT Assigned( self ) then
    Exit;

  for i := 0 to fCount-1 do
    begin
    if ( Items[ i ] = Param ) then
      begin
      result := i;
      Break;
      end;
    end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
{$IFDEF MD5}
{$IF Defined(INDY90) OR Defined(INDY100)}
function GetMD5( const StrL : TStringList ) : string;
var
  MD5s  : TMemoryStream;
  idMD5 : TIdHashMessageDigest5;
begin
  result := '';
  if NOT Assigned( StrL ) then
    Exit;

  MD5s := TMemoryStream.Create;
  idMD5 := TIdHashMessageDigest5.Create;
  StrL.SaveToStream( MD5s );
  try
    {$IFDEF INDY100}
    result := idMD5.HashStreamAsHex( MD5s, 0, MD5s.Size ); // D9/Indy10
    {$ELSE}
    result := idMD5.AsHex( idMD5.HashValue( MD5s ) ); // D7/Indy9
    {$ENDIF}
  except
  end;

  idMD5.Free;
  MD5s.free;
end;
{$IFEND}
{$ENDIF}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
constructor TFrmParameterBackup.CreateNew( AOwner: TComponent );
begin
  inherited CreateNew( AOwner );

  AutoScroll       := False;
  Caption          := PARAMETER_BackupFailCaption_;
  ClientHeight     := 104;
  ClientWidth      := 374;
  Position         := poMainFormCenter;
  PrintScale       := poNone;
  BorderStyle      := bsSingle;
  BorderIcons      := [];

  lblFileName      := TLabel.Create(Self);
  lblText          := TLabel.Create(Self);
  lblAction        := TLabel.Create(Self);
  btnIgnore        := TButton.Create(Self);
  grpBackups       := TGroupBox.Create(Self);
  cbbBackups       := TComboBox.Create(Self);
  btnLoadDifferent := TButton.Create(Self);
  btnCompare       := TButton.Create(Self);
  mmoCompare       := TMemo.Create(Self);

  with lblFileName do
    begin
    Name := 'lblFileName';
    Parent := Self;
    Left := 0;
    Top := 18;
    Width := 323;
    Height := 19;
    Align := alTop;
    Alignment := taCenter;
    AutoSize := False;
    Caption := 'FileName';
    ParentFont := False;
    Font.Size := 11;
    end;
  with lblText do
    begin
    Name := 'lblText';
    Parent := Self;
    Left := 0;
    Top := 0;
    Width := 323;
    Height := 18;
    Align := alTop;
    Alignment := taCenter;
    Caption := PARAMETER_BackupFailText_;
    ParentFont := False;
    Font.Size := 11;    
    end;
  with lblAction do
    begin
    Name := 'lblAction';
    Parent := Self;
    Left := 6;
    Top := 38;
    Height := 18;
    Alignment := taCenter;
    Caption := PARAMETER_BackupActionLabel_;
    ParentFont := False;
    Font.Size := 11;    
    end;
  with btnIgnore do
    begin
    Name := 'btnIgnore';
    Parent := Self;
    Left := 60;
    Top := 40;
    Width := 260;
    Height := 18;
    Caption := PARAMETER_BackupFailButtonCaption_;
    ModalResult := 5;
    TabOrder := 0;
    end;
  with grpBackups do
    begin
    Name := 'grpBackups';
    Parent := Self;
    Left := 0;
    Top := 59;
    Width := 323;
    Height := 44;
    Align := alBottom;
    Caption := 'Backups';
    TabOrder := 1;
    end;
  with cbbBackups do
    begin
    Name := 'cbbBackups';
    Parent := grpBackups;
    Left := 3;
    Top := 16;
    Width := 273;
    Height := 24;
    ItemHeight := 16;
    ParentFont := False;
    TabOrder := 0;
    OnChange := cbbBackupsOnChange;
    end;
  with btnLoadDifferent do
    begin
    Name := 'btnLoadDifferent';
    Parent := grpBackups;
    Left := 277;
    Top := 9;
    Width := 45;
    Height := 31;
    Caption := PARAMETER_BackupButtonLoad_;
    ParentFont := False;
    TabOrder := 1;
    OnClick := btnLoadDifferentClick;
    end;
  with btnCompare do
    begin
    Name := 'btnCompare';
    Parent := grpBackups;
    Left := 324;
    Top := 9;
    Width := 50;
    Height := 31;
    Caption := PARAMETER_BackupButtonCompare_;
    ParentFont := False;
    TabOrder := 1;
    OnClick := btnCompareClick;
    end;
  with mmoCompare do
    begin
    Name := 'mmoCompare';
    Parent := Self;
    Left := 0;
    Top := 104;
    Width := 323;
    Height := 82;
    Align := alBottom;
    Text := '';
    ScrollBars := ssVertical;
    end;
end;

function TFrmParameterBackup.Execute( Sender : T_INI_DATEI; MD5Fail : boolean = True ) : string;
  function FindBackups : TStringList;
  var
    rDirInfo   : TSearchRec;
    iError     : boolean;
    fn         : string;
    {$IFDEF MD5}
    StrL       : TStringList;
    MD5        : ShortString;
    MD5out     : ShortString;
    {$ENDIF}
  begin
    result := TStringList.Create;
    {$IFDEF MD5}
    StrL := TStringList.Create;
    {$ENDIF}

    fn := Format( FILE_EXT_MASTER_, [ ChangeFileExt( Sender.Dateiname, '' ) ] ); // Master
    if FileExists( fn ) then
      begin
      {$IFDEF MD5}
      MD5out := FIND_BACKUPS_NONE_;
      if FileExists( ChangeFileExt( fn, FILE_EXT_CHECKSUM_ ) ) then
        begin
        StrL.LoadFromFile( ChangeFileExt( fn, FILE_EXT_CHECKSUM_ ) );
        if ( StrL.Count > 0 ) then
          begin
          MD5 := Copy( StrL[0], 1, Pos( '*', StrL[0] )-2 );

          StrL.LoadFromFile( fn );

          if ( GetMD5( StrL ) <> MD5 ) then
            MD5out := FIND_BACKUPS_NOK_
          else
            MD5out := FIND_BACKUPS_OK_;
          end
        else
          try
            DeleteFile( PChar( ChangeFileExt( fn, FILE_EXT_CHECKSUM_ ) ) );
          except
          end;
        end;
      result.Add( Format( FIND_BACKUPS_FORMAT_, [ ExtractFileName( fn ), MD5out ] ) );
      {$ELSE}
      result.Add( Format( FIND_BACKUPS_FORMAT_NOSTATE_, [ ExtractFileName( fn ) ] ) );
      {$ENDIF}
      end;

    iError := NOT ( FindFirst( Format( '%s_????-??-??' + FILE_EXT_BACKUP_, [ ChangeFileExt( Sender.Dateiname, '' ) ] ), faAnyFile, rDirInfo) = 0 );
    while ( NOT iError ) do // Regular
      begin
      if ( rDirInfo.Name <> '.' ) AND ( rDirInfo.Name <> '..' ) then
        begin
        {$IFDEF MD5}
        MD5out := FIND_BACKUPS_NONE_;
        fn := ExtractFilePath( Sender.Dateiname ) + rDirInfo.Name;
        if FileExists( ChangeFileExt( fn, FILE_EXT_CHECKSUM_ ) ) then
          begin
          StrL.LoadFromFile( ChangeFileExt( fn, FILE_EXT_CHECKSUM_ ) );
          if ( StrL.Count > 0 ) then
            begin
            MD5 := Copy( StrL[0], 1, Pos( '*', StrL[0] )-2 );

            StrL.LoadFromFile( fn );

            if ( GetMD5( StrL ) <> MD5 ) then
              MD5out := FIND_BACKUPS_NOK_
            else
              MD5out := FIND_BACKUPS_OK_;
            end
          else
            try
              DeleteFile( PChar( ChangeFileExt( fn, FILE_EXT_CHECKSUM_ ) ) );
            except
            end;
          end;

        result.Add( Format( FIND_BACKUPS_FORMAT_, [ {ExtractFilePath( Sender.Dateiname ) + }rDirInfo.Name, MD5out ] ) );
        {$ELSE}
        result.Add( Format( FIND_BACKUPS_FORMAT_NOSTATE_, [ {ExtractFilePath( Sender.Dateiname ) + }rDirInfo.Name ] ) );
        {$ENDIF}
                                                                                                     
        iError := ( FindNext(rDirInfo) <> 0 );
        if iError then
          SysUtils.FindClose(rDirInfo);
        end;
      end;

    {$IFDEF MD5}
    StrL.free;
    {$ENDIF}
  end;
var
  StrL : TStringList;
  f    : string;
begin
  fSender := Sender;
  fFilePath := ExtractFilePath( Sender.Dateiname );

  result := Sender.Dateiname;
  if Visible then
    Exit;

  Caption := PARAMETER_BackupCaption_;
  lblText.Caption := PARAMETER_BackupText_;
  btnIgnore.Caption := PARAMETER_BackupButtonCaption_;
  btnCompare.Visible := NOT MD5Fail;
  mmoCompare.Visible := NOT MD5Fail;

  if MD5Fail then
    begin
    Caption := PARAMETER_BackupFailCaption_;
    lblText.Caption := PARAMETER_BackupFailText_;
    btnIgnore.Caption := PARAMETER_BackupFailButtonCaption_;
    btnLoadDifferent.Width := 97;
    end
  else
    btnLoadDifferent.Width := 45;

  lblFileName.Caption := RightStr( Sender.Dateiname, Length( Sender.Dateiname )-Length( ExtractFilePath( Application.ExeName ) ) );

  StrL := FindBackups;
  cbbBackups.Items.Assign( StrL );
  StrL.free;
  if cbbBackups.Items.Count > 0 then
    begin
    cbbBackups.ItemIndex := 0;
    cbbBackupsOnChange( self );
    end;
  grpBackups.Visible := cbbBackups.Items.Count > 0;

  if grpBackups.Visible then
    ClientHeight := IfThen( MD5Fail, 104, 184 )
  else
    ClientHeight := IfThen( MD5Fail, 104, 184 )-grpBackups.Height;

  if ( ShowModal = mrOK ) then
    begin
    if ( cbbBackups.ItemIndex >= 0 ) then
      begin
      f := StringReplace( cbbBackups.Items[ cbbBackups.ItemIndex ], FILE_EXT_BACKUP_ + ' (' + FIND_BACKUPS_OK_ + ')', FILE_EXT_BACKUP_, [rfReplaceAll] );
      f := StringReplace( f, FILE_EXT_BACKUP_ + ' (' + FIND_BACKUPS_NOK_ + ')', FILE_EXT_BACKUP_, [rfReplaceAll] );
      f := StringReplace( f, FILE_EXT_BACKUP_ + ' (' + FIND_BACKUPS_NONE_ + ')', FILE_EXT_BACKUP_, [rfReplaceAll] );

      result := fFilePath + f;
      end;
    end;
end;

function TFrmParameterBackup.ExecuteAndLoad( Sender : T_INI_DATEI ) : string;
var
  {$IFDEF MD5}
  StrL : TStringList;
  {$ENDIF}
  Backup : String;
begin
  result := '';
  if NOT Assigned( Sender ) then
    Exit;
  Backup := Execute( Sender, False );
  if ( Backup = Sender.Dateiname ) then
    Exit;

  if Assigned( Sender.fIniFile ) then
    Sender.fIniFile.free;
  Sender.fIniFile := TIniFileType.Create( BackUp );
  Sender.BackupLog( Format( LOG_BACKUP_, [ ExtractFileName( Backup ) ] ) );

  {$IFDEF useFastIni}
  Sender.fIniFile.Save( Sender.Dateiname );
  {$ELSE}
  if FileExists( Backup ) then
    begin
    try
      if FileExists( Sender.Dateiname ) then
        DeleteFile( PChar( Sender.Dateiname ) );
      CopyFile( PChar( BackUp ), PChar( Sender.Dateiname ), True );
    except
    end;
    end;
  {$ENDIF}

  {$IFDEF MD5}
  StrL := TStringList.Create;
  {$IFDEF useFastIni}
  Sender.fIniFile.GetStringList( StrL );
  {$ELSE}
  StrL.LoadFromFile( Sender.Dateiname );
  {$ENDIF}
  StrL.Text := Format( FILE_FORMAT_MD5_, [ GetMD5( StrL ), ExtractFileName( Sender.Dateiname ) ] );
  try
    if FileExists( ChangeFileExt( Sender.Dateiname, FILE_EXT_CHECKSUM_ ) ) then
      SysUtils.DeleteFile( ChangeFileExt( Sender.Dateiname, FILE_EXT_CHECKSUM_ ) );
    StrL.SaveToFile( ChangeFileExt( Sender.Dateiname, FILE_EXT_CHECKSUM_ ) );
  except
  end;
  {$ENDIF}

  Sender.fIniFile.Free;
  Sender.fIniFile := nil;

  Sender.Reload;
end;

procedure TFrmParameterBackup.btnLoadDifferentClick(Sender: TObject);
begin
  if cbbBackups.ItemIndex < 0 then
    begin
    ShowMessage( ERROR_NO_BACKUP_SELECTED_ );
    Exit;
    end;
  ModalResult := mrOk;
  Hide;
end;

procedure TFrmParameterBackup.cbbBackupsOnChange(Sender : TObject);
var
  f : string;
  StrL : TStringList;
begin
  if cbbBackups.ItemIndex < 0 then
    Exit;

  f := StringReplace( cbbBackups.Items[ cbbBackups.ItemIndex ], FILE_EXT_BACKUP_ + ' (' + FIND_BACKUPS_OK_ + ')', FILE_EXT_BACKUP_, [rfReplaceAll] );
  f := StringReplace( f, FILE_EXT_BACKUP_ + ' (' + FIND_BACKUPS_NOK_ + ')', FILE_EXT_BACKUP_, [rfReplaceAll] );
  f := StringReplace( f, FILE_EXT_BACKUP_ + ' (' + FIND_BACKUPS_NONE_ + ')', FILE_EXT_BACKUP_, [rfReplaceAll] );

  StrL := TStringList.Create;
  fSender.Compare( fFilePath + f, false, false, StrL );
  mmoCompare.Lines.Assign( StrL );
  StrL.free;
end;

procedure TFrmParameterBackup.btnCompareClick(Sender: TObject);
var
  f : string;
begin
  if cbbBackups.ItemIndex < 0 then
    begin
    ShowMessage( ERROR_NO_BACKUP_SELECTED_ );
    Exit;
    end;

  f := StringReplace( cbbBackups.Items[ cbbBackups.ItemIndex ], FILE_EXT_BACKUP_ + ' (' + FIND_BACKUPS_OK_ + ')', FILE_EXT_BACKUP_, [rfReplaceAll] );
  f := StringReplace( f, FILE_EXT_BACKUP_ + ' (' + FIND_BACKUPS_NOK_ + ')', FILE_EXT_BACKUP_, [rfReplaceAll] );
  f := StringReplace( f, FILE_EXT_BACKUP_ + ' (' + FIND_BACKUPS_NONE_ + ')', FILE_EXT_BACKUP_, [rfReplaceAll] );
  fSender.Compare( fFilePath + f, True, True, nil );
  ModalResult := mrCancel;
  Hide;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
constructor tParameterSynchronizer.Create;
begin
  inherited;
  fLog     := TStringList.Create;
  fStrL    := TStringList.Create;
  fLogging := false;
end;

destructor tParameterSynchronizer.Destroy;
begin
  if Assigned( fIni ) then
    fIni.free;
  fLog.free;
  fStrL.free;
  inherited;
end;

function tParameterSynchronizer.Open( FileName : string; Logging : boolean = false ) : boolean;
var
  MD5File : string;
  LogFile : string;
begin
  result := false;
  if NOT Assigned( self ) then
    Exit;
  if NOT FileExists( FileName ) then
    Exit;

  MD5File := ChangeFileExt( FileName, FILE_EXT_CHECKSUM_ );
  LogFile := ExtractFilePath( FileName ) + ChangeFileExt( ExtractFileName( FileName ), '.' + PARAMETER_LOGDATEI_EXT_ );
  {$IFDEF MD5}
  if IsFileInUse( MD5File ) then
    begin
    if ( GetCurrentThreadID = MainThreadID ) then
      ShowMessage( Format( ERROR_FILE_IN_USE_, [ MD5File ] ) );
    Exit;
    end;
  {$ENDIF}
  if Logging then
    begin
    if IsFileInUse( LogFile ) then
      begin
    if ( GetCurrentThreadID = MainThreadID ) then
      ShowMessage( Format( ERROR_FILE_IN_USE_, [ LogFile ] ) );
      Exit;
      end;
    end;
  if IsFileInUse( FileName ) then
    begin
    if ( GetCurrentThreadID = MainThreadID ) then
      ShowMessage( Format( ERROR_FILE_IN_USE_, [ FileName ] ) );
    Exit;
    end;

  fIni     := TIniFile.Create( FileName );
  fLogging := True;
  result   := True;
end;

function tParameterSynchronizer.Close : boolean;
var
  fn  : String;
  {$IFDEF MD5}
  MD5 : string;
  {$ENDIF}  
begin
  result := false;
  if NOT Assigned( self ) then
    Exit;
  if NOT Assigned( fIni ) then
    Exit;
  result := True;
  if fLogging AND ( fLog.Count = 0 ) then
    begin
    fIni.Free;
    fIni := nil;
    Exit;
    end;

  {$IFDEF useFastIni}
  fIni.Save;
  {$ENDIF}
  {$IFDEF useMemIni}
  fIni.UpdateFile;
  {$ENDIF}

  {$IFDEF MD5}
  {$IFDEF useFastIni}
  fIni.GetStringList( fStrL );
  {$ELSE}
  fStrL.LoadFromFile( fIni.FileName );
  {$ENDIF}

  MD5 := GetMD5( fStrL );
  fStrL.Text := Format( FILE_FORMAT_MD5_, [ MD5, ExtractFileName( fIni.FileName ) ] );
  try
    if FileExists( ChangeFileExt( fIni.FileName, FILE_EXT_CHECKSUM_ ) ) then
      SysUtils.DeleteFile( ChangeFileExt( fIni.FileName, FILE_EXT_CHECKSUM_ ) );
    fStrL.SaveToFile( ChangeFileExt( fIni.FileName, FILE_EXT_CHECKSUM_ ) );
  except
  end;
  {$ENDIF}

  if fLogging then
    begin
    fn := ExtractFilePath( fIni.FileName ) + ChangeFileExt( ExtractFileName( fIni.FileName ), '.' + PARAMETER_LOGDATEI_EXT_ );
    if FileExists( fn ) then
      fStrL.LoadFromFile( fn )
    else
      fStrL.Clear;
    if ( fLog.Count > 0 ) then
      begin
      fStrL.AddStrings( fLog );
      fLog.Clear;
      try
        fStrL.SaveToFile( fn );
      except
      end;
      fStrL.Clear;
      end;
    end;

  fIni.Free;
  fIni := nil;
end;

function tParameterSynchronizer.Update( Parameter : T_INI_DATEI; Section : string; Create : boolean = false ) : boolean;
var
  i : Integer;
begin
  result := false;
  if NOT Assigned( Parameter ) then
    Exit;

  result := True;
  for i := 0 to Parameter.Count-1 do
    begin
    if NOT result then
      Break;
    if ( Parameter[ i ] is T_PARAM_AOI ) then
      begin
      if ( LowerCase( T_PARAM_AOI( Parameter[ i ] ).Section ) <> LowerCase( Section ) ) then
        Continue;
      end
    else if ( Parameter[ i ] is T_PARAM_ROI ) then
      begin
      if ( LowerCase( T_PARAM_ROI( Parameter[ i ] ).Section ) <> LowerCase( Section ) ) then
        Continue;
      end
    else if ( Parameter[ i ] is T_PARAM_ALLGEMEIN ) then
      begin
      if ( LowerCase( T_PARAM_ALLGEMEIN( Parameter[ i ] ).fSection ) <> LowerCase( Section ) ) then
        Continue;
      end
    else
      Continue;
    result := result AND Update( Parameter[ i ], Create );
    end;
end;

function tParameterSynchronizer.Update( Parameter : T_PARAM_BASE; Create : boolean = false ) : boolean;

  procedure AddLog( val : string );
  begin
    if ( val = '' ) then
      Exit;

    fLog.Add( Format( LOG_FORMAT_, [ DateTimeToStr( NOW ), val ] ) );
  end;

  procedure DoInteger( Parameter : T_PARAM_INT );
  var
    oldI : Integer;
  begin
    if fIni.ValueExists( T_PARAM_ALLGEMEIN( Parameter ).fSection, T_PARAM_ALLGEMEIN( Parameter ).fName ) then
      begin
      oldI := fIni.ReadInteger( T_PARAM_ALLGEMEIN( Parameter ).fSection, T_PARAM_ALLGEMEIN( Parameter ).fName, T_PARAM_INT( Parameter ).fDefault );
      if ( oldI <> T_PARAM_INT( Parameter ).fValue ) then
        AddLog( Format( LOG_INTEGER_, [ BeautifyClassName( Parameter ), T_PARAM_ALLGEMEIN( Parameter ).fName, oldI, T_PARAM_INT( Parameter ).fValue ] ) );
      end
    else
      AddLog( Format( LOG_STRING_, [ BeautifyClassName( Parameter ), T_PARAM_ALLGEMEIN( Parameter ).fName, '---', IntToStr( T_PARAM_INT( Parameter ).fValue ) ] ) );
    {$IF NOT Defined( useFastIni ) AND NOT Defined( useMemIni ) AND NOT Defined( useRegistryIni ) }
    try
    {$IFEND}
      fIni.WriteInteger( T_PARAM_ALLGEMEIN( Parameter ).fSection, T_PARAM_INT( Parameter ).fName, T_PARAM_INT( Parameter ).fValue );
    {$IF NOT Defined( useFastIni ) AND NOT Defined( useMemIni ) AND NOT Defined( useRegistryIni ) }
    except
    end;
    {$IFEND}
  end;

  procedure DoReal( Parameter : T_PARAM_REAL );
  var
    oldR : Double;
  begin
    if fIni.ValueExists( T_PARAM_ALLGEMEIN( Parameter ).fSection, T_PARAM_ALLGEMEIN( Parameter ).fName ) then
      begin
//      oldR := fIni.ReadFloat( T_PARAM_ALLGEMEIN( Parameter ).fSection, T_PARAM_ALLGEMEIN( Parameter ).fName, T_PARAM_REAL( Parameter ).fDefault );
      oldR := StrToFloat_Int( fIni.ReadString( T_PARAM_ALLGEMEIN( Parameter ).fSection, T_PARAM_ALLGEMEIN( Parameter ).fName, '-err' ), T_PARAM_REAL( Parameter ).fDefault );
      if ( oldR <> T_PARAM_REAL( Parameter ).fValue ) then
        AddLog( Format( LOG_REAL_, [ T_PARAM_ALLGEMEIN( Parameter ).fName, oldR, T_PARAM_REAL( Parameter ).fValue ] ) );
      end
    else
      AddLog( Format( LOG_STRING_, [ BeautifyClassName( Parameter ), T_PARAM_ALLGEMEIN( Parameter ).fName, '---', FloatToStr( T_PARAM_REAL( Parameter ).fValue ) ] ) );
    {$IF NOT Defined( useFastIni ) AND NOT Defined( useMemIni ) AND NOT Defined( useRegistryIni ) }
    try
    {$IFEND}
      fIni.WriteFloat( T_PARAM_ALLGEMEIN( Parameter ).fSection, T_PARAM_REAL( Parameter ).fName, T_PARAM_REAL( Parameter ).fValue );
    {$IF NOT Defined( useFastIni ) AND NOT Defined( useMemIni ) AND NOT Defined( useRegistryIni ) }
    except
    end;
    {$IFEND}
  end;
var
  i, x  : Integer;
  oldI  : Integer;
  oldI6 : System.Int64;
  oldB  : Boolean;
  oldS  : String;
  oldSL : TStringList;
  {$IF Defined( useMATHROUT ) OR Defined( useTLH_Math )}
  oldP  : TYP_ePunkt;
  oldG  : Typ_eGerade;
  {$IFEND}
begin
  result := false;
  if NOT Assigned( self ) then
    Exit;
  if NOT Assigned( fIni ) then
    Exit;
  if NOT Assigned( Parameter ) then
    Exit;

  if ( Parameter is T_PARAM_AOI ) then
    begin
    if ( T_PARAM_AOI( Parameter ).TopLeftX.Owner.fFileName = fIni.FileName ) then
      Exit;
    end
  else if ( Parameter is T_PARAM_ROI ) then
    begin
    if ( T_PARAM_ROI( Parameter ).x1.Owner.fFileName = fIni.FileName ) then
      Exit;
    end
  else if ( Parameter is T_PARAM_ALLGEMEIN ) then
    begin
    if ( T_PARAM_ALLGEMEIN( Parameter ).Owner.fFileName = fIni.FileName ) then
      Exit;
    end
  else
    Exit;

  if ( Parameter is T_PARAM_AOI ) then
    begin
    if NOT fIni.SectionExists( T_PARAM_AOI( Parameter ).TopLeftX.fSection ) AND NOT Create then
      Exit;
    if NOT fIni.ValueExists( T_PARAM_AOI( Parameter ).TopLeftX.fSection, T_PARAM_AOI( Parameter ).TopLeftX.fName ) AND NOT Create then
      Exit;
    if NOT fIni.ValueExists( T_PARAM_AOI( Parameter ).TopLeftY.fSection, T_PARAM_AOI( Parameter ).TopLeftY.fName ) AND NOT Create then
      Exit;
    if NOT fIni.ValueExists( T_PARAM_AOI( Parameter ).TopRightX.fSection, T_PARAM_AOI( Parameter ).TopRightX.fName ) AND NOT Create then
      Exit;
    if NOT fIni.ValueExists( T_PARAM_AOI( Parameter ).TopRightY.fSection, T_PARAM_AOI( Parameter ).TopRightY.fName ) AND NOT Create then
      Exit;
    if NOT fIni.ValueExists( T_PARAM_AOI( Parameter ).BottomLeftX.fSection, T_PARAM_AOI( Parameter ).BottomLeftX.fName ) AND NOT Create then
      Exit;
    if NOT fIni.ValueExists( T_PARAM_AOI( Parameter ).BottomLeftY.fSection, T_PARAM_AOI( Parameter ).BottomLeftY.fName ) AND NOT Create then
      Exit;
    if NOT fIni.ValueExists( T_PARAM_AOI( Parameter ).BottomRightX.fSection, T_PARAM_AOI( Parameter ).BottomRightX.fName ) AND NOT Create then
      Exit;
    if NOT fIni.ValueExists( T_PARAM_AOI( Parameter ).BottomRightY.fSection, T_PARAM_AOI( Parameter ).BottomRightY.fName ) AND NOT Create then
      Exit;
    end
  else if ( Parameter is T_PARAM_ROI ) then
    begin
    if NOT fIni.SectionExists( T_PARAM_ROI( Parameter ).x1.fSection ) AND NOT Create then
      Exit;

    if NOT fIni.ValueExists( T_PARAM_ROI( Parameter ).x1.fSection, T_PARAM_ROI( Parameter ).x1.fName ) AND NOT Create then
      Exit;
    if NOT fIni.ValueExists( T_PARAM_ROI( Parameter ).y1.fSection, T_PARAM_ROI( Parameter ).y1.fName ) AND NOT Create then
      Exit;
    if NOT fIni.ValueExists( T_PARAM_ROI( Parameter ).x2.fSection, T_PARAM_ROI( Parameter ).x1.fName ) AND NOT Create then
      Exit;
    if NOT fIni.ValueExists( T_PARAM_ROI( Parameter ).y2.fSection, T_PARAM_ROI( Parameter ).y2.fName ) AND NOT Create then
      Exit;
    end
  {$IF Defined( useMATHROUT ) OR Defined( useTLH_Math )}
  else if ( Parameter is T_PARAM_eGerade ) then
    begin
    if NOT fIni.SectionExists( T_PARAM_ALLGEMEIN( Parameter ).fSection ) AND NOT Create then
      Exit;
    if NOT fIni.ValueExists( T_PARAM_ALLGEMEIN( Parameter ).fSection, T_PARAM_eGerade( Parameter ).fName + EGERADE_SUB_EXTENSION_1_ ) AND NOT Create then
      Exit;
    if NOT fIni.ValueExists( T_PARAM_ALLGEMEIN( Parameter ).fSection, T_PARAM_eGerade( Parameter ).fName + EGERADE_SUB_EXTENSION_2_ ) AND NOT Create then
      Exit;
    if NOT fIni.ValueExists( T_PARAM_ALLGEMEIN( Parameter ).fSection, T_PARAM_eGerade( Parameter ).fName + EGERADE_SUB_EXTENSION_3_ ) AND NOT Create then
      Exit;
    end
  else if ( Parameter is T_PARAM_ePunkt ) then
    begin
    if NOT fIni.SectionExists( T_PARAM_ALLGEMEIN( Parameter ).fSection ) AND NOT Create then
      Exit;
    if NOT fIni.ValueExists( T_PARAM_ALLGEMEIN( Parameter ).fSection, T_PARAM_ePunkt( Parameter ).fName + EPUNKT_SUB_EXTENSION_1_ ) AND NOT Create then
      Exit;
    if NOT fIni.ValueExists( T_PARAM_ALLGEMEIN( Parameter ).fSection, T_PARAM_ePunkt( Parameter ).fName + EPUNKT_SUB_EXTENSION_2_ ) AND NOT Create then
      Exit;
    end
  {$IFEND}
  else if ( Parameter is T_PARAM_ALLGEMEIN ) then
    begin
    if NOT fIni.SectionExists( T_PARAM_ALLGEMEIN( Parameter ).fSection ) AND NOT Create then
      Exit;

    if NOT fIni.ValueExists( T_PARAM_ALLGEMEIN( Parameter ).fSection, T_PARAM_ALLGEMEIN( Parameter ).fName ) AND NOT Create then
      Exit;
    end
  else
    Exit;

  if ( Parameter is T_PARAM_NR ) then
    begin
    if fIni.ValueExists( T_PARAM_ALLGEMEIN( Parameter ).fSection, T_PARAM_ALLGEMEIN( Parameter ).fName ) then
      begin
      oldI := fIni.ReadInteger( T_PARAM_ALLGEMEIN( Parameter ).fSection, T_PARAM_ALLGEMEIN( Parameter ).fName, T_PARAM_NR( Parameter ).fDefault );
      if ( oldI <> T_PARAM_NR( Parameter ).fValue ) then
        AddLog( Format( LOG_INTEGER_, [ BeautifyClassName( Parameter ), T_PARAM_ALLGEMEIN( Parameter ).fName, oldI, T_PARAM_NR( Parameter ).fValue ] ) );
      end
    else
      AddLog( Format( LOG_STRING_, [ BeautifyClassName( Parameter ), T_PARAM_ALLGEMEIN( Parameter ).fName, '---', IntToStr( T_PARAM_NR( Parameter ).fValue ) ] ) );
    {$IF NOT Defined( useFastIni ) AND NOT Defined( useMemIni ) AND NOT Defined( useRegistryIni ) }
    try
    {$IFEND}
      fIni.WriteInteger( T_PARAM_ALLGEMEIN( Parameter ).fSection, T_PARAM_ALLGEMEIN( Parameter ).fName, T_PARAM_NR( Parameter ).fValue );
    {$IF NOT Defined( useFastIni ) AND NOT Defined( useMemIni ) AND NOT Defined( useRegistryIni ) }
    except
    end;
    {$IFEND}    
    end
  else if ( Parameter is T_PARAM_BOOL ) then
    begin
    if fIni.ValueExists( T_PARAM_ALLGEMEIN( Parameter ).fSection, T_PARAM_ALLGEMEIN( Parameter ).fName ) then
      begin
      oldB := fIni.ReadBool( T_PARAM_ALLGEMEIN( Parameter ).fSection, T_PARAM_ALLGEMEIN( Parameter ).fName, T_PARAM_BOOL( Parameter ).fDefault );
      if ( oldB <> T_PARAM_BOOL( Parameter ).fValue ) then
        AddLog( Format( LOG_STRING_, [ BeautifyClassName( Parameter ), T_PARAM_ALLGEMEIN( Parameter ).fName, BoolToStr( oldB, True ), BoolToStr( T_PARAM_BOOL( Parameter ).fValue, True ) ] ) );
      end
    else
      AddLog( Format( LOG_STRING_, [ BeautifyClassName( Parameter ), T_PARAM_ALLGEMEIN( Parameter ).fName, '---', BoolToStr( T_PARAM_BOOL( Parameter ).fValue, True ) ] ) );
    {$IF NOT Defined( useFastIni ) AND NOT Defined( useMemIni ) AND NOT Defined( useRegistryIni ) }
    try
    {$IFEND}
      fIni.WriteString( T_PARAM_ALLGEMEIN( Parameter ).fSection, T_PARAM_ALLGEMEIN( Parameter ).fName, BoolToStr( T_PARAM_BOOL( Parameter ).fValue, True ) );
    {$IF NOT Defined( useFastIni ) AND NOT Defined( useMemIni ) AND NOT Defined( useRegistryIni ) }
    except
    end;
    {$IFEND}    
    end
  else if ( Parameter is T_PARAM_INT ) then
    DoInteger( T_PARAM_INT( Parameter ) )
  else if ( Parameter is T_PARAM_INT64 ) then
    begin
    if fIni.ValueExists( T_PARAM_ALLGEMEIN( Parameter ).fSection, T_PARAM_ALLGEMEIN( Parameter ).fName ) then
      begin
      oldI6 := fIni.ReadInteger( T_PARAM_ALLGEMEIN( Parameter ).fSection, T_PARAM_ALLGEMEIN( Parameter ).fName, T_PARAM_INT64( Parameter ).fDefault );
      if ( oldI6 <> T_PARAM_INT64( Parameter ).fValue ) then
        AddLog( Format( LOG_INTEGER_, [ BeautifyClassName( Parameter ), T_PARAM_ALLGEMEIN( Parameter ).fName, oldI6, T_PARAM_INT64( Parameter ).fValue ] ) );
      end
    else
      AddLog( Format( LOG_STRING_, [ BeautifyClassName( Parameter ), T_PARAM_ALLGEMEIN( Parameter ).fName, '---', IntToStr( T_PARAM_INT64( Parameter ).fValue ) ] ) );
    {$IF NOT Defined( useFastIni ) AND NOT Defined( useMemIni ) AND NOT Defined( useRegistryIni ) }
    try
    {$IFEND}
      fIni.WriteInteger( T_PARAM_ALLGEMEIN( Parameter ).fSection, T_PARAM_ALLGEMEIN( Parameter ).fName, T_PARAM_INT64( Parameter ).fValue );
    {$IF NOT Defined( useFastIni ) AND NOT Defined( useMemIni ) AND NOT Defined( useRegistryIni ) }
    except
    end;
    {$IFEND}    
    end
  else if ( Parameter is T_PARAM_REAL ) then
    DoReal( T_PARAM_REAL( Parameter ) )
  else if ( Parameter is T_PARAM_STR ) then
    begin
    if fIni.ValueExists( T_PARAM_ALLGEMEIN( Parameter ).fSection, T_PARAM_ALLGEMEIN( Parameter ).fName ) then
      begin
      oldS := fIni.ReadString( T_PARAM_ALLGEMEIN( Parameter ).fSection, T_PARAM_ALLGEMEIN( Parameter ).fName, T_PARAM_STR( Parameter ).fDefault );
      if ( oldS <> T_PARAM_STR( Parameter ).fValue ) then
        AddLog( Format( LOG_INTEGER_, [ BeautifyClassName( Parameter ), T_PARAM_ALLGEMEIN( Parameter ).fName, oldS, T_PARAM_STR( Parameter ).fValue ] ) );
      end
    else
      AddLog( Format( LOG_STRING_, [ BeautifyClassName( Parameter ), T_PARAM_ALLGEMEIN( Parameter ).fName, '---', T_PARAM_STR( Parameter ).fValue ] ) );
    {$IF NOT Defined( useFastIni ) AND NOT Defined( useMemIni ) AND NOT Defined( useRegistryIni ) }
    try
    {$IFEND}
      fIni.WriteString( T_PARAM_ALLGEMEIN( Parameter ).fSection, T_PARAM_ALLGEMEIN( Parameter ).fName, T_PARAM_STR( Parameter ).fValue );
    {$IF NOT Defined( useFastIni ) AND NOT Defined( useMemIni ) AND NOT Defined( useRegistryIni ) }
    except
    end;
    {$IFEND}    
    end
  else if ( Parameter is T_PARAM_STR_LIST ) then
    begin
    oldSL := TStringList.Create;
    {$IFDEF useFastIni}
    fIni.EnterSection( T_PARAM_ALLGEMEIN( Parameter ).fSection );
    {$ENDIF}
    if fIni.SectionExists( T_PARAM_ALLGEMEIN( Parameter ).fSection ) then
      begin
      fIni.ReadSectionValues( T_PARAM_ALLGEMEIN( Parameter ).fSection, TStrings( oldSL ) );
      for i := 0 to oldSL.Count-1 do
        begin
        x := Pos( '=', oldSL[ i ] );
        oldSL[ i ] := Copy( oldSL[ i ], x+1, Length( oldSL[ i ] )-x );
        end;

      if ( oldSL.Text <> T_PARAM_STR_LIST( Parameter ).fValue.Text ) then
        AddLog( Format( LOG_INTEGER_, [ BeautifyClassName( Parameter ), T_PARAM_ALLGEMEIN( Parameter ).fName, oldS, T_PARAM_STR_LIST( Parameter ).fValue.Text ] ) );
      end
    else
      AddLog( Format( LOG_STRING_, [ BeautifyClassName( Parameter ), T_PARAM_ALLGEMEIN( Parameter ).fName, '---', T_PARAM_STR_LIST( Parameter ).fValue.Text ] ) );
    oldSL.free;

    {$IFDEF useFastIni}
    fIni.ClearSection;
    {$ELSE}
    fIni.EraseSection( T_PARAM_ALLGEMEIN( Parameter ).fSection );
    {$ENDIF}
    for i := 0 to T_PARAM_STR_LIST( Parameter ).fValue.Count-1 do
      {$IF NOT Defined( useFastIni ) AND NOT Defined( useMemIni ) AND NOT Defined( useRegistryIni ) }
      try
      {$IFEND}
        fIni.WriteString( T_PARAM_ALLGEMEIN( Parameter ).fSection, T_PARAM_ALLGEMEIN( Parameter ).fName + IntToStr( i ), T_PARAM_STR_LIST( Parameter ).fValue[ i ] )
      {$IF NOT Defined( useFastIni ) AND NOT Defined( useMemIni ) AND NOT Defined( useRegistryIni ) }
      except
      end;
      {$IFEND}
    end
  else if ( Parameter is T_PARAM_ROI ) then
    begin
    if Assigned( T_PARAM_ROI( Parameter ).x1 ) then
      DoInteger( T_PARAM_ROI( Parameter ).x1 );
    if Assigned( T_PARAM_ROI( Parameter ).y1 ) then
      DoInteger( T_PARAM_ROI( Parameter ).y1 );
    if Assigned( T_PARAM_ROI( Parameter ).x2 ) then
      DoInteger( T_PARAM_ROI( Parameter ).x2 );
    if Assigned( T_PARAM_ROI( Parameter ).y2 ) then
      DoInteger( T_PARAM_ROI( Parameter ).y2 );
    end
  else if ( Parameter is T_PARAM_AOI ) then
    begin
    if Assigned( T_PARAM_AOI( Parameter ).TopLeftX ) then
      DoReal( T_PARAM_AOI( Parameter ).TopLeftX );
    if Assigned( T_PARAM_AOI( Parameter ).TopLeftY ) then
      DoReal( T_PARAM_AOI( Parameter ).TopLeftY );

    if Assigned( T_PARAM_AOI( Parameter ).TopRightX ) then
      DoReal( T_PARAM_AOI( Parameter ).TopRightX );
    if Assigned( T_PARAM_AOI( Parameter ).TopRightY ) then
      DoReal( T_PARAM_AOI( Parameter ).TopRightY );

    if Assigned( T_PARAM_AOI( Parameter ).BottomLeftX ) then
      DoReal( T_PARAM_AOI( Parameter ).BottomLeftX );
    if Assigned( T_PARAM_AOI( Parameter ).BottomLeftY ) then
      DoReal( T_PARAM_AOI( Parameter ).BottomLeftY );

    if Assigned( T_PARAM_AOI( Parameter ).BottomRightX ) then
      DoReal( T_PARAM_AOI( Parameter ).BottomRightX );
    if Assigned( T_PARAM_AOI( Parameter ).BottomRightY ) then
      DoReal( T_PARAM_AOI( Parameter ).BottomRightY );
    end
  {$IF Defined( useMATHROUT ) OR Defined( useTLH_Math )}
  else if ( Parameter is T_PARAM_ePunkt ) then
    begin
    oldP.x := 0;
    oldP.y := 0;

    if fIni.ValueExists( T_PARAM_ALLGEMEIN( Parameter ).fSection, T_PARAM_ALLGEMEIN( Parameter ).fName + EPUNKT_SUB_EXTENSION_1_ ) then
//      oldP.X := fIni.ReadFloat( T_PARAM_ALLGEMEIN( Parameter ).fSection, T_PARAM_ALLGEMEIN( Parameter ).fName + EPUNKT_SUB_EXTENSION_1_, T_PARAM_ePunkt( Parameter ).fDefault.X );
      oldP.X := StrToFloat_Int( fIni.ReadString( T_PARAM_ALLGEMEIN( Parameter ).fSection, T_PARAM_ALLGEMEIN( Parameter ).fName + EPUNKT_SUB_EXTENSION_1_, '-err' ), T_PARAM_REAL( Parameter ).fDefault );
    if fIni.ValueExists( T_PARAM_ALLGEMEIN( Parameter ).fSection, T_PARAM_ALLGEMEIN( Parameter ).fName + EPUNKT_SUB_EXTENSION_2_ ) then
//      oldP.Y := fIni.ReadFloat( T_PARAM_ALLGEMEIN( Parameter ).fSection, T_PARAM_ALLGEMEIN( Parameter ).fName + EPUNKT_SUB_EXTENSION_2_, T_PARAM_ePunkt( Parameter ).fDefault.Y );
      oldP.Y := StrToFloat_Int( fIni.ReadString( T_PARAM_ALLGEMEIN( Parameter ).fSection, T_PARAM_ALLGEMEIN( Parameter ).fName + EPUNKT_SUB_EXTENSION_2_, '-err' ), T_PARAM_REAL( Parameter ).fDefault );

    if ( oldG.nx <> T_PARAM_ePunkt( Parameter ).fValue.x ) OR ( oldG.ny <> T_PARAM_ePunkt( Parameter ).fValue.y ) then
      AddLog( Format( LOG_EPUNKT_, [ T_PARAM_ALLGEMEIN( Parameter ).fName, oldP.x, oldP.y, T_PARAM_ePunkt( Parameter ).fValue.x, T_PARAM_ePunkt( Parameter ).fValue.y ] ) );

    {$IF NOT Defined( useFastIni ) AND NOT Defined( useMemIni ) AND NOT Defined( useRegistryIni ) }
    try
    {$IFEND}
      fIni.WriteFloat( T_PARAM_ALLGEMEIN( Parameter ).fSection, T_PARAM_ALLGEMEIN( Parameter ).fName + EPUNKT_SUB_EXTENSION_1_, T_PARAM_ePunkt( Parameter ).fValue.X );
      fIni.WriteFloat( T_PARAM_ALLGEMEIN( Parameter ).fSection, T_PARAM_ALLGEMEIN( Parameter ).fName + EPUNKT_SUB_EXTENSION_2_, T_PARAM_ePunkt( Parameter ).fValue.Y );
    {$IF NOT Defined( useFastIni ) AND NOT Defined( useMemIni ) AND NOT Defined( useRegistryIni ) }
    except
    end;
    {$IFEND}
    end
  else if ( Parameter is T_PARAM_eGerade ) then
    begin
    oldG.nx := 0;
    oldG.ny := 0;
    oldG.c := 0;

    if fIni.ValueExists( T_PARAM_ALLGEMEIN( Parameter ).fSection, T_PARAM_ALLGEMEIN( Parameter ).fName + EGERADE_SUB_EXTENSION_1_ ) then
//      oldG.NX := fIni.ReadFloat( T_PARAM_ALLGEMEIN( Parameter ).fSection, T_PARAM_ALLGEMEIN( Parameter ).fName + EGERADE_SUB_EXTENSION_1_, T_PARAM_eGerade( Parameter ).fDefault.NX );
      oldG.NX := StrToFloat_Int( fIni.ReadString( T_PARAM_ALLGEMEIN( Parameter ).fSection, T_PARAM_ALLGEMEIN( Parameter ).fName + EGERADE_SUB_EXTENSION_1_, '-err' ), T_PARAM_eGerade( Parameter ).fDefault.NX );
    if fIni.ValueExists( T_PARAM_ALLGEMEIN( Parameter ).fSection, T_PARAM_ALLGEMEIN( Parameter ).fName + EGERADE_SUB_EXTENSION_2_ ) then
//      oldG.NY := fIni.ReadFloat( T_PARAM_ALLGEMEIN( Parameter ).fSection, T_PARAM_ALLGEMEIN( Parameter ).fName + EGERADE_SUB_EXTENSION_2_, T_PARAM_eGerade( Parameter ).fDefault.NY );
      oldG.NY := StrToFloat_Int( fIni.ReadString( T_PARAM_ALLGEMEIN( Parameter ).fSection, T_PARAM_ALLGEMEIN( Parameter ).fName + EGERADE_SUB_EXTENSION_2_, '-err' ), T_PARAM_eGerade( Parameter ).fDefault.NY );
    if fIni.ValueExists( T_PARAM_ALLGEMEIN( Parameter ).fSection, T_PARAM_ALLGEMEIN( Parameter ).fName + EGERADE_SUB_EXTENSION_3_ ) then
//      oldG.C := fIni.ReadFloat( T_PARAM_ALLGEMEIN( Parameter ).fSection, T_PARAM_ALLGEMEIN( Parameter ).fName + EGERADE_SUB_EXTENSION_3_, T_PARAM_eGerade( Parameter ).fDefault.C );
      oldG.C := StrToFloat_Int( fIni.ReadString( T_PARAM_ALLGEMEIN( Parameter ).fSection, T_PARAM_ALLGEMEIN( Parameter ).fName + EGERADE_SUB_EXTENSION_3_, '-err' ), T_PARAM_eGerade( Parameter ).fDefault.C );

    if ( oldG.nx <> T_PARAM_eGerade( Parameter ).fValue.nx ) OR ( oldG.ny <> T_PARAM_eGerade( Parameter ).fValue.ny ) OR ( oldG.c <> T_PARAM_eGerade( Parameter ).fValue.c ) then
      AddLog( Format( LOG_EGERADE_, [ T_PARAM_ALLGEMEIN( Parameter ).fName, oldG.nx, oldG.ny, oldG.c, T_PARAM_eGerade( Parameter ).fValue.nx, T_PARAM_eGerade( Parameter ).fValue.ny, T_PARAM_eGerade( Parameter ).fValue.c ] ) );

    {$IF NOT Defined( useFastIni ) AND NOT Defined( useMemIni ) AND NOT Defined( useRegistryIni ) }
    try
    {$IFEND}
      fIni.WriteFloat( T_PARAM_ALLGEMEIN( Parameter ).fSection, T_PARAM_ALLGEMEIN( Parameter ).fName + EGERADE_SUB_EXTENSION_1_, T_PARAM_eGerade( Parameter ).fValue.NX );
      fIni.WriteFloat( T_PARAM_ALLGEMEIN( Parameter ).fSection, T_PARAM_ALLGEMEIN( Parameter ).fName + EGERADE_SUB_EXTENSION_2_, T_PARAM_eGerade( Parameter ).fValue.NY );
      fIni.WriteFloat( T_PARAM_ALLGEMEIN( Parameter ).fSection, T_PARAM_ALLGEMEIN( Parameter ).fName + EGERADE_SUB_EXTENSION_3_, T_PARAM_eGerade( Parameter ).fValue.C );
    {$IF NOT Defined( useFastIni ) AND NOT Defined( useMemIni ) AND NOT Defined( useRegistryIni ) }
    except
    end;
    {$IFEND}
    end
  {$IFEND}
  else
    Exit;

  result := True;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

initialization
  FrmParameterBackup    := TFrmParameterBackup.CreateNew( nil );
  ParameterSynchronizer := tParameterSynchronizer.Create;

finalization
  FrmParameterBackup.free;
  ParameterSynchronizer.free;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

end.
