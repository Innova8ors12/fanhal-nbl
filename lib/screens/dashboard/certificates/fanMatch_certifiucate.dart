import 'dart:async';
import 'dart:io';

import 'package:fan_hall/controller/auth/league_api.dart';
import 'package:fan_hall/models/showcase.dart';
import 'package:fan_hall/providers/theme_provider.dart';
import 'package:fan_hall/screens/dashboard/certificates/buy_certificate/1_pick_category.dart';
import 'package:fan_hall/screens/dashboard/certificates/buy_certificate/3_certificate_type.dart';
import 'package:fan_hall/screens/dashboard/certificates/buy_certificate/4_choose_design.dart';
import 'package:fan_hall/screens/dashboard/scan_screens/certificate_full_view.dart';
import 'package:fan_hall/widgets/common.dart';
import 'package:fan_hall/widgets/constants.dart';
import 'package:fan_hall/widgets/style.dart';
import 'package:file_support/file_support.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:internet_file/internet_file.dart';
import 'package:native_pdf_renderer/native_pdf_renderer.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:ui' as ui;

class CertificatesScreenFanMatch extends StatefulWidget {
  final bool isshow;

  const CertificatesScreenFanMatch({Key? key, required this.isshow})
      : super(key: key);

  @override
  State<CertificatesScreenFanMatch> createState() =>
      _CertificatesScreenFanMatchState();
}

class _CertificatesScreenFanMatchState
    extends State<CertificatesScreenFanMatch> {
  String? selectedType = "All";

  late Timer _timer;
  final interval = const Duration(seconds: 5);
  int timerMaxSeconds = 120;
  int currentSeconds = 0;
  int page = 1;
  int limit = 2;
  bool hasMore = true;
  String? selectedSeason;
  bool isLoading = false;
  setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

  List<GlobalKey<State<StatefulWidget>>> _globalKeys = [];
  List<ShowCase> TeamCertificate = [];
  List<Image> show = [];
  List<String> id = [];
  List<Image> certtemp = [];
  ScrollController _scrollController = ScrollController();
  getshowcasecertificate(String selecttype) async {
    setLoading(true);
    var res = await ApiModel().getShowcaseFanMatch(
        selecttype == "Team"
            ? "1"
            : selecttype == "Player"
                ? "2"
                : selecttype == "Game"
                    ? "3"
                    : "",
        page,
        limit);

    ShowCase? _certificate;
    // print(res);
    TeamCertificate.clear();
    show.clear();
    certtemp.clear();
    id.clear();
    if (res != null && res['status']) {
      certtemp.clear();

      for (var item in res['data']) {
        _certificate = ShowCase.fromJson(item);
        if (_certificate.pdf != null) {
          await convertAndAddImages(_certificate);
          TeamCertificate.add(_certificate);
          id.add(_certificate.id.toString());
        }

        // show.add(_certificate.img.toString());
      }
      setLoading(false);
      _globalKeys = List.generate(
        show.length,
        (index) => GlobalKey<State<StatefulWidget>>(),
      );

      // nationalId = leagueModel!.data![1]!.id.toString();
      setState(() {});
    }
    
    setLoading(false);
  }

  String? checktype;

  Future<void> convertAndAddImages(ShowCase certificate) async {
    await pdftoimg(certificate.pdf.toString());
  }

  Future<void> saveAsPdf({bool share = false, int? index}) async {
    // setLoading(true);
    print("Save PDF");
    if (!(await Permission.storage.isGranted)) {
      await Permission.storage.request();
    }
    try {
      // Get the temporary directory using path_provider package.
      Directory? documentsDirectory = await getApplicationDocumentsDirectory();
      String documentPath = documentsDirectory!.path;
      String path = '${documentPath}/cert.pdf';
      final file = File(path);

      // Create a PDF document.
      final pdf = pw.Document();

      // Convert the widget to an image using the `RepaintBoundary` widget.
      final image = await _getImageFromWidget(index!);

      // Add the image to the PDF document.
      pdf.addPage(pw.Page(
          build: (pw.Context context) => pw.Center(child: pw.Image(image))));

      // Save the PDF document to a file.
      await file.writeAsBytes(await pdf.save());
      if (share) {
        setLoading(false);
        await SystemChannels.platform.invokeMethod('FlutterLoader.forceLoad');
        final _result = await OpenFile.open(path);
        print(_result.message);
      } else {
        setLoading(false);
        await OpenFile.open(path);
      }
      setLoading(false);
    } catch (e) {
      print('Error: $e');
    }
  }

  Directory? _appDocDir;
  Future<Directory?> getApplicationDocumentsDirectory() async {
    if (_appDocDir != null) {
      return _appDocDir;
    }
    if (Platform.isAndroid) {
      _appDocDir = await getExternalStorageDirectory();
    } else {
      _appDocDir = await getApplicationDocumentsDirectory();
    }
    return _appDocDir;
  }

  Future<pw.MemoryImage> _getImageFromWidget(int index) async {
    // Get the RenderObject of the widget.
    RenderRepaintBoundary? boundary = _globalKeys[index]
        .currentContext
        ?.findRenderObject() as RenderRepaintBoundary?;

    // Create an image from the RenderObject.
    final image = await boundary?.toImage(pixelRatio: 4.0);

    // Convert the image to PNG format.
    final pngBytes = await image?.toByteData(format: ui.ImageByteFormat.png);

    // Convert the PNG bytes to PDF image format.
    final pdfImage = pw.MemoryImage(pngBytes!.buffer.asUint8List());

    return pdfImage;
  }

  Future<dynamic> _refreshData() async {
    await Future.delayed(Duration(seconds: 2));
    getshowcasecertificate(selectedType!);

    setState(() {
      //  getshowcasecertificate(selectedType!);
    });
  }

  Future pdftoimg(String pdf) async {
    try {
      final document = await PdfDocument.openData(InternetFile.get(pdf));
      final page = await document.getPage(1);

      final pageImage = await page.render(
          width: page.width,
          height: page.height,
          format: PdfPageImageFormat.png);
      await page.close();
      certtemp.add(Image.memory(pageImage!.bytes));
    } on PlatformException catch (error) {
      print("@@: " + error.details.toString());
    }
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      getshowcasecertificate(selectedType!);
    }
  }

  @override
  void initState() {
    var duration = interval;
    // TODO: implement initState
    getshowcasecertificate(selectedType!);

    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var primarycolor = Provider.of<ThemeProvider>(context).theme1model;
    return Stack(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: size.width * horizontalPadding),
          child: Column(
            children: [
              SizedBox(height: size.height * 0.02),

              ///filters
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                        height: size.height * 0.05,
                        child: InputDecorator(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: primaryColorW,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(200),
                                  borderSide: BorderSide(
                                      color: primaryColorW, width: 2.0)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(200),
                                  borderSide: BorderSide(
                                      color: primaryColorW, width: 2.0)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(200),
                                  borderSide: BorderSide(
                                      color: primaryColorW, width: 2.0)),
                              contentPadding: EdgeInsets.all(10),
                            ),
                            child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                    icon: Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Image.asset(
                                          'assets/icons/ic_dropdown.png',
                                          color: textColor1,
                                          scale: 2),
                                    ),
                                    hint: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: VariableText(
                                        text: "All",
                                        fontsize: size.height * 0.014,
                                        fontcolor: textColor2,
                                        fontFamily: fontMedium,
                                      ),
                                    ),
                                    value: selectedType,
                                    dropdownColor: primaryColorW,
                                    isExpanded: true,
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                    },
                                    onChanged: (String? value) {
                                      setState(() {
                                        selectedType = value;
                                      });
                                      getshowcasecertificate(selectedType!);
                                    },
                                    style: TextStyle(
                                        fontSize: size.height * 0.012,
                                        color: textColor1),
                                    items: Constants.certTypeformatch
                                        .map<DropdownMenuItem<String>>(
                                            (String item) {
                                      return DropdownMenuItem<String>(
                                        value: item,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: VariableText(
                                            text: item,
                                            fontsize: size.height * 0.014,
                                            fontcolor: textColor1,
                                            fontFamily: fontSemiBold,
                                          ),
                                        ),
                                      );
                                    }).toList())))),
                  ),
                  SizedBox(width: size.width * 0.03),
                  Expanded(
                    child: SizedBox(
                        height: size.height * 0.05,
                        child: InputDecorator(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: primaryColorW,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(200),
                                  borderSide: BorderSide(
                                      color: primaryColorW, width: 2.0)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(200),
                                  borderSide: BorderSide(
                                      color: primaryColorW, width: 2.0)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(200),
                                  borderSide: BorderSide(
                                      color: primaryColorW, width: 2.0)),
                              contentPadding: EdgeInsets.all(10),
                            ),
                            child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                    icon: Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Image.asset(
                                          'assets/icons/ic_dropdown.png',
                                          color: textColor1,
                                          scale: 2),
                                    ),
                                    hint: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: VariableText(
                                        text: "2023",
                                        fontsize: size.height * 0.014,
                                        fontcolor: textColor2,
                                        fontFamily: fontMedium,
                                      ),
                                    ),
                                    value: selectedSeason,
                                    dropdownColor: primaryColorW,
                                    isExpanded: true,
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                    },
                                    onChanged: (String? value) {
                                      setState(() {
                                        selectedSeason = value;
                                      });
                                    },
                                    style: TextStyle(
                                        fontSize: size.height * 0.012,
                                        color: textColor1),
                                    items: Constants.season
                                        .map<DropdownMenuItem<String>>(
                                            (String item) {
                                      return DropdownMenuItem<String>(
                                        value: item,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: VariableText(
                                            text: item,
                                            fontsize: size.height * 0.014,
                                            fontcolor: textColor1,
                                            fontFamily: fontSemiBold,
                                          ),
                                        ),
                                      );
                                    }).toList())))),
                  ),
                ],
              ),

              SizedBox(height: size.height * 0.02),
              certtemp.isNotEmpty
                  ? widget.isshow
                      ? Expanded(
                          child: RefreshIndicator(
                          onRefresh: () async {
                            // Call your function here
                            getshowcasecertificate(selectedType!);
                          },
                          child: GridView.builder(
                            itemCount: certtemp.length,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: size.width * 0.04,
                              mainAxisSpacing: size.height * 0.02,
                              mainAxisExtent: size.height * 0.4,
                            ),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, int index) {
                              int indexx = index;

                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        SwipeLeftAnimationRoute(
                                          widget: CertificateFullview(
                                            image: certtemp[index],
                                            scan: false,
                                            show: widget.isshow,
                                            id: "1",
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      child: certtemp.isNotEmpty
                                          ? Image(
                                              image: certtemp[index].image,
                                              fit: BoxFit.cover,
                                              height: size.height * 0.4,
                                              width: size.width * 0.5,
                                            )
                                          : Container(),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ))
                      : Expanded(
                          child: GridView.builder(
                              itemCount: certtemp.length,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: size.width * 0.04,
                                      mainAxisSpacing: size.height * 0.02,
                                      mainAxisExtent: size.height * 0.4),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, int index) {
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          SwipeLeftAnimationRoute(
                                            widget: CertificateFullview(
                                              image: certtemp[index],
                                              show: widget.isshow,
                                              id: id.toString(),
                                              scan: false,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        child: certtemp.isNotEmpty
                                            ? Image(
                                                image: certtemp[index].image,
                                                fit: BoxFit.cover,
                                                height: size.height * 0.4,
                                                width: size.width * 0.5,
                                              )
                                            : Container(),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                        )
                  : Expanded(
                      child: Center(
                        child: VariableText(
                          text: "No FanMatch found!",
                          fontcolor: HexColor(
                              primarycolor.fanCardTextColor.toString()),
                          fontsize: size.height * 0.020,
                          fontFamily: fontMedium,
                        ),
                      ),
                    ),
              SizedBox(height: size.height * 0.02),
              widget.isshow
                  ? InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            SwipeLeftAnimationRoute(
                                widget: CertificateTypeScreen(
                              isfanmatch: true,
                              CertificateId: "",
                            ))).then((value) {});
                      },
                      child: Container(
                        height: size.height * 0.06,
                        width: size.height * 0.3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            color: Theme.of(context).primaryColor),
                        child: Center(
                          child: VariableText(
                            text: "Get new one",
                            fontcolor: HexColor(
                                primarycolor.fanCardTextColor.toString()),
                            fontsize: size.height * 0.020,
                            fontFamily: fontMedium,
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
              SizedBox(height: size.height * 0.01),
            ],
          ),
        ),
        if (isLoading)
          Container(
            child: ProcessLoadingLight(),
          )
      ],
    );
  }
}
