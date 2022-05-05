import 'package:flutter_cart/flutter_cart.dart';
import 'package:get/get.dart';
import 'package:qpi/model/product_mdel.dart';

import 'package:qpi/utils/services.dart';

class ProductController extends GetxController {
  var loading = true.obs;
  // List<int> ecgList = [];
  RxString ecgString = "".obs;
  // RxList<ECGCord> ecgControllerList = [].obs;
  RxList<ProductModel> prodList = <ProductModel>[].obs;
  RxList<ProductModel> categprodList = <ProductModel>[].obs;
  RxList<String> categList = <String>[].obs;
  RxString selCateg = "All".obs;
  RxDouble cartTotal = 0.0.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchProdList();
  }

  void filterProduct(String name) {
    List<ProductModel> resultedList = [];
    if (name == "All") {
      resultedList = prodList;
    } else {
      resultedList.clear();
      resultedList = prodList
          .where((element) => element.category == name
              // .toString()
              // .toLowerCase()
              // .contains(name.toLowerCase()),
              )
          .toList();
    }
    categprodList.value = resultedList;
  }

  getCartTotalAmount() {
    FlutterCart cartItems = FlutterCart();
    double totalAmount = 0.0;
    for (var e in cartItems.cartItem) {
      totalAmount += e.unitPrice;
    }
    return totalAmount;
  }

  // getGrandTotal() {
  //   double cartTotal = getCartTotalAmount();
  //   double sgst = cartTotal * 0.02;
  //   double cgst = cartTotal * 0.02;
  //   double discount = cartTotal * 0.05;
  //   return cartTotal + sgst + cgst - discount;
  // }

  Future<void> fetchProdList() async {
    try {
      loading(true);
      var prodData = await ApiServices.fetchProd();
      if (prodData != null) {
        print("moizata");
        print(prodData);
        prodList.value = prodData;
        categprodList.value = prodData;
        List abcd = [];
        categList.clear();
        for (int i = 0; i < prodList.length; i++) {
          abcd.add(prodList[i].category);
        }
        List neww = abcd.toSet().toList();
        categList.add("All");
        categList.add("Milk");
        for (int i = 0; i < neww.length; i++) {
          if (neww[i].toString() != "Milk") {
            categList.add(neww[i].toString());
          }
        }
      } else
        print("NO DATA FOUND");
    } finally {
      loading(false);
    }
  }
}
