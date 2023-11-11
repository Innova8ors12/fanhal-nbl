import 'package:fan_hall/controller/auth/user_authentications.dart';
import 'package:fan_hall/controller/services/local_preferences.dart';
import 'package:fan_hall/models/user_model.dart';
import 'package:fan_hall/providers/userProvider.dart';
import 'package:fan_hall/screens/get_started_screen.dart';
import 'package:fan_hall/screens/login_screens/login_screen.dart';
import 'package:permission_handler/permission_handler.dart' as ph;
import 'package:fan_hall/screens/login_screens/welcome_screen.dart';
import 'package:fan_hall/widgets/common.dart';
import 'package:fan_hall/widgets/style.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:location_platform_interface/location_platform_interface.dart';
// import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as lc;
// import 'package:geolocator_platform_interface/src/enums/location_accuracy.dart';
// import 'package:location_platform_interface/src/enums/location_accuracy.dart';


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location/location.dart' ;



import 'package:provider/provider.dart';

import '../controller/auth/league_api.dart';
import '../models/theme_model.dart';
import '../providers/theme_provider.dart';
import 'dashboard/main_dashboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //  late double lat;
  // late double long;

  Location location = Location();

  getMyLocation() async {
    while (true) {
      var response = await getLocationPermissions();
      if (response == null) {
        continue;
      } else if (response) {
        getlocation();
      

        break;
      }
    }
  }

  Future getLocationPermissions() async {
    try {
      PermissionStatus locationPermission = await location.hasPermission();
      //print("1 locationPermission: " + locationPermission.toString());
      if (locationPermission.toString() == 'PermissionStatus.granted') {
        bool locationService = await location.serviceEnabled();
        if (locationService) {
          return true;
        } else {
          locationService = await location.requestService();
          if (locationService) {
            return true;
          } else {
            throw Exception();
          }
        }
      } else if (locationPermission.toString() == "PermissionStatus.denied") {
        locationPermission = await location.requestPermission();
        if (locationPermission.toString() == 'PermissionStatus.deniedForever') {
          throw Exception("fromApp");
        } else {
          getLocationPermissions();
        }
      } else {
        locationPermission = await location.requestPermission();
        if (locationPermission.toString() == 'PermissionStatus.granted') {
          getLocationPermissions();
        } else {
          throw Exception("fromApp");
        }
      }
    } catch (e) {
      if (e.toString().contains("fromApp")) {
        locationPopup();
      } else {
        Fluttertoast.showToast(
            msg: "Location access denied", toastLength: Toast.LENGTH_SHORT);
      }
      return false;
    }
  }

  locationPopup() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Location Permission'),
          content: Text('Please allow location permission from app settings'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel', style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Open Settings'),
              onPressed: () async {
                try {
                  await ph.openAppSettings();
                  Navigator.of(context).pop();
                } catch (e) {
                  print(e.toString());
                }
              },
            )
          ],
        );
      },
    );
  }

  Future<bool> getlocation() async {
    Position position = await Geolocator.getCurrentPosition();
    lat = position.latitude.toString();
    long = position.longitude.toString();
    return position.longitude.isNaN ? false : true;
  }


  
//   lc.Location location = lc.Location();
// String? currentAddress;
// Position? _currentPosition;
// getLocation() async {
//     try{
//       PermissionStatus locationPermission = await location.hasPermission();

//       print("locationPermission: " + locationPermission.toString());
//       if(locationPermission.toString() == 'PermissionStatus.granted'){
//         bool locationService = await location.serviceEnabled();
//         if(locationService){
//           //  var loc = await location.getLocation();
//           //  latitude=loc.altitude.toString();
//           //  longitude=loc.longitude.toString();
//           // updateUserLocation();
//         }else{
//           locationService = await location.requestService();
//           if(locationService){
//             // updateUserLocation();
//           }else{
//             throw Exception();
//           }
//         }
//       }else if(locationPermission.toString() == "PermissionStatus.denied"){
//         locationPermission = await location.requestPermission();
//         print("locationPermission: " + locationPermission.toString());
//         if(locationPermission.toString() == 'PermissionStatus.deniedForever'){
//           throw Exception("fromApp");
//         }else{
//           getLocation();
//         }
//       }
//       else{
//         locationPermission = await location.requestPermission();
//         print("locationPermission: " + locationPermission.toString());
//         if(locationPermission.toString() == 'PermissionStatus.granted'){
//           getLocation();
//         }else{
//           throw Exception("fromApp");
//         }
//       }
//     }catch(e){
//       if(e.toString().contains("fromApp")){
//         locationPopup();
//       }else{
//         print(e.toString());
//         Fluttertoast.showToast(
//             msg: "Location access denied",
//             toastLength: Toast.LENGTH_SHORT);
//       }
//     }
//   }

//   locationPopup() {
//     return showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Location Permission'),
//           content: Text('Please allow location permission from app settings'),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Cancel', style: TextStyle(color: Colors.red)),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: Text('Open Settings'),
//               onPressed: () async{
//                 try{
//                   await ph.openAppSettings();
//                   Navigator.of(context).pop();
//                 }catch(e){
//                   print(e.toString());
//                 }
//               },
//             )
//           ],
//         );
//       },
//     );
//   }
 

  
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      proceed();
    });
    //  getLocation();
     getMyLocation();
    // TODO: implement initState
    super.initState();
  }

  proceed() async {
    LocalPreference lp = LocalPreference();
    //lp.clearAll();
    String token = await lp.getUserToken();
    print(token.toString());
    if (token != "null") {
      var response = await AuthenticationService().getLoggedUser(token);
      if (response is Map) {
         if (response['status']) {
          UserModel userDetails = UserModel.fromJson(response['data']);
          var res = await ApiModel().getTheme(userDetails.teamId!.toString());
          if (res['status'].toString() == "true") {
            name = userDetails.name!;
            userName = userDetails.username!;
            teamId = userDetails.teamId!;
            cardImage = userDetails.cardImg!;
            accessToken = userDetails.token!;
            teamImage = userDetails.team!.img!;
            nickName = userDetails.team!.nickName!;
            Theme1Model themeModel = Theme1Model.fromJson(res['data']);
            Provider.of<ThemeProvider>(context, listen: false)
                .settheme(themeModel);
            Provider.of<UserProvider>(context, listen: false)
                .setUser(userDetails);
            Navigator.pushReplacement(context,
                SwipeLeftAnimationRoute(milliseconds: 250, widget: const MainDashboard()));
          }
        } else {
          Fluttertoast.showToast(
              msg: response['msg'], toastLength: Toast.LENGTH_SHORT);
          Navigator.pushReplacement(
              context, SwipeUpAnimationRoute(widget: const WelcomeScreen()));
        }
      } else {
        Fluttertoast.showToast(msg: response, toastLength: Toast.LENGTH_SHORT);
        Navigator.pushReplacement(
            context, SwipeUpAnimationRoute(widget: const WelcomeScreen()));
      }
    } else {
      Future.delayed(const Duration(seconds: 2)).then((value) {
        Navigator.pushReplacement(
            context, SwipeUpAnimationRoute(widget: const WelcomeScreen()));
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset("assets/images/splash_background.png",
                fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xFF000000).withOpacity(0.8),
                      const Color(0xFF1E1E1E).withOpacity(0.8),
                      const Color(0xFF1E1E1E).withOpacity(0.8),
                      const Color(0xFF6A6A6A).withOpacity(0.8),
                      const Color(0xFFD9D9D9).withOpacity(0.8),
                    ]),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Image.asset("assets/icons/ic_splash_nike.png", scale: 2),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: size.height * 0.31),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  VariableText(
                    text: "WELCOME TO\nINMORATILITY",
                    fontsize: size.height * 0.026,
                    fontcolor: textColorW,
                    fontFamily: fontExtraBold,
                    weight: FontWeight.w700,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
