import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:tractian_flutter_challenger_v2/features/assets/presentation/pages/asset_page.dart';
import 'package:tractian_flutter_challenger_v2/features/assets/presentation/stores/asset_store.dart';
import 'get_assets_usecase_test.mocks.dart'; // Importa o arquivo gerado pelo mockito

void main() {
  testWidgets('AssetPage renders correctly and interacts with filters',
      (WidgetTester tester) async {
    final mockGetAssetsUseCase = MockGetAssetsUseCase();

    when(mockGetAssetsUseCase.call(any)).thenAnswer((_) async => {
          'assets': [],
          'locations': [],
          'components': [],
        });

    final store = AssetStore(mockGetAssetsUseCase);
    Get.put(store);

    await tester.pumpWidget(
      const GetMaterialApp(
        home: AssetPage(),
      ),
    );

    expect(find.text('Assets'), findsOneWidget);

    expect(find.byType(TextField), findsOneWidget);

    expect(find.byType(FilterChip), findsNWidgets(2));

    await tester.tap(find.text('Sensor de Energia'));
    await tester.pumpAndSettle();
    expect(store.showEnergySensors, true);

    await tester.tap(find.text('Crítico'));
    await tester.pumpAndSettle();
    expect(store.showCriticalAssets, true);
  });
}
