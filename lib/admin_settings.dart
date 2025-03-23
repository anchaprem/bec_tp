import 'package:flutter/material.dart';

class AdminSettings extends StatefulWidget {
  const AdminSettings({super.key});

  @override
  _AdminSettingsState createState() => _AdminSettingsState();
}

class _AdminSettingsState extends State<AdminSettings> {
  List<String> admins = ["admin1@example.com", "admin2@example.com"];
  TextEditingController adminController = TextEditingController();

  void addAdmin() {
    setState(() {
      admins.add(adminController.text);
      adminController.clear();
    });
  }

  void removeAdmin(int index) {
    setState(() {
      admins.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Manage Admins")),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: adminController,
                    decoration: InputDecoration(labelText: "Admin Email"),
                  ),
                ),
                IconButton(icon: Icon(Icons.add), onPressed: addAdmin),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: admins.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(admins[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => removeAdmin(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
