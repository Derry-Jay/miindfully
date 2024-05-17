import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class PlayBack extends StatefulWidget {
  final Function(bool) minimize;

  const PlayBack({Key? key, required this.minimize}) : super(key: key);

  @override
  _PlayBackState createState() => _PlayBackState();
}

class _PlayBackState extends State<PlayBack> {
  bool play = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Image.asset("assets/images/fav1.jpg",
                  fit: BoxFit.fitHeight,
                  height: MediaQuery.of(context).size.height),
            ),
            Positioned(
              top: 70,
              child: Container(
                child: AutoSizeText(
                  "The Wooden Ladder",
                  minFontSize: 20,
                  style: TextStyle(
                      // // fontFamily: "Roboto",
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Positioned(
              top: 100,
              child: InkWell(
                onTap: () {
                  Navigator.of(context, rootNavigator: true).pop();
                  widget.minimize(true);
                },
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.keyboard_arrow_down_outlined,
                      size: 60,
                      color: Colors.white,
                    )),
              ),
            ),
            Positioned(
              bottom: 180,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white)),
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: Icon(Icons.favorite_border,
                          size: 30.0, color: Colors.white),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white)),
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: Icon(Icons.cloud_download_outlined,
                          size: 30.0, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 120,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child:
                          Icon(Icons.replay, size: 30.0, color: Colors.white),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          play = !play;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: Icon(play ? Icons.play_arrow : Icons.pause,
                            size: 40.0, color: Colors.white),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child:
                          Icon(Icons.refresh, size: 30.0, color: Colors.white),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      child: Container(
                        child:
                            Icon(Icons.stop, size: 30.0, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 80,
              child: Container(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      color: Colors.white,
                      height: 3,
                      width: MediaQuery.of(context).size.width / 4,
                    ),
                    Container(
                      color: Colors.black,
                      height: 3,
                      width: MediaQuery.of(context).size.width / 2,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 60,
              child: Container(
                width: MediaQuery.of(context).size.width / 1.4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: AutoSizeText(
                        "0.42",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                      child: AutoSizeText(
                        "14.57",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
