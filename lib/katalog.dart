import 'package:flutter/material.dart';
import 'profil_page.dart';

// TUGAS 2: warna utama aplikasi diubah dari Colors.blue menjadi
// Colors.deepPurple (warna aksen: Colors.orange).

// TUGAS 5: Katalog diubah menjadi StatefulWidget supaya status favorit
// bisa berubah (ikon hati kosong <-> penuh) dengan setState.
class Katalog extends StatefulWidget {
  const Katalog({super.key});

  // Data produk
  // TUGAS 1: ditambah 4 produk baru
  // TUGAS 3: setiap produk punya kunci baru 'rating'
  static const List<Map<String, String>> items = [
    {
      'nama': 'Tas Ransel Laptop',
      'kategori': 'Tas',
      'harga': 'Rp 350.000',
      'rating': '4.5',
      'gambar': 'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_t.png',
      'deskripsi':
          'Tas ransel muat laptop hingga 15 inci, cocok untuk kuliah dan kerja.',
    },
    {
      'nama': 'Kaos Slim Fit Pria',
      'kategori': 'Pakaian',
      'harga': 'Rp 120.000',
      'rating': '4.3',
      'gambar':
          'https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_t.png',
      'deskripsi': 'Kaos bahan katun lembut, nyaman dipakai sehari-hari.',
    },
    {
      'nama': 'Jaket Katun Pria',
      'kategori': 'Pakaian',
      'harga': 'Rp 425.000',
      'rating': '4.6',
      'gambar': 'https://fakestoreapi.com/img/71li-ujtlUL._AC_UX679_t.png',
      'deskripsi': 'Jaket hangat untuk musim hujan dan perjalanan jauh.',
    },
    {
      'nama': 'Kemeja Casual',
      'kategori': 'Pakaian',
      'harga': 'Rp 180.000',
      'rating': '4.2',
      'gambar': 'https://fakestoreapi.com/img/71YXzeOuslL._AC_UY879_t.png',
      'deskripsi': 'Kemeja casual slim fit, cocok untuk acara santai.',
    },
    {
      'nama': 'Gelang Rantai Perak',
      'kategori': 'Aksesoris',
      'harga': 'Rp 275.000',
      'rating': '4.7',
      'gambar':
          'https://fakestoreapi.com/img/71pWzhdJNwL._AC_UL640_QL65_ML3_t.png',
      'deskripsi': 'Gelang rantai model naga, bahan perak berkualitas.',
    },
    {
      'nama': 'Hardisk Eksternal 2TB',
      'kategori': 'Elektronik',
      'harga': 'Rp 950.000',
      'rating': '4.4',
      'gambar': 'https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_t.png',
      'deskripsi': 'Penyimpanan portable USB 3.0, cepat dan ringkas.',
    },
    // ---- PRODUK BARU (TUGAS 1)
    {
      'nama': 'Yukata Kimono Sakura',
      'kategori': 'Pakaian',
      'harga': 'Rp 385.000',
      'rating': '4.8',
      'gambar':
          'https://images.unsplash.com/photo-1679000789255-e1bb41a03a21?fm=jpg&q=70&w=600&auto=format&fit=crop',
      'deskripsi':
          'Yukata tradisional Jepang, nyaman untuk festival atau santai.',
    },
    {
      'nama': 'Maneki Neko Keramik',
      'kategori': 'Aksesoris',
      'harga': 'Rp 95.000',
      'rating': '4.6',
      'gambar':
          'https://images.unsplash.com/photo-1619110480136-81e1b9970dc6?fm=jpg&q=70&w=600&auto=format&fit=crop',
      'deskripsi': 'Kucing pembawa keberuntungan khas Jepang, cocok untuk pajangan.',
    },
    {
      'nama': 'Lampion Chochin Merah',
      'kategori': 'Aksesoris',
      'harga': 'Rp 85.000',
      'rating': '4.5',
      'gambar':
          'https://images.unsplash.com/photo-1533514748558-031fa2639997?fm=jpg&q=70&w=600&auto=format&fit=crop',
      'deskripsi': 'Lampion kertas khas Jepang berwarna merah, cocok untuk dekorasi kamar.',
    },
    {
      'nama': 'Action Figure Anime',
      'kategori': 'Koleksi',
      'harga': 'Rp 275.000',
      'rating': '4.9',
      'gambar':
          'https://images.unsplash.com/photo-1609713292783-5e45ec29b62d?fm=jpg&q=70&w=600&auto=format&fit=crop',
      'deskripsi': 'Figure koleksi bergaya anime, detail cat rapi untuk pajangan.',
    },
  ];

  // Gambar produk dari internet, dengan loading dan cadangan jika gagal
  static Widget _gambar(String url, {double? size}) {
    return Image.network(
      url,
      width: size,
      height: size,
      fit: BoxFit.contain,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return SizedBox(
          width: size,
          height: size,
          child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        );
      },
      errorBuilder: (context, error, stack) => SizedBox(
        width: size,
        height: size,
        child: const Icon(Icons.image_not_supported, color: Colors.grey),
      ),
    );
  }

  // TUGAS 3: widget kecil untuk menampilkan rating
  static Widget _rating(String nilai, {double ukuran = 14}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star, color: Colors.amber, size: ukuran + 2),
        const SizedBox(width: 2),
        Text(
          nilai,
          style: TextStyle(fontSize: ukuran, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  @override
  State<Katalog> createState() => _KatalogState();
}

class _KatalogState extends State<Katalog> {
  // TUGAS 5: menyimpan nama produk yang sudah difavoritkan
  final Set<String> _favorit = {};

  
  bool _tampilGrid = false;

  
  void _gantiTampilan() {
    setState(() {
      _tampilGrid = !_tampilGrid;
    });
  }

  Widget _judul() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: _gantiTampilan,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Icon(
                  _tampilGrid ? Icons.grid_view : Icons.list,
                  color: Colors.deepPurple,
                  size: 28,
                ),
                const SizedBox(width: 10),
                Text(
                  _tampilGrid ? 'Galeri Produk' : 'Daftar Produk',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                const Text(
                  'Ketuk untuk ganti',
                  style: TextStyle(fontSize: 12, color: Colors.black45),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.swap_horiz, color: Colors.black45, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // TUGAS 5: tambah / hapus favorit, lalu beri umpan balik lewat SnackBar
  void _toggleFavorit(String nama) {
    final sudahFavorit = _favorit.contains(nama);

    setState(() {
      if (sudahFavorit) {
        _favorit.remove(nama);
      } else {
        _favorit.add(nama);
      }
    });

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            sudahFavorit
                ? '$nama dihapus dari Favorit'
                : '$nama ditambahkan ke Favorit',
          ),
          duration: const Duration(seconds: 1),
        ),
      );
  }

  // Pindah ke halaman detail sambil membawa data produk yang diklik
  void _bukaDetail(BuildContext context, Map<String, String> item) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailProduk(produk: item)),
    );
  }

  // ---------- Tampilan 1: ListView ----------
  Widget _buildList(List<Map<String, String>> items) {
    return ListView.builder(
      key: const ValueKey('list'),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          color: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            onTap: () => _bukaDetail(context, item),
            contentPadding: const EdgeInsets.all(8),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Katalog._gambar(item['gambar']!, size: 60),
            ),
            title: Text(
              item['nama']!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['deskripsi']!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      item['harga']!,
                      style: const TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 12),
                    // TUGAS 3: rating di daftar produk
                    Katalog._rating(item['rating']!),
                  ],
                ),
              ],
            ),
            trailing: Chip(
              label: Text(
                item['kategori']!,
                style: const TextStyle(fontSize: 10),
              ),
              backgroundColor: Colors.deepPurple[50],
              padding: EdgeInsets.zero,
            ),
          ),
        );
      },
    );
  }

  // ---------- Tampilan 2: GridView ----------
  Widget _buildGrid(List<Map<String, String>> items, int jumlahKolom) {
    return GridView.count(
      key: const ValueKey('grid'),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      crossAxisCount: jumlahKolom,
      childAspectRatio: 0.85,
      children: List.generate(items.length, (index) {
        final item = items[index];
        final isFavorit = _favorit.contains(item['nama']);

        return Card(
          color: Colors.white,
          elevation: 2,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          // Stack: kartu produk + tombol favorit di pojok kanan atas
          child: Stack(
            children: [
              InkWell(
                onTap: () => _bukaDetail(context, item),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        color: Colors.white,
                        padding: const EdgeInsets.all(8),
                        child: Katalog._gambar(item['gambar']!),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['nama']!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            item['harga']!,
                            style: const TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          // TUGAS 3: rating di galeri produk
                          Katalog._rating(item['rating']!),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // TUGAS 5: tombol favorit
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: Icon(
                    isFavorit ? Icons.favorite : Icons.favorite_border,
                    color: isFavorit ? Colors.red : Colors.grey,
                  ),
                  onPressed: () => _toggleFavorit(item['nama']!),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    const items = Katalog.items;

    // TUGAS 4: GridView responsif.
    final lebarLayar = MediaQuery.of(context).size.width;
    final jumlahKolom = lebarLayar >= 600 ? 3 : 2;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Katalog Produk',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
        actions: [
          // Tombol menuju halaman Profil
          IconButton(
            tooltip: 'Profil',
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilPage()),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.shopping_cart, color: Colors.white),
          ),
        ],
      ),
      // Satu bagian saja: judul + tombol logo, lalu list ATAU grid
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _judul(),
          Expanded(
            child: _tampilGrid
                ? _buildGrid(items, jumlahKolom)
                : _buildList(items),
          ),
        ],
      ),
    );
  }
}

// Halaman detail produk (menerima data dari halaman Katalog)
class DetailProduk extends StatelessWidget {
  final Map<String, String> produk;

  const DetailProduk({super.key, required this.produk});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          produk['nama']!,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: [
          // Gambar besar
          Container(
            color: Colors.white,
            height: 300,
            padding: const EdgeInsets.all(24),
            child: Katalog._gambar(produk['gambar']!),
          ),

          // Informasi produk
          Container(
            color: Colors.white,
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Chip(
                      label: Text(produk['kategori']!),
                      backgroundColor: Colors.deepPurple[50],
                    ),
                    const SizedBox(width: 12),
                    // TUGAS 3: rating di halaman detail
                    Katalog._rating(produk['rating']!, ukuran: 16),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  produk['nama']!,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  produk['harga']!,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(height: 32),
                const Text(
                  'Deskripsi Produk',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  produk['deskripsi']!,
                  style: const TextStyle(fontSize: 14, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),

      // Tombol beli di bagian bawah
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            icon: const Icon(Icons.add_shopping_cart),
            label: const Text('Tambah ke Keranjang'),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${produk['nama']} ditambahkan ke keranjang'),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
