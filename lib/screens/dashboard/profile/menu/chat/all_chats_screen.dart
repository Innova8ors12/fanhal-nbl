import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fan_hall/controller/auth/league_api.dart';
import 'package:fan_hall/models/chat_model.dart';
import 'package:fan_hall/models/user_model.dart';
import 'package:fan_hall/providers/theme_provider.dart';
import 'package:fan_hall/providers/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../widgets/common.dart';
import '../../../../../widgets/style.dart';
import '../../profile_menu_screen.dart';
import 'chat_screen.dart';

class AllChats extends StatefulWidget {
  const AllChats({Key? key}) : super(key: key);

  @override
  State<AllChats> createState() => _AllChatsState();
}

class _AllChatsState extends State<AllChats> with TickerProviderStateMixin {
  ScrollController? _scrollController;
  List<ChatModel> allMessages = [];
  bool isLoading = false;

  DateFormat chatTimeFormatter = DateFormat("hh:mm");
  late Timer _timer;

  final interval = const Duration(seconds: 5);

  setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

  getChatList() async {
    setLoading(true);
    // var userDetails = Provider.of<UserModel>(context, listen: false);
    var response = await ApiModel.getChatList(accessToken.toString());
    if (response != null) {
      allMessages.clear();
      if (response['status']) {
        for (var item in response['data']) {
          if (item['user'] != null) {
            allMessages.add(ChatModel.fromJson(item));
          }
        }
      }
      setLoading(false);
      startTimer(1);
    } else {
      allMessages.clear();
      setLoading(false);
      Fluttertoast.showToast(
          msg: "Try again later", toastLength: Toast.LENGTH_SHORT);
    }
  }

  updateChatList() async {
    // var userDetails = Provider.of<UserModel>(context, listen: false);
    var response = await ApiModel.getChatList(accessToken.toString());
    if (response != null) {
      allMessages.clear();
      if (response['status']) {
        for (var item in response['data']) {
          if (item['user'] != null) {
            allMessages.add(ChatModel.fromJson(item));
          }
        }
      }
      setState(() {});
    } else {
      _timer.cancel();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getChatList();
    _scrollController = ScrollController();
  }

  startTimer(int milliseconds) {
    var duration = interval;
    _timer = Timer.periodic(duration, (timer) {
      if (mounted) {
        updateChatList();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     var color = Provider.of<ThemeProvider>(context).theme1model;
    var size = MediaQuery.of(context).size;
 var user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      backgroundColor: primaryColorB,
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
              leading: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(Icons.arrow_back, color: primaryColorW)),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),

            ///Header
            SliverToBoxAdapter(
                child: SizedBox(
              height: size.height * 0.20,
              child: Stack(
                children: [
                  Positioned.fill(
                    child:
                        Image.asset("assets/tempImages/profile_background.png"),
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                      "assets/tempImages/profile_barcode.png",
                                      height: size.height * 0.05),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      VariableText(
                                        text: user.name!.toUpperCase(),
                                        fontcolor: primaryColorW,
                                        fontsize: size.height * 0.022,
                                        fontFamily: fontBold,
                                        max_lines: 1,
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: size.height * 0.01),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      VariableText(
                                        text: user.username,
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
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: size.height * 0.05,
                                    width: size.height * 0.05,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(200)),
                                    child: Icon(Icons.add,
                                        size: size.height * 0.035),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
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
                                  text: user.username,
                                  fontcolor: primaryColorW,
                                  fontsize: size.height * 0.014,
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
          ];
        },
        body: Container(
          color: backgroundColor1,
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: size.height * 0.01,
                horizontal: size.width * horizontalPadding),
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      VariableText(
                        text: "Messages",
                        fontcolor: primaryColorW,
                        fontsize: size.height * 0.016,
                        fontFamily: fontSemiBold,
                        max_lines: 1,
                      ),
                      VariableText(
                        text: "Requests",
                        fontcolor: textColor3,
                        fontsize: size.height * 0.016,
                        fontFamily: fontSemiBold,
                        max_lines: 1,
                        underlined: true,
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.02),
                  MySearchTextField(
                    text: "Search",
                  ),
                  allMessages.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                VariableText(
                                  text: "No chat found",
                                  fontcolor: HexColor(color.textColor!),
                                  fontsize: size.height * 0.020,
                                ),
                              ],
                            ),
                          ],
                        )
                      : ListView.builder(
                          itemCount: allMessages.length,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (_, index) {
                            return allMessages[index].chatdetail==null?Container(): InkWell(
                              onTap: () {
                                _timer.cancel();
                                Navigator.push(
                                    context,
                                    SwipeUpAnimationRoute(
                                      widget:ChatScreen(id: allMessages[index].user!.id!.toString() ,
                                      chatDetail: allMessages[index].user!,
                                      
                                      ),
                                    )).then((value) {
                                  updateChatList();
                                  startTimer(1);
                                });
                              },
                              child: SwipeActionCell(
                      key: ObjectKey("EE"),
                      trailingActions: <SwipeAction>[
                        SwipeAction(
                            title: "Delete",
                            onTap: (CompletionHandler handler) async {
                              await handler(true);
                              setState(() {});
                            },
                            color: Color(0xFFC60C30)),
                      ],
                      child:Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(200),
                                        child: CachedNetworkImage(
                                          imageUrl: allMessages[index]
                                              .user!
                                              .img
                                              .toString(),
                                          fit: BoxFit.cover,
                                          height: size.height * 0.065,
                                          width: size.height * 0.065,
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              Padding(
                                            padding: const EdgeInsets.all(45.0),
                                            child: CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        )),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: size.width * 0.02),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: VariableText(
                                                    text: allMessages[index]
                                                        .user!
                                                        .username
                                                        .toString(),
                                                    fontcolor: primaryColorW,
                                                    fontsize:
                                                        size.height * 0.018,
                                                    fontFamily: fontSemiBold,
                                                    max_lines: 1,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                VariableText(
                                                    text:allMessages[index].chatdetail!.content!.toString(),
                                                    fontcolor: primaryColorW,
                                                    fontsize:
                                                        size.height * 0.014,
                                                    fontFamily: fontRegular,
                                                    max_lines: 1,
                                                  ),
                                                Expanded(
                                                  child: allMessages[index]
                                                        .chatdetail!
                                                        .isSeen
                                                        .toString()=="1"?VariableText(
                                                    text:"seen",
                                                    fontcolor: primaryColorW,
                                                    fontsize:
                                                        size.height * 0.014,
                                                    fontFamily: fontRegular,
                                                    max_lines: 1,
                                                  ) :VariableText(
                                                    text:"",
                                                    fontcolor: primaryColorW,
                                                    fontsize:
                                                        size.height * 0.014,
                                                    fontFamily: fontRegular,
                                                    max_lines: 1,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Icon(Icons.camera_alt_outlined,
                                        color: primaryColorW)
                                  ],
                                ),
                              ),
                  ),
                              
                              
                              
                               
                            );
                          },
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // renderChatTile(BuildContext context){
  //   var size = MediaQuery.of(context).size;
  //   return
  // }
}
