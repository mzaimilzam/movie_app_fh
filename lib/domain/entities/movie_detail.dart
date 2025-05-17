import 'movie.dart';

class MovieDetail extends Movie {
  final int runtime;
  final List<Genre> genres;
  final String? tagline;
  
  const MovieDetail({
    required super.id,
    required super.title,
    super.overview,
    super.posterPath,
    super.backdropPath,
    required super.voteAverage,
    super.releaseDate,
    required this.runtime,
    required this.genres,
    this.tagline,
  });
  
  String get runtimeFormatted {
    final hours = runtime ~/ 60;
    final minutes = runtime % 60;
    
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
  
  String get genresText {
    return genres.map((genre) => genre.name).join(', ');
  }
}

class Genre {
  final int id;
  final String name;
  
  const Genre({
    required this.id,
    required this.name,
  });
}
