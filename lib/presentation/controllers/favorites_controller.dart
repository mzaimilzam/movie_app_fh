import 'package:get/get.dart';
import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_favorite_movies.dart';
import '../../domain/usecases/remove_movie_from_favorites.dart';

class FavoritesController extends GetxController {
  final GetFavoriteMovies getFavoriteMovies;
  final RemoveMovieFromFavorites removeMovieFromFavorites;

  FavoritesController({
    required this.getFavoriteMovies,
    required this.removeMovieFromFavorites,
  });

  // State variables
  final RxList<Movie> favoriteMovies = <Movie>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadFavoriteMovies();
  }

  Future<void> loadFavoriteMovies() async {
    isLoading.value = true;
    hasError.value = false;
    
    try {
      final movies = await getFavoriteMovies.execute();
      favoriteMovies.value = movies;
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> removeFromFavorites(int movieId) async {
    try {
      await removeMovieFromFavorites.execute(movieId);
      favoriteMovies.removeWhere((movie) => movie.id == movieId);
      
      Get.snackbar(
        'Success',
        'Movie removed from favorites',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to remove movie from favorites',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
