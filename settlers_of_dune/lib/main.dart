import 'dart:math';
import 'package:flutter/material.dart';
import 'package:settlers_of_dune/models/edge_grid.dart';
import 'package:settlers_of_dune/models/enums.dart';
import 'package:settlers_of_dune/models/hex_grid.dart';
import 'package:settlers_of_dune/models/vertex_grid.dart';
import 'package:settlers_of_dune/screens/board_screen.dart';

// Entry point of the Flutter application
void main() {
  runApp(const SettlersOfDuneApp());
}

// Main Application Widget
class SettlersOfDuneApp extends StatelessWidget {
  const SettlersOfDuneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settlers of Dune',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const BoardScreen(),
    );
  }
}

////////////////////////////////////////////////////////////////////////
// Building Class (Placeholder for future implementation)
class Building {
  final Player owner;
  final BuildingType type;

  Building(this.owner, this.type);
}

// Road Class (Placeholder for future implementation)
class Road {
  final Player owner;

  Road(this.owner);
}

// Player Class (Placeholder for future implementation)
class Player {
  final String id;
  final String name;
  final Inventory inventory;

  Player(this.id, this.name) : inventory = Inventory();
}

// Inventory Class (Placeholder for future implementation)
class Inventory {
  final Map<CardType, int> cards = {};

  void addCard(CardType type, [int quantity = 1]) {
    cards[type] = (cards[type] ?? 0) + quantity;
  }

  void removeCard(CardType type, [int quantity = 1]) {
    if ((cards[type] ?? 0) >= quantity) {
      cards[type] = (cards[type] ?? 0) - quantity;
    }
  }
}

enum CardType {
  resource,
  development,
  // Add other card types as needed
}

enum BuildingType {
  settlement,
  city,
  // Add other building types as needed
}

// Custom Painter to Draw the Hex Grid
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
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final Paint edgePaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    // Calculate center offset to center the grid in the canvas
    double gridWidth = hexSize * sqrt(3) * (hexGrid.radius * 2 + 2);
    double gridHeight = hexSize * 1.5 * (hexGrid.radius * 2 + 2);
    Offset center = Offset(size.width / 2, size.height / 2);

    // Draw Hexes
    for (var hex in hexGrid.hexes.values) {
      // Get the pixel position of the hex center
      Offset hexCenter = axialToPixel(hex.q, hex.r, hexSize);
      // Shift to center the grid
      hexCenter = hexCenter + center;

      // Set color based on HexType
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
      canvas.drawCircle(p, 5.0, vertexPaint);
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
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
