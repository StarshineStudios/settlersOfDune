// import 'package:settlers_of_dune/models/edge.dart';
// import 'package:settlers_of_dune/models/vertex.dart';

// class Hex {
//   final int q;
//   final int r;
//   final HexType type; // Resource type, etc.

//   Hex(this.q, this.r, this.type);

//   // Calculate the vertices for this hex
//   List<Vertex> getVertices() {
//     // Implement logic to calculate or retrieve associated vertices
//     // This might involve using a HexGrid class to manage vertices globally
//     return [];
//   }

//   // Calculate the edges for this hex
//   List<Edge> getEdges() {
//     // Similar to getVertices
//     return [];
//   }
// }

// enum HexType {
//   desert,
//   spice,
//   water,
//   // Add other resource types as needed
// }

// Hex Class
import 'package:settlers_of_dune/models/enums.dart';

class Hex {
  final int q;
  final int r;
  HexType type; // Resource type

  Hex(this.q, this.r, this.type);
}
