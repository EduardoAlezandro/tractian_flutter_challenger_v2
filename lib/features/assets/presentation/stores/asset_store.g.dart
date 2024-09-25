// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AssetStore on _AssetStoreBase, Store {
  late final _$isLoadingAtom =
      Atom(name: '_AssetStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$assetsAtom =
      Atom(name: '_AssetStoreBase.assets', context: context);

  @override
  ObservableList<Asset> get assets {
    _$assetsAtom.reportRead();
    return super.assets;
  }

  @override
  set assets(ObservableList<Asset> value) {
    _$assetsAtom.reportWrite(value, super.assets, () {
      super.assets = value;
    });
  }

  late final _$locationsAtom =
      Atom(name: '_AssetStoreBase.locations', context: context);

  @override
  ObservableList<Location> get locations {
    _$locationsAtom.reportRead();
    return super.locations;
  }

  @override
  set locations(ObservableList<Location> value) {
    _$locationsAtom.reportWrite(value, super.locations, () {
      super.locations = value;
    });
  }

  late final _$componentsAtom =
      Atom(name: '_AssetStoreBase.components', context: context);

  @override
  ObservableList<Component> get components {
    _$componentsAtom.reportRead();
    return super.components;
  }

  @override
  set components(ObservableList<Component> value) {
    _$componentsAtom.reportWrite(value, super.components, () {
      super.components = value;
    });
  }

  late final _$treeNodesAtom =
      Atom(name: '_AssetStoreBase.treeNodes', context: context);

  @override
  ObservableList<TreeNode> get treeNodes {
    _$treeNodesAtom.reportRead();
    return super.treeNodes;
  }

  @override
  set treeNodes(ObservableList<TreeNode> value) {
    _$treeNodesAtom.reportWrite(value, super.treeNodes, () {
      super.treeNodes = value;
    });
  }

  late final _$searchTextAtom =
      Atom(name: '_AssetStoreBase.searchText', context: context);

  @override
  String get searchText {
    _$searchTextAtom.reportRead();
    return super.searchText;
  }

  @override
  set searchText(String value) {
    _$searchTextAtom.reportWrite(value, super.searchText, () {
      super.searchText = value;
    });
  }

  late final _$showEnergySensorsAtom =
      Atom(name: '_AssetStoreBase.showEnergySensors', context: context);

  @override
  bool get showEnergySensors {
    _$showEnergySensorsAtom.reportRead();
    return super.showEnergySensors;
  }

  @override
  set showEnergySensors(bool value) {
    _$showEnergySensorsAtom.reportWrite(value, super.showEnergySensors, () {
      super.showEnergySensors = value;
    });
  }

  late final _$showCriticalAssetsAtom =
      Atom(name: '_AssetStoreBase.showCriticalAssets', context: context);

  @override
  bool get showCriticalAssets {
    _$showCriticalAssetsAtom.reportRead();
    return super.showCriticalAssets;
  }

  @override
  set showCriticalAssets(bool value) {
    _$showCriticalAssetsAtom.reportWrite(value, super.showCriticalAssets, () {
      super.showCriticalAssets = value;
    });
  }

  late final _$fetchAssetsAsyncAction =
      AsyncAction('_AssetStoreBase.fetchAssets', context: context);

  @override
  Future<void> fetchAssets(String companyId) {
    return _$fetchAssetsAsyncAction.run(() => super.fetchAssets(companyId));
  }

  late final _$_AssetStoreBaseActionController =
      ActionController(name: '_AssetStoreBase', context: context);

  @override
  void buildTree() {
    final _$actionInfo = _$_AssetStoreBaseActionController.startAction(
        name: '_AssetStoreBase.buildTree');
    try {
      return super.buildTree();
    } finally {
      _$_AssetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSearchText(String value) {
    final _$actionInfo = _$_AssetStoreBaseActionController.startAction(
        name: '_AssetStoreBase.setSearchText');
    try {
      return super.setSearchText(value);
    } finally {
      _$_AssetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleEnergySensorFilter(bool value) {
    final _$actionInfo = _$_AssetStoreBaseActionController.startAction(
        name: '_AssetStoreBase.toggleEnergySensorFilter');
    try {
      return super.toggleEnergySensorFilter(value);
    } finally {
      _$_AssetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleCriticalFilter(bool value) {
    final _$actionInfo = _$_AssetStoreBaseActionController.startAction(
        name: '_AssetStoreBase.toggleCriticalFilter');
    try {
      return super.toggleCriticalFilter(value);
    } finally {
      _$_AssetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void applyFilters() {
    final _$actionInfo = _$_AssetStoreBaseActionController.startAction(
        name: '_AssetStoreBase.applyFilters');
    try {
      return super.applyFilters();
    } finally {
      _$_AssetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
assets: ${assets},
locations: ${locations},
components: ${components},
treeNodes: ${treeNodes},
searchText: ${searchText},
showEnergySensors: ${showEnergySensors},
showCriticalAssets: ${showCriticalAssets}
    ''';
  }
}
