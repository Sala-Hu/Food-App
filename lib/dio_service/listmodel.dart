class listmodel
{
  late int Id;
  late String Name;
  late String Category;
  late String Image;
  late String Price;

  listmodel(this.Id,this.Name,this.Category,this.Image,this.Price);

  listmodel.fromJson(Map<String, dynamic> json)
      : Id = json['id'],
        Name = json['name'],
        Category = json['category'],
        Image = json['image'],
        Price = json['price'];

// Map<String, dynamic> toJson() => {
//   'name': name,
//   'email': email,
// };

}