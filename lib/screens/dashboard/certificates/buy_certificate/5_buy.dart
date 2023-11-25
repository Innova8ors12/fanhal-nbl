import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fan_hall/controller/auth/league_api.dart';
import 'package:fan_hall/models/certificate.dart';
import 'package:fan_hall/models/pdf_img_model.dart';
import 'package:fan_hall/models/pdf_model.dart';
import 'package:fan_hall/screens/dashboard/certificates/buy_certificate/payment.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
// import 'package:native_pdf_renderer/native_pdf_renderer.dart';
// import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:native_pdf_renderer/native_pdf_renderer.dart';
// import 'package:screenshot/screenshot.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../widgets/common.dart';
import '../../../../widgets/style.dart';
import '6_success.dart';
import 'package:internet_file/internet_file.dart';

class BuyScreen extends StatefulWidget {
  final String CertificateName;
  final String userName;
  final String type;
  final String id;
  final bool FanMatch;

  const BuyScreen(
      {Key? key,
      required this.CertificateName,
      required this.userName,
      required this.type,
      required this.id,
      required this.FanMatch})
      : super(key: key);

  @override
  State<BuyScreen> createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  Map<String, dynamic>? paymentIntent;
  int count = 1;
  String? amount = "0";
  var transtid;
  String? certPdf;
  Image? cert;
  Uint8List? certData;
  bool isCvvFocused = false;
  TextEditingController _name = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _phone = TextEditingController();
  OutlineInputBorder? border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: BorderSide(color: primaryColorW, width: 1.0),
  );
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

  Future<void> makePayment() async {
    try {
      //  int amountcert=calculateAmount(amount!);
      paymentIntent =
          await createPaymentIntent('${count * double.parse(amount!)}', 'USD');
      //Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent!['client_secret'],
                  style: ThemeMode.dark,
                  merchantDisplayName: 'Nfl'))
          .then((value) {});

      ///now finally display payment sheeet
      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        buycert(transtid.toString());

        paymentIntent = null;
      }).onError((error, stackTrace) {
        print('Error is:--->$error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Failed "),
              ));
    } catch (e) {
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $SECRET_KEY',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      print('Payment Intent Body->>> ${response.body.toString()}');
      var res = jsonDecode(response.body);
      transtid = res["id"];
      return res;
    } catch (err) {
      // ignore: avoid_print
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final doubleAmount = double.parse(amount);
    final calculatedAmount = (doubleAmount * 100).toInt();
    return calculatedAmount.toString();
  }

  getCertiPdfforFanMatch() async {
    setLoading(true);
    var res = await ApiModel().getCertificatePdfforfanMatch(
        widget.CertificateName,
        teamId.toString(),
        widget.userName,
        widget.id.toString());

    // _pdfModel = PdfModel.fromJson();

    if (res['status'] && res != null) {
      certPdf = res['data'];
      amount = res['amount'];
      // amount=res['amount'];
      setState(() {});
      print("ye pdf hai $res['data']");
      await pdftoimg(certPdf.toString());
      setLoading(false);
    } else {
      customToast(res['msg']);
      setLoading(false);
    }
  }

  getCertiPdf() async {
    setLoading(true);
    var res = await ApiModel().getCertificatePdf(widget.CertificateName,
        teamId.toString(), widget.type, widget.id.toString());

    // _pdfModel = PdfModel.fromJson();
    certPdf = res['data'];
    amount = res['amount'];
    // amount=res['amount'];
    setState(() {});
    print("ye pdf hai $res['data']");
    await pdftoimg(certPdf.toString());
    setLoading(false);
  }

  buycert(String transId) async {
    setLoading(true);
    var res = await ApiModel().buyCertificate(
        widget.id,
        transId,
        certData!,
        _name.text,
        _address.text,
        _phone.text,
        count,
        widget.CertificateName.toString());

    if (res != null && res['status']) {
      setLoading(false);

      Navigator.push(
          context,
          SwipeLeftAnimationRoute(
              widget: SuccessScreen(
            type: widget.type,
            isfanmatch: widget.FanMatch,
          )));

      setState(() {});
    } else {
      customToast(res['msg']);
    }
  }

  pdftoimgOld() async {
    setLoading(true);
    var res = await ApiModel().CertificateconvertTo(certPdf.toString());
    //  PdfToImg _pdf=PdfModel.fromJson(res);
    cert = res;
    setState(() {});
    print(cert);
    setLoading(false);
  }

  Future pdftoimg(String pdf) async {
    //setLoading(true);
    try {
      //print("downloading pdf");
      final document = await PdfDocument.openData(InternetFile.get(pdf));
      final page = await document.getPage(1);
      //print("converting to image");
      final pageImage = await page.render(
          width: page.width,
          height: page.height,
          format: PdfPageImageFormat.png);
      await page.close();
      certData = pageImage!.bytes;
      cert = Image.memory(pageImage.bytes);
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
    if (widget.FanMatch) {
      getCertiPdfforFanMatch();
    } else {
      getCertiPdf();
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backgroundColor1,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.02),

            ///appbar
            MenuAppbar(),
            SizedBox(height: size.height * 0.03),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: VariableText(
                          text: "You’re almost done!",
                          fontcolor: primaryColorW,
                          fontsize: size.height * 0.024,
                          fontFamily: fontSemiBold,
                          max_lines: 1,
                          textAlign: TextAlign.center),
                    )
                  ],
                ),
                SizedBox(height: size.height * 0.04),
                Container(
                  height: size.height * 0.6,
                  child: Column(
                    children: [
                      isLoading
                          ? Container(
                              child: CircularProgressIndicator(
                                color: Theme.of(context).primaryColor,
                              ),
                            )
                          : SizedBox(
                              height: size.height * 0.6,
                              child: Stack(
                                children: [
                                  Positioned(
                                      top: size.height * 0.05,
                                      child: widget.type == "art"
                                          ? Image.asset(
                                              "assets/tempImages/back_ground.png",
                                              fit: BoxFit.fitWidth)
                                          : Image.asset(
                                              "assets/tempImages/back_digital.jpg",
                                              color: borderUltraLightColor,
                                              fit: BoxFit.fitWidth,
                                              height: size.height * 2,
                                            )),
                                  if (cert != null)
                                    Positioned(
                                      top: size.height * 0.02, 
                                      child: Padding(
                                        padding:  EdgeInsets.all(size.height*0.05),
                                        child: Container(
                                          height: size.height*0.5,
                                          width: size.width*0.8,
                                          child: Center(
                                            child: Image(
                                                  image: cert!.image,
                                                  
                                                  fit: BoxFit.contain),
                                          ),
                                        ),
                                      ),
                                    )
                                  else
                                    Container()
                                ],
                              ))
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * horizontalPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ///
                      widget.type != "Digital"
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                VariableText(
                                    text: "Qant.",
                                    fontcolor: primaryColorW,
                                    fontsize: size.height * 0.014,
                                    fontFamily: fontMedium,
                                    max_lines: 1),
                                SizedBox(width: size.width * 0.02),
                                widget.FanMatch
                                    ? VariableText(
                                        text: "1",
                                        fontcolor: primaryColorW,
                                        fontsize: size.height * 0.014,
                                        fontFamily: fontMedium,
                                        max_lines: 1)
                                    : Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: size.width * 0.03,
                                            vertical: size.height * 0.009),
                                        decoration: BoxDecoration(
                                            color: primaryColorW,
                                            borderRadius:
                                                BorderRadius.circular(200)),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  count++;
                                                });
                                              },
                                              child: Icon(Icons.add,
                                                  color: primaryColorB,
                                                  size: size.height * 0.02),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      size.width * 0.05),
                                              child: VariableText(
                                                  text: count.toString(),
                                                  fontcolor: primaryColorB,
                                                  fontsize: size.height * 0.016,
                                                  fontFamily: fontMedium,
                                                  max_lines: 1),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                if (count > 1) {
                                                  setState(() {
                                                    count--;
                                                  });
                                                }
                                              },
                                              child: Icon(Icons.remove,
                                                  color: primaryColorB,
                                                  size: size.height * 0.02),
                                            ),
                                          ],
                                        ),
                                      )
                              ],
                            )
                          : Container(),
                      VariableText(
                          text:
                              "Total: \$${(count * double.parse(amount!)).toInt()} USD",
                          fontcolor: primaryColorW,
                          fontsize: size.height * 0.014,
                          fontFamily: fontMedium,
                          overflow: TextOverflow.ellipsis,
                          max_lines: 1),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.04),
                MyButton(
                  btnHeight: size.height * 0.055,
                  btnWidth: size.width * 0.60,
                  btnColor: Theme.of(context).primaryColor,
                  borderColor: Theme.of(context).primaryColor,
                  btnRadius: 200,
                  btnTxt: "Purchase",
                  fontSize: size.height * 0.018,
                  fontFamily: fontSemiBold,
                  weight: FontWeight.w500,
                  txtColor: Theme.of(context).iconTheme.color,
                  onTap: () async {
                    widget.type == "art"
                        ? showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: ListView(
                                      shrinkWrap: true,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              icon: SizedBox(
                                                height: size.height * 0.03,
                                                child: Image.asset(
                                                    'assets/icons/ic_menu_close.png'),
                                              ),
                                            ),
                                          ],
                                        ),
                                        VariableText(
                                          text: "Fill The Details",
                                          fontcolor: textColorW,
                                          fontFamily: fontRegular,
                                          fontsize: size.height * 0.030,
                                          weight: FontWeight.w600,
                                        ),
                                        SizedBox(height: size.height * 0.01),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: MyRoundTextField(
                                                  text: "Enter your Name",
                                                  cont: _name,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: size.height * 0.01),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: MyRoundTextField(
                                                  text: "Enter your Phone",
                                                  cont: _phone,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: size.height * 0.01),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: MyRoundTextField(
                                                  text: "Enter your address",
                                                  cont: _address,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: size.height * 0.01),
                                        isLoading
                                            ? CircularProgressIndicator(
                                                color: primaryColor1,
                                              )
                                            : MyButton(
                                                btnHeight: size.height * 0.05,
                                                btnWidth: size.width * 0.4,
                                                btnColor: Theme.of(context)
                                                    .primaryColor,
                                                btnRadius: 8,
                                                btnTxt: "Continue",
                                                fontSize: size.height * 0.016,
                                                fontFamily: fontMedium,
                                                txtColor: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? Colors.white
                                                    : textColorB,
                                                onTap: () {
                                                  if (_name.text == null &&
                                                      _address.text == null &&
                                                      _phone.text == null) {
                                                    customToast(
                                                        "please fill the details");
                                                  } else {
                                                    Navigator.of(context).pop();
                                                    makePayment();
                                                  }
                                                },
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : await makePayment();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
