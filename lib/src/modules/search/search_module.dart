import 'package:dev_search/src/core/core_module.dart';
import 'package:dev_search/src/modules/repositories/repositories_modules.dart';
import 'package:dev_search/src/modules/search/ui/search_page.dart';
import 'package:dev_search/src/modules/user/user_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SearchModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
        UserModule(),
        RepositorieModule(),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => SearchPage(userController: Modular.get())),
      ];
}
