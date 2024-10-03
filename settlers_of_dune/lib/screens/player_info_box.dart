import 'package:flutter/material.dart';
import 'package:settlers_of_dune/models/player.dart';

class PlayerInfoBox extends StatelessWidget {
  final List<Player> players;

  const PlayerInfoBox({super.key, required this.players});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(225, 169, 95, 1),
      height: MediaQuery.sizeOf(context).height,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: players.map((player) {
            return Container(
              color: getSecondaryColorForString(player.id), //color of outline
              margin: const EdgeInsets.all(8.0),
              width: 200, // Width for each player card
              child: Card(
                color: getColorForString(player.id),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        player.name,
                        style: TextStyle(color: getSecondaryColorForString(player.id), fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'ID: ${player.id}',
                        style: TextStyle(
                          color: getSecondaryColorForString(player.id),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Inventory:',
                        style: TextStyle(
                          color: getSecondaryColorForString(player.id),
                        ),
                      ),
                      for (var entry in player.inventory.resourceCards.entries)
                        Text(
                          '${entry.key.toString().split('.').last}: ${entry.value}',
                          style: TextStyle(
                            color: getSecondaryColorForString(player.id),
                          ),
                        ),
                      for (var entry in player.inventory.developmentCards.entries)
                        Text(
                          '${entry.key.toString().split('.').last}: ${entry.value}',
                          style: TextStyle(
                            color: getSecondaryColorForString(player.id),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

// Assign colors based on String
Color getColorForString(String id) {
  switch (id) {
    case 'atr':
      return Color.fromARGB(255, 10, 55, 7); // Sand color -desert
    case 'har':
      return Color.fromARGB(255, 37, 37, 37); // Dark sand color-sandstone
    case 'ben':
      return Color.fromARGB(255, 84, 108, 176); // Desert-y green-flora
    case 'imp':
      return Color.fromARGB(255, 190, 9, 9); // Brown-fauna
    case 'spa':
      return Color.fromARGB(255, 235, 108, 10); // Gray - alloy
    case 'smu':
      return Color.fromARGB(255, 222, 207, 0); // Blue - water
    // case 'atr':
    //   return const Color.fromARGB(255, 255, 129, 51); // Reddish orange
    default:
      return Colors.white;
  }
}

// Assign colors based on String
Color getSecondaryColorForString(String id) {
  switch (id) {
    case 'atr':
      return Color.fromARGB(255, 168, 157, 0); // Sand color -desert
    case 'har':
      return Color.fromARGB(255, 255, 255, 255); // Dark sand color-sandstone
    case 'ben':
      return Color.fromARGB(255, 0, 0, 0); // Desert-y green-flora
    case 'imp':
      return Color.fromARGB(255, 249, 249, 249); // Brown-fauna
    case 'spa':
      return Color.fromARGB(255, 109, 47, 0); // Gray - alloy
    case 'smu':
      return Color.fromARGB(255, 93, 90, 43); // Blue - water
    // case 'atr':
    //   return const Color.fromARGB(255, 255, 129, 51); // Reddish orange
    default:
      return Colors.white;
  }
}
