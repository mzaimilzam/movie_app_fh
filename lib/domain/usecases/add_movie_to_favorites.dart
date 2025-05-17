import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class AddMovieToFavorites {
  final MovieRepository repository;
  
  AddMovieToFavorites(this.repository);
  
  Future<void> execute(Movie movie) {
    return repository.addMovieToFavorites(movie);
  }
}
