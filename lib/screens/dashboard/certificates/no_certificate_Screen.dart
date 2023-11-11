import 'package:flutter/material.dart';

import '../../../widgets/common.dart';
import '../../../widgets/style.dart';
import 'buy_certificate/1_pick_category.dart';

class NoCertificateScreen extends StatelessWidget {
  NoCertificateScreen({Key? key}) : super(key: key);

  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Column(
      children: [
        SizedBox(height: size.height * 0.03),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: VariableText(
                  text: "Become a Forever Fan",
                  fontcolor: primaryColorW,
                  fontsize: size.height * 0.015,
                  fontFamily: fontSemiBold,
                  max_lines: 1,
                  textAlign: TextAlign.center
              ),
            )
          ],
        ),
        SizedBox(height: size.height * 0.02),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: VariableText(
                    text: "Get your first Certificate and become a Forever Fan of your team.",
                    fontcolor: primaryColorW,
                    fontsize: size.height * 0.014,
                    fontFamily: fontRegular,
                    max_lines: 5,
                    line_spacing: 1.5,
                    textAlign: TextAlign.center
                ),
              )
            ],
          ),
        ),
        SizedBox(height: size.height * 0.02),
        Image.asset("assets/icons/ic_no_certificate.png", fit: BoxFit.fitWidth),
        SizedBox(height: size.height * 0.02),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.15),
          child: MyButton(
            btnHeight: size.height * 0.055,
            btnColor: Theme.of(context).primaryColor,
            borderColor: Theme.of(context).primaryColor,
            btnRadius: 200,
            btnTxt: "Get My Certificate",
            fontSize: size.height * 0.014,
            fontFamily: fontMedium,
            weight: FontWeight.w500,
            txtColor: textColor1,
            onTap: (){
              Navigator.push(
                  context,
                  SwipeLeftAnimationRoute(widget: PickCertificateCategory()));
            },
          ),
        ),
      ],
    );
  }
}
