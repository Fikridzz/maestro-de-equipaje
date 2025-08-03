import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_master_bagasi/controller/home_controller.dart';
import 'package:test_master_bagasi/data/detail.dart';
import 'package:test_master_bagasi/data/product.dart';
import 'package:test_master_bagasi/styles/my_color.dart';
import 'package:test_master_bagasi/styles/my_font.dart';

class ProductPage extends HookConsumerWidget {
  final String id;
  const ProductPage(this.id, {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataProduct = ref.watch(getDetailProductProvider(id));
    final selectedColor = useState<String?>(null);
    final selectedSize = useState<String?>(null);
    final selectedVariant = useState<String?>(null);

    useEffect(() {
      if (dataProduct is AsyncData<Detail> && selectedVariant.value == null) {
        selectedVariant.value = dataProduct.value.productVariant.first.id;
        selectedColor.value =
            dataProduct.value.productVariant.first.colorVariant;
        selectedSize.value = dataProduct.value.productVariant.first.sizeVariant;
      }
      return null;
    }, [dataProduct]);

    void selectedProduct(
      String? color,
      String? size,
      List<Product> product,
    ) {
      selectedColor.value = color;
      selectedSize.value = size;
      selectedVariant.value = product
          .firstWhere(
            (e) => e.colorVariant == color && e.sizeVariant == size,
            orElse: () => Product(),
          )
          .id;
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 213, 213, 213),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          backgroundColor: MyColor.darkGrey,
          automaticallyImplyLeading: false,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 46),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: MyColor.greyOpacity,
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search_sharp, color: Colors.white),
                          SizedBox(width: 4),
                          Text(
                            'Cari di Master Bagasi',
                            style: MyFont.regularWhite,
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    child: SvgPicture.asset(
                      'assets/icon/menu_search_bar_transaction.svg',
                    ),
                  ),
                  SizedBox(width: 6),
                  Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    child: SvgPicture.asset(
                      'assets/icon/menu_search_bar_cart.svg',
                    ),
                  ),
                  SizedBox(width: 6),
                  Container(
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    child: SvgPicture.asset(
                      'assets/icon/menu_search_bar_chat.svg',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: dataProduct.when(
                data: (data) {
                  final productColors = data.productVariant
                      .map((e) => e.colorVariant ?? '')
                      .toSet()
                      .toList();

                  final carouselImages = [
                    ...data.productAssets.map((e) => e.url),
                    ...data.productVariant.map((e) => e.url)
                  ];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                        child: CarouselSlider.builder(
                          itemCount: carouselImages.length,
                          options: CarouselOptions(
                            height: 400,
                            viewportFraction: 1,
                            enableInfiniteScroll: false,
                          ),
                          itemBuilder: (context, index, realIndex) {
                            return ClipRRect(
                              borderRadius: BorderRadiusGeometry.circular(10),
                              child: Image.network(
                                width: MediaQuery.of(context).size.width,
                                carouselImages[index] ?? '',
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        padding: EdgeInsets.all(8),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: selectedVariant.value != null
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Rp ${data.productVariant.firstWhere(
                                          (e) => e.id == selectedVariant.value,
                                          orElse: () => Product(),
                                        ).sellingPrice}',
                                    style:
                                        MyFont.boldBlack.copyWith(fontSize: 16),
                                  ),
                                  Text(
                                    '${data.productVariant.firstWhere(
                                          (e) => e.id == selectedVariant.value,
                                          orElse: () => Product(),
                                        ).weight} Kg',
                                    style: MyFont.boldBlack,
                                  ),
                                ],
                              )
                            : Text(
                                'Varian tidak ditemukan',
                                style: MyFont.boldBlack.copyWith(fontSize: 16),
                              ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        padding: EdgeInsets.all(8),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.productDetail.name ?? '',
                              style: MyFont.semiBoldBlack,
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Opsi 1',
                              style: MyFont.boldBlack,
                            ),
                            SizedBox(height: 4),
                            SizedBox(
                              height: 36,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: productColors.length,
                                itemBuilder: (context, index) {
                                  final productColor = productColors[index];
                                  return GestureDetector(
                                    onTap: () => selectedProduct(
                                      productColor,
                                      selectedSize.value,
                                      data.productVariant,
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.all(6),
                                      margin: EdgeInsets.only(right: 8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        color:
                                            productColor == selectedColor.value
                                                ? Colors.black
                                                : Colors.white,
                                        border: Border.all(
                                          width: 1.2,
                                          color: Colors.black,
                                        ),
                                      ),
                                      child: Text(
                                        productColor,
                                        style: MyFont.regularBlack.copyWith(
                                          color: productColor ==
                                                  selectedColor.value
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Opsi 2',
                              style: MyFont.boldBlack,
                            ),
                            SizedBox(height: 4),
                            SizedBox(
                              height: 40,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: data.productVariant.length,
                                itemBuilder: (context, index) {
                                  final productSize =
                                      data.productVariant[index];
                                  return GestureDetector(
                                    onTap: () => selectedProduct(
                                      selectedColor.value,
                                      productSize.sizeVariant,
                                      data.productVariant,
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      margin: EdgeInsets.only(right: 8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        color: productSize.sizeVariant ==
                                                selectedSize.value
                                            ? Colors.black
                                            : Colors.white,
                                        border: Border.all(
                                          width: 1.2,
                                          color: Colors.black,
                                        ),
                                      ),
                                      child: Text(
                                        productSize.sizeVariant ?? '',
                                        style: MyFont.regularBlack.copyWith(
                                          color: productSize.sizeVariant ==
                                                  selectedSize.value
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        padding: EdgeInsets.all(8),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Detail Produk',
                              style: MyFont.boldBlack,
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    'Sertivikasi',
                                    style: MyFont.semiBoldBlack,
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    data.productDetail.productCertification ??
                                        '',
                                    style: MyFont.semiBoldBlack,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    'Kategori',
                                    style: MyFont.semiBoldBlack,
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    data.productDetail.categoryName ?? '',
                                    style: MyFont.semiBoldBlack,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    'Brand',
                                    style: MyFont.semiBoldBlack,
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    data.productDetail.brandName ?? '',
                                    style: MyFont.semiBoldBlack,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    'SKU',
                                    style: MyFont.semiBoldBlack,
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    data.productDetail.sku ?? '',
                                    style: MyFont.semiBoldBlack,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        padding: EdgeInsets.all(8),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Deskripsi Produk',
                              style: MyFont.boldBlack,
                            ),
                            Text(
                              data.productDetail.desc ?? '',
                              style: MyFont.semiBoldBlack,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24),
                    ],
                  );
                },
                error: (error, stackTrace) {
                  return Text(error.toString());
                },
                loading: () => Center(child: CircularProgressIndicator()),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: const Color.fromARGB(255, 213, 213, 213),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: selectedVariant.value != null
                              ? Colors.white
                              : Colors.grey[400],
                          side: BorderSide(
                              color: selectedVariant.value != null
                                  ? Colors.black
                                  : Colors.grey[400]!,
                              width: 1.2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(10),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Beli Langsung',
                          style: MyFont.semiBoldBlack,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: selectedVariant.value != null
                                ? Colors.black
                                : Colors.grey[400],
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadiusGeometry.circular(10))),
                        onPressed: () {},
                        child: Text(
                          '+ Keranjang',
                          style: MyFont.semiBoldWhite.copyWith(
                            color: selectedVariant.value != null
                                ? Colors.grey[400]
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
