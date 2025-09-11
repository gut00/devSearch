import 'package:dev_search/src/core/services/ocr_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CoreModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => Dio(BaseOptions(baseUrl: 'https://api.github.com')), export: true),
        Bind.singleton((i) => OcrService(), export: true),
      ];
}
