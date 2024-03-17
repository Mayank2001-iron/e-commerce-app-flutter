import 'package:e_commerce/model/product_model.dart';
import 'package:http/http.dart' as http;
class ApiCalls
{
  static getProducts()async
  { 
    ProductsModel products;
    var response = await http.get(Uri.parse('https://dummyjson.com/products'));
    // print(response.body);
    String StringResponse = response.body;
    products = ProductsModel.fromRawJson(StringResponse);
    return products;
  }
}