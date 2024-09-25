import 'package:get/get.dart';
import 'package:tractian_flutter_challenger_v2/bindings/asset_binding.dart';
import 'package:tractian_flutter_challenger_v2/bindings/home_binding.dart';
import 'package:tractian_flutter_challenger_v2/features/assets/presentation/pages/asset_page.dart';
import 'package:tractian_flutter_challenger_v2/features/companies/presetation/pages/home_page.dart';

class AppRoutes {
  static const String initial = '/';
  static const String assetPage = '/asset';

  static final List<GetPage> routes = [
    GetPage(
      name: initial,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: assetPage,
      page: () =>  const AssetPage(),
      binding: AssetBinding(),
    ),
  ];
}
