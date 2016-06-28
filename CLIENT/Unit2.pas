unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient,unit1,IniFiles, Sockets, ScktComp, ComCtrls;

type
  TForm2 = class(TForm)
    BitBtn4: TBitBtn;
    TcpClient1: TTcpClient;
    ClientSocket: TClientSocket;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    EdtIP1: TEdit;
    EdtIP2: TEdit;
    BitBtn1: TBitBtn;
    EdtPort1: TEdit;
    EdtPort2: TEdit;
    BitBtn2: TBitBtn;
    EdtIP3: TEdit;
    EdtPort3: TEdit;
    BitBtn3: TBitBtn;
    GroupBox2: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label7: TLabel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    Edit4: TEdit;
    CheckBox7: TCheckBox;
    Edit5: TEdit;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    Button1: TButton;
    Button4: TButton;
    Button3: TButton;
    Button2: TButton;
    Button6: TButton;
    Button5: TButton;
    GroupBox5: TGroupBox;
    CheckBox11: TCheckBox;
    CheckBox12: TCheckBox;
    CheckBox13: TCheckBox;
    CheckBox14: TCheckBox;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    CheckBox15: TCheckBox;
    BitBtn5: TBitBtn;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    procedure Edit4KeyPress(Sender: TObject; var Key: Char);
    procedure Edit5KeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure ClientSocketConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocketError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation
uses hardware,sound;
{$R *.dfm}

procedure TForm2.Edit4KeyPress(Sender: TObject; var Key: Char);
begin
   IF NOT (KEY IN ['0'..'9',#8]) THEN
       KEY:=#0;
end;

procedure TForm2.Edit5KeyPress(Sender: TObject; var Key: Char);
begin
     IF NOT (KEY IN ['0'..'9',#8]) THEN
       KEY:=#0;
end;

procedure TForm2.FormShow(Sender: TObject);
begin
    EdtIP1.Text:=MyIniFile.Server1IP;
    EdtIP2.Text:=MyIniFile.Server2IP;
    EdtIP3.Text:=MyIniFile.Server3IP;
    EdtPort1.Text:=MyIniFile.Server1Port;
    EdtPort2.Text:=MyIniFile.Server2Port;
    EdtPort3.Text:=MyIniFile.Server3Port;
    Checkbox1.Checked:=MyIniFile.MON;
    Checkbox2.Checked:=MyIniFile.TUS;
    Checkbox3.Checked:=MyIniFile.WED;
    Checkbox4.Checked:=MyIniFile.THU;
    Checkbox5.Checked:=MyIniFile.FRI;
    Checkbox6.Checked:=MyIniFile.SAR;
    Checkbox7.Checked:=MyIniFile.SUN;
    EDIT4.Text:=INTTOSTR(MyIniFile.TIME);
    EDIT5.Text:=INTTOSTR(MyIniFile.Refresh);
end;

procedure TForm2.BitBtn4Click(Sender: TObject);
var inifile:Tinifile;
begin
    MyIniFile.Server1IP:=EdtIP1.Text;
    MyIniFile.Server2IP:=EdtIP2.Text;
    MyIniFile.Server3IP:=EdtIP3.Text;
    MyIniFile.Server1Port:=EdtPort1.Text;
    MyIniFile.Server2Port:=EdtPort2.Text;
    MyIniFile.Server3Port:=EdtPort3.Text;
    MyIniFile.MON:=Checkbox1.Checked;
    MyIniFile.TUS:=Checkbox2.Checked;
    MyIniFile.WED:=Checkbox3.Checked;
    MyIniFile.THU:=Checkbox4.Checked;
    MyIniFile.FRI:=Checkbox5.Checked;
    MyIniFile.SAR:=Checkbox6.Checked;
    MyIniFile.SUN:=Checkbox7.Checked;
    MyIniFile.TIME:=strTOint(EDIT4.Text);
    MyIniFile.Refresh:=strTOint(EDIT5.Text);

   inifile:=Tinifile.create(ExtractFilePath(Application.ExeName)+'C_CONFIG.INI');
   inifile.WriteString('ServerList','Server1IP',MyIniFile.Server1IP);
   inifile.WriteString('ServerList','Server2IP',MyIniFile.Server2IP);
   inifile.WriteString('ServerList','Server3IP',MyIniFile.Server3IP);
   inifile.WriteString('ServerList','Server1Port',MyIniFile.Server1Port);
   inifile.WriteString('ServerList','Server2Port',MyIniFile.Server2Port);
   inifile.WriteString('ServerList','Server3Port',MyIniFile.Server3Port);
   inifile.WriteBool('Time','MON',MyIniFile.MON);
   inifile.WriteBool('Time','TUS',MyIniFile.TUS);
   inifile.WriteBool('Time','WED',MyIniFile.WED);
   inifile.WriteBool('Time','THU',MyIniFile.THU);
   inifile.WriteBool('Time','FRI',MyIniFile.FRI);
   inifile.WriteBool('Time','SAR',MyIniFile.SAR);
   inifile.WriteBool('Time','SUN',MyIniFile.SUN);
   inifile.WriteInteger('Time','TIME',MyIniFile.TIME);
   inifile.WriteInteger('Time','Refresh',MyIniFile.Refresh);
   inifile.UpdateFile;
   inifile.Free;

   FORM1.Timer2.Interval:=MyIniFile.TIME*1000-250;
   self.Close;
end;

procedure TForm2.BitBtn1Click(Sender: TObject);
begin
//    TcpClient1.RemoteHost:=EdtIP1.Text;
//    TcpClient1.RemotePort:=EdtPort1.Text;
    ClientSocket.close;
    ClientSocket.Address:=EdtIP1.Text;
    ClientSocket.Port:=strtoint(EdtPort1.Text);
    TRY
     // ClientSocket.Open;
      ClientSocket.Active:=true;
    EXCEPT
      SHOWMESSAGE('ERROR! TEST FAILED!');
    END;
    ClientSocket.Active:=false;
end;

procedure TForm2.BitBtn2Click(Sender: TObject);
begin
    ClientSocket.close;
    ClientSocket.Address:=EdtIP2.Text;
    ClientSocket.Port:=strtoint(EdtPort2.Text);
    ClientSocket.OPEN;
end;

procedure TForm2.BitBtn3Click(Sender: TObject);
begin
    ClientSocket.Address:=EdtIP3.Text;
    ClientSocket.Port:=strtoint(EdtPort3.Text);
    ClientSocket.close;
    TRY
      ClientSocket.OPEN;
    EXCEPT
      SHOWMESSAGE('ERROR! TEST FAILED!');
    END;
end;
procedure TForm2.ClientSocketConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
    if ClientSocket.Active=TRUE then ClientSocket.Socket.SendText('TEST');
    SHOWMESSAGE('TEST CONNECTION SUCCESSED');
 //   ClientSocket.Active:=false;
end;

procedure TForm2.ClientSocketError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
     CASE ErrorCode OF
        10061: SHOWMESSAGE('IP ERROR');
        10060: SHOWMESSAGE('PORT ERROR');
        10053: SHOWMESSAGE('DISCONNECT AUTOMETICALY')
     END;
     ErrorCode:=0;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
   dev:='CPU';
   FrmSound.ShowModal;
   dev:='';
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
   dev:='MEM';
   FrmSound.ShowModal;
   dev:='';
end;

procedure TForm2.Button6Click(Sender: TObject);
begin
   dev:='NETWORK';
   FrmSound.ShowModal;
   dev:='';
end;

procedure TForm2.Button4Click(Sender: TObject);
var i:integer;
begin
    i:=1;
    while i<Length(MyIniFile.SoundCPU) do begin
      if MyIniFile.SoundCPU[I]+MyIniFile.SoundCPU[I+1]='³¤' then
          Windows.Beep(2000,500)
      else
          Windows.Beep(2000,200);
      sleep(100);
      i:=i+2;
    end;

end;

procedure TForm2.Button2Click(Sender: TObject);
var i:integer;
begin
    i:=1;
    while i<Length(MyIniFile.SoundMEM) do begin
      if MyIniFile.SoundMEM[I]+MyIniFile.SoundMEM[I+1]='³¤' then
          Windows.Beep(2000,500)
      else
          Windows.Beep(2000,200);
      sleep(100);
      i:=i+2;
    end;

end;

procedure TForm2.Button5Click(Sender: TObject);
var i:integer;
begin
    i:=1;
    while i<Length(MyIniFile.SoundNETWORK) do begin
      if MyIniFile.SoundNETWORK[I]+MyIniFile.SoundNETWORK[I+1]='³¤' then
          Windows.Beep(2000,500)
      else
          Windows.Beep(2000,200);
      sleep(100);
      i:=i+2;
    end;

end;

end.
