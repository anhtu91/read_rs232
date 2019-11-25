unit Mathrout;

{
  enthält eine Sammlung ausgetesteter mathematischer Routinen
  im zweidimensionalen Umfeld
  Autor: Dr. H. Warsitz
  Stand: 19.05.2015

  28.02.03 - Berechnung Winkelhalbierende, Berechnung Winkel
  31.01.03 - Fehler in Geradedrehen (falsche Drehrichtung) behoben
  02.12.03 - Orientierte Winkelberechnung (OWinkel) ergänzt
  26.04.04 - Polarkoordinatenbestimmung
             Orientierte Dreiecksflächen
             Bestimmung der konvexen Hülle einer Punktmenge
             Bestimmung der konvexen Hülle eines bezüglich S sternförmigen Polygons
  17.10.04 - Polarkoordinatenbehandlung
  27.01.05 - Abstand Punkt von Strecke
  15.02.05 - Orientierter Abstand Punkt von Kreisbogen
             Abstand Punkt von Kreisbogen
             Orientierter Abstand Punkt von Kreis
             Abstand Punkt von Kreis
             Geradenbildung durch zwei Punkte P1, P2 "normiert" (d.h. positiver Abstand = rechts von (P1P2))
             Orientierter Abstand Punkt von Strecke
  16.02.05 - Parallele Gerade im Abstand beschleunigt
  19.02.05 - Orientierter_Abstand_Punkt_von_Gerade_plus
             Orientierter_Abstand_Punkt_von_Kreis_plus
             Orientierter_Abstand_Punkt_von_Kreisbogen_plus
             Orientierter_Abstand_Punkt_von_Strecke_plus
  25.02.05 - Orientierter_Abstand_Punkt_von Rechteck_plus
             Orientierter_Abstand_Punkt_von_Kreisbereich_plus
  26.02.05 - Orientierter_Abstand_Punkt_von_Kreisbereich_plus2
  28.02.05 - Im_Winkelbereich
  06.01.06 - Abstand_Punkt_von_Strecke_Sektor
  02.05.06 - Schnitt Polygonzug mit Gerade + Rückgabe Normalenvektor der schneidenden Polygonzugstrecke
  03.06.06 - Ausreißertest einer Punktmenge, die eine Gerade darstellen soll. [ Funktioniert nicht !!!!!]
  20.09.06 - Schnitt Gerade - Ellipse + Sonderfälle Parallele zur x-Achse, Parallele zur y-Achse
             sowie Verschiebung einer Geraden um einen Vektor. Neue Routinen:
             ( Schnittpunkte_Gerade_Ellipse, Schnittpunkte_xParallele_Ellipse,
               Schnittpunkte_yParallele_Ellipse, Verschiebung_der_Gerade )
             Routine Ellipsenpunkt zur Funktion gemacht und fehlerhafte Drehung bereinigt
  21.09.06 - Schnitt Gerade - Kreis + Sonderfälle Parallele zur x-Achse, Parallele zur y-Achse
             Neue Routinen: Schnittpunkte_Gerade_Kreis, Schnittpunkte_xParallele_Kreis,
               Schnittpunkte_yParallele_Kreis
  08.10.06 - neue Routine: Orthogonale_Projektion_Punkt_auf_Gerade_plus
  22.10.06 - neue Routine: Polygonflaechenbewertung
  19.01.07 - Fehler in Polygonflaechenbewertung korrigiert
  06.04.07 - Fehler in Verdrehwinkelbestimmung bei Ellipsenregression eliminiert
  15.06.07 - neue Routine: Schnittpunkte_Kreis_mit_Kreis
  16.05.08 - neue Routine: oWinkel zwischen zwei Geraden
  11.09.08 - numerisches Problem bei Polygonflächenbewertung entschärft
  14.08.11 - neue Routine: EllipsenpunktWinkel, liefert Ellipsenwinkel zu gegebenem Punkt
  02.05.13 - neue Routine; Normierung der Geradendarstellung
  16.07.13 - Korrektur der Polygonflaechenbewertung. Fehler bei Eigenvektor/Eigenwertbestimmung korrigiert
  05.08.13 - Neue Routinen: Varianten der Regressionsgeraden und Minabstandsgeraden mit Fehlerausgabe des Einpassfehler
  25.02.14 - In Polygonflaechenbewertung wird jetzt noch die Länge der auf die beiden Hauptachsen projeizierten Messpunkte ausgegeben
  12.05.14 - Unschärfe in Schnittpunkte_Gerade_Polygonzug bereinigt
  03.08.14 - Neue Routine EllipsenpunktWinkelAbstand hinzugefügt, liefert noch den orientierten Abstand des Punktes zur Ellipse (innen = negativ)
  14.08.14 - MinimumVonArray, MaximumVonArray optimiert
  15.02.15 - Bei Zwei_Geraden_sind_parallel, Prüfung auf Eingangsdaten integriert, bei OWinkel_zwischen_zwei_Geraden die Abfrage nach
             Parallelität ausgebaut da überflüssig
  16.02.15 - Vorzeichenfehler in OrientierteDreiecksflaeche korrigiert.  Betrag war korrekt.
  19.05.15 - Fehlerhafter eingefügter Code (von unbekannt) in Gerade_durch_zwei_Punkte korrigiert
  19.05.15 - Neue Routine "Orientierter_Abstand_Punkt_von_gegebener_Strecke"  (Gülker)
  19.05.15 - Routine "Kreisregression_mit_Ausreisserkontrolle" erweitert um die Rückgabe der aussortierten Punkte und größeren interen Array (Gülker)
}

interface

Const
  MAXANZPOLYGONPUNKTE = 1000;

Type

  TYP_ePunkt = Record
    x : extended;
    y : extended;
    end;

  Typ_eGerade = Record         // nx * x + ny * y = c
    nx : extended;
    ny : extended;
     c : extended;
    end;

  Typ_eKreis = Record          // ( x - mx )^2  + ( y - my )^2 = radius^2
    Mittelpunkt : Typ_ePunkt;  // ( mx ; my )
    Radius      : extended;
    end;

  Typ_eKreisbogen = Record     // Kreisbogen des Kreises "Kreis" von Startwinkel bis Endwinkel
    Kreis       : Typ_eKreis;  // Kreis
    Startwinkel : extended;    // Bogenanfang: Startwinkel in Bogenmaß aus [0, 2 * pi]
    Endwinkel   : extended;    // Bogenende  : Endwinkel in Bogenmaß   aus [0, 2 * pi]
    end;

  Typ_eEllipse = Record        // gedrehte Ellipse mit den beiden Halbmessern
    Mittelpunkt : Typ_ePunkt;
    Radius_x    : extended;
    Radius_y    : extended;
    Drehwinkel  : extended;
    end;

  TYP_POLYGONZUG = Record      // Polygonzug
    Anzahl : Integer;
    Punkte : Array[ 1 .. MAXANZPOLYGONPUNKTE ] of Typ_ePunkt;
    end;

  TYP_ePunktPolar = Record
    w : extended;  // Winkel in Bogenmaß
    r : extended;  // Radius
    end;

  TYP_POLYGONZUGPOLAR = Record      // Polygonzug aus Punkten in Polarkoordinaten
    Anzahl : Integer;
    Punkte : Array[ 1 .. MAXANZPOLYGONPUNKTE ] of Typ_ePunktPolar;
    end;

  TYP_2Matrix = Record  // Matrix
    xx : extended;      // erste Zeile       erste Spalte
    xy : extended;      //                   zweite Spalte
    yx : extended;      // zweite Zeile      erste Spalte
    yy : extended;      //                   zweite Spalte
    end;

  TYP_2AFFINE_ABBILDUNG = Record         // Affine Abbildung  y = A x + b
    Lineare_Abbildung : TYP_2Matrix;
    Verschiebung      : TYP_ePunkt;
    end;

{ ---------------------------------------------------------------------------- }

Function EPunkt(x, y : double) : TYP_ePunkt;

Function Signum( x : Extended ) : extended;

Function Sign( x : Extended ) : extended;

Function Skalarprodukt( A, B : TYP_ePunkt ) : extended;

Function EuklidscheNorm( A : TYP_ePunkt ) : extended;

Function Normierter_Vektor( A : TYP_ePunkt ) : TYP_ePunkt;

Function Winkel( A, B : TYP_ePunkt; Var Winkel : extended ) : integer;

Function WinkelPolarkoordinaten( A : Typ_ePunkt; Var Winkel : extended ) : integer;

Function Im_Winkelbereich( Winkel, Startwinkel, Endwinkel : extended ) : Boolean;

Function OWinkel( A, B : TYP_ePunkt; Var Winkel : extended ) : integer;

Function OrientierteDreiecksflaeche( A, B, C : Typ_ePunkt ) : extended;

Function PolarNachKartesisch( A : Typ_ePunktPolar ) : Typ_ePunkt;

Function KartesischNachPolar( A : Typ_ePunkt ) : Typ_ePunktPolar;

Procedure Arith_Mittel( Var mittelwert : extended; Var Anzahlneu : Integer; neuwert : extended );

Procedure Arith_Mittel_Punkt( Var Punkt_mittelwert : Typ_ePunkt; Var Anzahlneu : Integer; Punkt_neu : Typ_ePunkt );

Procedure Arith_Mittel_Gerade( Var Gerade_mittelwert : Typ_eGerade; Var Anzahlneu : Integer; Gerade_neu : Typ_eGerade );

Function Gebe_x_Koordinate( Gerade : Typ_eGerade; y_Wert : extended; Var x_Wert : Extended ) : Integer;

Function Gebe_y_Koordinate( Gerade : Typ_eGerade; x_Wert : extended; Var y_Wert : Extended ) : Integer;

Function Gerade_mit_minimalem_Abstand ( Var Punkte : Array of Typ_ePunkt;
  AnzPunkte : Longint;  Var Gerade : Typ_eGerade ) : Integer;

Function Gerade_mit_minimalem_Abstand_F ( Var Punkte : Array of Typ_ePunkt;
  AnzPunkte : Longint; Var Gerade : Typ_eGerade; Var Einpassfehler : extended ) : Integer;

(* geht nicht
Function Geraden_mit_minimalem_Abstand_ausreiszerbereinigt( Var Punkte : Array of Typ_ePunkt;
  AnzPunkte : Longint; Bandbreite : extended; Var Gerade : Typ_eGerade ) : Integer;
*)

Function Regressionsgerade( Var Punkte : Array of Typ_ePunkt;
  AnzPunkte : Longint;  Var Gerade : Typ_eGerade ) : Integer;

Function Regressionsgerade_F( Var Punkte : Array of Typ_ePunkt;
  AnzPunkte : Longint;  Var Gerade : Typ_eGerade; Var Einpassfehler : extended ) : Integer;

Function Vertikale_Regressionsgerade( Var Punkte : Array of Typ_ePunkt;
  AnzPunkte : Longint;  Var Gerade : Typ_eGerade ) : Integer;

Function Vertikale_Regressionsgerade_F( Var Punkte : Array of Typ_ePunkt;
  AnzPunkte : Longint;  Var Gerade : Typ_eGerade; Var Einpassfehler : extended ) : Integer;

Function Regressionsgerade_mit_Aussreissertest( horizontal: Boolean; Var Punkte : Array of Typ_ePunkt;
  AnzPunkte : Longint;  Var Gerade : Typ_eGerade; bandbreite: double;
  var indexArrayEliminiertePunkte: array of integer; var anzEliminiert: integer ) : Integer; //

(*
Function AusreiszerElimination_bei_Geraden( Var Punkte : Array of Typ_ePunkt;
  Var AnzPunkte : Longint; Ausreiszerniveau : extended ) : Integer;  // funktioniert nicht richtig !!!
*)

Function Kreisregression( Var Punkte : Array of Typ_ePunkt;
  AnzPunkte : Longint;  Var Mittelpunkt : Typ_ePunkt; Var radius : extended ) : Integer;

{
Function Kreisregression( Var Punkte : Array of Typ_ePunkt;
  AnzPunkte : Longint;  Var Kreis : Typ_eKreis ) : Integer;
}

Function Kreisregression_mit_Ausreisserkontrolle( Var Punkte : Array of Typ_ePunkt;
  AnzPunkte : Longint; Kreiszonenbreite : extended; Var Kreis : Typ_eKreis;
  Var aussortiertPunkte : Array of Typ_ePunkt; var anzAusSort: integer) : Integer;

Function Ellipsenregression( Var Punkte : Array of Typ_ePunkt;
  AnzPunkte : Longint;  Var Ellipse : Typ_eEllipse ) : Integer;

Function Ellipsenpunkt(Ellipse : Typ_eEllipse; Winkel : extended ) : Typ_ePunkt;

Function EllipsenpunktWinkel(Ellipse : Typ_eEllipse; Punkt : Typ_ePunkt;
  Var Winkel : extended; Var Ellipsenpkt : Typ_ePunkt ) : Integer;

Function EllipsenpunktWinkelAbstand(Ellipse : Typ_eEllipse; Punkt : Typ_ePunkt;
  Var Winkel, Abstand : extended; Var Ellipsenpkt : Typ_ePunkt ) : Integer;

Function Gerade_durch_zwei_Punkte( Punkt1, Punkt2 : Typ_ePunkt; Var Gerade : Typ_eGerade ) : Integer;

Function Senkrechte_Gerade_durch_Punkt( Gerade : Typ_eGerade; Punkt : Typ_ePunkt;
  Var SenkrechteGerade : Typ_eGerade ) : Integer;

Function Mittelsenkrechte_einer_Strecke( Punkt1, Punkt2 : Typ_ePunkt;
  Var Mittelsenkrechte : Typ_eGerade ) : Integer;

Function Parallele_Gerade_durch_Punkt( Gerade : Typ_eGerade; Punkt : Typ_ePunkt;
  Var ParalleleGerade : Typ_eGerade ) : Integer;

Function Parallele_Gerade_im_y_Abstand( Gerade : Typ_eGerade; y_Abstand : extended;
  Var ParalleleGerade : Typ_eGerade ) : Integer;

Function Parallele_Gerade_im_x_Abstand( Gerade : Typ_eGerade; x_Abstand : extended;
  Var ParalleleGerade : Typ_eGerade ) : Integer;

Function Parallele_Gerade_im_Abstand( Gerade : Typ_eGerade; OrientierterAbstand : extended;
  Var ParalleleGerade : Typ_eGerade ) : Integer;

Function Schnitt_Gerade_Strecke( Gerade : Typ_eGerade; Punkt1, Punkt2 : Typ_ePunkt;
  Var Schnittpunkt : Typ_ePunkt ) : Integer;

Function Schnitt_Gerade_Strecke_mit_Richtung( Gerade : Typ_eGerade; Punkt1, Punkt2 : Typ_ePunkt;
  Var Schnittpunkt, Richtung : Typ_ePunkt ) : Integer;

Function Orientierter_Abstand_Punkt_von_Gerade( Punkt : Typ_ePunkt; Gerade : Typ_eGerade;
  Var Abstand : extended ) : Integer;

Function Orientierter_Abstand_Punkt_von_Gerade_plus( Punkt : Typ_ePunkt; Gerade : Typ_eGerade;
  Var Abstand : extended; Var Sollpunkt : Typ_ePunkt ) : Integer;

Function Abstand_Punkt_von_Gerade( Punkt : Typ_ePunkt; Gerade : Typ_eGerade;
  Var Abstand : extended ) : Integer;

Function Orientierter_Abstand_Punkt_von_Kreis( Punkt : Typ_ePunkt; Kreis : Typ_eKreis ) : extended;

Function Orientierter_Abstand_Punkt_von_Kreis_plus( Punkt : Typ_ePunkt; Kreis : Typ_eKreis;
  Var Sollpunkt : Typ_ePunkt ) : extended;

Function Abstand_Punkt_von_Kreis( Punkt : Typ_ePunkt; Kreis : Typ_eKreis ) : extended;

Function Orientierter_Abstand_Punkt_von_Kreisbogen( Punkt : Typ_ePunkt; Kreisbogen : Typ_eKreisbogen;
  ImSektor : Boolean ) : extended;

Function Orientierter_Abstand_Punkt_von_Kreisbogen_plus( Punkt : Typ_ePunkt; Kreisbogen : Typ_eKreisbogen;
  ImSektor : Boolean; Var Sollpunkt : Typ_ePunkt ) : extended;

Function Abstand_Punkt_von_Kreisbogen( Punkt : Typ_ePunkt; Kreisbogen : Typ_eKreisbogen ) : extended;

Function Orientierter_Abstand_Punkt_von_Strecke( Punkt, Punkt1, Punkt2 : Typ_ePunkt ) : Extended;

Function Orientierter_Abstand_Punkt_von_gegebener_Strecke( Punkt, Punkt1, Punkt2 : Typ_ePunkt; Gerade : Typ_eGerade ) : Extended;//gü

Function Abstand_Punkt_von_Strecke_Sektor( Punkt, Punkt1, Punkt2 : Typ_ePunkt; Var Sektor : Integer ) : Extended;

Function Orientierter_Abstand_Punkt_von_Strecke_plus( Punkt, Punkt1, Punkt2 : Typ_ePunkt;
  Var Sollpunkt : Typ_ePunkt  ) : Extended;

Function Abstand_Punkt_von_Strecke( Punkt, Punkt1, Punkt2 : Typ_ePunkt ) : Extended;

Function Orientierter_Abstand_Punkt_von_Rechteck_plus( Punkt, PktRu, PktRo, PktLo, PktLu : Typ_ePunkt;
  Var Sollpunkt : Typ_ePunkt; Var Abstandsseite : Integer  ) : Extended;

Function Orientierter_Abstand_Punkt_von_Kreisbereich_plus( Punkt, Mittelpunkt : Typ_ePunkt;
  Radiusklein, Radiusgrosz, Startwinkel, Endwinkel : extended;
  Var Sollpunkt : Typ_ePunkt; Var Abstandsseite : Integer  ) : Extended;

Function Orientierter_Abstand_Punkt_von_Kreisbereich_plus2( Punkt, PktRu, PktRo, PktLo, PktLu : Typ_ePunkt;
  BogenU, BogenO : Typ_eKreisbogen; Var Sollpunkt : Typ_ePunkt; Var Abstandsseite : Integer  ) : Extended;

Function Abstand_Punkt_von_Punkt( Punkt1, Punkt2 : Typ_ePunkt ) : Extended;

Function Mittelpunkt( Punkt1, Punkt2 : Typ_ePunkt ) : Typ_ePunkt;

Function Zwei_Geraden_sind_Parallel( Gerade1, Gerade2 : Typ_eGerade;
  Var parallel : Boolean ) : Integer;

Function Zwei_Geraden_sind_Orthogonal( Gerade1, Gerade2 : Typ_eGerade;
  Var Orthogonal : Boolean) : Integer;

Function Cosinus_des_Winkel_zwischen_zwei_Geraden( Gerade1, Gerade2 : Typ_eGerade;
  Var Cosinus_winkel : extended ) : Integer;

Function Normiere_Gerade( Gerade : Typ_eGerade; Var NormGerade : Typ_eGerade ) : Integer;

Function Winkel_zwischen_zwei_Geraden( Gerade1, Gerade2 : Typ_eGerade;
  Var winkel : extended ) : Integer;

Function Tangens_des_Winkel_zwischen_zwei_Geraden( Gerade1, Gerade2 : Typ_eGerade;
  Var Tangens_winkel : extended ) : Integer;

Function oWinkel_zwischen_zwei_Geraden( Gerade1, Gerade2 : Typ_eGerade;
  Var winkel : extended ) : Integer;

Function Schnittpunkt_Zweier_Geraden( Gerade1, Gerade2 : Typ_eGerade;
  Var Schnittpunkt : Typ_ePunkt ) : Integer;

Function Orthogonale_Projektion_Punkt_auf_Gerade( Punkt : Typ_ePunkt; Gerade : Typ_eGerade;
  Var Projektionspunkt : Typ_ePunkt ) : Integer;

Function Orthogonale_Projektion_Punkt_auf_Gerade_plus( Punkt : Typ_ePunkt; Gerade : Typ_eGerade;
  Var lambdaGerade : extended; Var Projektionspunkt : Typ_ePunkt ) : Integer;

Function Drehung_der_Gerade( UrGerade : Typ_eGerade; Drehpunkt : Typ_ePunkt;
  Drehwinkel : extended; Var BildGerade : Typ_eGerade ) : integer;

Function Verschiebung_der_Gerade( UrGerade : Typ_eGerade; Verschiebung : Typ_ePunkt;
  Var BildGerade : Typ_eGerade ) : integer;

Function Winkelhalbierende_zu_Winkel_durch_drei_Punkte( A, B, C : Typ_ePunkt;
  Var Winkelhalbierende : Typ_eGerade ) : Integer;

Function Richtung_der_Winkelhalbierenden_zu_Winkel_durch_drei_Punkte( A, B, C : Typ_ePunkt;
  Var Richtung : extended ) : Integer;

Function Schnitt_Gerade_Polygonzug( Gerade : Typ_eGerade; Polygonzug : Typ_Polygonzug;
                            Var Schnittpunkt : Typ_ePunkt ) : Integer;

Function Schnitt_Gerade_Polygonzug_mit_Richtung( Gerade : Typ_eGerade; Polygonzug : Typ_Polygonzug;
                            Var Schnittpunkt, Richtung : Typ_ePunkt ) : Integer;

Function Schnittpunkte_Gerade_Polygonzug( Gerade : Typ_eGerade;
  Polygonzug : Typ_Polygonzug; Var Schnittpunkte : Typ_Polygonzug ) : Integer;

Function Polygonflaechenbewertung( Var Punkte : Array of Typ_ePunkt;
  AnzPunkte : Longint; Var Flaechenschwerpunkt : Typ_ePunkt; Var Flaeche : extended;
  Var Hauptachse1, Hauptachse2 : Typ_eGerade; Var Abstand1, Abstand2, Abstand3, Abstand4,
  Projektionsbereich1, Projektionsbereich2 : extended ) : Integer;

Function Schnittpunkte_Gerade_Ellipse( Gerade : Typ_eGerade;
  Ellipse : Typ_eEllipse; Var AnzahlSchnittpunkte : Integer; Var SP1, SP2 : Typ_ePunkt ) : Integer;

Function Schnittpunkte_xParallele_Ellipse( yWert : extended;
  Ellipse : Typ_eEllipse; Var AnzahlSchnittpunkte : Integer; Var SP1, SP2 : Typ_ePunkt ) : Integer;

Function Schnittpunkte_yParallele_Ellipse( xWert : extended;
  Ellipse : Typ_eEllipse; Var AnzahlSchnittpunkte : Integer; Var SP1, SP2 : Typ_ePunkt ) : Integer;

Function Schnittpunkte_Gerade_Kreis( Gerade : Typ_eGerade;
  Kreis : Typ_eKreis; Var AnzahlSchnittpunkte : Integer; Var SP1, SP2 : Typ_ePunkt ) : Integer;

Function Schnittpunkte_xParallele_Kreis( yWert : extended;
  Kreis : Typ_eKreis; Var AnzahlSchnittpunkte : Integer; Var SP1, SP2 : Typ_ePunkt ) : Integer;

Function Schnittpunkte_yParallele_Kreis( xWert : extended;
  Kreis : Typ_eKreis; Var AnzahlSchnittpunkte : Integer; Var SP1, SP2 : Typ_ePunkt ) : Integer;

Function Schnittpunkte_Kreis_mit_Kreis( Kreis1, Kreis2 : Typ_eKreis;
  Var AnzahlSchnittpunkte : Integer; Var SP1, SP2 : Typ_ePunkt ) : Integer;

Function Matrix_plus_Matrix( A, B : TYP_2Matrix ) : TYP_2Matrix;

Function Matrix_minus_Matrix( A, B : TYP_2Matrix ) : TYP_2Matrix;

Function Matrix_mal_Matrix( A, B : TYP_2Matrix ) : TYP_2Matrix;

Function Matrix_mal_Vektor( A : TYP_2Matrix; P : TYP_ePunkt ) : TYP_ePunkt;

Function Matrix_mal_Skalar( A : TYP_2Matrix; S : extended ) : TYP_2Matrix;

Function Vektor_plus_Vektor( P, Q : TYP_ePunkt ) : TYP_ePunkt;

Function Vektor_minus_Vektor( P, Q : TYP_ePunkt ) : TYP_ePunkt;

Function Vektor_mal_Skalar( P : TYP_ePunkt; S : extended ) : TYP_ePunkt;

Function Determinante( A : TYP_2Matrix ) : extended;

Function Inverse_Matrix( A : TYP_2Matrix; Var Inv_A : TYP_2Matrix ) : integer;

Function Affine_Abbildung_aus_Bild_und_Urbild( U1, U2, U3, B1, B2, B3 : TYP_ePunkt;
  Var Affine_Abbildung : TYP_2Affine_Abbildung ) : integer;

Function Affine_Abbildung_anwenden( Affine_Abbildung : TYP_2Affine_Abbildung;
  P : TYP_ePunkt ) : TYP_ePunkt;

Function Orthogonale_Affine_Abbildung_mit_Faktor_aus_Bild_und_Urbild
  ( U1, U2, U3, B1, B2, B3 : TYP_ePunkt; Faktor : extended;
    Var Affine_Abbildung : TYP_2Affine_Abbildung ) : integer;

Function Bestimme_Drehung( Drehpunkt : Typ_ePunkt; Drehwinkel : extended ) : TYP_2Affine_Abbildung;

Function Umkreis_Radius( P1, P2, P3 : Typ_ePunkt; Var Radius : extended ) : integer;

Function Umkreis_Mittelpunkt( P1, P2, P3 : Typ_ePunkt; Var Mittelpunkt : Typ_ePunkt ) : integer;

Function Konvexe_Huelle( Punktmenge : Typ_Polygonzug ) : Typ_Polygonzug;

Function Konvexe_Huelle_zu_Stern( Punktmenge : Typ_Polygonzug; Var KonvexeHuelle : Typ_Polygonzug ) : Integer;

function MinimumVonArray(const Data: array of double; Anzahl : integer; var minimum : double) : integer;

function MaximumVonArray(const Data: array of double; Anzahl : integer; var maximum : double) : integer;

{ ---------------------------------------------------------------------------- }

implementation

Uses
  math;

Const
  eps : extended = 1.0E-15;      { Rechen-Genauigkeit }

{ ---------------------------------------------------------------------------- }

Function  EPunkt(x,y: double): TYP_ePunkt;
begin
  Result.x := x;
  Result.y := y;
end;

{ ---------------------------------------------------------------------------- }

Function Signum( x : Extended ) : extended;
  { Die Funktion liefert
                1    wenn x positiv ist
               -1    wenn x negativ ist
                0    sonst
  }
  Begin
  try
    If x > 0.0
    then
      result := 1.0
    else
      If x < 0.0
      then
        result := -1.0
      else
        result := 0.0
  except
    result := -9999.9;
    end;
  end;

{-----------------------------------------------------------------------------------------}

Function Sign( x : Extended ) : extended;
  { Die Funktion liefert
               -1    wenn x negativ ist
                1    sonst
  }
  Begin
  try
    If x < 0.0
    then
      result := -1.0
    else
      result := 1.0
  except
    result := -9999.9;
    end;
  end;

{-----------------------------------------------------------------------------------------}

Function Skalarprodukt( A, B : TYP_ePunkt ) : extended;
  { Berechnet a.x * b.x + a.y * b.y }
  Begin
  result := A.x * B.x + A.y * B.y
  end;

{-----------------------------------------------------------------------------------------}

Function EuklidscheNorm( A : TYP_ePunkt ) : extended;
  { Berechnet die euklidische Länge von A = sqrt( a.x * a.x + a.y * a.y ) }
  Begin
  result := sqrt( Skalarprodukt( A, A ) )
  end;

{-----------------------------------------------------------------------------------------}

Function Normierter_Vektor( A : TYP_ePunkt ) : TYP_ePunkt;
  { Normiert den übergebenen Vektor auf die Länge 1, Nullvektor wird unverändert zurückgegegeben }
  Var
    Laenge : extended;
  Begin
  Try
    Laenge := 1.0 / EuklidscheNorm( A );
    result := Vektor_mal_Skalar( A, Laenge );
  except
    result := A
    end;
  end;

{-----------------------------------------------------------------------------------------}

Function Winkel( A, B : TYP_ePunkt; Var Winkel : extended ) : integer;
  { Berechnet Winkel zwischen A und B in Bogenmaß
     0 - Alles OK
    -1 - A hat Länge 0
    -2 - B hat Länge 0
  }
  Var
    LaengeA : extended;
    LaengeB : extended;
  Begin
  LaengeA := EuklidscheNorm( A );
  If LaengeA < eps
  then
    Begin
    result := -1;
    exit
    end;
  LaengeB := EuklidscheNorm( B );
  If LaengeB < eps
  then
    Begin
    result := -2;
    exit
    end;
  Winkel := arccos( Skalarprodukt( A, B ) / ( LaengeA * LaengeB ) );
  result := 0
  end;

{-----------------------------------------------------------------------------------------}

Function WinkelPolarkoordinaten( A : Typ_ePunkt; Var Winkel : extended ) : integer;
  { Für den Punkt A wird der Winkel errechnet, den er in Polarkoordinaten hätte.
    Der Winkel wird in Bogenmaß ausgegeben und liegt im Bereich von 0 bis 2 Pi

     0 - Alles OK
    -1 - A ist der Ursprung, dem kann kein Winkel zugeordnet werden.
  }
  Begin
  If EuklidscheNorm( A ) < eps
  then
    Begin
    result := -1;
    exit
    end;
  Winkel := Arctan2( A.y, A.x );
  If Winkel < 0.0
  then
    Winkel := Winkel + 2.0 * pi;
  result := 0;
  end;

{-----------------------------------------------------------------------------------------}

Function Im_Winkelbereich( Winkel, Startwinkel, Endwinkel : extended ) : Boolean;
  { Gibt true zurück, wenn der Winkel "Winkel" im Bereich zwischen Startwinkel und Endwinkel liegt
    einschließlich der Grenzen.
    Alle Winkelangaben müssen positiv sein und zwischen 0 und 2 * pi liegen }
  Var
    Endw : extended;
    Wnkl : extended;

  Begin
  Endw := Endwinkel - Startwinkel;
  If Endw < 0
  then
    Endw := Endw + 2 * pi;
  Wnkl := Winkel - Startwinkel;
  If Wnkl < 0
  then
    Wnkl := Wnkl + 2 * pi;
  result := ( 0 <= Wnkl ) and ( Wnkl <= Endw )
  end;

{-----------------------------------------------------------------------------------------}

Function OWinkel( A, B : TYP_ePunkt; Var Winkel : extended ) : integer;
  { Berechnet den orientierten Winkel in Bogenmaß zwischen den Vektorspitzen von A und B,
    wenn man die beiden Vektorfüße sich im Ursprung vereinigt denkt. Dies heißt man läuft bei
    A los (im Gegenuhrzeigersinn um den Ursprung) bis man auf B trifft.
     0 - Alles OK
    -1 - A hat Länge 0
    -2 - B hat Länge 0
  }
  Var
    WinkelA : extended;
    WinkelB : extended;
  Begin
  If WinkelPolarkoordinaten( A, WinkelA ) < 0
  then
    Begin
    result := -1;
    exit
    end;
  If WinkelPolarkoordinaten( B, WinkelB ) < 0
  then
    Begin
    result := -2;
    exit
    end;
  Winkel := WinkelB - WinkelA;
  If Winkel < 0
  then
    Winkel := Winkel + 2 * pi;
  result := 0
  end;

{-----------------------------------------------------------------------------------------}

Function OrientierteDreiecksflaeche( A, B, C : Typ_ePunkt ) : extended;
  { Berechnet die Fläche des Dreiecks, welches aus den drei Punkten
    A, B und C gebildet wird. Der errechnete
    Wert ist Vorzeichenbehaftet. Ein positiver Wert besagt, dass der
    Umlaufsinn der drei Punkte (mathematisch) positiv ist und dass der
    Winkel (A, B, C) negativ ist
  }
  Begin
  result := 0.5 * ( A.x * ( B.y - C.y ) +  B.x * ( C.y - A.y ) + C.x * ( A.y - B.y ) )
  end;

{-----------------------------------------------------------------------------------------}

Function PolarNachKartesisch( A : Typ_ePunktPolar ) : Typ_ePunkt;
  { ein Punkt in Polarkoordinaten wird in Kartesische Koordinaten umgewandelt}

  Var
    Sin_phi : extended;
    Cos_phi : extended;
  Begin
  SinCos(A.w, Sin_phi, Cos_phi );
  result.x := A.r * Cos_phi;
  result.y := A.r * Sin_phi
  end;

{-----------------------------------------------------------------------------------------}

Function KartesischNachPolar( A : Typ_ePunkt ) : Typ_ePunktPolar;
  { ein Punkt in kartesischen Koordinaten wird in Polarkoordinaten umgewandelt
    Der Winkel wird in Bogenmaß von 0 bis 2pi ausgegeben.
    Der Ursprung wird auf Radius 0 und Winkel 0 gesetzt. }

  Var
    Winkel : Extended;

  Begin
  If WinkelPolarkoordinaten( A, Winkel ) < 0
  then
    Begin
    result.w := 0;
    result.r := 0
    end
  else
    Begin
    result.w := Winkel;
    result.r := EuklidscheNorm( A )
    end
  end;

{-----------------------------------------------------------------------------------------}

Procedure Arith_Mittel( Var mittelwert : extended; Var Anzahlneu : Integer; neuwert : extended );
  { kumulierendes arithmetisches Mittel wird gebildet
    Rückgabewerte :
      mittelwert - ist das kumulierte Mittel
      Anzahlneu  - enthält die nach der Kumulierung darin kumulierte Anzahl
  }
  Var
    eAnzahl : extended;
  Begin
  try
    Inc(Anzahlneu);
    eAnzahl    := Anzahlneu;
    mittelwert := ( mittelwert * ( eAnzahl - 1.0 ) + neuwert ) / eAnzahl;
  except
    end;
  end;

{-----------------------------------------------------------------------------------------}

Procedure Arith_Mittel_Punkt( Var Punkt_mittelwert : Typ_ePunkt; Var Anzahlneu : Integer; Punkt_neu : Typ_ePunkt );
  Var
    anzahl : Integer;
  Begin
  try
    Anzahl := Anzahlneu;
    Arith_Mittel( Punkt_mittelwert.x, Anzahl, Punkt_neu.x );
    Arith_Mittel( Punkt_mittelwert.y, Anzahlneu, Punkt_neu.y );
  except
    end;
  end;

{-----------------------------------------------------------------------------------------}

Procedure Arith_Mittel_Gerade( Var Gerade_mittelwert : Typ_eGerade; Var Anzahlneu : Integer; Gerade_neu : Typ_eGerade );
  { Diese Mittelung der Geraden geht davon aus, daß die Geraden gleichartig erzeugt
    wurden. Dies heißt, die drei beschreibenden Koeffizienten der Geraden sind jeweils
    in der selben Größenordnung.
    Man behält die selbe Gerade, wenn man alle drei Koeffizienten mit einer
    Konstanten <> 0 multipliziert. Je nach Wahl dieser Konstanten kann man das
    Gewicht der Geraden in der resultierenden mittleren Gerade verändern.
    Man könnte dieses Problem entschärfen, in dem man die Gleichung der
    zu addierenden Geraden so normiert, daß der Normalenvektor (nx, ny) ein
    Einheitsvektor wäre und ny >= 0.
  }

  Var
    Anzahl : Integer;
  Begin
  try
    Anzahl := Anzahlneu;
    Arith_Mittel( Gerade_mittelwert.nx, Anzahl, Gerade_neu.nx );
    Anzahl := Anzahlneu;
    Arith_Mittel( Gerade_mittelwert.ny, Anzahl, Gerade_neu.ny );
    Arith_Mittel( Gerade_mittelwert.c,  Anzahlneu, Gerade_neu.c  );
  except
    end;
  end;

{ ---------------------------------------------------------------------------- }

Function Gebe_x_Koordinate( Gerade : Typ_eGerade; y_Wert : extended; Var x_Wert : Extended ) : Integer;
  { gibt die x-Koordinate des Punktes auf der Geraden zu einem gegebenen y-Wert.
    Rückgabewerte :
      0 - Alles Ok
     -1 - keine Gerade
     -2 - es gibt keinen x-Wert
  }
  Begin
  try
    If (abs(Gerade.nx) < eps)
    then
      Begin
      If (abs(Gerade.ny) < eps)
      then
        result := -1
      else
        result := -2;
      exit;
      end;
    x_Wert := ( Gerade.c - Gerade.ny * y_Wert ) / Gerade.nx;
    result := 0;
  except
    result := -9999
    end;
  end;

{ ---------------------------------------------------------------------------- }

Function Gebe_y_Koordinate( Gerade : Typ_eGerade; x_Wert : extended; Var y_Wert : Extended ) : Integer;
  { gibt die y-Koordinate des Punktes auf der Geraden zu einem gegebenen x-Wert.
    Rückgabewerte :
      0 - Alles Ok
     -1 - keine Gerade
     -2 - es gibt keinen y-Wert
  }
  Begin
  try
    If (abs(Gerade.ny) < eps)
    then
      Begin
      If (abs(Gerade.nx) < eps)
      then
        result := -1
      else
        result := -2;
      exit;
      end;
    y_Wert := ( Gerade.c - Gerade.nx * x_Wert ) / Gerade.ny;
    result := 0;
  except
    result := -9999
    end;
  end;

{ ---------------------------------------------------------------------------- }

Function Gerade_mit_minimalem_Abstand( Var Punkte : Array of Typ_ePunkt;
  AnzPunkte : Longint;  Var Gerade : Typ_eGerade ) : Integer;
  { Diese Funktion bestimmt die Gerade der Form
           nx * x + ny * y = c       ( nx oder ny ist ungleich 0 da sonst keine Gerade )
    bei welcher der Abstand zu den in x_Werte und y_Werte gegebenen Punkten
    minimal ist. Um den Euklidischen Abstand zu haben wird noch verlangt, daß
                        nx * nx  + ny * ny = 1
    ist.

    Bei der Regressionsgeraden wird die Gerade bestimmt, deren y-Abstand minimal ist.
    Für funktionale Zusammenhänge ( y hängt von x ab ) auch sehr vernünftig.

    Bei Geometrie-Belangen ist jedoch x und (!!!)  y  unabhängig.
    Returnwerte:
       0 - alles OK
      -1 - alle Punkte (x,y) liegen auf einem Kreis (auch Radius 0 möglich)
      -2 - Anzpaare < 2 }
  Var
    x_mw : extended;      { Mittelwert }
    y_mw : extended;
    xx_s : extended;      { Varianz x }
    yy_s : extended;      { Varianz y }
    xy_s : extended;      { Kovarianz }

    zaehler : extended;
    nenner  : extended;
    anzahl  : extended;

    dx      : extended;
    dy      : extended;
    lv      : LongInt;   { Laufvariable }

    x_max   : extended;
    y_max   : extended;
    faktor  : extended;


  Begin
  try
    If AnzPunkte < 2
    then
      Begin
      result := -2;
      exit
      end
    else
      anzahl := AnzPunkte;

    { Mittelwerte bestimmen }
    x_mw  := Punkte[ 0 ].x;
    y_mw  := Punkte[ 0 ].y;
    x_max := abs(Punkte[ 0 ].x);
    y_max := abs(Punkte[ 0 ].y);
    For lv := 1 to AnzPunkte - 1 do
      Begin
      x_mw := x_mw + Punkte[ lv ].x;
      y_mw := y_mw + Punkte[ lv ].y;
      if x_max < abs(Punkte[ lv ].x)
      then
        x_max := abs(Punkte[ lv ].x);
      if y_max < abs(Punkte[ lv ].y)
      then
        y_max := abs(Punkte[ lv ].y);
      end;
    x_mw := x_mw / anzahl;
    y_mw := y_mw / anzahl;

    If (x_max - x_mw) > (y_max - y_mw)
    then
      faktor := (x_max - x_mw)
    else
      faktor := (y_max - y_mw);

    If abs(faktor) < eps
    then
      faktor := 1.0;

    { Varianzen und Kovarianzen bestimmen }
    dx   := (Punkte[ 0 ].x - x_mw) / faktor;
    dy   := (Punkte[ 0 ].y - y_mw) / faktor;
    xx_s := dx * dx;
    yy_s := dy * dy;
    xy_s := dx * dy;
    For lv := 1 to AnzPunkte - 1 do
      Begin
      dx   := (Punkte[ lv ].x - x_mw) / faktor;
      dy   := (Punkte[ lv ].y - y_mw) / faktor;
      xx_s := xx_s + dx * dx;
      yy_s := yy_s + dy * dy;
      xy_s := xy_s + dx * dy;
      end;

    { Zähler bestimmen }
    zaehler := xx_s - yy_s;

    { Geradenparameter bestimmen}
    If abs(xy_s) <= eps
    then
      Begin
      If abs(zaehler) <= eps
      then
        Begin
        result := -1;
        exit
        end
      else
        If zaehler > 0.0
        then
          Gerade.nx := 0.0
        else
          Gerade.nx := 1.0;
      end
    else  { xy_s ungleich 0 }
      Begin
      { Nenner bestimmen }
      nenner  := sqrt( 4.0 * sqr(xy_s) + sqr(zaehler) );

      { nenner = 0, sollte hier zwar nicht mehr vorkommen aber zur Sicherheit }
      If abs(nenner) <= eps
      then { numerisch 0 }
        Begin
        result := -1;
        exit
        end;

      If xy_s > 0.0
      then
        Gerade.nx := - sqrt( 0.5 * ( 1.0 - zaehler / nenner ) )
      else { xy_s negativ }
        Gerade.nx :=   sqrt( 0.5 * ( 1.0 - zaehler / nenner ) );
      end;

    { die restlichen beiden Parameter bestimmen }
    Gerade.ny := sqrt( 1.0 - sqr(Gerade.nx) );
    Gerade.c  := Gerade.nx * x_mw + Gerade.ny * y_mw;

    result := 0
  except
    result := -9999
    end;
  end;

{ ---------------------------------------------------------------------------- }

Function Gerade_mit_minimalem_Abstand_F( Var Punkte : Array of Typ_ePunkt;
  AnzPunkte : Longint;  Var Gerade : Typ_eGerade; Var Einpassfehler : extended ) : Integer;
  { Diese Funktion bestimmt die Gerade der Form
           nx * x + ny * y = c       ( nx oder ny ist ungleich 0 da sonst keine Gerade )
    bei welcher der Abstand zu den in x_Werte und y_Werte gegebenen Punkten
    minimal ist. Um den Euklidischen Abstand zu haben wird noch verlangt, daß
                        nx * nx  + ny * ny = 1
    ist.

    Bei der Regressionsgeraden wird die Gerade bestimmt, deren y-Abstand minimal ist.
    Für funktionale Zusammenhänge ( y hängt von x ab ) auch sehr vernünftig.

    Bei Geometrie-Belangen ist jedoch x und (!!!)  y  unabhängig.

    Zusätzlich wird noch der Einpassfehler (=Summe der quadratischen Abweichungen) zurückgegeben.

    Returnwerte:
       0 - alles OK
      -1 - alle Punkte (x,y) liegen auf einem Kreis (auch Radius 0 möglich)
      -2 - Anzpaare < 2
      -3 - Fehler bei Abstandsbestimmung!
  }
  Var
    lv      : Integer;
    res     : Integer;
    Abstand : extended;
  Begin
  try
    res := Gerade_mit_minimalem_Abstand( Punkte, AnzPunkte, Gerade );
    If res < 0
    then
      Begin
      Einpassfehler := -9999.9999;
      Result        := res;
      exit
      end;
    Einpassfehler := 0.0;
    For lv := 0 to Anzpunkte - 1 do
      Begin
      res := Abstand_Punkt_von_Gerade( Punkte[ lv ], Gerade, Abstand );
      If res < 0
      then
        Begin
        Einpassfehler := -9999.9999;
        Result        := -3;
        exit
        end;
      Einpassfehler := Einpassfehler + sqr( Abstand );
      end;
    result := 0
  except
    result := -9999
    end
  end;


{ ---------------------------------------------------------------------------- }
(*
Function Geraden_mit_minimalem_Abstand_ausreiszerbereinigt( Var Punkte : Array of Typ_ePunkt;
  AnzPunkte : Longint; Bandbreite : extended; Var Gerade : Typ_eGerade ) : Integer;
  { Es wird eine Gerade mit minimalem Abstand bestimmt und die übergebenen Punkte
    werden auf Ausreißer hin untersucht. Das Ausreißeruntersuchungsverfahren
    stellt sicher, dass alle Punkte im Bereich +- Bandbreite um die Gerade herum legen.

    Returnwerte:
       0 - alles OK
      -1 - alle Punkte (x,y) liegen auf einem Kreis (auch Radius 0 möglich)
      -2 - Anzpaare < 2
  }
  Var
    lv                  : Integer;   { Laufvariable }
    Summe_Punkte        : Typ_ePunkt;      { Mittelwert }
    Mittelwert          : Typ_ePunkt;      { Mittelwert }
    Mittelwert_Rechteck : Typ_ePunkt;      { Rechteck }
    x_max               : extended;
    y_max               : extended;
    x_min               : extended;
    y_min               : extended;
    x_delta_mittel      : extended;
    y_delta_mittel      : extended;
    Polygon             : TYP_POLYGONZUG;
    Ausreiszer          : Array[ 1 .. MAXANZPOLYGONPUNKTE ] of Boolean;
    rc                  : Integer;
    maxEckenAbstand     : extended;
    minEckenAbstand     : extended;
    Hilfspunkt          : Typ_ePunkt;
    EckenAbstand        : extended;
    A_Indikator         : extended;  // Abstandsindikator
    M_Indikator         : extended;  // Mittelpunktsindikator
    Geradenabstand      : extended;

  Begin
  try
    { Kennwerte bestimmen }
    Polygon.Anzahl      := AnzPunkte;
    Summe_Punkte        := Punkte[ 0 ];
    x_max               := Punkte[ 0 ].x;
    y_max               := Punkte[ 0 ].y;
    x_min               := Punkte[ 0 ].x;
    y_min               := Punkte[ 0 ].y;
    Polygon.Punkte[ 1 ] := Punkte[ 0 ];
    Ausreiszer[ 1 ]     := false;
    For lv := 1 to Polygon.Anzahl - 1 do
      Begin
      Polygon.Punkte[ lv + 1 ] := Punkte[ lv ];
      Ausreiszer[ lv + 1 ]     := false;
      Summe_Punkte.x           := Summe_Punkte.x + Punkte[ lv ].x;
      Summe_Punkte.y           := Summe_Punkte.y + Punkte[ lv ].y;
      if x_max < Punkte[ lv ].x
      then
        x_max := Punkte[ lv ].x;
      if y_max < Punkte[ lv ].y
      then
        y_max := Punkte[ lv ].y;
      if x_min > Punkte[ lv ].x
      then
        x_min := Punkte[ lv ].x;
      if y_min > Punkte[ lv ].y
      then
        y_min := Punkte[ lv ].y;
      end;

    Repeat
      rc := Gerade_mit_minimalem_Abstand( Polygon.Punkte, Polygon.Anzahl, Gerade );
      If rc < 0
      then
        Begin
        result := rc;
        exit
        end;
      { Kennwerte ermitteln }
      Mittelwert.x          := Summe_Punkte.x / Polygon.Anzahl;
      Mittelwert.y          := Summe_Punkte.y / Polygon.Anzahl;
      Mittelwert_Rechteck.x := ( x_max + x_min ) / 2;
      Mittelwert_Rechteck.y := ( y_max + y_min ) / 2;
      x_delta_mittel        := ( x_max - x_min ) / Polygon.Anzahl;
      y_delta_mittel        := ( y_max - y_min ) / Polygon.Anzahl;
      Hilfspunkt.x          := x_min;
      Hilfspunkt.y          := y_min;
      Orientierter_Abstand_Punkt_von_Gerade( Hilfspunkt, Gerade, EckenAbstand );
      MaxEckenAbstand       := Eckenabstand;
      MinEckenAbstand       := Eckenabstand;
      Hilfspunkt.x          := x_min;
      Hilfspunkt.y          := y_max;
      Orientierter_Abstand_Punkt_von_Gerade( Hilfspunkt, Gerade, EckenAbstand );
      If MaxEckenAbstand < Eckenabstand
      then
        MaxEckenAbstand := Eckenabstand;
      If MinEckenAbstand > Eckenabstand
      then
        MinEckenAbstand := Eckenabstand;
      Hilfspunkt.x          := x_max;
      Hilfspunkt.y          := y_max;
      Orientierter_Abstand_Punkt_von_Gerade( Hilfspunkt, Gerade, EckenAbstand );
      If MaxEckenAbstand < Eckenabstand
      then
        MaxEckenAbstand := Eckenabstand;
      If MinEckenAbstand > Eckenabstand
      then
        MinEckenAbstand := Eckenabstand;
      Hilfspunkt.x          := x_max;
      Hilfspunkt.y          := y_min;
      Orientierter_Abstand_Punkt_von_Gerade( Hilfspunkt, Gerade, EckenAbstand );
      If MaxEckenAbstand < Eckenabstand
      then
        MaxEckenAbstand := Eckenabstand;
      If MinEckenAbstand > Eckenabstand
      then
        MinEckenAbstand := Eckenabstand;
      A_Indikator := (MaxEckenAbstand - MinEckenAbstand) / 4;
      M_Indikator := Abstand_Punkt_von_Punkt(Hilfspunkt, Mittelwert_Rechteck );


      { Ausreißerkontrolle }
      For lv := 1 to Polygon.Anzahl do
        Begin
        Orientierter_Abstand_Punkt_von_Gerade( Polygon.Punkte[ lv ], Gerade, Geradenabstand );
        If ( Geradenabstand > A_Indikator
        end;


    until true;
    result := 0
  except
    result := -9999
    end;
  end;

*)
{ ---------------------------------------------------------------------------- }

Function Regressionsgerade( Var Punkte : Array of Typ_ePunkt;
  AnzPunkte : Longint;  Var Gerade : Typ_eGerade ) : Integer;
  { Diese Funktion bestimmt die Regressionsgerade in der Form
           nx * x + ny * y = c       ( ny = 1 )

    Bei der Regressionsgeraden wird die Gerade bestimmt, deren y-Abstand minimal ist.
    Returnwerte:
       0 - alles OK
      -1 - alle Punkte (x,y) sind gleich
      -2 - Anzpaare = 0 }
  Var
    x_mw : extended;
    y_mw : extended;

    zaehler : extended;
    nenner  : extended;
    anzahl  : extended;

    lv     : LongInt;   { Laufvariable }
    x_zv   : extended;  { Zwischenvariable }
    y_zv   : extended;  { Zwischenvariable }

  Begin
  try
    If AnzPunkte = 0
    then
      Begin
      result := -2;
      exit
      end
    else
      anzahl := AnzPunkte;
    { Mittelwerte bestimmen }
    x_mw := Punkte[ 0 ].x;
    y_mw := Punkte[ 0 ].y;
    For lv := 1 to AnzPunkte - 1 do
      Begin
      x_mw := x_mw + Punkte[ lv ].x;
      y_mw := y_mw + Punkte[ lv ].y;
      end;
    x_mw := x_mw / anzahl;
    y_mw := y_mw / anzahl;

    { Nenner und Zähler bestimmen }
    nenner  := 0.0;
    zaehler := 0.0;
    For lv := 0 to AnzPunkte - 1 do
      begin
      x_zv      := Punkte[lv].x - x_mw;
      y_zv      := Punkte[lv].y - y_mw;
      zaehler := zaehler + x_zv * y_zv;
      nenner  := nenner + sqr( x_zv );
      end;

    { nenner = 0, wenn alle Punkte gleich}
    If abs(nenner) <= eps
    then { numerisch 0 }
      Begin
      result := -1;
      exit
      end;

    { Geradenparameter bestimmen }
    Gerade.nx     := - zaehler / nenner;
    Gerade.ny     := 1.0;
    Gerade.c      := Gerade.nx * x_mw + y_mw;
    result := 0
  except
    result := -9999
    end;
  end;

{ ---------------------------------------------------------------------------- }

Function Regressionsgerade_F( Var Punkte : Array of Typ_ePunkt;
  AnzPunkte : Longint;  Var Gerade : Typ_eGerade; Var Einpassfehler : extended ) : Integer;
  { Diese Funktion bestimmt die Regressionsgerade in der Form
           nx * x + ny * y = c       ( ny = 1 )

    Bei der Regressionsgeraden wird die Gerade bestimmt, deren y-Abstand minimal ist
    und gibt noch zusätzlich den Einpassfehler aus.

    Returnwerte:
       0 - alles OK
      -1 - alle Punkte (x,y) sind gleich
      -2 - Anzpaare = 0
      -3 - Fehler bei Einpassbestimmung
  }

  Var
    lv      : Integer;
    res     : Integer;
    y_Wert  : Extended;
    Abstand : extended;
  Begin
  try
    res := Regressionsgerade( Punkte, AnzPunkte, Gerade );
    If res < 0
    then
      Begin
      Einpassfehler := -9999.9999;
      Result        := res;
      exit
      end;
    Einpassfehler := 0.0;
    For lv := 0 to Anzpunkte - 1 do
      Begin
      res := Gebe_y_Koordinate( Gerade, Punkte[ lv ].x, y_Wert );
      If res < 0
      then
        Begin
        Einpassfehler := -9999.9999;
        Result        := -3;
        exit
        end;
      Abstand       := Punkte[ lv ].y - y_Wert;
      Einpassfehler := Einpassfehler + sqr( Abstand );
      end;
    result := 0
  except
    result := -9999
    end
  end;

{ ---------------------------------------------------------------------------- }

Function Regressionsgerade_mit_Aussreissertest( horizontal: Boolean; Var Punkte : Array of Typ_ePunkt;
                                  anzPunkte : Longint;  Var gerade : Typ_eGerade; bandbreite: double;
                                  var indexArrayEliminiertePunkte: array of integer;  var anzEliminiert: integer ) : Integer;
var i, anzP, ret  : integer;
    abstand       : extended;
    p             : array of Typ_ePunkt;
begin
  Result := -1;
  anzEliminiert := 0;
  SetLength (p, anzPunkte);
  if horizontal then
    ret := Regressionsgerade( Punkte, anzPunkte, gerade )
  else
    ret := Vertikale_Regressionsgerade( Punkte, anzPunkte, gerade );
  if ret = 0 then
    begin
    anzP := 0;
    for i:= 0 to anzPunkte-1 do
      begin
      Abstand_Punkt_von_Gerade( punkte[i], gerade, abstand);
      if abstand > bandbreite then
        begin
        indexArrayEliminiertePunkte[anzEliminiert] := i;
        Inc( anzEliminiert);
        end
      else
        begin
        p[anzP] := punkte[i];
        Inc(anzP);
        end;
      end;
    // 2. Regressionsstufe mit den übrigen Punkten
    if anzP > 2 then
      begin
      if horizontal then
        Result := Regressionsgerade( p, anzP, gerade )
      else
        Result := Vertikale_Regressionsgerade( p, anzP, gerade );
      end;
//    else
//      Result := 0; 
    end;
  finalize( p);
end;

{ ---------------------------------------------------------------------------- }

Function Vertikale_Regressionsgerade( Var Punkte : Array of Typ_ePunkt;
  AnzPunkte : Longint;  Var Gerade : Typ_eGerade ) : Integer;
  { Diese Funktion bestimmt die Regressionsgerade in der Form
           nx * x + ny * y = c       ( nx = 1 )

    Bei der Regressionsgeraden wird die Gerade bestimmt, deren x-Abstand minimal ist.
    Returnwerte:
       0 - alles OK
      -1 - alle Punkte (x,y) sind gleich
      -2 - Anzpaare = 0 }
  Var
    x_mw : extended;
    y_mw : extended;

    zaehler : extended;
    nenner  : extended;
    anzahl  : extended;

    lv     : LongInt;   { Laufvariable }
    x_zv   : extended;  { Zwischenvariable }
    y_zv   : extended;  { Zwischenvariable }

  Begin
  try
    If AnzPunkte = 0
    then
      Begin
      result := -2;
      exit
      end
    else
      anzahl := AnzPunkte;
    { Mittelwerte bestimmen }
    x_mw := Punkte[ 0 ].x;
    y_mw := Punkte[ 0 ].y;
    For lv := 1 to AnzPunkte - 1 do
      Begin
      x_mw := x_mw + Punkte[ lv ].x;
      y_mw := y_mw + Punkte[ lv ].y;
      end;
    x_mw := x_mw / anzahl;
    y_mw := y_mw / anzahl;

    { Nenner und Zähler bestimmen }
    nenner  := 0.0;
    zaehler := 0.0;
    For lv := 0 to AnzPunkte - 1 do
      begin
      x_zv      := Punkte[lv].x - x_mw;
      y_zv      := Punkte[lv].y - y_mw;
      zaehler := zaehler + x_zv * y_zv;
      nenner  := nenner + sqr( y_zv );
      end;

    { nenner = 0, wenn alle Punkte gleich}
    If abs(nenner) <= eps
    then { numerisch 0 }
      Begin
      result := -1;
      exit
      end;

    { Geradenparameter bestimmen }
    Gerade.ny     := - zaehler / nenner;
    Gerade.nx     := 1.0;
    Gerade.c      := Gerade.ny * y_mw + x_mw;
    result := 0
  except
    result := -9999
    end;
  end;

{ ---------------------------------------------------------------------------- }

Function Vertikale_Regressionsgerade_F( Var Punkte : Array of Typ_ePunkt;
  AnzPunkte : Longint;  Var Gerade : Typ_eGerade; Var Einpassfehler : extended ) : Integer;
  { Diese Funktion bestimmt die Regressionsgerade in der Form
           nx * x + ny * y = c       ( nx = 1 )

    Bei der Regressionsgeraden wird die Gerade bestimmt, deren x-Abstand minimal ist.
    Bestimmt zusätzlichden Einpassfehler.
    Returnwerte:
       0 - alles OK
      -1 - alle Punkte (x,y) sind gleich
      -2 - Anzpaare = 0
      -3 - Fehler bei Einpassbestimmung
  }

  Var
    lv      : Integer;
    res     : Integer;
    x_Wert  : Extended;
    Abstand : extended;
  Begin
  try
    res := Vertikale_Regressionsgerade( Punkte, AnzPunkte, Gerade );
    If res < 0
    then
      Begin
      Einpassfehler := -9999.9999;
      Result        := res;
      exit
      end;
    Einpassfehler := 0.0;
    For lv := 0 to Anzpunkte - 1 do
      Begin
      res := Gebe_x_Koordinate( Gerade, Punkte[ lv ].y, x_Wert );
      If res < 0
      then
        Begin
        Einpassfehler := -9999.9999;
        Result        := -3;
        exit
        end;
      Abstand       := Punkte[ lv ].x - x_Wert;
      Einpassfehler := Einpassfehler + sqr( Abstand );
      end;
    result := 0
  except
    result := -9999
    end
  end;

{ ---------------------------------------------------------------------------- }
(*
Function AusreiszerElimination_bei_Geraden( Var Punkte : Array of Typ_ePunkt;
  Var AnzPunkte : Longint; Ausreiszerniveau : extended ) : Integer;
  { Die übergebenen Punkte sollen auf einer Geraden liegen und werden um
    Ausreißer eliminiert.
    Die Ausreißerfindung erfolgt wie folgt:
    Die Punkte werden so auf eine Ursprungsgerade projiziert, dass die Streuung
    der projizierten Punkte möglichst klein ist.
    Dann werden alle Punkte entfernt, deren Projektion vom Median der projezierten
    Punkte mehr als Ausreißerniveau [mm] wegliegt.

    Es werden aus der übergebenen Punktmenge alle Punkte eliminiert, die als Ausreißer
    identifiziert wurden.  Punkte und Anzpunkte enthält am Schluss die bereinigten
    Punkte.

    Bemerkungen: Der Algorithmus hat noch zwei Schwächen:
    a) die quadratische Standardbewertungsform liefert hier eine geschlossene Lösung des
    Optimierungsproblems, aber Ausreißer verfälschen um so stärker das Ergebnis.
    Bisher habe ich noch keine Bewertungsfunktion mit der man eine geschlossene Lösung
    erhält.

    b) die Medianbildung geht davon aus, dass die Punkte "gleichförmig" im Gutfall vorliegen.
    Hat man auf einer Seite der Skala deutlich mehr Werte als auf der anderen Seite, würde
    die eine Seite komplett eliminiert, da der Median in diese Seite immer weiter hineinwandert.
    Abhilfe würde ggfs Clustertechnik schaffen.


    Rückgabewerte:
     1 - es wurden mehr als die Hälfte der Punkte entfernt (Ausreißerniveau zu fein ?)
     0 - Alles OK
    -1 - zu wenig Punkte (<2)
    -2 - Ausreißerniveau nicht > 0;
    -3 - die Punkte liegen auf einem Kreis
  }
  Const
    eps : extended = 1.0E-15;      { Rechen-Genauigkeit }

  Type
    Typ_Geradenpunkte = Record
      x : extended;  { Koordinaten des Punktes durch den die Ebene gelegt werden soll }
      y : extended;
      f : extended;  { Projektionswert }
      i : integer;   { Index im übergebenen Array }
      end;
  Var
    GP            : Array[ 1 .. MAXANZPOLYGONPUNKTE ] of Typ_Geradenpunkte;
    HGP           : Typ_Geradenpunkte;
    lv         		: Integer;
    lv1           : Integer;
    sum_x         : extended;
    sum_y         : extended;
    sum_xx        : extended;
    sum_yy        : extended;
    sum_xy        : extended;
    x_mw          : extended;
    y_mw          : extended;
    x_var         : extended;
    y_var         : extended;
    xy_kovar      : extended;
    Wert1         : extended;
    Wert2         : extended;
    Winkel1       : extended;
    Winkel2       : extended;
    sina          : extended;
    cosa          : extended;
    aktanzahl     : integer;
    aktanzahl_v   : integer;  { Anzahl der Punkte vor Elimination }
    Median        : extended;
    Getauscht     : Boolean;

  Begin
  If AnzPunkte < 2
  then
    Begin
    result := -1;
    exit
    end;
  If Ausreiszerniveau < eps
  then
    Begin
    result := -2;
    exit
    end;
  { Basisfelder befüllen }
  sum_x     := 0;
  sum_y     := 0;
  sum_xx    := 0;
  sum_yy    := 0;
  sum_xy    := 0;
  aktanzahl := 0;
  For lv := 0 to AnzPunkte - 1 do
    Begin
    inc(aktanzahl);
    GP[ aktanzahl ].i := lv;
    GP[ aktanzahl ].x := Punkte[ lv ].x;
    GP[ aktanzahl ].y := Punkte[ lv ].y;
    sum_x             := sum_x + Punkte[ lv ].x;
    sum_y             := sum_y + Punkte[ lv ].y;
    sum_xx            := sum_xx + Punkte[ lv ].x * Punkte[ lv ].x;
    sum_yy            := sum_yy + Punkte[ lv ].y * Punkte[ lv ].y;
    sum_xy            := sum_xy + Punkte[ lv ].x * Punkte[ lv ].y;
    end;
  { Eliminationsschleife }
  Repeat
    { Bestimmung der optimalen Projektion }
    x_mw     := sum_x / aktanzahl;
    y_mw     := sum_y / aktanzahl;
    x_var    := sum_xx / aktanzahl - x_mw * x_mw;
    y_var    := sum_yy / aktanzahl - y_mw * y_mw;
    xy_kovar := sum_xy / aktanzahl - x_mw * y_mw;
    If ( abs(xy_kovar) < eps )
    then
      If ( abs(x_var-y_var) < eps )
      then
        Begin
        result  := -3;
        exit;
        end
      else { normaler Spezialfall }
        Begin
        Winkel1 := 0;
        Winkel2 := pi/2;
        end
    else { normaler Fall, zwei Lösungen }
      Begin
      Winkel1 := arctan( (y_var - x_var + sqrt( sqr(y_var - x_var) + 4 * sqr(xy_kovar)))/(2 * xy_kovar ));
      Winkel2 := arctan( (y_var - x_var - sqrt( sqr(y_var - x_var) + 4 * sqr(xy_kovar)))/(2 * xy_kovar ));
      end;
    { Winkel zu minmalem Funktionswert bestimmen }
    Wert1 := x_var * sqr(sin( Winkel1 )) + y_var * sqr(cos( Winkel1 ))
      - 2 * sin( Winkel1 ) * cos( Winkel1 ) * xy_kovar;
    Wert2 := x_var * sqr(sin( Winkel2 )) + y_var * sqr(cos( Winkel2 ))
      - 2 * sin( Winkel2 ) * cos( Winkel2 ) * xy_kovar;
    If Wert1 < Wert2
    then
      Begin
      sina := sin( Winkel1 );
      cosa := cos( Winkel1 );
      end
    else
      Begin
      sina := sin( Winkel2 );
      cosa := cos( Winkel2 );
      end;
    { Elimination }
    { Werte bestimmen }
    For lv := 1 to aktanzahl do
      GP[ lv ].f := sina * GP[ lv ].x - cosa * GP[ lv ].y;
    { GP sortieren }
    For lv1 := aktanzahl - 1 downto 1 do
      Begin
      Getauscht := false;
      For lv := 1 to lv1 do
        If GP[ lv ].f > GP[ lv + 1 ].f
        then { Tauschen }
          Begin
          Getauscht    := true;
          HGP          := GP[ lv + 1 ];
          GP[ lv + 1 ] := GP[ lv ];
          GP[ lv ]     := HGP
          end;
      If not Getauscht
      then { Reihenfolge ist bereits richtig }
        break;
      end;
    { Median ermitteln }
    If Odd(aktanzahl)
    then
      Median := GP[ (aktanzahl+1) div 2 ].f
    else
      Median := ( GP[ aktanzahl div 2 ].f + GP[ (aktanzahl div 2) + 1 ].f ) / 2;

    { eliminieren }
    aktanzahl_v := aktanzahl;

    { Von oben her }
    For lv := aktanzahl_v downto ( (aktanzahl_v div 2) + 1) do
      If abs( GP[ lv ].f - Median ) > Ausreiszerniveau
      then
        Begin
        dec(aktanzahl);
        sum_x  := sum_x - GP[ lv ].x;
        sum_y  := sum_y - GP[ lv ].y;
        sum_xx := sum_xx - GP[ lv ].x * GP[ lv ].x;
        sum_yy := sum_yy - GP[ lv ].y * GP[ lv ].y;
        sum_xy := sum_xy - GP[ lv ].x * GP[ lv ].y;
        end
      else
        Break;
    { Von unten her }
    For lv := 1 to aktanzahl_v div 2 do
      If abs( GP[ lv ].f - Median ) > Ausreiszerniveau
      then
        Begin
        dec(aktanzahl);
        sum_x  := sum_x - GP[ lv ].x;
        sum_y  := sum_y - GP[ lv ].y;
        sum_xx := sum_xx - GP[ lv ].x * GP[ lv ].x;
        sum_yy := sum_yy - GP[ lv ].y * GP[ lv ].y;
        sum_xy := sum_xy - GP[ lv ].x * GP[ lv ].y;
        end
      else
        Begin
        lv1 := lv;
        Break
        end;

    If lv1 > 1
    then
      For lv := lv1 to aktanzahl + lv1 - 1 do
        GP[ lv - lv1 + 1 ] := GP[ lv ];
  until (aktanzahl_v = aktanzahl);
  { Übergabepunkte befüllen }
  { GP sortieren, wieder in richtige Reihenfolge bringen }
  For lv1 := aktanzahl - 1 downto 1 do
    Begin
    Getauscht := false;
    For lv := 1 to lv1 do
      If GP[ lv ].i > GP[ lv + 1 ].i
      then { Tauschen }
        Begin
        Getauscht    := true;
        HGP          := GP[ lv + 1 ];
        GP[ lv + 1 ] := GP[ lv ];
        GP[ lv ]     := HGP
        end;
    If not Getauscht
    then { Reihenfolge ist bereits richtig }
      break;
    end;
  aktanzahl_v := Anzpunkte;
  Anzpunkte   := aktanzahl;
  For lv := 1 to aktanzahl do
    Begin
    Punkte[ lv - 1 ].x := GP[ lv ].x;
    Punkte[ lv - 1 ].y := GP[ lv ].y;
    end;
  If aktanzahl < (aktanzahl_v div 2)
  then
    result := 1
  else
    result := 0;
  end;
*)
{ ---------------------------------------------------------------------------- }

Function Kreisregression( Var Punkte : Array of Typ_ePunkt;
  AnzPunkte : Longint;  Var Mittelpunkt : Typ_ePunkt; Var radius : extended ) : Integer;
  { Diese Funktion bestimmt den Mittelpunkt und den Radius eines Kreises, welcher
    in die Punktwolke (x_wert|y_wert) nach Kleinstquadrate am besten hineinpasst.
    Er benötigt mindestens 3 verschiedene Punkte.
    Returnwerte:
       0 - alles OK
      -1 - es sind keine drei verschiedenen Punkte
      -2 - Anzpaare < 3 }
  Var
    x_mw : extended;
    y_mw : extended;

    xx_s : extended;
    xy_s : extended;
    yy_s : extended;

    x_rs : extended;
    y_rs : extended;


    zv      : extended;
    nenner  : extended;
    anzahl  : extended;

    lv     : LongInt;   { Laufvariable }
    dx     : extended;  { Zwischenvariable }
    dy     : extended;  { Zwischenvariable }

  Begin
  try
    If AnzPunkte < 3
    then
      Begin
      result := -2;
      exit
      end
    else
      anzahl := AnzPunkte;

    { Mittelwerte bestimmen }
    x_mw := Punkte[ 0 ].x;
    y_mw := Punkte[ 0 ].y;
    For lv := 1 to AnzPunkte - 1 do
      Begin
      x_mw := x_mw + Punkte[ lv ].x;
      y_mw := y_mw + Punkte[ lv ].y;
      end;
    x_mw := x_mw / anzahl;
    y_mw := y_mw / anzahl;

    { Varianzen und Kovarianzen bestimmen }
    dx   := Punkte[ 0 ].x - x_mw;
    dy   := Punkte[ 0 ].y - y_mw;
    zv   := sqr(Punkte[ 0 ].x) +  sqr(Punkte[ 0 ].y);
    x_rs := dx * zv;
    y_rs := dy * zv;
    xx_s := dx * dx;
    yy_s := dy * dy;
    xy_s := dx * dy;
    For lv := 1 to AnzPunkte - 1 do
      Begin
      dx   := Punkte[ lv ].x - x_mw;
      dy   := Punkte[ lv ].y - y_mw;
      zv   := sqr(Punkte[ lv ].x) +  sqr(Punkte[ lv ].y);
      x_rs := x_rs + dx * zv;
      y_rs := y_rs + dy * zv;
      xx_s := xx_s + dx * dx;
      yy_s := yy_s + dy * dy;
      xy_s := xy_s + dx * dy;
      end;

    { Nenner bestimmen }
    nenner := 2.0 * ( xx_s * yy_s - sqr(xy_s) );

    { nenner = 0, wenn nicht mehr als zwei verschiedene Punkte }
    If abs(nenner) <= eps
    then { numerisch 0 }
      Begin
      result := -1;
      exit
      end;

    { Kreisparameter bestimmen }
    Mittelpunkt.x := (   yy_s * x_rs - xy_s * y_rs ) / nenner;
    Mittelpunkt.y := ( - xy_s * x_rs + xx_s * y_rs ) / nenner;

    { Mittelwerte bestimmen }
    radius := sqr( Punkte[ 0 ].x - Mittelpunkt.x ) + sqr( Punkte[ 0 ].y - Mittelpunkt.y );
    For lv := 1 to AnzPunkte - 1 do
      radius := radius + sqr( Punkte[ lv ].x - Mittelpunkt.x ) + sqr( Punkte[ lv ].y - Mittelpunkt.y );
    radius := sqrt(radius / anzahl);

    result := 0
  except
    result := -9999
    end;
  end;

{ ---------------------------------------------------------------------------- }

Procedure Sortiere(Var Abstaende : Array of extended; Var Punkte : Array of Typ_ePunkt;
  Anzpunkte : LongInt );
  { Sortiert die Felder Abstaende und Punkte nach Abstand aufsteigend }
  Var
    Tauschpunkt : Typ_ePunkt;
    Tauschzahl  : extended;
    lv_aussen   : LongInt;
    lv_innen    : LongInt;
    Getauscht   : Boolean;
  Begin
  For lv_aussen := (Anzpunkte - 1) downto 1 do
    Begin
    Getauscht := False;
    { das größte Element wird ans aktuelle 'rechte' Ende geschafft }
    For lv_innen := 1 to lv_aussen do
      If Abstaende[ lv_innen - 1 ] > Abstaende[ lv_innen ]
      then
        Begin
        Getauscht                 := true;
        Tauschzahl                := Abstaende[ lv_innen ];
        Abstaende[ lv_innen ]     := Abstaende[ lv_innen - 1 ];
        Abstaende[ lv_innen - 1 ] := Tauschzahl;
        Tauschpunkt               := Punkte[ lv_innen ];
        Punkte[ lv_innen ]        := Punkte[ lv_innen - 1 ];
        Punkte[ lv_innen - 1 ]    := Tauschpunkt;
        end;
    If not Getauscht
    then
      exit;
    end;
  end;

  (*
  { ---------------------------------------------------------------------------- }

Function Kreisregression_mit_Ausreisserkontrolle( Var Punkte : Array of Typ_ePunkt;
  AnzPunkte : Longint; Kreiszonenbreite : extended; Var Kreis : Typ_eKreis ) : Integer;
  { es wird eine Standardkreisregression durchgefuehrt und anschließend
    das Ergebnis und die Punkte auf Ausreißer hin kontrolliert und bereinigt.
    Es wird der Median der Abstände zum Mittelpunkt bestimmt und alle Punkte
    die mehr als Kreiszonenbreite / 2 vom Mittelpunkt weg sind eliminiert
    und mit dem Rest die Kreisregression wiederholt.
    Rückgabewerte :
       1 - Kreiszonenbreite zu schmal. Es wird unkorrigiertes Ergebnis zurückgegeben
       0 - alles OK
      -1 - es sind keine drei verschiedenen Punkte
      -2 - Anzpaare < 3
      -3 - Anzpaare zu groß
  }
  Const
    MAXANZAHLPUNKTE = 300;

  Type
    TYP_eFeld = array[ 1 .. MAXANZAHLPUNKTE ] of extended;
    TYP_ePunktFeld = array[ 1 .. MAXANZAHLPUNKTE ] of Typ_ePunkt;

  Var
    res          : Integer;
    Abstaende    : TYP_eFeld;
    Hilfspunkte  : TYP_ePunktFeld;
    lv           : Integer;
    Median       : extended;
    Restanzahl   : Integer;
    untereGrenze : extended;
    obereGrenze  : extended;
  Begin
  If AnzPunkte > MAXANZAHLPUNKTE
  then
    Begin
    result := -3;
    exit;
    end;
  { res := Kreisregression(Punkte, AnzPunkte, Kreis );}
  res := Kreisregression(Punkte, AnzPunkte, Kreis.Mittelpunkt, Kreis.Radius );
  If res <> 0
  then
    Begin
    result := res;
    exit;
    end;
  For lv := 1 to Anzpunkte do
    Begin
    Hilfspunkte[ lv ] := Punkte[ lv - 1 ];
    Abstaende[ lv ]   := Abstand_Punkt_von_Punkt( Hilfspunkte[ lv ], Kreis.Mittelpunkt );
    end;
  { Sortieren der Hilfspunkte nach Abstand }
  Sortiere( Abstaende, Hilfspunkte, Anzpunkte );
  If Odd(Anzpunkte)
  then  { Bei ungerader Anzahl }
    Median := Abstaende[ ( Anzpunkte + 1 ) div 2 ]
  else
    Median := ( Abstaende[ Anzpunkte div 2 ] + Abstaende[ ( Anzpunkte div 2 ) + 1 ] ) / 2;
  { Aussortieren der Ausreißer }
  Restanzahl   := 0;
  untereGrenze := Median - Kreiszonenbreite / 2;
  obereGrenze  := Median + Kreiszonenbreite / 2;
  For lv := 1 to AnzPunkte do
    If ( untereGrenze <= Abstaende[ lv ] ) and ( Abstaende[ lv ] <= obereGrenze )
    then
      Begin
      Inc(Restanzahl);
      Hilfspunkte[ Restanzahl ] := Hilfspunkte[ lv ];
      end;
  If Restanzahl < 3
  then
    res := 1
  else
    { res := Kreisregression(Hilfspunkte, Restanzahl, Kreis );}
    res := Kreisregression(Hilfspunkte, Restanzahl, Kreis.Mittelpunkt, Kreis.Radius );
  result := res
  end;
*)

Function Kreisregression_mit_Ausreisserkontrolle( Var Punkte : Array of Typ_ePunkt;
  AnzPunkte : Longint; Kreiszonenbreite : extended; Var Kreis : Typ_eKreis;
  Var aussortiertPunkte : Array of Typ_ePunkt; var anzAusSort: integer) : Integer;
  { es wird eine Standardkreisregression durchgefuehrt und anschließend
    das Ergebnis und die Punkte auf Ausreißer hin kontrolliert und bereinigt.
    Es wird der Median der Abstände zum Mittelpunkt bestimmt und alle Punkte
    die mehr als Kreiszonenbreite / 2 vom Mittelpunkt weg sind eliminiert
    und mit dem Rest die Kreisregression wiederholt.
    Rückgabewerte :
       1 - Kreiszonenbreite zu schmal. Es wird unkorrigiertes Ergebnis zurückgegeben
       0 - alles OK
      -1 - es sind keine drei verschiedenen Punkte
      -2 - Anzpaare < 3
      -3 - Anzpaare zu groß
  }
  Const
    MAXANZAHLPUNKTE = 1000;

  Type
    TYP_eFeld = array[ 1 .. MAXANZAHLPUNKTE ] of extended;
    TYP_ePunktFeld = array[ 1 .. MAXANZAHLPUNKTE ] of Typ_ePunkt;

  Var
    res          : Integer;
    Abstaende    : TYP_eFeld;
    Hilfspunkte  : TYP_ePunktFeld;
    lv           : Integer;
    Median       : extended;
    Restanzahl   : Integer;
    untereGrenze : extended;
    obereGrenze  : extended;
  Begin
  If AnzPunkte > MAXANZAHLPUNKTE
  then
    Begin
    result := -3;
    exit;
    end;
  { res := Kreisregression(Punkte, AnzPunkte, Kreis );}
  res := Kreisregression(Punkte, AnzPunkte, Kreis.Mittelpunkt, Kreis.Radius );
  If res <> 0
  then
    Begin
    result := res;
    exit;
    end;
  For lv := 1 to Anzpunkte do
    Begin
    Hilfspunkte[ lv ] := Punkte[ lv - 1 ];
    Abstaende[ lv ]   := Abstand_Punkt_von_Punkt( Hilfspunkte[ lv ], Kreis.Mittelpunkt );
    end;
  { Sortieren der Hilfspunkte nach Abstand }
  Sortiere( Abstaende, Hilfspunkte, Anzpunkte );
  If Odd(Anzpunkte)
  then  { Bei ungerader Anzahl }
    Median := Abstaende[ ( Anzpunkte + 1 ) div 2 ]
  else
    Median := ( Abstaende[ Anzpunkte div 2 ] + Abstaende[ ( Anzpunkte div 2 ) + 1 ] ) / 2;
  { Aussortieren der Ausreißer }
  Restanzahl   := 0;
  untereGrenze := Median - Kreiszonenbreite / 2;
  obereGrenze  := Median + Kreiszonenbreite / 2;
  anzAusSort := 0;
  For lv := 1 to AnzPunkte do
    If ( untereGrenze <= Abstaende[ lv ] ) and ( Abstaende[ lv ] <= obereGrenze )
    then
      Begin
      Inc(Restanzahl);
      Hilfspunkte[ Restanzahl ] := Hilfspunkte[ lv ];

      end
    else
      begin
      aussortiertPunkte[anzAusSort] :=  Hilfspunkte[ lv ];
      Inc(  anzAusSort );
      end;
  If Restanzahl < 3
  then
    res := 1
  else
    { res := Kreisregression(Hilfspunkte, Restanzahl, Kreis );}
    res := Kreisregression(Hilfspunkte, Restanzahl, Kreis.Mittelpunkt, Kreis.Radius );
  result := res
  end;


{ ---------------------------------------------------------------------------- }

Function Ellipsenregression( Var Punkte : Array of Typ_ePunkt;
  AnzPunkte : Longint;  Var Ellipse : Typ_eEllipse ) : Integer;
  { es wird die im Sinne von Kleinstquadrate am besten passende Ellipse in die
    übergebene Punktwolke gelegt.
    Gleichung der zu Grunde gelegten Quadrik
      A*xx + B*xy + C*yy + D*x + E*y + F = 0
    Bei einer Ellipse ist F < 0, und um die Unbestimmtheit zu beseitigen
    wird die Such-Gleichung mit -F durchdividiert, mit a=A/-F usw. hat man
      a*xx + b*xy + c*yy + d*x + e*y - 1 = 0
    In Matrix-Schreibweise
    ( x y ) | a    b/2  |  x   +  ( x y )  d   -  1  = 0
            | b/2   c   |  y               e

   Da fünf Parameter zu bestimmen sind müssen mindestens 5 Punkte gegeben werden
   von denen keine 3 auf einer Geraden liegen dürfen, dann ist die Quadrik eindeutig .

   Rückgabewerte :
           0 - Alles ok
          -1 - zu wenig Punkte
          -2 - Gleichungssystem ist unlösbar
          -3 - Verschiebevektor = Mittelpunkt ist nicht bestimmbar
     negativ - wohl keine Ellipse
   }
  Const
    ANZAHLZEILEN  = 5;
    ANZAHLSPALTEN = 6;
  Type
    Typ_eVektor = array[ 1 .. ANZAHLZEILEN ] of extended;
    Typ_eMatrix = array[ 1 .. ANZAHLZEILEN, 1 .. ANZAHLSPALTEN ] of extended;

  Var
    anzahl  : extended;
    matrix  : Typ_eMatrix;
    Loesung : Typ_eVektor;
    lv      : LongInt;   { Laufvariable }

    dx      : extended; { Hilfsgröße }
    dy      : extended; { Hilfsgröße }
    dxx     : extended; { Hilfsgröße }
    dxy     : extended; { Hilfsgröße }
    dyy     : extended; { Hilfsgröße }
    x       : extended;
    y       : extended;
    xx      : extended;
    xy      : extended;
    yy      : extended;
    xxx     : extended;
    xxy     : extended;
    xyy     : extended;
    yyy     : extended;
    xxxx    : extended;
    xxxy    : extended;
    xxyy    : extended;
    xyyy    : extended;
    yyyy    : extended;

    pivot      : extended;
    pivotzeile : LongInt;
    aktzeile   : LongInt;
    suchzeile  : LongInt;
    zeile      : LongInt;
    spalte     : LongInt;
    hgr        : extended;

    a          : extended;
    b          : extended;
    c          : extended;
    d          : extended;
    e          : extended;
    g          : extended;
    hpkt       : Typ_ePunkt;
    Eigenwert_1: extended;
    Eigenwert_2: extended;

  Begin
  try
    If AnzPunkte < 5
    then
      Begin
      result := -1;
      exit
      end
    else
      anzahl := AnzPunkte;

    { befüllen der Hilfsvariablen }
    x    := Punkte[ 0 ].x;
    y    := Punkte[ 0 ].y;
    xx   :=   x * x;
    xy   :=   x * y;
    yy   :=   y * y;
    xxx  :=  xx * x;
    xxy  :=  xx * y;
    xyy  :=  xy * y;
    yyy  :=  yy * y;
    xxxx := xxx * x;
    xxxy := xxx * y;
    xxyy := xxy * y;
    xyyy := xyy * y;
    yyyy := yyy * y;
    For lv := 1 to AnzPunkte - 1 do
      Begin
      dx   := Punkte[ lv ].x;
      dy   := Punkte[ lv ].y;
      dxx  := dx * dx;
      dxy  := dx * dy;
      dyy  := dy * dy;
      x    := x + dx;
      y    := y + dy;
      xx   := xx + dxx;
      xy   := xy + dxy;
      yy   := yy + dyy;
      xxx  := xxx + dxx * dx;
      xxy  := xxy + dxx * dy;
      xyy  := xyy + dxy * dy;
      yyy  := yyy + dyy * dy;
      xxxx := xxxx + dxx * dxx;
      xxxy := xxxy + dxx * dxy;
      xxyy := xxyy + dxx * dyy;
      xyyy := xyyy + dxy * dyy;
      yyyy := yyyy + dyy * dyy;
      end;
    { Matrix mit Hilfseinträgen füllen }
    matrix[ 1, 1 ] := xxxx;
    matrix[ 1, 2 ] := xxxy;
    matrix[ 1, 3 ] := xxyy;
    matrix[ 1, 4 ] := xxx ;
    matrix[ 1, 5 ] := xxy ;
    matrix[ 1, 6 ] := xx ;

    matrix[ 2, 1 ] := xxxy;
    matrix[ 2, 2 ] := xxyy;
    matrix[ 2, 3 ] := xyyy;
    matrix[ 2, 4 ] := xxy ;
    matrix[ 2, 5 ] := xyy ;
    matrix[ 2, 6 ] := xy ;

    matrix[ 3, 1 ] := xxyy;
    matrix[ 3, 2 ] := xyyy;
    matrix[ 3, 3 ] := yyyy;
    matrix[ 3, 4 ] := xyy ;
    matrix[ 3, 5 ] := yyy ;
    matrix[ 3, 6 ] := yy ;

    matrix[ 4, 1 ] := xxx ;
    matrix[ 4, 2 ] := xxy ;
    matrix[ 4, 3 ] := xyy ;
    matrix[ 4, 4 ] := xx  ;
    matrix[ 4, 5 ] := xy  ;
    matrix[ 4, 6 ] := x  ;

    matrix[ 5, 1 ] := xxy ;
    matrix[ 5, 2 ] := xyy ;
    matrix[ 5, 3 ] := yyy ;
    matrix[ 5, 4 ] := xy  ;
    matrix[ 5, 5 ] := yy  ;
    matrix[ 5, 6 ] := y  ;

    { Lösen des Gleichungssystems mit Gauss und Spaltenpivotsuche }
    { Die Dreiecksmatrix unterhalb der Diagonalen bleibt unverändert }
    For aktzeile := 1 to ANZAHLZEILEN do
      Begin
      { Pivotzeile suchen }
      Pivotzeile := aktzeile;
      Pivot      := abs(matrix[ Pivotzeile, aktzeile ]);
      For suchzeile := aktzeile + 1 to ANZAHLZEILEN do
        If Pivot < abs(matrix[ suchzeile, aktzeile ])
        then
          Begin
          Pivotzeile := suchzeile;
          Pivot      := abs(matrix[ Pivotzeile, aktzeile ]);
          end;
      If Pivot < eps   { ist immer positiv }
      then
        Begin
        result := -2;
        exit
        end;
      If Pivotzeile <> aktzeile
      then { aktzeile mit Pivotzeile tauschen }
        For spalte := aktzeile to ANZAHLSPALTEN do
          Begin  { dieser Spaltenbereich genügt, da davor schon 0-stehen }
          hgr                          := matrix[ Pivotzeile, spalte ];
          matrix[ Pivotzeile, spalte ] := matrix[ aktzeile, spalte ];
          matrix[ aktzeile, spalte ]   := hgr
          end;
      For zeile := aktzeile + 1 to ANZAHLZEILEN do
        Begin
        hgr := matrix[ zeile, aktzeile ] / matrix[ aktzeile, aktzeile ];
        For spalte := aktzeile + 1 to ANZAHLSPALTEN do
          matrix[ zeile, spalte ] := matrix[ zeile, spalte ] - hgr * matrix[ aktzeile, spalte ];
        end;
      end;
    { bestimmen von a, b, c, d, e = Loesung[ 1 .. 5 ] }
    For aktzeile := ANZAHLZEILEN downto 1 do
      Begin
      Loesung[ aktzeile ] := matrix[ aktzeile, ANZAHLSPALTEN ];
      For spalte := ANZAHLSPALTEN - 1 downto aktzeile + 1 do
        Loesung[ aktzeile ] := Loesung[ aktzeile ] - matrix[ aktzeile, spalte ] * Loesung[ spalte ];
      Loesung[ aktzeile ] := Loesung[ aktzeile ] / matrix[ aktzeile, aktzeile ]
      end;
    a := Loesung[ 1 ];
    b := Loesung[ 2 ];
    c := Loesung[ 3 ];
    d := Loesung[ 4 ];
    e := Loesung[ 5 ];

    { Bestimmung der Ellipsenparameter }
    { im ersten Schritt den Versatz bestimmen }
    hgr := b * b - 4.0 * a * c;
    If abs(hgr) < eps
    then
      Begin
      result := -3;
      exit
      end;
    Ellipse.Mittelpunkt.y := ( 2.0 * a * e - b * d ) / hgr;
    If abs(a) < eps
    then
      Begin
      result := -4;
      exit
      end;
    Ellipse.Mittelpunkt.x := -0.5 * ( b * Ellipse.Mittelpunkt.y + d ) / a ;
    g := - 1
      - a * sqr( Ellipse.Mittelpunkt.x )
      - b * Ellipse.Mittelpunkt.x * Ellipse.Mittelpunkt.y
      - c * sqr( Ellipse.Mittelpunkt.y );

    { reduziertes Problem Offset ist jetzt eliminiert und man muß aus
      a * x * x + b * x * y + c * y * y + g = 0
      die Halbachsen und die Schräglage ermitteln }
    { Fall 1  b = 0 }
    If abs(b) < eps
    then
      Begin
      Eigenwert_1 := a;
      Eigenwert_2 := c;
      Ellipse.Drehwinkel := 0.0; { Eigenvektorsystem ist ungedreht }
      end
    else { Fall 2: b <> 0 }
      Begin
      hgr         := sqrt( sqr( a - c ) + sqr( b ) );
      Eigenwert_1 := 0.5 * ( a + c + hgr );
      Eigenwert_2 := 0.5 * ( a + c - hgr );
      { Der Winkel ergibt sich zu: Ellipse.Drehwinkel := Arctan( b / ( a - c ) ) / 2.0;
        um Extremfälle abzudecken und um einen Winkel im Bereich von 0 bis 2pi zu erhalten
        wird eine Standardfunktionaliät genutzt. Fehlerabfrage überflüssig, da b <> 0 }
      HPkt.x := a - c;
      Hpkt.y := b;
      WinkelPolarkoordinaten( HPkt, Ellipse.Drehwinkel );
      Ellipse.Drehwinkel := Ellipse.Drehwinkel / 2.0;
      end;
    If (abs(Eigenwert_1) < eps) or (abs(Eigenwert_2) < eps)
    then
      Begin
      result := -5;
      exit
      end;
    Ellipse.Radius_x := - g / Eigenwert_1;
    Ellipse.Radius_y := - g / Eigenwert_2;
    If (Ellipse.Radius_x < eps) or (Ellipse.Radius_y < eps)
    then
      Begin
      result := -6;
      exit
      end;
    Ellipse.Radius_x := sqrt( Ellipse.Radius_x );
    Ellipse.Radius_y := sqrt( Ellipse.Radius_y );

    result := 0;
  except
    result := -9999
    end;
  end;

{ ---------------------------------------------------------------------------- }

Function Ellipsenpunkt(Ellipse : Typ_eEllipse; Winkel : extended ) : Typ_ePunkt;
  { liefert den Punkt der gedrehten Ellipse der zum Winkel "Winkel" in
    der normalisierten Parameter-Darstellung der Ellipse gehört.

    x(winkel) = radius_x * cos(winkel)       normalisierte Parameter-Darstellung der Ellipse
    y(winkel) = radius_y * sin(winkel)

  }
  Var
    Hilfspunkt : Typ_ePunkt;
    sinWinkel  : extended;
    cosWinkel  : extended;
  Begin
  try
    SinCos( winkel, sinWinkel, cosWinkel );
    Hilfspunkt.x := Ellipse.Radius_x * cosWinkel;
    Hilfspunkt.y := Ellipse.Radius_y * sinWinkel;

    SinCos( Ellipse.Drehwinkel, sinWinkel, cosWinkel );
    Result.x := Ellipse.Mittelpunkt.x + Hilfspunkt.x * cosWinkel - Hilfspunkt.y * sinWinkel;
    Result.y := Ellipse.Mittelpunkt.y + Hilfspunkt.x * sinWinkel + Hilfspunkt.y * cosWinkel;
  except
    end;
  end;

{ ---------------------------------------------------------------------------- }

Function EllipsenpunktWinkel(Ellipse : Typ_eEllipse; Punkt : Typ_ePunkt;
  Var Winkel : extended; Var Ellipsenpkt : Typ_ePunkt ) : Integer;
  { Zu einer gegebenen Ellipse und einem beliebigen Punkt wird der Punkt der
    Ellipse zurückgegeben, der in der Richtung des gegebenen Punktes vom
    Mittelpunkt aus liegt und der Winkel, der dem Ellipsenpunkt
    zugeordnet ist. Der Winkel wird in den Bereich [0, 2 pi ) normiert.

    Rückgabewert:
     0 - alles ok
    -1 - Mittelpunkt ist als Punkt gegeben worden, Ellipsenpunkt nicht ermittelber
  }
  Const
    eps : extended = 1.0E-10;
  Var
   Diffvektor      : Typ_ePunkt;
   DiffvektorPolar : Typ_ePunktPolar;
   Gerade          : Typ_eGerade;
   AnzSP           : Integer;
   res             : Integer;
   SP1             : Typ_ePunkt;
   SP2             : Typ_ePunkt;
   Drehwinkel      : extended;
   sinWinkel       : extended;
   cosWinkel       : extended;
   Hilfspkt        : Typ_ePunkt;

  Begin
  try
    { Gerade durch Mittelpunkt und gegebenen Punkt bestimmen }
    res := Gerade_durch_zwei_Punkte( Ellipse.Mittelpunkt, Punkt, Gerade );
    If res < 0
    then
      Begin
      result := -1;
      exit
      end;
    { die beiden Schnittpunkte bestimmen (müssen zwei existieren, wg Konstruktion) }
    Schnittpunkte_Gerade_Ellipse( Gerade, Ellipse, AnzSP, SP1, SP2 );
    { gesuchten Ellipsenpunkt bestimmen }
    If Abstand_Punkt_von_Punkt( Punkt, SP1 ) < Abstand_Punkt_von_Punkt( Punkt, SP2 )
    then
      Ellipsenpkt := SP1
    else
      Ellipsenpkt := SP2;
    { zugehörigen Winkel bestimmen }
    { 1. in Ursprung verschieben }
    Diffvektor := Vektor_Minus_Vektor( Ellipsenpkt, Ellipse.Mittelpunkt );
    { 2. Verdrehung zurücknehmen }
    Drehwinkel := - Ellipse.Drehwinkel;
    SinCos( Drehwinkel, sinWinkel, cosWinkel );
    HilfsPkt.x := Diffvektor.x * cosWinkel - Diffvektor.y * sinWinkel;
    HilfsPkt.y := Diffvektor.x * sinWinkel + Diffvektor.y * cosWinkel;
    { 3. Winkel bestimmen }
    HilfsPkt.x      := HilfsPkt.x / Ellipse.Radius_x; // =cos(Winkel)
    HilfsPkt.y      := HilfsPkt.y / Ellipse.Radius_y; // =sin(Winkel)
    DiffvektorPolar := KartesischNachPolar( HilfsPkt );
    Winkel          := DiffvektorPolar.w;

    result          := 0
  except
    result := -9999;
    end
  end;

{ ---------------------------------------------------------------------------- }

Function EllipsenpunktWinkelAbstand(Ellipse : Typ_eEllipse; Punkt : Typ_ePunkt;
  Var Winkel, Abstand : extended; Var Ellipsenpkt : Typ_ePunkt ) : Integer;
  { Zu einer gegebenen Ellipse und einem beliebigen Punkt wird der Punkt der
    Ellipse zurückgegeben, der in der Richtung des gegebenen Punktes vom
    Mittelpunkt aus liegt, der Winkel, der dem Ellipsenpunkt
    zugeordnet ist. Der Winkel wird in den Bereich [0, 2 pi ) normiert.
    Zusätzlich wird der Abstand Punkt zu Ellipsenpunkt ausgegeben. Liegt der Punkt
    im Innern der Ellipse wird der Abstand negativ ausgegeben.

    Rückgabewert:
     0 - alles ok
    -1 - Mittelpunkt ist als Punkt gegeben worden, Ellipsenpunkt nicht ermittelber
  }
  Const
    eps : extended = 1.0E-10;
  Var
   Diffvektor      : Typ_ePunkt;
   DiffvektorPunkt : Typ_ePunkt;
   DiffvektorPolar : Typ_ePunktPolar;
   Gerade          : Typ_eGerade;
   AnzSP           : Integer;
   res             : Integer;
   SP1             : Typ_ePunkt;
   SP2             : Typ_ePunkt;
   Drehwinkel      : extended;
   sinWinkel       : extended;
   cosWinkel       : extended;
   Hilfspkt        : Typ_ePunkt;
   Abstand1        : extended;
   Abstand2        : extended;

  Begin
  try
    { Gerade durch Mittelpunkt und gegebenen Punkt bestimmen }
    res := Gerade_durch_zwei_Punkte( Ellipse.Mittelpunkt, Punkt, Gerade );
    If res < 0
    then
      Begin
      result := -1;
      exit
      end;
    { die beiden Schnittpunkte bestimmen (müssen zwei existieren, wg Konstruktion) }
    Schnittpunkte_Gerade_Ellipse( Gerade, Ellipse, AnzSP, SP1, SP2 );
    { gesuchten Ellipsenpunkt und Abstandsbetrag bestimmen }
    Abstand1 := Abstand_Punkt_von_Punkt( Punkt, SP1 );
    Abstand2 := Abstand_Punkt_von_Punkt( Punkt, SP2 );
    If Abstand1 < Abstand2
    then
      Begin
      Abstand     := Abstand1;
      Ellipsenpkt := SP1
      end
    else
      Begin
      Abstand     := Abstand2;
      Ellipsenpkt := SP2;
      end;
    { zugehörigen Winkel bestimmen }
    { 1. in Ursprung verschieben }
    Diffvektor      := Vektor_Minus_Vektor( Ellipsenpkt, Ellipse.Mittelpunkt );
    DiffvektorPunkt := Vektor_Minus_Vektor( Punkt, Ellipse.Mittelpunkt );
    { Vorzeichen gemäß Lage zu gesuchten Abstand bestimmen (innen oder außen)}
    If EuklidscheNorm(Diffvektor) > EuklidscheNorm(DiffvektorPunkt)
    then { Punkt liegt im Inneren der Ellipse }
      Abstand := - Abstand;
    { 2. Verdrehung zurücknehmen }
    Drehwinkel := - Ellipse.Drehwinkel;
    SinCos( Drehwinkel, sinWinkel, cosWinkel );
    HilfsPkt.x := Diffvektor.x * cosWinkel - Diffvektor.y * sinWinkel;
    HilfsPkt.y := Diffvektor.x * sinWinkel + Diffvektor.y * cosWinkel;
    { 3. Winkel bestimmen }
    HilfsPkt.x      := HilfsPkt.x / Ellipse.Radius_x; // =cos(Winkel)
    HilfsPkt.y      := HilfsPkt.y / Ellipse.Radius_y; // =sin(Winkel)
    DiffvektorPolar := KartesischNachPolar( HilfsPkt );
    Winkel          := DiffvektorPolar.w;

    result          := 0
  except
    result := -9999;
    end
  end;

{ ---------------------------------------------------------------------------- }

Function Gerade_durch_zwei_Punkte( Punkt1, Punkt2 : Typ_ePunkt; Var Gerade : Typ_eGerade ) : Integer;
  { es wird eine Gerade durch die zwei Punkte Punkt1 und Punkt2 gelegt. Die Gerade wird so durch die
    Punkte gelegt, dass der Normalenvektor (Gerade.nx / Gerade.ny) um -90° Grad gedreht ist, gegen
    die Richtung (Punkt1Punkt2). Wenn man in diese Richtung auf die Gerade schaut, dann haben alle
    Punkte die links von der Geraden jetzt liegen einen negativen orientierten Abstand und alle Punkte
    die rechts davon liegen einen positiven orientierten Abstand.
    Rückgabewerte :
       0 - alles Ok
      -1 - beide Punkte gleich, keine Gerade bestimmbar }
  const
    eps_min = 1.0E-10;
  Var
    dx : extended;
    dy : extended;
  Begin
  try
    dx := Punkt2.x - Punkt1.x;
    dy := Punkt2.y - Punkt1.y;
    If abs(dx) < eps_min
    then
      dx := 0;
    If abs(dy) < eps_min
    then
      dy := 0;
    If ( abs(dx) < eps ) and ( abs(dy) < eps )
    then { beide Punkte sind gleich }
      Begin
      result := -1;
      exit
      end;
    { Falsche Stelle eingebaut
    if abs(dx) < eps_min then
      dx := 0;
    if abs(dy) < eps_min then
      dy := 0;
    }

    { um 270° gedrehter Normalenvektor. Drehmatrix lautet ( 0 1 | -1 0 )  }
    Gerade.nx :=   dy;
    Gerade.ny := - dx;
    Gerade.c  := Gerade.nx * Punkt1.x + Gerade.ny * Punkt1.y;
    result    := 0
  except
    result := -9999
    end;
  end;

{ ---------------------------------------------------------------------------- }

Function Senkrechte_Gerade_durch_Punkt( Gerade : Typ_eGerade; Punkt : Typ_ePunkt;
  Var SenkrechteGerade : Typ_eGerade ) : Integer;
  { Es wird die senkrechte Gerade zur gegebenen Geraden "Gerade" durch den Punkt
    "Punkt" bestimmt.
    Rückgabewerte :
      0 - Alles Ok
     -1 - "Gerade" ist keine Gerade
    }

  Begin
  try
    If (abs(Gerade.nx) < eps) and (abs(Gerade.ny) < eps)
    then
      Begin
      result := -1;
      exit
      end;

    SenkrechteGerade.nx :=  - Gerade.ny;
    SenkrechteGerade.ny :=    Gerade.nx;
    SenkrechteGerade.c  := SenkrechteGerade.nx * Punkt.x + SenkrechteGerade.ny * Punkt.y;
    result              := 0
  except
    result := -9999
    end;
  end;

{ ---------------------------------------------------------------------------- }

Function Mittelsenkrechte_einer_Strecke( Punkt1, Punkt2 : Typ_ePunkt;
  Var Mittelsenkrechte : Typ_eGerade ) : Integer;
  { Es wird die Mittelsenkrechte zu der Strecke zwischen den beiden Punkten
    Punkt1 und Punkt2 bestimmt.
    Rückgabewerte :
      0 - Alles Ok
     -1 - "zwei gleiche Punkte gegeben"
     -2 - Senkrechtbildung fehlgeschlagen
    }
  Var
    Mittelpoint       : Typ_ePunkt;
    Verbindungsgerade : Typ_eGerade;
  Begin
  try
    Mittelpoint := Mittelpunkt( Punkt1, Punkt2 );
    If Gerade_durch_zwei_Punkte( Punkt1, Punkt2, Verbindungsgerade ) <> 0
    then
      Begin
      result := -1;
      exit
      end;
    If Senkrechte_Gerade_durch_Punkt( Verbindungsgerade, Mittelpoint, Mittelsenkrechte ) <> 0
    then
      Begin
      result := -2;
      exit
      end;
    result := 0
  except
    result := -9999
    end;
  end;

{ ---------------------------------------------------------------------------- }

Function Parallele_Gerade_durch_Punkt( Gerade : Typ_eGerade; Punkt : Typ_ePunkt;
  Var ParalleleGerade : Typ_eGerade ) : Integer;
  { Es wird die parallele Gerade zur gegebenen Geraden "Gerade" durch den Punkt
    "Punkt" bestimmt.
    Rückgabewerte :
      0 - Alles Ok
     -1 - "Gerade" ist keine Gerade
    }

  Begin
  try
    If (abs(Gerade.nx) < eps) and (abs(Gerade.ny) < eps)
    then
      Begin
      result := -1;
      exit
      end;

    ParalleleGerade.nx := Gerade.nx;
    ParalleleGerade.ny := Gerade.ny;
    ParalleleGerade.c  := ParalleleGerade.nx * Punkt.x + ParalleleGerade.ny * Punkt.y;
    result             := 0
  except
    result := -9999
    end;
  end;

{ ---------------------------------------------------------------------------- }

Function Parallele_Gerade_im_y_Abstand( Gerade : Typ_eGerade; y_Abstand : extended;
  Var ParalleleGerade : Typ_eGerade ) : Integer;
  { es wird die parallele Gerade zur gegebenen Geraden bestimmt, die in y-Richtung
    um y_Abstand verschoben ist.
    Geraden mit ny = 0 (Parallelen zur y-Achse ) werden in sich selbst abgebildet
    Rückgabewerte :
      0 - Alles Ok
     -1 - "Gerade" ist keine Gerade
  }
  Begin
  try
    If (abs(Gerade.nx) < eps) and (abs(Gerade.ny) < eps)
    then
      Begin
      result := -1;
      exit
      end;

    ParalleleGerade.nx := Gerade.nx;
    ParalleleGerade.ny := Gerade.ny;
    ParalleleGerade.c  := Gerade.c + Gerade.ny * y_Abstand;
    result := 0
  except
    result := -9999
    end;
  end;

{ ---------------------------------------------------------------------------- }

Function Parallele_Gerade_im_x_Abstand( Gerade : Typ_eGerade; x_Abstand : extended;
  Var ParalleleGerade : Typ_eGerade ) : Integer;
  { es wird die parallele Gerade zur gegebenen Geraden bestimmt, die in x-Richtung
    um x_Abstand verschoben ist.
    Geraden mit nx = 0 (Parallelen zur x-Achse ) werden in sich selbst abgebildet
    Rückgabewerte :
      0 - Alles Ok
     -1 - "Gerade" ist keine Gerade
  }
  Begin
  try
    If (abs(Gerade.nx) < eps) and (abs(Gerade.ny) < eps)
    then
      Begin
      result := -1;
      exit
      end;

    ParalleleGerade.nx := Gerade.nx;
    ParalleleGerade.ny := Gerade.ny;
    ParalleleGerade.c  := Gerade.c + Gerade.nx * x_Abstand;
    result := 0
  except
    result := -9999
    end;
  end;

{ ---------------------------------------------------------------------------- }

Function Parallele_Gerade_im_Abstand( Gerade : Typ_eGerade; OrientierterAbstand : extended;
  Var ParalleleGerade : Typ_eGerade ) : Integer;
  { Zu einer gegebenen Geraden gibt es zwei Geraden im Abstand "Abstand"
    (= Betrag von OrientierterAbstand).
    Es wird bei positivem orientiertem Abstand die Gerade zurückgegeben, die
    auf der Seite der gegebenen Geraden liegt in die der Normalenvektor
    (Gerade.nx, Gerade.ny) zeigt. Ansonsten die andere Gerade.
    Rückgabewerte :
      0 - Alles Ok
     -1 - keine Gerade gegeben
   }
  Var
    Hilfspunkt : Typ_ePunkt;
  Begin
  try
    If (abs(Gerade.nx) < eps) and (abs(Gerade.ny) < eps)
    then
      Begin
      result := -1;
      exit
      end;

    ParalleleGerade.nx := Gerade.nx;
    ParalleleGerade.ny := Gerade.ny;
    Hilfspunkt.x       := Gerade.nx;
    Hilfspunkt.y       := Gerade.ny;
    ParalleleGerade.c  := Gerade.c + OrientierterAbstand * EuklidscheNorm( Hilfspunkt );
    result := 0
  except
    result := -9999;
    end;
  end;

{ ---------------------------------------------------------------------------- }

Function Schnitt_Gerade_Strecke( Gerade : Typ_eGerade; Punkt1, Punkt2 : Typ_ePunkt;
  Var Schnittpunkt : Typ_ePunkt ) : Integer;
  { Es wird versucht den Schnittpunkt zwischen Gerade und Strecke (Punkt1,Punkt2)
    zu finden.
    Rückgabewerte :
      0 - Schnittpunkt gefunden, alles Ok
     -1 - keine Gerade gegeben
     -2 - keine Strecke gegeben   (Punkt1 = Punkt2)
     -3 - kein Schnittpunkt vorhanden (parallel !)
     -4 - Schnittpunkt liegt nicht im Streckenbereich
   }
  Var
    dx     : extended;
    dy     : extended;
    nenner : extended;
    lambda : extended;
  Begin
  try
    If (abs(Gerade.nx) < eps) and (abs(Gerade.ny) < eps)
    then
      Begin
      result := -1;
      exit
      end;
    dx := Punkt2.x - Punkt1.x;
    dy := Punkt2.y - Punkt1.y;
    If (abs(dx) < eps) and (abs(dy) < eps)
    then
      Begin
      result := -2;
      exit
      end;
    nenner := Gerade.nx * dx + Gerade.ny * dy;
    If abs(nenner) < eps
    then
      Begin
      result := -3;
      exit
      end;
    lambda := ( Gerade.c - Gerade.nx * Punkt1.x - Gerade.ny * Punkt1.y ) / nenner;
    If ( lambda < ( - eps ) ) or ( lambda > ( 1.0 + eps ) )
    then
      Begin
      result := -4;
      exit
      end;
    Schnittpunkt.x := Punkt1.x + lambda * dx;
    Schnittpunkt.y := Punkt1.y + lambda * dy;
    result         := 0
  except
    result := -9999
    end;
  end;

{ ---------------------------------------------------------------------------- }

Function Schnitt_Gerade_Strecke_mit_Richtung( Gerade : Typ_eGerade; Punkt1, Punkt2 : Typ_ePunkt;
  Var Schnittpunkt, Richtung : Typ_ePunkt ) : Integer;
  { Es wird versucht den Schnittpunkt zwischen Gerade und Strecke (Punkt1,Punkt2)
    zu finden. Im erfolgreichen Fall wird die Richtung der Strecke zurückgegeben.
    Rückgabewerte :
      0 - Schnittpunkt gefunden, alles Ok
     -1 - keine Gerade gegeben
     -2 - keine Strecke gegeben   (Punkt1 = Punkt2)
     -3 - kein Schnittpunkt vorhanden (parallel !)
     -4 - Schnittpunkt liegt nicht im Streckenbereich
   }
  Var
    dx     : extended;
    dy     : extended;
    nenner : extended;
    lambda : extended;
    laenge : extended;
  Begin
  try
    If (abs(Gerade.nx) < eps) and (abs(Gerade.ny) < eps)
    then
      Begin
      result := -1;
      exit
      end;
    dx := Punkt2.x - Punkt1.x;
    dy := Punkt2.y - Punkt1.y;
    If (abs(dx) < eps) and (abs(dy) < eps)
    then
      Begin
      result := -2;
      exit
      end;
    nenner := Gerade.nx * dx + Gerade.ny * dy;
    If abs(nenner) < eps
    then
      Begin
      result := -3;
      exit
      end;
    lambda := ( Gerade.c - Gerade.nx * Punkt1.x - Gerade.ny * Punkt1.y ) / nenner;
    If ( lambda < ( - eps ) ) or ( lambda > ( 1.0 + eps ) )
    then
      Begin
      result := -4;
      exit
      end;
    Schnittpunkt.x := Punkt1.x + lambda * dx;
    Schnittpunkt.y := Punkt1.y + lambda * dy;
    laenge         := sqrt( sqr(dx) + sqr(dy) );
    Richtung.x     := dx / laenge;
    Richtung.y     := dy / laenge;
    result         := 0
  except
    result := -9999
    end;
  end;

{ ---------------------------------------------------------------------------- }

Function Orientierter_Abstand_Punkt_von_Gerade( Punkt : Typ_ePunkt; Gerade : Typ_eGerade;
  Var Abstand : extended ) : Integer;
  { Die Funktion liefert den vorzeichenbehafteten (=orientierten) Abstand des
    Punktes (x,y) von der Geraden
       nx * x + ny * y = c
    Das Vorzeichen gibt als Info auf welcher Seite der Geraden sich der Punkt befindet.
    Wurde die Gerade aus zwei Punkten P1 und P2 mit Hilfe der Funktion
    Gerade_durch_zwei_Punkte gebildet. So gilt: Ist der Abstand > 0, so liegt der
    Punkt rechts von der Geraden wenn man in Richtung (P1P2) schaut.

    Rückgabewerte:
      0 - Alles Ok
     -1 - keine Gerade gegeben
    }
  Begin
  try
    If (abs(Gerade.nx) < eps) and (abs(Gerade.ny) < eps)
    then
      Begin
      result := -1;
      exit
      end;
    Abstand := ( Gerade.nx * Punkt.x + Gerade.ny * Punkt.y - Gerade.c )
      / sqrt( sqr(Gerade.nx) + sqr(Gerade.ny) );
    result := 0
  except
    result := -9999
    end;
  end;

{ ---------------------------------------------------------------------------- }

Function Orientierter_Abstand_Punkt_von_Gerade_plus( Punkt : Typ_ePunkt; Gerade : Typ_eGerade;
  Var Abstand : extended; Var Sollpunkt : Typ_ePunkt ) : Integer;
  { Die Funktion liefert den vorzeichenbehafteten (=orientierten) Abstand des
    Punktes (x,y) von der Geraden
       nx * x + ny * y = c
    Das Vorzeichen gibt als Info auf welcher Seite der Geraden sich der Punkt befindet.
    Wurde die Gerade aus zwei Punkten P1 und P2 mit Hilfe der Funktion
    Gerade_durch_zwei_Punkte gebildet. So gilt: Ist der Abstand > 0, so liegt der
    Punkt rechts von der Geraden wenn man in Richtung (P1P2) schaut.
    Zusätzlich wird der Sollpunkt zurückgegeben, der zur Abstandsbestimmung herangezogen wurde.

    Rückgabewerte:
      0 - Alles Ok
     -1 - keine Gerade gegeben
    }
  Var
    NormV : Typ_ePunkt;
    Norm  : extended;
  Begin
  try
    If (abs(Gerade.nx) < eps) and (abs(Gerade.ny) < eps)
    then
      Begin
      result := -1;
      exit
      end;
    NormV.x   := Gerade.nx;
    NormV.y   := Gerade.ny;
    Norm      := EuklidscheNorm(NormV);
    Abstand   := ( Gerade.nx * Punkt.x + Gerade.ny * Punkt.y - Gerade.c ) / Norm;
    Sollpunkt := Vektor_minus_Vektor( Punkt, Vektor_mal_Skalar( NormV, Abstand / Norm ) );
    result := 0
  except
    result := -9999
    end;
  end;

{ ---------------------------------------------------------------------------- }

Function Abstand_Punkt_von_Gerade( Punkt : Typ_ePunkt; Gerade : Typ_eGerade;
  Var Abstand : extended ) : Integer;
  { Die Funktion liefert den Abstand des Punktes (x,y) von der Geraden
    nx * x + ny * y = c
    Rückgabewerte:
      0 - Alles Ok
     -1 - keine Gerade gegeben
    }
  Begin
  try
    result  := Orientierter_Abstand_Punkt_von_Gerade( Punkt, Gerade, Abstand );
    If result < 0
    then
      exit;
    Abstand := abs( Abstand );
  except
    result := -9999
    end;
  end;

{ ---------------------------------------------------------------------------- }

Function Orientierter_Abstand_Punkt_von_Kreis( Punkt : Typ_ePunkt; Kreis : Typ_eKreis ) : extended;
  { Gibt den Abstand eines Punktes von einem Kreis zurück. Negativ wenn im Kreis liegend, sonst positiv }
  Begin
  try
    result := Abstand_Punkt_von_Punkt( Punkt, Kreis.Mittelpunkt ) - Kreis.Radius
  except { Für den Fall, dass "Müll" übergeben wird }
    result := -9999.9999
    end;
  end;

{ ---------------------------------------------------------------------------- }

Function Orientierter_Abstand_Punkt_von_Kreis_plus( Punkt : Typ_ePunkt; Kreis : Typ_eKreis;
  Var Sollpunkt : Typ_ePunkt ) : extended;
  { Gibt den Abstand eines Punktes von einem Kreis zurück. Negativ wenn im Kreis liegend, sonst positiv.
    Zusätzlich wird der Kreispunkt bestimmt, gegen den dieser Abstand bestimmt wurde.
    Fällt der Punkt mit dem Mittelpunkt zusammen, wird der Punkt bei 0 Grad zurückgegeben.
   }
  Var
    DiffV  : Typ_ePunkt;
    Winkel : extended;
  Begin
  try
    result := Abstand_Punkt_von_Punkt( Punkt, Kreis.Mittelpunkt ) - Kreis.Radius;
    DiffV := Vektor_minus_Vektor( Punkt, Kreis.Mittelpunkt );
    If WinkelPolarkoordinaten( DiffV, Winkel ) < 0
    then { Punkt = Mittelpunkt }
      Winkel := 0;
    Sollpunkt.x := Kreis.Mittelpunkt.x + Kreis.Radius * Cos( Winkel );
    Sollpunkt.y := Kreis.Mittelpunkt.y + Kreis.Radius * Sin( Winkel );
  except { Für den Fall, dass "Müll" übergeben wird }
    result := -9999.9999
    end;
  end;

{ ---------------------------------------------------------------------------- }

Function Abstand_Punkt_von_Kreis( Punkt : Typ_ePunkt; Kreis : Typ_eKreis ) : extended;
  { Gibt den Abstand eines Punktes von einem Kreis zurück }
  Begin
  try
    result := Orientierter_Abstand_Punkt_von_Kreis( Punkt, Kreis );
    If result <> -9999.9999
    then
      result := abs( result );
  except { Für den Fall, dass "Müll" übergeben wird }
    result := -9999.9999
    end;
  end;

{ ---------------------------------------------------------------------------- }

Function Orientierter_Abstand_Punkt_von_Kreisbogen( Punkt : Typ_ePunkt; Kreisbogen : Typ_eKreisbogen;
  ImSektor : Boolean ) : extended;
  { Gibt den orientierten Abstand eines Punktes vom Kreisbogen zurück.
    Wenn ImSektor true ist, dann wird der Abstand des Punktes, wenn er auf der Seite des Mittelpunktes
    im Sektor zum Kreisbogen liegt, negativ ausgegeben. Ansonsten ist er positiv.
    Im anderen Fall ist der Abstand dann negativ, wenn er im Winkelbereich liegt und nicht auf der Seite des
    Mittelpunktes.
    Ist der Endwinkel = Startwinkel wird von einem Punkt als entarteter Bogen ausgegangen. }
  Var
    Winkel   : extended;
    Startw   : extended;
    Endw     : extended;
    BogenA   : Typ_ePunkt; { Anfangspunkt des Bogens }
    BogenE   : Typ_ePunkt; { Endpunkt des Bogens }
    AbstandA : extended;
    AbstandE : extended;
  Begin
  try
    If WinkelPolarkoordinaten( Vektor_Minus_Vektor( Punkt, Kreisbogen.Kreis.Mittelpunkt ), Winkel ) < 0
    then  { Punkt = Mittelpunkt des Kreises zum Kreisbogen }
      Begin
      If ImSektor
      then
        result := - Kreisbogen.Kreis.Radius
      else
        result := Kreisbogen.Kreis.Radius;
      exit
      end;
    { aufsteigenden Winkelbereich erhalten }
    If Kreisbogen.Startwinkel > Kreisbogen.Endwinkel
    then { 0 - Grad Lage liegt im Bogen }
      Begin
      Startw := Kreisbogen.Startwinkel;
      Endw   := Kreisbogen.Endwinkel + 2 * pi;
      If Winkel <= Kreisbogen.Endwinkel
      then { Winkel liegt im Bogen, präzider zwischen 0 Grad und Endwinkel }
        Winkel := Winkel + 2 * pi
      end
    else
      Begin
      Startw := Kreisbogen.Startwinkel;
      Endw   := Kreisbogen.Endwinkel
      end;
    If (Startw <= Winkel ) and ( Winkel <= Endw )
    then { liegt im Bogenbereich, negativ im Sektor, sonst außerhalb }
      begin
      result := Orientierter_Abstand_Punkt_von_Kreis( Punkt, Kreisbogen.Kreis );
      If not ImSektor
      then
        result := - result;
      exit
      end;
    { Liegt außerhalb des Bogenbereiches }
    BogenA.x := Kreisbogen.Kreis.Mittelpunkt.x + Kreisbogen.Kreis.Radius * cos( Kreisbogen.Startwinkel );
    BogenA.y := Kreisbogen.Kreis.Mittelpunkt.y + Kreisbogen.Kreis.Radius * sin( Kreisbogen.Startwinkel );
    BogenE.x := Kreisbogen.Kreis.Mittelpunkt.x + Kreisbogen.Kreis.Radius * cos( Kreisbogen.Endwinkel );
    BogenE.y := Kreisbogen.Kreis.Mittelpunkt.y + Kreisbogen.Kreis.Radius * sin( Kreisbogen.Endwinkel );
    AbstandA := Abstand_Punkt_von_Punkt( Punkt, BogenA );
    AbstandE := Abstand_Punkt_von_Punkt( Punkt, BogenE );
    If AbstandA < AbstandE
    then
      result := AbstandA
    else
      result := AbstandE;
  except { Für den Fall, dass "Müll" übergeben wird }
    result := -9999.9999
    end;
  end;

{ ---------------------------------------------------------------------------- }

Function Orientierter_Abstand_Punkt_von_Kreisbogen_plus( Punkt : Typ_ePunkt; Kreisbogen : Typ_eKreisbogen;
  ImSektor : Boolean; Var Sollpunkt : Typ_ePunkt ) : extended;
  { Gibt den orientierten Abstand eines Punktes vom Kreisbogen zurück.
    Wenn ImSektor true ist, dann wird der Abstand des Punktes, wenn er auf der Seite des Mittelpunktes
    im Sektor zum Kreisbogen liegt, negativ ausgegeben. Ansonsten ist er positiv.
    Im anderen Fall ist der Abstand dann negativ, wenn er im Winkelbereich liegt und nicht auf der Seite des
    Mittelpunktes.
    Ist der Endwinkel = Startwinkel wird von einem Punkt als entarteter Bogen ausgegangen.
    Zusätzlich wird noch der Sollpunkt zurückgegeben, gegen den der Abstand bestimmt wurde.
     }
  Var
    Winkel   : extended;
    Startw   : extended;
    Endw     : extended;
    BogenA   : Typ_ePunkt; { Anfangspunkt des Bogens }
    BogenE   : Typ_ePunkt; { Endpunkt des Bogens }
    AbstandA : extended;
    AbstandE : extended;
  Begin
  try
    If WinkelPolarkoordinaten( Vektor_Minus_Vektor( Punkt, Kreisbogen.Kreis.Mittelpunkt ), Winkel ) < 0
    then  { Punkt = Mittelpunkt des Kreises zum Kreisbogen }
      Begin
      If ImSektor
      then
        result := - Kreisbogen.Kreis.Radius
      else
        result := Kreisbogen.Kreis.Radius;
      exit
      end;
    { aufsteigenden Winkelbereich erhalten }
    If Kreisbogen.Startwinkel > Kreisbogen.Endwinkel
    then { 0 - Grad Lage liegt im Bogen }
      Begin
      Startw := Kreisbogen.Startwinkel;
      Endw   := Kreisbogen.Endwinkel + 2 * pi;
      If Winkel <= Kreisbogen.Endwinkel
      then { Winkel liegt im Bogen, präzider zwischen 0 Grad und Endwinkel }
        Winkel := Winkel + 2 * pi
      end
    else
      Begin
      Startw := Kreisbogen.Startwinkel;
      Endw   := Kreisbogen.Endwinkel
      end;
    If (Startw <= Winkel ) and ( Winkel <= Endw )
    then { liegt im Bogenbereich, negativ im Sektor, sonst außerhalb }
      begin
      result := Orientierter_Abstand_Punkt_von_Kreis_plus( Punkt, Kreisbogen.Kreis, Sollpunkt );
      If not ImSektor
      then
        result := - result;
      exit
      end;
    { Liegt außerhalb des Bogenbereiches }
    BogenA.x := Kreisbogen.Kreis.Mittelpunkt.x + Kreisbogen.Kreis.Radius * cos( Kreisbogen.Startwinkel );
    BogenA.y := Kreisbogen.Kreis.Mittelpunkt.y + Kreisbogen.Kreis.Radius * sin( Kreisbogen.Startwinkel );
    BogenE.x := Kreisbogen.Kreis.Mittelpunkt.x + Kreisbogen.Kreis.Radius * cos( Kreisbogen.Endwinkel );
    BogenE.y := Kreisbogen.Kreis.Mittelpunkt.y + Kreisbogen.Kreis.Radius * sin( Kreisbogen.Endwinkel );
    AbstandA := Abstand_Punkt_von_Punkt( Punkt, BogenA );
    AbstandE := Abstand_Punkt_von_Punkt( Punkt, BogenE );
    If AbstandA < AbstandE
    then
      Begin
      result    := AbstandA;
      Sollpunkt := BogenA
      end
    else
      Begin
      result    := AbstandE;
      Sollpunkt := BogenE
      end
  except { Für den Fall, dass "Müll" übergeben wird }
    result := -9999.9999
    end;
  end;

{ ---------------------------------------------------------------------------- }

Function Abstand_Punkt_von_Kreisbogen( Punkt : Typ_ePunkt; Kreisbogen : Typ_eKreisbogen ) : extended;
  { Gibt den Abstand eines Punktes vom Kreisbogen zurück.
    Ist der Endwinkel = Startwinkel wird von einem Punkt als entarteter Bogen ausgegangen. }
  Begin
  try
    result := Orientierter_Abstand_Punkt_von_Kreisbogen( Punkt, Kreisbogen, true );
    If result <> -9999.9999
    then
      result := abs( result );
  except { Für den Fall, dass "Müll" übergeben wird }
    result := -9999.9999
    end;
  end;

{ ---------------------------------------------------------------------------- }

Function Orientierter_Abstand_Punkt_von_Strecke( Punkt, Punkt1, Punkt2 : Typ_ePunkt ) : Extended;
  { Gibt den orientierten Abstand des Punktes "Punkt" von der Strecke, die durch Punkt1 und Punkt2 gegeben
    ist, zurück.
    Der Abstand ist negativ, wenn der Punkt links von der Strecke liegt, wenn man in Richtung (Punkt1Punkt2) schaut
    und die senkrechte Projektion des Punktes auf die durch die Strecke gehende Gerade auf der Strecke liegt.
    Liegt die Projektion außerhalb der Strecke ist der Abstand positiv.
    Ist keine Strecke (Punkt1 = Punkt2) gegeben, so ist der Abstand positiv
  }

  Var
    Gerade           : Typ_eGerade;
    Projektionspunkt : Typ_ePunkt;
    Diffx            : extended;
    Lambda           : extended;

  Begin
  try
    If Gerade_durch_zwei_Punkte( Punkt1, Punkt2, Gerade ) < 0
    then { Punkt1 = Punkt2 }
      Begin
      result := Abstand_Punkt_von_Punkt( Mittelpunkt(Punkt1, Punkt2), Punkt );
      exit
      end;
    Orthogonale_Projektion_Punkt_auf_Gerade( Punkt, Gerade, Projektionspunkt );
    { Punktgleichheit von Punkt1 und Punkt2 bereits in Gerade durch zwei Punkte bestimmt }
    Diffx := Punkt2.x - Punkt1.x;
    If abs(diffx) < eps
    then { x - Koordinaten stimmen überein, dann müssen y-Koordinaten verschieden sein }
      Lambda := ( Projektionspunkt.y - Punkt1.y ) / ( Punkt2.y - Punkt1.y )
    else
      Lambda := ( Projektionspunkt.x - Punkt1.x ) / ( Punkt2.x - Punkt1.x );
    If ( 0.0 <= Lambda ) and ( Lambda <= 1.0 )
    then { Projektionspunkt liegt auf der Strecke }
      Orientierter_Abstand_Punkt_von_Gerade( Punkt, Gerade, result )
    else { Projektionspunkt liegt außerhalb der Strecke }
      Begin
      Lambda := Abstand_Punkt_von_Punkt( Punkt, Punkt1 );
      result := Abstand_Punkt_von_Punkt( Punkt, Punkt2 );
      If result > Lambda
      then
        result := Lambda
      end
  except { Für den Fall, dass "Müll" übergeben wird }
    result := -9999.9999
    end;
  end;

{ ---------------------------------------------------------------------------- }

Function Orientierter_Abstand_Punkt_von_gegebener_Strecke( Punkt, Punkt1, Punkt2 : Typ_ePunkt; Gerade : Typ_eGerade) : Extended;
  { Abwandlung von gü: die Gerade zwischen den beiden Streckenpunkten wird mit übergeben.

    Man beachte, dass wenn die beiden Punkte Punkt1 und Punkt2 nicht auf der übergebenen Gerade liegen,
    dann werden falsche Werte zurückgegeben!
    Ebenso kann es falsche Ergebnisse geben, wenn die übergebene Gerade nicht durch
    Gerade_durch_zwei_Punkte( Punkt1, Punkt2, Gerade ) erzeugt wurde.

    Gibt den orientierten Abstand des Punktes "Punkt" von der Strecke, die durch Punkt1 und Punkt2 gegeben
    ist, zurück.
    Der Abstand ist negativ, wenn der Punkt links von der Strecke liegt, wenn man in Richtung (Punkt1Punkt2) schaut
    und die senkrechte Projektion des Punktes auf die durch die Strecke gehende Gerade auf der Strecke liegt.
    Liegt die Projektion außerhalb der Strecke ist der Abstand positiv.
    Ist keine Strecke (Punkt1 = Punkt2) gegeben, so ist der Abstand positiv
  }

  Var
    Projektionspunkt : Typ_ePunkt;
    Diffx            : extended;
    Lambda           : extended;
  Begin
  try

    Orthogonale_Projektion_Punkt_auf_Gerade( Punkt, Gerade, Projektionspunkt );
    { Punktgleichheit von Punkt1 und Punkt2 bereits in Gerade durch zwei Punkte bestimmt }
    Diffx := Punkt2.x - Punkt1.x;
    If abs(diffx) < eps
    then { x - Koordinaten stimmen überein, dann müssen y-Koordinaten verschieden sein }
      Lambda := ( Projektionspunkt.y - Punkt1.y ) / ( Punkt2.y - Punkt1.y )
    else
      Lambda := ( Projektionspunkt.x - Punkt1.x ) / ( Punkt2.x - Punkt1.x );
    If ( 0.0 <= Lambda ) and ( Lambda <= 1.0 )
    then { Projektionspunkt liegt auf der Strecke }
      Orientierter_Abstand_Punkt_von_Gerade( Punkt, Gerade, result )
    else { Projektionspunkt liegt außerhalb der Strecke }
      Begin
      Lambda := Abstand_Punkt_von_Punkt( Punkt, Punkt1 );
      result := Abstand_Punkt_von_Punkt( Punkt, Punkt2 );
      If result > Lambda
      then
        result := Lambda
      end
  except { Für den Fall, dass "Müll" übergeben wird }
    result := -9999.9999
    end;
  end;

{ ---------------------------------------------------------------------------- }

Function Abstand_Punkt_von_Strecke_Sektor( Punkt, Punkt1, Punkt2 : Typ_ePunkt; Var Sektor : Integer ) : Extended;
  { Gibt den Abstand des Punktes "Punkt" von der Strecke, die durch Punkt1 und Punkt2 gegeben
    ist, zurück.
    Zusätzlich wird der Sektor angegeben, in welchem der Punkt "Punkt" bezüglich der Strecke liegt.
    Siehe nachfolgende Skizze:
                              1 8 7
                                *      P2
                                |
                              2 | 6
                                |
                                *      P1
                              3 4 5
    "Sektor" =4 heißt, der Punkt liegt auf der Gerade unterhalb der Strecke
    "Sektor" =8 heißt, der Punkt liegt auf der Gerade oberhalb der Strecke
    Liegt der Punkt auf der Strecke wird als Sektor 0 ausgegeben
    Ist keine Strecke (Punkt1 = Punkt2) gegeben, so gelten die Angaben für die
    entartete Strecke, die nur aus einem Punkt besteht, mit der fiktiven "Richtung"
    in x-Richtung.
  }

  Var
    Gerade           : Typ_eGerade;
    Projektionspunkt : Typ_ePunkt;
    Diffx            : extended;
    Lambda           : extended;
    Mp               : Typ_ePunkt;
    Winkel           : extended;
    OAbstand         : extended;

  Begin
  try
    If Gerade_durch_zwei_Punkte( Punkt1, Punkt2, Gerade ) < 0
    then { Punkt1 = Punkt2 }
      Begin
      Mp     := Mittelpunkt(Punkt1, Punkt2);
      result := Abstand_Punkt_von_Punkt( Mp, Punkt );
      Mp     := Vektor_minus_Vektor( Punkt, Mp );
      If WinkelPolarkoordinaten( Mp, Winkel ) < 0
      then
        Sektor := 0
      else
        Begin
        Sektor := trunc(Winkel /(pi/2)) * 2 + 1;
        If Winkel = ( Sektor * pi / 2 )
        then
          Sektor := Sektor - 1;
        If Sektor = 0
        then
          Sektor := 8;
        end;
      exit
      end;
    Orthogonale_Projektion_Punkt_auf_Gerade( Punkt, Gerade, Projektionspunkt );
    { Punktgleichheit von Punkt1 und Punkt2 bereits in Gerade durch zwei Punkte bestimmt }
    Diffx := Punkt2.x - Punkt1.x;
    If abs(diffx) < eps
    then { x - Koordinaten stimmen überein, dann müssen y-Koordinaten verschieden sein }
      Lambda := ( Projektionspunkt.y - Punkt1.y ) / ( Punkt2.y - Punkt1.y )
    else
      Lambda := ( Projektionspunkt.x - Punkt1.x ) / ( Punkt2.x - Punkt1.x );
    Orientierter_Abstand_Punkt_von_Gerade( Punkt, Gerade, OAbstand );
    If ( 0.0 <= Lambda ) and ( Lambda <= 1.0 )
    then { Projektionspunkt liegt auf der Strecke }
      Begin
      If OAbstand > 0.0
      then
        Sektor := 6
      else
        If OAbstand < 0.0
        then
          Sektor := 2
        else
          Sektor := 0;
      result := abs(OAbstand)
      end
    else { Projektionspunkt liegt außerhalb der Strecke }
      Begin
      If OAbstand > 0.0
      then
        If Lambda > 1.0
        then
          Sektor := 7
        else
          Sektor := 5
      else
        If OAbstand < 0.0
        then
          If Lambda > 1.0
          then
            Sektor := 1
          else
            Sektor := 3
        else
          If Lambda > 1.0
          then
            Sektor := 8
          else
            Sektor := 4;

      Lambda := Abstand_Punkt_von_Punkt( Punkt, Punkt1 );
      result := Abstand_Punkt_von_Punkt( Punkt, Punkt2 );
      If result > Lambda
      then
        result := Lambda
      end
  except { Für den Fall, dass "Müll" übergeben wird }
    result := -9999.9999
    end;
  end;

{ ---------------------------------------------------------------------------- }

Function Orientierter_Abstand_Punkt_von_Strecke_plus( Punkt, Punkt1, Punkt2 : Typ_ePunkt;
  Var Sollpunkt : Typ_ePunkt  ) : Extended;
  { Gibt den orientierten Abstand des Punktes "Punkt" von der Strecke, die durch Punkt1 und Punkt2 gegeben
    ist, zurück.
    Der Abstand ist negativ, wenn der Punkt links von der Strecke liegt, wenn man in Richtung (Punkt1Punkt2) schaut
    und die senkrechte Projektion des Punktes auf die durch die Strecke gehende Gerade auf der Strecke liegt.
    Liegt die Projektion außerhalb der Strecke ist der Abstand positiv.
    Ist keine Strecke (Punkt1 = Punkt2) gegeben, so ist der Abstand positiv
    Zusätzlich wird noch der Sollpunkt zurückgegeben, gegen den der Abstand bestimmt wurde }

  Var
    Gerade           : Typ_eGerade;
    Projektionspunkt : Typ_ePunkt;
    Diffx            : extended;
    Lambda           : extended;

  Begin
  try
    If Gerade_durch_zwei_Punkte( Punkt1, Punkt2, Gerade ) < 0
    then { Punkt1 = Punkt2 }
      Begin
      result := Abstand_Punkt_von_Punkt( Mittelpunkt(Punkt1, Punkt2), Punkt );
      exit
      end;
    Orthogonale_Projektion_Punkt_auf_Gerade( Punkt, Gerade, Projektionspunkt );
    { Punktgleichheit von Punkt1 und Punkt2 bereits in Gerade durch zwei Punkte bestimmt }
    Diffx := Punkt2.x - Punkt1.x;
    If abs(diffx) < eps
    then { x - Koordinaten stimmen überein, dann müssen y-Koordinaten verschieden sein }
      Lambda := ( Projektionspunkt.y - Punkt1.y ) / ( Punkt2.y - Punkt1.y )
    else
      Lambda := ( Projektionspunkt.x - Punkt1.x ) / ( Punkt2.x - Punkt1.x );
    If ( 0.0 <= Lambda ) and ( Lambda <= 1.0 )
    then { Projektionspunkt liegt auf der Strecke }
      Orientierter_Abstand_Punkt_von_Gerade_plus( Punkt, Gerade, result, Sollpunkt )
    else { Projektionspunkt liegt außerhalb der Strecke }
      Begin
      Lambda := Abstand_Punkt_von_Punkt( Punkt, Punkt1 );
      result := Abstand_Punkt_von_Punkt( Punkt, Punkt2 );
      If result > Lambda
      then
        Begin
        Sollpunkt := Punkt1;
        result    := Lambda
        end
      else
        Sollpunkt := Punkt2
      end
  except { Für den Fall, dass "Müll" übergeben wird }
    result := -9999.9999
    end;
  end;

{ ---------------------------------------------------------------------------- }

Function Abstand_Punkt_von_Strecke( Punkt, Punkt1, Punkt2 : Typ_ePunkt ) : Extended;
  { Gibt den orientierten Abstand des Punktes "Punkt" von der Strecke, die durch Punkt1 und Punkt2 gegeben
    ist, zurück. }
  Begin
  try
    result := Orientierter_Abstand_Punkt_von_Strecke( Punkt, Punkt1, Punkt2 );
    If result <> -9999.9999
    then
      result := abs( result );
  except { Für den Fall, dass "Müll" übergeben wird }
    result := -9999.9999
    end;
  end;

{ ---------------------------------------------------------------------------- }

Function Orientierter_Abstand_Punkt_von_Rechteck_plus( Punkt, PktRu, PktRo, PktLo, PktLu : Typ_ePunkt;
  Var Sollpunkt : Typ_ePunkt; Var Abstandsseite : Integer  ) : Extended;
  { gibt den orientierten Abstand des Punktes Punkt vom Rechteck PktRu-PktRo-PktLo-PktLu zurück.
    Der Abstand ist negativ, wenn der Punkt innerhalb des Rechtecks liegt.
    Die Punkte müssen im mathematischen Drehsinn gegeben werden !
    Die Seiten werden wie folgt durchnummeriert:
    1 = PktRu-PktRo (rechts), 2 = PktRo-PktLo (oben), 3 = PktLo-PktLu (links), 4 = PktLu-PktRu (unten).
    Die Abstandsseite gibt die Nummer der Seite an, auf der der Sollpunkt liegt.
  }
  Var
    hpkt        : Array[ 1 .. 4 ] of Typ_ePunkt;
    Abstand     : Array[ 1 .. 4 ] of extended;
    Abstand_pos : extended;
    Abstand_neg : extended;
    Seitenr_pos : integer;
    Seitenr_neg : integer;
    lv          : integer;
  Begin
  { Abstandsberechnung }
  Abstand[ 1 ] := Orientierter_Abstand_Punkt_von_Strecke_plus( Punkt, PktRu, PktRo, hpkt[ 1 ] );
  Abstand[ 2 ] := Orientierter_Abstand_Punkt_von_Strecke_plus( Punkt, PktRo, PktLo, hpkt[ 2 ] );
  Abstand[ 3 ] := Orientierter_Abstand_Punkt_von_Strecke_plus( Punkt, PktLo, PktLu, hpkt[ 3 ] );
  Abstand[ 4 ] := Orientierter_Abstand_Punkt_von_Strecke_plus( Punkt, PktLu, PktRu, hpkt[ 4 ] );
  { Auswertung }
  Seitenr_pos := 0;
  Abstand_pos := 0;
  Seitenr_neg := 0;
  Abstand_neg := 0;
  For lv := 1 to 4 do
    If Abstand[ lv ] > 0
    then
      Begin
      If Seitenr_pos = 0
      then
        Begin
        Seitenr_pos := lv;
        Abstand_pos := Abstand[ lv ]
        end
      else { es gab bereits einen positiven Abstand }
        If Abstand_pos > Abstand[ lv ]
        then
          Begin
          Seitenr_pos := lv;
          Abstand_pos := Abstand[ lv ]
          end
      end
    else { negativer Abstand }
      Begin
      If Seitenr_neg = 0
      then
        Begin
        Seitenr_neg := lv;
        Abstand_neg := Abstand[ lv ]
        end
      else { es gab bereits einen negativen Abstand }
        If Abstand_neg < Abstand[ lv ]
        then
          Begin
          Seitenr_neg := lv;
          Abstand_neg := Abstand[ lv ]
          end
      end;
  { Rückgabewerte befüllen }
  If Seitenr_pos = 0
  then { Punkt liegt im inneren des Rechtecks }
    Begin
    Sollpunkt     := hpkt[ Seitenr_neg ];
    Abstandsseite := Seitenr_neg;
    result        := Abstand_neg
    end
  else { Punkt liegt außerhalb des Rechtecks }
    Begin
    Sollpunkt     := hpkt[ Seitenr_pos ];
    Abstandsseite := Seitenr_pos;
    result        := Abstand_pos
    end

  end;

{ ---------------------------------------------------------------------------- }

Function Orientierter_Abstand_Punkt_von_Kreisbereich_plus( Punkt, Mittelpunkt : Typ_ePunkt;
  Radiusklein, Radiusgrosz, Startwinkel, Endwinkel : extended;
  Var Sollpunkt : Typ_ePunkt; Var Abstandsseite : Integer  ) : Extended;
  { gibt den orientierten Abstand des Punktes Punkt vom Kreisbereich wieder, der
    wie folgt gegeben ist: Bereich zwischen Kreisbogen(Startwinkel, Endwinkel)
    bei Radiusklein und Kreisbogen(Startwinkel, Endwinkel) bei Radiusgrosz wieder
    Der Abstand ist negativ, wenn der Punkt innerhalb des Kreisbereiches liegt.
    Die Seiten werden wie folgt durchnummeriert:
    1 = untererBogen, 2 = rechteSeite, 3 = oberer Bogen, 4 = linkeSeite.
    Die Abstandsseite gibt die Nummer der Seite an, auf der der Sollpunkt liegt.
  }
  Var
    hpkt        : Array[ 1 .. 4 ] of Typ_ePunkt;
    Abstand     : Array[ 1 .. 4 ] of extended;
    Abstand_pos : extended;
    Abstand_neg : extended;
    Seitenr_pos : integer;
    Seitenr_neg : integer;
    lv          : integer;
    Pkt1        : Typ_ePunkt;
    Pkt2        : Typ_ePunkt;
    Kreisbogen  : Typ_eKreisbogen;
    DiffV       : Typ_ePunkt;
    Radius      : extended;
    Winkel      : extended;
  Begin
  { Abstandsberechnung }
  Kreisbogen.Kreis.Mittelpunkt := Mittelpunkt;
  Kreisbogen.Startwinkel       := Startwinkel;
  Kreisbogen.Endwinkel         := Endwinkel;
  Kreisbogen.Kreis.Radius      := Radiusklein;
  Abstand[ 1 ]                 := Orientierter_Abstand_Punkt_von_Kreisbogen_plus( Punkt, Kreisbogen, false, hpkt[ 1 ] );
  Pkt1.x                       := Mittelpunkt.x + Radiusklein * cos( Startwinkel );
  Pkt1.y                       := Mittelpunkt.y + Radiusklein * sin( Startwinkel );
  Pkt2.x                       := Mittelpunkt.x + Radiusgrosz * cos( Startwinkel );
  Pkt2.y                       := Mittelpunkt.y + Radiusgrosz * sin( Startwinkel );
  Abstand[ 2 ]                 := Orientierter_Abstand_Punkt_von_Strecke_plus( Punkt, Pkt1, Pkt2, hpkt[ 2 ] );
  Kreisbogen.Kreis.Radius      := Radiusgrosz;
  Abstand[ 3 ]                 := Orientierter_Abstand_Punkt_von_Kreisbogen_plus( Punkt, Kreisbogen, true, hpkt[ 3 ] );
  Pkt1.x                       := Mittelpunkt.x + Radiusklein * cos( Endwinkel );
  Pkt1.y                       := Mittelpunkt.y + Radiusklein * sin( Endwinkel );
  Pkt2.x                       := Mittelpunkt.x + Radiusgrosz * cos( Endwinkel );
  Pkt2.y                       := Mittelpunkt.y + Radiusgrosz * sin( Endwinkel );
  Abstand[ 4 ]                 := Orientierter_Abstand_Punkt_von_Strecke_plus( Punkt, Pkt2, Pkt1, hpkt[ 4 ] );
  { Bei den Geradenstücken kann ein außerhalb liegender Punkt auch innen liegen, wegen Bogen }
  If ( Abstand[ 2 ] > 0 ) or ( Abstand[ 4 ] > 0 )
  then
    Begin
    DiffV := Vektor_minus_Vektor( Punkt, Mittelpunkt );
    If WinkelPolarkoordinaten( DiffV, Winkel ) = 0
    then
      If Im_Winkelbereich( Winkel, Startwinkel, Endwinkel )
      then
        Begin
        Radius := EuklidscheNorm( DiffV );
        If ( Radiusklein <= Radius ) and ( Radius <= Radiusgrosz )
        then { Punkt liegt doch im Inneren }
          Begin
          If Abstand[ 2 ] > 0
          then
            Abstand[ 2 ] := - Abstand[ 2 ];
          If Abstand[ 4 ] > 0
          then
            Abstand[ 4 ] := - Abstand[ 4 ];
          end
        end
    end;

  { Auswertung }
  Seitenr_pos := 0;
  Abstand_pos := 0;
  Seitenr_neg := 0;
  Abstand_neg := 0;
  For lv := 1 to 4 do
    If Abstand[ lv ] > 0
    then
      Begin
      If Seitenr_pos = 0
      then
        Begin
        Seitenr_pos := lv;
        Abstand_pos := Abstand[ lv ]
        end
      else { es gab bereits einen positiven Abstand }
        If Abstand_pos > Abstand[ lv ]
        then
          Begin
          Seitenr_pos := lv;
          Abstand_pos := Abstand[ lv ]
          end
      end
    else { negativer Abstand }
      Begin
      If Seitenr_neg = 0
      then
        Begin
        Seitenr_neg := lv;
        Abstand_neg := Abstand[ lv ]
        end
      else { es gab bereits einen negativen Abstand }
        If Abstand_neg < Abstand[ lv ]
        then
          Begin
          Seitenr_neg := lv;
          Abstand_neg := Abstand[ lv ]
          end
      end;
  { Rückgabewerte befüllen }
  If Seitenr_pos = 0
  then { Punkt liegt im Innenraum des Kreisbereiches }
    Begin
    Sollpunkt     := hpkt[ Seitenr_neg ];
    Abstandsseite := Seitenr_neg;
    result        := Abstand_neg
    end
  else { Punkt liegt im Außenraum des Kreisbereiches }
    Begin
    Sollpunkt     := hpkt[ Seitenr_pos ];
    Abstandsseite := Seitenr_pos;
    result        := Abstand_pos
    end
  end;

{ ---------------------------------------------------------------------------- }

Function Orientierter_Abstand_Punkt_von_Kreisbereich_plus2( Punkt, PktRu, PktRo, PktLo, PktLu : Typ_ePunkt;
  BogenU, BogenO : Typ_eKreisbogen; Var Sollpunkt : Typ_ePunkt; Var Abstandsseite : Integer  ) : Extended;
  { gibt den orientierten Abstand des Punktes Punkt vom Kreisbereich wieder, der
    wie folgt gegeben ist:  Man umläuft das Gebiet im mathematischen Sinn
    BogenU, PktRuPktRo, BogenO, PktLoPktLu.
    Die Mittelpunkte und Winkelbereiche der beiden Bögen müssen gleich sein !! ( Wird aber nicht geprüft !!!! )
    Der Abstand ist negativ, wenn der Punkt innerhalb des Kreisbereiches liegt.
    Die Seiten werden wie folgt durchnummeriert:
    1 = untererBogen, 2 = rechteSeite, 3 = oberer Bogen, 4 = linkeSeite.
    Die Abstandsseite gibt die Nummer der Seite an, auf der der Sollpunkt liegt.
  }
  Var
    hpkt        : Array[ 1 .. 4 ] of Typ_ePunkt;
    Abstand     : Array[ 1 .. 4 ] of extended;
    Abstand_pos : extended;
    Abstand_neg : extended;
    Seitenr_pos : integer;
    Seitenr_neg : integer;
    lv          : integer;
    DiffV       : Typ_ePunkt;
    Radius      : extended;
    Winkel      : extended;
  Begin
  { Abstandsberechnung }
  Abstand[ 1 ] := Orientierter_Abstand_Punkt_von_Kreisbogen_plus( Punkt, BogenU, false, hpkt[ 1 ] );
  Abstand[ 2 ] := Orientierter_Abstand_Punkt_von_Strecke_plus( Punkt, PktRu, PktRo, hpkt[ 2 ] );
  Abstand[ 3 ] := Orientierter_Abstand_Punkt_von_Kreisbogen_plus( Punkt, BogenO, true, hpkt[ 3 ] );
  Abstand[ 4 ] := Orientierter_Abstand_Punkt_von_Strecke_plus( Punkt, PktLo, PktLu, hpkt[ 4 ] );
  { Bei den Geradenstücken kann ein außerhalb liegender Punkt auch innen liegen, wegen Bogen }
  If ( Abstand[ 2 ] > 0 ) or ( Abstand[ 4 ] > 0 )
  then
    Begin
    DiffV := Vektor_minus_Vektor( Punkt, BogenU.Kreis.Mittelpunkt );
    If WinkelPolarkoordinaten( DiffV, Winkel ) = 0
    then
      If Im_Winkelbereich( Winkel, BogenU.Startwinkel, BogenU.Endwinkel )
      then
        Begin
        Radius := EuklidscheNorm( DiffV );
        If ( BogenU.Kreis.Radius <= Radius ) and ( Radius <= BogenO.Kreis.Radius )
        then { Punkt liegt doch im Inneren }
          Begin
          If Abstand[ 2 ] > 0
          then
            Abstand[ 2 ] := - Abstand[ 2 ];
          If Abstand[ 4 ] > 0
          then
            Abstand[ 4 ] := - Abstand[ 4 ];
          end
        end
    end;
  { Auswertung }
  Seitenr_pos := 0;
  Abstand_pos := 0;
  Seitenr_neg := 0;
  Abstand_neg := 0;
  For lv := 1 to 4 do
    If Abstand[ lv ] > 0
    then
      Begin
      If Seitenr_pos = 0
      then
        Begin
        Seitenr_pos := lv;
        Abstand_pos := Abstand[ lv ]
        end
      else { es gab bereits einen positiven Abstand }
        If Abstand_pos > Abstand[ lv ]
        then
          Begin
          Seitenr_pos := lv;
          Abstand_pos := Abstand[ lv ]
          end
      end
    else { negativer Abstand }
      Begin
      If Seitenr_neg = 0
      then
        Begin
        Seitenr_neg := lv;
        Abstand_neg := Abstand[ lv ]
        end
      else { es gab bereits einen negativen Abstand }
        If Abstand_neg < Abstand[ lv ]
        then
          Begin
          Seitenr_neg := lv;
          Abstand_neg := Abstand[ lv ]
          end
      end;
  { Rückgabewerte befüllen }
  If Seitenr_pos = 0
  then { Punkt liegt im Innenraum des Kreisbereiches }
    Begin
    Sollpunkt     := hpkt[ Seitenr_neg ];
    Abstandsseite := Seitenr_neg;
    result        := Abstand_neg
    end
  else { Punkt liegt im Außenraum des Kreisbereiches }
    Begin
    Sollpunkt     := hpkt[ Seitenr_pos ];
    Abstandsseite := Seitenr_pos;
    result        := Abstand_pos
    end
  end;

{ ---------------------------------------------------------------------------- }

Function Abstand_Punkt_von_Punkt( Punkt1, Punkt2 : Typ_ePunkt ) : Extended;
  { Die Funktion liefert den Abstand des Punktes (x1,y1) zum
    Punkt (x2,y2) }
  begin
  try
    result := sqrt( sqr(Punkt1.x - Punkt2.x) + sqr(Punkt1.y - Punkt2.y) )
  except
    result := -9999.9999
    end;
  end;

{ ---------------------------------------------------------------------------- }

Function Mittelpunkt( Punkt1, Punkt2 : Typ_ePunkt ) : Typ_ePunkt;
  { Die Funktion liefert den Mittelpunkt zwischen den beiden Punkten Punkt1 und Punkt2 }
  Begin
  try
    result.x := ( Punkt1.x + Punkt2.x ) / 2.0;
    result.y := ( Punkt1.y + Punkt2.y ) / 2.0;
  except
  end;
  end;

{ ---------------------------------------------------------------------------- }

Function Zwei_Geraden_sind_Parallel( Gerade1, Gerade2 : Typ_eGerade;
  Var parallel : Boolean ) : Integer;
  { es wird geprüft ob die beiden Geraden
     nx1 * x + ny1 * y = c1
     nx2 * x + ny2 * y = c2
    parallel zueinander sind.
     Rückgabewert :
        0 - alles ok
       -1 - keine zwei Geraden gegeben
     }
  Begin
  try
    If ((abs(Gerade1.nx) < eps) and (abs(Gerade1.ny) < eps)) or
      ((abs(Gerade2.nx) < eps) and (abs(Gerade2.ny) < eps))
    then
      Begin
      result := -1;
      exit
      end;

    parallel := ( abs( Gerade1.nx * Gerade2.ny - Gerade2.nx * Gerade1.ny ) <= eps );
    result   := 0
  except
    result := -9999
    end;
  end;

{ ---------------------------------------------------------------------------- }

Function Zwei_Geraden_sind_Orthogonal( Gerade1, Gerade2 : Typ_eGerade;
  Var Orthogonal : Boolean) : Integer;
  { es wird geprüft ob die beiden Geraden
     nx1 * x + ny1 * y = c1
     nx2 * x + ny2 * y = c2
    senkrecht zueinander stehen.
     Rückgabewert :
        0 - alles ok
       -1 - keine zwei Geraden gegeben
     }
  Begin
  try
    If ((abs(Gerade1.nx) < eps) and (abs(Gerade1.ny) < eps)) or
      ((abs(Gerade2.nx) < eps) and (abs(Gerade2.ny) < eps))
    then
      Begin
      result := -1;
      exit
      end;

    orthogonal := ( abs( Gerade1.nx * Gerade2.nx + Gerade1.ny * Gerade2.ny ) <= eps );
    result     := 0
  except
    result := -9999
    end;
  end;

{ ---------------------------------------------------------------------------- }

Function Cosinus_des_Winkel_zwischen_zwei_Geraden( Gerade1, Gerade2 : Typ_eGerade;
  Var Cosinus_winkel : extended ) : Integer;
  { Es wird der spitze Winkel in Bogenmaß zwischen den beiden Geraden
     nx1 * x + ny1 * y = c1       Gerade1
     nx2 * x + ny2 * y = c2       Gerade2
     zurückgegeben
     Rückgabewert :
        0 - alles ok
       -1 - keine zwei Geraden gegeben
       -2 - Geraden parallel
     }
  Var
    parallel : Boolean;

  Begin
  try
    If ((abs(Gerade1.nx) < eps) and (abs(Gerade1.ny) < eps)) or
      ((abs(Gerade2.nx) < eps) and (abs(Gerade2.ny) < eps))
    then
      Begin
      result := -1;
      exit
      end;

    Zwei_Geraden_sind_Parallel( Gerade1, Gerade2, parallel ); { Resultabfrage überflüssig }

    If parallel
    then
      Begin
      result := -2;
      exit
      end;

    Cosinus_winkel := ( Gerade1.nx * Gerade2.nx + Gerade1.ny * Gerade2.ny ) /
      ( sqrt( sqr(Gerade1.nx) + sqr(Gerade1.ny) ) * sqrt( sqr(Gerade2.nx) + sqr(Gerade2.ny) ) );
    result := 0;
  except
    result := -9999
    end;
  end;


{ ---------------------------------------------------------------------------- }

Function Winkel_zwischen_zwei_Geraden( Gerade1, Gerade2 : Typ_eGerade;
  Var winkel : extended ) : Integer;
  { Es wird der spitze Winkel in Bogenmaß zwischen den beiden Geraden
     nx1 * x + ny1 * y = c1
     nx2 * x + ny2 * y = c2
     zurückgegeben
     Rückgabewert :
        0 - alles ok
       -1 - keine zwei Geraden gegeben
       -2 - Geraden parallel
     }
  Var
    parallel : Boolean;

  Begin
  try
    If ((abs(Gerade1.nx) < eps) and (abs(Gerade1.ny) < eps)) or
      ((abs(Gerade2.nx) < eps) and (abs(Gerade2.ny) < eps))
    then
      Begin
      result := -1;
      exit
      end;

    Zwei_Geraden_sind_Parallel( Gerade1, Gerade2, parallel ); { Resultabfrage überflüssig }

    If parallel
    then
      Begin
      result := -2;
      exit
      end;

    winkel := ArcCos( abs( Gerade1.nx * Gerade2.nx + Gerade1.ny * Gerade2.ny ) /
      ( sqrt( sqr(Gerade1.nx) + sqr(Gerade1.ny) ) * sqrt( sqr(Gerade2.nx) + sqr(Gerade2.ny) ) ) );
    result := 0;
  except
    result := -9999
    end;
  end;

{ ---------------------------------------------------------------------------- }
Function Tangens_des_Winkel_zwischen_zwei_Geraden( Gerade1, Gerade2 : Typ_eGerade;
  Var Tangens_winkel : extended ) : Integer;
  { Es wird der spitze Winkel in Bogenmaß zwischen den beiden Geraden
     nx1 * x + ny1 * y = c1       Gerade1
     nx2 * x + ny2 * y = c2       Gerade2
     zurückgegeben
     Rückgabewert :
        0 - alles ok
       -1 - keine zwei Geraden gegeben
       -2 - Geraden parallel
     }
  Var
    parallel : Boolean;

  Begin
  try
    If ((abs(Gerade1.nx) < EPS) and (abs(Gerade1.ny) < EPS)) or
       ((abs(Gerade2.nx) < EPS) and (abs(Gerade2.ny) < EPS)) then
      Begin
      result := -1;
      exit
      end;

    Zwei_Geraden_sind_Parallel( Gerade1, Gerade2, parallel ); { Resultabfrage überflüssig }

    If parallel
    then
      Begin
      result := -2;
      exit
      end;

    tangens_winkel := ( Gerade1.nx * Gerade2.ny - Gerade1.ny * Gerade2.nx ) /
                      ( Gerade1.nx * Gerade2.nx + Gerade1.ny * Gerade2.ny ) ;
    result := 0;
  except
    result := -9999
    end;
  end;

{ ---------------------------------------------------------------------------- }

Function Normiere_Gerade( Gerade : Typ_eGerade; Var NormGerade : Typ_eGerade ) : Integer;
  { Die übergebene Gerade wird so darg estellt, dass der Normalenvektor die Länge 1 hat und in die obere Hälfte der Ebene zeigt.
    Sollte ny = 0 sein, so wird nx positiv gemacht.
     Rückgabewert :
        0 - alles ok
       -1 - keine Gerade gegeben
  }
  Var
    Norm : extended;
  Begin
  try
    Norm := sqrt( sqr(Gerade.nx) + sqr(Gerade.ny) );
    If Norm < eps
    then
      Begin
      result := -1;
      exit
      end;
    If abs(Gerade.ny) < eps
    then { Normalenvektor liegt auf x-Achse }
      Begin
      If Gerade.nx < 0.0
      then
        Norm := - Norm
      end
    else
      If Gerade.ny < 0.0
      then
        Norm := - Norm;
    NormGerade.nx := Gerade.nx / Norm;
    NormGerade.ny := Gerade.ny / Norm;
    NormGerade.c  := Gerade.c / Norm;
    result        := 0;
  except
    result := -9999
    end;
  end;

{ ---------------------------------------------------------------------------- }

Function oWinkel_zwischen_zwei_Geraden( Gerade1, Gerade2 : Typ_eGerade;
  Var winkel : extended ) : Integer;
  { Es wird der Winkel in Bogenmaß zwischen den beiden Geraden
     nx1 * x + ny1 * y = c1
     nx2 * x + ny2 * y = c2
     zurückgegeben.
     Dabei wird der Winkel ausgegeben, der sich ergibt wenn man in Richtung des
     Richtungsvektors der Geraden 1 schaut und von dort mathematisch positiv zum
     Richtungsvektor der Gerade 2 möchte.
     Rückgabewert :
        0 - alles ok
       -1 - keine zwei Geraden gegeben
     }
  Var
    Richtung1 : Typ_ePunkt;
    Richtung2 : Typ_ePunkt;

  Begin
  try
    If ((abs(Gerade1.nx) < eps) and (abs(Gerade1.ny) < eps)) or
      ((abs(Gerade2.nx) < eps) and (abs(Gerade2.ny) < eps))
    then
      Begin
      result := -1;
      exit
      end;

    Richtung1.x :=   Gerade1.ny;
    Richtung1.y := - Gerade1.nx;
    Richtung2.x :=   Gerade2.ny;
    Richtung2.y := - Gerade2.nx;
    OWinkel( Richtung1, Richtung2, Winkel ); { Resultabfrage überflüssig }

    result := 0;
  except
    result := -9999
    end;
  end;

{ ---------------------------------------------------------------------------- }

Function Schnittpunkt_Zweier_Geraden( Gerade1, Gerade2 : Typ_eGerade;
  Var Schnittpunkt : Typ_ePunkt ) : Integer;
  { Liefert (sofern vorhanden) den Schnittpunkt der beiden Geraden
     nx1 * x + ny1 * y = c1
     nx2 * x + ny2 * y = c2

    Rückgabewert :
       0 - Schnittpunkt ermittelt
      -1 - keine zwei Geraden gegeben
      -2 - Geraden sind parallel
      -3 - Geraden fallen zusammen
   }
  Var
    Determinante : extended;
    x_zv         : extended;
    y_zv         : extended;

  Begin
  try
    If ((abs(Gerade1.nx) < eps) and (abs(Gerade1.ny) < eps)) or
      ((abs(Gerade2.nx) < eps) and (abs(Gerade2.ny) < eps))
    then
      Begin
      result := -1;
      exit
      end;

    Determinante :=   Gerade1.nx * Gerade2.ny - Gerade2.nx * Gerade1.ny;
    x_zv         :=   Gerade2.ny * Gerade1.c  - Gerade1.ny * Gerade2.c;
    y_zv         := - Gerade2.nx * Gerade1.c  + Gerade1.nx * Gerade2.c;
    If abs(Determinante) < eps
    then { Geraden sind parallel }
      Begin
      If abs( x_zv - y_zv ) < eps
      then { Geraden fallen zusammen }
        result := -3
      else
        result := -2
      end
    else { es gibt einen Schnittpunkt }
      begin
      Schnittpunkt.x := x_zv / Determinante;
      Schnittpunkt.y := y_zv / Determinante;
      result         := 0
      end
  except
    result := -9999
    end;
  end;

{ ---------------------------------------------------------------------------- }

Function Orthogonale_Projektion_Punkt_auf_Gerade( Punkt : Typ_ePunkt; Gerade : Typ_eGerade;
  Var Projektionspunkt : Typ_ePunkt ) : Integer;
  { es wird die senkrechte Projektion des Punktes "Punkt" auf die Gerade bestimmt.
    Rückgabewerte :
       0 = Alles OK
      -1 = keine Gerade gegeben (nx=ny=0) }

  Var
    lambda : extended;
  Begin
  try
    If ( abs(Gerade.nx) < eps ) and ( abs(Gerade.ny) < eps )
    then
      Begin
      result := -1;
      exit;
      end;
    lambda := ( Gerade.c - Punkt.x * Gerade.nx - Punkt.y * Gerade.ny ) /
      ( sqr(Gerade.nx) + sqr(Gerade.ny) );
    Projektionspunkt.x := Punkt.x + lambda * Gerade.nx;
    Projektionspunkt.y := Punkt.y + lambda * Gerade.ny;
    result             := 0;
  except
    result := -9999;
    end;
  end;

{ ---------------------------------------------------------------------------- }

Function Orthogonale_Projektion_Punkt_auf_Gerade_plus( Punkt : Typ_ePunkt; Gerade : Typ_eGerade;
  Var lambdaGerade : extended; Var Projektionspunkt : Typ_ePunkt ) : Integer;
  { es wird die senkrechte Projektion des Punktes "Punkt" auf die Gerade bestimmt.
    Zusätzlich wird eine Größe "lambdaGerade" herausgegeben. Mit Hilfe dieser
    Größe kann man bei zwei auf die selbe Gerade projizierten Punkte deren Abstand
    durch Differenzbildung der zugehörigen "lambdaGerade"-Werte ermitteln.
    Ebenso lassen sich die Punkte damit sortieren.

    Rückgabewerte :
       0 = Alles OK
      -1 = keine Gerade gegeben (nx=ny=0) }

  Var
    lambda   : extended;
    RefPunkt : Typ_ePunkt;
    LaengeN  : extended;
  Begin
  try
    If ( abs(Gerade.nx) < eps ) and ( abs(Gerade.ny) < eps )
    then
      Begin
      result := -1;
      exit;
      end;
    lambda := ( Gerade.c - Punkt.x * Gerade.nx - Punkt.y * Gerade.ny ) /
      ( sqr(Gerade.nx) + sqr(Gerade.ny) );
    Projektionspunkt.x := Punkt.x + lambda * Gerade.nx;
    Projektionspunkt.y := Punkt.y + lambda * Gerade.ny;
    result             := 0;
    { Referenzpunkt auf Gerade bestimmen }
    LaengeN := sqrt( sqr(Gerade.nx) + sqr(Gerade.ny) );
    If ( abs(Gerade.nx) < eps )
    then
      Begin
      RefPunkt.x := 0.0;
      Gebe_y_Koordinate( Gerade, RefPunkt.x, RefPunkt.y );
      lambdaGerade := -( Projektionspunkt.x - RefPunkt.x ) * LaengeN / Gerade.ny
      end
    else
      Begin
      RefPunkt.y := 0.0;
      Gebe_x_Koordinate( Gerade, RefPunkt.y, RefPunkt.x );
      lambdaGerade := ( Projektionspunkt.y - RefPunkt.y ) * LaengeN / Gerade.nx
      end;
  except
    result := -9999;
    end;
  end;

{ ---------------------------------------------------------------------------- }

Function Drehung_der_Gerade( UrGerade : Typ_eGerade; Drehpunkt : Typ_ePunkt;
  Drehwinkel : extended; Var BildGerade : Typ_eGerade ) : integer;
  { Die Gerade nx * x + ny * y = c wird um (x,y) um den Winkel "Drehwinkel"
    (in Bogenmaß) gedreht
    Rückgabewerte :
       0 = Alles OK
      -1 = keine Gerade gegeben (nx=ny=0) }

  Var
    cos_phi : extended;
    sin_phi : extended;
    nx2     : extended;
    ny2     : extended;
    x_a     : extended;  { Aufpunkt Urbild - Drehpunkt }
    y_a     : extended;
    x_a_neu : extended;  { Aufpunkt Bild }
    y_a_neu : extended;
  Begin
  try
    { neuen Normalenvektor }
    {
    cos_phi := cos(Drehwinkel);
    sin_phi := sin(Drehwinkel);
    }
    SinCos(Drehwinkel, Sin_phi, Cos_phi );  // 2x Schneller als Kommentar zuvor
    nx2 :=   cos_phi * UrGerade.nx - sin_phi * UrGerade.ny;
    ny2 :=   sin_phi * UrGerade.nx + cos_phi * UrGerade.ny;

    { neuer Aufpunkt }
    If abs(UrGerade.nx) < eps
    then
      If abs(UrGerade.ny) < eps
      then
        Begin
        result := -1;
        exit;
        end
      else { ny <> 0 }
        Begin
        x_a := 1.0 - Drehpunkt.x;
        y_a := ( UrGerade.c - UrGerade.nx ) / UrGerade.ny - Drehpunkt.y;
        end
    else { nx <> 0 }
      Begin
      x_a := ( UrGerade.c - UrGerade.ny ) / UrGerade.nx - Drehpunkt.x;
      y_a := 1.0 - Drehpunkt.y;
      end;

    x_a_neu :=   cos_phi * x_a - sin_phi * y_a + Drehpunkt.x;
    y_a_neu :=   sin_phi * x_a + cos_phi * y_a + Drehpunkt.y;

    { Gedrehte Gerade }
    BildGerade.nx := nx2;
    BildGerade.ny := ny2;
    BildGerade.c  := nx2 * x_a_neu + ny2 * y_a_neu;
    result        := 0;
  except
    result := -9999
    end;
  end;

{ ---------------------------------------------------------------------------- }

Function Verschiebung_der_Gerade( UrGerade : Typ_eGerade; Verschiebung : Typ_ePunkt;
  Var BildGerade : Typ_eGerade ) : integer;
  { Die Gerade nx * x + ny * y = c wird um den Vektor "Verschiebung" verschoben
    Rückgabewerte :
       0 = Alles OK
      -1 = keine Gerade gegeben (nx=ny=0)
  }
  Begin
  try
    If (abs(UrGerade.nx) < eps) and (abs(UrGerade.ny) < eps )
    then
      Begin
      result := -1;
      exit;
      end;

    { Verschobene Gerade }
    BildGerade.nx := UrGerade.nx;
    BildGerade.ny := UrGerade.ny;
    BildGerade.c  := UrGerade.c + UrGerade.nx * Verschiebung.x + UrGerade.ny * Verschiebung.y;
    result        := 0;
  except
    result := -9999
    end;
  end;

{ ---------------------------------------------------------------------------- }

Function Winkelhalbierende_zu_Winkel_durch_drei_Punkte( A, B, C : Typ_ePunkt;
  Var Winkelhalbierende : Typ_eGerade ) : Integer;
  { Es wird die Winkelhalbierende zum Winkel ABC bestimmt. B bildet
    die Spitze des Winkels.
    Rückgabewerte :
       0 = Alles OK
      -1 = kein Winkel gegeben (A = B oder C = B)  }

  Var
    BA : extended;    { Abstand B von A }
    BC : extended;    { Abstand B von C }
    HA : Typ_ePunkt;  { Hilfspunkt }
    HC : Typ_ePunkt;  { Hilfspunkt }
    MC : Typ_ePunkt;  { Mittelpunkt von HC HA }
  Begin
  try
    BA := Abstand_Punkt_von_Punkt(A, B);
    BC := Abstand_Punkt_von_Punkt(C, B);
    If ( BA < eps ) or ( BC < eps )
    then
      Begin
      result := -1;
      exit
      end;
    HA := Vektor_plus_Vektor( B, Vektor_mal_Skalar( Vektor_minus_Vektor( A, B ), 1.0 / BA ));
    HC := Vektor_plus_Vektor( B, Vektor_mal_Skalar( Vektor_minus_Vektor( C, B ), 1.0 / BC ));
    MC := Mittelpunkt( HC, HA );
    result := Gerade_durch_zwei_Punkte( B, MC, Winkelhalbierende );
  except
    result := -9999
    end;
  end;

{ ---------------------------------------------------------------------------- }

Function Richtung_der_Winkelhalbierenden_zu_Winkel_durch_drei_Punkte( A, B, C : Typ_ePunkt;
  Var Richtung : extended ) : Integer;
  { Es wird die Richtung  von B aus betrachtet der Winkelhalbierenden zum Winkel
    ABC bestimmt. B bildet die Spitze des Winkels.
    Rückgabewerte :
       0 = Alles OK
      -1 = kein Winkel gegeben (A = B oder C = B)  }

  Var
    BA : extended;    { Abstand B von A }
    BC : extended;    { Abstand B von C }
    HA : Typ_ePunkt;  { Hilfspunkt }
    HC : Typ_ePunkt;  { Hilfspunkt }
    MC : Typ_ePunkt;  { Mittelpunkt von HC C }
  Begin
  try
    BA := Abstand_Punkt_von_Punkt(A, B);
    BC := Abstand_Punkt_von_Punkt(C, B);
    If ( BA < eps ) or ( BC < eps )
    then
      Begin
      result := -1;
      exit
      end;
    HA     := Vektor_plus_Vektor( B, Vektor_mal_Skalar( Vektor_minus_Vektor( A, B ), 1.0 / BA ));
    HC     := Vektor_plus_Vektor( B, Vektor_mal_Skalar( Vektor_minus_Vektor( C, B ), 1.0 / BC ));
    MC     := Mittelpunkt( HC, HA );
    HC     := Vektor_minus_Vektor( MC, B );
    result := WinkelPolarkoordinaten( HC, Richtung );
  except
    result := -9999
    end;
  end;

{ ---------------------------------------------------------------------------- }

Function Schnitt_Gerade_Polygonzug( Gerade : Typ_eGerade; Polygonzug : Typ_Polygonzug;
  Var Schnittpunkt : Typ_ePunkt ) : Integer;
  { Berechnet den ersten Schnittpunkt der Gerade mit dem Polygonzug.
    Rückgabewerte :
      0 - alles OK
     -1 - keine Gerade
     -2 - kein Polygonzug
     -3 - kein Schnittpunkt
  }
  Var
    lv : Integer;

  Begin
  try
    If (abs(Gerade.nx) < eps) and (abs(Gerade.ny) < eps)
    then
      Begin
      result := -1;
      exit
      end;
    If Polygonzug.Anzahl < 2
    then
      Begin
      result := -2;
      exit
      end;
    lv := 0;
    Repeat
      Inc(lv);
    until (lv = Polygonzug.Anzahl) or
      (Schnitt_Gerade_Strecke( Gerade,
       Polygonzug.Punkte[ lv ], Polygonzug.Punkte[ lv + 1 ], Schnittpunkt ) = 0);
    If lv = Polygonzug.Anzahl
    then
      result := -3
    else
      result := 0
  except
    result := -9999
    end;
  end;

{ ---------------------------------------------------------------------------- }

Function Schnitt_Gerade_Polygonzug_mit_Richtung( Gerade : Typ_eGerade; Polygonzug : Typ_Polygonzug;
                            Var Schnittpunkt, Richtung : Typ_ePunkt ) : Integer;
  { Berechnet den ersten Schnittpunkt der Gerade mit dem Polygonzug. Gibt noch zusätzlich den Richtungsvektor
    des scheidenden Polgonzuges mit an.
    Rückgabewerte :
      0 - alles OK
     -1 - keine Gerade
     -2 - kein Polygonzug
     -3 - kein Schnittpunkt
  }
  Var
    lv : Integer;

  Begin
  try
    If (abs(Gerade.nx) < eps) and (abs(Gerade.ny) < eps)
    then
      Begin
      result := -1;
      exit
      end;
    If Polygonzug.Anzahl < 2
    then
      Begin
      result := -2;
      exit
      end;
    lv := 0;
    Repeat
      Inc(lv);
    until (lv = Polygonzug.Anzahl) or
      (Schnitt_Gerade_Strecke_mit_Richtung( Gerade,
       Polygonzug.Punkte[ lv ], Polygonzug.Punkte[ lv + 1 ], Schnittpunkt, Richtung ) = 0);
    If lv = Polygonzug.Anzahl
    then
      result := -3
    else
      result := 0
  except
    result := -9999
    end;
  end;


{ ---------------------------------------------------------------------------- }

Function Schnittpunkte_Gerade_Polygonzug( Gerade : Typ_eGerade;
  Polygonzug : Typ_Polygonzug; Var Schnittpunkte : Typ_Polygonzug ) : Integer;
  { Berechnet alle Schnittpunkte der Gerade mit dem Polygonzug.
    Rückgabewerte :
      0 - alles OK
     -1 - keine Gerade
     -2 - kein Polygonzug
  }
  Var
    lv  : Integer;
    lvs : Integer;

  Begin
  try
    If (abs(Gerade.nx) < eps) and (abs(Gerade.ny) < eps)
    then
      Begin
      result := -1;
      exit
      end;
    If Polygonzug.Anzahl < 2
    then
      Begin
      result := -2;
      exit
      end;
    lv                   := 1;
    Schnittpunkte.Anzahl := 1;
    While lv < Polygonzug.Anzahl do
      Begin
      If Schnitt_Gerade_Strecke( Gerade, Polygonzug.Punkte[ lv ],
        Polygonzug.Punkte[ lv + 1 ], Schnittpunkte.Punkte[ Schnittpunkte.Anzahl ] ) = 0
      then
        Inc( Schnittpunkte.Anzahl );
      Inc(lv);
      end;
    Dec( Schnittpunkte.Anzahl );
    { Bereinigen von eventuell doppelt gefundenen (benachbarten) Punkten. Z.Bsp. Schnittpunkt
      gleiher linker Punkt von Strecke 1 und rechter Punkt von Strecke 2 = identische Punkte }
    { Annahme hier kein verschlungenes Polygon, sonst erweiterte Prüfung erforderlich}
    lvs := 1;
    For lv := 2 to Schnittpunkte.Anzahl do
      Begin
      If Abstand_Punkt_von_Punkt( Schnittpunkte.Punkte[ lv - 1 ], Schnittpunkte.Punkte[ lv ] ) > eps
      then
        Begin
        Inc(lvs);
        Schnittpunkte.Punkte[ lvs ] := Schnittpunkte.Punkte[ lv  ];
        end;
      end;
    { bei Kreisförmigen Polgonzügen kann auch erster und letzter (wenn mehr als einer) nebeneinander liegen }
    If lvs > 1
    then
      If not(Abstand_Punkt_von_Punkt( Schnittpunkte.Punkte[ 1 ], Schnittpunkte.Punkte[ lvs ] ) > eps)
      then
        Dec(lvs);
    Schnittpunkte.Anzahl := lvs;
    result               := 0
  except
    result := -9999
    end;
  end;

{ ---------------------------------------------------------------------------- }

Function Polygonflaechenbewertung( Var Punkte : Array of Typ_ePunkt;
  AnzPunkte : Longint; Var Flaechenschwerpunkt : Typ_ePunkt; Var Flaeche : extended;
  Var Hauptachse1, Hauptachse2 : Typ_eGerade; Var Abstand1, Abstand2, Abstand3, Abstand4,
  Projektionsbereich1, Projektionsbereich2 : extended ) : Integer;
  { Es wird in Punkte ein geschlossener Polygonzug einer konvexen Fläche übergeben.
    Die Punkte sind geordnet und umlaufen die Fläche in mathematisch positivem Sinn.
    Falls nicht ist die ermittelte Fläche negativ.
    Der erste und der letzte gültige Punkte dürfen nicht übereinstimmen.
    Das Programm geht davon aus, dass dies nicht so ist.
    Es wird der Inhalt der durch den Polygonzug umschlossenenen Fläche ausgegeben. Die
    beiden Hauptachsen (gehen durch den Flächenschwerpunkt und stehen senkrecht aufeinander.)
    Hauptachse1 gehört zum größeren Eigenwert, Hauptachse2 gehört zum kleineren Eigenwert.
    Sowie die Abstände zum Flächenrand vom Flächenschwerpunkt entlang der Hauptachsen.
    Abstand1 = Abstand Flächenschwerpunkt Schnittpunkt Hauptachse1 mit Rand rechts oder oben
    Abstand2 = Abstand Flächenschwerpunkt Schnittpunkt Hauptachse2 mit Rand rechts oder oben
    Abstand3 = Abstand Flächenschwerpunkt Schnittpunkt Hauptachse1 mit Rand links oder unten
    Abstand4 = Abstand Flächenschwerpunkt Schnittpunkt Hauptachse2 mit Rand links oder unten.
    Projektionsbereich1 = Länge des Bereiches auf der Hauptachse 1 in den hinein alle Punkte der Kontur projiziert werden
    Projektionsbereich1 = Länge des Bereiches auf der Hauptachse 2 in den hinein alle Punkte der Kontur projiziert werden

    Rückgabewerte:

      0 - alles Ok
     -1 - zu wenig Punkte (<3)
     -2 - zu viele Punkte (>=MAXANZPOLYGONPUNKTE)
     -3 - abs(Flaeche) = 0
     -5 - Polygonzug umrundet keine konvexe Fläche ( es gibt nicht genau 2 Schnittpunkte der Hauptachsen mit Flächenrand )
     -6 - Polygonzug umrundet keine konvexe Fläche ( Schnittpunkt 0 kann es nicht geben im normierten System )
  }
  Const
    eps : extended = 1.0E-10;

  Var
    Disk         : extended;
    hExt         : extended;
    lv           : Integer;
    Polygon      : Typ_Polygonzug;
    Schnittpkte  : Typ_Polygonzug;
    TeilFlaeche  : extended;
    TrM_xx       : extended;
    TrM_yy       : extended;
    TrM_xy       : extended;
    Winkel       : extended;
    tanwkl       : extended;
    NullPkt      : Typ_ePunkt;
    HPkt         : Typ_ePunkt;
    RVekH        : Typ_ePunkt;
    ProjMin      : extended;
    ProjMax      : extended;

  Begin
  try
    If Anzpunkte < 3
    then
      Begin
      result := -1;
      exit
      end;
    If Anzpunkte >= MAXANZPOLYGONPUNKTE
    then
      Begin
      result := -2;
      exit
      end;
    Polygon.Anzahl := Anzpunkte + 1;
    For lv := 1 to Anzpunkte do
      Polygon.Punkte[ lv ] := Punkte[ lv - 1 ];
    Polygon.Punkte[ Polygon.Anzahl ] := Polygon.Punkte[ 1 ];

    { Schwerpunkt und Fläche bestimmen }
    Flaeche               := 0;
    Flaechenschwerpunkt.x := 0;
    Flaechenschwerpunkt.y := 0;
    For lv := 2 to Polygon.Anzahl do
      Begin
      Teilflaeche := ( Polygon.Punkte[ lv - 1 ].x * Polygon.Punkte[ lv ].y -
        Polygon.Punkte[ lv ].x * Polygon.Punkte[lv - 1 ].y ) / 2;
      Flaeche               := Flaeche + Teilflaeche;
      Flaechenschwerpunkt.x := Flaechenschwerpunkt.x + Teilflaeche * ( Polygon.Punkte[ lv - 1 ].x + Polygon.Punkte[ lv ].x )/3.0;
      Flaechenschwerpunkt.y := Flaechenschwerpunkt.y + Teilflaeche * ( Polygon.Punkte[ lv - 1 ].y + Polygon.Punkte[ lv ].y )/3.0;
      end;
    If abs(Flaeche) < eps
    then
      Begin
      result := -3;
      exit
      end;
    Flaechenschwerpunkt.x := Flaechenschwerpunkt.x / Flaeche;
    Flaechenschwerpunkt.y := Flaechenschwerpunkt.y / Flaeche;

    { Punkte um Schwerpunkt-Abstand so verschieben, dass Flächenschwerpunkt im Ursprung liegt }
    For lv := 1 to Polygon.Anzahl do
      Begin
      Polygon.Punkte[ lv ].x := Polygon.Punkte[ lv ].x - Flaechenschwerpunkt.x;
      Polygon.Punkte[ lv ].y := Polygon.Punkte[ lv ].y - Flaechenschwerpunkt.y;
      end;

    { Hauptachsen bestimmen, im KOO-System mit Schwerpunkt als Nullpunkt bestimmen }
    TrM_xx := 0;
    TrM_yy := 0;
    TrM_xy := 0;
    For lv := 2 to Polygon.Anzahl do
      Begin
      Teilflaeche := ( Polygon.Punkte[ lv - 1 ].x * Polygon.Punkte[ lv ].y -
        Polygon.Punkte[ lv ].x * Polygon.Punkte[lv - 1 ].y ) / 2;
      TrM_xx := TrM_xx + Teilflaeche * (   Polygon.Punkte[ lv - 1 ].y * Polygon.Punkte[ lv - 1 ].y
                                         + Polygon.Punkte[ lv ].y     * Polygon.Punkte[ lv - 1 ].y
                                         + Polygon.Punkte[ lv ].y     * Polygon.Punkte[ lv ].y
                                        ) / 6.0;
      TrM_yy := TrM_yy + Teilflaeche * (   Polygon.Punkte[ lv - 1 ].x * Polygon.Punkte[ lv - 1 ].x
                                         + Polygon.Punkte[ lv ].x     * Polygon.Punkte[ lv - 1 ].x
                                         + Polygon.Punkte[ lv ].x     * Polygon.Punkte[ lv ].x
                                       ) / 6.0;
      TrM_xy := TrM_xy + Teilflaeche * (   Polygon.Punkte[ lv ].x     * Polygon.Punkte[ lv - 1 ].y
                                     + 2 * Polygon.Punkte[ lv - 1 ].x * Polygon.Punkte[ lv - 1 ].y
                                     + 2 * Polygon.Punkte[ lv ].x     * Polygon.Punkte[ lv ].y
                                         + Polygon.Punkte[ lv - 1 ].x * Polygon.Punkte[ lv ].y
                                     ) / 12.0;
      end;

    { numerisches Problem beseitigen }
    hExt := abs(TrM_xx);
    If hExt < abs(TrM_yy)
    then
      hExt := abs(TrM_yy);
    If hExt < abs(TrM_xy)
    then
      hExt := abs(TrM_xy);
    hExt := hExt * sign( TrM_xx );
    TrM_xx := TrM_xx / hExt;
    TrM_yy := TrM_yy / hExt;
    TrM_xy := TrM_xy / hExt;

    { Eigenwert/-vektor berechnung }
    { Fall 1: TrM_xy ist bereits 0 }
    If abs( TrM_xy ) < eps
    then { Nebendiagonalelemente = 0 }
      Begin
      If TrM_xx >= TrM_yy
      then { alpha = 0 }
        Begin
        Hauptachse1.nx :=  0.0;
        Hauptachse1.ny := -1.0;
        Hauptachse1.c  :=  0.0;
        Hauptachse2.nx :=  1.0;
        Hauptachse2.ny :=  0.0;
        Hauptachse2.c  :=  0.0;
        end
      else { alpha = pi/2 }
        Begin
        Hauptachse1.nx :=  1.0;
        Hauptachse1.ny :=  0.0;
        Hauptachse1.c  :=  0.0;
        Hauptachse2.nx :=  0.0;
        Hauptachse2.ny :=  1.0;
        Hauptachse2.c  :=  0.0;
        end
      end
    else { Nebendiagonalelemente sind nicht 0 --> verdreht }
      Begin
      NullPkt.x := 0.0;
      NullPkt.y := 0.0;
      tanwkl    := ( -( TrM_xx - TrM_yy ) + sqrt( sqr( TrM_xx - TrM_yy ) + 4.0 * sqr(TrM_xy) ) ) / ( 2 * TrM_xy );
      Winkel    := - arctan( tanwkl );
      SinCos(Winkel, HPkt.y, HPkt.x);
      Gerade_durch_zwei_Punkte( NullPkt, HPkt, Hauptachse1 );

      Disk   := HPkt.x;
      HPkt.x := - HPkt.y;
      HPkt.y := Disk;
      Gerade_durch_zwei_Punkte( NullPkt, HPkt, Hauptachse2 );
      end;

    { restliche Ausgabegrößen bestimmen }
    Schnittpunkte_Gerade_Polygonzug( Hauptachse1, Polygon, Schnittpkte );
    If Schnittpkte.Anzahl <> 2
    then
      Begin
      result := -5;
      exit
      end;
    If WinkelPolarkoordinaten( Schnittpkte.Punkte[ 1 ], Winkel ) < 0
    then
      Begin
      result := -6;
      exit
      end;
    If (pi/2 < Winkel) and (Winkel <= (3* pi/2))
    then { Punkt1 ist links oder unten }
      Begin
      Abstand3 := EuklidscheNorm( Schnittpkte.Punkte[ 1 ] );
      Abstand1 := EuklidscheNorm( Schnittpkte.Punkte[ 2 ] );
      end
    else { Punkt1 ist rechts oder oben }
      Begin
      Abstand1 := EuklidscheNorm( Schnittpkte.Punkte[ 1 ] );
      Abstand3 := EuklidscheNorm( Schnittpkte.Punkte[ 2 ] );
      end;

    Schnittpunkte_Gerade_Polygonzug( Hauptachse2, Polygon, Schnittpkte );
    If Schnittpkte.Anzahl <> 2
    then
      Begin
      result := -5;
      exit
      end;
    If WinkelPolarkoordinaten( Schnittpkte.Punkte[ 1 ], Winkel ) < 0
    then
      Begin
      result := -6;
      exit
      end;
    If (pi/2 < Winkel) and (Winkel <= (3* pi/2))
    then { Punkt1 ist links oder unten }
      Begin
      Abstand4 := EuklidscheNorm( Schnittpkte.Punkte[ 1 ] );
      Abstand2 := EuklidscheNorm( Schnittpkte.Punkte[ 2 ] );
      end
    else { Punkt1 ist rechts oder oben }
      Begin
      Abstand2 := EuklidscheNorm( Schnittpkte.Punkte[ 1 ] );
      Abstand4 := EuklidscheNorm( Schnittpkte.Punkte[ 2 ] );
      end;

    { Projektionen auf Hauptachse 1 bestimmen }
    { normierten Richtungsvektor zur Hauptachse 1 bestimmen }
    RVekH.x := - Hauptachse1.ny;
    RVekH.y :=   Hauptachse1.nx;
    RVekH   := Normierter_Vektor( RVekH );

    { Projektionsabstände zum Schwerpunkt bestimmen }
    ProjMin := 10000000;
    ProjMax := - ProjMin;

    For lv := 1 to Polygon.Anzahl do
      Begin
      hExt := Skalarprodukt( RVekH, Polygon.Punkte[ lv ] ); { reicht, da Punkte so verschoben, dass Schwerpunkt = Ursprung }
      If ProjMin > hExt
      then
        ProjMin := hExt;
      If ProjMax < hExt
      then
        ProjMax := hExt;
      end;

    Projektionsbereich1 := ProjMax - ProjMin;

    { Projektionen auf Hauptachse 2 bestimmen }
    { normierten Richtungsvektor zur Hauptachse 1 bestimmen }
    RVekH.x := - Hauptachse2.ny;
    RVekH.y :=   Hauptachse2.nx;
    RVekH   := Normierter_Vektor( RVekH );

    { Projektionsabstände zum Schwerpunkt bestimmen }
    ProjMin := 10000000;
    ProjMax := - ProjMin;

    For lv := 1 to Polygon.Anzahl do
      Begin
      hExt := Skalarprodukt( RVekH, Polygon.Punkte[ lv ] ); { reicht, da Punkte so verschoben, dass Schwerpunkt = Ursprung }
      If ProjMin > hExt
      then
        ProjMin := hExt;
      If ProjMax < hExt
      then
        ProjMax := hExt;
      end;

    Projektionsbereich2 := ProjMax - ProjMin;

    { Hauptachsen in den Schwerpunkt verschieben }
    Parallele_Gerade_durch_Punkt( Hauptachse1, Flaechenschwerpunkt, Hauptachse1 );
    Parallele_Gerade_durch_Punkt( Hauptachse2, Flaechenschwerpunkt, Hauptachse2 );

    result := 0;
  except
    result := -9999
    end;
  end;

{ ---------------------------------------------------------------------------- }


Function Schnittpunkte_Gerade_Ellipse( Gerade : Typ_eGerade;
  Ellipse : Typ_eEllipse; Var AnzahlSchnittpunkte : Integer; Var SP1, SP2 : Typ_ePunkt ) : Integer;
  { Die Funktion liefert die Anzahl der Schnittpunkte und die Koordinaten der Schnittpunkte
    beim Schnitt Gerade mit Ellipse.
    Es sind drei Konstellationen möglich:
    a) kein Schnittpunkt
    b) ein Schnittpunkt (Tangente)  [ nur SP1 befüllt ]
    c) zwei Schnittpunkte

    Rückgabewerte:
      0 : Alles Ok
     -1 : Keine Gerade gegeben
     -2 : x-Hauptachse der Ellipse <= 0
     -3 : y-Hauptachse der Ellipse <= 0
  }
  Var
    SchubGerade : Typ_eGerade;
    Drehpunkt   : Typ_ePunkt;
    DrehGerade  : Typ_eGerade;
    A           : extended;
    B           : extended;
    C           : extended;
    Disk        : extended;
    Drehung     : TYP_2Affine_Abbildung;
    SP1_N       : Typ_ePunkt;
    SP2_N       : Typ_ePunkt;

  Begin
  try
    If (abs(Gerade.nx) < eps) and (abs(Gerade.ny) < eps)
    then
      Begin
      result := -1;
      exit
      end;
    If Ellipse.Radius_x < eps
    then
      Begin
      result := -2;
      exit
      end;
    If Ellipse.Radius_y < eps
    then
      Begin
      result := -3;
      exit
      end;
    { Gerade ins normierte Koordinatensystem verschieben }
    Verschiebung_der_Gerade( Gerade, Vektor_mal_Skalar(Ellipse.Mittelpunkt, -1), SchubGerade );

    { Gerade ins normierte Koordinatensystem drehen }
    Drehpunkt.x := 0.0;
    Drehpunkt.y := 0.0;
    Drehung_der_Gerade( SchubGerade, Drehpunkt, - Ellipse.Drehwinkel, DrehGerade );

    { Schnittpunkte im normierten Koordinatensystem errechnen }
    A := sqr(DrehGerade.nx * Ellipse.Radius_x) + sqr(DrehGerade.ny * Ellipse.Radius_y);
    If abs(DrehGerade.nx) < eps
    then { ny <> 0 }
      Begin
      B := - 2.0 * DrehGerade.nx * DrehGerade.c * sqr( Ellipse.Radius_x );
      C := sqr( Ellipse.Radius_x ) * ( sqr( Drehgerade.c ) - sqr( Drehgerade.ny * Ellipse.Radius_y ) )
      end
    else { nx <> 0 }
      Begin
      B := - 2.0 * DrehGerade.ny * DrehGerade.c * sqr( Ellipse.Radius_y );
      C := sqr( Ellipse.Radius_y ) * ( sqr( Drehgerade.c ) - sqr( Drehgerade.nx * Ellipse.Radius_x ) )
      end;
    Disk := B * B - 4.0 * A * C;
    If abs(Disk) < eps
    then { es gibt nur einen Punkt }
      Begin
      AnzahlSchnittpunkte := 1;
      If abs(DrehGerade.nx) < eps
      then { ny <> 0 }
        Begin
        SP1_N.x := - B / ( 2.0 * A );
        Gebe_y_Koordinate( DrehGerade, SP1_N.x, SP1_N.y )
        end
      else { nx <> 0 }
        Begin
        SP1_N.y := - B / ( 2.0 * A );
        Gebe_x_Koordinate( DrehGerade, SP1_N.y, SP1_N.x )
        end
      end
    else
      If Disk > eps
      then { es gibt zwei Schnittpunkte }
        Begin
        AnzahlSchnittpunkte := 2;
        If abs(DrehGerade.nx) < eps
        then { ny <> 0 }
          Begin
          SP1_N.x := ( - B + sqrt(Disk) ) / ( 2.0 * A );
          Gebe_y_Koordinate( DrehGerade, SP1_N.x, SP1_N.y );
          SP2_N.x := ( - B - sqrt(Disk) ) / ( 2.0 * A );
          Gebe_y_Koordinate( DrehGerade, SP2_N.x, SP2_N.y )
          end
        else { nx <> 0 }
          Begin
          SP1_N.y := ( - B + sqrt(Disk) ) / ( 2.0 * A );
          Gebe_x_Koordinate( DrehGerade, SP1_N.y, SP1_N.x );
          SP2_N.y := ( - B - sqrt(Disk) ) / ( 2.0 * A );
          Gebe_x_Koordinate( DrehGerade, SP2_N.y, SP2_N.x )
          end
        end
      else { es gibt keine Schnittpunkte }
        Begin
        AnzahlSchnittpunkte := 0;
        end;

    { Schnittpunkte in Originalkoordinaten transformieren }
    Drehung := Bestimme_Drehung( Drehpunkt, Ellipse.Drehwinkel );
    Case AnzahlSchnittpunkte of
      2 :
        Begin
        SP1 := Affine_Abbildung_anwenden( Drehung, SP1_N );
        SP1 := Vektor_plus_Vektor( SP1, Ellipse.Mittelpunkt );
        SP2 := Affine_Abbildung_anwenden( Drehung, SP2_N );
        SP2 := Vektor_plus_Vektor( SP2, Ellipse.Mittelpunkt );
        end;
      1 :
        Begin
        SP1 := Affine_Abbildung_anwenden( Drehung, SP1_N );
        SP1 := Vektor_plus_Vektor( SP1, Ellipse.Mittelpunkt );
        SP2 := SP1;
        end;
      0 :
      end; { of case }
    result := 0
  except
    result := -9999
    end;
  end;

{ ---------------------------------------------------------------------------- }

Function Schnittpunkte_yParallele_Ellipse( xWert : extended;
  Ellipse : Typ_eEllipse; Var AnzahlSchnittpunkte : Integer; Var SP1, SP2 : Typ_ePunkt ) : Integer;
  { es werden die Schnittpunkte einer zur y-Achse parallelen Gerade (x = xWert = Const)
    mit der Ellipse ausgegeben.
    Rückgabewerte:
      0 : Alles Ok
     -2 : x-Hauptachse der Ellipse <= 0
     -3 : y-Hauptachse der Ellipse <= 0
  }
  Var
    Gerade : Typ_eGerade;
  Begin
  Gerade.nx := 1.0;
  Gerade.ny := 0.0;
  Gerade.c  := xWert;
  result    := Schnittpunkte_Gerade_Ellipse( Gerade, Ellipse, AnzahlSchnittpunkte, SP1, SP2 )
  end;

{ ---------------------------------------------------------------------------- }

Function Schnittpunkte_xParallele_Ellipse( yWert : extended;
  Ellipse : Typ_eEllipse; Var AnzahlSchnittpunkte : Integer; Var SP1, SP2 : Typ_ePunkt ) : Integer;
  { es werden die Schnittpunkte einer zur x-Achse parallelen Gerade (y = yWert = Const)
    mit der Ellipse ausgegeben.
    Rückgabewerte:
      0 : Alles Ok
     -2 : x-Hauptachse der Ellipse <= 0
     -3 : y-Hauptachse der Ellipse <= 0
  }
  Var
    Gerade : Typ_eGerade;
  Begin
  Gerade.nx := 0.0;
  Gerade.ny := 1.0;
  Gerade.c  := yWert;
  result    := Schnittpunkte_Gerade_Ellipse( Gerade, Ellipse, AnzahlSchnittpunkte, SP1, SP2 )
  end;

{ ---------------------------------------------------------------------------- }

Function Schnittpunkte_Gerade_Kreis( Gerade : Typ_eGerade;
  Kreis : Typ_eKreis; Var AnzahlSchnittpunkte : Integer; Var SP1, SP2 : Typ_ePunkt ) : Integer;
  { Die Funktion liefert die Anzahl der Schnittpunkte und die Koordinaten der Schnittpunkte
    beim Schnitt Gerade mit Kreis.
    Es sind drei Konstellationen möglich:
    a) kein Schnittpunkt
    b) ein Schnittpunkt (Tangente)  [ nur SP1 befüllt ]
    c) zwei Schnittpunkte

    Rückgabewerte:
      0 : Alles Ok
     -1 : Keine Gerade gegeben
     -2 : Radius <= 0
  }
  Var
    Ellipse : Typ_eEllipse;

  Begin
  try
    If (abs(Gerade.nx) < eps) and (abs(Gerade.ny) < eps)
    then
      Begin
      result := -1;
      exit
      end;
    If Kreis.Radius < eps
    then
      Begin
      result := -2;
      exit
      end;
    Ellipse.Mittelpunkt := Kreis.Mittelpunkt;
    Ellipse.Radius_x    := Kreis.Radius;
    Ellipse.Radius_y    := Kreis.Radius;
    Ellipse.Drehwinkel  := 0.0;
    Schnittpunkte_Gerade_Ellipse( Gerade, Ellipse, AnzahlSchnittpunkte, SP1, SP2 );
    result := 0
  except
    result := -9999
    end;
  end;

{ ---------------------------------------------------------------------------- }

Function Schnittpunkte_xParallele_Kreis( yWert : extended;
  Kreis : Typ_eKreis; Var AnzahlSchnittpunkte : Integer; Var SP1, SP2 : Typ_ePunkt ) : Integer;
  { es werden die Schnittpunkte einer zur x-Achse parallelen Gerade (y = yWert = Const)
    mit dem Kreis ausgegeben.
    Rückgabewerte:
      0 : Alles Ok
     -2 : Radius <= 0
  }
  Var
    Gerade : Typ_eGerade;
  Begin
  Gerade.nx := 0.0;
  Gerade.ny := 1.0;
  Gerade.c  := yWert;
  result    := Schnittpunkte_Gerade_Kreis( Gerade, Kreis, AnzahlSchnittpunkte, SP1, SP2 )
  end;

{ ---------------------------------------------------------------------------- }

Function Schnittpunkte_yParallele_Kreis( xWert : extended;
  Kreis : Typ_eKreis; Var AnzahlSchnittpunkte : Integer; Var SP1, SP2 : Typ_ePunkt ) : Integer;
  { es werden die Schnittpunkte einer zur y-Achse parallelen Gerade (x = xWert = Const)
    mit dem Kreis ausgegeben.
    Rückgabewerte:
      0 : Alles Ok
     -2 : Radius <= 0
  }
  Var
    Gerade : Typ_eGerade;
  Begin
  Gerade.nx := 1.0;
  Gerade.ny := 0.0;
  Gerade.c  := xWert;
  result    := Schnittpunkte_Gerade_Kreis( Gerade, Kreis, AnzahlSchnittpunkte, SP1, SP2 )
  end;

{ ---------------------------------------------------------------------------- }

Function Schnittpunkte_Kreis_mit_Kreis( Kreis1, Kreis2 : Typ_eKreis;
  Var AnzahlSchnittpunkte : Integer; Var SP1, SP2 : Typ_ePunkt ) : Integer;
  { es werden die Schnittpunkte zwischen zwei Kreisen bestimmt

    Rückgabewerte:
      0  : Alles Ok
     -1  : Radius1 <= 0
     -2  : Radius2 <= 0
     -1x : Fehler x aus Schnitt Gerade Kreis

  }
  Var
    Gerade : Typ_eGerade;
    res    : Integer;

  Begin
  AnzahlSchnittpunkte := 0;
  try
    If Kreis1.Radius < eps
    then
      Begin
      result := -1;
      exit
      end;
    If Kreis2.Radius < eps
    then
      Begin
      result := -2;
      exit
      end;
    Gerade.nx := 2.0 * ( Kreis2.Mittelpunkt.x - Kreis1.Mittelpunkt.x );
    Gerade.ny := 2.0 * ( Kreis2.Mittelpunkt.y - Kreis1.Mittelpunkt.y );
    Gerade.c  := sqr(Kreis2.Mittelpunkt.x) + sqr(Kreis2.Mittelpunkt.y) - sqr(Kreis2.Radius)
      - sqr(Kreis1.Mittelpunkt.x) - sqr(Kreis1.Mittelpunkt.y) + sqr(Kreis1.Radius);
    res       := Schnittpunkte_Gerade_Kreis( Gerade, Kreis1, AnzahlSchnittpunkte, SP1, SP2 );
    If res >= 0
    then
      result := res
    else
      result := res - 10
  except
    result := -9999
    end;
  end;

{ ---------------------------------------------------------------------------- }
Function Matrix_plus_Matrix( A, B : TYP_2Matrix ) : TYP_2Matrix;
  { Berechnet A + B }
  Begin
  result.xx := A.xx + B.xx;
  result.xy := A.xy + B.xy;
  result.yx := A.yx + B.yx;
  result.yy := A.yy + B.yy;
  end;

{ ---------------------------------------------------------------------------- }

Function Matrix_minus_Matrix( A, B : TYP_2Matrix ) : TYP_2Matrix;
  { Berechnet A - B }
  Begin
  result.xx := A.xx - B.xx;
  result.xy := A.xy - B.xy;
  result.yx := A.yx - B.yx;
  result.yy := A.yy - B.yy;
  end;

{ ---------------------------------------------------------------------------- }

Function Matrix_mal_Matrix( A, B : TYP_2Matrix ) : TYP_2Matrix;
  { Berechnet A * B,
    man beachte im allgemeinen ist A * B <> B * A !!!! }
  Var
    matrix : TYP_2Matrix;
  Begin
  matrix.xx := A.xx * B.xx + A.xy * B.yx;
  matrix.xy := A.xx * B.xy + A.xy * B.yy;
  matrix.yx := A.yx * B.xx + A.yy * B.yx;
  matrix.yy := A.yx * B.xy + A.yy * B.yy;
  result    := matrix;
  end;

{ ---------------------------------------------------------------------------- }

Function Matrix_mal_Vektor( A : TYP_2Matrix; P : TYP_ePunkt ) : TYP_ePunkt;
  { berechnet A * P }
  Var
    vektor : Typ_ePunkt;
  Begin
  vektor.x := A.xx * P.x + A.xy * P.y;
  vektor.y := A.yx * P.x + A.yy * P.y;
  result   := vektor;
  end;

{ ---------------------------------------------------------------------------- }

Function Matrix_mal_Skalar( A : TYP_2Matrix; S : extended ) : TYP_2Matrix;
  { berechnet A * S }
  Begin
  result.xx := A.xx * S;
  result.xy := A.xy * S;
  result.yx := A.yx * S;
  result.yy := A.yy * S;
  end;

{ ---------------------------------------------------------------------------- }

Function Vektor_plus_Vektor( P, Q : TYP_ePunkt ) : TYP_ePunkt;
  { Berechnet P + Q }
  Begin
  result.x := P.x + Q.x;
  result.y := P.y + Q.y;
  end;

{ ---------------------------------------------------------------------------- }

Function Vektor_minus_Vektor( P, Q : TYP_ePunkt ) : TYP_ePunkt;
  { Berechnet P - Q }
  Begin
  result.x := P.x - Q.x;
  result.y := P.y - Q.y;
  end;

{ ---------------------------------------------------------------------------- }

Function Vektor_mal_Skalar( P : TYP_ePunkt; S : extended ) : TYP_ePunkt;
  { Berechnet P * S }
  Begin
  result.x := P.x * S;
  result.y := P.y * S;
  end;

{ ---------------------------------------------------------------------------- }

Function Determinante( A : TYP_2Matrix ) : extended;
  { Berechnet die Determinante von A }
  Begin
  result := A.xx * A.yy - A.xy * A.yx;
  end;

{ ---------------------------------------------------------------------------- }

Function Inverse_Matrix( A : TYP_2Matrix; Var Inv_A : TYP_2Matrix ) : integer;
  { Berechnet die inverse Matrix zu A sofern möglich
    Returncode :
     0 - alles ok
    -1 - A ist singulär
  }
  Var
    Det_A : extended;
  Begin
  Det_A := Determinante( A );
  If abs( Det_A ) < eps
  then
    Begin
    Result := -1;
    exit
    end;
  { Inverse Matrix bestimmen }
  Inv_A.xx := A.yy;
  Inv_A.xy := - A.xy;
  Inv_A.yx := - A.yx;
  Inv_A.yy := A.xx;
  Inv_A    := Matrix_mal_Skalar( Inv_A, 1.0 / Det_A );
  { Returnwert setzen }
  result   := 0;
  end;

{ ---------------------------------------------------------------------------- }

Function Affine_Abbildung_aus_Bild_und_Urbild( U1, U2, U3, B1, B2, B3 : TYP_ePunkt;
  Var Affine_Abbildung : TYP_2Affine_Abbildung ) : integer;
  { bestimmt eine Affine Abbildung, die jeweils U1 auf B1, U2 auf B2 und U3 auf B3
    abbildet. Damit sich eine Koordinatentransformation ergibt, dürfen Urbilder
    und Bilder nicht auf einer Geraden liegen.
    Returncode:
     0 - alles OK
    -1 - Urbilder liegen auf einer Geraden
    -2 - Bilder liegen auf einer Geraden
  }
  Var
    UMat     : TYP_2Matrix;  { Matrix aus den Urbildern }
    BMat     : TYP_2Matrix;  { Matrix aus den Bildern }
    Inv_UMat : TYP_2Matrix;  { inverse Matrix aus den Urbildern }

  Begin
  { Urbildmatrix belegen }
  UMat.xx := U2.x - U1.x;
  UMat.xy := U3.x - U1.x;
  UMat.yx := U2.y - U1.y;
  UMat.yy := U3.y - U1.y;

  { Inverse Urbild-Matrix bestimmen }
  If Inverse_Matrix( UMat, Inv_UMat ) <> 0
  then
    Begin
    result := -1;
    exit
    end;

  { Bildmatrix belegen }
  BMat.xx := B2.x - B1.x;
  BMat.xy := B3.x - B1.x;
  BMat.yx := B2.y - B1.y;
  BMat.yy := B3.y - B1.y;

  { Bildmatrix muß ebenfalls regulär sein, sonst gibt es zwar eine Abbildung,
    aber keine Koordinatentransformation !!! }
  If abs(Determinante(BMat)) < eps
  then
    Begin
    result := -2;
    exit
    end;

  { Bestimmung der affinen Abbildung }
  Affine_Abbildung.Lineare_Abbildung := Matrix_mal_Matrix( BMat, Inv_UMat );
  Affine_Abbildung.Verschiebung      := Vektor_minus_Vektor( B1,
    Matrix_mal_Vektor( Affine_Abbildung.Lineare_Abbildung, U1 ) );

  { Rückgabewert füllen }
  result := 0
  end;

{ ---------------------------------------------------------------------------- }

Function Affine_Abbildung_anwenden( Affine_Abbildung : TYP_2Affine_Abbildung;
  P : TYP_ePunkt ) : TYP_ePunkt;
  { berechnet y = Affine_Abbildung(P) = Lineare_Abbildung * P + Verschiebung }
  Begin
  result := Vektor_plus_Vektor(
    Matrix_mal_Vektor( Affine_Abbildung.Lineare_Abbildung, P ),
    Affine_Abbildung.Verschiebung )
  end;

{ ---------------------------------------------------------------------------- }

Function Orthogonale_Affine_Abbildung_mit_Faktor_aus_Bild_und_Urbild
  ( U1, U2, U3, B1, B2, B3 : TYP_ePunkt; Faktor : extended;
    Var Affine_Abbildung : TYP_2Affine_Abbildung ) : integer;
  { bestimmt eine Affine Abbildung A * x + q so, daß
    die Spalten von A senkrecht zueinander stehen und ein festes Längenverhältnis zueinander haben.
    Die erste Spalte ist um Faktor-fach länger als die zweite Spalte. Die Werte werden so bestimmt,
    daß U1 auf B1, U2 auf B2 und U3 auf B3 möglichst gut abgebildet werden.
    Returncode:
     0 - alles OK
    -1 - Urbilder liegen auf einer Geraden
  }
  Var
    bx     : Extended;  { Mittelwert über alle Bild-x Koordinaten }
    by     : Extended;
    ux     : Extended;  { Mittelwert über alle UrBild-x Koordinaten }
    uy     : Extended;
    ux_ux  : Extended;  { Varianz über alle UrBild-x Koordinaten }
    uy_uy  : Extended;
    ux_bx  : Extended;  { Kovarianz über UrBild-x Bild-x Koordinaten }
    ux_by  : Extended;
    uy_bx  : Extended;
    uy_by  : Extended;
    dux    : Extended;
    duy    : Extended;
    dbx    : Extended;
    dby    : Extended;
    nenner : Extended;
    a      : Extended;
    b      : Extended;

  Begin
  bx    := ( B1.x + B2.x + B3.x ) / 3;
  by    := ( B1.y + B2.y + B3.y ) / 3;
  ux    := ( U1.x + U2.x + U3.x ) / 3;
  uy    := ( U1.y + U2.y + U3.y ) / 3;
  ux_ux := 0.0;
  uy_uy := 0.0;
  ux_bx := 0.0;
  ux_by := 0.0;
  uy_bx := 0.0;
  uy_by := 0.0;
  dux   := U1.x - ux;
  duy   := U1.y - uy;
  dbx   := B1.x - bx;
  dby   := B1.y - by;
  ux_ux := ux_ux + dux * dux;
  uy_uy := uy_uy + duy * duy;
  ux_bx := ux_bx + dux * dbx;
  ux_by := ux_by + dux * dby;
  uy_bx := uy_bx + duy * dbx;
  uy_by := uy_by + duy * dby;
  dux   := U2.x - ux;
  duy   := U2.y - uy;
  dbx   := B2.x - bx;
  dby   := B2.y - by;
  ux_ux := ux_ux + dux * dux;
  uy_uy := uy_uy + duy * duy;
  ux_bx := ux_bx + dux * dbx;
  ux_by := ux_by + dux * dby;
  uy_bx := uy_bx + duy * dbx;
  uy_by := uy_by + duy * dby;
  dux   := U3.x - ux;
  duy   := U3.y - uy;
  dbx   := B3.x - bx;
  dby   := B3.y - by;
  ux_ux := ux_ux + dux * dux;
  uy_uy := uy_uy + duy * duy;
  ux_bx := ux_bx + dux * dbx;
  ux_by := ux_by + dux * dby;
  uy_bx := uy_bx + duy * dbx;
  uy_by := uy_by + duy * dby;
  ux_ux := ux_ux / 3.0;
  uy_uy := uy_uy / 3.0;
  ux_bx := ux_bx / 3.0;
  ux_by := ux_by / 3.0;
  uy_bx := uy_bx / 3.0;
  uy_by := uy_by / 3.0;

  { Bestimmung der Parameter a und b }
  Nenner := Faktor * Faktor * ux_ux + uy_uy;
  If abs(Nenner) < eps
  then
    Begin
    result := -1;
    exit
    end;
  a := ( Faktor * ux_bx + uy_by ) / Nenner;
  b := ( Faktor * ux_by - uy_bx ) / Nenner;

  { Bestimmung der affinen Abbildung }
  Affine_Abbildung.Lineare_Abbildung.xx := Faktor * a;
  Affine_Abbildung.Lineare_Abbildung.xy := - b;
  Affine_Abbildung.Lineare_Abbildung.yx := Faktor * b;
  Affine_Abbildung.Lineare_Abbildung.yy := a;
  Affine_Abbildung.Verschiebung.x       := bx - Faktor * a * ux + b * uy;
  Affine_Abbildung.Verschiebung.y       := by - Faktor * b * ux - a * uy;

  { Rückgabewert füllen }
  result := 0
  end;

{ ---------------------------------------------------------------------------- }

Function Bestimme_Drehung( Drehpunkt : Typ_ePunkt; Drehwinkel : extended ) : TYP_2Affine_Abbildung;
  { Bestimmt die affine Abbildung, welches die Drehung um einen Drehpunkt mit einem
    Drehwinkel beschreibt }
  Var
    Sin_phi : extended;
    Cos_phi : extended;
    Matrix  : TYP_2Matrix;
    Vektor  : Typ_ePunkt;
  Begin
  SinCos(Drehwinkel, Sin_phi, Cos_phi );  // 2x Schneller als Kommentar zuvor
  Matrix.xx :=   Cos_phi;
  Matrix.xy := - Sin_phi;
  Matrix.yx :=   Sin_phi;
  Matrix.yy :=   Cos_phi;
  Vektor    := Vektor_Minus_Vektor( Drehpunkt, Matrix_Mal_Vektor( Matrix, Drehpunkt ) );
  result.Lineare_Abbildung := Matrix;
  result.Verschiebung      := Vektor;
  end;

{ ---------------------------------------------------------------------------- }

Function Umkreis_Radius( P1, P2, P3 : Typ_ePunkt; Var Radius : extended ) : integer;
  { Berechnet den Radius zum Kreis der durch die drei Punkte geht. Dies geht nur, wenn
    die drei Punkte ein Dreieck bilden.
    Returncode :
     0 - Alles Ok
    -1 - Drei Punkte bilden kein Dreieck
   }
  Var
    DiffP1P2 : Typ_ePunkt;
    DiffP2P3 : Typ_ePunkt;
    DiffP3P1 : Typ_ePunkt;
    Nenner   : extended;
    Zaehler  : extended;
  Begin
  Try
    DiffP1P2 := Vektor_minus_Vektor( P1, P2 );
    DiffP2P3 := Vektor_minus_Vektor( P2, P3 );
    DiffP3P1 := Vektor_minus_Vektor( P3, P1 );
    Zaehler  := EuklidscheNorm( DiffP1P2 ) * EuklidscheNorm( DiffP2P3 ) *
      EuklidscheNorm( DiffP3P1 );
    Nenner   := P1.x * DiffP2P3.y + P2.x * DiffP3P1.y + P3.x * DiffP1P2.y;
    If abs( Nenner ) < eps
    then
      Begin
      result := -1;
      exit
      end;
    Radius   := Zaehler / ( 2.0 * abs( Nenner ) );
    result   := 0
  except
    result := -9999;
    end;
  end;

{ ---------------------------------------------------------------------------- }

Function Umkreis_Mittelpunkt( P1, P2, P3 : Typ_ePunkt; Var Mittelpunkt : Typ_ePunkt ) : integer;
  { Berechnet den Mittelpunkt zum Kreis der durch die drei Punkte geht. Dies geht nur, wenn
    die drei Punkte ein Dreieck bilden.
    Returncode :
     0 - Alles Ok
    -1 - Mittelsenkrechte zu P1P2 konnte nicht gebildet werden -> kein Dreieck
    -2 - Mittelsenkrechte zu P1P3 konnte nicht gebildet werden -> kein Dreieck
    -3 - Schnittpunkt konnte nicht gefunden werden
   }
  Var
    MittelsenkrechteP1P2 : Typ_eGerade;
    MittelsenkrechteP1P3 : Typ_eGerade;
  Begin
  Try
    If Mittelsenkrechte_einer_Strecke( P1, P2, MittelsenkrechteP1P2 ) <> 0
    then
      Begin
      result := -1;
      exit
      end;
    If Mittelsenkrechte_einer_Strecke( P1, P3, MittelsenkrechteP1P3 ) <> 0
    then
      Begin
      result := -2;
      exit
      end;
    If Schnittpunkt_Zweier_Geraden( MittelsenkrechteP1P2, MittelsenkrechteP1P3,
      Mittelpunkt )<> 0
    then
      Begin
      result := -3;
      exit
      end;
    result   := 0
  except
    result := -9999;
    end;
  end;

{ ---------------------------------------------------------------------------- }

Function Konvexe_Huelle( Punktmenge : Typ_Polygonzug ) : Typ_Polygonzug;
  { um die in Punktmenge gegebene Menge von beliebigen Punkten wird mit Hilfe des Jarvis-Algorithmus
    die konvexe Hülle bestimmt. Die Punkte werden im mathematischen Drehsinn geordnet
    ausgegeben !
  }
  Var
    lv  : Integer;
    lvl : Integer;         // Index des zuletzt gefundenen Punktes der Hülle
    lvk : Integer;         // Index des bisherigen Kandidaten
    lvu : Integer;         // Index zum kleinsten Punkt
    lvo : Integer;         // Index zum größten Punkt
    Pu  : Typ_ePunkt;      // unterer Extrempunkt
    Po  : Typ_ePunkt;      // oberer Extrempunkt
    Pk  : Typ_ePunkt;      // bester Kandidat
    Pap : Typ_ePunktPolar; // aktueller Kandidat in Polarkoordinaten
    Pkp : Typ_ePunktPolar; // bester Kandidat in Polarkoordinaten
  Begin
  { Bestimmung der Extrempunkte.
    Pu minimales y, darin minimales x
    Po maximales y, darin maximales x }
  Pu.x :=  10000000;
  Pu.y :=  10000000;
  lvu  :=         0;
  Po.x := -10000000;
  Po.y := -10000000;
  lvo  :=         0;
  For lv := 1 to Punktmenge.Anzahl do
    Begin
    If Pu.y > Punktmenge.Punkte[ lv ].y
    then
      Begin
      Pu  := Punktmenge.Punkte[ lv ];
      lvu := lv
      end
    else
      If ( Pu.y = Punktmenge.Punkte[ lv ].y ) and ( Pu.x > Punktmenge.Punkte[ lv ].x )
      then
        Begin
        Pu  := Punktmenge.Punkte[ lv ];
        lvu := lv
        end;

    If Po.y < Punktmenge.Punkte[ lv ].y
    then
      Begin
      Po  := Punktmenge.Punkte[ lv ];
      lvo := lv
      end
    else
      If ( Po.y = Punktmenge.Punkte[ lv ].y ) and ( Po.x < Punktmenge.Punkte[ lv ].x )
      then
        Begin
        Po  := Punktmenge.Punkte[ lv ];
        lvo := lv
        end
    end;

  result.Anzahl                  := 1;
  result.Punkte[ result.Anzahl ] := Pu;

  { Bestimmung der Hüllkurve von Pu nach Po }
  lvl := 0;
  repeat
    { Suche der nächsten Kante }
    Pk  := Po;
    Pkp := KartesischnachPolar( Vektor_minus_Vektor(Pk, result.Punkte[ result.Anzahl ] ) );
    lvk := lvo;
		For lv := 1 to Punktmenge.Anzahl do
      Begin
      If (lv <> lvl) and (Punktmenge.Punkte[ lv ].x > Po.x)
      then { nur ein solcher Punkt kann Kandidat werden }
        Begin
        Pap := KartesischnachPolar(
          Vektor_minus_Vektor(Punktmenge.Punkte[ lv ], result.Punkte[ result.Anzahl ] ) );
        If (Pap.W < Pkp.W) or ( (Pap.W = Pkp.W) and (Pap.R > Pkp.R) )
        then
          Begin
          Pkp := Pap;
          lvk := lv
          end;
        end
      end;
    lvl := lvk;
    inc(result.Anzahl);
    result.Punkte[ result.Anzahl ] := Punktmenge.Punkte[ lvl ];
  until lvl = lvo;

  { Bestimmung der Hüllkurve von Po nach Pu }
  lvl := 0;
  repeat
    { Suche der nächsten Kante }
    Pk  := Pu;
    Pkp := KartesischnachPolar( Vektor_minus_Vektor(Pk, result.Punkte[ result.Anzahl ] ) );
    lvk := lvu;
		For lv := 1 to Punktmenge.Anzahl do
      Begin
      If (lv <> lvl) and (Punktmenge.Punkte[ lv ].x < Pu.x)
      then { nur ein solcher Punkt kann Kandidat werden }
        Begin
        Pap := KartesischnachPolar(
          Vektor_minus_Vektor(Punktmenge.Punkte[ lv ], result.Punkte[ result.Anzahl ] ) );
        If (Pap.W < Pkp.W) or ( (Pap.W = Pkp.W) and (Pap.R > Pkp.R) )
        then
          Begin
          Pkp := Pap;
          lvk := lv
          end;
        end
      end;
    lvl := lvk;
    inc(result.Anzahl);
    result.Punkte[ result.Anzahl ] := Punktmenge.Punkte[ lvl ];
  until lvl = lvu;
  dec(result.Anzahl); // der Startpunkt wird zweimal gefunden, deswegen wieder rausnehmen
  end;

{ ---------------------------------------------------------------------------- }

Function Konvexe_Huelle_zu_Stern( Punktmenge : Typ_Polygonzug; Var KonvexeHuelle : Typ_Polygonzug ) : Integer;
  { Es wird die konvexe Hülle zu dem Polygon (= geschlossener Streckenzug) Punktmenge,
    der sternförmig bezüglich S ist, berechnet. Die Punkte des Streckenzuges kommen im
    mathematisch positiven Sinn um S herum. Sternförmig bezüglich S heißt: Es gibt
    mindestens einen Punkt S aus der durch das Polygon umschlossenen Fläche, so dass
    die Verbindungsstrecken zu S von jedem beliebigen anderen Punkt der umschlossenen
    Fläche ganz in der umschlossenen Fläche liegt. Der Nachweis dieser Eigenschaften des Polygons
    erfolgt  n i c h t  in dieser Routine, sondern wird ungeprüft vorausgesetzt !!!
    Die Findung der Hülle, deren Punkte wegen der Voraussetzung auch in mathematisch
    positiver Richtung ausgegeben werden, erfolgt nach Graham
    Returncode
    0 - alles OK
   -1 - Punktmenge zu klein
  }
  Type
    PListe = ^Typ_Liste;
    Typ_Liste = Record  // doppelt verkettete Liste
      Punktindex : integer;
      V          : PListe;  // Vorgänger
      N          : PListe;  // Nachfolger
      end;

  Var
    lv         : Integer;
    Liste      : PListe;
    Element    : PListe;
    Kandidat   : PListe;
    LastElem   : PListe;
    Flaeche    : extended;
    Po         : Typ_ePunkt; // maximaler Punkt
    lvo        : Integer;    // Index des Maximalen Punktes

  Begin
  If Punktmenge.Anzahl < 3
  then
    Begin
    result := -1;
    exit
    end;
  { Füllen der Liste mit allen Indizes des Polygons }
  { erstes Element erzeugen }
  New(Element);
  Element^.Punktindex := 1;
  Element^.V          := Element;
  Element^.N          := Element;
  Liste               := Element;
  { alle weiteren Elemente Erzeugen }
  For lv := 2 to Punktmenge.Anzahl do
    Begin
    New(Element);
    Element^.Punktindex := lv;
    LastElem            := Liste^.V;
    LastElem^.N	        := Element;
    Liste^.V            := Element;
    Element^.V          := LastElem;
    Element^.N          := Liste;
    end;
  { erste Ecke der Hülle bestimmen als maximales Element in x und darin in y }
  Po.x := -10000000000000;
  Po.y := -10000000000000;
  lvo  := 0;
  For lv := 1 to Punktmenge.Anzahl do
    If (Po.x < Punktmenge.Punkte[ lv ].x) or ( (Po.x = Punktmenge.Punkte[ lv ].x) and (Po.y < Punktmenge.Punkte[ lv ].y) )
    then
      Begin
      Po  := Punktmenge.Punkte[ lv ];
      lvo := lv
      end;
  { Startzeiger in der verketteten Liste auf dieses Element setzen }
  While Liste^.Punktindex <> lvo do
    Liste := Liste^.N;

  Element  := Liste;
  Kandidat := Element^.N;
  LastElem := Kandidat^.N;
  Flaeche  := OrientierteDreiecksflaeche( Punktmenge.Punkte[Element^.Punktindex],
    Punktmenge.Punkte[Kandidat^.Punktindex], Punktmenge.Punkte[LastElem^.Punktindex] );
  Repeat
    If abs(Flaeche) < eps
    then { die drei Punkte liegen auf einer Geraden }
      Begin
      Element^.N  := LastElem;
      LastElem^.V := Element;
      Dispose(Kandidat);
      Kandidat := LastElem;
      LastElem := Kandidat^.N
      end
    else
      If Flaeche < 0
      then { Kandidat ist Innenecke }
        Begin
        Element^.N  := LastElem;
        LastElem^.V := Element;
        Dispose(Kandidat);
        { Backtracking }
        Kandidat := Element;
        Element  := Kandidat^.V
        end
      else { Kandidat bleibt Außenecke }
        Begin { alles eins weiter }
        Element  := Kandidat;
			  Kandidat := Element^.N;
        LastElem := Kandidat^.N;
        end;
    Flaeche := OrientierteDreiecksflaeche( Punktmenge.Punkte[Element^.Punktindex],
      Punktmenge.Punkte[Kandidat^.Punktindex], Punktmenge.Punkte[LastElem^.Punktindex] );
  until (Flaeche > eps) and (LastElem = Liste);
  { Konvexe Hülle rausschreiben }
  KonvexeHuelle.Anzahl := 0;
  Element := Liste;
  Repeat
    inc(KonvexeHuelle.Anzahl);
    KonvexeHuelle.Punkte[ KonvexeHuelle.Anzahl ] := Punktmenge.Punkte[ Element^.Punktindex ];
    Element                                      := Element^.N;
  until Element = Liste;
  { Liste Löschen }
  Repeat
    LastElem := Element^.N;
    Dispose(Element);
    Element := LastElem;
  until Element^.N = Liste;
  Dispose(Element);
  result := 0;
  end;

{ ---------------------------------------------------------------------------- }

function MinimumVonArray(const Data: array of double; Anzahl : integer; var minimum : double) : integer;
  var
    i : integer;
  begin
  if Anzahl < 1
  then
    begin
    result := -1;
    exit;
    end;
  minimum := Data[0];
  for i := 1 to Anzahl - 1 do
    if Data[i] < minimum
    then
      minimum := Data[i];
  result := 0;
  end;

{ ---------------------------------------------------------------------------- }

function MaximumVonArray(const Data: array of double; Anzahl : integer; var maximum : double) : integer;
  //Result: 0: OK
  //       -1: zuwenig Werte ausgewählt
  var
    i : integer;
  begin
  if Anzahl < 1
  then
    begin
    result := -1;
    exit;
    end;
  maximum := Data[0];
  for i := 1 to Anzahl - 1 do
    if Data[i] > maximum
    then
      maximum := Data[i];
  result := 0;
  end;

{ ---------------------------------------------------------------------------- }


end.
