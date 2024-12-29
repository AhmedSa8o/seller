import 'dependency_injection_packages.dart';
import 'modules/authentication/login/internet_status/internet_status_bloc.dart';
import 'modules/on_boarding/controller/currency/currency_cubit.dart';
import 'modules/profile/controller/map/map_cubit.dart';
import 'modules/video/controller/upload_video/upload_video_cubit.dart';

class DependencyInjector {
  static late final SharedPreferences _sharedPreferences;

  static Future<void> initDB() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static final repositoryProvider = <RepositoryProvider>[
    RepositoryProvider<Client>(
      create: (context) => Client(),
    ),
    RepositoryProvider<SharedPreferences>(
      create: (context) => _sharedPreferences,
    ),
    RepositoryProvider<RemoteDataSources>(
      create: (context) => RemoteDataSourcesImpl(
        client: context.read(),
      ),
    ),
    RepositoryProvider<LocalDataSources>(
      create: (context) => LocalDataSourcesImpl(
        sharedPreferences: context.read(),
      ),
    ),
    RepositoryProvider<LoginRepository>(
      create: (context) => LoginRepositoryImpl(
        remoteDataSources: context.read(),
        localDataSources: context.read(),
      ),
    ),
    RepositoryProvider<SettingRepository>(
      create: (context) => SettingRepositoryImpl(
        remoteDataSources: context.read(),
        localDataSources: context.read(),
      ),
    ),
    RepositoryProvider<DashboardRepository>(
      create: (context) => DashboardRepositoryImpl(
        remoteDataSources: context.read(),
      ),
    ),
    RepositoryProvider<OrdersRepository>(
      create: (context) => OrdersRepositoryImpl(
        remoteDataSources: context.read(),
      ),
    ),
    RepositoryProvider<SellerProfileRepository>(
      create: (context) => SellerProfileRepositoryImpl(
        remoteDataSources: context.read(),
      ),
    ),
    RepositoryProvider<ReviewRepository>(
      create: (context) => ReviewRepositoryImpl(
        remoteDataSources: context.read(),
      ),
    ),
    RepositoryProvider<StoreProductRepository>(
      create: (context) => StoreProductRepositoryImpl(
        remoteDataSources: context.read(),
      ),
    ),
    RepositoryProvider<UpdateProductRepository>(
      create: (context) => UpdateProductRepositoryImpl(
        remoteDataSources: context.read(),
      ),
    ),
    RepositoryProvider<GalleryRepository>(
      create: (context) => GalleryRepositoryImpl(
        remoteDataSources: context.read(),
      ),
    ),
    RepositoryProvider<VariantRepository>(
      create: (context) => VariantRepositoryImpl(
        remoteDataSources: context.read(),
      ),
    ),
    RepositoryProvider<VariantItemRepository>(
      create: (context) => VariantItemRepositoryImpl(
        remoteDataSources: context.read(),
      ),
    ),
    RepositoryProvider<WithdrawRepository>(
      create: (context) => WithdrawRepositoryImpl(
        remoteDataSources: context.read(),
      ),
    ),
    RepositoryProvider<VideoRepository>(
      create: (context) => VideoRepositoryImpl(
        remoteDataSources: context.read(),
      ),
    ),
  ];

  static final blocProviders = <BlocProvider>[
    BlocProvider<InternetStatusBloc>(create: (context) => InternetStatusBloc()),
    BlocProvider<CurrencyCubit>(create: (context) => CurrencyCubit()),
    BlocProvider<LoginBloc>(
      create: (BuildContext context) => LoginBloc(
        loginRepository: context.read(),
      ),
    ),
    BlocProvider<SettingCubit>(
      create: (BuildContext context) => SettingCubit(
        settingRepository: context.read(),
      ),
    ),
    BlocProvider<DashboardCubit>(
      create: (BuildContext context) => DashboardCubit(
        dashboardRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<OrdersCubit>(
      create: (BuildContext context) => OrdersCubit(
        productRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<PendingProductCubit>(
      create: (BuildContext context) => PendingProductCubit(
        productRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<SellerOrderCubit>(
      create: (BuildContext context) => SellerOrderCubit(
        productRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<SellerProfileCubit>(
      create: (BuildContext context) => SellerProfileCubit(
        repository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<ReviewCubit>(
      create: (BuildContext context) => ReviewCubit(
        repository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<CategoryBrandCubit>(
      create: (BuildContext context) => CategoryBrandCubit(
        storeProductRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<StoreProductBloc>(
      create: (BuildContext context) => StoreProductBloc(
        storeProductRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<UpdateProductBloc>(
      create: (BuildContext context) => UpdateProductBloc(
        updateProductRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<EditProductCubit>(
      create: (BuildContext context) => EditProductCubit(
        updateProductRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<GetAllGalleryCubit>(
      create: (BuildContext context) => GetAllGalleryCubit(
        galleryRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<StatusChangeCubit>(
      create: (BuildContext context) => StatusChangeCubit(
        galleryRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<StoreGalleryBloc>(
      create: (BuildContext context) => StoreGalleryBloc(
        galleryRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<VariantProductCubit>(
      create: (BuildContext context) => VariantProductCubit(
        variantRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<VariantStatusChangeCubit>(
      create: (BuildContext context) => VariantStatusChangeCubit(
        variantRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<CreateVariantBloc>(
      create: (BuildContext context) => CreateVariantBloc(
        variantRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<UpdateVariantCubit>(
      create: (BuildContext context) => UpdateVariantCubit(
        variantRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<GetVariantItemCubit>(
      create: (BuildContext context) => GetVariantItemCubit(
        variantItemRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<StoreVICubit>(
      create: (BuildContext context) => StoreVICubit(
        variantItemRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<UpdateVariantItemBloc>(
      create: (BuildContext context) => UpdateVariantItemBloc(
        variantItemRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<UpdateSellerProfileCubit>(
      create: (BuildContext context) => UpdateSellerProfileCubit(
        sellerProfileRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<UpdateSellerShopCubit>(
      create: (BuildContext context) => UpdateSellerShopCubit(
        sellerProfileRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<PasswordChangeCubit>(
      create: (BuildContext context) => PasswordChangeCubit(
        sellerProfileRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<CountryStateCityCubit>(
      create: (BuildContext context) => CountryStateCityCubit(
        sellerProfileRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<CreateWithdrawCubit>(
      create: (BuildContext context) => CreateWithdrawCubit(
        withdrawRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<AccountInfoCubit>(
      create: (BuildContext context) => AccountInfoCubit(
        withdrawRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<WithdrawListCubit>(
      create: (BuildContext context) => WithdrawListCubit(
        withdrawRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<PasswordCubit>(
      create: (BuildContext context) => PasswordCubit(),
    ),
    BlocProvider<VideoCubit>(
      create: (BuildContext context) => VideoCubit(
        repository: context.read(),
      ),
    ),
    BlocProvider<UploadVideoCubit>(
      create: (BuildContext context) => UploadVideoCubit(
        repository: context.read(),
      ),
    ),
    BlocProvider<MapCubit>(
      create: (BuildContext context) => MapCubit(
        loginBloc: context.read(),
      ),
    ),
  ];
}
