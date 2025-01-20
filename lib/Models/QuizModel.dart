import 'dart:core';

class QuizModel{
   String ques="";
   int idx=0;
   bool opt1=false;
   bool opt2=false;
   bool opt3=false;
   bool opt4=false;
   int optselected=-1;
   int prevOptSelected=-1;
   bool isanswered=false;
   bool iscorrect=false;
   bool iswrong=false;
   bool isSumitted=false;
   int marks=0;
  QuizModel({ques,idx,opt1,opt2,opt3,opt4,isanswered,optselected,iscorrect,iswrong,marks});

}