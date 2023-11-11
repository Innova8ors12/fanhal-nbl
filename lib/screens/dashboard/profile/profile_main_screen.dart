import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fan_hall/models/get_album.dart';
import 'package:fan_hall/models/get_videos.dart';
import 'package:fan_hall/models/user_model.dart';
import 'package:fan_hall/providers/get_album.dart';
import 'package:fan_hall/providers/get_photos.dart';
import 'package:fan_hall/providers/get_vedios.dart';
import 'package:fan_hall/providers/theme_provider.dart';
import 'package:fan_hall/screens/dashboard/fan_card/showcase/showcase_main.dart';
import 'package:fan_hall/screens/dashboard/profile/menu/chat/all_chats_screen.dart';
import 'package:fan_hall/screens/dashboard/profile/profile_social/post_feed.dart';
import 'package:fan_hall/screens/dashboard/profile/view_single.dart';

import 'package:fan_hall/screens/registration_screens/image_from_gallery.dart';
import 'package:fan_hall/widgets/common.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:fan_hall/controller/auth/league_api.dart';
import 'package:fan_hall/controller/config.dart';
import 'package:fan_hall/models/get_photos.dart';
import 'package:fan_hall/providers/get_photos_provider.dart';
import 'package:fan_hall/screens/dashboard/scan_screens/scan_id_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:flutter_awesome_bottom_sheet/flutter_awesome_bottom_sheet.dart';
import 'package:video_player/video_player.dart';
// import 'package:file_support/file_support.dart';
// import 'package:photo_gallery/photo_gallery.dart';
import '../../../widgets/common.dart';
import '../../../widgets/style.dart';

import 'profile_menu_screen.dart';
import 'package:fan_hall/providers/userProvider.dart';
import 'profile_social/profile_social_main.dart';
import 'package:provider/provider.dart';

import 'view_video copy.dart';

// import 'package:image_pick
class ProfileMainScreen extends StatefulWidget {
  const ProfileMainScreen({Key? key}) : super(key: key);

  @override
  State<ProfileMainScreen> createState() => _ProfileMainScreenState();
}

// var location = endTop;
final ImagePicker _picker = ImagePicker();
XFile? imageFile1;
XFile? video;
List<XFile> imagePost = [];
List<GetPhotos> img = [];
List vid = [];

List<GetAlbum> alb = [];

XFile? selectedImage;
bool dialVisible = true;

class _ProfileMainScreenState extends State<ProfileMainScreen>
    with TickerProviderStateMixin {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  ScrollController? _scrollController;
  TabController? tabViewController;
  // bool loadingVideo = false;
  // List<String> _controllers = [];
  // isVideoLoading(bool loading) {
  //   setState(() {
  //     loadingVideo = loading;
  //   });
  // }

  bool isLoading = false;
  setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

  bool isupLoading = false;
  setupLoading(bool loading) {
    setState(() {
      isupLoading = loading;
    });
  }

  TabController? tabController;
  late Future<Album> futureAlbum;
  TextEditingController AlbumTitle = TextEditingController();

  List<GetVideos> getVideo = [];
  getAlbum() async {
    setLoading(true);
    var res = await ApiModel().getAlbum(accessToken.toString());
    GetAlbum? _getAlbum;
    // print(res);
    alb.clear();
    if (res != null && res['status']) {
      for (var item in res['data']) {
        _getAlbum = GetAlbum.fromJson(item);

        alb.add(_getAlbum);
      }
      setLoading(false);

      setState(() {});
    } else {}
  }

  GetPhotos? getPhotos;
  GetVideos? getVideos;

  Future<dynamic> uploadUserImage(imageFile1, String token) async {
    setupLoading(true);
    var url = CONFIG.domain + CONFIG.uploadPhotos;
    print(url);

    File tempFile = File(imageFile1);
    var image = await MultipartFile.fromFile(
      tempFile.path,
      filename: tempFile.path.split('/').last,
      // contentType: MediaType('image', 'jpg')
    );
    FormData postData = FormData.fromMap({
      "imgs[]": image,
    });

    try {
      Dio dio = new Dio();
      var response = await dio.post(url,
          data: postData,
          options: Options(
              contentType: 'multipart/form-data; boundary=1000',
              headers: <String, String>{
                "Content-Type": "application/json",
                "Accept": "application/json",
                "Authorization": "Bearer " + token
              }));
      print(response.statusCode.toString());
      setupLoading(false);
      // customToast(response.data['data'].toString());
      setState(() {});
      if (response.data['status'].toString() == "true") {
        UserModel userModel = UserModel.fromJson(response.data['data']);
        Provider.of<UserProvider>(context, listen: false).setUser(userModel);
        customToast('uploaded successfully');
      }

      return response.data;
    } catch (e) {
      print("uploadUserImage Exception: " + e.toString());
    }
  }

  // }
  final AwesomeBottomSheet _awesomeBottomSheet = AwesomeBottomSheet();
  Future uploadUserVideo(XFile video, String? token) async {
    setupLoading(true);
    var url = CONFIG.domain + CONFIG.uploadVideos;
    print(url);

    File tempFile = File(video.path);
    MultipartFile video1 = await MultipartFile.fromFile(
      tempFile.path,
      filename: video.path.split('/').last,
      // contentType: MediaType('audio', 'mp4')
    );
    FormData postData = FormData.fromMap({
      "vclip": video1,
    });
    try {
      Dio dio = new Dio();
      var response = await dio.post(url,
          data: postData,
          options: Options(
              contentType: 'multipart/form-data; boundary=2000',
              headers: <String, String>{
                "Content-Type": "application/json",
                "Accept": "application/json",
                "Authorization": "Bearer " + token!.toString()
              }));
      print(response.statusCode.toString());
      setupLoading(false);
      // customToast(response.data['data'].toString());
      setState(() {});
      if (response.data['status'].toString() == "true") {
        UserModel userModel = UserModel.fromJson(response.data['data']);
        Provider.of<UserProvider>(context, listen: false).setUser(userModel);
        customToast('uploaded successfully');
      }

      return response.data;
    } catch (e) {
      customToast("uploadUserVideo Exception: " + e.toString());

      var data = jsonDecode(e.toString());
      print(data.toString());
      print("uploadUserVideo Exception: " + e.toString());
      return data;
    }
  }

  openImage(String imageUrl, String id) {
    Image _img = Image.network(imageUrl);
    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        barrierColor: true ? Colors.black : Colors.white,
        pageBuilder: (BuildContext context, _, __) {
          return FullScreenImage(
            child: _img,
            dark: true,
            hasDelete: false,
          );
        },
      ),
    );
  }

  Future<Album> createAlbum(String title, String token) async {
    setupLoading(true);
    var url = CONFIG.domain + CONFIG.createAlbum;
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer " + token
      },
      body: jsonEncode(<String, String>{
        'name': title,
      }),
    );

    if (response.statusCode == 200) {
      var show = jsonDecode(response.body);
      setupLoading(false);
      customToast(show['msg']);
      return Album.fromJson(show);
    } else {
      throw Exception('Failed to create album.');
    }
  }

  void setDialVisible(bool value) {
    setState(() {
      dialVisible = value;
    });
  }

  TabBar get _tabBar => TabBar(
        controller: tabController,
        indicatorColor:
            Provider.of<ThemeProvider>(context).theme1model.shareBtnColor !=
                    null
                ? HexColor(Provider.of<ThemeProvider>(context)
                    .theme1model
                    .navMenuTextSelect!)
                : textColorW,
        labelColor:
            Provider.of<ThemeProvider>(context).theme1model.shareBtnColor !=
                    null
                ? HexColor(Provider.of<ThemeProvider>(context)
                    .theme1model
                    .navMenuTextSelect!)
                : textColorW,
        indicatorWeight: 3.0,
        isScrollable: false,
        labelPadding: const EdgeInsets.symmetric(horizontal: 10),
        indicatorSize: TabBarIndicatorSize.label,
        onTap: (int i) {
          onTabPressed(i);
        },
        tabs: [
          Tab(
              icon: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/icons/ic_profile_pics.png",
                height: 13,
                color: Provider.of<ThemeProvider>(context)
                            .theme1model
                            .shareBtnColor !=
                        null
                    ? HexColor(Provider.of<ThemeProvider>(context)
                        .theme1model
                        .shareBtnColor!)
                    : textColorW,
              ),
              const SizedBox(width: 5),
              VariableText(
                text: "Pics",
                fontsize: 12,
                fontcolor: Provider.of<ThemeProvider>(context)
                            .theme1model
                            .shareBtnColor !=
                        null
                    ? HexColor(Provider.of<ThemeProvider>(context)
                        .theme1model
                        .shareBtnColor!)
                    : textColorW,
                fontFamily: fontMedium,
                max_lines: 1,
              ),
            ],
          )),
          Tab(
              icon: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/icons/ic_profile_albums.png",
                height: 13,
                color: Provider.of<ThemeProvider>(context)
                            .theme1model
                            .shareBtnColor !=
                        null
                    ? HexColor(Provider.of<ThemeProvider>(context)
                        .theme1model
                        .shareBtnColor!)
                    : textColorW,
              ),
              const SizedBox(width: 5),
              VariableText(
                text: "My cards",
                fontsize: 12,
                fontcolor: Provider.of<ThemeProvider>(context)
                            .theme1model
                            .shareBtnColor !=
                        null
                    ? HexColor(Provider.of<ThemeProvider>(context)
                        .theme1model
                        .shareBtnColor!)
                    : textColorW,
                fontFamily: fontMedium,
                max_lines: 1,
              ),
            ],
          )),
          Tab(
              icon: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/icons/ic_profile_clips.png",
                height: 13,
                color: Provider.of<ThemeProvider>(context)
                            .theme1model
                            .shareBtnColor !=
                        null
                    ? HexColor(Provider.of<ThemeProvider>(context)
                        .theme1model
                        .shareBtnColor!)
                    : textColorW,
              ),
              const SizedBox(width: 5),
              VariableText(
                text: "Vlips ",
                fontsize: 12,
                fontcolor: Provider.of<ThemeProvider>(context)
                            .theme1model
                            .shareBtnColor !=
                        null
                    ? HexColor(Provider.of<ThemeProvider>(context)
                        .theme1model
                        .shareBtnColor!)
                    : textColorW,
                fontFamily: fontMedium,
                max_lines: 1,
              ),
            ],
          ))
        ],
      );

  onTabPressed(int i) {
    setState(() {
      tabViewController!.animateTo(i);
    });
  }

  bool _toggler = true;
  bool showPrevYear = false;

  @override
  void initState() {
    // Future.delayed(const Duration(seconds: 5), () {
    //   if (mounted) setState(() => getUserVid());
    // });
    super.initState();

    tabController = TabController(length: 3, vsync: this);
    tabViewController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
  }

  Future getImage() async {
    setState(() {
      selectedImage = imageFile1!;
    });
    //return image;
  }

  late Timer _timer;
  final interval = const Duration(seconds: 5);
  int timerMaxSeconds = 120;
  int currentSeconds = 0;

  bool isMessageSending = false;
  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';
  get durationText =>
      duration != null ? duration.toString().split('.').first : '';
  get positionText =>
      position != null ? position.toString().split('.').first : '';

  late Duration duration;
  late Duration position;
  startTimer(int milliseconds) {
    var duration = interval;
    _timer = Timer.periodic(duration, (timer) {
      if (mounted) {}
    });
  }

  // void dispose() {
  //   for (var item in _controllers) {
  //     item.dispose();
  //   }
  //   print("videos disposed");
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    var primarycolor = Provider.of<ThemeProvider>(context).theme1model;
    sharebtnbg = primarycolor.shareBtnBg!;
    sharebtncolor = primarycolor.shareBtnColor!;
    var size = MediaQuery.of(context).size;
    var user = Provider.of<UserProvider>(context).user;
    List<String> photo = Provider.of<GetPhotoProvider>(context).img;
    List<String> video1 = Provider.of<GetVideoProvider>(context).vid;
    List<String> albums1 = Provider.of<AlbumProvider>(context).albu;
    // getUserPhotos();
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SpeedDial(
          icon: Icons.add,
          iconTheme: IconThemeData(color: Theme.of(context).iconTheme.color),
          activeIcon: Icons.close,
          buttonSize: size.height * 0.05,
          visible: true,
          closeManually: false,
          curve: Curves.bounceInOut,
          overlayColor: Colors.transparent,
          overlayOpacity: 0.5,
          onOpen: () => print('OPENING DIAL'),
          onClose: () => print('DIAL CLOSED'),
          tooltip: 'Speed Dial',
          heroTag: 'speed-dial-hero-tag',
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 8.0,
          shape: CircleBorder(),
          gradientBoxShape: BoxShape.circle,
          orientation: SpeedDialOrientation.Up,
          children: [
            SpeedDialChild(
              label: "Pics",
              labelBackgroundColor: Theme.of(context).primaryColor,
              labelStyle: TextStyle(
                color: Theme.of(context).iconTheme.color,
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Image.asset(
                  "assets/icons/camera.png",
                  scale: 1,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
              backgroundColor: Theme.of(context).primaryColor,
              onTap: () async {
                Navigator.push(
                    context, SwipeLeftAnimationRoute(widget: Post_Feeds()));
                // imageFile1 = await _picker.pickImage(source: ImageSource.gallery);

                // uploadUserImage(imageFile1!.path, accessToken!);

                // getUserPhotos();
              },
            ),
            SpeedDialChild(
              label: "Vlips",
              labelBackgroundColor: Theme.of(context).primaryColor,
              labelStyle: TextStyle(color: Theme.of(context).iconTheme.color),
              child: IconButton(
                icon: Image.asset(
                  "assets/icons/video.png",
                  scale: 1,
                  color: Theme.of(context).iconTheme.color,
                ),
                onPressed: () async {
                  XFile? image =
                      await _picker.pickVideo(source: ImageSource.gallery);
                  uploadUserVideo(image!, accessToken.toString());

                  // getUserVid();
                },
              ),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            SpeedDialChild(
              label: "Chat",
              labelBackgroundColor: Theme.of(context).primaryColor,
              labelStyle: TextStyle(
                color: Theme.of(context).iconTheme.color,
              ),
              child: IconButton(
                icon: Image.asset(
                  "assets/icons/chat.png",
                  scale: 1,
                  color: Theme.of(context).iconTheme.color,
                ),
                onPressed: () {
                  Navigator.push(
                      context, SwipeLeftAnimationRoute(widget: AllChats()));
                },
              ),
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
      body: NestedScrollView(
        controller: _scrollController,
        floatHeaderSlivers: false,
        physics: NeverScrollableScrollPhysics(),
        headerSliverBuilder: (context, value) {
          return [
            SliverAppBar(
              backgroundColor: Colors.black,
              automaticallyImplyLeading: false,
              floating: true,
              pinned: true,
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        SwipeLeftAnimationRoute(widget: ProfileMenuScreen()));
                  },
                ),
              ],
            ),

            ///Header
            SliverToBoxAdapter(
                child: SizedBox(
              height: size.height * 0.25,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      "assets/tempImages/Steelers_Stadium.jpg",
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned.fill(
                      child: Container(
                    color: Colors.black.withOpacity(0.8),
                  )),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ///Header
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.06),
                          child: Container(
                            height: size.height,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(200),
                                  child: CachedNetworkImage(
                                    imageUrl: user.img!.toString(),
                                    fit: BoxFit.fill,
                                    height: size.height * 0.09,
                                    width: size.width * 0.19,
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),

                                  // Image.network(
                                  //   user.img!,
                                  //   scale: 3.5,
                                  //   fit: BoxFit.fill,
                                  //   height: size.height * 0.09,
                                  //   width: size.width * 0.19,
                                  // )
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    VariableText(
                                      text: user.name!.toUpperCase(),
                                      fontcolor: primaryColorW,
                                      fontsize: size.height * 0.022,
                                      fontFamily: fontBold,
                                      max_lines: 1,
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: size.height * 0.01),
                                    VariableText(
                                      text: "@${user.username!}",
                                      fontcolor: primaryColorW,
                                      fontsize: size.height * 0.014,
                                      fontFamily: fontRegular,
                                      max_lines: 1,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              SwipeUpAnimationRoute(
                                                  widget: QrScanScreen()));
                                        },
                                        child: Image.asset(
                                          "assets/icons/Scan1.png",
                                          scale: 2,
                                          fit: BoxFit.fill,
                                          // height: size.height * 0.07,
                                          // width: size.width * 0.15,
                                        )),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: size.height * 0.02),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.08),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.location_on_outlined,
                                    size: size.height * 0.02,
                                    color: primaryColorW),
                                SizedBox(width: 1),
                                VariableText(
                                  text: "${user.city},${user.nationality}",
                                  fontcolor: primaryColorW,
                                  fontsize: size.height * 0.012,
                                  fontFamily: fontRegular,
                                  max_lines: 1,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Image.asset("assets/icons/ic_profile_star.png",
                                    height: size.height * 0.018),
                                SizedBox(width: 1),
                                VariableText(
                                  text: "CLASS: 2023",
                                  fontcolor: primaryColorW,
                                  fontsize: size.height * 0.014,
                                  fontFamily: fontRegular,
                                  max_lines: 1,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                    ],
                  ),
                ],
              ),
            )),

            ///Team
            SliverToBoxAdapter(
                child: Column(
              children: [
                Container(
                  height: size.height * 0.11,
                  color: backgroundColor1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //SizedBox(height: size.height * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  SwipeLeftAnimationRoute(
                                      widget: ProfileSocialMain(
                                    Id: 2,
                                  )));
                            },
                            child: Image.asset("assets/icons/ic_logo.png",
                                height: size.height * 0.06),
                          ),
                          Image.network(
                            user.team!.img!,
                            height: size.height * 0.07,
                            width: size.width * 0.15,
                            fit: BoxFit.fill,
                          ),
                          Image.asset("assets/tempImages/profile_badge_3.png",
                              height: size.height * 0.05),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  height: size.height * 0.08,
                  color: Theme.of(context).primaryColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    SwipeLeftAnimationRoute(
                                        widget: ProfileSocialMain(
                                      Id: 0,
                                    )));
                              },
                              child: VariableText(
                                text: "TRIBE 10K",
                                fontsize: size.height * 0.022,
                                fontcolor: Theme.of(context).iconTheme.color,
                                fontFamily: fontBold,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Container(
                            height: size.height * 0.04,
                            width: 2,
                            color: primaryColorB,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    SwipeLeftAnimationRoute(
                                        widget: ProfileSocialMain(
                                      Id: 1,
                                    )));
                              },
                              child: VariableText(
                                text: "JOINET 928",
                                fontsize: size.height * 0.022,
                                fontcolor: Theme.of(context).iconTheme.color,
                                fontFamily: fontBold,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )),
            SliverAppBar(
              backgroundColor: HexColor(primarycolor.shareBtnBg!),
              automaticallyImplyLeading: false,
              floating: false,
              pinned: true,
              toolbarHeight: size.height * 0.06,
              collapsedHeight: size.height * 0.06,
              expandedHeight: size.height * 0.06,
              flexibleSpace: _tabBar,
            ),
          ];
        },
        body: TabBarView(
          controller: tabViewController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Consumer<GetPhotoProvider>(
              builder: (BuildContext context, value, Widget? child) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      isupLoading == true
                          ? Container(
                              height: 1, child: LinearProgressIndicator())
                          : GridView.builder(
                              itemCount: user.photos!.length,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: size.width * 0.005,
                                      mainAxisSpacing: size.width * 0.005,
                                      mainAxisExtent: size.height * 0.185
                                      //childAspectRatio: 0.80,
                                      ),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, int index) {
                                // var user =
                                //     Provider.of<UserProvider>(context).user;
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        SwipeUpAnimationRoute(
                                            widget: ViewSinglePost(
                                                id: user.photos![index].id
                                                    .toString(),
                                                photo: user.photos![index].name
                                                    .toString())));
                                  },
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        user.photos![index].name.toString(),
                                    fit: BoxFit.fitWidth,
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                );
                              }),
                    ],
                  ),
                );
              },
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  isupLoading == true
                      ? Container(height: 1, child: LinearProgressIndicator())
                      : ListView.separated(
                          separatorBuilder: (_, index) {
                            return Divider(
                                color: primaryColorB,
                                height: size.height * 0.05,
                                thickness: 1);
                          },
                          itemCount: 1,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (_, index) {
                            return Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding:
                                    EdgeInsets.only(top: size.height * 0.08),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        VariableText(
                                          text: showPrevYear
                                              ? 'CLASS 2022'
                                              : 'CLASS 2023',
                                          fontsize: size.height * 0.018,
                                          fontcolor: textColorW,
                                          fontFamily: fontSemiBold,
                                          weight: FontWeight.w600,
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(height: size.height * 0.01),
                                        Container(
                                          height: size.height * 0.65,
                                          width: size.width * 0.70,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
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
                                                                Radius.circular(
                                                                    20)),
                                                      ),
                                                      height:
                                                          size.height * 0.45,
                                                      width: size.width,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child:
                                                            user.cardImg != null
                                                                ? ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            30),
                                                                    child:
                                                                        CachedNetworkImage(
                                                                      imageUrl:
                                                                          user.cardImg!,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      imageBuilder:
                                                                          (context, imageProvider) =>
                                                                              Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          image:
                                                                              DecorationImage(
                                                                            image:
                                                                                imageProvider,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      // placeholder: (context, url) =>
                                                                      //     CircularProgressIndicator(
                                                                      //   color: Theme.of(context)
                                                                      //       .primaryColor,
                                                                      // ),
                                                                      errorWidget: (context,
                                                                              url,
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
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          VariableText(
                                                                        text:
                                                                            "No Image Found!",
                                                                        fontsize:
                                                                            size.height *
                                                                                0.026,
                                                                        fontcolor:
                                                                            textColorB,
                                                                        fontFamily:
                                                                            fontBold,
                                                                        weight:
                                                                            FontWeight.w700,
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        max_lines:
                                                                            2,
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
                                                                primarycolor
                                                                    .shareBtnBg!),
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        200))),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child:
                                                              SvgPicture.asset(
                                                            'assets/icons/share1.svg',
                                                            color: HexColor(
                                                                primarycolor
                                                                    .shareBtnColor!),
                                                            width: size.width *
                                                                0.002,
                                                            height:
                                                                size.height *
                                                                    0.02,
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
                                                        height:
                                                            size.height * 0.04,
                                                        width: size.width * 0.3,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5)),
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: SizedBox(
                                                            height:
                                                                size.height *
                                                                    0.04,
                                                            width: size.width *
                                                                0.04,
                                                            child: Image.asset(
                                                              'assets/icons/nfl1.png',
                                                              color: Theme.of(
                                                                      context)
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
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    SizedBox(
                                                      height:
                                                          size.height * 0.05,
                                                      child: Image.asset(
                                                        'assets/icons/nflcard.png',
                                                        color: Theme.of(context)
                                                            .iconTheme
                                                            .color,
                                                        scale: 5,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          size.height * 0.09,
                                                      child: teamImage != null
                                                          ? Image.network(
                                                              user.team!.img!,
                                                              height:
                                                                  size.height)
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
                                                      height:
                                                          size.height * 0.05,
                                                      child: SvgPicture.asset(
                                                        'assets/icons/yearnike.svg',
                                                        color: Theme.of(context)
                                                            .iconTheme
                                                            .color,
                                                        width:
                                                            size.width * 0.01,
                                                        height:
                                                            size.height * 0.03,
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
                                                  text: user.name!
                                                      .toUpperCase()
                                                      .toString(),
                                                  fontsize: size.height * 0.022,
                                                  fontcolor: Theme.of(context)
                                                      .iconTheme
                                                      .color,
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
                                                      "${'${user.team!.name!.toUpperCase()} ${user.team!.nickName!.toUpperCase()} FAN'}",
                                                  fontsize: size.height * 0.013,
                                                  fontcolor: Theme.of(context)
                                                      .iconTheme
                                                      .color,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                            "assets/images/fanhall_logo.png",
                                            scale: 2.8),
                                        //Image.asset("assets/tempImages/fancard_back.png", height: size.height * 0.65),
                                        Container(
                                          height: size.height * 0.65,
                                          width: size.width * 0.70,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      size.height * 0.06)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                  height: size.height * 0.03),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  InkWell(
                                                    onTap: () {},
                                                    child: Image.network(
                                                      user.team!.img!,
                                                      height:
                                                          size.height * 0.065,
                                                      width: size.width * 0.14,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                  ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      child: Image.network(
                                                        user.img!,
                                                        height:
                                                            size.height * 0.08,
                                                        width:
                                                            size.width * 0.17,
                                                        fit: BoxFit.fill,
                                                      )),
                                                  user.nationality == "Canada"
                                                      ? Image.asset(
                                                          "assets/icons/canadaflag.png",
                                                          height: size.height *
                                                              0.04,
                                                          width:
                                                              size.width * 0.12,
                                                          fit: BoxFit.fill,
                                                        )
                                                      : user.nationality ==
                                                              "United States"
                                                          ? Image.asset(
                                                              "assets/icons/usaflag.png",
                                                              height:
                                                                  size.height *
                                                                      0.04,
                                                              width:
                                                                  size.width *
                                                                      0.12,
                                                              fit: BoxFit.fill,
                                                            )
                                                          : user.nationality ==
                                                                  "Mexico"
                                                              ? Image.asset(
                                                                  "assets/icons/mexicoflag.png",
                                                                  height:
                                                                      size.height *
                                                                          0.04,
                                                                  width:
                                                                      size.width *
                                                                          0.12,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                )
                                                              : Container(),
                                                ],
                                              ),
                                              SizedBox(
                                                  height: size.height * 0.01),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      VariableText(
                                                        text: user.name!
                                                            .toUpperCase(),
                                                        fontsize:
                                                            size.height * 0.024,
                                                        fontcolor:
                                                            Theme.of(context)
                                                                .iconTheme
                                                                .color,
                                                        fontFamily: fontBold,
                                                        weight: FontWeight.w600,
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      VariableText(
                                                        text: user.nationality ==
                                                                "United States"
                                                            ? "${user.city}, USA/ 2023"
                                                            : "${user.city}, ${user.nationality}/ 2023",
                                                        fontsize:
                                                            size.height * 0.012,
                                                        fontcolor:
                                                            Theme.of(context)
                                                                .iconTheme
                                                                .color,
                                                        fontFamily: fontRegular,
                                                        weight: FontWeight.w500,
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              Divider(
                                                  color: textColor2,
                                                  thickness: 1,
                                                  height: size.height * 0.03),

                                              ///buttons
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        size.width * 0.04),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: MyButton(
                                                        btnHeight:
                                                            size.height * 0.04,
                                                        btnColor: HexColor(
                                                            primarycolor
                                                                .shareBtnBg!),
                                                        borderColor: HexColor(
                                                            primarycolor
                                                                .shareBtnBg!),
                                                        btnRadius: 200,
                                                        btnTxt: "My Profile",
                                                        fontSize:
                                                            size.height * 0.012,
                                                        fontFamily: fontMedium,
                                                        weight: FontWeight.w500,
                                                        txtColor: HexColor(
                                                            primarycolor
                                                                .shareBtnColor!),
                                                        onTap: () {
                                                          // widget.onProfile!();
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        width:
                                                            size.width * 0.02),
                                                    Expanded(
                                                      child: MyButton(
                                                        btnHeight:
                                                            size.height * 0.04,
                                                        btnColor: HexColor(
                                                            primarycolor
                                                                .shareBtnBg!),
                                                        borderColor: HexColor(
                                                            primarycolor
                                                                .shareBtnBg!),
                                                        btnRadius: 200,
                                                        btnTxt: "Showcase",
                                                        fontSize:
                                                            size.height * 0.012,
                                                        fontFamily: fontMedium,
                                                        weight: FontWeight.w500,
                                                        txtColor: HexColor(
                                                            primarycolor
                                                                .shareBtnColor!),
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              SwipeLeftAnimationRoute(
                                                                  widget:
                                                                      ShowcaseMainScreen()));
                                                        },
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  size.width *
                                                                      0.02),
                                                      child: Icon(
                                                        Icons.share_outlined,
                                                        color: HexColor(
                                                            primarycolor
                                                                .shareBtnColor!),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          size.width * 0.08,
                                                      vertical:
                                                          size.height * 0.035),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: primaryColorW,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25)),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: size
                                                                          .height *
                                                                      0.015),
                                                          decoration: BoxDecoration(
                                                              color: HexColor(
                                                                  primarycolor
                                                                      .shareBtnBg!),
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          25),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          25))),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              VariableText(
                                                                text:
                                                                    "@${user.username}",
                                                                fontsize:
                                                                    size.height *
                                                                        0.014,
                                                                fontcolor: HexColor(
                                                                    primarycolor
                                                                        .shareBtnColor!),
                                                                fontFamily:
                                                                    fontRegular,
                                                                weight:
                                                                    FontWeight
                                                                        .w500,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(20),
                                                            child: SizedBox(
                                                              height:
                                                                  size.height *
                                                                      0.15,
                                                              width:
                                                                  size.width *
                                                                      0.5,
                                                              child: SvgPicture
                                                                  .network(
                                                                "https://fanhall.app/${user.qrCode}",
                                                                placeholderBuilder:
                                                                    (BuildContext
                                                                            context) =>
                                                                        const CircularProgressIndicator(),
                                                                fit: BoxFit
                                                                    .cover,
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
                                                    horizontal:
                                                        size.width * 0.02),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: VariableText(
                                                        text: user.userId!
                                                            .toUpperCase(),
                                                        fontsize:
                                                            size.height * 0.010,
                                                        fontcolor:
                                                            Theme.of(context)
                                                                .iconTheme
                                                                .color,
                                                        fontFamily: fontRegular,
                                                        weight: FontWeight.w500,
                                                        textAlign:
                                                            TextAlign.center,
                                                        max_lines: 2,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                  height: size.height * 0.03),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                //child: Image.asset("assets/tempImages/fancard_front.png", height: size.height * 0.65),
                              ),
                            );
                          })
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  isupLoading == true
                      ? Container(height: 1, child: LinearProgressIndicator())
                      :
                      // _controllers.isEmpty
                      //     ? renderNoDataFound("No videos found",
                      //     )
                      //     :
                      Column(
                          children: [
                            GridView.builder(
                              itemCount: user.vclips!.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 2,
                                crossAxisSpacing: 2,
                              ),
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        SwipeUpAnimationRoute(
                                            widget: singleVideo(
                                                id: user.vclips![index].id,
                                                video: user.vclips![index].name
                                                    .toString())));
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: size.height * 2,
                                        color: Colors.grey,
                                        child: Image.network(
                                            "http://icons.iconarchive.com/icons/thiago-silva/palm/256/Videos-icon.png"),
                                      ),
                                      // ElevatedButton(
                                      //   onPressed: () {
                                      //     // setState(() {
                                      //     //   _controllers[index]
                                      //     //           .value
                                      //     //           .isPlaying
                                      //     //       ? _controllers[index]
                                      //     //           .pause()
                                      //     //       : _controllers[index]
                                      //     //           .play();
                                      //     // });
                                      //   },
                                      //   child: Icon(Icons.play_arrow),
                                      // )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  renderNoDataFound(String content) {
    var size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: size.height * 0.01),
        VariableText(
          text: content,
          fontFamily: fontRegular,
          fontsize: size.height * 0.020,
          fontcolor: Theme.of(context).iconTheme.color,
        ),
      ],
    );
  }
}
