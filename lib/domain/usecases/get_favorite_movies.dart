import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetFavoriteMovies {
  final MovieRepository repository;
  
  GetFavoriteMovies(this.repository);
  
  Future<List<Movie>> execute() {
    return repository.getFavoriteMovies();
  }
}
