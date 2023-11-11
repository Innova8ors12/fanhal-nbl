import 'dart:io';
import 'dart:math';
import 'package:fan_hall/models/teams_model1.dart';
import 'package:fan_hall/providers/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'style.dart';

final String? SECRET_KEY =
    "sk_test_51MOTAWLyijXiZsW8kmersxw9eizWTaqfH1VYZAzNOhxOgjBEQHcoBTGrterxYNluscCerb2nJa8nbGqHwvwpWcrY00J7YLrbtA";
File? imageFile;
List<String> nationalities1 = [];
List<String> region1 = [];

List<String> img = [];
List<Teams> allTeamsList1 = [];
String? americanId;
var postcount;

String? teamImage;
String? teamImage1;
String? lat;
String? long;

String? accessToken;
String? latitude = "23225";
String? longitude = "12120521";
String? selectedHero;
String? nickName = "";
String? herostype;
String? leagueName;
String? nationalId;
String? SeasonYear;
String? selectedmomentId;
int? teamId;
String? email;
String? selectedcity;
String? name = "syed soban";
String? userName = "syed soban";
File? image1;
bool? isupLoading;
File? image_post;
File? imageFile1;
String? leagueImage;
File? imageProfile;
String? cardImage;
String? selectedGender;
String? americanLeagueName;
String? nationalLeagueName;
String? sharebtncolor;
String? navbarselected;
String? sharebtnbg;
String? password = "soban";
Color primarycolor = Color(0xFFFFB612);
String? selectedNationality;
String? selectedRegion;
DateFormat dobFormatter = DateFormat("dd-MM-yyyy");
String? selectedDate;
String? kprimaryColor = "";
// TextEditingController _city = TextEditingController();
// // File? _image;
// TextEditingController _username = TextEditingController();
// TextEditingController _name = TextEditingController();
// TextEditingController _password = TextEditingController();

class VariableText extends StatelessWidget {
  final String? text;
  final Color? fontcolor;
  final TextAlign? textAlign;
  final FontWeight weight;
  final bool underlined, linethrough;
  final String fontFamily;
  final double? fontsize, line_spacing, letter_spacing;
  final int? max_lines;
  final TextOverflow overflow;
  final FontStyle fontStyle;
//final double minfontsize,scalefactor,fontsize;

  const VariableText({
    this.text,
    this.fontcolor = textColor1,
    this.fontsize = 15,
    this.textAlign,
    this.weight = FontWeight.normal,
    this.fontStyle = FontStyle.normal,
    this.underlined = false,
    this.line_spacing,
    this.letter_spacing = 0.7,
    this.max_lines, //double line_spacing=1.2,
    this.fontFamily = fontRegular,
    this.overflow = TextOverflow.ellipsis,
    this.linethrough = false,
// this.minfontsize=10,//this.scalefactor,
  });

  @override
  Widget build(BuildContext context) {
    //var media=MediaQuery.of(context);
    return Text(
      text!,
      maxLines: max_lines,
      overflow: overflow,
      textAlign: textAlign,
      //textScaleFactor: 1,
      style: TextStyle(
        color: fontcolor, fontWeight: weight,
        height: line_spacing,
        letterSpacing: letter_spacing,
        fontSize: fontsize,
        fontStyle: fontStyle,
        //  fontSize: fontsize,
        fontFamily: fontFamily,
        decorationThickness: 2.0,
        decoration: underlined
            ? TextDecoration.underline
            : (linethrough ? TextDecoration.lineThrough : TextDecoration.none),
      ),
    );
  }
}

class CodeField extends StatelessWidget {
  final TextEditingController? cont, next_cont;
  final String? hinttext;
  // final Widget icon;
  final bool texthidden, readonly;
  final TextAlign textAlign;
  Function? onComplete;
  final Color? enableColor;
  final Color? focusColor;
  final double? radius;

  CodeField({
    this.cont,
    this.hinttext,
    this.texthidden = false,
    this.readonly = false,
    //this.icon,
    this.onComplete,
    this.next_cont,
    this.textAlign = TextAlign.center,
    this.radius,
    this.enableColor,
    this.focusColor,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // var radius = size.width * 0.25;
    return TextField(
      onChanged: (x) {
        print("onchange");
        if (cont!.text.isNotEmpty) {
          FocusScope.of(context).nextFocus();
        } else {
          FocusScope.of(context).previousFocus();
        }
        if (next_cont != null) {
          next_cont!.text = "";
        }
        onComplete!(x);
      },
      controller: cont,
      maxLength: 1,
      obscureText: texthidden,
      readOnly: readonly,
      textAlign: textAlign,
      keyboardType: TextInputType.number,
      style: TextStyle(
        fontSize: 18, //fontFamily: fontNormal
      ),
      decoration: InputDecoration(
        counterText: "",
        contentPadding: EdgeInsets.only(top: 10, bottom: 10, left: 2),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                radius! == null ? size.width * 0.25 : radius!)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
              radius! == null ? size.width * 0.25 : radius!),
          borderSide: BorderSide(
              color: enableColor == null ? enableColor! : enableColor!,
              width: enableColor == null ? 2.0 : 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
              radius! == null ? size.width * 0.25 : radius!),
          borderSide: BorderSide(
              color: focusColor! == null ? Color(0xffFC1F61) : focusColor!,
              width: 1.0),
        ),
        fillColor: Theme.of(context).highlightColor,
        // fillColor: Colors.black,
        filled: true,
        hintText: hinttext,
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  final String? btnTxt;
  final double? btnHeight;
  final double? btnWidth;
  final Function()? onTap;
  final Color? btnColor;
  final Color? txtColor;
  final double? btnRadius;
  final double? fontSize;
  final FontWeight? weight;
  final Color? borderColor;
  final fontFamily;

  MyButton({
    this.btnTxt = "Test",
    this.borderColor = primaryColor1,
    this.weight = FontWeight.w500,
    this.fontSize = 20,
    this.btnRadius = 8,
    this.onTap,
    this.btnHeight,
    this.btnWidth,
    this.btnColor = primaryColor1,
    this.txtColor = textColorW,
    this.fontFamily = fontMedium,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: btnHeight,
      width: btnWidth != null ? btnWidth : null,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          primary: btnColor, //textStyle: TextStyle(color: Color(0xff000000)),
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: borderColor != null ? borderColor! : btnColor!,
                  width: 2),
              borderRadius: BorderRadius.circular(btnRadius!)),
        ),
        onPressed: onTap ?? null,
        child: Center(
          child: FittedBox(
            child: VariableText(
              text: btnTxt,
              fontcolor: txtColor,
              weight: weight!,
              max_lines: 1,
              fontsize: fontSize,
              fontFamily: fontFamily,
            ),
          ),
        ),
      ),
    );
  }
}

class MyButtonIcon extends StatelessWidget {
  final String? btnTxt;
  final double? btnHeight;
  final double? btnWidth;
  final Function()? onTap;
  final Color? btnColor;
  final Color? txtColor;
  final double? btnRadius;
  final double? fontSize;
  final FontWeight? weight;
  final Color? borderColor;
  final fontFamily;

  MyButtonIcon({
    this.btnTxt = "Test",
    this.borderColor = primaryColor1,
    this.weight = FontWeight.w500,
    this.fontSize = 20,
    this.btnRadius = 8,
    this.onTap,
    this.btnHeight,
    this.btnWidth,
    this.btnColor = primaryColor1,
    this.txtColor = textColorW,
    this.fontFamily = fontMedium,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: btnHeight,
      width: btnWidth != null ? btnWidth : null,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          primary: btnColor, //textStyle: TextStyle(color: Color(0xff000000)),
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: borderColor != null ? borderColor! : btnColor!,
                  width: 2),
              borderRadius: BorderRadius.circular(btnRadius!)),
        ),
        onPressed: onTap ?? null,
        child: Center(
          child: FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 10),
                VariableText(
                  text: btnTxt,
                  fontcolor: txtColor,
                  weight: weight!,
                  max_lines: 1,
                  fontsize: fontSize,
                  fontFamily: fontFamily,
                ),
                const SizedBox(width: 10),
                Icon(Icons.arrow_forward, color: txtColor)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyButtonPrefixIcon extends StatelessWidget {
  final String? btnTxt;
  final double? btnHeight;
  final double? btnWidth;
  final Function()? onTap;
  final Color? btnColor;
  final Color? txtColor;
  final double? btnRadius;
  final double? fontSize;
  final FontWeight? weight;
  final Color? borderColor;
  final fontFamily;
  final String? icon;

  MyButtonPrefixIcon({
    this.btnTxt = "Test",
    this.icon,
    this.borderColor = primaryColor1,
    this.weight = FontWeight.w500,
    this.fontSize = 20,
    this.btnRadius = 8,
    this.onTap,
    this.btnHeight,
    this.btnWidth,
    this.btnColor = primaryColor1,
    this.txtColor = textColorW,
    this.fontFamily = fontMedium,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: btnHeight,
      width: btnWidth != null ? btnWidth : null,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          primary: btnColor, //textStyle: TextStyle(color: Color(0xff000000)),
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: borderColor != null ? borderColor! : btnColor!,
                  width: 2),
              borderRadius: BorderRadius.circular(btnRadius!)),
        ),
        onPressed: onTap ?? null,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(flex: 20, child: Image.asset(icon!, scale: 2)),
              //SizedBox(width: 10),
              Expanded(
                flex: 55,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    VariableText(
                      text: btnTxt,
                      fontcolor: txtColor,
                      weight: weight!,
                      max_lines: 1,
                      fontsize: fontSize,
                      fontFamily: fontFamily,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyButtonPostfixIcon extends StatelessWidget {
  final String? btnTxt;
  final double? btnHeight;
  final double? btnWidth;
  final Function()? onTap;
  final Color? btnColor;
  final Color? txtColor;
  final double? btnRadius;
  final double? fontSize;
  final FontWeight? weight;
  final Color? borderColor;
  final fontFamily;
  final String? icon;
  final Color? iconColor;

  MyButtonPostfixIcon({
    this.btnTxt = "Test",
    this.icon,
    this.iconColor,
    this.borderColor = primaryColor1,
    this.weight = FontWeight.w500,
    this.fontSize = 20,
    this.btnRadius = 8,
    this.onTap,
    this.btnHeight,
    this.btnWidth,
    this.btnColor = primaryColor1,
    this.txtColor = textColorW,
    this.fontFamily = fontMedium,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: btnHeight,
      width: btnWidth != null ? btnWidth : null,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          primary: btnColor, //textStyle: TextStyle(color: Color(0xff000000)),
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: borderColor != null ? borderColor! : btnColor!,
                  width: 2),
              borderRadius: BorderRadius.circular(btnRadius!)),
        ),
        onPressed: onTap ?? null,
        child: Stack(
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        VariableText(
                          text: btnTxt,
                          fontcolor: txtColor,
                          weight: weight!,
                          max_lines: 1,
                          fontsize: fontSize,
                          fontFamily: fontFamily,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(icon!, scale: 2, color: iconColor)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyBackButton extends StatelessWidget {
  const MyBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => Navigator.of(context).pop(),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * horizontalPadding,
            vertical: size.height * 0.015),
        child: const Icon(Icons.arrow_back, color: primaryColorW),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  String? text;
  bool? isBack;
  String? actionImage;
  double? height;
  PopupMenuButton? actionOnTap;
  bool isActionBar;

  CustomAppBar({
    Key? key,
    this.text,
    this.isBack,
    this.actionImage,
    this.height,
    this.actionOnTap,
    this.isActionBar = true,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(height!);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: preferredSize.height,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/appbar_background.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
      leading: isBack!
          ? InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Image.asset(
                "assets/icons/ic_back.png",
                scale: 2,
              ),
            )
          : null,
      title: VariableText(
        text: text,
        fontFamily: fontMedium,
        fontsize: size.height * 0.026,
        fontcolor: textColorW,
      ),
      actions: isActionBar
          ? [
              actionOnTap == null
                  ? InkWell(
                      onTap: () {
                        actionOnTap;
                      },
                      child: Image.asset(
                        actionImage!,
                        scale: 2.2,
                      ),
                    )
                  : actionOnTap!,
            ]
          : [],
      backgroundColor: textColorW,
      centerTitle: true,
    );
  }
}

class NoAnimationRoute extends PageRouteBuilder {
  final Widget? widget;

  NoAnimationRoute({this.widget})
      : super(
          transitionDuration: Duration(milliseconds: 200),
          pageBuilder: (context, anim1, anim2) {
            return widget!;
          },
        );
}

class SwipeLeftAnimationRoute extends PageRouteBuilder {
  final Widget? widget;
  final int milliseconds;
  SwipeLeftAnimationRoute({this.widget, this.milliseconds = 200})
      : super(
          transitionDuration: Duration(
            milliseconds: milliseconds,
          ),
          pageBuilder: (context, anim1, anim2) => widget!,
          transitionsBuilder: (context, anim1, anim2, child) {
            var begin = Offset(1, 0);
            var end = Offset(0, 0);
            var tween = Tween<Offset>(begin: begin, end: end);
            var offsetAnimation = anim1.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
}

class SwipeRightAnimationRoute extends PageRouteBuilder {
  final Widget? widget;
  final int milliseconds;
  SwipeRightAnimationRoute({
    this.widget,
    this.milliseconds = 200,
  }) : super(
          transitionDuration: Duration(
            milliseconds: milliseconds,
          ),
          pageBuilder: (context, anim1, anim2) => widget!,
          transitionsBuilder: (context, anim1, anim2, child) {
            var begin = Offset(-1, 0);
            var end = Offset(0, 0);
            var tween = Tween<Offset>(begin: begin, end: end);
            var offsetAnimation = anim1.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
}

class SwipeUpAnimationRoute extends PageRouteBuilder {
  final Widget? widget;
  final int milliseconds;
  SwipeUpAnimationRoute({
    this.widget,
    this.milliseconds = 200,
  }) : super(
          transitionDuration: Duration(
            milliseconds: milliseconds,
          ),
          pageBuilder: (context, anim1, anim2) => widget!,
          transitionsBuilder: (context, anim1, anim2, child) {
            var begin = Offset(0, 1);
            var end = Offset(0, 0);
            var tween = Tween<Offset>(begin: begin, end: end);
            var offsetAnimation = anim1.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
}

class FadeAnimationRoute extends PageRouteBuilder {
  final Widget? widget;
  final int milliseconds;
  FadeAnimationRoute({
    this.widget,
    this.milliseconds = 200,
  }) : super(
          transitionDuration: Duration(
            milliseconds: milliseconds,
          ),
          pageBuilder: (context, anim1, anim2) => widget!,
          transitionsBuilder: (context, anim1, anim2, child) {
            var begin = Offset(0, 1);
            var end = Offset(0, 0);
            var tween = Tween<Offset>(begin: begin, end: end);
            //var offsetAnimation = anim1.drive(tween);
            return FadeTransition(
              opacity: anim1,
              //position: offsetAnimation,
              child: child,
            );
          },
        );
}

class MyTextField extends StatelessWidget {
  String? text;
  TextEditingController? cont;
  TextInputAction? inputAction;
  TextInputType? inputType;
  Function? validator;
  bool? obscure;

  MyTextField(
      {Key? key,
      this.text,
      this.cont,
      this.validator,
      this.obscure = false,
      this.inputAction = TextInputAction.next,
      this.inputType = TextInputType.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return TextFormField(
      controller: cont,
      textInputAction: inputAction,
      keyboardType: inputType,
      //validator: (value)=> validator(value),
      style: TextStyle(
        fontFamily: fontRegular,
        color: Theme.of(context).textTheme.titleMedium!.color,
        fontSize: size.height * 0.016,
      ),
      obscureText: obscure!,
      decoration: InputDecoration(
          hintText: text,
          hintStyle: TextStyle(color: Theme.of(context).hintColor),
          filled: true,
          fillColor: Theme.of(context).highlightColor,
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).focusColor, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).backgroundColor, width: 1.0),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 3, horizontal: 12)
          //contentPadding: EdgeInsets.only(left: 12, right: 8, bottom: 0)
          ),
    );
  }
}

class MyRoundTextField extends StatelessWidget {
  String? text;
  TextEditingController? cont;
  int? lenght;
  TextInputAction? inputAction;
  TextInputType? inputType;
  Function? validator;
  Function? onChange;
  bool? obscure;
  Color? fontColor;
  Color? hintColor;
  bool? filled;
  Color? filledColor;

  MyRoundTextField(
      {Key? key,
      this.text,
      this.cont,
      this.lenght,
      this.validator,
      this.onChange,
      this.obscure = false,
      this.inputAction = TextInputAction.next,
      this.inputType = TextInputType.text,
      this.filled = false,
      this.filledColor = Colors.transparent,
      this.fontColor = primaryColorW,
      this.hintColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return TextFormField(
      controller: cont,
      maxLength: lenght,
      textInputAction: inputAction,
      keyboardType: inputType,
      validator: (value) => validator!(value),
      // onChanged: (value) => onChange!(value),
      style: TextStyle(
        fontFamily: fontMedium,
        color: fontColor,
        fontSize: size.height * 0.018,
      ),

      obscureText: obscure!,
      decoration: InputDecoration(
          hintText: text,
          hintStyle: TextStyle(
              fontFamily: fontMedium,
              color:
                  hintColor != null ? hintColor : Theme.of(context).hintColor),
          filled: filled,
          fillColor: filledColor,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(200),
            borderSide: BorderSide(color: primaryColorW, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(200),
            borderSide: BorderSide(color: primaryColorW, width: 2.0),
          ),
          contentPadding: EdgeInsets.symmetric(
              vertical: size.height * 0.021, horizontal: size.width * 0.06)
          //contentPadding: EdgeInsets.only(left: 12, right: 8, bottom: 0)
          ),
    );
  }
}

class FullScreenImage extends StatefulWidget {
  FullScreenImage(
      {this.child,
      this.dark,
      this.onDelete,
      this.content,
      this.hasDelete = true});

  final Image? child;
  final bool? dark;
  final String? content;
  final Function? onDelete;
  final bool? hasDelete;

  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  @override
  void initState() {
    var brightness = widget.dark! ? Brightness.light : Brightness.dark;
    var color = widget.dark! ? Colors.black12 : Colors.white70;

    /*SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: color,
      statusBarColor: color,
      statusBarBrightness: brightness,
      statusBarIconBrightness: brightness,
      systemNavigationBarDividerColor: color,
      systemNavigationBarIconBrightness: brightness,
    ));*/
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: widget.dark! ? Colors.black : Colors.white,
        body: Stack(
          children: [
            Stack(
              children: [
                AnimatedPositioned(
                  duration: Duration(milliseconds: 33),
                  curve: Curves.fastOutSlowIn,
                  top: 0,
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: InteractiveViewer(
                    panEnabled: true,
                    minScale: 0.5,
                    maxScale: 4,
                    child: widget.child!,
                  ),
                ),
              ],
            ),
            SafeArea(
              child: Align(
                alignment: Alignment.topLeft,
                child: MaterialButton(
                  padding: const EdgeInsets.all(15),
                  elevation: 0,
                  child: Icon(
                    Icons.arrow_back,
                    color: widget.dark! ? Colors.white : Colors.black,
                    size: 25,
                  ),
                  color: widget.dark! ? Colors.black12 : Colors.white70,
                  highlightElevation: 0,
                  minWidth: double.minPositive,
                  height: double.minPositive,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
            if (widget.hasDelete!)
              SafeArea(
                child: Align(
                  alignment: Alignment.topRight,
                  child: MaterialButton(
                    padding: const EdgeInsets.all(15),
                    elevation: 0,
                    child: Icon(
                      Icons.delete,
                      color: widget.dark! ? Colors.white : Colors.black,
                      size: 25,
                    ),
                    color: widget.dark! ? Colors.black12 : Colors.white70,
                    highlightElevation: 0,
                    minWidth: double.minPositive,
                    height: double.minPositive,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    onPressed: () {
                      widget.onDelete!();
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class MySearchTextField extends StatelessWidget {
  String? text;
  TextEditingController? cont;
  TextInputAction? inputAction;
  TextInputType? inputType;
  Function? validator;
  bool? obscure;
  Color? fontColor;
  Color? hintColor;
  bool? filled;
  Color? filledColor;

  MySearchTextField(
      {Key? key,
      this.text,
      this.cont,
      this.validator,
      this.obscure = false,
      this.inputAction = TextInputAction.next,
      this.inputType = TextInputType.text,
      this.filled = false,
      this.filledColor = Colors.transparent,
      this.fontColor = primaryColorW,
      this.hintColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return TextFormField(
      controller: cont,
      textInputAction: inputAction,
      keyboardType: inputType,
      //validator: (value)=> validator(value),
      style: TextStyle(
        fontFamily: fontMedium,
        color: fontColor,
        fontSize: size.height * 0.018,
      ),
      obscureText: obscure!,
      decoration: InputDecoration(
          hintText: text,
          hintStyle:
              TextStyle(fontFamily: fontMedium, color: Color(0xFF777777)),
          filled: true,
          fillColor: Color(0xFF252525),
          prefixIcon: Icon(Icons.search, color: Color(0xFF777777)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(200),
            borderSide: BorderSide(color: primaryColorW, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(200),
            borderSide: BorderSide(color: Color(0xFF252525), width: 2.0),
          ),
          contentPadding: EdgeInsets.symmetric(
              vertical: size.height * 0.021, horizontal: size.width * 0.06)
          //contentPadding: EdgeInsets.only(left: 12, right: 8, bottom: 0)
          ),
    );
  }
}

class CustomeTextField extends StatelessWidget {
  String? title;
  String? hint;
  Widget? prefixChild;
  TextEditingController? cont;
  TextInputAction? inputAction;
  TextInputType? inputType;
  Function? validator;
  bool? obscure;

  CustomeTextField(
      {Key? key,
      this.title,
      this.hint,
      this.prefixChild,
      this.cont,
      this.validator,
      this.obscure = false,
      this.inputAction = TextInputAction.next,
      this.inputType = TextInputType.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VariableText(
          text: title,
          fontsize: size.height * 0.016,
          fontcolor: textColor1,
          weight: FontWeight.w600,
          fontFamily: fontSemiBold,
        ),
        SizedBox(height: size.height * 0.01),
        TextFormField(
          controller: cont,
          textInputAction: inputAction,
          keyboardType: inputType,
          //validator: (value)=> validator(value),
          style: TextStyle(
            fontFamily: fontMedium,
            color: textColor1,
            fontSize: size.height * 0.017,
          ),
          obscureText: obscure!,
          decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Theme.of(context).hintColor),
              filled: true,
              fillColor: primaryColorW,
              prefixIcon: prefixChild,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: primaryColor1, width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: borderColor, width: 1.0),
              ),
              contentPadding: EdgeInsets.symmetric(
                  vertical: size.height * 0.01, horizontal: 12)),
        ),
      ],
    );
  }
}

class PasswordTextField extends StatefulWidget {
  String? text;
  String? hint;
  Widget? prefixChild;
  TextEditingController? cont;
  TextInputAction? inputAction;
  TextInputType? inputType;
  Function? validator;
  bool? obscure;
  Color? fontColor;
  Color? hintColor;
  bool? filled;
  Color? filledColor;

  PasswordTextField(
      {Key? key,
      this.hint,
      this.prefixChild,
      this.cont,
      this.validator,
      this.obscure = true,
      this.text,
      this.inputAction = TextInputAction.next,
      this.inputType = TextInputType.text,
      this.filled = false,
      this.filledColor = Colors.transparent,
      this.fontColor = primaryColorW,
      this.hintColor})
      : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: size.height * 0.01),
        TextFormField(
          controller: widget.cont,
          textInputAction: widget.inputAction,
          keyboardType: widget.inputType,
          //validator: (value)=> validator(value),
          style: TextStyle(
            fontFamily: fontMedium,
            color: widget.fontColor,
            fontSize: size.height * 0.018,
          ),
          obscureText: widget.obscure!,
          decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: TextStyle(
                  fontFamily: fontMedium, color: Theme.of(context).hintColor),
              // filled: true,
              // fillColor: filledColor,
              suffixIcon: InkWell(
                onTap: () {
                  setState(() {
                    widget.obscure = !widget.obscure!;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: widget.obscure!
                      ? Icon(Icons.visibility_off,
                          color: widget.fontColor, size: size.height * 0.03)
                      : Icon(Icons.visibility,
                          color: widget.fontColor, size: size.height * 0.03),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(200),
                borderSide: BorderSide(color: primaryColorW, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(200),
                borderSide: BorderSide(color: primaryColorW, width: 2.0),
              ),
              contentPadding: EdgeInsets.symmetric(
                  vertical: size.height * 0.021, horizontal: size.width * 0.06)
              //contentPadding: EdgeInsets.only(left: 12, right: 8, bottom: 0)
              ),
        ),
      ],
    );
  }
}

class FlipCard extends StatelessWidget {
  final bool toggler;
  final Widget frontCard;
  final Widget backCard;

  const FlipCard({
    required this.toggler,
    required this.backCard,
    required this.frontCard,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 800),
        transitionBuilder: _transitionBuilder,
        layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
        switchInCurve: Curves.ease,
        switchOutCurve: Curves.ease.flipped,
        child: toggler
            ? SizedBox(key: const ValueKey('front'), child: frontCard)
            : SizedBox(key: const ValueKey('back'), child: backCard),
      ),
    );
  }

  Widget _transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnimation = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnimation,
      child: widget,
      builder: (context, widget) {
        final isFront = ValueKey(toggler) == widget!.key;
        final rotationY = isFront
            ? rotateAnimation.value
            : min(rotateAnimation.value, pi * 0.5);
        return Transform(
          transform: Matrix4.rotationY(rotationY)..setEntry(3, 0, 0),
          alignment: Alignment.center,
          child: widget,
        );
      },
    );
  }
}
class ProcessLoadingLight extends StatefulWidget {
  @override
  State createState() {
    return _ProcessLoadingLightState();
  }
}

class _ProcessLoadingLightState extends State<ProcessLoadingLight>
    with SingleTickerProviderStateMixin {
  AnimationController? _cont;
  Animation<Color?>? _anim;

  @override
  void initState() {
    _cont = AnimationController(
        duration: Duration(
          seconds: 1,
        ),
        vsync: this);
    _cont!.addListener(() {
      setState(() {});
    });
    ColorTween? col = ColorTween(begin: primaryColor1, end:primaryColorW);
    _anim = col.animate(_cont!);
    _cont!.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _cont!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color.fromRGBO(0, 0, 0, 0.3),
        child: Center(
          child: SizedBox(
              width: 50 * _cont!.value,
              height: 50 * _cont!.value,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(
                  _anim!.value,
                ),
              )),
        ));
  }
}
class MenuAppbar extends StatelessWidget {
  bool allowBack;
  MenuAppbar({Key? key, this.allowBack = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context).user;
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * horizontalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          allowBack
              ? InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(Icons.arrow_back, color: primaryColorW))
              : Container(),
          ClipRRect(
            borderRadius: BorderRadius.circular(200),
            child: user.img == null
                ? Image.asset(
                    "assets/icons/ic_profile1.png",
                    scale: 2,
                    fit: BoxFit.fill,
                    height: size.height * 0.05,
                    width: size.width * 0.10,
                  )
                : Image.network(
                    user.img!,
                    scale: 2,
                    fit: BoxFit.fill,
                    height: size.height * 0.05,
                    width: size.width * 0.10,
                  ),
          ),
        ],
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  String? icon;
  String? title;
  Function? onTap;
  MenuCard({Key? key, this.icon, this.title, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        onTap!();
      },
      child: Container(
        height: size.height * 0.12,
        width: size.height * 0.12,
        decoration: BoxDecoration(
            color: Color(0xFF444444), borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(icon!, scale: 2),
            SizedBox(height: size.height * 0.01),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: VariableText(
                      text: title!,
                      fontcolor: primaryColorW,
                      fontsize: size.height * 0.012,
                      fontFamily: fontRegular,
                      max_lines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

customToast(String msg) {
  return Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: primaryColor1,
      textColor: Colors.black);
}
