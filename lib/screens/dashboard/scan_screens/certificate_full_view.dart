import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fan_hall/controller/auth/league_api.dart';
import 'package:fan_hall/providers/userProvider.dart';
import 'package:fan_hall/screens/dashboard/certificates/buy_certificate/1_pick_category.dart';
import 'package:fan_hall/screens/dashboard/profile/profile_menu_screen.dart';
import 'package:file_support/file_support.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'dart:ui' as ui;
import 'package:pdf/widgets.dart' as pw;
import 'package:hexcolor/hexcolor.dart';
import 'package:internet_file/internet_file.dart';
import 'package:native_pdf_renderer/native_pdf_renderer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:image/image.dart' as img;
import '../../../widgets/common.dart';
import '../../../widgets/style.dart';

class CertificateFullview extends StatefulWidget {
  final bool? scan;
  final bool? show;
  final String? imageofcert;
  final Image? image;
  final String? id;
  const CertificateFullview(
      {Key? key,
      this.image,
      this.imageofcert,
      required this.scan,
      required this.show,
      this.id})
      : super(key: key);

  @override
  State<CertificateFullview> createState() => _CertificateFullviewState();
}

class _CertificateFullviewState extends State<CertificateFullview> {
  Image? image1;

  Future pdftoimg(String image) async {
    setLoading(true);
    try {
      //print("downloading pdf");
      final document = await PdfDocument.openData(InternetFile.get(image));
      final page = await document.getPage(1);
      //print("converting to image");
      final pageImage = await page.render(
          width: page.width,
          height: page.height,
          format: PdfPageImageFormat.png);
      await page.close();
      image1 = await Image.memory(pageImage!.bytes);
      setState(() {});
      //print("done!!!!!!!");
      setLoading(false);
    } on PlatformException catch (error) {
      print("@@: " + error.details.toString());
      setLoading(false);
    }
    setLoading(false);
  }
//  Future pdftoimg(String pdf) async {
//     try {
//       final document = await PdfDocument.openData(InternetFile.get(pdf));
//       final page = await document.getPage(1);

//       final pageImage = await page.render(
//           width: page.width,
//           height: page.height,
//           format: PdfPageImageFormat.png);
//       await page.close();
//       certtemp.add(Image.memory(pageImage!.bytes));
//     } on PlatformException catch (error) {
//       print("@@: " + error.details.toString());
//     }
//   }
  bool isLoading = false;
  setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: new Text("Are you sure you want to delete?"),
          actions: <Widget>[
            ElevatedButton(
              child: isLoading
                  ? CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    )
                  : Text("Delete"),
              onPressed: () async {
                await deletePost();
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  GlobalKey _globalKey = GlobalKey();
  Future<void> saveAsImage(bool share) async {
    if (!(await Permission.storage.isGranted)) {
      await Permission.storage.request();
    }

    try {
      Directory? documentsDirectory = await getApplicationDocumentsDirectory();
      String documentPath = documentsDirectory.path;
      String path = '$documentPath/cert.png';

      final image = await _getImageFromWidget();

      final imageFile = File(path);
      await imageFile.writeAsBytes(image);

      if (share) {
        // Use share_plus to share the image
        await Share.shareFiles([path], text: 'Check out this image!');
      } else {
        await OpenFile.open(path);
      }
    } catch (e) {
      print('Error: $e');
      customToast('Error: $e');
    }
  }

  Future<Uint8List> _getImageFromWidget() async {
    try {
      setLoading(true);
      // Find the RenderRepaintBoundary of the current context using a GlobalKey
      RenderRepaintBoundary boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;

      // Set the desired pixel ratio
      double pixelRatio =
          2.0; // Change this if necessary, but 1.0 should maintain original size

      // Capture the image with increased pixel ratio
      ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);

      // Convert the image to byte data in PNG format
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);

      // Convert the byte data to a Uint8List
      Uint8List byteList = byteData!.buffer.asUint8List();

      // Decode the image using the 'img' package
      img.Image decodedImage = img.decodeImage(byteList)!;

      // Resize the image to the desired dimensions
      img.Image resizedImage =
          img.copyResize(decodedImage, height: 1920, width: 1080);

      // Convert the resized image to JPEG format with higher quality
      Uint8List resizedByteList =
          Uint8List.fromList(img.encodeJpg(resizedImage, quality: 100));
      setLoading(false);
      return resizedByteList;
    } catch (e) {
      setLoading(false);
      // Handle and log any errors that occur during the process
      print('Error capturing and processing image: $e');
      rethrow; // Rethrow the error to propagate it further if needed
    }
  }
  // Future<pw.MemoryImage> _getImageFromWidget() async {
  //   // Get the RenderObject of the widget.
  //   RenderRepaintBoundary? boundary =
  //       _globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;

  //   // Create an image from the RenderObject.
  //   final image = await boundary?.toImage(pixelRatio: 4.0);

  //   // Convert the image to PNG format.
  //   final pngBytes = await image?.toByteData(format: ui.ImageByteFormat.png);

  //   // Convert the PNG bytes to PDF image format.
  //   final pdfImage = pw.MemoryImage(pngBytes!.buffer.asUint8List());

  //   return pdfImage;
  // }

  deletePost() async {
    setLoading(true);
    var res = await ApiModel().deleteCert(widget.id.toString());
    if (res['status'].toString() == "true") {
      customToast(res['data']);
      Navigator.of(context).pop(true);

      setLoading(false);
    } else {
      setLoading(false);
      Navigator.of(context).pop(true);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.scan!) {
      pdftoimg(widget.imageofcert!);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var user = Provider.of<UserProvider>(context).user;
    return SafeArea(
      child: Scaffold(
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
                      InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(Icons.arrow_back, color: primaryColorW)),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              SwipeLeftAnimationRoute(
                                  widget: ProfileMenuScreen()));
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(200),
                          child: user.img == null
                              ? Image.asset(
                                  "assets/icons/ic_profile1.png",
                                  scale: 2,
                                  fit: BoxFit.fill,
                                  height: size.height * 0.05,
                                  width: size.width * 0.10,
                                )
                              : Image.network(
                                  user.img!,
                                  scale: 2,
                                  fit: BoxFit.fill,
                                  height: size.height * 0.05,
                                  width: size.width * 0.10,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.015),
              ],
            ),
          ),
          backgroundColor: backgroundColor1,
          body: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    isLoading
                        ? Container(
                            height: size.height * 0.6,
                            child: SizedBox(
                              height: size.height * 0.01,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          )
                        : SizedBox(
                            height: size.height * 0.6,
                            child: widget.scan!
                                ? RepaintBoundary(
                                    key: _globalKey,
                                    child: InkWell(
                                        onLongPress: () {
                                          _showDialog();
                                        },
                                        child: image1 != null
                                            ? Image(
                                                image: image1!.image,
                                                fit: BoxFit.cover,
                                              )
                                            : Container()))
                                : InkWell(
                                    onLongPress: () {
                                      _showDialog();
                                    },
                                    child: RepaintBoundary(
                                      key: widget.scan!
                                          ? GlobalKey()
                                          : _globalKey,
                                      child: widget.image != null
                                          ? Image(
                                              image: widget.image!.image,
                                              fit: BoxFit.cover,
                                            )
                                          : Container(),
                                    ),
                                  ),
                          ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                widget.show!
                    ? widget.scan!
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: size.height * 0.02),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    saveAsImage(false);
                                  },
                                  child: Image.asset(
                                    "assets/icons/ic_download.png",
                                    color: textColorW,
                                    scale: 9,
                                  ),
                                ),
                                SizedBox(width: size.width * 0.04),
                                MyButton(
                                  btnHeight: size.height * 0.06,
                                  btnWidth: size.width * 0.50,
                                  btnColor: Theme.of(context).primaryColor,
                                  borderColor: Theme.of(context).primaryColor,
                                  btnRadius: 200,
                                  btnTxt: "Buy new one",
                                  fontSize: size.height * 0.018,
                                  fontFamily: fontMedium,
                                  weight: FontWeight.w500,
                                  txtColor: Theme.of(context).iconTheme.color,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        SwipeLeftAnimationRoute(
                                            widget: PickCertificateCategory()));
                                  },
                                ),
                                SizedBox(width: size.width * 0.04),
                                InkWell(
                                    onTap: () {
                                      saveAsImage(true);
                                    },
                                    child: Icon(Icons.share, color: textColorW))
                              ],
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: size.height * 0.00),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    saveAsImage(false);
                                  },
                                  child: Image.asset(
                                    "assets/icons/ic_download.png",
                                    color: textColorW,
                                    scale: 9,
                                  ),
                                ),
                                SizedBox(width: size.width * 0.04),
                                MyButton(
                                  btnHeight: size.height * 0.06,
                                  btnWidth: size.width * 0.50,
                                  btnColor: Theme.of(context).primaryColor,
                                  borderColor: Theme.of(context).primaryColor,
                                  btnRadius: 200,
                                  btnTxt: "Do IT NFT(ETH)",
                                  fontSize: size.height * 0.018,
                                  fontFamily: fontMedium,
                                  weight: FontWeight.w500,
                                  txtColor: Theme.of(context).iconTheme.color,
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                SizedBox(width: size.width * 0.04),
                                InkWell(
                                    onTap: () {
                                      saveAsImage(true);
                                    },
                                    child: Icon(Icons.share, color: textColorW))
                              ],
                            ),
                          )
                    : Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: size.height * 0.00),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                                onTap: () {
                                  saveAsImage(true);
                                },
                                child: Icon(Icons.share, color: textColorW))
                          ],
                        ),
                      )
              ],
            ),
          )),
    );
  }
}
