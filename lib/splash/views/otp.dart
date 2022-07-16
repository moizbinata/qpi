import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:flutter/material.dart';
import 'package:qpi/components/components.dart';
import 'package:qpi/navigation/bottom_navigator.dart';
import 'package:qpi/paints/custompaint.dart';
import 'package:qpi/splash/views/home.dart';
import 'package:qpi/splash/views/login.dart';
import 'package:qpi/utils/constants.dart';
import 'package:qpi/utils/size_config.dart';

class OTP extends StatefulWidget {
  final url;
  final otp;

  OTP({Key key, this.url, this.otp}) : super(key: key);

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  OtpFieldController otpController = OtpFieldController();

  String otpValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            CustomPaint(
              size: Size(SizeConfig.screenWidth, SizeConfig.screenHeight),
              painter: BackgroundPaint(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.heightMultiplier * 10,
                  horizontal: SizeConfig.heightMultiplier * 3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/img/logo4.png',
                    width: SizeConfig.heightMultiplier * 25,
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 4,
                  ),
                  regularText("We text you a code please enter it below", 2.4,
                      Constants.darkBlue, FontWeight.bold, 1),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2,
                  ),
                  OTPTextField(
                      controller: otpController,
                      length: 4,
                      width: MediaQuery.of(context).size.width,
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      fieldWidth: 55,
                      fieldStyle: FieldStyle.box,
                      outlineBorderRadius: 15,
                      style: TextStyle(fontSize: 17),
                      onChanged: (pin) {
                        print("Changed: " + pin);
                        setState(() {
                          otpValue = pin;
                        });
                      },
                      onCompleted: (pin) {
                        print("Completed: " + pin);
                        setState(() {
                          otpValue = pin;
                        });
                      }),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 3,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: SizeConfig.heightMultiplier * 1.8)),
                        onPressed: () {
                          print(otpValue);
                          if (otpValue == widget.otp) {
                            newRegister(context, widget.url);
                          } else {
                            Fluttertoast.showToast(msg: 'Incorrect OTP');
                          }
                          // Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => BottomNavigator(),
                          //     ));
                        },
                        child: regularText(
                            "Confirm", 2.0, Colors.white, FontWeight.bold, 1)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  newRegister(context, apiurl) async {
    // String apiurl =
    //     "${Constants.baseUrl}mystore/jatpat_register_newuser.php?username=${fnameContr.text.toString() + lnameContr.text.toString()}&firstname=${fnameContr.text}&mobile=${mobileContr.text}&email=${mailContr.text}&addr=${addressContr.text}&ctype=$custType&passwd=${pinContr.text}";
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
