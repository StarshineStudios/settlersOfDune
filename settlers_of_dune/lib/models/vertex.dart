// Vertex Class
import 'dart:ui';

import 'package:settlers_of_dune/main.dart';

class Vertex {
  final Offset position;
  Building? building;

  Vertex(this.position);

  String get id => '${position.dx.toStringAsFixed(2)},${position.dy.toStringAsFixed(2)}';
}


// import 'package:settlers_of_dune/models/player.dart';

// class Vertex {
//   final int x;
//   final int y;
//   final int z; // Using cube coordinates for vertex positions can be helpful
//   Building? building;

//   Vertex(this.x, this.y, this.z);

//   String get id => '$x,$y,$z';
// }

// class Building {
//   final Player owner;
//   final BuildingType type;

//   Building(this.owner, this.type);
// }

// enum BuildingType {
//   settlement,
//   city,
//   // Add other building types as needed
// }
