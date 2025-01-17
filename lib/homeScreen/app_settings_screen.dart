import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:varsitydating/authenticationScreen/login_screen.dart'; // Ensure login screen is imported
import 'package:varsitydating/homeScreen/user_profile_screen.dart';
/*import 'package:varsitydating/homeScreen/settings/manage_account_screen.dart';*/
import 'package:varsitydating/authenticationScreen/profile_setup_screen.dart';
import 'package:varsitydating/homeScreen/settings/privacy_settings_screen.dart';
import 'package:varsitydating/homeScreen/settings/notification_preferences_screen.dart';
import 'package:varsitydating/homeScreen/settings/subscription_payments_screen.dart';
import 'package:varsitydating/homeScreen/settings/security_settings_screen.dart';
import 'package:varsitydating/homeScreen/settings/appearance_settings_screen.dart';
import 'package:varsitydating/homeScreen/settings/connection_preferences_screen.dart';
import 'package:varsitydating/homeScreen/settings/support_feedback_screen.dart';
import 'package:varsitydating/homeScreen/settings/about_app_screen.dart';

class AppSettingsScreen extends StatelessWidget {
  const AppSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset(
              'images/logo.png',
              height: 40,
            ),
            SizedBox(width: 8.0),
            Text(
              'Varsity Dating',
              style: TextStyle(
                color: Colors.grey[850],
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const UserProfileScreen(),
              ),
            );
          },
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          // Group 1: Account Management
          ListTile(
            title: Text('Manage Account'),
            subtitle: Text('Update profile, change email, deactivate account'),
            leading: Icon(Icons.person),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileSetupScreen(),
                ),
              );
            },
          ),
          Divider(),

          // Group 2: Privacy and Notifications
          ListTile(
            title: Text('Privacy Settings'),
            subtitle: Text('Control who can see your profile'),
            leading: Icon(Icons.lock),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PrivacySettingsScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Notification Preferences'),
            subtitle: Text('Customize notification settings'),
            leading: Icon(Icons.notifications),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationPreferencesScreen(),
                ),
              );
            },
          ),
          Divider(),

          // Group 3: Subscription and Security
          ListTile(
            title: Text('Subscription & Payments'),
            subtitle: Text('Manage plans and payment methods'),
            leading: Icon(Icons.credit_card),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SubscriptionPaymentsScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Security Settings'),
            subtitle: Text('Review login history and reset password'),
            leading: Icon(Icons.security),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SecuritySettingsScreen(),
                ),
              );
            },
          ),
          Divider(),

          // Group 4: Appearance and Preferences
          ListTile(
            title: Text('Appearance Settings'),
            subtitle: Text('Customize app theme and display'),
            leading: Icon(Icons.color_lens),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AppearanceSettingsScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Connection Preferences'),
            subtitle: Text('Set match preferences and visibility'),
            leading: Icon(Icons.settings),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ConnectionPreferencesScreen(),
                ),
              );
            },
          ),
          Divider(),

          // Group 5: Support and About
          ListTile(
            title: Text('Support & Feedback'),
            subtitle: Text('Access help and provide feedback'),
            leading: Icon(Icons.help_outline),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SupportFeedbackScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('About the App'),
            subtitle: Text('View app version and legal policies'),
            leading: Icon(Icons.info_outline),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutAppScreen(),
                ),
              );
            },
          ),
          Divider(),

          // Logout
          ListTile(
            title: Text('Logout'),
            leading: Icon(Icons.exit_to_app, color: Colors.red),
            onTap: () async {
              try {
                // Sign out using Amplify
                await Amplify.Auth.signOut();

                // After signing out, navigate to the login screen without clearing any shared preferences
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              } catch (e) {
                // Handle error if sign-out fails
                print('Error signing out: $e');
              }
            },
          ),
        ],
      ),
    );
  }
}
