class User {
  final String id;
  final String name;
  final String teamName;
  final String email;
  final int budget;
  final int teamValue;
  final int points;
  final int placement;
  final int flags;

  User({
    required this.id,
    required this.name,
    required this.teamName,
    required this.email,
    required this.budget,
    required this.teamValue,
    required this.points,
    required this.placement,
    required this.flags,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['i'] ?? json['id'] ?? '',
      name: json['n'] ?? json['name'] ?? '',
      teamName: json['tn'] ?? json['teamName'] ?? '',
      email: json['em'] ?? json['email'] ?? '',
      budget: json['b'] ?? json['budget'] ?? 0,
      teamValue: json['tv'] ?? json['teamValue'] ?? 0,
      points: json['p'] ?? json['points'] ?? 0,
      placement: json['pl'] ?? json['placement'] ?? 0,
      flags: json['f'] ?? json['flags'] ?? 0,
    );
  }
}
