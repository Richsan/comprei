// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Hello World!`
  String get helloWorld {
    return Intl.message(
      'Hello World!',
      name: 'helloWorld',
      desc: 'The conventional newborn programmer greeting',
      args: [],
    );
  }

  /// `Invalid Credentials!`
  String get invalidCredentials {
    return Intl.message(
      'Invalid Credentials!',
      name: 'invalidCredentials',
      desc: '',
      args: [],
    );
  }

  /// `User Name`
  String get userName {
    return Intl.message(
      'User Name',
      name: 'userName',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginButton {
    return Intl.message(
      'Login',
      name: 'loginButton',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get signInButton {
    return Intl.message(
      'Sign in',
      name: 'signInButton',
      desc: '',
      args: [],
    );
  }

  /// `Create your account`
  String get registrationScreenTitle {
    return Intl.message(
      'Create your account',
      name: 'registrationScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get registerButton {
    return Intl.message(
      'Register',
      name: 'registerButton',
      desc: '',
      args: [],
    );
  }

  /// `Pick a folder where your account data file will be saved`
  String get databaseDirectory {
    return Intl.message(
      'Pick a folder where your account data file will be saved',
      name: 'databaseDirectory',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Password`
  String get invalidPassword {
    return Intl.message(
      'Invalid Password',
      name: 'invalidPassword',
      desc: '',
      args: [],
    );
  }

  /// `Invalid user name`
  String get invalidUsername {
    return Intl.message(
      'Invalid user name',
      name: 'invalidUsername',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get okButton {
    return Intl.message(
      'OK',
      name: 'okButton',
      desc: '',
      args: [],
    );
  }

  /// `Insert by QR code`
  String get insertByQRCode {
    return Intl.message(
      'Insert by QR code',
      name: 'insertByQRCode',
      desc: '',
      args: [],
    );
  }

  /// `Insert New Purchase`
  String get insertOptionsScreenTitle {
    return Intl.message(
      'Insert New Purchase',
      name: 'insertOptionsScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Insert New Purchase`
  String get insertPurchaseScreenTitle {
    return Intl.message(
      'Insert New Purchase',
      name: 'insertPurchaseScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Account successfully created!`
  String get accountCreatedSuccessfully {
    return Intl.message(
      'Account successfully created!',
      name: 'accountCreatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Purchase successfully saved!`
  String get purchaseSavedSuccessfully {
    return Intl.message(
      'Purchase successfully saved!',
      name: 'purchaseSavedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get saveButton {
    return Intl.message(
      'Save',
      name: 'saveButton',
      desc: '',
      args: [],
    );
  }

  /// `Merchant ID`
  String get merchantID {
    return Intl.message(
      'Merchant ID',
      name: 'merchantID',
      desc: '',
      args: [],
    );
  }

  /// `Tax`
  String get tax {
    return Intl.message(
      'Tax',
      name: 'tax',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Discount`
  String get discount {
    return Intl.message(
      'Discount',
      name: 'discount',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Invalid QR code!`
  String get invalidQRCode {
    return Intl.message(
      'Invalid QR code!',
      name: 'invalidQRCode',
      desc: '',
      args: [],
    );
  }

  /// `QR code has been detected!`
  String get qrCodeDetected {
    return Intl.message(
      'QR code has been detected!',
      name: 'qrCodeDetected',
      desc: '',
      args: [],
    );
  }

  /// `Purchase retrieved!`
  String get purchaseRetrieved {
    return Intl.message(
      'Purchase retrieved!',
      name: 'purchaseRetrieved',
      desc: '',
      args: [],
    );
  }

  /// `Scan a QR code!`
  String get scanCode {
    return Intl.message(
      'Scan a QR code!',
      name: 'scanCode',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get editButton {
    return Intl.message(
      'Edit',
      name: 'editButton',
      desc: '',
      args: [],
    );
  }

  /// `Product Nick Name`
  String get productNicknameHint {
    return Intl.message(
      'Product Nick Name',
      name: 'productNicknameHint',
      desc: '',
      args: [],
    );
  }

  /// `Value`
  String get value {
    return Intl.message(
      'Value',
      name: 'value',
      desc: '',
      args: [],
    );
  }

  /// `Unities`
  String get unities {
    return Intl.message(
      'Unities',
      name: 'unities',
      desc: '',
      args: [],
    );
  }

  /// `Id`
  String get id {
    return Intl.message(
      'Id',
      name: 'id',
      desc: '',
      args: [],
    );
  }

  /// `brand`
  String get brand {
    return Intl.message(
      'brand',
      name: 'brand',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get quantity {
    return Intl.message(
      'Quantity',
      name: 'quantity',
      desc: '',
      args: [],
    );
  }

  /// `Total Value`
  String get totalValue {
    return Intl.message(
      'Total Value',
      name: 'totalValue',
      desc: '',
      args: [],
    );
  }

  /// `Value per {unit}`
  String valuePerUnit(String unit) {
    return Intl.message(
      'Value per $unit',
      name: 'valuePerUnit',
      desc: '',
      args: [unit],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'pt'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
