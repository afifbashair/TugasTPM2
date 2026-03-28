import 'package:flutter/material.dart';

class JumlahbilanganPage extends StatefulWidget {
  @override
  _JumlahbilanganPageState createState() => _JumlahbilanganPageState();
}

class _JumlahbilanganPageState extends State<JumlahbilanganPage> {
  final TextEditingController angka = TextEditingController();
  int hasil = 0;
  String? errorText;

  void hitungJumlah() {
    String input = angka.text.trim();

    // 🔴 VALIDASI
    if (input.isEmpty) {
      setState(() {
        errorText = "Input tidak boleh kosong";
        hasil = 0;
      });
      return;
    }

    if (!RegExp(r'^[0-9]+$').hasMatch(input)) {
      setState(() {
        errorText = "Hanya boleh angka (0-9)";
        hasil = 0;
      });
      return;
    }

    if (input.length > 10) {
      setState(() {
        errorText = "Maksimal 10 digit";
        hasil = 0;
      });
      return;
    }

    // 🔢 PROSES HITUNG
    int total = 0;
    for (int i = 0; i < input.length; i++) {
      total += int.parse(input[i]);
    }

    setState(() {
      hasil = total;
      errorText = null;
    });
  }

  void clearInput() {
    angka.clear();
    setState(() {
      hasil = 0;
      errorText = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jumlah Total Angka"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
            ),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 8,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.calculate, size: 60, color: Colors.blue),

                    SizedBox(height: 10),

                    Text(
                      "Hitung Jumlah Digit",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 20),

                    TextField(
                      controller: angka,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Masukkan angka",
                        hintText: "Contoh: 1234",
                        errorText: errorText,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: clearInput,
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: hitungJumlah,
                          icon: Icon(Icons.calculate),
                          label: Text("Hitung"),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                          ),
                        ),
                        OutlinedButton.icon(
                          onPressed: clearInput,
                          icon: Icon(Icons.refresh),
                          label: Text("Reset"),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),

                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "Total: $hasil",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),

                    SizedBox(height: 15),

                    // 📌 SYARAT INPUT
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Syarat Input:\n"
                        "- Hanya angka (0-9)\n"
                        "- Tidak boleh kosong\n"
                        "- Maksimal 10 digit\n"
                        "- Tidak boleh mengandung huruf/simbol",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[700],
                        ),
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