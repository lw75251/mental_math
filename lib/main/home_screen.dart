import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mental_math/custom/bottom_nav_bar_dot.dart';
import 'package:mental_math/custom/panel.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _selectedIndex = 0;
  BorderRadiusGeometry radius = BorderRadius.only(
    topLeft: Radius.circular(50), 
    topRight: Radius.circular(50)
  );

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          SlidingUpPanel(
            maxHeight: MediaQuery.of(context).size.height,
            panel: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(color: Color(0xFFEEE)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  // Expanded(
                  //   child: Container(decoration: const BoxDecoration(color: Colors.red),),
                  //   flex: 6,
                  // ),
                  // Expanded(
                  //   child: Container(decoration: const BoxDecoration(color: Colors.green)),
                  //   flex: 2,
                  // )
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,

                  )
                ],
              )
            ),
            collapsed: Container(
                decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: radius
              ),
              child: Center(
                child: Text(
                  "This is the collapsed Widget",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            body: Center(
                child: Text("This is the Widget behind the sliding panel"),
              ),
            borderRadius: radius,
            bottomNavigationBar: BottomNavigationDotBar(
              padding: 10,
              items: [
                BottomNavigationDotBarItem(
                  icon: FontAwesomeIcons.brain,
                  onTap: () {
                    _onItemTapped(0);
                  }
                ),
                BottomNavigationDotBarItem(
                  icon: FontAwesomeIcons.chartBar,
                  onTap: () {
                    _onItemTapped(1);
                  }
                ),
                BottomNavigationDotBarItem(
                  icon: FontAwesomeIcons.user,
                  onTap: () {
                    _onItemTapped(2);
                  }
                ),
              ],
            ),
          ),
        ],
      ),
    );

    // return Material(
    //   child: SlidingUpPanel(
    //     maxHeight: MediaQuery.of(context).size.height,
    //     panel: Scaffold(
    //       body: Container(
    //         width: MediaQuery.of(context).size.width,
    //         decoration: BoxDecoration(color: Color(0xFFEEE)),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.end,
    //             children: <Widget>[
    //               Expanded(
    //                 child: Container(
    //                   decoration: const BoxDecoration(color: Colors.red),
    //                 ),
    //                 flex: 6,
    //               ),
    //               Expanded(
    //                 child: Container(
    //                   decoration: const BoxDecoration(color: Colors.green),
    //                 ),
    //                 flex: 2,
    //               )
    //             ],
    //         )
    //       ),
    //       bottomNavigationBar: BottomNavigationDotBar(
    //         padding: 10,
    //         items: [
    //           BottomNavigationDotBarItem(
    //             icon: FontAwesomeIcons.brain,
    //             onTap: () {
    //               _onItemTapped(0);
    //             }
    //           ),
    //           BottomNavigationDotBarItem(
    //             icon: FontAwesomeIcons.chartBar,
    //             onTap: () {
    //               _onItemTapped(1);
    //             }
    //           ),
    //           BottomNavigationDotBarItem(
    //             icon: FontAwesomeIcons.user,
    //             onTap: () {
    //               _onItemTapped(2);
    //             }
    //           ),
    //         ],
    //       ),
    //     ),
    //     collapsed: Container(
    //       decoration: BoxDecoration(
    //         color: Colors.blueGrey,
    //         borderRadius: radius
    //       ),
    //       child: Center(
    //         child: Text(
    //           "This is the collapsed Widget",
    //           style: TextStyle(color: Colors.white),
    //         ),
    //       ),
    //     ),
    //     body: Center(
    //       child: Text("This is the Widget behind the sliding panel"),
    //     ),
    //     borderRadius: radius,
    //   ),
    // );
  }
}