class Player {
  final String id;
  final String name;
  final Inventory inventory;

  Player(this.id, this.name) : inventory = Inventory();
}

class Inventory {
  final Map<CardType, int> cards = {};

  void addCard(CardType type, [int quantity = 1]) {
    cards[type] = (cards[type] ?? 0) + quantity;
  }

  void removeCard(CardType type, [int quantity = 1]) {
    if ((cards[type] ?? 0) >= quantity) {
      cards[type] = (cards[type] ?? 0) - quantity;
    }
  }
}

enum CardType {
  resource,
  development,
  // Add other card types as needed
}
