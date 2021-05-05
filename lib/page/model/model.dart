class UserModel {
  String name;
  int score;

  UserModel({this.name, this.score});

  factory UserModel.fromjson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] as String,
      score: json['score'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "score": score,
      };
}
