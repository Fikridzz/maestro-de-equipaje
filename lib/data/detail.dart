import 'package:test_master_bagasi/data/product.dart';

class Detail {
  final Product productDetail;
  final List<Product> productVariant;
  final List<Product> productAssets;

  Detail({
    required this.productDetail,
    required this.productVariant,
    required this.productAssets,
  });

  factory Detail.fromJson(Map<String, dynamic> json) {
    return Detail(
      productDetail: Product.fromJson(json['data']['product_detail']),
      productVariant: List<Product>.from(
        json['data']['product_variant'].map((it) => Product.fromJson(it)),
      ),
      productAssets: List<Product>.from(
        json['data']['product_assets'].map((it) => Product.fromJson(it)),
      ),
    );
  }
}
