import 'package:flutter/material.dart';
import 'package:qpi/splash/views/home.dart';
import 'package:qpi/splash/views/menu.dart';
import 'package:qpi/splash/views/products.dart';
import 'package:qpi/splash/views/subscription.dart';

class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/detail';
}

class TabNavigator extends StatelessWidget {
  TabNavigator({this.navigatorKey, this.tabItem, this.onBack, this.loginBack});
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;
  final onBack, loginBack;

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (tabItem == "Home") {
      print(tabItem);
      // ColorValue.setString(Colors.blue);
      child = Home(
        action: onBack,
      );
    } else if (tabItem == "Products") {
      print(tabItem);

      child = Products(
        action: onBack,
      );
    } else if (tabItem == "Subscription") {
      print(tabItem);

      child = Subscription(
        action: onBack,
      );
    } else if (tabItem == "Menu") {
      print(tabItem);

      child = Menu(
        action: onBack,
      );
    }

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}
