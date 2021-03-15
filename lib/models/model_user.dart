class UserModel {
  final String id;
  String image;

  UserModel({
    this.id,
    this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] as String ?? '',
      image: json['image'] as String ?? '',
    );
  }

  factory UserModel.fromDatabase(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String ?? '',
      image: json['image'] as String ?? '',
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
