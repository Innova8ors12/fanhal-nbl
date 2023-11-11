import 'package:flutter/material.dart';

import '../../../../widgets/common.dart';
import '../../../../widgets/style.dart';
import '2_1_select_team.dart';
import '2_3_select_moments.dart';
import '2_4_2_select_league.dart';

class SelectCategory extends StatelessWidget {
  const SelectCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backgroundColor1,
      body: SafeArea(
        child: Column(
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
                  Image.asset("assets/icons/ic_header_nfl.png", scale: 2),
                  SizedBox(height: size.height * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: VariableText(
                            text: "Select a option",
                            fontcolor: primaryColorW,
                            fontsize: size.height * 0.016,
                            fontFamily: fontRegular,
                            max_lines: 1,
                            textAlign: TextAlign.center
                        ),
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
                    btnTxt: "Hall of fame",
                    fontSize: size.height * 0.018,
                    fontFamily: fontSemiBold,
                    weight: FontWeight.w500,
                    txtColor: textColor1,
                    onTap: (){
                      Navigator.push(
                          context,
                          SwipeLeftAnimationRoute(widget: SelectTeamScreen(id: "1",
                          isfame: true,
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
                    btnTxt: "Super Bowl",
                    fontSize: size.height * 0.018,
                    fontFamily: fontSemiBold,
                    weight: FontWeight.w500,
                    txtColor: textColor1,
                    onTap: (){
                      Navigator.push(
                          context,
                          SwipeLeftAnimationRoute(widget: SelectMomentScreen()));
                    },
                  ),
                  SizedBox(height: size.height * 0.02),
                  MyButton(
                    btnHeight: size.height * 0.055,
                    btnWidth: size.width * 0.60,
                    btnColor: primaryColorW,
                    borderColor: primaryColorW,
                    btnRadius: 200,
                    btnTxt: "Awesome Moments",
                    fontSize: size.height * 0.018,
                    fontFamily: fontSemiBold,
                    weight: FontWeight.w500,
                    txtColor: textColor1,
                    onTap: (){
                      Navigator.push(
                          context,
                          SwipeLeftAnimationRoute(widget: SelectMomentScreen()));
                    },
                  ),
                  SizedBox(height: size.height * 0.02),
                  MyButton(
                    btnHeight: size.height * 0.055,
                    btnWidth: size.width * 0.60,
                    btnColor: primaryColorW,
                    borderColor: primaryColorW,
                    btnRadius: 200,
                    btnTxt: "Teams",
                    fontSize: size.height * 0.018,
                    fontFamily: fontSemiBold,
                    weight: FontWeight.w500,
                    txtColor: textColor1,
                    onTap: (){
                      Navigator.push(
                          context,
                          SwipeLeftAnimationRoute(widget: SelectLeague()));
                    },
                  ),
                  SizedBox(height: size.height * 0.08),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
