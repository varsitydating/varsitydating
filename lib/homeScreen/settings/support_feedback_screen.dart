import 'package:flutter/material.dart';

class SupportFeedbackScreen extends StatelessWidget {
  const SupportFeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Support & Feedback'),
      ),
      body: Center(
        child: Text('Support & Feedback Screen'),
      ),
    );
  }
}
