import '../../core/network/network_info.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_detail.dart';
import '../../domain/repositories/movie_repository.dart';
import '../datasources/local/movie_local_data_source.dart';
import '../datasources/remote/movie_remote_data_source.dart';
import '../models/movie_model.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  MovieRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<List<Movie>> getNowPlayingMovies(int page) async {
    if (await networkInfo.isConnectedToNetwork) {
      try {
        final movieModels = await remoteDataSource.getNowPlayingMovies(page);
        return movieModels;
      } catch (e) {
        throw Exception('Failed to fetch now playing movies');
      }
    } else {
      throw Exception('No internet connection');
    }
  }

  @override
  Future<MovieDetail> getMovieDetail(int movieId) async {
    if (await networkInfo.isConnectedToNetwork) {
      try {
        final movieDetail = await remoteDataSource.getMovieDetail(movieId);
        return movieDetail;
      } catch (e) {
        throw Exception('Failed to fetch movie detail');
      }
    } else {
      throw Exception('No internet connection');
    }
  }

  @override
  Future<List<Movie>> searchMovies(String query, int page) async {
    if (await networkInfo.isConnectedToNetwork) {
      try {
        final movieModels = await remoteDataSource.searchMovies(query, page);
        return movieModels;
      } catch (e) {
        throw Exception('Failed to search movies');
      }
    } else {
      throw Exception('No internet connection');
    }
  }

  @override
  Future<List<Movie>> getFavoriteMovies() async {
    try {
      final movieModels = await localDataSource.getFavoriteMovies();
      return movieModels;
    } catch (e) {
      throw Exception('Failed to get favorite movies');
    }
  }

  @override
  Future<void> addMovieToFavorites(Movie movie) async {
    try {
      final movieModel = MovieModel.fromEntity(movie);
      await localDataSource.addMovieToFavorites(movieModel);
    } catch (e) {
      throw Exception('Failed to add movie to favorites');
    }
  }

  @override
  Future<void> removeMovieFromFavorites(int movieId) async {
    try {
      await localDataSource.removeMovieFromFavorites(movieId);
    } catch (e) {
      throw Exception('Failed to remove movie from favorites');
    }
  }

  @override
  Future<bool> isMovieFavorite(int movieId) async {
    try {
      return await localDataSource.isMovieFavorite(movieId);
    } catch (e) {
      throw Exception('Failed to check if movie is favorite');
    }
  }
}
