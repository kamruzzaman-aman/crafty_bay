import 'package:get/get.dart';
import 'package:crafty_bay/presentation/state_holders/category_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/get_brand_controller.dart';
import 'package:crafty_bay/presentation/state_holders/get_review_controller.dart';
import 'package:crafty_bay/presentation/state_holders/home_carousel_product_controller.dart';
import 'package:crafty_bay/presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:crafty_bay/presentation/state_holders/new_product_controller.dart';
import 'package:crafty_bay/presentation/state_holders/product_controller.dart';
import 'package:crafty_bay/presentation/state_holders/product_wish_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/sentEmailOtpController.dart';
import 'package:crafty_bay/presentation/state_holders/special_product_controller.dart';
import 'package:crafty_bay/presentation/state_holders/verify_otp_controller.dart';
import 'package:crafty_bay/presentation/state_holders/add_to_cart_controller.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:crafty_bay/presentation/state_holders/cart_controller.dart';
import 'package:crafty_bay/presentation/state_holders/create_profile_controller.dart';
import 'package:crafty_bay/presentation/state_holders/create_review_controller.dart';
import 'package:crafty_bay/presentation/state_holders/create_wish_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/delete_cart_controller.dart';
import 'package:crafty_bay/presentation/state_holders/invoice_create_controller.dart';
import 'package:crafty_bay/presentation/state_holders/product_details_controller.dart';
import 'package:crafty_bay/presentation/state_holders/read_profile_controller.dart';
import 'package:crafty_bay/presentation/state_holders/popular_product_controller.dart';


class GetBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainBottomNavController());
    Get.put(SentEmailOtpController());
    Get.put(VerifyOtpController());
    Get.put(ReadProfileController());
    Get.put(AuthController());
    Get.put(CreateProfileController());
    Get.put(HomeCarouselProductController());
    Get.put(CategotyListController());
    Get.put(PopularProductController());
    Get.put(SpecialProductController());
    Get.put(NewProductController());
    Get.put(ProductController());
    Get.put(ProductDetailsController());
    Get.put(AddToCartController());
    Get.put(CartController());
    Get.put(DeleteCartController());
    Get.put(CreateWishListController());
    Get.put(ProductWishListController());
    Get.put(InvoiceCreateController());
    Get.put(GetReviewController());
    Get.put(CreateReviewController());
    Get.put(BrandController());
  }
}