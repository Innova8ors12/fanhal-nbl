import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fan_hall/controller/auth/league_api.dart';
import 'package:fan_hall/controller/config.dart';
import 'package:fan_hall/models/get_feeds.dart';
import 'package:fan_hall/models/get_photos.dart';
import 'package:fan_hall/providers/theme_provider.dart';
import 'package:fan_hall/providers/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../../widgets/common.dart';
import 'package:expandable/expandable.dart';
import '../../../../widgets/style.dart';
import '../menu/chat/chat_screen.dart';

class NewsfeedScreen extends StatefulWidget {
  NewsfeedScreen({Key? key}) : super(key: key);

  @override
  State<NewsfeedScreen> createState() => _NewsfeedScreenState();
}

class _NewsfeedScreenState extends State<NewsfeedScreen> {
  bool isLoading = false;
  TextEditingController _commentController = TextEditingController();
  List<GetFeeds> feedsPhoto = [];
  List<Comment> feedcomments = [];
  List<String> feedsusers = [];
  List<String> feedsuserimage = [];
  List<String> feedscommentscount = [];
  bool isMessageSending = false;

  setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }
  
  bool setlike = false;

  islike(bool loading) {
    setState(() {
      setlike = loading;
    });
  }

  Future likePhoto(String userId, String photoId, String token) async {
    var url = CONFIG.domain + CONFIG.likephoto;
    islike(false);
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer " + token
      },
      body:
          jsonEncode(<String, String>{'user_id': userId, 'photo_id': photoId}),
    );

    if (response.statusCode == 200) {
      var show = jsonDecode(response.body);
      islike(true);
    } else {}
  }

  setMessageSending(bool loading) {
    setState(() {
      isMessageSending = loading;
    });
  }



  int currentPage = 1; // Initial page number
int itemsPerPage = 10; // Number of feeds per page
 // Indicates whether new feeds are being loaded
bool hasMorePages = true; 

  // getfeedsphoto() async {
  //   setLoading(true);
  //   var res = await ApiModel().getfeeds(accessToken.toString());

  //   GetFeeds? _getFeeds;
  //   // print(res);
  //   feedsPhoto.clear();
  //   if (res != null && res['status']) {
  //     for (var item in res['data']) {
  //       _getFeeds = GetFeeds.fromJson(item);

  //       feedsPhoto.add(_getFeeds);
      

  //     }
  //     setLoading(false);
  //     print(feedsPhoto.length);
    
  //     setState(() {});
  //   }
  // }
  Future<void> getfeedsphoto() async {
  if (isLoading || !hasMorePages) return; // Don't fetch if already loading or no more pages
  
  setLoading(true);
  
  var res = await ApiModel().getfeeds(accessToken.toString(), page: currentPage, limit: itemsPerPage);
  
  GetFeeds? _getFeeds;
  feedsPhoto.clear();
  
  if (res != null && res['status']) {
    for (var item in res['data']) {
      _getFeeds = GetFeeds.fromJson(item);
      feedsPhoto.add(_getFeeds);
    }
    
    setLoading(false);
    print(feedsPhoto.length);
    setState(() {});
    
    if (feedsPhoto.length < itemsPerPage) {
      hasMorePages = false; // Reached the last page
    } else {
      currentPage++;
    }
  }
}

  sendComment({String? content, String? id, String? photoId}) async {
    
    setMessageSending(true);
    //scrollToBottom();
    var response = await ApiModel.sendComment(
        id: id, content: content!, photoId: photoId!, accessToken: accessToken);
    if (response != null) {
      if (response['status']) {
        Comment? _getcomments;
        // print(res);
        feedcomments.clear();
        _commentController.clear();
     
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

  @override
  void initState() {
    getfeedsphoto();
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) setState(() => getfeedsphoto());
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var color = Provider.of<ThemeProvider>(context).theme1model;
    var size = MediaQuery.of(context).size;
    var user = Provider.of<UserProvider>(context).user;
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
  children: [
    isLoading
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: size.width * 0.1,
              height: size.height * 0.05,
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            ),
          )
        : ListView.builder(
            itemCount: feedsPhoto.length + (hasMorePages ? 1 : 0),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              if (index == feedsPhoto.length) {
                // Show "Load More" button at the end
                return TextButton(
                  onPressed: () {
                    getfeedsphoto();
                  },
                  child: Text(
                    'Load More',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: size.height * 0.016,
                    ),
                  ),
                );
              } else {
                final reversedIndex = feedsPhoto.length - 1 - index;
                final reversedItem = feedsPhoto[reversedIndex];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.08),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(200),
                                    child: SizedBox(
                                      height: size.height * 0.05,
                                      width: size.width * 0.1,
                                      child: Container(
                                        height: size.height * 0.5,
                                        child: CachedNetworkImage(
                                          imageUrl: feedsPhoto[index]
                                              .user!
                                              .img!
                                              .toString(),
                                          fit: BoxFit.fitWidth,

                                          // progressIndicatorBuilder: (context, url, downloadProgress) =>
                                          //         CircularProgressIndicator(value: downloadProgress.progress),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: size.width * 0.02),
                                  Expanded(
                                    child: VariableText(
                                      text: feedsPhoto[index]
                                          .user!
                                          .username
                                          .toString(),
                                      fontsize: size.height * 0.014,
                                      fontcolor: primaryColorW,
                                      fontFamily: fontMedium,
                                      weight: FontWeight.w400,
                                      textAlign: TextAlign.start,
                                      max_lines: 1,
                                      underlined: true,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: size.height * 0.02),
                                child: CachedNetworkImage(
                                  imageUrl: feedsPhoto[index].name!.toString(),
                                  fit: BoxFit.fitWidth,
                                  // progressIndicatorBuilder: (context, url, downloadProgress) =>
                                  //         CircularProgressIndicator(value: downloadProgress.progress),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                )

                                // Image.network(feedsPhoto[index].name!.toString()),
                                ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.08),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            likePhoto(
                                                feedsPhoto[index]
                                                    .user!
                                                    .id!
                                                    .toString(),
                                                feedsPhoto[index].id.toString(),
                                                accessToken.toString());
                                            getfeedsphoto();
                                          },
                                          child: Image.asset(
                                              "assets/icons/feed_like.png",
                                              color: setlike == true
                                                  ? Colors.red
                                                  : Colors.white,
                                              scale: 1.5)),
                                      InkWell(
                                        onTap: () {},
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: size.width * 0.04),
                                          child: Image.asset(
                                              "assets/icons/feed_comment.png",
                                              scale: 1.5),
                                        ),
                                      ),
                                      Image.asset("assets/icons/feed_share.png",
                                          scale: 1.5)
                                    ],
                                  ),
                                  SizedBox(height: size.height * 0.015),
                                  Row(
                                    children: [
                                      VariableText(
                                        text:
                                            '${feedsPhoto[index].likecount} Me gusta',
                                        fontsize: size.height * 0.014,
                                        fontcolor: primaryColorW,
                                        fontFamily: fontMedium,
                                        weight: FontWeight.w500,
                                        textAlign: TextAlign.start,
                                        max_lines: 1,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: size.height * 0.015),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: VariableText(
                                          text: feedsPhoto[index]
                                              .caption
                                              .toString(),
                                          fontsize: size.height * 0.014,
                                          fontcolor: primaryColorW,
                                          fontFamily: fontRegular,
                                          weight: FontWeight.w400,
                                          textAlign: TextAlign.start,
                                          max_lines: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: size.height * 0.015),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: VariableText(
                                          text: 'Ver comentarios',
                                          fontsize: size.height * 0.014,
                                          fontcolor: textColor2,
                                          fontFamily: fontRegular,
                                          weight: FontWeight.w400,
                                          textAlign: TextAlign.start,
                                          max_lines: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                     SizedBox(height: size.height * 0.015),
                                  Container(
                                    height: size.height * 0.15,
                                    child: ListView.builder(
                                        itemCount:
                                            feedsPhoto[index].comment!.length,
                                        shrinkWrap: true,
                                        physics: ScrollPhysics(),
                                        itemBuilder: (_, i) {
                                          return ListTile(
                                              leading: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                child:ClipRRect(
                                    borderRadius: BorderRadius.circular(200),
                                    child: SizedBox(
                                      height: size.height * 0.04,
                                      width: size.width * 0.08,
                                      child: Container(
                                        height: size.height * 0.5,
                                        child: CachedNetworkImage(
                                          imageUrl: feedsPhoto[index]
                                              .comment![i].user!
                                              .img!
                                              .toString(),
                                          fit: BoxFit.fitWidth,

                                          // progressIndicatorBuilder: (context, url, downloadProgress) =>
                                          //         CircularProgressIndicator(value: downloadProgress.progress),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  )
                                              ),
                                              title: VariableText(
                                                text: feedsPhoto[index]
                                                    .comment![i]
                                                    .user!.username
                                                    .toString(),
                                                fontsize: size.height * 0.014,
                                                fontcolor: primaryColorW,
                                                fontFamily: fontMedium,
                                                weight: FontWeight.w400,
                                                textAlign: TextAlign.start,
                                                max_lines: 1,
                                              ),
                                              subtitle: VariableText(
                                                text: feedsPhoto[index]
                                                    .comment![i]
                                                    .comment
                                                    .toString(),
                                                fontsize: size.height * 0.010,
                                                fontcolor: textColorG,
                                                fontFamily: fontMedium,
                                                weight: FontWeight.w300,
                                                textAlign: TextAlign.start,
                                                max_lines: 10,
                                              ),
                                              );
                                        }),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xFF252525),
                                        borderRadius:
                                            BorderRadius.circular(200)),
                                    child: Row(
                                      children: [
                                        SizedBox(width: size.width * 0.02),
                                        Expanded(
                                          child: TextFormField(
                                            controller: _commentController,
                                            style: TextStyle(
                                                color: primaryColorW,
                                                fontSize: size.height * 0.016),
                                            decoration: InputDecoration(
                                              hintText: "Write comment...",
                                              hintStyle: TextStyle(
                                                  color: textColor3,
                                                  fontSize:
                                                      size.height * 0.016),
                                              contentPadding:
                                                  EdgeInsets.all(10),
                                              filled: true,
                                              fillColor: Color(0xFF252525),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(200),
                                                borderSide: BorderSide(
                                                    color: Color(0xFF252525),
                                                    width: 2.0),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(200),
                                                borderSide: BorderSide(
                                                    color: Color(0xFF252525),
                                                    width: 2.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              isMessageSending
                                                  ? Container(
                                                      height: 25,
                                                      width: size.width * 0.06,
                                                      //color: Colors.yellow,
                                                      child:
                                                          CircularProgressIndicator(
                                                              color: Theme.of(
                                                                      context)
                                                                  .iconTheme
                                                                  .color,
                                                              strokeWidth: 3),
                                                    )
                                                  : InkWell(
                                                      onTap: () {
                                                        if (_commentController
                                                            .text.isNotEmpty) {
                                                          sendComment(
                                                              content:
                                                                  _commentController
                                                                      .text
                                                                      .trim(),
                                                              photoId: feedsPhoto[
                                                                      index]
                                                                  .id
                                                                  .toString(),
                                                              id: user.id!
                                                                  .toString());
                                                        }
                                                      },
                                                      child: Image.asset(
                                                        "assets/icons/ic_send.png",
                                                        color: HexColor(color.primaryColor!),
                                                        scale: 2.2,
                                                      ),
                                                    ),
                                              SizedBox(
                                                  width: size.width * 0.02),

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
                            )
                          ],
                        )
                        );
              }}
        )
        ],
      ),
    );
  }
}
