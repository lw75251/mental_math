import 'dart:math';

import 'package:flutter/material.dart';

class Timer extends StatefulWidget {
  Timer({Key key}) : super(key: key);

  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> with TickerProviderStateMixin{
  AnimationController controller;
  
  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds%60).toString().padLeft(2,'0')}';
  }
  
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(minutes: 2)
    );

    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return new CustomPaint(
                painter: TimerPainter(
                  animation: controller,
                  backgroundColor: Colors.black,
                  color: Colors.pink
                ),
              );
            },
          )
        ),

        Align(
          alignment: FractionalOffset.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              AnimatedBuilder(animation: controller,
                builder: (context, child) {
                  return new Text(timerString,
                    style: TextStyle(fontSize: 25),
                  );
                },
              )
          ]),
        )
      ],
    );
  }
}


class TimerPainter extends CustomPainter {

  final Animation<double> animation;
  final Color backgroundColor, color;

  TimerPainter({
    this.animation,
    this.backgroundColor,
    this.color
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTRB(50, 100, 250, 200);
    final startAngle = -pi;
    final sweepAngle = pi;
    final useCenter = false;
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }


}