

import 'dart:io';

import 'package:fan_hall/nft/NFL/sql/sql_helper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/src/dropdown_button2.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../providers/userProvider.dart';
import 'createed_confirmed_nft.dart';

import 'package:fan_hall/nft/NFL/upload_media1.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../providers/userProvider.dart';
import 'package:fan_hall/widgets/style.dart';
import '../../../widgets/common.dart';
import '../../screens/dashboard/certificates/certificates_screen.dart';

class UploadMedia1 extends StatefulWidget {
  UploadMedia1(this.Image,{Key? key}) : super(key: key);
  String Image;

  @override
  State<UploadMedia1> createState() => _UploadMedia1State();
}

class _UploadMedia1State extends State<UploadMedia1>
    with TickerProviderStateMixin {
  ScrollController? _scrollController;
  TabController?  tabViewController;
  TabController? tabController;


  TabBar get _tabBar => TabBar(
    controller: tabController,


    indicatorColor: Color(0xFFFFB612),
    labelColor: textColorW,
    indicatorWeight: 3.0,

    isScrollable: false,
    labelPadding: const EdgeInsets.symmetric(horizontal: 0),
    indicatorSize: TabBarIndicatorSize.label,
    onTap: (int i ) {
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
      print("i ==${i}");
    });
  }
  List<Map<String, dynamic>> _journals = [];
  bool _isLoading = true;
  void _refreshJournals() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _journals = data;
      _isLoading = false;
      Get.to(CreatedConfirmedNft(imageNft));
    });

  }
  Future<void> _addItem() async {
    await SQLHelper.createItem(
      imageNft.toString(),
    );

    Fluttertoast.showToast(
        msg: "Successfully Save  Nft!"
    );
    _refreshJournals();

  }
  bool isLoading = false;
  var imageNft;
  imageToNft() async{

    setState(() {
      isLoading = true;
    });
    var headers = {
      'Content-Type': 'multipart/form-data',



      'Accept': 'application/json',
      'x-api-key': '32eb0e9e-4392-4dcb-86be-61fd46a3423f'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://api.tatum.io/v3/ipfs'));
    request.files.add(await http.MultipartFile.fromPath('file', widget.Image));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      //  print(await response.stream.bytesToString());
      var res = await response.stream.bytesToString();
      var body = jsonDecode(res);
      imageNft = body['ipfsHash'];
      Fluttertoast.showToast(
          msg: "NFT Successfully created "
      );
      setState(() {
        isLoading = false;
      });
      _addItem();

    }
    else if(response.statusCode == 400){
      var res = await response.stream.bytesToString();
      var body = jsonDecode(res);
      var message = body['data'];
      Fluttertoast.showToast(
          msg: message.toString()
      );
      setState(() {
        isLoading = false;
      });



    }
    else {
      print(response.reasonPhrase);
      setState(() {
        isLoading = false;
      });
    }

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this, initialIndex: 1, );
    tabViewController = TabController(length: 2, vsync: this, initialIndex: 1);
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      backgroundColor: backgroundColor1,
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(size.height * 0.15),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Padding(
      //         padding: EdgeInsets.symmetric(
      //             horizontal: size.width * horizontalPadding),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             GestureDetector(
      //                 onTap:(){
      //                   Navigator.pop(context);
      //                 },
      //                 child: Icon(Icons.arrow_back, color: Colors.white,)),
      //             ClipRRect(
      //               borderRadius: BorderRadius.circular(200),
      //               child: Image.network(
      //                 user.img!,
      //                 scale: 2,
      //                 fit: BoxFit.fill,
      //                 height: size.height * 0.05,
      //                 width: size.width * 0.10,
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //       SizedBox(height: size.height * 0.015),
      //       Row(
      //         mainAxisSize: MainAxisSize.max,
      //         children: [
      //           SizedBox(width: size.width * 0.05),
      //           Flexible(
      //             child: Stack(
      //               fit: StackFit.passthrough,
      //               alignment: Alignment.bottomCenter,
      //               children: [
      //                 Container(
      //                   decoration: BoxDecoration(
      //                     border: Border(
      //                       bottom: BorderSide(
      //                           color: Color(0xFF555555), width: 3.0),
      //                     ),
      //                   ),
      //                 ),
      //                 _tabBar,
      //               ],
      //             ),
      //           ),
      //           SizedBox(width: size.width * 0.05),
      //           Padding(
      //             padding: EdgeInsets.symmetric(
      //                 horizontal: size.width * horizontalPadding),
      //             child: Row(
      //               children: [
      //                 Image.asset("assets/icons/ic_certificate_slider_view.png",
      //                     scale: 2),
      //                 SizedBox(width: size.width * 0.06),
      //                 Image.asset("assets/icons/ic_certificate_grid_view.png",
      //                     scale: 2)
      //               ],
      //             ),
      //           )
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
      body: 
          Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
          
                     
                      Text(
                        'Media successfully converted!',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: size.height*0.01,
                      ),
                      Text(
                        'Time to make that field goal.',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),
                      SizedBox(
                        height: 30,
                      ),
          
                      Padding(
                        padding: const EdgeInsets.only(left: 5,right: 5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.file(File(widget.Image),
                            width: 300,
                            //height: 290,
                            //fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      isLoading ? Center(child: CircularProgressIndicator()):
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                        height: 45,
                        color: Colors.amber,
                        minWidth: 200,
                        onPressed: () {
                          imageToNft();
                        },
                        child: Text(
                          'Create NFT',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  )),
            ),
          ),

    );
  }

}











































