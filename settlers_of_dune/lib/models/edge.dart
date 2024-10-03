// Edge Class
import 'package:settlers_of_dune/main.dart';
import 'package:settlers_of_dune/models/vertex.dart';

class Edge {
  final Vertex vertex1;
  final Vertex vertex2;
  Road? road;

  Edge(this.vertex1, this.vertex2);

  String get id {
    // Ensure consistent ordering
    if (vertex1.id.compareTo(vertex2.id) < 0) {
      return '${vertex1.id}-${vertex2.id}';
    } else {
      return '${vertex2.id}-${vertex1.id}';
    }
  }
}


// import 'package:settlers_of_dune/models/player.dart';
// import 'package:settlers_of_dune/models/vertex.dart';

// class Edge {
//   final Vertex vertex1;
//   final Vertex vertex2;
//   Road? road;

//   Edge(this.vertex1, this.vertex2);

//   String get id {
//     // Ensure consistent ordering
//     if (vertex1.id.compareTo(vertex2.id) < 0) {
//       return '${vertex1.id}-${vertex2.id}';
//     } else {
//       return '${vertex2.id}-${vertex1.id}';
//     }
//   }
// }

// class Road {
//   final Player owner;

//   Road(this.owner);
// }
