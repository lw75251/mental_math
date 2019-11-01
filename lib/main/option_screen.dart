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
  final double _barPadding = 10.0;
  AnimationController _ac;

  final Map<String, bool> focus = {
    "Easy": true,
    "Medium": false,
    "Hard": false,
  };

  // Represents Easy, Medium, Hard
  var isSelected = [true, false , false];
  // Represents Active Dificulty
  int activeIndex = 0;
  // Represents Practice Mode
  bool practice = false;

  @override
  void initState() {
    _ac = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..addListener((){
      setState((){});
    });

    _ac.forward();
    super.initState();
  }

  final Map iconMap = {
    "Add": FontAwesomeIcons.plus,
    "Subtract": FontAwesomeIcons.minus,
    "Multiply": FontAwesomeIcons.times,
    "Divide": FontAwesomeIcons.divide,
    "Custom": FontAwesomeIcons.question
  };

  Widget _buildIcon( IconData _icon, BuildContext _context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _iconPadding-1.2),
      child: GestureDetector(
        child: Icon(_icon, color: Colors.black, size: _iconSize),
        onTap: (){
          _ac.reverse();
          Navigator.of(context).pop(true);
          return Future.value(false);          
        })
    );
  }

  Widget _buildLayout() {
  return Column( crossAxisAlignment: CrossAxisAlignment.start, 
    children: <Widget>[
      Padding(padding: EdgeInsets.only(top: 15.0, bottom: 10.0 ),
        child: Container(
          height: 36,
          child: Row(children: <Widget>[
              Container(height: 2.5, width: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  color: Colors.black38,
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Icon(FontAwesomeIcons.sun, size: _ac.value * 20),
              ),
              Hero(
                tag: "title",
              // Customized your own flightShuttleBuilder
                flightShuttleBuilder: (_,__, flightDirection, ___, ____) {
                  return DestinationTitle( title: "Game Type", smallFontSize: 20.0, largeFontSize: 30.0,
                    viewState: flightDirection == HeroFlightDirection.pop ? 
                      ViewState.enlarge : ViewState.shrink,
                  );
                },
              // use a ViewState that define static widget when it's not supposed to animate
                child: Text("Game Type", style: TextStyle(fontSize: 20.0)) 
              )
            ]),
        ),
      ),

      _buildImage()
    ]);
  }

  Widget _buildImage() {
    final Map _gameData = widget.gameData;
    double maxWidth = MediaQuery.of(context).size.width;
    String img = _gameData["img"];
    return Hero(
      tag: _gameData["header"] + "_img",
      child: Image(
        fit: BoxFit.cover,
        image: AssetImage("assets/images/$img"), 
        width: 8*maxWidth/9, 
        height: 300.0,));
  }

  Widget _buildButtons() {

    return ToggleButtons(
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.black26,
      selectedColor: Colors.blue,
      children: <Widget>[
        Text("Easy"),
        Text("Medium"),
        Text("Hard")
      ],
      isSelected: isSelected,
      onPressed: (int index) {
        setState(() {
          for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
            if (buttonIndex == index) {
              isSelected[buttonIndex] = true;
              activeIndex = index;
            } else {
              isSelected[buttonIndex] = false;
            }
          }
        });
      },
    );

    // Color _color = focus[text] ? Colors.lightBlueAccent : Colors.black26;
    // return Padding(
    //   padding: const EdgeInsets.all(8.0),
    //   child: MaterialButton(child: Text(text, 
    //     style: TextStyle(
    //       color: Colors.white
    //     )),
    //     elevation: 5,
    //     onPressed:(){
    //       setState(() {
    //         focus.forEach((_, bool val){ val = !val;});
    //       });
    //     },
    //     height: 42,
    //     color: _color,
    //     shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
    //   ),
    // );
  }


  Widget _buildContent() {
    final Map _gameData = widget.gameData;
    final String header = _gameData["header"];

    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;

    return Positioned(
      top: maxHeight/2.32,
      left: maxWidth/17,
      child: Container(
        width: maxWidth*14/17,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Hero(
            tag: header,
          // Customized your own flightShuttleBuilder
            flightShuttleBuilder: (_,__, flightDirection, ___, ____) {
              return DestinationTitle( title: header, smallFontSize: 20.0, largeFontSize: 40.0,
                viewState: flightDirection == HeroFlightDirection.pop ? 
                  ViewState.shrink : ViewState.enlarge,
              );
            },
          // use a ViewState that define static widget when it's not supposed to animate
            child: Text(header, style: TextStyle(fontSize: 40.0)) 
          ),
          Row(mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text("Practice Mode"),
            Switch(activeColor: Colors.blueAccent, value: practice,
              onChanged: (bool){
                setState(() {practice = bool;});
              }
            )
            ]),         
          Align(child: _buildButtons()),
          Center(
            child: MaterialButton(child: Text("Start"),color: Colors.blueAccent,
              onPressed: (){
                router.navigateTo(context, "/game/$header/$activeIndex", 
                  transitionDuration: const Duration(milliseconds: 500));
              },
            ),
          )

        ]),
      )
    );
  }

  // TODO: Implement Buttons
  Widget _buildIndicator(){
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

  Widget _buildHeros() {
    return Stack(
      children: <Widget>[
        _buildIndicator(),
        _buildContent()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // double maxHeight = MediaQuery.of(context).size.height;
    // double maxWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0XFFF2F7FB),
          elevation: 0.5,
          leading: _buildIcon(Icons.home, context),
          actions: <Widget>[
            _buildIcon(Icons.search, context)
          ],
        ),

        body: Stack(children: <Widget>[
              _buildLayout(),
              _buildHeros(),
            ])
    ); 
  }
}