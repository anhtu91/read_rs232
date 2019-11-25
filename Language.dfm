object FrmLanguage: TFrmLanguage
  Left = 24
  Top = 42
  Width = 1284
  Height = 961
  Caption = 'Languager'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PrintScale = poNone
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LabelProgressing: TLabel
    Left = 288
    Top = 32
    Width = 288
    Height = 37
    Alignment = taCenter
    Caption = 'Verarbeite Daten...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object PnlGround: TPanel
    Left = 0
    Top = 0
    Width = 1268
    Height = 922
    Align = alClient
    BevelOuter = bvNone
    Caption = 'PnlGround'
    TabOrder = 0
    object PageControl: TPageControl
      Left = 0
      Top = 0
      Width = 1268
      Height = 922
      ActivePage = tsLanguageAutom
      Align = alClient
      TabOrder = 0
      OnChange = PageControlChange
      object TabSheetExclusion: TTabSheet
        Caption = 'Exclusion'
        ImageIndex = 3
        object PanelLangExclusionGround: TPanel
          Left = 0
          Top = 0
          Width = 1260
          Height = 894
          Align = alClient
          ParentBackground = False
          TabOrder = 0
          object SplitterSeperator: TSplitter
            Left = 507
            Top = 1
            Height = 892
          end
          object PanelComponents: TPanel
            Left = 1
            Top = 1
            Width = 506
            Height = 892
            Align = alLeft
            TabOrder = 0
            object SplitterComponents: TSplitter
              Left = 251
              Top = 41
              Height = 850
            end
            object pnlExclusionRuntime: TPanel
              Left = 1
              Top = 1
              Width = 504
              Height = 40
              Align = alTop
              BevelInner = bvRaised
              BevelOuter = bvLowered
              Caption = 'RunTime-Components'
              Color = clGray
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
            end
            object PanelBoxComponents: TPanel
              Left = 1
              Top = 41
              Width = 250
              Height = 850
              Align = alLeft
              Caption = 'PanelBoxComponents'
              TabOrder = 1
              object ListBoxComponents: TListBox
                Left = 1
                Top = 21
                Width = 248
                Height = 828
                Align = alClient
                ItemHeight = 13
                MultiSelect = True
                Sorted = True
                TabOrder = 0
              end
              object PnlListComponentsHeader: TPanel
                Left = 1
                Top = 1
                Width = 248
                Height = 20
                Align = alTop
                BevelInner = bvRaised
                BevelOuter = bvLowered
                Caption = 'All'
                Color = clGray
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -13
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 1
              end
            end
            object PnlOtherCompoents: TPanel
              Left = 254
              Top = 41
              Width = 251
              Height = 850
              Align = alClient
              TabOrder = 2
              object PnlFilteredComponentsHeader: TPanel
                Left = 1
                Top = 1
                Width = 249
                Height = 20
                Align = alTop
                BevelInner = bvRaised
                BevelOuter = bvLowered
                Caption = 'Filter (Wildcard supported)'
                Color = clGray
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -13
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 0
              end
              object ListBoxComponentsFiltered: TListBox
                Left = 1
                Top = 45
                Width = 249
                Height = 804
                Align = alClient
                ItemHeight = 13
                MultiSelect = True
                Sorted = True
                TabOrder = 1
              end
              object PanelFilterComponents: TPanel
                Left = 1
                Top = 21
                Width = 249
                Height = 24
                Align = alTop
                TabOrder = 2
                object EditFilter: TEdit
                  Left = 0
                  Top = 0
                  Width = 248
                  Height = 21
                  TabOrder = 0
                  OnChange = EditFilterChange
                end
              end
            end
          end
          object PanelExclusions: TPanel
            Left = 510
            Top = 1
            Width = 749
            Height = 892
            Align = alClient
            Caption = 'Panel1'
            TabOrder = 1
            object PnlExclusionHeader: TPanel
              Left = 1
              Top = 1
              Width = 747
              Height = 40
              Align = alTop
              BevelInner = bvRaised
              BevelOuter = bvLowered
              Caption = 'Exclusion-Components'
              Color = clGray
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
            end
            object PanelExcluded: TPanel
              Left = 1
              Top = 41
              Width = 747
              Height = 850
              Align = alClient
              TabOrder = 1
              object SplitterExcluded: TSplitter
                Left = 743
                Top = 1
                Height = 848
                Align = alRight
              end
              object PanelExcludedAll: TPanel
                Left = 1
                Top = 1
                Width = 371
                Height = 848
                Align = alClient
                TabOrder = 0
                object PanelExclusionAllHeader: TPanel
                  Left = 1
                  Top = 1
                  Width = 369
                  Height = 20
                  Align = alTop
                  BevelInner = bvRaised
                  BevelOuter = bvLowered
                  Caption = 'All'
                  Color = clGray
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWhite
                  Font.Height = -13
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                  TabOrder = 0
                end
                object ListBoxExcludes: TListBox
                  Left = 1
                  Top = 21
                  Width = 369
                  Height = 826
                  Align = alClient
                  ItemHeight = 13
                  MultiSelect = True
                  Sorted = True
                  TabOrder = 1
                end
              end
              object PanelExcludedFiltered: TPanel
                Left = 372
                Top = 1
                Width = 371
                Height = 848
                Align = alRight
                TabOrder = 1
                object PanelExcludedFilteredC: TPanel
                  Left = 1
                  Top = 1
                  Width = 369
                  Height = 46
                  Align = alTop
                  TabOrder = 0
                  DesignSize = (
                    369
                    46)
                  object PanelExcludedFilteredHeader: TPanel
                    Left = 1
                    Top = 1
                    Width = 367
                    Height = 20
                    Align = alTop
                    BevelInner = bvRaised
                    BevelOuter = bvLowered
                    Caption = 'Filter (Wildcard supported)'
                    Color = clGray
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWhite
                    Font.Height = -13
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                    TabOrder = 0
                  end
                  object EditExcludedFilter: TEdit
                    Left = 1
                    Top = 20
                    Width = 365
                    Height = 21
                    Anchors = [akLeft, akTop, akRight]
                    TabOrder = 1
                    OnChange = EditExcludedFilterChange
                  end
                end
                object ListBoxExcludedFiltered: TListBox
                  Left = 1
                  Top = 47
                  Width = 369
                  Height = 800
                  Align = alClient
                  ItemHeight = 13
                  MultiSelect = True
                  Sorted = True
                  TabOrder = 1
                end
              end
            end
          end
        end
      end
      object tsLanguageAutom: TTabSheet
        Caption = 'Automatic'
        ImageIndex = 2
        object SplitterAutomatikUpDown: TSplitter
          Left = 0
          Top = 439
          Width = 1260
          Height = 3
          Cursor = crVSplit
          Align = alTop
        end
        object PanelHolderDown: TPanel
          Left = 0
          Top = 442
          Width = 1260
          Height = 452
          Align = alClient
          TabOrder = 0
          object SplitterAutomatikDown: TSplitter
            Left = 732
            Top = 1
            Height = 450
            Align = alRight
            OnMoved = SplitterAutomaticMoved
          end
          object PanelStringGridFileListCompsNotInRuntimeList: TPanel
            Left = 735
            Top = 1
            Width = 524
            Height = 450
            Align = alRight
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 0
            object PnlInCompFileButNotInAppHeader: TPanel
              Left = 2
              Top = 2
              Width = 520
              Height = 40
              Align = alTop
              BevelInner = bvRaised
              BevelOuter = bvLowered
              Caption = 'In Component-File but not found as RunTime-Component'
              Color = clGray
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
            end
          end
          object PanelstringGridRuntimeCompsNotInFileList: TPanel
            Left = 209
            Top = 1
            Width = 523
            Height = 450
            Align = alClient
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 1
            object PnlKompsNotInCompFileHeader: TPanel
              Left = 2
              Top = 2
              Width = 519
              Height = 40
              Align = alTop
              BevelInner = bvRaised
              BevelOuter = bvLowered
              Caption = 'RunTime-Components not found in Component-File'
              Color = clGray
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              ShowHint = False
              TabOrder = 0
            end
          end
          object pgcAutomatic: TPageControl
            Left = 1
            Top = 1
            Width = 208
            Height = 450
            ActivePage = tsAutomaticForms
            Align = alLeft
            TabOrder = 2
            object tsAutomaticForms: TTabSheet
              Caption = 'Forms'
              object SplitterAutomaticControls: TSplitter
                Left = 0
                Top = 327
                Width = 200
                Height = 4
                Cursor = crVSplit
                Align = alBottom
              end
              object PanelAutomaticControls: TPanel
                Left = 0
                Top = 331
                Width = 200
                Height = 91
                Align = alBottom
                TabOrder = 0
                object GrpBoxLCID: TGroupBox
                  Left = 3
                  Top = 1
                  Width = 201
                  Height = 42
                  Caption = 'LCID'
                  TabOrder = 0
                  DesignSize = (
                    201
                    42)
                  object ComboBoxLCID: TComboBox
                    Left = 2
                    Top = 15
                    Width = 197
                    Height = 21
                    Anchors = [akLeft, akTop, akRight, akBottom]
                    ItemHeight = 13
                    TabOrder = 0
                    OnChange = ComboBoxLCIDChange
                    OnKeyPress = ComboBoxLCIDKeyPress
                  end
                end
                object GrpBoxCharSet: TGroupBox
                  Left = 3
                  Top = 45
                  Width = 201
                  Height = 42
                  Caption = 'CharSet'
                  TabOrder = 1
                  DesignSize = (
                    201
                    42)
                  object ComboBoxCharSet: TComboBox
                    Left = 2
                    Top = 15
                    Width = 197
                    Height = 21
                    Anchors = [akLeft, akTop, akRight, akBottom]
                    ItemHeight = 13
                    TabOrder = 0
                    OnChange = ComboBoxCharSetChange
                    OnKeyPress = ComboBoxLCIDKeyPress
                  end
                end
              end
              object GroupBoxForms: TGroupBox
                Left = 0
                Top = 0
                Width = 200
                Height = 327
                Align = alClient
                Caption = 'Forms'
                TabOrder = 1
                object chkLbxForms: TCheckListBox
                  Left = 2
                  Top = 15
                  Width = 196
                  Height = 310
                  OnClickCheck = chkLbxFormsClickCheck
                  Align = alClient
                  ItemHeight = 13
                  Items.Strings = (
                    'FrmMain'
                    'FrmNotMain'
                    'FrmAnythingButMain')
                  TabOrder = 0
                  OnMouseDown = chkLbxFormsMouseDown
                end
              end
            end
            object tsAutomaticComponents: TTabSheet
              Caption = 'Components'
              ImageIndex = 1
              object chklstPropertys: TCheckListBox
                Left = 0
                Top = 0
                Width = 200
                Height = 422
                OnClickCheck = chkLbxFormsClickCheck
                Align = alClient
                ItemHeight = 13
                Items.Strings = (
                  'Self.Caption'
                  'Caption'
                  'Text'
                  'Hint'
                  'Items'
                  'Lines'
                  'Title'
                  'LeftAxis.Title.Caption'
                  'RightAxis.Title.Caption'
                  'TopAxis.Title.Caption'
                  'BottomAxis.Title.Caption'
                  'Title.Text'
                  'Tabs')
                TabOrder = 0
              end
            end
          end
        end
        object PanelHolderUp: TPanel
          Left = 0
          Top = 0
          Width = 1260
          Height = 439
          Align = alTop
          TabOrder = 1
          object SplitterAutomaticUpLeft: TSplitter
            Left = 420
            Top = 1
            Height = 437
            OnMoved = SplitterAutomaticMoved
          end
          object SplitterAutomaticUpRight: TSplitter
            Left = 837
            Top = 1
            Height = 437
            Align = alRight
            OnMoved = SplitterAutomaticMoved
          end
          object PanelStringGridCompsInRuntimeList: TPanel
            Left = 1
            Top = 1
            Width = 419
            Height = 437
            Align = alLeft
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 0
            object PnlLaufzeitKomponentenHeader: TPanel
              Left = 2
              Top = 2
              Width = 415
              Height = 40
              Align = alTop
              BevelInner = bvRaised
              BevelOuter = bvLowered
              Caption = 'RunTime - Components'
              Color = clGray
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
            end
          end
          object PanelStringGridCompsInFileList: TPanel
            Left = 423
            Top = 1
            Width = 414
            Height = 437
            Align = alClient
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 1
            object PnlKomponentenfileHeader: TPanel
              Left = 2
              Top = 2
              Width = 410
              Height = 40
              Align = alTop
              BevelInner = bvRaised
              BevelOuter = bvLowered
              Caption = 'Components in Component-File'
              Color = clGray
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              OnClick = PnlKomponentenfileHeaderClick
            end
          end
          object PanelStringGridSourceStrings: TPanel
            Left = 840
            Top = 1
            Width = 419
            Height = 437
            Align = alRight
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 2
            object PnlSourceStringsHeader: TPanel
              Left = 2
              Top = 2
              Width = 415
              Height = 40
              Align = alTop
              BevelInner = bvRaised
              BevelOuter = bvLowered
              Caption = 'SourceCode Strings'
              Color = clGray
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
            end
          end
        end
      end
      object tsLanguageSource: TTabSheet
        Caption = 'Source'
        ImageIndex = 1
        object SplitterManuelLeftRight: TSplitter
          Left = 657
          Top = 0
          Height = 894
        end
        object PnlManualRight: TPanel
          Left = 660
          Top = 0
          Width = 600
          Height = 894
          Align = alClient
          BevelOuter = bvNone
          Caption = 'PnlManualRight'
          TabOrder = 0
          object PanelSourceCodeControls: TPanel
            Left = 0
            Top = 0
            Width = 600
            Height = 239
            Align = alTop
            TabOrder = 0
            object Memo1: TMemo
              Left = 214
              Top = 1
              Width = 385
              Height = 237
              Align = alClient
              Lines.Strings = (
                '<Index>:'
                'Running Index-Number for the SourceCodeStrings'
                
                  'StartIndex: 1000, (re)-Load of LanguageFiles restores the old Co' +
                  'unt.'
                ''
                'Button <Find next> or Function-Key <F3>:'
                
                  'Searches for the next String in Source (Marked by 2x '#39', Ex: '#39'tes' +
                  't'#39' ) and selects '
                'it'
                ''
                'Button <Replace and find next> or Function-Key <F4>'
                
                  'Once a string was found and is selected it can be Auto-Replaced ' +
                  'with'
                
                  'a '#39'GetCodeString( ID )'#39' reference and will be added to SourceCod' +
                  'e-Strings-'
                'List below.'
                ''
                'Button <Skip and find next> or Function-Key <F5>'
                'Skips current selection and searches for next'
                ''
                ''
                'Once finished a File save it via <Save as> and move the found '
                'SourceCodeStrings into'
                'Automatic-Areal/CompFile by pressing <Move to Automatic>.')
              ScrollBars = ssVertical
              TabOrder = 0
            end
            object PanelControls: TPanel
              Left = 1
              Top = 1
              Width = 213
              Height = 237
              Align = alLeft
              TabOrder = 1
              object btnFindNext: TButton
                Left = 2
                Top = 132
                Width = 209
                Height = 20
                Caption = 'Find next (F3)'
                TabOrder = 1
                OnClick = btnFindNextClick
              end
              object btnReplaceAndFindNext: TButton
                Left = 2
                Top = 153
                Width = 209
                Height = 20
                Caption = 'Replace and find next (F4)'
                TabOrder = 2
                WordWrap = True
                OnClick = btnReplaceAndFindNextClick
              end
              object cbxLeerStringsUeberspringen: TCheckBox
                Left = 102
                Top = 13
                Width = 106
                Height = 19
                Caption = 'Skip empty ('#39#39' / '#39' '#39')'
                Checked = True
                State = cbChecked
                TabOrder = 7
                OnClick = cbxLeerStringsUeberspringenClick
              end
              object cbxKommentiertesUeberspringen: TCheckBox
                Left = 2
                Top = 33
                Width = 210
                Height = 21
                Caption = 'Skip Commented (GetSource..(..)) '
                Checked = True
                State = cbChecked
                TabOrder = 8
                WordWrap = True
                OnClick = cbxKommentiertesUeberspringenClick
              end
              object btnCopyStrings: TButton
                Left = 2
                Top = 215
                Width = 209
                Height = 20
                Caption = 'Move to Automatic'
                TabOrder = 5
                WordWrap = True
                OnClick = btnCopyStringsClick
              end
              object btnScanSources: TButton
                Left = 2
                Top = 194
                Width = 209
                Height = 20
                Caption = 'Scan Sources for Strings'
                TabOrder = 4
                WordWrap = True
                OnClick = btnScanSourcesClick
              end
              object btnSkipAndFindNext: TButton
                Left = 2
                Top = 174
                Width = 209
                Height = 20
                Caption = 'Skip and find next (F5)'
                TabOrder = 3
                WordWrap = True
                OnClick = btnSkipAndFindNextClick
              end
              object GrpBox: TGroupBox
                Left = 1
                Top = 54
                Width = 210
                Height = 51
                Caption = 'Create Dublicates?'
                TabOrder = 9
                object RadioBtnDublicatesYes: TRadioButton
                  Left = 8
                  Top = 15
                  Width = 89
                  Height = 17
                  Caption = 'Yes'
                  TabOrder = 0
                  OnClick = cbxNoDoublicateClick
                end
                object RadioBtnDublicatesAsk: TRadioButton
                  Left = 8
                  Top = 32
                  Width = 192
                  Height = 17
                  Caption = 'Ask'
                  Checked = True
                  TabOrder = 1
                  TabStop = True
                  OnClick = cbxNoDoublicateClick
                end
                object RadioBtnDublicatesNo: TRadioButton
                  Left = 106
                  Top = 15
                  Width = 94
                  Height = 17
                  Caption = 'No'
                  TabOrder = 2
                  OnClick = cbxNoDoublicateClick
                end
              end
              object btnFindPrevious: TButton
                Left = 2
                Top = 111
                Width = 209
                Height = 20
                Caption = 'Find previous (F2)'
                TabOrder = 0
                OnClick = btnFindPreviousClick
              end
              object lbledtFortlaufendeNr: TLabeledEdit
                Left = 1
                Top = 13
                Width = 99
                Height = 21
                EditLabel.Width = 26
                EditLabel.Height = 13
                EditLabel.Caption = 'Index'
                LabelSpacing = 1
                TabOrder = 6
              end
            end
          end
          object GroupBoxManualOutput: TGroupBox
            Left = 0
            Top = 239
            Width = 600
            Height = 655
            Align = alClient
            Caption = 'Sourcecode Strings'
            TabOrder = 1
            object MemoGlobalPas: TMemo
              Left = 2
              Top = 15
              Width = 596
              Height = 638
              Align = alClient
              Color = clHighlightText
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Courier New'
              Font.Style = []
              ParentFont = False
              ScrollBars = ssBoth
              TabOrder = 0
            end
          end
        end
        object PnlManualLeft: TPanel
          Left = 0
          Top = 0
          Width = 657
          Height = 894
          Align = alLeft
          BevelOuter = bvNone
          Caption = 'PnlManualLeft'
          TabOrder = 1
          object GroupBoxManageManual: TGroupBox
            Left = 0
            Top = 0
            Width = 657
            Height = 49
            Align = alTop
            Caption = ' Sourcefile(s)'
            TabOrder = 0
            DesignSize = (
              657
              49)
            object lblSourceFileName: TLabel
              Left = 174
              Top = 11
              Width = 460
              Height = 34
              Anchors = [akLeft, akTop, akRight]
              AutoSize = False
              Caption = '---'
              WordWrap = True
            end
            object btnOpenSourceFile: TButton
              Left = 2
              Top = 16
              Width = 52
              Height = 25
              Caption = 'Load'
              TabOrder = 0
              OnClick = btnOpenSourceFileClick
            end
            object btnSaveSourceFile: TButton
              Left = 54
              Top = 16
              Width = 52
              Height = 25
              Caption = 'Save as'
              TabOrder = 1
              OnClick = btnSaveSourceFileClick
            end
            object btnFontSizePlus: TButton
              Left = 636
              Top = 7
              Width = 18
              Height = 20
              Anchors = [akTop, akRight]
              Caption = '+'
              TabOrder = 4
              OnClick = btnFontSizePlusClick
            end
            object btnFontSizeMinus: TButton
              Left = 636
              Top = 26
              Width = 18
              Height = 20
              Anchors = [akTop, akRight]
              Caption = '-'
              TabOrder = 5
              OnClick = btnFontSizeMinusClick
            end
            object btnSourceFilePrevious: TButton
              Left = 112
              Top = 16
              Width = 22
              Height = 25
              Caption = '<'
              Enabled = False
              TabOrder = 2
              OnClick = btnSourceFilePreviousClick
            end
            object btnSourceFileNext: TButton
              Left = 135
              Top = 16
              Width = 22
              Height = 25
              Caption = '>'
              Enabled = False
              TabOrder = 3
              OnClick = btnSourceFileNextClick
            end
          end
          object MemoSourcefile: TMemo
            Left = 0
            Top = 49
            Width = 657
            Height = 845
            Align = alClient
            ScrollBars = ssBoth
            TabOrder = 1
            OnClick = MemoSourcefileClick
            OnKeyUp = MemoSourcefileKeyUp
            OnMouseUp = MemoSourcefileMouseUp
          end
        end
      end
      object tsLanguageTranslate: TTabSheet
        Caption = 'Translation'
        ImageIndex = 2
        object GroupBoxTranslationGrid: TGroupBox
          Left = 0
          Top = 65
          Width = 1260
          Height = 829
          Align = alClient
          Caption = 'Translation'
          TabOrder = 0
          object StringGridTranslationSplitter2: TSplitter
            Left = 834
            Top = 15
            Height = 812
            Align = alRight
            OnMoved = StringGridTranslationSplitterMoved
          end
          object StringGridTranslationSplitter1: TSplitter
            Left = 410
            Top = 15
            Height = 812
            OnMoved = StringGridTranslationSplitterMoved
          end
          object StringGridTranslationOutput: TStringGrid
            Left = 837
            Top = 15
            Width = 421
            Height = 812
            Align = alRight
            ColCount = 1
            FixedCols = 0
            RowCount = 1
            FixedRows = 0
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing, goTabs]
            TabOrder = 0
            OnDblClick = StringGridObjectsDblClick_Translate
            OnDrawCell = StringGridTranslationOutputDrawCell
            OnEnter = StringGridTranslationOutputEnter
            OnKeyPress = StringGridTranslationOutputKeyPress
            OnMouseWheelDown = StringGridObjectsMouseWheelDown
            OnMouseWheelUp = StringGridObjectsMouseWheelUp
            OnSelectCell = StringGridTranslationOutputSelectCell
            OnTopLeftChanged = StringGridTranslationOutputTopLeftChanged
            ColWidths = (
              64)
            RowHeights = (
              24)
          end
          object StringGridTranslationComponents: TStringGrid
            Left = 2
            Top = 15
            Width = 408
            Height = 812
            Align = alLeft
            ColCount = 1
            FixedCols = 0
            RowCount = 1
            FixedRows = 0
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing, goTabs]
            ScrollBars = ssNone
            TabOrder = 1
            OnDblClick = StringGridObjectsDblClick_Translate
            OnDrawCell = StringGridTranslationComponentsDrawCell
            OnEnter = StringGridTranslationOutputEnter
            OnMouseWheelDown = StringGridObjectsMouseWheelDown
            OnMouseWheelUp = StringGridObjectsMouseWheelUp
            OnSelectCell = StringGridTranslationOutputSelectCell
            ColWidths = (
              64)
            RowHeights = (
              24)
          end
          object StringGridTranslationInput: TStringGrid
            Left = 413
            Top = 15
            Width = 421
            Height = 812
            Align = alClient
            ColCount = 1
            FixedCols = 0
            RowCount = 1
            FixedRows = 0
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing, goTabs]
            ScrollBars = ssNone
            TabOrder = 2
            OnDblClick = StringGridObjectsDblClick_Translate
            OnDrawCell = StringGridTranslationInputDrawCell
            OnEnter = StringGridTranslationOutputEnter
            OnMouseWheelDown = StringGridObjectsMouseWheelDown
            OnMouseWheelUp = StringGridObjectsMouseWheelUp
            OnSelectCell = StringGridTranslationOutputSelectCell
            ColWidths = (
              64)
            RowHeights = (
              24)
          end
        end
        object PanelTranslationTop: TPanel
          Left = 0
          Top = 0
          Width = 1260
          Height = 65
          Align = alTop
          TabOrder = 1
          object PanelLegend: TPanel
            Left = 1059
            Top = 1
            Width = 200
            Height = 63
            Align = alRight
            TabOrder = 0
            object LabelLegendHeader: TLabel
              Left = 1
              Top = 1
              Width = 198
              Height = 12
              Align = alTop
              Alignment = taCenter
              AutoSize = False
              Caption = 'Legend'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object PanelLegendOverSize: TPanel
              Left = 1
              Top = 25
              Width = 198
              Height = 13
              Align = alClient
              Caption = 'Text exceeds Objectwidth'
              Color = clRed
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
            end
            object PanelLegendAutoSize: TPanel
              Left = 1
              Top = 38
              Width = 198
              Height = 12
              Align = alBottom
              Caption = 'AutoSize active'
              Color = clGray
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindow
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 1
            end
            object pnlLegendVCL: TPanel
              Left = 1
              Top = 50
              Width = 198
              Height = 12
              Align = alBottom
              Caption = 'VCL Text different'
              Color = clFuchsia
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindow
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 2
            end
            object pnlLegendVCLComponentMissing: TPanel
              Left = 1
              Top = 13
              Width = 198
              Height = 12
              Align = alTop
              Caption = 'VCL Component missing'
              Color = clSilver
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindow
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 3
            end
          end
          object PanelTranslationControls: TPanel
            Left = 1
            Top = 1
            Width = 1058
            Height = 63
            Align = alClient
            TabOrder = 1
            DesignSize = (
              1058
              63)
            object LabelTranslateInputFile: TLabel
              Left = 301
              Top = 7
              Width = 754
              Height = 15
              AutoSize = False
              Caption = '---'
              WordWrap = True
            end
            object LabelTranslateOutputFile: TLabel
              Left = 301
              Top = 24
              Width = 754
              Height = 15
              AutoSize = False
              Caption = '---'
              WordWrap = True
            end
            object LabelUnfilledLinesCap: TLabel
              Left = 301
              Top = 41
              Width = 68
              Height = 13
              AutoSize = False
              Caption = 'Empty Lines:'
            end
            object LabelUnfilledLines: TLabel
              Left = 364
              Top = 41
              Width = 26
              Height = 13
              Alignment = taCenter
              AutoSize = False
              Caption = '0'
            end
            object GroupBoxInputLanguage: TGroupBox
              Left = 4
              Top = 1
              Width = 118
              Height = 58
              Caption = 'Input'
              TabOrder = 0
              object ButtonLoadInputLanguage: TButton
                Left = 4
                Top = 22
                Width = 110
                Height = 20
                Caption = 'Load'
                TabOrder = 0
                OnClick = ButtonLoadInputLanguageClick
              end
            end
            object GroupBoxOutputLanguage: TGroupBox
              Left = 124
              Top = 1
              Width = 175
              Height = 58
              Caption = 'Output'
              TabOrder = 1
              object ButtonLoadOutputLanguage: TButton
                Left = 3
                Top = 16
                Width = 85
                Height = 20
                Caption = 'Load'
                TabOrder = 0
                OnClick = ButtonLoadOutputLanguageClick
              end
              object ButtonSaveTranslatedLanguage: TButton
                Left = 87
                Top = 16
                Width = 85
                Height = 20
                Caption = 'Save'
                TabOrder = 1
                OnClick = ButtonSaveTranslatedLanguageClick
              end
              object ButtonClearTranslatedLanguage: TButton
                Left = 87
                Top = 35
                Width = 85
                Height = 20
                Caption = 'Clear'
                TabOrder = 2
                OnClick = ButtonClearTranslatedLanguageClick
              end
              object ButtonImportOutputLanguageSK: TButton
                Left = 3
                Top = 35
                Width = 85
                Height = 20
                Caption = 'Import (SK)'
                TabOrder = 3
                OnClick = ButtonImportOutputLanguageSKClick
              end
            end
            object chkTranslateAutoFill: TCheckBox
              Left = 932
              Top = 44
              Width = 125
              Height = 17
              Anchors = [akTop, akRight]
              Caption = 'Auto fill identical texts'
              Checked = True
              State = cbChecked
              TabOrder = 2
            end
            object btnTranslateNextEmpty: TButton
              Left = 423
              Top = 39
              Width = 27
              Height = 17
              Caption = '>'
              TabOrder = 3
              OnClick = FindEmptyLineClick
            end
            object btnTranslatePrevEmpty: TButton
              Left = 395
              Top = 39
              Width = 27
              Height = 17
              Caption = '<'
              TabOrder = 4
              OnClick = FindEmptyLinePrevClick
            end
            object chkHighlightVCLDifference: TCheckBox
              Left = 717
              Top = 44
              Width = 163
              Height = 17
              Anchors = [akTop, akRight]
              Caption = 'Highlight Text different to VCL'
              TabOrder = 5
              OnClick = chkHighlightVCLDifferenceClick
            end
            object btnAutoFill: TButton
              Left = 882
              Top = 45
              Width = 48
              Height = 16
              Caption = 'AutoFill'
              TabOrder = 6
              OnClick = btnAutoFillClick
            end
          end
        end
      end
    end
  end
  object PanelLangProgressing: TPanel
    Left = 157
    Top = 336
    Width = 977
    Height = 145
    TabOrder = 1
    Visible = False
    object lblProcessing: TLabel
      Left = 2
      Top = 32
      Width = 974
      Height = 37
      Alignment = taCenter
      AutoSize = False
      Caption = 'Processing...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ProgressBarLang: TProgressBar
      Left = 7
      Top = 96
      Width = 965
      Height = 26
      TabOrder = 0
    end
  end
  object TimerLanguage: TTimer
    Interval = 500
    OnTimer = TimerLanguageTimer
    Left = 1185
    Top = 807
  end
  object ApplicationEventsFKeys: TApplicationEvents
    OnMessage = ApplicationEventsMessage
    Left = 1188
    Top = 856
  end
end
