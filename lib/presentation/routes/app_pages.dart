import 'package:get/get.dart';
import '../bindings/favorites_binding.dart';
import '../bindings/movie_detail_binding.dart';
import '../bindings/movie_list_binding.dart';
import '../pages/favorites_page.dart';
import '../pages/movie_detail_page.dart';
import '../pages/movie_list_page.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => const MovieListPage(),
      binding: MovieListBinding(),
    ),
    GetPage(
      name: AppRoutes.movieDetail,
      page: () => const MovieDetailPage(),
      binding: MovieDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.favorites,
      page: () => const FavoritesPage(),
      binding: FavoritesBinding(),
    ),
  ];
}
