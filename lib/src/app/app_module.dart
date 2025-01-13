import 'package:dev_search/splash_view.dart';
import 'package:dev_search/src/core/core_module.dart';
import 'package:dev_search/src/modules/search/search_module.dart';
import 'package:dev_search/src/modules/user/user_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
        UserModule(),
        SearchModule(),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const SplashView()),
        ModuleRoute('/search', module: SearchModule()),
        ModuleRoute('/user', module: UserModule()),
      ];
}
