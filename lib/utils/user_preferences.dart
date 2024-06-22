



import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class UserPreferences {
  static late SharedPreferences _preferences;

  static const _keyUser = 'user';
  // static const myUser = User(
  //   imagePath:
  //       'https://cdn2.iconfinder.com/data/icons/circle-icons-1/64/profle-512.png',
  //   name: 'Sarah Abs',
  //   email: 'sarah.abs@gmail.com',
  //   about:
  //       'Certified Personal Trainer and Nutritionist with years of experience in creating effective diets and training plans focused on achieving individual customers goals in a smooth way.',
  //
  // );
  static const myUser = User(
    imagePath:
    'images/profile.png',
    name: 'Enter your name',
    email: 'Enter your gmail',
    about:
    'Enter about yourself',

  );

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUser(User user) async {
    final json = jsonEncode(user.toJson());

    await _preferences.setString(_keyUser, json);
  }

  static User getUser() {
    final json = _preferences.getString(_keyUser);

    return json == null ? myUser : User.fromJson(jsonDecode(json));
  }
}
