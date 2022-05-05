import 'package:get/get.dart';
import 'package:qpi/model/ussermomdel.dart';

class LoginController extends GetxController {
  var loading = false.obs;
  RxList<UserModel> userDataList = <UserModel>[].obs;
}
