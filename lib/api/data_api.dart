

import '../client/client.dart';
import 'get_data_model.dart';

class ImageGetApi {
  Future<List<UserModel>> get() async {
    var response = await apiRequest.get('/api/?key=16870991-34bf54ebfe302cf6fae66add4&q=yellow+flowers&image_type=photo');
    // http.StreamedResponse response = await request.send();
    List<UserModel> request =[];
    (response['hits']).forEach((e){
      request.add(UserModel.fromJson(e));
    }
    );     return request;
  }
}


