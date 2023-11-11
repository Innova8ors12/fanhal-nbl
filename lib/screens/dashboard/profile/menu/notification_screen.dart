import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';

import '../../../../widgets/common.dart';
import '../../../../widgets/style.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backgroundColor1,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: size.height * 0.02),
              ///appbar
              MenuAppbar(),
              SizedBox(height: size.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  VariableText(
                    text: "Notifications",
                    fontcolor: primaryColorW,
                    fontsize: size.height * 0.026,
                    fontFamily: fontSemiBold,
                    max_lines: 1,
                    textAlign: TextAlign.center
                  )
                ],
              ),
              SizedBox(height: size.height * 0.03),
              ///Today
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       VariableText(
              //           text: "Today",
              //           fontcolor: primaryColorW,
              //           fontsize: size.height * 0.018,
              //           fontFamily: fontMedium,
              //           max_lines: 1
              //       )
              //     ],
              //   ),
              // ),
              // SizedBox(height: size.height * 0.02),
              // ListView(
              //   shrinkWrap: true,
              //   physics: NeverScrollableScrollPhysics(),
              //   children: [
              //     SwipeActionCell(
              //         key: ObjectKey("AA"),
              //         trailingActions: <SwipeAction>[
              //           SwipeAction(
              //               title: "Delete",
              //               onTap: (CompletionHandler handler) async {
              //                 await handler(true);
              //                 setState(() {});
              //               },
              //               color: Color(0xFFC60C30)),
              //         ],
              //         child: renderNotificationDetails("Your order will be delivered today.", true)
              //     ),
              //     SizedBox(height: size.height * 0.01),
              //     SwipeActionCell(
              //         key: ObjectKey("BB"),
              //         trailingActions: <SwipeAction>[
              //           SwipeAction(
              //               title: "Delete",
              //               onTap: (CompletionHandler handler) async {
              //                 await handler(true);
              //                 setState(() {});
              //               },
              //               color: Color(0xFFC60C30)),
              //         ],
              //         child: renderNotificationDetails("Your order has been shipped.", false)
              //     )
              //   ],
              // ),
              // SizedBox(height: size.height * 0.03),
              ///Yesterday
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    VariableText(
                        text: "Yesterday",
                        fontcolor: primaryColorW,
                        fontsize: size.height * 0.018,
                        fontFamily: fontMedium,
                        max_lines: 1
                    )
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.02),
              ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  SwipeActionCell(
                      key: ObjectKey("CC"),
                      trailingActions: <SwipeAction>[
                        SwipeAction(
                            title: "Delete",
                            onTap: (CompletionHandler handler) async {
                              await handler(true);
                              setState(() {});
                            },
                            color: Color(0xFFC60C30)),
                      ],
                      child: renderNotificationDetails("Your order will be delivered today.", true)
                  ),
                  SizedBox(height: size.height * 0.01),
                  SwipeActionCell(
                      key: ObjectKey("DD"),
                      trailingActions: <SwipeAction>[
                        SwipeAction(
                            title: "Delete",
                            onTap: (CompletionHandler handler) async {
                              await handler(true);
                              setState(() {});
                            },
                            color: Color(0xFFC60C30)),
                      ],
                      child: renderNotificationDetails("Your order has been shipped.", false)
                  )
                ],
              ),
              SizedBox(height: size.height * 0.03),
              ///Week
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    VariableText(
                        text: "This Week",
                        fontcolor: primaryColorW,
                        fontsize: size.height * 0.018,
                        fontFamily: fontMedium,
                        max_lines: 1
                    )
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.02),
              ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  SwipeActionCell(
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
                      child: renderNotificationDetails("Your certificate has been validated by the Steelers.", false)
                  ),
                  SizedBox(height: size.height * 0.01),
                  SwipeActionCell(
                      key: ObjectKey("FF"),
                      trailingActions: <SwipeAction>[
                        SwipeAction(
                            title: "Delete",
                            onTap: (CompletionHandler handler) async {
                              await handler(true);
                              setState(() {});
                            },
                            color: Color(0xFFC60C30)),
                      ],
                      child: renderNotificationDetails("Your certificate has been validated by the NFL.", true)
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  renderNotificationDetails(String title, bool isRead){
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.08,
      color: Colors.black,
      child: Row(
        children: [
          Expanded(
            flex: 10,
            child: Image.asset("assets/icons/ic_notification_unread.png", scale: 2, color: isRead ? Color(0xFF23BD2A) : Color(0xFF323232)),
          ),
          Expanded(
            flex: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: VariableText(
                      text: title,
                      fontcolor: primaryColorW,
                      fontsize: size.height * 0.014,
                      fontFamily: fontRegular,
                      max_lines: 3
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
