
import 'package:tractian_flutter_challenger_v2/core/services/api_service.dart';
import 'package:tractian_flutter_challenger_v2/features/assets/data/models/asset_model.dart';
import 'package:tractian_flutter_challenger_v2/features/assets/data/models/component_model.dart';
import 'package:tractian_flutter_challenger_v2/features/assets/data/models/location_model.dart';

abstract class AssetRemoteDataSource {
  Future<List<AssetModel>> getAssets(String companyId);
  Future<List<LocationModel>> getLocations(String companyId);
  Future<List<ComponentModel>> getComponents(String companyId);
}

class AssetRemoteDataSourceImpl implements AssetRemoteDataSource {
  final ApiService apiService;

  AssetRemoteDataSourceImpl(this.apiService);

  @override
  Future<List<AssetModel>> getAssets(String companyId) async {
    final response = await apiService.get('/companies/$companyId/assets');
    return (response as List)
        .map((json) => AssetModel.fromJson(json))
        .toList();
  }

  @override
  Future<List<LocationModel>> getLocations(String companyId) async {
    final response = await apiService.get('/companies/$companyId/locations');
    return (response as List)
        .map((json) => LocationModel.fromJson(json))
        .toList();
  }

  @override
  Future<List<ComponentModel>> getComponents(String companyId) async {
    final assets = await getAssets(companyId);
    final components = assets.where((asset) => asset.sensorType != null).map((asset) {
      return ComponentModel(
        id: asset.id,
        name: asset.name,
        sensorType: asset.sensorType!,
        status: asset.status!,
        parentId: asset.parentId,
        locationId: asset.locationId,
      );
    }).toList();
    return components;
  }
}
