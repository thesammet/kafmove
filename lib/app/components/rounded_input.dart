import 'package:flutter/material.dart';
import 'package:move/app/components/input_conatiner.dart';

class RoundedInput extends StatelessWidget {
  const RoundedInput({Key key, this.hintText, this.textController})
      : super(key: key);

  final String hintText;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return InputContainer(
      child: TextField(
        style: TextStyle(
          fontFamily: 'Metropolis',
          fontSize: 18,
          color: const Color(0xff000000),
          letterSpacing: -0.36,
          fontWeight: FontWeight.w500,
        ),
        controller: textController,
        cursorColor: const Color(0xff303030),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: const Color(0xff909090))),
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: 'Metropolis',
            fontSize: 18,
            color: const Color(0xff808080),
            letterSpacing: -0.36,
            fontWeight: FontWeight.w500,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
