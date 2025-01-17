import 'package:flutter/material.dart';
import 'package:varsitydating/homeScreen/swipeable_profiles_screen.dart';
import 'package:varsitydating/homeScreen/chat_screen.dart';
import 'package:varsitydating/homeScreen/discover_screen.dart';
import 'package:varsitydating/homeScreen/user_profile_screen.dart';

class LikedByScreen extends StatelessWidget {
  const LikedByScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liked By'),
      ),
      body: const Center(
        child: Text('Liked By Screen'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color.fromARGB(255, 241, 141, 47),
        unselectedItemColor: Colors.grey,
        currentIndex: 3, // Set current index to 'Liked By'
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const DiscoverScreen()),
              );
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ChatScreen()),
              );
              break;
            case 3:
              // Current screen
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
}
