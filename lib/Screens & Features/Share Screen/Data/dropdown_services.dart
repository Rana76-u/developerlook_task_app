import 'package:cloud_firestore/cloud_firestore.dart';

class DropDownServices {

  Future<List<Map<String, dynamic>>> getAirportList(String input) async {

    String upperInput = input.toUpperCase();
    String lowerInput = input.toLowerCase();

    QuerySnapshot<Object?> snapshot = await FirebaseFirestore.instance.collection('airports').where(
      Filter.or(
        Filter('code', isGreaterThanOrEqualTo: upperInput),
        Filter('code', isLessThan: '$lowerInput\uf8ff'),
        Filter('airport', isGreaterThanOrEqualTo: upperInput),
        Filter('airport', isLessThan: '$lowerInput\uf8ff'),
        Filter('city', isGreaterThanOrEqualTo: upperInput),
        Filter('city', isLessThan: '$lowerInput\uf8ff'),
      ),
    ).get();

    return snapshot.docs.map((doc) => {
      'city': doc['city'],
      'airport': doc['airport'],
      'code': doc['code'],
    }).toList();
  }

  Future<List<Map<String, dynamic>>> getAirLineList(String input) async {

    String upperInput = input.toUpperCase();
    String lowerInput = input.toLowerCase();

    QuerySnapshot<Object?> snapshot = await FirebaseFirestore.instance.collection('airlines').where(
      Filter.or(
        Filter('name', isGreaterThanOrEqualTo: upperInput),
        Filter('name', isLessThan: '$lowerInput\uf8ff'),
        Filter('country', isGreaterThanOrEqualTo: upperInput),
        Filter('country', isLessThan: '$lowerInput\uf8ff'),
        Filter('code', isGreaterThanOrEqualTo: upperInput),
        Filter('code', isLessThan: '$lowerInput\uf8ff'),
      ),
    ).get();

    return snapshot.docs.map((doc) => {
      'name': doc['name'],
      'country': doc['country'],
      'code': doc['code'],
    }).toList();
  }

  Future<List<Map<String, dynamic>>> getClassList(String input) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection('class').doc('set1').get();
    final List<dynamic> classList = doc['classes'];
    return classList.map((c) => {'name': c.toString()}).toList();
  }
}