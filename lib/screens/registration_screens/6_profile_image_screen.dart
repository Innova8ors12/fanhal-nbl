import 'dart:convert';
import 'dart:io';

import 'package:fan_hall/controller/auth/league_api.dart';
import 'package:fan_hall/controller/auth/user_authentications.dart';
import 'package:fan_hall/controller/services/local_preferences.dart';
import 'package:fan_hall/models/theme_model.dart';
import 'package:fan_hall/models/user_model.dart';
import 'package:fan_hall/providers/theme_provider.dart';
import 'package:fan_hall/providers/userProvider.dart';
import 'package:fan_hall/screens/dashboard/main_dashboard.dart';
import 'package:fan_hall/screens/registration_screens/image_from_gallery.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../widgets/common.dart';
import '../../widgets/style.dart';
import '../login_screens/welcome_screen.dart';

class UserProfileImageScreen extends StatefulWidget {
  String teamId;
  // File? img;
  UserProfileImageScreen({
    Key? key,
    required this.teamId,
  }) : super(key: key);

  @override
  State<UserProfileImageScreen> createState() => _UserProfileImageScreenState();
}

class _UserProfileImageScreenState extends State<UserProfileImageScreen> {
  bool photoUploaded = false;

  bool isLoading = false;

  void setLoading(bool loading) {
    isLoading = loading;
    setState(() {
      isLoading = loading;
    });
  }

  File? imageProfile;
  loginUser() async {
    setLoading(true);

    UserModel user = UserModel(
      username: userName,
      token: password,
    );
    var response = await AuthenticationService().loginUser(user);

    if (response is Map) {
      if (response['status'].toString() == "true") {
        UserModel userModel = UserModel.fromJson(response['data']);
        print("ye mera token hai " + userModel.token!);
        name = userModel.name!;
        userName = userModel.username!;
        teamId = userModel.teamId!;
        cardImage = userModel.cardImg!;
        accessToken = userModel.token!;
        nickName = userModel.team!.nickName!;
        // leagueImage=userModel.
        LocalPreference lp = LocalPreference();

        lp.setUserToken(userModel.token!);
        Provider.of<UserProvider>(context, listen: false).setUser(userModel);
        var res = await ApiModel().getTheme(teamId!.toString());
        if (res['status'].toString() == "true") {
          Theme1Model themeModel = Theme1Model.fromJson(res['data']);
          Provider.of<ThemeProvider>(context, listen: false)
              .settheme(themeModel);
        }
        setLoading(false);
        Fluttertoast.showToast(
            msg: "Login Successful", toastLength: Toast.LENGTH_SHORT);
        Navigator.pushAndRemoveUntil(
            context,
            SwipeLeftAnimationRoute(widget: MainDashboard()),
            (route) => route.isCurrent);
      } else {
        setLoading(false);
        Fluttertoast.showToast(
            msg: response['msg'], toastLength: Toast.LENGTH_SHORT);
      }
    } else {
      setLoading(false);
      Fluttertoast.showToast(
          msg: response.toString(), toastLength: Toast.LENGTH_SHORT);
    }
  }

  UserModel? userModel;

  createUser() async {
    setLoading(true);

   

    UserModel userDetails = UserModel(
        name: name,
        username: userName,
        email: email,
        token: password,
        img: imageProfile!.path,
        cardImg: image1!.path,
        teamId: int.parse(widget.teamId),
        leagueName: leagueName,
        city: selectedcity,
        dob: selectedDate,
        gender: selectedGender,
        latitude: lat!.toString(),
        longitude: long!.toString(),
        nationality: selectedNationality
        );

    print(userDetails.token);
    var response = await AuthenticationService().userCreate(userDetails);
    print(response);
    if (response['status']) {
      setLoading(false);
      Fluttertoast.showToast(
          msg: "Account created Successful", toastLength: Toast.LENGTH_SHORT);
      loginUser();
    } else {
      setLoading(false);
      Fluttertoast.showToast(
          msg: response['msg'], toastLength: Toast.LENGTH_SHORT);
    }
    // } else {
    //   setLoading(false);
    //   Fluttertoast.showToast(
    //       msg: " error " + response, toastLength: Toast.LENGTH_SHORT);
    // }
  }

  Future<void> _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageProfile = File(pickedFile.path.toString());
      });
      print(imageProfile);
    }
  }

  @override
  void initState() {
    TextEditingController userName = TextEditingController();
    TextEditingController name = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController city = TextEditingController();
    String? selectedGender;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

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
          Container(
            child: Positioned.fill(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: size.height * 0.2),
                    photoUploaded
                        ? Container(
                            height: size.width * 0.5,
                            width: size.width * 0.7,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: Theme.of(context).primaryColor),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(children: [
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(
                                          height: size.height * 0.07,
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
                                        Container(
                                          child: imageProfile != null
                                              ? CircleAvatar(
                                                  radius: 50,
                                                  backgroundImage: FileImage(
                                                    imageProfile!,
                                                  ),
                                                  // onBackgroundImageError: (e, s) {
                                                  //   debugPrint(
                                                  //       'image issue, $e,$s');
                                                  // },
                                                  child: Text(""))
                                              : Container(
                                                  height: size.height * 0.1,
                                                  child: Center(
                                                      child: Text(
                                                    "Image No found!!!",
                                                    style: TextStyle(
                                                        color: textColorB),
                                                  ))),
                                        ),
                                        SizedBox(
                                          height: size.height * 0.04,
                                          child: leagueImage != null
                                              ? selectedNationality ==
                                                      "Canada"
                                                  ? Image.asset(
                                                      "assets/icons/canadaflag.png",
                                                      height:
                                                          size.height * 0.04,
                                                      width: size.width * 0.12,
                                                      fit: BoxFit.fill,
                                                    )
                                                  : selectedNationality ==
                                                          "United States"
                                                      ? Image.asset(
                                                          "assets/icons/usaflag.png",
                                                          height: size.height *
                                                              0.04,
                                                          width:
                                                              size.width * 0.12,
                                                          fit: BoxFit.fill,
                                                        )
                                                      :  selectedNationality ==
                                                          "Mexico"
                                                      ?Image.asset(
                                                          "assets/icons/mexicoflag.png",
                                                          height: size.height *
                                                              0.04,
                                                          width:
                                                              size.width * 0.12,
                                                          fit: BoxFit.fill,
                                                        ):Container()
                                              : Container(
                                                  width: size.width * 0.05,
                                                  child: Center(
                                                      child: Text(
                                                    "No Team !",
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 192, 57, 57)),
                                                  )),
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
                                      fontsize: size.height * 0.018,
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
                                      text:
                                          "${'${nickName!.toUpperCase()} OFFICIAL FAN'}",
                                      fontsize: size.height * 0.010,
                                      fontcolor:
                                          Theme.of(context).iconTheme.color,
                                      fontFamily: fontBold,
                                      weight: FontWeight.w500,
                                      textAlign: TextAlign.center,
                                      max_lines: 2,
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                          )
                        : Container(
                            height: size.width * 0.5,
                            width: size.width * 0.7,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: Theme.of(context).primaryColor),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(children: [
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(
                                          height: size.height * 0.07,
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
                                        Container(
                                          child: CircleAvatar(
                                              radius: 50,
                                              backgroundImage: AssetImage(
                                                "assets/icons/ic_profile1.png",
                                              ),
                                              // onBackgroundImageError: (e, s) {
                                              //   debugPrint(
                                              //       'image issue, $e,$s');
                                              // },
                                              child: Text("")),
                                        ),
                                        SizedBox(
                                          height: size.height * 0.04,
                                          width: size.width * 0.15,
                                          child: leagueImage != null
                                              ? selectedNationality ==
                                                      "Canada"
                                                  ? Image.asset(
                                                      "assets/icons/canadaflag.png",
                                                      height:
                                                          size.height * 0.04,
                                                      width: size.width * 0.12,
                                                      fit: BoxFit.fill,
                                                    )
                                                  : selectedNationality ==
                                                          "United States"
                                                      ? Image.asset(
                                                          "assets/icons/usaflag.png",
                                                          height: size.height *
                                                              0.04,
                                                          width:
                                                              size.width * 0.12,
                                                          fit: BoxFit.fill,
                                                        )
                                                      :  selectedNationality ==
                                                          "Mexico"
                                                      ?Image.asset(
                                                          "assets/icons/mexicoflag.png",
                                                          height: size.height *
                                                              0.04,
                                                          width:
                                                              size.width * 0.12,
                                                          fit: BoxFit.fill,
                                                        ):Container()
                                              : Container(
                                                  width: size.width * 0.05,
                                                  child: Center(
                                                      child: Text(
                                                    "No Team !",
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 192, 57, 57)),
                                                  )),
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
                                      text:
                                          "${'${nickName!.toUpperCase()} OFFICIAL FAN'}",
                                      fontsize: size.height * 0.012,
                                      fontcolor:
                                          Theme.of(context).iconTheme.color,
                                      fontFamily: fontBold,
                                      weight: FontWeight.w500,
                                      textAlign: TextAlign.center,
                                      max_lines: 2,
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                          ),
                    SizedBox(height: size.height * 0.01),
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
                              VariableText(
                                text: "Choose your profile pic.",
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
                                : "Upload your profile picture",
                            fontSize: size.height * 0.018,
                            fontFamily: fontSemiBold,
                            weight: FontWeight.w500,
                            txtColor: photoUploaded
                                ? Theme.of(context).iconTheme.color
                                : textColor1,
                            onTap: () {
                              if (photoUploaded == false) {
                                _getFromGallery();
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
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: MyBackButton(),
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
                    child: isLoading == true
                        ? SizedBox(
                            height: size.height * 0.05,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          )
                        : MyButtonIcon(
                            btnHeight: size.height * 0.055,
                            btnColor: primaryColorW,
                            borderColor: primaryColorW,
                            btnRadius: 200,
                            btnTxt: "Finish",
                            fontSize: size.height * 0.018,
                            fontFamily: fontSemiBold,
                            weight: FontWeight.w500,
                            txtColor: textColor1,
                            onTap: () {
                              createUser();
                              // Navigator.pushAndRemoveUntil(
                              //     context,
                              //     SwipeLeftAnimationRoute(
                              //         widget: WelcomeScreen()),
                              //     (route) => route.isCurrent);
                              /*Navigator.push(
                                      context,
                                      SwipeRightAnimationRoute(widget: WelcomeScreen()));*/
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
