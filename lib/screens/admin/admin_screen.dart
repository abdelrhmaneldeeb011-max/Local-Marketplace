import 'package:wafrnalak/models/store.dart';
import 'package:wafrnalak/models/user.dart';
import 'package:wafrnalak/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  List<Store> _stores = [];
  List<User> _users = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final stores = await ApiService.getAdminStores();
      final users = await ApiService.getAdminUsers();
      if (mounted) {
        setState(() {
          _stores = stores;
          _users = users;
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _toggleStoreStatus(Store store) async {
    try {
      await ApiService.updateStoreStatus(store.id, !store.active);
      _load();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update store')),
        );
      }
    }
  }

  Future<void> _deleteStore(int storeId) async {
    try {
      await ApiService.deleteStore(storeId);
      _load();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete store')),
        );
      }
    }
  }

  Future<void> _toggleBlockUser(User user) async {
    try {
      await ApiService.blockUser(user.id, !user.blocked);
      _load();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update user')),
        );
      }
    }
  }

  Future<void> _deleteUser(int userId) async {
    try {
      await ApiService.deleteUser(userId);
      _load();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete user')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("admin_panel".tr()),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _load,
          ),
        ],
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "manage_stores".tr(),
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  if (_stores.isEmpty)
                    Text('No stores found'.tr(), style: TextStyle(color: Colors.grey)),
                  ..._stores.map((store) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.red.shade100,
                          child: const Icon(Icons.store, color: Colors.red),
                        ),
                        title: Text(store.name),
                        subtitle: Text("${"owner".tr()}: ${store.owner ?? ''}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                store.active ? Icons.block : Icons.check_circle,
                                color: store.active ? Colors.red : Colors.green,
                              ),
                              onPressed: () => _toggleStoreStatus(store),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.black54),
                              onPressed: () => _deleteStore(store.id),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 25),
                  Text(
                    "manage_users".tr(),
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  if (_users.isEmpty)
                    Text('No users found'.tr(), style: TextStyle(color: Colors.grey)),
                  ..._users.map((user) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue.shade100,
                          child: const Icon(Icons.person, color: Colors.blue),
                        ),
                        title: Text(user.name),
                        subtitle: Text(user.email),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: user.blocked ? Colors.green : Colors.red,
                              ),
                              onPressed: () => _toggleBlockUser(user),
                              child: Text(
                                user.blocked ? "unblock".tr() : "block".tr(),
                              ),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _deleteUser(user.id),
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
