import 'package:fan_hall/controller/references.dart';
import 'package:fan_hall/models/get_feeds.dart';
import 'package:fan_hall/models/user_model.dart';
import 'package:fan_hall/providers/userProvider.dart';
import 'package:fan_hall/screens/dashboard/profile/menu/chat/all_chats_screen.dart';
import 'package:fan_hall/screens/login_screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widgets/common.dart';
import '../../../widgets/style.dart';
import '../fan_card/showcase/showcase_main.dart';
import '../scan_screens/scan_id_screen.dart';
import 'menu/edit_profile/edit_profile_screen.dart';
import 'menu/manage_draft_screen.dart';
import 'menu/my_orders/my_orders_screen.dart';
import 'menu/notification_screen.dart';
import 'menu/privacy_screen.dart';

class ProfileMenuScreen extends StatelessWidget {
  const ProfileMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      backgroundColor: backgroundColor1,
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: size.width * horizontalPadding),
          child: Column(
            children: [
              SizedBox(height: size.height * 0.02),

              ///appbar
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child:
                        Image.asset("assets/icons/ic_menu_close.png", scale: 2),
                  )
                ],
              ),
              SizedBox(height: size.height * 0.04),

              ///profile details
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.06),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child: SizedBox(
                          height: size.height * 0.07,
                          width: size.width * 0.15,
                          child: Image.network(
                            user.img!,
                            scale: 2,
                            fit: BoxFit.fill,
                          )),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: VariableText(
                                text: user.name!.toUpperCase(),
                                fontcolor: primaryColorW,
                                fontsize: size.height * 0.022,
                                fontFamily: fontBold,
                                max_lines: 1,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: VariableText(
                                text:
                                    "Member since:${user.joiningDate} ${user.city},${user.nationality}",
                                fontcolor: primaryColorW,
                                fontsize: size.height * 0.014,
                                fontFamily: fontRegular,
                                max_lines: 2,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: size.height * 0.04),

              ///Trophies
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset("assets/icons/ic_logo.png",
                        scale: 13),
                    Image.asset("assets/tempImages/menu_trophies_2.png",
                        scale: 2),
                    Image.asset("assets/tempImages/menu_trophies_3.png",
                        scale: 2),
                  ],
                ),
              ),
              Divider(
                  color: textColor2,
                  thickness: 3,
                  height: size.height * 0.04),

              ///verified
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.09),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.push(context,
                              SwipeUpAnimationRoute(widget: QrScanScreen()));
                        },
                        child: Image.asset(
                            "assets/tempImages/profile_barcode.png",
                            height: size.height * 0.04)),
                    Flexible(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              VariableText(
                                text: "@${user.username}",
                                fontcolor: primaryColorW,
                                fontsize: size.height * 0.016,
                                fontFamily: fontMedium,
                                max_lines: 1,
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.003),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              VariableText(
                                text: "STEELERS FAN",
                                fontcolor: primaryColorW,
                                fontsize: size.height * 0.014,
                                fontFamily: fontRegular,
                                max_lines: 1,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Image.asset("assets/icons/ic_menu_verified.png",
                        height: size.height * 0.04)
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.04),

              ///Card
              Row(
                children: [
                  Spacer(),
                  MenuCard(
                    icon: "assets/icons/ic_menu_profile.png",
                    title: "Edit Profile",
                    onTap: () {
                      Navigator.push(context,
                          SwipeUpAnimationRoute(widget: EditProfileScreen()));
                    },
                  ),
                  Spacer(),
                  MenuCard(
                    icon: "assets/icons/ic_menu_notification.png",
                    title: "Notifications",
                    onTap: () {
                      Navigator.push(context,
                          SwipeUpAnimationRoute(widget: NotificationScreen()));
                    },
                  ),
                  Spacer(),
                  MenuCard(
                    icon: "assets/icons/ic_menu_myorders.png",
                    title: "My Orders",
                    onTap: () {
                      Navigator.push(context,
                          SwipeUpAnimationRoute(widget: MyOrdersScreen()));
                    },
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(height: size.height * 0.02),
              Row(
                children: [
                  Spacer(),
                  MenuCard(
                    icon: "assets/icons/ic_menu_draft.png",
                    title: "Manage Draft",
                    onTap: () {
                      Navigator.push(context,
                          SwipeUpAnimationRoute(widget: ManageDraftScreen()));
                    },
                  ),
                  Spacer(),
                  MenuCard(
                    icon: "assets/icons/ic_menu_showcase.png",
                    title: "Showcase",
                    onTap: () {
                      Navigator.push(context,
                          SwipeUpAnimationRoute(widget: ShowcaseMainScreen()));
                    },
                  ),
                  Spacer(),
                  MenuCard(
                    icon: "assets/icons/ic_menu_content.png",
                    title: "Add Content",
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(height: size.height * 0.02),
              Row(
                children: [
                  Spacer(),
                  MenuCard(
                    icon: "assets/icons/ic_menu_privacy.png",
                    title: "Privacy",
                    onTap: () {
                      Navigator.push(context,
                          SwipeUpAnimationRoute(widget: PrivacyScreen()));
                    },
                  ),
                  Spacer(),
                  MenuCard(
                    icon: "assets/icons/ic_menu_chat.png",
                    title: "Chat",
                    onTap: () {
                      Navigator.push(
                          context, SwipeUpAnimationRoute(widget: AllChats()));
                    },
                  ),
                  Spacer(),
                  MenuCard(
                    icon: "assets/icons/ic_menu_customer.png",
                    title: "Customer Service",
                    onTap: () {},
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(height: size.height * 0.02),

              ///settings
              Row(
                children: [
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: VariableText(
                      text: "Settings",
                      fontcolor: primaryColorW,
                      fontsize: size.height * 0.014,
                      fontFamily: fontRegular,
                      max_lines: 1,
                      textAlign: TextAlign.center,
                      underlined: true,
                    ),
                  ),
                  Spacer(),
                  Spacer(),
                  VariableText(
                    text: "Help",
                    fontcolor: primaryColorW,
                    fontsize: size.height * 0.014,
                    fontFamily: fontRegular,
                    max_lines: 1,
                    textAlign: TextAlign.center,
                    underlined: true,
                  ),
                  Spacer(),
                  Spacer(),
                  InkWell(
                    onTap: () async{
                               await preferenceController.clearAll();
                      selectedNationality=null;
                      selectedcity=null;
                      user.img==null;
                      
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WelcomeScreen()),
                          (route) => route.isCurrent);
                    },
                    child: VariableText(
                      text: "Sign out",
                      fontcolor: primaryColorW,
                      fontsize: size.height * 0.014,
                      fontFamily: fontRegular,
                      max_lines: 1,
                      textAlign: TextAlign.center,
                      underlined: true,
                    ),
                  ),
                  Spacer(),
                ],
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/icons/ic_menu_footer.png", scale: 2),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
