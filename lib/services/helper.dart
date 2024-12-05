import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:total_app/models/total_model.dart';

class Helper {
  ///Insert data to database
  static Future<void> saveData(String item, double price) async {
    await Supabase.instance.client
        .from("total")
        .insert({'item': item, 'price': price});
  }

  ///Retrieve all data from database (supabase)
  static Stream<List<TotalModel>> getAllData() {
    return Supabase.instance.client
        .from('total')
        .stream(primaryKey: ['id'])
        .order('id', ascending: false)
        .map((data) => data.map((item) => TotalModel.fromMap(item)).toList());
  }

  /// Update data in the 'total' table
  /// Update data in the 'total' table
  static Future<bool> updateData(TotalModel total) async {
    try {
      final response = await Supabase.instance.client
          .from('total')
          .update({'item': total.item, 'price': total.price})
          .eq('id', total.id!)
          .select();

      if (response.isEmpty) {
        debugPrint('No rows updated. Verify the ID exists.');
        return false;
      }
      return true;
    } catch (e) {
      debugPrint('Error updating data: $e');
      return false;
    }
  }

  ///Delete data
  static Future<bool> deleteData(int id) async {
    try {
      final response = await Supabase.instance.client
          .from('total')
          .delete()
          .eq('id', id)
          .select();

      if (response.isEmpty) {
        debugPrint('No rows deleted. Verify the ID exists.');
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
