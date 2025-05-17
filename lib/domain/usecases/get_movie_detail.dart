import '../entities/movie_detail.dart';
import '../repositories/movie_repository.dart';

class GetMovieDetail {
  final MovieRepository repository;
  
  GetMovieDetail(this.repository);
  
  Future<MovieDetail> execute(int movieId) {
    return repository.getMovieDetail(movieId);
  }
}
