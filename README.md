# Teste para empresa Ioasys

## 📱Escopo de projeto
Deve ser criado um aplicativo em Flutter com as seguintes especificações:

* Login e acesso de Usuário já registrado
    * Para o login usamos padrões OAuth 2.0. Na resposta de sucesso do login a api retornará 3 custom headers (access-token, client, uid);
    * Para ter acesso as demais APIS precisamos enviar esses 3 custom headers para a API autorizar a requisição;
* Busca de Empresas
* Listagem de Empresas
* Detalhamento de Empresas
# Resultado
#### Apresentação geral:
<img src="https://github.com/prswins/flutter_empresas/blob/master/empresas_flutter_video.gif?raw=true" width="500"/>


| Telas  |   |   |   |
| ------------ | ------------ | ------------ | ------------ |
| Login  | Listagem  | Busca  | Detalhes  |
|  |  |  |  |
| <img src="https://github.com/prswins/flutter_empresas/blob/master/flutter_01.png?raw=true" width="250"/>  |  <img src="https://github.com/prswins/flutter_empresas/blob/master/flutter_04.png" width="250"/> | <img src="https://github.com/prswins/flutter_empresas/blob/master/flutter_02.png" width="250"/>  |  <img src="https://github.com/prswins/flutter_empresas/blob/master/flutter_03.png" width="250"/> |



# Sobre o desenvolvimento
### Instruções
Utilizado MobX(Gerenciar estados), GetIt(Provedor de código) e FVM para versão do SDK do Flutter.

Esse projeto utiliza biblioteca de geração de código para auxiliar no gerenciamento de estados, execute o comando para gerar arquivos:

```
fvm flutter packages pub run build_runner build --delete-conflicting-outputs
```

ou o comando para observer e manter o código sempre sincronizado:

```
fvm flutter packages pub run build_runner watch
```

Caso ocorra algum erro durante do build, utilizar:
```
flutter pub cache repair
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-output
```


## Gerar icone do aplicativo

```

Executar os seguintes comandos
- fvm flutter pub get
- fvm flutter pub run flutter_launcher_icons:main
Obs.: Os icones para iOS devem preencher toda a imagem e não conter bordas transparentes.
```

## Recursos:

* Rotas (Navegação)
* Dio
* Database
* MobX (Reatividade dos dados com a interface)
* GetIt (Provedor de código)
* Code Generation
* Logging
* Injeção de dependecia
* Suporte para diversos idiomas



### Organização das pastas
Núcleo da estrutura

```
empresas_flutter/
|- android
|- build
|- i18n
|- ios
|- lib
|- test
```

Estrutura para o projeto

```
lib/
|- controller/
|- data/
|- services/
|- ui/
|- util/
|- ui/widgets/
|- main.dart
|- routes.dart
```


```
 Banco de dados
- Nome, versão, inserção/alteração de tabelas (/data/local/database_helper.dart
- Tabelas (database.dart)
```

```
 Consumo API
- Configuração de cliente http (/data/network/api_base_helper.dart)
- Função para recuperação de proxy, criado um bridge com código nativo.
```

```
 Gerenciamento de dados (API, Local DB)
- (/data/data_manager.dart)
- Gerar models com https://app.quicktype.io/ a partir de um json (/data/model/)
- Adaptar seguindo exemplo de Login, caso vá utilizar as funcionalidades do mobx nele.
```

```
 Criar um novo Store/Controller 
- Criar dentro do diretório (/controller).
- Para facilitar a geração do código, utilizar o plugin no Visual Studio Code, flutter_mobx e digitar 'mobx' no arquivo criado.
- getIt.registerSingleton<Classe>(Classe()); (main.dart)
```

```
 Resgatar um Store/Controller já registrado
- final store = GetIt.I.get<Classe>();
- Utilizar Observer.
```

```
 Novo idioma para o app 
- Importar o asset no pubspec.yaml
- Dentro do método isSupported da classe '_AppLocalizationsDelegate', adicionar os idiomas, seguindo o modelo: 'pt'
- Dentro do método build, adicionar novo idioma em supportedLocales, seguindo o modelo: Locale('pt', 'BR') (main.dart)
- Criar arquivo json na pasta 'i18n', na raiz do projeto com as traduções, seguindo o modelo: pt.json
- Para resgatar as strings criadas utilizar conforme exemplo: AppLocalizations.tl(key)
```

```
 Gerenciamento de rotas
- Ao criar nova tela, configurá-la no (/services/nav/routes.dart)
- Para utilizar, recuperar a instancia do GetIt, conforme exemplo: GetIt.I.get<NavigationService>().navigateTo(Routes.nomerota);
```

```
 Firebase
- Criar o projeto no Firebase, realizar as configurações conforme exemplo.
- https://firebase.flutter.dev/
- https://pub.dev/packages/firebase_messaging
- https://pub.dev/packages/firebase_crashlytics
```
