// Screen to Display the Board
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:settlers_of_dune/main.dart';
import 'package:settlers_of_dune/models/edge_grid.dart';
import 'package:settlers_of_dune/models/enums.dart';
import 'package:settlers_of_dune/models/hex_grid.dart';
import 'package:settlers_of_dune/models/player.dart';
import 'package:settlers_of_dune/models/vertex.dart';
import 'package:settlers_of_dune/models/vertex_grid.dart';
import 'package:settlers_of_dune/screens/dice_widget.dart';
import 'package:settlers_of_dune/screens/hex_grid_painter.dart';
import 'package:settlers_of_dune/screens/player_info_box.dart';

class BoardScreen extends StatefulWidget {
  const BoardScreen({super.key});

  @override
  _BoardScreenState createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  late HexGrid hexGrid;
  late VertexGrid vertexGrid;
  late EdgeGrid edgeGrid;
  int temp = 0;

  @override
  void initState() {
    super.initState();
    int radius = 3; // Default radius
    // int playerCount = 4; //Default

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

  //THE BUILD@override
  Widget build(BuildContext context) {
    Player player1 = Player('atr', 'Atreides');
    Player player2 = Player('har', 'Harkonnen');
    Player player3 = Player('ben', 'Bene Gesserit');
    Player player4 = Player('spa', 'Spacing Guild');
    Player player5 = Player('smu', 'Smugglers');
    Player player6 = Player('imp', 'Imperium');

    int turn = 0;
    GameState gameState = GameState.setup;

    List<Player> players = [player1, player2, player3, player4, player5, player6];

    players[1].inventory.addResourceCard(HexType.alloy, 10);
    players[1].inventory.addResourceCard(HexType.spice, 3);
    players[1].inventory.addDevelopmentCard(DevelopmentCardType.soldier);

    Size screenSize = MediaQuery.of(context).size;

    double hexSize = min(
      screenSize.width / (sqrt(3) * (hexGrid.radius * 2 + 2)),
      screenSize.height / (1.5 * (hexGrid.radius * 2 + 2)),
    );

    hexGrid.hexSize = hexSize;

    vertexGrid = VertexGrid();
    edgeGrid = EdgeGrid();

    for (var hex in hexGrid.hexes.values) {
      Offset hexCenter = axialToPixel(hex.q, hex.r, hexGrid.hexSize);

      List<Offset> hexVertices = [];
      for (int i = 0; i < 6; i++) {
        double angleDeg = 60 * i - 30;
        double angleRad = pi / 180 * angleDeg;
        double x = hexCenter.dx + hexGrid.hexSize * cos(angleRad);
        double y = hexCenter.dy + hexGrid.hexSize * sin(angleRad);
        Offset vertexPos = Offset(x, y);
        hexVertices.add(vertexPos);
      }

      List<Vertex> vertices = hexVertices.map((pos) {
        return vertexGrid.getOrCreateVertex(pos);
      }).toList();

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
      body: Row(
        children: [
          PlayerInfoBox(players: players),
          Container(
            decoration: BoxDecoration(color: Colors.black),
            child: Center(
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
          ),
          // DICE WIDGET INTEGRATION
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Temp: $temp'),
              DiceWidget(onRoll: (rollValue) {
                setState(() {
                  temp += rollValue; // Increment temp by the dice roll
                  print(rollValue);
                });
              }),
            ],
          ),
        ],
      ),
    );
  }
}
//DEFINE DICE
