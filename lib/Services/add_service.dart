import 'package:firebase_database/firebase_database.dart';

class ShoppingService {
  final DatabaseReference _database =
  FirebaseDatabase.instance.ref().child('shopping_list');

  Stream<Map<String, String>> getShoppingList() {
    return _database.onValue.map(
          (event) {
        final Map<String, String> items = {};
        DataSnapshot snapshot = event.snapshot;
        // print('Snapshot data: ${snapshot.value}');
        if (snapshot.value != null) {
          Map<dynamic, dynamic> values =
          snapshot.value as Map<dynamic, dynamic>;
          values.forEach((key, value) {
            // print('Key: $key'); // Print the key
            // print('Value: $value'); // Print the value
            items[key] = value['name'] as String;
            items[key] = value['npm'] as String;
          });
        }
        return items;
      },
    );
  }

  void addShoppingItem(String itemName,String itemNpm) {
    _database.push().set({'name': itemName});
    _database.push().set({'npm': itemNpm});


  }


  Future<void> removeShoppingItem(String key) async {
    await _database.child(key).remove();
  }
}