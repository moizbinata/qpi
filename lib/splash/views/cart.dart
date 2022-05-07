import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qpi/components/components.dart';
import 'package:qpi/controller/cart_controller.dart';
import 'package:qpi/controller/product_controller.dart';
import 'package:qpi/splash/views/home.dart';
import 'package:qpi/splash/views/payment.dart';
import 'package:qpi/splash/views/prodDetail.dart';
import 'package:qpi/splash/views/proddetail_seller.dart';
import 'package:qpi/splash/views/search_map.dart';
import 'package:qpi/utils/constants.dart';
import 'package:qpi/utils/services.dart';
import 'package:qpi/utils/size_config.dart';
import 'package:url_launcher/url_launcher.dart';

enum SingingCharacter { clock, urgent }

// ignore: must_be_immutable
class Cart extends StatefulWidget {
  Cart({Key key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  SingingCharacter _character = SingingCharacter.clock;
  List<String> days = ["S", "M", "T", "W", "T", "F", "S"];
  String urgency = "NotUrgent";
  DateTime selectedDate = DateTime.now();
  CartController cartController = CartController();
  TimeOfDay selectedTime = TimeOfDay.now();
  int activeIndex = 0;
  int _groupValue = -1;

  GetStorage box = GetStorage();
// Initial Selected Value
  String dropdownvalue = '15 Mins';

  // List of items in our dropdown menu
  var items = [
    '15 Mins',
    '30 Mins',
    '45 Mins',
  ];
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());
    final prodController = Get.put(ProductController());

    return Scaffold(
      body: Container(
        height: SizeConfig.screenHeight,
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
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.heightMultiplier * 2),
            child: SingleChildScrollView(
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
                    title: regularText("My Cart", 3.0, Constants.primaryColor,
                        FontWeight.bold, 0),
                    trailing: InkWell(
                        onTap: () async {
                          // Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => PaymentScreen(),
                          //     ));
                          box.write('timeslot',
                              "${selectedTime.hour}:${selectedTime.minute}");
                          box.write('dateslot',
                              "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}");
                          print(box.read('address2'));

                          if (box.read('address2') == null) {
                            box.write('address2', box.read('address'));
                            print(box.read('address2'));
                          }
                          ApiServices apiServices = ApiServices();
                          if (controller.cart.call().cartItem.isNotEmpty) {
                            await apiServices.postOrder(urgency);

                            modalforCheckout(
                                controller.cart
                                    .call()
                                    .getCartItemCount()
                                    .toString(),
                                prodController
                                    .getCartTotalAmount()
                                    .toStringAsFixed(2),
                                box.read('orderid').toString());
                          } else {
                            print("not called");
                            Fluttertoast.showToast(msg: 'First Order Please');
                          }
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
                              "Order", 2.0, Colors.white, FontWeight.bold, 1),
                        )),
                  ),

                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Icon(Icons.edit_location_alt_outlined)),
                      Expanded(
                        flex: 10,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GoogleSearchPlacesApi(),
                                ));
                          },
                          child: regularText(
                            (box.read('address2') == null)
                                ? box.read('address').toString()
                                : box.read('address2').toString(),
                            2.0,
                            Constants.primaryColor,
                            FontWeight.normal,
                            0,
                          ),
                        ),
                      ),
                    ],
                  ),

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
                  //calendar
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      regularText(
                        "Delivery Date",
                        1.9,
                        Constants.primaryColor,
                        FontWeight.normal,
                        0,
                      ),
                      InkWell(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: Row(
                          children: [
                            regularText(
                                "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                                2.0,
                                Constants.primaryColor,
                                FontWeight.bold,
                                0),
                            SizedBox(
                              width: 10,
                            ),
                            FaIcon(
                              FontAwesomeIcons.calendarAlt,
                              size: SizeConfig.textMultiplier * 2.5,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  //clock,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          height: SizeConfig.heightMultiplier * 2.7,
                          child: Radio<SingingCharacter>(
                            value: SingingCharacter.clock,
                            groupValue: _character,
                            onChanged: (SingingCharacter value) {
                              setState(() {
                                _character = value;
                                urgency = "NotUrgent";
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: regularText(
                          "Delivery Time",
                          1.9,
                          Constants.primaryColor,
                          FontWeight.normal,
                          0,
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                _selectTime(context);
                              },
                              child: regularText(
                                  "${selectedTime.hour}:${selectedTime.minute}",
                                  2.0,
                                  Constants.primaryColor,
                                  FontWeight.bold,
                                  0),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            FaIcon(
                              FontAwesomeIcons.clock,
                              size: SizeConfig.textMultiplier * 2.5,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          height: SizeConfig.heightMultiplier * 2.7,
                          child: Radio<SingingCharacter>(
                            value: SingingCharacter.urgent,
                            groupValue: _character,
                            onChanged: (SingingCharacter value) {
                              setState(() {
                                _character = value;
                                urgency = dropdownvalue;
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: regularText(
                          "Urgent Delivery",
                          1.9,
                          Constants.primaryColor,
                          FontWeight.normal,
                          0,
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: SizedBox(
                          height: SizeConfig.heightMultiplier * 3,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: DropdownButton(
                              // Initial Value
                              value: dropdownvalue,

                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),

                              // Array list of items
                              items: items.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownvalue = newValue;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  spaces(),
                  regularText("Order Details: ", 2.0, Constants.grey,
                      FontWeight.bold, 0),
                  spaces(),
                  GetBuilder<CartController>(
                    builder: (_) => ListView.builder(
                        physics: ScrollPhysics(),
                        itemCount: controller.cart.call().cartItem.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final item = controller.cart
                              .call()
                              .cartItem[index]
                              .productName;
                          return Dismissible(
                            // Each Dismissible must contain a Key. Keys allow Flutter to
                            // uniquely identify widgets.
                            key: Key(item),
                            // Provide a function that tells the app
                            // what to do after an item has been swiped away.
                            onDismissed: (direction) {
                              // Remove the item from the data source.
                              controller.cart.call().deleteItemFromCart(index);
                              setState(() {});
                              // Then show a snackbar.
                              Fluttertoast.showToast(msg: '$item dismissed');
                            },
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              minVerticalPadding: 0,
                              leading: regularText((index + 1).toString(), 2.0,
                                  Constants.primaryColor, FontWeight.bold, 1),
                              title: regularText(
                                  controller.cart
                                      .call()
                                      .cartItem[index]
                                      .productName
                                      .toString(),
                                  2.0,
                                  Constants.primaryColor,
                                  FontWeight.bold,
                                  0),
                              subtitle: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      regularText(
                                          "Subtotal: ₹ " +
                                              controller.cart
                                                  .call()
                                                  .cartItem[index]
                                                  .unitPrice
                                                  .toString(),
                                          2.0,
                                          Constants.grey,
                                          FontWeight.normal,
                                          0),
                                      regularText(
                                          "Qty: " +
                                              controller.cart
                                                  .call()
                                                  .cartItem[index]
                                                  .quantity
                                                  .toString(),
                                          2.0,
                                          Constants.grey,
                                          FontWeight.normal,
                                          0),
                                      IconButton(
                                          onPressed: () {
                                            var editItem;
                                            for (var item
                                                in prodController.prodList) {
                                              if (item.productid.toString() ==
                                                  controller.cart
                                                      .call()
                                                      .cartItem[index]
                                                      .productId
                                                      .toString()) {
                                                setState(() {
                                                  editItem = item;
                                                });
                                              }
                                            }
                                            if (box
                                                    .read('cusType')
                                                    .toString() ==
                                                "Seller") {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProdDetailSeller(
                                                      selProd: editItem,
                                                    ),
                                                  ));
                                            } else {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProdDetail(
                                                      selProd: editItem,
                                                    ),
                                                  ));
                                            }
                                            controller.cart
                                                .call()
                                                .deleteItemFromCart(index);
                                          },
                                          icon: Icon(Icons.edit)),
                                    ],
                                  ),
                                  (controller.cart
                                              .call()
                                              .cartItem[index]
                                              .uniqueCheck
                                              .toString() !=
                                          "")
                                      ? showDaysTimeWeek(controller.cart
                                          .call()
                                          .cartItem[index]
                                          .uniqueCheck
                                          .toString())
                                      : SizedBox(),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  Divider(
                    color: Constants.grey,
                    height: 1,
                    thickness: 1,
                  ),
                  spaces(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.heightMultiplier * 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        regularText("Total Order: ", 2.0, Constants.grey,
                            FontWeight.bold, 0),
                        regularText(
                            controller.cart
                                .call()
                                .getCartItemCount()
                                .toString(),
                            2.0,
                            Constants.grey,
                            FontWeight.bold,
                            0),
                      ],
                    ),
                  ),
                  spaces(),

                  spaces(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.heightMultiplier * 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        regularText("Grand Total: ", 2.0, Constants.grey,
                            FontWeight.bold, 0),
                        regularText(
                            "₹ " +
                                (prodController.getCartTotalAmount())
                                    .toStringAsFixed(2),
                            2.0,
                            Constants.grey,
                            FontWeight.bold,
                            0),
                      ],
                    ),
                  ),
                  spaces(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
      });
    }
  }

  Widget showDaysTimeWeek(uniqueCheck) {
    final split = uniqueCheck.split('//');
    final Map<int, dynamic> values = {
      for (int i = 0; i < split.length; i++) i: split[i]
    };
    print(values); // {0: grubs, 1:  sheep}

    List trueDays = jsonDecode(values[0]);
    final value2 = values[1];
    // final value3 = values[2];

    print(trueDays); // grubs
    print(value2); //  sheep
    // print(value3);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        space1(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                for (int i = 0; i < days.length; i++)
                  Container(
                    margin: EdgeInsets.only(
                        right: SizeConfig.heightMultiplier * 0.02),
                    child: CircleAvatar(
                      radius: SizeConfig.heightMultiplier * 1.5,
                      backgroundColor: (trueDays[i] == false)
                          ? Colors.white
                          : Constants.primaryColor,
                      child: regularText(
                          days[i],
                          1.4,
                          (trueDays[i] == false)
                              ? Constants.primaryColor
                              : Colors.white,
                          FontWeight.normal,
                          1),
                    ),
                  ),
              ],
            ),
            regularText("For $value2 Week/s", 1.9, Constants.primaryColor,
                FontWeight.normal, 0),
          ],
        ),
        spaces(),
        Divider(
          color: Constants.grey,
          height: 1,
          thickness: 1,
        ),
        spaces(),
      ],
    );
  }

  modalforCheckout(totalItem, totalAmount, orderId) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(SizeConfig.heightMultiplier * 2),
        child: SingleChildScrollView(
          child: Column(
            children: [
              spaces(),
              Row(
                children: [
                  regularText(
                      "Thanks ", 2.4, Constants.green, FontWeight.bold, 0),
                  regularText("for order", 2.4, Constants.primaryColor,
                      FontWeight.bold, 0),
                ],
              ),
              regularText("ORDER ID: $orderId", 2.0, Constants.grey,
                  FontWeight.normal, 1),
              spaces(),
              regularText("Total Order: " + totalItem, 2.0, Constants.grey,
                  FontWeight.bold, 1),
              spaces(),
              regularText("Total Amount:  ₹ " + totalAmount, 2.0,
                  Constants.grey, FontWeight.bold, 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Constants.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onPressed: () {
                      print(box.read('orderid').toString());

                      if (box.read('orderid').toString() != null) {
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Home(),
                            ));
                        Fluttertoast.showToast(msg: 'Thanks for order');
                        box.remove('orderid');
                        cartController.cart.call().deleteAllCart();
                      } else {
                        Fluttertoast.showToast(msg: 'Something went wrong');
                      }
                    },
                    child: regularText("Pay On Delivery", 2.1, Colors.white,
                        FontWeight.bold, 1),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: BorderSide(color: Constants.primaryColor)),
                    ),
                    onPressed: () async {
                      print(orderId);
                      await launchUrl(Uri.parse(
                          'http://qpifoods.com/mystore/razorpay/paymainindex.php?mobile=${box.read('mobile')}&bkamt=$totalAmount&bookid-$orderId&custname=${box.read('username')}'));
                      print(
                          'http://qpifoods.com/mystore/razorpay/paymainindex.php?mobile=${box.read('mobile')}&bkamt=$totalAmount&bookid-$orderId&custname=${box.read('username')}');
                      Navigator.pop(context);
                      cartController.cart.call().deleteAllCart();
                    },
                    child: regularText("Pay Online", 2.1,
                        Constants.primaryColor, FontWeight.bold, 1),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
