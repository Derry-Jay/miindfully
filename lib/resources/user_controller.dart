import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:miindfully/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:miindfully/models/category.dart';
import 'package:miindfully/models/category_base.dart';
import 'package:miindfully/models/reply.dart';
import 'package:miindfully/models/user_model.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends ControllerMVC {
  Future<SharedPreferences> sharedPrefs = SharedPreferences.getInstance();
  ValueNotifier<UserModel> user = ValueNotifier(UserModel());
  List<Category> categories = <Category>[];
  List<String> images = <String>[
    "assets/images/fiords.jpg",
    "assets/images/greatwall.jpg",
    "assets/images/mountain.jpg",
    "assets/images/river.jpg",
  ];
  UserController() {
    setValue();
  }
  void login() async {
    try {
      final url =
          Uri.parse("https://nodeserver.mydevfactory.com:1971/api/login");
      final response = await post(url, body: user.value.toMap());
      final result = Reply.fromMap(json.decode(response.body));
      print(result.data);
      if (result.base.code == 200) {
        final prefs = await sharedPrefs;
        user.value = UserModel.fromJson(result.data);
        print(user.value.toJson());
        if (await prefs.setString("userID", user.value.id!) &&
            await prefs.setString("apiToken", user.value.apiToken!))
          Navigator.of(state!.context).push(MaterialPageRoute(
              builder: (context) => Home(userData: user.value)));
      } else
        ScaffoldMessenger.of(state!.context)
            .showSnackBar(SnackBar(content: Text(result.base.message)));
    } catch (e) {
      RegExp re = RegExp(r'SocketException');
      ScaffoldMessenger.of(state!.context).showSnackBar(SnackBar(
          content: Text((re.hasMatch(e.toString()) ? "Server" : "Unknown") +
              " Error.... Please try later")));
      rethrow;
    }
  }

  void register() async {
    try {
      final url =
          Uri.parse("https://nodeserver.mydevfactory.com:1971/api/register");
      final response = await post(url, body: user.value.toJson());
      final result = Reply.fromMap(json.decode(response.body));
      if (result.base.code == 200) {
        user.value = UserModel.fromJson(result.data);
        Navigator.of(state!.context).push(MaterialPageRoute(
            builder: (context) => Home(userData: user.value)));
      } else
        ScaffoldMessenger.of(state!.context)
            .showSnackBar(SnackBar(content: Text(result.base.message)));
    } catch (e) {
      RegExp re = RegExp(r'SocketException');
      ScaffoldMessenger.of(state!.context).showSnackBar(SnackBar(
          content: Text((re.hasMatch(e.toString()) ? "Server" : "Unknown") +
              " Error.... Please try later")));
      rethrow;
    }
  }

  void setValue() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    if (user.value.token == null || user.value.token!.isEmpty)
      user.value.token = androidInfo.id;
  }

  void waitForCategories() async {
    try {
      final prefs = await sharedPrefs;
      final body = {"_id": prefs.getString("userID")};
      final url = Uri.parse(
          "https://nodeserver.mydevfactory.com:1971/api/getallcategories");
      print(prefs.getString("apiToken"));
      final result = await post(url, body: body, headers: {
        HttpHeaders.authorizationHeader:
            "Bearer " + prefs.getString("apiToken")!
      });
      print(result.body);
      final value = CategoryBase.fromMap(json.decode(result.body));
      if (value.base.code == 200)
        setState(() {
          categories.addAll(value.categories);
        });
    } catch (e) {
      rethrow;
    }
  }
}
