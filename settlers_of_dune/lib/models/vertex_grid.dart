// VertexGrid Class
import 'dart:ui';

import 'package:settlers_of_dune/models/vertex.dart';

class VertexGrid {
  final Map<String, Vertex> vertices = {};

  Vertex getOrCreateVertex(Offset pos) {
    // Round the position to avoid floating point precision issues
    Offset roundedPos = Offset(
      (pos.dx * 100).roundToDouble() / 100,
      (pos.dy * 100).roundToDouble() / 100,
    );
    String key = '${roundedPos.dx.toStringAsFixed(2)},${roundedPos.dy.toStringAsFixed(2)}';
    return vertices.putIfAbsent(key, () => Vertex(roundedPos));
  }

  Vertex? getVertex(Offset pos) {
    String key = '${pos.dx.toStringAsFixed(2)},${pos.dy.toStringAsFixed(2)}';
    return vertices[key];
  }
}


// import 'package:settlers_of_dune/models/vertex.dart';

// class VertexGrid {
//   final Map<String, Vertex> vertices = {};

//   Vertex getOrCreateVertex(int x, int y, int z) {
//     String key = '$x,$y,$z';
//     return vertices.putIfAbsent(key, () => Vertex(x, y, z));
//   }

//   Vertex? getVertex(int x, int y, int z) {
//     return vertices['$x,$y,$z'];
//   }

//   // Add methods to associate vertices with hexes if needed
// }
