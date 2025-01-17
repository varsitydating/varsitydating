import 'package:flutter/material.dart';

class ConnectionPreferencesScreen extends StatelessWidget {
  const ConnectionPreferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connection Preferences'),
      ),
      body: Center(
        child: Text('Connection Preferences Screen'),
      ),
    );
  }
}
