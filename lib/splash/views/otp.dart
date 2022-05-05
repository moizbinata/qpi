import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:flutter/material.dart';
import 'package:qpi/components/components.dart';
import 'package:qpi/navigation/bottom_navigator.dart';
import 'package:qpi/paints/custompaint.dart';
import 'package:qpi/splash/views/home.dart';
import 'package:qpi/utils/constants.dart';
import 'package:qpi/utils/size_config.dart';

class OTP extends StatelessWidget {
  OTP({Key key}) : super(key: key);
  OtpFieldController otpController = OtpFieldController();
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
                      length: 5,
                      width: MediaQuery.of(context).size.width,
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      fieldWidth: 55,
                      fieldStyle: FieldStyle.box,
                      outlineBorderRadius: 15,
                      style: TextStyle(fontSize: 17),
                      onChanged: (pin) {
                        print("Changed: " + pin);
                      },
                      onCompleted: (pin) {
                        print("Completed: " + pin);
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
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BottomNavigator(),
                              ));
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
}
