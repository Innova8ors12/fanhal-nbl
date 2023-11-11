import 'package:fan_hall/providers/theme_provider.dart';
import 'package:fan_hall/providers/userProvider.dart';
import 'package:fan_hall/screens/dashboard/draft/fan_draft/fan_draft_screen.dart';
import 'package:fan_hall/screens/dashboard/draft/scores/scores_screen.dart';
import 'package:fan_hall/screens/dashboard/profile/profile_menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../../../widgets/common.dart';
import '../../../widgets/style.dart';

class DraftMainScreen extends StatefulWidget {
  const DraftMainScreen({Key? key}) : super(key: key);

  @override
  State<DraftMainScreen> createState() => _DraftMainScreenState();
}

class _DraftMainScreenState extends State<DraftMainScreen>
    with TickerProviderStateMixin {
  TabController? tabViewController;
  TabController? tabController;

  TabBar get _tabBar => TabBar(
        controller: tabController,
        indicatorColor:HexColor(navbarselected!),
        labelColor: textColorW,
        indicatorWeight: 3.0,
        isScrollable: false,
        labelPadding: const EdgeInsets.symmetric(horizontal: 0),
        indicatorSize: TabBarIndicatorSize.label,
        onTap: (int i) {
          onTabPressed(i);
        },
        tabs: [
          Tab(
              icon: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const VariableText(
                text: "Fan Draft",
                fontsize: 12,
                fontcolor: textColorW,
                fontFamily: fontMedium,
                max_lines: 1,
              ),
            ],
          )),
          Tab(
              icon: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const VariableText(
                text: "Scores",
                fontsize: 12,
                fontcolor: textColorW,
                fontFamily: fontMedium,
                max_lines: 1,
              ),
            ],
          ))
        ],
      );

  onTabPressed(int i) {
    setState(() {
      tabViewController!.animateTo(i);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabViewController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var user = Provider.of<UserProvider>(context).user;
    var primarycolor = Provider.of<ThemeProvider>(context).theme1model;
    navbarselected=primarycolor.navMenuTextSelect;
    return Scaffold(
      backgroundColor: backgroundColor1,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * horizontalPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                 InkWell(
                    onTap: (){
                         Navigator.push(context,
                  SwipeLeftAnimationRoute(widget: ProfileMenuScreen()));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child: Image.network(
                        user.img!,
                        scale: 2,
                        fit: BoxFit.fill,
                        height: size.height * 0.05,
                        width: size.width * 0.10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.015),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(width: size.width * 0.05),
                Flexible(
                  child: Stack(
                    fit: StackFit.passthrough,
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: Color(0xFF555555), width: 3.0),
                          ),
                        ),
                      ),
                      _tabBar,
                    ],
                  ),
                ),
                SizedBox(width: size.width * 0.05),
              ],
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabViewController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          FanDraftScreen(), //NoCertificateScreen(),
          ScoresScreen(),
        ],
      ),
    );
  }
}
