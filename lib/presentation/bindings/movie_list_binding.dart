import 'package:get/get.dart';
import '../../core/network/api_client.dart';
import '../../core/network/network_info.dart';
import '../../data/datasources/local/movie_local_data_source.dart';
import '../../data/datasources/remote/movie_remote_data_source.dart';
import '../../data/repositories/movie_repository_impl.dart';
import '../../domain/usecases/get_now_playing_movies.dart';
import '../../domain/usecases/search_movies.dart';
import '../controllers/movie_list_controller.dart';

class MovieListBinding extends Bindings {
  @override
  void dependencies() {
    // Core
    Get.lazyPut<ApiClient>(() => ApiClient());
    Get.lazyPut<NetworkInfo>(() => NetworkInfo());
    
    // Data sources
    Get.lazyPut<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(Get.find<ApiClient>()),
    );
    
    // Repository
    Get.lazyPut(
      () => MovieRepositoryImpl(
        remoteDataSource: Get.find<MovieRemoteDataSource>(),
        localDataSource: Get.find<MovieLocalDataSource>(),
        networkInfo: Get.find<NetworkInfo>(),
      ),
    );
    
    // Use cases
    Get.lazyPut(() => GetNowPlayingMovies(Get.find<MovieRepositoryImpl>()));
    Get.lazyPut(() => SearchMovies(Get.find<MovieRepositoryImpl>()));
    
    // Controller
    Get.lazyPut(
      () => MovieListController(
        getNowPlayingMovies: Get.find<GetNowPlayingMovies>(),
        searchMovies: Get.find<SearchMovies>(),
      ),
    );
  }
}
