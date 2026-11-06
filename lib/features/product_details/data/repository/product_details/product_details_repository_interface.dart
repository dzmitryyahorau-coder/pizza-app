import 'package:pizza_app/features/product_details/data/models/product_details.dart';

abstract interface class IProductDetailsRepository {
  Future<ProductDetails?> getProductDetails(String id);
}
