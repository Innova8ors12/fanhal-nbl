import 'package:fan_hall/providers/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/common.dart';
import '../../../../widgets/style.dart';

class ManageDraftScreen extends StatefulWidget {
  const ManageDraftScreen({Key? key}) : super(key: key);

  @override
  State<ManageDraftScreen> createState() => _ManageDraftScreenState();
}

class _ManageDraftScreenState extends State<ManageDraftScreen> {
  bool showSubScreen = false;
  String selectedType = "draft";

  bool check = false;

  getSubScreen(String type){
    switch(type){
      case "draft":
        {
          return renderDraftSub();
        }
      case "renew":
        {
          return renderRenewSub();
        }
      case "manage":
        {
          return renderManageSub();
        }
      default:
        {
          return renderDraftSub();
        }
    }
  }


  renderDraftSub(){
    var size = MediaQuery.of(context).size;
    var user = Provider.of<UserProvider>(context).user;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: VariableText(
                text: "Save up to USD \$9.80 by selecting the All-Year Fan Draft membership.",
                fontcolor: primaryColorW,
                fontsize: size.height * 0.014,
                fontFamily: fontRegular,
                max_lines: 5,
                line_spacing: 1.5,
              ),
            ),
          ],
        ),
        SizedBox(height: size.height * 0.03),
        Container(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.07, vertical: size.height * 0.02),
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor, width: 4)
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: VariableText(
                            text: "Fan Draft",
                            fontcolor: primaryColorW,
                            fontsize: size.height * 0.014,
                            fontFamily: fontRegular,
                            max_lines: 1,
                            line_spacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: VariableText(
                            text: "Monthly USD \$4.90",
                            fontcolor: primaryColorW,
                            fontsize: size.height * 0.016,
                            fontFamily: fontMedium,
                            max_lines: 1,
                            line_spacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.005),
                    Row(
                      children: [
                        Expanded(
                          child: VariableText(
                            text: "Current membership",
                            fontcolor: primaryColorW,
                            fontsize: size.height * 0.014,
                            fontFamily: fontRegular,
                            max_lines: 1
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(height: size.height * 0.02),
        Container(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.07, vertical: size.height * 0.02),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              border: Border.all(color: Theme.of(context).primaryColor, width: 4)
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: VariableText(
                            text: "All-Year Fan Draft",
                            fontcolor: textColor1,
                            fontsize: size.height * 0.014,
                            fontFamily: fontSemiBold,
                            max_lines: 1,
                            line_spacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: VariableText(
                            text: "Annually USD \$49.00/year",
                            fontcolor: textColor1,
                            fontsize: size.height * 0.016,
                            fontFamily: fontMedium,
                            max_lines: 1,
                            line_spacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.005),
                    Row(
                      children: [
                        Expanded(
                          child: VariableText(
                              text: "Save US \$9.80 with this membership",
                              fontcolor: textColor1,
                              fontsize: size.height * 0.014,
                              fontFamily: fontRegular,
                              max_lines: 1
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
  renderRenewSub(){
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: VariableText(
                          text: "Last payment",
                          fontcolor: primaryColorW,
                          fontsize: size.height * 0.014,
                          fontFamily: fontMedium,
                          max_lines: 1,
                          line_spacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: VariableText(
                          text: "November 14th 2023",
                          fontcolor: primaryColorW,
                          fontsize: size.height * 0.016,
                          fontFamily: fontMedium,
                          max_lines: 1,
                          line_spacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.005),
                  Row(
                    children: [
                      Expanded(
                        child: VariableText(
                          text: "See invoices",
                          fontcolor: primaryColorW,
                          fontsize: size.height * 0.014,
                          fontFamily: fontRegular,
                          max_lines: 1,
                          underlined: true,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Divider(color: primaryColorB, thickness: 4, height: size.height * 0.05),
        Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: VariableText(
                          text: "Preferred payment method",
                          fontcolor: primaryColorW,
                          fontsize: size.height * 0.014,
                          fontFamily: fontMedium,
                          max_lines: 1,
                          line_spacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: VariableText(
                          text: "Mastercard ****0000",
                          fontcolor: primaryColorW,
                          fontsize: size.height * 0.016,
                          fontFamily: fontMedium,
                          max_lines: 1,
                          line_spacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.005),
                  Row(
                    children: [
                      Expanded(
                        child: VariableText(
                          text: "Edit my payment method",
                          fontcolor: primaryColorW,
                          fontsize: size.height * 0.014,
                          fontFamily: fontRegular,
                          max_lines: 1,
                          underlined: true,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Divider(color: primaryColorB, thickness: 4, height: size.height * 0.05),
      ],
    );
  }
  renderManageSub(){
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: VariableText(
                text: "Remind me before renewing",
                fontcolor: primaryColorW,
                fontsize: size.height * 0.016,
                fontFamily: fontSemiBold,
                max_lines: 2
              ),
            ),
          ],
        ),
        SizedBox(height: size.height * 0.02),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox(
              activeColor: Theme.of(context).primaryColor,
              visualDensity: VisualDensity.compact,
              value: check,
              onChanged: (v){
                setState(() {
                  check = v!;
                });
              },
            ),
            Expanded(
              child: VariableText(
                  text: "Send me an reminder on december 11th, 3 days before my renewal date.",
                  fontcolor: primaryColorW,
                  fontsize: size.height * 0.014,
                  fontFamily: fontMedium,
                  max_lines: 3,
                  line_spacing: 1.8,
              ),
            ),
          ],
        ),
        Divider(color: primaryColorB, thickness: 4, height: size.height * 0.05),
        Row(
          children: [
            Expanded(
              child: VariableText(
                  text: "Cancel membership",
                  fontcolor: primaryColorW,
                  fontsize: size.height * 0.016,
                  fontFamily: fontSemiBold,
                  max_lines: 2
              ),
            ),
          ],
        ),
        SizedBox(height: size.height * 0.01),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: VariableText(
                  text: "By canceling your membership you will loose access to all your Fan Draft benefits.",
                  fontcolor: primaryColorW,
                  fontsize: size.height * 0.014,
                  fontFamily: fontMedium,
                  max_lines: 5,
                  line_spacing: 1.5,
              ),
            ),
          ],
        ),
        SizedBox(height: size.height * 0.02),
        MyButton(
          btnHeight: size.height * 0.055,
          btnColor: Color(0xFFA5A5A5),
          borderColor: Color(0xFFA5A5A5),
          btnRadius: 200,
          btnTxt: "Cancel membership and benefits",
          fontSize: size.height * 0.014,
          fontFamily: fontBold,
          weight: FontWeight.w600,
          txtColor: textColor1,
          onTap: (){},
        ),
      ],
    );
  }

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
                MyButton(
                  btnHeight: size.height * 0.06,
                  btnColor: Color(0xFF444444),
                  borderColor: Color(0xFF444444),
                  btnRadius: 10,
                  btnTxt: showSubScreen ? "Back" : "Manager Subscription",
                  fontSize: size.height * 0.014,
                  fontFamily: fontMedium,
                  weight: FontWeight.w500,
                  txtColor: textColorW,
                  onTap: (){
                    setState(() {
                      showSubScreen = false;
                    });
                  },
                ),
                Divider(color: textColor2, thickness: 4, height: size.height * 0.05),
                showSubScreen ?
                    getSubScreen(selectedType) :
                ///MainScreen
                Column(
                  children: [
                    ///draft
                    InkWell(
                      onTap: (){
                        setState(() {
                          selectedType = "draft";
                          showSubScreen = true;
                        });
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: VariableText(
                                        text: "Fan Draft",
                                        fontcolor: primaryColorW,
                                        fontsize: size.height * 0.014,
                                        fontFamily: fontRegular,
                                        max_lines: 1,
                                        line_spacing: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: VariableText(
                                        text: "Monthly USD \$4.90",
                                        fontcolor: primaryColorW,
                                        fontsize: size.height * 0.016,
                                        fontFamily: fontMedium,
                                        max_lines: 1,
                                        line_spacing: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: size.height * 0.005),
                                Row(
                                  children: [
                                    Expanded(
                                      child: VariableText(
                                        text: "See more plans",
                                        fontcolor: primaryColorW,
                                        fontsize: size.height * 0.014,
                                        fontFamily: fontRegular,
                                        max_lines: 1,
                                        underlined: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios_rounded, size: size.height * 0.022, color: primaryColorW)
                        ],
                      ),
                    ),
                    Divider(color: textColor2, thickness: 4, height: size.height * 0.05),
                    ///renew
                    InkWell(
                      onTap: (){
                        setState(() {
                          selectedType = "renew";
                          showSubScreen = true;
                        });
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: VariableText(
                                        text: "Renewal Date",
                                        fontcolor: primaryColorW,
                                        fontsize: size.height * 0.014,
                                        fontFamily: fontRegular,
                                        max_lines: 1,
                                        line_spacing: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: VariableText(
                                        text: "December 14th, 2023",
                                        fontcolor: primaryColorW,
                                        fontsize: size.height * 0.016,
                                        fontFamily: fontMedium,
                                        max_lines: 1,
                                        line_spacing: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: size.height * 0.005),
                                Row(
                                  children: [
                                    Expanded(
                                      child: VariableText(
                                        text: "Billing and Payment Methods",
                                        fontcolor: primaryColorW,
                                        fontsize: size.height * 0.014,
                                        fontFamily: fontRegular,
                                        max_lines: 1,
                                        underlined: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios_rounded, size: size.height * 0.022, color: primaryColorW)
                        ],
                      ),
                    ),
                    Divider(color: textColor2, thickness: 4, height: size.height * 0.05),
                    ///manage
                    InkWell(
                      onTap: (){
                        setState(() {
                          selectedType = "manage";
                          showSubScreen = true;
                        });
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: VariableText(
                                        text: "Manage",
                                        fontcolor: primaryColorW,
                                        fontsize: size.height * 0.014,
                                        fontFamily: fontRegular,
                                        max_lines: 1,
                                        line_spacing: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: VariableText(
                                        text: "Membership",
                                        fontcolor: primaryColorW,
                                        fontsize: size.height * 0.016,
                                        fontFamily: fontMedium,
                                        max_lines: 1,
                                        line_spacing: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: size.height * 0.005),
                                Row(
                                  children: [
                                    Expanded(
                                      child: VariableText(
                                        text: "Remind me or Cancel",
                                        fontcolor: primaryColorW,
                                        fontsize: size.height * 0.014,
                                        fontFamily: fontRegular,
                                        max_lines: 1,
                                        underlined: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios_rounded, size: size.height * 0.022, color: primaryColorW)
                        ],
                      ),
                    ),
                    Divider(color: textColor2, thickness: 4, height: size.height * 0.05),
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
