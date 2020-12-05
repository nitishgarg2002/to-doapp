import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final _textEditingController =TextEditingController();
  final String labelText;
  CustomTextField({@required this.labelText});
  @override
  Widget build(BuildContext context) {
    return  TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12),
                ),
                ),
                labelText: labelText,
            ),
            controller: _textEditingController,
            );
  }
}