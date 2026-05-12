import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  final String title;
  final String value;
  final TextAlign textAlign;
  final double fontSize;
  final bool isBold;

  const Label({
    Key? key,
    required this.title,
    required this.value,
    this.textAlign = TextAlign.left,
    this.fontSize = 16,
    this.isBold = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            textAlign: textAlign,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

class ResultLabel extends StatelessWidget {
  final String text;
  final double fontSize;
  final bool highlight;

  const ResultLabel({
    Key? key,
    required this.text,
    this.fontSize = 14,
    this.highlight = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: highlight ? FontWeight.bold : FontWeight.normal,
          color: highlight ? Colors.deepPurple : Colors.black87,
        ),
      ),
    );
  }
}
