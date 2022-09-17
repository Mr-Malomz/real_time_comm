import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:real_time_comm/models/product.dart';
import 'package:real_time_comm/promo_service.dart';
import 'package:real_time_comm/utils.dart';
import 'package:real_time_comm/widgets/card.dart';
import 'package:real_time_comm/widgets/promo.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Promo>? promos;
  bool _isLoading = false;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    _getPromoList();
    _subscribe();
  }

  _getPromoList() async {
    setState(() {
      _isLoading = true;
    });
    PromoService().getPromos().then((value) {
      setState(() {
        promos = value;
        _isLoading = false;
      });
    }).catchError((e) {
      setState(() {
        _isLoading = false;
        _isError = true;
      });
    });
  }

  _subscribe() {
    final realtime = Realtime(PromoService().client);
    final subscription = realtime.subscribe(['documents']);

    //listening to stream we can listen to
    subscription.stream.listen((e) {
      if (e.payload.isNotEmpty) {
        if (e.events.contains('databases.*.collections.*.documents.*.update')) {
          setState(() {
            promos!
                .map((element) => element.status = e.payload['status'])
                .toList();
          });
        }
      }
    });
  }

  List<Product> products = [
    Product(
      name: "Biscus Flower",
      price: 3.45,
      totalSold: 3453,
      imgURL:
          "https://images.unsplash.com/photo-1606041008023-472dfb5e530f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=388&q=80",
    ),
    Product(
      name: "Petal Flower",
      price: 1.25,
      totalSold: 4567,
      imgURL:
          "https://images.unsplash.com/photo-1595681242679-1b77b1e6a3c8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
    ),
    Product(
      name: "Sunflower",
      price: 5.02,
      totalSold: 45000,
      imgURL:
          "https://images.unsplash.com/photo-1470509037663-253afd7f0f51?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE8EBF3),
      appBar: AppBar(
        title: const Text("E-commerce Product List"),
        backgroundColor: const Color(0xff1C4ED8),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _isError
              ? const Center(
                  child: Text(
                    'Error loading promos',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : Column(
                  children: [
                    promos![0].status ? const PromoCard() : const SizedBox(),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return ProductCard(
                            name: products[index].name,
                            totalSold: products[index].totalSold,
                            price: products[index].price,
                            imgURL: products[index].imgURL);
                      },
                    ),
                  ],
                ),
    );
  }
}
