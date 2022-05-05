import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qpi/controller/cart_controller.dart';
import 'package:qpi/controller/login_controller.dart';
import 'package:qpi/controller/product_controller.dart';
import 'package:qpi/splash/splash_screen.dart';
import 'package:qpi/utils/size_config.dart';

Future<void> main() async {
  // LicenseRegistry.addLicense(
  //   () async* {
  //     final license = await rootBundle.loadString('google_fonts/OFL.txt');
  //     yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  //   },
  // );
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {});
  // if (defaultTargetPlatform == TargetPlatform.android) {
  //   AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  // }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);
  final ProductController productController = Get.put(ProductController());
  final CartController cartController = Get.put(CartController());
  final LoginController loginController = Get.put(LoginController());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);

        return const GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'GBS',
          home: SplashScreen(),
        );
      });
    });
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
