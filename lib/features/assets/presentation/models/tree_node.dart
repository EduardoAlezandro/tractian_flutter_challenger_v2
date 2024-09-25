enum NodeType { location, asset, component }

class TreeNode {
  final String id;
  final String name;
  final NodeType type;
  final String? parentId;
  final List<TreeNode> children;
  final String? sensorType;
  final String? status;
  bool isExpanded;  // Propriedade para controlar a expansão

  TreeNode({
    required this.id,
    required this.name,
    required this.type,
    this.parentId,
    this.children = const [],
    this.sensorType,
    this.status,
    this.isExpanded = false,  // Inicialmente, o nó não está expandido
  });
}
