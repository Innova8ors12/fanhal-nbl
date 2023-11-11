import 'package:flutter/material.dart';

import '../../../../../widgets/common.dart';
import '../../../../../widgets/style.dart';

class ChangeTeamScreen extends StatelessWidget {
  const ChangeTeamScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: primaryColorB,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * horizontalPadding),
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
              //SizedBox(height: size.height * 0.20),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: VariableText(
                              text: "Are you sure you want to change your favorite team?",
                              fontcolor: primaryColorW,
                              fontsize: size.height * 0.016,
                              fontFamily: fontRegular,
                              max_lines: 5,
                              line_spacing: 1.5,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.03),
                      MyButton(
                        btnHeight: size.height * 0.06,
                        btnColor: primaryColorW,
                        borderColor: primaryColorW,
                        btnRadius: 200,
                        btnTxt: "Change",
                        fontSize: size.height * 0.016,
                        fontFamily: fontMedium,
                        weight: FontWeight.w500,
                        txtColor: textColor1,
                        onTap: (){},
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
