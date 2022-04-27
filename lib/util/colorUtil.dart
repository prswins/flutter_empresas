import 'dart:ui';

class ColorUtil {
  static final Color darkGrey = const Color(0xff1f2120); //#1f2120
  static final Color goldStar = const Color(0xffd6b469); //#d6b469
  static final Color darkerGoldStar = const Color(0xff473b21); //#473b21
  static final Color primary = const Color(0xffE01E69);
  static final Color primaryText = const Color(0xffE01E69);


}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}