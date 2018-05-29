import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class ImageWidget extends StatefulWidget {
  @override
  _ImageWidgetState createState() => new _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  initState() {
    super.initState();
    controller = new AnimationController(
      duration: const Duration(milliseconds: 5000), vsync: this);
    animation = new CurvedAnimation(parent: controller, curve: Curves.easeIn);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });

    controller.forward();
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return new AnimatedImageWidget(animation: animation);
  }
}

class AnimatedImageWidget extends AnimatedWidget {
  static final _opacityTween = new Tween<double>(begin: 1.0, end: 0.4);

  AnimatedImageWidget({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return new Center(
      child: new Opacity(
        opacity: _opacityTween.evaluate(animation),
        child: new Container(
          child: new Image.asset(
            'images/home.jpg',
            width: 700.0,
            height: 320.0,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}