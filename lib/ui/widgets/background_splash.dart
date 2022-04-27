import 'package:flutter/material.dart';

class BackgroundSplash extends StatelessWidget {
  const BackgroundSplash({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
            color: Colors.white,
          ),
        ),
        Image.asset(
          'assets/bg.png',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fill,
          // scale: .5,
        ),
      ],
    );
  }
}
