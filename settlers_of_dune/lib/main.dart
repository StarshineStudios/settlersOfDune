import 'dart:math';
import 'package:flutter/material.dart';
import 'package:settlers_of_dune/models/edge_grid.dart';
import 'package:settlers_of_dune/models/enums.dart';
import 'package:settlers_of_dune/models/hex_grid.dart';
import 'package:settlers_of_dune/models/player.dart';
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

enum BuildingType {
  settlement,
  city,
  // Add other building types as needed
}
