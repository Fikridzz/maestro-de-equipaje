import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_master_bagasi/data/detail.dart';
import 'package:test_master_bagasi/data/homepage.dart';
import 'package:test_master_bagasi/data/product.dart';
import 'package:test_master_bagasi/repository/data_repository.dart';
import 'package:test_master_bagasi/repository/http_data_repository.dart';

final dataRepositoryProvider = Provider<DataRepository>((ref) {
  return HttpDataRepository();
});

final getHomepageProvider = FutureProvider.autoDispose<Homepage>((ref) {
  final repository = ref.watch(dataRepositoryProvider);
  return repository.getDataHomepage();
});

final getDetailProductProvider = FutureProvider.family.autoDispose<Detail, String>((ref, productId) {
  final repository = ref.watch(dataRepositoryProvider);
  return repository.getDetailProduct(productId);
});