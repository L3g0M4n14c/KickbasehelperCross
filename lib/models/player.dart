class Player {
  final String id;
  final String firstName;
  final String lastName;
  final String profileBigUrl;
  final String teamName;
  final String teamId;
  final int position;
  final int number;
  final double averagePoints;
  final int totalPoints;
  final int marketValue;
  final int marketValueTrend;
  final int tfhmvt;
  final int prlo;
  final int stl;
  final int status;
  final bool userOwnsPlayer;

  Player({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.profileBigUrl,
    required this.teamName,
    required this.teamId,
    required this.position,
    required this.number,
    required this.averagePoints,
    required this.totalPoints,
    required this.marketValue,
    required this.marketValueTrend,
    required this.tfhmvt,
    required this.prlo,
    required this.stl,
    required this.status,
    required this.userOwnsPlayer,
  });

  String get fullName => '$firstName $lastName';

  String get positionName {
    switch (position) {
      case 1:
        return 'TW';
      case 2:
        return 'ABW';
      case 3:
        return 'MF';
      case 4:
        return 'ST';
      default:
        return '?';
    }
  }

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      profileBigUrl: json['profileBigUrl'] ?? '',
      teamName: json['teamName'] ?? '',
      teamId: json['teamId'] ?? '',
      position: json['position'] ?? 0,
      number: json['number'] ?? 0,
      averagePoints: (json['averagePoints'] ?? 0).toDouble(),
      totalPoints: json['totalPoints'] ?? 0,
      marketValue: json['marketValue'] ?? 0,
      marketValueTrend: json['marketValueTrend'] ?? 0,
      tfhmvt: json['tfhmvt'] ?? 0,
      prlo: json['prlo'] ?? 0,
      stl: json['stl'] ?? 0,
      status: json['status'] ?? 0,
      userOwnsPlayer: json['userOwnsPlayer'] ?? false,
    );
  }
}

class MarketPlayer {
  final String id;
  final String firstName;
  final String lastName;
  final String profileBigUrl;
  final String teamName;
  final String teamId;
  final int position;
  final int number;
  final double averagePoints;
  final int totalPoints;
  final int marketValue;
  final int marketValueTrend;
  final int price;
  final String expiry;
  final int offers;
  final int stl;
  final int status;

  MarketPlayer({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.profileBigUrl,
    required this.teamName,
    required this.teamId,
    required this.position,
    required this.number,
    required this.averagePoints,
    required this.totalPoints,
    required this.marketValue,
    required this.marketValueTrend,
    required this.price,
    required this.expiry,
    required this.offers,
    required this.stl,
    required this.status,
  });

  String get fullName => '$firstName $lastName';

  String get positionName {
    switch (position) {
      case 1:
        return 'TW';
      case 2:
        return 'ABW';
      case 3:
        return 'MF';
      case 4:
        return 'ST';
      default:
        return '?';
    }
  }

  factory MarketPlayer.fromJson(Map<String, dynamic> json) {
    return MarketPlayer(
      id: json['id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      profileBigUrl: json['profileBigUrl'] ?? '',
      teamName: json['teamName'] ?? '',
      teamId: json['teamId'] ?? '',
      position: json['position'] ?? 0,
      number: json['number'] ?? 0,
      averagePoints: (json['averagePoints'] ?? 0).toDouble(),
      totalPoints: json['totalPoints'] ?? 0,
      marketValue: json['marketValue'] ?? 0,
      marketValueTrend: json['marketValueTrend'] ?? 0,
      price: json['price'] ?? 0,
      expiry: json['expiry'] ?? '',
      offers: json['offers'] ?? 0,
      stl: json['stl'] ?? 0,
      status: json['status'] ?? 0,
    );
  }
}

class UserStats {
  final int budget;
  final int teamValue;
  final int points;
  final int placement;

  UserStats({
    required this.budget,
    required this.teamValue,
    required this.points,
    required this.placement,
  });

  factory UserStats.fromJson(Map<String, dynamic> json) {
    return UserStats(
      budget: json['budget'] ?? 0,
      teamValue: json['teamValue'] ?? 0,
      points: json['points'] ?? 0,
      placement: json['placement'] ?? 0,
    );
  }
}
