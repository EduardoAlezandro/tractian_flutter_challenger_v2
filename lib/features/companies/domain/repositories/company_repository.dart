

import 'package:tractian_flutter_challenger_v2/features/companies/domain/entities/company.dart';

abstract class CompanyRepository {
  Future<List<Company>> getCompanies();
}
