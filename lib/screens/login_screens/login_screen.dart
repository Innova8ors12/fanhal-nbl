import 'package:fan_hall/controller/auth/league_api.dart';
import 'package:fan_hall/controller/auth/user_authentications.dart';
import 'package:fan_hall/models/theme_model.dart';
import 'package:fan_hall/models/user_model.dart';
import 'package:fan_hall/providers/theme_provider.dart';
import 'package:fan_hall/providers/userProvider.dart';
import 'package:fan_hall/screens/dashboard/profile/profile_main_screen.dart';
import 'package:fan_hall/screens/reset_password_screens/1_forgot_pass_screen.dart';
import 'package:fan_hall/services/local_preference.dart';
import 'package:fan_hall/widgets/common.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../controller/references.dart';
import '../../widgets/common.dart';
import '../../widgets/style.dart';
import '../dashboard/main_dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _userName = TextEditingController();
  TextEditingController _password = TextEditingController();
  late VideoPlayerController _controller;
  final hPadding = 0.17;

  playVideo() {
    _controller = VideoPlayerController.asset('assets/videos/login1.mp4')
      ..initialize().then((_) {
        _controller.setLooping(true);
        _controller.setVolume(0.0);
        _controller.play();
        setState(() {});
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    playVideo();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  bool isLoading = false;
  setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

  validate() {
    bool allSet = false;
    if (_userName.text.isNotEmpty) {
      if (_password.text.isNotEmpty) {
        return true;
      } else {
        Fluttertoast.showToast(
            msg: "Please enter password", toastLength: Toast.LENGTH_SHORT);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Please enter email", toastLength: Toast.LENGTH_SHORT);
    }
    return allSet;
  }

  loginUser() async {
    setLoading(true);
    if (validate()) {
      UserModel user = UserModel(
        username: _userName.text.trim(),
        token: _password.text.trim(),
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
          teamImage = userModel.team!.img!;
          nickName=userModel.team!.nickName!;
          await preferenceController.setUserToken(userModel.token!);
          Provider.of<UserProvider>(context, listen: false).setUser(userModel);
          var res = await ApiModel().getTheme(teamId!.toString());
          if (res['status'].toString() == "true") {
            Theme1Model themeModel = Theme1Model.fromJson(res['data']);
            Provider.of<ThemeProvider>(context, listen: false)
                .settheme(themeModel);
          }
          setLoading(false);
          selectedNationality="";
          selectedRegion="";
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
  }

  UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          if (_controller.value.isInitialized) VideoPlayer(_controller),
          Positioned.fill(
            child: Container(
              color: const Color(0xFF000000).withOpacity(0.6),
            ),
          ),
       
          Positioned.fill(
            child: SafeArea(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: size.width * hPadding),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: size.height * 0.20),
                      Image.asset("assets/icons/ic_logo.png", scale: 5.8),
                      SizedBox(height: size.height * 0.04),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: VariableText(
                              text: "We’re glad you’re back!",
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

                      ///username
                      MyRoundTextField(
                        text: "Enter username or Email",
                        cont: _userName,
                      ),
                      SizedBox(height: size.height * 0.02),

                      ///password
                     PasswordTextField(
                        hint: "Enter password",
                        cont: _password,
                        obscure: true,
                      ),
                      SizedBox(height: size.height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                                : MyButton(
                                    btnHeight: size.height * 0.055,
                                    btnColor: primaryColorW,
                                    borderColor: primaryColorW,
                                    btnRadius: 200,
                                    btnTxt: "Login",
                                    fontSize: size.height * 0.018,
                                    fontFamily: fontSemiBold,
                                    weight: FontWeight.w500,
                                    txtColor: textColor1,
                                    onTap: () {
                                      loginUser();
                                    },
                                  ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.04),

                      ///Forgot pass
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                                  context,
                                  SwipeLeftAnimationRoute(
                                      widget: ForgotPassScreen()))
                              .then((value) => playVideo());
                        },
                        child: VariableText(
                          text: "Forgot my password.",
                          fontsize: size.height * 0.018,
                          fontcolor: textColorW,
                          fontFamily: fontMedium,
                          weight: FontWeight.w500,
                          textAlign: TextAlign.center,
                          underlined: true,
                        ),
                      )
                    ],
                  ),
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
      ),
    );
  }
}
