import 'dart:math';

import 'package:emojis_demo/models/Question.dart';

class QuestionGenerator{


  static Question generateQuestion(){
    Question question=Question();
    Random random=Random();
    int operator= random.nextInt(4);
    int num1= random.nextInt(101);
    int num2= 0;
    if(operator>2){
      num2=1+random.nextInt(100);
    }else{
      num2=random.nextInt(101);
    }
    if(num2 >num1){
      int temp= num1;
      num1=num2;
      num2=temp;
    }
    question.question= getQuestion(num1,num2,operator);
    question.answer= getAnswer(num1,num2,operator);
    question.options= getOptions(question.answer);
    return question;
  }

  static String getQuestion(int num1, int num2, int operator) {
    switch(operator){
      case 0:
        return "What is the value of $num1 + $num2";
      case 1:
        return "What is the value of $num1 - $num2";
      case 2:
        return "What is the value of $num1 * $num2";
      default :
        return "What is the quotient of $num1 / $num2";
    }
  }

  static int getAnswer(int num1, int num2, int operator) {
    switch(operator){
      case 0:
        return num1+num2;
      case 1:
        return num1-num2;
      case 2:
        return num1*num2;
      default :
        return   (num1/num2).toInt();
    }
  }

  static List<String> getOptions(int answer) {
    Random random = Random();
    Set<int> options = {answer}; // include correct answer

    // generate 3 unique wrong options from 0–100
    while (options.length < 4) {
      int wrongAnswer = random.nextInt(101); // 0 to 100
      options.add(wrongAnswer);
    }

    // shuffle and convert to string list
    List<String> optionList = options.map((e) => e.toString()).toList();
    optionList.shuffle();

    return optionList;
  }
}