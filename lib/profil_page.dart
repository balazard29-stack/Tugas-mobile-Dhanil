import 'package:flutter/material.dart';

// Halaman Profil: halaman baru yang dibuka dengan Navigator.push dari Katalog
class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  static const String nama = 'Dhanil';
  static const String peran = 'Mahasiswa';
  static const String nim = '131311313';
  static const String prodi = 'infor';
  static const String kampus = 'UPGRIS';
  static const String email = '@gmail.com';


  Widget _baris(IconData ikon, String label, String nilai) {
    return ListTile(
      leading: Icon(ikon, color: Colors.deepPurple),
      title: Text(
        label,
        style: const TextStyle(fontSize: 12, color: Colors.black54),
      ),
      subtitle: Text(
        nilai,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Profil',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: [
          // Bagian atas: avatar + nama
          Container(
            color: Colors.deepPurple,
            padding: const EdgeInsets.only(top: 16, bottom: 32),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 52,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 48,
                    backgroundColor: Colors.deepPurple[100],
                    child: Text(
                      nama.isNotEmpty ? nama[0].toUpperCase() : '?',
                      style: TextStyle(
                        fontSize: 44,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple[800],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  nama,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  peran,
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
              ],
            ),
          ),

          // Kartu data diri
          Card(
            margin: const EdgeInsets.fromLTRB(12, 12, 12, 6),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _baris(Icons.badge, 'NIM', nim),
                const Divider(height: 1),
                _baris(Icons.school, 'Program Studi', prodi),
                const Divider(height: 1),
                _baris(Icons.apartment, 'Kampus', kampus),
                const Divider(height: 1),
                _baris(Icons.email, 'Email', email),
              ],
            ),
          ),

          // Kartu tentang aplikasi
          Card(
            margin: const EdgeInsets.fromLTRB(12, 6, 12, 12),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: _baris(
              Icons.info,
              'Tentang Aplikasi',
              'Katalog Produk v1.0.0 - dibuat dengan Flutter',
            ),
          ),
        ],
      ),
    );
  }
}
