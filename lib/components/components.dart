import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qpi/utils/constants.dart';
import 'package:qpi/utils/size_config.dart';

Widget spaces() {
  return SizedBox(
    height: SizeConfig.heightMultiplier * 2,
  );
}

Widget space1() {
  return SizedBox(
    height: SizeConfig.heightMultiplier * 1,
  );
}

Widget customTextField(
    textController, placeholder, icon, myValidator, mLength) {
  return Container(
    clipBehavior: Clip.hardEdge,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          offset: const Offset(
            1.0,
            1.0,
          ),
          blurRadius: 10.0,
          spreadRadius: 2.0,
        ),
      ],
    ),

    child: TextFormField(
        validator: RequiredValidator(
          errorText: 'This field is required',
        ),
        maxLength: (myValidator == "Username") ? mLength : 100,

        // maxLengthEnforced: false,
        maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
        controller: textController,
        cursorColor: Colors.black,
        obscureText: (myValidator == "Password") ? true : false,
        keyboardType: (myValidator == "Username")
            ? TextInputType.number
            : (myValidator == "Email")
                ? TextInputType.emailAddress
                : TextInputType.text,
        decoration: customImpDec(placeholder)),
    // Row(
    //   children: [
    //     Expanded(
    //       flex: 6,
    //       child: TextFormField(
    //           validator: RequiredValidator(
    //             errorText: '$myValidator is required',
    //           ),
    //           maxLength: mLength,
    //           // maxLengthEnforced: false,
    //           maxLengthEnforcement:
    //               MaxLengthEnforcement.truncateAfterCompositionEnds,
    //           controller: textController,
    //           cursorColor: Colors.black,
    //           obscureText: (myValidator == "Password") ? true : false,
    //           keyboardType: (myValidator == "Username")
    //               ? TextInputType.number
    //               : TextInputType.text,
    //           decoration: customImpDec(placeholder)),
    //     ),
    //     Expanded(
    //       flex: 1,
    //       child: Icon(
    //         icon,
    //         color: Constants.grey,
    //         size: SizeConfig.textMultiplier * 4,
    //       ),
    //     )
    //   ],
    // ),
  );
}

Widget regularText(
    String title, double size, Color color, FontWeight fontWeight, align) {
  return Text(
    title,
    overflow: TextOverflow.ellipsis,
    textAlign: (align == 0)
        ? TextAlign.left
        : (align == 1)
            ? TextAlign.center
            : TextAlign.right,
    maxLines: 3,
    style: GoogleFonts.nunito(
      textStyle: TextStyle(
        color: color,
        fontSize: SizeConfig.textMultiplier * size,
        fontWeight: fontWeight,
      ),
    ),
  );
}

InputDecoration customImpDec(String hint) {
  return InputDecoration(
    counterStyle: TextStyle(color: Colors.transparent),
    fillColor: Colors.white,
    filled: true,
    isDense: true,
    contentPadding: EdgeInsets.symmetric(horizontal: 17, vertical: 15),
    hintText: hint,
    hintStyle: TextStyle(
        color: Constants.grey,
        fontSize: SizeConfig.textMultiplier * 2.0,
        fontWeight: FontWeight.w600),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Constants.primaryColor),
      borderRadius: BorderRadius.circular(10),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Constants.lightGrey),
      borderRadius: BorderRadius.circular(10),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Constants.lightGrey),
      borderRadius: BorderRadius.circular(10),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Constants.lightGrey),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Constants.lightGrey),
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

class CustomBorder {
  static var enabledBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(color: Colors.grey));

  static var focusBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(color: ThemeData.light().primaryColor, width: 1));

  static var errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(color: Colors.red, width: 1));
}
