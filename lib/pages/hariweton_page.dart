import 'package:flutter/material.dart';

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
  final wetonList = ["Legi","Pahing","Pon","Wage","Kliwon"];

  void hitung() {
    if (selectedDate == null) {
      setState(() => error = "Tanggal harus dipilih");
      return;
    }

    int hari = selectedDate!.weekday % 7;
    int weton = selectedDate!.millisecondsSinceEpoch ~/ 86400000 % 5;

    setState(() {
      hasil = "${hariList[hari]} ${wetonList[weton]}";
      error = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hari Weton"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green, Colors.lightGreenAccent],
            ),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.calendar_today, size: 60),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );
                      setState(() => selectedDate = picked);
                    },
                    child: const Text("Pilih Tanggal"),
                  ),

                  if (error != null)
                    Text(error!, style: const TextStyle(color: Colors.red)),

                  const SizedBox(height: 10),

                  ElevatedButton(onPressed: hitung, child: const Text("Hitung")),

                  const SizedBox(height: 20),

                  Text(hasil, style: const TextStyle(fontSize: 22)),

                  const SizedBox(height: 10),

                  const Text("Syarat:\n- Pilih tanggal terlebih dahulu",
                      style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}