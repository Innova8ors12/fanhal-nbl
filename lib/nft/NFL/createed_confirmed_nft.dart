import 'package:fan_hall/nft/NFL/see_wallet.dart';
import 'package:fan_hall/nft/NFL/upload_media.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/src/dropdown_button2.dart';
import 'package:provider/provider.dart';

import '../../providers/userProvider.dart';
import '../../screens/dashboard/certificates/certificate_main.dart';
import '../../widgets/style.dart';
import 'nft_mywallet.dart';
import 'nft_preview.dart';

class CreatedConfirmedNft extends StatefulWidget {
   CreatedConfirmedNft(this.nft,{super.key});
  var nft;

  @override
  State<CreatedConfirmedNft> createState() => _CreatedConfirmedNftState();
}

class _CreatedConfirmedNftState extends State<CreatedConfirmedNft> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var user = Provider.of<UserProvider>(context).user;
    return Scaffold(
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
        body: Column(
          children: [
            SizedBox(
              height: 18,
            ),
            Center(
              child: CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.black,
                  child: Image.asset('images/Group 75.png')),
            ),
            SizedBox(
              height: 55,
            ),
            Text(
              'FIELD GOAL!',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffFFB612)),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Your transaction was successful.',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Colors.white),
            ),
            SizedBox(
              height: 45,
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
              height: 45,
              minWidth: 260,
              color: Colors.white,
              onPressed: () {
                Get.to(NFTPreview(widget.nft));
              },
              child: Text(
                'Preview my NFT',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
              height: 45,
              minWidth: 260,
              color: Color(0xffFFB612),
              onPressed: () {

                Get.to(UploadMedia());
              },
              child: Text(
                'Create new NFT',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
              height: 45,
              minWidth: 260,
              color: Colors.white,
              onPressed: () {
                Get.to( SeeMyWallet());
               //  Get.to(SeeMyWallet());
              },
              child: Text(
                'See my Wallet',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
          ],
        ));
  }
}
