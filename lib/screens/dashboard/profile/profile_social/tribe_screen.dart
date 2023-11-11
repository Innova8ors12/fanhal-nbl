import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fan_hall/controller/auth/league_api.dart';
import 'package:fan_hall/models/chat_model.dart';
import 'package:fan_hall/models/get_feeds.dart';
import 'package:fan_hall/models/tribe_model.dart';

import 'package:fan_hall/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../../../../widgets/common.dart';
import '../../../../widgets/style.dart';
import '../menu/chat/chat_screen.dart';

class TribeScreen extends StatefulWidget {
  TribeScreen({Key? key}) : super(key: key);

  @override
  State<TribeScreen> createState() => _TribeScreenState();
}

class _TribeScreenState extends State<TribeScreen> {
  List<User2> allUserList = [];
  ScrollController? _scrollController;
  bool isLoading = false;

  DateFormat chatTimeFormatter = DateFormat("hh:mm");
  TextEditingController search=TextEditingController();
  late Timer _timer;

  final interval = const Duration(seconds: 5);

  setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

  updateUserList() async {
    // var userDetails = Provider.of<UserModel>(context, listen: false);
    var response = await ApiModel.getChatList(accessToken.toString());
    if (response != null) {
      allUserList.clear();
      if (response['status']) {
        for (var item in response['data']) {
          if (item['user'] != null) {
            allUserList.add(User2.fromJson(item));
          }
        }
      }
      setState(() {});
    } else {
      _timer.cancel();
    }
  }

  getUserList() async {
    setLoading(true);
    // var userDetails = Provider.of<UserModel>(context, listen: false);
    var response = await ApiModel.getUserList(accessToken.toString());
    if (response != null) {
      allUserList.clear();
      if (response['status']) {
        for (var item in response['data']) {
          allUserList.add(User2.fromJson(item));
        }
        print("pere length hai ${allUserList.length}");
      }
      setLoading(false);
      // startTimer(1);
    } else {
      allUserList.clear();
      setLoading(false);
      Fluttertoast.showToast(
          msg: "Try again later", toastLength: Toast.LENGTH_SHORT);
    }
  }

  startTimer(int milliseconds) {
    var duration = interval;
    _timer = Timer.periodic(duration, (timer) {
      if (mounted) {
        updateUserList();
      }
    });
  }
 List<String> items = [];
  List<User2> filteredItems = [];
 
  List<String> tempList = [];
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserList();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          SizedBox(height: size.height * 0.0),
          MySearchTextField(
            text: "Search",
            cont: search,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:isLoading == true
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: size.width * 0.1,
                      height: size.height * 0.05,
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      )),
                )
              : ListView.builder(
              itemCount:allUserList.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (_, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                          context,
                          SwipeUpAnimationRoute(widget: ChatScreen(id:allUserList[index].id.toString(),chatDetail:allUserList[index],)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(200),
                            child: CachedNetworkImage(
                              imageUrl: allUserList[index].img!.toString(),
                              fit: BoxFit.cover,
                              height: size.height * 0.065,
                              width: size.height * 0.065,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Padding(
                                padding: const EdgeInsets.all(45.0),
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress,
                                    color: Theme.of(context).primaryColor),
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
                                        text:allUserList[index]==null?"": allUserList[index]
                                            .username!
                                            .toString(),
                                        fontcolor: primaryColorW,
                                        fontsize: size.height * 0.018,
                                        fontFamily: fontSemiBold,
                                        max_lines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: VariableText(
                                        text: "Lorem ipsum",
                                        fontcolor: primaryColorW,
                                        fontsize: size.height * 0.014,
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
                        Image.asset("assets/icons/chat_go.png", scale: 2),
                        SizedBox(width: size.width * 0.02),
                        Image.asset("assets/icons/camera.png",color: Colors.white, scale: 1.2)
                        //Icon(Icons.camera_alt_outlined, color: primaryColorW)
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  renderChatTile(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        // Navigator.push(
        //     context,
        //     SwipeUpAnimationRoute(widget: ChatScreen(id: "1",chatDetail:allUserList[1],)));
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(200),
                child:
                    Image.asset("assets/tempImages/chat_tile.png", scale: 2)),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: VariableText(
                            text: "Olivia Rodriguez",
                            fontcolor: primaryColorW,
                            fontsize: size.height * 0.018,
                            fontFamily: fontSemiBold,
                            max_lines: 1,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: VariableText(
                            text: "Lorem ipsum",
                            fontcolor: primaryColorW,
                            fontsize: size.height * 0.014,
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
            Image.asset("assets/icons/chat_go.png", scale: 2),
            SizedBox(width: size.width * 0.02),
            Image.asset("assets/icons/chat_request.png", scale: 2)
            //Icon(Icons.camera_alt_outlined, color: primaryColorW)
          ],
        ),
      ),
    );
  }
}
