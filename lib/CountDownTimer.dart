import 'dart:async';
import 'package:flutter/material.dart';

class RoundedCountdownTimer extends StatefulWidget {
  final Function() submitQuiz;
  final isSubmitted;
  const RoundedCountdownTimer({super.key, required this.submitQuiz, this.isSubmitted});

  @override
  State<RoundedCountdownTimer> createState() => _RoundedCountdownTimerState();
}

class _RoundedCountdownTimerState extends State<RoundedCountdownTimer> {
  Duration _duration = Duration(minutes: 15); // Initial timer duration
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatTime(Duration duration) {
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }


  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_duration.inSeconds > 0) {
        setState(() {
          _duration = _duration - Duration(seconds: 1);
        });
      } else {
        _timer.cancel();
        if(widget.isSubmitted==false) widget.submitQuiz();
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: _duration<=Duration(minutes: 2)?LinearGradient(colors: [Colors.red,Colors.red],begin: Alignment.topLeft,end: Alignment.bottomRight):LinearGradient(
          colors: [Colors.blue,Colors.purple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(4, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Center(
        child: Text(
          _formatTime(_duration),
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

