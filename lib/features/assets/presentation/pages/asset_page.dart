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
            Get.back();
          },
        ),
      ),
      body: Column(
        children: [
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Observer(
                  builder: (_) => FilterChip(
                    label: const Row(
                      children: [
                        Icon(Icons.bolt, size: 16, color: Colors.grey),
                        SizedBox(width: 4),
                        Text('Sensor de Energia'),
                      ],
                    ),
                    selected: controller.showEnergySensors,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    selectedColor: Colors.blue.shade100,
                    onSelected: (bool selected) {
                      controller.toggleEnergySensorFilter(selected);
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Observer(
                  builder: (_) => FilterChip(
                    label: const Row(
                      children: [
                        Icon(Icons.info_outline, size: 16, color: Colors.grey),
                        SizedBox(width: 4),
                        Text('Crítico'),
                      ],
                    ),
                    selected: controller.showCriticalAssets,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    selectedColor: Colors.blue.shade100,
                    onSelected: (bool selected) {
                      controller.toggleCriticalFilter(selected);
                    },
                  ),
                ),
              ],
            ),
          ),
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
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width *
                            1.5, 
                        height: MediaQuery.of(context).size.height *
                            1.5,
                        child: ListView.builder(
                          shrinkWrap:
                              true,
                          itemCount: controller.treeNodes.length,
                          itemBuilder: (context, index) {
                            final node = controller.treeNodes[index];
                            return TreeNodeWidget(node: node);
                          },
                        ),
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
