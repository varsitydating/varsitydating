import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:varsitydating/authenticationScreen/profile_setup_screen.dart';
import 'package:varsitydating/controllers/authentication_controller.dart';
import 'package:varsitydating/homeScreen/swipeable_profiles_screen.dart';
import 'package:varsitydating/homescreen/settings/appearance_settings_screen.dart';

import 'package:amplify_datastore/amplify_datastore.dart';
import 'models/ModelProvider.dart';

import 'amplifyconfiguration.dart'; // Import the correct configuration file

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _configureAmplify(); // Configure Amplify plugins
  Get.put(AuthenticationController());
  final appTheme = await AppTheme.loadTheme(); // Load theme preferences
  runApp(MyApp(appTheme: appTheme));
}

// Configure Amplify plugins
Future<void> _configureAmplify() async {
  try {
    final authPlugin = AmplifyAuthCognito();
    final storagePlugin = AmplifyStorageS3();
    final datastorePlugin =
        AmplifyDataStore(modelProvider: ModelProvider.instance);

    // Add Amplify plugins
    await Amplify.addPlugin(authPlugin);
    await Amplify.addPlugin(storagePlugin);
    await Amplify.addPlugin(datastorePlugin);

    // Configure Amplify
    await Amplify.configure(amplifyconfig);
    print("Amplify configured successfully");
  } catch (e) {
    print("Amplify configuration failed: $e");
  }
}

class MyApp extends StatelessWidget {
  final AppTheme appTheme;

  const MyApp({super.key, required this.appTheme});

  @override
  Widget build(BuildContext context) {
    return Authenticator(
      child: GetMaterialApp(
        title: 'Varsity Dating',
        theme: ThemeData.light().copyWith(
          primaryColor: appTheme.themeColor,
        ),
        darkTheme: ThemeData.dark().copyWith(
          primaryColor: appTheme.themeColor,
        ),
        themeMode: appTheme.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => const SplashScreen()),
          GetPage(name: '/home', page: () => SwipeableProfilesScreen()),
          GetPage(
              name: '/profile-setup', page: () => const ProfileSetupScreen()),
          GetPage(
            name: '/appearance-settings',
            page: () => const AppearanceSettingsScreen(),
          ),
        ],
        builder: Authenticator.builder(),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthenticationController authController =
      AuthenticationController.authController;

  @override
  void initState() {
    super.initState();
    navigateToNextScreen();
  }

  Future<void> navigateToNextScreen() async {
    try {
      // Ensure user is authenticated
      final user = await Amplify.Auth.getCurrentUser();

      final isComplete = await checkProfileSetupStatus();
      await Future.delayed(const Duration(seconds: 3));
      if (isComplete) {
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        Navigator.of(context).pushReplacementNamed('/profile-setup');
      }
    } catch (e) {
      print('Error in navigation: $e');
      Navigator.of(context).pushReplacementNamed('/login'); // Optional login route
    }
  }

  Future<bool> checkProfileSetupStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool('isProfileSetupComplete') ?? false;
    } catch (e) {
      print('Error checking profile setup status: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink, Colors.red],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("images/logo.png", width: 200),
              const SizedBox(height: 20),
              const Text(
                "Welcome to Varsity Dating",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "The campus is buzzing, login to connect with your crush!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppTheme {
  final bool isDarkMode;
  final Color themeColor;

  AppTheme({required this.isDarkMode, required this.themeColor});

  static Future<AppTheme> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool('isDarkMode') ?? false;
    final themeColorValue =
        prefs.getInt('themeColor') ?? Colors.deepPurple.value;
    return AppTheme(
      isDarkMode: isDarkMode,
      themeColor: Color(themeColorValue),
    );
  }
}
