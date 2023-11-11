import 'package:fan_hall/providers/theme_provider.dart';
import 'package:fan_hall/providers/userProvider.dart';
import 'package:fan_hall/screens/dashboard/certificates/fanMatch_certifiucate.dart';
import 'package:fan_hall/screens/dashboard/scan_screens/scan_certificate_screen.dart';
import 'package:fan_hall/widgets/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/common.dart';
import '../../certificates/certificates_screen.dart';
import '../../certificates/fanlikes_screen.dart';

class ShowcaseMainScreen extends StatefulWidget {
  const ShowcaseMainScreen({Key? key}) : super(key: key);

  @override
  State<ShowcaseMainScreen> createState() => _ShowcaseMainScreenState();
}

class _ShowcaseMainScreenState extends State<ShowcaseMainScreen>
    with TickerProviderStateMixin {
  ScrollController? _scrollController;
  TabController? tabViewController;
  TabController? tabController;

  TabBar get _tabBar => TabBar(
        controller: tabController,
        indicatorColor: Theme.of(context).primaryColor,
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
                text: "Certificates",
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
                text: "FanMatch",
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
                text: "NFT’s",
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
    tabController = TabController(length: 3, vsync: this);
    tabViewController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var color = Provider.of<ThemeProvider>(context).theme1model;

    var user = Provider.of<UserProvider>(context).user;

    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor1,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(size.height * 0.30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(
                        child: Image.asset(
                            "assets/tempImages/Steelers_Stadium.jpg",
                            fit: BoxFit.fitWidth)),
                    Container(
                      color: primaryColorB.withOpacity(0.8),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * horizontalPadding),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Icon(Icons.arrow_back,
                                          color: primaryColorW)),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Image.asset(
                                        "assets/icons/ic_menu_close.png",
                                        scale: 2),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.05),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(200),
                                            child: Image.network(
                                              user.img!,
                                              scale: 5.5,
                                              fit: BoxFit.fill,
                                              height: size.height * 0.06,
                                              width: size.width * 0.13,
                                            )),
                                      ],
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            VariableText(
                                              text: user.name!
                                                  .toUpperCase()
                                                  .toString(),
                                              fontcolor: primaryColorW,
                                              fontsize: size.height * 0.022,
                                              fontFamily: fontBold,
                                              max_lines: 1,
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: size.height * 0.01),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            VariableText(
                                              text: "@${user.username}",
                                              fontcolor: primaryColorW,
                                              fontsize: size.height * 0.014,
                                              fontFamily: fontRegular,
                                              max_lines: 1,
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                            "assets/tempImages/profile_badge_3.png",
                                            height: size.height * 0.05),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.08),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.location_on_outlined,
                                          size: size.height * 0.02,
                                          color: primaryColorW),
                                      SizedBox(width: 1),
                                      VariableText(
                                        text:
                                            "${user.city},${user.nationality}",
                                        fontcolor: primaryColorW,
                                        fontsize: size.height * 0.014,
                                        fontFamily: fontRegular,
                                        max_lines: 1,
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                          "assets/icons/ic_profile_star.png",
                                          height: size.height * 0.018),
                                      SizedBox(width: 1),
                                      VariableText(
                                        text: "CLASS: 2023",
                                        fontcolor: primaryColorW,
                                        fontsize: size.height * 0.014,
                                        fontFamily: fontRegular,
                                        max_lines: 1,
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: size.height * 0.02),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //SizedBox(height: size.height * 0.015),
              ///tab
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
                  // Padding(
                  //   padding: EdgeInsets.symmetric(
                  //       horizontal: size.width * horizontalPadding),
                  //   child: Row(
                  //     children: [
                  //       InkWell(
                  //         onTap: () {
                  //           Navigator.push(
                  //               context,
                  //               SwipeLeftAnimationRoute(
                  //                   widget: ScanCertificateScreen(
                  //                 certscan: true,
                  //               )));
                  //         },
                  //         child: Image.asset("assets/icons/scan.png",
                  //             scale: 5, color: textColorW),
                  //       ),
                  //       SizedBox(width: size.width * 0.06),
                  //       Image.asset("assets/icons/ic_certificate_grid_view.png",
                  //           scale: 2)
                  //     ],
                  //   ),
                  // )
                ],
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: tabViewController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            CertificatesScreen(
              isshow: false,
            ),
            CertificatesScreenFanMatch(  isshow: false,) ,//NoCertificateScreen(),
            FanlikesScreen(),
          ],
        ),
      ),
    );
  }
}
