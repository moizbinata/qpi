import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'package:qpi/components/components.dart';
import 'package:qpi/controller/login_controller.dart';
import 'package:qpi/model/ussermomdel.dart';
import 'package:qpi/navigation/bottom_navigator.dart';
import 'package:qpi/paints/custompaint.dart';
import 'package:qpi/splash/views/regUser.dart';
import 'package:qpi/utils/constants.dart';
import 'package:qpi/utils/size_config.dart';

// ignore: must_be_immutable
class Login extends StatelessWidget {
  Login({Key key}) : super(key: key);
  TextEditingController userController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  FocusNode fn = FocusNode();
  LoginController loginController = new LoginController();
  GetStorage box = GetStorage();
  final phoneValid = RequiredValidator(errorText: 'Username is required');
  // MultiValidator([
  //   RequiredValidator(errorText: 'Phone is required'),
  // MinLengthValidator(10, errorText: 'Phone number must be 10-11 digits'),
  // MaxLengthValidator(11, errorText: 'Phone number must be 10-11 digits')
  // ]);
  final passValidator = RequiredValidator(errorText: 'Password is required');
  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LoginController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.heightMultiplier * 3),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/img/bg3.png',
                  ),
                  fit: BoxFit.cover)),
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/img/logo4.png',
                  width: SizeConfig.heightMultiplier * 40,
                ),
                customTextField(
                  userController,
                  "Enter Mobile Number",
                  Icons.account_circle_sharp,
                  "Username",
                  10,
                ),
                space1(),
                customTextField(pinController, "Enter Password",
                    Icons.password_outlined, "Password", 11),
                space1(),
                SizedBox(
                  width: double.infinity,
                  child: GetBuilder<LoginController>(
                    builder: (_) => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Constants.primaryColor,
                          padding: EdgeInsets.symmetric(
                              vertical: SizeConfig.heightMultiplier * 1.8)),
                      onPressed: () {
                        FocusScope.of(context).requestFocus(fn);

                        if (_formKey.currentState.validate()) {
                          startLogin(context);

                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => BottomNavigator(),
                          //   ),
                          // );

                        }
                      },
                      child: regularText(
                          "Login", 2.5, Colors.white, FontWeight.bold, 1),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 1,
                ),
                regularText(
                    "or", 2.5, Constants.darkBlue, FontWeight.normal, 1),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserRegistration(),
                        ),
                      );
                    },
                    child: regularText("Register here", 2.5, Constants.darkBlue,
                        FontWeight.normal, 0))
              ],
            ),
          ),
        ),
      ),
    );
  }

  startLogin(context) async {
    //${userController.text}
    String apiurl =
        "${Constants.baseUrl}mystore/jatpat_login.php?username=${userController.text}&password=${pinController.text}";
    print(apiurl);
    var response = await http.post(Uri.parse(apiurl));
    print(response.body);
    if (response.statusCode == 200) {
      final body = jsonDecode("[" + response.body + "]");
      print("response body ");
      print(body);

      List data = body;
      if (response.body.toString().contains("status") &&
          response.body.toString().contains("300")) {
        Fluttertoast.showToast(msg: 'Incorrect phone or password');
      } else {
        // box.write('userProfile', jsonEncode(data));
        // box.write('mobile', userController.text);
        // print(box.read('userProfile'));
        loginController.userDataList
            .assignAll(userModelFromJson(jsonEncode(data)));
        box.write('mobile', loginController.userDataList.first.mobile);
        box.write('email', loginController.userDataList.first.email);
        box.write('address', loginController.userDataList.first.addr);
        box.write('username', loginController.userDataList.first.username);
        box.write('promoLink', loginController.userDataList.first.promolink);
        box.write('cusType', loginController.userDataList.first.ctype);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNavigator(),
          ),
        );
        Fluttertoast.showToast(msg: 'Login Successfully');
      }
    } else {
      Fluttertoast.showToast(msg: 'Something went wrong');
      throw Exception("Unable to perform request");
    }
  }
}
