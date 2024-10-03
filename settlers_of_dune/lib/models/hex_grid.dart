// HexGrid Class
import 'dart:math';

import 'package:settlers_of_dune/models/enums.dart';
import 'package:settlers_of_dune/models/hex.dart';

class HexGrid {
  final Map<String, Hex> hexes = {};
  final int radius;
  double hexSize;

  HexGrid(this.radius, {this.hexSize = 50.0}) {
    // Initialize resources
    List<HexType> resources = [];

    // Add 6 of each resource
    for (HexType type in HexType.values) {
      if (type != HexType.desert) {
        for (int i = 0; i < 6; i++) {
          resources.add(type);
        }
      }
    }

    // Add 1 desert
    resources.add(HexType.desert);

    // Shuffle the resources
    resources.shuffle(Random());

    // Ensure the number of resources matches the number of hexes
    int totalHexes = 1 + 6 + 12 + 18; // Radius 3: 37 hexes
    if (resources.length != totalHexes) {
      throw Exception('Number of resources (${resources.length}) does not match number of hexes ($totalHexes)');
    }

    // Assign resources to hexes
    int index = 0;
    for (int q = -radius; q <= radius; q++) {
      int r1 = max(-radius, -q - radius);
      int r2 = min(radius, -q + radius);
      for (int r = r1; r <= r2; r++) {
        HexType type = resources[index];
        hexes['$q,$r'] = Hex(q, r, type);
        index++;
      }
    }
  }

  Hex? getHex(int q, int r) {
    return hexes['$q,$r'];
  }
}
// import 'dart:math';

// import 'package:settlers_of_dune/models/hex.dart';

// class HexGrid {
//   final Map<String, Hex> hexes = {};

//   HexGrid(int radius) {
//     // Initialize hexes within the given radius
//     for (int q = -radius; q <= radius; q++) {
//       int r1 = max(-radius, -q - radius);
//       int r2 = min(radius, -q + radius);
//       for (int r = r1; r <= r2; r++) {
//         hexes['$q,$r'] = Hex(q, r, HexType.desert); // Assign types as needed
//       }
//     }
//   }

//   Hex? getHex(int q, int r) {
//     return hexes['$q,$r'];
//   }

//   // Additional utility methods as needed
// }
