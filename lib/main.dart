import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/kickbase_manager.dart';
import 'views/team_view.dart';
import 'views/market_view.dart';
import 'views/sales_recommendation_view.dart';
import 'views/lineup_optimizer_view.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => KickbaseManager(),
      child: const KickbaseHelperApp(),
    ),
  );
}

class KickbaseHelperApp extends StatelessWidget {
  const KickbaseHelperApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kickbase Helper',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const MainDashboard(),
    );
  }
}

class MainDashboard extends StatefulWidget {
  const MainDashboard({Key? key}) : super(key: key);

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _selectedIndex = 0;

  static final List<Widget> _tabs = <Widget>[
    TeamView(),
    MarketView(),
    SalesRecommendationView(),
    LineupOptimizerView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kickbase Helper')), 
      body: _tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Team',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Markt',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Verkaufen',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted),
            label: 'Aufstellung',
          ),
        ],
      ),
    );
  }
}