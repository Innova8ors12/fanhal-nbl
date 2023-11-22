import 'package:cached_network_image/cached_network_image.dart';
import 'package:fan_hall/controller/auth/league_api.dart';
import 'package:fan_hall/models/certificate.dart';
import 'package:fan_hall/models/user_model.dart';
import 'package:fan_hall/providers/theme_provider.dart';
import 'package:fan_hall/providers/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:internet_file/internet_file.dart';
import 'package:native_pdf_renderer/native_pdf_renderer.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/common.dart';
import '../../../../widgets/style.dart';
import '5_buy.dart';

class ChooseDesignScreen extends StatefulWidget {
  bool isfame;
  bool fanmatch;
  final String type;
  final String id;
  ChooseDesignScreen(
      {Key? key,
      required this.type,
      required this.id,
      this.isfame = false,
      this.fanmatch = false})
      : super(key: key);

  @override
  State<ChooseDesignScreen> createState() => _ChooseDesignScreenState();
}

class _ChooseDesignScreenState extends State<ChooseDesignScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<Offset>? _offsetFloat;
  List<Certificate> teamCertificates1 = [];

  ScrollController _scrollController = ScrollController();
  PageController _pageController = PageController(
    viewportFraction: 0.60,
    keepPage: true,
    initialPage: 0,
  );
  var nameCert;
  String? certId;
  bool hasMore = true;
  List<Image> certtemp = [];
  int indexx = 0;
  int page = 1;
  int limit = 2;
  bool isLoading = false;
  setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

  getcertificate() {
    if (selectedHero == null && selectedmomentId == null) {
      getTeamCertificates();
    }
    if (selectedHero != null) {
      getHeroCertificate();
    }
    if (selectedmomentId != null) {
      getMomentsCertificate();
    }
  }

  Future pdftoimgOld(String pdf) async {
    setLoading(true);
    var res = await ApiModel().CertificateconvertTo(pdf.toString());
    if (res != null) {
      certtemp.add(res);
    }
    setLoading(false);

    setState(() {});
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

  Future<void> getTeamCertificates() async {
    if (isLoading || !hasMore) return;

    setState(() {
      isLoading = true;
    });

    var res =
        await ApiModel().getCertificate(widget.type, widget.id, page, limit);
    List<Certificate> certificates = [];

    if (res != null && res['status']) {
      var data = res['data'];

      if (data is Iterable) {
        for (var item in data) {
          var certificate = Certificate.fromJson(item);

          await convertAndAddImages(certificate);
          certificates.add(certificate);
        }
      } else if (data is Map) {
        var certificate = Certificate.fromJson(res['data']);
        await convertAndAddImages(certificate);
        certificates.add(certificate);
      }

      if (certificates[0].data!.isNotEmpty) {
        setState(() {
          TeamCertificate.addAll(certificates[0].data!);
          page++; // Increment page number
          isLoading = false;
        });
      } else {
        setState(() {
          hasMore = false;
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> getFanMatchCertificate() async {
    if (isLoading || !hasMore) return;

    setState(() {
      isLoading = true;
    });

    var res = await ApiModel()
        .getFanMatchCertificate(widget.type.toString(), page, limit);
    List<Certificate> certificates = [];

    if (res != null && res['status']) {
      var data = res['data'];

      if (data is Iterable) {
        for (var item in data) {
          var certificate = Certificate.fromJson(item);

          await convertAndAddImages(certificate);
          certificates.add(certificate);
        }
      } else if (data is Map) {
        var certificate = Certificate.fromJson(res['data']);
        await convertAndAddImages(certificate);
        certificates.add(certificate);
      }

      if (certificates[0].data!.isNotEmpty) {
        setState(() {
          TeamCertificate.addAll(certificates[0].data!);
          page++; // Increment page number
          isLoading = false;
        });
      } else {
        setState(() {
          hasMore = false;
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> convertAndAddImages(Certificate certificate) async {
    for (var item in certificate.data!) {
      await pdftoimg(item.certImg.toString());
    }
  }

  Future<void> gethalloffamecertificate() async {
    if (isLoading || !hasMore) return;

    setState(() {
      isLoading = true;
    });

    var res = await ApiModel()
        .getCertificatefame(widget.type, widget.id, page, limit);
    List<Certificate> certificates = [];

    if (res != null && res['status']) {
      var data = res['data'];

      if (data is Iterable) {
        for (var item in data) {
          var certificate = Certificate.fromJson(item);
          await convertAndAddImages(certificate);
          certificates.add(certificate);
        }
      } else if (data is Map) {
        var certificate = Certificate.fromJson(res['data']);
        await convertAndAddImages(certificate);
        certificates.add(certificate);
      }

      if (certificates[0].data!.isNotEmpty) {
        setState(() {
          TeamCertificate.addAll(certificates[0].data!);
          page++; // Increment page number
          isLoading = false;
        });
      } else {
        setState(() {
          hasMore = false;
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  getHeroCertificate() async {
    if (isLoading || !hasMore) return;

    setState(() {
      isLoading = true;
    });

    var res = await ApiModel()
        .getherosCertificate(widget.type, widget.id, page, limit);
    List<Certificate> certificates = [];

    if (res != null && res['status']) {
      var data = res['data'];

      if (data is Iterable) {
        for (var item in data) {
          var certificate = Certificate.fromJson(item);
          await convertAndAddImages(certificate);
          certificates.add(certificate);
        }
      } else if (data is Map) {
        var certificate = Certificate.fromJson(res['data']);
        await convertAndAddImages(certificate);
        certificates.add(certificate);
      }

      if (certificates[0].data!.isNotEmpty) {
        setState(() {
          TeamCertificate.addAll(certificates[0].data!);
          page++; // Increment page number
          isLoading = false;
        });
      } else {
        setState(() {
          hasMore = false;
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  getMomentsCertificate() async {
    if (isLoading || !hasMore) return;

    setState(() {
      isLoading = true;
    });

    var res = await ApiModel()
        .getmomeCertificate(widget.type, widget.id, page, limit);
    List<Certificate> certificates = [];

    if (res != null && res['status']) {
      var data = res['data'];

      if (data is Iterable) {
        for (var item in data) {
          var certificate = Certificate.fromJson(item);
          await convertAndAddImages(certificate);
          certificates.add(certificate);
        }
      } else if (data is Map) {
        var certificate = Certificate.fromJson(res['data']);
        await convertAndAddImages(certificate);
        certificates.add(certificate);
      }

      if (certificates[0].data!.isNotEmpty) {
        setState(() {
          TeamCertificate.addAll(certificates[0].data!);
          page++; // Increment page number
          isLoading = false;
        });
      } else {
        setState(() {
          hasMore = false;
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  // var nickName;
  List<Data> TeamCertificate = [];

  @override
  void initState() {
    if (widget.fanmatch) {
      getFanMatchCertificate();
    } else {
      widget.isfame ? gethalloffamecertificate() : getcertificate();
    }
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      //  reverseDuration: Duration(seconds: 6),
      duration: const Duration(milliseconds: 500),
    );
    _offsetFloat = Tween(begin: Offset(5.0, 0.0), end: Offset(0.0, 0.0))
        .animate(CurvedAnimation(
      curve: Curves.easeInOut,
      parent: _controller!,
    ));

    _offsetFloat!.addListener(() {
      setState(() {});
    });
    _controller!.forward();
  }

  TextEditingController _certificateName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var color = Provider.of<ThemeProvider>(context).theme1model;
    var size = MediaQuery.of(context).size;
    var userdata = Provider.of<UserProvider>(context).user;
    setState(() {
      nameCert = _certificateName;
    });
    return Scaffold(
      backgroundColor: backgroundColor1,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SafeArea(
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
                              text: "Choose your design!",
                              fontcolor: primaryColorW,
                              fontsize: size.height * 0.024,
                              fontFamily: fontSemiBold,
                              max_lines: 1,
                              textAlign: TextAlign.center),
                        )
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),

                    ///Name
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.20),
                      child: MyRoundTextField(
                        text: "Enter name",
                        lenght: widget.fanmatch ? 18 : 20,
                        fontColor: textColor1,
                        cont: _certificateName,
                        hintColor: textColor3,
                        filled: true,
                        filledColor: primaryColorW,
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    certtemp.isNotEmpty
                        ? Container(
                            alignment: Alignment.center,
                            height: size.height * 0.50,
                            width: size.width,
                            child: NotificationListener<ScrollEndNotification>(
                              onNotification: (notification) {
                                if (notification.metrics.pixels ==
                                    notification.metrics.maxScrollExtent) {
                                  // Scrolled to the end
                                  getcertificate(); // Call your function here
                                }
                                return true;
                              },
                              child: SlideTransition(
                                position: _offsetFloat!,
                                child: PageView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemCount: certtemp.length,
                                  controller: _pageController,
                                  onPageChanged: (int index) {
                                    setState(() {
                                      indexx = index;
                                    });
                                  },
                                  itemBuilder: (_, i) {
                                    return Transform.scale(
                                      scale: i == indexx ? 1 : 0.8,
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            certId = TeamCertificate[indexx]
                                                .id
                                                .toString();
                                          });
                                        },
                                        child: Container(
                                          child: Stack(
                                            children: [
                                              Positioned.fill(
                                                child: certtemp.isNotEmpty
                                                    ? Image(
                                                        image:
                                                            certtemp[i].image,
                                                        fit: BoxFit.cover,
                                                        height:
                                                            size.height * 0.5,
                                                      )
                                                    : Container(),
                                              ),
                                              Positioned(
                                                top: widget.fanmatch
                                                    ? size.height * 0.43
                                                    : widget.type == "Digital"
                                                        ? size.height * 0.325
                                                        : size.height * 0.2855,
                                                right: widget.fanmatch
                                                    ? size.width * 0.02
                                                    : size.width * 0.05,
                                                left: widget.fanmatch
                                                    ? size.width * 0.33
                                                    : size.width * 0.05,
                                                child: widget.fanmatch
                                                    ? Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          VariableText(
                                                            text: _certificateName
                                                                .text
                                                                .toUpperCase(),
                                                            fontcolor: widget
                                                                    .fanmatch
                                                                ? HexColor(TeamCertificate[
                                                                        indexx]
                                                                    .textColor
                                                                    .toString())
                                                                : widget.type ==
                                                                        "Digital"
                                                                    ? HexColor(TeamCertificate[
                                                                            indexx]
                                                                        .textColor
                                                                        .toString())
                                                                    : textColorB,
                                                            fontsize: widget
                                                                    .fanmatch
                                                                ? _certificateName
                                                                            .text
                                                                            .length >
                                                                        12
                                                                    ? size.height *
                                                                        0.008
                                                                    : size.height *
                                                                        0.011
                                                                : widget.type ==
                                                                        "Digital"
                                                                    ? size.height *
                                                                        0.019
                                                                    : size.height *
                                                                        0.018,
                                                            fontFamily:
                                                                fontBold,
                                                            weight: widget
                                                                    .fanmatch
                                                                ? FontWeight
                                                                    .w400
                                                                : widget.type ==
                                                                        "Digital"
                                                                    ? FontWeight
                                                                        .w800
                                                                    : FontWeight
                                                                        .w800,
                                                            max_lines: 1,
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          VariableText(
                                                            text:
                                                                "@${userdata.username!.toString()}",
                                                            fontcolor: widget
                                                                    .fanmatch
                                                                ? HexColor(TeamCertificate[
                                                                        indexx]
                                                                    .textColor
                                                                    .toString())
                                                                : widget.type ==
                                                                        "Digital"
                                                                    ? HexColor(TeamCertificate[
                                                                            indexx]
                                                                        .textColor
                                                                        .toString())
                                                                    : textColorB,
                                                            fontsize: widget
                                                                    .fanmatch
                                                                ? _certificateName
                                                                            .text
                                                                            .length >
                                                                        12
                                                                    ? size.height *
                                                                        0.0085
                                                                    : size.height *
                                                                        0.009
                                                                : widget.type ==
                                                                        "Digital"
                                                                    ? size.height *
                                                                        0.019
                                                                    : size.height *
                                                                        0.018,
                                                            fontFamily:
                                                                fontBold,
                                                            weight:
                                                                FontWeight.w400,
                                                            max_lines: 1,
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ],
                                                      )
                                                    : Container(
                                                        width:
                                                            size.width * 0.255,
                                                        height:
                                                            size.height * 0.035,
                                                        child: VariableText(
                                                          text: _certificateName
                                                              .text
                                                              .toUpperCase(),
                                                          fontcolor: widget
                                                                  .fanmatch
                                                              ? textColorW
                                                              : widget.type ==
                                                                      "Digital"
                                                                  ? HexColor(TeamCertificate[
                                                                          indexx]
                                                                      .textColor
                                                                      .toString())
                                                                  : textColorB,
                                                          fontsize: widget
                                                                  .fanmatch
                                                              ? size.height *
                                                                  0.010
                                                              : widget.type ==
                                                                      "Digital"
                                                                  ? size.height *
                                                                      0.019
                                                                  : size.height *
                                                                      0.018,
                                                          fontFamily: fontBold,
                                                          weight: widget
                                                                  .fanmatch
                                                              ? FontWeight.w400
                                                              : widget.type ==
                                                                      "Digital"
                                                                  ? FontWeight
                                                                      .w800
                                                                  : FontWeight
                                                                      .w800,
                                                          max_lines: 1,
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          )
                        : isLoading
                            ? SizedBox(
                                height: size.height * 0.45,
                                child: Center(
                                  child: VariableText(
                                    text: "Loading......!!",
                                    fontcolor: primaryColorW,
                                    fontsize: size.height * 0.018,
                                    fontFamily: fontMedium,
                                    max_lines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: size.height * 0.45,
                                child: Center(
                                  child: VariableText(
                                    text: widget.fanmatch
                                        ? "No FanMatch found!"
                                        : "No Certificates Found!",
                                    fontcolor: HexColor(
                                        color.secondaryTextColor.toString()),
                                    fontsize: size.height * 0.018,
                                    fontFamily: fontMedium,
                                    max_lines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                    SizedBox(height: size.height * 0.01),
                    hasMore
                        ? Container()
                        // MyButton(
                        //     onTap: getcertificate,
                        //     btnTxt: "Show More",
                        //     btnHeight: size.height * 0.055,
                        //     btnWidth: size.width * 0.20,
                        //     btnColor: Theme.of(context).primaryColor,
                        //     borderColor: Theme.of(context).primaryColor,
                        //     btnRadius: 200,
                        //     fontSize: size.height * 0.014,
                        //     fontFamily: fontSemiBold,
                        //     weight: FontWeight.w500,
                        //     txtColor: Theme.of(context).iconTheme.color,
                        //   )
                        : VariableText(
                            text: "NO MORE Found!",
                            fontcolor:
                                HexColor(color.secondaryTextColor.toString()),
                            fontsize: size.height * 0.015,
                            fontFamily: fontSemiBold,
                            max_lines: 1,
                            textAlign: TextAlign.center),

                    // TextButton(
                    //   onPressed: () {},
                    //   child: VariableText(
                    //     text: "View Full Screen",
                    //     fontcolor: primaryColorW,
                    //     fontsize: size.height * 0.010,
                    //     fontFamily: fontMedium,
                    //     max_lines: 1,
                    //     textAlign: TextAlign.center,
                    //     underlined: true,
                    //   ),
                    // ),
                    SizedBox(height: size.height * 0.01),
                    MyButton(
                      btnHeight: size.height * 0.055,
                      btnWidth: size.width * 0.60,
                      btnColor: Theme.of(context).primaryColor,
                      borderColor: Theme.of(context).primaryColor,
                      btnRadius: 200,
                      btnTxt: "Continue",
                      fontSize: size.height * 0.018,
                      fontFamily: fontSemiBold,
                      weight: FontWeight.w500,
                      txtColor: Theme.of(context).iconTheme.color,
                      onTap: () {
                        if (_certificateName.text.isEmpty) {
                          customToast("Enter your Name");
                        } else {
                          setState(() {
                            certId = TeamCertificate[indexx].id.toString();
                          });
                          Navigator.push(
                              context,
                              SwipeLeftAnimationRoute(
                                  widget: BuyScreen(
                                CertificateName: _certificateName.text.trim(),
                                type: widget.type.toString(),
                                id: certId.toString(),
                                FanMatch: widget.fanmatch,
                                userName: "@${userdata.username.toString()}",
                              )));
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (isLoading)
            Container(
              child: ProcessLoadingLight(),
            )
        ],
      ),
    );
  }
}
