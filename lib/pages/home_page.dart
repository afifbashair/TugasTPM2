import 'package:flutter/material.dart';
import 'package:berhitung_app/pages/kelompok_page.dart';
import 'package:berhitung_app/pages/kalkulator_page.dart';
import 'package:berhitung_app/pages/cekbilangan_page.dart';
import 'package:berhitung_app/pages/jumlahbilangan_page.dart';
import 'package:berhitung_app/pages/stopwatch_page.dart';
import 'package:berhitung_app/pages/piramid_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Menu Utama")),
      body: ListView(
        children: [

          ListTile(
            title: Text("Data Kelompok"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => KelompokPage()));
            },
          ),

          ListTile(
            title: Text("Penjumlahan & Pengurangan"),
            onTap: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (_) => KalkulatorPage()));
            },
          ),

          ListTile(
            title: Text("Ganjil / Genap & Bilangan Prima"),
            onTap: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (_) => BilanganPage()));
            },
          ),

          ListTile(
            title: Text("Jumlah Total Angka"),
            onTap: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (_) => JumlahAngkaPage()));
            },
          ),

          ListTile(
            title: Text("Stopwatch"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => StopwatchPage()));
            },
          ),

          ListTile(
            title: Text("Luas & Volume Piramid"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => PiramidPage()));
            },
          ),

        ],
      ),
    );
  }
}