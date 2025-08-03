class Product {
  final String? id;
  final String? sku;
  final String? productType;
  final String? productCertification;
  final String? containerName;
  final String? containerBg;
  final String? brandId;
  final String? productId;
  final String? name;
  final String? desc;
  final String? type;
  final String? colorVariant;
  final String? sizeVariant;
  final String? variantName;
  final String? category;
  final String? categoryName;
  final String? categoryDetailName;
  final String? provinceName;
  final int? sold;
  final String? ingredients;
  final int? sellingPrice;
  final String? brandName;
  final double? weight;
  final double? productWeight;
  final int? discount;
  final bool? isMainImage;
  final String? imgUrl;
  final String? url;

  Product({
    this.containerName,
    this.containerBg,
    this.brandId,
    this.productId,
    this.name,
    this.desc,
    this.type,
    this.category,
    this.sellingPrice,
    this.brandName,
    this.weight,
    this.imgUrl,
    this.id,
    this.sku,
    this.productType,
    this.productCertification,
    this.colorVariant,
    this.sizeVariant,
    this.variantName,
    this.categoryName,
    this.categoryDetailName,
    this.provinceName,
    this.sold,
    this.ingredients,
    this.discount,
    this.url,
    this.isMainImage,
    this.productWeight,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      sku: json['sku'],
      productType: json['product_type'],
      productCertification: json['product_certification'],
      containerName: json['container_name'],
      containerBg: json['container_background'],
      brandId: json['brand_id'],
      productId: json['product_id'],
      name: json['name'],
      desc: json['desc'],
      type: json['type'],
      colorVariant: json['color_variant'],
      sizeVariant: json['size_variant'],
      variantName: json['variant_name'],
      category: json['category'],
      categoryName: json['category_name'],
      categoryDetailName: json['category_detail_name'],
      provinceName: json['province_name'],
      sold: json['sold'],
      ingredients: json['ingredients'],
      sellingPrice: json['selling_price'],
      brandName: json['brand_name'],
      weight: json['weight'],
      productWeight: json['product_weight'],
      discount: json['discount'],
      imgUrl: json['image_url'],
      url: json['url'],
      isMainImage: json['is_main_image'],
    );
  }
}
