import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HariWetonPage extends StatefulWidget {
  const HariWetonPage({Key? key}) : super(key: key);

  @override
  State<HariWetonPage> createState() => _HariWetonPageState();
}

class _HariWetonPageState extends State<HariWetonPage> {
  DateTime? selectedDate;
  String hasil = "";
  String? error;

  final hariList = ["Minggu","Senin","Selasa","Rabu","Kamis","Jumat","Sabtu"];
  final wetonList = ["Kliwon","Legi","Pahing","Pon","Wage"];

  void hitung() {
    if (selectedDate == null) {
      setState(() => error = "Silakan pilih tanggal terlebih dahulu");
      return;
    }

    int hari = selectedDate!.weekday % 7;
    int weton = selectedDate!.millisecondsSinceEpoch ~/ 86400000 % 5;

    setState(() {
      hasil = "${hariList[hari]} ${wetonList[weton]}";
      error = null;
    });
  }

  String formatTanggal() {
    if (selectedDate == null) return "Belum dipilih";
    return DateFormat('dd MMMM yyyy').format(selectedDate!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hari & Weton"),
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
                    const Icon(Icons.calendar_month,
                        size: 70, color: Colors.green),

                    const SizedBox(height: 10),

                    const Text(
                      "Cek Hari & Weton",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 20),

                    // 📅 Tanggal yang dipilih
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        formatTanggal(),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),

                    const SizedBox(height: 15),

                    ElevatedButton.icon(
                      onPressed: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                        );
                        setState(() => selectedDate = picked);
                      },
                      icon: const Icon(Icons.date_range),
                      label: const Text("Pilih Tanggal"),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                      ),
                    ),

                    if (error != null) ...[
                      const SizedBox(height: 10),
                      Text(error!,
                          style: const TextStyle(color: Colors.red)),
                    ],

                    const SizedBox(height: 15),

                    ElevatedButton.icon(
                      onPressed: hitung,
                      icon: const Icon(Icons.calculate),
                      label: const Text("Hitung"),
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
                          const Text(
                            "Hasil",
                            style: TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            hasil.isEmpty ? "-" : hasil,
                            style: const TextStyle(
                              fontSize: 26,
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
                        "- Pilih tanggal terlebih dahulu\n"
                        "- Tanggal harus valid\n"
                        "- Rentang tahun 1900 - 2100",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
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