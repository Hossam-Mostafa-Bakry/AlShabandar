import 'dart:convert';

import 'package:flutter/material.dart';

class User {
  int accountID;
  String firstName;
  String mobile;
  String profilePic;
  String email;

  User._({
    this.accountID,
    this.firstName,
    this.mobile,
    this.profilePic,
    this.email,
  });

  factory User() {
    if (_this == null) _this = User._();
    return _this;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    print('ddd');
    print(json.toString());
    if (_this == null) {
      _this = User._(
        accountID: json["appUserId"],
        firstName: json["name"],
        profilePic: json["image"],
        mobile: json["phone"],
        email: json["email"],
      );
    } else {
      _this.firstName = json["name"];
      _this.profilePic = json["image"];
      _this.mobile = json["phone"];
      _this.email = json["email"];
    }

    return _this;
  }

  static printUser() {
    debugPrint(_this.mobile);
    debugPrint(_this.firstName);
  }

  clearUser() {
    firstName = null;
    profilePic = null;
    mobile = null;
  }

  static User _this;
}
