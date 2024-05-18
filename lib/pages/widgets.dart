import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyBackButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 32.0,
      left: 8.0,
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.keyboard_arrow_left),
        color: Colors.white,
      ),
    );
  }

}