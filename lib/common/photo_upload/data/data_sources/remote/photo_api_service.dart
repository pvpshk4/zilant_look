import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:zilant_look/common/photo_upload/data/models/photo_model.dart';

part 'photo_api_service.g.dart';

@RestApi(baseUrl: "http://127.0.0.1:5000/")
abstract class PhotoApiService {
  factory PhotoApiService(Dio dio, {String? baseUrl}) = _PhotoApiService;

  @POST('/clothes')
  Future<PhotoModel> uploadClothesPhoto(@Body() Map<String, dynamic> photoData);

  @POST('/human')
  Future<PhotoModel> uploadHumanPhoto(@Body() Map<String, dynamic> photoData);
}
