import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/kickbase_manager.dart';
import '../models/player.dart';

class SalesRecommendationView extends StatefulWidget {
  const SalesRecommendationView({Key? key}) : super(key: key);

  @override
  State<SalesRecommendationView> createState() => _SalesRecommendationViewState();
}

class _SalesRecommendationViewState extends State<SalesRecommendationView> {
  final Set<String> _selectedForSale = {};

  @override
  Widget build(BuildContext context) {
    return Consumer<KickbaseManager>(
      builder: (context, manager, child) {
        final currencyFormat = NumberFormat.currency(locale: 'de_DE', symbol: '€', decimalDigits: 0);
        
        final totalSaleValue = manager.teamPlayers
            .where((p) => _selectedForSale.contains(p.id))
            .fold<int>(0, (sum, player) => sum + player.marketValue);

        return Column(
          children: [
            if (_selectedForSale.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.orange.shade50,
                child: Column(
                  children: [
                    Text(
                      'Ausgewählte Spieler: ${_selectedForSale.length}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Gesamtwert: ${currencyFormat.format(totalSaleValue)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
            Expanded(
              child: manager.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: manager.teamPlayers.length,
                      itemBuilder: (context, index) {
                        final player = manager.teamPlayers[index];
                        final isSelected = _selectedForSale.contains(player.id);

                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          color: isSelected ? Colors.orange.shade50 : null,
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
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Column(
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
                                const SizedBox(width: 8),
                                Checkbox(
                                  value: isSelected,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value == true) {
                                        _selectedForSale.add(player.id);
                                      } else {
                                        _selectedForSale.remove(player.id);
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
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
