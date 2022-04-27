import 'package:flutter_empresas/data/response/postLoginResponse.dart';
import 'package:mobx/mobx.dart';
part 'profile_controller.g.dart';

class ProfileController = _ProfileControllerBase with _$ProfileController;

abstract class _ProfileControllerBase with Store {
  
  @observable
  PostLoginResponse? usuario;

  @action
  setUsuario(PostLoginResponse response) => usuario = response;
}
