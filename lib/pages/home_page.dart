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

  Widget menuItem(String title, IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.8), color],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 8,
              offset: const Offset(2, 4),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
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
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4CAF50), Color(0xFF009688)],
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
                (route) => false);
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),

      body: Column(
        children: [

          // 👋 HEADER USER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4CAF50), Color(0xFF009688)],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Text(
              "Halo, ${widget.username} 👋",
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 10),

          // 📱 MENU GRID
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [

                  menuItem("Data Kelompok", Icons.group, Colors.blue, () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => KelompokPage()));
                  }),

                  menuItem("Kalkulator", Icons.calculate, Colors.orange, () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => KalkulatorPage()));
                  }),

                  menuItem("Cek Bilangan", Icons.numbers, Colors.purple, () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => CekbilanganPage()));
                  }),

                  menuItem("Jumlah Angka", Icons.summarize, Colors.teal, () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => JumlahbilanganPage()));
                  }),

                  menuItem("Stopwatch", Icons.timer, Colors.red, () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => StopwatchPage()));
                  }),

                  menuItem("Piramid", Icons.change_history, Colors.indigo, () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => PiramidPage()));
                  }),

                  menuItem("Hari & Weton", Icons.calendar_today, Colors.green, () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => HariWetonPage()));
                  }),

                  menuItem("Hitung Umur", Icons.cake, Colors.pink, () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => UmurPage()));
                  }),

                  menuItem("Hijriyah", Icons.mosque, Colors.brown, () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => HijriyahPage()));
                  }),

                  menuItem("Kalender Saka", Icons.event, Colors.cyan, () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => SakaPage()));
                  }),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}