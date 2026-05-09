import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  List<Map<String, dynamic>> stores = [
    {"name": "مطعم الشام", "owner": "أحمد", "status": true},
    {"name": "بيتزا هت", "owner": "محمد", "status": false},
  ];

  List<Map<String, dynamic>> users = [
    {"name": "عبدالرحمن", "email": "abdo@gmail.com", "blocked": false},
    {"name": "كريم", "email": "karim@gmail.com", "blocked": true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("admin_panel".tr()),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// إدارة المطاعم
            Text(
              "manage_stores".tr(),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            ...stores.map((store) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.red.shade100,
                    child: const Icon(Icons.store, color: Colors.red),
                  ),
                  title: Text(store["name"]),
                  subtitle: Text("${"owner".tr()}: ${store["owner"]}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          store["status"] ? Icons.block : Icons.check_circle,
                          color: store["status"] ? Colors.red : Colors.green,
                        ),
                        onPressed: () {
                          setState(() {
                            store["status"] = !store["status"];
                          });
                        },
                      ),

                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.black54),
                        onPressed: () {
                          setState(() {
                            stores.remove(store);
                          });
                        },
                      ),
                    ],
                  ),
                ),
              );
            }),

            const SizedBox(height: 25),

            /// إدارة المستخدمين
            Text(
              "manage_users".tr(),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            ...users.map((user) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue.shade100,
                    child: const Icon(Icons.person, color: Colors.blue),
                  ),
                  title: Text(user["name"]),
                  subtitle: Text(user["email"]),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: user["blocked"]
                              ? Colors.green
                              : Colors.red,
                        ),
                        onPressed: () {
                          setState(() {
                            user["blocked"] = !user["blocked"];
                          });
                        },
                        child: Text(
                          user["blocked"] ? "unblock".tr() : "block".tr(),
                        ),
                      ),

                      const SizedBox(width: 8),

                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            users.remove(user);
                          });
                        },
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
