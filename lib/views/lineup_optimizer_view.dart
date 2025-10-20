import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/kickbase_manager.dart';
import '../models/player.dart';

class LineupOptimizerView extends StatefulWidget {
  const LineupOptimizerView({Key? key}) : super(key: key);

  @override
  State<LineupOptimizerView> createState() => _LineupOptimizerViewState();
}

class _LineupOptimizerViewState extends State<LineupOptimizerView> {
  final Map<String, Player?> _lineup = {
    'TW': null,
    'ABW1': null,
    'ABW2': null,
    'ABW3': null,
    'ABW4': null,
    'MF1': null,
    'MF2': null,
    'MF3': null,
    'MF4': null,
    'ST1': null,
    'ST2': null,
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _generateOptimalLineup();
    });
  }

  void _generateOptimalLineup() {
    final manager = Provider.of<KickbaseManager>(context, listen: false);
    final players = manager.teamPlayers;

    // Reset lineup
    _lineup.forEach((key, value) {
      _lineup[key] = null;
    });

    // Sort players by total points
    final sortedPlayers = List<Player>.from(players)
      ..sort((a, b) => b.totalPoints.compareTo(a.totalPoints));

    // Get goalkeepers
    final goalkeepers = sortedPlayers.where((p) => p.position == 1).toList();
    if (goalkeepers.isNotEmpty) {
      _lineup['TW'] = goalkeepers.first;
    }

    // Get defenders
    final defenders = sortedPlayers.where((p) => p.position == 2).toList();
    for (int i = 0; i < 4 && i < defenders.length; i++) {
      _lineup['ABW${i + 1}'] = defenders[i];
    }

    // Get midfielders
    final midfielders = sortedPlayers.where((p) => p.position == 3).toList();
    for (int i = 0; i < 4 && i < midfielders.length; i++) {
      _lineup['MF${i + 1}'] = midfielders[i];
    }

    // Get forwards
    final forwards = sortedPlayers.where((p) => p.position == 4).toList();
    for (int i = 0; i < 2 && i < forwards.length; i++) {
      _lineup['ST${i + 1}'] = forwards[i];
    }

    setState(() {});
  }

  int _getTotalPoints() {
    return _lineup.values
        .where((p) => p != null)
        .fold(0, (sum, player) => sum + player!.totalPoints);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<KickbaseManager>(
      builder: (context, manager, child) {
        final currencyFormat = NumberFormat.currency(locale: 'de_DE', symbol: '€', decimalDigits: 0);

        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.blue.shade50,
              child: Column(
                children: [
                  const Text(
                    'Optimale Aufstellung',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Gesamtpunkte: ${_getTotalPoints()}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildPositionSection('Torwart', ['TW'], currencyFormat),
                    const SizedBox(height: 16),
                    _buildPositionSection(
                        'Abwehr', ['ABW1', 'ABW2', 'ABW3', 'ABW4'], currencyFormat),
                    const SizedBox(height: 16),
                    _buildPositionSection(
                        'Mittelfeld', ['MF1', 'MF2', 'MF3', 'MF4'], currencyFormat),
                    const SizedBox(height: 16),
                    _buildPositionSection('Sturm', ['ST1', 'ST2'], currencyFormat),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: _generateOptimalLineup,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Aufstellung neu berechnen'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPositionSection(
      String title, List<String> positions, NumberFormat currencyFormat) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ...positions.map((pos) {
          final player = _lineup[pos];
          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: player != null
                    ? _getPositionColor(player.position)
                    : Colors.grey,
                child: Text(
                  player?.positionName ?? '?',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                player?.fullName ?? 'Kein Spieler',
                style: TextStyle(
                  fontWeight: player != null ? FontWeight.bold : FontWeight.normal,
                  color: player != null ? Colors.black : Colors.grey,
                ),
              ),
              subtitle: player != null ? Text(player.teamName) : null,
              trailing: player != null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${player.totalPoints} Pkt',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          currencyFormat.format(player.marketValue),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    )
                  : null,
            ),
          );
        }).toList(),
      ],
    );
  }

  Color _getPositionColor(int position) {
    switch (position) {
      case 1:
        return Colors.yellow.shade700; // TW
      case 2:
        return Colors.green; // ABW
      case 3:
        return Colors.blue; // MF
      case 4:
        return Colors.red; // ST
      default:
        return Colors.grey;
    }
  }
}
