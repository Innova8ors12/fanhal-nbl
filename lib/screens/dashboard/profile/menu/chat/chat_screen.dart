import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fan_hall/controller/auth/league_api.dart';
import 'package:fan_hall/models/chat_model.dart';
import 'package:fan_hall/models/user_model.dart';
import 'package:fan_hall/providers/theme_provider.dart';
import 'package:fan_hall/providers/userProvider.dart';
import 'package:fan_hall/widgets/style.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../widgets/common.dart';

class ChatScreen extends StatefulWidget {
  final String id;
  User2 chatDetail;
  ChatScreen({Key? key, required this.id, required this.chatDetail})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _messageController = TextEditingController();
  late ScrollController _scrollController;
  List<ChatModel> allMessages = [];

  int activeNoteIndex = -1;

  //List<bool> sendingMessage = [];
  DateFormat chatTimeFormatter = DateFormat("hh:mm");

  bool isLoading = true;
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
      if (mounted) {
        updateChat();
      }
    });
  }

  setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

  void scrollToBottom() {
    if (_scrollController.hasClients) {
      final bottomOffset = _scrollController.position.maxScrollExtent;
      print(bottomOffset.toString());
      _scrollController.animateTo(
        bottomOffset + 500,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      print("No Scroll client");
    }
  }

  updateChat() async {
    print("update");
    var userDetails = Provider.of<UserProvider>(context, listen: false);
    var response = await ApiModel.getAllMessages(
        widget.id.toString(), accessToken.toString());
    if (response != null) {
      List<ChatModel> newMessages = [];
      if (response['status']) {
        for (var item in response['data']) {
          newMessages.add(ChatModel.fromJson(item));
        }
        for (var item in newMessages) {
          bool add = false;
          for (var item2 in allMessages) {
            if (item2.id == item.id) {
              add = false;
              break;
            } else {
              add = true;
            }
          }
          if (allMessages.isEmpty) {
            add = true;
          }
          if (add) {
            seeAllMessages();
            setState(() {
              allMessages.add(item);
            });
            scrollToBottom();
          }
        }
      }
    }
  }

  addMessage({
    String? senderID,
    Chatdetail? content,
  }) {
    allMessages.add(ChatModel(senderId: senderID, chatdetail: content));
  }

  setMessageSending(bool loading) {
    setState(() {
      isMessageSending = loading;
    });
  }

  getAllMessages() async {
    var response =
        await ApiModel.getAllMessages(widget.id, accessToken.toString());
    if (response != null) {
      allMessages.clear();
      if (response['status']) {
        for (var item in response['data']) {
          allMessages.add(ChatModel.fromJson(item));
        }
      }
      setLoading(false);
      seeAllMessages();
      startTimer(100);
    } else {
      allMessages.clear();
      setLoading(false);
      Fluttertoast.showToast(
          msg: "Try again later", toastLength: Toast.LENGTH_SHORT);
    }
    Future.delayed(Duration(milliseconds: 200)).then((value) {
      scrollToBottom();
    });
  }

  checkSeen() async {
    var response =
        await ApiModel.checkSeen(id: widget.id, accessToken: accessToken);
  }

  sendMessage({
    String? content,
  }) async {
    // var userDetails = Provider.of<UserModel>(context, listen: false);
    setMessageSending(true);
    //scrollToBottom();
    var response = await ApiModel.sendMessage(
        id: widget.id, content: content!, accessToken: accessToken);

    if (response != null) {
      if (response['status']) {
     getAllMessages();
        // if(!widget.partner.onHoliday){
        //   NotificationServices.postNotification(
        //       title: 'New Message',
        //       body: 'You got message from ${userDetails.name}',
        //       partnerID: widget.partner.id.toString(),
        //       purpose: 'chat',
        //       receiverToken: widget.partner.fcmToken
        //   );
        // }
        // if(widget.partner.onHoliday){
        //   renderOfficeMode();
        // }
        _messageController.clear();
        setMessageSending(false);
      } else {
        setMessageSending(false);
        Fluttertoast.showToast(
            msg: "Message not sent", toastLength: Toast.LENGTH_SHORT);
      }
    } else {
      setMessageSending(false);
      Fluttertoast.showToast(msg: "Try again", toastLength: Toast.LENGTH_SHORT);
    }
  }

  deleteMessage(String id) async {
    // var userDetails = Provider.of<UserModel>(context, listen: false);

    //scrollToBottom();
    setLoading(true);
    var response = await ApiModel.DeleteMessage(id.toString(),accessToken);

    if (response != null) {
      if (response['status']) {
        updateChat();
        setLoading(false);
        Navigator.of(context).pop();

        _messageController.clear();
      } else {
        setLoading(false);
        Fluttertoast.showToast(
            msg: "Message not sent", toastLength: Toast.LENGTH_SHORT);
      }
    } else {
      setLoading(false);
      Fluttertoast.showToast(msg: "Try again", toastLength: Toast.LENGTH_SHORT);
    }
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    checkSeen();
    _scrollController = ScrollController();
    seeAllMessages();
    getAllMessages();
  }

  void _showDialog(int id) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: new Text("Are you sure you want to delete?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            ElevatedButton(
              child: isLoading
                  ? CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    )
                  : Text("Delete"),
              onPressed: () async {
                await deleteMessage(id.toString());
                // Your deleteMessage method!
              },
            ),
            ElevatedButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    _timer.cancel();

    super.dispose();
  }

  seeAllMessages() async {
    var userDetails = Provider.of<UserProvider>(context, listen: false);
    var response = await ApiModel.seenMessage(
      id: widget.id,
      accessToken: accessToken.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var color = Provider.of<ThemeProvider>(context).theme1model;
    var userDetails = Provider.of<UserProvider>(context);
    var size = MediaQuery.of(context).size;
    var padding = size.height * 0.03;
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor1,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * horizontalPadding,
                  vertical: size.height * 0.02),
              child: Row(
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.arrow_back, color: primaryColorW)),
                  SizedBox(width: size.width * 0.02),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child: CachedNetworkImage(
                        imageUrl: widget.chatDetail.img.toString(),
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
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      )),
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.02),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: VariableText(
                                  text: widget.chatDetail.username,
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
                                  text: widget.chatDetail.name,
                                  fontcolor: primaryColorW,
                                  fontsize: size.height * 0.012,
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
                  Container(
                    height: size.height * 0.04,
                    width: size.height * 0.04,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(200)),
                    child: Center(
                        child: Icon(
                      Icons.add,
                      size: size.height * 0.025,
                      color: Theme.of(context).iconTheme.color,
                    )),
                  ),
                ],
              ),
            ),
            Container(
              height: size.height * 0.03,
              width: size.width,
              margin: EdgeInsets.only(
                top: padding - 9,
              ),
              child: Stack(
                children: [
                  Divider(
                    color: borderColor,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 3, horizontal: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: VariableText(
                          text: "Today",
                          fontFamily: fontSemiBold,
                          fontcolor: Theme.of(context).iconTheme.color,
                          fontsize: size.height * 0.013,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            allMessages == null
                ? CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  )
                : Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                            itemCount: allMessages.length,
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemBuilder: (context, index) {
                              return allMessages[index].senderId !=
                                      userDetails.user.id.toString()
                                  ? Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xFFEFF9FF),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(0),
                                            topRight: Radius.circular(5),
                                            bottomLeft: Radius.circular(5),
                                            bottomRight: Radius.circular(5)),
                                      ),
                                      margin: EdgeInsets.only(
                                          left: 15,
                                          right: size.width * 0.32,
                                          bottom: 15),
                                      padding: EdgeInsets.all(10),
                                      // height: size.height * 0.12,
                                      //width: 80,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              VariableText(
                                                text:
                                                    widget.chatDetail.username,
                                                fontFamily: fontSemiBold,
                                                fontcolor: textColor1,
                                                fontsize: size.height * 0.019,
                                              ),
                                              VariableText(
                                                text: chatTimeFormatter.format(
                                                    DateTime.parse(
                                                        allMessages[index]
                                                            .chatdetail!
                                                            .createdAt!)),
                                                fontFamily: fontRegular,
                                                fontcolor: textColor1,
                                                fontsize: size.height * 0.017,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: size.height * 0.004),
                                          VariableText(
                                            text: allMessages[index]
                                                .chatdetail!
                                                .content
                                                .toString(),
                                            fontFamily: fontRegular,
                                            fontcolor: textColor1,
                                            fontsize: size.height * 0.017,
                                            max_lines: 50,
                                          ),
                                        ],
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        _showDialog(allMessages[index]
                                            .chatdetail!
                                            .chatHistoryId!);
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Color(0xffFEE8EF),
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(5),
                                                  topRight: Radius.circular(0),
                                                  bottomLeft:
                                                      Radius.circular(5),
                                                  bottomRight:
                                                      Radius.circular(5)),
                                            ),
                                            margin: EdgeInsets.only(
                                                left: size.width * 0.32,
                                                right: 15,
                                                bottom: 15),
                                            padding: EdgeInsets.all(10),
                                            // height: size.height * 0.12,
                                            //width: 80,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    VariableText(
                                                      text: "You",
                                                      fontFamily: fontSemiBold,
                                                      fontcolor: textColor1,
                                                      fontsize:
                                                          size.height * 0.019,
                                                    ),
                                                    VariableText(
                                                      text: chatTimeFormatter
                                                          .format(DateTime.parse(
                                                              allMessages[index]
                                                                  .chatdetail!
                                                                  .createdAt!)),
                                                      fontFamily: fontRegular,
                                                      fontcolor: textColor1,
                                                      fontsize:
                                                          size.height * 0.017,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                    height:
                                                        size.height * 0.004),
                                                VariableText(
                                                  text: allMessages[index]
                                                      .chatdetail!
                                                      .content
                                                      .toString(),
                                                  fontFamily: fontRegular,
                                                  fontcolor: textColor1,
                                                  fontsize: size.height * 0.017,
                                                  max_lines: 50,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                            },
                          ),
                          Row(
                            children: [
                              // Expanded(
                              //             child: allMessages[]
                              //                   .chatdetail!
                              //                   .isSeen
                              //                   .toString()=="1"?VariableText(
                              //               text:"seen",
                              //               fontcolor: primaryColorW,
                              //               fontsize:
                              //                   size.height * 0.014,
                              //               fontFamily: fontRegular,
                              //               max_lines: 1,
                              //             ) :VariableText(
                              //               text:"",
                              //               fontcolor: primaryColorW,
                              //               fontsize:
                              //                   size.height * 0.014,
                              //               fontFamily: fontRegular,
                              //               max_lines: 1,
                              //             ),
                              //           )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
            Container(
              decoration: BoxDecoration(
                  color: Color(0xFF252525),
                  borderRadius: BorderRadius.circular(200)),
              child: Row(
                children: [
                  SizedBox(width: size.width * 0.02),
                  Expanded(
                    child: TextFormField(
                      controller: _messageController,
                      style: TextStyle(
                          color: primaryColorW, fontSize: size.height * 0.016),
                      decoration: InputDecoration(
                        hintText: "Write message...",
                        hintStyle: TextStyle(
                            color: textColor3, fontSize: size.height * 0.016),
                        contentPadding: EdgeInsets.all(10),
                        filled: true,
                        fillColor: Color(0xFF252525),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(200),
                          borderSide:
                              BorderSide(color: Color(0xFF252525), width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(200),
                          borderSide:
                              BorderSide(color: Color(0xFF252525), width: 2.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        isMessageSending
                            ? Container(
                                height: 25,
                                width: size.width * 0.06,
                                //color: Colors.yellow,
                                child: CircularProgressIndicator(
                                    color: Colors.red, strokeWidth: 3),
                              )
                            : InkWell(
                                onTap: () {
                                  if (_messageController.text.isNotEmpty) {
                                    sendMessage(
                                      content: _messageController.text.trim(),
                                    );
                                  }
                                },
                                child: Image.asset(
                                  "assets/icons/ic_send.png",
                                  color: HexColor(color.primaryColor!),
                                  scale: 2.2,
                                ),
                              ),
                        SizedBox(width: size.width * 0.02),
                        InkWell(
                            onTap: () {},
                            child: Icon(Icons.mic, color: textColor3)),
                        SizedBox(width: size.width * 0.02),
                        /*InkWell(
                          onTap: () {},
                          child: Image.asset(
                            "assets/icons/ic_emoji.png",
                            scale: 2.2,
                          ),
                        ),*/
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
