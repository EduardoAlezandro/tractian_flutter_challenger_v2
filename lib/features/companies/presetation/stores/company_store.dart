
import 'package:mobx/mobx.dart';
import 'package:tractian_flutter_challenger_v2/features/companies/domain/entities/company.dart';
import 'package:tractian_flutter_challenger_v2/features/companies/domain/usecases/get_companies_usecase.dart';

part 'company_store.g.dart';

class CompanyStore = _CompanyStoreBase with _$CompanyStore;

abstract class _CompanyStoreBase with Store {
  final GetCompaniesUseCase getCompaniesUseCase;
  
  _CompanyStoreBase(this.getCompaniesUseCase) {
    fetchCompanies();
  }

  @observable
  ObservableList<Company> companies = ObservableList<Company>();

  @observable
  bool isLoading = false;

  @action
  Future<void> fetchCompanies() async {
    isLoading = true;
    final result = await getCompaniesUseCase();
    companies.addAll(result);
    isLoading = false;
  }
}
