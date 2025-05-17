import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/date_formatter.dart';
import '../controllers/movie_detail_controller.dart';

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage({super.key});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  final MovieDetailController controller = Get.find<MovieDetailController>();
  
  @override
  void initState() {
    super.initState();
    // Get the movie ID from arguments
    final movieId = Get.arguments as int;
    controller.loadMovieDetail(movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (controller.hasError.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(controller.errorMessage.value),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => controller.loadMovieDetail(Get.arguments as int),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }
        
        final movie = controller.movieDetail.value;
        if (movie == null) {
          return const Center(child: Text('Movie not found'));
        }
        
        return CustomScrollView(
          slivers: [
            // App Bar with backdrop image
            SliverAppBar(
              expandedHeight: 200,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: movie.backdropPath != null
                    ? CachedNetworkImage(
                        imageUrl: movie.fullBackdropPath,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: Colors.grey[300],
                          child: const Center(child: CircularProgressIndicator()),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.error),
                        ),
                      )
                    : Container(color: Colors.grey[300]),
              ),
              actions: [
                Obx(() => IconButton(
                  icon: Icon(
                    controller.isFavorite.value
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: controller.isFavorite.value ? Colors.red : null,
                  ),
                  onPressed: controller.toggleFavorite,
                )),
              ],
            ),
            
            // Movie details
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and release year
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            movie.title,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                        if (movie.releaseDate != null)
                          Text(
                            '(${DateFormatter.formatYear(movie.releaseDate)})',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                      ],
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Release date, runtime, genres
                    Row(
                      children: [
                        if (movie.releaseDate != null) ...[
                          Text(DateFormatter.formatDate(movie.releaseDate)),
                          const SizedBox(width: 8),
                          const Text('•'),
                          const SizedBox(width: 8),
                        ],
                        Text(movie.runtimeFormatted),
                        if (movie.genres.isNotEmpty) ...[
                          const SizedBox(width: 8),
                          const Text('•'),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              movie.genresText,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Rating
                    Row(
                      children: [
                        RatingBar.builder(
                          initialRating: movie.voteAverage / 2,
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 20,
                          ignoreGestures: true,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (_) {},
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${movie.voteAverage.toStringAsFixed(1)}/10',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Tagline
                    if (movie.tagline != null && movie.tagline!.isNotEmpty)
                      Text(
                        movie.tagline!,
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey[600],
                        ),
                      ),
                    
                    const SizedBox(height: 16),
                    
                    // Overview
                    Text(
                      'Overview',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      movie.overview ?? 'No overview available',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
