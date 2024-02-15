import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crafty_bay/presentation/state_holders/get_brand_controller.dart';
import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:crafty_bay/presentation/ui/widgets/home/brand_container.dart';

class BrandScreen extends StatefulWidget {
  const BrandScreen({super.key});

  @override
  State<BrandScreen> createState() => _BrandScreenState();
}

class _BrandScreenState extends State<BrandScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) {
        // Get.find<MainBottomNavController>().changeIndex(0);
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primaryColor.withOpacity(.5),
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios_new),
            ),
            title: const Text('Brands'),
          ),
          body: Padding(
            padding:  const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            child: GetBuilder<BrandController>(
                builder: (brandController) {
                  return Visibility(
                    visible: brandController.isLoading == false,
                    replacement: const Center(child: CircularProgressIndicator()),
                    child: GridView.builder(
                        itemCount: brandController.brand.brandList?.length??0,
                        gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          childAspectRatio: .78,
                          mainAxisSpacing: 0,
                          crossAxisSpacing: 5,
                        ),
                        itemBuilder: (context, index) {
                          return  Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: FittedBox(child: BrandContainer(
                              brand: brandController.brand.brandList![index],
                            ),
                          ));
                        }),
                  );
                }
            ),
          )),
    );
  }
}
