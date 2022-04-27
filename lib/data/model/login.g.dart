// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Login on _LoginBase, Store {
  final _$idAtom = Atom(name: '_LoginBase.id');

  @override
  int? get id {
    _$idAtom.reportRead();
    return super.id;
  }

  @override
  set id(int? value) {
    _$idAtom.reportWrite(value, super.id, () {
      super.id = value;
    });
  }

  final _$logadoAtom = Atom(name: '_LoginBase.logado');

  @override
  bool get logado {
    _$logadoAtom.reportRead();
    return super.logado;
  }

  @override
  set logado(bool value) {
    _$logadoAtom.reportWrite(value, super.logado, () {
      super.logado = value;
    });
  }

  final _$userAtom = Atom(name: '_LoginBase.user');

  @override
  String get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(String value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$pwdAtom = Atom(name: '_LoginBase.pwd');

  @override
  String get pwd {
    _$pwdAtom.reportRead();
    return super.pwd;
  }

  @override
  set pwd(String value) {
    _$pwdAtom.reportWrite(value, super.pwd, () {
      super.pwd = value;
    });
  }

  final _$_LoginBaseActionController = ActionController(name: '_LoginBase');

  @override
  dynamic setId(int? value) {
    final _$actionInfo =
        _$_LoginBaseActionController.startAction(name: '_LoginBase.setId');
    try {
      return super.setId(value);
    } finally {
      _$_LoginBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setLogado(bool value) {
    final _$actionInfo =
        _$_LoginBaseActionController.startAction(name: '_LoginBase.setLogado');
    try {
      return super.setLogado(value);
    } finally {
      _$_LoginBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setUser(String value) {
    final _$actionInfo =
        _$_LoginBaseActionController.startAction(name: '_LoginBase.setUser');
    try {
      return super.setUser(value);
    } finally {
      _$_LoginBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setPwd(String value) {
    final _$actionInfo =
        _$_LoginBaseActionController.startAction(name: '_LoginBase.setPwd');
    try {
      return super.setPwd(value);
    } finally {
      _$_LoginBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
id: ${id},
logado: ${logado},
user: ${user},
pwd: ${pwd}
    ''';
  }
}
