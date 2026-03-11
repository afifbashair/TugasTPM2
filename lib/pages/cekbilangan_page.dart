import 'package:flutter/material.dart';

class CekbilanganPage extends StatefulWidget {
  const CekbilanganPage({Key? key}) : super(key: key);

  @override
  _CekbilanganPageState createState() => _CekbilanganPageState();
}

class _CekbilanganPageState extends State<CekbilanganPage> {
  TextEditingController angka = TextEditingController();
  String hasil = "";

  bool isPrima(int n) {
    if (n <= 1) return false;
    for (int i = 2; i < n; i++) {
      if (n % i == 0) return false;
    }
    return true;
  }

  void cekBilangan() {
    int n = int.parse(angka.text);

    String ganjilGenap = (n % 2 == 0) ? "Genap" : "Ganjil";
    String prima = isPrima(n) ? "Bilangan Prima" : "Bukan Prima";

    setState(() {
      hasil = "$ganjilGenap\n$prima";
    });
  }

  @override
  void dispose() {
    angka.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ganjil / Genap & Prima"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: angka,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Masukkan angka",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: cekBilangan,
              child: const Text("Cek"),
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
