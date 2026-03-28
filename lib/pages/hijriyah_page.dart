import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

class HijriyahPage extends StatefulWidget {
  const HijriyahPage({Key? key}) : super(key: key);

  @override
  State<HijriyahPage> createState() => _HijriyahPageState();
}

class _HijriyahPageState extends State<HijriyahPage> {
  DateTime? date;
  String hasil = "";
  String? error;

  void convert() {
    if (date == null) {
      setState(() => error = "Silakan pilih tanggal terlebih dahulu");
      return;
    }

    final h = HijriCalendar.fromDate(date!);

    setState(() {
      hasil = "${h.hDay} ${h.longMonthName} ${h.hYear}";
      error = null;
    });
  }

  String formatTanggal() {
    if (date == null) return "Belum dipilih";
    return DateFormat('dd MMMM yyyy', 'id_ID').format(date!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Konversi Hijriyah"),
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
                    const Icon(Icons.mosque,
                        size: 70, color: Colors.green),

                    const SizedBox(height: 10),

                    const Text(
                      "Konversi ke Hijriyah",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 20),

                    // 📅 Tanggal dipilih
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
                        setState(() => date = picked);
                      },
                      icon: const Icon(Icons.date_range),
                      label: const Text("Pilih Tanggal"),
                    ),

                    if (error != null) ...[
                      const SizedBox(height: 10),
                      Text(error!,
                          style: const TextStyle(color: Colors.red)),
                    ],

                    const SizedBox(height: 15),

                    ElevatedButton.icon(
                      onPressed: convert,
                      icon: const Icon(Icons.calculate),
                      label: const Text("Konversi"),
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
                          const Text("Hasil Hijriyah"),
                          const SizedBox(height: 8),
                          Text(
                            hasil.isEmpty ? "-" : hasil,
                            style: const TextStyle(
                              fontSize: 24,
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