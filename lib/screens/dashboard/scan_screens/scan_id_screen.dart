import 'package:fan_hall/controller/auth/league_api.dart';
import 'package:fan_hall/screens/dashboard/social/social_home.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../widgets/common.dart';
import '../../../widgets/style.dart';

class QrScanScreen extends StatefulWidget {
  bool registered;
  QrScanScreen({Key? key, this.registered=true}) : super(key: key);

  @override
  State<QrScanScreen> createState() => _QrScanScreenState();
}

class _QrScanScreenState extends State<QrScanScreen> {

 bool isLoading = false;
 setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

 GetCertificate(String scanid) async {

    setLoading(true);
    var res =
        await ApiModel().getScanCertificate(scanid.toString());

    // print(res);

    if (res != null && res['status']) {
    
      setLoading(false);
      Navigator.push(
                        context,
                        SwipeLeftAnimationRoute(widget: SocialHomeScreen()));
    } else {
      setLoading(false);
      Fluttertoast.showToast(
          msg:res['msg'],
          toastLength: Toast.LENGTH_SHORT);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backgroundColor1,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.02),
            ///appbar
            MenuAppbar(allowBack: true),
            SizedBox(height: size.height * 0.04),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: VariableText(
                      text: "Scan a QR Fanhall ID",
                      fontcolor: primaryColorW,
                      fontsize: size.height * 0.024,
                      fontFamily: fontSemiBold,
                      max_lines: 1,
                      textAlign: TextAlign.center
                  ),
                )
              ],
            ),
            SizedBox(height: size.height * 0.02),
            Container(
              height: size.height * 0.40,
                width: size.width ,
              color: Color(0xffD9D9D9),
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: VariableText(
                            text: "Open Cellphone Camera to Scan QR Code",
                            fontcolor: textColor2,
                            fontsize: size.height * 0.024,
                            fontFamily: fontMedium,
                            max_lines: 4,
                            textAlign: TextAlign.center
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.20),
              child: MyRoundTextField(
                text: "Enter Fanhall ID",
                filled: true,
                filledColor: primaryColorW,
                fontColor: textColor1,
                hintColor: textColor2,
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.20),
              child: MyButton(
                btnHeight: size.height * 0.055,
                btnColor: Color(0xFF555555),
                borderColor: Color(0xFF555555),
                btnRadius: 200,
                btnTxt: "Validate",
                fontSize: size.height * 0.018,
                fontFamily: fontSemiBold,
                weight: FontWeight.w500,
                txtColor: textColorW,
                onTap: (){},
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Image.asset("assets/images/fanhall_logo.png", scale: 2),
            SizedBox(height: size.height * 0.02),
            if(!widget.registered)
              Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.20),
              child: MyButton(
                btnHeight: size.height * 0.055,
                btnColor: Theme.of(context).primaryColor,
                borderColor: Theme.of(context).primaryColor,
                btnRadius: 200,
                btnTxt: "Register Now",
                fontSize: size.height * 0.018,
                fontFamily: fontSemiBold,
                weight: FontWeight.w500,
                txtColor: Theme.of(context).iconTheme.color,
                onTap: (){},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
