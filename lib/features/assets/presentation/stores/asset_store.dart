import 'package:mobx/mobx.dart';
import 'package:tractian_flutter_challenger_v2/features/assets/domain/entities/asset.dart';
import 'package:tractian_flutter_challenger_v2/features/assets/domain/entities/component.dart';
import 'package:tractian_flutter_challenger_v2/features/assets/domain/entities/location.dart';
import 'package:tractian_flutter_challenger_v2/features/assets/domain/usecases/get_companies_usecase.dart';
import 'package:tractian_flutter_challenger_v2/features/assets/presentation/models/tree_node.dart';

part 'asset_store.g.dart';

class AssetStore = _AssetStoreBase with _$AssetStore;

abstract class _AssetStoreBase with Store {
  final GetAssetsUseCase getAssetsUseCase;

  _AssetStoreBase(this.getAssetsUseCase);

  @observable
  bool isLoading = false;

  @observable
  ObservableList<Asset> assets = ObservableList<Asset>();

  @observable
  ObservableList<Location> locations = ObservableList<Location>();

  @observable
  ObservableList<Component> components = ObservableList<Component>();

  @observable
  ObservableList<TreeNode> treeNodes = ObservableList<TreeNode>();

  List<TreeNode> originalTreeNodes = [];

  @observable
  String searchText = '';

  @observable
  bool showEnergySensors = false;

  @observable
  bool showCriticalAssets = false;

  @action
  Future<void> fetchAssets(String companyId) async {
    isLoading = true;
    final result = await getAssetsUseCase(companyId);
    assets.addAll(result['assets']);
    locations.addAll(result['locations']);
    components.addAll(result['components']);
    buildTree();
    isLoading = false;
  }

  @action
  void buildTree() {
    treeNodes.clear();
    originalTreeNodes.clear();

    final Map<String, TreeNode> locationNodes = {};
    final Map<String, TreeNode> assetNodes = {};
    final Map<String, TreeNode> componentNodes = {};

    for (var loc in locations) {
      locationNodes[loc.id] = TreeNode(
        id: loc.id,
        name: loc.name,
        type: NodeType.location,
        parentId: loc.parentId,
        children: [],
      );
    }

    for (var loc in locations) {
      if (loc.parentId != null && locationNodes.containsKey(loc.parentId)) {
        locationNodes[loc.parentId]!.children.add(locationNodes[loc.id]!);
      }
    }

    for (var asset in assets) {
      assetNodes[asset.id] = TreeNode(
        id: asset.id,
        name: asset.name,
        type: NodeType.asset,
        parentId: asset.parentId,
        children: [],
      );
    }

    for (var asset in assets) {
      if (asset.parentId != null && assetNodes.containsKey(asset.parentId)) {
        assetNodes[asset.parentId]!.children.add(assetNodes[asset.id]!);
      } else if (asset.locationId != null &&
          locationNodes.containsKey(asset.locationId)) {
        locationNodes[asset.locationId]!.children.add(assetNodes[asset.id]!);
      }
    }

    for (var component in components) {
      componentNodes[component.id] = TreeNode(
        id: component.id,
        name: component.name,
        type: NodeType.component,
        parentId: component.parentId,
        sensorType: component.sensorType,
        status: component.status,
        children: [],
      );
    }

    for (var component in components) {
      if (component.parentId != null &&
          assetNodes.containsKey(component.parentId)) {
        assetNodes[component.parentId]!
            .children
            .add(componentNodes[component.id]!);
      } else if (component.locationId != null &&
          locationNodes.containsKey(component.locationId)) {
        locationNodes[component.locationId]!
            .children
            .add(componentNodes[component.id]!);
      }
    }

    for (var loc in locations) {
      if (loc.parentId == null) {
        originalTreeNodes.add(locationNodes[loc.id]!);
      }
    }

    for (var asset in assets) {
      if (asset.parentId == null && asset.locationId == null) {
        originalTreeNodes.add(assetNodes[asset.id]!);
      }
    }

    for (var component in components) {
      if (component.parentId == null && component.locationId == null) {
        originalTreeNodes.add(componentNodes[component.id]!);
      }
    }

    treeNodes.addAll(originalTreeNodes);

    if (searchText.isNotEmpty || showEnergySensors || showCriticalAssets) {
      applyFilters();
    }
  }

  @action
  void setSearchText(String value) {
    searchText = value;
    applyFilters();
  }

  @action
  void toggleEnergySensorFilter(bool value) {
    showEnergySensors = value;
    applyFilters();
  }

  @action
  void toggleCriticalFilter(bool value) {
    showCriticalAssets = value;
    applyFilters();
  }

  @action
  void applyFilters() {
    treeNodes.clear();

    if (searchText.isEmpty && !showEnergySensors && !showCriticalAssets) {
      treeNodes.addAll(originalTreeNodes);
      return;
    }

    for (var node in originalTreeNodes) {
      final filteredNode = _filterNode(node);
      if (filteredNode != null) {
        treeNodes.add(filteredNode);
      }
    }
  }

  TreeNode? _filterNode(TreeNode node) {
    bool matchesText =
        node.name.toLowerCase().contains(searchText.toLowerCase());
    bool matchesEnergySensor =
        showEnergySensors ? node.sensorType == 'energy' : true;
    bool matchesCritical = showCriticalAssets ? node.status == 'alert' : true;

    bool matchesNode = matchesText && matchesEnergySensor && matchesCritical;

    final List<TreeNode> filteredChildren = [];
    for (var child in node.children) {
      final filteredChild = _filterNode(child);
      if (filteredChild != null) {
        filteredChildren.add(filteredChild);
      }
    }

    if (matchesNode || filteredChildren.isNotEmpty) {
      return TreeNode(
        id: node.id,
        name: node.name,
        type: node.type,
        parentId: node.parentId,
        sensorType: node.sensorType,
        status: node.status,
        isExpanded: true,
        children:
            filteredChildren, 
      );
    }

    return null;
  }
}
