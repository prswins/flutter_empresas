import 'package:flutter/material.dart';
import 'package:flutter_empresas/controller/home_controller.dart';
import 'package:flutter_empresas/data/network/api_base_helper.dart';
import 'package:flutter_empresas/data/response/getEnterpriseListResponse.dart';
import 'package:flutter_empresas/services/nav/navigation_service.dart';
import 'package:flutter_empresas/services/nav/routes.dart';
import 'package:flutter_empresas/services/notification/local_notification_service.dart';
import 'package:flutter_empresas/util/app_localizations.dart';
import 'package:flutter_empresas/util/colorUtil.dart';
import 'package:flutter_empresas/util/dialogUtil.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchTextController = TextEditingController();
  final controller = GetIt.I.get<HomeController>();

  @override
  void initState() {
    // GetIt.I.get<NotificationService>().setPage(Routes.home);
    super.initState();
    // notification.initNotification();
    GetIt.I.get<LocalNotificationService>().showNotification(
        0,
        AppLocalizations.tl("t_welcome_1_login"),
        AppLocalizations.tl("t_welcome_2_login"),
        3);
  }

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Stack(
            children: [
              Container(
                height: altura * 0.25,
                color: ColorUtil.primary,
                child: Image.asset(
                  'assets/bg.png',
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fill,
                  // scale: .5,
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                    onTap: () => DialogUtil.logout(),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        //"Logout",
                        AppLocalizations.tl("logout_title"),
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    )),
              ),
              Container(
                padding: EdgeInsets.only(top: altura * 0.1),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Text(
                        //"Pesquise por uma empresa",
                        AppLocalizations.tl("t_title_home"),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: altura * 0.2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextField(
                            controller: searchTextController,
                            decoration: InputDecoration(
                              hintText:
                                  // "Digite...",
                                  AppLocalizations.tl("tf_search_input_home"),
                            ),
                            onChanged: onItemChanged,
                            style: TextStyle(color: Colors.grey, fontSize: 11),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: altura * 0.30),
                child: Column(
                  children: [
                    Observer(builder: (_) {
                      switch (controller.searchState) {
                        case SearchState.EMPTY:
                          return Center(
                              child: Text(
                            "Não foram encontrados itens",
                            style: TextStyle(color: ColorUtil.primary),
                          ));
                        case SearchState.LOADING:
                          return Center(
                              child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                ColorUtil.primary),
                          ));

                        case SearchState.SUCESS:
                          return Expanded(
                              child: ListView.builder(
                                  itemCount: controller.listaLocal.length,
                                  itemBuilder: (context, index) {
                                    //return Text(controller.listaLocal[index].enterpriseName);
                                    return EmpresaItem(
                                        empresa: controller.listaLocal[index]);
                                  }));
                        default:
                          return SizedBox();
                      }
                    })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onItemChanged(String value) async {
    if (value.length > 3)
      controller.buscarEmpresas(buscaNome: value);
    else
      controller.buscarEmpresas(buscaNome: "");
  }
}

class EmpresaItem extends StatelessWidget {
  const EmpresaItem({
    Key? key,
    required this.empresa,
  }) : super(key: key);
  final Enterpris empresa;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => goToEnterpriseScreen(enterpris: empresa),
      child: ListTile(
        title: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Image.network(
                ApiBaseHelper.dev_host + "${empresa.photo}",
                height: MediaQuery.of(context).size.height * .2,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      color: ColorUtil.primary,
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
            ),
            Center(
              child: Text(
                empresa.enterpriseName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 20,
                        color: Colors.white,
                      ),
                      Shadow(
                        blurRadius: 20,
                        color: Colors.black,
                      )
                    ]),
              ),
            ),
          ],
        ),
        /*subtitle: Column(
          children: [
            Text(empresa.description),
            Column(
              children: [],
            ),
          ],
        ),*/
      ),
    );
  }

  void goToEnterpriseScreen({Enterpris? enterpris}) {
    GetIt.I
        .get<NavigationService>()
        .navigateTo(Routes.enterprise, arguments: enterpris);
  }
}
