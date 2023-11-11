import 'package:fan_hall/widgets/common.dart';
import 'package:fan_hall/widgets/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CertificateVview extends StatefulWidget {
  const CertificateVview({super.key});

  @override
  State<CertificateVview> createState() => _CertificateVviewState();
}

class _CertificateVviewState extends State<CertificateVview> {
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
              // Navigator.push(
              //     context,
              //     SwipeLeftAnimationRoute(widget: PickCertificateCategory()));
            },
          ),
        ),
      ],
    );
  }
}