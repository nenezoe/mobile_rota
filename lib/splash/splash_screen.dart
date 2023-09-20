import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors.dart';
import '../speech_screen.dart';
import '../voice_screen.dart';
import 'splash_controller.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  static const name = '/splash';

  @override
  Widget build(BuildContext context) {
    final _ = Get.put(SplashController());

    return Scaffold(
      body: Stack(
        children: [
          Obx(
            () => AnimatedContainer(
              duration: 1.seconds,
              decoration: BoxDecoration(
                gradient: _.currentGradient,
              ),
            ),
          ),
          Center(
            child: Image.asset(
              'assets/images/rotapadlogo.png',
              height: 150,
              width: 150,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 80,
            child: Obx(
              () => AnimatedOpacity(
                opacity: _.showNavigateBtn ? 1 : 0,
                curve: Curves.easeInCubic,
                duration: const Duration(milliseconds: 100),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 40.0),
                    //   child: Text(
                    //     'Save time with our speech ',
                    //     style: TextStyle(
                    //         color: Colors.white,
                    //         fontFamily: 'Figtree',
                    //         fontSize: 24),
                    //   ),
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    // Text(
                    //   'We have new features!',
                    //   style: TextStyle(
                    //       color: Colors.white54, fontFamily: 'Figtree'),
                    // ),
                    InkWell(
                      onTap: () {
                        Get.to(SpeechScreen());
                        // Get.to(SpeechToTextScreen());
                      },
                      // onTap: _.navigate,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40.0, vertical: 24),
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Color(0xff7f00ff)
                              // color: Color(0xff084c70)
                              ),
                          child: Center(
                            child: Text(
                              'Get Started!',
                              style: GoogleFonts.figtree(
                                // color: bgColor,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                // fontFamily: 'Figtree',
                                // type: FontType.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }


}
