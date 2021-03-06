unit IWUnit2;
{PUBDIST}

interface

uses
  IWAppForm, IWApplication, IWTypes,ACTIVEX, Controls, ComCtrls,
  IWCompListbox, IWDBStdCtrls, Classes, IWControl, IWGrids, IWDBGrids,
  IWCompEdit, IWLayoutMgr, IWTemplateProcessorHTML, IWCompButton,ADODB, DB,
  IWCompDynamicChart, IWClientSideDatasetBase, IWClientSideDataset;

type
  Tdatadisplay = class(TIWAppForm)
    IWEdit1: TIWEdit;
    IWEdit2: TIWEdit;
    IWTemplateProcessorHTML1: TIWTemplateProcessorHTML;
    IWBtnSearch: TIWButton;
    IWComboBox1: TIWComboBox;
    DataSource1: TDataSource;
    IWButton1: TIWButton;
    IWButton2: TIWButton;
    IWDBGrid1: TIWDBGrid;
    IWDynamicChart1: TIWDynamicChart;
    IWClientSideDataset1: TIWClientSideDataset;
    IWBtnAnalyse: TIWButton;
    procedure IWBtnSearchClick(Sender: TObject);
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWButton2Click(Sender: TObject);
    procedure IWButton1Click(Sender: TObject);
    procedure IWBtnAnalyseClick(Sender: TObject);
  public
  end;

implementation
{$R *.dfm}

uses
  ServerController;
VAR ADOQuery2: TADOQuery;
procedure Tdatadisplay.IWBtnSearchClick(Sender: TObject);
VAR STRSQL:STRING;
begin
    CoInitialize(nil) ;
    IWDBGrid1.Columns.Clear;
    STRSQL:='SELECT SERVER_IP as 服务器IP,cint(CPUUsage) as CPU占用率,CPUNumber as CPU内核数量,cint(MEMUsage) as 内存使用率,cint(VMUsage) as 虚拟内存使用率,cint(HDFreeSpace) as 硬盘空闲空间,cint(HDUsage) as 硬盘使用率,';
    STRSQL:=STRSQL+'HDTotalSpace as 硬盘总空间,';
    STRSQL:=STRSQL+'CNOW as 数据采集时间,CWEEKDAY-1 as 星期 FROM SERVERLOG WHERE CDATE BETWEEN '+#35+IWEdit1.Text+#35+' AND '+#35+IWEdit2.Text+#35+' ';
    if IWComboBox1.Text='' then
        STRSQL:=STRSQL+' AND SERVER_IP='''+IWComboBox1.Text+'''';
    ADOQuery2.SQL.Text:=STRSQL;
    ADOQuery2.Open;
    IF ADOQuery2.RecordCount=0 THEN BEGIN
       EXIT;
    END;
    CounInitialize();
end;

procedure Tdatadisplay.IWAppFormCreate(Sender: TObject);
VAR STRSQL:STRING;
    ADOQuery1: TADOQuery;
begin
    CoInitialize(nil) ;
    ADOQuery2:=TADOQUERY.Create(WEBAPPLICATION);
    ADOQuery2.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=..\SERVER\SERVERLOG.mdb;Persist Security Info=True';
    ADOQuery2.CursorLocation:=clUseServer;
    DataSource1.DataSet:= ADOQuery2;
    ADOQuery1:=TADOQUERY.Create(WEBAPPLICATION);
    ADOQuery1.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=..\SERVER\SERVERLOG.mdb;Persist Security Info=True';
    ADOQuery1.CursorLocation:=clUseServer;
    STRSQL:='SELECT distinct(SERVER_IP) FROM SERVERLOG';
    ADOQuery1.SQL.Text:=STRSQL;
    ADOQuery1.Open;
    WHILE NOT ADOQuery1.Eof DO BEGIN
       IWComboBox1.Items.Add(ADOQuery1.FIELDBYNAME('SERVER_IP').ASSTRING);
       ADOQuery1.Next;
    END;
    IWComboBox1.ItemIndex:=0;
    ADOQuery1.Free;
end;

procedure Tdatadisplay.IWButton2Click(Sender: TObject);
begin
     ADOQuery2.MoveBy(-IWDBGrid1.RowLimit);
 //     DataSource1.DataSet:= ADOQuery2;
end;

procedure Tdatadisplay.IWButton1Click(Sender: TObject);
begin
     ADOQuery2.MoveBy(IWDBGrid1.RowLimit);
//      DataSource1.DataSet:= ADOQuery2;
end;

procedure Tdatadisplay.IWBtnAnalyseClick(Sender: TObject);
VAR STRSQL:STRING;
    ADOQuery1: TADOQuery;
begin
    CoInitialize(nil) ;
    IWDBGrid1.Columns.Clear;
    STRSQL:='SELECT SERVER_IP as 服务器IP,cint(max(CPUUsage)) as 最高CPU占用率,cint(avg(CPUUsage)) as 平均CPU占用率,cint(max(CPUNumber)) as CPU内核数量,'+
            'cint(max(MEMUsage)) as 最高内存使用率,cint(avg(MEMUsage)) as 平均内存使用率,cint(max(VMUsage)) as 最高虚拟内存使用率,cint(avg(VMUsage)) as 平均虚拟内存使用率,'+
            'cint(avg(HDFreeSpace)) as 硬盘空闲空间MB,cint(avg(HDUsage)) as 硬盘使用率, CLng(MIN(HDFreeSpace)/((MAX(HDFreeSpace)-MIN(HDFreeSpace))/'+
            '(#'+IWEdit2.Text+'#-#'+IWEdit1.Text+'#+1))) AS 预计使用天数'+
            ' FROM SERVERLOG WHERE CDATE BETWEEN '+#35+IWEdit1.Text+#35+' AND '+#35+IWEdit2.Text+#35;
  {  if IWComboBox1.Text<>'' then
        STRSQL:=STRSQL+' AND SERVER_IP='''+IWComboBox1.Text+''''
    else  }
    STRSQL:=STRSQL+'  GROUP BY SERVER_IP';
    ADOQuery2.SQL.Text:=STRSQL;
    ADOQuery2.Open;
    IF ADOQuery2.RecordCount=0 THEN BEGIN
       EXIT;
    END;
    
 {   ADOQuery1:=TADOQUERY.Create(WEBAPPLICATION);
    ADOQuery1.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=..\SERVER\SERVERLOG.mdb;Persist Security Info=True';
    ADOQuery1.CursorLocation:=clUseServer;   }
//    STRSQL:='SELECT MAX(HDFreeSpace) as HDMAX-MIN(HDFreeSpace) as HDMIN FROM SERVERLOG WHERE CDATE BETWEEN'''+IWEdit1.Text+''' AND '''+IWEdit2.Text ';

    CounInitialize();
end;

end.
