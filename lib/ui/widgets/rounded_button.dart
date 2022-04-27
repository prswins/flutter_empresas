import 'package:flutter/material.dart';
import 'package:flutter_empresas/util/colorUtil.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;
  final bool isPrimaryColor;
  final double maxWidthWidget;

  const RoundedButton(
      {Key? key,
      required this.text,
      required this.callback,
      required this.isPrimaryColor,
      required this.maxWidthWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52.0,
      margin: EdgeInsets.all(15),
      child: ElevatedButton(
        onPressed: callback,
        style: ElevatedButton.styleFrom(
            elevation: 3,
            padding: EdgeInsets.all(0.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0))),
        child: Ink(
          decoration: BoxDecoration(
              /*gradient: LinearGradient(
                colors: colorGradiente,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),*/
              color: isPrimaryColor ? ColorUtil.primary : Colors.white,
              border: Border.all(
                  color: isPrimaryColor ? ColorUtil.primary : Colors.white),
              borderRadius: BorderRadius.circular(10.0)),
          child: Container(
            constraints:
                BoxConstraints(maxWidth: maxWidthWidget, minHeight: 52.0),
            alignment: Alignment.center,
            child: Text(
              text.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isPrimaryColor ? Colors.white : ColorUtil.primaryText),
            ),
          ),
        ),
      ),
    );
  }
}
