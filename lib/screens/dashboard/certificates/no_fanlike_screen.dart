import 'package:flutter/material.dart';

import '../../../widgets/common.dart';
import '../../../widgets/style.dart';

class NoFanLikeScreen extends StatelessWidget {
  const NoFanLikeScreen({Key? key}) : super(key: key);

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
                  text: "Show your passion on your phone",
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
                    text: "Get your first FanLike and show you are a Forever Fan on your phone’s wallpaper.",
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
        Image.asset("assets/icons/ic_no_fanlike.png", fit: BoxFit.fitWidth),
        SizedBox(height: size.height * 0.02),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.15),
          child: MyButton(
            btnHeight: size.height * 0.055,
            btnColor: Theme.of(context).primaryColor,
            borderColor: Theme.of(context).primaryColor,
            btnRadius: 200,
            btnTxt: "Get my FanLike",
            fontSize: size.height * 0.014,
            fontFamily: fontMedium,
            weight: FontWeight.w500,
            txtColor: textColor1,
            onTap: (){},
          ),
        ),
      ],
    );
  }
}
