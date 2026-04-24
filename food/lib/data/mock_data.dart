import '../models/ad_model.dart';
import '../models/cart_item_model.dart';
import '../models/category_model.dart';
import '../models/food_model.dart';
import '../models/order_model.dart';
import '../models/review_model.dart';

class MockData {
  const MockData._();

  static const List<CategoryModel> categories = <CategoryModel>[
    CategoryModel(
      id: 'pizza',
      name: 'Pizza',
      imageUrl:
          'https://images.unsplash.com/photo-1604382354936-07c5d9983bd3?auto=format&fit=crop&w=500&q=80',
      colorHex: 'FFF0E5',
    ),
    CategoryModel(
      id: 'burger',
      name: 'Burger',
      imageUrl:
          'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=500&q=80',
      colorHex: 'FFE8D6',
    ),
    CategoryModel(
      id: 'pasta',
      name: 'Pasta',
      imageUrl:
          'https://images.unsplash.com/photo-1473093295043-cdd812d0e601?auto=format&fit=crop&w=500&q=80',
      colorHex: 'FDECC8',
    ),
    CategoryModel(
      id: 'chicken',
      name: 'Chicken',
      imageUrl:
          'https://images.unsplash.com/photo-1598515214211-89d3c73ae83b?auto=format&fit=crop&w=500&q=80',
      colorHex: 'FFE1D8',
    ),
    CategoryModel(
      id: 'dessert',
      name: 'Dessert',
      imageUrl:
          'https://images.unsplash.com/photo-1551024506-0bccd828d307?auto=format&fit=crop&w=500&q=80',
      colorHex: 'FCE4EC',
    ),
  ];

  static const List<AdModel> ads = <AdModel>[
    AdModel(
      id: 'ad-1',
      title: 'Weekend pizza ritual',
      subtitle: 'Buy one artisan pizza and get 35% off the second.',
      imageUrl:
          'https://images.unsplash.com/photo-1513104890138-7c749659a591?auto=format&fit=crop&w=1200&q=80',
      actionLabel: 'Grab deal',
      foodId: '2',
    ),
    AdModel(
      id: 'ad-2',
      title: 'Juicy burger drop',
      subtitle: 'Stacked patties, melted cheddar, and crisp fries.',
      imageUrl:
          'https://images.unsplash.com/photo-1550547660-d9450f859349?auto=format&fit=crop&w=1200&q=80',
      actionLabel: 'Order now',
      foodId: '1',
    ),
    AdModel(
      id: 'ad-3',
      title: 'Fresh bowls arrive hot',
      subtitle: 'Balanced meals with bright greens and premium protein.',
      imageUrl:
          'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?auto=format&fit=crop&w=1200&q=80',
      actionLabel: 'Explore',
      foodId: '6',
    ),
  ];

  static final List<ReviewModel> reviews = <ReviewModel>[
    ReviewModel(
      id: 'review-1',
      userName: 'Mona',
      avatarUrl:
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=120&q=80',
      comment: 'Arrived hot, rich flavor, and the packaging felt premium.',
      rating: 4.8,
      createdAt: DateTime(2026, 4, 12),
    ),
    ReviewModel(
      id: 'review-2',
      userName: 'Omar',
      avatarUrl:
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=120&q=80',
      comment: 'Great portion size. The sauce was the best part.',
      rating: 4.6,
      createdAt: DateTime(2026, 4, 18),
    ),
  ];

  static final List<FoodModel> foods = <FoodModel>[
    FoodModel(
      id: '1',
      name: 'Truffle Flame Burger',
      description:
          'Angus beef, aged cheddar, crispy onions, truffle glaze, and toasted brioche.',
      imageUrl:
          'https://images.unsplash.com/photo-1550547660-d9450f859349?auto=format&fit=crop&w=900&q=90',
      price: 13.99,
      rating: 4.8,
      reviewCount: 428,
      prepTime: '18 min',
      categoryId: 'burger',
      ingredients: <String>[
        'Angus beef',
        'Aged cheddar',
        'Truffle glaze',
        'Brioche bun',
      ],
      calories: 690,
      reviews: reviews,
      isPopular: true,
    ),
    FoodModel(
      id: '2',
      name: 'Burrata Margherita',
      description:
          'Wood-fired crust with San Marzano tomato, burrata, basil, and olive oil.',
      imageUrl:
          'https://images.unsplash.com/photo-1604382354936-07c5d9983bd3?auto=format&fit=crop&w=900&q=90',
      price: 15.49,
      rating: 4.9,
      reviewCount: 512,
      prepTime: '22 min',
      categoryId: 'pizza',
      ingredients: <String>[
        'Burrata',
        'Basil',
        'San Marzano tomato',
        'Olive oil',
      ],
      calories: 740,
      reviews: reviews,
      isPopular: true,
    ),
    FoodModel(
      id: '3',
      name: 'Creamy Tuscan Pasta',
      description:
          'Fresh tagliatelle tossed with parmesan cream, basil, roasted tomato, and herbs.',
      imageUrl:
          'https://images.unsplash.com/photo-1473093295043-cdd812d0e601?auto=format&fit=crop&w=900&q=90',
      price: 12.25,
      rating: 4.7,
      reviewCount: 316,
      prepTime: '20 min',
      categoryId: 'pasta',
      ingredients: <String>[
        'Tagliatelle',
        'Parmesan',
        'Roasted tomato',
        'Fresh basil',
      ],
      calories: 610,
      reviews: reviews,
    ),
    FoodModel(
      id: '4',
      name: 'Honey Chili Chicken',
      description:
          'Crispy chicken glazed with honey chili, sesame, spring onion, and lime.',
      imageUrl:
          'https://images.unsplash.com/photo-1598515214211-89d3c73ae83b?auto=format&fit=crop&w=900&q=90',
      price: 11.75,
      rating: 4.6,
      reviewCount: 274,
      prepTime: '17 min',
      categoryId: 'chicken',
      ingredients: <String>[
        'Chicken breast',
        'Honey chili glaze',
        'Sesame',
        'Lime',
      ],
      calories: 520,
      reviews: reviews,
    ),
    FoodModel(
      id: '5',
      name: 'Molten Chocolate Cake',
      description:
          'Warm chocolate cake with a soft center, vanilla cream, and berries.',
      imageUrl:
          'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?auto=format&fit=crop&w=900&q=90',
      price: 7.5,
      rating: 4.9,
      reviewCount: 198,
      prepTime: '14 min',
      categoryId: 'dessert',
      ingredients: <String>[
        'Dark chocolate',
        'Vanilla cream',
        'Butter',
        'Berries',
      ],
      calories: 430,
      reviews: reviews,
      isPopular: true,
    ),
    FoodModel(
      id: '6',
      name: 'Avocado Chicken Bowl',
      description:
          'Grilled chicken, avocado, quinoa, corn salsa, greens, and citrus dressing.',
      imageUrl:
          'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?auto=format&fit=crop&w=900&q=90',
      price: 10.99,
      rating: 4.5,
      reviewCount: 143,
      prepTime: '16 min',
      categoryId: 'chicken',
      ingredients: <String>[
        'Grilled chicken',
        'Avocado',
        'Quinoa',
        'Citrus dressing',
      ],
      calories: 480,
      reviews: reviews,
    ),
  ];

  static List<OrderModel> orders() {
    return <OrderModel>[
      OrderModel(
        id: 'ORD-1028',
        items: <CartItemModel>[
          CartItemModel(food: foods[1], quantity: 1),
          CartItemModel(food: foods[4], quantity: 2),
        ],
        subtotal: foods[1].price + (foods[4].price * 2),
        deliveryFee: 4.99,
        total: foods[1].price + (foods[4].price * 2) + 4.99,
        status: OrderStatus.delivered,
        address: 'Nasr City, Cairo',
        paymentMethod: PaymentMethod.cashOnDelivery,
        createdAt: DateTime(2026, 4, 20, 19, 35),
      ),
      OrderModel(
        id: 'ORD-1037',
        items: <CartItemModel>[
          CartItemModel(food: foods[0], quantity: 2),
        ],
        subtotal: foods[0].price * 2,
        deliveryFee: 4.99,
        total: (foods[0].price * 2) + 4.99,
        status: OrderStatus.onTheWay,
        address: 'Nasr City, Cairo',
        paymentMethod: PaymentMethod.wallet,
        createdAt: DateTime(2026, 4, 24, 21, 10),
      ),
    ];
  }
}
