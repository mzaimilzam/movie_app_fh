import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import '../../data/datasources/local/movie_local_data_source.dart';
import '../../data/models/movie_model.dart';
import '../constants/app_constants.dart';
import '../network/api_client.dart';
import '../network/network_info.dart';

class DependencyInjection {
  static Future<void> init() async {
    // Initialize Hive
    final appDocumentDir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDocumentDir.path);
    
    // Register Hive adapters
    Hive.registerAdapter(MovieModelAdapter());
    
    // Open Hive boxes
    final favoriteMoviesBox = await Hive.openBox<MovieModel>(AppConstants.favoriteMoviesBox);
    
    // Core
    Get.put<ApiClient>(ApiClient(), permanent: true);
    Get.put<NetworkInfo>(NetworkInfo(), permanent: true);
    
    // Data sources
    Get.put<MovieLocalDataSource>(
      MovieLocalDataSourceImpl(favoriteMoviesBox),
      permanent: true,
    );
  }
}

// This is a placeholder adapter until we generate the real one with build_runner
class MovieModelAdapter extends TypeAdapter<MovieModel> {
  @override
  final int typeId = 0;

  @override
  MovieModel read(BinaryReader reader) {
    final id = reader.readInt();
    final title = reader.readString();
    final overview = reader.readString();
    final posterPath = reader.readString();
    final backdropPath = reader.readString();
    final voteAverage = reader.readDouble();
    final releaseDate = reader.readString();
    final genreIds = List<int>.from(reader.readList());

    return MovieModel(
      id: id,
      title: title,
      overview: overview.isEmpty ? null : overview,
      posterPath: posterPath.isEmpty ? null : posterPath,
      backdropPath: backdropPath.isEmpty ? null : backdropPath,
      voteAverage: voteAverage,
      releaseDate: releaseDate.isEmpty ? null : releaseDate,
      genreIds: genreIds.isEmpty ? null : genreIds,
    );
  }

  @override
  void write(BinaryWriter writer, MovieModel obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.title);
    writer.writeString(obj.overview ?? '');
    writer.writeString(obj.posterPath ?? '');
    writer.writeString(obj.backdropPath ?? '');
    writer.writeDouble(obj.voteAverage);
    writer.writeString(obj.releaseDate ?? '');
    writer.writeList(obj.genreIds ?? []);
  }
}
