import '../../../core/routes/routes_names.dart';
import '../../../dependency_injection_packages.dart';
import '../../../utils/constants.dart';
import '../../../utils/k_images.dart';
import '../../../utils/language_string.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';

class EmptyProductButton extends StatelessWidget {
  const EmptyProductButton({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: false,
          expandedHeight: 55.0,
          toolbarHeight: 55.0,
          backgroundColor: Utils.dynamicPrimaryColor(context),
          pinned: true,
          title: const Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Text(
              Language.myShop,
              style: TextStyle(color: blackColor),
            ),
          ),
          // centerTitle: true,
          // titleSpacing: 30.0,
          // flexibleSpace: FlexibleSpaceBar(
          //   centerTitle: false,
          //   title: Text(
          //     Language.myShop,
          //     style: TextStyle(color: blackColor),
          //   ),
          // ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomImage(path: KImages.emptyOrder),
                const SizedBox(height: 10.0),
                const Text(
                  "No Product Available",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      color: blackColor),
                ),
                Container(
                  height: 48.0,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(
                      horizontal: defaultPadding, vertical: defaultPadding),
                  // color: Utils.dynamicPrimaryColor(context),
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0.0),
                        splashFactory: NoSplash.splashFactory,
                        backgroundColor: MaterialStateProperty.all(
                            Utils.dynamicPrimaryColor(context))),
                    onPressed: () => Navigator.pushNamed(
                        context, RouteNames.storeProductScreen),
                    icon: const Icon(
                      Icons.file_upload_outlined,
                      color: blackColor,
                    ),
                    label: const Text(
                      "Create Product",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20.0,
                        color: blackColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.1)
              ],
            ),
          ),
        )
      ],
    );
  }
}
