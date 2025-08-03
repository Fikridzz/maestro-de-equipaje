import 'dart:convert';

import 'package:test_master_bagasi/data/detail.dart';
import 'package:test_master_bagasi/data/homepage.dart';
import 'package:test_master_bagasi/repository/data_repository.dart';
import 'package:flutter/services.dart' show rootBundle;

class HttpDataRepository implements DataRepository {
  @override
  Future<Homepage> getDataHomepage() async {
    try {
      await Future.delayed(Duration(seconds: 2));

      var jsonString  = await rootBundle.loadString('assets/data/homepage_data.json');
      var data = jsonDecode(jsonString);
      return Homepage.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Detail> getDetailProduct(String productId) async {
    try {
      await Future.delayed(Duration(seconds: 2));

      var jsonString  = await rootBundle.loadString('assets/data/product_detail_data.json');
      var data = jsonDecode(jsonString);
      return Detail.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }
}
