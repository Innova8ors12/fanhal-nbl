import 'dart:io';

import 'package:fan_hall/controller/auth/league_api.dart';
import 'package:fan_hall/models/theme_model.dart';
import 'package:fan_hall/providers/get_album.dart';
import 'package:fan_hall/providers/get_photos.dart';
import 'package:fan_hall/providers/get_photos_provider.dart';
import 'package:fan_hall/providers/get_vedios.dart';
import 'package:fan_hall/providers/league_provider.dart';
import 'package:fan_hall/providers/userProvider.dart';
import 'package:fan_hall/screens/dashboard/certificates/buy_certificate/2_4_2_select_league.dart';
import 'package:fan_hall/screens/dashboard/main_dashboard.dart';
import 'package:fan_hall/screens/login_screens/login_screen.dart';
import 'package:fan_hall/screens/login_screens/welcome_screen.dart';
import 'package:fan_hall/screens/registration_screens/3_select_league.dart';
import 'package:fan_hall/screens/registration_screens/5_main_image_screen.dart';
import 'package:fan_hall/screens/reset_password_screens/1_forgot_pass_screen.dart';
import 'package:fan_hall/screens/reset_password_screens/1_update_password.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fan_hall/widgets/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import 'providers/theme_provider.dart';
import 'screens/splash_screen.dart';
import 'widgets/theme_data.dart';

///flutter 3.3.4

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = new MyHttpOverrides();
  Stripe.publishableKey = "pk_test_51MOTAWLyijXiZsW8ErqMpNZ2sstagIQoPVnSGBltb1hFqD5jjleKKMGwt4GkE8hPDb9eiWXi5K4CJaUU2O7Dcdes00012W9Koh";
  runApp(MultiProvider(
    providers: [
      Provider<ApiModel>(
        create: (_) => ApiModel(),
      ),
      ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
      ChangeNotifierProvider<LeagueProvider>(create: (_) => LeagueProvider()),
      ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
      ChangeNotifierProvider<PhotosProvider>(create: (_) => PhotosProvider()),
      ChangeNotifierProvider<GetPhotoProvider>(
          create: (_) => GetPhotoProvider()),
             ChangeNotifierProvider<AlbumProvider>(
          create: (_) => AlbumProvider()),
      ChangeNotifierProvider<GetVideoProvider>(
          create: (_) => GetVideoProvider()),
      // ChangeNotifierProvider<Provider>(create: (_) => PhotosProvider()),
      // ChangeNotifierProvider<PhotosProvider>(create: (_) => PhotosProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeProvider themeChangeProvider = ThemeProvider();
  // var theme=Provider.of<ThemeProvider>(context).

  // void getCurrentAppTheme() async {
  //   themeChangeProvider.theme = themeChangeProvider.themes;
  // }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) {
      return themeChangeProvider;
    }, child: Consumer<ThemeProvider>(
      builder: (BuildContext context, value, Widget? child) {
        return GetMaterialApp(
            debugShowCheckedModeBanner: true,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              // Define the default brightness and colors.
              brightness: Brightness.dark,
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                
                
                selectedItemColor: value.theme1model.navMenuTextSelect== null
                    ? Color(0xFFFFFFFF)
                    : HexColor(value.theme1model.navMenuTextSelect!),
                     unselectedItemColor: value.theme1model.navMenuTextColor== null
                    ? Color(0xFFFFFFFF)
                    : HexColor(value.theme1model.navMenuTextColor!),
                    
                backgroundColor: value.theme1model.navMenuBgColor == null
                    ? Color(0xFF323232)
                    : HexColor(value.theme1model.navMenuBgColor!),
              ),
              primaryColor: value.theme1model.primaryColor == null
                  ? Colors.blue
                  : HexColor(value.theme1model.primaryColor!),
              backgroundColor: value.theme1model.backgroundColor == null
                  ? Color(0xFF323232)
                  : HexColor(value.theme1model.backgroundColor!),

              indicatorColor: value.theme1model.indicatorColor == null
                  ? Color(0xFFFFFFFF)
                  : HexColor(value.theme1model.indicatorColor!),
              hintColor: value.theme1model.hintColor == null
                  ? Color(0xFFD9D9D9)
                  : HexColor(value.theme1model.hintColor!),
              focusColor: value.theme1model.focusColor == null
                  ? Color(0xFFFFFFFF)
                  : HexColor(value.theme1model.focusColor!),
              // backgroundColor:
              //      LinearGradient(colors: [Colors.blue, Colors.green]),

              buttonTheme: ButtonThemeData(
                buttonColor: value.theme1model.buttonColor == null
                    ? Color(0xFFFFB612)
                    : HexColor(value.theme1model.buttonColor!),
              ),
              cardTheme:CardTheme(
                color:  value.theme1model.fanCardBtnBg == null
                    ? Color(0xFFFFB612)
                    : HexColor(value.theme1model.fanCardBtnBg !),
                
              ) ,
              cardColor: value.theme1model.fanCardBtnBg == null
                    ? Color(0xFFFFB612)
                    : HexColor(value.theme1model.fanCardBtnBg !), 
              iconTheme: IconThemeData(
                  color: value.theme1model.fanCardBtnBg== null
                      ? Color(0xFFFFFFFF)
                      : HexColor(value.theme1model.fanCardTextColor!)),
              // Define the default font family.
              fontFamily: fontRegular,

              // Define the default `TextTheme`. Use this to specify the default
              // text styling for headlines, titles, bodies of text, and more.
              textTheme: const TextTheme(
                headline1: TextStyle(
                    fontSize: 72.0,
                    fontWeight: FontWeight.bold,
                    color: textColorB),
                headline6:
                    TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
                bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
              ),
            ),
            // theme: Themes.themeData(themeChangeProvider.themes), //, context
            home: const SplashScreen());
      },
    ));
  }
}
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}