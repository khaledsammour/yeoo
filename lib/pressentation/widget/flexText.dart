import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';

class FlexText extends StatelessWidget {
  const FlexText({
    Key? key,
    required this.title,
    required this.style,
    this.textAlign = TextAlign.start,
  }) : super(key: key);
  final String title;
  final TextStyle style;
  final TextAlign textAlign;
  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      title,
      textAlign: textAlign,
      minFontSize: 6,
      style: style,
    );
  }
}
