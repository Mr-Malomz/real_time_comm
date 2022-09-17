class AppConstant {
  final String databaseId = "6324e4eeacd349fc27a7";
  final String projectId = "6324e49a723c62b19cff";
  final String endpoint = "http://192.168.1.10/v1";
  final String collectionId = "6324e51dd009b3d1a1f5";
}

class Promo {
  String? $id;
  String name;
  bool status;

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
