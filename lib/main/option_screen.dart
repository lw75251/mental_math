import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mental_math/routes/router.dart';

class OptionScreen extends StatefulWidget {
  final Map gameData;
  const OptionScreen(
    this.gameData,
    {Key key}) : super(key: key);

  @override
  _OptionScreenState createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {
  final double _iconSize = 28.0;
  final double _iconPadding = 20.0;
  final double _barPadding = 4.0;

  Widget _buildIcon( IconData _icon, BuildContext _context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _iconPadding),
      child: GestureDetector(
        child: Icon(_icon, color: Colors.black, size: _iconSize),
        onTap: (){
          router.navigateTo(_context, welcomeRoute, 
            transitionDuration: const Duration(milliseconds: 500));
        })
    );
  }

  Widget _buildOptions() {
    final Map _gameData = widget.gameData;
    String img = _gameData["img"];

    return Padding(padding: EdgeInsets.only(top: 15.0, right: _barPadding, bottom: _barPadding ),
          child: Column(children: <Widget>[
            Row(children: <Widget>[
              Container(height: 2.5, width: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  color: Colors.black38,
                ),
              ),
              Icon(FontAwesomeIcons.sun, size: _iconSize),
              Text("Game Type", style: TextStyle(fontSize: 20.0),)
            ]),
            Hero(
              tag: _gameData["header"]+"_img",
              child: Image(image:AssetImage("assets/images/$img"),width: 200.0, height: 200.0,))
          ]),
    );
  }

  Widget _buildButtons(){
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height;
    double maxWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFFF2F7FB),
        elevation: 0.5,
        leading: _buildIcon(Icons.arrow_back, context),
        actions: <Widget>[
          _buildIcon(Icons.search, context)
        ],
      ),

      body: Stack(children: <Widget>[
            _buildOptions(),
            _buildButtons()
          ])
    );
  }
}