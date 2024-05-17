import 'dart:ui';
import 'package:miindfully/home_dash/category_details.dart';
import 'package:miindfully/resources/user_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:miindfully/models/user_model.dart';
import 'package:page_transition/page_transition.dart';

class HomeDash extends StatefulWidget {
  final UserModel? userData;
  const HomeDash({Key? key, this.userData}) : super(key: key);

  @override
  _HomeDashState createState() => _HomeDashState();
}

class _HomeDashState extends StateMVC<HomeDash> {
  late UserController con;
  _HomeDashState() : super(UserController()) {
    con = controller as UserController;
  }

  alert(BuildContext context, String title) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.grow,
      isButtonVisible: false,
      //  isCloseButton: false,
      //   isOverlayTapDismiss: true,
      descStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 17),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Colors.grey),
      ),
      titleStyle: TextStyle(color: Color(0xffE1CA92), fontSize: 20
          // , fontFamily: "Roboto"
          ),
    );

    return Alert(
      context: context,
      title: "$title",
      style: alertStyle,
      content: Container(
        margin: EdgeInsets.only(top: 10),
        height: MediaQuery.of(context).size.height / 10,
        width: MediaQuery.of(context).size.width,
        child: AutoSizeText(
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
          style: TextStyle(
              // // fontFamily: "Roboto",
              color: Colors.black87),
        ),
      ),
      buttons: [],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(
                            left: 5, right: 5, bottom: 5, top: 5),
                        child: AutoSizeText(
                            '" I am grateful for the resources that continue to show up to help me be a great parent... "',
                            textAlign: TextAlign.center,
                            minFontSize: 32,
                            style: TextStyle(
                                // // fontFamily: "Roboto",
                                fontStyle: FontStyle.italic,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        height: MediaQuery.of(context).size.height / 3.2),
                    SizedBox(height: 10),
                    con.categories.isEmpty
                        ? Text("No Categories")
                        : SizedBox(
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(PageTransition(
                                          curve: Curves.decelerate,
                                          type: PageTransitionType.rightToLeft,
                                          child: CategoryDetails(
                                            userData: widget.userData,
                                            index: index,
                                            title: con.user.value.name! +
                                                "'s " +
                                                con.categories[index].category,
                                          )));
                                    },
                                    child: Container(
                                      color: Color(0xffFAD7A0),
                                      width: MediaQuery.of(context).size.width,
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                              child: con.categories[index].imageURL
                                                      .startsWith("http")
                                                  ? Image.network(
                                                      con.categories[index]
                                                          .imageURL,
                                                      fit: BoxFit.fill,
                                                      height: MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                          2.5,
                                                      width: MediaQuery.of(context)
                                                          .size
                                                          .width)
                                                  : Image.asset(con.images[index],
                                                      fit: BoxFit.fill,
                                                      height: MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                          2.5,
                                                      width: MediaQuery.of(context)
                                                          .size
                                                          .width),
                                            ),
                                          ),
                                          Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    left: 10,
                                                    bottom: 10,
                                                    right: 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5)),
                                                        color:
                                                            Color(0xffFAD7A0),
                                                      ),
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              1.6,
                                                      child: AutoSizeText(
                                                        con.user.value.name! +
                                                            "'s " +
                                                            con
                                                                .categories[
                                                                    index]
                                                                .category,
                                                        minFontSize: 15,
                                                        softWrap: true,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            // // fontFamily: "Roboto",
                                                            color: Colors.brown,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        alert(
                                                            context,
                                                            con.user.value
                                                                    .name! +
                                                                "'s " +
                                                                con
                                                                    .categories[
                                                                        index]
                                                                    .category);
                                                      },
                                                      child: Container(
                                                        child: Icon(
                                                          Icons.info_outline,
                                                          color: Colors.white,
                                                          size: 30,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                itemCount: con.categories.length),
                            height: MediaQuery.of(context).size.height / 1.6),
                    //   SizedBox(
                    //       child: InkWell(
                    //         onTap: () {
                    //           Navigator.of(context).push(PageTransition(
                    //               curve: Curves.decelerate,
                    //               type: PageTransitionType.rightToLeft,
                    //               child: CategoryDetails(
                    //                 userData: widget.userData,
                    //                 index: 0,
                    //                 title: "Tate’s Miindful Pick of the Day",
                    //               )));
                    //         },
                    //         child: Container(
                    //           color: Color(0xffFAD7A0),
                    //           width: MediaQuery.of(context).size.width,
                    //           child: Stack(
                    //             children: [
                    //               Align(
                    //                 alignment: Alignment.centerRight,
                    //                 child: Container(
                    //                   child: Image.asset("assets/images/fav2.jpg",
                    //                       fit: BoxFit.fill,
                    //                       height:
                    //                           MediaQuery.of(context).size.height /
                    //                               2.5,
                    //                       width:
                    //                           MediaQuery.of(context).size.width),
                    //                 ),
                    //               ),
                    //               Align(
                    //                   alignment: Alignment.bottomLeft,
                    //                   child: Container(
                    //                     margin: EdgeInsets.only(
                    //                         left: 10, bottom: 10, right: 10),
                    //                     child: Row(
                    //                       mainAxisAlignment:
                    //                           MainAxisAlignment.spaceBetween,
                    //                       children: [
                    //                         Container(
                    //                           decoration: BoxDecoration(
                    //                             borderRadius: BorderRadius.all(
                    //                                 Radius.circular(5)),
                    //                             color: Color(0xffFAD7A0),
                    //                           ),
                    //                           padding: EdgeInsets.all(5),
                    //                           width: MediaQuery.of(context)
                    //                                   .size
                    //                                   .width /
                    //                               1.6,
                    //                           child: AutoSizeText(
                    //                             "Tate’s Miindful Pick of the Day",
                    //                             minFontSize: 15,
                    //                             softWrap: true,
                    //                             textAlign: TextAlign.center,
                    //                             style: TextStyle(
                    //                                 // // fontFamily: "Roboto",
                    //                                 color: Colors.brown,
                    //                                 fontWeight: FontWeight.bold),
                    //                           ),
                    //                         ),
                    //                         InkWell(
                    //                           onTap: () {
                    //                             alert(context,
                    //                                 "Tate’s Miindful Pick of the Day");
                    //                           },
                    //                           child: Container(
                    //                             child: Icon(
                    //                               Icons.info_outline,
                    //                               color: Colors.white,
                    //                               size: 30,
                    //                             ),
                    //                           ),
                    //                         )
                    //                       ],
                    //                     ),
                    //                   )),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //       height: MediaQuery.of(context).size.height / 4),
                    //   SizedBox(height: 10),
                    //   SizedBox(
                    //       child: InkWell(
                    //         onTap: () {
                    //           Navigator.of(context).push(PageTransition(
                    //               curve: Curves.decelerate,
                    //               type: PageTransitionType.rightToLeft,
                    //               child: CategoryDetails(
                    //                 userData: widget.userData,
                    //                 index: 1,
                    //                 title: "Tate’s Miindful Mantras",
                    //               )));
                    //         },
                    //         child: Container(
                    //           color: Color(0xffFAD7A0),
                    //           width: MediaQuery.of(context).size.width,
                    //           child: Stack(
                    //             children: [
                    //               Align(
                    //                 alignment: Alignment.centerRight,
                    //                 child: Container(
                    //                   child: Image.asset(
                    //                     "assets/images/mantra4.jpg",
                    //                     fit: BoxFit.fill,
                    //                     height:
                    //                         MediaQuery.of(context).size.height /
                    //                             2.5,
                    //                     width: MediaQuery.of(context).size.width,
                    //                   ),
                    //                 ),
                    //               ),
                    //               Align(
                    //                 alignment: Alignment.bottomLeft,
                    //                 child: Container(
                    //                   margin: EdgeInsets.only(
                    //                       left: 10, bottom: 10, right: 10),
                    //                   child: Row(
                    //                     mainAxisAlignment:
                    //                         MainAxisAlignment.spaceBetween,
                    //                     children: [
                    //                       Container(
                    //                         decoration: BoxDecoration(
                    //                           borderRadius: BorderRadius.all(
                    //                               Radius.circular(5)),
                    //                           color: Color(0xffFAD7A0),
                    //                         ),
                    //                         padding: EdgeInsets.all(5),
                    //                         width: MediaQuery.of(context)
                    //                                 .size
                    //                                 .width /
                    //                             1.6777216,
                    //                         child: Text(
                    //                           "Tate’s Miindful Mantras",
                    //                           // minFontSize: 10,
                    //                           softWrap: true,
                    //                           textAlign: TextAlign.center,
                    //                           style: TextStyle(
                    //                               fontSize: 14.4115188075855872,
                    //                               color: Colors.brown,
                    //                               fontWeight: FontWeight.bold),
                    //                         ),
                    //                       ),
                    //                       InkWell(
                    //                         onTap: () {
                    //                           alert(context,
                    //                               "Tate’s Miindful Mantras");
                    //                         },
                    //                         child: Container(
                    //                           child: Icon(
                    //                             Icons.info_outline,
                    //                             color: Colors.white,
                    //                             size: 30,
                    //                           ),
                    //                         ),
                    //                       )
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //       height: MediaQuery.of(context).size.height / 4),
                    //   SizedBox(height: 10),
                    //   SizedBox(
                    //       child: InkWell(
                    //         onTap: () {
                    //           Navigator.of(context).push(PageTransition(
                    //               curve: Curves.decelerate,
                    //               type: PageTransitionType.rightToLeft,
                    //               child: CategoryDetails(
                    //                 userData: widget.userData,
                    //                 index: 2,
                    //                 title: "Tate’s Miindful Adventures",
                    //               )));
                    //         },
                    //         child: Container(
                    //           color: Color(0xffFAD7A0),
                    //           width: MediaQuery.of(context).size.width,
                    //           child: Stack(
                    //             children: [
                    //               Align(
                    //                 alignment: Alignment.centerRight,
                    //                 child: Container(
                    //                   child: Image.asset(
                    //                     "assets/images/adventure4.jpg",
                    //                     fit: BoxFit.fill,
                    //                     height:
                    //                         MediaQuery.of(context).size.height /
                    //                             2.5,
                    //                     width: MediaQuery.of(context).size.width,
                    //                   ),
                    //                 ),
                    //               ),
                    //               Align(
                    //                 alignment: Alignment.bottomLeft,
                    //                 child: Container(
                    //                   margin: EdgeInsets.only(
                    //                       left: 10, bottom: 10, right: 10),
                    //                   child: Row(
                    //                     mainAxisAlignment:
                    //                         MainAxisAlignment.spaceBetween,
                    //                     children: [
                    //                       Container(
                    //                         decoration: BoxDecoration(
                    //                           borderRadius: BorderRadius.all(
                    //                               Radius.circular(5)),
                    //                           color: Color(0xffFAD7A0),
                    //                         ),
                    //                         margin: EdgeInsets.only(
                    //                             left: 5, bottom: 10),
                    //                         padding: EdgeInsets.all(5),
                    //                         width: MediaQuery.of(context)
                    //                                 .size
                    //                                 .width /
                    //                             1.6777216,
                    //                         child: Text(
                    //                           "Tate’s Miindful Adventures",
                    //                           // minFontSize: 10,
                    //                           softWrap: true,
                    //                           textAlign: TextAlign.center,
                    //                           style: TextStyle(
                    //                               fontSize: 14.4115188075855872,
                    //                               color: Colors.brown,
                    //                               fontWeight: FontWeight.bold),
                    //                         ),
                    //                       ),
                    //                       InkWell(
                    //                         onTap: () {
                    //                           alert(context,
                    //                               "Tate’s Miindful Adventures");
                    //                         },
                    //                         child: Container(
                    //                           child: Icon(
                    //                             Icons.info_outline,
                    //                             color: Colors.white,
                    //                             size: 30,
                    //                           ),
                    //                         ),
                    //                       )
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //       height: MediaQuery.of(context).size.height / 4),
                    //   SizedBox(height: 10),
                    //   SizedBox(
                    //       child: InkWell(
                    //         onTap: () {
                    //           Navigator.of(context).push(PageTransition(
                    //               curve: Curves.decelerate,
                    //               type: PageTransitionType.rightToLeft,
                    //               child: CategoryDetails(
                    //                 userData: widget.userData,
                    //                 index: 3,
                    //                 title: "Tate’s Miindful Breathing",
                    //               )));
                    //         },
                    //         child: Container(
                    //           color: Color(0xffFAD7A0),
                    //           width: MediaQuery.of(context).size.width,
                    //           child: Stack(
                    //             children: [
                    //               Align(
                    //                 alignment: Alignment.centerRight,
                    //                 child: Container(
                    //                   child: Image.asset(
                    //                     "assets/images/adventure6.jpg",
                    //                     fit: BoxFit.fill,
                    //                     height:
                    //                         MediaQuery.of(context).size.height /
                    //                             2.5,
                    //                     width: MediaQuery.of(context).size.width,
                    //                   ),
                    //                 ),
                    //               ),
                    //               Align(
                    //                 alignment: Alignment.bottomLeft,
                    //                 child: Container(
                    //                   margin: EdgeInsets.only(
                    //                       left: 10, bottom: 10, right: 10),
                    //                   child: Row(
                    //                     mainAxisAlignment:
                    //                         MainAxisAlignment.spaceBetween,
                    //                     children: [
                    //                       Container(
                    //                         decoration: BoxDecoration(
                    //                           borderRadius: BorderRadius.all(
                    //                               Radius.circular(5)),
                    //                           color: Color(0xffFAD7A0),
                    //                         ),
                    //                         padding: EdgeInsets.all(5),
                    //                         width: MediaQuery.of(context)
                    //                                 .size
                    //                                 .width /
                    //                             2.048,
                    //                         child: AutoSizeText(
                    //                           "Tate’s Miindful Breathing",
                    //                           minFontSize: 12,
                    //                           softWrap: true,
                    //                           textAlign: TextAlign.center,
                    //                           style: TextStyle(
                    //                               // // fontFamily: "Roboto",
                    //                               color: Colors.brown,
                    //                               fontWeight: FontWeight.bold),
                    //                         ),
                    //                       ),
                    //                       InkWell(
                    //                         onTap: () {
                    //                           alert(context,
                    //                               "Tate’s Miindful Breathing");
                    //                         },
                    //                         child: Container(
                    //                           child: Icon(
                    //                             Icons.info_outline,
                    //                             color: Colors.white,
                    //                             size: 30,
                    //                           ),
                    //                         ),
                    //                       )
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //       height: MediaQuery.of(context).size.height / 4),
                    //   SizedBox(height: 10),
                    //   SizedBox(
                    //       child: InkWell(
                    //         onTap: () {
                    //           Navigator.of(context).push(PageTransition(
                    //               curve: Curves.decelerate,
                    //               type: PageTransitionType.rightToLeft,
                    //               child: CategoryDetails(
                    //                 userData: widget.userData,
                    //                 index: 4,
                    //                 title: "Tate’s Miindful Music",
                    //               )));
                    //         },
                    //         child: Container(
                    //           color: Color(0xffFAD7A0),
                    //           width: MediaQuery.of(context).size.width,
                    //           child: Stack(
                    //             children: [
                    //               Align(
                    //                 alignment: Alignment.centerRight,
                    //                 child: Container(
                    //                   child: Image.asset(
                    //                     "assets/images/mountain.jpg",
                    //                     fit: BoxFit.fill,
                    //                     height:
                    //                         MediaQuery.of(context).size.height /
                    //                             2.5,
                    //                     width: MediaQuery.of(context).size.width,
                    //                   ),
                    //                 ),
                    //               ),
                    //               Align(
                    //                 alignment: Alignment.bottomLeft,
                    //                 child: Container(
                    //                   margin: EdgeInsets.only(
                    //                       left: 10, bottom: 10, right: 10),
                    //                   child: Row(
                    //                     mainAxisAlignment:
                    //                         MainAxisAlignment.spaceBetween,
                    //                     children: [
                    //                       Container(
                    //                         decoration: BoxDecoration(
                    //                           borderRadius: BorderRadius.all(
                    //                               Radius.circular(5)),
                    //                           color: Color(0xffFAD7A0),
                    //                         ),
                    //                         padding: EdgeInsets.all(5),
                    //                         width: MediaQuery.of(context)
                    //                                 .size
                    //                                 .width /
                    //                             2.048,
                    //                         child: AutoSizeText(
                    //                           "Tate’s Miindful Music",
                    //                           minFontSize: 12,
                    //                           softWrap: true,
                    //                           textAlign: TextAlign.center,
                    //                           style: TextStyle(
                    //                               // // fontFamily: "Roboto",
                    //                               color: Colors.brown,
                    //                               fontWeight: FontWeight.bold),
                    //                         ),
                    //                       ),
                    //                       InkWell(
                    //                         onTap: () {
                    //                           alert(context,
                    //                               "Tate’s Miindful Music");
                    //                         },
                    //                         child: Container(
                    //                           child: Icon(
                    //                             Icons.info_outline,
                    //                             color: Colors.white,
                    //                             size: 30,
                    //                           ),
                    //                         ),
                    //                       )
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //       height: MediaQuery.of(context).size.height / 4),
                    //   SizedBox(height: 10),
                    //   SizedBox(
                    //       child: InkWell(
                    //         onTap: () {
                    //           Navigator.of(context).push(PageTransition(
                    //               curve: Curves.decelerate,
                    //               type: PageTransitionType.rightToLeft,
                    //               child: CategoryDetails(
                    //                 userData: widget.userData,
                    //                 index: 5,
                    //                 title: "Tate’s Miindful Seasons",
                    //               )));
                    //         },
                    //         child: Container(
                    //           color: Color(0xffFAD7A0),
                    //           width: MediaQuery.of(context).size.width,
                    //           child: Stack(
                    //             children: [
                    //               Align(
                    //                 alignment: Alignment.centerRight,
                    //                 child: Container(
                    //                   child: Image.asset(
                    //                     "assets/images/fiords.jpg",
                    //                     fit: BoxFit.fill,
                    //                     height:
                    //                         MediaQuery.of(context).size.height /
                    //                             2.5,
                    //                     width: MediaQuery.of(context).size.width,
                    //                   ),
                    //                 ),
                    //               ),
                    //               Align(
                    //                 alignment: Alignment.bottomLeft,
                    //                 child: Container(
                    //                   margin: EdgeInsets.only(
                    //                       left: 10, bottom: 10, right: 10),
                    //                   child: Row(
                    //                     mainAxisAlignment:
                    //                         MainAxisAlignment.spaceBetween,
                    //                     children: [
                    //                       Container(
                    //                         decoration: BoxDecoration(
                    //                           borderRadius: BorderRadius.all(
                    //                               Radius.circular(5)),
                    //                           color: Color(0xffFAD7A0),
                    //                         ),
                    //                         padding: EdgeInsets.all(5),
                    //                         width: MediaQuery.of(context)
                    //                                 .size
                    //                                 .width /
                    //                             2.048,
                    //                         child: AutoSizeText(
                    //                           "Tate’s Miindful Seasons",
                    //                           minFontSize: 12,
                    //                           softWrap: true,
                    //                           textAlign: TextAlign.center,
                    //                           style: TextStyle(
                    //                               // // fontFamily: "Roboto",
                    //                               color: Colors.brown,
                    //                               fontWeight: FontWeight.bold),
                    //                         ),
                    //                       ),
                    //                       InkWell(
                    //                         onTap: () {
                    //                           alert(context,
                    //                               "Tate’s Miindful Seasons");
                    //                         },
                    //                         child: Container(
                    //                           child: Icon(
                    //                             Icons.info_outline,
                    //                             color: Colors.white,
                    //                             size: 30,
                    //                           ),
                    //                         ),
                    //                       )
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //       height: MediaQuery.of(context).size.height / 4)
                  ],
                )),
            backgroundColor: Color(0xffFEF2EF)));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    con.waitForCategories();
  }
}
