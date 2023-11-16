import 'package:fan_hall/controller/auth/league_api.dart';
import 'package:fan_hall/models/scan_model.dart';
import 'package:fan_hall/nft/NFL/create_wallet.dart';
import 'package:fan_hall/providers/theme_provider.dart';
import 'package:fan_hall/screens/dashboard/certificates/fanMatch_certifiucate.dart';
import 'package:fan_hall/screens/dashboard/profile/profile_menu_screen.dart';
import 'package:fan_hall/screens/dashboard/scan_screens/certificate_full_view.dart';
import 'package:fan_hall/screens/dashboard/scan_screens/scan_certificate_screen.dart';
import 'package:fan_hall/screens/dashboard/scan_screens/verified_certificate_screen.dart';
import 'package:fan_hall/widgets/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../../../providers/userProvider.dart';
import '../../../widgets/common.dart';
import 'certificates_screen.dart';
import 'fanlikes_screen.dart';
import 'no_certificate_Screen.dart';
import 'no_fanlike_screen.dart';

class CertificateMainScreen extends StatefulWidget {
  bool? isfanMatch;
  CertificateMainScreen({Key? key, this.isfanMatch = false}) : super(key: key);

  @override
  State<CertificateMainScreen> createState() => _CertificateMainScreenState();
}

class _CertificateMainScreenState extends State<CertificateMainScreen>
    with TickerProviderStateMixin {
  ScrollController? _scrollController;
  TabController? tabViewController;
  TabController? tabController;
  bool isLoading = false;
  setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

  TabBar get _tabBar => TabBar(
        controller: tabController,
        indicatorColor: HexColor(
            Provider.of<ThemeProvider>(context).theme1model.navMenuTextSelect!),
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

  bool isSuccess = true;
  String _scanBarcode = "-1";
  TextEditingController scanid = TextEditingController();
  @override
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this,initialIndex: widget.isfanMatch! ? 1 : 0);
    tabViewController = TabController(
        length: 3, vsync: this, initialIndex: widget.isfanMatch! ? 1 : 0);
    _scrollController = ScrollController();
    // if (!widget.isfanMatch!) {
    //   tabViewController!.animateTo(1);
    // }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    tabViewController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var user = Provider.of<UserProvider>(context).user;
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
                    onTap: () {
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
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * horizontalPadding),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              SwipeLeftAnimationRoute(
                                  widget: ScanCertificateScreen(
                                certscan: true,
                              )));
                        },
                        child: Image.asset("assets/icons/scan.png",
                            scale: 5, color: textColorW),
                      ),
                      SizedBox(width: size.width * 0.06),
                      // Image.asset(
                      //   "assets/icons/ic_certificate_grid_view.png",
                      //   scale: 2,
                      //   color: Provider.of<ThemeProvider>(context)
                      //               .theme1model
                      //               .shareBtnColor !=
                      //           null
                      //       ? HexColor(Provider.of<ThemeProvider>(context)
                      //           .theme1model
                      //           .navMenuTextSelect!)
                      //       : textColorW,
                      // )
                    ],
                  ),
                )
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
            isshow: true,
          ),
          CertificatesScreenFanMatch(
            isshow: true,
          ),
          //NoCertificateScreen(),
          CreateWallet(),
        ],
      ),
    );
  }
}
