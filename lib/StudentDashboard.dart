import 'package:flutter/material.dart';
import 'package:login/oncampus.dart'; // Ensure these are correctly imported
import 'package:login/offcampus.dart';
import 'package:login/announcements.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  _StudentDashboardState createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  int _selectedIndex = 0; // For managing BottomNavigationBar selection
  String selectedPreference = "Admin Preferences";  // Default preference

  // The pages for each section of the bottom navigation
  final List<Widget> _pages = [
    const HomePage(),
    const ProfilePage(),
    const SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Method to show the notification preferences dialog
  void _showNotificationPreferencesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Notification Preferences'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Choose your notification frequency:'),
              ListTile(
                title: const Text('Admin Preferences'),
                leading: Radio<String>(
                  value: 'Admin Preferences',
                  groupValue: selectedPreference,
                  onChanged: (String? value) {
                    setState(() {
                      selectedPreference = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Every 6 hours'),
                leading: Radio<String>(
                  value: '6 hours',
                  groupValue: selectedPreference,
                  onChanged: (String? value) {
                    setState(() {
                      selectedPreference = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Every 12 hours'),
                leading: Radio<String>(
                  value: '12 hours',
                  groupValue: selectedPreference,
                  onChanged: (String? value) {
                    setState(() {
                      selectedPreference = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Every 24 hours'),
                leading: Radio<String>(
                  value: '24 hours',
                  groupValue: selectedPreference,
                  onChanged: (String? value) {
                    setState(() {
                      selectedPreference = value!;
                    });
                  },
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle save logic here
                print('Preference saved: $selectedPreference');
                Navigator.of(context).pop(); // Close the dialog after saving
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: _selectedIndex == 0 ? false : true,  // Hides back button in Home tab
        title: const Text("BEC T&P Cell", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _pages[_selectedIndex], // Displays the selected page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

// Home Page with On-Campus, Off-Campus, Announcements
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(context),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildCategoryCard(context, "On-Campus", "Latest on-campus opportunities", Icons.school, '/on-campus'),
                _buildCategoryCard(context, "Off-Campus", "Off-campus job postings and internships", Icons.business, '/off-campus'),
                _buildCategoryCard(context, "Announcements", "Updates and announcements from admin", Icons.announcement, '/announcements'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade900, Colors.blue.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome Back!",
            style: TextStyle(fontSize: screenWidth < 600 ? 20 : 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 5),
          Text(
            "Explore new job opportunities & track your applications.",
            style: TextStyle(fontSize: screenWidth < 600 ? 12 : 14, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, String title, String subtitle, IconData icon, String route) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route); // Navigate to respective route
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey.shade900, Colors.grey.shade800],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 40, color: Colors.blueAccent),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade400),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Profile Page (To show student details)
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Text("Student Profile", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        // You can display student information here like name, email, etc.
        const Text("Name: Student Name", style: TextStyle(fontSize: 18)),
        const Text("Email: student@example.com", style: TextStyle(fontSize: 18)),
      ],
    );
  }
}

// Settings Page (with Notification Preferences and Logout)
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Text("Settings", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        ListTile(
          leading: const Icon(Icons.notifications),
          title: const Text('Notification Preferences'),
          onTap: () {
            // Show the notification preferences dialog
            _showNotificationPreferencesDialog(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.exit_to_app),
          title: const Text('Logout'),
          onTap: () {
            // Handle Logout functionality here
            Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false); // Redirect to Login screen
          },
        ),
      ],
    );
  }

  void _showNotificationPreferencesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Notification Preferences'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Choose your notification frequency:'),
              ListTile(
                title: const Text('Admin Preferences'),
                leading: Radio<String>(
                  value: 'Admin Preferences',
                  groupValue: 'Admin Preferences', // Use state to manage the selected value
                  onChanged: (String? value) {
                    // Handle radio button change
                  },
                ),
              ),
              ListTile(
                title: const Text('Every 6 hours'),
                leading: Radio<String>(
                  value: '6 hours',
                  groupValue: '6 hours', // Use state to manage the selected value
                  onChanged: (String? value) {
                    // Handle radio button change
                  },
                ),
              ),
              ListTile(
                title: const Text('Every 12 hours'),
                leading: Radio<String>(
                  value: '12 hours',
                  groupValue: '12 hours', // Use state to manage the selected value
                  onChanged: (String? value) {
                    // Handle radio button change
                  },
                ),
              ),
              ListTile(
                title: const Text('Every 24 hours'),
                leading: Radio<String>(
                  value: '24 hours',
                  groupValue: '24 hours', // Use state to manage the selected value
                  onChanged: (String? value) {
                    // Handle radio button change
                  },
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle save logic here
                print('Notification preference saved');
                Navigator.of(context).pop(); // Close the dialog after saving
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
