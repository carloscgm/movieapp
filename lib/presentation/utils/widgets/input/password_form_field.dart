import 'package:flutter/material.dart';

class PasswordFormField extends StatefulWidget {
  const PasswordFormField(
      {Key? key, this.controller, this.validator, this.decoration})
      : super(key: key);

  final TextEditingController? controller;
  final FormFieldValidator<String?>? validator;
  final InputDecoration? decoration;

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  var _passwordHidden = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.text,
      obscureText: _passwordHidden,
      validator: widget.validator,
      decoration: (widget.decoration ?? const InputDecoration()).copyWith(
          suffixIcon: InkWell(
        customBorder: const CircleBorder(),
        onTap: _togglePasswordView,
        child: Icon(
          _passwordHidden ? Icons.visibility_off : Icons.visibility,
        ),
      )),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _passwordHidden = !_passwordHidden;
    });
  }
}
