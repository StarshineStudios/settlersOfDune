// EdgeGrid Class
import 'package:settlers_of_dune/models/edge.dart';
import 'package:settlers_of_dune/models/vertex.dart';

class EdgeGrid {
  final Map<String, Edge> edges = {};

  Edge getOrCreateEdge(Vertex v1, Vertex v2) {
    String key = v1.id.compareTo(v2.id) < 0 ? '${v1.id}-${v2.id}' : '${v2.id}-${v1.id}';
    return edges.putIfAbsent(key, () => Edge(v1, v2));
  }

  Edge? getEdge(Vertex v1, Vertex v2) {
    String key = v1.id.compareTo(v2.id) < 0 ? '${v1.id}-${v2.id}' : '${v2.id}-${v1.id}';
    return edges[key];
  }
}


// import 'package:settlers_of_dune/models/edge.dart';
// import 'package:settlers_of_dune/models/vertex.dart';

// class EdgeGrid {
//   final Map<String, Edge> edges = {};

//   Edge getOrCreateEdge(Vertex v1, Vertex v2) {
//     String key = v1.id.compareTo(v2.id) < 0 ? '${v1.id}-${v2.id}' : '${v2.id}-${v1.id}';
//     return edges.putIfAbsent(key, () => Edge(v1, v2));
//   }

//   Edge? getEdge(Vertex v1, Vertex v2) {
//     String key = v1.id.compareTo(v2.id) < 0 ? '${v1.id}-${v2.id}' : '${v2.id}-${v1.id}';
//     return edges[key];
//   }
// }
