import 'package:flutter/material.dart';

class PromoCard extends StatefulWidget {
  const PromoCard({Key? key}) : super(key: key);

  @override
  State<PromoCard> createState() => _PromoCardState();
}

class _PromoCardState extends State<PromoCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 30.0, 16.0, 0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 140.0,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Color(0xFFAD8317),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              boxShadow: [BoxShadow(color: Colors.grey)],
            ),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      "https://res.cloudinary.com/dtgbzmpca/image/upload/v1663276980/promo.png",
                      height: 100.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Take advantage of our promo",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 9.0),
                      Text(
                        "30% discount",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(height: 9.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              top: -20,
              left: MediaQuery.of(context).size.width * 0.8,
              child: ClipOval(
                child: Material(
                  color: Colors.white70,
                  child: InkWell(
                    onTap: () {},
                    child: const SizedBox(
                      width: 56,
                      height: 56,
                      child: Icon(
                        Icons.cancel,
                        size: 40.0,
                      ),
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
