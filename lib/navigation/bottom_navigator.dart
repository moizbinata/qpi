import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qpi/components/components.dart';
import 'package:qpi/navigation/tab_navigator.dart';
import 'package:qpi/splash/views/home.dart';
import 'package:qpi/splash/views/login.dart';
import 'package:qpi/utils/constants.dart';
import 'package:qpi/utils/size_config.dart';
import 'package:get/get.dart';
import 'package:qpi/controller/product_controller.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({Key key}) : super(key: key);

  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _currentPage = 0;
  List<String> pageKeys = ["Home", "Products", "Subscription", "Menu"];
  final Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "Home": GlobalKey<NavigatorState>(),
    "Products": GlobalKey<NavigatorState>(),
    "Subscription": GlobalKey<NavigatorState>(),
    "Menu": GlobalKey<NavigatorState>(),
  };
  final controller = Get.put(ProductController());

  void _selectTab(String tabItem, int index) {
    if (tabItem == pageKeys[_currentPage]) {
      _navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentPage = index;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

//toLoginBack not used
  toLoginBack() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }

  toHome() {
    // _selectTab('Home', 0);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }

  Future<bool> onWilPop(home) async {
    print("onWilPop:::::");
    final isFirstRouteInCurrentTab =
        !await _navigatorKeys[_currentPage].currentState.maybePop();
    if (isFirstRouteInCurrentTab) {
      if (_currentPage != 0) {
        _selectTab('Home', 0);
        return false;
      }
    }
    return isFirstRouteInCurrentTab;
  }

  @override
  Widget build(BuildContext context) {
    // String menuIconDir = 'assets/svgs/bill.svg';

    bool s = MediaQuery.of(context).viewInsets.bottom != 0;
    return WillPopScope(
      onWillPop: () => onWilPop(false),
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            _buildOffstageNavigator("Home"),
            _buildOffstageNavigator("Products"),
            _buildOffstageNavigator("Subscription"),
            _buildOffstageNavigator("Menu"),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0.0,
          color: Colors.white,
          child: SizedBox(
            height: SizeConfig.heightMultiplier * 8,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: SizeConfig.screenWidth * 0.25,
                  child: InkWell(
                    onTap: () {
                      controller.fetchProdList();
                      _selectTab("Home", 0);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Transform.translate(
                          offset: Offset(0, (_currentPage == 0) ? -10 : 0),
                          child: CircleAvatar(
                            radius: SizeConfig.heightMultiplier * 2.5,
                            backgroundColor: (_currentPage == 0)
                                ? Constants.primaryColor
                                : Colors.transparent,
                            child: FaIcon(
                              Icons.home_filled,
                              color: (_currentPage == 0)
                                  ? Colors.white
                                  : Constants.primaryColor,
                              size: (_currentPage == 0)
                                  ? SizeConfig.textMultiplier * 3
                                  : SizeConfig.textMultiplier * 3.5,
                            ),
                          ),
                        ),
                        regularText("Home", 1.8, Constants.primaryColor,
                            FontWeight.normal, false),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: SizeConfig.screenWidth * 0.25,
                  child: InkWell(
                    onTap: () {
                      _selectTab("Products", 1);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Transform.translate(
                          offset: Offset(0, (_currentPage == 1) ? -10 : 0),
                          child: CircleAvatar(
                            radius: SizeConfig.heightMultiplier * 2.5,
                            backgroundColor: (_currentPage == 1)
                                ? Constants.primaryColor
                                : Colors.transparent,
                            child: FaIcon(
                              FontAwesomeIcons.opencart,
                              color: (_currentPage == 1)
                                  ? Colors.white
                                  : Constants.primaryColor,
                              size: (_currentPage == 1)
                                  ? SizeConfig.textMultiplier * 3
                                  : SizeConfig.textMultiplier * 3.5,
                            ),
                          ),
                        ),
                        regularText("Products", 1.8, Constants.primaryColor,
                            FontWeight.normal, false),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: SizeConfig.screenWidth * 0.25,
                  child: InkWell(
                    onTap: () {
                      _selectTab("Subscription", 2);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Transform.translate(
                          offset: Offset(0, (_currentPage == 2) ? -10 : 0),
                          child: CircleAvatar(
                            radius: SizeConfig.heightMultiplier * 2.5,
                            backgroundColor: (_currentPage == 2)
                                ? Constants.primaryColor
                                : Colors.transparent,
                            child: FaIcon(
                              Icons.favorite,
                              color: (_currentPage == 2)
                                  ? Colors.white
                                  : Constants.primaryColor,
                              size: (_currentPage == 2)
                                  ? SizeConfig.textMultiplier * 3
                                  : SizeConfig.textMultiplier * 3.5,
                            ),
                          ),
                        ),
                        regularText("Subscription", 1.8, Constants.primaryColor,
                            FontWeight.normal, false),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: SizeConfig.screenWidth * 0.25,
                  child: InkWell(
                    onTap: () {
                      _selectTab("Menu", 3);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Transform.translate(
                          offset: Offset(0, (_currentPage == 3) ? -10 : 0),
                          child: CircleAvatar(
                            radius: SizeConfig.heightMultiplier * 2.5,
                            backgroundColor: (_currentPage == 3)
                                ? Constants.primaryColor
                                : Colors.transparent,
                            child: FaIcon(
                              Icons.menu,
                              color: (_currentPage == 3)
                                  ? Colors.white
                                  : Constants.primaryColor,
                              size: (_currentPage == 3)
                                  ? SizeConfig.textMultiplier * 3
                                  : SizeConfig.textMultiplier * 3.5,
                            ),
                          ),
                        ),
                        regularText("Menu", 1.8, Constants.primaryColor,
                            FontWeight.normal, false),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: pageKeys[_currentPage] != tabItem,
      child: TabNavigator(
          navigatorKey: _navigatorKeys[tabItem],
          tabItem: tabItem,
          onBack: toHome,
          loginBack: toLoginBack),
    );
  }
}
