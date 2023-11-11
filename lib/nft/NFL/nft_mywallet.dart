import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/src/dropdown_button2.dart';
import 'package:image_picker/image_picker.dart';

class NFTMyWallet extends StatefulWidget {
  const NFTMyWallet({super.key});

  @override
  State<NFTMyWallet> createState() => _NFTMyWalletState();
}

class _NFTMyWalletState extends State<NFTMyWallet>
    with SingleTickerProviderStateMixin {
  PickedFile? imageFile;
  late TabController bookingTabController =
      TabController(length: 2, vsync: this, initialIndex: 0);
  final List<String> items = [
    'All',
    'Apparel',
    'Luxury Tech',
  ];
  final List<String> seasons = [
    'Season 2023',
    'Season 2022',
    'Season 2024',
  ];
  String? selectedValue;
  String? selectedValue1;
  @override
  void dispose() {
    super.dispose();
    bookingTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.grey.shade900,
        leading: Visibility(
          visible: true,
          child: IconButton(
            icon: Icon(Icons.arrow_back, size: 20, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey.shade900,
              child: Image.asset('images/Group 34.png'),
            )
          ],
        ),
        bottom: TabBar(
          controller: bookingTabController,
          labelStyle: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
          indicatorColor: Colors.white,
          tabs: [
            Tab(text: "Certificates"),
            Tab(text: "NFTs"),
          ],
        ),
      ),
      body: TabBarView(controller: bookingTabController, children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: SafeArea(
              child: Column(
            children: [],
          )),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: SafeArea(
              child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 14,
                ),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          hint: Row(
                            children: const [
                              SizedBox(
                                width: 4,
                              ),
                              Expanded(
                                child: Text(
                                  'All',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          items: items
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                              .toList(),
                          value: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value as String;
                            });
                          },
                          buttonStyleData: ButtonStyleData(
                            height: 40,
                            width: 160,
                            padding: const EdgeInsets.only(left: 14, right: 14),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22),
                                border: Border.all(
                                  color: Colors.black26,
                                ),
                                color: Colors.white),
                            elevation: 2,
                          ),
                          iconStyleData: const IconStyleData(
                            icon: Icon(
                              Icons.arrow_drop_down,
                            ),
                            iconSize: 32,
                            iconEnabledColor: Colors.black,
                            iconDisabledColor: Colors.black,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            maxHeight: 200,
                            width: 200,
                            padding: null,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              color: Colors.white,
                            ),
                            elevation: 8,
                            offset: const Offset(-20, 0),
                            scrollbarTheme: ScrollbarThemeData(
                              radius: const Radius.circular(40),
                              thickness: MaterialStateProperty.all<double>(6),
                              thumbVisibility:
                                  MaterialStateProperty.all<bool>(true),
                            ),
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                            padding: EdgeInsets.only(left: 14, right: 14),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          hint: Row(
                            children: const [
                              SizedBox(
                                width: 4,
                              ),
                              Expanded(
                                child: Text(
                                  'Season 2023',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          items: seasons
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                              .toList(),
                          value: selectedValue1,
                          onChanged: (value) {
                            setState(() {
                              selectedValue1 = value as String;
                            });
                          },
                          buttonStyleData: ButtonStyleData(
                            height: 40,
                            width: 160,
                            padding: const EdgeInsets.only(left: 14, right: 14),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22),
                                border: Border.all(
                                  color: Colors.black26,
                                ),
                                color: Colors.white),
                            elevation: 2,
                          ),
                          iconStyleData: const IconStyleData(
                            icon: Icon(
                              Icons.arrow_drop_down,
                            ),
                            iconSize: 32,
                            iconEnabledColor: Colors.black,
                            iconDisabledColor: Colors.black,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            maxHeight: 200,
                            width: 200,
                            padding: null,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22),
                                color: Colors.white),
                            elevation: 8,
                            offset: const Offset(-20, 0),
                            scrollbarTheme: ScrollbarThemeData(
                              radius: const Radius.circular(40),
                              thickness: MaterialStateProperty.all<double>(6),
                              thumbVisibility:
                                  MaterialStateProperty.all<bool>(true),
                            ),
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                            padding: EdgeInsets.only(left: 14, right: 14),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 55,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Column(
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          color: Color(0xffFFB612),
                          child: Icon(
                            Icons.add,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Text(
                          'Create new NFT',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.normal),
                        ),
                        SizedBox(
                          height: 22,
                        ),
                      ],
                    )),
                    Expanded(
                      child: Column(
                        children: [
                          Image.asset(
                            'images/nft.png',
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.fill,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                Icons.share_outlined,
                                color: Colors.grey,
                              ),
                              Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                              Icon(
                                Icons.send,
                                color: Colors.grey,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Image.asset(
                            'images/Mask group.png',
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.fill,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                Icons.share_outlined,
                                color: Colors.grey,
                              ),
                              Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                              Icon(
                                Icons.send,
                                color: Colors.grey,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Image.asset(
                            'images/Mask group.png',
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.fill,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                Icons.share_outlined,
                                color: Colors.grey,
                              ),
                              Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                              Icon(
                                Icons.send,
                                color: Colors.grey,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 35,
                ),
              ],
            ),
          )),
        ),
      ]),
    );
  }
}
