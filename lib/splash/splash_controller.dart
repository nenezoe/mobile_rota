import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile_rota/splash/splash_screen_gradients.dart';

class SplashController extends GetxController {
  final index = 0.obs;

  bool getStarted = false;

  Gradient get currentGradient => splashScreenGradients[index.value];

  final _showNavigateBtn = false.obs;

  bool get showNavigateBtn => _showNavigateBtn.value;

  checkLoginState() async {
    // // TODO REMOVE
    // if (kDebugMode) {
    //   await FirebaseAuth.instance.signOut();
    // }

    // final auth = Get.find<FirebaseAuthService>();
    // if (auth.user == null) {
    //   Get.offAllNamed(Routes.onBoardingScreen);
    //   return;
    // }
    // Get.offAllNamed(Routes.homeScreen);
  }

  void animate() async {
    if (index.value < splashScreenGradients.length - 1) {
      index(index.value + 1);
      await Future.delayed(0.8.seconds);
      animate();
    } else {
      _showNavigateBtn.value = true;
    }
  }

  void navigate() {
    checkLoginState();
  }

  @override
  void onInit() {
    super.onInit();
    final box = GetStorage();

    // if (box.read(PreferenceKeys.initialized) != true) {
    //   const defaultTimeToRate = TimeOfDay(hour: 8, minute: 0);

    //   Helpers.setupNotificationSchedule(defaultTimeToRate);

    //   box.write(PreferenceKeys.initialized, true);
    // }

    animate();
  }
}
