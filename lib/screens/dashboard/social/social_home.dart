import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fan_hall/controller/auth/league_api.dart';
import 'package:fan_hall/models/getAllUser.dart';
import 'package:fan_hall/models/get_feeds.dart';
import 'package:fan_hall/models/user_model.dart';
import 'package:fan_hall/providers/theme_provider.dart';
import 'package:fan_hall/providers/userProvider.dart';
import 'package:fan_hall/screens/dashboard/profile/menu/chat/all_chats_screen.dart';
import 'package:fan_hall/screens/dashboard/profile/profile_menu_screen.dart';
import 'package:fan_hall/screens/dashboard/profile/profile_social/post_feed.dart';
import 'package:fan_hall/widgets/common.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:location/location.dart';

import 'package:provider/provider.dart';
import 'dart:ui' as ui;
import '../../../widgets/common.dart';
import '../../../widgets/constants.dart';
import '../../../widgets/style.dart';
import '../scan_screens/scan_id_screen.dart';

class SocialHomeScreen extends StatefulWidget {
  const SocialHomeScreen({Key? key}) : super(key: key);

  @override
  State<SocialHomeScreen> createState() => _SocialHomeScreenState();
}

class _SocialHomeScreenState extends State<SocialHomeScreen>
    with SingleTickerProviderStateMixin {
  List<GetAllUser> allUserList2 = [];
  String? selectedCity;
  String? selectedTeam;
  String? selectedTeam1;
  bool? fromEventDetail = true;
  bool mapView = false;
  AnimationController? _controller;
  Animation<Offset>? _offsetFloat;
  bool isLoading = false;
  Location location = Location();

  int indexx = 0;
  setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

  // final LatLng _center =  LatLng(45.521563, -122.677433); // San Francisco coordinates
  late GoogleMapController _mapController;

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  getUserList() async {
    setLoading(true);
    // var userDetails = Provider.of<UserModel>(context, listen: false);
    var response = await ApiModel.getUserList(accessToken.toString());
    if (response != null) {
      allUserList2.clear();
      if (response['status']) {
        for (var item in response['data']) {
          allUserList2.add(GetAllUser.fromJson(item));
        }
      }
      print("length hai ${allUserList2.length}");
      setLoading(false);
      // startTimer(1);
    } else {
      allUserList2.clear();
      setLoading(false);
      Fluttertoast.showToast(
          msg: "Try again later", toastLength: Toast.LENGTH_SHORT);
    }
  }

  getUserListbyteam(String teamid) async {
    setLoading(true);
    // var userDetails = Provider.of<UserModel>(context, listen: false);
    var response = await ApiModel.getUserListbyteam(
        accessToken.toString(), teamid.toString());
    if (response != null) {
      allUserList2.clear();
      if (response['status']) {
        for (var item in response['data']) {
          allUserList2.add(GetAllUser.fromJson(item));
        }
      }
      print("length hai ${allUserList2.length}");
      setLoading(false);
      // startTimer(1);
    } else {
      allUserList2.clear();
      setLoading(false);
      Fluttertoast.showToast(
          msg: "Try again later", toastLength: Toast.LENGTH_SHORT);
    }
  }

  getuserteam() {
    if (selectedTeam == "ALL") {
      getUserList();
    }
    if (selectedTeam == selectedTeam1.toString()) {
      getUserListbyteam(selectedTeam1.toString());
    } else {}
  }

  final _controllerMap = Completer<GoogleMapController>();
  List<Marker> allMarkers = [];
  BitmapDescriptor? icon;
  List<UserModel> users = [];
  Set<Marker> fromEventMarkers = {};
  static CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(double.parse(lat!), double.parse(long!)),
    zoom: 14.4746,
  );
  addMarkers() {
    if (mounted) {
      // Marker(
      //     markerId: const MarkerId('Venue1'),
      //     draggable: false,
      //     icon: BitmapDescriptor.defaultMarker,
      //     position: _kGooglePlex.target);
      setState(() {
        for (var address in allUserList2) {
          allMarkers.add(
            Marker(
                infoWindow: InfoWindow(
                  title: address.name,
                ),
                markerId: MarkerId(address.name.toString()),
                draggable: false,
                icon: BitmapDescriptor.defaultMarker,
                position: LatLng(double.parse(address.latitude.toString()),
                    double.parse(address.longitude.toString()))),
          );
        }
        allMarkers.add(
          Marker(
              infoWindow: InfoWindow(
                title: userName.toString(),
              ),
              markerId: const MarkerId('Venue1'),
              draggable: false,
              icon: BitmapDescriptor.defaultMarker,
              position: _kGooglePlex.target),
        );

        // }
      });
    }
  }

  loadMarker() async {
    final Uint8List markerIcon =
        await getBytesFromAsset('assets/icons/ic_map_marker.png', 80);
    icon = BitmapDescriptor.fromBytes(markerIcon);
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  void dispose() {
    loadMarker();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserList();
    addMarkers();
    //  loadMarker();

    fromEventDetail!
        ? Future.delayed(const Duration(seconds: 1)).then((value) {
            fromEventMarkers.add(Marker(
                infoWindow: InfoWindow(
                  title: userName.toString(),
                ),
                markerId: MarkerId(userName!),
                draggable: false,
                icon: BitmapDescriptor.defaultMarker,
                position: LatLng(double.parse(lat!), double.parse(long!))));
          })
        : null;
    // getuserteam();

    _controller = AnimationController(
      vsync: this,
      //  reverseDuration: Duration(seconds: 6),
      duration: const Duration(milliseconds: 500),
    );
    _offsetFloat = Tween(begin: Offset(5.0, 0.0), end: Offset(0.0, 0.0))
        .animate(CurvedAnimation(
      curve: Curves.easeInOut,
      parent: _controller!,
    ));

    _offsetFloat!.addListener(() {
      setState(() {});
    });
    _controller!.forward();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var user = Provider.of<UserProvider>(context).user;

    selectedTeam1 = user.team!.id.toString();
    var primarycolor = Provider.of<ThemeProvider>(context).theme1model;
    List<String> cities = [
      "Near (10 KM)",
      "Far (25 KM)",
      user.nationality.toString(),
      "Everyone"
    ];
    List<String> teams = [user.team!.name!.toString(),"All NFL teams"];
    return Scaffold(
      backgroundColor: backgroundColor1,

      //Theme.of(context).backgroundColor,

      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.02),

            ///appbar
            InkWell(
                onTap: () {
                  Navigator.push(context,
                      SwipeLeftAnimationRoute(widget: ProfileMenuScreen()));
                },
                child: MenuAppbar(allowBack: false)),
            SizedBox(height: size.height * 0.04),

            ///view Selection
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * horizontalPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("assets/icons/nfl.png",
                      color: primaryColorW, scale: 2),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                            onTap: () {
                              setState(() {
                                mapView = true;
                              });
                            },
                            child: Image.asset(
                                "assets/icons/ic_social_mapview.png",
                                color: mapView
                                    ? Theme.of(context).primaryColor
                                    : primaryColorW,
                                scale: 2)),
                        SizedBox(width: size.width * 0.05),
                        InkWell(
                            onTap: () {
                              setState(() {
                                mapView = false;
                              });
                            },
                            child: Image.asset(
                                "assets/icons/ic_social_sliderview.png",
                                color: mapView
                                    ? primaryColorW
                                    : Theme.of(context).primaryColor,
                                scale: 2)),
                        SizedBox(width: size.width * 0.05),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  SwipeLeftAnimationRoute(
                                      widget: QrScanScreen()));
                            },
                            child: Image.asset(
                                "assets/icons/ic_social_qrcode.png",
                                scale: 2)),
                        SizedBox(width: size.width * 0.05),
                        Image.asset("assets/icons/ic_social_search.png",
                            scale: 2),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: size.height * 0.04),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                        height: size.height * 0.05,
                        child: InputDecorator(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: primaryColorW,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(200),
                                  borderSide: BorderSide(
                                      color: primaryColorW, width: 2.0)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(200),
                                  borderSide: BorderSide(
                                      color: primaryColorW, width: 2.0)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(200),
                                  borderSide: BorderSide(
                                      color: primaryColorW, width: 2.0)),
                              contentPadding: EdgeInsets.all(10),
                            ),
                            child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                    icon: Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Image.asset(
                                          'assets/icons/ic_dropdown.png',
                                          color: textColor1,
                                          scale: 2),
                                    ),
                                    hint: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: VariableText(
                                        text: "City",
                                        fontsize: size.height * 0.017,
                                        fontcolor: textColor1,
                                        fontFamily: fontMedium,
                                      ),
                                    ),
                                    value: selectedCity,
                                    dropdownColor: primaryColorW,
                                    isExpanded: true,
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                    },
                                    onChanged: (String? value) {
                                      setState(() {
                                        selectedCity = value;
                                      });
                                    },
                                    style: TextStyle(
                                        fontSize: size.height * 0.017,
                                        color: textColor1),
                                    items: cities.map<DropdownMenuItem<String>>(
                                        (String item) {
                                      return DropdownMenuItem<String>(
                                        value: item,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: VariableText(
                                            text: item,
                                            fontsize: size.height * 0.017,
                                            fontcolor: textColor1,
                                            fontFamily: fontMedium,
                                          ),
                                        ),
                                      );
                                    }).toList())))),
                  ),
                  SizedBox(width: size.width * 0.06),
                  Expanded(
                    child: SizedBox(
                        height: size.height * 0.05,
                        child: InputDecorator(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: primaryColorW,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(200),
                                  borderSide: BorderSide(
                                      color: primaryColorW, width: 2.0)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(200),
                                  borderSide: BorderSide(
                                      color: primaryColorW, width: 2.0)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(200),
                                  borderSide: BorderSide(
                                      color: primaryColorW, width: 2.0)),
                              contentPadding: EdgeInsets.all(10),
                            ),
                            child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                    icon: Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Image.asset(
                                          'assets/icons/ic_dropdown.png',
                                          color: textColor1,
                                          scale: 2),
                                    ),
                                    hint: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: VariableText(
                                        text: user.team!.name!.toString(),
                                        fontsize: size.height * 0.017,
                                        fontcolor: textColor1,
                                        fontFamily: fontMedium,
                                      ),
                                    ),
                                    value: selectedTeam,
                                    dropdownColor: primaryColorW,
                                    isExpanded: true,
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                    },
                                    onChanged: (String? value) async {
                                      setState(() {
                                        selectedTeam = value;
                                        allUserList2.clear();
                                      });
                                      if (selectedTeam == user.team!.name) {
                                        await getUserListbyteam(
                                            teamId!.toString());
                                        print(teamId);
                                      }
                                      if (selectedTeam == "All NFL teams") {
                                        await getUserList();
                                      }
                                      //  else{
                                      //  await getUserList();
                                      //  }
                                    },
                                    style: TextStyle(
                                        fontSize: size.height * 0.017,
                                        color: textColor1),
                                    items: teams.map<DropdownMenuItem<String>>(
                                        (String item) {
                                      return DropdownMenuItem<String>(
                                        value: item,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: VariableText(
                                            text: item,
                                            fontsize: size.height * 0.017,
                                            fontcolor: textColor1,
                                            fontFamily: fontMedium,
                                          ),
                                        ),
                                      );
                                    }).toList())))),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.04),
            mapView
                ? isLoading
                    ? CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      )
                    : Expanded(
                        child: Container(
                            child:
                                //          GoogleMap(
                                //   initialCameraPosition: CameraPosition(
                                //     target: LatLng(52.1223, -0.2225233),
                                //     zoom: 15,
                                //   ),
                                //   markers: _markers,
                                // ),
                                GoogleMap(
                                    mapType: MapType.normal,
                                    initialCameraPosition: fromEventDetail ==
                                            true
                                        ? CameraPosition(
                                            target: LatLng(
                                                double.parse(lat!.toString()),
                                                double.parse(long!.toString())),
                                            zoom: 11.4746,
                                          )
                                        : _kGooglePlex,
                                    markers: Set.from(fromEventDetail == true
                                        ? allMarkers
                                        : fromEventMarkers),
                                    onMapCreated:
                                        (GoogleMapController controller) {
                                      _controllerMap.complete(controller);
                                      Future.delayed(const Duration(seconds: 1))
                                          .then((value) {
                                        addMarkers();
                                      });
                                    }
                                 
                                    )

                            //                    GoogleMap(
                            //   onMapCreated: _onMapCreated,
                            //   initialCameraPosition: CameraPosition(
                            //     target:LatLng(lat!,long!),
                            //     zoom: 11.0,
                            //   ),
                            //   markers: {
                            //                 Marker(
                            //                   icon:BitmapDescriptor.defaultMarker,
                            //                   markerId: MarkerId(user.nationality!),
                            //                   position: LatLng(lat!,long!),
                            //                   infoWindow: InfoWindow(
                            //                     title: user.name,
                            //                   ),
                            //                 ),
                            //               },
                            // ),
                            ),
                      )
                : isLoading
                    ? CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      )
                    : Container(
                        //color: Colors.red,
                        alignment: Alignment.center,
                        height: size.height * 0.55,
                        width: size.width,
                        child: SlideTransition(
                          position: _offsetFloat!,
                          child: PageView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: allUserList2.length,
                            controller: PageController(
                                viewportFraction: 0.60,
                                keepPage: true,
                                initialPage: 0),
                            onPageChanged: (int index) => setState(() {
                              indexx = index;
                            }),
                            itemBuilder: (_, i) {
                              return Transform.scale(
                                  scale: i == indexx ? 1 : 0.8,
                                  child: Container(
                                    height: size.height * 0.35,
                                    width: size.width * 0.60,
                                    decoration: BoxDecoration(
                                        color: HexColor(allUserList2[i]
                                            .team!
                                            .theme!
                                            .primaryColor!),
                                        borderRadius:
                                            BorderRadius.circular(50)),
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
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20)),
                                                ),
                                                height: size.height * 0.35,
                                                width: size.width,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: allUserList2[i]
                                                              .cardImg !=
                                                          null
                                                      ? ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl:
                                                                allUserList2[i]
                                                                    .cardImg!,
                                                            fit: BoxFit.cover,
                                                            imageBuilder: (context,
                                                                    imageProvider) =>
                                                                Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                image:
                                                                    DecorationImage(
                                                                  image:
                                                                      imageProvider,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ),
                                                            // placeholder: (context, url) =>
                                                            //     CircularProgressIndicator(
                                                            //   color: Theme.of(context)
                                                            //       .primaryColor,
                                                            // ),
                                                            errorWidget:
                                                                (context, url,
                                                                        error) =>
                                                                    Icon(Icons
                                                                        .error),
                                                          ),
                                                          // Image.network(
                                                          //   user.cardImg!,
                                                          //   fit: BoxFit.fill,
                                                          // ),
                                                        )
                                                      : Container(
                                                          child: Center(
                                                            child: VariableText(
                                                              text:
                                                                  "No Image Found!",
                                                              fontsize:
                                                                  size.height *
                                                                      0.026,
                                                              fontcolor:
                                                                  textColorB,
                                                              fontFamily:
                                                                  fontBold,
                                                              weight: FontWeight
                                                                  .w700,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              max_lines: 2,
                                                            ),
                                                          ),
                                                        ),
                                                )),
                                            Positioned(
                                              right: size.width * 0.02,
                                              top: size.height * 0.012,
                                              child: InkWell(
                                                onTap: () {
                                                  Container(
                                                    child: SpeedDial(
                                                      icon: Icons.add,
                                                      iconTheme: IconThemeData(
                                                          color:
                                                              Theme.of(context)
                                                                  .iconTheme
                                                                  .color),
                                                      activeIcon: Icons.close,
                                                      buttonSize:
                                                          size.height * 0.05,
                                                      visible: true,
                                                      closeManually: false,
                                                      curve: Curves.bounceInOut,
                                                      overlayColor:
                                                          Colors.transparent,
                                                      overlayOpacity: 0.5,
                                                      onOpen: () =>
                                                          print('OPENING DIAL'),
                                                      onClose: () =>
                                                          print('DIAL CLOSED'),
                                                      tooltip: 'Speed Dial',
                                                      heroTag:
                                                          'speed-dial-hero-tag',
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      elevation: 8.0,
                                                      shape: CircleBorder(),
                                                      gradientBoxShape:
                                                          BoxShape.circle,
                                                      orientation:
                                                          SpeedDialOrientation
                                                              .Up,
                                                      children: [
                                                        SpeedDialChild(
                                                          label: "Pics",
                                                          labelBackgroundColor:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          labelStyle: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .iconTheme
                                                                .color,
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(6.0),
                                                            child: Image.asset(
                                                              "assets/icons/camera.png",
                                                              scale: 1,
                                                              color: Theme.of(
                                                                      context)
                                                                  .iconTheme
                                                                  .color,
                                                            ),
                                                          ),
                                                          backgroundColor:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          onTap: () async {
                                                            Navigator.push(
                                                                context,
                                                                SwipeLeftAnimationRoute(
                                                                    widget:
                                                                        Post_Feeds()));
                                                            // imageFile1 = await _picker.pickImage(source: ImageSource.gallery);

                                                            // uploadUserImage(imageFile1!.path, accessToken!);

                                                            // getUserPhotos();
                                                          },
                                                        ),
                                                        SpeedDialChild(
                                                          label: "Vlips",
                                                          labelBackgroundColor:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          labelStyle: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .iconTheme
                                                                  .color),
                                                          child: IconButton(
                                                            icon: Image.asset(
                                                              "assets/icons/video.png",
                                                              scale: 1,
                                                              color: Theme.of(
                                                                      context)
                                                                  .iconTheme
                                                                  .color,
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              // XFile? image =
                                                              //     await _picker.pickVideo(source: ImageSource.gallery);
                                                              // uploadUserVideo(image!, accessToken.toString());

                                                              // getUserVid();
                                                            },
                                                          ),
                                                          backgroundColor:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                        ),
                                                        SpeedDialChild(
                                                          label: "Chat",
                                                          labelBackgroundColor:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          labelStyle: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .iconTheme
                                                                .color,
                                                          ),
                                                          child: IconButton(
                                                            icon: Image.asset(
                                                              "assets/icons/chat.png",
                                                              scale: 1,
                                                              color: Theme.of(
                                                                      context)
                                                                  .iconTheme
                                                                  .color,
                                                            ),
                                                            onPressed: () {
                                                              Navigator.push(
                                                                  context,
                                                                  SwipeLeftAnimationRoute(
                                                                      widget:
                                                                          AllChats()));
                                                            },
                                                          ),
                                                          backgroundColor:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: HexColor(
                                                          allUserList2[i]
                                                              .team!
                                                              .theme!
                                                              .shareBtnBg!),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  200))),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Icon(
                                                      Icons.add,
                                                      color: HexColor(
                                                          allUserList2[i]
                                                              .team!
                                                              .theme!
                                                              .shareBtnColor!),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                                right: size.width * 0.15,
                                                left: size.width * 0.15,
                                                top: size.height * 0.312,
                                                child: Container(
                                                  height: size.height * 0.04,
                                                  width: size.width * 0.5,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5)),
                                                      color: HexColor(
                                                          allUserList2[i]
                                                              .team!
                                                              .theme!
                                                              .primaryColor!)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: SizedBox(
                                                      height:
                                                          size.height * 0.04,
                                                      width: size.width * 0.04,
                                                      child: Image.asset(
                                                        'assets/icons/nfl1.png',
                                                        color: HexColor(
                                                            allUserList2[i]
                                                                .team!
                                                                .theme!
                                                                .fanCardTextColor!),
                                                       scale: 5.5 ,
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
                                                  color: HexColor(
                                                      allUserList2[i]
                                                          .team!
                                                          .theme!
                                                          .fanCardTextColor!),
                                                  scale: 6,
                                                ),
                                              ),
                                              SizedBox(
                                                height: size.height * 0.09,
                                                child: teamImage != null
                                                    ? Image.network(
                                                        allUserList2[i]
                                                            .team!
                                                            .img!,
                                                        height: size.height)
                                                    : Container(
                                                        child: Center(
                                                            child: Text(
                                                          "No Team !",
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      192,
                                                                      57,
                                                                      57)),
                                                        )),
                                                      ),
                                              ),
                                              SizedBox(
                                                height: size.height * 0.04,
                                                child: SvgPicture.asset(
                                                  'assets/icons/yearnike.svg',
                                                  color: HexColor(
                                                      allUserList2[i]
                                                          .team!
                                                          .theme!
                                                          .fanCardTextColor!),
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
                                            text: allUserList2[i]
                                                .name!
                                                .toUpperCase()
                                                .toString(),
                                            fontsize: size.height * 0.022,
                                            fontcolor: HexColor(allUserList2[i]
                                                .team!
                                                .theme!
                                                .fanCardTextColor!),
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
                                                "${'${allUserList2[i].team!.nickName!.toUpperCase()} OFFICIAL FAN'}",
                                            fontsize: size.height * 0.010,
                                            fontcolor: HexColor(allUserList2[i]
                                                .team!
                                                .theme!
                                                .fanCardTextColor!),
                                            fontFamily: fontRegular,
                                            weight: FontWeight.w500,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ));
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
