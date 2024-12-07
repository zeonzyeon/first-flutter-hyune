import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductListScreen(category: "전체"),
    );
  }
}

class Product {
  final String name;
  final String category;
  final int price;
  final String image;

  Product(this.name, this.category, this.price, this.image);
}

class ProductListScreen extends StatefulWidget {
  final String category;

  ProductListScreen({required this.category});

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  static Map<Product, int> cart = {};

  List<Product> allProducts = [
    Product("사과", "식품", 1000, "images/apple.png"),
    Product("바나나", "식품", 2000, "images/banana.png"),
    Product("포도", "식품", 3000, "images/grape.png"),
    Product("딸기", "식품", 3000, "images/strawberry.png"),
    Product("세제", "생활", 10000, "images/detergent.png"),
    Product("휴지", "생활", 10000, "images/tissue.png"),
    Product("전자레인지", "가전", 100000, "images/microwave.png"),
    Product("TV", "가전", 300000, "images/TV.png"),
    Product("엔진오일", "자동차", 50000, "images/engine_oil.png"),
    Product("타이어", "자동차", 150000, "images/tire.png"),
    Product("블랙박스", "자동차", 200000, "images/dash_cam.png"),
  ];

  void _addToCart(Product product) {
    setState(() {
      if (cart.containsKey(product)) {
        cart[product] = cart[product]! + 1;
      } else {
        cart[product] = 1;
      }
    });
  }

  List<Product> _filterProducts(String category) {
    if (category == "전체") {
      return allProducts;
    }
    return allProducts
        .where((product) => product.category == category)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Product> products = _filterProducts(widget.category);

    return Scaffold(
      appBar: AppBar(
        title: Text("상품 목록 (${widget.category})"),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(cart: cart),
                ),
              ).then((_) {
                setState(() {});
              });
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text("카테고리 선택",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
            ListTile(
              title: Text("전체"),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductListScreen(category: "전체"),
                  ),
                );
              },
            ),
            ListTile(
              title: Text("식품"),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductListScreen(category: "식품"),
                  ),
                );
              },
            ),
            ListTile(
              title: Text("생활"),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductListScreen(category: "생활"),
                  ),
                );
              },
            ),
            ListTile(
              title: Text("가전"),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductListScreen(category: "가전"),
                  ),
                );
              },
            ),
            ListTile(
              title: Text("자동차"),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductListScreen(category: "자동차"),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.asset(products[index].image, width: 50),
            title: Text(products[index].name),
            subtitle: Text("${products[index].price} 원"),
            trailing: IconButton(
              icon: Icon(Icons.add_shopping_cart),
              onPressed: () {
                _addToCart(products[index]);
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProductDetailScreen(product: products[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class CartScreen extends StatefulWidget {
  final Map<Product, int> cart;

  CartScreen({required this.cart});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void _updateQuantity(Product product, int change) {
    setState(() {
      if (widget.cart[product]! + change > 0) {
        widget.cart[product] = widget.cart[product]! + change;
      } else {
        widget.cart.remove(product);
      }
    });
  }

  int _calculateTotalPrice() {
    int total = 0;
    widget.cart.forEach((product, quantity) {
      total += product.price * quantity;
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("장바구니"),
      ),
      body: widget.cart.isEmpty
          ? Center(child: Text("장바구니가 비었습니다."))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.cart.length,
                    itemBuilder: (context, index) {
                      Product product = widget.cart.keys.elementAt(index);
                      int quantity = widget.cart[product]!;
                      return ListTile(
                        title: Text(product.name),
                        subtitle: Text(
                          "${product.price} 원 x $quantity",
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                _updateQuantity(product, -1);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                _updateQuantity(product, 1);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "총 가격: ${_calculateTotalPrice()} 원",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("구매 완료"),
                          content: Text("총 가격: ${_calculateTotalPrice()} 원"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  widget.cart.clear();
                                });
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: Text("확인"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text("구매하기"),
                ),
              ],
            ),
    );
  }
}

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(product.image, width: 150),
            SizedBox(height: 16),
            Text(
              product.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "${product.price} 원",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
