import 'package:flutter/material.dart';
import 'package:settlers_of_dune/models/player.dart';

class PlayerInfoBox extends StatelessWidget {
  final List<Player> players;

  const PlayerInfoBox({super.key, required this.players});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: players.map((player) {
          return Container(
            margin: const EdgeInsets.all(8.0),
            width: 200, // Width for each player card
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      player.name,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Text('ID: ${player.id}'),
                    const SizedBox(height: 8),
                    const Text('Inventory:'),
                    for (var entry in player.inventory.resourceCards.entries) Text('${entry.key.toString().split('.').last}: ${entry.value}'),
                    for (var entry in player.inventory.developmentCards.entries) Text('${entry.key.toString().split('.').last}: ${entry.value}'),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
