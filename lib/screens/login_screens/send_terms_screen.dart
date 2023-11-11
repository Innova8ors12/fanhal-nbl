import 'package:flutter/material.dart';

import '../../widgets/common.dart';
import '../../widgets/style.dart';

class SendTermsScreen extends StatelessWidget {
  const SendTermsScreen({Key? key}) : super(key: key);

  final hPadding = 0.17;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    TextEditingController _email = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      body: Stack(
        children: [
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
                              text: "Terms and Conditions",
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

                      ///Email
                      MyRoundTextField(
                        text: "Enter Email",
                        cont: _email,
                      ),
                      SizedBox(height: size.height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: MyButton(
                              btnHeight: size.height * 0.055,
                              btnColor: primaryColorW,
                              borderColor: primaryColorW,
                              btnRadius: 200,
                              btnTxt: "Send",
                              fontSize: size.height * 0.018,
                              fontFamily: fontSemiBold,
                              weight: FontWeight.w500,
                              txtColor: textColor1,
                              onTap: () {
                                /*Navigator.push(
                                    context,
                                    SwipeLeftAnimationRoute(widget: UserDetailsScreen()));*/
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
