import 'package:flutter/material.dart';

class KelompokPage extends StatelessWidget {

  final List<Map<String, String>> users = const [
    {'username': 'Afif Maulana B', 'nim': '123210051'},
    {'username': 'Muhammad Harsin', 'nim': '123200014'},
    {'username': 'Syaidatul Munawwirah', 'nim': '123230036'},
    {'username': 'Mada Soneta', 'nim': '123230184'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Data Kelompok")),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.person),
              ),
              title: Text(user['username']!),
              subtitle: Text('NIM: ${user['nim']}'),
              onTap: (){},
            ),
          );
        },
      ),
    );
  }
}