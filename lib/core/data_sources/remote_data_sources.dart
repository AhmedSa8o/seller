import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:seller_app/core/errors/exception.dart';

import '../../dependency_injection_packages.dart';
import '../../modules/on_boarding/model/website_setup_model.dart';
import '../../modules/video/controller/video_cubit/video_state_model.dart';
import '../../modules/video/model/video_model.dart';
import '../../modules/withdraw/model/withdraw_model.dart';
import 'remote_data_sources_packages.dart';

abstract class RemoteDataSources {
  Future<UserResponseModel> login(Map<String, dynamic> body);

  Future<String> logout(String token);
  Future<List<SpecificationModel>> getSpecificationKeys(String token);

  Future<WebsiteSetupModel> getSetting();

  Future<DashboardModel> getDashboardData(String token);

  Future<ProductModel> getAllProduct(String token);

  Future<ProductModel> getAllPendingProduct(String token);

  Future<SellerAllOrdersModel> getSellerAllOrders(String token);

  Future<SellerAllOrdersModel> getSellerCompletedOrders(String token);

  Future<SellerAllOrdersModel> getSellerDeclinedOrders(String token);

  Future<SellerAllOrdersModel> getSellerDeliveredOrders(String token);

  Future<SellerAllOrdersModel> getSellerPendingOrders(String token);

  Future<SellerAllOrdersModel> getSellerProgressOrders(String token);

  Future<SellerProfileModel> getSellerProfile(String token);

  Future<List<ReviewModel>> getAllReviews(String token);

  Future<ReviewModel> getAllReviewsById(String id, String token);

  Future<String> storeProduct(StoreProductStateModel body, String token);

  Future<CategoryBrandModel> getAllCategoryAndBrands(String token);

  Future<String> updateProductStatus(String id, String token);

  Future<String> deleteSingleProduct(String id, String token);

  Future<OrderModel> getSingleOrderDetailsProduct(String id, String token);

  Future<String> updateSingleProduct(
      String id, String token, UpdateProductModelState body);

  Future<EditProductModel> getEditProduct(String id, String token);

  Future<GalleryModel> getAllGalleryImages(String id, String token);

  Future<String> galleryStatusChange(int id, String token);

  Future<String> deleteSingleGalleryImage(int id, String token);

  Future<String> storeGalleryImages(StoreGalleryStateModel body, String token);

  Future<ProductVariantModel> getAllProductVariantById(String id, String token);

  Future<SingleVariant> getAllProductVariantByVariantId(
      String id, String token);

  Future<String> deleteProductVariant(String id, String token);

  Future<String> variantProductStatusChange(String id, String token);

  Future<String> createVariantProduct(
      String token, CreateVariantStateModel body);

  Future<String> updateVariantProduct(
      String id, String token, UpdateVariantStateModel body);

  Future<VariantItem> getVariantItemById(String id, String token);

  Future<VariantItemModel> getVIByVPIdAndVId(
      String productId, String variantId, String token);

  Future<String> deleteVariantItemById(String id, String token);

  Future<String> storeVariantItem(String token, Map<String, dynamic> body);

  Future<String> updateVariantItem(
      String itemId, String token, UpdateVariantItemStateModel body);

  Future<String> updateVIStatus(String itemId, String token);

  Future<String> updateSellerProfile(
      UpdateSellerProfileStateModel body, String token);

  Future<String> updateSellerShop(
      UpdateSellerShopStateModel body, String token);

  Future<List<StateByCountryModel>> getStateByCountryList(
      String countryId, String token);

  Future<String> passwordChange(PasswordChangeModel body, String token);

  Future<List<CityByStateModel>> getCityByStateList(
      String stateId, String token);

  Future<AccountInfoModel> getAccountInformation(String id, String token);

  Future<List<AccountInfoModel>> getAllMethodList(String token);

  Future<List<WithdrawModel>> getAllWithdrawList(String token);

  Future<String> createWithdrawMethod(
      CreateWithdrawStateModel body, String token);

  Future<List<VideoModel>> getAllVideos(String productId);

  Future<String> updateVideoStatus(String productId);

  Future<String> deleteVideo(String productId);

  Future<String> storeVideo(VideoStateModel body);
}

typedef CallClientMethod = Future<http.Response> Function();

class RemoteDataSourcesImpl implements RemoteDataSources {
  final http.Client client;

  RemoteDataSourcesImpl({required this.client});

  final postHeader = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'X-Requested-With': 'XMLHttpRequest',
  };

  final defaultHeader = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'X-Requested-With': 'XMLHttpRequest',
  };

  @override
  Future<UserResponseModel> login(Map<String, dynamic> body) async {
    final uri = Uri.parse(RemoteUrls.login);
    final headers = {
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
    };
    final callClient = client.post(uri, headers: headers, body: body);
    final response =
        await NetworkParser.callClientWithCatchException(() => callClient);
    return UserResponseModel.fromMap(response);
  }

  @override
  Future<String> logout(String token) async {
    final uri = Uri.parse(RemoteUrls.logout(token));
    final headers = {'Accept': 'application/json'};
    final callClient = client.get(uri, headers: headers);
    final response =
        await NetworkParser.callClientWithCatchException(() => callClient);
    return response['notification'] as String;
  }

  @override
  Future<DashboardModel> getDashboardData(String token) async {
    final uri = Uri.parse(RemoteUrls.getDashboardData(token));
    //final headers = {'Accept': 'application/json'};
    final clientMethod = client.get(uri, headers: defaultHeader);
    final callClientMethod =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return DashboardModel.fromMap(callClientMethod);
  }

  @override
  Future<ProductModel> getAllProduct(String token) async {
    final uri = Uri.parse(RemoteUrls.getAllProduct(token));
    //final headers = {'Accept': 'application/json'};

    final clientMethod = client.get(uri, headers: defaultHeader);
    final response =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return ProductModel.fromMap(response);
  }

  @override
  Future<ProductModel> getAllPendingProduct(String token) async {
    final uri = Uri.parse(RemoteUrls.getAllPendingProduct(token));
    //final headers = {'Accept': 'application/json'};

    final clientMethod = client.get(uri, headers: defaultHeader);
    final response =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return ProductModel.fromMap(response);
  }

  @override
  Future<SellerAllOrdersModel> getSellerAllOrders(String token) async {
    final uri = Uri.parse(RemoteUrls.getSellerAllOrders(token));
    //final headers = {'Accept': 'application/json'};

    final clientMethod = client.get(uri, headers: defaultHeader);
    final response =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return SellerAllOrdersModel.fromMap(response);
  }

  @override
  Future<SellerAllOrdersModel> getSellerCompletedOrders(String token) async {
    final uri = Uri.parse(RemoteUrls.getSellerCompletedOrders(token));
    //final headers = {'Accept': 'application/json'};

    final clientMethod = client.get(uri, headers: defaultHeader);
    final response =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return SellerAllOrdersModel.fromMap(response);
  }

  @override
  Future<SellerAllOrdersModel> getSellerDeclinedOrders(String token) async {
    final uri = Uri.parse(RemoteUrls.getSellerDeclinedOrders(token));
    //final headers = {'Accept': 'application/json'};

    final clientMethod = client.get(uri, headers: defaultHeader);
    final response =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return SellerAllOrdersModel.fromMap(response);
  }

  @override
  Future<SellerAllOrdersModel> getSellerDeliveredOrders(String token) async {
    final uri = Uri.parse(RemoteUrls.getSellerDeliveredOrders(token));
    // final headers = {'Accept': 'application/json'};

    final clientMethod = client.get(uri, headers: defaultHeader);
    final response =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return SellerAllOrdersModel.fromMap(response);
  }

  @override
  Future<SellerAllOrdersModel> getSellerPendingOrders(String token) async {
    final uri = Uri.parse(RemoteUrls.getSellerPendingOrders(token));
    //final headers = {'Accept': 'application/json'};

    final clientMethod = client.get(uri, headers: defaultHeader);
    final response =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return SellerAllOrdersModel.fromMap(response);
  }

  @override
  Future<SellerAllOrdersModel> getSellerProgressOrders(String token) async {
    final uri = Uri.parse(RemoteUrls.getSellerProgressOrders(token));
    //final headers = {'Accept': 'application/json'};

    final clientMethod = client.get(uri, headers: defaultHeader);
    final response =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return SellerAllOrdersModel.fromMap(response);
  }

  @override
  Future<SellerProfileModel> getSellerProfile(String token) async {
    final url = Uri.parse(RemoteUrls.sellerProfile(token));
    //final headers = {'Accept': 'application/json'};
    final clientMethod = client.get(url, headers: defaultHeader);
    final sellerResponse =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return SellerProfileModel.fromMap(sellerResponse);
  }

  @override
  Future<List<ReviewModel>> getAllReviews(String token) async {
    final url = Uri.parse(RemoteUrls.productReview(token));
    //final headers = {'Accept': 'application/json'};
    final clientMethod = client.get(url, headers: defaultHeader);
    final response =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    final reviews = response['reviews'] as List;
    return List<ReviewModel>.from(reviews.map((e) => ReviewModel.fromMap(e)))
        .toList();
  }

  @override
  Future<String> storeProduct(StoreProductStateModel body, String token) async {
    final url = Uri.parse(RemoteUrls.storeProduct(token));
    final request = http.MultipartRequest('POST', url);

    // Convert the dynamic map to string map for fields
    final bodyMap = body.toMap();
    final fieldsMap = <String, String>{};

    bodyMap.forEach((key, value) {
      if (value != null) {
        // Convert any non-string values to string
        if (value is List) {
          // Handle specifications arrays
          if (key == 'keys' || key == 'specifications') {
            for (var i = 0; i < value.length; i++) {
              fieldsMap['$key[$i]'] = value[i].toString();
            }
          }
        } else {
          fieldsMap[key] = value.toString();
        }
      }
    });

    request.fields.addAll(fieldsMap);
    request.headers.addAll(postHeader);

    if (body.thumbImage.isNotEmpty) {
      final file =
          await http.MultipartFile.fromPath('thumb_image', body.thumbImage);
      request.files.add(file);
    }

    http.StreamedResponse response = await request.send();
    final clientMethod = http.Response.fromStream(response);

    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }

  @override
  Future<CategoryBrandModel> getAllCategoryAndBrands(String token) async {
    final url = Uri.parse(RemoteUrls.getAllCategoryAndBrands(token));
    //final headers = {'Accept': 'application/json'};
    final callClientMethod = client.get(url, headers: defaultHeader);
    final response = await NetworkParser.callClientWithCatchException(
        () => callClientMethod);
    return CategoryBrandModel.fromMap(response);
  }

  @override
  Future<String> updateProductStatus(String id, String token) async {
    final url = Uri.parse(RemoteUrls.updateProductStatus(id, token));
    // final headers = {'Accept': 'application/json'};
    final callClientMethod = client.put(url, headers: postHeader);
    final response = await NetworkParser.callClientWithCatchException(
        () => callClientMethod);
    return response as String;
  }

  @override
  Future<String> deleteSingleProduct(String id, String token) async {
    final url = Uri.parse(RemoteUrls.deleteSingleProduct(id, token));
    //final headers = {'Accept': 'application/json'};
    final clientMethod = client.delete(url, headers: defaultHeader);
    final response =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return response['message'];
  }

  @override
  Future<String> updateSingleProduct(
      String id, String token, UpdateProductModelState body) async {
    final url = Uri.parse(RemoteUrls.updateSingleProduct(id, token));
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'X-Requested-With': 'XMLHttpRequest',
    };

    final request = http.MultipartRequest('POST', url);

    // Convert the Map<String, dynamic> to Map<String, String>
    final Map<String, dynamic> dynamicMap = body.toMap();
    final Map<String, String> stringMap = dynamicMap.map(
      (key, value) => MapEntry(key, value?.toString() ?? ''),
    );

    request.fields.addAll(stringMap);
    request.headers.addAll(headers);

    if (body.thumbImage.isNotEmpty) {
      final file =
          await http.MultipartFile.fromPath('thumb_image', body.thumbImage);
      request.files.add(file);
    }

    http.StreamedResponse response = await request.send();
    final clientMethod = http.Response.fromStream(response);

    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }

  @override
  Future<GalleryModel> getAllGalleryImages(String id, String token) async {
    final url = Uri.parse(RemoteUrls.getAllGalleryImages(id, token));
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    final clientMethod = client.get(url, headers: headers);
    final responseBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return GalleryModel.fromMap(responseBody);
  }

  @override
  Future<String> galleryStatusChange(int id, String token) async {
    final url = Uri.parse(RemoteUrls.galleryStatusChange(id, token));
    // final headers = {
    //   'Accept': 'application/json',
    //   'Content-Type': 'application/json'
    // };
    final clientMethod = client.put(url, headers: postHeader);
    final responseBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseBody as String;
  }

  @override
  Future<String> deleteSingleGalleryImage(int id, String token) async {
    final url = Uri.parse(RemoteUrls.deleteSingleGalleryImage(id, token));
    final clientMethod = client.delete(url, headers: defaultHeader);
    final responseBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseBody['message'] as String;
  }

  @override
  Future<String> storeGalleryImages(
      StoreGalleryStateModel body, String token) async {
    final url = Uri.parse(RemoteUrls.storeGalleryImages(token));
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
    };
    // final clientMethod = client.put(url, headers: headers,body: body);
    final request = http.MultipartRequest('POST', url);
    request.fields.addAll(body.toMap());

    request.headers.addAll(postHeader);
    List<MultipartFile> list = [];
    if (body.images.isNotEmpty) {
      for (int i = 0; i < body.images.length; i++) {
        debugPrint('imagesss: ${body.images[i]}');
        final file =
            await http.MultipartFile.fromPath('images[$i]', body.images[i]);
        list.add(file);
      }

      debugPrint('called from Remote Data source: ${list.length}');
      request.files.addAll(list);
    }

    // (int i = 0; i < images.length; i++) {
    //   ByteData byteData = await images[i].getByteData();
    //   List<int> imageData = byteData.buffer.asUint8List();
    //
    //   MultipartFile multipartFile = MultipartFile.fromBytes(
    //     imageData,
    //     filename: images[i].name,
    //     contentType: MediaType('image', 'jpg'),
    //   );
    //
    //   _list.add(multipartFile);
    // }

    http.StreamedResponse response = await request.send();
    final clientMethod = http.Response.fromStream(response);

    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }

  @override
  Future<EditProductModel> getEditProduct(String id, String token) async {
    final url = Uri.parse(RemoteUrls.getEditProduct(id, token));
    final clientMethod = client.get(url);
    final responseBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return EditProductModel.fromMap(responseBody);
  }

  @override
  Future<ProductVariantModel> getAllProductVariantById(
      String id, String token) async {
    final url = Uri.parse(RemoteUrls.getAllProductVariantById(id, token));
    final clientMethod = client.get(url, headers: defaultHeader);
    final responseBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return ProductVariantModel.fromMap(responseBody);
  }

  @override
  Future<SingleVariant> getAllProductVariantByVariantId(
      String id, String token) async {
    final url = Uri.parse(RemoteUrls.getAllProductVariantById(id, token));
    final clientMethod = client.get(url, headers: defaultHeader);
    final responseBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return SingleVariant.fromMap(responseBody);
  }

  @override
  Future<String> deleteProductVariant(String id, String token) async {
    final url = Uri.parse(RemoteUrls.deleteProductVariant(id, token));
    final clientMethod = client.delete(url, headers: defaultHeader);
    final responseBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseBody['message'] as String;
  }

  @override
  Future<String> variantProductStatusChange(String id, String token) async {
    final url = Uri.parse(RemoteUrls.variantProductStatusChange(id, token));
    final clientMethod = client.put(url, headers: postHeader);
    final responseBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseBody as String;
  }

  @override
  Future<String> createVariantProduct(
      String token, CreateVariantStateModel body) async {
    final url = Uri.parse(RemoteUrls.createVariantProduct(token));
    final headers = {
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
    };
    final clientMethod = client.post(url, headers: headers, body: body.toMap());
    final responseBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseBody["message"] as String;
  }

  @override
  Future<String> updateVariantProduct(
      String id, String token, UpdateVariantStateModel body) async {
    final url = Uri.parse(RemoteUrls.updateVariantProduct(id, token));
    final headers = {
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
    };
    final clientMethod = client.put(url, headers: headers, body: body.toMap());
    final responseBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseBody["message"] as String;
  }

  @override
  Future<VariantItemModel> getVIByVPIdAndVId(
      String productId, String variantId, String token) async {
    final url =
        Uri.parse(RemoteUrls.getVIByVPIdAndVId(productId, variantId, token));
    final clientMethod = client.get(url, headers: defaultHeader);
    final responseBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return VariantItemModel.fromMap(responseBody);
  }

  @override
  Future<VariantItem> getVariantItemById(String id, String token) async {
    final url = Uri.parse(RemoteUrls.getVariantItemById(id, token));
    final clientMethod = client.get(url, headers: defaultHeader);
    final responseBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return VariantItem.fromMap(responseBody);
  }

  @override
  Future<String> deleteVariantItemById(String id, String token) async {
    final url = Uri.parse(RemoteUrls.deleteVariantItemById(id, token));
    final clientMethod = client.delete(url, headers: defaultHeader);
    final responseBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseBody["message"] as String;
  }

  @override
  Future<String> storeVariantItem(
      String token, Map<String, dynamic> body) async {
    final url = Uri.parse(RemoteUrls.storeVariantItem(token));
    final headers = {
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
    };
    final clientMethod = client.post(url, headers: headers, body: body);
    final responseBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseBody["message"] as String;
  }

  @override
  Future<String> updateVIStatus(String itemId, String token) async {
    final url = Uri.parse(RemoteUrls.updateVIStatus(itemId, token));
    final clientMethod = client.put(url, headers: postHeader);
    final responseBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseBody;
  }

  @override
  Future<String> updateVariantItem(
      String itemId, String token, UpdateVariantItemStateModel body) async {
    final url = Uri.parse(RemoteUrls.updateVariantItem(itemId, token));
    final headers = {
      // 'Content-Type': 'application/json',
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
    };
    final clientMethod = client.put(url, headers: headers, body: body.toMap());
    final responseBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseBody["message"] as String;
  }

  @override
  Future<OrderModel> getSingleOrderDetailsProduct(
      String id, String token) async {
    final url = Uri.parse(RemoteUrls.getSingleOrderDetailsProduct(id, token));
    final clientMethod = client.get(url, headers: defaultHeader);
    final responseBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return OrderModel.fromMap(responseBody["order"]);
  }

  @override
  Future<WebsiteSetupModel> getSetting() async {
    final url = Uri.parse(RemoteUrls.getSetting);
    final clientMethod = client.get(url, headers: defaultHeader);
    final responseBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return WebsiteSetupModel.fromMap(responseBody);
  }

  @override
  Future<ReviewModel> getAllReviewsById(String id, String token) async {
    final url = Uri.parse(RemoteUrls.getAllReviewsById(id, token));
    final clientMethod = client.get(url, headers: defaultHeader);
    final responseBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return ReviewModel.fromMap(responseBody['review']);
  }

  // @override
  // Future<String> updateSellerProfile(
  //     Map<String, dynamic> body, String token) async {
  //   final url = Uri.parse(RemoteUrls.updateSellerProfile(token));
  //   final headers = {
  //     'Accept': 'application/json',
  //   };
  //   final clientMethod = client.put(url, headers: headers, body: body);
  //   final responseBody =
  //       await NetworkParser.callClientWithCatchException(() => clientMethod);
  //   return responseBody['notification'] as String;
  // }

  // @override
  // Future<String> updateSellerShop(
  //     Map<String, dynamic> body, String token) async {
  //   final url = Uri.parse(RemoteUrls.updateSellerShop(token));
  //   final headers = {
  //     'Accept': 'application/json',
  //     'Content-Type': 'application/x-www-form-urlencoded'
  //   };
  //   final clientMethod = client.put(url, headers: headers, body: body);
  //   final responseBody =
  //       await NetworkParser.callClientWithCatchException(() => clientMethod);
  //   return responseBody["notification"] as String;
  // }

  @override
  Future<String> updateSellerProfile(
      UpdateSellerProfileStateModel body, String token) async {
    final url = Uri.parse(RemoteUrls.updateSellerProfile(token));
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'X-Requested-With': 'XMLHttpRequest',
    };
    // final clientMethod = client.put(url, headers: headers,body: body);
    final request = http.MultipartRequest(
      'POST',
      url,
    );
    request.fields.addAll(body.toMap());

    request.headers.addAll(headers);
    if (body.image.isNotEmpty) {
      print('immmmmm: ${body.image}');
      final file = await http.MultipartFile.fromPath('image', body.image);
      request.files.add(file);
    }
    // final file = await http.MultipartFile.fromPath('image', body.image);
    // request.files.add(file);

    http.StreamedResponse response = await request.send();
    final clientMethod = http.Response.fromStream(response);

    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['notification'] as String;
  }

  @override
  Future<String> updateSellerShop(
      UpdateSellerShopStateModel body, String token) async {
    final url = Uri.parse(RemoteUrls.updateSellerShop(token));
    final mimeTypeData =
        lookupMimeType(body.bannerImage, headerBytes: [0xFF, 0xD8])!.split('/');
    final headers = {
      'Accept': 'application/json',
      // 'Content-Type': 'application/octet-stream'
      'Content-Type': 'application/x-www-form-urlencoded',
      'X-Requested-With': 'XMLHttpRequest',
    };

    final request = http.MultipartRequest('POST', url);
    request.fields.addAll(body.toMap());
    print('bodyyyyyy: ${body.toMap()}');
    final length = body.bannerImage.length;

    request.headers.addAll(headers);
    final List<MultipartFile> allImages = [];
    if (body.bannerImage.isNotEmpty) {
      final file =
          await http.MultipartFile.fromPath('banner_image', body.bannerImage);
      // request.files.add(file);
      debugPrint('bannerImageAdded  ${body.bannerImage}');
      debugPrint('bannerType ${body.bannerImage.runtimeType}');
      request.files.add(file);
    }
    if (body.logo.isNotEmpty) {
      final logoFile = await http.MultipartFile.fromPath('logo', body.logo);
      debugPrint('logoImageAdded ${body.logo}');
      debugPrint('logoType ${body.logo.runtimeType}');
      request.files.add(logoFile);
    }
    // request.files.add(allImages);

    //https://stackoverflow.com/questions/49125191/how-to-upload-images-and-file-to-a-server-in-flutter
    //https://stackoverflow.com/questions/74842077/how-to-upload-image-to-server-in-flutter
    //https://stackoverflow.com/questions/73726499/how-can-i-upload-image-to-server-in-flutter

    http.StreamedResponse response = await request.send();
    final clientMethod = http.Response.fromStream(response);

    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['notification'] as String;
  }

  @override
  Future<List<CityByStateModel>> getCityByStateList(
      String stateId, String token) async {
    final url = Uri.parse(RemoteUrls.getCityByStateList(stateId, token));
    final clientMethod = client.get(url, headers: defaultHeader);
    final responseBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    final cityList = responseBody['cities'] as List;
    return List<CityByStateModel>.from(
        cityList.map((city) => CityByStateModel.fromMap(city)));
  }

  @override
  Future<List<StateByCountryModel>> getStateByCountryList(
      String countryId, String token) async {
    final url = Uri.parse(RemoteUrls.getStateByCountryList(countryId, token));
    final clientMethod = client.get(url, headers: defaultHeader);
    final responseBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);

    final stateList = responseBody['states'] as List;
    return List<StateByCountryModel>.from(
        stateList.map((state) => StateByCountryModel.fromMap(state)));
  }

  @override
  Future<String> passwordChange(PasswordChangeModel body, String token) async {
    final url = Uri.parse(RemoteUrls.passwordChange(token));
    final headers = {
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
    };
    final clientMethod = client.put(url, headers: headers, body: body.toMap());
    final responseBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);

    return responseBody["notification"] as String;
  }

  @override
  Future<String> createWithdrawMethod(
      CreateWithdrawStateModel body, String token) async {
    final url = Uri.parse(RemoteUrls.createWithdrawMethod(token));
    final headers = {
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
    };
    final clientMethod = client.post(url, headers: headers, body: body.toMap());
    final responseBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);

    return responseBody["notification"] as String;
  }

  @override
  Future<AccountInfoModel> getAccountInformation(
      String id, String token) async {
    final url = Uri.parse(RemoteUrls.getAccountInformation(id, token));
    final clientMethod = client.get(url, headers: defaultHeader);
    final responseBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);

    return AccountInfoModel.fromMap(responseBody["method"]);
  }

  @override
  Future<List<AccountInfoModel>> getAllMethodList(String token) async {
    final url = Uri.parse(RemoteUrls.getAllMethodList(token));
    final clientMethod = client.get(url, headers: defaultHeader);
    final responseBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    final methodList = responseBody["methods"] as List;

    return List<AccountInfoModel>.from(
            methodList.map((account) => AccountInfoModel.fromMap(account)))
        .toList();
  }

  @override
  Future<List<WithdrawModel>> getAllWithdrawList(String token) async {
    final url = Uri.parse(RemoteUrls.getAllWithdrawList(token));
    final clientMethod = client.get(url, headers: defaultHeader);
    final responseBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    final methodList = responseBody["withdraws"] as List;

    return List<WithdrawModel>.from(
        methodList.map((withdraw) => WithdrawModel.fromMap(withdraw))).toList();
  }

  @override
  Future<String> deleteVideo(String productId) async {
    final url = Uri.parse(RemoteUrls.deleteVideo(productId));
    final clientMethod = client.delete(url, headers: defaultHeader);
    final responseBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);

    return responseBody["message"] as String;
  }

  @override
  Future<List<VideoModel>> getAllVideos(String productId) async {
    final url = Uri.parse(RemoteUrls.getAllVideos(productId));
    print('show-all-video-url $url');
    final clientMethod = client.get(url, headers: defaultHeader);
    final responseBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    final methodList = responseBody["videos"] as List;
    print('video-length ${methodList.length}');
    return List<VideoModel>.from(
        methodList.map((withdraw) => VideoModel.fromMap(withdraw))).toList();
  }

  @override
  Future<String> storeVideo(VideoStateModel body) async {
    final uri = Uri.parse(RemoteUrls.storeVideo);
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'X-Requested-With': 'XMLHttpRequest',
    };

    final request = http.MultipartRequest('POST', uri);
    request.fields.addAll(body.toMap());

    request.headers.addAll(headers);
    if (body.thumbImage.isNotEmpty) {
      final thumbImage =
          await http.MultipartFile.fromPath('thumb_image', body.thumbImage);
      log('thumb_image ${body.thumbImage}');
      request.files.add(thumbImage);
    }

    if (body.video.isNotEmpty) {
      final videoFile = await http.MultipartFile.fromPath('video', body.video);
      log('product_icon ${body.video}');
      request.files.add(videoFile);
    }

    http.StreamedResponse response = await request.send();
    final clientMethod = http.Response.fromStream(response);

    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }

  @override
  Future<String> updateVideoStatus(String productId) async {
    final url = Uri.parse(RemoteUrls.updateVideoStatus(productId));
    final clientMethod = client.put(url, headers: defaultHeader);
    final responseBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);

    return responseBody as String;
  }

  @override
  Future<List<SpecificationModel>> getSpecificationKeys(String token) async {
    final url = Uri.parse(RemoteUrls.getAllCategoryAndBrands(token));
    final callClientMethod = client.get(url, headers: defaultHeader);
    final response = await NetworkParser.callClientWithCatchException(
        () => callClientMethod);

    final responseMap = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final specList = responseMap['specification_keys'] as List;
      return specList.map((spec) => SpecificationModel.fromMap(spec)).toList();
    } else {
      throw ServerException(
        responseMap['message'] ?? 'Error occurred',
        response.statusCode,
      );
    }
  }
}
