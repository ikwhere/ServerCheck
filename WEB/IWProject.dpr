program IWProject;
{PUBDIST}

uses
  IWInitStandAlone,
  ServerController in 'ServerController.pas' {IWServerController: TDataModule},
  IWUnit1 in 'IWUnit1.pas' {LOGIN: TIWForm1},
  DatamoduleUnit in 'DatamoduleUnit.pas' {DataModule1: TDataModule},
  IWUnit2 in 'IWUnit2.pas' {datadisplay: TIWAppForm};

{$R *.res}

begin
  IWRun(TLOGIN, TIWServerController);
end.
