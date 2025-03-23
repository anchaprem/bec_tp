import 'package:flutter/material.dart';
import 'package:login/AdminDashboard.dart';
import 'package:login/StudentDashboard.dart';
import 'package:login/oncampus.dart';
import 'package:login/offcampus.dart';
import 'package:login/announcements.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      routes: {
        '/student': (context) => StudentDashboard(),
        '/admin': (context) => AdminDashboard(),
        '/on-campus': (context) => const OnCampusPage(),
        '/off-campus': (context) => const OffCampusPage(),
        '/announcements': (context) => const AnnouncementsPage(),
        '/login': (context) => LoginScreen(),
      },
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isStudent = true;
  bool obscurePassword = true;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() {
    String username = usernameController.text;
    String password = passwordController.text;

    if (isStudent) {
      // Student login only requires the correct username
      if (username == "Y21AIT4052002") {
        Navigator.pushNamed(context, '/student');
      } else {
        _showErrorDialog('Invalid Student Username');
      }
    } else {
      // Admin login requires both the correct username and password
      if (username == "admin01" && password == "12345") {
        Navigator.pushNamed(context, '/admin');
      } else {
        _showErrorDialog('Invalid Admin Credentials');
      }
    }
  }

  // Show error dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Login Failed'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.pink],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.school, size: 80, color: Colors.white),
              SizedBox(height: 10),
              Text("${isStudent ? 'Student' : 'Admin'} Login",
                  style: TextStyle(fontSize: 24, color: Colors.white)),
              SizedBox(height: 20),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Username',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(height: 10),
              if (!isStudent)
                TextField(
                  controller: passwordController,
                  obscureText: obscurePassword,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: 'Password',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscurePassword ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                    ),
                  ),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                ),
                child: Text("Login", style: TextStyle(fontSize: 18)),
              ),
              SizedBox(height: 20),
              ToggleButtons(
                isSelected: [isStudent, !isStudent],
                selectedColor: Colors.white,
                fillColor: Colors.black26,
                borderRadius: BorderRadius.circular(10),
                children: [
                  Padding(padding: EdgeInsets.all(10), child: Text("Student")),
                  Padding(padding: EdgeInsets.all(10), child: Text("Admin")),
                ],
                onPressed: (index) {
                  setState(() {
                    isStudent = index == 0;
                    usernameController.clear();
                    passwordController.clear();
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
