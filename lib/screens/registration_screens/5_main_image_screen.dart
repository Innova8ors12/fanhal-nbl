import 'dart:ui';

import 'package:fan_hall/controller/auth/league_api.dart';
import 'package:fan_hall/models/theme_model.dart';
import 'package:fan_hall/models/user_model.dart';
import 'package:fan_hall/providers/theme_provider.dart';
import 'package:fan_hall/screens/registration_screens/image_from_gallery.dart';
import 'package:fan_hall/widgets/theme_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/common.dart';
import '../../widgets/style.dart';
import '../login_screens/welcome_screen.dart';
import '6_profile_image_screen.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UserMainImageScreen extends StatefulWidget {
  final String teamId;
  const UserMainImageScreen({Key? key, required this.teamId}) : super(key: key);

  @override
  State<UserMainImageScreen> createState() => _UserMainImageScreenState();
}

class _UserMainImageScreenState extends State<UserMainImageScreen> {
  bool photoUploaded = false;

  PickedFile? _imageFile;
  bool isLoading = true;

  final ImagePicker _picker = ImagePicker();

  Future<void> _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    // setState(() {});

    _imageFile = pickedFile;
    if (pickedFile != null) {
      setState(() {
        image1 = File(pickedFile.path.toString());
      });
      print(image1);
    }
  }

  setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

  getThemeData() async {
    var res = await ApiModel().getTheme(widget.teamId);
    if (res['status'].toString() == "true") {
      Theme1Model themeModel = Theme1Model.fromJson(res['data']);
      Provider.of<ThemeProvider>(context, listen: false).settheme(themeModel);
      setLoading(false);
    }
  }

  @override
  void initState() {
    getThemeData();
    super.initState();
  }

  Theme1Model? theme1model;

  @override
  Widget build(BuildContext context) {
        var color = Provider.of<ThemeProvider>(context).theme1model;
    var size = MediaQuery.of(context).size;

// Future _imgFromCamera() async {
//     var image = await ImagePicker.platform
//         .pickImage(source: ImageSource.camera, imageQuality: 50);
//     if (image != null) {
//       selectedImage = File(image.path);
//       proceed();
//     }
//   }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset("assets/images/main_image_background.png",
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
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.15),
                child: SingleChildScrollView(
                  child: color.shareBtnBg==null?CircularProgressIndicator(
                                            color:
                                                Theme.of(context).primaryColor,
                                          ): Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: size.height * 0.05),
                      photoUploaded
                          ? Container(
                              height: size.height * 0.65,
                              width: size.width * 0.70,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(children: [
                                  // SizedBox(
                                  //   height: size.height * 0.5,
                                  // ),
                                  Stack(
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                          ),
                                          height: size.height * 0.45,
                                          width: size.width,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: image1 != null
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    child: Image.file(
                                                      image1!,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                                : Container(
                                                    child: Center(
                                                      child: VariableText(
                                                        text: "No Image Found!",
                                                        fontsize:
                                                            size.height * 0.026,
                                                        fontcolor: textColorB,
                                                        fontFamily: fontBold,
                                                        weight: FontWeight.w700,
                                                        textAlign:
                                                            TextAlign.center,
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
                                          child: SizedBox(
                                            height: size.height * 0.04,
                                            child:Container(
                                      decoration: BoxDecoration(
                                          color:color==null?Colors.black: HexColor(color.shareBtnBg!),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(200))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SvgPicture.asset(
                                          'assets/icons/share1.svg',
                                          color:color==null?Colors.black:
                                            HexColor(color.shareBtnColor!),
                                          width: size.width * 0.002,
                                          height: size.height * 0.02,
                                        ),
                                      ),
                                    ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          right: size.width * 0.19,
                                          left: size.width * 0.19,
                                          top: size.height * 0.41,
                                          child: Container(
                                            height: size.height * 0.04,
                                            width: size.width * 0.3,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5)),
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                height: size.height * 0.04,
                                                width: size.width * 0.04,
                                                child: Image.asset(
                                                        'assets/icons/nfl1.png',
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color,
                                                  scale: 5.5,
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
                                          height: size.height * 0.05,
                                          child: Image.asset(
                                      'assets/icons/nflcard.png',
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color,
                                          scale: 5,
                                          ),
                                        ),
                                        SizedBox(
                                          height: size.height * 0.08,
                                          child: teamImage != null
                                              ? Image.network(
                                                  teamImage.toString(),
                                                  height: size.height * 0.50)
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
                                          height: size.height * 0.04,
                                          child: SvgPicture.asset(
                                            'assets/icons/yearnike.svg',
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color,
                                            width: size.width * 0.01,
                                            height: size.height * 0.03,
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
                                      text: name!.toUpperCase().toString(),
                                      fontsize: size.height * 0.020,
                                      fontcolor:
                                          Theme.of(context).iconTheme.color,
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
                                      text: "${'${nickName!.toUpperCase()} OFFICIAL FAN'}",
                                      fontsize: size.height * 0.013,
                                      fontcolor:
                                          Theme.of(context).iconTheme.color,
                                      fontFamily: fontRegular,
                                      weight: FontWeight.w500,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ]),
                              ),
                            )
                          : Container(
                              height: size.height * 0.65,
                              width: size.width * 0.70,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(children: [
                                  // SizedBox(
                                  //   height: size.height * 0.5,
                                  // ),
                                  Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                        ),
                                        height: size.height * 0.45,
                                        width: size.width,
                                        child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ClipRRect(
                                                 borderRadius:
                                                        BorderRadius.circular(
                                                            30), 
                                              child: Image.asset(
                                                "assets/icons/ic_profile1.png",
                                                // scale: 5,
                                                fit: BoxFit.cover,
                                              ),
                                            )),
                                      ),
                                     Positioned(
                                        right: size.width * 0.02,
                                        top: size.height * 0.012,
                                        child: InkWell(
                                          onTap: () {},
                                          child: SizedBox(
                                            height: size.height * 0.04,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: HexColor(color.shareBtnBg!),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              200))),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SvgPicture.asset(
                                                  'assets/icons/share1.svg',
                                                  color: HexColor(color.shareBtnColor!),
                                                  width: size.width * 0.002,
                                                  height: size.height * 0.02,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          right: size.width * 0.19,
                                          left: size.width * 0.19,
                                          top: size.height * 0.41,
                                          child: Container(
                                            height: size.height * 0.04,
                                            width: size.width * 0.3,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5)),
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                height: size.height * 0.04,
                                                width: size.width * 0.04,
                                                child:  Image.asset(
                                            'assets/icons/nfl1.png',
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color,
                                                 scale: 5.5,
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
                                          height: size.height * 0.05,
                                          child:Image.asset(
                                      'assets/icons/nflcard.png',
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color,
                                           scale: 5,
                                          ),
                                        ),
                                        SizedBox(
                                          height: size.height * 0.08,
                                          child: teamImage != null
                                              ? Image.network(
                                                  teamImage.toString(),
                                                  height: size.height * 0.50)
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
                                          height: size.height * 0.04,
                                          child: SvgPicture.asset(
                                            'assets/icons/yearnike.svg',
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color,
                                            width: size.width * 0.01,
                                            height: size.height * 0.03,
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
                                      text: name!.toUpperCase().toString(),
                                      fontsize: size.height * 0.020,
                                      fontcolor:
                                          Theme.of(context).iconTheme.color,
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
                                      text: "${'${nickName!.toUpperCase()} OFFICIAL FAN'}",
                                      fontsize: size.height * 0.012,
                                      fontcolor:
                                          Theme.of(context).iconTheme.color,
                                      fontFamily: fontRegular,
                                      weight: FontWeight.w500,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                      SizedBox(height: size.height * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: VariableText(
                              text: "Welcome to inmortality!",
                              fontsize: size.height * 0.022,
                              fontcolor: textColorW,
                              fontFamily: fontBold,
                              weight: FontWeight.w700,
                              textAlign: TextAlign.center,
                              max_lines: 1,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: size.height * 0.02),
                      photoUploaded
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                VariableText(
                                  text: "Do you like it? ",
                                  fontsize: size.height * 0.016,
                                  fontcolor: textColorW,
                                  fontFamily: fontMedium,
                                  weight: FontWeight.w500,
                                  textAlign: TextAlign.center,
                                ),
                                InkWell(
                                  onTap: () {
                                    _getFromGallery();
                                  },
                                  child: VariableText(
                                    text: "Upload new one",
                                    fontsize: size.height * 0.016,
                                    fontcolor: textColorW,
                                    fontFamily: fontMedium,
                                    weight: FontWeight.w500,
                                    textAlign: TextAlign.center,
                                    underlined: true,
                                  ),
                                )
                              ],
                            )
                          : Row(
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
                                        text: "Choose your ID Card photo",
                                        fontsize: size.height * 0.016,
                                        fontcolor: textColorW,
                                        fontFamily: fontMedium,
                                        weight: FontWeight.w500,
                                        textAlign: TextAlign.center,
                                      )
                              ],
                            ),
                      SizedBox(height: size.height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: MyButton(
                              btnHeight: size.height * 0.055,
                              btnColor: photoUploaded
                                  ? Theme.of(context).primaryColor
                                  : primaryColorW,
                              borderColor: photoUploaded
                                  ? Theme.of(context).primaryColor
                                  : primaryColorW,
                              btnRadius: 200,
                              btnTxt: photoUploaded
                                  ? "Photo Uploaded"
                                  : "Upload your main photo",
                              fontSize: size.height * 0.018,
                              fontFamily: fontSemiBold,
                              weight: FontWeight.w500,
                              txtColor:photoUploaded?Theme.of(context).iconTheme.color: textColor1,
                              onTap: () async {
                                if (photoUploaded == false) {
                                  await _getFromGallery();
                                  setState(() {
                                    photoUploaded = true;
                                  });
                                } else {
                                  print("object");
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.06),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                        // getThemeData();
                        // UserModel userDetails = UserModel(
                        //   img: image1!.path,
                        // );

                        // UserModel userDetails = UserModel();
                        // userDetails.cardImg = image1.toString();
                        if (image1 == null) {
                          customToast("Please Select Your Card Image");
                        } else {
                          Navigator.push(
                              context,
                              SwipeLeftAnimationRoute(
                                  widget: UserProfileImageScreen(
                                teamId: widget.teamId,
                              )));
                        }
                      },
                    ),
                  ),
                ],
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
  // @override
  // void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  //   super.debugFillProperties(properties);
  //   properties.add(DiagnosticsProperty<File?>('image1', image1));
  // }

  // void dispose() {
  //   controller.dispose();
  //   super.dispose();
  // }
}
