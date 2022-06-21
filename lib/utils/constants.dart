import 'package:flutter/material.dart';

class Constants {
  static final baseUrl = "http://www.qpifoods.com/";

  static final primaryColor = Color(0xff385486); //cbedff
  static final secondaryColor = Color(0xff02a6de); //2ac3ff
  static final lightBlue = Color(0xffc1d5f6); //2ac3ff
  static final red = Color(0xffe84a4a); //05103a
  static final darkBlue = Color(0xff05103a); //2b9f5f
  static final green = Color(0xff2b9f5f); //f7f5d2
  static final lightGrey = Color(0xfff7f5d2); //grey.shade400
  static final grey = Colors.grey.shade600; //grey.shade400
  static final List<String> banImgs = [
    "http://qpifoods.com/mystore/banners/mainbanner/ban5.jpg",
    "http://qpifoods.com/mystore/banners/mainbanner/ban6.jpg",
    "http://qpifoods.com/mystore/banners/mainbanner/ban7.jpg",
    "http://qpifoods.com/mystore/banners/mainbanner/ban9.jpg",
    "http://qpifoods.com/mystore/banners/mainbanner/ban10.jpg",
    "http://qpifoods.com/mystore/banners/mainbanner/ban11.jpg",
  ];
  // 'assets/img/ban_1.jpeg',
  // // 'assets/img/ban_1.jpeg',
  // 'assets/img/ban_2.jpeg',
  // 'assets/img/ban_3.jpeg',
  // 'assets/img/ban_4.jpeg',
  // 'assets/img/ban_5.jpeg',
  // static final requiredValidator =
  //     RequiredValidator(errorText: 'this field is required');
  static Widget loader() => Center(
          child: CircularProgressIndicator(
        backgroundColor: Constants.secondaryColor,
        color: Constants.primaryColor,
      ));

  // static Future<SharedPreferences> init() async {
  //   prefs = await _instance;
  //   return prefs;
  // }
}
