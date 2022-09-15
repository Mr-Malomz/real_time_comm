import 'package:appwrite/appwrite.dart';
import 'package:real_time_comm/utils.dart';

class StockService {
  Client client = Client();
  Databases? db;

  StockService() {
    _init();
  }

  //initialize the application
  _init() async {
    client
        .setEndpoint(AppConstant().endpoint)
        .setProject(AppConstant().projectId);

    db = Databases(client, databaseId: AppConstant().databaseId);

    //get current session
    Account account = Account(client);

    try {
      await account.get();
    } on AppwriteException catch (e) {
      if (e.code == 401) {
        account
            .createAnonymousSession()
            .then((value) => value)
            .catchError((e) => e);
      }
    }
  }

  Future<List<Promo>> getPromos() async {
    try {
      var data =
          await db?.listDocuments(collectionId: AppConstant().collectionId);
      var promoList =
          data?.documents.map((promo) => Promo.fromJson(promo.data)).toList();
      return promoList!;
    } catch (e) {
      throw Exception('Error getting list of promos');
    }
  }

  Future closePromo(String name, String status, String id) async {
    try {
      Promo updatePromo = Promo(
        name: name,
        status: status,
      );
      var data = await db?.updateDocument(
        collectionId: AppConstant().collectionId,
        documentId: id,
        data: updatePromo.toJson(),
      );
      return data;
    } catch (e) {
      throw Exception('Error updating promo');
    }
  }
}
