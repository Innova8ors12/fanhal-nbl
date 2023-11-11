import 'package:fan_hall/models/theme_model.dart';
import 'package:flutter/material.dart';

import 'style.dart';

class Themes {
  static ThemeData themeData(Theme1Model themeDetails) {
    return themeDetails == null
        ? ThemeData(
            // Define the default brightness and colors.
            brightness: Brightness.dark,
            primaryColor: Colors.lightBlue[800],

            // Define the default font family.
            fontFamily: 'Georgia',

            // Define the default `TextTheme`. Use this to specify the default
            // text styling for headlines, titles, bodies of text, and more.
            textTheme: const TextTheme(
              headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
              headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
              bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
            ),
          )
        : ThemeData(
            primaryColor: themeDetails.primaryColor!.isEmpty
                ? Colors.lightBlue[800]
                : Color(int.parse("0xff" +
                    themeDetails.primaryColor!
                        .substring(1, themeDetails.primaryColor!.length))),
            // backgroundColor: Color(int.parse("0xff" +
            //     themeDetails.backgroundColor!
            //         .substring(1, themeDetails.backgroundColor!.length))),
            // indicatorColor: Color(int.parse("0xff" +
            //     themeDetails.indicatorColor!
            //         .substring(1, themeDetails.indicatorColor!.length))),
            // hintColor: Color(int.parse("0xff" +
            //     themeDetails.hintColor!
            //         .substring(1, themeDetails.hintColor!.length))),
            // focusColor: Color(int.parse("0xff" +
            //     themeDetails.focusColor!
            //         .substring(1, themeDetails.focusColor!.length))),
            // buttonTheme: ButtonThemeData(
            //   buttonColor: Color(int.parse("0xff" +
            //       themeDetails.buttonColor!
            //           .substring(1, themeDetails.buttonColor!.length))),
            // ),
            fontFamily: fontRegular,
          );
    //, BuildContext context
    // switch (them) {
    //   // case "YELLOW":
    //   //   {
    //   //           return ThemeData(
    //   //       primaryColor: Colors.red, // const Color(0xFFFFB612),
    //   //       backgroundColor: Colors.blue, //const Color(0xFF323232),
    //   //       indicatorColor: const Color(0xFFFFFFFF),
    //   //       hintColor: const Color(0xFFD9D9D9),
    //   //       focusColor: const Color(0xFFFFFFFF),
    //   //       buttonTheme: const ButtonThemeData(
    //   //         buttonColor: Color(0xFFFFB612),
    //   //       ),
    //   //       fontFamily: fontRegular,
    //   //     );
    //   //   }

    //   case "ps":
    //     {
    //       return ThemeData(
    //         primaryColor: Colors.red, // const Color(0xFFFFB612),
    //         backgroundColor: Colors.blue, //const Color(0xFF323232),
    //         indicatorColor: const Color(0xFFFFFFFF),
    //         hintColor: const Color(0xFFD9D9D9),
    //         focusColor: const Color(0xFFFFFFFF),
    //         buttonTheme: const ButtonThemeData(
    //           buttonColor: Color(0xFFFFB612),
    //         ),
    //         fontFamily: fontRegular,
    //       );
    //     }
    //   default:
    //     {
    //       return ThemeData(
    //         primaryColor: const Color(0xFFFFB612),
    //         backgroundColor: const Color(0xFF323232),
    //         indicatorColor: const Color(0xFFFFFFFF),
    //         hintColor: const Color(0xFFD9D9D9),
    //         focusColor: const Color(0xFFFFFFFF),
    //         buttonTheme: const ButtonThemeData(
    //           buttonColor: Color(0xFFFFB612),
    //         ),
    //         fontFamily: fontRegular,
    //       );
    //     }
    // }
  }
}
