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

  void hitung() {
    if (lahir == null) {
      setState(() => error = "Tanggal lahir wajib dipilih");
      return;
    }

    final now = DateTime.now();

    if (lahir!.isAfter(now)) {
      setState(() => error = "Tanggal tidak valid");
      return;
    }

    final diff = now.difference(lahir!);

    int hari = diff.inDays;
    int tahun = hari ~/ 365;
    int bulan = (hari % 365) ~/ 30;
    int sisaHari = (hari % 365) % 30;

    setState(() {
      hasil = "$tahun thn $bulan bln $sisaHari hari\n"
          "${diff.inHours} jam, ${diff.inMinutes} menit";
      error = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hitung Umur"),
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
                  const Icon(Icons.cake, size: 60),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime(2000),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      setState(() => lahir = picked);
                    },
                    child: const Text("Pilih Tanggal Lahir"),
                  ),

                  if (error != null)
                    Text(error!, style: const TextStyle(color: Colors.red)),

                  const SizedBox(height: 10),

                  ElevatedButton(onPressed: hitung, child: const Text("Hitung")),

                  const SizedBox(height: 20),

                  Text(hasil, textAlign: TextAlign.center),

                  const SizedBox(height: 10),

                  const Text(
                    "Syarat:\n- Tidak boleh tanggal masa depan",
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}