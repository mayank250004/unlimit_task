import 'dart:async';
import 'package:flutter/material.dart';

class JokeCardWidget extends StatefulWidget {
  final String joke;

  const JokeCardWidget({Key? key, required this.joke}) : super(key: key);

  @override
  State<JokeCardWidget> createState() {
    return _JokeCardWidgetState();
  }
}

class _JokeCardWidgetState extends State<JokeCardWidget> {
  late Timer _timer;
  bool _isVisible = false;
  final GlobalKey _cardKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startBlinkingAnimation();
    });
  }

  void _startBlinkingAnimation() {
    _timer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      setState(() {
        _isVisible = !_isVisible; // Toggle visibility
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel(); // Cancel the timer when the widget is disposed
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          elevation: 4.0,
          margin: const EdgeInsets.all(16.0),
          key: _cardKey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(widget.joke, style: const TextStyle(fontSize: 18.0)),
          ),
        ),
        if (_isVisible)
          const Positioned(
            left: 0,
            top: 0,
            child: Icon(
              Icons.emoji_emotions_rounded,
              size: 32.0,
              color: Colors.orange,
            ),
          ),
      ],
    );
  }
}
