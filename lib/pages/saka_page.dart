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

  void convert() {
    if (date == null) {
      setState(() => error = "Tanggal wajib dipilih");
      return;
    }

    int sakaYear = date!.year - 78;

    setState(() {
      hasil = "Tahun Saka: $sakaYear";
      error = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kalender SAKA"),
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
                  const Icon(Icons.event, size: 60),

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