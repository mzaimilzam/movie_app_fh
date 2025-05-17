import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_client.dart';
import '../../models/movie_detail_model.dart';
import '../../models/movie_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getNowPlayingMovies(int page);
  Future<MovieDetailModel> getMovieDetail(int movieId);
  Future<List<MovieModel>> searchMovies(String query, int page);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final ApiClient _client;

  MovieRemoteDataSourceImpl(this._client);

  @override
  Future<List<MovieModel>> getNowPlayingMovies(int page) async {
    final response = await _client.get(
      ApiConstants.nowPlayingEndpoint,
      queryParameters: {'page': page},
    );

    final results = response.data['results'] as List;
    return results.map((movie) => MovieModel.fromJson(movie)).toList();
  }

  @override
  Future<MovieDetailModel> getMovieDetail(int movieId) async {
    final response = await _client.get('${ApiConstants.movieDetailEndpoint}$movieId');
    return MovieDetailModel.fromJson(response.data);
  }

  @override
  Future<List<MovieModel>> searchMovies(String query, int page) async {
    final response = await _client.get(
      ApiConstants.searchMovieEndpoint,
      queryParameters: {
        'query': query,
        'page': page,
      },
    );

    final results = response.data['results'] as List;
    return results.map((movie) => MovieModel.fromJson(movie)).toList();
  }
}
