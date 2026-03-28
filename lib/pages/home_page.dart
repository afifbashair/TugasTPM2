import 'package:berhitung_app/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:berhitung_app/pages/kelompok_page.dart';
import 'package:berhitung_app/pages/kalkulator_page.dart';
import 'package:berhitung_app/pages/cekbilangan_page.dart';
import 'package:berhitung_app/pages/jumlahbilangan_page.dart';
import 'package:berhitung_app/pages/stopwatch_page.dart';
import 'package:berhitung_app/pages/piramid_page.dart';
import 'package:berhitung_app/pages/hijriyah_page.dart';
import 'package:berhitung_app/pages/saka_page.dart';
import 'package:berhitung_app/pages/hariweton_page.dart';
import 'package:berhitung_app/pages/umur_page.dart';

class HomePage extends StatefulWidget {

  final String username;

  const HomePage({super.key, required this.username});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

    Widget menuItem(String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(2, 4),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BerhitungQu"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [const Color.fromARGB(255, 64, 115, 211), const Color.fromARGB(255, 64, 35, 129)],
            ),
          ),
        ),
      
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
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              menuItem("Data Kelompok", Icons.group, () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => KelompokPage()));
              }),
              menuItem("Kalkulator", Icons.calculate, () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => KalkulatorPage()));
              }),
              menuItem("Cek Bilangan", Icons.numbers, () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => CekbilanganPage()));
              }),
              menuItem("Jumlah Angka", Icons.summarize, () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => JumlahbilanganPage()));
              }),
              menuItem("Stopwatch", Icons.timer, () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => StopwatchPage()));
              }),
              menuItem("Piramid", Icons.change_history, () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => PiramidPage()));
              }),
              menuItem("Cek Hari & Weton", Icons.calendar_today, () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => HariWetonPage()));
              }),
              menuItem("Hitung Umur", Icons.cake, () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => UmurPage()));
              }),
              menuItem("Konversi Hijriyah", Icons.mosque, () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => HijriyahPage()));
              }),
              menuItem("Tanggal Saka", Icons.event, () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => SakaPage()));
              }),
            ],
          ),
        ),
    );
  }
}
