import 'package:flutter/material.dart';
import 'package:flutter_empresas/data/network/api_base_helper.dart';
import 'package:flutter_empresas/data/response/getEnterpriseListResponse.dart';
import 'package:flutter_empresas/services/nav/navigation_service.dart';
import 'package:flutter_empresas/util/colorUtil.dart';
import 'package:get_it/get_it.dart';

class EnterpriseScreen extends StatelessWidget {
  final Enterpris empresa;

  const EnterpriseScreen({
    Key? key,
    required this.empresa,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: GestureDetector(
            onTap: () => GetIt.I.get<NavigationService>().goBack(),
            child: Icon(
              Icons.arrow_back,
              color: Colors.red,
            )),
        title: Text(
          empresa.enterpriseName,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Image.network(
            ApiBaseHelper.dev_host + "${empresa.photo}",
            height: MediaQuery.of(context).size.height * .2,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
          ),
          SizedBox(
            height: 10,
          ),
          empresa.enterpriseType != null &&
                  empresa.enterpriseType!.enterpriseTypeName.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        empresa.enterpriseType!.enterpriseTypeName,
                        style: TextStyle(color: ColorUtil.primary),
                        //+ empresa.description+ empresa.description
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                )
              : SizedBox(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(empresa.description
                //+ empresa.description+ empresa.description
                ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(empresa.country + ", " + empresa.city),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
