import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quizcrack/quiz.dart';
import 'package:quizcrack/result.dart';

import 'Models/QuizModel.dart';
import 'CountDownTimer.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<dynamic> users = [];
  List<QuizModel> questionStates = [];
  int score = 0;
  int Correct = 0;
  int InCorrect = 0;
  bool isSubmitted=false;
  bool isResetting=false;

  Future<void> AsyncData() async {

    const url = "https://api.jsonserve.com/Uw5CrX";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final jsondata = jsonDecode(response.body);
    setState(() {
      users = jsondata['questions'];
      Modelset();
    });
  }

  void Modelset() {

    for (int i = 0; i < users.length; i++) {
      List<dynamic> optionlist = users[i]['options'];
      QuizModel updatedmodel = new QuizModel();
      updatedmodel.idx = i + 1;
      updatedmodel.ques = users[i]['description'];
      updatedmodel.opt1 = optionlist[0]['is_correct'];
      updatedmodel.opt2 = optionlist[1]['is_correct'];
      updatedmodel.opt3 = optionlist[2]['is_correct'];
      updatedmodel.opt4 = optionlist[3]['is_correct'];
      questionStates.add(updatedmodel);
    }
  }

  void _modelreset(){
    for (int i = 0; i < users.length; i++) {
      questionStates[i].opt1=false;
      questionStates[i].opt2=false;
      questionStates[i].opt3=false;
      questionStates[i].opt4=false;
      questionStates[i].isanswered=false;
      questionStates[i].iscorrect=false;
      questionStates[i].iswrong=false;
      questionStates[i].isSumitted=false;
      questionStates[i].prevOptSelected=-1;
      questionStates[i].optselected=-1;
    }
  }

  void _modeloverview()
  {
    for(int i=0;i<users.length;i++)
    {
      questionStates[i].isSumitted=true;
    }
  }

  void resetQuiz() async {
    _modelreset();
    setState(() {
      isResetting=true;
    });
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      isResetting = false;
      score = 0;
      Correct = 0;
      InCorrect = 0;
      isSubmitted = false;
    });
  }


  @override
  void initState() {
    isSubmitted=false;
    AsyncData();
    super.initState();
  }

  void updateScore(int value, int corrct, int Incorrect) {
    score += value;
    Correct += corrct;
    InCorrect += Incorrect;
  }

  Future<void> _submitted() async{
    setState(() {
      isResetting=true;
      isSubmitted=true;
    });

    await Future.delayed(const Duration(seconds: 1));
    final shouldReset = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(
          score: score,
          correct: Correct,
          incorrect: InCorrect,
          notAttempted: users.length - (Correct + InCorrect),
        ),
      ),
    );

    if (shouldReset == true) {
      resetQuiz();
    }else
    {
      setState(() {
        isResetting=true;
      });
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        isResetting=false;
        _modeloverview();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isResetting==true || users.isEmpty?Center(child: CircularProgressIndicator()):Scaffold(
        appBar:AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.quiz, color: Colors.white, size: 30),
                    SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        'QuizCrack',
                        style: TextStyle(
                          fontSize: 24, // Font size
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          letterSpacing: 1.5,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
              if (!isSubmitted)
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: RoundedCountdownTimer(
                      submitQuiz: _submitted,
                      isSubmitted: isSubmitted,
                    ),
                  ),
                ),
            ],
          ),

          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blueAccent,
                  Colors.deepPurpleAccent,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        body: Quiz(
          users: users,
          updateScore: updateScore,
          questionStates: questionStates,
        ),

        floatingActionButton: isResetting==true?null:isSubmitted==true?Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton.extended(
                onPressed: () {
                  resetQuiz();
                },
                label: Text(
                  "Reset Quiz",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                icon: Icon(Icons.refresh),
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FloatingActionButton.extended(
                onPressed: () {
                  isSubmitted = true;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultPage(
                        score: score,
                        correct: Correct,
                        incorrect: InCorrect,
                        notAttempted: users.length - (Correct + InCorrect),
                      ),
                    ),
                  );
                },
                label: Text(
                  "Show Result",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                icon: Icon(Icons.assessment),
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ]
        )
            :FloatingActionButton(
          onPressed: () async {
            _submitted();
          },
          backgroundColor: Colors.deepPurpleAccent,
          elevation: 10,
          child: Text(
            "Submit",
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
