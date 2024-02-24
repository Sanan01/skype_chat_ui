import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.lightBlueAccent,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          centerTitle: true, // Center the title (avatar)
        ),
      ),
      home: const ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int _selectedIndex = 0;

  final List<ChatMessage> _messages = [
    ChatMessage(
      text: 'Call ended - 28m 27s',
      sender: 'Sanan',
      imageUrl: 'https://via.placeholder.com/50',
      time: DateTime.now(),
      status: UserStatus.active,
    ),
    ChatMessage(
      text: 'Hello! How are you?',
      sender: 'Awwab',
      imageUrl: 'https://via.placeholder.com/50',
      time: DateTime.now(),
      status: UserStatus.away,
    ),
    ChatMessage(
      text: 'Talk to you later!',
      sender: 'Alice',
      imageUrl: 'https://via.placeholder.com/50',
      time: DateTime.now(),
      status: UserStatus.defaultStatus,
    ),
    ChatMessage(
      text: 'Inshallah! Take care!',
      sender: 'Junaid',
      imageUrl: 'https://via.placeholder.com/50',
      time: DateTime.now(),
      status: UserStatus.offline,
    ),
    ChatMessage(
      text: 'Gari dekhne ajao?!',
      sender: 'Sunil',
      imageUrl: 'https://via.placeholder.com/50',
      time: DateTime.now(),
      status: UserStatus.away,
    ),
    ChatMessage(
      text: 'Shanu, kya haal hai?',
      sender: 'Salman 😈',
      imageUrl: 'https://via.placeholder.com/50',
      time: DateTime.now(),
      status: UserStatus.away,
    ),
  ];

  String formatDate(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {
            // Add your notification button functionality here
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.videocam),
            onPressed: () {
              // Add your video call button functionality here
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Add your search button functionality here
            },
          ),
          PopupMenuButton(
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              const PopupMenuItem(
                value: 'settings',
                child: Text('Settings'),
              ),
              const PopupMenuItem(
                value: 'logout',
                child: Text('Logout'),
              ),
            ],
            onSelected: (value) {
              // Add your menu button functionality here
            },
          ),
        ],
        title: Stack(
          children: [
            const CircleAvatar(
              backgroundImage: NetworkImage('https://via.placeholder.com/50'),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),
        bottom: const PreferredSize(
          preferredSize:
              Size.fromHeight(0.0), // Adjust the height of the bottom border
          child: Divider(
            // color: Colors.black, // Adjust the color of the bottom border
            height: 1.0,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Chats',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) {
                // Assuming _messages contains a status property for each message
                UserStatus status = _messages[index].status;

                return ChatMessageListItem(
                  message: _messages[index],
                  formatDate: formatDate,
                  status: status,
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue[700], // Set selected item color
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: 'Calls',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: 'Contacts',
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final String sender;
  final String imageUrl;
  final DateTime time;
  final UserStatus status;

  ChatMessage({
    required this.text,
    required this.sender,
    required this.imageUrl,
    required this.time,
    required this.status,
  });
}

class ChatMessageListItem extends StatelessWidget {
  final ChatMessage message;
  final String Function(DateTime) formatDate;
  final UserStatus status; // Add user status property

  const ChatMessageListItem({
    Key? key,
    required this.message,
    required this.formatDate,
    required this.status, // Add status parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color statusColor = _getStatusColor(status); // Get color based on status

    return Padding(
      padding:
          const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(message.imageUrl),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.sender,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  message.text,
                  style: const TextStyle(
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4.0),
                const Divider(
                  color: Colors.grey, // Change the color of the line as needed
                  thickness: 1, // Change the thickness of the line as needed
                ),
              ],
            ),
          ),
          Text(
            formatDate(message.time),
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.grey,
            ),
          ),
          const Divider(
            color: Colors.grey, // Change the color of the line as needed
            thickness: 1, // Change the thickness of the line as needed
          ),
        ],
      ),
    );
  }

  // Helper function to get color based on user status
  Color _getStatusColor(UserStatus status) {
    switch (status) {
      case UserStatus.active:
        return Colors.green;
      case UserStatus.away:
        return Colors.yellow;
      case UserStatus.offline:
        return Colors.red;
      default:
        return Colors.grey; // Default color for unknown status
    }
  }
}

// Enum to represent user status
enum UserStatus {
  active,
  away,
  offline,
  defaultStatus,
}
