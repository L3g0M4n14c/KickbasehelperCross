import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/kickbase_manager.dart';
import 'providers/authentication_manager.dart';
import 'views/team_view.dart';
import 'views/market_view.dart';
import 'views/sales_recommendation_view.dart';
import 'views/lineup_optimizer_view.dart';
import 'views/login_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationManager()),
        ChangeNotifierProvider(create: (_) => KickbaseManager()),
      ],
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
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: Consumer<AuthenticationManager>(
        builder: (context, authManager, child) {
          // Initialize authentication on first build
          if (!authManager.isAuthenticated) {
            authManager.initialize();
          }

          if (authManager.isAuthenticated) {
            // Set auth token for KickbaseManager
            final kickbaseManager = Provider.of<KickbaseManager>(context, listen: false);
            if (authManager.accessToken != null) {
              kickbaseManager.setAuthToken(authManager.accessToken!);
            }
            return const MainDashboard();
          } else {
            return const LoginView();
          }
        },
      ),
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

  static const List<Widget> _tabs = <Widget>[
    TeamView(),
    MarketView(),
    SalesRecommendationView(),
    LineupOptimizerView(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final kickbaseManager = Provider.of<KickbaseManager>(context, listen: false);
      kickbaseManager.loadUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<KickbaseManager, AuthenticationManager>(
      builder: (context, kickbaseManager, authManager, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Kickbase Helper'),
            elevation: 2,
            actions: [
              if (kickbaseManager.leagues.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: DropdownButton<String>(
                    value: kickbaseManager.selectedLeague?.id,
                    underline: Container(),
                    icon: const Icon(Icons.arrow_drop_down),
                    items: kickbaseManager.leagues.map((league) {
                      return DropdownMenuItem<String>(
                        value: league.id,
                        child: Text(league.name),
                      );
                    }).toList(),
                    onChanged: (String? leagueId) {
                      if (leagueId != null) {
                        final league = kickbaseManager.leagues.firstWhere(
                          (l) => l.id == leagueId,
                        );
                        kickbaseManager.selectLeague(league);
                      }
                    },
                  ),
                ),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  kickbaseManager.loadUserData();
                },
              ),
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () async {
                  await authManager.logout();
                },
              ),
            ],
          ),
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
      },
    );
  }
}