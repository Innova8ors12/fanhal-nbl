import 'dart:convert';
import 'dart:io';

import 'package:fan_hall/nft/NFL/adress_created.dart';
import 'package:fan_hall/nft/NFL/upload_media.dart';
import 'package:fan_hall/nft/NFL/upload_media1.dart';
import 'package:fan_hall/widgets/common.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/src/dropdown_button2.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../widgets/style.dart';

class CreateWallet extends StatefulWidget {
  const CreateWallet({super.key});

  @override
  State<CreateWallet> createState() => _CreateWalletState();
}

class _CreateWalletState extends State<CreateWallet>
    with SingleTickerProviderStateMixin {
  late TabController bookingTabController =
      TabController(length: 3, vsync: this, initialIndex: 0);

  String? selectedValue;
  String? selectedValue1;
  bool createaddresss = false;
  bool upladmedia = false;
  bool isuploaded = false;
  PickedFile? imageFile;
  @override
  void dispose() {
    super.dispose();
    bookingTabController.dispose();
  }

  var wallet;
  var isLoading = false;
  createWallet() async {
    setState(() {
      isLoading = true;
    });
    var headers = {
      'x-api-key': '32eb0e9e-4392-4dcb-86be-61fd46a3423f',
      'Accept': 'application/json',
    };
    var request = http.Request(
        'GET', Uri.parse('https://api.tatum.io/v3/ethereum/wallet'));
    // request.files.add(await http.MultipartFile.fromPath('file', imageFile!.path));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      //  print(await response.stream.bytesToString());
      var res = await response.stream.bytesToString();
      var body = jsonDecode(res);

      var message = body['xpub'];
      print('ada=$message');
      wallet = message;
      setState(() {
        wallet;
      });
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: "NFT Wallet Successfully created\n$wallet ");

      setState(() {
        createaddresss = true;
      });
    } else {
      print(response.reasonPhrase);
      print('object');
      setState(() {
        isLoading = false;
      });
      setState(() {
        createaddresss = false;
      });
    }
  }

  var waladdress;

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
        Uri.parse('https://api.tatum.io/v3/ethereum/address/${wallet}/0'));

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

      Fluttertoast.showToast(
          msg: "NFT Wallet address Successfully created\n$waladdress");
      setState(() {
        upladmedia = true;
      });
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
    return Scaffold(
      backgroundColor: backgroundColor1,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SafeArea(
            child: isuploaded
                ? Center(child: UploadMedia1(imageFile!.path))
                : upladmedia
                    ? Column(
                        children: [
                          SizedBox(
                            height: 75,
                          ),
                          Text(
                            'You are all set up!',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          Text(
                            'Now let\'s get your first NFT.',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.normal),
                          ),
                          SizedBox(
                            height: 55,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 70, right: 70),
                            child: InkWell(
                              onTap: () {
                                showBottomSheet();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Choose media',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.amber,
                                        decoration: TextDecoration.underline),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.arrow_downward_rounded,
                                    color: Colors.amber,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : createaddresss
                        ? Column(
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
                              isLoading
                                  ? Center(child: CircularProgressIndicator())
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          left: 70, right: 70),
                                      child: MaterialButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(22),
                                        ),
                                        height: 45,
                                        color: Colors.amber,
                                        onPressed: () {
                                          walletAddress();
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.wallet,
                                              color: Colors.black,
                                            ),
                                            SizedBox(
                                              width: 12,
                                            ),
                                            Text(
                                              'Create my Adress',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                              Expanded(child: Container()),
                            ],
                          )
                        : Column(
                            children: [
                              SizedBox(
                                height: 75,
                              ),
                              Text(
                                'Take your passion to the next level!',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 35,
                              ),
                              Text(
                                'Get your first NFT from a certificate, image',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'or video, but first create your wallet and',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'address',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 55,
                              ),
                              isLoading
                                  ? Center(child: CircularProgressIndicator())
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          left: 70, right: 70),
                                      child: MaterialButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(22),
                                        ),
                                        height: 45,
                                        color: Colors.amber,
                                        onPressed: () {
                                          createWallet();
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.wallet,
                                                color: Colors.black),
                                            SizedBox(
                                              width: 12,
                                            ),
                                            Text(
                                              'Create my Wallet',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                            ],
                          )),
      ),
    );
  }

  void showBottomSheet() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.grey.shade900,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18), topRight: Radius.circular(18))),
        builder: (context) {
          return Column(
            children: [
              SizedBox(
                height: 25,
              ),
              Text(
                'Choose media',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(
                height: 25,
              ),
              ListTile(
                onTap: () {
                  //  Get.to(UploadMedia1());
                },
                leading: Icon(
                  Icons.gif_box_outlined,
                  color: Colors.white,
                ),
                title: Text(
                  'Certificate',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
              ListTile(
                onTap: () {
                  takePhoto(
                    ImageSource.camera,
                  );
                  Navigator.pop(context);
                },
                leading: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                ),
                title: Text(
                  'Camera Roll',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
              ListTile(
                onTap: () {
                  takePhoto(
                    ImageSource.gallery,
                  );
                  Navigator.pop(context);
                },
                leading: Icon(
                  Icons.camera,
                  color: Colors.white,
                ),
                title: Text(
                  'Chose from Gallery',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
              ListTile(
                onTap: () {
                  // takePhoto(
                  //   ImageSource.gallery,
                  // );
                  Navigator.pop(context);
                },
                leading: Icon(
                  Icons.video_call_outlined,
                  color: Colors.white,
                ),
                title: Text(
                  'Vlips',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ],
          );
        });
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await ImagePicker().getImage(
      source: source,
    );
    if (pickedFile != null) {
      imageFile = pickedFile;
      setState(() {
        isuploaded = true;
      });
      // Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadMedia1(imageFile!.path)));
    }
  }
}
