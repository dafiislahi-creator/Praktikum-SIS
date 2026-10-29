
import 'package:flutter/material.dart';
import '../models/drink.dart';

class EditProductPage extends StatefulWidget {
  final Function(Drink) onSave;
  final Drink existingDrink;

  const EditProductPage({
    super.key,
    required this.onSave,
    required this.existingDrink,
  });

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _imageUrlController = TextEditingController();

  static const Color brown = Color(0xFF795548);
  static const Color darkBrown = Color(0xFF4E342E);
  static const Color cream = Color(0xFFFAF5EF);

  @override
  void initState() {
    super.initState();

    _nameController.text = widget.existingDrink.name;
    _priceController.text = widget.existingDrink.price.toString();
    _imageUrlController.text = widget.existingDrink.imageUrl;
  }

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
        const SnackBar(
          content: Text('Periksa kembali data produk yang dimasukkan.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final updatedDrink = Drink(
      id: widget.existingDrink.id,
      name: _nameController.text.trim(),
      price: int.parse(_priceController.text.trim()),
      imageUrl: _imageUrlController.text.trim(),
    );

    widget.onSave(updatedDrink);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Produk berhasil diperbarui!'),
        backgroundColor: darkBrown,
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
      prefixIcon: Icon(icon, color: brown),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFD7CCC8)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFD7CCC8)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: brown, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      appBar: AppBar(
        title: const Text(
          'Edit Produk',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: darkBrown,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.edit_note_rounded,
                size: 65,
                color: brown,
              ),
              const SizedBox(height: 8),
              const Text(
                'Perbarui Produk',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: darkBrown,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Ubah informasi produk sesuai kebutuhan.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 24),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1E7DC),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.brown.withOpacity(0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      textCapitalization: TextCapitalization.words,
                      decoration: _inputDecoration(
                        label: 'Nama Produk',
                        icon: Icons.local_cafe_rounded,
                        hint: 'Contoh: Es Kopi Susu',
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
                    const SizedBox(height: 18),

                    TextFormField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      decoration: _inputDecoration(
                        label: 'Harga Produk',
                        icon: Icons.payments_outlined,
                        prefixText: 'Rp ',
                        hint: 'Contoh: 15000',
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
                          return 'Harga harus lebih dari Rp 0.';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 18),

                    TextFormField(
                      controller: _imageUrlController,
                      decoration: _inputDecoration(
                        label: 'Path Aset Gambar',
                        icon: Icons.image_outlined,
                        hint: 'assets/espresso.jpg',
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
                          return 'Gunakan format PNG, JPG, atau JPEG.';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 26),

                    SizedBox(
                      height: 52,
                      child: ElevatedButton.icon(
                        onPressed: _submitForm,
                        icon: const Icon(Icons.save_rounded),
                        label: const Text(
                          'Simpan Perubahan',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: darkBrown,
                          foregroundColor: Colors.white,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Pastikan informasi produk sudah benar sebelum disimpan.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
