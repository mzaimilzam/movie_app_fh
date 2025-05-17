import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app_fh/domain/entities/movie.dart';
import 'package:movie_app_fh/domain/repositories/movie_repository.dart';
import 'package:movie_app_fh/domain/usecases/get_now_playing_movies.dart';

import 'get_now_playing_movies_test.mocks.dart';

@GenerateMocks([MovieRepository])
void main() {
  late GetNowPlayingMovies usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetNowPlayingMovies(mockMovieRepository);
  });

  final tPage = 1;
  final tMovies = [
    const Movie(
      id: 1,
      title: 'Test Movie',
      voteAverage: 8.5,
    ),
  ];

  test(
    'should get list of movies from the repository',
    () async {
      // arrange
      when(mockMovieRepository.getNowPlayingMovies(tPage))
          .thenAnswer((_) async => tMovies);

      // act
      final result = await usecase.execute(tPage);

      // assert
      expect(result, tMovies);
      verify(mockMovieRepository.getNowPlayingMovies(tPage));
      verifyNoMoreInteractions(mockMovieRepository);
    },
  );
}
