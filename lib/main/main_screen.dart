import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mental_math/custom/destination_title.dart';
import 'package:mental_math/routes/router.dart';
import 'package:navigation_dot_bar/navigation_dot_bar.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  final double _iconSize = 28.0;

  final double _iconPadding = 20.0;

  final double _barPadding = 10.0;

  final List options = [
    {
      "header": "Add",
      "img": "addition_background.jpg",
      "icon": FontAwesomeIcons.plus
    }, 
    {
      "header": "Subtract",
      "img": "subtraction_background.jpg",
      "icon": FontAwesomeIcons.minus
    }, 
    {
      "header": "Multiply",
      "img": "multiply_background.jpg",
      "icon": FontAwesomeIcons.times
    }, 
    {
      "header": "Divide",
      "img": "divide_background.jpg",
      "icon": FontAwesomeIcons.divide
    }, 
    {
      "header": "Custom",
      "img": "all_background.jpg",
      "icon": Icons.settings
    },    
  ];

  AnimationController _ac;
  ValueNotifier<bool> stateNotifier;
  bool returnFromOptionsPage = false;

  @override
  void initState() { 
    _ac = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    )..addListener((){
      setState((){});
    });

    // ValueNotifier will trigger defined animation according to its updated value
    stateNotifier = ValueNotifier(returnFromOptionsPage)
      ..addListener(() {
        if (stateNotifier.value) {
          _ac.reverse(from: 1.0);
          stateNotifier.value = false;
        }
      });

    super.initState();
  }

  Widget _buildIcon( dynamic _icon, BuildContext _context) {
    var test = options[0];
    var header = test["header"];
    var img = 'addition_background.jpg';
    return _icon.runtimeType == IconData ? 
    Padding(
      padding: EdgeInsets.symmetric(horizontal: _iconPadding),
      child: GestureDetector(
        child: Icon(_icon, color: Colors.black, size: _iconSize),
        onTap: () async {
          _ac.forward(from: 0.0);
          router.navigateTo(_context, "/settings/$header/$img", 
            transitionDuration: const Duration(milliseconds: 500));

        })
    ) : Padding(
      padding: EdgeInsets.only(left: _iconPadding-1.35, top: _iconPadding-6),
      child: GestureDetector(
        child: AnimatedIcon(icon: _icon, progress: _ac, color: Colors.black,size: _iconSize),
        onTap: (){
          _ac.forward(from: 0.0);
          router.navigateTo(_context, "/settings/$header/$img", 
            transitionDuration: const Duration(milliseconds: 1000));
        })
    );
  }

  Widget _buildListItem(Map data, BuildContext _context) {
    String header = data["header"];
    String img = data["img"];
    return Container(
      width: 100,
      height: 70,
      child: Stack(
        children: <Widget>[
          Row( children: <Widget>[
            Expanded(flex: 3, child: Container()),
            Expanded(flex: 5, child: Hero(
              tag: header + "_img",
              child: Image(
                image: AssetImage("assets/images/" + img),
                fit: BoxFit.cover))
            ),
            Hero( tag: header + "_icon", child: GestureDetector(
              onTap: () async {
                _ac.forward(from: 0.0);
                stateNotifier.value = await router.navigateTo(context, "/settings/$header/$img", 
                  transitionDuration: const Duration(milliseconds: 1000));
              },
              child: Container( height: 70, width: 70,
                child: Icon(data["icon"], size: _iconSize, color: Colors.white),
                color: Colors.black),
            ))
          ]),
          
          Row( children: <Widget>[
            Expanded(flex: 3, child: Hero( tag: header,
              // Customized your own flightShuttleBuilder
              flightShuttleBuilder: (_, __, flightDirection, ___, ____) {
                  return DestinationTitle(
                    title: header,
                    isOverflow: true,
                    viewState: flightDirection == HeroFlightDirection.push
                        ? ViewState.enlarge
                        : ViewState.shrink,
                    smallFontSize: 20.0,
                    largeFontSize: 40.0,
                  );
                },
        // use a ViewState that define static widget when it's not supposed to animate
              child: DestinationTitle(
                title: header,
                viewState: ViewState.shrunk,
              ))),
            Expanded(flex: 6, child: Container()),
            Container(height: 70, width: 70)
          ]),  
      ])
    );
  }

  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height;
    double maxWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFFF2F7FB),
        elevation: 0.5,
        iconTheme: IconThemeData(color: Colors.black),
        // leading: _buildIcon(AnimatedIcons.menu_home, context),
        // actions: <Widget>[
        //   _buildIcon(Icons.search, context)
        // ],
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader( child: Text('Profile'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile( title: Text('Item 1'),
              onTap: () { Navigator.pop(context); },
            ),
            ListTile( title: Text('Item 2'),
              onTap: () { Navigator.pop(context); },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationDotBar(
        items: [
          BottomNavigationDotBarItem(
            icon: FontAwesomeIcons.brain,
            onTap: () {}
          ),
          BottomNavigationDotBarItem(
            icon: FontAwesomeIcons.chartBar,
            onTap: () {}
          ),
          BottomNavigationDotBarItem(
            icon: FontAwesomeIcons.clipboardList,
            onTap: () {}
          ),
        ]),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 15.0, bottom: _barPadding ),
            child: Row(children: <Widget>[
              Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Container(height: 2.5, width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        color: Colors.black38,
                      ),
                  ),
                ),
                Expanded(
                  child: Hero(
                    tag: "title",
                  // Customized your own flightShuttleBuilder
                    flightShuttleBuilder: (_,__, flightDirection, ___, ____) {
                      return DestinationTitle( title: "Game Type", smallFontSize: 20.0, largeFontSize: 30.0,
                        viewState: flightDirection == HeroFlightDirection.push ? 
                          ViewState.shrink : ViewState.enlarge,
                      );
                    },
                  // use a ViewState that define static widget when it's not supposed to animate
                    child: Text("Game Type", style: TextStyle(fontSize: 30.0)) 
                  ),
                )
              ]),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              height: maxHeight - 211.0,
              width: maxWidth,
              child: ListView.separated(
                itemCount: options.length,
                itemBuilder: (context, int) => _buildListItem(options[int], context),
                separatorBuilder: (context, _ ) => Padding(padding: EdgeInsets.all(10),),
              ),
            ),
          )
        ],
      )
    );
  }
}