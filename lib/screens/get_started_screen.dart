import 'package:fan_hall/screens/registration_screens/1_user_details_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/common.dart';
import '../widgets/style.dart';

class GetStartedScreen extends StatelessWidget {
  bool canBack;
  GetStartedScreen({Key? key, this.canBack=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: ()=> Future.value(canBack),
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset("assets/images/welcome_background.png", fit: BoxFit.cover),
            ),
            Positioned.fill(
              child: Container(
                color: const Color(0xFF000000).withOpacity(0.8),
              ),
            ),
            Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/icons/ic_logo.png", scale: 5.8),
                  SizedBox(height: size.height * 0.06),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      VariableText(
                        text: "BECOME\nA FOREVER FAN",
                        fontsize: size.height * 0.026,
                        fontcolor: textColorW,
                        fontFamily: fontBold,
                        weight: FontWeight.w700,
                        textAlign: TextAlign.center,
                        line_spacing: 1.5,
                      )
                    ],
                  ),
                  SizedBox(height: size.height * 0.08),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      VariableText(
                        text: "Write your history and get your\nNFL Oficial Certificate.",
                        fontsize: size.height * 0.018,
                        fontcolor: textColorW,
                        fontFamily: fontSemiBold,
                        weight: FontWeight.w500,
                        textAlign: TextAlign.center,
                        line_spacing: 1.5,
                      )
                    ],
                  ),
                  SizedBox(height: size.height * 0.12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyButton(
                        btnHeight: size.height * 0.06,
                        btnWidth: size.width * 0.60,
                        btnColor: primaryColorW,
                        borderColor: primaryColorW,
                        btnRadius: 200,
                        btnTxt: "Get Started",
                        fontSize: size.height * 0.018,
                        fontFamily: fontSemiBold,
                        weight: FontWeight.w500,
                        txtColor: textColor1,
                        onTap: (){
                          Navigator.push(
                              context,
                              SwipeLeftAnimationRoute(widget: UserCredentialsScreen(), milliseconds: 300));
                        },
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
