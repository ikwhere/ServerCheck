unit sound;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,IniFiles;

type
  TFrmSound = class(TForm)
    ListBox1: TListBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ListBox2: TListBox;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  FrmSound: TFrmSound;
  dev:string;
implementation
USES hardware;
{$R *.dfm}

procedure TFrmSound.Button1Click(Sender: TObject);
begin
   listbox1.Items.Add(listbox2.Items[listbox2.ItemIndex]);
end;

procedure TFrmSound.Button2Click(Sender: TObject);
begin
   listbox1.Items.Delete(listbox1.ItemIndex);
end;

procedure TFrmSound.Button3Click(Sender: TObject);
begin
  listbox1.Clear;
end;

procedure TFrmSound.Button4Click(Sender: TObject);
var i:integer;
var inifile:Tinifile;
    SoundStr:string;
begin
   For i:=0 To Listbox1.Count-1 do begin
       SoundStr:=SoundStr+Listbox1.Items.Strings[i]
   end;
   if dev='CPU' then  MyIniFile.SoundCPU:=SoundStr
   else if dev='MEM' then  MyIniFile.SoundMEM:=SoundStr
   else if dev='NETWORK' then  MyIniFile.SoundNETWORK:=SoundStr;

   inifile:=Tinifile.create(ExtractFilePath(Application.ExeName)+'C_CONFIG.INI');
   inifile.WriteString('Sound',dev,SoundStr);
   inifile.UpdateFile;
   inifile.Free;
   self.Close;
end;

procedure TFrmSound.FormShow(Sender: TObject);
VAR I:integer;
begin
    Listbox1.Clear;
    i:=1;
    if (dev='CPU') AND (MyIniFile.SoundCPU<>'') then
    while i<Length(MyIniFile.SoundCPU) do begin
      Listbox1.Items.Add(MyIniFile.SoundCPU[I]+MyIniFile.SoundCPU[I+1]) ;
      i:=i+2;
    end;
    if dev='MEM' then
    while i<Length(MyIniFile.SoundMEM) do begin
      Listbox1.Items.Add(MyIniFile.SoundMEM[I]+MyIniFile.SoundMEM[I+1]) ;
      i:=i+2;
    end;
    if dev='NETWORK' then
    while i<Length(MyIniFile.SoundNETWORK) do begin
      Listbox1.Items.Add(MyIniFile.SoundNETWORK[I]+MyIniFile.SoundNETWORK[I+1]) ;
      i:=i+2;
    end;
end;

end.
