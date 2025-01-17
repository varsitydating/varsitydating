import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart'; // For swipe functionality
import 'package:varsitydating/models/UserProfile.dart';
import 'package:varsitydating/homeScreen/discover_screen.dart';
import 'package:varsitydating/homeScreen/chat_screen.dart';
import 'package:varsitydating/homeScreen/likedby_screen.dart';
import 'package:varsitydating/homeScreen/user_profile_screen.dart';
import 'package:varsitydating/homeScreen/app_settings_screen.dart';

class SwipeableProfilesScreen extends StatefulWidget {
  const SwipeableProfilesScreen({super.key});

  @override
  _SwipeableProfilesScreenState createState() =>
      _SwipeableProfilesScreenState();
}

class _SwipeableProfilesScreenState extends State<SwipeableProfilesScreen> {
  List<UserProfile> _profiles = [];
  bool _isLoading = true;
  late MatchEngine _matchEngine;

  @override
  void initState() {
    super.initState();
    _fetchProfiles();
  }

  Future<void> _fetchProfiles() async {
    final profiles = await UserProfile.fetchOtherProfiles();
    final swipeItems = profiles.map((profile) {
      return SwipeItem(
        content: profile,
        likeAction: () => print('Liked: ${profile.name}'),
        nopeAction: () => print('Disliked: ${profile.name}'),
      );
    }).toList();

    setState(() {
      _profiles = profiles;
      _isLoading = false;
      _matchEngine = MatchEngine(swipeItems: swipeItems);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 243, 177, 33),
        title: Row(
          children: [
            Image.asset(
              'images/logo.png', // Replace with your logo asset path
              height: 30,
            ),
            const SizedBox(width: 8),
            const Text(
              'Varsity Dating',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AppSettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _profiles.isEmpty
              ? const Center(child: Text('No profiles available'))
              : SwipeCards(
                  matchEngine: _matchEngine,
                  onStackFinished: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('No more profiles to show!')),
                    );
                  },
                  itemBuilder: (context, index) {
                    final profile = _profiles[index];
                    return Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          profile.profileImageURL!.isNotEmpty
                              ? Image.network(
                                  profile.profileImageURL!,
                                  height: 300,
                                  fit: BoxFit.cover,
                                )
                              : const Placeholder(
                                  fallbackHeight: 300,
                                  fallbackWidth: double.infinity,
                                ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              profile.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              profile.university ?? "No bio provided.",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  itemChanged: (item, index) {
                    print('Profile viewed: ${item.content.name}');
                  },
                ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color.fromARGB(255, 241, 141, 47),
        unselectedItemColor: Colors.grey,
        currentIndex: 0, // Set current index to 'Swipe'
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
                MaterialPageRoute(
                    builder: (context) => SwipeableProfilesScreen()),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const DiscoverScreen()),
              );
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
                MaterialPageRoute(
                    builder: (context) => const LikedByScreen()),
              );
              break;
            case 4:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const UserProfileScreen()),
              );
              break;
          }
        },
      ),
    );
  }
}
