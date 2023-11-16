import 'dart:io';

import 'package:fan_hall/models/user_model.dart';
import 'package:fan_hall/screens/dashboard/fan_card/fan_card_screen.dart';
import 'package:fan_hall/widgets/style.dart';
import 'package:flutter/material.dart';

import '../../widgets/common.dart';
import 'certificates/certificate_main.dart';
import 'draft/draft_main.dart';
import 'profile/profile_main_screen.dart';
import 'social/social_home.dart';

class MainDashboard extends StatefulWidget {
  bool isfanmatch;
 MainDashboard({Key? key,this.isfanmatch=false}) : super(key: key);

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  var mainTab = {
    "tabs": [
      {"title": "Draft", "icon": "assets/icons/ic_bottom_draft.png"},
      {
        "title": "Certificates",
        "icon": "assets/icons/ic_bottom_certificate.png"
      },
      {"title": "Star", "icon": "assets/icons/ic_bottom_star.png"},
      {"title": "Profile", "icon": "assets/icons/ic_bottom_profile.png"},
      {"title": "Members", "icon": "assets/icons/ic_bottom_social.png"}
    ]
  };

  Future<bool> onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Confirm'),
              content: Text('Do you want to exit the app?'),
              actions: <Widget>[
                TextButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Yes', style: TextStyle(color: Colors.red)),
                  onPressed: () {
                    exit(0);
                  },
                )
              ],
            );
          },
        )) ??
        false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(
        length: 5,
        animationDuration: const Duration(milliseconds: 200),
        initialIndex:widget.isfanmatch? 1:2,
        vsync: this);
    tabController!.addListener(handleTabSelection);
  }

  handleTabSelection() {
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController!.dispose();
  }

  // UserModel? userModel;
  // UserModel userModel1 = UserModel();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: onWillPop,
      child: SafeArea(
        child: Scaffold(
          body: TabBarView(
            controller: tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              DraftMainScreen(),
              CertificateMainScreen(
                
              ),
              FanCardScreen(
                onProfile: () {
                  tabController!.animateTo(3);
                },
              ),
              ProfileMainScreen(),
              SocialHomeScreen(),
            ],
          ),
          bottomNavigationBar: Container(
            height: size.height * 0.08,
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(mainTab['tabs']!.length, (index) {
                if (mainTab['tabs']![index]['title'] == "Star") {
                  return Expanded(
                    flex: 10,
                    child: InkWell(
                      onTap: () {
                        tabController!.animateTo(index);
                      },
                      child: Image.asset(
                        mainTab['tabs']![index]['icon'].toString(),
                        height: size.height * 0.065,
                        color: tabController!.index == index
                            ? Theme.of(context)
                                .bottomNavigationBarTheme
                                .selectedItemColor
                            : Theme.of(context)
                                .bottomNavigationBarTheme
                                .unselectedItemColor,
                      ),
                    ),
                  );
                } else {
                  return Expanded(
                    flex: 10,
                    child: InkWell(
                      onTap: () {
                        tabController!.animateTo(index);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Spacer(),
                          Image.asset(
                            mainTab['tabs']![index]['icon'].toString(),
                            scale: 1.8,
                            color: tabController!.index == index
                                ? Theme.of(context)
                                    .bottomNavigationBarTheme
                                    .selectedItemColor
                                : Theme.of(context)
                                    .bottomNavigationBarTheme
                                    .unselectedItemColor,
                          ),
                          SizedBox(height: size.height * 0.003),
                          VariableText(
                            text: mainTab['tabs']![index]['title'],
                            fontcolor: tabController!.index == index
                                ? Theme.of(context)
                                    .bottomNavigationBarTheme
                                    .selectedItemColor
                                : Theme.of(context)
                                    .bottomNavigationBarTheme
                                    .unselectedItemColor,
                            fontsize: size.width * 0.025,
                            fontFamily: fontMedium,
                            max_lines: 1,
                          ),
                          Spacer(),
                          Container(
                            height: 3,
                            color: tabController!.index == index
                                ? Theme.of(context)
                                    .bottomNavigationBarTheme
                                    .selectedItemColor
                                : Theme.of(context)
                                    .bottomNavigationBarTheme
                                    .unselectedItemColor,
                          )
                        ],
                      ),
                    ),
                  );
                }
              }),
            ),
          ),
        ),
      ),
    );
  }
}
