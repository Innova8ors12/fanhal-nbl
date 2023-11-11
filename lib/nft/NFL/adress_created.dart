import 'package:fan_hall/nft/NFL/upload_media.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../providers/userProvider.dart';
import 'package:fan_hall/widgets/style.dart';
import '../../../widgets/common.dart';
import '../../screens/dashboard/certificates/certificates_screen.dart';

class AdreesCreated extends StatefulWidget {
  AdreesCreated(this.wallet,{Key? key}) : super(key: key);
  var wallet;
  @override
  State<AdreesCreated> createState() => _AdreesCreatedState();
}

class _AdreesCreatedState extends State<AdreesCreated>
    with TickerProviderStateMixin {
  ScrollController? _scrollController;
  TabController? tabViewController;
  TabController? tabController;

  TabBar get _tabBar => TabBar(
    controller: tabController,
    indicatorColor: Color(0xFFFFB612),
    labelColor: textColorW,
    indicatorWeight: 3.0,
    isScrollable: false,
    labelPadding: const EdgeInsets.symmetric(horizontal: 0),
    indicatorSize: TabBarIndicatorSize.label,
    onTap: (int i) {
      onTabPressed(i);
    },
    tabs: [
      Tab(
          icon: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const VariableText(
                text: "Certificates",
                fontsize: 12,
                fontcolor: textColorW,
                fontFamily: fontMedium,
                max_lines: 1,
              ),
            ],
          )),
      Tab(
          icon: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const VariableText(
                text: "NFT’s",
                fontsize: 12,
                fontcolor: textColorW,
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this, initialIndex: 1);
    tabViewController = TabController(length: 2, vsync: this,initialIndex: 1);
    _scrollController = ScrollController();
  }
  var waladdress;
  bool  isLoading = false;

  walletAddress() async {
    setState(() {
      isLoading = true;
    });
    var headers = {
      'x-api-key': '32eb0e9e-4392-4dcb-86be-61fd46a3423f',
      'Accept': 'application/json',
      'x-testnet-type': 'ethereum-sepolia',
    };

    var request = http.Request('GET',
        Uri.parse('https://api.tatum.io/v3/ethereum/address/${widget.wallet}/0'));

    request.headers.addAll(headers);
    // request.headers.addAll(pharms);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      //  print(await response.stream.bytesToString());
      var res = await response.stream.bytesToString();
      var body = jsonDecode(res);

      var message = body['address'];
      print('Address=$message');
      waladdress = message;
      setState(() {
        waladdress;
      });
      setState(() {
        isLoading = false;
      });

      Fluttertoast.showToast(msg: "NFT Wallet address Successfully created\n$waladdress");
      Get.to(UploadMedia());
    } else {
      print(response.reasonPhrase);
      print('error');
      setState(() {
        isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      backgroundColor: backgroundColor1,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * horizontalPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap:(){
                      Navigator.pop(context);
                    },
                      child: Icon(Icons.arrow_back, color: Colors.white,)),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: Image.network(
                      user.img!,
                      scale: 2,
                      fit: BoxFit.fill,
                      height: size.height * 0.05,
                      width: size.width * 0.10,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.015),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(width: size.width * 0.05),
                Flexible(
                  child: Stack(
                    fit: StackFit.passthrough,
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                  color: Color(0xFF555555),

                                width: 3.0),
                          ),
                        ),
                      ),
                      _tabBar,
                    ],
                  ),
                ),
                SizedBox(width: size.width * 0.05),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * horizontalPadding),
                  child: Row(
                    children: [
                      Image.asset("assets/icons/ic_certificate_slider_view.png",
                          scale: 2),
                      SizedBox(width: size.width * 0.06),
                      Image.asset("assets/icons/ic_certificate_grid_view.png",
                          scale: 2)
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabViewController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          CertificatesScreen(isshow: true,),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SafeArea(
                child: Column(
                  children: [

                    SizedBox(
                      height: 75,
                    ),
                    Text(
                      'Wallet created successfully!',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Text(
                      'Not set up your address.',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    isLoading ? Center(child: CircularProgressIndicator()):
                    Padding(
                      padding: const EdgeInsets.only(left: 70, right: 70),
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                        height: 45,
                        color: Colors.amber,
                        onPressed: () {
                          walletAddress();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.wallet, color: Colors.black,),
                            SizedBox(
                              width: 12,
                            ),
                            Text(
                              'Create my Adress',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(child: Container()),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}








