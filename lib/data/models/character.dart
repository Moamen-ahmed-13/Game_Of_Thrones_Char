class Character {
  late int charId;
  late String name;
  late String nickname;
  late String charFamily;
  late String charImage;

  Character.fromJson(Map<String, dynamic> json) {
    charId = json['id'];
    name = json['fullName'] ?? 'Unknown';
    nickname = json['title'] ?? 'Unknown';
    charFamily = json['family'] ?? 'Unknown';
    charImage = json['imageUrl'] ?? '';
  }
}
