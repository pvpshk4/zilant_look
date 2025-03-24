import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:zilant_look/common/photo_upload/data/models/photo_model.dart';

part 'photo_api_service.g.dart';

@RestApi(baseUrl: "http://127.0.0.1:5000/background")
abstract class PhotoApiService {
  factory PhotoApiService(Dio dio, {String? baseUrl}) = _PhotoApiService;

  @POST('/human')
  Future<PhotoModel> uploadPhoto(@Body() Map<String, dynamic> photoData);

  @GET('/processed/{filename}')
  Future<PhotoModel> getPhoto(@Path('filename') String filename);
}
