import 'package:flutter/material.dart';

const OutlineInputBorder formBorder = OutlineInputBorder(
  borderSide: BorderSide.none,
  borderRadius: BorderRadius.only(
    topRight: Radius.circular(10),
    bottomLeft: Radius.circular(10),
    bottomRight: Radius.circular(10)
  ),
);

const nameInputDecoration = InputDecoration(
  labelText: 'name',
  filled: true,
  fillColor: Colors.white,
  floatingLabelBehavior: FloatingLabelBehavior.never,
  border: formBorder
);

const emailInputDecoration = InputDecoration(
  labelText: 'email',
  filled: true,
  fillColor: Colors.white,
  floatingLabelBehavior: FloatingLabelBehavior.never,
  border: formBorder
);

const passwordInputDecoration = InputDecoration(
  labelText: 'password',
  filled: true,
  fillColor: Colors.white,
  floatingLabelBehavior: FloatingLabelBehavior.never,
  border: formBorder
);
const confirmPasswordInputDecoration = InputDecoration(
  labelText: 'confirm password',
  filled: true,
  fillColor: Colors.white,
  floatingLabelBehavior: FloatingLabelBehavior.never,
  border: formBorder
);

final ButtonStyle submitButtonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all(const Color(0xFF607D8B)),
  minimumSize: MaterialStateProperty.all(const Size.fromHeight(40))
);