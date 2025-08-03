import 'package:test_master_bagasi/data/detail.dart';
import 'package:test_master_bagasi/data/homepage.dart';
import 'package:test_master_bagasi/data/product.dart';

abstract class DataRepository {
  Future<Homepage> getDataHomepage();
  Future<Detail> getDetailProduct(String productId);
}