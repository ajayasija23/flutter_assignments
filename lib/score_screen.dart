import 'package:emojis_demo/base_widgets.dart';
import 'package:emojis_demo/quiz_screen.dart';
import 'package:emojis_demo/util/theme.dart';
import 'package:emojis_demo/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScorePage extends BaseStatelessWidget {
  final int score;

  final int total;

  const ScorePage({super.key,required this.score,required this.total});

  @override
  Widget buildBody(BuildContext context) {
    return SafeArea(child: Center(
      child: Column(
        children: [
          80.h,
          Text("Math Master",style: TextStyles.robotoH1.copyWith(color: primaryColor,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
          16.h,
          SvgPicture.asset("assets/ic_logo.svg",height: 150,width: 150,),
          80.h,
          Text("Your score",style: TextStyles.robotoBody,textAlign: TextAlign.center,),
          Text("$score/$total",style: TextStyles.robotoH1.copyWith(color: primaryColor,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
        ],
      ),
    ));
  }
}



