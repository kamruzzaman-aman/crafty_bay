import 'package:carousel_slider/carousel_slider.dart';
import 'package:crafty_bay/presentation/state_holders/product_details_controller.dart';
import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsCarousel extends StatefulWidget {
  const ProductDetailsCarousel({
    super.key,
    required this.onTap, required this.imageUrls,
  });
  final List<String> imageUrls;
  final VoidCallback onTap;

  @override
  State<ProductDetailsCarousel> createState() => _ProductDetailsCarouselState();
}

class _ProductDetailsCarouselState extends State<ProductDetailsCarousel> {
  final ValueNotifier<int> _index = ValueNotifier<int>(0);

 // List<int> items = List.generate(5, (index) => index);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Stack(children: [
      Column(
        children: [
          CarouselSlider(
            items: widget.imageUrls
                .map(
                  (urls) => GetBuilder<ProductDetailsController>(
                    builder: (productDetailsController) {
                      return Visibility(
                        visible: productDetailsController.isLoading==false,
                        replacement: const Center(child: CircularProgressIndicator()),
                        child: Image.network(
                          urls,
                        ),
                      );
                    }
                  ),
                ).toList(),
            options: CarouselOptions(
                viewportFraction: 1,
                height: width * 0.66,
                onPageChanged: (index, reason) {
                  _index.value = index;
                }),
          ),
        ],
      ),
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: ValueListenableBuilder<int>(
          valueListenable: _index,
          builder: (_, value, __) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for(int i=0;i<widget.imageUrls.length;i++)
                 Container(
                  width: 10.0,
                  height: 10.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _index.value == i
                          ? AppColors.primaryColor
                          : Colors.white),
                )
              ],

            );
          },
        ),
      ),
    ]);
  }
}
