class MaterialMod {
  String id;
  String name;
  String supplier;
  double price;
  int count;
  final String description;
  // final List<dynamic> media;

  MaterialMod({
    this.id,
    this.name,
    this.supplier,
    this.price,
    this.description,
    this.count,
    // this.media
  });

  MaterialMod.fromFire(fire)
      : name = fire['name'],
        supplier = fire['supplier'],
        price = fire['price'].toDouble(),
        description = fire['description'],
        // media = fire['media'],
        count = fire['count'],
        id = null;

  printMaterialMod() {
    print(this.id);
    print(this.name);
    print(this.supplier);
    print(this.price);
    print(this.description);
    // this.media.forEach((element) {
    //   print(element);
    // });

    Map<String, dynamic> tofire() => {
          'name': name,
          'supplier': supplier,
          'price': price,
          'description': description,
          'count': count,
          // 'media': media,
        };
  }
}
