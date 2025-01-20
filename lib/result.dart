import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'Homepage.dart';

class ResultPage extends StatelessWidget {
  final int score;
  final int correct;
  final int incorrect;
  final int notAttempted;

  const ResultPage({
    super.key,
    required this.score,
    required this.correct,
    required this.incorrect,
    required this.notAttempted,
  });

  @override
  Widget build(BuildContext context) {
    final int totalQuestions = correct + incorrect + notAttempted;
    final double correctPercentage =
    totalQuestions == 0 ? 0 : correct / totalQuestions;

    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4A90E2), Color(0xFF50E3C2)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedCircularIndicator(
                    percentage: correctPercentage,
                  ),
                  const SizedBox(height: 30),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 15,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        resultRow("Score", "$score", Colors.blueAccent),
                        const SizedBox(height: 10),
                        resultRow("Correct Answers", "$correct", Colors.green),
                        const SizedBox(height: 10),
                        resultRow("Incorrect Answers", "$incorrect", Colors.red),
                        const SizedBox(height: 10),
                        resultRow("Not Attempted", "$notAttempted", Colors.orange),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),
                  // Retry Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Homepage()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 50),
                    ),
                    child: const Text(
                      "Retry Quiz",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                     Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                      elevation: 5,
                    ),
                    child: Text(
                      "Result Overview",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget resultRow(String label, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }
}

class AnimatedCircularIndicator extends StatelessWidget {
  final double percentage;

  const AnimatedCircularIndicator({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 100.0,
      lineWidth: 15.0,
      animation: true,
      percent: percentage,
      center: Text(
        "${(percentage * 100).toInt()}%",
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      progressColor: Colors.greenAccent,
      backgroundColor: Colors.white.withOpacity(0.3),
      circularStrokeCap: CircularStrokeCap.round,
    );
  }
}
