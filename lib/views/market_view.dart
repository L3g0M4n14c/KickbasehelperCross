import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/kickbase_manager.dart';
import '../models/player.dart';

class MarketView extends StatefulWidget {
  const MarketView({Key? key}) : super(key: key);

  @override
  State<MarketView> createState() => _MarketViewState();
}

class _MarketViewState extends State<MarketView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final manager = Provider.of<KickbaseManager>(context, listen: false);
      if (manager.selectedLeague != null) {
        manager.loadMarketPlayers();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<KickbaseManager>(
      builder: (context, manager, child) {
        final currencyFormat = NumberFormat.currency(locale: 'de_DE', symbol: '€', decimalDigits: 0);

        return manager.isLoading
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: () => manager.loadMarketPlayers(),
                child: manager.marketPlayers.isEmpty
                    ? const Center(
                        child: Text(
                          'Keine Spieler auf dem Markt',
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    : ListView.builder(
                        itemCount: manager.marketPlayers.length,
                        itemBuilder: (context, index) {
                          final player = manager.marketPlayers[index];
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
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(player.teamName),
                                  Text(
                                    'Angebote: ${player.offers}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    currencyFormat.format(player.price),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.green,
                                    ),
                                  ),
                                  Text(
                                    'MW: ${currencyFormat.format(player.marketValue)}',
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
