import 'dart:async';

import 'package:get/get.dart';

import '../../login/views/login_view.dart';

class HomeController extends GetxController {

  late Timer _pindah;

  @override
  void onInit() {
    _pindah = Timer.periodic(
  const Duration(seconds: 4),
  (timer) => Get.off(
    () => LoginView(),
    transition: Transition.leftToRight,
  ),
);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    _pindah.cancel();
  }
}
