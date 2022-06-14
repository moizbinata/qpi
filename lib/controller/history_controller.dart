import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qpi/model/history_model.dart';
import 'package:qpi/utils/services.dart';

class HistoryController extends GetxController {
  RxList<HistoryModel> historyList = <HistoryModel>[].obs;
  var loading = true.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchHistoryList();
  }

  Future<void> fetchHistoryList() async {
    try {
      loading(true);
      var prodData = await ApiServices.fetchHistory();
      if (prodData != null) {
        historyList.assignAll(prodData);
      }
      print(historyList.toString());
    } finally {
      loading(false);
    }
  }
}
