import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:petmate/provider/notification_provider.dart';
import 'package:petmate/pages/home_page.dart';
import 'package:petmate/pages/favs.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  int selectedPage = 1;

  final List<IconData> icons = [Icons.home, Icons.notifications];
  final Color deepPurple = Colors.deepPurple;
  final Color grey = Colors.grey;
  final Color white = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
        ),

        title: const Text("Notifications"),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: Consumer<NotificationProvider>(
        builder: (context, notificationProvider, child) {
          print("Notification list: ${notificationProvider.notifications}"); // Debugging

          if (notificationProvider.notifications.isEmpty) {
            return const Center(
              child: Text(
                "No notifications yet!",
                style: TextStyle(fontSize: 18, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: notificationProvider.notifications.length,
            itemBuilder: (context, index) {
              var notification = notificationProvider.notifications[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                child: ListTile(
                  title: Text(
                    'Purchase on ${notification['date']}',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    'Total: \$${(notification['totalAmount'] as double).toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
        child: BottomNavigationBar(
          backgroundColor: white,
          selectedItemColor: deepPurple,
          unselectedItemColor: grey,
          elevation: 1,
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedPage,
          onTap: (value) {
            if (value != selectedPage) {
              setState(() {
                selectedPage = value;
              });

              Widget nextPage = value == 0 ? const HomePage() : const FavsPage();

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => nextPage),
              );
            }
          },
          items: List.generate(
            icons.length,
                (index) => BottomNavigationBarItem(
              icon: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    icons[index],
                    color: selectedPage == index ? deepPurple : grey,
                  ),
                  const SizedBox(height: 5),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: selectedPage == index ? 15 : 0,
                    height: selectedPage == index ? 3 : 0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: deepPurple,
                    ),
                  ),
                ],
              ),
              label: '',
            ),
          ),
        ),
      ),
    );
  }
}

