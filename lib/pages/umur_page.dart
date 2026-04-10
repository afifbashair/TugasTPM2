import 'package:flutter/material.dart';

class UmurPage extends StatefulWidget {
  const UmurPage({Key? key}) : super(key: key);

  @override
  State<UmurPage> createState() => _UmurPageState();
}

class _UmurPageState extends State<UmurPage> {
  DateTime? lahir;
  String hasil = "";
  String? error;
  TimeOfDay? waktu;

  // 📅 Format manual (tanpa intl)
  String formatTanggal(DateTime? date) {
  if (date == null) return "Belum dipilih";

  const bulan = [
    "Januari","Februari","Maret","April","Mei","Juni",
    "Juli","Agustus","September","Oktober","November","Desember"
  ];

  String jam = waktu != null
      ? "${waktu!.hour.toString().padLeft(2, '0')}:${waktu!.minute.toString().padLeft(2, '0')}"
      : "00:00";

  return "${date.day} ${bulan[date.month - 1]} ${date.year} - $jam";
}

  void hitung() {
  if (lahir == null) {
    setState(() => error = "Silakan pilih tanggal lahir");
    return;
  }

  final now = DateTime.now();

  final lahirLengkap = DateTime(
    lahir!.year,
    lahir!.month,
    lahir!.day,
    waktu?.hour ?? 0,
    waktu?.minute ?? 0,
  );

  if (lahirLengkap.isAfter(now)) {
    setState(() => error = "Tanggal tidak valid");
    return;
  }

  int tahun = now.year - lahirLengkap.year;
  int bulan = now.month - lahirLengkap.month;
  int hari = now.day - lahirLengkap.day;
  int jam = now.hour - lahirLengkap.hour;
  int menit = now.minute - lahirLengkap.minute;

  // 🔁 koreksi menit
  if (menit < 0) {
    menit += 60;
    jam -= 1;
  }

  // 🔁 koreksi jam
  if (jam < 0) {
    jam += 24;
    hari -= 1;
  }

  // 🔁 koreksi hari
  if (hari < 0) {
    bulan -= 1;
    final lastMonth = DateTime(now.year, now.month, 0).day;
    hari += lastMonth;
  }

  // 🔁 koreksi bulan
  if (bulan < 0) {
    tahun -= 1;
    bulan += 12;
  }

  setState(() {
    hasil =
        "$tahun Tahun $bulan Bulan $hari Hari\n"
        "$jam Jam $menit Menit";
    error = null;
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hitung Umur"),
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
                    const Icon(Icons.cake, size: 70, color: Colors.green),

                    const SizedBox(height: 10),

                    const Text(
                      "Hitung Umur",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 20),

                    // 📅 Tanggal lahir
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        formatTanggal(lahir),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),

                    const SizedBox(height: 15),

                    ElevatedButton.icon(
                      onPressed: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime(2000),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        setState(() => lahir = picked);
                      },
                      icon: const Icon(Icons.date_range),
                      label: const Text("Pilih Tanggal Lahir"),
                    ),

                    const SizedBox(height: 15),

                    ElevatedButton.icon(
                      onPressed: () async {
                        TimeOfDay? picked = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        setState(() => waktu = picked);
                      },
                      icon: const Icon(Icons.access_time),
                      label: const Text("Pilih Jam Lahir"),
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
                          const Text("Hasil Umur"),
                          const SizedBox(height: 10),
                          Text(
                            hasil.isEmpty ? "-" : hasil,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
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
                        "- Pilih tanggal lahir\n"
                        "- Tidak boleh tanggal masa depan",
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