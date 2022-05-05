import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qpi/components/components.dart';
import 'package:qpi/navigation/bottom_navigator.dart';
import 'package:qpi/splash/views/login.dart';
import 'package:qpi/utils/constants.dart';
import 'package:qpi/utils/size_config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  GetStorage box = GetStorage();
  @override
  void initState() {
    super.initState();
    // controller = AnimationController(
    //     duration: const Duration(milliseconds: 4000), vsync: this);
    // animation = Tween(begin: 0.0, end: 1.0).animate(controller)
    //   ..addListener(() {
    //     setState(() {});
    //   });
    // controller.repeat();
    startTime();
  }

  startTime() async {
    var duration = Duration(seconds: 4);
    return Timer(duration, route);
  }

  route() {
    if (box.read('mobile') != null) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNavigator(),
          ));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ));
    }
  }

  // @override
  // void dispose() {
  //   //controller.stop();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Constants.primaryColor, Colors.white],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/img/logo4.png'),
                width: SizeConfig.heightMultiplier * 30,
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.heightMultiplier * 2),
                child: regularText(
                    "WELCOME TO TIA 'PURE N DIVINE'\n(A UNIT OF TOMPEE FARMS & DAIRY PVT. LTD.)",
                    2.2,
                    Colors.white,
                    FontWeight.bold,
                    1),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 10,
              ),
              Image(
                image: AssetImage(
                  'assets/img/rider.png',
                ),
                width: SizeConfig.heightMultiplier * 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
