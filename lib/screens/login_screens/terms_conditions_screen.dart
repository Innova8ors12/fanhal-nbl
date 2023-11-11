import 'package:flutter/material.dart';

import '../../widgets/common.dart';
import '../../widgets/style.dart';
import 'send_terms_screen.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({Key? key}) : super(key: key);

  final hPadding = 0.17;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * hPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //SizedBox(height: size.height * 0.10),
                Image.asset("assets/icons/ic_logo.png", scale: 5.8),
                SizedBox(height: size.height * 0.02),
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
                Container(
                  height: size.height * 0.40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: primaryColorW,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: size.width * 0.02, vertical: size.height * 0.015),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: VariableText(
                                      text: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo.",
                                      fontsize: size.height * 0.015,
                                      fontcolor: Colors.black,
                                      fontFamily: fontRegular,
                                      weight: FontWeight.w400,
                                      textAlign: TextAlign.center,
                                      line_spacing: 1.3,
                                      max_lines: 30000,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(
                              context,
                              SwipeLeftAnimationRoute(widget: SendTermsScreen()));
                        },
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(200)
                            ),
                            child: Icon(Icons.mail_outline_outlined, color: primaryColorW),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: MyButton(
                        btnHeight: size.height * 0.055,
                        btnColor: primaryColorW,
                        borderColor: primaryColorW,
                        btnRadius: 200,
                        btnTxt: "Back",
                        fontSize: size.height * 0.018,
                        fontFamily: fontSemiBold,
                        weight: FontWeight.w500,
                        txtColor: textColor1,
                        onTap: (){
                          Navigator.of(context).pop();
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
    );
  }
}
