import 'package:carousel_slider/carousel_slider.dart';
import 'package:crafty_bay/data/models/home_carousel_product_model.dart';
import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:flutter/material.dart';

class HomeCarousel extends StatefulWidget {
  const HomeCarousel({
    super.key,
    required this.onTap,
    required this.homeCarouselProductList,
  });

  final VoidCallback onTap;
  final List<HomeCarouselProduct> homeCarouselProductList;

  @override
  State<HomeCarousel> createState() => _HomeCarouselState();
}

class _HomeCarouselState extends State<HomeCarousel> {
  final ValueNotifier<int> _index = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        CarouselSlider(
          items: widget.homeCarouselProductList
              .map(
                (product) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 1.5),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        Image.network(
                          product.image??'',
                          height: height * 0.3,
                          fit: BoxFit.fitHeight,
                        ),
                        Positioned(
                          top: 50,
                          bottom: 0,
                          left: 15,
                          right: 0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title.toString(),
                                style:  TextStyle(
                                  fontSize: width * 0.05,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: width * 0.5,
                                child: Text(
                                  product.shortDes.toString(),
                                  style:  TextStyle(
                                    fontSize: width * 0.035,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              )
              .toList(),
          options: CarouselOptions(
              viewportFraction: 1,
              height: width * 0.45,
              onPageChanged: (index, reason) {
                _index.value = index;
              }),
        ),
        const SizedBox(height: 5),
        ValueListenableBuilder(
          valueListenable: _index,
          builder: (BuildContext context, int value, Widget? child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < widget.homeCarouselProductList.length; i++)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: .9),
                    alignment: Alignment.center,
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      color: _index.value == i
                          ? AppColors.primaryColor
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
