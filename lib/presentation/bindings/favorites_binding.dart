import 'package:get/get.dart';
import '../../data/repositories/movie_repository_impl.dart';
import '../../domain/usecases/get_favorite_movies.dart';
import '../../domain/usecases/remove_movie_from_favorites.dart';
import '../controllers/favorites_controller.dart';

class FavoritesBinding extends Bindings {
  @override
  void dependencies() {
    // Use cases
    Get.lazyPut(() => GetFavoriteMovies(Get.find<MovieRepositoryImpl>()));
    Get.lazyPut(() => RemoveMovieFromFavorites(Get.find<MovieRepositoryImpl>()));
    
    // Controller
    Get.lazyPut(
      () => FavoritesController(
        getFavoriteMovies: Get.find<GetFavoriteMovies>(),
        removeMovieFromFavorites: Get.find<RemoveMovieFromFavorites>(),
      ),
    );
  }
}
