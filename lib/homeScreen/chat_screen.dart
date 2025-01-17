import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:varsitydating/homeScreen/discover_screen.dart';
import 'package:varsitydating/homeScreen/likedby_screen.dart';
import 'package:varsitydating/homeScreen/swipeable_profiles_screen.dart';
import 'package:varsitydating/homeScreen/user_profile_screen.dart';
// ignore: unused_import
import 'package:varsitydating/homeScreen/chat/message_screen.dart';
import 'package:varsitydating/models/UserProfile.dart' as custom_model; // Updated model import

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  Future<List<custom_model.UserProfile>> fetchUsers() async {
    try {
      final users = await Amplify.DataStore.query(custom_model.UserProfile.classType);
      return users;
    } catch (e) {
      debugPrint("Error fetching users: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<custom_model.UserProfile>>(
        future: fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No chats available'));
          }

          final users = snapshot.data!;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              final dob = user.dob?.getDateTime() ?? DateTime.now();
              final age = DateTime.now().year - dob.year - ((DateTime.now().month < dob.month || (DateTime.now().month == dob.month && DateTime.now().day < dob.day)) ? 1 : 0);
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: user.profileImageURL!.isNotEmpty
                      ? NetworkImage(user.profileImageURL!)
                      : null,
                  child: user.profileImageURL!.isEmpty
                      ? Text(user.name[0])
                      : null,
                ),
                title: Text(user.name),
                subtitle: Text('Age: $age'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MessageScreen(
                        chatName: user.name,
                        age: age,
                        profileImageURL: user.profileImageURL!,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color.fromARGB(255, 241, 141, 47),
        unselectedItemColor: Colors.grey,
        currentIndex: 2, // Set current index to 'Chats'
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
              // Current screen
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
}

class MessageScreen extends StatelessWidget {
  final String chatName;
  final int age;
  final String profileImageURL;

  const MessageScreen({
    super.key,
    required this.chatName,
    required this.age,
    required this.profileImageURL,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: profileImageURL.isNotEmpty
                  ? NetworkImage(profileImageURL)
                  : null,
              child: profileImageURL.isEmpty
                  ? Text(chatName[0])
                  : null,
            ),
            const SizedBox(width: 10),
            Text('$chatName, $age'),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true, // Start from the bottom
              itemCount: 20, // Replace with the actual number of messages
              itemBuilder: (context, index) {
                final isSender = index % 2 == 0;
                return Align(
                  alignment: isSender
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isSender
                          ? Colors.grey[200]
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Message $index', // Replace with actual message data
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${DateTime.now().hour}:${DateTime.now().minute}', // Replace with actual time
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                FloatingActionButton(
                  onPressed: () {},
                  mini: true,
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
