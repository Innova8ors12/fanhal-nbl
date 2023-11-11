import 'package:fan_hall/controller/auth/league_api.dart';
import 'package:fan_hall/models/get_photos.dart';
import 'package:fan_hall/providers/userProvider.dart';
import 'package:fan_hall/screens/dashboard/profile/profile_social/post_feed.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/common.dart';
import '../../../../widgets/style.dart';
import '../../scan_screens/scan_id_screen.dart';
import '../profile_menu_screen.dart';
import 'newsfeed_screen.dart';
import 'tribe_screen.dart';

class ProfileSocialMain extends StatefulWidget {
  final Id;
   ProfileSocialMain({Key? key, required this.Id}) : super(key: key);

  @override
  State<ProfileSocialMain> createState() => _ProfileSocialMainState();
}

class _ProfileSocialMainState extends State<ProfileSocialMain>
    with TickerProviderStateMixin {
  ScrollController? _scrollController;
  TabController? tabViewController;
  TabController? tabController;
 List<GetPhotos>  feedsPhoto=[];

  TabBar get _tabBar => TabBar(
        controller: tabController,
        indicatorColor: Theme.of(context).primaryColor,
        labelColor: textColorW,
        indicatorWeight: 3.0,
        isScrollable: false,
        labelPadding: const EdgeInsets.symmetric(horizontal: 10),
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
                text: "Tribe",
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
                text: "Joinet",
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
                text: "Newsfeed",
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
    onTabPressed(widget.Id);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
var user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      backgroundColor: primaryColorB,
      body: NestedScrollView(
        controller: _scrollController,
        floatHeaderSlivers: false,
        physics: NeverScrollableScrollPhysics(),
        headerSliverBuilder: (context, value) {
          return [
            SliverAppBar(
              backgroundColor: Colors.black,
              automaticallyImplyLeading: false,
              floating: true,
              pinned: true,
              leading: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.arrow_back),
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        SwipeLeftAnimationRoute(widget: ProfileMenuScreen()));
                  },
                ),
              ],
            ),

            ///Header
            SliverToBoxAdapter(
                child: SizedBox(
              height: size.height * 0.24,
              child: Stack(
                children: [
                  Positioned.fill(
                    child:
                        Image.asset("assets/tempImages/Steelers_Stadium.jpg",fit: BoxFit.fill,),
                  ),
                  Positioned.fill(
                      child: Container(
                    color: Colors.black.withOpacity(0.8),
                  )),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ///Header
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.06),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            SwipeUpAnimationRoute(
                                                widget: QrScanScreen()));
                                      },
                                      child: Image.asset(
                                          "assets/tempImages/profile_barcode.png",
                                          height: size.height * 0.05)),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      VariableText(
                                        text: user.name!.toUpperCase().toString(),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap:(){
                                      image_post=null;
                                       Navigator.push(
                                            context,
                                            SwipeUpAnimationRoute(
                                                widget:Post_Feeds()));
                                    },
                                    child: Container(
                                      height: size.height * 0.05,
                                      width: size.height * 0.05,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(200)),
                                      child: Icon(Icons.add,
                                          size: size.height * 0.035),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),

                      SizedBox(height: size.height * 0.03),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.08),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.location_on_outlined,
                                    size: size.height * 0.02,
                                    color: primaryColorW),
                                SizedBox(width: 1),
                                VariableText(
                                  text: "${user.city},${user.nationality}",
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
                                Image.asset("assets/icons/ic_profile_star.png",
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
                ],
              ),
            )),
            SliverAppBar(
              backgroundColor: Colors.black,
              automaticallyImplyLeading: false,
              floating: false,
              pinned: true,
              toolbarHeight: size.height * 0.06,
              collapsedHeight: size.height * 0.06,
              expandedHeight: size.height * 0.06,
              flexibleSpace: _tabBar,
            ),
          ];
        },
        body: TabBarView(
          controller: tabViewController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            TribeScreen(),
            TribeScreen(),
            NewsfeedScreen(),
          ],
        ),
      ),
    );
  }
}
