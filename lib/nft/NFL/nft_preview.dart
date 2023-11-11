import 'dart:async';

import 'package:fan_hall/nft/NFL/see_wallet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
// import 'package:share_plus/share_plus.dart';

import '../../providers/userProvider.dart';
import '../../widgets/style.dart';
import 'nft_mywallet.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NFTPreview extends StatefulWidget {
   NFTPreview(this.ipfsImage,{super.key});
  var ipfsImage;

  @override
  State<NFTPreview> createState() => _NFTPreviewState();
}

class _NFTPreviewState extends State<NFTPreview> {
  bool isLoading = true;
  var baseUrlImage= "https://api.tatum.io/v3/ipfs/";
  var imageUrl;

  previewImages(){

    imageUrl = baseUrlImage+widget.ipfsImage;
    setState(() {
      imageUrl;
    });
    print("image url ==${imageUrl}");

    setState(() {
      isLoading = false;
    });


  }
  // previewNft()async{
  //   var headers = {
  //     'Accept': '*',
  //     'x-api-key': '32eb0e9e-4392-4dcb-86be-61fd46a3423f'
  //   };
  //   var request = http.Request('GET', Uri.parse('https://api.tatum.io/v3/ipfs/bafkreiaok65eihtdzyoqbthonzphyauyixcpjyyiuqyryrhke3s2czlwwi'));
  //
  //   request.headers.addAll(headers);
  //
  //   http.StreamedResponse response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //     print(await response.stream.bytesToString());
  //   }
  //   else {
  //   print(response.reasonPhrase);
  //   }
  //
  // }
  @override
  void initState() {
    previewImages();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var user = Provider.of<UserProvider>(context).user;
    return isLoading?Center(child: CircularProgressIndicator()):
      Scaffold(
          backgroundColor: backgroundColor1,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
            backgroundColor: backgroundColor1,
          leading: Visibility(
            visible: true,
            child: IconButton(
              icon: Icon(Icons.arrow_back, size: 20, color: Colors.white),
              onPressed: () {
              //  previewNft();
                Navigator.pop(context);
              },
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
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
          // bottom: TabBar(
          //   controller: bookingTabController,
          //   labelStyle: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
          //   indicatorColor: Colors.white,
          //   tabs: [
          //     Tab(text: "Certificates"),
          //     Tab(text: "NFTs"),
          //   ],
          // ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 18,
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30),
                  child: Image.network(
                    imageUrl.toString(),
                   // 'images/nft.png',
                    width: double.infinity,
                   // height: 500,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Spacer(),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                      height: 45,
                      minWidth: 200,
                      color: Color(0xffFFB612),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SeeMyWallet()));
                     //   Get.to(SeeMyWallet());
                      },
                      child: Text(
                        'Go to my Wallet',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: (){
                        shareData(widget.ipfsImage);
                      },
                      child: CircleAvatar(
                        backgroundColor: Color(0xffFFB612),
                        child: Icon(
                          Icons.share_outlined,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ));
  }
  shareData(String data) {
    // Share.share(data);
  }
}
