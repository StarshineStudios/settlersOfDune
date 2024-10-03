// Screen to Display the Board
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:settlers_of_dune/main.dart';
import 'package:settlers_of_dune/models/edge_grid.dart';
import 'package:settlers_of_dune/models/hex_grid.dart';
import 'package:settlers_of_dune/models/vertex.dart';
import 'package:settlers_of_dune/models/vertex_grid.dart';

class BoardScreen extends StatefulWidget {
  const BoardScreen({super.key});

  @override
  _BoardScreenState createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  late HexGrid hexGrid;
  late VertexGrid vertexGrid;
  late EdgeGrid edgeGrid;

  @override
  void initState() {
    super.initState();
    int radius = 3; // Default radius
    hexGrid = HexGrid(radius);
    vertexGrid = VertexGrid();
    edgeGrid = EdgeGrid();

    // Initialize vertices and edges based on hexes
    for (var hex in hexGrid.hexes.values) {
      // Get the pixel position of the hex center
      Offset hexCenter = axialToPixel(hex.q, hex.r, hexGrid.hexSize);

      // Define the 6 vertices around the hex (pointy-top)
      List<Offset> hexVertices = [];
      for (int i = 0; i < 6; i++) {
        double angleDeg = 60 * i - 30;
        double angleRad = pi / 180 * angleDeg;
        double x = hexCenter.dx + hexGrid.hexSize * cos(angleRad);
        double y = hexCenter.dy + hexGrid.hexSize * sin(angleRad);
        Offset vertexPos = Offset(x, y);
        hexVertices.add(vertexPos);
      }

      // Add vertices to the vertex grid
      List<Vertex> vertices = hexVertices.map((pos) {
        return vertexGrid.getOrCreateVertex(pos);
      }).toList();

      // Create edges between consecutive vertices
      for (int i = 0; i < vertices.length; i++) {
        Vertex v1 = vertices[i];
        Vertex v2 = vertices[(i + 1) % vertices.length];
        edgeGrid.getOrCreateEdge(v1, v2);
      }
    }
  }

  // Axial to Pixel conversion for pointy-top hexagons
  Offset axialToPixel(int q, int r, double size) {
    double x = size * sqrt(3) * (q + r / 2);
    double y = size * 1.5 * r;
    return Offset(x, y);
  }

  @override
  Widget build(BuildContext context) {
    // Obtain screen size
    Size screenSize = MediaQuery.of(context).size;

    // Calculate hex size based on screen size and grid radius
    double hexSize = min(
      screenSize.width / (sqrt(3) * (hexGrid.radius * 2 + 2)),
      screenSize.height / (1.5 * (hexGrid.radius * 2 + 2)),
    );

    // Update hexSize in hexGrid
    hexGrid.hexSize = hexSize;

    // Re-initialize hex positions based on new hexSize
    vertexGrid = VertexGrid();
    edgeGrid = EdgeGrid();

    for (var hex in hexGrid.hexes.values) {
      // Get the pixel position of the hex center
      Offset hexCenter = axialToPixel(hex.q, hex.r, hexGrid.hexSize);

      // Define the 6 vertices around the hex (pointy-top)
      List<Offset> hexVertices = [];
      for (int i = 0; i < 6; i++) {
        double angleDeg = 60 * i - 30;
        double angleRad = pi / 180 * angleDeg;
        double x = hexCenter.dx + hexGrid.hexSize * cos(angleRad);
        double y = hexCenter.dy + hexGrid.hexSize * sin(angleRad);
        Offset vertexPos = Offset(x, y);
        hexVertices.add(vertexPos);
      }

      // Add vertices to the vertex grid
      List<Vertex> vertices = hexVertices.map((pos) {
        return vertexGrid.getOrCreateVertex(pos);
      }).toList();

      // Create edges between consecutive vertices
      for (int i = 0; i < vertices.length; i++) {
        Vertex v1 = vertices[i];
        Vertex v2 = vertices[(i + 1) % vertices.length];
        edgeGrid.getOrCreateEdge(v1, v2);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settlers of Dune'),
      ),
      body: Center(
        child: InteractiveViewer(
          boundaryMargin: const EdgeInsets.all(100),
          minScale: 0.5,
          maxScale: 3.0,
          child: CustomPaint(
            size: Size(
              hexGrid.hexSize * sqrt(3) * (hexGrid.radius * 2 + 2),
              hexGrid.hexSize * 1.5 * (hexGrid.radius * 2 + 2),
            ),
            painter: HexGridPainter(
              hexGrid,
              vertexGrid,
              edgeGrid,
            ),
          ),
        ),
      ),
    );
  }
}
