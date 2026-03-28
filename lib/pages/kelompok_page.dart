import 'package:flutter/material.dart';

class KelompokPage extends StatelessWidget {

  final List<Map<String, String>> users = const [
    {'username': 'Afif Maulana B', 'nim': '123210051'},
    {'username': 'Muhammad Harsin', 'nim': '123200014'},
    {'username': 'Syaidatul Munawwirah', 'nim': '123230036'},
    {'username': 'Mada Soneta', 'nim': '123230184'},
  ];

  // 🔤 Ambil inisial nama
  String getInitial(String name) {
    List<String> parts = name.split(" ");
    if (parts.length == 1) return parts[0][0];
    return parts[0][0] + parts[1][0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Kelompok"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green, Colors.teal],
            ),
          ),
        ),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];

          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),

                // 👤 Avatar dengan inisial
                leading: CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.teal,
                  child: Text(
                    getInitial(user['username']!),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                title: Text(
                  user['username']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                subtitle: Text("NIM: ${user['nim']}"),

                trailing: const Icon(Icons.arrow_forward_ios, size: 16),

                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      title: const Text("Detail Mahasiswa"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.person, size: 50),
                          const SizedBox(height: 10),
                          Text(user['username']!,
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text("NIM: ${user['nim']}"),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Tutup"),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}