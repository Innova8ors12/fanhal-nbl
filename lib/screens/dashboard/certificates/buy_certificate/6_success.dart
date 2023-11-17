import 'package:fan_hall/screens/dashboard/certificates/certificates_screen.dart';
import 'package:fan_hall/screens/dashboard/profile/menu/my_orders/my_orders_screen.dart';
import 'package:fan_hall/screens/dashboard/profile/menu/my_orders/order_status_screen.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/common.dart';
import '../../../../widgets/style.dart';
import '../../main_dashboard.dart';

class SuccessScreen extends StatelessWidget {
  final String type;
  final bool isfanmatch;
  const SuccessScreen({Key? key, required this.type, required this.isfanmatch})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        backgroundColor: backgroundColor1,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.02),

              ///appbar
              MenuAppbar(allowBack: false),
              //SizedBox(height: size.height * 0.10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(size.height * 0.03),
                      decoration: BoxDecoration(
                          color: primaryColorB,
                          borderRadius: BorderRadius.circular(200)),
                      child: Image.asset("assets/icons/ic_buy_success.png",
                          scale: 2),
                    ),
                    SizedBox(height: size.height * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: VariableText(
                              text: "TOUCHDOWN!",
                              fontcolor: Theme.of(context).primaryColor,
                              fontsize: size.height * 0.024,
                              fontFamily: fontSemiBold,
                              max_lines: 1,
                              textAlign: TextAlign.center),
                        )
                      ],
                    ),
                    SizedBox(height: size.height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: VariableText(
                              text: "Your purchase was successful.",
                              fontcolor: primaryColorW,
                              fontsize: size.height * 0.016,
                              fontFamily: fontRegular,
                              max_lines: 1,
                              textAlign: TextAlign.center),
                        )
                      ],
                    ),
                    SizedBox(height: size.height * 0.04),
                    MyButton(
                      btnHeight: size.height * 0.055,
                      btnWidth: size.width * 0.60,
                      btnColor: primaryColorW,
                      borderColor: primaryColorW,
                      btnRadius: 200,
                      btnTxt: "View my Certificates",
                      fontSize: size.height * 0.018,
                      fontFamily: fontSemiBold,
                      weight: FontWeight.w500,
                      txtColor: textColor1,
                      onTap: () {
                        if (isfanmatch) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              SwipeLeftAnimationRoute(
                                  widget: MainDashboard(isfanmatch: true)),
                              (route) => route.isCurrent);
                        } else {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          Navigator.of(context).pop(true);
                        }
                      },
                    ),
                    SizedBox(height: size.height * 0.02),
                    !isfanmatch
                        ? type == "Digital"
                            ? MyButton(
                                btnHeight: size.height * 0.055,
                                btnWidth: size.width * 0.60,
                                btnColor: Theme.of(context).primaryColor,
                                borderColor: Theme.of(context).primaryColor,
                                btnRadius: 200,
                                btnTxt: "Send as a Pic",
                                fontSize: size.height * 0.018,
                                fontFamily: fontSemiBold,
                                weight: FontWeight.w500,
                                txtColor: Theme.of(context).iconTheme.color,
                                onTap: () {
                                  if (!isfanmatch) {
                                    Navigator.of(context).pop();
                                  }
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop(true);
                                  // Navigator.push(
                                  //     context,
                                  //     SwipeLeftAnimationRoute(
                                  //         widget: MyOrdersScreen()));
                                },
                              )
                            : MyButton(
                                btnHeight: size.height * 0.055,
                                btnWidth: size.width * 0.60,
                                btnColor: Theme.of(context).primaryColor,
                                borderColor: Theme.of(context).primaryColor,
                                btnRadius: 200,
                                btnTxt: "View Status Order",
                                fontSize: size.height * 0.018,
                                fontFamily: fontSemiBold,
                                weight: FontWeight.w500,
                                txtColor: Theme.of(context).iconTheme.color,
                                onTap: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop(true);
                                  Navigator.push(
                                      context,
                                      SwipeLeftAnimationRoute(
                                          widget: MyOrdersScreen()));
                                },
                              )
                        : SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
