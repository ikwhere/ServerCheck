object datadisplay: Tdatadisplay
  Left = 0
  Top = 0
  Width = 349
  Height = 296
  Background.Fixed = False
  HandleTabs = False
  SupportedBrowsers = [brIE, brNetscape6]
  TemplateProcessor = IWTemplateProcessorHTML1
  OnCreate = IWAppFormCreate
  DesignLeft = 341
  DesignTop = 200
  object IWEdit1: TIWEdit
    Left = 160
    Top = 64
    Width = 105
    Height = 25
    ZIndex = 0
    BGColor = clNone
    DoSubmitValidation = True
    Editable = True
    Font.Color = clNone
    Font.Enabled = True
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'IWEdit1'
    MaxLength = 0
    ReadOnly = False
    Required = False
    ScriptEvents = <>
    TabOrder = 0
    PasswordPrompt = False
    Text = '2008/7/1'
  end
  object IWEdit2: TIWEdit
    Left = 216
    Top = 32
    Width = 113
    Height = 25
    ZIndex = 0
    BGColor = clNone
    DoSubmitValidation = True
    Editable = True
    Font.Color = clNone
    Font.Enabled = True
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'IWEdit2'
    MaxLength = 0
    ReadOnly = False
    Required = False
    ScriptEvents = <>
    TabOrder = 1
    PasswordPrompt = False
    Text = '2008/7/31'
  end
  object IWBtnSearch: TIWButton
    Left = 104
    Top = 224
    Width = 89
    Height = 33
    ZIndex = 0
    ButtonType = btButton
    Caption = 'Search'
    Color = clBtnFace
    DoSubmitValidation = True
    Font.Color = clNone
    Font.Enabled = True
    Font.Size = 10
    Font.Style = []
    ScriptEvents = <>
    TabOrder = 2
    OnClick = IWBtnSearchClick
  end
  object IWComboBox1: TIWComboBox
    Left = 16
    Top = 40
    Width = 129
    Height = 25
    ZIndex = 0
    Font.Color = clNone
    Font.Enabled = True
    Font.Size = 10
    Font.Style = []
    ItemsHaveValues = False
    NoSelectionText = '-- No Selection --'
    RequireSelection = True
    ScriptEvents = <>
    UseSize = False
    DoSubmitValidation = True
    Editable = True
    TabOrder = 3
    ItemIndex = -1
    Sorted = False
  end
  object IWButton1: TIWButton
    Left = 216
    Top = 184
    Width = 89
    Height = 33
    ZIndex = 0
    ButtonType = btButton
    Caption = 'Next'
    Color = clBtnFace
    DoSubmitValidation = True
    Font.Color = clNone
    Font.Enabled = True
    Font.Size = 10
    Font.Style = []
    ScriptEvents = <>
    TabOrder = 4
    OnClick = IWButton1Click
  end
  object IWButton2: TIWButton
    Left = 216
    Top = 152
    Width = 89
    Height = 33
    ZIndex = 0
    ButtonType = btButton
    Caption = 'Prior'
    Color = clBtnFace
    DoSubmitValidation = True
    Font.Color = clNone
    Font.Enabled = True
    Font.Size = 10
    Font.Style = []
    ScriptEvents = <>
    TabOrder = 5
    OnClick = IWButton2Click
  end
  object IWDBGrid1: TIWDBGrid
    Left = 104
    Top = 112
    Width = 89
    Height = 49
    ZIndex = 0
    BorderColors.Color = clNone
    BorderColors.Light = clNone
    BorderColors.Dark = clNone
    BGColor = clNone
    BorderSize = 1
    BorderStyle = tfAbove
    CellPadding = 0
    CellSpacing = 0
    Font.Color = clWindowText
    Font.Enabled = True
    Font.Size = 10
    Font.Style = []
    FrameBuffer = 40
    Lines = tlAll
    UseFrame = False
    UseWidth = True
    Columns = <>
    DataSource = DataSource1
    FooterRowCount = 1
    FromStart = False
    HighlightColor = clHighlightText
    HighlightRows = False
    Options = [dgShowTitles]
    RefreshMode = rmAutomatic
    RowLimit = 50
    RollOver = False
    RowClick = False
    RollOverColor = clHighlight
    RowHeaderColor = clNone
    RowAlternateColor = clNone
    RowCurrentColor = clNone
  end
  object IWDynamicChart1: TIWDynamicChart
    Left = 24
    Top = 200
    Width = 41
    Height = 49
    ZIndex = 0
    Colors.Strings = (
      'red'
      'blue'
      'green'
      'yellow'
      'brown')
    Data = IWClientSideDataset1
    ValuesInBars = True
  end
  object IWBtnAnalyse: TIWButton
    Left = 208
    Top = 224
    Width = 89
    Height = 33
    ZIndex = 0
    ButtonType = btButton
    Caption = 'Analyse'
    Color = clBtnFace
    DoSubmitValidation = True
    Font.Color = clNone
    Font.Enabled = True
    Font.Size = 10
    Font.Style = []
    ScriptEvents = <>
    TabOrder = 6
    OnClick = IWBtnAnalyseClick
  end
  object IWTemplateProcessorHTML1: TIWTemplateProcessorHTML
    Enabled = True
    MasterFormTag = True
    TagType = ttIntraWeb
    Left = 40
    Top = 136
  end
  object DataSource1: TDataSource
    Left = 72
    Top = 168
  end
  object IWClientSideDataset1: TIWClientSideDataset
    Left = 16
    Top = 88
  end
end