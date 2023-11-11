import 'package:fan_hall/nft/NFL/sql/sql_helper.dart';
import 'package:fan_hall/nft/NFL/upload_media.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
// import 'package:share_plus/share_plus.dart';
import '../../providers/userProvider.dart';
import 'package:fan_hall/widgets/style.dart';
import '../../../widgets/common.dart';
import '../../screens/dashboard/certificates/certificates_screen.dart';
import 'nft_preview.dart';

class SeeMyWallet extends StatefulWidget {
  SeeMyWallet({Key? key}) : super(key: key);

  @override
  State<SeeMyWallet> createState() => _SeeMyWalletState();
}

class _SeeMyWalletState extends State<SeeMyWallet>
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
  // This function is used to fetch all data from the database
  void _refreshJournals() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _journals = data;
      _isLoading = false;
    });


  }
  void _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    Fluttertoast.showToast(
        msg: "Successfully deleted Nft!"
    );
    _refreshJournals();
    Navigator.pop(context);

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshJournals();
    tabController = TabController(length: 2, vsync: this, initialIndex: 1, );
    tabViewController = TabController(length: 2, vsync: this, initialIndex: 1);
    _scrollController = ScrollController();
  }
  var baseUrlImage= "https://api.tatum.io/v3/ipfs/";


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
                                color: Color(0xFF555555), width: 3.0),
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
          _isLoading
              ? const Center(
            child: CircularProgressIndicator(),
          ):
          Column(
            children: [
              Expanded(

                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount:_journals.length,
                    itemBuilder: (context,index){
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              // color: Colors.green,
                              height: 110,width: 85,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),

                                image: DecorationImage(
                                  image: NetworkImage(baseUrlImage+_journals[index]['ipfsHash'],),
                                  fit: BoxFit.cover,

                                ),

                              ),

                            ),
                            SizedBox(width: 10,),

                            GestureDetector(
                              onTap: (){
                                Get.to(NFTPreview(_journals[index]['ipfsHash'],));
                              },
                              child: Container(
                                height: 45,width: 140,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30,),
                                  color: Color(0xFFFFB612),
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.remove_red_eye, color: Colors.black,),
                                      SizedBox(width: 5,),
                                      Text("Preview", style: TextStyle(color: Colors.black),),
                                    ],),
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            GestureDetector(
                                onTap: (){
                                  showDialog(
                                      context: context,
                                      builder: (_) {
                                        return AlertDialog(
                                          title: Text("Delete", style: TextStyle(fontSize: 16),),
                                          content: Text("Are you sure to Delete this Nft?"),
                                          actions: [
                                            TextButton(
                                              onPressed: ()async {
                                                _deleteItem(_journals[index]['id']);
                                              },
                                              child: Text("Delete"),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("Cancel"),
                                            ),
                                          ],
                                        );
                                      });

                                },
                                child: Icon(Icons.delete, color: Colors.black)),
                            SizedBox(width: 10,),
                            GestureDetector(
                                onTap: (){
                                  shareData(_journals[index]['ipfsHash'],);
                                },
                                child: Icon(Icons.share, color: Colors.black)),
                            SizedBox(width: 10,),
                            Expanded(child: Icon(Icons.send, color: Colors.black)),
                            SizedBox(width: 10,),


                          ],
                        ),
                      );
                    }),
              ),
              SizedBox(height: 5,),
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
             // SizedBox(height: 5,)
              SizedBox(height: 5,),
            ],
          ),




        ],
      ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        // floatingActionButton: new FloatingActionButton.extended(
        //
        //     elevation: 0.0,
        //     backgroundColor: Color(0xffFFB612),
        //     label: Text('      Create new NFT       '),
        //     onPressed: (){
        //       Get.to(UploadMedia());
        //     }
        //
        // )

    //   FloatingActionButton.extended(
    //   backgroundColor: Colors.green,
    //   foregroundColor: Colors.black,
    //   onPressed: () {
    //     // Respond to button press
    //   },
    //   icon: Icon(Icons.add),
    //   label: Text('Floating Action Button'),
    // )
    );

  }

  shareData(String data) {
    // Share.share(data);

  }

}








