
import 'package:flutter/material.dart';
import '../models/drink.dart';

class DrinkDetailPage extends StatefulWidget {
  final Drink drink;
  final Function(Drink, int) onAddToCart;

  const DrinkDetailPage({
    super.key,
    required this.drink,
    required this.onAddToCart,
  });

  @override
  State<DrinkDetailPage> createState() => _DrinkDetailPageState();
}

class _DrinkDetailPageState extends State<DrinkDetailPage> {
  int _quantity = 1;

  static const Color brown = Color(0xFF795548);
  static const Color darkBrown = Color(0xFF4E342E);
  static const Color cream = Color(0xFFFAF5EF);

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => '.',
    );
  }

  void _showSuccessDialog(
    BuildContext context,
    String drinkName,
    int quantity,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: cream,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle_rounded,
                color: brown,
                size: 65,
              ),
              const SizedBox(height: 14),
              const Text(
                'Berhasil Ditambahkan!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: darkBrown,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '$drinkName sebanyak $quantity berhasil ditambahkan ke keranjang.',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            SizedBox(
              width: 130,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: darkBrown,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = widget.drink.price * _quantity;

    return Scaffold(
      backgroundColor: cream,
      appBar: AppBar(
        title: Text(
          widget.drink.name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: darkBrown,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DrinkInfoCard(drink: widget.drink),
              const SizedBox(height: 24),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.brown.withOpacity(0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      'Jumlah Pesanan',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: darkBrown,
                      ),
                    ),
                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: _decrementQuantity,
                          icon: const Icon(
                            Icons.remove_circle_rounded,
                            size: 38,
                          ),
                          color: brown,
                          tooltip: 'Kurangi jumlah',
                        ),
                        const SizedBox(width: 20),
                        Container(
                          width: 65,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: cream,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '$_quantity',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: darkBrown,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        IconButton(
                          onPressed: _incrementQuantity,
                          icon: const Icon(
                            Icons.add_circle_rounded,
                            size: 38,
                          ),
                          color: brown,
                          tooltip: 'Tambah jumlah',
                        ),
                      ],
                    ),

                    const Divider(height: 30),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Harga',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            'Rp ${_formatPrice(totalPrice)}',
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: darkBrown,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              SizedBox(
                height: 54,
                child: ElevatedButton.icon(
                  onPressed: () {
                    widget.onAddToCart(widget.drink, _quantity);
                    _showSuccessDialog(
                      context,
                      widget.drink.name,
                      _quantity,
                    );
                  },
                  icon: const Icon(Icons.shopping_cart_rounded),
                  label: const Text(
                    'Tambah ke Keranjang',
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
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Nikmati pilihan menu favorit dari Warung IS.',
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

class DrinkInfoCard extends StatelessWidget {
  final Drink drink;

  const DrinkInfoCard({
    super.key,
    required this.drink,
  });

  static const Color brown = Color(0xFF795548);
  static const Color darkBrown = Color(0xFF4E342E);

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => '.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFFF1E7DC),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            width: 190,
            height: 190,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.asset(
              drink.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(
                    Icons.local_cafe_rounded,
                    size: 85,
                    color: brown,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Text(
            drink.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: darkBrown,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Rp ${_formatPrice(drink.price)}',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: brown,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Harga per produk',
            style: TextStyle(
              fontSize: 13,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
