import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  // Function to get the app version
  Future<String> _getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return "Version: ${packageInfo.version}, Build: ${packageInfo.buildNumber}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About the App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Introduction
            Text(
              'Welcome to Varsity Dating!',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 8),
            Text(
              'Varsity Dating is a platform exclusively for college and university students to meet and connect. Whether you are looking for friendship, study buddies, or a potential partner, our app helps you find like-minded people from your university or beyond.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 16),

            // How It Works
            Text(
              'How It Works:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 8),
            Text(
              '1. Create your profile and set your preferences.\n'
              '2. Start matching with students from your institution or other universities.\n'
              '3. Enjoy secure, encrypted messaging to get to know your matches.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 16),

            // Features
            Text(
              'Key Features:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 8),
            Text(
              '- Profile creation and customization\n'
              '- Match based on study preferences, hobbies, and more\n'
              '- Secure, end-to-end encrypted messaging\n'
              '- Discover matches randomly or based on preferences\n'
              '- Google and Apple login integration',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 16),

            // Safety and Security
            Text(
              'Safety and Security:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 8),
            Text(
              'Your privacy is our priority. We use end-to-end encryption to ensure that your conversations remain private and secure.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 16),

            // Mission and Vision
            Text(
              'Our Mission:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 8),
            Text(
              'We aim to create a safe, inclusive, and supportive space where students can connect, build relationships, and explore new opportunities.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 16),

            // Community Guidelines
            Text(
              'Community Guidelines:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 8),
            Text(
              'We encourage respectful and kind interactions within the community. Please follow the guidelines to ensure a positive experience for everyone.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 16),

            // Contact Information
            Text(
              'Contact Us:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 8),
            Text(
              'For support or inquiries, email us at: support@varsitydating.com',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 16),

            // App Version
            FutureBuilder<String>(
              future: _getAppVersion(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error fetching version');
                } else {
                  return Text(
                    snapshot.data ?? 'Version not available',
                    style: Theme.of(context).textTheme.bodyMedium,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
