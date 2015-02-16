unit useConfigFile;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, DB;

type
  TseConfigFileRecord = record
    propName : string;
    proValue : Variant;
    proType :  Cardinal;
  end;

  TseConfigFileArray = array of TseConfigFileRecord;
  
  TseConfigFile = class(TObject)
  private
    FProperties : TseConfigFileArray;
  public
    constructor Create;
    procedure AddProperty(psName : string; pvValue : Variant; pType : TFieldType);
    property Properties : TseConfigFileArray read FProperties write FProperties;
  end;

implementation

{ TseConfigFile }

procedure TseConfigFile.AddProperty(psName: string; pvValue: Variant;
  pType: TFieldType);
begin
//  if (High(FProperties) = -1) then
//    SetLength(FProperties, 1)
//  else if (High(FProperties) = 0) then
//    SetLength(FProperties, 2)
//  else
    SetLength(FProperties, High(FProperties) + 2);
end;

constructor TseConfigFile.Create;
begin

end;

end.
