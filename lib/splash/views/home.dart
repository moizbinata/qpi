import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qpi/components/components.dart';
import 'package:qpi/controller/cart_controller.dart';
import 'package:qpi/controller/product_controller.dart';
import 'package:qpi/splash/views/cart.dart';
import 'package:qpi/splash/views/prodDetail.dart';
import 'package:qpi/splash/views/proddetail_seller.dart';
import 'package:qpi/utils/constants.dart';
import 'package:qpi/utils/size_config.dart';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatefulWidget {
  final action;
  const Home({Key key, this.action}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();

  GetStorage box = GetStorage();
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    final controller = Get.put(ProductController());

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.heightMultiplier * 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            regularText(
                                "Hi, " + box.read('username').toString(),
                                2.7,
                                Constants.primaryColor,
                                FontWeight.bold,
                                0),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_rounded,
                                  color: Constants.primaryColor,
                                  size: SizeConfig.textMultiplier * 2.5,
                                ),
                                regularText(box.read('address').toString(), 2.2,
                                    Constants.grey, FontWeight.normal, 0),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            InkWell(
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
                            SizedBox(
                              width: SizeConfig.heightMultiplier * 2,
                            ),
                            Container(
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
                              child: InkWell(
                                  onTap: () {
                                    GetStorage box = GetStorage();
                                    box.erase();
                                    widget.action();

                                    // Navigator.pushReplacement(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => Login(),
                                    //   ),
                                    // );
                                  },
                                  child: CircleAvatar(
                                      backgroundColor: Constants.primaryColor,
                                      child: FaIcon(
                                        Icons.logout,
                                        size: SizeConfig.heightMultiplier * 2.4,
                                        color: Colors.white,
                                      ))),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  spaces(),
                  CarouselSlider.builder(
                    itemCount: Constants.banImgs.length,
                    options: CarouselOptions(
                        autoPlay: true,
                        aspectRatio: 16 / 15,
                        height: SizeConfig.heightMultiplier * 22,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            activeIndex = index;
                          });
                        }),
                    itemBuilder: (context, index, realIdx) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                offset: Offset(
                                  1.0,
                                  1.0,
                                ),
                                blurRadius: 8.0,
                                spreadRadius: 2.0,
                              ),
                            ],
                          ),
                          child: Image.asset(
                            Constants.banImgs[index],
                            fit: BoxFit.fill,

                            // width: SizeConfig.screenWidth,
                            //height: SizeConfig.heightMultiplier * 29,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2,
                  ),
                  Center(child: buildIndicator()),
                  spaces(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.all(14),
                          margin: EdgeInsets.symmetric(
                              horizontal: SizeConfig.heightMultiplier * 3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Constants.primaryColor,
                                  Constants.primaryColor.withOpacity(0.5),
                                ],
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              regularText("Weekly Subscription", 2.2,
                                  Colors.white, FontWeight.normal, 0),
                              Icon(
                                Icons.chevron_right_rounded,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                      spaces(),
                      ListTile(
                        onTap: () {},
                        leading: regularText("Product by category", 2.4,
                            Constants.grey, FontWeight.bold, 0),
                        trailing: Icon(Icons.chevron_right_outlined),
                      ),
                      // spaces(),
                      Container(
                        margin: EdgeInsets.only(
                            left: SizeConfig.heightMultiplier * 3),
                        child: regularText("Tap to order", 2.2, Constants.grey,
                            FontWeight.bold, 0),
                      ),
                      spaces(),
                      //first two
                      GridView.builder(
                        itemCount: 4,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
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
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
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
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
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
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
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
                                        selProd:
                                            controller.prodList[index + 12],
                                      ),
                                    ));
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProdDetail(
                                        selProd:
                                            controller.prodList[index + 12],
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
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
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
                                        selProd:
                                            controller.prodList[index + 16],
                                      ),
                                    ));
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProdDetail(
                                        selProd:
                                            controller.prodList[index + 16],
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
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
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
                                        selProd:
                                            controller.prodList[index + 20],
                                      ),
                                    ));
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProdDetail(
                                        selProd:
                                            controller.prodList[index + 20],
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
                        itemCount: controller.prodList.length - 24,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
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
                                        selProd:
                                            controller.prodList[index + 24],
                                      ),
                                    ));
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProdDetail(
                                        selProd:
                                            controller.prodList[index + 24],
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
                ],
              ),
            ),
          )),
    );
  }

  Widget buildIndicator() {
    return AnimatedSmoothIndicator(
      curve: Curves.easeIn,
      effect: WormEffect(
          dotHeight: SizeConfig.heightMultiplier * 1.5,
          dotWidth: SizeConfig.heightMultiplier * 1.5,
          dotColor: Colors.grey.shade400,
          activeDotColor: Colors.grey.shade800),
      activeIndex: activeIndex,
      count: Constants.banImgs.length,
    );
  }
}

Widget productBox(url, name, price, prodId, category) {
  return Container(
    // clipBehavior: Clip.hardEdge,
    margin: EdgeInsets.symmetric(
      vertical: SizeConfig.heightMultiplier * 2,
      horizontal: SizeConfig.heightMultiplier * 2,
    ),
    decoration: BoxDecoration(
      image: DecorationImage(
          image: AssetImage('assets/img/prodBoxBg.png'),
          fit: BoxFit.fitWidth,
          alignment: Alignment.topLeft),
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          offset: Offset(
            1.0,
            1.0,
          ),
          blurRadius: 15.0,
          spreadRadius: 2.0,
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(),
            CachedNetworkImage(
              imageUrl: url,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              height: SizeConfig.heightMultiplier * 12,
              width: SizeConfig.heightMultiplier * 12,
            ),
            Transform.translate(
              offset: Offset(10, -10),
              child: CircleAvatar(
                backgroundColor: Constants.primaryColor,
                child: IconButton(
                  onPressed: () async {
                    CartController cartController = CartController();
                    await cartController.cart.call().addToCart(
                        productId: int.tryParse(prodId),
                        unitPrice: int.tryParse(price),
                        quantity: 1,
                        productDetailsObject: category,
                        productName: name,
                        uniqueCheck: "");
                    Fluttertoast.showToast(
                        msg: '$name added to cart.',
                        toastLength: Toast.LENGTH_LONG);
                    print(cartController.cart.call().cartItem.length);
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.cartPlus,
                    color: Colors.white,
                  ),
                  alignment: Alignment.topRight,
                ),
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: SizedBox(),
            ),
            Expanded(
              flex: 7,
              child: regularText(
                name,
                2.0,
                Constants.primaryColor,
                FontWeight.normal,
                0,
              ),
            ),
            Expanded(
              flex: 3,
              child: regularText(
                  "₹ \n" + price, 1.9, Constants.grey, FontWeight.bold, 1),
            ),
          ],
        ),
      ],
    ),
  );
}
