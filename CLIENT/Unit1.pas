unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Menus,  ComCtrls, StdCtrls, Buttons, ToolWin,
  MPlayer, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,IniFiles,
  Sockets,Winsock,ScktComp,shellapi, ImgList;
const
  WM_BarIcon=WM_USER+200 ;
const
    SystemBasicInformation   =   0;
    SystemPerformanceInformation   =   2;
    SystemTimeInformation   =   3;
    DRIVE_UNKNOWN     =      0;
    DRIVE_NO_ROOT_DIR  = 1;
    DRIVE_REMOVABLE   =    2;
    DRIVE_FIXED        =       3;
    DRIVE_REMOTE       =      4;
    DRIVE_CDROM        =       5;
    DRIVE_RAMDISK     =      6 ;
type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    Panel1: TPanel;
    ProgressBar1: TProgressBar;
    N4: TMenuItem;
    ProgressBar4: TProgressBar;
    ProgressBar6: TProgressBar;
    Shape1: TShape;
    Shape2: TShape;
    Label4: TLabel;
    ProgressBar2: TProgressBar;
    Label5: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Panel2: TPanel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Shape3: TShape;
    Label17: TLabel;
    RichEdit1: TRichEdit;
    ClientSocket1: TClientSocket;
    Timer2: TTimer;
    ClientSocket3: TClientSocket;
    ClientSocket2: TClientSocket;
    Label18: TLabel;
    PopupMenu1: TPopupMenu;
    N5: TMenuItem;
    N6: TMenuItem;
    ToolBar1: TToolBar;
    BitBtn1: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    HARDWAREINFO: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    procedure N4Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ClientSocket1Read(Sender: TObject;Socket: TCustomWinSocket);
    procedure ClientSocket1Disconnect(Sender: TObject;Socket: TCustomWinSocket);
    procedure ClientSocket1Connect(Sender: TObject;Socket: TCustomWinSocket);
    procedure ClientSocket1Error(Sender: TObject;Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;var ErrorCode: Integer);
    procedure Timer2Timer(Sender: TObject);
    procedure ClientSocket2Connect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocket3Connect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocket2Disconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocket3Disconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocket3Error(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure ClientSocket3Read(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocket2Read(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocket2Error(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure BitBtn5Click(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure RichEdit1Change(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);

  private
    { Private declarations }
     procedure WMBarIcon(var Message:TMessage);message WM_BarIcon;
     procedure WMSysCommand(var Message:TMessage);message WM_SYSCOMMAND;
  public
    { Public declarations }

  end;


var CPUTerminated:boolean;    //┮Τ絬祘い耞北夹в
    CPUPaused:boolean;        //┮Τ絬祘既氨北夹в
    WeekPaused:boolean;       //琍戳い耞夹в  ???
    IPADDESS:STRING;
    Tid:Dword; //CPU THREADID
    CPUThread,CPUThread1:Thandle;


//Function gethostname Lib "" (ByVal hostname$; ByVal HostLen : Long):Long ;stdcall ;external 'WSOCK32.DLL';
//Function gethostbyname Lib "WSOCK32.DLL" (ByVal _hostname$) As Long
var
  Form1: TForm1;


implementation

uses Unit2,hardware;
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
     lpData.hIcon := form1.Icon.Handle;
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
procedure RECONNECT;
begin
//   while  not  CPUTerminated   do BEGIN   // 絬祘
       WHILE CPUPaused DO SLEEP(1000);
       IF NOT (FORM1.ClientSocket1.Active) AND (MyIniFile.Server1IP<>'') AND (MyIniFile.Server1Port<>'') THEN  FORM1.ClientSocket1.Open;
       IF NOT (FORM1.ClientSocket2.Active) AND (MyIniFile.Server2IP<>'') AND (MyIniFile.Server2Port<>'') THEN  FORM1.ClientSocket2.Open;
       IF NOT (FORM1.ClientSocket3.Active) AND (MyIniFile.Server3IP<>'') AND (MyIniFile.Server3Port<>'') THEN  FORM1.ClientSocket3.Open;
      // SLEEP(100000)
//   END;
end;
{procedure TFORM1.MYClientSocketError(Sender: TObject;  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;  var ErrorCode: Integer);
VAR STR,STRNAME:STRING;
begin
    case ErrorCode of
        10060: STR:=' IP ERROR';
        10061: STR:=' PORT ERROR';
        10053: STR:=' DISCONNECT AUTOMETICALY';
    end;
    IF (Sender AS TClientSocket).Name='ClientSocket1' THEN STRNAME:=': 1# SERVER';
    IF (Sender AS TClientSocket).Name='ClientSocket2' THEN STRNAME:=': 2# SERVER';
    IF (Sender AS TClientSocket).Name='ClientSocket3' THEN STRNAME:=': 3# SERVER';
    richedit1.lines.add(datetimetostr(now)+STRNAME+(sender as TClientSocket).HOST+'('+(sender as TClientSocket).Address+')' +STR);
    ErrorCode := 0;
end;      }
//当与服务器端的连接发生错误时
procedure TForm1.ClientSocket1Error(Sender: TObject;Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;var ErrorCode: Integer);
VAR STR:STRING;
begin
    case ErrorCode of
        10060: STR:=' IP ERROR';
        10061: STR:=' PORT ERROR';
        10053: STR:=' DISCONNECT AUTOMETICALY';
        ELSE  STR:=' UNKNOW ERROR'+' '+INTTOSTR(ErrorCode);
    end;
    richedit1.lines.add(datetimetostr(now)+':  1# SERVER '+MyIniFile.Server1IP+STR);
    ErrorCode := 0;
    Socket.Close;
end;
//当断开与服务器端的连接时发生
procedure TForm1.ClientSocket1Disconnect(Sender: TObject;Socket: TCustomWinSocket);
begin
    richedit1.lines.add(datetimetostr(now)+ ': CONNECTION OF '+ Socket.RemoteAddress +' IS DISCONNECTED');
end;

//已经连接到服务器端
procedure TForm1.ClientSocket1Connect(Sender: TObject;Socket: TCustomWinSocket);
begin
//    if ClientSocket1.Active=TRUE then ClientSocket1.Socket.SendText(SENDSTR);
    richedit1.lines.add(datetimetostr(now)+': CONNECTION OF '+ Socket.RemoteAddress+' IS CONNECTED') ;
end;

procedure TForm1.ClientSocket1Read(Sender: TObject;
  Socket: TCustomWinSocket);
begin
   RICHEDIT1.Lines.Add(DATETIMETOSTR(NOW)+Socket.ReceiveText);
end;

procedure Senddata_code(ClientSocket:TClientSocket);
VAR StrLen,SENDSTR:STRING;          //祇癳跑秖
    len:integer;
    Ldata:integer;
begin
   SENDSTR:=IPADDESS+','+FORMATFLOAT('0.0',CPUhandle.CUsage)+','+INTTOSTR(CPUhandle.CNumber)+','+
            FORMATFLOAT('0.0',MEMhandle.MUsage*100)+','+FORMATFLOAT('0.0',MEMhandle.VMUsage*100)+','+
              FORMATFLOAT('0.0',HDINFO1.Usage*100)+','+INTTOSTR(HDINFO1.lpFreeClusters)+','+INTTOSTR(HDINFO1.lpTotalClusters)+','+
              datetimetostr(NOW())+','+inttostr(dayofweek(date))+','+datetimetostr(date())+',';
  len:=length(SENDSTR);
  StrLen:='000000000';
  while len>0 do begin
      len:=trunc(len/10);
      StrLen:=copy(StrLen,1,length(StrLen)-1);
  end;
  StrLen:=StrLen+inttostr(length(SENDSTR));      //FORMAT length of data TO 00000XXXX
  ClientSocket.Socket.SendText(StrLen+SENDSTR);

//  if  ClientSocket.Socket.Connected then   ClientSocket.Socket.SendText(StrLen+SENDSTR)
end;
procedure Senddata;
begin
        CASE dayofweek(date) OF
            1:IF MyIniFile.SUN THEN WeekPaused:=FALSE ELSE WeekPaused:=TRUE;
            2:IF MyIniFile.MON THEN WeekPaused:=FALSE ELSE WeekPaused:=TRUE;
            3:IF MyIniFile.TUS THEN WeekPaused:=FALSE ELSE WeekPaused:=TRUE;
            4:IF MyIniFile.WED THEN WeekPaused:=FALSE ELSE WeekPaused:=TRUE;
            5:IF MyIniFile.THU THEN WeekPaused:=FALSE ELSE WeekPaused:=TRUE;
            6:IF MyIniFile.FRI THEN WeekPaused:=FALSE ELSE WeekPaused:=TRUE;
            7:IF MyIniFile.SAR THEN WeekPaused:=FALSE ELSE WeekPaused:=TRUE;
         END;
        IF (MyIniFile.Server1IP<>'') AND (MyIniFile.Server1Port<>'') AND (form1.ClientSocket1.Socket.Connected) THEN
        BEGIN
            Senddata_code(form1.ClientSocket1);
        END;
        IF (MyIniFile.Server2IP<>'') AND (MyIniFile.Server2Port<>'') AND (form1.ClientSocket1.Socket.Connected) THEN
        BEGIN
            Senddata_code(form1.ClientSocket2);
        END;
        IF (MyIniFile.Server3IP<>'') AND (MyIniFile.Server3Port<>'') AND (form1.ClientSocket1.Socket.Connected) THEN
        BEGIN
            Senddata_code(form1.ClientSocket3);
        END;
end;

//==========================NETWORK SECTION END==================================//

procedure TForm1.N4Click(Sender: TObject);
begin
  bitbtn3.Click;
  Form2.SHOWMODAL;
end;
procedure GetHardwareInfo;
var i:integer;
begin
    while not CPUTerminated do begin
        NEW_GetCPUUsage;     // 尿笲︽浪代CPU笲︽瞯,既氨氨陪ボ,ぃ氨絬祘
        IF NOT CPUPaused THEN BEGIN
            Form1.Label15.Caption := 'CPU Number:'+INTTOSTR(CPUhandle.CNumber);
            Form1.Label4.Caption :=FormatFloat( '   CPU   Usage:   0.0%',CPUhandle.CUsage);
            Form1.ProgressBar1.Position:=trunc(CPUhandle.CUsage);
            GetMEMUsage;
            Form1.Label13.Caption:='MEMTotalPhys:'+MEMhandle.MEMTotalPhys;
            Form1.Label14.Caption:='MEMAvailPhys:'+MEMhandle.MEMAvailPhys;
            Form1.Label5.Caption:=FORMATFLOAT('MEMUsage:   0.00%',MEMhandle.MUsage*100);
            Form1.ProgressBar4.Position:=trunc(MEMhandle.MUsage*100);
            Form1.Label6.Caption:=FORMATFLOAT('VirualMEM:   0.00%',MEMhandle.VMUsage*100);
            Form1.ProgressBar2.Position:=trunc(MEMhandle.VMUsage*100);
            GetHDUsage;
            Form1.Label7.Caption:=FORMATFLOAT('HDUsage:   0.00%',HDINFO1.Usage*100);
            Form1.ProgressBar6.Position:=trunc((1-HDINFO1.Usage)*100);
       //     Form1.Label8.Caption:=Form1.Label8.Caption+'ALL'+'                 '+FormatSpace(lpFreeSpace)+'                 '+FormatSpace(lpTotalSpace)+'             '+FORMATFLOAT('0.00%',(1-lpFreeSpace/lpTotalSpace)*100)+#13#10;
            Sleep(MyIniFile.Refresh*1000);
        END;
        //inc(i);
    end;
end;
procedure TForm1.BitBtn1Click(Sender: TObject);
VAR IPADDRESS:TSTRINGS;
I:INTEGER;
begin
    BITBTN1.Enabled:=FALSE;
    BITBTN4.Enabled:=true;
    BITBTN3.Enabled:=true;
//=============GET IP ADDESS=================//

    IPADDRESS:=GetIP;
    form1.Label16.Caption:='';
    FOR I:=0 TO IPADDRESS.Count-1 DO
    begin
        form1.Label16.Caption:=form1.Label16.Caption+#13#10+IPADDRESS[i];
        IF COPY(IPADDRESS[i],1,7)='10.185.' THEN IPADDESS:=IPADDRESS[i];
        IF IPADDESS='' THEN IPADDESS:=IPADDRESS[i];
    end;
//=============OPEN GETCPUUsage Thread=================//
   CPUPaused:=false;
   CPUTerminated:=false;
   CPUThread:=CreateThread(nil,0,@GetHardwareInfo,nil,0,Tid);

   IF (MyIniFile.Server1IP<>'') AND (MyIniFile.Server1Port<>'') THEN
   BEGIN
       ClientSocket1.Address:=MyIniFile.Server1IP;
       ClientSocket1.Port:=strtoint(MyIniFile.Server1Port);
       ClientSocket1.open;
   END;
   IF (MyIniFile.Server2IP<>'') AND (MyIniFile.Server2Port<>'') THEN
   BEGIN
       ClientSocket2.Address:=MyIniFile.Server2IP;
       ClientSocket2.Port:=strtoint(MyIniFile.Server2Port);
       ClientSocket2.open;
    END;
    IF (MyIniFile.Server3IP<>'') AND (MyIniFile.Server3Port<>'') THEN
    BEGIN
       ClientSocket3.Address:=MyIniFile.Server3IP;
       ClientSocket3.Port:=strtoint(MyIniFile.Server3Port);
       ClientSocket3.open;
    END;
   Timer2.Interval:=MyIniFile.TIME*1000-500;
 //  Timer3.enabled:=true;
   Timer2.enabled:=true;
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
begin
   bitbtn4.Enabled:=NOT self.Enabled;
   bitbtn1.Enabled:=true;
    Timer2.Enabled:=False;
    CPUPaused:=true;
     // SuspendThread(Tid)
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
begin
   CPUTerminated:=true;
   Timer2.Enabled:=False;
   ClientSocket1.Close;
   ClientSocket2.Close;
   ClientSocket3.Close;
   Tid:=0;
   Label8.Caption:='';
   Label7.Caption:='';
   Label6.Caption:='';
   Label5.Caption:='';
   Label4.Caption:='';
   Label15.Caption:='';
   Label14.Caption:='';
   Label13.Caption:='';
   ProgressBar1.Position:=0;
   ProgressBar2.Position:=0;
   ProgressBar4.Position:=0;
   ProgressBar6.Position:=0;
   bitbtn3.Enabled:=false;
   bitbtn1.Enabled:=true;
   bitbtn4.Enabled:=false;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
   if not IniFile then exit;
//   if datetimetostr(date())>'2009/8/30' then self.Close;
 //  ClientSocket1.ClientType:=ctNonBlocking;
   //如有多个符合条件的IP则取最后一个
{   ClientSocket1.OnError:=MYClientSocketError;
   ClientSocket2.OnError:=MYClientSocketError;
   ClientSocket3.OnError:=MYClientSocketError;     }
end;

procedure TForm1.N3Click(Sender: TObject);
begin
   self.Close;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
  bitbtn3.Click;
  Form2.SHOWMODAL;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin

  // showmessage(ClientSocket.Owner.Name);
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
//    SuspendThread(CPUThread1);
    Senddata;
//    ResumeThread(CPUThread1);
end;

procedure TForm1.ClientSocket2Connect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
    //if ClientSocket2.Active=TRUE then ClientSocket2.Socket.SendText(SENDSTR);
    richedit1.lines.add(datetimetostr(now)+': CONNECTION OF '+ Socket.RemoteAddress+' IS CONNECTED') ;
end;

procedure TForm1.ClientSocket3Connect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
    //if ClientSocket3.Active=TRUE then ClientSocket3.Socket.SendText(SENDSTR);
    richedit1.lines.add(datetimetostr(now)+' CONNECTION OF '+ Socket.RemoteAddress+' IS CONNECTED') ;
end;

procedure TForm1.ClientSocket2Disconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
    richedit1.lines.add(datetimetostr(now)+ ': CONNECTION OF '+ Socket.RemoteAddress +' IS DISCONNECTED');
end;

procedure TForm1.ClientSocket3Disconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
     richedit1.lines.add(datetimetostr(now)+ ': CONNECTION OF '+ Socket.RemoteAddress +' IS DISCONNECTED');
end;

procedure TForm1.ClientSocket3Error(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
  VAR STR:STRING;
begin
    case ErrorCode of
        10060: STR:=' IP ERROR';
        10061: STR:=' PORT ERROR';
        10053: STR:=' DISCONNECT AUTOMETICALY';
        ELSE  STR:=' UNKNOW ERROR';
    end;
  //  richedit1.lines.add(datetimetostr(now)+':  SERVER '+(sender as TClientSocket).HOST+'('+(sender as TClientSocket).Address+')' +STR);
   richedit1.lines.add(datetimetostr(now)+':  3# SERVER '+MyIniFile.Server3IP+STR);
    ErrorCode := 0;
    Socket.Close;
end;

procedure TForm1.ClientSocket3Read(Sender: TObject;
  Socket: TCustomWinSocket);
begin
    RICHEDIT1.Lines.Add(DATETIMETOSTR(NOW)+Socket.ReceiveText);
end;

procedure TForm1.ClientSocket2Read(Sender: TObject;
  Socket: TCustomWinSocket);
begin
     RICHEDIT1.Lines.Add(DATETIMETOSTR(NOW)+Socket.ReceiveText);
end;

procedure TForm1.ClientSocket2Error(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
  VAR STR:STRING;
begin
    case ErrorCode of
        10060: STR:=' IP ERROR';
        10061: STR:=' PORT ERROR';
        10053: STR:=' DISCONNECT AUTOMETICALY';
        ELSE  STR:=' UNKNOW ERROR';
    end;
    //richedit1.lines.add(datetimetostr(now)+':  SERVER '+(sender as TClientSocket).HOST+'('+(sender as TClientSocket).Address+')' +STR);
    richedit1.lines.add(datetimetostr(now)+':  2# SERVER '+MyIniFile.Server2IP+STR);
    ErrorCode := 0;
    Socket.Close;
end;

procedure TForm1.BitBtn5Click(Sender: TObject);
begin
   RichEdit1.Lines.Clear;
end;

procedure TForm1.Timer3Timer(Sender: TObject);
begin
   // RECONNECT
end;

procedure TForm1.BitBtn6Click(Sender: TObject);
begin
   self.Close;
end;

procedure TForm1.RichEdit1Change(Sender: TObject);
begin
   if richedit1.Lines.Count>10000 then
     richedit1.Lines.SaveToFile('CLIENTLOG'+DATETOSTR(DATE()));
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

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  bitbtn1.Click;
end;
initialization
  InitializeCriticalSection(dev_ThreadCritical);
finalization
  DeleteCriticalSection(dev_ThreadCritical);
end.


