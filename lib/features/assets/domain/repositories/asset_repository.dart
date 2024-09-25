import 'package:tractian_flutter_challenger_v2/features/assets/domain/entities/asset.dart';
import 'package:tractian_flutter_challenger_v2/features/assets/domain/entities/component.dart';
import 'package:tractian_flutter_challenger_v2/features/assets/domain/entities/location.dart';

abstract class AssetRepository {
  Future<List<Asset>> getAssets(String companyId);
  Future<List<Location>> getLocations(String companyId);
  Future<List<Component>> getComponents(String companyId);
}
