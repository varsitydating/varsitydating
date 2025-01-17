// ignore: unused_import
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:varsitydating/homeScreen/swipeable_profiles_screen.dart';
import 'package:varsitydating/homeScreen/chat_screen.dart';
import 'package:varsitydating/homeScreen/discover_screen.dart';
import 'package:varsitydating/homeScreen/likedby_screen.dart';
import 'package:varsitydating/homeScreen/app_settings_screen.dart';
import 'package:varsitydating/models/UserProfile.dart' as custom_model;

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  custom_model.UserProfile? userProfile;
  String displayName = "User";
  int age = 0;
  List<String> uploadedImages = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    try {
      final userId = (await Amplify.Auth.getCurrentUser()).userId;
      final fetchedUserProfile = await Amplify.DataStore.query(
        custom_model.UserProfile.classType,
        where: custom_model.UserProfile.ID.eq(userId),
      );

      if (fetchedUserProfile.isNotEmpty) {
        setState(() {
          userProfile = fetchedUserProfile.first;
          displayName = '${userProfile?.name ?? "User"} ${userProfile?.surname ?? ""}';
          age = calculateAge(userProfile?.dob);
          uploadedImages = userProfile?.profileImageURL != null
              ? userProfile!.profileImageURL!.split(",")
              : [];
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching profile: $e")),
      );
    }
  }

  int calculateAge(TemporalDate? dob) {
    if (dob == null) return 0;
    final birthDate = DateTime.parse(dob.format());
    final today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Varsity Dating'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AppSettingsScreen()),
            ),
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : userProfile != null
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 16.0),
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: userProfile?.profileImageURL != null
                              ? NetworkImage(userProfile!.profileImageURL!)
                              : const AssetImage('assets/default_profile_image.png')
                                  as ImageProvider,
                        ),
                        const SizedBox(height: 16.0),
                        Text(
                          'Hi, $displayName',
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Feels good to be $age',
                          style: const TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                        const SizedBox(height: 20.0),
                        if (uploadedImages.isNotEmpty)
                          Wrap(
                            spacing: 10.0,
                            runSpacing: 10.0,
                            children: uploadedImages
                                .map((imageUrl) => ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        imageUrl,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ))
                                .toList(),
                          )
                        else
                          const Text("No images uploaded."),
                        const SizedBox(height: 20.0),
                        const Text(
                          "Upgrade to Premium or Student Plus",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.orange),
                        ),
                        const SizedBox(height: 10.0),
                        Column(
                          children: [
                            upgradeCard(
                              title: "Premium Account",
                              description:
                                  "Unlock exclusive features like advanced filters and unlimited swipes.",
                              color: Colors.orange[300],
                            ),
                            const SizedBox(height: 10),
                            upgradeCard(
                              title: "Student Plus Account",
                              description:
                                  "Enjoy all premium features at a discounted rate for students!",
                              color: Colors.blue[300],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              : const Center(
                  child: Text("No profile data available."),
                ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        currentIndex: 4,
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LikedByScreen()),
              );
              break;
          }
        },
      ),
    );
  }

  Widget upgradeCard({
    required String title,
    required String description,
    required Color? color,
  }) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(color: Colors.grey.shade300, width: 1.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 8.0),
            Text(
              description,
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}
