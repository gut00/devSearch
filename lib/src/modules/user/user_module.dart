import 'package:dev_search/src/core/core_module.dart';
import 'package:dev_search/src/modules/repositories/repositories_modules.dart';
import 'package:dev_search/src/modules/user/controller/user_controller.dart';
import 'package:dev_search/src/modules/user/service/user_service.dart';
import 'package:dev_search/src/modules/user/ui/user_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class UserModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
        RepositorieModule(),
      ];

  @override
  List<Bind> get binds => [
        Bind.factory((i) => UserService(i.get()), export: true),
        Bind.singleton((i) => UserController(i.get()), export: true),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => UserPage(userController: Modular.get(), repoController: Modular.get())),
      ];
}
