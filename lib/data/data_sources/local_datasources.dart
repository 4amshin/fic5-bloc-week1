import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSources {
  //save token into local
  Future<void> saveToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('token', token);
    log("Token Saved = $token");
  }

  //get the token
  Future<String> getToken() async {
    final pref = await SharedPreferences.getInstance();
    //get the token with key 'token'
    final token = pref.getString('token') ?? '';
    log("Get Token = $token");
    return token;
  }

  //delete the token
  Future<void> deleteToken() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove('token');
    log("Token Deleted");
  }
}
