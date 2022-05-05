// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:qpi/components/components.dart';
// import 'package:qpi/controller/cart_controller.dart';
// import 'package:qpi/controller/product_controller.dart';
// import 'package:qpi/splash/views/home.dart';
// import 'package:qpi/utils/constants.dart';
// import 'package:qpi/utils/size_config.dart';
// import 'package:flutter_cart/flutter_cart.dart';
// import 'package:get/get.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';

// class PaymentScreen extends StatefulWidget {
//   const PaymentScreen({Key key}) : super(key: key);

//   @override
//   State<PaymentScreen> createState() => _PaymentScreenState();
// }

// class _PaymentScreenState extends State<PaymentScreen> {
//   static const platform = const MethodChannel("razorpay_flutter");

//   Razorpay _razorpay;

//   GetStorage box = GetStorage();
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     _razorpay.clear();
//   }

//   void openCheckout() async {
//     var options = {
//       'key': 'rzp_test_PMxI8t8ygIC0u7',
//       'amount': 100,
//       'name': 'Acme Corp.',
//       'order_id': '2342344',
//       'description': 'Fine T-Shirt',
//       'timeout': 60,
//       'prefill': {'contact': '9066545279', 'email': 'meena.aspirehr@gmail.com '}
//     };
//     try {
//       _razorpay.open(options);
//     } catch (e) {
//       debugPrint('Error: e');
//     }
//   }

//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     print('Success Response: $response');
//     Fluttertoast.showToast(
//         msg: "SUCCESS: " + response.paymentId, toastLength: Toast.LENGTH_SHORT);
//   }

//   void _handlePaymentError(PaymentFailureResponse response) {
//     // Do something when payment fails
//     print('Error Response: $response');
//     Fluttertoast.showToast(
//         msg: "ERROR: " + response.code.toString() + " - " + response.message,
//         toastLength: Toast.LENGTH_SHORT);
//   }

//   void _handleExternalWallet(ExternalWalletResponse response) {
//     // Do something when an external wallet was selected
//     print('External SDK Response: $response');
//     Fluttertoast.showToast(
//         msg: "EXTERNAL_WALLET: " + response.walletName,
//         toastLength: Toast.LENGTH_SHORT);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(CartController());
//     final prodController = Get.put(ProductController());

//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           padding: EdgeInsets.symmetric(
//               vertical: SizeConfig.heightMultiplier * 10,
//               horizontal: SizeConfig.heightMultiplier * 4),
//           width: SizeConfig.screenWidth,
//           height: SizeConfig.screenHeight,
//           child: Column(
//             children: [
//               Expanded(
//                 flex: 4,
//                 child: Container(
//                   width: double.infinity,
//                   // height: double.infinity,
//                   decoration: BoxDecoration(
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.3),
//                           offset: Offset(
//                             1.0,
//                             1.0,
//                           ),
//                           blurRadius: 15.0,
//                           spreadRadius: 2.0,
//                         ),
//                       ],
//                       color: Constants.lightBlue,
//                       borderRadius: BorderRadius.circular(20)),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       regularText("THANKS FOR ORDER", 3.0,
//                           Constants.primaryColor, FontWeight.bold, 1),
//                       spaces(),
//                       regularText("ORDER ID: 0000000", 2.0, Constants.grey,
//                           FontWeight.normal, 1),
//                       spaces(),
//                       regularText(
//                           "Total Order: " +
//                               controller.cart
//                                   .call()
//                                   .getCartItemCount()
//                                   .toString(),
//                           2.0,
//                           Constants.grey,
//                           FontWeight.bold,
//                           1),
//                       spaces(),
//                       regularText(
//                           "Total Amount:  ₹ " +
//                               prodController
//                                   .getCartTotalAmount()
//                                   .toStringAsFixed(2),
//                           2.0,
//                           Constants.grey,
//                           FontWeight.bold,
//                           1),
//                     ],
//                   ),
//                 ),
//               ),
//               spaces(),
//               spaces(),
//               InkWell(
//                   onTap: () {
//                     Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => Home(),
//                         ));
//                   },
//                   child: Container(
//                     clipBehavior: Clip.hardEdge,
//                     padding: EdgeInsets.symmetric(
//                         vertical: SizeConfig.heightMultiplier * 1.5),
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         border: Border.all(
//                           color: Constants.primaryColor,
//                           width: 2,
//                         ),
//                         color: Colors.white),
//                     child: regularText("Back to home", 2.0,
//                         Constants.primaryColor, FontWeight.bold, 1),
//                   )),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
