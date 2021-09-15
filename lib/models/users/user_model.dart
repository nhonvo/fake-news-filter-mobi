class UserModel {
  String username;
  String? fullname;
  String? email;
  String? token;
  String? avt;
  String? phone;
  String? countryCode;

  UserModel({
    required this.username,
    this.fullname,
    this.email,
    this.token,
    this.avt,
    this.phone,
    this.countryCode,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json["username"],
      fullname: json["fullname"],
      email: json["email"],
      token: json["token"],
      avt: json['avatar'],
      phone: json['phoneNumber'],
      countryCode: json['countryCode'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    if (this.fullname != null) data['lastName'] = this.fullname;
    data['email'] = this.email;
    return data;
  }
}
