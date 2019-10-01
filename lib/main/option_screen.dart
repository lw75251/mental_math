import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mental_math/custom/destination_title.dart';
import 'package:mental_math/routes/router.dart';

class OptionScreen extends StatefulWidget {
  final Map gameData;
  const OptionScreen(
    this.gameData,
    {Key key}) : super(key: key);

  @override
  _OptionScreenState createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> with SingleTickerProviderStateMixin {
  
  final double _iconSize = 28.0;
  final double _iconPadding = 20.0;
  final double _barPadding = 4.0;
  
  final Map iconMap = {
    "Addition": FontAwesomeIcons.plus,
    "Subtraction": FontAwesomeIcons.minus,
    "Multiplication": FontAwesomeIcons.times,
    "Division": FontAwesomeIcons.divide,
    "Custom": FontAwesomeIcons.question
  };

  Widget _buildIcon( IconData _icon, BuildContext _context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _iconPadding-1.2),
      child: GestureDetector(
        child: Icon(_icon, color: Colors.black, size: _iconSize),
        onTap: (){
          router.pop(context);
        })
    );
  }

  Widget _buildLayout() {
    final Map _gameData = widget.gameData;
    String img = _gameData["img"];

    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;

    return Padding(padding: EdgeInsets.only(top: 15.0, right: _barPadding, bottom: _barPadding ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, 
            crossAxisAlignment: CrossAxisAlignment.start,

            children: <Widget>[
              Row(children: <Widget>[
                Container(height: 2.5, width: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    color: Colors.black38,
                  ),
                ),
                Icon(FontAwesomeIcons.sun, size: _iconSize),
                Text(" Game Type", style: TextStyle(fontSize: 20.0),)
              ]),
              Hero(
                tag: _gameData["header"] + "_img",
                child: Image(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/$img"), 
                  width: 8*maxWidth/9, 
                  height: 300.0,))
            ]),
    );
  }

  Widget _buildSettings() {
    final Map _gameData = widget.gameData;
    final String header = _gameData["header"];
    // return Hero( tag: header,
    //   child: Text(header, 
    //   style: TextStyle(color: Colors.black))
    // );
    return Align(
      alignment: FractionalOffset(1,1),
      child: Hero(
        tag: header,
      // Customized your own flightShuttleBuilder
        flightShuttleBuilder: (
          BuildContext flightContext,
          Animation<double> animation,
          HeroFlightDirection flightDirection,
          BuildContext fromHeroContext,
          BuildContext toHeroContext,
        ) {
          return DestinationTitle(
            title: header,
            isOverflow: true,
            viewState: flightDirection == HeroFlightDirection.pop
                ? ViewState.enlarge
                : ViewState.shrink,
            smallFontSize: 20.0,
            largeFontSize: 40.0,
          );
        },
      // use a ViewState that define static widget when it's not supposed to animate
        child: DestinationTitle(
          title: header,
          smallFontSize: 30.0,
          largeFontSize: 42.0,
          viewState: ViewState.shrunk,
        ),
      ),
    );
  }

  // TODO: Implement Buttons
  Widget _buildButtons(){
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;
    final Map _gameData = widget.gameData;
    return Align(
      alignment: FractionalOffset(7.8/9,0.01),
      child: Hero(
        tag: _gameData["header"] + "_icon",
        child: Container(
          height: 70,
          width: 70,
          child: Icon(iconMap[_gameData["header"]], size: _iconSize, color: Colors.white,),
          color: Colors.black,
        )),
    );
  }

  @override
  Widget build(BuildContext context) {
    // double maxHeight = MediaQuery.of(context).size.height;
    // double maxWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop(true);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0XFFF2F7FB),
          elevation: 0.5,
          leading: _buildIcon(Icons.arrow_back, context),
          actions: <Widget>[
            _buildIcon(Icons.search, context)
          ],
        ),

        body: Stack(children: <Widget>[
              _buildLayout(),
              _buildButtons(),
              _buildSettings()
            ])
      )
    ); 
  }
}