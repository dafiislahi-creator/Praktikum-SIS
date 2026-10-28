
import 'package:flutter/material.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();

  final _namaController = TextEditingController();
  final _hargaController = TextEditingController();
  final _deskripsiController = TextEditingController();
  final _gambarController = TextEditingController();

  final Color warnaLatar = const Color(0xFFFCF7FC);
  final Color warnaUngu = const Color(0xFFEFE7F5);
  final Color warnaTeks = const Color(0xFF8D75B5);

  @override
  void dispose() {
    _namaController.dispose();
    _hargaController.dispose();
    _deskripsiController.dispose();
    _gambarController.dispose();
    super.dispose();
  }

  InputDecoration dekorasiInput({
    required String label,
    required IconData ikon,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(
        fontSize: 12,
        color: Color(0xFFB55B5B),
      ),
      prefixIcon: Icon(
        ikon,
        size: 15,
        color: const Color(0xFF55505B),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(3),
        borderSide: const BorderSide(
          color: Color(0xFFD98989),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(3),
        borderSide: const BorderSide(
          color: Color(0xFFD98989),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(3),
        borderSide: const BorderSide(
          color: Color(0xFFB88ACF),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(3),
        borderSide: const BorderSide(
          color: Colors.redAccent,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(3),
        borderSide: const BorderSide(
          color: Colors.redAccent,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 10,
      ),
      isDense: true,
    );
  }

  String? validasiNama(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Nama produk tidak boleh kosong.';
    }
    if (value.trim().length < 3) {
      return 'Nama produk minimal 3 karakter.';
    }
    return null;
  }

  String? validasiHarga(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Harga tidak boleh kosong.';
    }

    final harga = int.tryParse(value.trim());

    if (harga == null) {
      return 'Masukkan harga dalam bentuk angka.';
    }
    if (harga <= 0) {
      return 'Harga harus lebih dari 0.';
    }
    return null;
  }

  String? validasiDeskripsi(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Deskripsi tidak boleh kosong.';
    }
    return null;
  }

  String? validasiGambar(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Path gambar tidak boleh kosong.';
    }

    final path = value.trim().toLowerCase();

    if (!path.startsWith('assets/')) {
      return "Path harus dimulai dengan 'assets/'.";
    }

    if (!(path.endsWith('.png') ||
        path.endsWith('.jpg') ||
        path.endsWith('.jpeg'))) {
      return 'Path harus berupa file gambar (.png, .jpg).';
    }

    return null;
  }

  void simpanProduk() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Semua data produk valid.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warnaLatar,
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F5F8),
        foregroundColor: const Color(0xFF333333),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Tambah Produk Baru',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(8, 10, 8, 12),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              children: [
                TextFormField(
                  controller: _namaController,
                  decoration: dekorasiInput(
                    label: 'Nama Produk',
                    ikon: Icons.production_quantity_limits,
                  ),
                  style: const TextStyle(fontSize: 12),
                  validator: validasiNama,
                ),
                const SizedBox(height: 12),

                TextFormField(
                  controller: _hargaController,
                  keyboardType: TextInputType.number,
                  decoration: dekorasiInput(
                    label: 'Harga',
                    ikon: Icons.payments,
                  ),
                  style: const TextStyle(fontSize: 12),
                  validator: validasiHarga,
                ),
                const SizedBox(height: 12),

                TextFormField(
                  controller: _deskripsiController,
                  maxLines: 2,
                  decoration: dekorasiInput(
                    label: 'Deskripsi Singkat',
                    ikon: Icons.description,
                  ),
                  style: const TextStyle(fontSize: 12),
                  validator: validasiDeskripsi,
                ),
                const SizedBox(height: 12),

                TextFormField(
                  controller: _gambarController,
                  decoration: dekorasiInput(
                    label: 'Path Aset Gambar',
                    ikon: Icons.image,
                  ),
                  style: const TextStyle(fontSize: 12),
                  validator: validasiGambar,
                ),
                const SizedBox(height: 14),

                SizedBox(
                  width: double.infinity,
                  height: 34,
                  child: ElevatedButton(
                    onPressed: simpanProduk,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: warnaUngu,
                      foregroundColor: warnaTeks,
                      elevation: 0,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Simpan',
                      style: TextStyle(fontSize: 12),
                    ),
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
