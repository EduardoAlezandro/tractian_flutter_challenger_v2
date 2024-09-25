// lib/bindings/initial_bindings.dart

import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:tractian_flutter_challenger_v2/core/services/api_service.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<Dio>(
      Dio(BaseOptions(baseUrl: 'https://fake-api.tractian.com')),
      permanent: true,
    );
    Get.put<ApiService>(
      ApiService(Get.find<Dio>()),
      permanent: true,
    );
  }
}
