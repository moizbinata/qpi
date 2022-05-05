import 'dart:convert';

List<UserModel> userModelFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.mobile,
    this.email,
    this.addr,
    this.username,
    this.status,
    this.promolink,
    this.ctype,
    this.error,
  });

  String mobile;
  String email;
  String addr;
  String username;
  String status;
  String promolink;
  String ctype;
  bool error;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        mobile: json["mobile"],
        email: json["email"],
        addr: json["addr"],
        username: json["username"],
        status: json["status"],
        promolink: json["promolink"],
        ctype: json["ctype"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "mobile": mobile,
        "email": email,
        "addr": addr,
        "username": username,
        "status": status,
        "promolink": promolink,
        "ctype": ctype,
        "error": error,
      };
}
