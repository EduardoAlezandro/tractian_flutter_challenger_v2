import 'package:get/get.dart';
import 'package:tractian_flutter_challenger_v2/core/services/api_service.dart';
import 'package:tractian_flutter_challenger_v2/features/companies/data/datasources/company_remote_data_source.dart';
import 'package:tractian_flutter_challenger_v2/features/companies/data/repositories/company_repository_impl.dart';
import 'package:tractian_flutter_challenger_v2/features/companies/domain/repositories/company_repository.dart';
import 'package:tractian_flutter_challenger_v2/features/companies/domain/usecases/get_companies_usecase.dart';
import 'package:tractian_flutter_challenger_v2/features/companies/presetation/stores/company_store.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompanyRemoteDataSource>(
      () => CompanyRemoteDataSourceImpl(Get.find<ApiService>()),
    );

    Get.lazyPut<CompanyRepository>(
      () => CompanyRepositoryImpl(Get.find<CompanyRemoteDataSource>()),
    );

    Get.lazyPut<GetCompaniesUseCase>(
      () => GetCompaniesUseCase(Get.find<CompanyRepository>()),
    );

    Get.lazyPut<CompanyStore>(
      () => CompanyStore(Get.find<GetCompaniesUseCase>()),
    );
  }
}
