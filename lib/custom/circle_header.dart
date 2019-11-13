import 'dart:math';

import 'package:flutter/material.dart';

class HalfCircle extends StatelessWidget {
  final Widget child;
  const HalfCircle({this.child, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      child: child,
      clipper: HalfCircleClipper(),
    );
  }
}

// class HalfCircle extends StatefulWidget {
//   Widget child;

//   HalfCircle({this.child});

//   @override
//   _HalfCircleState createState() => _HalfCircleState();
// }

// class _HalfCircleState extends State<HalfCircle> with TickerProviderStateMixin {
//   AnimationController controller;

//   @override
//   void initState() {
//     controller = AnimationController(
//       vsync: this,
//       duration: Duration(minutes: 2)
//     );

//     controller.forward();
//     super.initState();
//   }
  
//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {

//     return Stack(children: <Widget>[
//       Positioned.fill(
//         child: AnimatedBuilder(
//           animation: controller,
//           builder: (context, child) {
//             return new CustomPaint(
//               painter: HalfCircleTimerPainter(
//                 animation: controller,
//                 backgroundColor: Colors.black,
//                 color: Colors.white
//               ),
//             );
//           },
//         ),
//       )

//     ]);


//   }
// }

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

class HalfCircleTimerPainter extends CustomPainter {

  final Animation<double> animation;
  final Color backgroundColor, color;

  HalfCircleTimerPainter({
    this.animation,
    this.backgroundColor,
    this.color
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {

    final radius = min(size.width, size.height)/2;
    final center = Offset(size.width/2, size.height/2);

    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0
      .. style = PaintingStyle.stroke;

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius/2), 0, pi, false, paint);
    paint.color = color;

    double progress = (1.0 - animation.value);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius/2), 0, -progress, false, paint);
  }

  @override
  bool shouldRepaint(HalfCircleTimerPainter old) {
    return animation.value != old.animation.value || 
      color != old.color ||
      backgroundColor != old.backgroundColor;
  }

}