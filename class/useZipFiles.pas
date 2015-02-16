unit useZipFiles;

interface

uses
  SysUtils, Variants, Classes, ComObj;

function ShellZip(zipfile, sourcefolder:string; filter: string = ''): boolean;
function ShellUnzip(zipfile, targetfolder: string; filter: string = ''): boolean;

implementation

const
  SHCONTCH_NOPROGRESSBOX = 4;
  SHCONTCH_AUTORENAME = 8;
  SHCONTCH_RESPONDYESTOALL = 16;
  SHCONTF_INCLUDEHIDDEN = 128;
  SHCONTF_FOLDERS = 32;
  SHCONTF_NONFOLDERS = 64;

function ShellZip(zipfile, sourcefolder:string; filter: string = ''): boolean;
const
  emptyzip: array[0..23] of byte  = (80,75,5,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
var
  ms: TMemoryStream;
  ShellObj: variant;
  SrcFileDir, DestFldr: variant;
  ShellFileDirItems: variant;
begin
  if not FileExists(zipfile) then
  begin
    // create a new empty ZIP file
    ms := TMemoryStream.Create;
    ms.WriteBuffer(emptyzip, sizeof(emptyzip));
    ms.SaveToFile(zipfile);
    ms.Free;
  end;

  ShellObj := CreateOleObject('Shell.Application');

  SrcFileDir := ShellObj.NameSpace(sourcefolder);
  DestFldr := ShellObj.NameSpace(zipfile);

  ShellFileDirItems := SrcFileDir.Items;

  if (filter <> '') then
    ShellFileDirItems.Filter(SHCONTF_INCLUDEHIDDEN or SHCONTF_NONFOLDERS or SHCONTF_FOLDERS,filter);

  DestFldr.CopyHere(ShellFileDirItems, 0);
  Result := True;
end;

function ShellUnzip(zipfile, targetfolder: string; filter: string = ''): boolean;
var
  ShellObj: variant;
  SrcFileDir, DestFldr: variant;
  ShellFileDirItems: variant;
begin
  ShellObj := CreateOleObject('Shell.Application');

  SrcFileDir := ShellObj.NameSpace(zipfile);
  DestFldr := ShellObj.NameSpace(targetfolder);

  ShellFileDirItems := SrcFileDir.Items;
  if (filter <> '') then
    ShellFileDirItems.Filter(SHCONTF_INCLUDEHIDDEN or SHCONTF_NONFOLDERS or SHCONTF_FOLDERS,filter);

  DestFldr.CopyHere(ShellFileDirItems, SHCONTCH_NOPROGRESSBOX or SHCONTCH_RESPONDYESTOALL);
  Result := True;
end;

end.

