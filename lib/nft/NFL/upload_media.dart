import 'package:fan_hall/nft/NFL/upload_media1.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../providers/userProvider.dart';
import 'package:fan_hall/widgets/style.dart';
import '../../../widgets/common.dart';
import '../../screens/dashboard/certificates/certificates_screen.dart';

class UploadMedia extends StatefulWidget {
  UploadMedia({Key? key}) : super(key: key);

  @override
  State<UploadMedia> createState() => _UploadMediaState();
}

class _UploadMediaState extends State<UploadMedia>
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this, initialIndex: 1, );
    tabViewController = TabController(length: 2, vsync: this, initialIndex: 1);
    _scrollController = ScrollController();
  }

  PickedFile? imageFile;
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

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SafeArea(
                child: Column(
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
                )),
          ),
        ],
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
      setState(() {
        imageFile = pickedFile;
        Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadMedia1(imageFile!.path)));
      });

    }
  }
}

























