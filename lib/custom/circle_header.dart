import 'package:flutter/material.dart';

class HalfCircle extends StatelessWidget {
  Widget child;

  HalfCircle({this.child});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      child: child,
      clipper: HalfCircleClipper(),
    );
  }
}

class HalfCircleClipper extends CustomClipper<Path> {
  HalfCircleClipper();

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height-100);
    path.quadraticBezierTo( size.width / 6, size.height, size.width / 2, size.height);
    path.quadraticBezierTo( size.width - (size.width / 6), size.height, 
      size.width, size.height-100);    
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }

}