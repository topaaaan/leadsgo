import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  Color color;
  Background({Key key, @required this.child, @required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: color,
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          child,
        ],
      ),
    );
  }
}
