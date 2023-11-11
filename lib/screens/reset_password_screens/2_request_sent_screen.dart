import 'package:fan_hall/controller/auth/user_authentications.dart';
import 'package:fan_hall/screens/reset_password_screens/1_forgot_pass_screen.dart';
import 'package:fan_hall/screens/reset_password_screens/1_update_password.dart';
import 'package:fan_hall/screens/reset_password_screens/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:video_player/video_player.dart';

import '../../widgets/common.dart';
import '../../widgets/style.dart';
import '3_resend_screen.dart';

class RequestSentScreen extends StatefulWidget {
  String email;
  RequestSentScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<RequestSentScreen> createState() => _RequestSentScreenState();
}

class _RequestSentScreenState extends State<RequestSentScreen> {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    playVideo();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  bool isLoading = false;
  setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

  validate() {
    bool allSet = false;
    if (widget.email.isNotEmpty) {
      return true;
    } else {
      Fluttertoast.showToast(
          msg: "Please enter email", toastLength: Toast.LENGTH_SHORT);
    }
    return allSet;
  }

  forgotPassword() async {
    setLoading(true);
    if (validate()) {
      var response = await AuthenticationService().forgotPassword(widget.email);
      if (response is Map) {
        if (response['status']) {
          String otp = response['otp'].toString();

          setLoading(false);
          Navigator.push(
              context,
              SwipeLeftAnimationRoute(
                  milliseconds: 200,
                  widget: OtpScreen(
                    email: widget.email,
                    otp: otp,
                  ))).then((value) => playVideo());
        } else {
          setLoading(false);
          Fluttertoast.showToast(
              msg: response['msg'].toString(), toastLength: Toast.LENGTH_SHORT);
        }
      } else {
        setLoading(false);
        Fluttertoast.showToast(
            msg: response.toString(), toastLength: Toast.LENGTH_SHORT);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      body: Stack(
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
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: size.width * hPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: size.height * 0.20),
                    Image.asset("assets/icons/ic_logo.png", scale: 5.8),
                    SizedBox(height: size.height * 0.04),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: VariableText(
                            text: "You’ve got mail!",
                            fontsize: size.height * 0.026,
                            fontcolor: textColorW,
                            fontFamily: fontBold,
                            weight: FontWeight.w700,
                            textAlign: TextAlign.center,
                            line_spacing: 1.5,
                            max_lines: 3,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: size.height * 0.04),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: VariableText(
                            text:
                                'We have send you an email to reset your password, follow the link and login.',
                            fontsize: size.height * 0.018,
                            fontcolor: textColorW,
                            fontFamily: fontMedium,
                            weight: FontWeight.w400,
                            textAlign: TextAlign.center,
                            line_spacing: 1.5,
                            max_lines: 4,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: size.height * 0.04),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: isLoading == true
                              ? SizedBox(
                                  height: size.height * 0.05,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                )
                              : MyButton(
                                  btnHeight: size.height * 0.055,
                                  btnColor: primaryColorW,
                                  borderColor: primaryColorW,
                                  btnRadius: 200,
                                  btnTxt: "Resend link",
                                  fontSize: size.height * 0.018,
                                  fontFamily: fontSemiBold,
                                  weight: FontWeight.w500,
                                  txtColor: textColor1,
                                  onTap: () {
                                    forgotPassword();
                                    // Navigator.push(
                                    //         context,
                                    //         SwipeLeftAnimationRoute(
                                    //             widget: ()))
                                    //     .then((value) => playVideo());
                                  },
                                ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            SwipeLeftAnimationRoute(
                                widget: Update_Name(
                              email: widget.email,
                            )));
                      },
                      child: VariableText(
                        text: "Continue",
                        fontsize: size.height * 0.018,
                        fontcolor: textColorW,
                        fontFamily: fontRegular,
                        weight: FontWeight.w400,
                        textAlign: TextAlign.center,
                        underlined: true,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: MyBackButton(),
            ),
          )
        ],
      ),
    );
  }
}
