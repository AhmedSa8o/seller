class RemoteUrls {
  static const String rootUrl = "https://storeassaf.com/";
  // static const String rootUrl = "https://risuvo.com/shopo_map/version/";

  static const String baseUrl = '${rootUrl}api/';

  static const String login = '${baseUrl}store-login';

  static String logout(String token) => '${baseUrl}user/logout?token=$token';

  static const String getSetting = '${baseUrl}website-setup';

  ///video related routes state
  static String storeVideo = "${baseUrl}store-product-video";

  static String getAllVideos(String productId) =>
      "${baseUrl}product-video/$productId";

  static String updateVideoStatus(String productId) =>
      "${baseUrl}product-video-status/$productId";

  static String deleteVideo(String productId) =>
      "${baseUrl}delete-product-video/$productId";

  ///video related routes end
  static String storeProduct(String token) =>
      "${baseUrl}seller/product?token=$token";

  static String getDashboardData(String token) =>
      "${baseUrl}seller/dashboard?token=$token";

  static String getAllProduct(String token) =>
      "${baseUrl}seller/product?token=$token";

  static String getAllPendingProduct(String token) =>
      "${baseUrl}seller/pending-product?token=$token";

  static String deleteSingleProduct(String id, String token) =>
      "${baseUrl}seller/product/$id?token=$token";

  static String updateSingleProduct(String id, String token) =>
      "${baseUrl}seller/update-product/$id?token=$token";

  static String getEditProduct(String id, String token) =>
      "${baseUrl}seller/product/$id/edit?token=$token";

  static String getAllGalleryImages(String id, String token) =>
      "${baseUrl}seller/product-gallery/$id?token=$token";

  static String galleryStatusChange(int id, String token) =>
      "${baseUrl}seller/product-gallery-status/$id?token=$token";

  static String deleteSingleGalleryImage(int id, String token) =>
      "${baseUrl}seller/delete-product-image/$id?token=$token";

  static String storeGalleryImages(String token) =>
      "${baseUrl}seller/store-product-gallery?token=$token";

  static String getAllProductVariantById(String id, String token) =>
      "${baseUrl}seller/product-variant/$id?token=$token";

  static String getAllProductVariantByVariantId(String id, String token) =>
      "${baseUrl}seller/get-product-variant/$id?token=$token";

  static String deleteProductVariant(String id, String token) =>
      "${baseUrl}seller/delete-product-variant/$id?token=$token";

  static String variantProductStatusChange(String id, String token) =>
      "${baseUrl}seller/product-variant-status/$id?token=$token";

  static String createVariantProduct(String token) =>
      "${baseUrl}seller/store-product-variant?token=$token";

  static String updateVariantProduct(String id, String token) =>
      "${baseUrl}seller/update-product-variant/$id?token=$token";

  static String getVariantItemById(String id, String token) =>
      "${baseUrl}seller/get-product-variant-item/$id?token=$token";

  static String getVIByVPIdAndVId(
          String productId, String variantId, String token) =>
      "${baseUrl}seller/product-variant-item?product_id=$productId&variant_id=$variantId&token=$token";

  static String deleteVariantItemById(String id, String token) =>
      "${baseUrl}seller/delete-product-variant-item/$id?token=$token";

  static String storeVariantItem(String token) =>
      "${baseUrl}seller/store-product-variant-item?token=$token";

  static String updateVIStatus(String itemId, String token) =>
      "${baseUrl}seller/product-variant-item-status/$itemId?token=$token";

  static String updateVariantItem(String itemId, String token) =>
      "${baseUrl}seller/update-product-variant-item/$itemId?token=$token";

//seller related route start
  static String getSellerAllOrders(String token) =>
      "${baseUrl}seller/all-order?token=$token";

  static String getSellerPendingOrders(String token) =>
      "${baseUrl}seller/pending-order?token=$token";

  static String getSellerProgressOrders(String token) =>
      "${baseUrl}seller/pregress-order?token=$token";

  static String getSellerDeliveredOrders(String token) =>
      "${baseUrl}seller/delivered-order?token=$token";

  static String getSellerCompletedOrders(String token) =>
      "${baseUrl}seller/completed-order?token=$token";

  static String getSellerDeclinedOrders(String token) =>
      "${baseUrl}seller/declined-order?token=$token";

  static String getSingleOrderDetailsProduct(String id, String token) =>
      "${baseUrl}seller/order-show/$id?token=$token";

//seller related route end

  static String getAllCategoryAndBrands(String token) =>
      "${baseUrl}seller/product/create?token=$token";

  static String updateProductStatus(String id, String token) =>
      "${baseUrl}seller/product-status/$id?token=$token";

  static String sellerProfile(String token) =>
      "${baseUrl}seller/my-profile?token=$token";

  static String updateSellerProfile(String token) =>
      "${baseUrl}seller/update-seller-profile?token=$token";

  static String updateSellerShop(String token) =>
      "${baseUrl}seller/update-seller-shop?token=$token";

  static String getCityByStateList(String stateId, String token) =>
      "${baseUrl}seller/city-by-state/$stateId?token=$token";

  static String getStateByCountryList(String countryId, String token) =>
      "${baseUrl}seller/state-by-country/$countryId?token=$token";

  static String passwordChange(String token) =>
      "${baseUrl}seller/password-update?token=$token";

  static String createWithdrawMethod(String token) =>
      "${baseUrl}seller/my-withdraw?token=$token";

  static String getAccountInformation(String id, String token) =>
      "${baseUrl}seller/get-withdraw-account-info/$id?token=$token";

  static String getAllMethodList(String token) =>
      "${baseUrl}seller/my-withdraw/create?token=$token";

  static String getAllWithdrawList(String token) =>
      "${baseUrl}seller/my-withdraw?token=$token";

  static String productReview(String token) =>
      "${baseUrl}seller/product-review?token=$token";

  static String getAllReviewsById(String id, String token) =>
      "${baseUrl}seller/show-product-review/$id?token=$token";

  static videoUrl(String videoUrl) => '${rootUrl}upload/$videoUrl';

  static String imageUrl(String url) => rootUrl + url;
}
