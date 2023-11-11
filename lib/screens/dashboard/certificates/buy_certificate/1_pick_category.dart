import 'package:fan_hall/controller/auth/league_api.dart';
import 'package:fan_hall/models/get_nick.dart';
import 'package:fan_hall/providers/userProvider.dart';
import 'package:fan_hall/screens/dashboard/certificates/buy_certificate/3_certificate_type.dart';
import 'package:fan_hall/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/common.dart';
import '../../../../widgets/style.dart';
import '2_1_select_team.dart';
import '2_2_select_hero.dart';
import '2_3_select_moments.dart';
import '2_4_1_select_category.dart';

class PickCertificateCategory extends StatefulWidget {
  const PickCertificateCategory({Key? key}) : super(key: key);

  @override
  State<PickCertificateCategory> createState() =>
      _PickCertificateCategoryState();
}

class _PickCertificateCategoryState extends State<PickCertificateCategory> {
  //  getNick() async {
  //   var res = await ApiModel().getTeamNick();
  //    herostype?_ herostype;
  //   // print(res);
  //    herostypeTeams.clear();
  //   IdTeams.clear();
  //   if (res != null && res['status']) {
  //     for (var item in res['data']) {
  //       _ herostype =  herostype.fromJson(item);
  //        herostypeTeams.add(_ herostype);
  //        IdTeams.add(_ herostype. herostype!.toString());
  //     }
  //     print(nationalities1);
  //     // nationalId = leagueModel!.data![1]!.id.toString();
  //     setState(() {});
  //   }
  // }
  void initState() {
//  getNick();
    // TODO: implement initState
    super.initState();
  }

  List<String> IdTeams = [];

  String? herostypeName;
  List<String> herosType = ["Active Players", "Legends Players"];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
 var user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
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
                  SizedBox(
                                    height: size.height * 0.15,
                                    child: teamImage == null
                                        ? Image.network( user.team!.img!,
                                            height: size.height)
                                        : Image.network( teamImage.toString(),
                                            height: size.height)
                                  ),
                  SizedBox(height: size.height * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: VariableText(
                            text: "Now pick a category!",
                            fontcolor: primaryColorW,
                            fontsize: size.height * 0.024,
                            fontFamily: fontSemiBold,
                            max_lines: 1,
                            textAlign: TextAlign.center),
                      )
                    ],
                  ),
                  SizedBox(height: size.height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: VariableText(
                            text: "Select an option to continue.",
                            fontcolor: primaryColorW,
                            fontsize: size.height * 0.016,
                            fontFamily: fontRegular,
                            max_lines: 1,
                            textAlign: TextAlign.center),
                      )
                    ],
                  ),
                  SizedBox(height: size.height * 0.06),

                  MyButton(
                    btnHeight: size.height * 0.055,
                    btnWidth: size.width * 0.60,
                    btnColor: primaryColorW,
                    borderColor: primaryColorW,
                    btnRadius: 200,
                    btnTxt: nickName.toString(),
                    fontSize: size.height * 0.018,
                    fontFamily: fontSemiBold,
                    weight: FontWeight.w500,
                    txtColor: textColor1,
                    onTap: () {
                      setState(() {
                        selectedHero = null;
                        selectedmomentId = null;
                      });
                      Navigator.push(
                          context,
                            SwipeLeftAnimationRoute(widget: CertificateTypeScreen(CertificateId:teamId.toString(),))  
                          );

                      // Navigator.push(
                      //     context,
                      //     SwipeLeftAnimationRoute(
                      //         widget: SelectTeamScreen(
                      //       id: teamId.toString(),
                      //     )));
                    },
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
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Image.asset(
                                        'assets/icons/ic_dropdown.png',
                                        scale: 3),
                                  ),
                                  hint: Padding(
                                    padding: const EdgeInsets.only(left: 12),
                                    child: Center(
                                      child: VariableText(
                                        text: "Hero",
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
                                    selectedmomentId=null;
                                    herostype = null;
                                    if (herostype == null) {
                                      setState(() {
                                        herostype = value;
                                        // selectedHero=herosType.toString();
                                      
                                      });
                                    } else {
                                      herostype = null;
                                    }
                                      if (herostype=="Active Players") {
                                          Navigator.push(
                                              context,
                                              SwipeLeftAnimationRoute(
                                                  widget: SelectHeroScreen(
                                                      Htype:"Active")));
                                        } else {
                                           Navigator.push(
                                              context,
                                              SwipeLeftAnimationRoute(
                                                  widget: SelectHeroScreen(
                                                      Htype: "Legend")));
                                        }
                                  },
                                  style: TextStyle(
                                      fontSize: size.height * 0.017,
                                      color: textColorW),
                                  items: herosType
                                      .map<DropdownMenuItem<String>>(
                                          (String item) {
                                    return DropdownMenuItem<String>(
                                      value: item,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
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
                  // MyButtonPostfixIcon(
                  //   btnHeight: size.height * 0.055,
                  //   btnWidth: size.width * 0.60,
                  //   btnColor: primaryColorW,
                  //   borderColor: primaryColorW,
                  //   btnRadius: 200,
                  //   btnTxt: "Heroes",
                  //   icon: "assets/icons/ic_dropdown.png",
                  //   iconColor: primaryColorB,
                  //   fontSize: size.height * 0.018,
                  //   fontFamily: fontSemiBold,
                  //   weight: FontWeight.w500,
                  //   txtColor: textColor1,
                  //   onTap: (){

                  //     Navigator.push(
                  //         context,
                  //         SwipeLeftAnimationRoute(widget: SelectHeroScreen()));
                  //   },
                  // ),
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
                    onTap: () {
                      selectedHero=null;
                      Navigator.push(
                          context,
                          SwipeLeftAnimationRoute(
                              widget: SelectMomentScreen()));
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
