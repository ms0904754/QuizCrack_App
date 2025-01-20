import 'package:flutter/material.dart';

class OptionList extends StatelessWidget {
  final String option, descp;
  final int chooseopt;
  final int currentopt;
  final bool correctans;
  final bool isSubmit;

  const OptionList(
      {super.key, required this.option, required this.descp, required this.correctans, required this.chooseopt, required this.currentopt, required this.isSubmit});

  @override
  Widget build(BuildContext context) {
    return isSubmit==true?ListTile(
      selected: true,
      selectedColor: chooseopt == currentopt
          ? correctans == true
          ? Colors.green
          : Colors.red
          :correctans==true?Colors.green: Colors.grey,
      leading: CircleAvatar(
        backgroundColor: chooseopt == currentopt
            ? correctans == true
            ? Colors.green
            : Colors.red
            :correctans==true?Colors.green: Colors.grey,
        radius: 20,
        child: Text(
          option,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(
        descp,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ):ListTile(
      selected: true,
      selectedColor: chooseopt == currentopt
          ? Color(0xFF4A90E2)
          : Colors.transparent,
      leading: CircleAvatar(
        backgroundColor: chooseopt == currentopt
            ? Color(0xFF4A90E2)
            : Colors.grey,
        radius: 20,
        child: chooseopt == currentopt?Icon(Icons.check_rounded,color: Colors.white,):Text(
          option,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(
          descp,
          style: TextStyle(
            color: Colors.black54,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
      ),
    );

  }
}

