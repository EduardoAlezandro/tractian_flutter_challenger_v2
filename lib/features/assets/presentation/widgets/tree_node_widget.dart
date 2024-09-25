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

    // Cálculo do padding e posição do ícone
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
                  // Exibimos apenas o nome do sensor
                  Text(
                    widget.node.name, // Exibindo somente o nome, sem sensorType
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  _getStatusIcon(
                      widget.node.status,
                      widget
                          .node.sensorType), // Passando sensorType para o ícone
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
    IconData iconData;
    switch (node.type) {
      case NodeType.location:
        iconData = Icons.location_on;
        break;
      case NodeType.asset:
        iconData = Icons.build;
        break;
      case NodeType.component:
        iconData = Icons.memory;
        break;
      default:
        iconData = Icons.device_unknown;
    }
    return Icon(iconData, color: Colors.blue);
  }

  Widget _getStatusIcon(String? status, String? sensorType) {
    if (sensorType == 'energy' && (status == 'alert' || status == 'alert')) {
      // Ícone de energia vermelho quando o status for crítico ou alerta
      return const Icon(Icons.bolt, color: Colors.red, size: 22);
    } else if (sensorType == 'energy') {
      // Ícone de energia verde para o sensor de energia normal
      return const Icon(Icons.bolt, color: Colors.green, size: 22);
    } else if (status == 'alert' || status == 'critical') {
      // Ícone vermelho para status crítico
      return const Icon(Icons.circle, color: Colors.red, size: 12);
    } else if (status == 'normal') {
      // Ícone verde para status normal
      return const Icon(Icons.circle, color: Colors.green, size: 12);
    } else if (status == 'powered') {
      // Ícone de energia verde para status powered
      return const Icon(Icons.bolt, color: Colors.green, size: 22);
    }
    return const SizedBox(); // Nenhum ícone se nenhum critério for atendido
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

    // Desenha a linha vertical abaixo do nó (conecta com os filhos)
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
