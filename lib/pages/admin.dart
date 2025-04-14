import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:petmate/provider/notification_provider.dart';
import 'package:petmate/pages/home_page.dart';
import 'package:petmate/pages/favs.dart';
import 'package:petmate/provider/admin_provider.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<AdminPage> {
  int selectedPage = 1;

  final List<IconData> icons = [Icons.home, Icons.admin_panel_settings_rounded];
  final Color deepPurple = Colors.deepPurple;
  final Color grey = Colors.grey;
  final Color white = Colors.white;

  bool isLoggedIn = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;

  void _login() {
    const hardcodedUsername = 'Admin';
    const hardcodedPassword = '1234';

    if (_usernameController.text == hardcodedUsername &&
        _passwordController.text == hardcodedPassword) {
      setState(() {
        isLoggedIn = true;
        _errorMessage = null;
      });
    } else {
      setState(() {
        _errorMessage = 'Invalid username or password';
      });
    }
  }

  Widget _buildLoginForm() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Admin Login', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(labelText: 'Username'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Password'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: _login, child: const Text('Login')),
          if (_errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
            ),
        ],
      ),
    );
  }

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
        title: const Text("Purchase Panel"),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: isLoggedIn
          ? Consumer<NotificationProvider>(
        builder: (context, notificationProvider, child) {
          if (notificationProvider.notifications.isEmpty) {
            return const Center(
              child: Text(
                "No purchase yet!",
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
      )
          : _buildLoginForm(),
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

              Widget nextPage = value == 0 ? const HomePage() : const AdminPage();

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
