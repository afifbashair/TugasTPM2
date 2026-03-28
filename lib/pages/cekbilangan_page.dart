import 'package:flutter/material.dart';

class CekbilanganPage extends StatefulWidget {
  const CekbilanganPage({Key? key}) : super(key: key);

  @override
  State<CekbilanganPage> createState() => _CekbilanganPageState();
}

class _CekbilanganPageState extends State<CekbilanganPage> {
  final TextEditingController angka = TextEditingController();
  String hasil = "";
  String? error;

  // ⚡ Optimasi cek prima (cukup sampai √n)
  bool isPrima(int n) {
    if (n <= 1) return false;
    if (n == 2) return true;
    if (n % 2 == 0) return false;

    for (int i = 3; i * i <= n; i += 2) {
      if (n % i == 0) return false;
    }
    return true;
  }

  void cekBilangan() {
    if (angka.text.isEmpty) {
      setState(() => error = "Input tidak boleh kosong");
      return;
    }

    int? n = int.tryParse(angka.text);

    if (n == null) {
      setState(() => error = "Masukkan angka yang valid");
      return;
    }

    String ganjilGenap = (n % 2 == 0) ? "Genap" : "Ganjil";
    String prima = isPrima(n) ? "Bilangan Prima" : "Bukan Prima";

    setState(() {
      hasil = "$ganjilGenap\n$prima";
      error = null;
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
        title: const Text("Cek Bilangan"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green, Colors.teal],
            ),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.numbers,
                        size: 70, color: Colors.green),

                    const SizedBox(height: 10),

                    const Text(
                      "Cek Ganjil / Genap & Prima",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 20),

                    TextField(
                      controller: angka,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Masukkan angka",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.calculate),
                      ),
                    ),

                    if (error != null) ...[
                      const SizedBox(height: 10),
                      Text(error!,
                          style: const TextStyle(color: Colors.red)),
                    ],

                    const SizedBox(height: 15),

                    ElevatedButton.icon(
                      onPressed: cekBilangan,
                      icon: const Icon(Icons.search),
                      label: const Text("Cek"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                      ),
                    ),

                    const SizedBox(height: 25),

                    // ✨ HASIL
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.teal.shade50,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          const Text("Hasil"),
                          const SizedBox(height: 8),
                          Text(
                            hasil.isEmpty ? "-" : hasil,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 15),

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Syarat:\n"
                        "- Input harus angka\n"
                        "- Tidak boleh kosong\n"
                        "- Angka ≥ 0",
                        style: TextStyle(fontSize: 12),
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