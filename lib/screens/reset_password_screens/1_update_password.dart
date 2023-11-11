import 'package:fan_hall/screens/login_screens/login_screen.dart';
import 'package:fan_hall/screens/reset_password_screens/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:video_player/video_player.dart';

import '../../controller/auth/user_authentications.dart';
import '../../widgets/common.dart';
import '../../widgets/style.dart';
import '2_request_sent_screen.dart';

class Update_Name extends StatefulWidget {
  String email;
  Update_Name({Key? key, required this.email}) : super(key: key);

  @override
  State<Update_Name> createState() => _Update_NameState();
}

class _Update_NameState extends State<Update_Name> {
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

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  bool isLoading = false;
  setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

  // validate() {
  //   bool allSet = false;
  //   if (_passwordController.text.isNotEmpty) {
  //     return true;
  //   } else {
  //     Fluttertoast.showToast(
  //         msg: "Please enter email", toastLength: Toast.LENGTH_SHORT);
  //   }
  //   return allSet;
  // }

  bool btnEnable = false;

  validate() {
    bool allSet = false;
    if (_passwordController.text.isNotEmpty) {
      if (_newPasswordController.text.isNotEmpty) {
        return true;
      } else {
        Fluttertoast.showToast(
            msg: "Please enter Confirm Password",
            toastLength: Toast.LENGTH_SHORT);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Please enter New Password", toastLength: Toast.LENGTH_SHORT);
    }
    return allSet;
  }

  updatepassword() async {
    setLoading(true);
    if (validate()) {
      var response = await AuthenticationService()
          .updatePasswordCustomer(widget.email, _newPasswordController.text);
      if (response is Map) {
        if (response['status']) {
          // UserModel userDetails = UserModel.fromJson(response['data']);
          setLoading(false);
          Fluttertoast.showToast(
              msg: "Password update successfull",
              toastLength: Toast.LENGTH_SHORT);
          Navigator.pushReplacement(
              context,
              SwipeLeftAnimationRoute(
                  milliseconds: 200, widget: LoginScreen()));
        } else {
          setLoading(false);
          Fluttertoast.showToast(
              msg: response['msg'], toastLength: Toast.LENGTH_SHORT);
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
                child: SingleChildScrollView(
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
                              text: "One step closer",
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
                      SizedBox(height: size.height * 0.06),

                      ///email
                     PasswordTextField(
                        hint: "Enter Password",
                        cont: _passwordController,
                      ),
                      SizedBox(height: size.height * 0.02),
                     PasswordTextField(
                        hint: "Enter New Password",
                        cont: _newPasswordController,
                      ),
                      SizedBox(height: size.height * 0.02),
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
                                    btnTxt: "Set new password",
                                    fontSize: size.height * 0.018,
                                    fontFamily: fontSemiBold,
                                    weight: FontWeight.w500,
                                    txtColor: textColor1,
                                    onTap: () {
                                      updatepassword();
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ],
                  ),
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
