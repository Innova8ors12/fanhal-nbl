import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import '../../widgets/common.dart';
import '../../widgets/style.dart';
import '../dashboard/scan_screens/scan_certificate_screen.dart';
import '../dashboard/scan_screens/scan_id_screen.dart';
import '../get_started_screen.dart';
import 'login_screen.dart';
import 'terms_conditions_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late VideoPlayerController _controller;
  final hPadding = 0.17;

  playVideo() {
    _controller = VideoPlayerController.asset('assets/videos/login1.mp4')
      ..initialize().then((_) {
        _controller.setLooping(true);
        _controller.setVolume(0.0);
        _controller.play();
        setState(() {});
      });
  }

  getPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    kprimaryColor = preferences.getString("primaryColor") ?? "";
  }

  @override
  void initState() {
    // TODO: implement initState
    getPrefs();
    super.initState();
    playVideo();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.black,
        body: Container(
          child: Stack(
            children: [
              if (_controller.value.isInitialized) VideoPlayer(_controller),
              Positioned.fill(
                child: Container(
                  color: const Color(0xFF000000).withOpacity(0.6),
                ),
              ),
              /*Positioned.fill(
                child: Image.asset("assets/images/welcome_background.png", fit: BoxFit.cover),
              ),
              Positioned.fill(
                child: Container(
                  color: const Color(0xFF000000).withOpacity(0.8),
                ),
              ),*/
              Positioned.fill(
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: size.height * 0.17),
                      Image.asset("assets/icons/ic_logo.png", scale: 5.8),
                      SizedBox(height: size.height * 0.10),

                      ///login button
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * hPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: VariableText(
                                text: "WELCOME",
                                fontsize: size.height * 0.020,
                                fontcolor: textColorW,
                                fontFamily: fontBold,
                                weight: FontWeight.w700,
                                textAlign: TextAlign.center,
                                max_lines: 1,
                              ),
                            ),
                            Expanded(
                              child: MyButtonPrefixIcon(
                                btnHeight: size.height * 0.055,
                                btnColor: primaryColorW,
                                borderColor: primaryColorW,
                                btnRadius: 200,
                                btnTxt: "Login",
                                icon: "assets/icons/ic_key.png",
                                fontSize: size.height * 0.018,
                                fontFamily: fontSemiBold,
                                weight: FontWeight.w500,
                                txtColor: textColor1,
                                onTap: () {
                                  Navigator.push(
                                          context,
                                          SwipeLeftAnimationRoute(
                                              widget: LoginScreen()))
                                      .then((value) => playVideo());
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),

                      ///certificate
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * hPadding),
                        child: Row(
                          children: [
                            Expanded(
                              child: MyButtonPrefixIcon(
                                btnHeight: size.height * 0.055,
                                btnColor: primaryColorW,
                                borderColor: primaryColorW,
                                btnRadius: 200,
                                btnTxt: "Scan a certificate",
                                icon: "assets/icons/ic_barcode_small.png",
                                fontSize: size.height * 0.018,
                                fontFamily: fontSemiBold,
                                weight: FontWeight.w500,
                                txtColor: textColor1,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      SwipeLeftAnimationRoute(
                                          widget: ScanCertificateScreen(certscan: true,)));
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),

                      ///ID
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * hPadding),
                        child: Row(
                          children: [
                            Expanded(
                              child: MyButtonPrefixIcon(
                                btnHeight: size.height * 0.055,
                                btnColor: primaryColorW,
                                borderColor: primaryColorW,
                                btnRadius: 200,
                                btnTxt: "Scan ID Fanhall",
                                icon: "assets/icons/ic_scanner.png",
                                fontSize: size.height * 0.018,
                                fontFamily: fontSemiBold,
                                weight: FontWeight.w500,
                                txtColor: textColor1,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      SwipeLeftAnimationRoute(
                                          widget: QrScanScreen(
                                        registered: false,
                                      )));
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      Expanded(
                        child: ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(height: size.height * 0.03),

                                ///terms
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    VariableText(
                                      text: 'By tapping “Register now”',
                                      fontsize: size.height * 0.014,
                                      fontcolor: textColorW,
                                      fontFamily: fontMedium,
                                      weight: FontWeight.w400,
                                      textAlign: TextAlign.center,
                                      line_spacing: 1.5,
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    VariableText(
                                      text: "you agree to our ",
                                      fontsize: size.height * 0.014,
                                      fontcolor: textColorW,
                                      fontFamily: fontMedium,
                                      weight: FontWeight.w400,
                                      textAlign: TextAlign.center,
                                      line_spacing: 1.5,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            SwipeLeftAnimationRoute(
                                                widget: TermsScreen()));
                                      },
                                      child: VariableText(
                                        text: "Terms and Conditions.",
                                        fontsize: size.height * 0.014,
                                        fontcolor: textColorW,
                                        fontFamily: fontMedium,
                                        weight: FontWeight.w400,
                                        textAlign: TextAlign.center,
                                        line_spacing: 1.5,
                                        underlined: true,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: size.height * 0.06),

                                ///register button
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * hPadding),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: MyButton(
                                          btnHeight: size.height * 0.055,
                                          btnColor: primaryColorW,
                                          borderColor: primaryColorW,
                                          btnRadius: 200,
                                          btnTxt: "Register now",
                                          fontSize: size.height * 0.018,
                                          fontFamily: fontSemiBold,
                                          weight: FontWeight.w500,
                                          txtColor: textColor1,
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                SwipeLeftAnimationRoute(
                                                    widget: GetStartedScreen(
                                                        canBack: true)));
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
