program imessSaebelmessplatte;

{$I SMP.inc}

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  Forms,
  Main in 'Main.pas' {FrmRS232},
  uPrinter in 'uPrinter.pas',
  uFrmOptions in 'uFrmOptions.pas' {FrmOptions},
  uParameter in 'uParameter.pas',
  {$IFDEF WEBIO}
  uWEBIO in 'uWEBIO.pas' {FrmWEBIO},
  {$ENDIF}
  uLanguager in 'uLanguager.pas',
  Language in 'Language.pas' {FrmLanguage};

{$R *.res}
{$IF CompilerVersion < 22}
  {$R Win7UAC_asInvoker.res}
{$IFEND}

begin
  Application.Initialize;
  Application.CreateForm(TFrmRS232, FrmRS232);
  Application.CreateForm(TFrmLanguage, FrmLanguage);
  Application.CreateForm(TFrmOptions, FrmOptions);
  {$IFDEF WEBIO}
  Application.CreateForm(TFrmWEBIO, FrmWEBIO);
  {$ENDIF}
  Application.Run;
end.
