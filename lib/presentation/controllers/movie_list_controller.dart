import 'package:get/get.dart';
import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_now_playing_movies.dart';
import '../../domain/usecases/search_movies.dart';

class MovieListController extends GetxController {
  final GetNowPlayingMovies getNowPlayingMovies;
  final SearchMovies searchMovies;

  MovieListController({
    required this.getNowPlayingMovies,
    required this.searchMovies,
  });

  // State variables
  final RxList<Movie> movies = <Movie>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;
  final RxInt currentPage = 1.obs;
  final RxBool hasMorePages = true.obs;
  final RxBool isSearching = false.obs;
  final RxString searchQuery = ''.obs;
  final RxList<Movie> searchResults = <Movie>[].obs;
  final RxInt searchPage = 1.obs;
  final RxBool hasMoreSearchResults = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNowPlayingMovies();
  }

  Future<void> fetchNowPlayingMovies() async {
    if (isLoading.value || !hasMorePages.value) return;
    
    isLoading.value = true;
    hasError.value = false;
    
    try {
      final result = await getNowPlayingMovies.execute(currentPage.value);
      
      if (result.isEmpty) {
        hasMorePages.value = false;
      } else {
        movies.addAll(result);
        currentPage.value++;
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshMovies() async {
    movies.clear();
    currentPage.value = 1;
    hasMorePages.value = true;
    await fetchNowPlayingMovies();
  }

  void setSearchMode(bool searching) {
    isSearching.value = searching;
    if (!searching) {
      searchQuery.value = '';
      searchResults.clear();
      searchPage.value = 1;
    }
  }

  Future<void> search(String query) async {
    if (query.isEmpty) {
      setSearchMode(false);
      return;
    }
    
    searchQuery.value = query;
    searchResults.clear();
    searchPage.value = 1;
    hasMoreSearchResults.value = true;
    await fetchSearchResults();
  }

  Future<void> fetchSearchResults() async {
    if (isLoading.value || !hasMoreSearchResults.value || searchQuery.isEmpty) return;
    
    isLoading.value = true;
    hasError.value = false;
    
    try {
      final result = await searchMovies.execute(searchQuery.value, searchPage.value);
      
      if (result.isEmpty) {
        hasMoreSearchResults.value = false;
      } else {
        searchResults.addAll(result);
        searchPage.value++;
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
