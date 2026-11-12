import 'package:pizza_app/features/product_details/data/models/product_details.dart';
import 'package:pizza_app/features/product_details/data/repository/product_details/product_details_repository_interface.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const tableName = 'product';

class SupabaseProductDetailsRepository implements IProductDetailsRepository {
  @override
  Future<ProductDetails?> getProductDetails(String id) async {
    final data = await Supabase.instance.client
        .from(tableName)
        .select('''
          id,
          name,
          description,
          price,
          image_asset,
          category:product_category ( id, category_key ),
          default_size:product_size ( id, cm, price ),
          sizes:products_product_sizes ( product_size ( id, cm, price ) ),
          toppings:products_toppings ( toppings ( id, toppings_key, weight_grams, price, image_asset ) ),
          ingredients:products_ingredients ( ingredient ( id, ingredient_key ) )
        ''')
        .eq('id', id)
        .maybeSingle();

    if (data == null) return null;

    return ProductDetails.fromMap(data);
  }
}
