unit uMSSQL;

interface

uses
  Classes, DB, ADODB;

const
  XML_DIR__ : string = ''; // MS

type
  tMSSQL = class
  private
    AdoCon    : TADOConnection;
    AdoQry    : TADOQuery;
    fUserName : String;
    fPassword : String;
    fServer   : string;
    fDB       : string;
    fTable    : string;
    fOwner    : TComponent;
  public
    constructor Create( AOwner : TComponent; DB : string; Table : string; UserName : String; Password : String; Provider : string; DataSource : String );
    constructor CreateODBC( AOwner : TComponent; DSN : string; DB : string; Table : string; UserName : String; Password : String );
    destructor  Destroy; override;
    function    AddValue( Time : TDateTime; RingNo : string; Order : string; RueckNo : string; Index : Integer; dValue : Double ) : boolean;
    function    ReturnHighestIndex( RingNo : string; var Index : Integer ) : boolean;

    property    UserName : string read fUserName write fUserName;
    property    Password : string read fPassword write fPassword;
  end;

implementation

uses
  SysUtils, JvSimpleXml, ActiveX, uTLH.Strings;

constructor tMSSQL.CreateODBC( AOwner : TComponent; DSN : string; DB : string; Table : string; UserName : String; Password : String );
begin
  inherited Create;
  fOwner                   := AOwner;
  fUserName                := UserName;
  fPassword                := Password;
  fServer                  := DSN;
  fDB                      := DB;
  fTable                   := Table;

  AdoCon                   := TADOConnection.Create( AOwner );
  AdoCon.CommandTimeout    := 1;
  AdoCon.ConnectionTimeout := 1;

  AdoQry                   := TADOQuery.Create( AOwner );
  AdoQry.Connection        := AdoCon;
  AdoQry.CommandTimeout    := 1;

  // ODBC
  AdoCon.ConnectionString  := 'Provider=MSDASQL;PersistSecurityInfo=False;' +
                              'Trusted_Connection=No;' +
                               Format( 'Data Source=%s;', [ DSN ] ) +
                               Format( 'catalog=%s;', [ DB ] );
end;

constructor tMSSQL.Create( AOwner : TComponent; DB : string; Table : string; UserName : String; Password : String; Provider : string; DataSource : String );
begin
  inherited Create;
  fOwner                   := AOwner;
  fUserName                := UserName;
  fPassword                := Password;
//  fServer                  := ''; // MS
  fDB                      := DB;
  fTable                   := Table;

  AdoCon                   := TADOConnection.Create( AOwner );
  AdoCon.CommandTimeout    := 1;
  AdoCon.ConnectionTimeout := 1;

  AdoQry                   := TADOQuery.Create( AOwner );
  AdoQry.Connection        := AdoCon;
  AdoQry.CommandTimeout    := 1;

  // MSSQL
  AdoCon.ConnectionString  := Format( 'Provider=%s;', [ Provider ] ) +
                              'Persist Security Info=False;' +
                              'User ID="";' +
                              Format( 'Initial Catalog=%s;', [ DB ] ) +
                              Format( 'Data Source=%s;', [ DataSource ] ) +
                              'Use Procedure for Prepare=1;' +
                              'Auto Translate=True;Packet Size=4096;' +
                              'Workstation ID=<PC-Name>;' +
                              'Initial File Name="";' +
                              'Use Encryption for Data=False;' +
                              'Tag with column collation when possible=False;' +
                              'MARS Connection=False;' +
                              'DataTypeCompatibility=0;' +
                              'Trust Server Certificate=False;Server SPN="";' +
                              'Application Intent=READWRITE;' +
                              'Application Name=<Programmname>;';
end;

destructor tMSSQL.Destroy;
begin
  if AdoCon.Connected then
    AdoCon.Close;
  AdoCon.free;
  AdoQry.free;
  inherited;
end;

function tMSSQL.AddValue( Time : TDateTime; RingNo : string; Order : string; RueckNo : string; Index : Integer; dValue : Double ) : boolean;
  procedure AddSQL( Time : TDateTime; RingNo : string; Order : string; RueckNo : string; Index : Integer; Value : Double );
  begin
    AdoQry.SQL.Clear;
    AdoQry.SQL.Add( Format( 'INSERT INTO %s.dbo.%s (Datum, Ring, Folge, Streifen, Auftrag, Ruecknr, Probe, Messwert) VALUES ( :P_1, :P_2, :P_3, :P_4, :P_5, :P_6, :P_7, :P_8 )', [ fDB, fTable ] ) );
    AdoQry.Prepared := True;

    AdoQry.Parameters.FindParam('P_1').DataType := ftString;
    AdoQry.Parameters.FindParam('P_1').Value := FormatDateTime( 'yyyymmdd hh:nn:ss.zzz', Time ); // SQL screws on conversion of TDateTime
    AdoQry.Parameters.FindParam('P_2').Value := GetTok( RingNo, 1, '-' );
    AdoQry.Parameters.FindParam('P_3').Value := GetTok( RingNo, 2, '-' );
    AdoQry.Parameters.FindParam('P_4').Value := GetTok( RingNo, 3, '-' );
    AdoQry.Parameters.FindParam('P_5').Value := Order;
    AdoQry.Parameters.FindParam('P_6').Value := RueckNo;
    AdoQry.Parameters.FindParam('P_7').Value := Index;
    AdoQry.Parameters.FindParam('P_8').Value := Value;

    AdoQry.ExecSQL; // PUSH
  end;
var
  XML                 : TJvSimpleXML;
  i, j                : integer;

  tTime               : TDateTime;
  tIndex              : Integer;
  tOrder, tRingNo     : string;
  tRueckNo            : string;
  tValue              : Double;
  OverflowFile        : string;
begin
  OverflowFile := XML_DIR__ + 'Overflow.xml';
  result := False;

  CoInitialize(NIL);
  try
    AdoCon. Open( fUserName, fPassword );
    result := True;
  except
//    on E : Exception do
//      begin
//      ShowMessage('Exception class name = '+E.ClassName);
//      ShowMessage('Exception message = '+E.Message);
//      end;
  end;

  if AdoCon.Connected then
    begin
    if FileExists( OverflowFile ) then // Resynch
      begin
      XML := TJvSimpleXML.Create(nil);
      XML.LoadFromFile( OverflowFile );

      for i := 0 to XML.Root.ItemCount-1 do
        begin
        tTime := NOW;
        tRingNo := '';
        tOrder := '';
        tRueckNo := '';
        tIndex := 0;
        tValue := 0;

        for j := 0 to XML.Root.Items[ i ].ItemCount-1 do
          begin
          case j of
            0 : tTime    := StrToFloat( XML.Root.Items[ i ].Items[ j ].Value );
            1 : tRingNo  := XML.Root.Items[ i ].Items[ j ].Value;
            2 : tOrder   := XML.Root.Items[ i ].Items[ j ].Value;
            3 : tRueckNo :=  XML.Root.Items[ i ].Items[ j ].Value;
            4 : tIndex   := StrToInt( XML.Root.Items[ i ].Items[ j ].Value );
            5 : tValue   := StrToFloat( XML.Root.Items[ i ].Items[ j ].Value );
          end;
          end;
        AddSQL( tTime, tRingNo, tOrder, tRueckNo, tIndex, tValue );
        end;
      DeleteFile( OverflowFile );
      end;

    try
      AddSQL( Time, RingNo, Order, RueckNo, Index, dValue );
    except
    end;

    AdoCon.Close;
    end
  else
    begin
    XML := TJvSimpleXML.Create(nil);

    if FileExists( OverflowFile ) then
      XML.LoadFromFile( OverflowFile )
    else
      XML.Root.Name := 'DatabaseTemp';

    with XML.Root.Items.Add( 'Entrys' ) do
      begin
      Items.Add( 'Datum', FloatToStr( Time ) );
      Items.Add( 'RingNo', RingNo );
      Items.Add( 'Order',  Order );
      Items.Add( 'RueckNo', RueckNo );
      Items.Add( 'Index', IntToStr( Index ) );
      Items.Add( 'Value', FloatToStr( dValue ) );
      end;
    XML.SaveToFile( OverflowFile );

    XML.Free;
    end;
end;

function tMSSQL.ReturnHighestIndex( RingNo : string; var Index : Integer ) : boolean;
begin
  result := False;

  if NOT Assigned( self ) then
    Exit;

  Index := 0;

  CoInitialize(NIL);
  try
    AdoCon.Open( fUserName, fPassword );
    result := True;
  except
//    on E : Exception do
//      begin
//      ShowMessage('Exception class name = '+E.ClassName);
//      ShowMessage('Exception message = '+E.Message);
//      end;
  end;

  if AdoCon.Connected then
    begin
    AdoQry.SQL.Clear;
    AdoQry.SQL.Add( Format( 'SELECT Max(Probe) FROM %s.dbo.%s WHERE Ring=%s AND Folge=%s AND Streifen=%s', [ fDB, fTable, GetTok( RingNo, 1, '-' ), GetTok( RingNo, 2, '-' ), GetTok( RingNo, 3, '-' ) ] ) );
    AdoQry.Active := True; // POP

    if ( AdoQry.FieldCount >= 0 ) then
      Index := AdoQry.Fields[0].AsInteger;

    AdoCon.Close;
    end;
end;

end.
