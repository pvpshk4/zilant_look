import 'dart:io';

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:zilant_look/common/photo_upload/data/models/photo_model.dart';

part 'photo_api_service.g.dart';

@RestApi(baseUrl: "http://127.0.0.1:8000")
abstract class PhotoApiService {
  factory PhotoApiService(Dio dio, {String? baseUrl}) = _PhotoApiService;

  @POST('/upload')
  @MultiPart()
  Future<PhotoModel> uploadPhoto(@Part() File file);

  @GET('/photos/{id}')
  Future<PhotoModel> getPhoto(@Path('id') String photoId);
}
