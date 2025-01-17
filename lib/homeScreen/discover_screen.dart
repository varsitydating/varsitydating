import 'package:flutter/material.dart';
import 'dart:async';
import 'package:varsitydating/homeScreen/swipeable_profiles_screen.dart';
import 'package:varsitydating/homeScreen/chat_screen.dart';
import 'package:varsitydating/homeScreen/likedby_screen.dart';
import 'package:varsitydating/homeScreen/user_profile_screen.dart';
import 'package:varsitydating/homeScreen/discover/daily_poll_screen.dart';
import 'package:varsitydating/homeScreen/discover/join_group_screen.dart';
import 'package:varsitydating/homeScreen/discover/campus_events_screen.dart';
import 'package:varsitydating/homeScreen/discover/campus_streams_screen.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  int currentMessageIndex = 0;
  final List<String> messages = [
    "You’re not just my love; you’re my favorite study partner and my reason to succeed.",
    "Every moment with you feels like solving the perfect equation of life.",
    "With you by my side, every challenge feels like a multiple-choice question with only one correct answer: us.",
    "Together, we make the perfect team—like coffee and late-night study sessions.",
    "You inspire me to dream bigger, study harder, and love deeper.",
    "Your love makes my world brighter than the campus lights at night.",
  ];

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(minutes: 2), (timer) {
      setState(() {
        currentMessageIndex = (currentMessageIndex + 1) % messages.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset('images/logo.png', height: 40),
            const SizedBox(width: 8.0),
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
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            color: Colors.grey[850],
            onPressed: () {
              // Add navigation logic to settings screen
            },
          ),
          IconButton(
            icon: const Icon(Icons.menu),
            color: Colors.grey[850],
            onPressed: () {
              // Add navigation logic to app settings screen
            },
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          // Wide Card with Rotating Messages
          Container(
            color: Colors.amber[200],
            height: 80,
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.center,
            child: Text(
              messages[currentMessageIndex],
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          // Buttons Grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            padding: const EdgeInsets.all(8.0),
            children: [
              _buildButton(
                context,
                icon: Icons.poll,
                title: "Daily Poll",
                color: Colors.greenAccent,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DailyPollScreen()),
                ),
              ),
              _buildButton(
                context,
                icon: Icons.group,
                title: "Join a Group",
                color: Colors.lightBlueAccent,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => JoinGroupScreen()),
                ),
              ),
              _buildButton(
                context,
                icon: Icons.event,
                title: "Campus Events",
                color: Colors.pinkAccent,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CampusEventsScreen()),
                ),
              ),
              _buildButton(
                context,
                icon: Icons.live_tv,
                title: "Campus Streams",
                color: Colors.orangeAccent,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CampusStreamsScreen()),
                ),
              ),
              _buildPlaceholderButton(
                context,
                icon: Icons.coffee,
                title: "Coffee Meetups",
                color: Colors.brown,
              ),
              _buildPlaceholderButton(
                context,
                icon: Icons.flash_on,
                title: "Speed Dating",
                color: Colors.redAccent,
              ),
              _buildPlaceholderButton(
                context,
                icon: Icons.gamepad,
                title: "Game Nights",
                color: Colors.purple,
              ),
              _buildPlaceholderButton(
                context,
                icon: Icons.photo_camera,
                title: "Photo Contests",
                color: Colors.teal,
              ),
              _buildPlaceholderButton(
                context,
                icon: Icons.food_bank,
                title: "Food Fests",
                color: Colors.orange,
              ),
              _buildPlaceholderButton(
                context,
                icon: Icons.nature_people,
                title: "Outdoor Adventures",
                color: Colors.lightGreen,
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color.fromARGB(255, 241, 141, 47),
        unselectedItemColor: Colors.grey,
        currentIndex: 1, // Set current index to 'Discover'
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.swipe), label: 'Swipe'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Discover'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chats'),
          BottomNavigationBarItem(icon: Icon(Icons.thumb_up), label: 'Liked By'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SwipeableProfilesScreen()),
              );
              break;
            case 1:
              // Stay on the current screen
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ChatScreen()),
              );
              break;
            case 3:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LikedByScreen()),
              );
              break;
            case 4:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const UserProfileScreen()),
              );
              break;
          }
        },
      ),
    );
  }

  Widget _buildButton(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      color: color,
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.white),
              const SizedBox(height: 8.0),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholderButton(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
  }) {
    return _buildButton(
      context,
      icon: icon,
      title: title,
      color: color,
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$title feature is coming soon!')),
        );
      },
    );
  }
}
