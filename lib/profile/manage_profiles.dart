import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:miindfully/models/user_model.dart';
import 'package:miindfully/profile/add_profile.dart';
import 'package:miindfully/profile/profile.dart';
import 'package:page_transition/page_transition.dart';
import 'package:string_extensions/string_extensions.dart';

class ManageProfiles extends StatefulWidget {
  final String? call;

  const ManageProfiles({Key? key, this.call}) : super(key: key);

  @override
  _ManageProfilesState createState() => _ManageProfilesState();
}

class _ManageProfilesState extends State<ManageProfiles> {
  UserModel? childDetails;

  @override
  void initState() {
    fetchChildDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            leading: Builder(
              builder: (BuildContext context) {
                return widget.call != null
                    ? Container()
                    : IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      );
              },
            ),
            backgroundColor: Color(0xffFAD7A0),
            foregroundColor: Colors.brown,
            elevation: 1.0,
            title: Text("Manage Profiles")),
        body: Container(
          color: Color(0xffFEF2EF),
          padding: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: childDetails != null
                ? MainAxisAlignment.start
                : MainAxisAlignment.center,
            children: [
              Visibility(
                  visible: childDetails != null ? true : false,
                  child: Expanded(
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Container(
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(PageTransition(
                                    curve: Curves.decelerate,
                                    type: PageTransitionType.rightToLeft,
                                    child: Profile(
                                      userData: childDetails,
                                      fetchChildData: fetchChildData,
                                    )));
                              },
                              child: Container(
                                child: Row(
                                  children: [
                                    childDetails != null &&
                                            childDetails!.image != ""
                                        ? Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle),
                                            child: Image.asset(
                                              "${childDetails?.image}",
                                              height: 50,
                                            ),
                                          )
                                        : Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle),
                                            child: Image.asset(
                                              "assets/images/profile.png",
                                              height: 50,
                                            ),
                                          ),
                                    Flexible(
                                      child: Container(
                                        margin: EdgeInsets.only(left: 20),
                                        child: AutoSizeText(
                                          "${childDetails != null ? (childDetails!.name)!.toTitleCase() : ""}",
                                          minFontSize: 18,
                                          style: TextStyle(
                                              // // fontFamily: "Roboto",
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(PageTransition(
                      curve: Curves.decelerate,
                      type: PageTransitionType.rightToLeft,
                      child: AddProfile(fetchChildData: fetchChildData)));
                },
                child: Container(
                  height: MediaQuery.of(context).size.height / 14,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color(0xffE1CA92),
                    borderRadius: BorderRadius.all(Radius.circular(
                      5.0,
                    )),
                  ),
                  margin:
                      EdgeInsets.only(top: 50, bottom: 5, left: 15, right: 15),
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    "Add Profile",
                    style: TextStyle(
                        // // fontFamily: "Roboto",
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void fetchChildDetails() async {
    UserModel? data = await UserModel.readStringPref(UserModel.prefChildData);
    setState(() {
      childDetails = data;
    });
  }

  void fetchChildData() async {
    UserModel? data = await UserModel.readStringPref(UserModel.prefChildData);
    setState(() {
      childDetails = data;
    });
  }
}
