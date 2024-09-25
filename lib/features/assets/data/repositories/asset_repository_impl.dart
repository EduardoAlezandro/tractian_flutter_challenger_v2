import 'package:tractian_flutter_challenger_v2/features/assets/data/datasources/asset_remote_data_source.dart';
import 'package:tractian_flutter_challenger_v2/features/assets/domain/entities/asset.dart';
import 'package:tractian_flutter_challenger_v2/features/assets/domain/entities/component.dart';
import 'package:tractian_flutter_challenger_v2/features/assets/domain/entities/location.dart';
import 'package:tractian_flutter_challenger_v2/features/assets/domain/repositories/asset_repository.dart';

class AssetRepositoryImpl implements AssetRepository {
  final AssetRemoteDataSource remoteDataSource;

  AssetRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Asset>> getAssets(String companyId) async {
    final models = await remoteDataSource.getAssets(companyId);
    return models;
  }

  @override
  Future<List<Location>> getLocations(String companyId) async {
    final models = await remoteDataSource.getLocations(companyId);
    return models;
  }

  @override
  Future<List<Component>> getComponents(String companyId) async {
    final models = await remoteDataSource.getComponents(companyId);
    return models;
  }
}
