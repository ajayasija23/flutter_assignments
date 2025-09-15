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
extension PaddingExtension on Widget {
  Widget paddingAll(double value) =>
      Padding(padding: EdgeInsets.all(value), child: this);

  Widget paddingSymmetric({double vertical = 0, double horizontal = 0}) =>
      Padding(
        padding: EdgeInsets.symmetric(
          vertical: vertical,
          horizontal: horizontal,
        ),
        child: this,
      );

  Widget paddingOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) =>
      Padding(
        padding: EdgeInsets.only(
          left: left,
          top: top,
          right: right,
          bottom: bottom,
        ),
        child: this,
      );
}

extension MarginExtension on Widget {
  Widget marginAll(double value) =>
      Container(margin: EdgeInsets.all(value), child: this);

  Widget marginSymmetric({double vertical = 0, double horizontal = 0}) =>
      Container(
        margin: EdgeInsets.symmetric(
          vertical: vertical,
          horizontal: horizontal,
        ),
        child: this,
      );

  Widget marginOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) =>
      Container(
        margin: EdgeInsets.only(
          left: left,
          top: top,
          right: right,
          bottom: bottom,
        ),
        child: this,
      );
}


extension OnTapExtension on Widget {
  Widget onTap(VoidCallback onTap) {
    return MouseRegion(
      cursor: SystemMouseCursors.click, // shows hand cursor on web
      child: GestureDetector(
        onTap: onTap,
        child: this,
      ),
    );
  }
}

class SimpleButton extends StatelessWidget {
  const SimpleButton({
    super.key,
    this.text = "Continue",                    // default text
    this.backgroundColor = primaryColor,      // default background
    this.textColor = Colors.black54,           // default text color
    this.onPressed,                          // optional callback
    this.radius = 12,                        // default corner radius
    this.fullWidth = true,                  // default is not full width
    this.padding,                            // optional custom padding
    this.height=50,
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
    Widget button = Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(backgroundColor), // works for all states
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
          padding: WidgetStateProperty.all(padding ?? const EdgeInsets.symmetric(vertical: 16)),
          minimumSize: height != null ? WidgetStateProperty.all(Size(0, height!)) : null,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
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

class OutlineTextField extends StatelessWidget {
  final double padding;

  final dynamic label;

  final dynamic controller;
  final TextInputType inputType;

  const OutlineTextField({super.key,this.padding=0.0,this.label,this.controller,this.inputType=TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: TextField(
        keyboardType: inputType,
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
        ),
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  const PasswordField({super.key,this.padding=0.0,this.label,this.controller});
  final double padding;
  final dynamic label;

  final dynamic controller;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(widget.padding),
      child: TextField(
        obscureText: _obscureText,
        controller: widget.controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: widget.label,
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
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
    color: Colors.black54,
  );

  // Small text
  static const TextStyle small = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: Colors.black54,
  );

  // Headings
  static const TextStyle h1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.black54,
  );

  static const TextStyle h2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black54,
  );

  static const TextStyle h3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black54,
  );

  // Using Google Fonts (Roboto)
  // Note: GoogleFonts cannot be const, so these are static final
  static final TextStyle robotoBody = GoogleFonts.workSans(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Colors.black54,
  );

  static final TextStyle robotoTitle = GoogleFonts.workSans(
    fontSize: 20,
    fontWeight: FontWeight.normal,
    color: Colors.black54,
  );

  static final TextStyle robotoH1 = GoogleFonts.workSans(
    fontSize: 30,
    fontWeight: FontWeight.normal,
    color: Colors.black54,
  );
}

class RoundedImageTile extends StatelessWidget {
  final String imageUrl;
  final String title;

  const RoundedImageTile({
    super.key,
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
      return Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey[300],
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.network(imageUrl,height: 120,width: 120,fit: BoxFit.cover,),
                8.h,
                Text(title.titleCase,style: TextStyles.robotoTitle,)
              ],
            ),
          ),
      );
  }
}



