import 'package:checkout_screen_ui/validation.dart';
import 'package:fan_hall/controller/auth/league_api.dart';
import 'package:fan_hall/controller/auth/user_authentications.dart';
import 'package:fan_hall/models/user_model.dart';
import 'package:fan_hall/screens/registration_screens/2_user_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:text_form_field_validator/text_form_field_validator.dart';
import 'package:flutter_textfield_validation/flutter_textfield_validation.dart';
import 'package:regexed_validator/regexed_validator.dart';
import 'package:text_form_field_validator/text_form_field_validator.dart';
import '../../widgets/common.dart';
import '../../widgets/style.dart';
import '../login_screens/welcome_screen.dart';

class UserCredentialsScreen extends StatefulWidget {
  UserCredentialsScreen({Key? key}) : super(key: key);

  @override
  State<UserCredentialsScreen> createState() => _UserCredentialsScreenState();
}

class _UserCredentialsScreenState extends State<UserCredentialsScreen> {
  //   void initState() {
  TextEditingController usernameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController cityController = TextEditingController();

  String? selectedGender;

  String? selectedNationality;
  bool invalidUsername = false;
  bool invalidUsernameEmail = false;
  final _formKey = GlobalKey<FormState>();

  bool _isValid = false;
  DateFormat dobFormatter = DateFormat("dd-MM-yyyy");

  String? selectedDate;

  // setState(() {});
  bool isLoading = false;

  bool? loading;

  void setLoading(bool loading) {
    isLoading = loading;
    // setState(() {
    //   isLoading = loading;
    // });
  }

  //    checkEnabled(){
  Future validateUsername() async {
    setLoading(true);
    var response = await ApiModel.checkUserName(usernameController.text);
    if (response != null) {
      if (response) {
        setState(() {
          invalidUsername = false;
        });
        setLoading(false);
        return true;
      } else {
        setLoading(false);
        setState(() {
          invalidUsername = true;
        });
        return false;
      }
    } else {
      setLoading(false);
      Fluttertoast.showToast(
          msg: "Try again later", toastLength: Toast.LENGTH_SHORT);
      return false;
    }
  }

  Future validateUsernameEmail() async {
    setLoading(true);
    var response = await ApiModel.checkUserNameEmail(emailController.text);
    if (response != null) {
      if (response) {
        setState(() {
          invalidUsernameEmail = false;
        });
        setLoading(false);
        return true;
      } else {
        setLoading(false);
        setState(() {
          invalidUsernameEmail = true;
        });
        return false;
      }
    } else {
      setLoading(false);
      Fluttertoast.showToast(
          msg: "Try again later", toastLength: Toast.LENGTH_SHORT);
      return false;
    }
  }

  validate(BuildContext context) {
    bool allSet = false;
    if (nameController.text.isNotEmpty) {
      if (usernameController.text.isNotEmpty) {
        if (passwordController.text.isNotEmpty) {
          if (emailController.text.isNotEmpty) {
            if (nameController.text.isNotEmpty ||
                usernameController.text.isNotEmpty ||
                emailController.text.isNotEmpty ||
                passwordController.text.isNotEmpty) {
              userName = usernameController.text.toLowerCase();
              name = nameController.text.toLowerCase();
              password = passwordController.text.toLowerCase();
              email = emailController.text.toString();
            
                 
            }
          } else {
            Fluttertoast.showToast(
                msg: "Please enter Email", toastLength: Toast.LENGTH_SHORT);
          }
        } else {
          Fluttertoast.showToast(
              msg: "Please enter password", toastLength: Toast.LENGTH_SHORT);
        }
      } else {
        Fluttertoast.showToast(
            msg: "Please enter username", toastLength: Toast.LENGTH_SHORT);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Please enter name", toastLength: Toast.LENGTH_SHORT);
    }

    return allSet;
  }

  // UserModel userDetails =
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double padding = size.width * 0.05;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              child: Image.asset("assets/images/welcome_background.png",
                  fit: BoxFit.cover),
            ),
          ),
          Positioned.fill(
            child: Container(
              color: const Color(0xFF000000).withOpacity(0.8),
            ),
          ),
          Container(
            child: Positioned.fill(
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.17,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: size.height * 0.15),
                        Image.asset("assets/icons/ic_logo.png", scale: 5.8),
                        SizedBox(height: size.height * 0.04),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: VariableText(
                                text: "Start your journey to become a fan!",
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

                        ///nameController
                        MyRoundTextField(
                          text: "Enter name",
                          cont: nameController,
                          //              validator: (email) {
                          //    if (isEmailValid(email)) return null;
                          //    else
                          //      return 'Enter a valid email address';
                          //  },
                        ),
                        SizedBox(height: size.height * 0.02),

                        ///usernameController
                        MyRoundTextField(
                          text: "Enter username",
                          cont: usernameController,
                        ),
                        if (invalidUsername)
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: padding,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  VariableText(
                                    text: 'Username already taken!',
                                    fontcolor: Colors.red,
                                    fontsize: size.height * 0.016,
                                  ),
                                   Icon(Icons.close,color:Colors.red ,)
                                ],
                              ),
                            ),
                          )
                          
                          ,
                        invalidUsername
                            ? SizedBox(height: size.height * 0)
                            : Container(),
                        // SizedBox(height: size.height * 0.01),
                        SizedBox(height: size.height * 0.02),
                        MyRoundTextField(
                          key: _formKey,
                          inputType: TextInputType.emailAddress,
                          text: "Enter Email",
                          cont: emailController,
                          validator: (value) {
                            // if (value.isEmpty) {
                            //   return 'Please enter your email';
                            // }
                            bool emailValid = RegExp(
                                    r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value);
                            if (!emailValid) {
                              return customToast("'Please enter a valid email'");
                            }
                            return null;
                          },
                          onChange: (value) {
                            setState(() {
                              _isValid = _formKey.currentState!.validate();
                            });
                          },
                        ),
                        if (invalidUsernameEmail)
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: padding,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: Row(
                                children: [
                                  VariableText(
                                    text: 'Email already taken!',
                                    fontcolor: Colors.red,
                                    fontsize: size.height * 0.016,
                                  ),
                                  Icon(Icons.close,color:Colors.red ,)
                                ],
                              ),
                            ),
                          ),
                        invalidUsernameEmail
                            ? SizedBox(height: size.height * 0)
                            : Container(),
                        SizedBox(height: size.height * 0.01),

                        ///passwordController
                        PasswordTextField(
                          hint: "Choose password",
                          obscure: true,
                          hintColor: Theme.of(context).hintColor,
                          // prefixChild: ,

                          cont: passwordController,
                        ),
                        SizedBox(height: size.height * 0.10),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
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
                    child:isLoading? SizedBox(
                            height: size.height * 0.05,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          )
                        :MyButtonIcon(
                      btnHeight: size.height * 0.055,
                      btnColor: primaryColorW,
                      borderColor: primaryColorW,
                      btnRadius: 200,
                      btnTxt: "Continue",
                      fontSize: size.height * 0.018,
                      fontFamily: fontSemiBold,
                      weight: FontWeight.w500,
                      txtColor: textColor1,
                      onTap: () async {
                      
                       
                         
                        await validate(context);
                        setLoading(true);
                         var response = await validateUsername();
                        var response1 = await validateUsernameEmail();
                        if (response && response1) {
                            
                          UserModel userDetails = UserModel();
                          userDetails.username = usernameController.text;
                          userDetails.name = nameController.text;
                          userDetails.token = passwordController.text;
                          userDetails.email = emailController.text;
                          selectedNationality = null;
                          setLoading(false);
                            Navigator.pushReplacement(
                      context,
                      SwipeLeftAnimationRoute(
                          milliseconds: 200, widget: const UserDetailsScreen()))
               ;
                        } else {
                          customToast("Please Put Correct info");
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
}
