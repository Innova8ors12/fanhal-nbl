import 'package:fan_hall/controller/auth/league_api.dart';
import 'package:fan_hall/controller/auth/user_authentications.dart';
import 'package:fan_hall/models/league_model.dart';
import 'package:fan_hall/models/user_model.dart';
import 'package:fan_hall/providers/league_provider.dart';
import 'package:fan_hall/screens/registration_screens/4_select_team_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../widgets/common.dart';
import '../../widgets/style.dart';
import '../login_screens/welcome_screen.dart';

class UserLeagueScreen extends StatefulWidget {
  const UserLeagueScreen({Key? key}) : super(key: key);

  @override
  State<UserLeagueScreen> createState() => _UserLeagueScreenState();
}

class _UserLeagueScreenState extends State<UserLeagueScreen> {
  int selectedLeague = -1;

  onLeagueSelect(int value) {
    setState(() {
      selectedLeague = value;
    });
  }

  league() async {
    List<LeagueModel> datalist = await ApiModel().getData();
  }

  @override
  void initState() {
    super.initState();

    allTeamsList1.clear();
    getResponse();

    // league();
    // final dataProvider = Provider.of<LeagueProvider>(context, listen: false);
    // dataProvider.datalist;

    // print(dataProvider.datalist);
  }

  getResponse() async {
    var res = await ApiModel().getData();
    // print(res);
    if (res != null && res['status']) {
      leagueModel = LeagueModel.fromJson(res);
      // print(leagueModel);

      americanId = leagueModel!.data![0]!.id.toString();
      americanLeagueName = leagueModel!.data![0]!.name.toString();

      nationalId = leagueModel!.data![1]!.id.toString();
      setState(() {});
    }
  }

  LeagueModel? leagueModel;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final dataProvider = Provider.of<LeagueProvider>(context);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Consumer<LeagueProvider>(builder: (context, value, child) {
          // If the loading it true then it will show the circular progressbar
          // if (value.isLoading) {
          //   return const Center(
          //     child: CircularProgressIndicator(),
          //   );
          // }
          // If loading is false then this code will show the list of todo item
          // print(dataProvider.responseData.img.toString());

          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset("assets/images/welcome_background.png",
                    fit: BoxFit.fill),
              ),
              Positioned.fill(
                child: Container(
                  color: const Color(0xFF000000).withOpacity(0.8),
                ),
              ),
              Positioned.fill(
                child: SafeArea(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.17),
                    child: Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: size.height * 0.15),
                            Image.asset("assets/icons/ic_logo.png", scale: 5.8),
                            SizedBox(height: size.height * 0.04),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: VariableText(
                                    text: "Your team’s\nleague!",
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
                            SizedBox(height: size.height * 0.04),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                VariableText(
                                  text: "Select a league to continue.",
                                  fontsize: size.height * 0.018,
                                  fontcolor: textColorW,
                                  fontFamily: fontMedium,
                                  weight: FontWeight.w500,
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                            SizedBox(height: size.height * 0.04),
                            leagueModel == null
                                ? Center(
                                    child: CircularProgressIndicator(
                                    color: Theme.of(context).primaryColor,
                                  ))
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        onTap: () {

                                          onLeagueSelect(0);
                                        },
                                        child: Container(
                                            height: size.height * 0.13,
                                            width: size.height * 0.13,
                                            padding: EdgeInsets.all(15),
                                            decoration: BoxDecoration(
                                                color: selectedLeague == 0
                                                    ? primaryColorW
                                                        .withOpacity(0.8)
                                                    : Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(200)),
                                            child: Image.network(leagueModel!
                                                .data![0]!.img
                                                .toString())),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          onLeagueSelect(1);
                                        },
                                        child: Container(
                                            height: size.height * 0.13,
                                            width: size.height * 0.13,
                                            padding: EdgeInsets.all(15),
                                            decoration: BoxDecoration(
                                                color: selectedLeague == 1
                                                    ? primaryColorW
                                                        .withOpacity(0.8)
                                                    : Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(200)),
                                            child: Image.network(leagueModel!
                                                .data![1]!.img
                                                .toString())),
                                      ),
                                    ],
                                  ),
                            SizedBox(height: size.height * 0.10),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      SwipeLeftAnimationRoute(
                                          widget: WelcomeScreen()),
                                      (route) => route.isCurrent);
                                },
                                child: VariableText(
                                  text: "Skip",
                                  fontsize: size.height * 0.018,
                                  fontcolor: textColor3,
                                  fontFamily: fontMedium,
                                  weight: FontWeight.w400,
                                  textAlign: TextAlign.center,
                                  underlined: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: MyButtonIcon(
                            btnHeight: size.height * 0.055,
                            btnColor: primaryColorW,
                            borderColor: primaryColorW,
                            btnRadius: 200,
                            btnTxt: "Continue",
                            fontSize: size.height * 0.018,
                            fontFamily: fontSemiBold,
                            weight: FontWeight.w500,
                            txtColor: textColor1,
                            onTap: () {
                              allTeamsList1.clear();
                            // Provider.of<LeagueProvider>(context).allTeamsList.clear();
                              if (selectedLeague == -1) {
                                customToast("please select the League");
                              } else {
                                if (selectedLeague == 0) {
                                  leagueName =
                                      leagueModel!.data![0]!.name.toString();
                                  UserModel userDetails = UserModel();
                                  userDetails.leagueName =
                                      leagueName.toString();
                                  leagueImage =
                                      leagueModel!.data![0]!.img.toString();
                                  leagueName =
                                      leagueModel!.data![0]!.name.toString();
                                  Navigator.push(
                                      context,
                                      SwipeLeftAnimationRoute(
                                          widget: UserTeamScreen(
                                        id: americanId.toString(),
                                        img: leagueImage.toString(),
                                      )));
                                } else {
                                  leagueName =
                                      leagueModel!.data![1]!.name.toString();
                                  UserModel userDetails = UserModel();
                                  userDetails.leagueName =
                                      leagueName.toString();
                                  leagueImage =
                                      leagueModel!.data![1]!.img.toString();
                                  Navigator.push(
                                      context,
                                      SwipeLeftAnimationRoute(
                                          widget: UserTeamScreen(
                                              id: nationalId.toString(),
                                              img: leagueImage.toString())));
                                }
                              }
                            },
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
          );
        }));
  }
}
