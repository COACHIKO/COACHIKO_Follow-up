import 'package:flutter/material.dart';

class CustomWeightInput extends StatefulWidget {
  final bool isComplete;
  final String hintText;
  final Function(String)? onChanged;

  const CustomWeightInput({
    super.key,
    required this.isComplete,
    required this.hintText,
    this.onChanged,
  });

  @override
  CustomWeightInputState createState() => CustomWeightInputState();
}

class CustomWeightInputState extends State<CustomWeightInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      style: TextStyle(
        fontSize: 15,
        color: widget.isComplete ? Colors.white : const Color(0xFF959595),
      ),
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        // Remove the border and outline
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        contentPadding: EdgeInsets.zero, // Remove default padding
        // Adjust hint style
        hintStyle: TextStyle(
          fontSize: 20,
          color: widget.isComplete ? Colors.white : const Color(0xFF959595),
        ),
        hintText: widget.hintText,
      ),
    );
  }
}
