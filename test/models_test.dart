import 'package:flutter_test/flutter_test.dart';
import 'package:kickbasehelper_cross/models/player.dart';
import 'package:kickbasehelper_cross/models/league.dart';
import 'package:kickbasehelper_cross/models/user.dart';

void main() {
  group('Player Model Tests', () {
    test('Player.fromJson creates valid Player object', () {
      final json = {
        'id': '123',
        'firstName': 'Thomas',
        'lastName': 'Müller',
        'profileBigUrl': 'https://example.com/player.jpg',
        'teamName': 'Bayern München',
        'teamId': 'FCB',
        'position': 4,
        'number': 25,
        'averagePoints': 150.5,
        'totalPoints': 1505,
        'marketValue': 10000000,
        'marketValueTrend': 1,
        'tfhmvt': 500000,
        'prlo': 200000,
        'stl': 0,
        'status': 0,
        'userOwnsPlayer': true,
      };

      final player = Player.fromJson(json);

      expect(player.id, '123');
      expect(player.firstName, 'Thomas');
      expect(player.lastName, 'Müller');
      expect(player.fullName, 'Thomas Müller');
      expect(player.position, 4);
      expect(player.positionName, 'ST');
      expect(player.totalPoints, 1505);
      expect(player.marketValue, 10000000);
    });

    test('Player position names are correct', () {
      expect(Player.fromJson({'position': 1}).positionName, 'TW');
      expect(Player.fromJson({'position': 2}).positionName, 'ABW');
      expect(Player.fromJson({'position': 3}).positionName, 'MF');
      expect(Player.fromJson({'position': 4}).positionName, 'ST');
      expect(Player.fromJson({'position': 99}).positionName, '?');
    });
  });

  group('League Model Tests', () {
    test('League.fromJson creates valid League object', () {
      final json = {
        'id': 'league123',
        'name': 'Test Liga',
        'creatorName': 'John Doe',
        'adminName': 'Jane Doe',
        'created': '2025-01-01',
        'season': '2024/25',
        'matchDay': 15,
        'currentUser': {
          'id': 'user123',
          'name': 'Test User',
          'teamName': 'Test Team',
          'budget': 5000000,
          'teamValue': 50000000,
          'points': 1200,
          'placement': 3,
          'won': 10,
          'drawn': 3,
          'lost': 2,
          'se11': 11,
          'ttm': 100,
        },
      };

      final league = League.fromJson(json);

      expect(league.id, 'league123');
      expect(league.name, 'Test Liga');
      expect(league.matchDay, 15);
      expect(league.currentUser.name, 'Test User');
      expect(league.currentUser.budget, 5000000);
    });
  });

  group('User Model Tests', () {
    test('User.fromJson handles short field names', () {
      final json = {
        'i': 'user123',
        'n': 'Max Mustermann',
        'tn': 'FC Muster',
        'em': 'max@example.com',
        'b': 3000000,
        'tv': 40000000,
        'p': 850,
        'pl': 5,
        'f': 0,
      };

      final user = User.fromJson(json);

      expect(user.id, 'user123');
      expect(user.name, 'Max Mustermann');
      expect(user.teamName, 'FC Muster');
      expect(user.email, 'max@example.com');
      expect(user.budget, 3000000);
      expect(user.teamValue, 40000000);
      expect(user.points, 850);
      expect(user.placement, 5);
    });
  });

  group('MarketPlayer Model Tests', () {
    test('MarketPlayer.fromJson creates valid MarketPlayer object', () {
      final json = {
        'id': '456',
        'firstName': 'Robert',
        'lastName': 'Lewandowski',
        'profileBigUrl': 'https://example.com/player2.jpg',
        'teamName': 'Barcelona',
        'teamId': 'BAR',
        'position': 4,
        'number': 9,
        'averagePoints': 200.0,
        'totalPoints': 2000,
        'marketValue': 15000000,
        'marketValueTrend': 2,
        'price': 16000000,
        'expiry': '2025-10-21T12:00:00Z',
        'offers': 5,
        'stl': 0,
        'status': 0,
      };

      final marketPlayer = MarketPlayer.fromJson(json);

      expect(marketPlayer.id, '456');
      expect(marketPlayer.fullName, 'Robert Lewandowski');
      expect(marketPlayer.price, 16000000);
      expect(marketPlayer.offers, 5);
      expect(marketPlayer.positionName, 'ST');
    });
  });

  group('UserStats Model Tests', () {
    test('UserStats.fromJson creates valid UserStats object', () {
      final json = {
        'budget': 5000000,
        'teamValue': 55000000,
        'points': 1500,
        'placement': 2,
      };

      final userStats = UserStats.fromJson(json);

      expect(userStats.budget, 5000000);
      expect(userStats.teamValue, 55000000);
      expect(userStats.points, 1500);
      expect(userStats.placement, 2);
    });
  });
}
