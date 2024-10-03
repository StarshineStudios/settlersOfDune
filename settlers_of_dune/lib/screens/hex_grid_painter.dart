import 'dart:math';
import 'package:flutter/material.dart';
import 'package:settlers_of_dune/models/edge_grid.dart';
import 'package:settlers_of_dune/models/enums.dart';
import 'package:settlers_of_dune/models/hex_grid.dart';
import 'package:settlers_of_dune/models/player.dart';
import 'package:settlers_of_dune/models/vertex_grid.dart';
import 'package:settlers_of_dune/screens/board_screen.dart';

class HexGridPainter extends CustomPainter {
  final HexGrid hexGrid;
  final VertexGrid vertexGrid;
  final EdgeGrid edgeGrid;
  final double hexSize;

  HexGridPainter(this.hexGrid, this.vertexGrid, this.edgeGrid) : hexSize = hexGrid.hexSize;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint hexPaint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 2.0;

    final Paint hexBorderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.black
      ..strokeWidth = 2.0;

    final Paint vertexPaint = Paint()
      ..color = Color.fromARGB(255, 224, 189, 137)
      ..style = PaintingStyle.fill;

    final Paint edgePaint = Paint()
      ..color = Color.fromARGB(255, 188, 154, 85)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0;

    Offset center = Offset(size.width / 2, size.height / 2);

    // Draw Hexes
    for (var hex in hexGrid.hexes.values) {
      Offset hexCenter = axialToPixel(hex.q, hex.r, hexSize);
      hexCenter = hexCenter + center;

      hexPaint.color = getColorForHexType(hex.type);

      // Draw hexagon
      Path hexPath = Path();
      for (int i = 0; i < 6; i++) {
        double angleDeg = 60 * i - 30;
        double angleRad = pi / 180 * angleDeg;
        double x = hexCenter.dx + hexSize * cos(angleRad);
        double y = hexCenter.dy + hexSize * sin(angleRad);
        if (i == 0) {
          hexPath.moveTo(x, y);
        } else {
          hexPath.lineTo(x, y);
        }
      }
      hexPath.close();
      canvas.drawPath(hexPath, hexPaint);
      canvas.drawPath(hexPath, hexBorderPaint);

      // Draw Hex Number
      if (hex.number != null) {
        drawHexNumber(canvas, hexCenter, hex.number!);
      }

      // Draw Resource Icon
      drawResourceIcon(canvas, hexCenter, hex.type);
    }

    // Draw Edges
    for (var edge in edgeGrid.edges.values) {
      Offset p1 = edge.vertex1.position + center;
      Offset p2 = edge.vertex2.position + center;
      canvas.drawLine(p1, p2, edgePaint);
    }

    // Draw Vertices
    for (var vertex in vertexGrid.vertices.values) {
      Offset p = vertex.position + center;
      canvas.drawCircle(p, 15.0, vertexPaint);
    }
  }

  // Method to draw the hex's number at the center
  void drawHexNumber(Canvas canvas, Offset hexCenter, int number) {
    final textSpan = TextSpan(
      text: number.toString(),
      style: TextStyle(
        color: const Color.fromARGB(255, 255, 255, 255),
        fontSize: 50,
        fontWeight: FontWeight.bold,
      ),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 0, maxWidth: hexSize);
    final offset = hexCenter - Offset(textPainter.width / 2, textPainter.height / 2);
    textPainter.paint(canvas, offset);
  }

  // Method to draw a resource icon at the center of the hex
  void drawResourceIcon(Canvas canvas, Offset hexCenter, HexType type) {
    IconData? iconData;

    switch (type) {
      case HexType.water:
        iconData = Icons.water_drop;
        break;
      case HexType.alloy:
        iconData = Icons.construction;
        break;
      case HexType.spice:
        iconData = Icons.local_fire_department; // Just an example, customize this
        break;
      case HexType.flora:
        iconData = Icons.nature;
        break;
      case HexType.fauna:
        iconData = Icons.mouse;
      case HexType.sandstone:
        iconData = Icons.rectangle;
        break;
      // Add more resources or custom icons as needed
      default:
        return; // No icon for desert or undefined
    }

    if (iconData != null) {
      final textPainter = TextPainter(
        text: TextSpan(
          text: String.fromCharCode(iconData.codePoint),
          style: TextStyle(
            fontSize: 50.0,
            fontFamily: iconData.fontFamily,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();
      final iconOffset = hexCenter - Offset(textPainter.width / 2, textPainter.height / 2 + 50);
      textPainter.paint(canvas, iconOffset);
    }
  }

  // Axial to Pixel conversion for pointy-top hexagons
  Offset axialToPixel(int q, int r, double size) {
    double x = size * sqrt(3) * (q + r / 2);
    double y = size * 1.5 * r;
    return Offset(x, y);
  }

  // Assign colors based on HexType
  Color getColorForHexType(HexType type) {
    switch (type) {
      case HexType.desert:
        return const Color.fromARGB(255, 255, 217, 160); // Sand color -desert
      case HexType.sandstone:
        return const Color.fromARGB(255, 205, 164, 82); // Dark sand color-sandstone
      case HexType.flora:
        return const Color.fromARGB(255, 158, 176, 84); // Desert-y green-flora
      case HexType.fauna:
        return const Color.fromARGB(255, 180, 124, 46); // Brown-fauna
      case HexType.alloy:
        return const Color.fromARGB(255, 172, 157, 113); // Gray - alloy
      case HexType.water:
        return const Color.fromARGB(255, 74, 213, 223); // Blue - water
      case HexType.spice:
        return const Color.fromARGB(255, 255, 129, 51); // Reddish orange
      default:
        return Colors.white;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
