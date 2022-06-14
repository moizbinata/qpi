import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qpi/components/components.dart';
import 'package:qpi/controller/product_controller.dart';
import 'package:qpi/splash/views/cart.dart';
import 'package:qpi/splash/views/home.dart';
import 'package:qpi/splash/views/proddetail_seller.dart';
import 'package:qpi/utils/size_config.dart';
import 'package:qpi/splash/views/prodDetail.dart';
import 'package:qpi/utils/constants.dart';

import 'package:get/get.dart';

class Subscription extends StatelessWidget {
  final action;
  Subscription({Key key, this.action}) : super(key: key);
  GetStorage box = GetStorage();
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());

    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListTile(
                // contentPadding: EdgeInsets.zero,
                minVerticalPadding: 0,
                leading: regularText("Most Liked Products", 2.6,
                    Constants.primaryColor, FontWeight.bold, 0),
                trailing: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Cart(),
                        ));
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.opencart,
                    size: SizeConfig.heightMultiplier * 4,
                    color: Constants.primaryColor,
                  ),
                ),
              ),

              //first two
              GridView.builder(
                itemCount: 4,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      if (box.read('cusType').toString() == "Seller") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProdDetailSeller(
                                selProd: controller.prodList[index],
                              ),
                            ));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProdDetail(
                                selProd: controller.prodList[index],
                              ),
                            ));
                      }
                    },
                    child: productBox(
                      controller.prodList[index].url,
                      controller.prodList[index].servicename,
                      controller.prodList[index].price,
                      controller.prodList[index].productid,
                      controller.prodList[index].category,
                    ),
                  );
                },
              ),
              spaces(),
              Image.asset(
                'assets/img/ban_2.jpeg',
                width: SizeConfig.screenWidth,
              ),
              spaces(),
              //second two
              GridView.builder(
                itemCount: 4,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      if (box.read('cusType').toString() == "Seller") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProdDetailSeller(
                                selProd: controller.prodList[index + 4],
                              ),
                            ));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProdDetail(
                                selProd: controller.prodList[index + 4],
                              ),
                            ));
                      }
                    },
                    child: productBox(
                      controller.prodList[index + 4].url,
                      controller.prodList[index + 4].servicename,
                      controller.prodList[index + 4].price,
                      controller.prodList[index + 4].productid,
                      controller.prodList[index + 4].category,
                    ),
                  );
                },
              ),

              spaces(),
              Image.asset(
                'assets/img/ban_3.jpeg',
                width: SizeConfig.screenWidth,
              ),
              spaces(),
              //third two
              GridView.builder(
                itemCount: 4,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      if (box.read('cusType').toString() == "Seller") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProdDetailSeller(
                                selProd: controller.prodList[index + 8],
                              ),
                            ));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProdDetail(
                                selProd: controller.prodList[index + 8],
                              ),
                            ));
                      }
                    },
                    child: productBox(
                      controller.prodList[index + 8].url,
                      controller.prodList[index + 8].servicename,
                      controller.prodList[index + 8].price,
                      controller.prodList[index + 8].productid,
                      controller.prodList[index + 8].category,
                    ),
                  );
                },
              ),

              spaces(),
              Image.asset(
                'assets/img/ban_3.jpeg',
                width: SizeConfig.screenWidth,
              ),
              spaces(),
              //forth two
              GridView.builder(
                itemCount: 4,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      if (box.read('cusType').toString() == "Seller") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProdDetailSeller(
                                selProd: controller.prodList[index + 12],
                              ),
                            ));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProdDetail(
                                selProd: controller.prodList[index + 12],
                              ),
                            ));
                      }
                    },
                    child: productBox(
                      controller.prodList[index + 12].url,
                      controller.prodList[index + 12].servicename,
                      controller.prodList[index + 12].price,
                      controller.prodList[index + 12].productid,
                      controller.prodList[index + 12].category,
                    ),
                  );
                },
              ),

              spaces(),
              Image.asset(
                'assets/img/ban_3.jpeg',
                width: SizeConfig.screenWidth,
              ),
              spaces(),
              //fifth two
              GridView.builder(
                itemCount: 4,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      if (box.read('cusType').toString() == "Seller") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProdDetailSeller(
                                selProd: controller.prodList[index + 16],
                              ),
                            ));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProdDetail(
                                selProd: controller.prodList[index + 16],
                              ),
                            ));
                      }
                    },
                    child: productBox(
                      controller.prodList[index + 16].url,
                      controller.prodList[index + 16].servicename,
                      controller.prodList[index + 16].price,
                      controller.prodList[index + 16].productid,
                      controller.prodList[index + 16].category,
                    ),
                  );
                },
              ),

              spaces(),
              Image.asset(
                'assets/img/ban_3.jpeg',
                width: SizeConfig.screenWidth,
              ),
              spaces(),
              //sixth two
              GridView.builder(
                itemCount: 4,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      if (box.read('cusType').toString() == "Seller") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProdDetailSeller(
                                selProd: controller.prodList[index + 20],
                              ),
                            ));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProdDetail(
                                selProd: controller.prodList[index + 20],
                              ),
                            ));
                      }
                    },
                    child: productBox(
                      controller.prodList[index + 20].url,
                      controller.prodList[index + 20].servicename,
                      controller.prodList[index + 20].price,
                      controller.prodList[index + 20].productid,
                      controller.prodList[index + 20].category,
                    ),
                  );
                },
              ),

              spaces(),
              Image.asset(
                'assets/img/ban_3.jpeg',
                width: SizeConfig.screenWidth,
              ),
              spaces(),
              //seventh two
              GridView.builder(
                itemCount: 4,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      if (box.read('cusType').toString() == "Seller") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProdDetailSeller(
                                selProd: controller.prodList[index + 24],
                              ),
                            ));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProdDetail(
                                selProd: controller.prodList[index + 24],
                              ),
                            ));
                      }
                    },
                    child: productBox(
                      controller.prodList[index + 24].url,
                      controller.prodList[index + 24].servicename,
                      controller.prodList[index + 24].price,
                      controller.prodList[index + 24].productid,
                      controller.prodList[index + 24].category,
                    ),
                  );
                },
              ),

              spaces(),
              Image.asset(
                'assets/img/ban_3.jpeg',
                width: SizeConfig.screenWidth,
              ),
              spaces(),
              //ninth two
              GridView.builder(
                itemCount: controller.prodList.length - 24,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      if (box.read('cusType').toString() == "Seller") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProdDetailSeller(
                                selProd: controller.prodList[index + 24],
                              ),
                            ));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProdDetail(
                                selProd: controller.prodList[index + 24],
                              ),
                            ));
                      }
                    },
                    child: productBox(
                      controller.prodList[index + 24].url,
                      controller.prodList[index + 24].servicename,
                      controller.prodList[index + 24].price,
                      controller.prodList[index + 24].productid,
                      controller.prodList[index + 24].category,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      )),
    );
  }
}
