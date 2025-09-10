import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spinning_wheel/controller/spin_controller.dart';
import 'package:spinning_wheel/models/wheel_segment.dart';
import 'package:spinning_wheel/spinner_wheel.dart';
import 'package:emojis_demo/util/theme.dart';

extension SpaceExtension on num {
  /// Horizontal space (width)
  SizedBox get w => SizedBox(width: toDouble());

  /// Vertical space (height)
  SizedBox get h => SizedBox(height: toDouble());
}

extension TitleCase on String{
  String get titleCase => this[0].toUpperCase() + this.substring(1);
}

class SimpleButton extends StatelessWidget {
  const SimpleButton({
    super.key,
    this.text = "Continue",                    // default text
    this.backgroundColor = primaryColor,      // default background
    this.textColor = Colors.white,           // default text color
    this.onPressed,                          // optional callback
    this.radius = 12,                        // default corner radius
    this.fullWidth = true,                  // default is not full width
    this.padding,                            // optional custom padding
    this.height,                             // optional custom height
  });

  final String text;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback? onPressed;
  final double radius;
  final bool fullWidth;
  final EdgeInsetsGeometry? padding;
  final double? height;

  @override
  Widget build(BuildContext context) {
    Widget button = ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(backgroundColor), // works for all states
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        padding: MaterialStateProperty.all(padding ?? const EdgeInsets.symmetric(vertical: 16)),
        minimumSize: height != null ? MaterialStateProperty.all(Size(0, height!)) : null,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );

    if (fullWidth) {
      return SizedBox(width: double.infinity, child: button);
    } else {
      return button;
    }
  }
}


class SpinWheelWidget extends StatelessWidget {
  const SpinWheelWidget({
    super.key,
    required this.controller,
    required this.segments,
    this.size = 300,
    this.onComplete,
  });

  final SpinnerController controller;
  final List<WheelSegment> segments; // Adjust type if your segments differ
  final double size;
  final void Function(WheelSegment,int)? onComplete;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: SpinnerWheel(
        controller: controller,
        segments: segments,
        wheelColor: Colors.red,
        onComplete: onComplete!,
        centerChild: Image.asset("assets/ic_spin.png",height: 100,width: 100),
        indicator: Image.asset("assets/ic_wheel_arrow.png"),
        labelStyle: TextStyle(
          fontWeight: FontWeight.normal,
          color: Theme.of(context).colorScheme.onPrimary,
          fontSize: 10
        ),
      ),
    );
  }
}

class TextStyles {
  // Normal body text
  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Colors.white,
  );

  // Small text
  static const TextStyle small = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: Colors.white,
  );

  // Headings
  static const TextStyle h1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle h2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle h3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  // Using Google Fonts (Roboto)
  // Note: GoogleFonts cannot be const, so these are static final
  static final TextStyle robotoBody = GoogleFonts.sarabun(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Colors.white,
  );

  static final TextStyle robotoTitle = GoogleFonts.sarabun(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static final TextStyle robotoH1 = GoogleFonts.sarabun(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}


