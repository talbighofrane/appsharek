import 'package:flutter/material.dart';

class CheetahInput extends StatelessWidget {
  final String labelText;
  Function onSaved;
  
  CheetahInput({
    this.labelText,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        fillColor: Color.fromARGB(255, 255, 255, 255),
        filled: true,
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
      initialValue: '',
      validator: (var value) {
        if (value.isEmpty) {
          return '$labelText is required';
        }

        return null;
      },
      onSaved: onSaved as void Function(String),
    );
  }
}
