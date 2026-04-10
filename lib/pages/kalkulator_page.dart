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
  String? error1;
  String? error2;

  bool validasi() {
    bool isValid = true;

    if (angka1.text.isEmpty) {
      error1 = "Tidak boleh kosong";
      isValid = false;
    } else if (!RegExp(r'^-?\d+(\.\d+)?$').hasMatch(angka1.text)) {
      error1 = "Harus angka";
      isValid = false;
    } else {
      error1 = null;
    }

    if (angka2.text.isEmpty) {
      error2 = "Tidak boleh kosong";
      isValid = false;
    } else if (!RegExp(r'^-?\d+(\.\d+)?$').hasMatch(angka2.text)) {
      error2 = "Harus angka";
      isValid = false;
    } else {
      error2 = null;
    }

    setState(() {});
    return isValid;
  }

  void tambah() {
    if (!validasi()) return;

    double a = double.parse(angka1.text);
    double b = double.parse(angka2.text);

    setState(() {
      hasil = "Hasil Penjumlahan: ${a + b}";
    });
  }

  void kurang() {
    if (!validasi()) return;

    double a = double.parse(angka1.text);
    double b = double.parse(angka2.text);

    setState(() {
      hasil = "Hasil Pengurangan: ${a - b}";
    });
  }

  void reset() {
    angka1.clear();
    angka2.clear();
    setState(() {
      hasil = "";
      error1 = null;
      error2 = null;
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
        title: const Text("Kalkulator Sederhana"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
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
                    Icon(Icons.calculate, size: 60, color: Colors.blue),

                    const SizedBox(height: 10),

                    const Text(
                      "Penjumlahan & Pengurangan",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    TextField(
                      controller: angka1,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Angka pertama",
                        errorText: error1,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    TextField(
                      controller: angka2,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Angka kedua",
                        errorText: error2,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: tambah,
                          icon: const Icon(Icons.add),
                          label: const Text("Tambah"),
                        ),
                        ElevatedButton.icon(
                          onPressed: kurang,
                          icon: const Icon(Icons.remove),
                          label: const Text("Kurang"),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    OutlinedButton.icon(
                      onPressed: reset,
                      icon: const Icon(Icons.refresh),
                      label: const Text("Reset"),
                    ),

                    const SizedBox(height: 20),

                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        hasil.isEmpty ? "Hasil akan muncul di sini" : hasil,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Syarat Input:\n"
                        "- Tidak boleh kosong\n"
                        "- maksimal 16 angka\n"
                        "- Harus berupa angka\n"
                        "- Bisa bilangan desimal\n"
                        "- Contoh: 10 atau 3.5",
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