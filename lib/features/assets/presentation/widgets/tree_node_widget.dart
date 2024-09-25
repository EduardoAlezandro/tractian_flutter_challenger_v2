import 'package:flutter/material.dart';
import 'package:tractian_flutter_challenger_v2/features/assets/presentation/models/tree_node.dart';

class TreeNodeWidget extends StatefulWidget {
  final TreeNode node;
  final int depth;
  final bool isLast;

  const TreeNodeWidget({
    super.key,
    required this.node,
    this.depth = 0,
    this.isLast = false,
  });

  @override
  _TreeNodeWidgetState createState() => _TreeNodeWidgetState();
}

class _TreeNodeWidgetState extends State<TreeNodeWidget> {
  @override
  Widget build(BuildContext context) {
    const double arrowIconSize = 24.0;

    final double leftPadding = widget.depth * 16.0;
    final double iconCenterX = leftPadding + arrowIconSize / 2;
    const double iconCenterY = arrowIconSize / 2;

    return Stack(
      children: [
        if (widget.node.isExpanded)
          Positioned.fill(
            child: CustomPaint(
              painter: NodePainter(
                isExpanded: widget.node.isExpanded,
                iconCenterOffset: Offset(iconCenterX, iconCenterY),
              ),
            ),
          ),
        Padding(
          padding: EdgeInsets.only(left: leftPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  widget.node.children.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.node.isExpanded = !widget.node.isExpanded;
                            });
                          },
                          child: SizedBox(
                            width: arrowIconSize,
                            height: arrowIconSize,
                            child: Center(
                              child: Icon(
                                widget.node.isExpanded
                                    ? Icons.arrow_drop_down
                                    : Icons.arrow_right,
                                size: arrowIconSize,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(width: arrowIconSize),
                  _buildLeadingIcon(widget.node),
                  const SizedBox(width: 8),
                  Text(
                    widget.node.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  _getStatusIcon(widget.node.status, widget.node.sensorType),
                ],
              ),
              if (widget.node.isExpanded)
                Column(
                  children: widget.node.children
                      .map(
                        (childNode) => TreeNodeWidget(
                          node: childNode,
                          depth: widget.depth + 1,
                        ),
                      )
                      .toList(),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLeadingIcon(TreeNode node) {
    String imagePath;

    switch (node.type) {
      case NodeType.location:
        imagePath = 'assets/images/locations_icon.png';
        break;
      case NodeType.asset:
        imagePath = 'assets/images/components_icon.png';
        break;
      case NodeType.component:
        imagePath = 'assets/images/motor_icon.png';
        break;
      default:
        imagePath =
            'assets/images/default_icon.png'; // Coloque uma imagem padrão, se necessário
    }

    return Image.asset(
      imagePath,
      width: 24, // Tamanho do ícone
      height: 24,
      color: Colors
          .blue, // Aplicar cor se for um ícone monocromático, senão remova esta linha
    );
  }

  Widget _getStatusIcon(String? status, String? sensorType) {
    if (sensorType == 'energy' && (status == 'alert' || status == 'alert')) {
      return const Icon(Icons.bolt, color: Colors.red, size: 22);
    } else if (sensorType == 'energy') {
      return const Icon(Icons.bolt, color: Colors.green, size: 22);
    } else if (status == 'alert' || status == 'critical') {
      return const Icon(Icons.circle, color: Colors.red, size: 12);
    } else if (status == 'normal') {
      return const Icon(Icons.circle, color: Colors.green, size: 12);
    } else if (status == 'powered') {
      return const Icon(Icons.bolt, color: Colors.green, size: 22);
    }
    return const SizedBox();
  }
}

class NodePainter extends CustomPainter {
  final bool isExpanded;
  final Offset iconCenterOffset;

  NodePainter({
    required this.isExpanded,
    required this.iconCenterOffset,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (!isExpanded) {
      return;
    }

    final Paint paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1.0;

    final double startX = iconCenterOffset.dx;
    final double centerY = iconCenterOffset.dy;

    canvas.drawLine(
      Offset(startX, centerY),
      Offset(startX, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(NodePainter oldDelegate) {
    return oldDelegate.isExpanded != isExpanded ||
        oldDelegate.iconCenterOffset != iconCenterOffset;
  }
}
