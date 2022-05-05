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
import 'package:qpi/utils/constants.dart';
import 'package:qpi/utils/services.dart';
import 'package:qpi/utils/size_config.dart';

// ignore: must_be_immutable
class Cart extends StatefulWidget {
  Cart({Key key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<String> days = ["S", "M", "T", "W", "T", "F", "S"];
  DateTime selectedDate = DateTime.now();
  CartController cartController = CartController();
  TimeOfDay selectedTime = TimeOfDay.now();
  int activeIndex = 0;
  List<dynamic> _placeList = [];

  GetStorage box = GetStorage();

  TextEditingController addressContr = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState

    addressContr.text = box.read('address').toString();
    super.initState();
    addressContr.addListener(() {
      getSuggestion(addressContr.text);
    });
  }

  void getSuggestion(String input) async {
    String kPLACES_API_KEY = "your api";
    String type = '(regions)';

    try {
      String baseURL =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      String request =
          '$baseURL?input=$input&key=AIzaSyDuVgdpLJJDl1H-irTSFsg9OsrNoJnpjRM';
      var response = await http.get(Uri.parse(request));
      var data = json.decode(response.body);
      print('mydata');
      print(data);
      if (response.statusCode == 200) {
        setState(() {
          _placeList = json.decode(response.body)['predictions'];
        });
      } else {
        throw Exception('Failed to load predictions');
      }
    } catch (e) {
      // toastMessage('success');
    }
  }

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
                  ),
                  regularText(
                      "Address: ", 2.0, Constants.grey, FontWeight.bold, 0),

                  Row(
                    children: [
                      Icon(Icons.pin_drop),
                      TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  title: regularText(
                                      "Search Location",
                                      2.0,
                                      Constants.primaryColor,
                                      FontWeight.normal,
                                      0),
                                  content: SizedBox(
                                    height: SizeConfig.screenHeight *
                                        0.5, // Change as per your requirement
                                    width: SizeConfig.screenWidth *
                                        0.9, // Change as per your requirement
                                    child: Column(
                                      children: [
                                        TextField(
                                          controller: addressContr,
                                          decoration: InputDecoration(
                                            hintText: "Seek your location here",
                                            focusColor: Colors.white,
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.never,
                                            prefixIcon: Icon(Icons.map),
                                            suffixIcon: IconButton(
                                              icon: Icon(Icons.cancel),
                                              onPressed: () {
                                                addressContr.clear();
                                              },
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: SizeConfig.screenHeight * 0.3,
                                          child: ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            itemCount: _placeList.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return ListTile(
                                                onTap: () {
                                                  addressContr.text =
                                                      _placeList[index]
                                                              ["description"]
                                                          .toString();
                                                },
                                                title: Text(_placeList[index]
                                                    ["description"]),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ));
                            },
                          );
                        },
                        child: regularText(
                          addressContr.text.toString() ?? "Search Location",
                          2.0,
                          Constants.primaryColor,
                          FontWeight.normal,
                          0,
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
                        "Delivery On/From",
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
                      regularText(
                        "Delivery Time",
                        1.9,
                        Constants.primaryColor,
                        FontWeight.normal,
                        0,
                      ),
                      Row(
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
                      itemBuilder: (context, index) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        minVerticalPadding: 0,
                        leading: regularText((index + 1).toString(), 2.0,
                            Constants.primaryColor, FontWeight.bold, 1),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () {
                            controller.cart.call().deleteItemFromCart(index);
                            setState(() {});
                          },
                        ),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    FontWeight.bold,
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
                                    FontWeight.bold,
                                    0),
                              ],
                            ),
                            // regularText(
                            //     controller.cart
                            //         .call()
                            //         .cartItem[index]
                            //         .uniqueCheck
                            //         .toString(),
                            //     1.9,
                            //     Colors.black,
                            //     FontWeight.normal,
                            //     0),
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
                        isThreeLine: true,
                      ),
                    ),
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
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.heightMultiplier * 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        regularText("Subtotal: ", 2.0, Constants.grey,
                            FontWeight.bold, 0),
                        regularText(
                            "₹ " +
                                (prodController.getCartTotalAmount())
                                    .toString(),
                            2.0,
                            Constants.grey,
                            FontWeight.bold,
                            0),
                      ],
                    ),
                  ),
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
                  spaces(),
                  InkWell(
                      onTap: () async {
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => PaymentScreen(),
                        //     ));
                        box.write('timeslot',
                            "${selectedTime.hour}:${selectedTime.minute}");
                        box.write('address2', addressContr.text.toString());
                        box.write('dateslot',
                            "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}");

                        ApiServices apiServices = ApiServices();
                        await apiServices.postOrder();
                        if (box.read('orderid') != null) {
                          // Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => PaymentScreen(),
                          //     ));
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
                          Fluttertoast.showToast(msg: 'Something went wrong');
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: SizeConfig.heightMultiplier * 1.5),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Constants.primaryColor),
                        child: regularText(
                            "Order Now", 2.0, Colors.white, FontWeight.bold, 1),
                      )),
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
          children: [
            for (int i = 0; i < days.length; i++)
              Container(
                margin:
                    EdgeInsets.only(right: SizeConfig.heightMultiplier * 0.02),
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
        space1(),
        // regularText("Timeslot: $value2", 2.0, Constants.primaryColor,
        //     FontWeight.normal, 0),
        space1(),
        regularText("Total Week: $value2", 2.0, Constants.primaryColor,
            FontWeight.normal, 0),
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
                  regularText("For you we make  ", 2.4, Constants.green,
                      FontWeight.bold, 0),
                  regularText("ordering easy", 2.4, Constants.primaryColor,
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
                    onPressed: () {
                      print(totalAmount * 100);
                      print(orderId);
                      Navigator.pop(context);
                      var options = {
                        'key':
                            'pnB3aVf5OtXziipl7bFgr5KR', //pnB3aVf5OtXziipl7bFgr5KR   KEYSECRET
                        'amount': 1000, //totalAmount * 100,
                        'name': 'Qpi',
                        'order_id': "$orderId",
                        'description': 'Qpi Order',
                        'timeout': 300,
                        'prefill': {
                          'contact': '9066545279', // box.read('mobile'),
                          'email': 'abc@gmail.com', //box.read('email'),
                        }
                      };
                      cartController.cart.call().deleteAllCart();
                    },
                    child: regularText("Razorpay", 2.1, Constants.primaryColor,
                        FontWeight.bold, 1),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: regularText("Search Location", 2.0, Constants.primaryColor,
              FontWeight.normal, 0),
          content: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: TextField(
                  controller: addressContr,
                  decoration: InputDecoration(
                    hintText: "Seek your location here",
                    focusColor: Colors.white,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    prefixIcon: Icon(Icons.map),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: () {
                        addressContr.clear();
                      },
                    ),
                  ),
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _placeList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      addressContr.text =
                          _placeList[index]["description"].toString();
                    },
                    child: ListTile(
                      title: Text(_placeList[index]["description"]),
                    ),
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }
}
