import 'package:fan_hall/models/certificate.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/common.dart';
import '../../../../widgets/style.dart';
import '4_choose_design.dart';

class CertificateTypeScreen extends StatefulWidget {
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
  State<CertificateTypeScreen> createState() => _CertificateTypeScreenState();
}

class _CertificateTypeScreenState extends State<CertificateTypeScreen> {
  List<String> Fanmatchtypes = ["Video FanMatch", "Pic FanMatch"];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backgroundColor1,
      body: SafeArea(
        child: widget.isfanmatch
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
                        Container(
                            height: size.height * 0.06,
                            width: size.width * 0.6,
                            decoration: BoxDecoration(
                              color: textColorW,
                              borderRadius: BorderRadius.circular(200),
                            ),
                            child: InputDecorator(
                                decoration: InputDecoration(
                                  iconColor: primaryColor1,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(200),
                                      borderSide: BorderSide(
                                          color: primaryColorW, width: 2.0)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(200),
                                      borderSide: BorderSide(
                                          color: primaryColorW, width: 2.0)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(200),
                                      borderSide: BorderSide(
                                          color: primaryColorW, width: 2.0)),
                                  contentPadding: EdgeInsets.all(10),
                                ),
                                child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                        icon: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Image.asset(
                                              'assets/icons/ic_dropdown.png',
                                              scale: 3),
                                        ),
                                        hint: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12),
                                          child: Center(
                                            child: VariableText(
                                              text: "FanMatch Of Team",
                                              fontsize: size.height * 0.018,
                                              fontFamily: fontSemiBold,
                                              weight: FontWeight.w500,
                                              fontcolor: textColor1,
                                            ),
                                          ),
                                        ),
                                        value: herostype,
                                        dropdownColor: textColorW,
                                        isExpanded: true,
                                        onTap: () {
                                          FocusScope.of(context).unfocus();
                                        },
                                        onChanged: (String? value) {
                                          // selectedmomentId=null;
                                          Fanmatchtype = null;
                                          if (herostype == null) {
                                            setState(() {
                                              Fanmatchtype = value;
                                              // selectedHero=herosType.toString();
                                            });
                                          } else {
                                            Fanmatchtype = null;
                                          }
                                          if (Fanmatchtype ==
                                              "Video FanMatch") {
                                            Navigator.push(
                                                context,
                                                SwipeLeftAnimationRoute(
                                                    widget: ChooseDesignScreen(
                                                  type: "1",
                                                  id: "",
                                                  fanmatch: true,
                                                  isvideo: true,
                                                )));
                                          } else {
                                            Navigator.push(
                                                context,
                                                SwipeLeftAnimationRoute(
                                                    widget: ChooseDesignScreen(
                                                  type: "1",
                                                  id: "",
                                                  fanmatch: true,
                                                )));
                                          }
                                        },
                                        style: TextStyle(
                                            fontSize: size.height * 0.017,
                                            color: textColorW),
                                        items: Fanmatchtypes.map<
                                                DropdownMenuItem<String>>(
                                            (String item) {
                                          return DropdownMenuItem<String>(
                                            value: item,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Center(
                                                child: VariableText(
                                                  text: item,
                                                  fontsize: size.height * 0.018,
                                                  fontFamily: fontSemiBold,
                                                  weight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList())))),
                        // MyButton(
                        //   btnHeight: size.height * 0.055,
                        //   btnWidth: size.width * 0.60,
                        //   btnColor: primaryColorW,
                        //   borderColor: primaryColorW,
                        //   btnRadius: 200,
                        //   btnTxt: "FanMatch Of Team",
                        //   fontSize: size.height * 0.018,
                        //   fontFamily: fontSemiBold,
                        //   weight: FontWeight.w500,
                        //   txtColor: textColor1,
                        //   onTap: () {
                        //     Navigator.push(
                        //         context,
                        //         SwipeLeftAnimationRoute(
                        //             widget: ChooseDesignScreen(
                        //           type: "1",
                        //           id: "",
                        //           fanmatch: true,
                        //         )));
                        //   },
                        // ),
                        SizedBox(height: size.height * 0.02),
                        Container(
                            height: size.height * 0.06,
                            width: size.width * 0.6,
                            decoration: BoxDecoration(
                              color: textColorW,
                              borderRadius: BorderRadius.circular(200),
                            ),
                            child: InputDecorator(
                                decoration: InputDecoration(
                                  iconColor: primaryColor1,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(200),
                                      borderSide: BorderSide(
                                          color: primaryColorW, width: 2.0)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(200),
                                      borderSide: BorderSide(
                                          color: primaryColorW, width: 2.0)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(200),
                                      borderSide: BorderSide(
                                          color: primaryColorW, width: 2.0)),
                                  contentPadding: EdgeInsets.all(10),
                                ),
                                child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                        icon: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Image.asset(
                                              'assets/icons/ic_dropdown.png',
                                              scale: 3),
                                        ),
                                        hint: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12),
                                          child: Center(
                                            child: VariableText(
                                              text: "FanMatch Of Player",
                                              fontsize: size.height * 0.018,
                                              fontFamily: fontSemiBold,
                                              weight: FontWeight.w500,
                                              fontcolor: textColor1,
                                            ),
                                          ),
                                        ),
                                        value: herostype,
                                        dropdownColor: textColorW,
                                        isExpanded: true,
                                        onTap: () {
                                          FocusScope.of(context).unfocus();
                                        },
                                        onChanged: (String? value) {
                                          // selectedmomentId=null;
                                          Fanmatchtype = null;
                                          if (herostype == null) {
                                            setState(() {
                                              Fanmatchtype = value;
                                              // selectedHero=herosType.toString();
                                            });
                                          } else {
                                            Fanmatchtype = null;
                                          }
                                          if (Fanmatchtype ==
                                              "Video FanMatch") {
                                            Navigator.push(
                                                context,
                                                SwipeLeftAnimationRoute(
                                                    widget: ChooseDesignScreen(
                                                  type: "2",
                                                  id: "",
                                                  fanmatch: true,
                                                  isvideo: true,
                                                )));
                                          } else {
                                            Navigator.push(
                                                context,
                                                SwipeLeftAnimationRoute(
                                                    widget: ChooseDesignScreen(
                                                  type: "2",
                                                  id: "",
                                                  fanmatch: true,
                                                )));
                                          }
                                        },
                                        style: TextStyle(
                                            fontSize: size.height * 0.017,
                                            color: textColorW),
                                        items: Fanmatchtypes.map<
                                                DropdownMenuItem<String>>(
                                            (String item) {
                                          return DropdownMenuItem<String>(
                                            value: item,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Center(
                                                child: VariableText(
                                                  text: item,
                                                  fontsize: size.height * 0.018,
                                                  fontFamily: fontSemiBold,
                                                  weight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList())))),
                        // MyButton(
                        //   btnHeight: size.height * 0.055,
                        //   btnWidth: size.width * 0.60,
                        //   btnColor: primaryColorW,
                        //   borderColor: primaryColorW,
                        //   btnRadius: 200,
                        //   btnTxt: "FanMatch Of Team",
                        //   fontSize: size.height * 0.018,
                        //   fontFamily: fontSemiBold,
                        //   weight: FontWeight.w500,
                        //   txtColor: textColor1,
                        //   onTap: () {
                        //     Navigator.push(
                        //         context,
                        //         SwipeLeftAnimationRoute(
                        //             widget: ChooseDesignScreen(
                        //           type: "1",
                        //           id: "",
                        //           fanmatch: true,
                        //         )));
                        //   },
                        // ),
                        SizedBox(height: size.height * 0.02),
                        Container(
                            height: size.height * 0.06,
                            width: size.width * 0.6,
                            decoration: BoxDecoration(
                              color: textColorW,
                              borderRadius: BorderRadius.circular(200),
                            ),
                            child: InputDecorator(
                                decoration: InputDecoration(
                                  iconColor: primaryColor1,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(200),
                                      borderSide: BorderSide(
                                          color: primaryColorW, width: 2.0)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(200),
                                      borderSide: BorderSide(
                                          color: primaryColorW, width: 2.0)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(200),
                                      borderSide: BorderSide(
                                          color: primaryColorW, width: 2.0)),
                                  contentPadding: EdgeInsets.all(10),
                                ),
                                child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                        icon: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Image.asset(
                                              'assets/icons/ic_dropdown.png',
                                              scale: 3),
                                        ),
                                        hint: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12),
                                          child: Center(
                                            child: VariableText(
                                              text: "FanMatch Of Game",
                                              fontsize: size.height * 0.018,
                                              fontFamily: fontSemiBold,
                                              weight: FontWeight.w500,
                                              fontcolor: textColor1,
                                            ),
                                          ),
                                        ),
                                        value: herostype,
                                        dropdownColor: textColorW,
                                        isExpanded: true,
                                        onTap: () {
                                          FocusScope.of(context).unfocus();
                                        },
                                        onChanged: (String? value) {
                                          // selectedmomentId=null;
                                          Fanmatchtype = null;
                                          if (herostype == null) {
                                            setState(() {
                                              Fanmatchtype = value;
                                              // selectedHero=herosType.toString();
                                            });
                                          } else {
                                            Fanmatchtype = null;
                                          }
                                          if (Fanmatchtype ==
                                              "Video FanMatch") {
                                            Navigator.push(
                                                context,
                                                SwipeLeftAnimationRoute(
                                                    widget: ChooseDesignScreen(
                                                  type: "3",
                                                  id: "",
                                                  fanmatch: true,
                                                  isvideo: true,
                                                )));
                                          } else {
                                            Navigator.push(
                                                context,
                                                SwipeLeftAnimationRoute(
                                                    widget: ChooseDesignScreen(
                                                  type: "3",
                                                  id: "",
                                                  fanmatch: true,
                                                )));
                                          }
                                        },
                                        style: TextStyle(
                                            fontSize: size.height * 0.017,
                                            color: textColorW),
                                        items: Fanmatchtypes.map<
                                                DropdownMenuItem<String>>(
                                            (String item) {
                                          return DropdownMenuItem<String>(
                                            value: item,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Center(
                                                child: VariableText(
                                                  text: item,
                                                  fontsize: size.height * 0.018,
                                                  fontFamily: fontSemiBold,
                                                  weight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList())))),
                        // MyButton(
                        //   btnHeight: size.height * 0.055,
                        //   btnWidth: size.width * 0.60,
                        //   btnColor: primaryColorW,
                        //   borderColor: primaryColorW,
                        //   btnRadius: 200,
                        //   btnTxt: "FanMatch Of Team",
                        //   fontSize: size.height * 0.018,
                        //   fontFamily: fontSemiBold,
                        //   weight: FontWeight.w500,
                        //   txtColor: textColor1,
                        //   onTap: () {
                        //     Navigator.push(
                        //         context,
                        //         SwipeLeftAnimationRoute(
                        //             widget: ChooseDesignScreen(
                        //           type: "1",
                        //           id: "",
                        //           fanmatch: true,
                        //         )));
                        //   },
                        // ),
                        SizedBox(height: size.height * 0.02),

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
                                  id: widget.CertificateId,
                                  isfame: widget.isfame,
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
                                        id: widget.CertificateId,
                                        isfame: widget.isfame)));
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
