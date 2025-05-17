import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_constants.dart';
import '../controllers/movie_list_controller.dart';
import '../routes/app_routes.dart';
import '../widgets/movie_card.dart';
import '../widgets/search_bar_widget.dart';

class MovieListPage extends StatelessWidget {
  const MovieListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MovieListController>();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Playing Movies'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => Get.toNamed(AppRoutes.favorites),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          SearchBarWidget(
            onSearch: controller.search,
            onClear: () => controller.setSearchMode(false),
          ),
          
          // Movie List
          Expanded(
            child: Obx(() {
              // Show search results if searching
              if (controller.isSearching.value) {
                return _buildSearchResults(controller);
              }
              
              // Show now playing movies
              return _buildMovieList(controller);
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildMovieList(MovieListController controller) {
    if (controller.isLoading.value && controller.movies.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    
    if (controller.hasError.value && controller.movies.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(controller.errorMessage.value),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: controller.refreshMovies,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }
    
    return RefreshIndicator(
      onRefresh: controller.refreshMovies,
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            controller.fetchNowPlayingMovies();
          }
          return false;
        },
        child: GridView.builder(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: AppConstants.defaultPadding,
            mainAxisSpacing: AppConstants.defaultPadding,
          ),
          itemCount: controller.movies.length + (controller.isLoading.value ? 2 : 0),
          itemBuilder: (context, index) {
            if (index >= controller.movies.length) {
              return const Center(child: CircularProgressIndicator());
            }
            
            final movie = controller.movies[index];
            return MovieCard(
              movie: movie,
              onTap: () => Get.toNamed(
                AppRoutes.movieDetail,
                arguments: movie.id,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSearchResults(MovieListController controller) {
    if (controller.isLoading.value && controller.searchResults.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    
    if (controller.searchResults.isEmpty) {
      return const Center(
        child: Text('No results found'),
      );
    }
    
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          controller.fetchSearchResults();
        }
        return false;
      },
      child: GridView.builder(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: AppConstants.defaultPadding,
          mainAxisSpacing: AppConstants.defaultPadding,
        ),
        itemCount: controller.searchResults.length + (controller.isLoading.value ? 2 : 0),
        itemBuilder: (context, index) {
          if (index >= controller.searchResults.length) {
            return const Center(child: CircularProgressIndicator());
          }
          
          final movie = controller.searchResults[index];
          return MovieCard(
            movie: movie,
            onTap: () => Get.toNamed(
              AppRoutes.movieDetail,
              arguments: movie.id,
            ),
          );
        },
      ),
    );
  }
}
