import 'package:hive/hive.dart';
import '../../models/movie_model.dart';

abstract class MovieLocalDataSource {
  Future<List<MovieModel>> getFavoriteMovies();
  Future<void> addMovieToFavorites(MovieModel movie);
  Future<void> removeMovieFromFavorites(int movieId);
  Future<bool> isMovieFavorite(int movieId);
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final Box<MovieModel> _favoriteMoviesBox;

  MovieLocalDataSourceImpl(this._favoriteMoviesBox);

  @override
  Future<List<MovieModel>> getFavoriteMovies() async {
    return _favoriteMoviesBox.values.toList();
  }

  @override
  Future<void> addMovieToFavorites(MovieModel movie) async {
    await _favoriteMoviesBox.put(movie.id, movie);
  }

  @override
  Future<void> removeMovieFromFavorites(int movieId) async {
    await _favoriteMoviesBox.delete(movieId);
  }

  @override
  Future<bool> isMovieFavorite(int movieId) async {
    return _favoriteMoviesBox.containsKey(movieId);
  }
}
