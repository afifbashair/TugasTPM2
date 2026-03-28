import 'package:flutter/material.dart';

class SakaPage extends StatefulWidget {
  const SakaPage({Key? key}) : super(key: key);

  @override
  State<SakaPage> createState() => _SakaPageState();
}

class _SakaPageState extends State<SakaPage> {
  DateTime? date;
  String hasil = "";
  String? error;

  final sakaMonths = [
    "Chaitra",
    "Vaisakha",
    "Jyaistha",
    "Ashadha",
    "Shravana",
    "Bhadra",
    "Ashwin",
    "Kartika",
    "Agrahayana",
    "Pausha",
    "Magha",
    "Phalguna"
  ];

  // 📅 Format tanggal manual
  String formatTanggal(DateTime? date) {
    if (date == null) return "Belum dipilih";

    const bulan = [
      "Januari","Februari","Maret","April","Mei","Juni",
      "Juli","Agustus","September","Oktober","November","Desember"
    ];

    return "${date.day} ${bulan[date.month - 1]} ${date.year}";
  }

  void convert() {
    if (date == null) {
      setState(() => error = "Silakan pilih tanggal");
      return;
    }

    DateTime d = date!;

    // 📌 Tentukan tahun Saka
    int sakaYear;
    DateTime sakaNewYear = DateTime(d.year, 3, 22);

    if (d.isBefore(sakaNewYear)) {
      sakaYear = d.year - 79;
      sakaNewYear = DateTime(d.year - 1, 3, 22);
    } else {
      sakaYear = d.year - 78;
    }

    // 📌 Hitung selisih hari dari tahun baru Saka
    int diffDays = d.difference(sakaNewYear).inDays;

    // 📌 Panjang bulan (kalender Saka sederhana)
    List<int> monthDays = [
      30, 31, 31, 31, 31, 31,
      30, 30, 30, 30, 30, 30
    ];

    int monthIndex = 0;

    while (diffDays >= monthDays[monthIndex]) {
      diffDays -= monthDays[monthIndex];
      monthIndex++;
      if (monthIndex >= 12) break;
    }

    int day = diffDays + 1;
    String monthName = sakaMonths[monthIndex];

    setState(() {
      hasil = "$day $monthName $sakaYear";
      error = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kalender Saka Lengkap"),
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
                    const Icon(Icons.temple_buddhist,
                        size: 70, color: Colors.green),

                    const SizedBox(height: 10),

                    const Text(
                      "Konversi Kalender Saka",
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
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
                        formatTanggal(date),
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
                          const Text("Hasil Kalender Saka"),
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
                        "- Pilih tanggal valid\n"
                        "- Kalender Saka dimulai sekitar 22 Maret\n\n"
                        "Fitur:\n"
                        "- Tahun Saka\n"
                        "- Bulan Saka\n"
                        "- Hari Saka",
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