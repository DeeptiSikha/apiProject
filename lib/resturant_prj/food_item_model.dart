
class FoodItemModel{
   late final String id;
   late final String foodname;
   late final String description;
   late final int price;

   FoodItemModel({
     required this.id,
     required this.foodname,
     required this.description,
     required this.price
   });

   factory FoodItemModel.fromJson(Map<String,dynamic> data){
     return FoodItemModel(
         id: data['id'],
         foodname: data['foodname'],
         description: data['description'],
         price: data['price']
     );
   }
}
