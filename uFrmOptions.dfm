object FrmOptions: TFrmOptions
  Left = 754
  Top = 279
  AutoScroll = False
  Caption = 'Options'
  ClientHeight = 398
  ClientWidth = 412
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PrintScale = poNone
  Scaled = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pgcOptions: TPageControl
    Left = 0
    Top = 0
    Width = 412
    Height = 372
    ActivePage = tsGeneral
    Align = alClient
    TabOrder = 0
    object tsGeneral: TTabSheet
      Caption = 'General'
      object grpGeneral: TGroupBox
        Left = 0
        Top = 100
        Width = 404
        Height = 126
        Align = alClient
        Caption = 'General'
        Constraints.MinHeight = 106
        TabOrder = 0
        DesignSize = (
          404
          126)
        object lblDecimal: TLabel
          Left = 8
          Top = 65
          Width = 41
          Height = 13
          Caption = 'Decimals'
        end
        object lblEdtMaxValue: TLabeledEdit
          Left = 56
          Top = 15
          Width = 343
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 46
          EditLabel.Height = 13
          EditLabel.Caption = 'MaxValue'
          LabelPosition = lpLeft
          LabelSpacing = 5
          TabOrder = 0
          OnKeyPress = lblEdtMaxValueKeyPress
        end
        object lblEdtDirectory: TLabeledEdit
          Left = 56
          Top = 39
          Width = 327
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 44
          EditLabel.Height = 13
          EditLabel.Caption = 'Directory'
          LabelPosition = lpLeft
          LabelSpacing = 5
          ReadOnly = True
          TabOrder = 1
        end
        object btnDirectory: TButton
          Left = 384
          Top = 38
          Width = 17
          Height = 23
          Anchors = [akTop, akRight]
          Caption = '...'
          TabOrder = 2
          OnClick = btnDirectoryClick
        end
        object cbbDecimal: TComboBox
          Left = 56
          Top = 62
          Width = 345
          Height = 21
          BevelInner = bvLowered
          Style = csDropDownList
          Anchors = [akLeft, akTop, akRight]
          ItemHeight = 13
          TabOrder = 3
          OnChange = cbbDecimalChange
          OnKeyPress = cbbDecimalKeyPress
          Items.Strings = (
            '0'
            '1'
            '2'
            '3'
            '4'
            '5')
        end
        object chkAutoSave: TCheckBox
          Left = 8
          Top = 85
          Width = 103
          Height = 17
          Caption = 'AutoSave'
          TabOrder = 4
        end
        object chkExportHeader: TCheckBox
          Left = 115
          Top = 85
          Width = 212
          Height = 17
          Caption = 'Write Header to Exported Files'
          TabOrder = 5
        end
        object chkEditableIndex: TCheckBox
          Left = 8
          Top = 101
          Width = 125
          Height = 17
          Caption = 'Editable Index'
          TabOrder = 6
        end
        object chkResetIndex: TCheckBox
          Left = 136
          Top = 101
          Width = 125
          Height = 17
          Caption = 'Reset Index'
          TabOrder = 7
        end
      end
      object grpLanguage: TGroupBox
        Left = 0
        Top = 0
        Width = 404
        Height = 40
        Align = alTop
        Caption = 'Language'
        TabOrder = 1
        OnDblClick = grpLanguageDblClick
        DesignSize = (
          404
          40)
        object cbbLanguage: TComboBox
          Left = 4
          Top = 16
          Width = 395
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          ItemHeight = 13
          TabOrder = 0
        end
      end
      object rgMeters: TRadioGroup
        Left = 0
        Top = 40
        Width = 404
        Height = 30
        Align = alTop
        Caption = 'Meters (Input)'
        Columns = 2
        Items.Strings = (
          '1 Meter'
          '2 Meter')
        TabOrder = 2
      end
      object rgMetersDisplay: TRadioGroup
        Left = 0
        Top = 70
        Width = 404
        Height = 30
        Align = alTop
        Caption = 'Meters (Displayed)'
        Columns = 3
        Items.Strings = (
          'Both'
          '1 Meter'
          '2 Meter')
        TabOrder = 3
      end
      object grpInfos: TGroupBox
        Left = 0
        Top = 226
        Width = 404
        Height = 118
        Align = alBottom
        Caption = 'Infos'
        TabOrder = 4
        DesignSize = (
          404
          118)
        object lbledtInfo2: TLabeledEdit
          Left = 53
          Top = 69
          Width = 344
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 29
          EditLabel.Height = 13
          EditLabel.Caption = 'Info 2'
          LabelPosition = lpLeft
          LabelSpacing = 5
          TabOrder = 0
        end
        object lbledtInfo1: TLabeledEdit
          Left = 53
          Top = 47
          Width = 344
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 29
          EditLabel.Height = 13
          EditLabel.Caption = 'Info 1'
          LabelPosition = lpLeft
          LabelSpacing = 5
          TabOrder = 1
        end
        object lbledtInfo3: TLabeledEdit
          Left = 53
          Top = 91
          Width = 344
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 29
          EditLabel.Height = 13
          EditLabel.Caption = 'Info 3'
          LabelPosition = lpLeft
          LabelSpacing = 5
          TabOrder = 2
        end
        object rgGridData: TRadioGroup
          Left = 2
          Top = 15
          Width = 400
          Height = 30
          Align = alTop
          Caption = 'Grid Data'
          Columns = 4
          Items.Strings = (
            'Index'
            'Info 1'
            'Info 2'
            'Info 3')
          TabOrder = 3
          OnClick = rgGridDataClick
        end
      end
    end
    object tsPassword: TTabSheet
      Caption = 'Password'
      ImageIndex = 6
      object grpPassword: TGroupBox
        Left = 0
        Top = 0
        Width = 404
        Height = 344
        Align = alClient
        Caption = 'Password'
        TabOrder = 0
        DesignSize = (
          404
          344)
        object lbledtPasswordCurrent: TLabeledEdit
          Left = 2
          Top = 37
          Width = 398
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 65
          EditLabel.Height = 13
          EditLabel.Caption = 'Old Password'
          PasswordChar = '*'
          TabOrder = 0
        end
        object lbledtPasswordNew: TLabeledEdit
          Left = 2
          Top = 85
          Width = 398
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 70
          EditLabel.Height = 13
          EditLabel.Caption = 'New Password'
          PasswordChar = '*'
          TabOrder = 1
        end
        object btnPasswordApply: TButton
          Left = 104
          Top = 174
          Width = 191
          Height = 25
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Apply'
          TabOrder = 3
          OnClick = btnPasswordApplyClick
        end
        object lbledtPasswordNewRetype: TLabeledEdit
          Left = 2
          Top = 127
          Width = 398
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 107
          EditLabel.Height = 13
          EditLabel.Caption = 'Retype new Password'
          PasswordChar = '*'
          TabOrder = 2
        end
      end
    end
    object tsRS232: TTabSheet
      Caption = 'RS232'
      ImageIndex = 1
      object grpRS232: TGroupBox
        Left = 0
        Top = 0
        Width = 404
        Height = 344
        Align = alClient
        Caption = 'RS232'
        TabOrder = 0
        DesignSize = (
          404
          344)
        object lblSerialPort: TLabel
          Left = 1
          Top = 32
          Width = 96
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = 'Port'
        end
        object lblSerialBaudrate: TLabel
          Left = 1
          Top = 55
          Width = 96
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = 'Baudrate'
        end
        object lblSerialDataBits: TLabel
          Left = 1
          Top = 78
          Width = 96
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = 'Databits'
        end
        object lblSerialParity: TLabel
          Left = 1
          Top = 101
          Width = 96
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = 'Parity'
        end
        object lblSerialStopBits: TLabel
          Left = 1
          Top = 126
          Width = 96
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = 'Stopbits'
        end
        object lblDataFormat: TLabel
          Left = 1
          Top = 149
          Width = 96
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = 'DataFormat'
        end
        object cbbSerialDataBits: TSerDataBitsComboBox
          Left = 97
          Top = 75
          Width = 304
          Height = 21
          TabOrder = 3
          Serial = FrmRS232.Serial
          Text = ' Bit'
          Min = db_4
          Max = db_8
        end
        object cbbSerialParity: TSerParityBitComboBox
          Left = 97
          Top = 98
          Width = 304
          Height = 21
          TabOrder = 4
          Serial = FrmRS232.Serial
        end
        object cbbSerialPort: TSerPortComboBox
          Left = 97
          Top = 28
          Width = 304
          Height = 21
          TabOrder = 1
          Serial = FrmRS232.Serial
        end
        object cbbSerialStop: TSerStopBitsComboBox
          Left = 97
          Top = 123
          Width = 304
          Height = 21
          TabOrder = 5
          Serial = FrmRS232.Serial
          Text = ' Bit'
        end
        object cbbSerialBaud: TSerBaudComboBox
          Left = 97
          Top = 52
          Width = 304
          Height = 21
          TabOrder = 2
          Serial = FrmRS232.Serial
          Text = ' Baud'
        end
        object chkSerialActive: TCheckBox
          Left = 344
          Top = 2
          Width = 54
          Height = 17
          Anchors = [akTop, akRight]
          Caption = 'Active'
          TabOrder = 0
          OnClick = chkSerialActiveClick
        end
        object cbbDataFormat: TComboBox
          Left = 97
          Top = 147
          Width = 304
          Height = 21
          BevelInner = bvLowered
          Style = csDropDownList
          Anchors = [akLeft, akTop, akRight]
          ItemHeight = 13
          TabOrder = 6
          OnKeyPress = cbbDataFormatKeyPress
          Items.Strings = (
            'Print1 / Print2'
            'PC Mode')
        end
      end
    end
    object tsWebIO: TTabSheet
      Caption = 'WebIO'
      ImageIndex = 2
      object grpWebIO: TGroupBox
        Left = 0
        Top = 0
        Width = 404
        Height = 344
        Align = alClient
        Caption = 'WebIO'
        TabOrder = 0
        DesignSize = (
          404
          344)
        object lblIP: TLabel
          Left = 40
          Top = 30
          Width = 10
          Height = 13
          Caption = 'IP'
        end
        object lblEdtPort: TLabeledEdit
          Left = 56
          Top = 50
          Width = 342
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 20
          EditLabel.Height = 13
          EditLabel.BiDiMode = bdRightToLeft
          EditLabel.Caption = 'Port'
          EditLabel.ParentBiDiMode = False
          LabelPosition = lpLeft
          LabelSpacing = 5
          TabOrder = 2
          Text = '80'
        end
        object lbledtPassword: TLabeledEdit
          Left = 56
          Top = 75
          Width = 342
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 46
          EditLabel.Height = 13
          EditLabel.Caption = 'Password'
          LabelPosition = lpLeft
          LabelSpacing = 5
          TabOrder = 3
        end
        object chkUseWebIO: TCheckBox
          Left = 344
          Top = 2
          Width = 54
          Height = 17
          Anchors = [akTop, akRight]
          Caption = 'Active'
          TabOrder = 0
          OnClick = chkUseWebIOClick
        end
        object jvIPEdtIP: TJvIPAddress
          Left = 57
          Top = 26
          Width = 341
          Height = 21
          Address = -1062731420
          Anchors = [akLeft, akTop, akRight]
          ParentColor = False
          TabOrder = 1
          OnExit = jvIPEdtIPExit
        end
      end
    end
    object tsPrinter: TTabSheet
      Caption = 'Printer'
      ImageIndex = 4
      object grpPrinter: TGroupBox
        Left = 0
        Top = 41
        Width = 404
        Height = 303
        Align = alClient
        Caption = 'Printer'
        TabOrder = 0
        DesignSize = (
          404
          303)
        object chkPrint: TCheckBox
          Left = 8
          Top = 17
          Width = 73
          Height = 17
          Caption = 'Auto Print'
          TabOrder = 1
        end
        object cbbPrinterFormat: TComboBox
          Left = 8
          Top = 37
          Width = 391
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          ItemHeight = 13
          TabOrder = 2
          Text = '82x10 (1 Line)'
          OnChange = cbbPrinterFormatChange
          Items.Strings = (
            '82x10 (1 Line)'
            '82x50 (5(3) Lines)'
            '82x50 (7(5) Lines) (OrderID)'
            '105x10 (Endless)')
        end
        object chkPrinter_Enabled: TCheckBox
          Left = 344
          Top = 2
          Width = 54
          Height = 17
          Anchors = [akTop, akRight]
          Caption = 'Active'
          TabOrder = 0
          OnClick = chkPrinter_EnabledClick
        end
      end
      object rgPrinterType: TRadioGroup
        Left = 0
        Top = 0
        Width = 404
        Height = 41
        Align = alTop
        Caption = 'Printer Type'
        Columns = 2
        Items.Strings = (
          'TSC TTP-245C'
          'TSC TC200')
        TabOrder = 1
      end
    end
    object tsMSSQL: TTabSheet
      Caption = 'Database'
      ImageIndex = 4
      DesignSize = (
        404
        344)
      object datenbankGruppe: TGroupBox
        Left = 0
        Top = 0
        Width = 404
        Height = 187
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Database'
        TabOrder = 0
        DesignSize = (
          404
          187)
        object chkMSSQL_Enabled: TCheckBox
          Left = 344
          Top = 2
          Width = 54
          Height = 17
          Anchors = [akTop, akRight]
          Caption = 'Active'
          TabOrder = 0
        end
        object lbledtMSSQL_Server: TLabeledEdit
          Left = 97
          Top = 28
          Width = 300
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 32
          EditLabel.Height = 13
          EditLabel.Caption = 'Server'
          LabelPosition = lpLeft
          TabOrder = 1
        end
        object lbledtMSSQL_User: TLabeledEdit
          Left = 97
          Top = 94
          Width = 300
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 22
          EditLabel.Height = 13
          EditLabel.Caption = 'User'
          LabelPosition = lpLeft
          TabOrder = 4
        end
        object lbledtMSSQL_Password: TLabeledEdit
          Left = 97
          Top = 116
          Width = 300
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 46
          EditLabel.Height = 13
          EditLabel.Caption = 'Password'
          LabelPosition = lpLeft
          TabOrder = 5
        end
        object lbledtMSSQL_DB: TLabeledEdit
          Left = 97
          Top = 138
          Width = 300
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 13
          EditLabel.Height = 13
          EditLabel.Caption = 'DB'
          LabelPosition = lpLeft
          TabOrder = 6
        end
        object lbledtMSSQL_Table: TLabeledEdit
          Left = 97
          Top = 160
          Width = 300
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 26
          EditLabel.Height = 13
          EditLabel.Caption = 'Table'
          LabelPosition = lpLeft
          TabOrder = 7
        end
        object lbledtMSSQL_Provider: TLabeledEdit
          Left = 97
          Top = 50
          Width = 300
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 40
          EditLabel.Height = 13
          EditLabel.Caption = 'Provider'
          LabelPosition = lpLeft
          TabOrder = 2
        end
        object lbledtMSSQL_DataSource: TLabeledEdit
          Left = 97
          Top = 72
          Width = 300
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 59
          EditLabel.Height = 13
          EditLabel.Caption = 'Data Source'
          LabelPosition = lpLeft
          TabOrder = 3
        end
      end
    end
    object tsBarcode: TTabSheet
      Caption = 'Barcode'
      ImageIndex = 5
      object grpBarcodeDevice: TGroupBox
        Left = 0
        Top = 0
        Width = 404
        Height = 138
        Align = alClient
        Caption = 'Barcode Device'
        TabOrder = 0
        DesignSize = (
          404
          138)
        object lbledtBarcodeHID: TLabeledEdit
          Left = 5
          Top = 29
          Width = 393
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 60
          EditLabel.Height = 13
          EditLabel.Caption = 'Barcode HID'
          ReadOnly = True
          TabOrder = 1
        end
        object lbledtBarcodeText: TLabeledEdit
          Left = 5
          Top = 70
          Width = 393
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 49
          EditLabel.Height = 13
          EditLabel.Caption = 'Last Input'
          ReadOnly = True
          TabOrder = 2
        end
        object btnBarcodeTeachIn: TButton
          Left = 102
          Top = 104
          Width = 191
          Height = 25
          Anchors = [akLeft, akTop, akRight]
          Caption = 'TeachIn'
          TabOrder = 0
          OnClick = btnBarcodeTeachInClick
        end
        object chkBarcodeEnabled: TCheckBox
          Left = 344
          Top = 2
          Width = 53
          Height = 17
          Caption = 'Active'
          TabOrder = 3
          OnClick = chkBarcodeEnabledClick
        end
      end
      object grpBarcodeTarget: TGroupBox
        Left = 0
        Top = 138
        Width = 404
        Height = 206
        Align = alBottom
        Anchors = [akLeft, akTop, akRight, akBottom]
        Caption = 'ScanTarget'
        TabOrder = 1
        DesignSize = (
          404
          206)
        object cbbBarcodeTarget: TComboBox
          Left = 4
          Top = 21
          Width = 396
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 0
          Text = 'Info 1'
          Items.Strings = (
            'Info 1'
            'Info 2'
            'Info 3')
        end
      end
    end
    object tsEthernet: TTabSheet
      Caption = 'Ethernet'
      ImageIndex = 7
      DesignSize = (
        404
        344)
      object grpEthernetIP: TGroupBox
        Left = 0
        Top = 0
        Width = 404
        Height = 69
        Align = alTop
        Caption = 'Ethernet'
        TabOrder = 0
        DesignSize = (
          404
          69)
        object lblEthernetIP: TLabel
          Left = 15
          Top = 25
          Width = 10
          Height = 13
          Caption = 'IP'
        end
        object jvIPEdtEthernet: TJvIPAddress
          Left = 30
          Top = 21
          Width = 369
          Height = 21
          Address = 0
          Anchors = [akLeft, akTop, akRight]
          ParentColor = False
          TabOrder = 0
        end
        object lbledtEthernet_Port: TLabeledEdit
          Left = 30
          Top = 43
          Width = 369
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 20
          EditLabel.Height = 13
          EditLabel.BiDiMode = bdRightToLeft
          EditLabel.Caption = 'Port'
          EditLabel.ParentBiDiMode = False
          LabelPosition = lpLeft
          LabelSpacing = 5
          TabOrder = 1
        end
      end
      object chkEthernet_Active: TCheckBox
        Left = 344
        Top = 2
        Width = 54
        Height = 17
        Anchors = [akTop, akRight]
        Caption = 'Active'
        TabOrder = 1
        OnClick = chkSerialActiveClick
      end
    end
  end
  object pnlControls: TPanel
    Left = 0
    Top = 372
    Width = 412
    Height = 26
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      412
      26)
    object btnApply: TBitBtn
      Left = 5
      Top = 2
      Width = 120
      Height = 22
      Caption = 'Save'
      ModalResult = 6
      TabOrder = 0
      OnClick = btnParameters
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object btnSaveClose: TBitBtn
      Left = 125
      Top = 2
      Width = 163
      Height = 22
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Save and Close'
      TabOrder = 1
      OnClick = btnParameters
      Glyph.Data = {
        F2010000424DF201000000000000760000002800000024000000130000000100
        0400000000007C01000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333334433333
        3333333333388F3333333333000033334224333333333333338338F333333333
        0000333422224333333333333833338F33333333000033422222243333333333
        83333338F3333333000034222A22224333333338F33F33338F33333300003222
        A2A2224333333338F383F3338F33333300003A2A222A222433333338F8333F33
        38F33333000034A22222A22243333338833333F3338F333300004222A2222A22
        2433338F338F333F3338F3330000222A3A2224A22243338F3838F338F3338F33
        0000A2A333A2224A2224338F83338F338F3338F300003A33333A2224A2224338
        333338F338F3338F000033333333A2224A2243333333338F338F338F00003333
        33333A2224A2233333333338F338F83300003333333333A2224A333333333333
        8F338F33000033333333333A222433333333333338F338F30000333333333333
        A224333333333333338F38F300003333333333333A223333333333333338F8F3
        000033333333333333A3333333333333333383330000}
      NumGlyphs = 2
    end
    object btnCancel: TBitBtn
      Left = 289
      Top = 2
      Width = 120
      Height = 22
      Anchors = [akTop, akRight]
      Caption = 'Cancel'
      TabOrder = 2
      OnClick = btnParameters
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
  end
end
