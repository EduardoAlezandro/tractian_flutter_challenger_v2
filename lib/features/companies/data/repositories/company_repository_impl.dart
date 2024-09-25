
import 'package:tractian_flutter_challenger_v2/features/companies/data/datasources/company_remote_data_source.dart';
import 'package:tractian_flutter_challenger_v2/features/companies/domain/entities/company.dart';
import 'package:tractian_flutter_challenger_v2/features/companies/domain/repositories/company_repository.dart';

class CompanyRepositoryImpl implements CompanyRepository {
  final CompanyRemoteDataSource remoteDataSource;

  CompanyRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Company>> getCompanies() async {
    final models = await remoteDataSource.getCompanies();
    return models;
  }
}
