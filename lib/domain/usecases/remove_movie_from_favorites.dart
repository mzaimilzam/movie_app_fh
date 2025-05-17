import '../repositories/movie_repository.dart';

class RemoveMovieFromFavorites {
  final MovieRepository repository;
  
  RemoveMovieFromFavorites(this.repository);
  
  Future<void> execute(int movieId) {
    return repository.removeMovieFromFavorites(movieId);
  }
}
