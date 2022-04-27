import 'package:dio/dio.dart';
import 'package:flutter_empresas/data/data_manager.dart';
import 'package:flutter_empresas/data/response/getEnterpriseListResponse.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
part 'home_controller.g.dart';

enum LoadState { LOADING_TRUE, LOADING_FALSE }
enum SearchState { EMPTY, LOADING, SUCESS }

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  @observable
  LoadState loading = LoadState.LOADING_FALSE;

  @observable
  SearchState searchState = SearchState.EMPTY;

  @action
  setLoading(LoadState state) => loading = state;

  @action
  setSearchState(SearchState state) => searchState = state;

  @observable
  List<Enterpris> listaLocal = [];

  @action
  listaLocalAddList(List<Enterpris> lista) => listaLocal = lista;

  Future buscarEmpresas( {required String buscaNome}) async {
    setSearchState(SearchState.LOADING);
    await DataManager.instance
        .getEmpresaConsultar(nome: buscaNome, type: null)
        .then((value) {
      if (value != null &&
          value is Response) if (GetEnterpriseListResponse.fromJson(value.data)
              .enterprises!
              .length >
          0) {
        setSearchState(SearchState.SUCESS);
        listaLocalAddList(
            GetEnterpriseListResponse.fromJson(value.data).enterprises!);
        //GetEnterpriseListResponse.fromJson(value.data).enterprises;
      } else {
        if (listaLocal.length > 0) {
          setSearchState(SearchState.EMPTY);
        }
      }
    });
  }
}
