class UserModel {
  String email;
  String id;
  String userName;
  String phone;

  UserModel(
      {required this.email,
      required this.id,
      required this.userName,
      required this.phone});

  UserModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          email: json['email'],
          userName: json['userName'],
          phone: json['phone'],
        );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "email": email,
      "userName": userName,
      "phone": phone,
    };
  }
}
