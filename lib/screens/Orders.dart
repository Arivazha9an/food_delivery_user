import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  // Mock list of orders
  final List<Map<String, dynamic>> _orders = [
    {
      'hotelName': 'Pizza Hut',
      'isVeg': false,
      'foodName': 'Pepperoni Pizza',
      'image': 'assets/images/pizza.jpg',
      'price': 1299,
      'quantity': 2,
    },
    {
      'hotelName': 'Burger King',
      'isVeg': true,
      'foodName': 'Veggie Burger',
      'image': 'assets/images/pizza.jpg',
      'price': 1050,
      'quantity': 1,
    },
    {
      'hotelName': 'Sushi World',
      'isVeg': false,
      'foodName': 'Salmon Sushi',
      'image': 'assets/images/pizza.jpg',
      'price': 899,
      'quantity': 3,
    },
  ];

  // Calculate total price for all orders
  double getTotalPrice() {
    double total = 0;
    for (var order in _orders) {
      total += order['price'] * order['quantity'];
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _orders.length,
              itemBuilder: (context, index) {
                final order = _orders[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(8),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(order['image']),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order['hotelName'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.circle,
                              color: order['isVeg'] ? Colors.green : Colors.red,
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              order['foodName'],
                              style: const TextStyle(fontSize: 16),
                            ),                            
                          ],
                        ),
                      ],
                    ),
                    subtitle: Text(
                      "Price: \₹${order['price']} x ${order['quantity']} = \₹${(order['price'] * order['quantity']).toStringAsFixed(2)}",
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Price:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\₹${getTotalPrice().toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
