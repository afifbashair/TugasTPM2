import 'package:berhitung_app/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:berhitung_app/pages/kelompok_page.dart';
import 'package:berhitung_app/pages/kalkulator_page.dart';
import 'package:berhitung_app/pages/cekbilangan_page.dart';
import 'package:berhitung_app/pages/jumlahbilangan_page.dart';
import 'package:berhitung_app/pages/stopwatch_page.dart';
import 'package:berhitung_app/pages/piramid_page.dart';

class HomePage extends StatefulWidget {

  final String username;

  const HomePage({super.key, required this.username});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu Utama"),
        actions: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              widget.username, 
              style: const TextStyle(fontSize: 16),
              ),

          ),
        ),
          IconButton(
            onPressed: (){
              Navigator.pushAndRemoveUntil(
                context, 
                MaterialPageRoute(builder: (context) => LoginPage()), 
                (route) => false);
            }, 
            icon: Icon(Icons.logout))
        ],
        ),
      body: ListView(
        children: [
          ListTile(
            title: Text("Data Kelompok"),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => KelompokPage()));
            },
          ),
          ListTile(
            title: Text("Penjumlahan & Pengurangan"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => KalkulatorPage()));
            },
          ),
          ListTile(
            title: Text("Ganjil / Genap & Bilangan Prima"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => CekbilanganPage()));
            },
          ),
          ListTile(
            title: Text("Jumlah Total Angka"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => JumlahbilanganPage()));
            },
          ),
          ListTile(
            title: Text("Stopwatch"),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => StopwatchPage()));
            },
          ),
          ListTile(
            title: Text("Luas & Volume Piramid"),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => PiramidPage()));
            },
          ),
        ],
      ),
    );
  }
}
