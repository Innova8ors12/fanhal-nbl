import 'package:fan_hall/controller/auth/league_api.dart';
import 'package:fan_hall/models/teams_model1.dart';
import 'package:fan_hall/models/user_model.dart';
import 'package:fan_hall/providers/league_provider.dart';
import 'package:fan_hall/screens/dashboard/certificates/buy_certificate/1_pick_category.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/common.dart';
import '../../../../widgets/constants.dart';
import '../../../../widgets/style.dart';
import '2_4_4_pick_category.dart';

class BuySelectTeam extends StatefulWidget {
  final String id;
  final String img;
  const BuySelectTeam({Key? key , required this.id, required this.img}) : super(key: key);

  @override
  State<BuySelectTeam> createState() => _BuySelectTeamState();
}

class _BuySelectTeamState extends State<BuySelectTeam> {
  List<TeamsModel> list = [];

  bool isLoading = true;
  int selectedTeam = -1;

  onTeamSelect(int value) {
    setState(() {
      selectedTeam = value;
    });
  }

  setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

  int selectedRegionIndex = 0;

  onRegionSelect(int index) {
    setState(() {
      selectedRegionIndex = index;
    });
  }

  getTeam() async {
    var response = await ApiModel().getTeam(widget.id);
    if (response != null && response['status']) {
      for (var item in response["data"]) {

        list.add(TeamsModel.fromJson(item));
      }
      Provider.of<LeagueProvider>(context, listen: false).setLeagueTeams(list);
      setLoading(false);
      //  else {
      //   setLoading(false);
      //   Fluttertoast.showToast(
      //       msg: response['msg'], toastLength: Toast.LENGTH_SHORT);
      // }
    } else {
      setLoading(false);
      Fluttertoast.showToast(
          msg: response.toString(), toastLength: Toast.LENGTH_SHORT);
    }
    setState(() {});
  }

  // getAllteams() async {
  //   var res = await ApiModel().getTeam(widget.id);
  //   if (res['data']['name'] == "AFC SOUTH") {
  //     teams.add(res['data']['name']);
  //     setState(() {});
  //   }
  // }

  @override
  void initState() {
    // getAllteams();
    // Provider.of<LeagueProvider>(context).allTeamsList.clear();
    getTeam();

    super.initState();
  }

  getTeamData() async {
    var res = await ApiModel().getTeam(widget.id);
    if (res != null && res['status']) {
      teamModel = TeamsModel.fromJson(res);
      // print(leagueModel);

      setState(() {});
    }
  }

  TeamsModel? teamModel;
  String? teamIdcert;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    List<Teams> event;
    if (selectedRegionIndex == 0) {
      // event = Provider.of<LeagueProvider>(context).allTeamsList;
    } else if (selectedRegionIndex == 1) {
      event = Provider.of<LeagueProvider>(context).AFC_East;
    } else if (selectedRegionIndex == 2) {
      event = Provider.of<LeagueProvider>(context).AFC_West;
    } else if (selectedRegionIndex == 3) {
      event = Provider.of<LeagueProvider>(context).AFC_North;
    } else {
      event = Provider.of<LeagueProvider>(context).AFC_South;
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body:
          //  teamModel == null
          //     ? Center(child: CircularProgressIndicator())

          //     :
          Stack(
        children: [
          Positioned.fill(
            child: Image.asset("assets/images/welcome_background.png",
                fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: Container(
              color: const Color(0xFF000000).withOpacity(0.8),
            ),
          ),
          Positioned.fill(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: size.height * 0.15),
                    Image.asset("assets/icons/ic_logo.png", scale: 5.8),
                    SizedBox(height: size.height * 0.03),
                    Expanded(
                      child: Container(
                        color: backgroundColor1,
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.04),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: size.height * 0.015),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: VariableText(
                                    text: "Show your true colors!",
                                    fontsize: size.height * 0.026,
                                    fontcolor: textColorW,
                                    fontFamily: fontBold,
                                    weight: FontWeight.w700,
                                    textAlign: TextAlign.center,
                                    line_spacing: 1.5,
                                    max_lines: 3,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: size.height * 0.02),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                isLoading == true
                                    ? SizedBox(
                                        height: size.height * 0.05,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      )
                                    : VariableText(
                                        text: "Choose your team.",
                                        fontsize: size.height * 0.018,
                                        fontcolor: textColorW,
                                        fontFamily: fontMedium,
                                        weight: FontWeight.w500,
                                        textAlign: TextAlign.center,
                                      )
                              ],
                            ),
                            SizedBox(height: size.height * 0.02),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(5, (index) {
                                return InkWell(
                                  onTap: () {
                                    onRegionSelect(index);
                                    // print(event);
                                  },
                                  child: VariableText(
                                    text: widget.id=="1"? Constants.regionsA[index]:Constants.regionsN[index],
                                    fontsize: size.height * 0.012,
                                    fontcolor: selectedRegionIndex == index
                                        ? Theme.of(context).primaryColor
                                        : textColorW,
                                    fontFamily: fontRegular,
                                    weight: FontWeight.w400,
                                    textAlign: TextAlign.center,
                                    underlined: true,
                                  ),
                                );
                              }),
                            ),
                            SizedBox(height: size.height * 0.04),
                            // Wrap(
                            //   spacing: 10.0,
                            //   runSpacing: 10.0,
                            //   children:
                            Container(
                              height: size.height * 0.3,
                              child: Consumer<LeagueProvider>(builder:
                                  (BuildContext context, value, Widget? child) {
                                return GridView.builder(
                                  scrollDirection: Axis.vertical,
                                  physics: const ScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 150,
                                          childAspectRatio: 3 / 3,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10),
                                  itemBuilder: (context, index) {
                                    return selectedRegionIndex == 0
                                        ? InkWell(
                                            onTap: () {
                                              teamId =value.allTeamsList[index].id
                                                 ;
                                              teamImage =value.allTeamsList[index].img
                                                  .toString();
                                              onTeamSelect(index);
                                              value.allTeamSelect(index);
                                            },
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    color:value.allTeamsList[
                                                                    index]
                                                                .isSelected ==
                                                            true
                                                        ? primaryColorW
                                                            .withOpacity(0.8)
                                                        : Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            500)),

                                                // height: size.height * 0.0,
                                                width: 10,
                                                child: Image.network(
                                                value.allTeamsList[index].img
                                                      .toString(),
                                                  scale: 2,
                                                )),
                                          )
                                        : selectedRegionIndex == 1
                                            ? InkWell(
                                                onTap: () {
                                                  teamId = value
                                                      .AFC_East[index].id
                                                     ;
                                                  teamImage = value
                                                      .AFC_East[index].img
                                                      .toString();
                                                  onTeamSelect(index);
                                                  value.eastTeamSelect(index);
                                                },
                                                child: Container(
                                                    // height: size.height * 0.0,
                                                    decoration: BoxDecoration(
                                                        color: value
                                                                    .AFC_East[
                                                                        index]
                                                                    .isSelected ==
                                                                true
                                                            ? primaryColorW
                                                                .withOpacity(
                                                                    0.8)
                                                            : Colors
                                                                .transparent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(500)),
                                                    width: 50,
                                                    child: Image.network(
                                                      value.AFC_East[index].img
                                                          .toString(),
                                                      scale: 2,
                                                    )),
                                              )
                                            : selectedRegionIndex == 2
                                                ? InkWell(
                                                    onTap: () {
                                                      teamId = value
                                                          .AFC_West[index].id
                                                          ;
                                                      teamImage = value
                                                          .AFC_West[index].img
                                                          .toString();
                                                      onTeamSelect(index);
                                                      value.westTeamSelect(
                                                          index);
                                                      // value.seleceUnselect(
                                                      //     index,
                                                      //     value.AFC_West);
                                                    },
                                                    child: Container(
                                                        // height: size.height * 0.0,
                                                        decoration: BoxDecoration(
                                                            color: value
                                                                        .AFC_West[
                                                                            index]
                                                                        .isSelected ==
                                                                    true
                                                                ? primaryColorW
                                                                    .withOpacity(
                                                                        0.8)
                                                                : Colors
                                                                    .transparent,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        500)),
                                                        width: 50,
                                                        child: Image.network(
                                                          value.AFC_West[index]
                                                              .img
                                                              .toString(),
                                                          scale: 2,
                                                        )),
                                                  )
                                                : selectedRegionIndex == 3
                                                    ? InkWell(
                                                        onTap: () {
                                                          teamId = value
                                                              .AFC_North[index]
                                                              .id
                                                              ;
                                                          teamImage = value
                                                              .AFC_North[index]
                                                              .img
                                                              .toString();
                                                          onTeamSelect(index);
                                                          value.northTeamSelect(
                                                              index);
                                                          // value.seleceUnselect(
                                                          //     index,
                                                          //     value
                                                          //         .AFC_North);
                                                        },
                                                        child: Container(
                                                            height:
                                                                size.height *
                                                                    0.2,
                                                            decoration: BoxDecoration(
                                                                color: value
                                                                            .AFC_North[
                                                                                index]
                                                                            .isSelected ==
                                                                        true
                                                                    ? primaryColorW
                                                                        .withOpacity(
                                                                            0.8)
                                                                    : Colors
                                                                        .transparent,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100)),
                                                            width: 1,
                                                            child:
                                                                Image.network(
                                                              value
                                                                  .AFC_North[
                                                                      index]
                                                                  .img
                                                                  .toString(),
                                                              height:
                                                                  size.height *
                                                                      0.2,
                                                              scale: 1.5,
                                                            )),
                                                      )
                                                    : InkWell(
                                                        onTap: () {
                                                          teamId = value
                                                              .AFC_South[index]
                                                              .id
                                                            ;
                                                          teamImage = value
                                                              .AFC_South[index]
                                                              .img
                                                              .toString();
                                                          onTeamSelect(index);
                                                          value.southTeamSelect(
                                                              index);

                                                          // value.seleceUnselect(
                                                          //     index,
                                                          //     value
                                                          //         .AFC_South);
                                                        },
                                                        child: Container(
                                                            // height: size.height * 0.0,
                                                            decoration: BoxDecoration(
                                                                color: value
                                                                            .AFC_South[
                                                                                index]
                                                                            .isSelected ==
                                                                        true
                                                                    ? primaryColorW
                                                                        .withOpacity(
                                                                            0.8)
                                                                    : Colors
                                                                        .transparent,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            500)),
                                                            width: 50,
                                                            child:
                                                                Image.network(
                                                              value
                                                                  .AFC_South[
                                                                      index]
                                                                  .img
                                                                  .toString(),
                                                              scale: 2,
                                                            )),
                                                      );
                                  },
                                  itemCount: selectedRegionIndex == 0
                                      ? value.allTeamsList.length
                                      : selectedRegionIndex == 1
                                          ? value.AFC_East.length
                                          : selectedRegionIndex == 2
                                              ? value.AFC_West.length
                                              : selectedRegionIndex == 3
                                                  ? value.AFC_North.length
                                                  : value.AFC_South.length,
                                );
                              }),
                            ),

                            //  List.generate(6, (index) {
                            //   return Image.asset("assets/tempImages/ps.png",
                            //       scale: 1.5);
                            // }),
                            // )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.002,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                           
                            Expanded(
                              child: MyButtonIcon(
                                btnHeight: size.height * 0.055,
                                btnColor: primaryColorW,
                                borderColor: primaryColorW,
                                btnRadius: 200,
                                btnTxt: "Save & Continue",
                                fontSize: size.height * 0.018,
                                fontFamily: fontSemiBold,
                                weight: FontWeight.w500,
                                txtColor: textColor1,
                                onTap: () {
                                  if (selectedTeam == -1) {
                                    customToast("please select the team");
                                  } else {
                                    if (selectedTeam == teamId) {
                                      teamId = selectedTeam;
                                      teamImage1 = teamImage1.toString();
                                      UserModel userDetails = UserModel();
                                      userDetails.teamId = int.parse(teamId.toString());

                                      Navigator.push(
                                          context,
                                          SwipeLeftAnimationRoute(
                                              widget:PickCertificateCategory(
                                              
                                              // teamid1:teamId.toString(),
                                              )
                                          //      UserMainImageScreen(
                                          //   teamId: americanId.toString(),
                                          //   // img: widget.img,
                                          // )
                                          ));
                                    } else {
                                      Navigator.push(
                                          context,
                                          SwipeLeftAnimationRoute(
                                              widget:
                                              BuyPickCategory(
                                                 teamid1:teamId.toString() ,
                                              ) 
                                              // UserMainImageScreen(
                                              //     // img: widget.img,
                                              //     teamId: teamId.toString())
                                                  ));
                                    }
                                  }
                                  // Navigator.push(
                                  //     context,
                                  //     SwipeLeftAnimationRoute(
                                  //         widget: UserMainImageScreen()));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: MyBackButton(),
            ),
          )
        ],
      ),
    );
  }
}
