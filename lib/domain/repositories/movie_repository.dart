import '../entities/movie.dart';
import '../entities/movie_detail.dart';

abstract class MovieRepository {
  Future<List<Movie>> getNowPlayingMovies(int page);
  Future<MovieDetail> getMovieDetail(int movieId);
  Future<List<Movie>> searchMovies(String query, int page);
  Future<List<Movie>> getFavoriteMovies();
  Future<void> addMovieToFavorites(Movie movie);
  Future<void> removeMovieFromFavorites(int movieId);
  Future<bool> isMovieFavorite(int movieId);
}
