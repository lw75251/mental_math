
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mental_math/routes/router.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  MyApp(){
    Routes.defineRoutes(router);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Flutter Demo',

      // *THEME 
      theme: ThemeData(
        primaryColor: Color(0xFF2B2B33),
        accentColor: Colors.white,
        fontFamily: 'Varela',
        textTheme: TextTheme(
          body1: TextStyle(fontSize: 14.0, fontFamily: 'Montserrat'),
        ),
      ),

      // *ROUTES 
      initialRoute: loginRoute,
      onGenerateRoute: router.generator,
    );
  }
}