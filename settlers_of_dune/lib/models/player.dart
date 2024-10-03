import 'package:settlers_of_dune/models/enums.dart';

class Player {
  final String id;
  final String name;
  Inventory inventory;

  Player(this.id, this.name) : inventory = Inventory();
}

class Inventory {
  final Map<HexType, int> resourceCards = {};
  final Map<DevelopmentCardType, int> developmentCards = {};

  void addResourceCard(HexType type, [int quantity = 1]) {
    resourceCards[type] = (resourceCards[type] ?? 0) + quantity;
  }

  void addDevelopmentCard(DevelopmentCardType type, [int quantity = 1]) {
    developmentCards[type] = (developmentCards[type] ?? 0) + quantity;
  }

  void removeResourceCard(HexType type, [int quantity = 1]) {
    if ((resourceCards[type] ?? 0) >= quantity) {
      resourceCards[type] = (resourceCards[type] ?? 0) - quantity;
    }
  }

  void removeDevelopmentCard(DevelopmentCardType type, [int quantity = 1]) {
    if ((developmentCards[type] ?? 0) >= quantity) {
      developmentCards[type] = (developmentCards[type] ?? 0) - quantity;
    }
  }
}

enum DevelopmentCardType {
  soldier,
  thumper,
  // Add other card types as needed
}
