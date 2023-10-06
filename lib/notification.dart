import 'package:flutter/material.dart';

class Notification {
  final String userName;
  final String userAvatar;
  final String exchangeStatus;
  final String itemPhoto;
  final String timeAgo;

  Notification({
    required this.userName,
    required this.userAvatar,
    required this.exchangeStatus,
    required this.itemPhoto,
    required this.timeAgo,
  });
}

class NotificationWidget extends StatefulWidget {
  @override
  _NotificationWidgetState createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  List<Notification> notifications = [
    Notification(
      userName: "Tricia",
      userAvatar: "assets/images/tricia.png",
      exchangeStatus: " accepted your exchange request. ",
      itemPhoto: "assets/images/doll.png",
      timeAgo: "just now",
    ),
    Notification(
      userName: "CC",
      userAvatar: "assets/images/athena.png",
      exchangeStatus: " sent a request to exchange. ",
      itemPhoto: "assets/images/doll.png",
      timeAgo: "today",
    ),
    Notification(
      userName: "Ryan",
      userAvatar: "assets/images/ryan.png",
      exchangeStatus: " sent a request to exchange. ",
      itemPhoto: "assets/images/doll.png",
      timeAgo: "1d",
    ),
    Notification(
      userName: "Mandy",
      userAvatar: "assets/images/mandy.png",
      exchangeStatus: " sent a request to exchange. ",
      itemPhoto: "assets/images/doll.png",
      timeAgo: "3d",
    ),
  ];

  // Method to add new notifications
  void addNotification(Notification notification) {
    setState(() {
      notifications.add(notification);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 196, 194, 178),
        title: const Text('Notification'),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return NotificationCard(notification: notifications[index]);
        },
      ),
      //floatingActionButton: FloatingActionButton(
      //  onPressed: () {
      // Simulated: Add a new notification when the button is pressed
      //    addNotification(Notification(message: '同意了你的申請。'));
      //  },
      //  child: Icon(Icons.add),
      //),
    );
  }

  // Helper method to create a notification row
  Widget _buildNotificationRow(String message) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(width: 12),
              Text(
                message,
                textAlign: TextAlign.left,
                style: TextStyle(
                  //color: undefined,
                  fontFamily: 'Basic',
                  fontSize: 14,
                  letterSpacing: 0,
                  fontWeight: FontWeight.normal,
                  height: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final Notification notification;

  NotificationCard({required this.notification});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(notification.userAvatar),
        ),
        title: Text(notification.userName),
        subtitle:
            Text("${notification.exchangeStatus} ${notification.timeAgo}"),
        trailing: Image.asset(
          notification.itemPhoto,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
