import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:qpi/components/components.dart';
import 'package:qpi/splash/views/login.dart';
import 'package:qpi/utils/constants.dart';
import 'package:qpi/utils/size_config.dart';

class UserRegistration extends StatefulWidget {
  UserRegistration({Key key}) : super(key: key);

  @override
  State<UserRegistration> createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  TextEditingController fnameContr = TextEditingController();

  TextEditingController lnameContr = TextEditingController();

  TextEditingController mobileContr = TextEditingController();

  TextEditingController mailContr = TextEditingController();

  TextEditingController addressContr = TextEditingController();

  TextEditingController pinContr = TextEditingController();

  String custType = "Customer";

  var custTypeList = [
    'Customer',
    'Seller',
  ];

  final _formKey = GlobalKey<FormState>();

  FocusNode fn = FocusNode();

  @override
  Widget build(BuildContext context) {
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
            child: Container(
              padding: EdgeInsets.all(SizeConfig.heightMultiplier * 2),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.chevron_left,
                            color: Constants.primaryColor,
                            size: SizeConfig.heightMultiplier * 4,
                          ),
                        ),
                        regularText("Registration", 3.0, Constants.primaryColor,
                            FontWeight.bold, 1),
                      ],
                    ),

                    space1(),
                    space1(),
                    space1(),

                    regularText("Are you new here, fill up and don't be new",
                        2.0, Constants.primaryColor, FontWeight.bold, 1),
                    space1(),
                    space1(),

                    //textfield
                    customTextField(fnameContr, "First Name",
                        Icons.password_outlined, "First Name", 11),
                    space1(),
                    //textfield
                    customTextField(lnameContr, "Last Name",
                        Icons.password_outlined, "Last Name", 11),
                    space1(),

                    //textfield
                    customTextField(
                        mobileContr,
                        "Mobile Number (e.g.9000000000)",
                        Icons.password_outlined,
                        "Username",
                        10),
                    space1(),

                    //textfield
                    customTextField(mailContr, "Email Address",
                        Icons.password_outlined, "Email", 11),
                    space1(),

                    //textfield
                    customTextField(
                        addressContr,
                        "Address (where product to be delivered)",
                        Icons.password_outlined,
                        "Address",
                        11),
                    space1(),

                    //textfield
                    customTextField(pinContr, "Password",
                        Icons.password_outlined, "Passwordd", 11),
                    //textfield
                    space1(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.heightMultiplier * 0.5,
                        horizontal: SizeConfig.heightMultiplier * 2,
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
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
                      child: DropdownButton(
                        // Initial Value
                        value: custType,
                        // Down Arrow Icon
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                        ),
                        alignment: Alignment.centerRight,
                        // Array list of items
                        items: custTypeList.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: regularText(items, 1.8,
                                Constants.primaryColor, FontWeight.w600, 0),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String newValue) {
                          setState(() {
                            custType = newValue;
                          });
                          print(custType);
                        },
                      ),
                    ),

                    space1(),
                    space1(),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Constants.primaryColor,
                            padding: EdgeInsets.symmetric(
                                vertical: SizeConfig.heightMultiplier * 1.8)),
                        onPressed: () {
                          FocusScope.of(context).requestFocus(fn);

                          if (_formKey.currentState.validate()) {
                            newRegister(context);
                          }
                        },
                        child: regularText(
                            "Regsiter", 2.0, Colors.white, FontWeight.bold, 1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  newRegister(context) async {
    String apiurl =
        "${Constants.baseUrl}mystore/jatpat_register_newuser.php?username=${fnameContr.text.toString() + lnameContr.text.toString()}&firstname=${fnameContr.text}&mobile=${mobileContr.text}&email=${mailContr.text}&addr=${addressContr.text}&ctype=$custType&passwd=${pinContr.text}";
    var response = await http.post(Uri.parse(apiurl));
    if (response.statusCode == 200) {
      if (response.body.toLowerCase() == "wrong") {
        Fluttertoast.showToast(msg: 'Already exists or something went wrong');
      } else {
        Fluttertoast.showToast(msg: 'Registered Successfully');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ),
        );
      }
    } else {
      Fluttertoast.showToast(msg: 'Something went wrong, contact admin');
      throw Exception("Unable to perform request");
    }
  }
}
