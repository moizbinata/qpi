import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  Rx<FlutterCart> cart = FlutterCart().obs;
}
