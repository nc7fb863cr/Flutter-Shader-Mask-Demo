import 'package:flutter/material.dart';

const TWO_PI = 3.14 * 2;
const INDENT = 40.0;

class MainScreen extends StatelessWidget {
  Widget _buildCircle(BuildContext context, double value, Widget child) {
    final size = MediaQuery.of(context).size.width * .6;
    final percentage = (value * 100).ceil();

    return Container(
      width: size,
      height: size,
      child: Stack(
        children: [
          ShaderMask(
            shaderCallback: (Rect rect) {
              return SweepGradient(
                startAngle: 0.0,
                endAngle: TWO_PI,
                stops: [value, value],
                center: Alignment.center,
                colors: [Colors.blue, Colors.grey.withAlpha(55)],
              ).createShader(rect);
            },
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, image: DecorationImage(image: AssetImage('assets/radial_scale.png'))),
            ),
          ),
          Center(
            child: Container(
              width: size - INDENT,
              height: size - INDENT,
              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              child: Center(child: Text("$percentage", style: TextStyle(fontSize: 32))),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Progress Indicator")),
      body: Center(
        child: TweenAnimationBuilder(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: Duration(seconds: 2),
          builder: _buildCircle,
        ),
      ),
    );
  }
}
