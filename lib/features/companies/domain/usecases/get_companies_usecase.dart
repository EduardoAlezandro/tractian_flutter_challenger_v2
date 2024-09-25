import 'package:tractian_flutter_challenger_v2/features/companies/domain/entities/company.dart';
import 'package:tractian_flutter_challenger_v2/features/companies/domain/repositories/company_repository.dart';

class GetCompaniesUseCase {
  final CompanyRepository repository;

  GetCompaniesUseCase(this.repository);

  Future<List<Company>> call() {
    return repository.getCompanies();
  }
}
