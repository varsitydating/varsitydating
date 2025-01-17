import 'package:flutter/material.dart';
import 'package:varsitydating/homeScreen/discover/daily_poll_questions_screen.dart';

class DailyPollScreen extends StatefulWidget {
  const DailyPollScreen({super.key});

  @override
  _DailyPollScreenState createState() => _DailyPollScreenState();
}

class _DailyPollScreenState extends State<DailyPollScreen> {
  int currentDay = 0;
  List<Map<String, Map<String, int>>> pollResults = [];
  List<Color> questionColors = [
    Colors.red.shade100,
    Colors.blue.shade100,
    Colors.green.shade100,
    Colors.orange.shade100,
    Colors.purple.shade100,
    Colors.yellow.shade100,
  ];

  @override
  void initState() {
    super.initState();
    initializePollResults();
  }

  void initializePollResults() {
    pollResults = DailyPollQuestionsScreen.questions.map((poll) {
      return {
        poll['question'] as String: {
          for (var option in poll['options']) option as String: 0,
        },
      };
    }).toList();
  }

  List<Map<String, dynamic>> getTodayPolls() {
    int start = (currentDay * 3) % DailyPollQuestionsScreen.questions.length;
    return DailyPollQuestionsScreen.questions.sublist(
      start,
      start + 3 > DailyPollQuestionsScreen.questions.length
          ? DailyPollQuestionsScreen.questions.length
          : start + 3,
    );
  }

  void vote(String question, String option) {
    setState(() {
      var result =
          pollResults.firstWhere((result) => result.containsKey(question));
      if (result[question]!.containsKey(option)) {
        result[question]![option] = (result[question]![option] ?? 0) + 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final todayPolls = getTodayPolls();

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Image.asset('images/logo.png', height: 40),
        ),
        title: const Text(
          "Daily Poll",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: todayPolls.asMap().entries.map((entry) {
            final index = entry.key;
            final poll = entry.value;

            return Card(
              margin: const EdgeInsets.all(10),
              color: questionColors[index % questionColors.length],
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      poll['question'],
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    ...poll['options'].map<Widget>((option) {
                      final question = poll['question'];
                      final votes = pollResults.firstWhere(
                          (result) => result.containsKey(question))[question]!;
                      final totalVotes = votes.values
                          .fold<int>(0, (sum, count) => sum + count);

                      final percentage = totalVotes > 0
                          ? (votes[option]! / totalVotes * 100)
                              .toStringAsFixed(1)
                          : "0.0";

                      return ListTile(
                        title: Row(
                          children: [
                            Expanded(child: Text(option)),
                            Text('$percentage%'),
                          ],
                        ),
                        leading: Radio<String>(
                          value: option,
                          groupValue: null,
                          onChanged: (value) {
                            vote(question, option);
                          },
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            currentDay++;
          });
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
