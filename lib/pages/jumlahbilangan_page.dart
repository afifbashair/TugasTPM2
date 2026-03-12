import 'package:flutter/material.dart';

class JumlahbilanganPage extends StatefulWidget {
  @override
  _JumlahbilanganPageState createState() => _JumlahbilanganPageState();
}

class _JumlahbilanganPageState extends State<JumlahbilanganPage> {

  TextEditingController angka = TextEditingController();
  int hasil = 0;

  void hitungJumlah() {

    String input = angka.text;
    int total = 0;

    for (int i = 0; i < input.length; i++) {
      total += int.parse(input[i]);
    }

    setState(() {
      hasil = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Jumlah Total Angka")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: angka,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Masukkan angka (contoh: 1234)",
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: hitungJumlah,
              child: Text("Hitung"),
            ),

            SizedBox(height: 20),

            Text(
              "Total: $hasil",
              style: TextStyle(fontSize: 22),
            )

          ],
        ),
      ),
    );
  }
}