import 'package:flutter/material.dart';

import '../../../widgets/common.dart';
import '../../../widgets/style.dart';

class DraftSuccessScreen extends StatelessWidget {
  const DraftSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backgroundColor1,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.02),
            ///appbar
            MenuAppbar(),
            //SizedBox(height: size.height * 0.10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(size.height * 0.03),
                    decoration: BoxDecoration(
                        color: primaryColorB,
                        borderRadius: BorderRadius.circular(200)
                    ),
                    child: Image.asset("assets/icons/ic_buy_success.png", scale: 2),
                  ),
                  SizedBox(height: size.height * 0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: VariableText(
                            text: "FIELD GOAL!",
                            fontcolor: Theme.of(context).primaryColor,
                            fontsize: size.height * 0.024,
                            fontFamily: fontSemiBold,
                            max_lines: 1,
                            textAlign: TextAlign.center
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: size.height * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: VariableText(
                            text: "Your subscription is complete",
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
                    btnColor: Theme.of(context).primaryColor,
                    borderColor: Theme.of(context).primaryColor,
                    btnRadius: 200,
                    btnTxt: "Enter Draft",
                    fontSize: size.height * 0.018,
                    fontFamily: fontSemiBold,
                    weight: FontWeight.w500,
                    txtColor: Theme.of(context).iconTheme.color,
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
