class UserModel {
  final String id;
  String image;

  UserModel({
    required this.id,
    required this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      image: json['image'] ?? '',
    );
  }

  factory UserModel.fromDatabase(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toDatabase() {
    Map<String, dynamic> item = {
      "id": id,
      "image": image,
    };
    return item;
  }
}
