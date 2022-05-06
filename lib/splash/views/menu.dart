import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qpi/components/components.dart';
import 'package:qpi/splash/views/search_map.dart';
import 'package:qpi/utils/constants.dart';
import 'package:qpi/utils/size_config.dart';
import 'package:url_launcher/url_launcher.dart';

class Menu extends StatelessWidget {
  final action;
  Menu({Key key, this.action}) : super(key: key);
  GetStorage box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.primaryColor,
      body: SafeArea(
          child: SizedBox(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  'assets/img/logo4.png',
                  height: SizeConfig.heightMultiplier * 15,
                ),
                ListTile(
                  leading: FaIcon(
                    FontAwesomeIcons.user,
                    color: Colors.white,
                  ),
                  title: regularText("Personal Information", 2.0, Colors.white,
                      FontWeight.bold, 0),
                ),
                buildInfoTile('Username', 'username'),
                buildInfoTile('Email', 'email'),
                buildInfoTile('Mobile', 'mobile'),
                buildInfoTile('Address', 'address'),
                buildInfoTile('Promolink', 'promoLink'),
                buildInfoTile('Customer Type', 'cusType'),
                ListTile(
                  leading: FaIcon(
                    FontAwesomeIcons.wallet,
                    color: Colors.white,
                  ),
                  title: regularText(
                      "My Wallet", 2.0, Colors.white, FontWeight.bold, 0),
                  trailing: regularText(
                      "0.0 INR", 2.0, Colors.white, FontWeight.bold, 0),
                ),
                ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  title: regularText(
                      "Logout", 2.0, Colors.white, FontWeight.bold, 0),
                  onTap: () {
                    GetStorage box = GetStorage();
                    box.erase();
                    action();
                  },
                )
              ],
            ),
            Column(
              children: [
                ListTile(
                  onTap: () async {
                    final Uri launchUri = Uri(
                      scheme: 'tel',
                      path: '9986768269',
                    );

                    await launchUrl(launchUri);
                  },
                  leading: FaIcon(
                    FontAwesomeIcons.phone,
                    color: Colors.white,
                  ),
                  title: regularText(
                      "9986768269", 2.2, Colors.white, FontWeight.bold, 0),
                ),
                ListTile(
                  onTap: () {
                    launchUrl(
                      Uri.parse("www.tompee.com"),
                      mode: LaunchMode.externalApplication,
                    );
                  },
                  leading: FaIcon(
                    FontAwesomeIcons.globe,
                    color: Colors.white,
                  ),
                  title: regularText(
                      "www.tompee.com", 2.2, Colors.white, FontWeight.bold, 0),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }

  buildInfoTile(keyName, valueName) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: SizeConfig.heightMultiplier * 3),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child:
                regularText(keyName, 1.9, Colors.white, FontWeight.normal, 0),
          ),
          Expanded(
            flex: 1,
            child: regularText(box.read(valueName).toString().toUpperCase(),
                1.9, Color.fromARGB(255, 196, 194, 194), FontWeight.normal, 0),
          ),
        ],
      ),
    );
  }
}
