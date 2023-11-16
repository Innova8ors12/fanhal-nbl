import 'package:cached_network_image/cached_network_image.dart';
import 'package:fan_hall/models/user_model.dart';
import 'package:fan_hall/providers/theme_provider.dart';
import 'package:fan_hall/providers/userProvider.dart';
import 'package:fan_hall/widgets/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../../../widgets/common.dart';
import '../profile/profile_menu_screen.dart';
import 'showcase/showcase_main.dart';

class FanCardScreen extends StatefulWidget {
  Function? onProfile;
  FanCardScreen({Key? key, this.onProfile}) : super(key: key);

  @override
  State<FanCardScreen> createState() => _FanCardScreenState();
}

class _FanCardScreenState extends State<FanCardScreen> {
  bool _toggler = true;
  bool showPrevYear = false;
  bool isLoading = false;
  setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

  UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    var primarycolor = Provider.of<ThemeProvider>(context).theme1model;
    var size = MediaQuery.of(context).size;
    var user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      backgroundColor: primaryColorB,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset("assets/images/home_fancard_background.png",
                fit: BoxFit.fill),
          ),
          Align(
              alignment: Alignment.topLeft,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width * 1.2,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      HexColor(primarycolor.primaryColor!),
                    ],
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    stops: [0.2, 1],
                    tileMode: TileMode.repeated,
                  ),
                ),
              )),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * horizontalPadding,
                  vertical: size.height * verticalPadding),
              child: InkWell(
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
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(top: size.height * 0.06),
              child: GestureDetector(
                onTap: () {},
                onVerticalDragEnd: (v) {
                  setState(() {
                    showPrevYear = !showPrevYear;
                  });
                },
                onHorizontalDragEnd: (v) {
                  setState(() {
                    _toggler = !_toggler;
                  });
                },
                child: FlipCard(
                  toggler: _toggler,
                  frontCard: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      VariableText(
                        text: showPrevYear
                            ? 'WELCOME TO IMMORTALITY'
                            : 'WELCOME TO IMMORTALITY',
                        fontsize: size.height * 0.018,
                        fontcolor: textColorW,
                        fontFamily: fontSemiBold,
                        weight: FontWeight.w600,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: size.height * 0.01),
                      Container(
                        height: size.height * 0.72,
                        width: size.width * 0.77,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(50)),
                        child: Padding(
                          padding:  EdgeInsets.all(8.0),
                          child: Column(children: [
                            Stack(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    height: size.height * 0.51,
                                    width: size.width,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: user.cardImg != null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(35),
                                              child: CachedNetworkImage(
                                                imageUrl: user.cardImg!,
                                                fit: BoxFit.cover,
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            )
                                          : Container(
                                              child: Center(
                                                child: VariableText(
                                                  text: "No Image Found!",
                                                  fontsize: size.height * 0.026,
                                                  fontcolor: textColorB,
                                                  fontFamily: fontBold,
                                                  weight: FontWeight.w700,
                                                  textAlign: TextAlign.center,
                                                  max_lines: 2,
                                                ),
                                              ),
                                            ),
                                    )),
                                Positioned(
                                  right: size.width * 0.02,
                                  top: size.height * 0.012,
                                  child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: HexColor(
                                              primarycolor.shareBtnBg!),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(200))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SvgPicture.asset(
                                          'assets/icons/share1.svg',
                                          color: HexColor(
                                              primarycolor.shareBtnColor!),
                                          width: size.width * 0.002,
                                          height: size.height * 0.02,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    right: size.width * 0.19,
                                    left: size.width * 0.19,
                                    top: size.height * 0.47,
                                    child: Container(
                                      height: size.height * 0.04,
                                      width: size.width * 0.3,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          color:
                                              Theme.of(context).primaryColor),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          height: size.height * 0.04,
                                          width: size.width * 0.04,
                                          child: Image.asset(
                                            'assets/icons/nfl1.png',
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color,
                                            scale: 5,
                                          ),
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: size.width * 0.02,
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    height: size.height * 0.08,
                                    child: Image.asset(
                                      'assets/icons/nflcard.png',
                                      color: Theme.of(context).iconTheme.color,
                                      scale: 5,
                                      // width: size.width * 0.1,
                                      // height: size.height * 0.4,
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.11,
                                    child: teamImage != null
                                        ? Image.network(user.team!.img!,
                                            scale: 1, height: size.height)
                                        : Container(
                                            child: Center(
                                                child: Text(
                                              "No Team !",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 192, 57, 57)),
                                            )),
                                          ),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.05,
                                    child: SvgPicture.asset(
                                      'assets/icons/yearnike.svg',
                                      color: Theme.of(context).iconTheme.color,
                                      width: size.width * 0.01,
                                      height: size.height * 0.04,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: VariableText(
                                text: user.name!.toUpperCase().toString(),
                                fontsize: size.height * 0.022,
                                fontcolor: Theme.of(context).iconTheme.color,
                                fontFamily: fontBold,
                                weight: FontWeight.w700,
                                textAlign: TextAlign.center,
                                max_lines: 2,
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.005,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: VariableText(
                                text:
                                    "${user.team!.nickName!.toUpperCase()} OFFICIAL FAN",
                                fontsize: size.height * 0.014,
                                fontcolor: Theme.of(context).iconTheme.color,
                                fontFamily: fontRegular,
                                weight: FontWeight.w500,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ]),
                        ),
                      )
                    ],
                  ),
                  backCard: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/icons/nfl1.png",
                          color: textColorW, scale: 4),
                      SizedBox(height: size.height * 0.01),
                      //Image.asset("assets/tempImages/fancard_back.png", height: size.height * 0.65),
                      Container(
                        height: size.height * 0.72,
                        width: size.width * 0.77,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius:
                                BorderRadius.circular(size.height * 0.06)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: size.height * 0.05),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: Image.network(
                                    user.team!.img!,
                                    height: size.height * 0.065,
                                    width: size.width * 0.14,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.network(
                                      user.img!,
                                      height: size.height * 0.08,
                                      width: size.width * 0.17,
                                      fit: BoxFit.fill,
                                    )),
                                user.nationality == "Canada"
                                    ? Image.asset(
                                        "assets/icons/canadaflag.png",
                                        height: size.height * 0.04,
                                        width: size.width * 0.12,
                                        fit: BoxFit.fill,
                                      )
                                    : user.nationality == "United States"
                                        ? Image.asset(
                                            "assets/icons/usaflag.png",
                                            height: size.height * 0.04,
                                            width: size.width * 0.12,
                                            fit: BoxFit.fill,
                                          )
                                        : user.nationality == "Mexico"
                                            ? Image.asset(
                                                "assets/icons/mexicoflag.png",
                                                height: size.height * 0.04,
                                                width: size.width * 0.12,
                                                fit: BoxFit.fill,
                                              )
                                            : Container(),
                              ],
                            ),
                            SizedBox(height: size.height * 0.01),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    VariableText(
                                      text: user.name!.toUpperCase(),
                                      fontsize: size.height * 0.024,
                                      fontcolor:
                                          Theme.of(context).iconTheme.color,
                                      fontFamily: fontBold,
                                      weight: FontWeight.w600,
                                      textAlign: TextAlign.center,
                                    ),
                                    VariableText(
                                      text:
                                          "${user.city}, ${user.nationality == "Canada" ? "Canada " : user.nationality == "United States" ? "USA " : "Mexico "}/ 2023",
                                      fontsize: size.height * 0.012,
                                      fontcolor:
                                          Theme.of(context).iconTheme.color,
                                      fontFamily: fontRegular,
                                      weight: FontWeight.w500,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Divider(
                                color: textColor2,
                                thickness: 1,
                                height: size.height * 0.03),
                            SizedBox(height: size.height * 0.01),

                            ///buttons
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.04,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: MyButton(
                                      btnHeight: size.height * 0.04,
                                      btnColor:
                                          HexColor(primarycolor.shareBtnBg!),
                                      borderColor:
                                          HexColor(primarycolor.shareBtnBg!),
                                      btnRadius: 200,
                                      btnTxt: "My Profile",
                                      fontSize: size.height * 0.012,
                                      fontFamily: fontMedium,
                                      weight: FontWeight.w500,
                                      txtColor:
                                          HexColor(primarycolor.shareBtnColor!),
                                      onTap: () {
                                        widget.onProfile!();
                                      },
                                    ),
                                  ),
                                  SizedBox(width: size.width * 0.02),
                                  Expanded(
                                    child: MyButton(
                                      btnHeight: size.height * 0.04,
                                      btnColor:
                                          HexColor(primarycolor.shareBtnBg!),
                                      borderColor:
                                          HexColor(primarycolor.shareBtnBg!),
                                      btnRadius: 200,
                                      btnTxt: "Showcase",
                                      fontSize: size.height * 0.012,
                                      fontFamily: fontMedium,
                                      weight: FontWeight.w500,
                                      txtColor:
                                          HexColor(primarycolor.shareBtnColor!),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            SwipeLeftAnimationRoute(
                                                widget: ShowcaseMainScreen()));
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.02),
                                    child: Icon(Icons.share_outlined),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.08,
                                    vertical: size.height * 0.035),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: primaryColorW,
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: size.height * 0.015),
                                        decoration: BoxDecoration(
                                            color: HexColor(
                                                primarycolor.shareBtnBg!),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(25),
                                                topRight: Radius.circular(25))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            VariableText(
                                              text: "@${user.username}",
                                              fontsize: size.height * 0.014,
                                              fontcolor: HexColor(
                                                  primarycolor.shareBtnColor!),
                                              fontFamily: fontRegular,
                                              weight: FontWeight.w500,
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: SizedBox(
                                            height: size.height * 0.15,
                                            width: size.width * 0.55,
                                            child: SvgPicture.network(
                                              "https://fanhall.app/${user.qrCode}",
                                              placeholderBuilder: (BuildContext
                                                      context) =>
                                                  const CircularProgressIndicator(),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.02),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: VariableText(
                                      text: user.userId!.toUpperCase(),
                                      fontsize: size.height * 0.014,
                                      fontcolor:
                                          Theme.of(context).iconTheme.color,
                                      fontFamily: fontRegular,
                                      weight: FontWeight.w500,
                                      textAlign: TextAlign.center,
                                      max_lines: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: size.height * 0.03),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              //child: Image.asset("assets/tempImages/fancard_front.png", height: size.height * 0.65),
            ),
          )
        ],
      ),
    );
  }
}
