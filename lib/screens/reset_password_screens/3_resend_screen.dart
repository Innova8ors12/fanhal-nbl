// import 'package:fan_hall/controller/auth/user_authentications.dart';
// import 'package:fan_hall/screens/reset_password_screens/otp_screen.dart';
// import 'package:fan_hall/screens/reset_password_screens/update_password.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:video_player/video_player.dart';

// import '../../widgets/common.dart';
// import '../../widgets/style.dart';

// class ResendScreen extends StatefulWidget {
//   String email;
//   ResendScreen({Key? key, required this.email}) : super(key: key);

//   @override
//   State<ResendScreen> createState() => _ResendScreenState();
// }

// class _ResendScreenState extends State<ResendScreen> {
//   late VideoPlayerController _controller;
//   final hPadding = 0.17;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _controller = VideoPlayerController.asset('assets/videos/login1.mp4')
//       ..initialize().then((_) {
//         _controller.setLooping(true);
//         _controller.setVolume(0.0);
//         _controller.play();
//         setState(() {});
//       });
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     _controller.dispose();
//   }

//   forgotPassword() async {
//     setLoading(true);
//     if (validate()) {
//       var response = await AuthenticationService().forgotPassword(widget.email);
//       if (response is Map) {
//         if (response['status']) {
//           String otp = response['otp'].toString();

//           setLoading(false);
//           Navigator.push(
//               context,
//               SwipeLeftAnimationRoute(
//                   milliseconds: 200,
//                   widget: OtpScreen(
//                     email: widget.email,
//                     otp: otp,
//                   ))).then((value) => playVideo());
//         } else {
//           setLoading(false);
//           Fluttertoast.showToast(
//               msg: response['msg'].toString(), toastLength: Toast.LENGTH_SHORT);
//         }
//       } else {
//         setLoading(false);
//         Fluttertoast.showToast(
//             msg: response.toString(), toastLength: Toast.LENGTH_SHORT);
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;

//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: [
//           if (_controller.value.isInitialized) VideoPlayer(_controller),
//           Positioned.fill(
//             child: Container(
//               color: const Color(0xFF000000).withOpacity(0.6),
//             ),
//           ),
//           /*Positioned.fill(
//             child: Image.asset("assets/images/welcome_background.png", fit: BoxFit.cover),
//           ),
//           Positioned.fill(
//             child: Container(
//               color: const Color(0xFF000000).withOpacity(0.8),
//             ),
//           ),*/
//           Positioned.fill(
//             child: SafeArea(
//               child: Padding(
//                 padding:
//                     EdgeInsets.symmetric(horizontal: size.width * hPadding),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     SizedBox(height: size.height * 0.20),
//                     Image.asset("assets/icons/ic_logo.png", scale: 2.8),
//                     SizedBox(height: size.height * 0.04),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Expanded(
//                           child: VariableText(
//                             text: "Second time is a charm!",
//                             fontsize: size.height * 0.026,
//                             fontcolor: textColorW,
//                             fontFamily: fontBold,
//                             weight: FontWeight.w700,
//                             textAlign: TextAlign.center,
//                             line_spacing: 1.5,
//                             max_lines: 3,
//                           ),
//                         )
//                       ],
//                     ),
//                     SizedBox(height: size.height * 0.04),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Expanded(
//                           child: VariableText(
//                             text:
//                                 'Check your mail inbox or spam and find the link to reset your password.',
//                             fontsize: size.height * 0.018,
//                             fontcolor: textColorW,
//                             fontFamily: fontMedium,
//                             weight: FontWeight.w400,
//                             textAlign: TextAlign.center,
//                             line_spacing: 1.5,
//                             max_lines: 4,
//                           ),
//                         )
//                       ],
//                     ),
//                     SizedBox(height: size.height * 0.04),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                           child: MyButton(
//                             btnHeight: size.height * 0.055,
//                             btnColor: primaryColorW,
//                             borderColor: primaryColorW,
//                             btnRadius: 200,
//                             btnTxt: "Resend OTP",
//                             fontSize: size.height * 0.018,
//                             fontFamily: fontSemiBold,
//                             weight: FontWeight.w500,
//                             txtColor: textColor1,
//                             onTap: () {
//                               forgotPassword();
//                               // Navigator.push(
//                               //     context,
//                               //     SwipeLeftAnimationRoute(widge()));
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: size.height * 0.04),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Expanded(
//                           child: VariableText(
//                             text: "Didn’t receive an email?",
//                             fontsize: size.height * 0.018,
//                             fontcolor: textColorW,
//                             fontFamily: fontMedium,
//                             weight: FontWeight.w400,
//                             textAlign: TextAlign.center,
//                             line_spacing: 0,
//                             max_lines: 1,
//                           ),
//                         )
//                       ],
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         /*Navigator.push(
//                             context,
//                             SwipeLeftAnimationRoute(widget: ForgotPassScreen()));*/
//                       },
//                       child: VariableText(
//                         text: "Ask for help",
//                         fontsize: size.height * 0.018,
//                         fontcolor: textColorW,
//                         fontFamily: fontRegular,
//                         weight: FontWeight.w400,
//                         textAlign: TextAlign.center,
//                         underlined: true,
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           SafeArea(
//             child: Align(
//               alignment: Alignment.topLeft,
//               child: MyBackButton(),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
