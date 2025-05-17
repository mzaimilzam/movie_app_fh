import 'package:get/get.dart';
import '../../data/repositories/movie_repository_impl.dart';
import '../../domain/usecases/add_movie_to_favorites.dart';
import '../../domain/usecases/get_favorite_movies.dart';
import '../../domain/usecases/get_movie_detail.dart';
import '../../domain/usecases/remove_movie_from_favorites.dart';
import '../controllers/movie_detail_controller.dart';

class MovieDetailBinding extends Bindings {
  @override
  void dependencies() {

    // Use cases
    Get.lazyPut(() => GetMovieDetail(Get.find<MovieRepositoryImpl>()));
    Get.lazyPut(() => AddMovieToFavorites(Get.find<MovieRepositoryImpl>()));
    Get.lazyPut(() => RemoveMovieFromFavorites(Get.find<MovieRepositoryImpl>()));
    Get.lazyPut(() => GetFavoriteMovies(Get.find<MovieRepositoryImpl>()));

    // Controller
    Get.lazyPut(
      () => MovieDetailController(
        getMovieDetail: Get.find<GetMovieDetail>(),
        addMovieToFavorites: Get.find<AddMovieToFavorites>(),
        removeMovieFromFavorites: Get.find<RemoveMovieFromFavorites>(),
        getFavoriteMovies: Get.find<GetFavoriteMovies>(),
      ),
    );
  }
}
