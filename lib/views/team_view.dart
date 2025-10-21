import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/kickbase_manager.dart';
import '../models/player.dart';

class TeamView extends StatefulWidget {
  const TeamView({Key? key}) : super(key: key);

  @override
  State<TeamView> createState() => _TeamViewState();
}

class _TeamViewState extends State<TeamView> {
  String _sortBy = 'marketValue';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final manager = Provider.of<KickbaseManager>(context, listen: false);
      if (manager.selectedLeague != null) {
        manager.loadTeamPlayers();
      }
    });
  }

  List<Player> _getSortedPlayers(List<Player> players) {
    final sortedPlayers = List<Player>.from(players);
    switch (_sortBy) {
      case 'name':
        sortedPlayers.sort((a, b) => a.fullName.compareTo(b.fullName));
        break;
      case 'marketValue':
        sortedPlayers.sort((a, b) => b.marketValue.compareTo(a.marketValue));
        break;
      case 'points':
        sortedPlayers.sort((a, b) => b.totalPoints.compareTo(a.totalPoints));
        break;
      case 'position':
        sortedPlayers.sort((a, b) => a.position.compareTo(b.position));
        break;
    }
    return sortedPlayers;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<KickbaseManager>(
      builder: (context, manager, child) {
        final sortedPlayers = _getSortedPlayers(manager.teamPlayers);
        final currencyFormat = NumberFormat.currency(locale: 'de_DE', symbol: '€', decimalDigits: 0);

        return Column(
          children: [
            if (manager.userStats != null)
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.green.shade50,
                child: Column(
                  children: [
                    Text(
                      'Budget: ${currencyFormat.format(manager.userStats!.budget)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Teamwert: ${currencyFormat.format(manager.userStats!.teamValue)}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Text('Sortieren: '),
                  const SizedBox(width: 8),
                  Expanded(
                    child: SegmentedButton<String>(
                      segments: const [
                        ButtonSegment(value: 'marketValue', label: Text('Wert')),
                        ButtonSegment(value: 'points', label: Text('Punkte')),
                        ButtonSegment(value: 'position', label: Text('Position')),
                        ButtonSegment(value: 'name', label: Text('Name')),
                      ],
                      selected: {_sortBy},
                      onSelectionChanged: (Set<String> newSelection) {
                        setState(() {
                          _sortBy = newSelection.first;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: manager.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : RefreshIndicator(
                      onRefresh: () => manager.loadTeamPlayers(),
                      child: ListView.builder(
                        itemCount: sortedPlayers.length,
                        itemBuilder: (context, index) {
                          final player = sortedPlayers[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: _getPositionColor(player.position),
                                child: Text(
                                  player.positionName,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              title: Text(
                                player.fullName,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(player.teamName),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    currencyFormat.format(player.marketValue),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    '${player.totalPoints} Pkt',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ),
          ],
        );
      },
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
