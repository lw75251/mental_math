import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mental_math/custom/bottom_nav_bar_dot.dart';
import 'package:mental_math/custom/panel.dart';
import 'package:mental_math/main/game_settings.dart';

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
            // isDraggable: false,
            maxHeight: MediaQuery.of(context).size.height,
            sideBarColor: Color(0xFFEAEEF9),
            panel: Container(decoration: const BoxDecoration(color: Color(0XFFF2F7FB))),
            body: GameSettingScreen(),
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
  }
}