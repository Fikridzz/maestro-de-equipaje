import 'package:test_master_bagasi/data/banner.dart';
import 'package:test_master_bagasi/data/product.dart';

class Homepage {
  final List<Banner> banners;
  final List<Product> productsFromIna;
  final List<Product> trendings;

  Homepage({
    required this.banners,
    required this.productsFromIna,
    required this.trendings,
  });

  factory Homepage.fromJson(Map<String, dynamic> json) {
    return Homepage(
      banners: List<Banner>.from(
        json['data']['banner'].map((it) => Banner.fromJson(it)),
      ),
      productsFromIna: List<Product>.from(
        json['data']['brand_asli_indonesia'].map((it) => Product.fromJson(it)),
      ),
      trendings: List<Product>.from(
        json['data']['lagi_viral'].map((it) => Product.fromJson(it)),
      ),
    );
  }
}
