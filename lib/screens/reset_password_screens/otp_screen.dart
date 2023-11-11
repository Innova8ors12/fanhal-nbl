import 'package:fan_hall/controller/auth/league_api.dart';
import 'package:fan_hall/controller/auth/user_authentications.dart';
import 'package:fan_hall/screens/reset_password_screens/1_update_password.dart';
import 'package:fan_hall/screens/reset_password_screens/2_request_sent_screen.dart';
import 'package:fan_hall/widgets/style.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../models/user_model.dart';
import '../../widgets/common.dart';

class OtpScreen extends StatefulWidget {
  String email;
  String otp;
  OtpScreen({Key? key, required this.email, required this.otp})
      : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController txt1 = TextEditingController();
  TextEditingController txt2 = TextEditingController();
  TextEditingController txt3 = TextEditingController();
  TextEditingController txt4 = TextEditingController();
  TextEditingController txt5 = TextEditingController();
  TextEditingController txt6 = TextEditingController();

  String? enteredOTP;
  bool btnEnable = false;
  bool isLoading = false;
  setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

  validate() {
    bool allSet = false;
    if (widget.email.isNotEmpty) {
      if (enteredOTP!.isNotEmpty) {
        return true;
      } else {
        Fluttertoast.showToast(
            msg: "Please enter OTP", toastLength: Toast.LENGTH_SHORT);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Please enter email", toastLength: Toast.LENGTH_SHORT);
    }
    return allSet;
  }

  verifyOtp() async {
    // validate();
    setLoading(true);

    var response =
        await AuthenticationService().checkOTP(widget.email, enteredOTP);
    if (response is Map) {
      if (response['status']) {
        // UserModel userDetails = UserModel.fromJson(response['data']);
        setLoading(false);
        Navigator.pushReplacement(
            context,
            SwipeLeftAnimationRoute(
                milliseconds: 200,
                widget: Update_Name(
                  email: widget.email,
                )));
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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      // backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.06),
                child: Image.asset("assets/icons/ic_logo.png",
                scale: 5.8,
                    height: size.height * 0.10),
              ),
            ),
            Container(
              height: size.height * 0.79,
              margin: EdgeInsets.only(top: size.height * 0.21),
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * horizontalPadding),
              decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24))),
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.025),
                  VariableText(
                    text: "Email Verification",
                    fontcolor: Theme.of(context).textTheme.titleLarge!.color,
                    fontFamily: fontBold,
                    fontsize: size.height * 0.028,
                    weight: FontWeight.w600,
                  ),
                  SizedBox(height: size.height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: VariableText(
                          text:
                              "Please enter 6 Digit OTP sent to ${widget.email}",
                          fontcolor:
                              Theme.of(context).textTheme.titleSmall!.color,
                          fontFamily: fontRegular,
                          fontsize: size.height * 0.018,
                          weight: FontWeight.w400,
                          textAlign: TextAlign.center,
                          line_spacing: 1.3,
                          max_lines: 3,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.02),

                  ///OTP field
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: size.height * 0.015),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            VariableText(
                              text: "Enter OTP",
                              fontcolor:
                                  Theme.of(context).textTheme.titleLarge!.color,
                              fontFamily: fontBold,
                              fontsize: size.height * 0.018,
                              weight: FontWeight.w500,
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.02),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.08),
                          child: Row(
                            children: [
                              createCodeField(context, txt1, txt2),
                              SizedBox(width: 10),
                              createCodeField(context, txt2, txt3),
                              SizedBox(width: 10),
                              createCodeField(context, txt3, txt4),
                              SizedBox(width: 10),
                              createCodeField(context, txt4, null),
                              SizedBox(width: 10),
                              createCodeField(context, txt5, null),
                              SizedBox(width: 10),
                              createCodeField(context, txt6, null)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),

                  ///Continue
                  isLoading == true
                      ? SizedBox(
                          height: size.height * 0.05,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        )
                      : MyButton(
                          btnHeight: size.height * 0.06,
                          btnColor: Theme.of(context).primaryColor,
                          borderColor: Theme.of(context).primaryColor,
                          btnRadius: 8,
                          btnTxt: "Continue",
                          fontSize: size.height * 0.018,
                          fontFamily: fontMedium,
                          // txtColor: Theme.of(context).brightness == Brightness.light ? primaryLColor2 : primaryDColor2,
                          onTap: () {
                            verifyOtp();
                            // Navigator.push(context,
                            //     SwipeLeftAnimationRoute(
                            //         milliseconds: 200,
                            //         widget: const ResetPassScreen()
                            //     )
                            // );
                          },
                        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget createCodeField(BuildContext context, TextEditingController cont,
      TextEditingController? nextcont) {
    return Expanded(
        child: CodeField(
      cont: cont,
      next_cont: nextcont,
      onComplete: (value) {
        if (txt1.text.isNotEmpty &&
            txt2.text.isNotEmpty &&
            txt3.text.isNotEmpty &&
            txt4.text.isNotEmpty &&
            txt5.text.isNotEmpty &&
            txt6.text.isNotEmpty) {
          FocusScope.of(context).unfocus();
          setState(() {
            btnEnable = true;
          });
          setState(() {
            enteredOTP = txt1.text +
                txt2.text +
                txt3.text +
                txt4.text +
                txt5.text +
                txt6.text;
          });
        } else {
          setState(() {
            btnEnable = false;
          });
        }
        setState(() {});
      },
      radius: 8.0,
      enableColor: Theme.of(context).backgroundColor,
      focusColor: Theme.of(context).focusColor,
    ));
  }
}
