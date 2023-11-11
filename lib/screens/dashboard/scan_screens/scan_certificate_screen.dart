import 'package:fan_hall/controller/auth/league_api.dart';
import 'package:fan_hall/models/scan_model.dart';
import 'package:fan_hall/screens/dashboard/scan_screens/certificate_full_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../widgets/common.dart';
import '../../../widgets/style.dart';
import 'verified_certificate_screen.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScanCertificateScreen extends StatefulWidget {
  final bool? certscan;
  const ScanCertificateScreen({Key? key, required this.certscan})
      : super(key: key);

  @override
  State<ScanCertificateScreen> createState() => _ScanCertificateScreenState();
}

class _ScanCertificateScreenState extends State<ScanCertificateScreen> {
  String _scanBarcode = "-1";
  bool isSuccess = true;

  TextEditingController scanid = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  scancertid() {
    if (scanid.text != "" && _scanBarcode == "-1") {
      GetCertificate(scanid.text.toString());
    } else {
      if (scanid.text.trim.toString() == "" && _scanBarcode == "-1") {
        customToast("Please Enter or Scan First");
      } else {
        if (_scanBarcode != "-1") {

          GetCertificate(_scanBarcode);
        } else {
          customToast("Please Enter or Scan First");
        }
      }
    }
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);

      print(barcodeScanRes);

    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });

      if (_scanBarcode != "-1"){
         scanid.text= _scanBarcode.toString();
      }
  }

  bool isLoading = false;
  setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

  GetCertificate(String id) async {
    setLoading(true);

    var res = await ApiModel().getScanCertificate(id.toString());

    // print(res);

    if (res != null && res['status']) {
      ScanCertificate scandata = ScanCertificate.fromJson(res['data']);
     
     

      //  Fluttertoast.showToast(
      //     msg: "",
      //     toastLength: Toast.LENGTH_SHORT);
      setLoading(false);
      customToast("Found");
      isSuccess = false;
      Navigator.push(
          context,
          SwipeLeftAnimationRoute(
              widget: CertificateFullview(
            scan: widget.certscan,
            imageofcert: scandata.pdf,
            show: true,
          )));
    } else {
      setLoading(false);
      customToast(res['msg']);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backgroundColor1,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: size.height * 0.02),

              ///appbar
              MenuAppbar(allowBack: true),
              SizedBox(height: size.height * 0.04),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: VariableText(
                        text: "Scan a QR Certificate",
                        fontcolor: primaryColorW,
                        fontsize: size.height * 0.024,
                        fontFamily: fontSemiBold,
                        max_lines: 1,
                        textAlign: TextAlign.center),
                  )
                ],
              ),
              isSuccess
                  ? Container()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: VariableText(
                              text: "Fumble! Certificate not found.",
                              fontcolor: primaryColorW,
                              fontsize: size.height * 0.020,
                              fontFamily: fontLight,
                              max_lines: 1,
                              textAlign: TextAlign.center),
                        )
                      ],
                    ),
              SizedBox(height: size.height * 0.02),
              InkWell(
                onTap: () {
                  scanQR();
                },
                child: Container(
                  height: size.height * 0.40,
                  width: size.width,
                  color: Color(0xffD9D9D9),
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: VariableText(
                                text: "Open Cellphone Camera to Scan QR Code",
                                fontcolor: textColor2,
                                fontsize: size.height * 0.024,
                                fontFamily: fontMedium,
                                max_lines: 4,
                                textAlign: TextAlign.center),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.20),
                child: MyRoundTextField(
                  cont: scanid,
                  text: "Enter Certificate #",
                  filled: true,
                  filledColor: primaryColorW,
                  fontColor: textColor1,
                  hintColor: textColor2,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.20),
                child: isLoading
                    ? CircularProgressIndicator()
                    : MyButton(
                        btnHeight: size.height * 0.055,
                        btnColor: Color(0xFF555555),
                        borderColor: Color(0xFF555555),
                        btnRadius: 200,
                        btnTxt: "Validate",
                        fontSize: size.height * 0.018,
                        fontFamily: fontSemiBold,
                        weight: FontWeight.w500,
                        txtColor: textColorW,
                        onTap: () {
                          scancertid();
                        },
                      ),
              ),
              SizedBox(height: size.height * 0.02),
              Image.asset("assets/icons/scan_logo.png", scale: 2.8),
              SizedBox(height: size.height * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.20),
                child: MyButton(
                  btnHeight: size.height * 0.055,
                  btnColor: Theme.of(context).primaryColor,
                  borderColor: Theme.of(context).primaryColor,
                  btnRadius: 200,
                  btnTxt: "I want my certificate",
                  fontSize: size.height * 0.018,
                  fontFamily: fontSemiBold,
                  weight: FontWeight.w500,
                  txtColor: Theme.of(context).iconTheme.color,
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
