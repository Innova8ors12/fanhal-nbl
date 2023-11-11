
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fan_hall/controller/auth/league_api.dart';
import 'package:fan_hall/models/get_feeds.dart';
import 'package:fan_hall/providers/theme_provider.dart';
import 'package:fan_hall/providers/userProvider.dart';
import 'package:fan_hall/screens/dashboard/profile/profile_menu_screen.dart';
import 'package:fan_hall/widgets/common.dart';
import 'package:fan_hall/widgets/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
class singleVideo extends StatefulWidget {
   final id;
  final video;
  const singleVideo({super.key,required this.id,required this.video});

  @override
  State<singleVideo> createState() => _singleVideoState();
}

class _singleVideoState extends State<singleVideo> {
  late VideoPlayerController _controller;
  @override
  GetFeeds? feedsPhotosingle;
  List<Comment> feedcomments = [];
    bool isLoading = false;
   setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }
   getfeedsphoto() async {
    setLoading(true);
    var res = await ApiModel().getsnglepost(accessToken.toString(),widget.id.toString());


    GetFeeds? _getFeeds;
    // print(res);
    bool setlike = false;

  islike(bool loading) {
    setState(() {
      setlike = loading;
    });
  }
    if (res != null && res['status']) {
   
        _getFeeds = GetFeeds.fromJson(res['data']);

        feedsPhotosingle =_getFeeds;
        // feedsuserimage.add(_getFeeds.user!.img!.toString());
        // feedsusers.add(_getFeeds.user!.username!.toString());
        // feedscommentscount.add(_getFeeds.comment![item].comment.toString());
// //  herosNameIdTeams.add(_herosName.id!.toString());

      
      setLoading(false);
      // print(feedsPhotosingle.length);
      // nationalId = leagueModel!.data![1]!.id.toString();
      setState(() {});
    }
    setLoading(false);
  }
  @override
  void initState() {
    // TODO: implement initState
     getfeedsphoto();
    super.initState();
     _controller = VideoPlayerController.network(
        widget.video)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }
   void dispose() {
    super.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
   var size = MediaQuery.of(context).size;
    var user = Provider.of<UserProvider>(context).user;
     var color = Provider.of<ThemeProvider>(context).theme1model;
          return 
          Scaffold(
            appBar: AppBar(backgroundColor: Colors.black,
              automaticallyImplyLeading: false,
            leading:InkWell(
              child: Icon(
                    Icons.arrow_back,
                    color: Colors.white ,
                    size: 25,
                  ),
              onTap: (){
              Navigator.of(context).pop();
            },),
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
              ],),
            
            
            
            
            
            
            
            
       
            body:
            
             SingleChildScrollView(
               child: Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              
                               SizedBox(height: size.height*0.024,),
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
                                          child: Container(
                                                        height: size.height * 2,
                                                        child:CachedNetworkImage(
                                            imageUrl: 
                                                user
                                                .img!
                                                .toString()
                                                ,
                                            fit: BoxFit.fitWidth,
             
                                            // progressIndicatorBuilder: (context, url, downloadProgress) =>
                                            //         CircularProgressIndicator(value: downloadProgress.progress),
                                            errorWidget: (context, url, error) =>
                                                Icon(Icons.error),
                                          ), ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: size.width * 0.02),
                                    VariableText(
                                      text:
                                          user
                                          .username
                                          .toString()
                                          ,
                                      fontsize: size.height * 0.014,
                                      fontcolor: primaryColorW,
                                      fontFamily: fontMedium,
                                      weight: FontWeight.w400,
                                      textAlign: TextAlign.start,
                                      max_lines: 1,
                                      underlined: true,
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: size.height * 0.02),
                                  child: Column(
                                        children: [
                                          _controller
                                                  .value
                                                  .isInitialized
                                              ? Container(
                                                 height: size.height *0.5,
                                                child: AspectRatio(
                                                    aspectRatio:
                                                        _controller
                                                            .value
                                                            .aspectRatio,
                                                    child: VideoPlayer(
                                                      _controller
                                                    ),
                                                  ),
                                              )
                                              : Container( height: size.height *0.5,),
                                          Center(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  _controller
                                                          .value
                                                          .isPlaying
                                                      ? _controller
                                                          .pause()
                                                      : _controller
                                                          .play();
                                                });
                                              },
                                              child: Icon(
                                                _controller
                                                        .value
                                                        .isPlaying
                                                    ? Icons.pause
                                                    : Icons.play_arrow,
                                              ),
                                            ),
                                          )
                                        ],
                                      )
             
                                  // Image.network(feedsPhoto[index].name!.toString()),
                                  ),
                               isLoading?CircularProgressIndicator():
                                     
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.08),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                            "assets/icons/feed_like.png",
                                            color:
                                            // setlike == true
                                            //     ? Colors.red
                                                 Colors.white,
                                            scale: 1.5),
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
                                          text:isLoading?"":
                                              "0 Me gusta',",
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
                                        VariableText(
                                          text:isLoading?"":"",
                                          // feedsPhotosingle!
                                          //     .caption
                                          //     .toString(),
                                          fontsize: size.height * 0.014,
                                          fontcolor: primaryColorW,
                                          fontFamily: fontRegular,
                                          weight: FontWeight.w400,
                                          textAlign: TextAlign.start,
                                          max_lines: 10,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: size.height * 0.015),
                                    isLoading?CircularProgressIndicator(color:HexColor(color.primaryColor!),):
                                    Row(
                                      children: [
                                        VariableText(
                                          text: 'Ver comentarios',
                                          fontsize: size.height * 0.014,
                                          fontcolor: textColor3,
                                          fontFamily: fontRegular,
                                          weight: FontWeight.w400,
                                          textAlign: TextAlign.start,
                                          max_lines: 10,
                                        ),
                                      ],
                                    ),
                                       SizedBox(height: size.height * 0.015),
                                   
                                    ],
                                    ))]))));}

                                    
}
// class ViewSinglePost extends StatefulWidget {
//   final id;
//   final video;
//   const ViewSinglePost({super.key,required this.id,required this.video});

//   @override
//   State<ViewSinglePost> createState() => _ViewSinglePostState();
// }

// class _ViewSinglePostState extends State<ViewSinglePost> {
//   GetFeeds? feedsPhotosingle;
//   List<Comment> feedcomments = [];
//     bool isLoading = false;
//    setLoading(bool loading) {
//     setState(() {
//       isLoading = loading;
//     });
//   }
//    getfeedsphoto() async {
//     setLoading(true);
//     var res = await ApiModel().getsnglepost(accessToken.toString(),widget.id.toString());


//     GetFeeds? _getFeeds;
//     // print(res);
//     bool setlike = false;

//   islike(bool loading) {
//     setState(() {
//       setlike = loading;
//     });
//   }
//     if (res != null && res['status']) {
   
//         _getFeeds = GetFeeds.fromJson(res['data']);

//         feedsPhotosingle =_getFeeds;
//         // feedsuserimage.add(_getFeeds.user!.img!.toString());
//         // feedsusers.add(_getFeeds.user!.username!.toString());
//         // feedscommentscount.add(_getFeeds.comment![item].comment.toString());
// //  herosNameIdTeams.add(_herosName.id!.toString());

      
//       setLoading(false);
//       // print(feedsPhotosingle.length);
//       // nationalId = leagueModel!.data![1]!.id.toString();
//       setState(() {});
//     }
//   }
//   @override
//   void initState() {
//     // TODO: implement initState
//      getfeedsphoto();
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//    var size = MediaQuery.of(context).size;
//     var user = Provider.of<UserProvider>(context).user;
//      var color = Provider.of<ThemeProvider>(context).theme1model;
//           return 
//           Scaffold(
//             appBar: AppBar(backgroundColor: Colors.black,
//               automaticallyImplyLeading: false,
//             leading:InkWell(
//               child: Icon(
//                     Icons.arrow_back,
//                     color: Colors.white ,
//                     size: 25,
//                   ),
//               onTap: (){
//               Navigator.of(context).pop();
//             },),
//               actions: [
//                 IconButton(
//                   icon: const Icon(
//                     Icons.menu,
//                     color: Colors.white,
//                   ),
//                   onPressed: () {
//                     Navigator.push(context,
//                         SwipeLeftAnimationRoute(widget: ProfileMenuScreen()));
//                   },
//                 ),
//               ],),
            
            
            
            
            
            
            
            
       
//             body:
            
//              SingleChildScrollView(
//                child: Padding(
//                           padding: const EdgeInsets.only(bottom: 30),
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
                              
//                                SizedBox(height: size.height*0.024,),
//                               Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: size.width * 0.08),
//                                 child: Row(
//                                   children: [
//                                     ClipRRect(
//                                       borderRadius: BorderRadius.circular(200),
//                                       child: SizedBox(
//                                         height: size.height * 0.05,
//                                         width: size.width * 0.1,
//                                         child: Container(
//                                           height: size.height * 0.5,
//                                           child: CachedNetworkImage(
//                                             imageUrl: 
//                                                 user
//                                                 .img!
//                                                 .toString()
//                                                 ,
//                                             fit: BoxFit.fitWidth,
             
//                                             // progressIndicatorBuilder: (context, url, downloadProgress) =>
//                                             //         CircularProgressIndicator(value: downloadProgress.progress),
//                                             errorWidget: (context, url, error) =>
//                                                 Icon(Icons.error),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(width: size.width * 0.02),
//                                     Expanded(
//                                       child: VariableText(
//                                         text:
//                                             user
//                                             .username
//                                             .toString()
//                                             ,
//                                         fontsize: size.height * 0.014,
//                                         fontcolor: primaryColorW,
//                                         fontFamily: fontMedium,
//                                         weight: FontWeight.w400,
//                                         textAlign: TextAlign.start,
//                                         max_lines: 1,
//                                         underlined: true,
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                               Padding(
//                                   padding: EdgeInsets.symmetric(
//                                       vertical: size.height * 0.02),
//                                   child: Container(
//                                     height: size.height*0.5,
//                                     child: CachedNetworkImage(
//                                       imageUrl: widget.video.toString(),
//                                       fit: BoxFit.fill,
//                                       // progressIndicatorBuilder: (context, url, downloadProgress) =>
//                                       //         CircularProgressIndicator(value: downloadProgress.progress),
//                                       errorWidget: (context, url, error) =>
//                                           Icon(Icons.error),
//                                     ),
//                                   )
             
//                                   // Image.network(feedsPhoto[index].name!.toString()),
//                                   ),
//                                isLoading?CircularProgressIndicator():
                                     
//                               Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: size.width * 0.08),
//                                 child: Column(
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Image.asset(
//                                             "assets/icons/feed_like.png",
//                                             color:
//                                             // setlike == true
//                                             //     ? Colors.red
//                                                  Colors.white,
//                                             scale: 1.5),
//                                         InkWell(
//                                           onTap: () {},
//                                           child: Padding(
//                                             padding: EdgeInsets.symmetric(
//                                                 horizontal: size.width * 0.04),
//                                             child: Image.asset(
//                                                 "assets/icons/feed_comment.png",
//                                                 scale: 1.5),
//                                           ),
//                                         ),
//                                         Image.asset("assets/icons/feed_share.png",
//                                             scale: 1.5)
//                                       ],
//                                     ),
//                                     SizedBox(height: size.height * 0.015),
//                                     Row(
//                                       children: [
//                                         VariableText(
//                                           text:isLoading?"":
//                                               "'${feedsPhotosingle!.likecount} Me gusta',",
//                                           fontsize: size.height * 0.014,
//                                           fontcolor: primaryColorW,
//                                           fontFamily: fontMedium,
//                                           weight: FontWeight.w500,
//                                           textAlign: TextAlign.start,
//                                           max_lines: 1,
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(height: size.height * 0.015),
//                                     Row(
//                                       children: [
//                                         Expanded(
//                                           child: VariableText(
//                                             text:isLoading?"":
//                                             feedsPhotosingle!
//                                                 .caption
//                                                 .toString(),
//                                             fontsize: size.height * 0.014,
//                                             fontcolor: primaryColorW,
//                                             fontFamily: fontRegular,
//                                             weight: FontWeight.w400,
//                                             textAlign: TextAlign.start,
//                                             max_lines: 10,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(height: size.height * 0.015),
//                                     isLoading?CircularProgressIndicator(color:HexColor(color.primaryColor!),):
//                                     Row(
//                                       children: [
//                                         Expanded(
//                                           child: VariableText(
//                                             text: 'Ver comentarios',
//                                             fontsize: size.height * 0.014,
//                                             fontcolor: textColor3,
//                                             fontFamily: fontRegular,
//                                             weight: FontWeight.w400,
//                                             textAlign: TextAlign.start,
//                                             max_lines: 10,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                        SizedBox(height: size.height * 0.015),
//                                     Container(
//                                       height: size.height * 0.15,
//                                       child: ListView.builder(
//                                           itemCount:
//                                               feedsPhotosingle!.comment!.length,
//                                           shrinkWrap: true,
//                                           physics: ScrollPhysics(),
//                                           itemBuilder: (_, i) {
//                                             return ListTile(
//                                                 leading: ClipRRect(
//                                                   borderRadius:
//                                                       BorderRadius.circular(30),
//                                                   child:ClipRRect(
//                                       borderRadius: BorderRadius.circular(200),
//                                       child: SizedBox(
//                                         height: size.height * 0.04,
//                                         width: size.width * 0.08,
//                                         child: Container(
//                                           height: size.height * 0.5,
//                                           child: CachedNetworkImage(
//                                             imageUrl:isLoading?"": feedsPhotosingle!
//                                                 .comment![i].user!
//                                                 .img!
//                                                 .toString(),
//                                             fit: BoxFit.fitWidth,
             
//                                             // progressIndicatorBuilder: (context, url, downloadProgress) =>
//                                             //         CircularProgressIndicator(value: downloadProgress.progress),
//                                             errorWidget: (context, url, error) =>
//                                                 Icon(Icons.error),
//                                           ),
//                                         ),
//                                       ),
//                                     )
//                                                 ),
//                                                 title: VariableText(
//                                                   text:isLoading?"": feedsPhotosingle!
//                                                       .comment![i]
//                                                       .user!.username
//                                                       .toString(),
//                                                   fontsize: size.height * 0.014,
//                                                   fontcolor: primaryColorW,
//                                                   fontFamily: fontMedium,
//                                                   weight: FontWeight.w400,
//                                                   textAlign: TextAlign.start,
//                                                   max_lines: 1,
//                                                 ),
//                                                 subtitle: VariableText(
//                                                   text: isLoading?"": feedsPhotosingle!
//                                                       .comment![i]
//                                                       .comment
//                                                       .toString(),
//                                                   fontsize: size.height * 0.010,
//                                                   fontcolor: textColorG,
//                                                   fontFamily: fontMedium,
//                                                   weight: FontWeight.w300,
//                                                   textAlign: TextAlign.start,
//                                                   max_lines: 10,
//                                                 ),
//                                                 );
//                                           }),
//                                     ),
//                           //           Container(
//                           //             decoration: BoxDecoration(
//                           //                 color: Color(0xFF252525),
//                           //                 borderRadius:
//                           //                     BorderRadius.circular(200)),
//                           //             child: Row(
//                           //               children: [
//                           //                 SizedBox(width: size.width * 0.02),
//                           //                 Expanded(
//                           //                   child: TextFormField(
//                           //                     controller: _commentController,
//                           //                     style: TextStyle(
//                           //                         color: primaryColorW,
//                           //                         fontSize: size.height * 0.016),
//                           //                     decoration: InputDecoration(
//                           //                       hintText: "Write comment...",
//                           //                       hintStyle: TextStyle(
//                           //                           color: textColor3,
//                           //                           fontSize:
//                           //                               size.height * 0.016),
//                           //                       contentPadding:
//                           //                           EdgeInsets.all(10),
//                           //                       filled: true,
//                           //                       fillColor: Color(0xFF252525),
//                           //                       focusedBorder: OutlineInputBorder(
//                           //                         borderRadius:
//                           //                             BorderRadius.circular(200),
//                           //                         borderSide: BorderSide(
//                           //                             color: Color(0xFF252525),
//                           //                             width: 2.0),
//                           //                       ),
//                           //                       enabledBorder: OutlineInputBorder(
//                           //                         borderRadius:
//                           //                             BorderRadius.circular(200),
//                           //                         borderSide: BorderSide(
//                           //                             color: Color(0xFF252525),
//                           //                             width: 2.0),
//                           //                       ),
//                           //                     ),
//                           //                   ),
//                           //                 ),
//                           //                 Padding(
//                           //                   padding: const EdgeInsets.all(8.0),
//                           //                   child: Row(
//                           //                     mainAxisAlignment:
//                           //                         MainAxisAlignment.spaceEvenly,
//                           //                     children: [
//                           //                       isMessageSending
//                           //                           ? Container(
//                           //                               height: 25,
//                           //                               width: size.width * 0.06,
//                           //                               //color: Colors.yellow,
//                           //                               child:
//                           //                                   CircularProgressIndicator(
//                           //                                       color: Theme.of(
//                           //                                               context)
//                           //                                           .iconTheme
//                           //                                           .color,
//                           //                                       strokeWidth: 3),
//                           //                             )
//                           //                           : InkWell(
//                           //                               onTap: () {
//                           //                                 if (_commentController
//                           //                                     .text.isNotEmpty) {
//                           //                                   sendComment(
//                           //                                       content:
//                           //                                           _commentController
//                           //                                               .text
//                           //                                               .trim(),
//                           //                                       photoId: feedsPhoto[
//                           //                                               index]
//                           //                                           .id
//                           //                                           .toString(),
//                           //                                       id: user.id!
//                           //                                           .toString());
//                           //                                 }
//                           //                               },
//                           //                               child: Image.asset(
//                           //                                 "assets/icons/ic_send.png",
//                           //                                 color: HexColor(color.primaryColor!),
//                           //                                 scale: 2.2,
//                           //                               ),
//                           //                             ),
//                           //                       SizedBox(
//                           //                           width: size.width * 0.02),
             
//                           //                       /*InkWell(
//                           //   onTap: () {},
//                           //   child: Image.asset(
//                           //     "assets/icons/ic_emoji.png",
//                           //     scale: 2.2,
//                           //   ),
//                           // ),*/
//                           //                     ],
//                           //                   ),
//                           //                 ),
//                           //               ],
//                           //             ),
//                           //           ),
//                                   ],
//                                 ),
//                               )
//                             ],
//                           )
//                          // dark: true,
//                          // hasDelete: false,
//                        ),
//              ));
//   }
// }