import 'package:fan_hall/controller/auth/league_api.dart';
import 'package:fan_hall/models/scan_model.dart';
import 'package:fan_hall/widgets/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internet_file/internet_file.dart';
import 'package:native_pdf_renderer/native_pdf_renderer.dart';

import '../../../widgets/common.dart';
import '../certificates/buy_certificate/1_pick_category.dart';
import 'certificate_full_view.dart';

class VerifiedCertificateScreen extends StatefulWidget {
  final String? image;
  ScanCertificate? cert;
  ScanCertificate? cert2;
  VerifiedCertificateScreen({Key? key, this.image, this.cert, this.cert2})
      : super(key: key);

  @override
  State<VerifiedCertificateScreen> createState() =>
      _VerifiedCertificateScreenState();
}

class _VerifiedCertificateScreenState extends State<VerifiedCertificateScreen> {
  bool isLoading = false;
  Image? cert;
  setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

  pdftoimgOld() async {
    setLoading(true);
    print("####");
    var res = await ApiModel().CertificateconvertTo(widget.image.toString());
    //  PdfToImg _pdf=PdfModel.fromJson(res);
    cert = res;
    setState(() {});
    print(widget.cert);
    setLoading(false);
  }

  Future pdftoimg() async {
    //setLoading(true);
    try {
      //print("downloading pdf");
      final document =
          await PdfDocument.openData(InternetFile.get(widget.image.toString()));
      final page = await document.getPage(1);
      //print("converting to image");
      final pageImage =
          await page.render(width: page.width, height: page.height);
      await page.close();
      cert = Image.memory(pageImage!.bytes);
      //print("done!!!!!!!");
    } on PlatformException catch (error) {
      print("@@: " + error.details.toString());
    }
    //setLoading(false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pdftoimg();
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor1,
        body: Stack(
          children: [
            // Column(
            //   children: [
            //     Expanded(
            //       flex: 20,
            //       child: Stack(
            //         children: [
            //           Container(
            //             color: Theme.of(context).primaryColor,
            //             child: widget.cert!.type == "digital"
            //                 ? Image.network(widget.cert!.backgroundImg!)
            //                 : Image.network(
            //                     widget.cert2!.backgroundImgDigital!),
            //           ),
            //           Positioned(
            //             top: size.height * 0.46,
            //             left: size.width * 0.15,
            //             right: size.width * 0.15,
            //             child: Padding(
            //               padding: EdgeInsets.symmetric(
            //                   vertical: size.height * 0.025),
            //               child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   MyButton(
            //                     btnHeight: size.height * 0.055,
            //                     btnWidth: size.width * 0.55,
            //                     btnColor: primaryColorB,
            //                     borderColor: primaryColorB,
            //                     btnRadius: 200,
            //                     btnTxt: "Buy certificate",
            //                     fontSize: size.height * 0.016,
            //                     fontFamily: fontSemiBold,
            //                     weight: FontWeight.w500,
            //                     txtColor: textColorW,
            //                     onTap: () {
            //                       Navigator.push(
            //                           context,
            //                           SwipeLeftAnimationRoute(
            //                               widget: PickCertificateCategory()));
            //                     },
            //                   ),
            //                   SizedBox(width: size.width * 0.03),
            //                   isLoading
            //                       ? CircularProgressIndicator()
            //                       : InkWell(
            //                           onTap: () {
            //                             Navigator.push(
            //                                 context,
            //                                 SwipeLeftAnimationRoute(
            //                                     widget: CertificateFullview(
            //                                   imageofcert: cert.toString(),show: true,
            //                                   scan: true,
            //                                 )));
            //                           },
            //                           child: Container(
            //                               height: size.height * 0.055,
            //                               width: size.height * 0.055,
            //                               padding: EdgeInsets.all(10),
            //                               decoration: BoxDecoration(
            //                                   color: primaryColorB,
            //                                   borderRadius:
            //                                       BorderRadius.circular(200)),
            //                               child: Image.asset(
            //                                   "assets/icons/certificate_view_full.png")),
            //                         )
            //                 ],
            //               ),
            //             ),
            //           )
            //         ],
            //       ),
            //     ),
            //     Expanded(
            //       child: Padding(
            //         padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             SizedBox(height: size.height * 0.006),
            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 Expanded(
            //                   child: VariableText(
            //                       text:
            //                           "${widget.cert!.team!.name.toString().toUpperCase()} ${widget.cert!.team!.nickName.toString().toUpperCase()} FOREVER FAN",
            //                       fontcolor: textColorW,
            //                       fontsize: size.height * 0.020,
            //                       fontFamily: fontMedium,
            //                       max_lines: 2,
            //                       textAlign: TextAlign.center),
            //                 )
            //               ],
            //             ),
            //             SizedBox(height: size.height * 0.04),
            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 widget.cert!.type == "digital"
            //                     ? Image.network(widget.cert!.icon1!,
            //                         height: size.height * 0.05)
            //                     : Image.network(widget.cert2!.icon1!,
            //                         height: size.height * 0.05)
            //                 // Image.network(cert2!.icon1.toString(), height: size.height * 0.05),
            //                 ,
            //                 Padding(
            //                     padding: EdgeInsets.symmetric(
            //                         horizontal: size.width * 0.03),
            //                     child: widget.cert!.type == "digital"
            //                         ? Image.network(widget.cert!.icon2!,
            //                             height: size.height * 0.12)
            //                         : Image.network(
            //                             widget.cert2!.icon2.toString(),
            //                             height: size.height * 0.12)

            //                     // Image.asset("assets/tempImages/profile_badge_1.png", height: size.height * 0.12),
            //                     ),
            //                 widget.cert!.type == "digital"
            //                     ? Image.network(widget.cert!.icon3!,
            //                         height: size.height * 0.05)
            //                     : Image.network(widget.cert2!.icon3!,
            //                         height: size.height * 0.05)
            //               ],
            //             ),
            //             SizedBox(height: size.height * 0.04),
            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 Expanded(
            //                   child: VariableText(
            //                       text:
            //                           "FANHALL CERTIFICATE: NFL S22 PS FAN 0001 AA",
            //                       fontcolor: textColorW,
            //                       fontsize: size.height * 0.014,
            //                       fontFamily: fontMedium,
            //                       max_lines: 2,
            //                       textAlign: TextAlign.center),
            //                 )
            //               ],
            //             ),
            //             SizedBox(height: size.height * 0.006),
            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 Expanded(
            //                   child: VariableText(
            //                       text:
            //                           "September 27, 2022 / Pennsylvania, USA",
            //                       fontcolor: textColorW,
            //                       fontsize: size.height * 0.012,
            //                       fontFamily: fontMedium,
            //                       max_lines: 2,
            //                       textAlign: TextAlign.center),
            //                 )
            //               ],
            //             ),
            //           ],
            //         ),
            //       ),
            //     )
            //   ],
            // ),
            // Padding(
            //   padding: EdgeInsets.symmetric(
            //       horizontal: size.width * 0.05, vertical: size.height * 0.025),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       InkWell(
            //           onTap: () {
            //             Navigator.of(context).pop();
            //           },
            //           child: Icon(Icons.arrow_back, color: primaryColorB)),
            //       Icon(
            //         Icons.download,
            //         color: primaryColorB,
            //       )
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
