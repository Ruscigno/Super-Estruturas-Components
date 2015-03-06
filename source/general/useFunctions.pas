unit useFunctions;

interface

uses
  useConstants;

//function GetTableFromDB(Table : string) : string; overload;
//function GetTableFromDB(Connection : TmpgConnection; Table : string) : string; overload;
function Decrypt(psPassword : string) : string;
function EhNulo(pValor : Variant) : Boolean;
function Encrypt(psPassword : string) : string;
function FormataCPF_CNPJ(PValor: string): string;
function GetAppConfigFile : string;
function GetAppLogFile : string;
function GetAppSqlLogFile : string;
function GetConfigFile(psDefaultFile : string = STRING_INDEFINIDO) : string;
function GetExeName: string;
function GetMesExt(pnMes : word) : string;
function GetMesExtAbrev(pnMes : word) : string;
//function GetParentForm(pControl : TWinControl): TfmpgForm;
function LimparCPF_CNPJ(PValor: string): string;
function ValidaCGC(snrCNPJ: string):Boolean;
function ValidaCNPJ(pCNPJ: string):Boolean;
function ValidaCPF(pCPF: string):Boolean;
procedure StatusBarText(pText : String; iPanel : Integer = 0);
procedure SetConfigFile(const Value: string; var pVariable : string);

implementation

uses
  {$IF RTLVersion >= 19}
    System.SysUtils, System.Classes, System.Variants, System.Math, FMX.Dialogs,
    System.UITypes, System.StrUtils;
  {$ELSE}
    SysUtils, Classes, Variants, Math, Dialogs, StrUtils;
  {$IFEND}

function GetAppConfigFile : string;
begin
  result := ChangeFileExt(GetExeName,sAPP_CONIFG_FILE);
end;

function GetAppSqlLogFile : string;
begin
  result := ChangeFileExt(GetExeName, sSQL_LOG_FILE);
end;

function GetAppLogFile : string;
begin
  result := ChangeFileExt(GetExeName, sAPP_LOG_FILE);
end;

function GetExeName: string;
begin
//  if Assigned(oAplicacao) and (oAplicacao.IsService) then
    result := ParamStr(0)
//  else
//    result := Forms.Application.ExeName;
end;

function EhNulo(pValor : Variant) : Boolean;
var
  aValor : String;
begin
  if (VarIsNull(pValor) or VarIsEmpty(pValor)) then
    Result := True
  else
  begin
    aValor := VarToStr(pValor);
    Result :=
      (CompareStr(aValor, STRING_INDEFINIDO) = 0)
      or (CompareStr(aValor, IntToStr(NUMERO_INDEFINIDO)) = 0)
      or (CompareStr(aValor, '') = 0);
  end;
end;

function ValidaCPF(pCPF: string):Boolean;
var
  sDigs, sVal  : string;
  iSTot, iSTot2: integer;
  i: integer;
begin
  Result := False;
  if(Length(pCPF) = 11)then
  begin
    pCPF   := Trim(pCPF);
    iSTot  := 0;
    iSTot2 := 0;

    for i := 9 downto 1 do
    begin
      iSTot  := iSTot  + StrToInt(Copy(pCPF,i,1)) * (11-i);
      iSTot2 := iSTot2 + StrToInt(Copy(pCPF,i,1)) * (12-i);
    end;
    iSTot  := iSTot mod 11;
    sDigs  := sDigs + IntToStr(IfThen(iSTot < 2, 0, 11-iSTot));

    iSTot2 := iSTot2 + 2*StrToInt(sDigs);
    isTot2 := iSTot2 mod 11;
    sDigs  := sDigs + IntToStr(IfThen(iSTot2 < 2, 0, 11-iSTot2));

    sVal   := Copy(pCPF,10,2);
    if(sDigs = sVal)then
      Result := True
  end;
end;

function ValidaCGC(snrCNPJ: String):Boolean;
var
  wCNPJcalc : string;
  wSomaCNPJ : integer;
  WSX1     : shortint;
  wCNPJDigt : integer;
begin
  Result := False;
  if (snrCNPJ <> '')and (snrCNPJ <> '  .   .   /    -  ') then
    try
      snrCNPJ := Copy(snrCNPJ,1,2)+Copy(snrCNPJ,4,3)+
        Copy(snrCNPJ,8,3)+Copy(snrCNPJ,12,4)+Copy(snrCNPJ,17,2);
      wCNPJcalc := Copy(snrCNPJ,1,12);
      wSomaCNPJ := 0;
      {-----------------------------}
      for wsx1:= 1 to 4 do
        wSomaCNPJ:= wSomaCNPJ + strtoint(copy(wCNPJcalc, wsx1, 1)) * (6 - wsx1);
      for wsx1:= 1 to 8 do
        wSomaCNPJ:= wSomaCNPJ + strtoint(copy(wCNPJcalc, wsx1 + 4, 1)) * (10 - wsx1);
      wCNPJDigt:= 11 - wSomaCNPJ mod 11;
      if wCNPJDigt in [10,11] then
        wCNPJcalc:= wCNPJcalc + '0'
      else
        wCNPJcalc := wCNPJcalc +  inttoStr(wCNPJDigt);
      {---------------------------------}
      wSomaCNPJ:= 0;
      for wsx1:= 1 to 5 do
        wSomaCNPJ:= wSomaCNPJ + strtoint(copy(wCNPJcalc, wsx1, 1)) * (7 - wsx1);
      for wsx1:= 1 to 8 do
        wSomaCNPJ:= wSomaCNPJ + strtoint(copy(wCNPJcalc, wsx1 + 5, 1)) * (10 - wsx1);
      wCNPJDigt:= 11 - wSomaCNPJ mod 11;
      if wCNPJDigt in [10,11] then
        wCNPJcalc:= wCNPJcalc + '0'
      else
        wCNPJcalc := wCNPJcalc +  inttoStr(wCNPJDigt);
      if  snrCNPJ <> wCNPJcalc then
      begin
//        application.messagebox('C.N.P.J. Inválido !','Atenção!',mb_iconstop+mb_ok);
//        Result := false;
      end
      else
        Result := True ;
    except
      on econverterror do
      begin
        Result := False;
//        MessageDlg('Valor não é válido !','Atenção!', mtWarning, mbOk);
      end;
    end;
end;

function ValidaCNPJ(pCNPJ: string):Boolean;
begin
  Result:= ValidaCGC(pCNPJ);
end;

function FormataCPF_CNPJ(PValor: string): string;
begin
  if(Length(PValor) = 11)then
  begin
//      EditMask:= '000\.000\.000\-00;1;_';
    Result:= LeftStr(PValor, 3) + '.';
    Result:= Result + MidStr(PValor, 4, 3) + '.';
    Result:= Result + MidStr(PValor, 7, 3) + '-';
    Result:= Result + RightStr(PValor, 2);
  end
  else if(Length(PValor) = 14)then
  begin
//      EditMask:= '00!\.000!\.000\/0000\-00;1;_'
    Result:= LeftStr(PValor, 2) + '.';
    Result:= Result + MidStr(PValor, 3, 3) + '.';
    Result:= Result + MidStr(PValor, 6, 3) + '/';
    Result:= Result + MidStr(PValor, 9, 4) + '-';
    Result:= Result + RightStr(PValor, 2);
  end
  else
    Raise Exception.Create('CPF ou CNPJ inválido!');
end;

function LimparCPF_CNPJ(PValor: string): string;
begin
  Result:= PValor;
  Result:= StringReplace(Result, '-', '', [rfReplaceAll]);
  Result:= StringReplace(Result, '.', '', [rfReplaceAll]);
  Result:= StringReplace(Result, '/', '', [rfReplaceAll]);
end;

procedure StatusBarText(pText : String; iPanel : Integer = 0);
begin
//  if (oAplicacao.frmMenu <> nil) then
//    TfseMenu(oAplicacao.frmMenu).mpgStatusBar.Panels[iPanel].Text := pText;
end;


//function GetParentForm(pControl : TWinControl): TfmpgForm;
//var
//  oControl : TControl;
//begin
//  Result := nil;
//  oControl := pControl;
//  while (oControl.Parent <> nil) and not(oControl.Parent is TfmpgForm) do
//    oControl := oControl.Parent;
//  if (oControl.Parent <> nil) and (oControl.Parent is TfmpgForm) then
//    Result := TfmpgForm(oControl.Parent);
//end;

//function GetTableFromDB(Table : string) : string;
//begin
//  result := GetTableFromDB(oAplicacao.Connection, Table);
//end;

//function GetTableFromDB(Connection : TmpgConnection; Table : string) : string;
//var
//  sTextIni, sTextFim : string;
//  iPos : integer;
//begin
//  if Assigned(Connection) then
//  begin
//    if not (Connection.Connected) then
//      Connection.Connected := True;
//
//    sTextFim := '';
//    iPos := Pos('where', LowerCase(Table));
//    if (iPos > 0) then
//    begin
//      sTextIni := MidStr(Table, 1, iPos-1);
//      sTextFim := MidStr(Table, iPos, Length(Table));
//    end
//    else
//      sTextIni := Table;
//
//    if (MidStr(Connection.Protocol, 1, Length(sBD_MYSQL)) = sBD_MYSQL) then
//      result := LowerCase(sTextIni)
//    else if (MidStr(Connection.Protocol, 1, Length(sBD_FIREBIRD)) = sBD_FIREBIRD) then
//      result := UpperCase(sTextIni);
//
//    result := result + sTextFim;
//  end
//  else
//    result := Table;
//end;

function Encrypt(psPassword : string) : string;
begin
  result := '';
end;

function Decrypt(psPassword : string) : string;
begin
  result := '';
end;

function GetConfigFile(psDefaultFile : string = STRING_INDEFINIDO) : string;
begin
  if (psDefaultFile = STRING_INDEFINIDO) then
    result := ChangeFileExt(ExtractFileName(GetExeName), '.ini')
  else
    result := psDefaultFile;

  if not DirectoryExists(ExtractFilePath(result)) then
    result := ExtractFilePath(GetExeName) + result;
end;

function GetMesExtAbrev(pnMes : word) : string;
begin
  result := sMesesDoAnoAbrev[TMesesDoAnoEnum(pnMes - 1)];
end;

function GetMesExt(pnMes : word) : string;
begin
  result := sMesesDoAno[TMesesDoAnoEnum(pnMes - 1)];
end;

procedure SetConfigFile(const Value: string; var pVariable : string);
begin
  if (pVariable <> Value) then
    pVariable := Value;
  if not FileExists(pVariable) {and (csDesigning in Application.ComponentState) } then
    pVariable := GetAppConfigFile;
end;

end.

