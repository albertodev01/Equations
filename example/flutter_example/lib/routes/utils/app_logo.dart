import 'package:flutter/material.dart';

/// The vectorial logo of the app.
class AppLogo extends StatelessWidget {
  /// Creates a [AppLogo] widget.
  const AppLogo();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Image.asset(
        'assets/logo.png',
        width: 285,
        height: 95,
      ),
    );
  }
}
