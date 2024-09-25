import 'package:tractian_flutter_challenger_v2/features/assets/domain/repositories/asset_repository.dart';

class GetAssetsUseCase {
  final AssetRepository repository;

  GetAssetsUseCase(this.repository);

  Future<Map<String, dynamic>> call(String companyId) async {
    final assets = await repository.getAssets(companyId);
    final locations = await repository.getLocations(companyId);
    final components = await repository.getComponents(companyId);

    return {
      'assets': assets,
      'locations': locations,
      'components': components,
    };
  }
}
