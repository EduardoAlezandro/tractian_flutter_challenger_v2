// lib/bindings/asset_binding.dart

import 'package:get/get.dart';
import 'package:tractian_flutter_challenger_v2/core/services/api_service.dart';
import 'package:tractian_flutter_challenger_v2/features/assets/data/datasources/asset_remote_data_source.dart';
import 'package:tractian_flutter_challenger_v2/features/assets/data/repositories/asset_repository_impl.dart';
import 'package:tractian_flutter_challenger_v2/features/assets/domain/repositories/asset_repository.dart';
import 'package:tractian_flutter_challenger_v2/features/assets/domain/usecases/get_companies_usecase.dart';
import 'package:tractian_flutter_challenger_v2/features/assets/presentation/stores/asset_store.dart';

class AssetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AssetRemoteDataSource>(
      () => AssetRemoteDataSourceImpl(Get.find<ApiService>()),
    );
    Get.lazyPut<AssetRepository>(
      () => AssetRepositoryImpl(Get.find<AssetRemoteDataSource>()),
    );
    Get.lazyPut<GetAssetsUseCase>(
      () => GetAssetsUseCase(Get.find<AssetRepository>()),
    );
    Get.lazyPut<AssetStore>(
      () => AssetStore(Get.find<GetAssetsUseCase>()),
    );
  }
}
