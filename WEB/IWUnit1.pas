unit IWUnit1;
{PUBDIST}

interface

uses
  IWAppForm, IWApplication, IWTypes, IWCompLabel, IWCompEdit, Classes,
  Controls, IWControl, IWCompButton, IWLayoutMgr, IWTemplateProcessorHTML,
  DB, ADODB,ACTIVEX;

type
  TLOGIN = class(TIWAppForm)
    IWBtnLogin: TIWButton;
    IWBtnReset: TIWButton;
    IWEdit1: TIWEdit;
    IWEdit2: TIWEdit;
    IWLabel1: TIWLabel;
    IWLabel2: TIWLabel;
    IWTemplateProcessorHTML1: TIWTemplateProcessorHTML;
    IWLabel3: TIWLabel;

    procedure IWBtnLoginClick(Sender: TObject);
  public
  end;

implementation
{$R *.dfm}


uses
  ServerController, IWUnit2;

procedure TLOGIN.IWBtnLoginClick(Sender: TObject);
VAR STRSQL:STRING;
    ADOQuery1: TADOQuery;
begin
    CoInitialize(nil) ;
    ADOQuery1:=TADOQUERY.Create(WEBAPPLICATION);
    ADOQuery1.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=..\SERVER\SERVERLOG.mdb;Persist Security Info=True';
    ADOQuery1.CursorLocation:=clUseServer;
    STRSQL:='SELECT * FROM USERINFO WHERE NAME='''+IWEdit1.Text+'''';
    ADOQuery1.SQL.Text:=STRSQL;
    ADOQuery1.Open;
    IF ADOQuery1.RecordCount=0 THEN BEGIN
       IWLabel3.Caption:='THE USER IS NOT FOUNDED' ;
       EXIT;
    END;
    STRSQL:='SELECT * FROM USERINFO WHERE NAME='''+IWEdit1.Text+''' AND PASSWORD='''+IWEdit2.Text+'''';
    ADOQuery1.SQL.Text:=STRSQL;
    ADOQuery1.Open;
    IF ADOQuery1.RecordCount=0 THEN BEGIN
       IWLabel3.Caption:='THE PASSWORD IS WRONG' ;
       EXIT;
    END;
    webapplication.ACTIVEFORM.FREE;
    Tdatadisplay.CREATE(webapplication).SHOW;
    ADOQuery1.Free;
end;

initialization
  CoInitialize(nil);   
finalization
  CoUninitialize();       


end.
