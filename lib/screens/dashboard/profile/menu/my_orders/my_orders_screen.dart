import 'package:fan_hall/controller/auth/league_api.dart';
import 'package:fan_hall/models/orderlist.dart';
import 'package:fan_hall/screens/dashboard/certificates/buy_certificate/1_pick_category.dart';
import 'package:flutter/material.dart';

import '../../../../../widgets/common.dart';
import '../../../../../widgets/style.dart';
import 'order_status_screen.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({Key? key}) : super(key: key);

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
   bool isLoading = false;
  setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    }); 
  }
   List<Orderlist> certorder= [];
   getteamcertificateOrder() async {
    setLoading(true);
    var res = await ApiModel().getCertiorder();

    Orderlist? _orderlist;
    // print(res);
    certorder.clear();
    if (res != null && res['status']) {
      for (var item in res['data']) {
        _orderlist = Orderlist.fromJson(item);

        certorder.add(_orderlist);
//  herosNameIdTeams.add(_herosName.id!.toString());

      }
      setLoading(false);
      print(nationalities1);
      // nationalId = leagueModel!.data![1]!.id.toString();
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getteamcertificateOrder();
    super.initState();
  }
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
                      text: "Orders",
                      fontcolor: primaryColorW,
                      fontsize: size.height * 0.018,
                      fontFamily: fontSemiBold,
                      max_lines: 1,
                      textAlign: TextAlign.center
                  )
                ],
              ),
              SizedBox(height: size.height * 0.03),
           certorder.isEmpty?Center(child: Container(
            child:VariableText(text: "No Orders To See",

            fontcolor: textColorW,) ,
           )):   ListView.builder(
                itemCount: certorder.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (_, index){
                  return Padding(
                    padding: EdgeInsets.only(bottom: size.height * 0.02),
                    child: renderOrder(certorder[index]),
                  );
                },
              ),
              //renderOrder()
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * horizontalPadding, vertical: size.height * 0.01),
        child: MyButton(
          btnHeight: size.height * 0.055,
          btnColor: Theme.of(context).primaryColor,
          borderColor: Theme.of(context).primaryColor,
          btnRadius: 200,
          btnTxt: "Shop More",
          fontSize: size.height * 0.018,
          fontFamily: fontMedium,
          weight: FontWeight.w500,
          txtColor: textColor1,
          onTap: (){
              Navigator.push(
                                context,
                                SwipeLeftAnimationRoute(widget: PickCertificateCategory()));
          },
        ),
      ),
    );
  }

  renderOrder(Orderlist orderdata){
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.13,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * horizontalPadding),
        child: Row(
          children: [
            Expanded(
              flex: 25,
              child: 
              Image.network(orderdata.img!.toString(), height: size.height * 0.13, fit: BoxFit.fitHeight),
            ),
            Expanded(
              flex: 35,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: VariableText(
                            text: orderdata.user!.username.toString().toUpperCase(),
                            fontcolor: primaryColorW,
                            fontsize: size.height * 0.018,
                            fontFamily: fontMedium,
                            max_lines: 1,
                            textAlign: TextAlign.start,
                            line_spacing: 1.3,
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: VariableText(
                            text: "${orderdata.certificate!.team!.nickName} Forever Fan",
                            fontcolor: primaryColorW,
                            fontsize: size.height * 0.014,
                            fontFamily: fontRegular,
                            max_lines: 1,
                            textAlign: TextAlign.start,
                            line_spacing: 1.3,
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: VariableText(
                            text: orderdata.createdAt,
                            fontcolor: primaryColorW,
                            fontsize: size.height * 0.014,
                            fontFamily: fontRegular,
                            max_lines: 1,
                            textAlign: TextAlign.start,
                            line_spacing: 1.3,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: size.height * 0.01),
                  Row(
                    children: [
                      MyButton(
                        btnHeight: size.height * 0.036,
                        btnWidth: size.width * 0.27,
                        btnColor: primaryColorW,
                        borderColor: primaryColorW,
                        btnRadius: 200,
                        btnTxt: "View Status",
                        fontSize: size.height * 0.014,
                        fontFamily: fontMedium,
                        weight: FontWeight.w500,
                        txtColor: textColor1,
                        onTap: (){
                          Navigator.push(
                              context,
                              SwipeLeftAnimationRoute(widget: OrderStatusScreen(status: orderdata.status!,)));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 15,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  PopupMenuButton(
                    icon: Icon(Icons.more_vert_sharp, color: primaryColorW),
                    color: textColorW,
                    padding: EdgeInsets.all(0),
                    elevation: 5,
                    offset: Offset(-20.0, size.height * 0.065),
                    onSelected: (v){
                      switch(v){
                        case 1:{

                        }
                        return;
                        case 2:{

                        }
                        return;
                        case 3:{

                        }
                        return;
                      }
                    },
                    itemBuilder: (iContext) => [
                      PopupMenuItem(
                        value: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            VariableText(
                              text: "Archive",
                              fontFamily: fontMedium,
                              fontcolor: textColor1,
                              fontsize: size.height * 0.014,
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            VariableText(
                              text: "Help",
                              fontFamily: fontMedium,
                              fontcolor: textColor1,
                              fontsize: size.height * 0.014,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
