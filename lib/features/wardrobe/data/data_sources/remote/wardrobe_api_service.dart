import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'wardrobe_api_service.g.dart';

@RestApi(baseUrl: "http://127.0.0.1:5000/")
abstract class WardrobeApiService {
  factory WardrobeApiService(Dio dio, {String? baseUrl}) = _WardrobeApiService;

  @GET('/clothes')
  Future<List<Map<String, dynamic>>> getWardrobeItems({
    @Query('limit') required int limit,
    @Query('offset') required int offset,
  });

  @DELETE('/clothes/{id}')
  Future<void> deleteClothingItem(@Path('id') String id);

  @PUT('/clothes/{id}')
  Future<void> updateClothingItem(
    @Path('id') String id,
    @Body() Map<String, dynamic> item,
  );
}
