import 'package:flutter/material.dart';
import 'package:equations/equations.dart';
import 'package:equations_solver/localization/localization.dart';

/// This is just a wrapper of a [TextFormField] that parses and validates the
/// coefficients of a polynomial equation.
class PolynomialInputField extends StatelessWidget {
  /// The [TextEditingController] controller.
  final TextEditingController controller;

  /// The placeholder text to show in the input field.
  final String placeholder;

  /// Creates a [PolynomialBody] widget.
  const PolynomialInputField({
    Key? key,
    required this.controller,
    required this.placeholder,
  }) : super(key: key);

  String? _validationLogic(String? value, BuildContext context) {
    if (value != null) {
      if (!value.isNumericalExpression) {
        return context.l10n.wrong_input;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      child: TextFormField(
        key: const Key('PolynomialInputField-TextFormField'),
        controller: controller,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blueAccent,
            ),
          ),
          hintText: placeholder,
        ),
        validator: (value) => _validationLogic(value, context),
      ),
    );
  }
}
