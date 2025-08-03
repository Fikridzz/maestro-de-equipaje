import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_master_bagasi/controller/home_controller.dart';
import 'package:test_master_bagasi/styles/my_color.dart';
import 'package:test_master_bagasi/styles/my_font.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataHomepage = ref.watch(getHomepageProvider);
    return Scaffold(
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
        child: SingleChildScrollView(
          child: dataHomepage.when(
            data: (data) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    color: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Icon(Icons.location_on_outlined, color: Colors.white),
                        SizedBox(width: 8),
                        Text('Dikirim ke', style: MyFont.regularWhite),
                        Spacer(),
                        OutlinedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            side: BorderSide(color: Colors.white, width: 1.4),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          onPressed: () {},
                          child: Row(
                            children: [
                              Text(
                                'Kirim Barang Pribadi',
                                style: MyFont.boldWhite,
                              ),
                              SizedBox(width: 8),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 14,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: CarouselSlider.builder(
                      itemCount: data.banners.length,
                      options: CarouselOptions(
                        autoPlay: true,
                        viewportFraction: 1,
                        aspectRatio: 2.0,
                      ),
                      itemBuilder: (context, index, realIndex) {
                        return ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(15),
                          child: Image.network(
                            data.banners[index].url ?? '',
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            data.productsFromIna.first.containerBg ?? ''),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Brand Asli Indonesia',
                              style: MyFont.boldBlack.copyWith(fontSize: 16),
                            ),
                            Text(
                              'Lihat Semua',
                              style:
                                  MyFont.boldBlack.copyWith(color: Colors.red),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        SizedBox(
                          height: 130,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: data.productsFromIna.length,
                            itemBuilder: (context, index) {
                              final product = data.productsFromIna[index];
                              return Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadiusGeometry.circular(100),
                                      child: Image.network(
                                        product.imgUrl ?? '',
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container();
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      product.name ?? '',
                                      style: MyFont.boldBlack,
                                    ),
                                  ],
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
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          data.trendings.first.containerBg ?? '',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Lagi viral',
                              style: MyFont.boldWhite.copyWith(fontSize: 16),
                            ),
                            Text(
                              'Lihat Semua',
                              style:
                                  MyFont.boldBlack.copyWith(color: Colors.red),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        SizedBox(
                          height: 310,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: data.trendings.length,
                            itemBuilder: (context, index) {
                              final product = data.trendings[index];
                              return GestureDetector(
                                onTap: () => context
                                    .push('/product/${product.productId}'),
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  height: 250,
                                  width: 180,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadiusGeometry.circular(100),
                                        child: Image.network(
                                          product.imgUrl ?? '',
                                          height: 180,
                                          width: 180,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Container();
                                          },
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        product.name ?? '',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: MyFont.semiBoldBlack,
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        'Rp ${product.sellingPrice}',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: MyFont.boldBlack
                                            .copyWith(fontSize: 16),
                                      ),
                                      SizedBox(height: 4),
                                      Container(
                                        width: 180,
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: const Color.fromARGB(255, 213, 213, 213),
                                        ),
                                        child: Text(
                                          product.weight.toString(),
                                          style: MyFont.boldBlack.copyWith(fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            error: (error, stackTrace) {
              return Text(error.toString());
            },
            loading: () => Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}
