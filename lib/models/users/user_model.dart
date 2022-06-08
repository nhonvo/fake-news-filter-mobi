class UserModel {
/*
{
  "userId": "69db714f-9576-45ba-b5b7-f00649be03de",
  "fullName": "Huynh Huu Khanh",
  "phoneNumber": null,
  "userName": "hkhansh27",
  "email": "khanh200111@gmail.com",
  "role": null,
  "status": 1,
  "avatar": null,
  "noNewsContributed": null,
  "roles": [
    "Admin"
  ]
}
*/

  String? userId;
  String? fullName;
  String? phoneNumber;
  String? userName;
  String? email;
  String? role;
  int? status;
  String? avatar;
  String? noNewsContributed;
  List<String?>? roles;

  UserModel({
    this.userId,
    this.fullName,
    this.phoneNumber,
    this.userName,
    this.email,
    this.role,
    this.status,
    this.avatar,
    this.noNewsContributed,
    this.roles,
  });
  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId']?.toString();
    fullName = json['fullName']?.toString();
    phoneNumber = json['phoneNumber']?.toString();
    userName = json['userName']?.toString();
    email = json['email']?.toString();
    role = json['role']?.toString();
    status = json['status']?.toInt();
    avatar = json['avatar']?.toString();
    noNewsContributed = json['noNewsContributed']?.toString();
    if (json['roles'] != null) {
      final v = json['roles'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      roles = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userId'] = userId;
    data['fullName'] = fullName;
    data['phoneNumber'] = phoneNumber;
    data['userName'] = userName;
    data['email'] = email;
    data['role'] = role;
    data['status'] = status;
    data['avatar'] = avatar;
    data['noNewsContributed'] = noNewsContributed;
    if (roles != null) {
      final v = roles;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v);
      });
      data['roles'] = arr0;
    }
    return data;
  }
}
