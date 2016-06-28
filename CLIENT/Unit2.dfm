object Form2: TForm2
  Left = 234
  Top = 151
  Width = 437
  Height = 525
  Caption = #37197#32622#38913#38754
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object BitBtn4: TBitBtn
    Left = 96
    Top = 433
    Width = 81
    Height = 31
    Caption = 'SAVE'
    TabOrder = 0
    OnClick = BitBtn4Click
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 429
    Height = 121
    Align = alTop
    Caption = 'SERVER LIST'
    TabOrder = 1
    object Label1: TLabel
      Left = 23
      Top = 27
      Width = 85
      Height = 13
      AutoSize = False
      Caption = '1'#65283'SERVER  IP'
    end
    object Label2: TLabel
      Left = 23
      Top = 57
      Width = 85
      Height = 13
      AutoSize = False
      Caption = '2'#65283'SERVER  IP'
    end
    object Label3: TLabel
      Left = 263
      Top = 27
      Width = 33
      Height = 13
      AutoSize = False
      Caption = 'PORT'
    end
    object Label4: TLabel
      Left = 263
      Top = 57
      Width = 33
      Height = 13
      AutoSize = False
      Caption = 'PORT'
    end
    object Label5: TLabel
      Left = 23
      Top = 87
      Width = 85
      Height = 13
      AutoSize = False
      Caption = '3'#65283'SERVER  IP'
    end
    object Label6: TLabel
      Left = 263
      Top = 87
      Width = 33
      Height = 13
      AutoSize = False
      Caption = 'PORT'
    end
    object EdtIP1: TEdit
      Left = 119
      Top = 24
      Width = 137
      Height = 21
      TabOrder = 0
    end
    object EdtIP2: TEdit
      Left = 119
      Top = 54
      Width = 137
      Height = 21
      TabOrder = 1
    end
    object BitBtn1: TBitBtn
      Left = 354
      Top = 22
      Width = 33
      Height = 25
      Caption = 'TEST'
      TabOrder = 2
      OnClick = BitBtn1Click
    end
    object EdtPort1: TEdit
      Left = 301
      Top = 24
      Width = 37
      Height = 21
      TabOrder = 3
    end
    object EdtPort2: TEdit
      Left = 301
      Top = 54
      Width = 37
      Height = 21
      TabOrder = 4
    end
    object BitBtn2: TBitBtn
      Left = 354
      Top = 51
      Width = 33
      Height = 25
      Caption = 'TEST'
      TabOrder = 5
      OnClick = BitBtn2Click
    end
    object EdtIP3: TEdit
      Left = 119
      Top = 84
      Width = 137
      Height = 21
      TabOrder = 6
    end
    object EdtPort3: TEdit
      Left = 301
      Top = 84
      Width = 37
      Height = 21
      TabOrder = 7
    end
    object BitBtn3: TBitBtn
      Left = 354
      Top = 81
      Width = 33
      Height = 25
      Caption = 'TEST'
      TabOrder = 8
      OnClick = BitBtn3Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 121
    Width = 429
    Height = 88
    Align = alTop
    Caption = 'TIME'
    TabOrder = 2
    object Label8: TLabel
      Left = 16
      Top = 19
      Width = 42
      Height = 17
      AutoSize = False
      Caption = 'WEEK'
    end
    object Label9: TLabel
      Left = 8
      Top = 52
      Width = 65
      Height = 13
      AutoSize = False
      Caption = 'SEND TIME'
    end
    object Label10: TLabel
      Left = 216
      Top = 52
      Width = 42
      Height = 13
      AutoSize = False
      Caption = 'Refresh'
    end
    object Label11: TLabel
      Left = 344
      Top = 52
      Width = 49
      Height = 13
      AutoSize = False
      Caption = 'Seconds'
    end
    object Label7: TLabel
      Left = 144
      Top = 52
      Width = 49
      Height = 13
      AutoSize = False
      Caption = 'Seconds'
    end
    object CheckBox1: TCheckBox
      Left = 64
      Top = 19
      Width = 49
      Height = 17
      Caption = 'MON'
      TabOrder = 0
    end
    object CheckBox2: TCheckBox
      Left = 112
      Top = 19
      Width = 49
      Height = 17
      Caption = 'TUS'
      TabOrder = 1
    end
    object CheckBox3: TCheckBox
      Left = 160
      Top = 19
      Width = 49
      Height = 17
      Caption = 'WED'
      TabOrder = 2
    end
    object CheckBox4: TCheckBox
      Left = 208
      Top = 19
      Width = 49
      Height = 17
      Caption = 'THU'
      TabOrder = 3
    end
    object CheckBox5: TCheckBox
      Left = 256
      Top = 19
      Width = 49
      Height = 17
      Caption = 'FRI'
      TabOrder = 4
    end
    object CheckBox6: TCheckBox
      Left = 304
      Top = 19
      Width = 49
      Height = 17
      Caption = 'SAR'
      TabOrder = 5
    end
    object Edit4: TEdit
      Left = 80
      Top = 44
      Width = 57
      Height = 21
      MaxLength = 24
      TabOrder = 6
      OnKeyPress = Edit4KeyPress
    end
    object CheckBox7: TCheckBox
      Left = 352
      Top = 19
      Width = 49
      Height = 17
      Caption = 'SUN'
      TabOrder = 7
    end
    object Edit5: TEdit
      Left = 264
      Top = 44
      Width = 65
      Height = 21
      TabOrder = 8
      OnKeyPress = Edit5KeyPress
    end
  end
  object GroupBox3: TGroupBox
    Left = 0
    Top = 209
    Width = 429
    Height = 208
    Align = alTop
    Caption = 'ALERT'
    TabOrder = 3
    object GroupBox4: TGroupBox
      Left = 2
      Top = 15
      Width = 425
      Height = 90
      Align = alTop
      Caption = 'Sound Alert'
      TabOrder = 0
      object Label12: TLabel
        Left = 32
        Top = 24
        Width = 27
        Height = 13
        AutoSize = False
        Caption = 'CPU'
      end
      object Label13: TLabel
        Left = 160
        Top = 24
        Width = 30
        Height = 13
        AutoSize = False
        Caption = 'MEM'
      end
      object Label14: TLabel
        Left = 280
        Top = 24
        Width = 61
        Height = 13
        AutoSize = False
        Caption = 'NETWORK'
      end
      object Label15: TLabel
        Left = 24
        Top = 48
        Width = 41
        Height = 33
        AutoSize = False
        Caption = 'Alert Value'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object Label16: TLabel
        Left = 136
        Top = 56
        Width = 27
        Height = 13
        AutoSize = False
        Caption = '%'
      end
      object Label17: TLabel
        Left = 256
        Top = 56
        Width = 27
        Height = 13
        AutoSize = False
        Caption = '%'
      end
      object Label18: TLabel
        Left = 400
        Top = 56
        Width = 17
        Height = 13
        AutoSize = False
        Caption = '%'
      end
      object Button1: TButton
        Left = 64
        Top = 17
        Width = 25
        Height = 25
        Caption = '...'
        TabOrder = 0
        OnClick = Button1Click
      end
      object Button4: TButton
        Left = 88
        Top = 17
        Width = 33
        Height = 25
        Caption = 'TEST'
        TabOrder = 1
        OnClick = Button4Click
      end
      object Button3: TButton
        Left = 192
        Top = 17
        Width = 25
        Height = 25
        Caption = '...'
        TabOrder = 2
        OnClick = Button3Click
      end
      object Button2: TButton
        Left = 216
        Top = 17
        Width = 33
        Height = 25
        Caption = 'TEST'
        TabOrder = 3
        OnClick = Button2Click
      end
      object Button6: TButton
        Left = 344
        Top = 17
        Width = 25
        Height = 25
        Caption = '...'
        TabOrder = 4
        OnClick = Button6Click
      end
      object Button5: TButton
        Left = 368
        Top = 17
        Width = 33
        Height = 25
        Caption = 'TEST'
        TabOrder = 5
        OnClick = Button5Click
      end
      object Edit1: TEdit
        Left = 64
        Top = 53
        Width = 65
        Height = 21
        TabOrder = 6
      end
      object Edit2: TEdit
        Left = 184
        Top = 53
        Width = 65
        Height = 21
        TabOrder = 7
      end
      object Edit3: TEdit
        Left = 328
        Top = 52
        Width = 65
        Height = 21
        TabOrder = 8
      end
    end
    object GroupBox5: TGroupBox
      Left = 2
      Top = 105
      Width = 425
      Height = 101
      Align = alClient
      Caption = 'Message Alert'
      TabOrder = 1
      object CheckBox11: TCheckBox
        Left = 16
        Top = 20
        Width = 41
        Height = 25
        Caption = 'CPU'
        TabOrder = 0
      end
      object CheckBox12: TCheckBox
        Left = 136
        Top = 20
        Width = 49
        Height = 25
        Caption = 'MEM'
        TabOrder = 1
      end
      object CheckBox13: TCheckBox
        Left = 16
        Top = 60
        Width = 41
        Height = 25
        Caption = 'HD'
        TabOrder = 2
      end
      object CheckBox14: TCheckBox
        Left = 264
        Top = 18
        Width = 81
        Height = 25
        Caption = 'NETWORK'
        TabOrder = 3
      end
      object Button7: TButton
        Left = 64
        Top = 17
        Width = 25
        Height = 25
        Caption = '...'
        TabOrder = 4
      end
      object Button8: TButton
        Left = 88
        Top = 17
        Width = 33
        Height = 25
        Caption = 'TEST'
        TabOrder = 5
      end
      object Button9: TButton
        Left = 192
        Top = 17
        Width = 25
        Height = 25
        Caption = '...'
        TabOrder = 6
      end
      object Button10: TButton
        Left = 216
        Top = 17
        Width = 33
        Height = 25
        Caption = 'TEST'
        TabOrder = 7
      end
      object Button11: TButton
        Left = 344
        Top = 17
        Width = 25
        Height = 25
        Caption = '...'
        TabOrder = 8
      end
      object Button12: TButton
        Left = 368
        Top = 17
        Width = 33
        Height = 25
        Caption = 'TEST'
        TabOrder = 9
      end
      object Button13: TButton
        Left = 64
        Top = 57
        Width = 25
        Height = 25
        Caption = '...'
        TabOrder = 10
      end
      object Button14: TButton
        Left = 88
        Top = 57
        Width = 33
        Height = 25
        Caption = 'TEST'
        TabOrder = 11
      end
      object Button15: TButton
        Left = 192
        Top = 57
        Width = 25
        Height = 25
        Caption = '...'
        TabOrder = 12
      end
      object Button16: TButton
        Left = 216
        Top = 57
        Width = 33
        Height = 25
        Caption = 'TEST'
        TabOrder = 13
      end
      object CheckBox15: TCheckBox
        Left = 136
        Top = 60
        Width = 49
        Height = 25
        Caption = 'MEM'
        TabOrder = 14
      end
    end
  end
  object BitBtn5: TBitBtn
    Left = 216
    Top = 433
    Width = 81
    Height = 31
    Caption = 'Canel'
    TabOrder = 4
    OnClick = BitBtn4Click
  end
  object TcpClient1: TTcpClient
    Left = 30
    Top = 56
  end
  object ClientSocket: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Port = 0
    OnConnect = ClientSocketConnect
    OnError = ClientSocketError
    Left = 46
    Top = 112
  end
end
