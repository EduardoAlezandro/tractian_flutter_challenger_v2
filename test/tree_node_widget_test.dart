import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tractian_flutter_challenger_v2/features/assets/presentation/models/tree_node.dart';
import 'package:tractian_flutter_challenger_v2/features/assets/presentation/widgets/tree_node_widget.dart';

void main() {
  testWidgets('TreeNodeWidget renders correctly', (WidgetTester tester) async {
    final node = TreeNode(
        id: '1', name: 'Test Node', type: NodeType.asset, children: []);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TreeNodeWidget(node: node),
        ),
      ),
    );

    expect(find.text('Test Node'), findsOneWidget);

    expect(find.byIcon(Icons.build), findsOneWidget);
  });

  testWidgets('TreeNodeWidget expands and collapses multiple nodes',
      (WidgetTester tester) async {
    final node = TreeNode(
      id: '1',
      name: 'Parent Node',
      type: NodeType.asset,
      children: [
        TreeNode(id: '2', name: 'Child Node 1', type: NodeType.asset),
        TreeNode(id: '3', name: 'Child Node 2', type: NodeType.asset),
      ],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TreeNodeWidget(node: node),
        ),
      ),
    );

    expect(find.text('Child Node 1'), findsNothing);
    expect(find.text('Child Node 2'), findsNothing);

    await tester.tap(find.byIcon(Icons.arrow_right));
    await tester.pumpAndSettle();
    expect(find.text('Child Node 1'), findsOneWidget);
    expect(find.text('Child Node 2'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_drop_down));
    await tester.pumpAndSettle();
    expect(find.text('Child Node 1'), findsNothing);
    expect(find.text('Child Node 2'), findsNothing);
  });

  testWidgets('TreeNodeWidget displays location icon correctly',
      (WidgetTester tester) async {
    final node = TreeNode(
        id: '1', name: 'Location Node', type: NodeType.location, children: []);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TreeNodeWidget(node: node),
        ),
      ),
    );

    expect(find.byIcon(Icons.location_on), findsOneWidget);
  });
}
