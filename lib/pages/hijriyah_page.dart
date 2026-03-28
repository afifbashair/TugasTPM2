import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';

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
      setState(() => error = "Tanggal wajib dipilih");
      return;
    }

    final h = HijriCalendar.fromDate(date!);

    setState(() {
      hasil = "${h.hDay} ${h.longMonthName} ${h.hYear}";
      error = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hijriyah"),
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
            color: Color.fromARGB(216, 10, 112, 41),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(100),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.mosque, size: 60),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );
                      setState(() => date = picked);
                    },
                    child: const Text("Pilih Tanggal"),
                  ),

                  if (error != null)
                    Text(error!, style: const TextStyle(color: Colors.red)),

                  const SizedBox(height: 10),

                  ElevatedButton(onPressed: convert, child: const Text("Konversi")),

                  const SizedBox(height: 20),

                  Text(hasil, style: const TextStyle(fontSize: 22)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}