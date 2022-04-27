// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginController on _LoginControllerBase, Store {
  Computed<bool>? _$isValidComputed;

  @override
  bool get isValid => (_$isValidComputed ??= Computed<bool>(() => super.isValid,
          name: '_LoginControllerBase.isValid'))
      .value;
  Computed<dynamic>? _$validateUserComputed;

  @override
  dynamic get validateUser =>
      (_$validateUserComputed ??= Computed<dynamic>(() => super.validateUser,
              name: '_LoginControllerBase.validateUser'))
          .value;
  Computed<dynamic>? _$validatePwdComputed;

  @override
  dynamic get validatePwd =>
      (_$validatePwdComputed ??= Computed<dynamic>(() => super.validatePwd,
              name: '_LoginControllerBase.validatePwd'))
          .value;

  final _$loginListAtom = Atom(name: '_LoginControllerBase.loginList');

  @override
  List<Login> get loginList {
    _$loginListAtom.reportRead();
    return super.loginList;
  }

  @override
  set loginList(List<Login> value) {
    _$loginListAtom.reportWrite(value, super.loginList, () {
      super.loginList = value;
    });
  }

  final _$stateLoginAtom = Atom(name: '_LoginControllerBase.stateLogin');

  @override
  LoginState get stateLogin {
    _$stateLoginAtom.reportRead();
    return super.stateLogin;
  }

  @override
  set stateLogin(LoginState value) {
    _$stateLoginAtom.reportWrite(value, super.stateLogin, () {
      super.stateLogin = value;
    });
  }

  final _$_LoginControllerBaseActionController =
      ActionController(name: '_LoginControllerBase');

  @override
  dynamic setLoginList(List<Login> list) {
    final _$actionInfo = _$_LoginControllerBaseActionController.startAction(
        name: '_LoginControllerBase.setLoginList');
    try {
      return super.setLoginList(list);
    } finally {
      _$_LoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setStateLogin(LoginState state) {
    final _$actionInfo = _$_LoginControllerBaseActionController.startAction(
        name: '_LoginControllerBase.setStateLogin');
    try {
      return super.setStateLogin(state);
    } finally {
      _$_LoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loginList: ${loginList},
stateLogin: ${stateLogin},
isValid: ${isValid},
validateUser: ${validateUser},
validatePwd: ${validatePwd}
    ''';
  }
}
