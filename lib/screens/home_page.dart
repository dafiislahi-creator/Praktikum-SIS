
import 'package:flutter/material.dart';
import '../models/drink.dart';
import 'drink_detail_page.dart';

class HomePage extends StatefulWidget {
  final List<Drink> drinkList;
  final Function(Drink, int) onAddToCart;
  final void Function() onAdd;
  final void Function(Drink) onEdit;
  final void Function(String) onDelete;

  const HomePage({
    Key? key,
    required this.drinkList,
    required this.onAddToCart,
    required this.onAdd,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String searchText = '';

  static const Color darkBrown = Color(0xFF3E2723);
  static const Color mediumBrown = Color(0xFF795548);
  static const Color lightBrown = Color(0xFFD7B899);
  static const Color cream = Color(0xFFFAF3E8);

  void _showQuickAddDialog(String foodName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$foodName ditambahkan ke keranjang.'),
        backgroundColor: darkBrown,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _confirmDelete(Drink drink) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: cream,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        icon: const Icon(
          Icons.delete_outline_rounded,
          color: Colors.redAccent,
          size: 38,
        ),
        title: const Text(
          'Hapus Produk?',
          style: TextStyle(
            color: darkBrown,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Apakah kamu yakin ingin menghapus ${drink.name}?',
          textAlign: TextAlign.center,
          style: const TextStyle(color: mediumBrown),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text(
              'Batal',
              style: TextStyle(color: mediumBrown),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: darkBrown,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              widget.onDelete(drink.id);
              Navigator.of(ctx).pop();
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = widget.drinkList
        .where(
          (drink) =>
              drink.name.toLowerCase().contains(searchText.toLowerCase()),
        )
        .toList();

    return Scaffold(
      backgroundColor: cream,
      appBar: AppBar(
        backgroundColor: darkBrown,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Warung IS',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            Text(
              'Menu Minuman',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFFE8C7A7),
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: const Color(0xFF795548),
              child: const Icon(
                Icons.coffee_rounded,
                color: Color(0xFFE8C7A7),
              ),
            ),
          ),
        ],
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bagian pencarian
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
            decoration: const BoxDecoration(
              color: darkBrown,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Mau minum apa hari ini?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 7),
                const Text(
                  'Temukan minuman favoritmu di sini.',
                  style: TextStyle(
                    color: Color(0xFFD7B899),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Cari minuman...',
                    hintStyle: const TextStyle(
                      color: Color(0xFF9E8A7B),
                      fontSize: 14,
                    ),
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: mediumBrown,
                    ),
                    suffixIcon: searchText.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                searchText = '';
                              });
                            },
                            icon: const Icon(
                              Icons.close_rounded,
                              color: mediumBrown,
                            ),
                          )
                        : null,
                    filled: true,
                    fillColor: cream,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Judul daftar menu
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 14),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Pilihan Menu',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: darkBrown,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE9D8C5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${filteredList.length} menu',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: darkBrown,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Daftar minuman
          Expanded(
            child: filteredList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.local_cafe_outlined,
                          size: 65,
                          color: Colors.brown.shade300,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Menu tidak ditemukan',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: darkBrown,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Coba gunakan kata kunci lain.',
                          style: TextStyle(
                            fontSize: 13,
                            color: mediumBrown,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final drink = filteredList[index];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xFFE8DCCF),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: darkBrown.withValues(alpha: 0.05),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              // Gambar minuman
                              ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: Image.asset(
                                  drink.imageUrl,
                                  width: 88,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  errorBuilder: (ctx, err, stack) {
                                    return Container(
                                      width: 88,
                                      height: 100,
                                      color: const Color(0xFFF0E4D6),
                                      child: const Icon(
                                        Icons.local_cafe_rounded,
                                        size: 40,
                                        color: mediumBrown,
                                      ),
                                    );
                                  },
                                ),
                              ),

                              const SizedBox(width: 14),

                              // Nama dan harga
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      drink.name,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: darkBrown,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Rp ${drink.price}',
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: mediumBrown,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      height: 32,
                                      child: OutlinedButton.icon(
                                        onPressed: () {
                                          widget.onAddToCart(drink, 1);
                                          _showQuickAddDialog(drink.name);
                                        },
                                        icon: const Icon(
                                          Icons.add_shopping_cart_rounded,
                                          size: 14,
                                        ),
                                        label: const Text(
                                          'Tambah',
                                          style: TextStyle(fontSize: 11),
                                        ),
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: darkBrown,
                                          side: const BorderSide(
                                            color: lightBrown,
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Tombol aksi
                              Column(
                                children: [
                                  IconButton(
                                    tooltip: 'Detail',
                                    visualDensity: VisualDensity.compact,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DrinkDetailPage(
                                            drink: drink,
                                            onAddToCart: widget.onAddToCart,
                                          ),
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.info_outline_rounded,
                                      color: mediumBrown,
                                      size: 22,
                                    ),
                                  ),
                                  IconButton(
                                    tooltip: 'Edit',
                                    visualDensity: VisualDensity.compact,
                                    onPressed: () {
                                      widget.onEdit(drink);
                                    },
                                    icon: const Icon(
                                      Icons.edit_outlined,
                                      color: Color(0xFF8D6E63),
                                      size: 22,
                                    ),
                                  ),
                                  IconButton(
                                    tooltip: 'Hapus',
                                    visualDensity: VisualDensity.compact,
                                    onPressed: () {
                                      _confirmDelete(drink);
                                    },
                                    icon: const Icon(
                                      Icons.delete_outline_rounded,
                                      color: Colors.redAccent,
                                      size: 22,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),

      // Tombol tambah produk
      floatingActionButton: FloatingActionButton.extended(
        onPressed: widget.onAdd,
        backgroundColor: darkBrown,
        foregroundColor: Colors.white,
        elevation: 5,
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'Tambah Produk',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
