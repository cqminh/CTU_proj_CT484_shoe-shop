import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../../models/auth_token.dart';
import '../products/products_manager.dart';

import '../../models/product.dart';

class ProductsManager with ChangeNotifier {
  final List<Product> _items = [
    Product(
      id: 's1',
      name: 'GAZELLE INDOOR SHOES',
      description: 'Pretty shoes',
      price: 100,
      size: 43,
      imageUrl:
          'https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/70051231bf7a4a96acbdaf9c0145da82_9366/Gazelle_Indoor_Shoes_Purple_HQ8715_01_standard.jpg',
    ),
    Product(
      id: 's2',
      name: 'EQ21 SHOES',
      description: 'Beautiful shoes',
      price: 129.99,
      size: 41,
      imageUrl:
          'https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/a9153313324447daa47daed701513b19_9366/Giay_Chay_Bo_EQ21_Xam_GY2195_01_standard.jpg',
    ),
    Product(
      id: 's3',
      name: 'SUPERSTAR SHOES',
      description: 'Beautiful shoes',
      price: 129.99,
      size: 41,
      imageUrl:
          'https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/4e894c2b76dd4c8e9013aafc016047af_9366/Giay_Superstar_trang_FV3284_01_standard.jpg',
    ),
    Product(
      id: 's4',
      name: 'FORUM LOW SHOES',
      description: 'Beautiful shoes',
      price: 129.99,
      size: 41,
      imageUrl:
          'https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/09c5ea6df1bd4be6baaaac5e003e7047_9366/Forum_Low_Shoes_White_FY7756_01_standard.jpg',
    ),
    Product(
      id: 's5',
      name: 'OZWEEGO SHOES',
      description: 'Beautiful shoes',
      price: 129.99,
      size: 41,
      imageUrl:
          'https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/fdd2ed4315b74f6ea506acb600b20504_9366/OZWEEGO_Shoes_Beige_FX6029_01_standard.jpg',
    ),
    Product(
      id: 's6',
      name: 'TERREX AX4 HIKING SHOES',
      description: 'Beautiful shoes',
      price: 129.99,
      size: 41,
      imageUrl:
          'https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/13c8021f1d9846a8b524af3800de2585_9366/Terrex_AX4_Hiking_Shoes_Blue_HP7392_01_standard.jpg',
    ),

    Product(
      id: 's7',
      name: 'NMD S1 SHOES',
      description: 'Pretty shoes',
      price: 309.99,
      size: 44,
      imageUrl:
          'https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/66f848fabde3484e9bb4af7f009e3f9a_9366/Giay_NMD_S1_trang_HP9778_01_standard.jpg',
    ),

    Product(
      id: 's8',
      name: 'BOUNCE RAPIDASPORT',
      description: 'Pretty shoes',
      price: 89.99,
      size: 40,
      imageUrl:
          'https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/e1135b64bc804560bdd4af4701473fad_9366/Giay_Buoc_Day_Bounce_RapidaSport_mau_xanh_la_HP6128_01_standard.jpg',
    ),

    Product(
      id: 's9',
      name: 'ADISTAR 2.0 SHOES',
      description: 'Pretty shoes',
      price: 159.99,
      size: 39,
      imageUrl:
          'https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/d0fbf9b2772542f58acaaf1e00f46ba8_9366/Giay_Adistar_2.0_Hong_GV9122_01_standard.jpg',
    ),

    Product(
      id: 's10',
      name: 'SOLARBOOST 5 SHOES',
      description: 'Pretty shoes',
      price: 219.99,
      size: 43,
      imageUrl:
          'https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/4549391aeb81426791efafc400f5dc7f_9366/Giay_Solarboost_5_trang_HP5673_01_standard.jpg',
    ),
   
   
  ];




  int get itemCount {
    return _items.length;
  }

  List<Product> get items {
    return [..._items];
  }

  Product? findById(String id) {
    try {
      return _items.firstWhere((item) => item.id == id);
    } catch (error) {
      return null;
    }
  }
  List<Product> findByName(String name) {
    List<Product> result = [];
    for (var item in _items) {
      if (item.name.toLowerCase().contains(name.toLowerCase()))
        result.add(item);
    }
    return result;
  }



  //Them san pham
  void addProduct(Product product) {
    _items.add(
      product.copyWith(
        id: 'p${DateTime.now().toIso8601String()}',
      ),
    );
    notifyListeners();
  }

  //Sua san pham
  void updateProduct(Product product) {
    final index = _items.indexWhere((item) => item.id == product.id);
    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  //Xoa san pham
  void deleteProduct(String id) {
    final index = _items.indexWhere((item) => item.id == id);
    _items.removeAt(index);
    notifyListeners();
  }
}
