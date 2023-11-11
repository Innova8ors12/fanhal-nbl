import 'package:fan_hall/providers/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/common.dart';
import '../../../../widgets/style.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  bool private = false;
  bool location = false;
  bool invisible = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
     var user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      backgroundColor: backgroundColor1,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * horizontalPadding),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: size.height * 0.03),
                ///appbar
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                      child: Image.asset("assets/icons/ic_menu_close.png", scale: 2),
                    )
                  ],
                ),
                SizedBox(height: size.height * 0.05),
                ///profile details
                 Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.06),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child: SizedBox(
                          height: size.height * 0.07,
                          width: size.width * 0.15,
                          child: Image.network(
                            user.img!,
                            scale: 2,
                            fit: BoxFit.fill,
                          )),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: VariableText(
                                text: user.name!.toUpperCase(),
                                fontcolor: primaryColorW,
                                fontsize: size.height * 0.022,
                                fontFamily: fontBold,
                                max_lines: 1,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: VariableText(
                                text:
                                    "Member since:${user.joiningDate} ${user.city},${user.nationality}",
                                fontcolor: primaryColorW,
                                fontsize: size.height * 0.014,
                                fontFamily: fontRegular,
                                max_lines: 2,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
                SizedBox(height: size.height * 0.04),
                Row(
                  children: [
                    Expanded(
                      child: VariableText(
                        text: "Account Privacy",
                        fontcolor: primaryColorW,
                        fontsize: size.height * 0.018,
                        fontFamily: fontBold,
                        max_lines: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    VariableText(
                      text: "Private account",
                      fontFamily: fontRegular,
                      fontsize: size.height * 0.016,
                      fontcolor: textColorW,
                      textAlign: TextAlign.left,
                    ),
                    FlutterSwitch(
                      width: size.width * 0.13,
                      height: size.height * 0.032,
                      valueFontSize: size.height * 0.015,
                      toggleSize: size.height * 0.025,
                      value: private,
                      borderRadius: 30.0,
                      showOnOff: false,
                      activeColor: Theme.of(context).primaryColor,
                      inactiveColor: textColor2,
                      onToggle: (val) {
                        setState(() {
                          private = val;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    VariableText(
                      text: "Location Tracking",
                      fontFamily: fontRegular,
                      fontsize: size.height * 0.016,
                      fontcolor: textColorW,
                      textAlign: TextAlign.left,
                    ),
                    FlutterSwitch(
                      width: size.width * 0.13,
                      height: size.height * 0.032,
                      valueFontSize: size.height * 0.015,
                      toggleSize: size.height * 0.025,
                      value: location,
                      borderRadius: 30.0,
                      showOnOff: false,
                      activeColor: Theme.of(context).primaryColor,
                      inactiveColor: textColor2,
                      onToggle: (val) {
                        setState(() {
                          location = val;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    VariableText(
                      text: "Invisible Mode",
                      fontFamily: fontRegular,
                      fontsize: size.height * 0.016,
                      fontcolor: textColorW,
                      textAlign: TextAlign.left,
                    ),
                    FlutterSwitch(
                      width: size.width * 0.13,
                      height: size.height * 0.032,
                      valueFontSize: size.height * 0.015,
                      toggleSize: size.height * 0.025,
                      value: invisible,
                      borderRadius: 30.0,
                      showOnOff: false,
                      activeColor: Theme.of(context).primaryColor,
                      inactiveColor: textColor2,
                      onToggle: (val) {
                        setState(() {
                          invisible = val;
                        });
                      },
                    ),
                  ],
                ),
                Divider(color: textColor2, thickness: 4, height: size.height * 0.05),
                Row(
                  children: [
                    Expanded(
                      child: VariableText(
                        text: "Interactions",
                        fontcolor: primaryColorW,
                        fontsize: size.height * 0.018,
                        fontFamily: fontBold,
                        max_lines: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: VariableText(
                        text: "Mentions",
                        fontFamily: fontRegular,
                        fontsize: size.height * 0.016,
                        fontcolor: textColorW,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    VariableText(
                      text: "Everyone",
                      fontFamily: fontRegular,
                      fontsize: size.height * 0.012,
                      fontcolor: textColor4,
                    ),
                    SizedBox(width: size.width * 0.02),
                    Icon(Icons.arrow_forward_ios_rounded, size: size.height * 0.02, color: primaryColorW)
                  ],
                ),
                SizedBox(height: size.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: VariableText(
                        text: "Blocked accounts",
                        fontFamily: fontRegular,
                        fontsize: size.height * 0.016,
                        fontcolor: textColorW,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios_rounded, size: size.height * 0.02, color: primaryColorW)
                  ],
                ),
                SizedBox(height: size.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: VariableText(
                        text: "Muted Accounts",
                        fontFamily: fontRegular,
                        fontsize: size.height * 0.016,
                        fontcolor: textColorW,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios_rounded, size: size.height * 0.02, color: primaryColorW)
                  ],
                ),
                SizedBox(height: size.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: VariableText(
                        text: "Accounts you follow",
                        fontFamily: fontRegular,
                        fontsize: size.height * 0.016,
                        fontcolor: textColorW,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios_rounded, size: size.height * 0.02, color: primaryColorW)
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
