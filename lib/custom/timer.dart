import 'dart:math';

import 'package:flutter/material.dart';

class CountDown extends StatefulWidget {
  CountDown({Key key}) : super(key: key);

  _CountDownState createState() => _CountDownState();
}

class _CountDownState extends State<CountDown> with TickerProviderStateMixin{
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
                  return Text(timerString,
                    style: TextStyle(fontSize: 20, color: Colors.white),
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
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0
      .. style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 4.0, paint);
    paint.color = color;

    double progress = (1.0 - animation.value) * 2 * pi;
    canvas.drawArc(Offset(27.5,27.5) & size/2, pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    return animation.value != old.animation.value || 
      color != old.color ||
      backgroundColor != old.backgroundColor;
  }

}