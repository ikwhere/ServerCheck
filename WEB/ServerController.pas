unit ServerController;
{PUBDIST}

interface

uses
  Classes,
  DatamoduleUnit,
  IWServerControllerBase, IWAppForm, IWApplication,
  SysUtils, ADODB, DB,ACTIVEX ,IniFiles,Dialogs;

type
  TIWServerController = class(TIWServerControllerBase)
    ADOQuery1: TADOQuery;
    procedure IWServerControllerBaseNewSession(ASession: TIWApplication;
      var VMainForm: TIWAppForm);
    procedure IWServerControllerBaseCreate(Sender: TObject);
  private
  public

  end;

  // This is a class which you can add variables to that are specific to the user. Add variables
  // to this class instead of creating global variables. This object can references by using:
  //   UserSession
  // So if a variable named UserName of type string is added, it can be referenced by using:
  //   UserSession.UserName
  // Such variables are similar to globals in a normal application, however these variables are
  // specific to each user.
  //
  // See the IntraWeb Manual for more details.
  TUserSession = class(TComponent)
  public
    DataModule1: TDataModule1;
    //
    constructor Create(AOwner: TComponent); override;
    procedure MOVE(AFORMCLASS:TIWAppForm);
  end;

// Procs
  function UserSession: TUserSession;

implementation
{$R *.dfm}

uses
  IWInit;

procedure TUserSession.MOVE(AFORMCLASS:TIWAppForm);
BEGIN

  
END;
function UserSession: TUserSession;
begin
  Result := TUserSession(RWebApplication.Data);
end;

{ TUserSession }

constructor TUserSession.Create(AOwner: TComponent);
begin
  inherited;
  Datamodule1 := TDatamodule1.Create(AOwner);
end;

procedure TIWServerController.IWServerControllerBaseNewSession(
  ASession: TIWApplication; var VMainForm: TIWAppForm);
begin
  ASession.Data := TUserSession.Create(ASession);
end;
procedure TIWServerController.IWServerControllerBaseCreate(
  Sender: TObject);
var inifile:Tinifile;
VAR I:INTEGER;
begin
   inifile:=Tinifile.create(SELF.FCacheDir+'W_CONFIG.INI');
   I:=inifile.ReadInteger('ServerBase','port',8081);
   SELF.Port:=inifile.ReadInteger('ServerBase','port',8081);
   SELF.BOUNDIP:=inifile.Readstring('ServerBase','IP','127.0.0.1');
   inifile.free;
end;

initialization
  CoInitialize(nil)
end.
