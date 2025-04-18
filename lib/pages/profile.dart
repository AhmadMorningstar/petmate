import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:petmate/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:petmate/pages/auth_screen.dart';



class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  int selectedPage = 2; // Profile page index

  final List<IconData> icons = [Icons.home, Icons.location_on, Icons.person];
  final Color deepPurple = Colors.deepPurple;
  final Color grey = Colors.grey;
  final Color white = Colors.white;
  final Uri googleMapsUrl = Uri.parse("https://maps.app.goo.gl/Q7JtMLLLd7f8KjSy9");


  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username'); // Remove the saved username to log out

    // Optionally navigate to login screen after logout
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AuthScreen()), // Replace with login screen or home page
      );
    }
  }

  Future<String?> _getUsernameFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/pfp.jpg'),
          ),
          const SizedBox(height: 10),
          FutureBuilder<String?>(
            future: _getUsernameFromPrefs(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              if (snapshot.hasData) {
                final username = snapshot.data!;
                return Text(
                  username, // Display the username of the logged-in user
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                );
              } else {
                return const Text('User not found');
              }
            },
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: const Text('About Us'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () => _showDialog(context, 'About Us', 'It is a vocational institute working to provide opportunities and workforce for its graduates. It is one of the training centers of Gasha Company for Education, which is a leading company in Kurdistan to provide high-quality educational services.\n\n\nGasha Institute offers five-year educational programs in the fields of petroleum, computer science, management, and accounting. Educators and high-level teachers promote the learning process, graduates earn diplomas, and can become successful careerists in the future. Since its establishment in 2014, our institute has consistently been the leader in the annual assessments of the Ministry of Education at the level of all institutes in Kurdistan.\n\n\nGasha Institute focuses on providing opportunities to develop the broad abilities and talents of all students throughout their learning process based on modern technology and science. Our educational programs emphasize the development of students confidence, initiative, independence, and skills, so that they can make a positive contribution to society and be able to find jobs according to the needs of the labor market.'),
                ),
                ListTile(
                  title: const Text('Privacy Policy'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () => _showDialog(context, 'Privacy Policy', 'Privacy Policy\n\n\nEffective Date: 2025\n\n\nGasha Institute ("we," "our," or "us") respects your privacy and is committed to protecting the personal information you may provide while using this test application ("App"). This Privacy Policy explains how we collect, use, and safeguard your information.\n\n\n1. Information We Collect\n\n\nThis App does not collect personal data from users. Any data displayed within the App is for demonstration purposes only.\n\n\n2. How We Use Your Information\n\n\nSince this is a test application, no user data is collected, stored, or shared. The App may contain links to external resources, such as Google Maps, for navigation purposes.\n\n\n3. Third-Party Services\n\n\nThis App may use third-party services such as Google Maps. These services operate under their own privacy policies, and we encourage users to review them.\n\n\n4. Data Security\n\n\nAs no user data is collected, there is no risk of data breach or unauthorized access within this App.\n\n\n5. Changes to This Privacy Policy\n\n\nThis Privacy Policy may be updated for compliance or informational purposes. Any changes will be reflected within the App.\n\n\nFor more information, visit our official website: https://gie.gasha.edu.iq'),
                ),
                ListTile(
                  title: const Text('Terms & Conditions'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () => _showDialog(context, 'Terms & Conditions', 'Terms & Conditions\n\n\nEffective Date: 2025\n\n\n1. Introduction\n\n\nThese Terms & Conditions ("Terms") govern your use of this test application ("App"), developed for Gasha Institute. By using the App, you agree to comply with these Terms.\n\n\n2. Purpose of the App\n\n\nThis App is for testing and demonstration purposes only. It is not intended for commercial use, data collection, or official transactions.\n\n\n3. User Responsibilities\n\n\nUsers must not misuse the App for unauthorized activities.\n\n\nThe App may include links to external services (e.g., Google Maps); use of these services is subject to their respective policies.\n\n\nThe App content is provided "as is" without guarantees of accuracy.\n\n\n4. Limitations of Liability\n\n\nGasha Institute is not responsible for any errors, malfunctions, or third-party service disruptions while using this App.\n\n\n5. Changes to These Terms\n\n\nThese Terms may be updated periodically. Continued use of the App constitutes acceptance of any modifications.\n\n\nFor more details, visit: https://gie.gasha.edu.iq\n\n\nCopyright 2025 @ Gasha Institute. All Rights Reserved.'),
                ),
                ListTile(
                  title: const Text('Logout'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: _logout,
                  textColor: Colors.red,
                ),
                const SizedBox(height: 20),

                // OpenStreetMap (No API Key Required)
                SizedBox(
                  height: 300,
                  child: FlutterMap(
                    options: MapOptions(
                      initialCenter: LatLng(36.2103168, 44.0654822), // Gasha Institute Location
                      initialZoom: 15.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: ['a', 'b', 'c'],
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: LatLng(36.2103168, 44.0654822),
                            width: 40.0,
                            height: 40.0,
                            child: const Icon(Icons.location_pin, color: Colors.red, size: 40),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
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
            setState(() {
              selectedPage = value;
            });

            if (value == 1) {
              launchUrl(Uri.parse("https://maps.app.goo.gl/Q7JtMLLLd7f8KjSy9"));
            } else {
              Widget nextPage;
              switch (value) {
                case 0:
                  nextPage = const HomePage();
                  break;
                case 2:
                  nextPage = const ProfilePage();
                  break;
                default:
                  nextPage = const ProfilePage();
              }

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

  void _showDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.7, // 60% of screen height
          child: SingleChildScrollView(
            child: Text(content),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
