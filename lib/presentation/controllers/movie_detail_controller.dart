import 'package:get/get.dart';
import '../../domain/entities/movie_detail.dart';
import '../../domain/usecases/add_movie_to_favorites.dart';
import '../../domain/usecases/get_favorite_movies.dart';
import '../../domain/usecases/get_movie_detail.dart';
import '../../domain/usecases/remove_movie_from_favorites.dart';

class MovieDetailController extends GetxController {
  final GetMovieDetail getMovieDetail;
  final AddMovieToFavorites addMovieToFavorites;
  final RemoveMovieFromFavorites removeMovieFromFavorites;
  final GetFavoriteMovies getFavoriteMovies;

  MovieDetailController({
    required this.getMovieDetail,
    required this.addMovieToFavorites,
    required this.removeMovieFromFavorites,
    required this.getFavoriteMovies,
  });

  // State variables
  final Rx<MovieDetail?> movieDetail = Rx<MovieDetail?>(null);
  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool isFavorite = false.obs;
  final RxBool isTogglingFavorite = false.obs;

  Future<void> loadMovieDetail(int movieId) async {
    isLoading.value = true;
    hasError.value = false;
    
    try {
      final detail = await getMovieDetail.execute(movieId);
      movieDetail.value = detail;
      
      // Check if the movie is in favorites
      await checkFavoriteStatus(movieId);
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> checkFavoriteStatus(int movieId) async {
    try {
      isFavorite.value = await getFavoriteMovies.execute().then((movies) => movies.any((movie) => movie.id == movieId));
    } catch (e) {
      isFavorite.value = false;
    }
  }

  Future<void> toggleFavorite() async {
    if (movieDetail.value == null || isTogglingFavorite.value) return;
    
    isTogglingFavorite.value = true;
    
    try {
      if (isFavorite.value) {
        await removeMovieFromFavorites.execute(movieDetail.value!.id);
        isFavorite.value = false;
      } else {
        await addMovieToFavorites.execute(movieDetail.value!);
        isFavorite.value = true;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to ${isFavorite.value ? 'remove from' : 'add to'} favorites',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isTogglingFavorite.value = false;
    }
  }
}
