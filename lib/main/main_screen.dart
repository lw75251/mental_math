import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:mental_math/custom/fade_page_route.dart';
import 'package:mental_math/routes/router.dart';

class MainScreen extends StatelessWidget {
  final double _iconSize = 28.0;
  final double _iconPadding = 20.0;
  final double _barPadding = 4.0;

  final List options = [
    {
      "header": "Addition",
      "img": AssetImage('assets/images/addition_background.jpg'),
    }, 
    {
      "header": "Subtraction",
      "img": AssetImage('assets/images/subtraction_background.jpg'),
    }, 
    {
      "header": "Multiplication",
      "img": AssetImage('assets/images/multiply_background.jpg'),
    }, 
    {
      "header": "Division",
      "img": AssetImage('assets/images/divide_background.jpg'),
    }, 
    {
      "header": "Custom",
      "img": AssetImage('assets/images/all_background.jpg'),
    },    
  ];

  Widget _buildIcon( IconData _icon, BuildContext _context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _iconPadding),
      child: GestureDetector(
        child: Icon(_icon, color: Colors.black, size: _iconSize),
        onTap: (){
          router.navigateTo(_context, welcomeRoute);
        })
    );
  }

  Widget _buildListItem(Map data) {
    return Container(
      width: 100,
      height: 50,
      child: Row(children: <Widget>[
        Expanded(flex: 3, child: Text(data["header"], 
          style: TextStyle(color: Colors.black, ),)),
        Expanded(flex: 6, child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: data["img"]
            )))
        ),
        IconButton(icon: Icon(Icons.settings, size: _iconSize,), onPressed: (){},)
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
        leading: _buildIcon(Icons.menu, context),
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
                separatorBuilder: (context, _ ) => Padding(padding: EdgeInsets.all(15),),
              ),
            ),
          )
        ],
      )
    );
  }
}