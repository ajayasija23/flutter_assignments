import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:emojis_demo/models/Question.dart';
import 'package:emojis_demo/score_screen.dart';
import 'package:emojis_demo/util/question_generator.dart';
import 'package:emojis_demo/util/theme.dart';
import 'package:emojis_demo/widget_helper.dart';
import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  Question question = QuestionGenerator.generateQuestion();
  String selectedAnswer = "";
  int score = 0;
  int total= 0;
  final AudioPlayer audioPlayer = AudioPlayer();

  // play sound
  void playSound(bool correct) async {
    String path = correct ? "correct.mp3" : "wrong.mp3";
    await audioPlayer.play(AssetSource(path));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.all(16),
        child: Column(
          children: [
            16.h,
            Text(
              "Math Master",
              style: TextStyles.robotoTitle.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            8.h,
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Score: $score/$total",
                style: TextStyles.robotoBody.copyWith(
                  fontSize: 16,
                ),
              ),
            ),
            16.h,
            Container(
              height: 120,
              width: double.infinity,
              alignment: Alignment.center,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, secondaryColor],
                  transform: GradientRotation(180),
                ),
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: Text(
                "Q. ${question.question}",
                style: TextStyles.robotoTitle.copyWith(color: Colors.white),
              ),
            ),
            Spacer(),
            16.h,
            _buildOptions(),
            Spacer(),
            SimpleButton(text: "Finish", textColor: Colors.white,onPressed:()=>Navigator.push(context, MaterialPageRoute(builder: (context) => ScorePage(score: score, total: total,))),)
          ],
        ),
      ),
    );
  }

  Widget _buildOptions() {
    List<Widget> widgets = [];

    for (int index = 0; index < question.options.length; index++) {
      String prefix = String.fromCharCode(65 + index); // 65 = 'A'
      String item = question.options[index];
      widgets.add(
        Container(
          height: 50,
          width: double.infinity,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(bottom: 8),
          // spacing between options
          decoration: BoxDecoration(
            color: selectedAnswer != question.options[index]
                ? Colors.transparent
                : (selectedAnswer == question.answer.toString() ? green : red),
            border: selectedAnswer != question.options[index]
                ? BoxBorder.all(color: primaryColor)
                : null,
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
          child: Text("$prefix. $item", style: TextStyles.robotoBody),
        ).onTap(() {
          if (selectedAnswer.isEmpty) {
            setState(() {
              selectedAnswer = question.options[index];
            });
            bool isCorrect=selectedAnswer == question.answer.toString();
            playSound(isCorrect);
            Timer(const Duration(seconds: 1), () {
              setState(() {
                if(isCorrect) {
                  score++;
                }
                total++;
                selectedAnswer = "";
                question = QuestionGenerator.generateQuestion();
              });
            });
          }
        }),
      );
      widgets.add(16.h);
    }

    return Column(children: widgets);
  }
}
