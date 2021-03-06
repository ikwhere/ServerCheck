unit SERVER;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, IdBaseComponent, IdComponent, IdTCPServer,
  DB, ADODB, Sockets,ScktComp, Spin,ActiveX,IniFiles,ShellAPI, Menus;
const
  WM_BarIcon=WM_USER+200 ;
const
    ThreadMax=2;  //
    strlen=9;
type
  client_record=record
     CHandle: integer;          //客户端套接字句柄      客戶端套接字句柄
     CSocket:TCustomWinSocket;    //客户端套接字        客户端套接字
     CName:string;                //客户端计算机名称    客户端計算機名稱
     CAddress:string;             //客户端计算机IP地址  客户端IP地址
     CUsed: boolean;               //客户端联机标志     客户端聯機標志
     RecvData:string;
  end;
  TCLIENTINFO=record
      SERVER_IP:STRING;
      CPUUsage:STRING;
      CPUNumber:STRING;
      MEMUsage:STRING;
      VMUsage:STRING;
      HDUsage:STRING;
      HDFreeSpace:STRING;              //MB
      HDTotalSpace:STRING;             //MB
      CNOW:STRING;
      CWEEKDAY:STRING;
      CDATE:STRING;
  END;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    RichEdit1: TRichEdit;
    GroupBox2: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    ADOQuery1: TADOQuery;
    Button5: TButton;
    StatusBar1: TStatusBar;
    ServerSocket: TServerSocket;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    EdtPort: TEdit;
    EdtCaCnt: TEdit;
    PopupMenu1: TPopupMenu;
    N5: TMenuItem;
    N6: TMenuItem;
    RichEdit2: TRichEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure EdtPortKeyPress(Sender: TObject; var Key: Char);
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ServerSocketListen(Sender: TObject;Socket: TCustomWinSocket);
    procedure ServerSocketClientRead(Sender: TObject;Socket: TCustomWinSocket);
    procedure ServerSocketClientConnect(Sender: TObject;Socket: TCustomWinSocket);
    procedure ServerSocketClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ServerSocketClientError(Sender: TObject;Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;  var ErrorCode: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure EdtCaCntKeyPress(Sender: TObject; var Key: Char);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);

  private
    { Private declarations }
      procedure WMBarIcon(var Message:TMessage);message WM_BarIcon;
     procedure WMSysCommand(var Message:TMessage);message WM_SYSCOMMAND;
     procedure SaveToDB;
  public
    { Public declarations }
    session: array[0..ThreadMax] of client_record;      //客户端连接数组
    Sessions: integer;                             //客户端连接数
  end;
type TMyIniFile=record    //ゴ秨皌竚ゅン
    cachecount:string;
    port:string;
    connectcount:string;
end;
var TempStrS:TStringList;   //钡Μ计沮羬跋
    TmpStrMax:integer;      //羬计沮玂秖
    Terminated:BOOLEAN;     //い耞狝叭跑秖
    Tid:Dword;              //THREAD 絪腹
    StrThread:Dword;              //THREAD 絪腹
    dev_ThreadCritical: _RTL_CRITICAL_SECTION;
var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.WMSysCommand(var Message:TMessage);
var
   lpData:PNotifyIconData;
begin
  if Message.WParam = SC_ICON then
  begin
     lpData := new(PNotifyIconDataA);
     lpData.cbSize := 88;//SizeOf(PNotifyIconDataA);
     lpData.Wnd := Form1.Handle;
     lpData.hIcon := APPLICATION.Icon.Handle;
     lpData.uCallbackMessage := WM_BARICON;
     lpData.uID :=0;
     lpData.szTip := 'SERVERCHECK_CLIENT _V1.0';
     lpData.uFlags := NIF_ICON or NIF_MESSAGE or NIF_TIP;
     Shell_NotifyIcon(NIM_ADD,lpData);
     dispose(lpData);
     Form1.Visible := False;
  end
  else
  begin
     DefWindowProc(Form1.Handle,Message.Msg,Message.WParam,Message.LParam);
  end;
end;
procedure TForm1.WMBarIcon(var Message:TMessage);
var
   lpData:PNotifyIconData;
   p:Tpoint;
BEGIN
   if Message.LParam = WM_LButtonDown  then
   begin
      lpData := new(PNotifyIconDataA);
      lpData.cbSize:=sizeof(_NOTIFYICONDATAA);
      lpdata.Wnd:=FORM1.Handle;
      Shell_NotifyIcon(NIM_DELETE,lpData);
      dispose(lpData);
      Form1.Visible := true;
   end
   else if Message.LParam = WM_RBUTTONDOWN  then
   begin
      getcursorpos(p);
      popupmenu1.Popup(p.X,p.Y);
   end
   else
      DefWindowProc(Form1.Handle,Message.Msg,Message.WParam,Message.LParam);
END;
//计沮玂ㄧ计
procedure TForm1.SaveToDB;
var i,j,k,m:integer;
    sqlstr:string;
    TEMPCHAR:pchar;
    CLIENTINFO:array[0..10] of string;
begin

        For i:=0 to TEMPSTRS.Count-1 do begin
            TEMPCHAR:=PCHAR(TEMPSTRS[i]);
            k:=0;
            m:=0;
            //================だ澄计沮=================//
            FOR j:=0 to length(TEMPSTRS[i]) do
                if TEMPCHAR[j]=',' then begin
                      CLIENTINFO[m]:=copy(TEMPCHAR,k+1,j-k);
                      k:=j+1;
                      INC(m);
            end;
            //================だ澄计沮=================//
            sqlstr:='insert into SERVERLOG(SERVER_IP, CPUUsage,CPUNumber,MEMUsage,VMUsage,'+
                    'HDUsage,HDFreeSpace,HDTotalSpace,CNOW,CWEEKDAY,CDATE) values (';
            FOR j:=0 TO m-1 DO BEGIN
               sqlstr:=sqlstr+#39+CLIENTINFO[j]+#39;
               if j<m-1 then sqlstr:=sqlstr+',' else sqlstr:=sqlstr+');';
            END;

   {         sqlstr:='insert into SERVERLOG(SERVER_IP, CPUUsage,CPUNumber,MEMUsage,VMUsage,'+
                    'HDUsage,HDFreeSpace,HDTotalSpace,CNOW,CWEEKDAY,CDATE) values ('
                     +#39+CLIENTINFO[0]+#39+','+#39+CLIENTINFO[1]+#39+','+#39+CLIENTINFO[2]+
                     #39+','+#39+CLIENTINFO[3]+#39+','+#39+CLIENTINFO[4]+
                     #39+','+#39+CLIENTINFO[5]+#39+','+#39+CLIENTINFO[6]+#39+','+#39+CLIENTINFO[7]+
                     #39+','+#39+CLIENTINFO[8]+#39+','+#39+CLIENTINFO[9]+#39+','+#39+CLIENTINFO[10]+#39+');'; }
        CoInitialize(nil);
        Form1.ADOQuery1.SQL.Clear;
        Form1.ADOQuery1.SQL.Add(sqlstr);
        Form1.ADOQuery1.ExecSQL;
        Form1.ADOQuery1.Close;
        CoUninitialize();
        END;
//        EnterCriticalSection(dev_ThreadCritical);
        Form1.RichEdit2.Lines.Add(DATETIMETOSTR(NOW)+'->'+inttostr(TEMPSTRS.Count)+' DATAS AT '+CLIENTINFO[8]+' INSERT INTO DB');
//        FORM1.Caption:='DF' ;
        TEMPSTRS.Clear;

  //      LeaveCriticalSection(dev_ThreadCritical);
end;
//だ?祘
procedure SplitData;
var
    i,len:integer;
    TempStr:string;
begin
    while not Terminated do begin
      sleep(1000);
      EnterCriticalSection(dev_ThreadCritical);
      with Form1 do
          for i:=0 to sessions do begin
             if session[i].CUsed and (session[i].RecvData<>'') then begin
                len:=strtoint(copy(session[i].RecvData,0,strlen));                   //Get the length of the SendData
                if length(session[i].RecvData)=len+strlen then begin                //IF the length of the session[i].RecvData equal the length of the SendData add the strlen
                    TempStr:=copy(session[i].RecvData,strlen+1,length(session[i].RecvData)-strlen);     //Cut the length in the head of  session[i].RecvData
                    TempStrS.Add(TempStr);                                      //Put the RecvData in the TempStrS
                    session[i].RecvData:='';
                    continue;
                end;
                if length(session[i].RecvData)>len+strlen then begin
                   // session[i].RecvData:=copy(session[i].RecvData,,length(session[i].RecvData)-strlen);
                    TempStr:=copy(session[i].RecvData,strlen+1,len);
                    TempStrS.Add(TempStr); //Put the RecvData in the TempStrS
                    session[i].RecvData:=copy(session[i].RecvData,strlen+len+1,length(session[i].RecvData)-len-strlen);
                  //  richedit3.Text:=richedit3.Text+TempStr+#13#10+session[i].RecvData+#13#10;
                end;
             end;
          end;
          LeaveCriticalSection(dev_ThreadCritical);
      IF TEMPSTRS.Count=TmpStrMax THEN BEGIN
           form1.SaveToDB;
   //        Form1.MEMO1.Lines.Add(DATETIMETOSTR(NOW)+'->'+form1.EdtCaCnt.Text+' DATAS INSERT INTO DB')
      END;

    end;
end;
procedure TForm1.Button1Click(Sender: TObject);
begin
SELF.Close;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  RICHEDIT1.Lines.Clear;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
   richedit2.Lines.Clear;
end;

procedure TForm1.Button4Click(Sender: TObject);
var inifile:Tinifile;
begin
   IF (TRIM(EdtCaCnt.Text)<>'') and (TRIM(EdtPort.Text)<>'') THEN
   BEGIN
       inifile:=Tinifile.create(ExtractFilePath(Application.ExeName)+'S_CONFIG.INI');
       ServerSocket.Port:=STRTOINT(EdtPort.Text);
       TmpStrMax:=STRTOINT(EdtCaCnt.Text);
       inifile.WriteString('ServerBase','cachecount',TRIM(EdtCaCnt.Text));
       inifile.WriteString('ServerBase','port',TRIM(EdtPort.Text));
       SHOWMESSAGE('CONFIGATION HAS BEEN SAVED!');
       button5.Enabled:=true;
   END;
end;

procedure TForm1.EdtPortKeyPress(Sender: TObject; var Key: Char);
begin
      IF NOT (KEY IN ['0'..'9',#8]) THEN
       KEY:=#0;
end;

procedure TForm1.Button5Click(Sender: TObject);
//var     CPUThread:Thandle;
begin
    IF ServerSocket.Active then
        begin
        ServerSocket.Close;
        Terminated:=true;
        Button5.Caption:='START';
        StatusBar1.Panels[0].Text:='SERVER IS CLOSEING';
        StatusBar1.Font.Color:=clred;
        EdtPort.Enabled:=true;
        EdtCaCnt.Enabled:=true;
        end
    else
        begin
        ServerSocket.Port:=STRTOINT(EdtPort.Text);
        ServerSocket.Open;
        Terminated:=false;
        Button5.Caption:='STOP';
        StatusBar1.Panels[0].Text:='SERVER IS WORKING';
        StatusBar1.Font.Color:=clgreen;
        EdtPort.Enabled:=false;
        EdtCaCnt.Enabled:=false;
        end;
        StrThread:=CreateThread(nil,0,@SplitData,nil,0,Tid)    //絯跋だ矪瞶絬祘
end;
procedure TForm1.FormCreate(Sender: TObject);
begin
    ServerSocket.ServerType:=stNonBlocking;
    TEMPSTRS:=TStringList.Create;
end;

procedure TForm1.ServerSocketListen(Sender: TObject;Socket: TCustomWinSocket);
begin
    RichEdit1.Lines.Add('WAITING FOR CLIENT CONNECT...');
end;
procedure TForm1.ServerSocketClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
    i,j:integer;
    CPUThread:Thandle;
    ReceiveText:string;
begin
    for i:=0 to sessions do
    begin
        if session[i].CHandle = Socket.SocketHandle then
        begin
      //    session[i].CSocket.SendText(DATETIMETOSTR(NOW)+': RESPONSE TO '+session[i].CAddress+' INFO HAS BEEN RECEIVED ');
      session[i].CSocket.SendText(' :RESPONSE TO '+session[i].CAddress+' INFO HAS BEEN RECEIVED ');
      //    sleep(3000);
          ReceiveText:=Socket.ReceiveText;
          RichEdit1.Lines.Add(DATETIMETOSTR(NOW)+': RECEIVED FROM '+session[i].CAddress) ;
          j:=1;
          IF ReceiveText='' THEN j:=0;
          IF ReceiveText='TEST' THEN j:=2;
          CASE j OF
             1:BEGIN
                EnterCriticalSection(dev_ThreadCritical);
                session[i].RecvData:=session[i].RecvData+ReceiveText;
                LeaveCriticalSection(dev_ThreadCritical);
                //TEMPSTRS.ADD(ReceiveText);
               // RichEdit1.Lines.Add(DATETIMETOSTR(NOW)+': RECEIVED FROM '+session[i].CAddress) ;
               // IF TEMPSTRS.Count=TmpStrMax THEN SaveToDB;
               END;
             2:BEGIN
//                TEMPSTRS.ADD(ReceiveText);
                RichEdit1.Lines.Add(DATETIMETOSTR(NOW)+': TEST FROM '+session[i].CAddress) ;
                session[i].CSocket.Close;           //IF RECEIVE 'TEST' CHARS THEN CLOSE SESSION
               END
          END;
        END;
    END;
END;
procedure TForm1.ServerSocketClientConnect(Sender: TObject;Socket: TCustomWinSocket);
var
    i,j,k:integer;
    g_success:STRING;
begin
    g_success:='Y';
    j:=0;
    for i:=1 to sessions do
    begin
        if not session[i].CUsed then
        begin
            session[i].CHandle := Socket.SocketHandle ;
            session[i].CSocket := Socket;
//            session[i].CName := Socket.RemoteHost ;
            session[i].CAddress := Socket.RemoteAddress ;
            session[i].CUsed := True;
            Break;
        end;
        j:=i;           //Jゲ﹚单SESSIONS┪タㄏノSESSION玡SESSION絪腹,礚ヴ種竡
    end;
    if j=sessions then       //当线程数达到上限时，自动增加上限值
    begin
    k:=0 ;
        if k=1 then
        begin
        inc(sessions);
        session[i].CHandle := Socket.SocketHandle ;
        session[i].CSocket := Socket;
        session[i].CName := Socket.RemoteHost ;
        session[i].CAddress := Socket.RemoteAddress ;
        session[i].CUsed := True;
        end
        else       begin
        Socket.SendText('  THE NUMBER OF CONNECT IS MAX');
        RichEdit1.Lines.Add(DATETIMETOSTR(NOW)+': CLIENT:  '+inttostr(Socket.SocketHandle)+' THE NUMBER OF CONNECT IS MAX');
        Socket.Close;
        g_success:='N'
        end;
    end;
    IF g_success='Y' THEN
        RichEdit1.Lines.Add(DATETIMETOSTR(NOW)+': CLIENT: '+inttostr(Socket.SocketHandle)+'    ('+Socket.RemoteAddress+ ') ALREADY CONNECTED');
//    IF g_success='N' THEN
//        RichEdit1.Lines.Add(DATETIMETOSTR(NOW)+': CLIENT:   THE NUMBER OF CONNECT IS MAX');
end;

procedure TForm1.ServerSocketClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
    i:integer;
begin
    for i:=0 to sessions do
    begin
        if session[i].CHandle =Socket.SocketHandle then
        begin
            session[i].CHandle :=0;
            session[i].CUsed := False;
            Break;
        end;
    end;
    RichEdit1.Lines.Add(DATETIMETOSTR(NOW)+': CLIENT: '+'('+Socket.RemoteAddress+ ') DISCONNECTED');
end;
 

procedure TForm1.ServerSocketClientError(Sender: TObject;Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
    RichEdit1.Lines.Add(DATETIMETOSTR(NOW)+': CLIENT: ('+Socket.RemoteAddress+ ') CONNECT ERROR ErrorCode='+inttostr(ErrorCode));
    ErrorCode := 0;
end;


procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TEMPSTRS.Free;
end;

procedure TForm1.FormShow(Sender: TObject);
var inifile:Tinifile;
begin
   inifile:=Tinifile.Create(ExtractFilePath(Application.ExeName)+'S_CONFIG.INI');
   IF inifile.FileName='' THEN BEGIN
      SHOWMESSAGE('打开S_CONFIG.INI文件失败,程式将退出');
      application.Terminate;
   END;
   sessions:=ThreadMax;
   TmpStrMax:=inifile.ReadInteger('ServerBase','cachecount',0);
   EdtCaCnt.Text:=inifile.Readstring('ServerBase','cachecount','0');
   EdtPort.Text:=inifile.Readstring('ServerBase','port','0');
   inifile.free;
//   showmessage(datetimetostr(date()));
end;

procedure TForm1.EdtCaCntKeyPress(Sender: TObject; var Key: Char);
begin
      button5.Enabled:=false;
      IF NOT (KEY IN ['0'..'9',#8]) THEN
       KEY:=#0;
end;
procedure TForm1.N5Click(Sender: TObject);
var
   lpData:PNotifyIconData;
BEGIN
      lpData := new(PNotifyIconDataA);
      lpData.cbSize:=sizeof(_NOTIFYICONDATAA);
      lpdata.Wnd:=FORM1.Handle;
      Shell_NotifyIcon(NIM_DELETE,lpData);
      dispose(lpData);
      Form1.Visible := true;

end;

procedure TForm1.N6Click(Sender: TObject);
begin
    application.Terminate;
end;

initialization
  InitializeCriticalSection(dev_ThreadCritical);
finalization
  DeleteCriticalSection(dev_ThreadCritical);
end.

