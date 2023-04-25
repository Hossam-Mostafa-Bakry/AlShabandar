import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mishwar/Model/CategoryModel.dart';
import 'package:mishwar/Model/ProductModel.dart';
import 'package:mishwar/Model/PromotionItemsModel.dart';
import 'package:mishwar/Model/SubProductModel.dart';
import 'GlobalVariables.dart';
import 'package:mishwar/app/AppConfig.dart';

class ProductServices {

  String GlobalURL = GlobalVariables.url;

  getCategory() async {
    try {
      final response = await http.get(
        Uri.parse('${GlobalURL}/foodCategory/GetFoodCategories'),
        headers: await getHeader(),
      );

      if (response.statusCode == 200 && response.body != null) {

        List categoryItems = json.decode(utf8.decode(response.bodyBytes));

        // var Response = CategoryModel.fromJson(jsonDecode(response.body));

        appConfig.dApp.mainCategoryListFetch(categoryItems.map((e) => CategoryDetail.fromJson(e)).toList());
        // appConfig.dApp.mainCategoryListFetch(Response.categoryDetail);
        appConfig.dApp.setSelectedCategory(appConfig.dApp.mainCategoryList[0]);

      }
    } catch (e) {
      print('$e,,,,error main Products');
      // print('$e,,,,error main Products again');
    }
  }

  getProduct(var id, var page) async {
    print('${appConfig.dApp.selectedCategory},,selectedCategory');

    try {
      final response = await http.get(
        Uri.parse(
          '${GlobalURL}/FoodItem/GetFoodItemsByCategoryID?categoryId=$id',
        ),
        headers: await getHeader(),
      );
      if (response.statusCode == 200 && response.body != null) {
        print(' statusCode1 => ${response.statusCode}');
        // var Response = ProductModel.fromJson(jsonDecode(response.body));
        List listOfProducts = jsonDecode(response.body);
        print(listOfProducts);
        List<ProductDetail> l = listOfProducts.map((e) => ProductDetail.fromJson(e)).toList();
        appConfig.dApp.mainProductsListFetch(l);
      }
    } catch (e) {
      print('$e,,,,error main products1');
    }
  }

  Future<List<ProductDetail>> GetAllPromosUpdate() async {

    try {
      final response = await http.get(
        Uri.parse('${GlobalURL}/FoodItem/GetFoodItemsByCategoryID?categoryId=0'),
        headers: await getHeader(),
      );
      print(' all promo => ${response.body}');
      print("000000000000000");
      if (response.statusCode == 200) {
        Iterable l = json.decode(response.body);

        List slideritems =
        json.decode(response.body);
        return slideritems.map((e) => ProductDetail.fromJson(e)).toList();

      }
    } catch (e) {
      print('$e,,,,error search doctors');
    }
  }

  getPromotion() async {
    try {
      final response = await http.get(
        Uri.parse(
          // '${GlobalURL}/home/GetFoodItemsByCategoryID?categoryId=$id',
          // 'http://www.newpos.elmasren.com/api/GetFoodItemsByOrderTypeID?branchId=1&orderType=1',
          'http://www.newpos.elmasren.com/api/FoodItem/GetFoodItemsByCategoryID?categoryId=0',
        ),
        headers: await getHeader(),
      );
      if (response.statusCode == 200 && response.body != null) {
        print(' statusCode => ${response.statusCode}');
        var Response = ProductModel.fromJson(jsonDecode(response.body));
        return Response.message;
        // appConfig.dApp.mainProductsListFetch(Response.message);
      }
    } catch (e) {
      print('$e,,,,error main promotion');
    }
  }

  Future<List<SubProductDetail>> GetSubProduct(var id) async {
    try {
      final response = await http.get(
        Uri.parse(
          '${GlobalURL}/home/GetSubItems?product_id=$id',
        ),
        headers: await getHeader(),
      );
      print("000000000000000");
      if (response.statusCode == 200 && response.body != null) {
        var Response = SubProductModel.fromJson(jsonDecode(response.body));
        print('Response => $Response');
        return Response.subProductDetail;
      }
    } catch (e) {
      print('$e,,,,error search doctors');
    }
  }


}

ProductServices productServices = ProductServices();

