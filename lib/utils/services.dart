import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:qpi/controller/cart_controller.dart';
import 'package:qpi/controller/product_controller.dart';
import 'package:qpi/model/order_model.dart';
import 'package:qpi/model/product_mdel.dart';
import 'package:qpi/splash/views/cart.dart';

class ApiServices {
  static var client = http.Client();

  static Future<List<ProductModel>> fetchProd() async {
    var response = await client.get(Uri.parse(
        'http://www.qpifoods.com/mystore/jatpat_getall_products.php'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      print(jsonString);
      return productModelFromJson(jsonString);
    } else {
      return null;
    }
  }

  Future<String> postOrder(urgency) async {
    List<String> days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
    GetStorage box = GetStorage();
    final controller = Get.put(CartController());
    final prodController = Get.put(ProductController());

    int totalOrder = 0;
    List<String> orderJson = [];
    totalOrder = controller.cart.call().cartItem.length;

    for (int i = 0; i < totalOrder; i++) {
      String pType = (controller.cart.call().cartItem[i].uniqueCheck == "")
          ? "order"
          : "subscription";
      if (pType == "order") {
        orderJson.add("{%22pid%22:" +
            controller.cart.call().cartItem[i].productId.toString() +
            ",%22pname%22:%22" +
            controller.cart.call().cartItem[i].productName +
            "%22,%22price%22:%22" +
            controller.cart.call().cartItem[i].unitPrice.toString() +
            "%22,%22quan%22:%22" +
            controller.cart.call().cartItem[i].quantity.toString() +
            "%22,%22ptype%22:%22" +
            pType +
            "%22}");
      } else {
        final split =
            controller.cart.call().cartItem[i].uniqueCheck.split('//');
        final Map<int, dynamic> values = {
          for (int i = 0; i < split.length; i++) i: split[i]
        };

        List trueDays = jsonDecode(values[0]);
        final value2 = values[1];
        String delDays = "";
        //  sheep
        for (int i = 0; i < trueDays.length; i++) {
          if (trueDays[i] == true) {
            delDays = delDays + days[i].toString() + ",";
          }
        }
        orderJson.add("{%22pid%22:" +
            controller.cart.call().cartItem[i].productId.toString() +
            ",%22pname%22:%22" +
            controller.cart.call().cartItem[i].productName +
            "%22,%22price%22:%22" +
            controller.cart.call().cartItem[i].unitPrice.toString() +
            "%22,%22quan%22:%22" +
            controller.cart.call().cartItem[i].quantity.toString() +
            "%22,%22ptype%22:%22" +
            pType +
            "%22,%22weekdays%22:%22" +
            delDays +
            "%22,%22numweeks%22:%22" +
            value2 +
            "%22}");
      }
    }
    //  https://www.qpifoods.com/mystore/jatpat_store_bill.php?custname=Mala&
    // mobile=9066545279&addr=Malleswaram%20&payamt=762.30&paystatus=Done&
    // deldate=1-5-2022&deltime=12:4&email=meena.aspirehr@gmail.com%20&
    // all_arraylist=[{%22pid%22:%222804%22,%22pname%22:%22Salted%20Butter%2050%20GMS%22,%22price%22:%22131%22,%22quan%22:%223%22,%20%22ptype%22:%22subscription%22,%22weekdays%22:%22Tue,Fri,Sat%22,%22numweeks%22:%223%22},
    // {%22pid%22:%222830%22,%22pname%22:%22Sausages%22,%22price%22:%22110%22,%22quan%22:%225%22,%20%22ptype%22:%22order%22}]

    String postUrl =
        "https://www.qpifoods.com/mystore/jatpat_store_bill.php?custname=${box.read('username')}&mobile=${box.read('mobile')}&addr=${box.read('address2')}&payamt=${prodController.getCartTotalAmount().toStringAsFixed(2)}&paystatus=Done&deldate=${box.read('dateslot')}&deltime=${box.read('timeslot')}&delpriority=$urgency&email=${box.read('email')}&all_arraylist=" +
            orderJson.toString();
    var response = await client.get(Uri.parse(postUrl));
    print(postUrl);
    print(response.body.toString());
    if (response.statusCode == 200) {
      var jsonString = response.body.toString();
      List<OrderModel> orderId = [];
      // ignore: unnecessary_string_interpolations
      if (response.body.toString().contains(":300")) {
        print("error");
        Fluttertoast.showToast(msg: 'Something went wrong');
        return null;
      } else {
        print("moiz");
        var orderJson = orderModelFromJson("[" + jsonString + "]");
        orderId.assignAll(orderJson);
        if (orderId.isNotEmpty) {
          box.write('orderid', orderId.first.status.toString());
          return orderId.first.status;
        } else {
          Fluttertoast.showToast(msg: 'Something went wrong');

          return null;
        }
      }
    } else {
      Fluttertoast.showToast(msg: 'Something went wrong');
      return null;
    }
  }
}
