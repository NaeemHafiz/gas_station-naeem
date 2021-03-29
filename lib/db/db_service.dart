import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gas_station/models/branch_model.dart';
import 'package:gas_station/models/city_model.dart';
import 'package:gas_station/models/user/user_model.dart';

class FireStoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addUser(UserModel userModel, String userType) async {
    await _db.collection(userType).add(userModel.toMap());
  }

  Future<void> addUserPhoneAuthentication(
      UserModel userModel, String userType) async {
     await _db.collection(userType).add(userModel.toMap());

  }

  Future<void> addCity(CityModel cityModel, String userType) async {
    await _db.collection(userType).add(cityModel.toMap());
  }

  Future<void> addBranch(BranchModel branchModel, String userType) async {
    await _db.collection(userType).add(branchModel.toMap());
  }
// Future<BranchModel> fetchBranch() {
//   return _db
//       .collection('users')
//       .doc()
//       .get()
//       .then((snapShot) => BranchModel.branchFromFireStore(snapShot.data())).catchError(onError);
// }
//
// Stream<List<String>> fetchUnitTypes() {
//   return _db.collection('types').doc('units').snapshots().map((snapshot) =>
//       snapshot
//           .data()['production']
//           .map<String>((type) => type.toString())
//           .toList());
// }
//
// //Adding product to firestore
// Future<void> setProduct(Product product) {
//   var options = SetOptions(merge: true);
//   return _db
//       .collection('products')
//       .doc(product.productId)
//       .set(product.toMap(), options);
// }
//
// //Fetching single product
// Future<Product> fetchProduct(String productId) {
//   return _db
//       .collection('products')
//       .doc(productId)
//       .get()
//       .then((snapshot) => Product.fromFirestore(snapshot.data()));
// }
//
// //Fetching product from firestore
// Stream<List<Product>> fetchProductByVend0rId(String vendorId) {
//   return _db
//       .collection('products')
//       .where('vendorId', isEqualTo: vendorId)
//       .snapshots()
//       .map((query) => query.docs)
//       .map((snapshot) => snapshot
//       .map((document) => Product.fromFirestore(document.data()))
//       .toList());
// }
//
// // Fetching upcoming markets
// Stream<List<Market>> upComingMarkets() {
//   return _db
//       .collection('markets')
//       .where('dateEnd', isGreaterThan: DateTime.now().toIso8601String())
//       .snapshots()
//       .map((query) => query.docs)
//       .map((snapshot) => snapshot
//       .map((document) => Market.fromFirestore(document.data()))
//       .toList());
// }
//
// Stream<List<Product>> fetchAvailableProducts() {
//   return _db
//       .collection('products')
//       .where('availableUnits', isGreaterThan: 0)
//       .snapshots()
//       .map((query) => query.docs)
//       .map((snapshot) => snapshot
//       .map((document) => Product.fromFirestore(document.data()))
//       .toList());
// }
//
// Future<Vendor> fetchVendor(String vendorId) {
//   return _db
//       .collection('vendors')
//       .doc(vendorId)
//       .get()
//       .then((snapshot) => Vendor.fromFirestore(snapshot.data()));
// }
//
// Future<void> setVendor(Vendor vendor){
//   var options = SetOptions(merge: true);
//   return _db
//       .collection('vendors')
//       .doc(vendor.vendorId)
//       .set(vendor.toMap(),options);
// }
}
