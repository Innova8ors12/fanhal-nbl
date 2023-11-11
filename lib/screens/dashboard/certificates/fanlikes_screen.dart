import 'package:flutter/material.dart';

import '../../../widgets/common.dart';
import '../../../widgets/constants.dart';
import '../../../widgets/style.dart';

class FanlikesScreen extends StatefulWidget {
  const FanlikesScreen({Key? key}) : super(key: key);

  @override
  State<FanlikesScreen> createState() => _FanlikesScreenState();
}

class _FanlikesScreenState extends State<FanlikesScreen> {
  String? selectedType;
  String? selectedSeason;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * horizontalPadding),
      child: Column(
        children: [
          SizedBox(height: size.height * 0.03),

          ///filters
          // Row(
          //   children: [
          //     Expanded(
          //       child: SizedBox(
          //           height: size.height * 0.05,
          //           child: InputDecorator(
          //               decoration: InputDecoration(
          //                 filled: true,
          //                 fillColor: primaryColorW,
          //                 enabledBorder:OutlineInputBorder(
          //                     borderRadius: BorderRadius.circular(200),
          //                     borderSide: BorderSide(color: primaryColorW, width: 2.0)
          //                 ),
          //                 focusedBorder: OutlineInputBorder(
          //                     borderRadius: BorderRadius.circular(200),
          //                     borderSide: BorderSide(color: primaryColorW, width: 2.0)),
          //                 border: OutlineInputBorder(
          //                     borderRadius: BorderRadius.circular(200),
          //                     borderSide: BorderSide(color: primaryColorW, width: 2.0)),
          //                 contentPadding: EdgeInsets.all(10),
          //               ),
          //               child:  DropdownButtonHideUnderline(
          //                   child: DropdownButton<String>(
          //                       icon: Padding(
          //                         padding: const EdgeInsets.only(right: 10),
          //                         child: Image.asset('assets/icons/ic_dropdown.png', color: textColor1, scale: 2),
          //                       ),
          //                       hint: Padding(
          //                         padding: const EdgeInsets.only(left:8.0),
          //                         child: VariableText(
          //                           text: "Type",
          //                           fontsize: size.height * 0.014,
          //                           fontcolor: textColor2,
          //                           fontFamily: fontMedium,
          //                         ),
          //                       ),
          //                       value: selectedType,
          //                       dropdownColor: primaryColorW,
          //                       isExpanded: true,
          //                       onTap: (){
          //                         FocusScope.of(context).unfocus();
          //                       },
          //                       onChanged: (String? value){
          //                         setState(() {
          //                           selectedType = value;
          //                         });
          //                       },
          //                       style: TextStyle(
          //                           fontSize: size.height * 0.012,
          //                           color: textColor1
          //                       ),
          //                       items:
          //                       Constants.certType.map<DropdownMenuItem<String>>((String item) {
          //                         return DropdownMenuItem<String>(
          //                           value: item,
          //                           child: Padding(
          //                             padding: const EdgeInsets.only(left:8.0),
          //                             child: VariableText(
          //                               text: item,
          //                               fontsize: size.height * 0.014,
          //                               fontcolor: textColor1,
          //                               fontFamily: fontSemiBold,
          //                             ),
          //                           ),
          //                         );
          //                       }).toList()
          //                   ))
          //           )
          //       ),
          //     ),
          //     SizedBox(width: size.width * 0.03),
          //     Expanded(
          //       child: SizedBox(
          //           height: size.height * 0.05,
          //           child: InputDecorator(
          //               decoration: InputDecoration(
          //                 filled: true,
          //                 fillColor: primaryColorW,
          //                 enabledBorder:OutlineInputBorder(
          //                     borderRadius: BorderRadius.circular(200),
          //                     borderSide: BorderSide(color: primaryColorW, width: 2.0)
          //                 ),
          //                 focusedBorder: OutlineInputBorder(
          //                     borderRadius: BorderRadius.circular(200),
          //                     borderSide: BorderSide(color: primaryColorW, width: 2.0)),
          //                 border: OutlineInputBorder(
          //                     borderRadius: BorderRadius.circular(200),
          //                     borderSide: BorderSide(color: primaryColorW, width: 2.0)),
          //                 contentPadding: EdgeInsets.all(10),
          //               ),
          //               child:  DropdownButtonHideUnderline(
          //                   child: DropdownButton<String>(
          //                       icon: Padding(
          //                         padding: const EdgeInsets.only(right: 10),
          //                         child: Image.asset('assets/icons/ic_dropdown.png', color: textColor1, scale: 2),
          //                       ),
          //                       hint: Padding(
          //                         padding: const EdgeInsets.only(left:8.0),
          //                         child: VariableText(
          //                           text: "Season",
          //                           fontsize: size.height * 0.014,
          //                           fontcolor: textColor2,
          //                           fontFamily: fontMedium,
          //                         ),
          //                       ),
          //                       value: selectedSeason,
          //                       dropdownColor: primaryColorW,
          //                       isExpanded: true,
          //                       onTap: (){
          //                         FocusScope.of(context).unfocus();
          //                       },
          //                       onChanged: (String? value){
          //                         setState(() {
          //                           selectedSeason = value;
          //                         });
          //                       },
          //                       style: TextStyle(
          //                           fontSize: size.height * 0.012,
          //                           color: textColor1
          //                       ),
          //                       items:
          //                       Constants.season.map<DropdownMenuItem<String>>((String item) {
          //                         return DropdownMenuItem<String>(
          //                           value: item,
          //                           child: Padding(
          //                             padding: const EdgeInsets.only(left:8.0),
          //                             child: VariableText(
          //                               text: item,
          //                               fontsize: size.height * 0.014,
          //                               fontcolor: textColor1,
          //                               fontFamily: fontSemiBold,
          //                             ),
          //                           ),
          //                         );
          //                       }).toList()
          //                   ))
          //           )
          //       ),
          //     ),
          //   ],
          // ),
          // SizedBox(height: size.height * 0.02),
          // Expanded(
          //   child: GridView.builder(
          //       itemCount: 4,
          //       shrinkWrap: true,
          //       physics: const BouncingScrollPhysics(),
          //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //           crossAxisCount: 2,
          //           crossAxisSpacing: size.width * 0.02,
          //           mainAxisSpacing: size.height * 0.01,
          //           mainAxisExtent: size.height * 0.36
          //       ),
          //       scrollDirection: Axis.vertical,
          //       itemBuilder: (context, int index) {
          //         if(index == 3){
          //           return Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Container(
          //                 height: size.height * 0.06,
          //                 width: size.height * 0.06,
          //                 decoration: BoxDecoration(
          //                     color: Theme.of(context).primaryColor
          //                 ),
          //                 child: Center(
          //                   child: Icon(Icons.add),
          //                 ),
          //               ),
          //               SizedBox(height: size.height * 0.01),
          //               VariableText(
          //                 text: "Buy new one",
          //                 fontcolor: primaryColorW,
          //                 fontsize: size.height * 0.012,
          //                 fontFamily: fontMedium,
          //               )
          //             ],
          //           );
          //         }
          //         return Column(
          //           children: [
          //             Image.asset("assets/tempImages/fanlikes_1.png", height: size.height * 0.3125, fit: BoxFit.fitWidth),
          //             SizedBox(height: size.height * 0.01),
          //             Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //               children: [
          //                 Image.asset("assets/icons/ic_certificate_nft.png", height: size.height * 0.03),
          //                 Image.asset("assets/icons/ic_certificate_zoom.png", height: size.height * 0.03),
          //                 Image.asset("assets/icons/ic_certificate_share.png", height: size.height * 0.03),
          //               ],
          //             )
          //           ],
          //         );
          //       }),
          // ),
          // SizedBox(height: size.height * 0.01),
        ],
      ),
    );
  }
}
