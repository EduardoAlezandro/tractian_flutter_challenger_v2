import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:tractian_flutter_challenger_v2/features/assets/presentation/pages/asset_page.dart';
import 'package:tractian_flutter_challenger_v2/features/assets/presentation/stores/asset_store.dart';
import 'get_assets_usecase_test.mocks.dart';

void main() {
  setUp(() {
    Get.reset();
  });

  Widget createWidgetUnderTest() {
    return const GetMaterialApp(
      home: AssetPage(),
    );
  }

  testWidgets('AssetPage renders correctly and interacts with filters',
      (WidgetTester tester) async {
    final mockGetAssetsUseCase = MockGetAssetsUseCase();

    when(mockGetAssetsUseCase.call(any)).thenAnswer((_) async => {
          'assets': [
            {
              'id': '1',
              'name': 'Asset 1',
              'locationId': null,
              'parentId': null
            },
            {
              'id': '2',
              'name': 'Asset 2',
              'locationId': null,
              'parentId': null
            },
          ],
          'locations': [],
          'components': [],
        });

    Get.parameters = {'companyId': 'test-company-id'};

    final store = AssetStore(mockGetAssetsUseCase);
    Get.put(store);

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Assets'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(FilterChip), findsNWidgets(2));

    await tester.tap(find.text('Sensor de Energia'));
    await tester.pumpAndSettle();
    expect(store.showEnergySensors, isTrue);

    await tester.tap(find.text('Crítico'));
    await tester.pumpAndSettle();
    expect(store.showCriticalAssets, isTrue);

    await tester.pumpAndSettle();

    expect(find.text('Asset 1'), findsOneWidget);
    expect(find.text('Asset 2'), findsOneWidget);
  });

  testWidgets('AssetPage shows empty state when no assets available',
      (WidgetTester tester) async {
    final mockGetAssetsUseCase = MockGetAssetsUseCase();

    when(mockGetAssetsUseCase.call(any)).thenAnswer((_) async => {
          'assets': [],
          'locations': [],
          'components': [],
        });

    Get.parameters = {'companyId': 'test-company-id'};

    final store = AssetStore(mockGetAssetsUseCase);
    Get.put(store);

    await tester.pumpWidget(createWidgetUnderTest());

    await tester.pumpAndSettle();

    expect(find.text('Nenhum ativo disponível.'), findsOneWidget);
  });

  testWidgets('AssetPage handles API error gracefully',
      (WidgetTester tester) async {
    final mockGetAssetsUseCase = MockGetAssetsUseCase();

    when(mockGetAssetsUseCase.call(any))
        .thenThrow(Exception('Erro ao buscar ativos'));

    Get.parameters = {'companyId': 'test-company-id'};

    final store = AssetStore(mockGetAssetsUseCase);
    Get.put(store);

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle();

    expect(find.text('Nenhum ativo disponível.'), findsOneWidget);
  });
}
