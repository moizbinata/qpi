import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qpi/components/components.dart';
import 'package:qpi/controller/cart_controller.dart';
import 'package:qpi/navigation/bottom_navigator.dart';
import 'package:qpi/splash/views/cart.dart';
import 'package:qpi/utils/constants.dart';
import 'package:qpi/utils/size_config.dart';

class ProdDetail extends StatefulWidget {
  final selProd;
  ProdDetail({Key key, this.selProd}) : super(key: key);

  @override
  State<ProdDetail> createState() => _ProdDetailState();
}

class _ProdDetailState extends State<ProdDetail> {
  List<String> days = ["S", "M", "T", "W", "T", "F", "S"];
  int num_days = 1;
  List<bool> daysBool = [false, false, false, false, false, false, false];
  int totalProd = 1;
  int weeks = 1;
  int _groupValue = 0;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: SizeConfig.screenHeight + 100,
          width: SizeConfig.screenWidth,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitWidth,
              image: AssetImage(
                'assets/img/bg2.png',
              ),
            ),
          ),
          child: SafeArea(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                minVerticalPadding: 0,
                leading: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  iconSize: SizeConfig.textMultiplier * 5,
                  icon: Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.chevron_left,
                      color: Constants.primaryColor,
                    ),
                  ),
                ),
                title: regularText("Product Detail", 3.0,
                    Constants.primaryColor, FontWeight.bold, 0),
                trailing: InkWell(
                    onTap: () async {
                      int subtotalPrice = 0;
                      subtotalPrice = (_groupValue == 0)
                          ? (int.tryParse(widget.selProd.price) * totalProd)
                          : (num_days > 1 || weeks > 1)
                              ? ((int.tryParse(widget.selProd.price) *
                                      totalProd) *
                                  (num_days * weeks))
                              : (int.tryParse(widget.selProd.price) *
                                  totalProd);

                      await controller.cart.call().addToCart(
                            productId: int.tryParse(widget.selProd.productid),
                            unitPrice: int.tryParse(widget.selProd.price),

                            // int.tryParse(widget.selProd.price),

                            quantity: totalProd,
                            productDetailsObject: widget.selProd.category,
                            productName: widget.selProd.servicename,
                            uniqueCheck: (_groupValue == 0)
                                ? ""
                                : daysBool.toString() +
                                    // "//" +
                                    // timeslot +
                                    "//" +
                                    weeks.toString(),
                          );
                      print(daysBool.toString() +
                          // "//" +
                          // timeslot +
                          "//" +
                          weeks.toString());
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Cart(),
                          ));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.heightMultiplier * 1,
                          horizontal: SizeConfig.heightMultiplier * 2),
                      margin: EdgeInsets.only(
                          right: SizeConfig.heightMultiplier * 1),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          // border: Border.all(
                          //   color: Constants.primaryColor,
                          //   width: 2,
                          // ),
                          color: Constants.primaryColor),
                      child: regularText(
                          "Add to Cart", 2.0, Colors.white, FontWeight.bold, 1),
                    )),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.heightMultiplier * 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: CachedNetworkImage(
                            imageUrl: widget.selProd.url,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            width: SizeConfig.heightMultiplier * 20,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: regularText(widget.selProd.proddesc, 2.0,
                              Constants.grey, FontWeight.bold, 1),
                        )
                      ],
                    ),
                    spaces(),
                    regularText("Product : " + widget.selProd.servicename ?? "",
                        2.4, Constants.primaryColor, FontWeight.bold, 0),
                    spaces(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            regularText("Category : " + widget.selProd.category,
                                2.1, Constants.grey, FontWeight.bold, 0),
                            spaces(),
                            regularText(
                                (widget.selProd.discount == null)
                                    ? "Discount: 0.0"
                                    : "Discount: " + widget.selProd.discount,
                                2.1,
                                Constants.grey,
                                FontWeight.bold,
                                0),
                            spaces(),
                            Row(
                              children: [
                                regularText("Qty: ", 2.1, Constants.grey,
                                    FontWeight.bold, 0),
                                IconButton(
                                    onPressed: () {
                                      if (totalProd == 1) {
                                        setState(() {
                                          totalProd = 1;
                                        });
                                      } else if (totalProd > 1) {
                                        setState(() {
                                          totalProd--;
                                        });
                                      }
                                    },
                                    icon: FaIcon(
                                      FontAwesomeIcons.minus,
                                      size: SizeConfig.textMultiplier * 2,
                                    )),
                                regularText(
                                  totalProd.toString(),
                                  2.1,
                                  Constants.grey,
                                  FontWeight.bold,
                                  1,
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        totalProd++;
                                      });
                                    },
                                    icon: FaIcon(
                                      FontAwesomeIcons.plus,
                                      size: SizeConfig.textMultiplier * 2,
                                    )),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            regularText("Price : " + widget.selProd.orgrice,
                                2.1, Constants.grey, FontWeight.bold, 0),
                            spaces(),
                            regularText(
                                (widget.selProd.discount == null)
                                    ? "Discounted Price: ${widget.selProd.price}"
                                    : "Discounted Price: " +
                                        (int.tryParse(widget.selProd.price) -
                                                int.tryParse(
                                                    widget.selProd.discount))
                                            .toString(),
                                2.1,
                                Constants.grey,
                                FontWeight.bold,
                                0),
                            spaces(),
                            regularText(
                                (_groupValue == 0)
                                    ? "Total Price: " +
                                        (int.tryParse(widget.selProd.price) *
                                                totalProd)
                                            .toString()
                                    : (num_days > 1 || weeks > 1)
                                        ? "Total Price: " +
                                            ((int.tryParse(widget
                                                            .selProd.price) *
                                                        totalProd) *
                                                    (num_days * weeks))
                                                .toString()
                                        : "Total Price: " +
                                            (int.tryParse(
                                                        widget.selProd.price) *
                                                    totalProd)
                                                .toString(),
                                2.1,
                                Constants.grey,
                                FontWeight.bold,
                                0),
                          ],
                        )
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: _myRadioButton(
                            title: "One-time order",
                            value: 0,
                            onChanged: (newValue) =>
                                setState(() => _groupValue = newValue),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: _myRadioButton(
                            title: "Subscription Order",
                            value: 1,
                            onChanged: (newValue) =>
                                setState(() => _groupValue = newValue),
                          ),
                        ),
                      ],
                    ),
                    spaces(),

                    AbsorbPointer(
                      absorbing: (_groupValue == 0) ? true : false,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.heightMultiplier * 2,
                          horizontal: SizeConfig.heightMultiplier * 1,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color.fromARGB(255, 186, 212, 228),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            regularText(
                                "Select days",
                                // (_groupValue == 1)
                                //     ? "Select days"
                                //     : "THIS BOX IS DISABLED",
                                1.9,
                                Constants.primaryColor,
                                FontWeight.normal,
                                0),
                            spaces(),
                            Row(
                              children: [
                                for (int i = 0; i < days.length; i++)
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: SizeConfig.heightMultiplier * 1),
                                    child: InkWell(
                                      onTap: () {
                                        print(daysBool[i].toString());
                                        setState(() {
                                          daysBool[i] = !daysBool[i];
                                        });
                                        num_days = 0;
                                        for (var element in daysBool) {
                                          if (element == true) {
                                            setState(() {
                                              num_days++;
                                            });
                                          }
                                        }
                                        print(num_days);
                                      },
                                      child: CircleAvatar(
                                          radius:
                                              SizeConfig.heightMultiplier * 2,
                                          backgroundColor: (daysBool[i])
                                              ? Constants.primaryColor
                                              : Colors.white,
                                          child: regularText(
                                              days[i],
                                              1.9,
                                              (daysBool[i])
                                                  ? Colors.white
                                                  : Constants.primaryColor,
                                              FontWeight.normal,
                                              1)),
                                    ),
                                  ),
                              ],
                            ),
                            spaces(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                regularText(
                                  "Delivery Till",
                                  // (_groupValue == 1)
                                  //     ? "Delivery Till"
                                  //     : "DISABLED",
                                  1.9,
                                  Constants.primaryColor,
                                  FontWeight.normal,
                                  0,
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          if (weeks == 1)
                                            setState(() {
                                              weeks = 1;
                                            });
                                          else if (weeks > 1)
                                            setState(() {
                                              weeks--;
                                            });
                                        },
                                        icon: FaIcon(
                                          FontAwesomeIcons.minus,
                                          size: SizeConfig.textMultiplier * 2,
                                        )),
                                    regularText(weeks.toString(), 2.1,
                                        Constants.grey, FontWeight.bold, 1),
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            weeks++;
                                          });
                                        },
                                        icon: FaIcon(
                                          FontAwesomeIcons.plus,
                                          size: SizeConfig.textMultiplier * 2,
                                        )),
                                    regularText(
                                        "Week/s",
                                        2.0,
                                        Constants.primaryColor,
                                        FontWeight.bold,
                                        0),
                                  ],
                                ),
                                SizedBox(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    spaces(),
                    // InkWell(
                    //     onTap: () async {
                    //       int subtotalPrice = 0;
                    //       subtotalPrice = (_groupValue == 0)
                    //           ? (int.tryParse(widget.selProd.price) * totalProd)
                    //           : (num_days > 1 || weeks > 1)
                    //               ? ((int.tryParse(widget.selProd.price) *
                    //                       totalProd) *
                    //                   (num_days * weeks))
                    //               : (int.tryParse(widget.selProd.price) *
                    //                   totalProd);

                    //       await controller.cart.call().addToCart(
                    //             productId:
                    //                 int.tryParse(widget.selProd.productid),
                    //             unitPrice: subtotalPrice,
                    //             // int.tryParse(widget.selProd.price),

                    //             quantity: totalProd,
                    //             productDetailsObject: widget.selProd.category,
                    //             productName: widget.selProd.servicename,
                    //             uniqueCheck: (_groupValue == 0)
                    //                 ? ""
                    //                 : daysBool.toString() +
                    //                     // "//" +
                    //                     // timeslot +
                    //                     "//" +
                    //                     weeks.toString(),
                    //           );
                    //       print(daysBool.toString() +
                    //           // "//" +
                    //           // timeslot +
                    //           "//" +
                    //           weeks.toString());
                    //       Navigator.pushReplacement(
                    //           context,
                    //           MaterialPageRoute(
                    //             builder: (context) => Cart(),
                    //           ));
                    //     },
                    //     child: Container(
                    //       padding: EdgeInsets.symmetric(
                    //           vertical: SizeConfig.heightMultiplier * 1.5),
                    //       width: double.infinity,
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(20),
                    //           // border: Border.all(
                    //           //   color: Constants.primaryColor,
                    //           //   width: 2,
                    //           // ),
                    //           color: Constants.primaryColor),
                    //       child: regularText("Proceed to Order", 2.0,
                    //           Colors.white, FontWeight.bold, 1),
                    //     )
                    //     ),
                    // spaces(),
                    // InkWell(
                    //     child: Container(
                    //   padding: EdgeInsets.symmetric(
                    //       vertical: SizeConfig.heightMultiplier * 1.5),
                    //   width: double.infinity,
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(20),
                    //       border: Border.all(
                    //         color: Constants.primaryColor,
                    //         width: 2,
                    //       ),
                    //       color: Colors.white),
                    //   child: regularText("Add to Subscription", 2.0,
                    //       Constants.primaryColor, FontWeight.bold, 1),
                    // )),
                  ],
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }

  Widget _myRadioButton({String title, int value, Function onChanged}) {
    return RadioListTile(
      contentPadding: EdgeInsets.zero,
      value: value,
      groupValue: _groupValue,
      onChanged: onChanged,
      title: Text(title),
    );
  }
}
