import 'dart:async';

import 'package:flutter/material.dart';

class CustomLoader extends StatefulWidget {
  const CustomLoader({super.key});

  @override
  State<CustomLoader> createState() {
    return _LoaderState();
  }
}

class _LoaderState extends State<CustomLoader> {
  late Timer _timer;
  int _currentColorIndex = 0;
  final List<Color> _colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
  ];

  @override
  void initState() {
    super.initState();
    // Start a timer to change colors and create a wave effect
    _timer = Timer.periodic(const Duration(milliseconds: 299), (timer) {
      setState(() {
        _currentColorIndex = (_currentColorIndex + 1) % _colors.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      // Center the row
      child: Row(
        mainAxisSize: MainAxisSize.min, // Set mainAxisSize to min
        children: <Widget>[
          for (int i = 0; i < _colors.length; i++)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _colors[(_currentColorIndex + i) % _colors.length],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
