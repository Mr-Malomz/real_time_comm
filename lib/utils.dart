class AppConstant {
  final String databaseId = "62fd8cd2b67d0edab8e4";
  final String projectId = "62fd8c8766522d6a0c35";
  final String endpoint = "http://192.168.1.11/v1";
  final String collectionId = "62fd8cfe5923c756372e";
}

class Promo {
  String? $id;
  String name;
  String status;

  Promo({required this.name, required this.status});

  factory Promo.fromJson(Map<dynamic, dynamic> json) {
    return Promo(
      name: json['name'],
      status: json['status'],
    );
  }

  Map<dynamic, dynamic> toJson() {
    return {'name': name, 'status': status};
  }
}
