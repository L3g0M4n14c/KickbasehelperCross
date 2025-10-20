class League {
  final String id;
  final String name;
  final String creatorName;
  final String adminName;
  final String created;
  final String season;
  final int matchDay;
  final LeagueUser currentUser;

  League({
    required this.id,
    required this.name,
    required this.creatorName,
    required this.adminName,
    required this.created,
    required this.season,
    required this.matchDay,
    required this.currentUser,
  });

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      creatorName: json['creatorName'] ?? '',
      adminName: json['adminName'] ?? '',
      created: json['created'] ?? '',
      season: json['season'] ?? '',
      matchDay: json['matchDay'] ?? 0,
      currentUser: LeagueUser.fromJson(json['currentUser'] ?? {}),
    );
  }
}

class LeagueUser {
  final String id;
  final String name;
  final String teamName;
  final int budget;
  final int teamValue;
  final int points;
  final int placement;
  final int won;
  final int drawn;
  final int lost;
  final int se11;
  final int ttm;

  LeagueUser({
    required this.id,
    required this.name,
    required this.teamName,
    required this.budget,
    required this.teamValue,
    required this.points,
    required this.placement,
    required this.won,
    required this.drawn,
    required this.lost,
    required this.se11,
    required this.ttm,
  });

  factory LeagueUser.fromJson(Map<String, dynamic> json) {
    return LeagueUser(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      teamName: json['teamName'] ?? '',
      budget: json['budget'] ?? 0,
      teamValue: json['teamValue'] ?? 0,
      points: json['points'] ?? 0,
      placement: json['placement'] ?? 0,
      won: json['won'] ?? 0,
      drawn: json['drawn'] ?? 0,
      lost: json['lost'] ?? 0,
      se11: json['se11'] ?? 0,
      ttm: json['ttm'] ?? 0,
    );
  }
}
