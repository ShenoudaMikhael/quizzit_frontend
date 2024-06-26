import 'package:flutter/material.dart';
import 'package:quizzit/src/pages/quiz_page/radio_button_item.dart';
import 'package:quizzit/src/services/api_service.dart';
import 'package:rive/rive.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key, required this.category, required this.difficulty});
  final String category;
  final String difficulty;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<dynamic> qa = [];
  int currentIndex = 0;
  String? _selectedValue;
  List<String> _shuffledAnswers = [];

  @override
  void initState() {
    super.initState();
    fetchQuizQuestions();
  }

  Future<void> fetchQuizQuestions() async {
    qa = await QuizzitAPi.getQuizQuestions(widget.category, widget.difficulty);
    if (qa.isNotEmpty) {
      _shuffleAnswers();
    }
    setState(() {});
  }

  void _shuffleAnswers() {
    if (currentIndex < qa.length) {
      List<String> answers =
          List<String>.from(qa[currentIndex]["incorrect_answers"]);
      answers.add(qa[currentIndex]["correct_answer"]);
      answers.shuffle();
      _shuffledAnswers = answers;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: qa.isNotEmpty && currentIndex < qa.length
            ? currentQuestion(currentIndex)
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  Widget currentQuestion(int index) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          right: MediaQuery.of(context).size.width * .05,
          left: MediaQuery.of(context).size.width * .05,
          top: MediaQuery.of(context).size.height * 0.05,
          bottom: MediaQuery.of(context).size.height * 0.70,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              color: Colors.blue,
            ),
          ),
        ),
        Positioned(
          right: MediaQuery.of(context).size.width * .1,
          left: MediaQuery.of(context).size.width * .1,
          top: MediaQuery.of(context).size.height * 0.20,
          bottom: MediaQuery.of(context).size.height * 0.55,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              color: Colors.green,
            ),
          ),
        ),
        Positioned(
          right: MediaQuery.of(context).size.width * .1,
          left: MediaQuery.of(context).size.width * .1,
          top: MediaQuery.of(context).size.height * 0.18,
          bottom: MediaQuery.of(context).size.height * 0.75,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              color: Colors.deepPurpleAccent,
            ),
            child: const CircleAvatar(
              child: Icon(
                Icons.alarm_sharp,
                size: 36,
              ),
            ),
          ),
        ),
        Positioned(
          right: MediaQuery.of(context).size.width * .1,
          left: MediaQuery.of(context).size.width * .6,
          top: MediaQuery.of(context).size.height * 0.20,
          bottom: MediaQuery.of(context).size.height * 0.75,
          child: Container(
            color: Colors.yellow,
            child: const Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: LinearProgressIndicator(
                      value: 0.5,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("05"),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: MediaQuery.of(context).size.width * .6,
          left: MediaQuery.of(context).size.width * .1,
          top: MediaQuery.of(context).size.height * 0.20,
          bottom: MediaQuery.of(context).size.height * 0.75,
          child: Container(
            color: Colors.yellow,
            child: const Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("05"),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: LinearProgressIndicator(
                      value: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: MediaQuery.of(context).size.width * .1,
          left: MediaQuery.of(context).size.width * .1,
          top: MediaQuery.of(context).size.height * 0.25,
          bottom: MediaQuery.of(context).size.height * 0.55,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              color: Colors.deepPurpleAccent,
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const Center(child: Text("data")),
                  Expanded(child: Text(qa[currentIndex]["question"])),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: MediaQuery.of(context).size.width * .1,
          left: MediaQuery.of(context).size.width * .1,
          top: MediaQuery.of(context).size.height * 0.48,
          bottom: MediaQuery.of(context).size.height * 0.05,
          child: Container(
            color: Colors.amber[50],
            child: Column(
              children: <Widget>[
                ..._shuffledAnswers
                    .map(
                      (element) => RadioButtonItem(
                        value: element,
                        groupValue: _selectedValue,
                        onChanged: (value) {
                          setState(() {
                            _selectedValue = value;
                            show = true;
                            crt = qa[currentIndex]["correct_answer"] == value
                                ? true
                                : false;
                          });
                          Future.delayed(const Duration(milliseconds: 1500))
                              .then((_) {
                            setState(() {
                              show = false;
                              currentIndex += 1;
                              _selectedValue = null; // Reset the selected value
                              if (currentIndex < qa.length) {
                                _shuffleAnswers();
                              } else {
                                // Handle end of questions
                                currentIndex = 0;
                                _shuffleAnswers();
                              }
                            });
                          });
                        },
                      ),
                    )
                    .toList(),
              ],
            ),
          ),
        ),
        answered()
      ],
    );
  }

  bool crt = false;
  bool show = false;
  Widget answered() {
    return show
        ? crt
            ? const Positioned(
                child: RiveAnimation.asset(
                'assets/right_animation.riv',
              ))
            : const Positioned(
                child: RiveAnimation.asset(
                'assets/wrong_animation.riv',
              ))
        : const SizedBox(
            height: 0.01,
            width: 0.01,
          );
  }
}
