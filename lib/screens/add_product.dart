
import 'package:flutter/material.dart';
import '../models/drink.dart';

class AddProductPage extends StatefulWidget {
  final Function(Drink) onSave;

  const AddProductPage({
    super.key,
    required this.onSave,
  });

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _imageUrlController = TextEditingController();

  static const Color darkBrown = Color(0xFF3E2723);
  static const Color mediumBrown = Color(0xFF795548);
  static const Color lightBrown = Color(0xFFD7B899);
  static const Color cream = Color(0xFFFAF3E8);

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Periksa kembali data produk yang dimasukkan.',
          ),
          backgroundColor: darkBrown,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
      return;
    }

    final name = _nameController.text.trim();
    final price = int.parse(_priceController.text.trim());
    final imageUrl = _imageUrlController.text.trim();

    final newDrink = Drink(
      id: DateTime.now().toString(),
      name: name,
      price: price,
      imageUrl: imageUrl,
    );

    widget.onSave(newDrink);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Produk berhasil ditambahkan!'),
        backgroundColor: darkBrown,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );

    Navigator.of(context).pop();
  }

  InputDecoration _inputDecoration({
    required String label,
    required IconData icon,
    String? hint,
    String? prefixText,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixText: prefixText,
      prefixIcon: Icon(
        icon,
        color: mediumBrown,
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 17,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: lightBrown,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Color(0xFFE0D3C4),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: mediumBrown,
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Colors.redAccent,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Colors.redAccent,
          width: 1.5,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              'Tambah Produk',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Warung IS',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFFE8C7A7),
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Ikon utama
                Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE9D8C5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.add_business_rounded,
                      size: 48,
                      color: darkBrown,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Produk Baru',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: darkBrown,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Lengkapi informasi produk yang ingin ditambahkan ke menu.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.5,
                    color: mediumBrown,
                  ),
                ),

                const SizedBox(height: 28),

                // Form dalam card
                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: const Color(0xFFE8DCCF),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: darkBrown.withValues(alpha: 0.05),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Informasi Produk',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: darkBrown,
                        ),
                      ),

                      const SizedBox(height: 22),

                      // Nama produk
                      TextFormField(
                        controller: _nameController,
                        textCapitalization: TextCapitalization.words,
                        decoration: _inputDecoration(
                          label: 'Nama Produk',
                          hint: 'Contoh: Es Kopi Susu',
                          icon: Icons.local_cafe_outlined,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Nama produk tidak boleh kosong.';
                          }

                          if (value.trim().length < 3) {
                            return 'Nama produk minimal 3 karakter.';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // Harga produk
                      TextFormField(
                        controller: _priceController,
                        keyboardType: TextInputType.number,
                        decoration: _inputDecoration(
                          label: 'Harga Produk',
                          hint: 'Contoh: 15000',
                          icon: Icons.payments_outlined,
                          prefixText: 'Rp ',
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Harga tidak boleh kosong.';
                          }

                          final price = int.tryParse(value.trim());

                          if (price == null) {
                            return 'Masukkan harga dalam bentuk angka.';
                          }

                          if (price <= 0) {
                            return 'Harga harus lebih dari 0.';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // Path gambar
                      TextFormField(
                        controller: _imageUrlController,
                        decoration: _inputDecoration(
                          label: 'Path Aset Gambar',
                          hint: 'assets/espresso.jpg',
                          icon: Icons.image_outlined,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Path gambar tidak boleh kosong.';
                          }

                          final path = value.trim().toLowerCase();

                          if (!path.startsWith('assets/')) {
                            return "Path harus dimulai dengan 'assets/'.";
                          }

                          if (!path.endsWith('.png') &&
                              !path.endsWith('.jpg') &&
                              !path.endsWith('.jpeg')) {
                            return 'Gunakan file .png, .jpg, atau .jpeg.';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 12),

                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            color: mediumBrown,
                            size: 17,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Pastikan gambar sudah tersedia di folder assets dan terdaftar di pubspec.yaml.',
                              style: TextStyle(
                                fontSize: 12,
                                height: 1.5,
                                color: mediumBrown,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 28),

                      // Tombol simpan
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: darkBrown,
                            foregroundColor: Colors.white,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.save_rounded, size: 20),
                              SizedBox(width: 10),
                              Text(
                                'Simpan Produk',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  'WARUNG IS • CLASSIC MODERN',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: mediumBrown,
                    fontSize: 10,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
