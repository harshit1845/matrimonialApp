class UserProfile {
  final String fullName;
  final String? image;
  final int id;

  UserProfile({required this.fullName, this.image,required this.id});

  factory UserProfile.fromJson(Map<String, dynamic> j) =>
      UserProfile(fullName: j['fullName'] ?? '', image: j['image'],id: j['id']);
}

class MatchProfile {
  final String fullName;
  final int age;
  final String city;
  final String? image;

  MatchProfile({
    required this.fullName,
    required this.age,
    required this.city,
    this.image,
  });

  factory MatchProfile.fromJson(Map<String, dynamic> j) {
    // quick age calc from yyyy‑MM‑dd
    int age = 0;
    try {
      final dob = DateTime.parse(j['dateOfBirth']);
      final now = DateTime.now();
      age = now.year - dob.year -
          ((now.month < dob.month ||
              (now.month == dob.month && now.day < dob.day))
              ? 1
              : 0);
    } catch (_) {}
    return MatchProfile(
      fullName: j['fullName'] ?? '',
      age: age,
      city: j['city'] ?? '',
      image: j['image'],
    );
  }
}
