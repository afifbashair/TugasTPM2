import 'package:flutter/material.dart';

class KalkulatorPage extends StatefulWidget {
  const KalkulatorPage({Key? key}) : super(key: key);

  @override
  _KalkulatorPageState createState() => _KalkulatorPageState();
}

class _KalkulatorPageState extends State<KalkulatorPage> {
  TextEditingController angka1 = TextEditingController();
  TextEditingController angka2 = TextEditingController();

  String hasil = "";

  void tambah() {
    double a = double.parse(angka1.text);
    double b = double.parse(angka2.text);

    setState(() {
      hasil = "Hasil Penjumlahan: ${a + b}";
    });
  }

  void kurang() {
    double a = double.parse(angka1.text);
    double b = double.parse(angka2.text);

    setState(() {
      hasil = "Hasil Pengurangan: ${a - b}";
    });
  }

  @override
  void dispose() {
    angka1.dispose();
    angka2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Penjumlahan & Pengurangan"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: angka1,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Masukkan angka pertama",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: angka2,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Masukkan angka kedua",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: tambah,
                  child: const Text("Tambah"),
                ),

                const SizedBox(width: 20),

                ElevatedButton(
                  onPressed: kurang,
                  child: const Text("Kurang"),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Text(
              hasil,
              style: const TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}