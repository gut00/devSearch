import 'package:dev_search/src/core/core_module.dart';
import 'package:dev_search/src/modules/repositories/controller/repo_controller.dart';
import 'package:dev_search/src/modules/repositories/service/repo_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RepositorieModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  List<Bind> get binds => [
        Bind.factory((i) => RepoService(i.get<Dio>()), export: true),
        Bind.singleton((i) => RepoController(i.get<RepoService>()), export: true),
      ];
}
