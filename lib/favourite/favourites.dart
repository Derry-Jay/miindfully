import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:miindfully/item_details/item_list.dart';
import 'package:miindfully/models/user_model.dart';
import 'package:page_transition/page_transition.dart';

class Favourites extends StatefulWidget {
  final UserModel? userData;
  const Favourites({
    Key? key,
    this.userData,
  }) : super(key: key);

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  List<dynamic> favoritesList = [
    {
      "image": "assets/images/fav1.jpg",
      "name": "The Wooden Ladder",
      "detail": "Lorem ipsum dolor sit amet, consectetur.",
    },
    {
      "image": "assets/images/fav2.jpg",
      "name": "Golden Plank Bridge",
      "detail": "Lorem ipsum dolor sit amet, consectetur.",
    },
    {
      "image": "assets/images/fav3.jpg",
      "name": "Wobbly Table",
      "detail": "Lorem ipsum dolor sit amet, consectetur.",
    },
    {
      "image": "assets/images/fav4.jpg",
      "name": "Infinite Lookout",
      "detail": "Lorem ipsum dolor sit amet, consectetur.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Color(0xffFAD7A0),
        elevation: 1.0,
        title: Text(
          "Favourites",
          style: TextStyle(
              // fontFamily: "FuturaHeavy",
              color: Colors.brown),
        ),
      ),
      body: Container(
        color: Color(0xffFEF2EF),
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(15),
        child: ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: favoritesList.length > 0 ? favoritesList.length : 0,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(PageTransition(
                      curve: Curves.decelerate,
                      type: PageTransitionType.rightToLeft,
                      child: ItemList(
                        userData: widget.userData,
                        title: favoritesList[index]["name"],
                        image: favoritesList[index]["image"],
                      )));
                },
                child: Container(
                    margin: EdgeInsets.only(bottom: 15),
                    child: Row(
                      children: [
                        Container(
                          color: Color(0xffD0E0E3),
                          width: MediaQuery.of(context).size.width / 3,
                          child: Image.asset("${favoritesList[index]["image"]}",
                              fit: BoxFit.fitHeight,
                              height: MediaQuery.of(context).size.height / 8),
                        ),
                        Expanded(
                          child: Container(
                            height: MediaQuery.of(context).size.height / 8.5,
                            margin: EdgeInsets.only(left: 10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: AutoSizeText(
                                    "${favoritesList[index]["name"]}",
                                    minFontSize: 15,
                                    maxFontSize: 20,
                                    style: TextStyle(
                                        // // fontFamily: "Roboto",
                                        ),
                                  ),
                                ),
                                Container(
                                  child: AutoSizeText(
                                    "${favoritesList[index]["detail"]}",
                                    minFontSize: 8,
                                    maxFontSize: 11,
                                    style: TextStyle(
                                        // // fontFamily: "Roboto",
                                        color: Colors.black54),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )),
              );
            }),
      ),
    );
  }
}
