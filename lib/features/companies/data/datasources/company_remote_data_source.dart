import 'package:tractian_flutter_challenger_v2/core/services/api_service.dart';
import 'package:tractian_flutter_challenger_v2/features/companies/data/model/company_model.dart';

abstract class CompanyRemoteDataSource {
  Future<List<CompanyModel>> getCompanies();
}

class CompanyRemoteDataSourceImpl implements CompanyRemoteDataSource {
  final ApiService apiService;

  CompanyRemoteDataSourceImpl(this.apiService);

  @override
  Future<List<CompanyModel>> getCompanies() async {
    final response = await apiService.get('/companies');
    return (response as List)
        .map((json) => CompanyModel.fromJson(json))
        .toList();
  }
}
