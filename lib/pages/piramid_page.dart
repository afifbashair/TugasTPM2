import 'dart:math';
import 'package:flutter/material.dart';

class PiramidPage extends StatefulWidget {
  const PiramidPage({Key? key}) : super(key: key);

  @override
  State<PiramidPage> createState() => _PiramidPageState();
}

class _PiramidPageState extends State<PiramidPage> {
  final TextEditingController panjang = TextEditingController();
  final TextEditingController lebar = TextEditingController();
  final TextEditingController tinggi = TextEditingController();

  String? e1, e2, e3;

  double? luas;
  double? volume;

  bool validasi() {
    bool valid = true;

    if (panjang.text.isEmpty) {
      e1 = "Tidak boleh kosong";
      valid = false;
    } else if (double.tryParse(panjang.text) == null) {
      e1 = "Harus angka";
      valid = false;
    } else {
      e1 = null;
    }

    if (lebar.text.isEmpty) {
      e2 = "Tidak boleh kosong";
      valid = false;
    } else if (double.tryParse(lebar.text) == null) {
      e2 = "Harus angka";
      valid = false;
    } else {
      e2 = null;
    }

    if (tinggi.text.isEmpty) {
      e3 = "Tidak boleh kosong";
      valid = false;
    } else if (double.tryParse(tinggi.text) == null) {
      e3 = "Harus angka";
      valid = false;
    } else {
      e3 = null;
    }

    setState(() {});
    return valid;
  }

  void hitung() {
    if (!validasi()) return;

    double p = double.parse(panjang.text);
    double l = double.parse(lebar.text);
    double t = double.parse(tinggi.text);

    // 🔺 Hitung tinggi miring otomatis
    double s1 = sqrt(pow(l / 2, 2) + pow(t, 2));
    double s2 = sqrt(pow(p / 2, 2) + pow(t, 2));

    double alas = p * l;

    setState(() {
      luas = alas + (p * s1) + (l * s2);
      volume = (1 / 3) * alas * t;
    });
  }

  void reset() {
    panjang.clear();
    lebar.clear();
    tinggi.clear();

    setState(() {
      luas = null;
      volume = null;
      e1 = e2 = e3 = null;
    });
  }

  Widget inputField(String label, TextEditingController c, String? error) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: c,
        keyboardType:
            const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          labelText: label,
          errorText: error,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    panjang.dispose();
    lebar.dispose();
    tinggi.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Piramid Otomatis"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange, Colors.deepOrange],
            ),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Icon(Icons.change_history,
                        size: 60, color: Colors.orange),

                    const SizedBox(height: 10),

                    const Text(
                      "Input 3 Nilai Saja",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 20),

                    inputField("Panjang Alas (p)", panjang, e1),
                    inputField("Lebar Alas (l)", lebar, e2),
                    inputField("Tinggi Piramid (t)", tinggi, e3),

                    const SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: hitung,
                          icon: const Icon(Icons.calculate),
                          label: const Text("Hitung"),
                        ),
                        OutlinedButton.icon(
                          onPressed: reset,
                          icon: const Icon(Icons.refresh),
                          label: const Text("Reset"),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Text(
                            luas == null
                                ? "Luas belum dihitung"
                                : "Luas: ${luas!.toStringAsFixed(2)}",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            volume == null
                                ? "Volume belum dihitung"
                                : "Volume: ${volume!.toStringAsFixed(2)}",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 15),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Catatan:\n"
                        "- Tinggi miring dihitung otomatis\n"
                        "- Hanya perlu 3 input\n"
                        "- Gunakan angka positif",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[700],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}