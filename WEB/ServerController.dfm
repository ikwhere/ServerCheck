object IWServerController: TIWServerController
  OldCreateOrder = False
  OnCreate = IWServerControllerBaseCreate
  AppName = 'MyIWApp'
  BoundIP = '192.168.1.100'
  ComInitialization = ciNormal
  SessionTrackingMethod = tmURL
  Description = 'My Intraweb Application'
  DestinationDevice = ddWeb
  ExceptionDisplayMode = smAlert
  ExecCmd = 'EXEC'
  HistoryEnabled = False
  Port = 801
  RestrictIPs = False
  ShowResyncWarning = True
  SessionTimeout = 10
  SSLPort = 0
  SupportedBrowsers = [brIE, brNetscape6]
  OnNewSession = IWServerControllerBaseNewSession
  Left = 487
  Top = 202
  Height = 310
  Width = 342
  object ADOQuery1: TADOQuery
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=..\SERV' +
      'ER\SERVERLOG.mdb;Persist Security Info=True'
    Parameters = <>
    Left = 80
    Top = 40
  end
end
