import 'package:flutter/material.dart';

import 'Models/QuizModel.dart';
import 'options.dart';

class Quiz extends StatefulWidget {
  final List users;
  final List questionStates;
  final Function(int,int,int) updateScore;

  Quiz({super.key, required this.users, required this.updateScore, required this.questionStates});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
            itemCount: widget.users.length,
            itemBuilder: (BuildContext context, int index) {
              List<dynamic> optionlist = widget.users[index]['options'];
              return DetailedPage(
                  users: widget.users,
                  optionlist: optionlist,
                  model: widget.questionStates[index],
                  updateScore: widget.updateScore);
            },
          );
  }
}

class DetailedPage extends StatefulWidget {
  DetailedPage(
      {super.key,
      required this.users,
      required this.optionlist,
      required this.model,
      required this.updateScore});

  final List users;
  final List optionlist;
  final QuizModel model;
  final Function(int,int,int) updateScore;

  @override
  State<DetailedPage> createState() => _DetailedPageState();
}

class _DetailedPageState extends State<DetailedPage> {

  void _updateScore(int selectedOption) {
    bool correctAnswer = widget.optionlist[selectedOption]['is_correct'];

    if (widget.model.prevOptSelected != -1) {
      bool wasCorrect =
          widget.optionlist[widget.model.prevOptSelected]['is_correct'];
      if (wasCorrect) {
        widget.updateScore(-5,-1,0);
      } else {
        widget.updateScore(1,0,-1);
      }
    }

    if (correctAnswer) {
      widget.updateScore(5,1,0);
    } else {
      widget.updateScore(-1,0,1);
    }

      setState(() {
        widget.model.prevOptSelected = selectedOption;
        widget.model.optselected = selectedOption;
        widget.model.isanswered = true;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${widget.model.idx}.",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  widget.model.ques,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 6,
          ),
          GestureDetector(
            onTap: () {
              // setState(() {
                if(!widget.model.isSumitted)_updateScore(0);
              // });
            },
            child: OptionList(
              option: "A",
              descp: widget.optionlist[0]['description'],
              chooseopt: widget.model.optselected,
              currentopt: 0,
              correctans: widget.optionlist[0]['is_correct'],
              isSubmit: widget.model.isSumitted,
            ),
          ),
          SizedBox(
            height: 6,
          ),
          GestureDetector(
            onTap: () {
              if(!widget.model.isSumitted) _updateScore(1);
            },
            child: OptionList(
              option: "B",
              descp: widget.optionlist[1]['description'],
              chooseopt: widget.model.optselected,
              currentopt: 1,
              correctans: widget.optionlist[1]['is_correct'],
              isSubmit: widget.model.isSumitted,
            ),
          ),
          SizedBox(
            height: 6,
          ),
          GestureDetector(
            onTap: () {
              if(!widget.model.isSumitted)_updateScore(2);
            },
            child: OptionList(
              option: "C",
              descp: widget.optionlist[2]['description'],
              chooseopt: widget.model.optselected,
              currentopt: 2,
              correctans: widget.optionlist[2]['is_correct'],
              isSubmit: widget.model.isSumitted,
            ),
          ),
          SizedBox(
            height: 6,
          ),
          GestureDetector(
            onTap: () {
              if(!widget.model.isSumitted) _updateScore(3);
            },
            child: OptionList(
              option: "D",
              descp: widget.optionlist[3]['description'],
              chooseopt: widget.model.optselected,
              currentopt: 3,
              correctans: widget.optionlist[3]['is_correct'],
              isSubmit: widget.model.isSumitted,
            ),
          ),
          Divider(
            thickness: 0.5,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}
