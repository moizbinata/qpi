import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qpi/components/components.dart';
import 'package:qpi/controller/product_controller.dart';
import 'package:qpi/splash/views/cart.dart';
import 'package:qpi/splash/views/home.dart';
import 'package:qpi/splash/views/prodDetail.dart';
import 'package:qpi/splash/views/proddetail_seller.dart';
import 'package:qpi/utils/constants.dart';
import 'package:qpi/utils/size_config.dart';

// ignore: must_be_immutable
class Products extends StatelessWidget {
  final action;
  Products({Key key, this.action}) : super(key: key);
  GetStorage box = GetStorage();
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    print("length: " + controller.categList.length.toString());
    return Scaffold(
      body: Container(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitWidth,
              image: AssetImage(
                'assets/img/bg.png',
              ),
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: regularText("Product", 2.2, Constants.primaryColor,
                          FontWeight.bold, 0),
                      subtitle: regularText("Categories", 2.2,
                          Constants.primaryColor, FontWeight.bold, 0),
                      trailing: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Cart(),
                                ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(
                                    1.0,
                                    1.0,
                                  ),
                                  blurRadius: 7.0,
                                  spreadRadius: 2.0,
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                                backgroundColor: Constants.primaryColor,
                                child: FaIcon(
                                  FontAwesomeIcons.opencart,
                                  size: SizeConfig.heightMultiplier * 2.4,
                                  color: Colors.white,
                                )),
                          )),
                    ),
                    Container(
                      padding: EdgeInsets.all(SizeConfig.heightMultiplier * 1),
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.heightMultiplier * 10,
                      child: ListView.builder(
                          itemCount: controller.categList.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext ctxt, int index) {
                            print(controller.categList[index].toString());
                            return InkWell(
                              onTap: () {
                                print(controller.categList[index].toString());
                                controller.filterProduct(
                                    controller.categList[index].toString());
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        SizeConfig.heightMultiplier * 2),
                                margin: EdgeInsets.symmetric(
                                    vertical: SizeConfig.heightMultiplier * 2,
                                    horizontal:
                                        SizeConfig.heightMultiplier * 1),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: (controller.categList[index] ==
                                          controller.categList[index])
                                      ? Constants.primaryColor
                                      : Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(
                                        1.0,
                                        1.0,
                                      ),
                                      blurRadius: 10.0,
                                      spreadRadius: 2.0,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: regularText(
                                      controller.categList[index].toString(),
                                      2.0,
                                      (controller.categList[index] ==
                                              controller.categList[index])
                                          ? Colors.white
                                          : Constants.primaryColor,
                                      FontWeight.normal,
                                      1),
                                ),
                              ),
                            );
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Obx(
                        () => GridView.builder(
                          itemCount: controller.categprodList.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                if (box.read('cusType').toString() ==
                                    "Seller") {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProdDetailSeller(
                                          selProd:
                                              controller.categprodList[index],
                                        ),
                                      ));
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProdDetail(
                                          selProd:
                                              controller.categprodList[index],
                                        ),
                                      ));
                                }
                              },
                              child: productBox(
                                controller.categprodList[index].url,
                                controller.categprodList[index].servicename,
                                controller.categprodList[index].price,
                                controller.categprodList[index].productid,
                                controller.categprodList[index].category,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
