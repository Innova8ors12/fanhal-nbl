import 'package:cached_network_image/cached_network_image.dart';
import 'package:fan_hall/controller/auth/league_api.dart';
import 'package:fan_hall/models/certt_team.dart';
import 'package:fan_hall/models/teams_model1.dart';
import 'package:fan_hall/screens/dashboard/certificates/buy_certificate/2_4_1_select_category.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/common.dart';
import '../../../../widgets/style.dart';
import '3_certificate_type.dart';

class BuyPickCategory extends StatefulWidget {
  String teamid1;
  BuyPickCategory({Key? key,required this.teamid1}) : super(key: key);

  @override
  State<BuyPickCategory> createState() => _BuyPickCategoryState();
}
 
class _BuyPickCategoryState extends State<BuyPickCategory> {
  String? timg="";
  String? tname="";
 bool isLoading = false;
  setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }
getTeamData() async {
  setLoading(true);
    var res = await ApiModel().getteamData(widget.teamid1);
  
    if (res != null && res['status']) {
      CertTeams? teamData;
      teamData = CertTeams.fromJson(res['data']);
      tname=teamData.nickName.toString();
      timg=teamData.img!.toString();

      // print(leagueModel);
       
      setState(() {});
    }
    setLoading(false);
  }
@override
  void initState() {
    // TODO: implement initState

    getTeamData();
    super.initState();
  }
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
                 isLoading?CircularProgressIndicator(
                  color:Theme.of(context).primaryColor
                 ):Image.network(timg!.toString(),scale: 5,),
                 
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
                            textAlign: TextAlign.center
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: size.height * 0.02),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: VariableText(
                              text: "If you choose WallArt Certificate you will get a digital version for FREE.",
                              fontcolor: primaryColorW,
                              fontsize: size.height * 0.016,
                              fontFamily: fontRegular,
                              max_lines: 4,
                              textAlign: TextAlign.center
                          ),
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
                    btnTxt: tname.toString(),
                    fontSize: size.height * 0.018,
                    fontFamily: fontSemiBold,
                    weight: FontWeight.w500,
                    txtColor: textColor1,
                    onTap: (){
                      Navigator.push(
                          context,
                          SwipeLeftAnimationRoute(widget: CertificateTypeScreen(CertificateId:widget.teamid1,))
                      );
                    },
                  ),
                  SizedBox(height: size.height * 0.02),
                  MyButtonPostfixIcon(
                    btnHeight: size.height * 0.055,
                    btnWidth: size.width * 0.60,
                    btnColor: primaryColorW,
                    borderColor: primaryColorW,
                    btnRadius: 200,
                    btnTxt: "Heroes",
                    icon: "assets/icons/ic_dropdown.png",
                    iconColor: primaryColorB,
                    fontSize: size.height * 0.018,
                    fontFamily: fontSemiBold,
                    weight: FontWeight.w500,
                    txtColor: textColor1,
                    onTap: (){
                      Navigator.push(
                          context,
                          SwipeLeftAnimationRoute(widget: CertificateTypeScreen(CertificateId: "1",))
                      );
                    },
                  ),
                  SizedBox(height: size.height * 0.02),
                  MyButton(
                    btnHeight: size.height * 0.055,
                    btnWidth: size.width * 0.60,
                    btnColor: primaryColorW,
                    borderColor: primaryColorW,
                    btnRadius: 200,
                    btnTxt: "Legends",
                    fontSize: size.height * 0.018,
                    fontFamily: fontSemiBold,
                    weight: FontWeight.w500,
                    txtColor: textColor1,
                    onTap: (){
                      Navigator.push(
                          context,
                          SwipeLeftAnimationRoute(widget: CertificateTypeScreen(CertificateId:"1",))
                      );
                    },
                  ),
                  SizedBox(height: size.height * 0.02),
                   MyButton(
                    btnHeight: size.height * 0.055,
                    btnWidth: size.width * 0.60,
                    btnColor: primaryColorW,
                    borderColor: primaryColorW,
                    btnRadius: 200,
                    btnTxt: "Go NFL",
                    fontSize: size.height * 0.018,
                    fontFamily: fontSemiBold,
                    weight: FontWeight.w500,
                    txtColor: textColor1,
                    onTap: () {
                      Navigator.push(context,
                          SwipeLeftAnimationRoute(widget: SelectCategory()));
                    },
                  ),
                  // MyButton(
                  //   btnHeight: size.height * 0.055,
                  //   btnWidth: size.width * 0.60,
                  //   btnColor: primaryColorW,
                  //   borderColor: primaryColorW,
                  //   btnRadius: 200,
                  //   btnTxt: "Special Events",
                  //   fontSize: size.height * 0.018,
                  //   fontFamily: fontSemiBold,
                  //   weight: FontWeight.w500,
                  //   txtColor: textColor1,
                  //   onTap: (){
                  //     Navigator.push(
                  //         context,
                  //         SwipeLeftAnimationRoute(widget: CertificateTypeScreen(CertificateId: "1",))
                  //     );
                  //   },
                  // ),
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
