unit useConstants;

interface

type
    TMesesDoAnoEnum = (maJan, maFev, maMar, maAbr, maMai, maJun, maJul, maAgo, maSet, maOut, maNov, maDez);

const
  //Instalações
  nSE_CDINSTACAO = 1;

  //Sistemas
  nSE_CDSISTEMA  = 10000;
  nSCD_CDSISTEMA = 20000;
  nSKL_CDSISTEMA = 30000;
  nPRO_CDSISTEMA = 40000;

{Nomes para arquivos}
  sSQL_LOG_FILE    = '-SQL-Log.log';
  sAPP_CONIFG_FILE = '.ini';
  sAPP_LOG_FILE    = '-app-log.log';
  sEMAIL_LOG       = '{$SYTEM-LOG}';

{Tipos de bancos}
  sBD_MYSQL = 'mysql';
  sBD_FIREBIRD = 'firebird';

{Nome dos formulários}
  sfseCadCompleto = 'fseCadCompleto';


  sNAO = 'N';
  sSIM = 'S';
  STRING_INDEFINIDO = '';
  NUMERO_INDEFINIDO = -999;
  SSQLDataSetOpen = 'Unable to determine field names for %s';
  SNoDataSet = 'No dataset association';
  SSQLGenSelect = 'Must select at least one key field and one update field';
  SSQLNotGenerated = 'Update SQL statements not generated, exit anyway?';

  sTPAUX_TPUSUARIO = 'TpUsuario';
  sTPAUX_TPOPERTELA = 'TpOperacaoFuncTela';

  nCDTPPESSOA_FORNECEDORES  = 1;
  nCDTPPESSOA_MEDICOS       = 2;
  nCDTPPESSOA_DENTISTAS     = 3;
  nCDTPPESSOA_VETERINARIOS  = 4;
  nCDTPPESSOA_RESP_TECNICOS = 5;
  nCDTPPESSOA_LABORATORIOS  = 6;

{ Parâmetros }
  PRM_TIPO_CADASTRO = 'prmTipoCadastro';
  PRM_DATASET_CONSULTA = 'prmDatasetConsulta';
  PRM_CONSULTA_SELECT = 'prmConsultaSelect';
  PRM_CONSULTA_BOUNDS = 'prmConsultaBounds';
  PRM_CONSULTA_TEXTO = 'prmConsultaTexto';
  PRM_TIPO_CADASTRO_PESSOA = 'prmTipoCadastroPessoa';
  PRM_CAMPO_DESCRICAO = 'prmCampoDescricao';

  {TmpgCustomDataset}
  C_ID  = 'ID';
  C_DEL = 'DeleteSQL';
  C_INS = 'InsertSQL';
  C_MOD = 'ModifySQL';
  C_REF = 'RefreshSQL';
  C_SEL = 'SelectSQL';
  C_PK  = 'PrimaryKey';
  C_GEN = 'Generated';

  sMesesDoAno : array[TMesesDoAnoEnum] of string = ('Janeiro','Fevereiro','Março','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro');
  sMesesDoAnoAbrev : array[TMesesDoAnoEnum] of string = ('Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez');

implementation

{ TmpgAplicacao }

end.
