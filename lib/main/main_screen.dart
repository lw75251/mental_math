import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mental_math/routes/router.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  final double _iconSize = 28.0;

  final double _iconPadding = 20.0;

  final double _barPadding = 4.0;

  final List options = [
    {
      "header": "Addition",
      "img": AssetImage('assets/images/addition_background.jpg'),
      "icon": FontAwesomeIcons.plus
    }, 
    {
      "header": "Subtraction",
      "img": AssetImage('assets/images/subtraction_background.jpg'),
      "icon": FontAwesomeIcons.minus
    }, 
    {
      "header": "Multiplication",
      "img": AssetImage('assets/images/multiply_background.jpg'),
      "icon": FontAwesomeIcons.times
    }, 
    {
      "header": "Division",
      "img": AssetImage('assets/images/divide_background.jpg'),
      "icon": FontAwesomeIcons.divide
    }, 
    {
      "header": "Custom",
      "img": AssetImage('assets/images/all_background.jpg'),
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

  Widget _buildListItem(Map data) {
    return Container(
      width: 100,
      height: 70,
      child: Row(children: <Widget>[
        Expanded(flex: 3, child: Hero(
          tag: data["header"],
          child: Text(data["header"], 
          style: TextStyle(color: Colors.black)),
        )),
        Expanded(flex: 6, child: Hero(
          tag: data["header"] + "_img",
          child: Image(image: data["img"], fit: BoxFit.cover,))
        ),
        Hero(
            tag: data["header"] + "_icon",
            child: Container(
              height: 70,
              width: 70,
              child: Icon(data["icon"], size: _iconSize, color: Colors.white,),
              color: Colors.black,
            )),
      ],),
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
        leading: _buildIcon(AnimatedIcons.menu_arrow, context),
        actions: <Widget>[
          _buildIcon(Icons.search, context)
        ],
      ),

      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 15.0, right: _barPadding, bottom: _barPadding ),
            child: Row(children: <Widget>[
                Container(height: 2.5, width: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    color: Colors.black38,
                  ),
                ),
              Text("Game Type")
            ],),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              height: maxHeight - 116.0,
              width: maxWidth,
              child: ListView.separated(
                itemCount: options.length,
                itemBuilder: (context, int) => _buildListItem(options[int]),
                separatorBuilder: (context, _ ) => Padding(padding: EdgeInsets.all(10),),
              ),
            ),
          )
        ],
      )
    );
  }
}