import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:panja/screens/stockscreens/app.dart';
import 'package:panja/screens/stockscreens/homepage.dart';
import 'package:panja/screens/prediction.dart';
import 'package:panja/screens/similar.dart';

import 'add.dart';

List<Widget> navitems = [
  MyApp(),
  Prediction(),
  SimilarStocks(),
];
int index = 0;

class NavBar extends StatefulWidget {
  NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  void initState() {
    setState(() {
      index = 0;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff10151E),
      body: navitems[index],
      bottomNavigationBar: GNav(
          // tab button ripple color when pressed
          // tab button hover color
          haptic: true, // haptic feedback
          tabBorderRadius: 18,
          tabMargin: EdgeInsets.fromLTRB(10, 10, 10, 20),
          tabActiveBorder:
              Border.all(color: Colors.black, width: 0), // tab button border
          tabBorder:
              Border.all(color: Colors.grey, width: 0), // tab button border
          // tab button shadow
          curve: Curves.easeIn, // tab animation curves
          duration: Duration(milliseconds: 400), // tab animation duration
          gap: 8, // the tab button gap between icon and text
          color: Colors.grey[800], // unselected icon color
          activeColor:
              Colors.white.withOpacity(0.6), // selected icon and text color
          iconSize: 24, // tab button icon size
          tabBackgroundColor: Color(0xff144D79)
              .withOpacity(0.5), // selected tab background color
          padding: EdgeInsets.symmetric(
              horizontal: 20, vertical: 5), // navigation bar padding
          tabs: [
            GButton(
              onPressed: () {
                setState(() {
                  index = 0;
                });
              },
              icon: LineIcons.home,
              text: 'Home',
            ),
            GButton(
              onPressed: () {
                setState(() {
                  index = 1;
                });
              },
              icon: LineIcons.barChart,
              text: 'Prediction',
            ),
            GButton(
              onPressed: () {
                setState(() {
                  index = 2;
                });
              },
              icon: LineIcons.sortAmountDown,
              text: 'Similar Stocks',
            ),
            // GButton(
            //   onPressed: () {
            //     setState(() {
            //       index = 3;
            //     });
            //   },
            //   icon: LineIcons.addToShoppingCart,
            //   text: 'Add details',
            // ),
          ]),
    );
  }
}
