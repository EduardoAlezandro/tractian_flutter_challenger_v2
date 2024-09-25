import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:tractian_flutter_challenger_v2/features/assets/presentation/stores/asset_store.dart';
import 'package:tractian_flutter_challenger_v2/features/assets/presentation/widgets/tree_node_widget.dart';

class AssetPage extends GetView<AssetStore> {
  const AssetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String companyId = Get.arguments['companyId'];
    controller.fetchAssets(companyId);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF17192D),
        centerTitle: true,
        title: const Text(
          'Assets',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 24,
          ),
          onPressed: () {
            Get.back(); // Voltar para a tela anterior
          },
        ),
      ),
      body: Column(
        children: [
          // Campo de busca
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: controller.setSearchText,
              decoration: const InputDecoration(
                labelText: 'Buscar Ativo ou Local',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          // Filtros
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                // Filtro "Sensor de Energia"
                Observer(
                  builder: (_) => FilterChip(
                    label: const Text('Sensor de Energia'),
                    selected: controller.showEnergySensors,
                    onSelected: (bool selected) {
                      controller.toggleEnergySensorFilter(selected);
                    },
                  ),
                ),
                const SizedBox(width: 8),
                // Filtro "Crítico"
                Observer(
                  builder: (_) => FilterChip(
                    label: const Text('Crítico'),
                    selected: controller.showCriticalAssets,
                    onSelected: (bool selected) {
                      controller.toggleCriticalFilter(selected);
                    },
                  ),
                ),
              ],
            ),
          ),
          // Árvore de nós com rolagem horizontal e vertical
          Expanded(
            child: Observer(
              builder: (_) {
                if (controller.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (controller.treeNodes.isEmpty) {
                  return const Center(child: Text('Nenhum ativo disponível.'));
                } else {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        itemCount: controller.treeNodes.length,
                        itemBuilder: (context, index) {
                          final node = controller.treeNodes[index];
                          return TreeNodeWidget(node: node);
                        },
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
