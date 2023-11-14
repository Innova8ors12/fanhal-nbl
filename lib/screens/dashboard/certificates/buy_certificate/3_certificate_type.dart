import 'package:fan_hall/models/certificate.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/common.dart';
import '../../../../widgets/style.dart';
import '4_choose_design.dart';

class CertificateTypeScreen extends StatelessWidget {
  bool isfame;
  bool isfanmatch;
  final String CertificateId;
  String? seasonid;
  CertificateTypeScreen(
      {Key? key,
      required this.CertificateId,
      this.seasonid,
      this.isfame = false,
      this.isfanmatch = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backgroundColor1,
      body: SafeArea(
        child: isfanmatch
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: size.height * 0.02),

                  ///appbar
                  MenuAppbar(),
                  //SizedBox(height: size.height * 0.03),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: size.height * 0.15,
                          child: teamImage != null
                              ? Image.network(teamImage.toString(),
                                  height: size.height)
                              : Container(
                                  child: Center(
                                      child: Text(
                                    "No Team !",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 192, 57, 57)),
                                  )),
                                ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: VariableText(
                                  text: "Go all the way!",
                                  fontcolor: primaryColorW,
                                  fontsize: size.height * 0.024,
                                  fontFamily: fontSemiBold,
                                  max_lines: 1,
                                  textAlign: TextAlign.center),
                            )
                          ],
                        ),
                        SizedBox(height: size.height * 0.02),
                        MyButton(
                          btnHeight: size.height * 0.055,
                          btnWidth: size.width * 0.60,
                          btnColor: primaryColorW,
                          borderColor: primaryColorW,
                          btnRadius: 200,
                          btnTxt: "Fanmatch Of Team",
                          fontSize: size.height * 0.018,
                          fontFamily: fontSemiBold,
                          weight: FontWeight.w500,
                          txtColor: textColor1,
                          onTap: () {
                            Navigator.push(
                                context,
                                SwipeLeftAnimationRoute(
                                    widget: ChooseDesignScreen(
                                  type: "1",
                                  id: "",
                                  fanmatch: true,
                                )));
                          },
                        ),
                        SizedBox(height: size.height * 0.02),
                        MyButton(
                          btnHeight: size.height * 0.055,
                          btnWidth: size.width * 0.60,
                          btnColor: primaryColorW,
                          borderColor: primaryColorW,
                          btnRadius: 200,
                          btnTxt: "Fanmatch Of Player",
                          fontSize: size.height * 0.018,
                          fontFamily: fontSemiBold,
                          weight: FontWeight.w500,
                          txtColor: textColor1,
                          onTap: () {
                            Navigator.push(
                                context,
                                SwipeLeftAnimationRoute(
                                    widget: ChooseDesignScreen(
                                  type: "2",
                                  id: "",
                                  fanmatch: true,
                                )));
                          },
                        ),
                        SizedBox(height: size.height * 0.02),
                        MyButton(
                          btnHeight: size.height * 0.055,
                          btnWidth: size.width * 0.60,
                          btnColor: primaryColorW,
                          borderColor: primaryColorW,
                          btnRadius: 200,
                          btnTxt: "Fanmatch Of Game",
                          fontSize: size.height * 0.018,
                          fontFamily: fontSemiBold,
                          weight: FontWeight.w500,
                          txtColor: textColor1,
                          onTap: () {
                            Navigator.push(
                                context,
                                SwipeLeftAnimationRoute(
                                    widget: ChooseDesignScreen(
                                  type: "3",
                                  id: "",
                                  fanmatch: true,
                                )));
                          },
                        ),
                        SizedBox(height: size.height * 0.15),
                      ],
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: size.height * 0.02),

                  ///appbar
                  MenuAppbar(),
                  //SizedBox(height: size.height * 0.03),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: size.height * 0.15,
                          child: teamImage != null
                              ? Image.network(teamImage.toString(),
                                  height: size.height)
                              : Container(
                                  child: Center(
                                      child: Text(
                                    "No Team !",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 192, 57, 57)),
                                  )),
                                ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: VariableText(
                                  text: "Go all the way!",
                                  fontcolor: primaryColorW,
                                  fontsize: size.height * 0.024,
                                  fontFamily: fontSemiBold,
                                  max_lines: 1,
                                  textAlign: TextAlign.center),
                            )
                          ],
                        ),
                        SizedBox(height: size.height * 0.02),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: VariableText(
                                    text:
                                        "If you choose WallArt Certificate you will get a digital version for FREE.",
                                    fontcolor: primaryColorW,
                                    fontsize: size.height * 0.016,
                                    fontFamily: fontRegular,
                                    max_lines: 4,
                                    textAlign: TextAlign.center),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: size.height * 0.06),
                        MyButton(
                          btnHeight: size.height * 0.055,
                          btnWidth: size.width * 0.60,
                          btnColor: primaryColorW,
                          borderColor: primaryColorW,
                          btnRadius: 200,
                          btnTxt: "Digital",
                          fontSize: size.height * 0.018,
                          fontFamily: fontSemiBold,
                          weight: FontWeight.w500,
                          txtColor: textColor1,
                          onTap: () {
                            Navigator.push(
                                context,
                                SwipeLeftAnimationRoute(
                                    widget: ChooseDesignScreen(
                                  type: "Digital",
                                  id: CertificateId,
                                  isfame: isfame,
                                )));
                          },
                        ),
                        SizedBox(height: size.height * 0.02),
                        MyButton(
                          btnHeight: size.height * 0.055,
                          btnWidth: size.width * 0.60,
                          btnColor: primaryColorW,
                          borderColor: primaryColorW,
                          btnRadius: 200,
                          btnTxt: "WallArt",
                          fontSize: size.height * 0.018,
                          fontFamily: fontSemiBold,
                          weight: FontWeight.w500,
                          txtColor: textColor1,
                          onTap: () {
                            Navigator.push(
                                context,
                                SwipeLeftAnimationRoute(
                                    widget: ChooseDesignScreen(
                                        type: "art",
                                        id: CertificateId,
                                        isfame: isfame)));
                          },
                        ),
                        SizedBox(height: size.height * 0.15),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
