import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fan_hall/controller/auth/league_api.dart';
import 'package:fan_hall/models/article_model.dart';
import 'package:fan_hall/providers/userProvider.dart';
import 'package:fan_hall/screens/dashboard/draft/fan_draft/draft_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../../widgets/common.dart';
import '../../../../widgets/style.dart';
import '../draft_success_screen.dart';
import 'survey_screen.dart';

class FanDraftScreen extends StatefulWidget {
  const FanDraftScreen({Key? key}) : super(key: key);

  @override
  State<FanDraftScreen> createState() => _FanDraftScreenState();
}

class _FanDraftScreenState extends State<FanDraftScreen> {
  List<String> draftTypes = ["AWARDS", "WINNERS", "NEWS", "SURVEYS"];
  int selectedType = 0;
  bool hasSubscription = false;

  List<ArticleModel> Article = [];

  String? posterimage;
  Map<String, dynamic>? paymentIntent;

  bool isLoading = false;

  setLoading(bool loading) {
      setState(() {
      isLoading = loading;
    });
  }

  String Charges = "4.9";
  Future<void> makePayment() async {
    setLoading(true);
    try {
      paymentIntent = await createPaymentIntent(Charges, 'USD');
      //Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent!['client_secret'],
                  // applePay: const PaymentSheetApplePay(merchantCountryCode: '+92',),
                  // googlePay: const PaymentSheetGooglePay(testEnv: true, currencyCode: "US", merchantCountryCode: "+92"),
                  style: ThemeMode.dark,
                  merchantDisplayName: 'Nfl'))
          .then((value) {});

      ///now finally display payment sheeet
      displayPaymentSheet();

      setLoading(false);
    } catch (e, s) {
      setLoading(false);
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        Navigator.push(
            context, SwipeLeftAnimationRoute(widget: DraftSuccessScreen()));

        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("paid successfully")));

        paymentIntent = null;
        setState(() {
          hasSubscription = true;
        });
      }).onError((error, stackTrace) {
        print('Error is:--->$error $stackTrace');
      });

      //  Navigator.push(context, SwipeLeftAnimationRoute(widget: SuccessScreen()));
    } on StripeException catch (e) {
      print('Error is:---> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled "),
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
      // ignore: avoid_print
      print('Payment Intent Body->>> ${response.body.toString()}');
      return jsonDecode(response.body);
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

  getArticle() async {
    setLoading(true);
    var res = await ApiModel().getArticle();

    ArticleModel? _article;
    // print(res);
    Article.clear();
    if (res != null && res['status']) {
      for (var item in res['data']) {
        _article = ArticleModel.fromJson(item);

        Article.add(_article);
      }
      setLoading(false);
      setState(() {});
    }
  }

  getTeamPoster() async {
    setLoading(true);
    var res = await ApiModel().getTeamPoster();

    // ArticleModel? _article;
    // print(res);
    Article.clear();
    if (res != null && res['status']) {
      setLoading(false);
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    // getTeamPoster();
    getArticle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: size.height * 0.02),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * horizontalPadding),
            child: Row(
              children: [
                Expanded(
                  flex: 20,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedType = 0;
                      });
                    },
                    child: Container(
                      height: size.height * 0.045,
                      margin: EdgeInsets.only(right: size.width * 0.015),
                      decoration: BoxDecoration(
                          color: selectedType == 0
                              ? Theme.of(context).primaryColor
                              : primaryColorW,
                          border: Border.all(
                              color: selectedType == 0
                                  ? Theme.of(context).primaryColor
                                  : primaryColorW),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.02),
                            child: VariableText(
                              text: draftTypes[0],
                              fontcolor: selectedType == 0
                                  ? Theme.of(context).iconTheme.color
                                  : primaryColorB,
                              fontsize: size.height * 0.012,
                              fontFamily: fontMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 20,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedType = 1;
                      });
                    },
                    child: Container(
                      height: size.height * 0.045,
                      margin: EdgeInsets.only(right: size.width * 0.015),
                      decoration: BoxDecoration(
                          color: selectedType == 1
                              ? Theme.of(context).primaryColor
                              : primaryColorW,
                          border: Border.all(
                              color: selectedType == 1
                                  ? Theme.of(context).primaryColor
                                  : primaryColorW),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.02),
                            child: VariableText(
                              text: draftTypes[1],
                              fontcolor: selectedType == 1
                                  ? Theme.of(context).iconTheme.color
                                  : primaryColorB,
                              fontsize: size.height * 0.012,
                              fontFamily: fontMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 20,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedType = 2;
                      });
                    },
                    child: Container(
                      height: size.height * 0.045,
                      margin: EdgeInsets.only(right: size.width * 0.015),
                      decoration: BoxDecoration(
                          color: selectedType == 2
                              ? Theme.of(context).primaryColor
                              : primaryColorW,
                          border: Border.all(
                              color: selectedType == 2
                                  ? Theme.of(context).primaryColor
                                  : primaryColorW),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.02),
                            child: VariableText(
                              text: draftTypes[2],
                              fontcolor: selectedType == 2
                                  ? Theme.of(context).iconTheme.color
                                  : primaryColorB,
                              fontsize: size.height * 0.012,
                              fontFamily: fontMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 20,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedType = 3;
                      });
                    },
                    child: Container(
                      height: size.height * 0.045,
                      margin: EdgeInsets.only(right: size.width * 0.015),
                      decoration: BoxDecoration(
                          color: selectedType == 3
                              ? Theme.of(context).primaryColor
                              : primaryColorW,
                          border: Border.all(
                              color: selectedType == 3
                                  ? Theme.of(context).primaryColor
                                  : primaryColorW),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.02),
                            child: VariableText(
                              text: draftTypes[3],
                              fontcolor: selectedType == 3
                                  ? Theme.of(context).iconTheme.color
                                  : primaryColorB,
                              fontsize: size.height * 0.012,
                              fontFamily: fontMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          hasSubscription
              ? selectedType == 3
                  ? renderSurvey(context)
                  : Column(
                      children: [
                        SizedBox(height: size.height * 0.02),
                        renderDraft(context),
                      ],
                    )
              : renderNoSub(context)
        ],
      ),
    );
  }

  renderDraft(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        height: size.height * 0.60,
        child: ListView.separated(
            physics: ScrollPhysics(),
            itemCount: Article.length,
            separatorBuilder: (_, index) {
              return Divider(
                  color: primaryColorB,
                  height: size.height * 0.05,
                  thickness: 1);
            },
            itemBuilder: (_, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      SwipeLeftAnimationRoute(
                          widget: DraftDetailsScreen(
                        title: Article[index].title.toString(),
                        image: Article[index].image.toString(),
                        content: Article[index].content.toString(),
                      )));
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * horizontalPadding),
                        child: Row(
                          children: [
                            Expanded(
                              child: VariableText(
                                text: Article[index].title,
                                fontcolor: primaryColorW,
                                fontsize: size.height * 0.014,
                                fontFamily: fontSemiBold,
                                max_lines: 2,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * horizontalPadding),
                        child: Row(
                          children: [
                            Expanded(
                              child: VariableText(
                                text: "4hr ago - Twitter",
                                fontcolor: textColor3,
                                fontsize: size.height * 0.012,
                                fontFamily: fontRegular,
                                max_lines: 1,
                                line_spacing: 1.5,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: size.height * 0.015),
                          child: Container(
                            height: size.height * 0.5,
                            child: CachedNetworkImage(
                              imageUrl: Article[index].image.toString(),
                              fit: BoxFit.cover,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          )),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * horizontalPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset("assets/icons/scan_logo.png",
                                scale: 2.4),
                            Icon(Icons.share, color: primaryColorW)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  renderNoSub(BuildContext context) {
    var user = Provider.of<UserProvider>(context).user;
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: size.height * 0.02),
        Stack(
          children: [
            Container(
              height: size.height * 0.5,
              child: user.team!.poster == null
                  ? Container(
                      child: Center(
                        child: VariableText(
                          text: "No Poster Found!!",
                          fontcolor: primaryColorW,
                          fontsize: size.height * 0.014,
                          fontFamily: fontMedium,
                          max_lines: 1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : user.team!.poster!.poster == null
                      ? Container(
                          child: Center(
                            child: VariableText(
                              text: "No Poster Found!!",
                              fontcolor: primaryColorW,
                              fontsize: size.height * 0.014,
                              fontFamily: fontMedium,
                              max_lines: 1,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : CachedNetworkImage(
                          imageUrl: user.team!.poster!.poster.toString(),
                          fit: BoxFit.cover,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
            )
          ],
        ),
        SizedBox(height: size.height * 0.02),
        isLoading == true
            ? CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              )
            : MyButton(
                btnHeight: size.height * 0.055,
                btnWidth: size.width * 0.50,
                btnColor: Theme.of(context).primaryColor,
                borderColor: Theme.of(context).primaryColor,
                btnRadius: 200,
                btnTxt: "Access now",
                fontSize: size.height * 0.018,
                fontFamily: fontMedium,
                weight: FontWeight.w400,
                txtColor: Theme.of(context).iconTheme.color,
                onTap: () async {
                  await makePayment();
                },
              ),
        SizedBox(height: size.height * 0.02),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: VariableText(
                  text:
                      "Unlock your VIP experience for just: \$$Charges USD monthly",
                  fontcolor: primaryColorW,
                  fontsize: size.height * 0.012,
                  fontFamily: fontMedium,
                  max_lines: 1,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  renderSurvey(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: size.height * 0.02),
        Stack(
          children: [
            Image.asset("assets/tempImages/survey_1.png", fit: BoxFit.fitWidth),
          ],
        ),
        SizedBox(height: size.height * 0.01),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: VariableText(
                text:
                    'Your opinion is important, help us choose the design for our next collection of Jumper Hoodie.',
                fontsize: size.height * 0.012,
                fontcolor: primaryColorW,
                fontFamily: fontRegular,
                weight: FontWeight.w500,
                textAlign: TextAlign.center,
                line_spacing: 1.6,
                max_lines: 5,
              ),
            )
          ],
        ),
        SizedBox(height: size.height * 0.02),
        MyButton(
          btnHeight: size.height * 0.055,
          btnWidth: size.width * 0.50,
          btnColor: Theme.of(context).primaryColor,
          borderColor: Theme.of(context).primaryColor,
          btnRadius: 200,
          btnTxt: "Start Survey",
          fontSize: size.height * 0.018,
          fontFamily: fontMedium,
          weight: FontWeight.w400,
          txtColor: Theme.of(context).iconTheme.color,
          onTap: () {
            Navigator.push(
                context, SwipeLeftAnimationRoute(widget: SurveyScreen()));
          },
        ),
        SizedBox(height: size.height * 0.02),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: VariableText(
                  text:
                      "Participate and win tickets for this season. By completing this survey you are accepting the Terms & Conditions.",
                  fontcolor: primaryColorW,
                  fontsize: size.height * 0.012,
                  fontFamily: fontRegular,
                  max_lines: 5,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
