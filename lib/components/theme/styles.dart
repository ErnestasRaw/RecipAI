import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:receptai/components/theme/palette.dart';

class Styles {
  /// Private constructor to get rid of suggestion for using the constructor
  Styles._();

  /////////////////////////////////////////
  /// Standard styles
  /// Using [fontVariations] to get a working font weight. This is unoptimal, need a cleaner method
  static TextStyle _processTextStyle(TextStyle style) {
    final weight = style.fontWeight;
    return style.copyWith(
      fontVariations: weight == null
          ? null
          : [
              FontVariation(
                'wght',
                ((weight.index + 1) * 100).toDouble(),
              ),
            ],
    );
  }

  static TextStyle ag16Medium({Color? color}) {
    return _processTextStyle(TextStyle(
      // fontFamily: 'Poppins-Medium',
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
      fontSize: 16,
      height: 20 / 16,
      color: color,
    ));
  }

  static TextStyle ag16Light({Color? color, bool inherit = true}) {
    return _processTextStyle(TextStyle(
      inherit: inherit,
      // fontFamily: 'Poppins-Light',
      fontFamily: 'Inter',
      fontWeight: FontWeight.w300,
      fontSize: 16,
      height: 20 / 16,
      // fontVariations: [
      //   FontVariation(
      //     'wght',
      //     ((FontWeight.w300.index + 1) * 100).toDouble(),
      //   ),
      // ],
      color: color,
    ));
  }

  static TextStyle titleAg25Semi({Color? color = Palette.white}) {
    return _processTextStyle(TextStyle(
      // fontFamily: 'Poppins-Light',
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
      fontSize: 25,
      height: 30.26 / 25,
      color: color,
    ));
  }

  static TextStyle titleAg40Semi({Color? color = Palette.white}) {
    return _processTextStyle(TextStyle(
      // fontFamily: 'Poppins-Light',
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
      fontSize: 40,
      height: 30.26 / 25,
      color: color,
    ));
  }

  /// Like ag16Regular.copyWith(height: 1.5) - cannot do that because "has inherit=true, resetting height won't work"
  /// setting inherit:false to let HtmlWidget do something with it
  static TextStyle htmlText({Color? color}) {
    return const TextStyle(
      fontFamily: 'Poppins-Regular',
      fontWeight: FontWeight.w400,
      fontSize: 16,
      height: 1.5,
      //color: color,
      //inherit: true,
    );
  }

  static InputDecoration inputDec(
      {String? labelText, String? helperText, Icon? icon, String? errorMessage, bool? required}) {
    return InputDecoration(
      counterText: '',
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(child: Text(labelText ?? '')),
          Text(
            required == true ? ' *' : '',
            style: const TextStyle(color: Colors.red),
          ),
        ],
      ),
      focusColor: const Color.fromARGB(255, 41, 112, 167),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(0)),
      ),
      floatingLabelAlignment: FloatingLabelAlignment.start,
      filled: true,
      errorText: errorMessage,
      fillColor: Colors.white,
      //helperText: helperText ?? '',
      prefixIcon: icon,
    );
  }

  static ButtonStyle bottomButtonsStyle() {
    return ElevatedButton.styleFrom(
        backgroundColor: MaterialStateColor.resolveWith((states) => Palette.seedColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)));
  }
}
