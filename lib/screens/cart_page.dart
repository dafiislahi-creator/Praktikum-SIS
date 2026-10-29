
import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class CartPage extends StatefulWidget {
  final List<CartItem> cartItems;
  final Function(String) onRemoveFromCart;
  final VoidCallback onClearCart;

  const CartPage({
    super.key,
    required this.cartItems,
    required this.onRemoveFromCart,
    required this.onClearCart,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _mejaController = TextEditingController();

  static const Color darkBrown = Color(0xFF3E2723);
  static const Color mediumBrown = Color(0xFF795548);
  static const Color lightBrown = Color(0xFFD7B899);
  static const Color cream = Color(0xFFFAF3E8);

  @override
  void dispose() {
    _namaController.dispose();
    _mejaController.dispose();
    super.dispose();
  }

  String formatRupiah(int price) {
    return 'Rp${price.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => '.',
    )}';
  }

  int get totalPrice {
    return widget.cartItems.fold(
      0,
      (total, item) => total + item.drink.price * item.quantity,
    );
  }

  void checkout() {
    if (widget.cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Keranjang masih kosong'),
          backgroundColor: darkBrown,
        ),
      );
      return;
    }

    if (!_formKey.currentState!.validate()) {
      return;
    }

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: cream,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          icon: const CircleAvatar(
            radius: 34,
            backgroundColor: Color(0xFFE2EBD9),
            child: Icon(
              Icons.check_circle_rounded,
              color: Color(0xFF55764B),
              size: 42,
            ),
          ),
          title: const Text(
            'Pesanan Berhasil!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: darkBrown,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Terima kasih telah memesan di Warung IS.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: mediumBrown,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _detailPesanan('Nama pemesan', _namaController.text),
              const SizedBox(height: 10),
              _detailPesanan('Nomor meja', _mejaController.text),
              const Divider(height: 25, color: lightBrown),
              const Text(
                'Total pembayaran',
                style: TextStyle(
                  fontSize: 13,
                  color: mediumBrown,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                formatRupiah(totalPrice),
                style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: darkBrown,
                ),
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: darkBrown,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(dialogContext);
                },
                child: const Text('Selesai'),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _detailPesanan(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: mediumBrown,
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: const TextStyle(
              color: darkBrown,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration({
    required String label,
    required IconData icon,
    String? hint,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon, color: mediumBrown),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: lightBrown),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFE0D3C4)),
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
        borderSide: const BorderSide(color: Colors.redAccent),
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
        centerTitle: false,
        elevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Keranjang',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Pesanan Warung IS',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFFE8C7A7),
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Kosongkan keranjang',
            icon: const Icon(Icons.delete_sweep_rounded),
            onPressed: widget.cartItems.isEmpty
                ? null
                : () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        backgroundColor: cream,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        title: const Text(
                          'Kosongkan Keranjang?',
                          style: TextStyle(color: darkBrown),
                        ),
                        content: const Text(
                          'Semua item di keranjang akan dihapus.',
                          style: TextStyle(color: mediumBrown),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx),
                            child: const Text(
                              'Batal',
                              style: TextStyle(color: mediumBrown),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: darkBrown,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              widget.onClearCart();
                              Navigator.pop(ctx);
                            },
                            child: const Text('Kosongkan'),
                          ),
                        ],
                      ),
                    );
                  },
          ),
          const SizedBox(width: 8),
        ],
      ),

      body: widget.cartItems.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 125,
                      height: 125,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE9D8C5),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.shopping_bag_outlined,
                        size: 65,
                        color: mediumBrown,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Keranjang Masih Kosong',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: darkBrown,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Yuk, pilih minuman favoritmu dan tambahkan ke keranjang.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        color: mediumBrown,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : ListView(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
              children: [
                // Judul daftar pesanan
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Pesanan Kamu',
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
                        '${widget.cartItems.length} item',
                        style: const TextStyle(
                          color: darkBrown,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // Daftar item
                ...widget.cartItems.map((item) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: const Color(0xFFE8DCCF),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: darkBrown.withValues(alpha: 0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(13),
                          child: Image.asset(
                            item.drink.imageUrl,
                            width: 78,
                            height: 85,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 78,
                                height: 85,
                                color: const Color(0xFFF0E4D6),
                                child: const Icon(
                                  Icons.local_cafe_rounded,
                                  color: mediumBrown,
                                  size: 35,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 13),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.drink.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: darkBrown,
                                ),
                              ),
                              const SizedBox(height: 7),
                              Text(
                                '${item.quantity} x ${formatRupiah(item.drink.price)}',
                                style: const TextStyle(
                                  color: mediumBrown,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                formatRupiah(
                                  item.drink.price * item.quantity,
                                ),
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: darkBrown,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          tooltip: 'Hapus item',
                          onPressed: () {
                            widget.onRemoveFromCart(item.drink.id);
                          },
                          icon: const Icon(
                            Icons.delete_outline_rounded,
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                  );
                }),

                const SizedBox(height: 12),

                // Form checkout
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: const Color(0xFFE8DCCF),
                    ),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons.receipt_long_rounded,
                              color: mediumBrown,
                              size: 24,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Detail Pemesanan',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: darkBrown,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        TextFormField(
                          controller: _namaController,
                          textCapitalization: TextCapitalization.words,
                          decoration: _inputDecoration(
                            label: 'Nama Pemesan',
                            icon: Icons.person_outline_rounded,
                            hint: 'Masukkan nama kamu',
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Nama pemesan tidak boleh kosong';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        TextFormField(
                          controller: _mejaController,
                          keyboardType: TextInputType.number,
                          decoration: _inputDecoration(
                            label: 'Nomor Meja (1-20)',
                            icon: Icons.table_restaurant_outlined,
                            hint: 'Contoh: 5',
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Nomor meja harus diisi';
                            }

                            final nomorMeja = int.tryParse(value.trim());

                            if (nomorMeja == null) {
                              return 'Nomor meja harus berupa angka';
                            }

                            if (nomorMeja < 1 || nomorMeja > 20) {
                              return 'Nomor meja harus antara 1-20';
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 22),

                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: cream,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Total Pembayaran',
                                      style: TextStyle(
                                        color: mediumBrown,
                                        fontSize: 13,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Termasuk semua item',
                                      style: TextStyle(
                                        color: Color(0xFF9E8A7B),
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  formatRupiah(totalPrice),
                                  textAlign: TextAlign.end,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: darkBrown,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 18),

                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton(
                            onPressed: checkout,
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
                                Icon(Icons.receipt_long_rounded, size: 20),
                                SizedBox(width: 10),
                                Text(
                                  'Checkout Sekarang',
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
                ),
              ],
            ),
    );
  }
}
