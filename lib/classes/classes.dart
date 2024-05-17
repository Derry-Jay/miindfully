import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:miindfully/classes/home_footer.dart';
import 'package:miindfully/classes/home_header.dart';
import 'package:miindfully/models/user_model.dart';

class Classes extends StatefulWidget {
  final UserModel? userData;
  const Classes({Key? key, this.userData}) : super(key: key);

  @override
  _ClassesState createState() => _ClassesState();
}

class _ClassesState extends State<Classes> {
  List cardList = [];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  List<dynamic> favoritesList = [
    {"image": "assets/images/fav1.jpg", "name": "The Wooden Ladder"},
    {"image": "assets/images/fav2.jpg", "name": "Golden Plank Bridge"},
    {"image": "assets/images/fav3.jpg", "name": "Wobbly Table"},
    {"image": "assets/images/fav4.jpg", "name": "Infinite Lookout"},
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createCard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xffFEF2EF),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Color(0xffFEF2EF),
              child: CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  height: MediaQuery.of(context).size.height / 3,
                  reverse: false,
                  viewportFraction: 1.0,
                  onPageChanged: (index, reason) {},
                  pauseAutoPlayOnTouch: true,
                ),
                items: cardList.map(
                  (card) {
                    return Builder(builder: (BuildContext context) {
                      return Container(
                        color: Color(0xffFEF2EF),
                        child: Card(
                          child: card,
                        ),
                      );
                    });
                  },
                ).toList(),
              ),
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.only(top: 5),
              child: HomeFooter(
                userData: widget.userData,
              ),
            )),
          ],
        ),
      ),
    );
  }

  void createCard() {
    for (int i = 0; i < favoritesList.length; ++i) {
      cardList.add(Container(
        child: HomeHeader(
            userData: widget.userData,
            call: "FromHome",
            image: favoritesList[i]["image"],
            title: favoritesList[i]["name"]),
      ));
    }
  } //func

}
