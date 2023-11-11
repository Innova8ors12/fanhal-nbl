import 'package:cached_network_image/cached_network_image.dart';
import 'package:fan_hall/models/article_model.dart';
import 'package:fan_hall/providers/userProvider.dart';
import 'package:fan_hall/widgets/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

import '../../../../controller/auth/league_api.dart';
import '../../../../widgets/common.dart';

class DraftDetailsScreen extends StatefulWidget {
  final String image;
  final String content;
  final String title;
  const DraftDetailsScreen({Key? key ,required this.content,required this.title,required this.image}) : super(key: key);

  @override
  State<DraftDetailsScreen> createState() => _DraftDetailsScreenState();
}

class _DraftDetailsScreenState extends State<DraftDetailsScreen> {
  List<ArticleModel> Article= [];

bool isLoading = false;

  setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }
getArticle () async {
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
  @override
  void initState() {
    // TODO: implement initState
  getArticle();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
  var user = Provider.of<UserProvider>(context).user;
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor1,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.03, horizontal: size.width * horizontalPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.arrow_back, color: primaryColorW)
                    ),
                    Row(
                      children: [
                        Icon(Icons.share, color: primaryColorW),
                        SizedBox(width: size.width * 0.04),
                        ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: Image.network(
                    user.img!,
                    scale: 2,
                    fit: BoxFit.fill,
                    height: size.height * 0.06,
                    width: size.width * 0.12,
                  ),
                ),
                      ],
                    )
                  ],
                ),
              ),
          Container(
                      height: size.height*0.5,
                      child: CachedNetworkImage(
                                                  imageUrl:widget.image.toString(),
                                                   fit: BoxFit.cover,
                                                  imageBuilder:
                                                      (context, imageProvider) =>
                                                          Container(
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  // placeholder: (context, url) =>
                                                  //     CircularProgressIndicator(
                                                  //   color: Theme.of(context)
                                                  //       .primaryColor,
                                                  // ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                ),
                    ),
              SizedBox(height: size.height * 0.03),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: VariableText(
                            text: widget.title.toString(),
                            fontcolor: primaryColorW,
                            fontsize: size.height * 0.020,
                            fontFamily: fontBold,
                            max_lines: 5,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: VariableText(
                            text: "4hr ago - Twitter",
                            fontcolor: primaryColorW,
                            fontsize: size.height * 0.016,
                            fontFamily: fontRegular,
                            max_lines: 1,
                            line_spacing: 1.6,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
                    SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  
                  child: Html(
                    data: """
                    ${widget.content}

                    """,
            
                   
                  ),
                ),
              ),
            ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
