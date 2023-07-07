import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:questanaire_app/provider/auth_provider.dart';
import 'package:questanaire_app/screens/register_screen.dart';
import 'package:questanaire_app/screens/welcome_screen.dart';

import '../constants/constants.dart';
import '../models/question_model.dart';
import '../responsive/responsive.dart';
import '../widgets/next_button.dart';
import '../widgets/option_card.dart';
import '../widgets/question_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<QuestionModel> _questions = [
    QuestionModel(
      id: "10",
      title: "What is 2 + 2 ?",
      options: {
        "5": false,
        "30": false,
        "4": true,
        "10": false,
      },
    ),
    QuestionModel(
      id: "11",
      title: "What is 10 + 20 ?",
      options: {
        "50": false,
        "30": true,
        "40": false,
        "10": false,
      },
    ),
  ];
  int index = 0;
  bool isClicked = false;
  void nextQuestion() {
    if (index == _questions.length - 1) {
      return;
    } else {
      if (isClicked) {
        setState(() {
          index++;
          isClicked = false;
        });
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data)))
      }
    }
  }

  void changColor() {
    setState(() {
      isClicked = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              ap.userSignOut().then(
                    (value) => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WelcomScreen(),
                      ),
                    ),
                  );
            },
            icon: Icon(
              Icons.exit_to_app,
            ),
          ),
        ],
        backgroundColor: background,
        title: const Text("Quiz App"),
        shadowColor: Colors.transparent,
      ),
      body: Container(
        width: R.sw(812, context),
        padding: EdgeInsets.symmetric(horizontal: R.sw(10, context)),
        child: Column(
          children: [
            QuestionWidget(
              question: _questions[index].title,
              index: index,
              totalQuestions: _questions.length,
            ),
            const Divider(
              color: neutral,
            ),
            SizedBox(height: R.sh(24, context)),
            for (int i = 0; i < _questions[index].options.length; i++)
              OptionCard(
                ontap: changColor,
                option: _questions[index].options.keys.toList()[i],
                color: isClicked
                    ? _questions[index].options.values.toList()[i] == true
                        ? correctAns
                        : incorrectAns
                    : neutral,
              ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: R.sw(10, context)),
        child: NextButton(
          nextQuestion: nextQuestion,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

// questionnaire design flutter admin side