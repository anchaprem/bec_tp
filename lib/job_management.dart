import 'package:flutter/material.dart';

class JobManagement extends StatefulWidget {
  const JobManagement({super.key});

  @override
  _JobManagementState createState() => _JobManagementState();
}

class _JobManagementState extends State<JobManagement> {
  List<String> jobs = ["Software Engineer", "Data Analyst"];
  TextEditingController jobController = TextEditingController();

  void addJob() {
    setState(() {
      jobs.add(jobController.text);
      jobController.clear();
    });
  }

  void deleteJob(int index) {
    setState(() {
      jobs.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Manage Jobs")),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: jobController,
                    decoration: InputDecoration(labelText: "Job Title"),
                  ),
                ),
                IconButton(icon: Icon(Icons.add), onPressed: addJob),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: jobs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(jobs[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => deleteJob(index),
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
