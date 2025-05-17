import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetNowPlayingMovies {
  final MovieRepository repository;
  
  GetNowPlayingMovies(this.repository);
  
  Future<List<Movie>> execute(int page) {
    return repository.getNowPlayingMovies(page);
  }
}
