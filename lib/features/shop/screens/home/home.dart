import 'package:trendify_mart/features/shop/controllers/product/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendify_mart/utils/constants/image_strings.dart';
import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../common/widgets/shimmers/vertical_product_shimmer.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../data/repositories/product/product_repository.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/device/device_utility.dart';
import '../all_products/all_products.dart';
import 'widgets/header_categories.dart';
import 'widgets/header_search_container.dart';
import 'widgets/home_appbar.dart';
import 'widgets/promo_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Header
            const TPrimaryHeaderContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// -- Appbar
                  THomeAppBar(),
                  SizedBox(height: TSizes.spaceBtwSections), 

                  /// -- Searchbar
                  TSearchContainer(text: 'Search in Store', showBorder: false),
                  SizedBox(height: TSizes.spaceBtwSections),

                  /// -- Categories
                  THeaderCategories(),
                  SizedBox(height: TSizes.spaceBtwSections * 2),
                ],
              ),
            ),

            /// -- Body
            Container(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// -- Promo Slider 1
                  const TPromoSilder(
                    banners: [
                      TImages.banner1,
                      TImages.banner2,
                      TImages.banner3,
                      TImages.banner4,
                      TImages.banner5,
                      TImages.banner6,
                      TImages.banner7
                    ]
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// -- Popular Products
                  TSectionHeading(
                    title: TTexts.popularProducts,
                    onPressed: () => Get.to(
                        () => AllProducts(
                      title: TTexts.popularProducts,
                      future: ProductRepository.instance.getAllFeaturedProducts(),
                    ),
                  ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  Obx(
                    () {
                      // Check if categories are still loading
                      if (controller.isLoading.value) return const TVerticalProductShimmer();

                      // Check if there are no featured categories found
                      if (controller.featuredProducts.isEmpty) {
                        return Center(child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium));
                      } else {
                        /// Record Found! 
                        return TGridLayout(
                          itemCount: controller.featuredProducts.length,
                          itemBuilder: (_, index) => TProductCardVertical(product: controller.featuredProducts[index], isNetworkImage: true),
                        );
                      }
                    },
                  ),

                  SizedBox(height: TDeviceUtils.getBottomNavigationBarHeight() + TSizes.defaultSpace),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
