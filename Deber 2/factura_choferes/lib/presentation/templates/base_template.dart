import 'package:flutter/material.dart';
import 'package:factura_choferes/presentation/organisms/headers/app_header.dart';

class BaseTemplate extends StatelessWidget {
  final String title;
  final Widget body;
  final VoidCallback? onBackPressed;
  final bool showBackButton;

  const BaseTemplate({
    Key? key,
    required this.title,
    required this.body,
    this.onBackPressed,
    this.showBackButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(
        title: title,
        onBackPressed: showBackButton
            ? (onBackPressed ?? () => Navigator.of(context).pop())
            : null,
      ),
      body: body,
    );
  }
}
