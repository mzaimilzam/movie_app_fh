class Movie {
  final int id;
  final String title;
  final String? overview;
  final String? posterPath;
  final String? backdropPath;
  final double voteAverage;
  final String? releaseDate;
  final List<int>? genreIds;
  
  const Movie({
    required this.id,
    required this.title,
    this.overview,
    this.posterPath,
    this.backdropPath,
    required this.voteAverage,
    this.releaseDate,
    this.genreIds,
  });
  
  String get fullPosterPath => posterPath != null 
    ? 'https://image.tmdb.org/t/p/w500$posterPath' 
    : '';
    
  String get fullBackdropPath => backdropPath != null 
    ? 'https://image.tmdb.org/t/p/original$backdropPath' 
    : '';
}
