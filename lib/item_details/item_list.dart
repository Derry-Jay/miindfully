import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miindfully/classes/home_header.dart';
import 'package:miindfully/item_details/playback.dart';
import 'package:miindfully/login/get_started.dart';
import 'package:miindfully/models/user_model.dart';

class ItemList extends StatefulWidget {
  final UserModel? userData;
  final String? call;
  final String? title;
  final String? image;
  const ItemList({Key? key, this.userData, this.call, this.title, this.image})
      : super(key: key);

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  bool minimize = false;
  bool play = true;

  List<dynamic> itemList = [
    {
      "image": "assets/images/fav1.jpg",
      "title": "The Wooden Ladder",
      "ages": "4-5",
      "detail": "Lorem ipsum dolor sit amet, consectetur.",
      "length": "7m"
    },
    {
      "image": "assets/images/fav2.jpg",
      "title": "Twisty Slide",
      "ages": "6-8",
      "detail": "Lorem ipsum dolor sit amet, consectetur.",
      "length": "12m"
    },
    {
      "image": "assets/images/fav3.jpg",
      "title": "Golden Plank Bridges",
      "ages": "All ages",
      "detail": "Lorem ipsum dolor sit amet, consectetur.",
      "length": "21m"
    },
    {
      "image": "assets/images/fav4.jpg",
      "title": "Wobbly Table",
      "ages": "All ages",
      "detail": "Lorem ipsum dolor sit amet, consectetur.",
      "length": "11m"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: HomeHeader(
                userData: widget.userData,
                title: widget.title,
                image: widget.image,
              ),
            ),
            Visibility(
              visible: widget.call != null ? false : true,
              child: Container(
                color: Colors.black,
                padding: EdgeInsets.only(left: 10, right: 10),
                height: MediaQuery.of(context).size.height / 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                          onTap: () {
                            if (widget.userData != null)
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PlayBack(
                                        minimize: minimizeCallback,
                                      )));
                            else
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => GetStarted()));
                          },
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width / 1.5,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color(0xffE1CA92),
                              borderRadius: BorderRadius.all(Radius.circular(
                                5.0,
                              )),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  child: Icon(
                                    Icons.play_arrow,
                                    size: 20.0,
                                    color: Colors.black,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  alignment: Alignment.center,
                                  child: AutoSizeText(
                                    "${widget.userData != null ? "PLAY" : "LOG IN TO PLAY"}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        // // fontFamily: "Roboto",
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Icon(Icons.favorite_border,
                                size: 25.0, color: Color(0xffFAD7A0)),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Icon(Icons.cloud_download_outlined,
                                size: 25.0, color: Color(0xffFAD7A0)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                child: Container(
                    child: Stack(
              children: [
                Container(
                  child: listDetails(),
                ),
                Visibility(
                  visible: minimize ? true : false,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PlayBack(
                                  minimize: minimizeCallback,
                                )));
                      },
                      child: Container(
                        color: Colors.black54,
                        height: MediaQuery.of(context).size.height / 11,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 6,
                              child: Image.asset("assets/images/fav1.jpg",
                                  fit: BoxFit.fitHeight,
                                  height:
                                      MediaQuery.of(context).size.height / 6),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5, right: 5),
                              child: AutoSizeText(
                                "The Wooden Ladder",
                                minFontSize: 8,
                                maxFontSize: 10,
                                style: TextStyle(
                                    // // fontFamily: "Roboto",
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              height: 3,
                              color: Colors.white,
                              width: MediaQuery.of(context).size.width / 9,
                            ),
                            Container(
                              height: 3,
                              color: Colors.black87,
                              width: MediaQuery.of(context).size.width / 15,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5, right: 5),
                              child: AutoSizeText(
                                "0.43",
                                minFontSize: 8,
                                maxFontSize: 10,
                                style: TextStyle(
                                    // // fontFamily: "Roboto",
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  play = !play;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 10, right: 10),
                                child: Icon(
                                    play ? Icons.play_arrow : Icons.pause,
                                    size: 20.0,
                                    color: Colors.white),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  minimize = false;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 10, right: 10),
                                child: Icon(Icons.close,
                                    size: 20.0, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ))),
          ],
        ),
      ),
    );
  }

  Widget listDetails() {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      color: Color(0xffFEF2EF),
      child: ListView(
        children: [
          Container(
            child: AutoSizeText(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
              style: TextStyle(
                  // // fontFamily: "Roboto",
                  color: Colors.black87),
            ),
          ),
          Visibility(
            visible: widget.call != null ? false : true,
            child: Container(
              padding: EdgeInsets.only(top: 10),
              child: AutoSizeText(
                "59 m",
                style: TextStyle(
                    // // fontFamily: "Roboto",
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Visibility(
            visible: false /* widget.call!=null ?  : true*/,
            child: Container(
              padding: EdgeInsets.only(top: 10),
              child: AutoSizeText(
                "More like this",
                style: TextStyle(
                    // // fontFamily: "Roboto",
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Visibility(
            visible: false /*widget.call != null ?  : true*/,
            child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      margin: EdgeInsets.only(left: 20),
                      child: Card(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 5),
                              child: AutoSizeText(
                                "Under 10m",
                                minFontSize: 8,
                                maxFontSize: 11,
                                style: TextStyle(
                                    // // fontFamily: "Roboto",
                                    color: Colors.black87),
                              ),
                            ),
                            Container(
                              child: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      margin: EdgeInsets.only(left: 20),
                      child: Card(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 5),
                              child: AutoSizeText(
                                "All",
                                minFontSize: 8,
                                maxFontSize: 11,
                                style: TextStyle(
                                    // // fontFamily: "Roboto",
                                    color: Colors.black87),
                              ),
                            ),
                            Container(
                              child: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )),
          ),
//           Container(
//             margin: EdgeInsets.only(top: 10),
//             child: ListView.builder(
//                 shrinkWrap: true,
//                 physics: ClampingScrollPhysics(),
//                 itemCount: itemList.length > 0 ? itemList.length : 0,
//                 itemBuilder: (context, index) {
//                   return InkWell(
//                     onTap: () {},
//                     child: Container(
//                         margin: EdgeInsets.only(bottom: 10),
//                         child: Row(
//                           children: [
//                             Container(
//                               color: Color(0xffD0E0E3),
//                               // height:MediaQuery.of(context).size.height/8,
//                               width: MediaQuery.of(context).size.width / 3,
//                               child: Image.asset("${itemList[index]["image"]}",
//                                   fit: BoxFit.fitHeight,
//                                   height:
//                                       MediaQuery.of(context).size.height / 8),
//                               /*Stack(
//                               children: [
//
//                                 Positioned(
//                                   bottom: 0.0,
//                                   right: 0.0,
//                                   left: 0.0,
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child:Image.asset("${itemList[index]["image"]}",fit:BoxFit.fitHeight,
//                                         height:MediaQuery.of(context).size.height/10),
//                                   ),
//                                 ),
//
//                                 Align(
//                                     alignment: Alignment.center,
//                                     child: Container(
//                                       child:AutoSizeText("${index+1}",
//                                         style: TextStyle(// fontFamily: "Roboto",),),
//                                     ),
//
//
//                               ],
//                             ),
// */
//                             ),
//                             Expanded(
//                               child: Container(
//                                 height:
//                                     MediaQuery.of(context).size.height / 8.5,
//                                 margin: EdgeInsets.only(left: 10),
//                                 child: Column(
//                                   mainAxisSize: MainAxisSize.min,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Container(
//                                       child: AutoSizeText(
//                                         "${itemList[index]["title"]}",
//                                         minFontSize: 15,
//                                         maxFontSize: 20,
//                                         style: TextStyle(
//                                             // // fontFamily: "Roboto",
//                                             ),
//                                       ),
//                                     ),
//                                     Container(
//                                       child: AutoSizeText(
//                                         "Ages ${itemList[index]["ages"]}",
//                                         minFontSize: 8,
//                                         maxFontSize: 11,
//                                         style: TextStyle(
//                                             // // fontFamily: "Roboto",
//                                             color: Colors.grey),
//                                       ),
//                                     ),
//                                     Container(
//                                       child: AutoSizeText(
//                                         "${itemList[index]["detail"]}",
//                                         minFontSize: 8,
//                                         maxFontSize: 11,
//                                         style: TextStyle(
//                                             // // fontFamily: "Roboto",
//                                             color: Colors.black54),
//                                       ),
//                                     ),
//                                     Container(
//                                       child: AutoSizeText(
//                                         "${itemList[index]["length"]}",
//                                         minFontSize: 8,
//                                         maxFontSize: 11,
//                                         style: TextStyle(
//                                             // // fontFamily: "Roboto",
//                                             color: Colors.grey),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             )
//                           ],
//                         )),
//                   );
//                 }),
//           )
        ],
      ),
    );
  }

  void minimizeCallback(bool data) {
    setState(() {
      minimize = data;
    });
  }
}
