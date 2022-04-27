// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  final _$loadingAtom = Atom(name: '_HomeControllerBase.loading');

  @override
  LoadState get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(LoadState value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$searchStateAtom = Atom(name: '_HomeControllerBase.searchState');

  @override
  SearchState get searchState {
    _$searchStateAtom.reportRead();
    return super.searchState;
  }

  @override
  set searchState(SearchState value) {
    _$searchStateAtom.reportWrite(value, super.searchState, () {
      super.searchState = value;
    });
  }

  final _$listaLocalAtom = Atom(name: '_HomeControllerBase.listaLocal');

  @override
  List<Enterpris> get listaLocal {
    _$listaLocalAtom.reportRead();
    return super.listaLocal;
  }

  @override
  set listaLocal(List<Enterpris> value) {
    _$listaLocalAtom.reportWrite(value, super.listaLocal, () {
      super.listaLocal = value;
    });
  }

  final _$_HomeControllerBaseActionController =
      ActionController(name: '_HomeControllerBase');

  @override
  dynamic setLoading(LoadState state) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.setLoading');
    try {
      return super.setLoading(state);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSearchState(SearchState state) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.setSearchState');
    try {
      return super.setSearchState(state);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic listaLocalAddList(List<Enterpris> lista) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.listaLocalAddList');
    try {
      return super.listaLocalAddList(lista);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
searchState: ${searchState},
listaLocal: ${listaLocal}
    ''';
  }
}
