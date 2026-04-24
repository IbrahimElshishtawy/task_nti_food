import '../models/ad_model.dart';
import '../models/category_model.dart';
import '../models/food_model.dart';
import '../models/review_model.dart';

class MockFoodData {
  const MockFoodData._();

  static const List<CategoryModel> categories = <CategoryModel>[
    CategoryModel(
      id: 'hot_drinks',
      nameAr: 'مشروبات ساخنة',
      nameEn: 'Hot Drinks',
      imageUrl:
          'https://images.unsplash.com/photo-1509042239860-f550ce710b93?auto=format&fit=crop&w=500&q=80',
      colorHex: 'FFF1E6',
    ),
    CategoryModel(
      id: 'cold_drinks',
      nameAr: 'مشروبات باردة',
      nameEn: 'Cold Drinks',
      imageUrl:
          'https://images.unsplash.com/photo-1517701604599-bb29b565090c?auto=format&fit=crop&w=500&q=80',
      colorHex: 'E8F7FF',
    ),
    CategoryModel(
      id: 'main_meals',
      nameAr: 'وجبات رئيسية',
      nameEn: 'Main Meals',
      imageUrl:
          'https://images.unsplash.com/photo-1544025162-d76694265947?auto=format&fit=crop&w=500&q=80',
      colorHex: 'FFF0E5',
    ),
    CategoryModel(
      id: 'sandwiches',
      nameAr: 'سندوتشات',
      nameEn: 'Sandwiches',
      imageUrl:
          'https://images.unsplash.com/photo-1528735602780-2552fd46c7af?auto=format&fit=crop&w=500&q=80',
      colorHex: 'FFF7D6',
    ),
    CategoryModel(
      id: 'pizza',
      nameAr: 'بيتزا',
      nameEn: 'Pizza',
      imageUrl:
          'https://images.unsplash.com/photo-1604382354936-07c5d9983bd3?auto=format&fit=crop&w=500&q=80',
      colorHex: 'FFF0E5',
    ),
    CategoryModel(
      id: 'burger',
      nameAr: 'برجر',
      nameEn: 'Burger',
      imageUrl:
          'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=500&q=80',
      colorHex: 'FFE8D6',
    ),
    CategoryModel(
      id: 'pasta',
      nameAr: 'باستا',
      nameEn: 'Pasta',
      imageUrl:
          'https://images.unsplash.com/photo-1473093295043-cdd812d0e601?auto=format&fit=crop&w=500&q=80',
      colorHex: 'FDECC8',
    ),
    CategoryModel(
      id: 'chicken',
      nameAr: 'فراخ',
      nameEn: 'Chicken',
      imageUrl:
          'https://images.unsplash.com/photo-1598515214211-89d3c73ae83b?auto=format&fit=crop&w=500&q=80',
      colorHex: 'FFE1D8',
    ),
    CategoryModel(
      id: 'healthy',
      nameAr: 'أكلات صحية',
      nameEn: 'Healthy',
      imageUrl:
          'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?auto=format&fit=crop&w=500&q=80',
      colorHex: 'E8F8EF',
    ),
    CategoryModel(
      id: 'dessert',
      nameAr: 'حلويات',
      nameEn: 'Dessert',
      imageUrl:
          'https://images.unsplash.com/photo-1551024506-0bccd828d307?auto=format&fit=crop&w=500&q=80',
      colorHex: 'FCE4EC',
    ),
    CategoryModel(
      id: 'ice_cream',
      nameAr: 'آيس كريم',
      nameEn: 'Ice Cream',
      imageUrl:
          'https://images.unsplash.com/photo-1501443762994-82bd5dace89a?auto=format&fit=crop&w=500&q=80',
      colorHex: 'F4E8FF',
    ),
    CategoryModel(
      id: 'juices',
      nameAr: 'عصائر',
      nameEn: 'Juices',
      imageUrl:
          'https://images.unsplash.com/photo-1622597467836-f3285f2131b8?auto=format&fit=crop&w=500&q=80',
      colorHex: 'FFEFC2',
    ),
    CategoryModel(
      id: 'coffee',
      nameAr: 'قهوة',
      nameEn: 'Coffee',
      imageUrl:
          'https://images.unsplash.com/photo-1461023058943-07fcbe16d735?auto=format&fit=crop&w=500&q=80',
      colorHex: 'F2E2D0',
    ),
    CategoryModel(
      id: 'tea',
      nameAr: 'شاي',
      nameEn: 'Tea',
      imageUrl:
          'https://images.unsplash.com/photo-1571934811356-5cc061b6821f?auto=format&fit=crop&w=500&q=80',
      colorHex: 'EAF6DF',
    ),
    CategoryModel(
      id: 'oriental',
      nameAr: 'أكلات شرقية',
      nameEn: 'Oriental',
      imageUrl:
          'https://images.unsplash.com/photo-1563379091339-03246963d29a?auto=format&fit=crop&w=500&q=80',
      colorHex: 'FFF2D8',
    ),
    CategoryModel(
      id: 'western',
      nameAr: 'أكلات غربية',
      nameEn: 'Western',
      imageUrl:
          'https://images.unsplash.com/photo-1558030006-450675393462?auto=format&fit=crop&w=500&q=80',
      colorHex: 'EDEBFF',
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
      foodId: '4',
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
      foodId: '21',
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
    ReviewModel(
      id: 'review-3',
      userName: 'Lina',
      avatarUrl:
          'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=120&q=80',
      comment: 'Fresh, photogenic, and still tasted better than it looked.',
      rating: 4.9,
      createdAt: DateTime(2026, 4, 21),
    ),
  ];

  static final List<FoodModel> foods = <FoodModel>[
    _food(
      id: '1',
      nameAr: 'برجر ترافل فاير',
      nameEn: 'Truffle Flame Burger',
      descriptionAr:
          'برجر أنجوس مع شيدر معتق، بصل مقرمش، صوص ترافل وخبز بريوش محمص.',
      descriptionEn:
          'Angus beef, aged cheddar, crispy onions, truffle glaze, and toasted brioche.',
      imageUrl:
          'https://images.unsplash.com/photo-1550547660-d9450f859349?auto=format&fit=crop&w=900&q=90',
      price: 13.99,
      oldPrice: 16.50,
      rating: 4.8,
      reviewsCount: 428,
      calories: 690,
      preparationTime: '18 min',
      categoryId: 'burger',
      ingredients: <String>['Angus beef', 'Cheddar', 'Truffle', 'Brioche'],
      isPopular: true,
      isRecommended: true,
      sizes: _mealSizes,
      extras: _burgerExtras,
    ),
    _food(
      id: '2',
      nameAr: 'كلاسيك تشيز برجر',
      nameEn: 'Classic Cheeseburger',
      descriptionAr:
          'قطعة لحم مشوية، شيدر ذائب، خيار مخلل، خس وصوص هاوس كريمي.',
      descriptionEn:
          'Grilled patty, melted cheddar, pickles, lettuce, and creamy house sauce.',
      imageUrl:
          'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=900&q=90',
      price: 10.75,
      oldPrice: 12.25,
      rating: 4.6,
      reviewsCount: 311,
      calories: 640,
      preparationTime: '16 min',
      categoryId: 'burger',
      ingredients: <String>['Beef', 'Cheddar', 'Pickles', 'House sauce'],
      isPopular: true,
      sizes: _mealSizes,
      extras: _burgerExtras,
    ),
    _food(
      id: '3',
      nameAr: 'برجر فراخ كرانشي',
      nameEn: 'Crispy Chicken Burger',
      descriptionAr:
          'فراخ مقرمشة، كولسلو خفيف، صوص سبايسي وعسل داخل خبز بطاطس ناعم.',
      descriptionEn:
          'Crispy chicken, light slaw, spicy honey sauce, and a soft potato bun.',
      imageUrl:
          'https://images.unsplash.com/photo-1606755962773-d324e9a13086?auto=format&fit=crop&w=900&q=90',
      price: 11.20,
      oldPrice: 13.00,
      rating: 4.7,
      reviewsCount: 274,
      calories: 620,
      preparationTime: '17 min',
      categoryId: 'burger',
      ingredients: <String>['Chicken', 'Slaw', 'Spicy honey', 'Potato bun'],
      isRecommended: true,
      sizes: _mealSizes,
      extras: _burgerExtras,
    ),
    _food(
      id: '4',
      nameAr: 'بيتزا بوراتا مارجريتا',
      nameEn: 'Burrata Margherita',
      descriptionAr:
          'عجينة فرن حطب مع طماطم سان مارزانو، بوراتا، ريحان وزيت زيتون.',
      descriptionEn:
          'Wood-fired crust with San Marzano tomato, burrata, basil, and olive oil.',
      imageUrl:
          'https://images.unsplash.com/photo-1604382354936-07c5d9983bd3?auto=format&fit=crop&w=900&q=90',
      price: 15.49,
      oldPrice: 18.00,
      rating: 4.9,
      reviewsCount: 512,
      calories: 740,
      preparationTime: '22 min',
      categoryId: 'pizza',
      ingredients: <String>['Burrata', 'Basil', 'Tomato', 'Olive oil'],
      isPopular: true,
      isRecommended: true,
      sizes: _pizzaSizes,
      extras: _pizzaExtras,
    ),
    _food(
      id: '5',
      nameAr: 'بيتزا بيبروني فولكانو',
      nameEn: 'Pepperoni Volcano Pizza',
      descriptionAr:
          'بيبروني مدخن، موتزاريلا كثيرة، هالبينو وصوص طماطم غني.',
      descriptionEn:
          'Smoky pepperoni, extra mozzarella, jalapeno, and rich tomato sauce.',
      imageUrl:
          'https://images.unsplash.com/photo-1513104890138-7c749659a591?auto=format&fit=crop&w=900&q=90',
      price: 14.90,
      oldPrice: 17.25,
      rating: 4.7,
      reviewsCount: 389,
      calories: 820,
      preparationTime: '21 min',
      categoryId: 'pizza',
      ingredients: <String>['Pepperoni', 'Mozzarella', 'Jalapeno', 'Tomato'],
      isPopular: true,
      sizes: _pizzaSizes,
      extras: _pizzaExtras,
    ),
    _food(
      id: '6',
      nameAr: 'بيتزا تشيكن رانش',
      nameEn: 'Chicken Ranch Pizza',
      descriptionAr:
          'فراخ مشوية، صوص رانش، ذرة، فلفل ألوان وجبن موتزاريلا ذائب.',
      descriptionEn:
          'Grilled chicken, ranch sauce, corn, peppers, and melted mozzarella.',
      imageUrl:
          'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?auto=format&fit=crop&w=900&q=90',
      price: 14.25,
      oldPrice: 16.80,
      rating: 4.6,
      reviewsCount: 245,
      calories: 780,
      preparationTime: '23 min',
      categoryId: 'pizza',
      ingredients: <String>['Chicken', 'Ranch', 'Corn', 'Mozzarella'],
      isRecommended: true,
      sizes: _pizzaSizes,
      extras: _pizzaExtras,
    ),
    _food(
      id: '7',
      nameAr: 'باستا توسكان كريمي',
      nameEn: 'Creamy Tuscan Pasta',
      descriptionAr:
          'تاليتيلي طازجة مع كريمة بارميزان، طماطم مشوية، ريحان وأعشاب.',
      descriptionEn:
          'Fresh tagliatelle tossed with parmesan cream, roasted tomato, basil, and herbs.',
      imageUrl:
          'https://images.unsplash.com/photo-1473093295043-cdd812d0e601?auto=format&fit=crop&w=900&q=90',
      price: 12.25,
      oldPrice: 14.10,
      rating: 4.7,
      reviewsCount: 316,
      calories: 610,
      preparationTime: '20 min',
      categoryId: 'pasta',
      ingredients: <String>['Tagliatelle', 'Parmesan', 'Tomato', 'Basil'],
      isPopular: true,
      sizes: _mealSizes,
      extras: _pastaExtras,
    ),
    _food(
      id: '8',
      nameAr: 'باستا جمبري ألفريدو',
      nameEn: 'Shrimp Alfredo Pasta',
      descriptionAr:
          'جمبري سوتيه، فيتوتشيني، صوص ألفريدو حريري ولمسة ليمون.',
      descriptionEn:
          'Sauteed shrimp, fettuccine, silky Alfredo sauce, and a lemon finish.',
      imageUrl:
          'https://images.unsplash.com/photo-1551183053-bf91a1d81141?auto=format&fit=crop&w=900&q=90',
      price: 15.75,
      oldPrice: 18.25,
      rating: 4.8,
      reviewsCount: 231,
      calories: 670,
      preparationTime: '22 min',
      categoryId: 'pasta',
      ingredients: <String>['Shrimp', 'Fettuccine', 'Alfredo', 'Lemon'],
      isRecommended: true,
      sizes: _mealSizes,
      extras: _pastaExtras,
    ),
    _food(
      id: '9',
      nameAr: 'بيني بيستو أخضر',
      nameEn: 'Pesto Penne',
      descriptionAr:
          'بيني ألدنتي مع بيستو ريحان، صنوبر، بارميزان وطماطم مجففة.',
      descriptionEn:
          'Al dente penne with basil pesto, pine nuts, parmesan, and sun-dried tomato.',
      imageUrl:
          'https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?auto=format&fit=crop&w=900&q=90',
      price: 11.85,
      oldPrice: 13.40,
      rating: 4.5,
      reviewsCount: 188,
      calories: 560,
      preparationTime: '19 min',
      categoryId: 'pasta',
      ingredients: <String>['Penne', 'Pesto', 'Parmesan', 'Pine nuts'],
      sizes: _mealSizes,
      extras: _pastaExtras,
    ),
    _food(
      id: '10',
      nameAr: 'فراخ هاني تشيلي',
      nameEn: 'Honey Chili Chicken',
      descriptionAr:
          'قطع فراخ مقرمشة بصوص عسل وتشيلي، سمسم، بصل أخضر ولايم.',
      descriptionEn:
          'Crispy chicken glazed with honey chili, sesame, spring onion, and lime.',
      imageUrl:
          'https://images.unsplash.com/photo-1598515214211-89d3c73ae83b?auto=format&fit=crop&w=900&q=90',
      price: 11.75,
      oldPrice: 13.75,
      rating: 4.6,
      reviewsCount: 274,
      calories: 520,
      preparationTime: '17 min',
      categoryId: 'chicken',
      ingredients: <String>['Chicken', 'Honey chili', 'Sesame', 'Lime'],
      isPopular: true,
      sizes: _mealSizes,
      extras: _mealExtras,
    ),
    _food(
      id: '11',
      nameAr: 'فراخ ليمون مشوية',
      nameEn: 'Grilled Lemon Chicken',
      descriptionAr:
          'صدر فراخ مشوي بتتبيلة ليمون وزعتر مع خضار مشوية وأرز أعشاب.',
      descriptionEn:
          'Grilled chicken breast with lemon thyme marinade, vegetables, and herb rice.',
      imageUrl:
          'https://images.unsplash.com/photo-1532550907401-a500c9a57435?auto=format&fit=crop&w=900&q=90',
      price: 12.60,
      oldPrice: 14.20,
      rating: 4.7,
      reviewsCount: 201,
      calories: 480,
      preparationTime: '24 min',
      categoryId: 'chicken',
      ingredients: <String>['Chicken breast', 'Lemon', 'Thyme', 'Herb rice'],
      isRecommended: true,
      sizes: _mealSizes,
      extras: _mealExtras,
    ),
    _food(
      id: '12',
      nameAr: 'طبق شاورما فراخ',
      nameEn: 'Chicken Shawarma Plate',
      descriptionAr:
          'شاورما فراخ متبلة، ثومية، مخلل، بطاطس وأرز شرقي دافئ.',
      descriptionEn:
          'Spiced chicken shawarma, garlic dip, pickles, fries, and warm oriental rice.',
      imageUrl:
          'https://images.unsplash.com/photo-1529006557810-274b9b2fc783?auto=format&fit=crop&w=900&q=90',
      price: 10.95,
      oldPrice: 12.50,
      rating: 4.7,
      reviewsCount: 347,
      calories: 650,
      preparationTime: '18 min',
      categoryId: 'oriental',
      ingredients: <String>['Shawarma', 'Garlic dip', 'Pickles', 'Rice'],
      isPopular: true,
      sizes: _mealSizes,
      extras: _orientalExtras,
    ),
    _food(
      id: '13',
      nameAr: 'طبق كفتة بلدي',
      nameEn: 'Beef Kofta Platter',
      descriptionAr:
          'كفتة مشوية على الفحم مع طحينة، سلطة بلدي وخبز طازج.',
      descriptionEn:
          'Charcoal-grilled kofta with tahini, baladi salad, and fresh bread.',
      imageUrl:
          'https://images.unsplash.com/photo-1600891964599-f61ba0e24092?auto=format&fit=crop&w=900&q=90',
      price: 13.40,
      oldPrice: 15.25,
      rating: 4.6,
      reviewsCount: 222,
      calories: 700,
      preparationTime: '25 min',
      categoryId: 'oriental',
      ingredients: <String>['Kofta', 'Tahini', 'Baladi salad', 'Bread'],
      isRecommended: true,
      sizes: _mealSizes,
      extras: _orientalExtras,
    ),
    _food(
      id: '14',
      nameAr: 'كشري بريميوم',
      nameEn: 'Premium Koshary Bowl',
      descriptionAr:
          'عدس، أرز، مكرونة، حمص، بصل مقرمش، دقة وصوص طماطم حار.',
      descriptionEn:
          'Lentils, rice, pasta, chickpeas, crispy onions, daqqa, and spicy tomato sauce.',
      imageUrl:
          'https://images.unsplash.com/photo-1596797038530-2c107229654b?auto=format&fit=crop&w=900&q=90',
      price: 7.95,
      oldPrice: 9.10,
      rating: 4.5,
      reviewsCount: 418,
      calories: 610,
      preparationTime: '14 min',
      categoryId: 'oriental',
      ingredients: <String>['Lentils', 'Rice', 'Pasta', 'Crispy onions'],
      isPopular: true,
      sizes: _mealSizes,
      extras: _orientalExtras,
    ),
    _food(
      id: '15',
      nameAr: 'كبسة فراخ',
      nameEn: 'Chicken Kabsa',
      descriptionAr:
          'فراخ متبلة بتوابل خليجية مع أرز بسمتي، مكسرات وصوص دقوس.',
      descriptionEn:
          'Gulf-spiced chicken with basmati rice, nuts, and daqoos sauce.',
      imageUrl:
          'https://images.unsplash.com/photo-1563379091339-03246963d29a?auto=format&fit=crop&w=900&q=90',
      price: 12.90,
      oldPrice: 15.00,
      rating: 4.8,
      reviewsCount: 302,
      calories: 720,
      preparationTime: '28 min',
      categoryId: 'main_meals',
      ingredients: <String>['Chicken', 'Basmati rice', 'Nuts', 'Daqoos'],
      isRecommended: true,
      sizes: _mealSizes,
      extras: _orientalExtras,
    ),
    _food(
      id: '16',
      nameAr: 'ستيك مشروم',
      nameEn: 'Steak and Mushrooms',
      descriptionAr:
          'ستيك مشوي مع مشروم كريمي، بطاطس مهروسة وخضار سوتيه.',
      descriptionEn:
          'Grilled steak with creamy mushrooms, mashed potatoes, and sauteed vegetables.',
      imageUrl:
          'https://images.unsplash.com/photo-1558030006-450675393462?auto=format&fit=crop&w=900&q=90',
      price: 21.50,
      oldPrice: 25.00,
      rating: 4.9,
      reviewsCount: 176,
      calories: 760,
      preparationTime: '30 min',
      categoryId: 'western',
      ingredients: <String>['Steak', 'Mushrooms', 'Potatoes', 'Vegetables'],
      isPopular: true,
      isRecommended: true,
      sizes: _mealSizes,
      extras: _mealExtras,
    ),
    _food(
      id: '17',
      nameAr: 'فيش آند تشيبس',
      nameEn: 'Fish and Chips',
      descriptionAr:
          'فيليه سمك مقرمش، بطاطس ذهبية، صوص تارتار وسلطة كابج.',
      descriptionEn:
          'Crispy fish fillet, golden fries, tartar sauce, and cabbage salad.',
      imageUrl:
          'https://images.unsplash.com/photo-1544025162-d76694265947?auto=format&fit=crop&w=900&q=90',
      price: 14.70,
      oldPrice: 17.00,
      rating: 4.5,
      reviewsCount: 155,
      calories: 680,
      preparationTime: '24 min',
      categoryId: 'western',
      ingredients: <String>['Fish', 'Fries', 'Tartar', 'Cabbage'],
      sizes: _mealSizes,
      extras: _mealExtras,
    ),
    _food(
      id: '18',
      nameAr: 'كلوب ساندوتش ديك رومي',
      nameEn: 'Turkey Club Sandwich',
      descriptionAr:
          'ديك رومي مدخن، بيض، خس، طماطم، مايونيز خفيف وتوست محمص.',
      descriptionEn:
          'Smoked turkey, egg, lettuce, tomato, light mayo, and toasted bread.',
      imageUrl:
          'https://images.unsplash.com/photo-1528735602780-2552fd46c7af?auto=format&fit=crop&w=900&q=90',
      price: 9.80,
      oldPrice: 11.20,
      rating: 4.4,
      reviewsCount: 144,
      calories: 520,
      preparationTime: '13 min',
      categoryId: 'sandwiches',
      ingredients: <String>['Turkey', 'Egg', 'Lettuce', 'Toast'],
      sizes: _sandwichSizes,
      extras: _sandwichExtras,
    ),
    _food(
      id: '19',
      nameAr: 'ساندوتش شاورما فراخ',
      nameEn: 'Chicken Shawarma Sandwich',
      descriptionAr:
          'عيش صاج، شاورما فراخ، ثومية، خيار مخلل وبطاطس داخل الساندوتش.',
      descriptionEn:
          'Saj bread, chicken shawarma, garlic dip, pickles, and fries inside.',
      imageUrl:
          'https://images.unsplash.com/photo-1628294896516-344152572ee8?auto=format&fit=crop&w=900&q=90',
      price: 8.90,
      oldPrice: 10.00,
      rating: 4.7,
      reviewsCount: 363,
      calories: 580,
      preparationTime: '12 min',
      categoryId: 'sandwiches',
      ingredients: <String>['Saj', 'Chicken', 'Garlic dip', 'Pickles'],
      isPopular: true,
      sizes: _sandwichSizes,
      extras: _sandwichExtras,
    ),
    _food(
      id: '20',
      nameAr: 'راب فلافل صحي',
      nameEn: 'Falafel Power Wrap',
      descriptionAr:
          'فلافل بالفرن، طحينة لايت، خضار مقرمش وخبز حبوب كاملة.',
      descriptionEn:
          'Baked falafel, light tahini, crunchy vegetables, and wholegrain wrap.',
      imageUrl:
          'https://images.unsplash.com/photo-1593001874117-c99c800e3eb7?auto=format&fit=crop&w=900&q=90',
      price: 8.25,
      oldPrice: 9.40,
      rating: 4.6,
      reviewsCount: 214,
      calories: 430,
      preparationTime: '14 min',
      categoryId: 'healthy',
      ingredients: <String>['Falafel', 'Tahini', 'Vegetables', 'Wholegrain'],
      isRecommended: true,
      sizes: _sandwichSizes,
      extras: _healthyExtras,
    ),
    _food(
      id: '21',
      nameAr: 'بول فراخ بالأفوكادو',
      nameEn: 'Avocado Chicken Bowl',
      descriptionAr:
          'فراخ مشوية، أفوكادو، كينوا، ذرة، خضار وصوص حمضيات.',
      descriptionEn:
          'Grilled chicken, avocado, quinoa, corn salsa, greens, and citrus dressing.',
      imageUrl:
          'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?auto=format&fit=crop&w=900&q=90',
      price: 10.99,
      oldPrice: 12.30,
      rating: 4.5,
      reviewsCount: 143,
      calories: 480,
      preparationTime: '16 min',
      categoryId: 'healthy',
      ingredients: <String>['Chicken', 'Avocado', 'Quinoa', 'Citrus'],
      isPopular: true,
      sizes: _mealSizes,
      extras: _healthyExtras,
    ),
    _food(
      id: '22',
      nameAr: 'سلطة سلمون وكينوا',
      nameEn: 'Quinoa Salmon Salad',
      descriptionAr:
          'سلمون مشوي، كينوا، خيار، أفوكادو، خضار وصوص زبادي ليمون.',
      descriptionEn:
          'Grilled salmon, quinoa, cucumber, avocado, greens, and lemon yogurt dressing.',
      imageUrl:
          'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=900&q=90',
      price: 16.40,
      oldPrice: 18.75,
      rating: 4.8,
      reviewsCount: 121,
      calories: 510,
      preparationTime: '19 min',
      categoryId: 'healthy',
      ingredients: <String>['Salmon', 'Quinoa', 'Avocado', 'Yogurt'],
      isRecommended: true,
      sizes: _mealSizes,
      extras: _healthyExtras,
    ),
    _food(
      id: '23',
      nameAr: 'سلطة يوناني فيتا',
      nameEn: 'Greek Feta Salad',
      descriptionAr:
          'طماطم كرزية، خيار، زيتون، جبنة فيتا، أوريجانو وزيت زيتون.',
      descriptionEn:
          'Cherry tomato, cucumber, olives, feta cheese, oregano, and olive oil.',
      imageUrl:
          'https://images.unsplash.com/photo-1607532941433-304659e8198a?auto=format&fit=crop&w=900&q=90',
      price: 8.80,
      oldPrice: 10.25,
      rating: 4.4,
      reviewsCount: 117,
      calories: 320,
      preparationTime: '10 min',
      categoryId: 'healthy',
      ingredients: <String>['Tomato', 'Cucumber', 'Olives', 'Feta'],
      sizes: _mealSizes,
      extras: _healthyExtras,
    ),
    _food(
      id: '24',
      nameAr: 'مولتن شوكولاتة',
      nameEn: 'Molten Chocolate Cake',
      descriptionAr:
          'كيك شوكولاتة دافئ بقلب سائل مع كريمة فانيليا وتوت.',
      descriptionEn:
          'Warm chocolate cake with a soft center, vanilla cream, and berries.',
      imageUrl:
          'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?auto=format&fit=crop&w=900&q=90',
      price: 7.50,
      oldPrice: 8.90,
      rating: 4.9,
      reviewsCount: 198,
      calories: 430,
      preparationTime: '14 min',
      categoryId: 'dessert',
      ingredients: <String>['Dark chocolate', 'Vanilla', 'Butter', 'Berries'],
      isPopular: true,
      sizes: _dessertSizes,
      extras: _dessertExtras,
    ),
    _food(
      id: '25',
      nameAr: 'تشيز كيك لوتس',
      nameEn: 'Lotus Cheesecake',
      descriptionAr:
          'تشيز كيك كريمي بقاعدة بسكويت لوتس وصوص كراميل غني.',
      descriptionEn:
          'Creamy cheesecake with Lotus biscuit base and rich caramel sauce.',
      imageUrl:
          'https://images.unsplash.com/photo-1533134242443-d4fd215305ad?auto=format&fit=crop&w=900&q=90',
      price: 7.20,
      oldPrice: 8.35,
      rating: 4.8,
      reviewsCount: 226,
      calories: 460,
      preparationTime: '8 min',
      categoryId: 'dessert',
      ingredients: <String>['Cream cheese', 'Lotus', 'Caramel', 'Cream'],
      isRecommended: true,
      sizes: _dessertSizes,
      extras: _dessertExtras,
    ),
    _food(
      id: '26',
      nameAr: 'كنافة كريمة',
      nameEn: 'Kunafa Cream Cup',
      descriptionAr:
          'كنافة مقرمشة، كريمة خفيفة، فستق وشربات ورد متوازن.',
      descriptionEn:
          'Crispy kunafa, light cream, pistachio, and balanced rose syrup.',
      imageUrl:
          'https://images.unsplash.com/photo-1578985545062-69928b1d9587?auto=format&fit=crop&w=900&q=90',
      price: 6.80,
      oldPrice: 7.95,
      rating: 4.7,
      reviewsCount: 172,
      calories: 420,
      preparationTime: '9 min',
      categoryId: 'dessert',
      ingredients: <String>['Kunafa', 'Cream', 'Pistachio', 'Rose syrup'],
      sizes: _dessertSizes,
      extras: _dessertExtras,
    ),
    _food(
      id: '27',
      nameAr: 'تيراميسو جار',
      nameEn: 'Tiramisu Jar',
      descriptionAr:
          'طبقات ماسكاربوني، إسبرسو، كاكاو وبسكويت ليدي فينجر.',
      descriptionEn:
          'Layers of mascarpone, espresso, cocoa, and ladyfinger biscuits.',
      imageUrl:
          'https://images.unsplash.com/photo-1551024506-0bccd828d307?auto=format&fit=crop&w=900&q=90',
      price: 7.85,
      oldPrice: 9.25,
      rating: 4.6,
      reviewsCount: 136,
      calories: 390,
      preparationTime: '7 min',
      categoryId: 'dessert',
      ingredients: <String>['Mascarpone', 'Espresso', 'Cocoa', 'Biscuits'],
      sizes: _dessertSizes,
      extras: _dessertExtras,
    ),
    _food(
      id: '28',
      nameAr: 'آيس كريم فانيليا',
      nameEn: 'Vanilla Bean Ice Cream',
      descriptionAr:
          'آيس كريم فانيليا طبيعي بقوام كريمي مع قطع فانيليا حقيقية.',
      descriptionEn:
          'Natural vanilla ice cream with a creamy texture and real vanilla beans.',
      imageUrl:
          'https://images.unsplash.com/photo-1501443762994-82bd5dace89a?auto=format&fit=crop&w=900&q=90',
      price: 5.90,
      oldPrice: 6.75,
      rating: 4.5,
      reviewsCount: 111,
      calories: 260,
      preparationTime: '5 min',
      categoryId: 'ice_cream',
      ingredients: <String>['Vanilla', 'Milk', 'Cream', 'Sugar'],
      sizes: _dessertSizes,
      extras: _iceCreamExtras,
    ),
    _food(
      id: '29',
      nameAr: 'سوربيه مانجو',
      nameEn: 'Mango Sorbet',
      descriptionAr:
          'سوربيه مانجو منعش بدون ألبان مع لمسة لايم ونعناع.',
      descriptionEn:
          'Refreshing dairy-free mango sorbet with lime and mint.',
      imageUrl:
          'https://images.unsplash.com/photo-1563805042-7684c019e1cb?auto=format&fit=crop&w=900&q=90',
      price: 5.70,
      oldPrice: 6.50,
      rating: 4.6,
      reviewsCount: 97,
      calories: 210,
      preparationTime: '5 min',
      categoryId: 'ice_cream',
      ingredients: <String>['Mango', 'Lime', 'Mint', 'Sugar'],
      isRecommended: true,
      sizes: _dessertSizes,
      extras: _iceCreamExtras,
    ),
    _food(
      id: '30',
      nameAr: 'سانداي فراولة',
      nameEn: 'Strawberry Sundae',
      descriptionAr:
          'آيس كريم فانيليا، صوص فراولة، كريمة وقطع بسكويت مقرمشة.',
      descriptionEn:
          'Vanilla ice cream, strawberry sauce, whipped cream, and crunchy biscuit.',
      imageUrl:
          'https://images.unsplash.com/photo-1567206563064-6f60f40a2b57?auto=format&fit=crop&w=900&q=90',
      price: 6.35,
      oldPrice: 7.25,
      rating: 4.7,
      reviewsCount: 142,
      calories: 330,
      preparationTime: '6 min',
      categoryId: 'ice_cream',
      ingredients: <String>['Ice cream', 'Strawberry', 'Cream', 'Biscuit'],
      sizes: _dessertSizes,
      extras: _iceCreamExtras,
    ),
    _food(
      id: '31',
      nameAr: 'آيس سبانش لاتيه',
      nameEn: 'Iced Spanish Latte',
      descriptionAr:
          'إسبرسو بارد، حليب كريمي وحلاوة متوازنة فوق مكعبات ثلج.',
      descriptionEn:
          'Cold espresso, creamy milk, and balanced sweetness over ice.',
      imageUrl:
          'https://images.unsplash.com/photo-1517701604599-bb29b565090c?auto=format&fit=crop&w=900&q=90',
      price: 5.60,
      oldPrice: 6.50,
      rating: 4.8,
      reviewsCount: 256,
      calories: 180,
      preparationTime: '6 min',
      categoryId: 'cold_drinks',
      ingredients: <String>['Espresso', 'Milk', 'Ice', 'Condensed milk'],
      isPopular: true,
      sizes: _drinkSizes,
      extras: _coffeeExtras,
    ),
    _food(
      id: '32',
      nameAr: 'كولد برو بالحمضيات',
      nameEn: 'Cold Brew Citrus',
      descriptionAr:
          'كولد برو مركز مع تونك خفيف، برتقال ولمسة قرفة.',
      descriptionEn:
          'Concentrated cold brew with light tonic, orange, and a cinnamon hint.',
      imageUrl:
          'https://images.unsplash.com/photo-1461023058943-07fcbe16d735?auto=format&fit=crop&w=900&q=90',
      price: 5.95,
      oldPrice: 6.90,
      rating: 4.6,
      reviewsCount: 121,
      calories: 90,
      preparationTime: '7 min',
      categoryId: 'coffee',
      ingredients: <String>['Cold brew', 'Tonic', 'Orange', 'Cinnamon'],
      isRecommended: true,
      sizes: _drinkSizes,
      extras: _coffeeExtras,
    ),
    _food(
      id: '33',
      nameAr: 'عصير مانجو فريش',
      nameEn: 'Fresh Mango Juice',
      descriptionAr:
          'مانجو طبيعي مع قوام كثيف، ثلج خفيف وبدون ألوان صناعية.',
      descriptionEn:
          'Natural mango with a rich texture, light ice, and no artificial colors.',
      imageUrl:
          'https://images.unsplash.com/photo-1622597467836-f3285f2131b8?auto=format&fit=crop&w=900&q=90',
      price: 4.75,
      oldPrice: 5.50,
      rating: 4.7,
      reviewsCount: 188,
      calories: 160,
      preparationTime: '5 min',
      categoryId: 'juices',
      ingredients: <String>['Mango', 'Ice', 'Water', 'Honey'],
      isPopular: true,
      sizes: _drinkSizes,
      extras: _juiceExtras,
    ),
    _food(
      id: '34',
      nameAr: 'عصير بطيخ ونعناع',
      nameEn: 'Watermelon Mint Juice',
      descriptionAr:
          'بطيخ مبرد، نعناع طازج، لايم ونقطة عسل اختيارية.',
      descriptionEn:
          'Chilled watermelon, fresh mint, lime, and an optional honey touch.',
      imageUrl:
          'https://images.unsplash.com/photo-1589733955941-5eeaf752f6dd?auto=format&fit=crop&w=900&q=90',
      price: 4.60,
      oldPrice: 5.20,
      rating: 4.5,
      reviewsCount: 102,
      calories: 120,
      preparationTime: '5 min',
      categoryId: 'juices',
      ingredients: <String>['Watermelon', 'Mint', 'Lime', 'Honey'],
      sizes: _drinkSizes,
      extras: _juiceExtras,
    ),
    _food(
      id: '35',
      nameAr: 'بوست برتقال وجزر',
      nameEn: 'Orange Carrot Boost',
      descriptionAr:
          'برتقال طازج، جزر، زنجبيل خفيف وثلج لمشروب منعش.',
      descriptionEn:
          'Fresh orange, carrot, light ginger, and ice for a bright refresh.',
      imageUrl:
          'https://images.unsplash.com/photo-1600271886742-f049cd451bba?auto=format&fit=crop&w=900&q=90',
      price: 4.85,
      oldPrice: 5.60,
      rating: 4.6,
      reviewsCount: 95,
      calories: 135,
      preparationTime: '5 min',
      categoryId: 'juices',
      ingredients: <String>['Orange', 'Carrot', 'Ginger', 'Ice'],
      isRecommended: true,
      sizes: _drinkSizes,
      extras: _juiceExtras,
    ),
    _food(
      id: '36',
      nameAr: 'كابتشينو كلاسيك',
      nameEn: 'Classic Cappuccino',
      descriptionAr:
          'إسبرسو متوازن مع رغوة حليب حريرية ورشة كاكاو.',
      descriptionEn:
          'Balanced espresso with silky milk foam and a cocoa dusting.',
      imageUrl:
          'https://images.unsplash.com/photo-1509042239860-f550ce710b93?auto=format&fit=crop&w=900&q=90',
      price: 4.20,
      oldPrice: 4.95,
      rating: 4.7,
      reviewsCount: 241,
      calories: 140,
      preparationTime: '6 min',
      categoryId: 'hot_drinks',
      ingredients: <String>['Espresso', 'Milk', 'Foam', 'Cocoa'],
      isPopular: true,
      sizes: _drinkSizes,
      extras: _coffeeExtras,
    ),
    _food(
      id: '37',
      nameAr: 'قهوة تركي',
      nameEn: 'Turkish Coffee',
      descriptionAr:
          'قهوة تركي غنية مطحونة ناعم مع وش كثيف وحبهان اختياري.',
      descriptionEn:
          'Rich finely ground Turkish coffee with thick foam and optional cardamom.',
      imageUrl:
          'https://images.unsplash.com/photo-1577968897966-3d4325b36b61?auto=format&fit=crop&w=900&q=90',
      price: 3.80,
      oldPrice: 4.40,
      rating: 4.8,
      reviewsCount: 180,
      calories: 40,
      preparationTime: '7 min',
      categoryId: 'coffee',
      ingredients: <String>['Coffee', 'Water', 'Cardamom', 'Sugar'],
      isRecommended: true,
      sizes: _drinkSizes,
      extras: _coffeeExtras,
    ),
    _food(
      id: '38',
      nameAr: 'شاي كرك',
      nameEn: 'Karak Tea',
      descriptionAr:
          'شاي أسود بالحليب، هيل، زعفران خفيف وحلاوة مضبوطة.',
      descriptionEn:
          'Black tea with milk, cardamom, light saffron, and balanced sweetness.',
      imageUrl:
          'https://images.unsplash.com/photo-1571934811356-5cc061b6821f?auto=format&fit=crop&w=900&q=90',
      price: 3.95,
      oldPrice: 4.60,
      rating: 4.6,
      reviewsCount: 154,
      calories: 150,
      preparationTime: '8 min',
      categoryId: 'tea',
      ingredients: <String>['Black tea', 'Milk', 'Cardamom', 'Saffron'],
      isPopular: true,
      sizes: _drinkSizes,
      extras: _teaExtras,
    ),
    _food(
      id: '39',
      nameAr: 'شاي مغربي بالنعناع',
      nameEn: 'Moroccan Mint Tea',
      descriptionAr:
          'شاي أخضر مع نعناع طازج وسكر خفيف يقدم ساخن ومنعش.',
      descriptionEn:
          'Green tea with fresh mint and light sugar, served hot and refreshing.',
      imageUrl:
          'https://images.unsplash.com/photo-1597318181409-cf64d0b5d8a2?auto=format&fit=crop&w=900&q=90',
      price: 3.65,
      oldPrice: 4.25,
      rating: 4.5,
      reviewsCount: 109,
      calories: 70,
      preparationTime: '7 min',
      categoryId: 'tea',
      ingredients: <String>['Green tea', 'Mint', 'Sugar', 'Water'],
      sizes: _drinkSizes,
      extras: _teaExtras,
    ),
    _food(
      id: '40',
      nameAr: 'هوت شوكليت',
      nameEn: 'Signature Hot Chocolate',
      descriptionAr:
          'كاكاو بلجيكي، حليب مبخر، مارشميلو وصوص شوكولاتة داكنة.',
      descriptionEn:
          'Belgian cocoa, steamed milk, marshmallow, and dark chocolate sauce.',
      imageUrl:
          'https://images.unsplash.com/photo-1542990253-0d0f5be5f0ed?auto=format&fit=crop&w=900&q=90',
      price: 4.90,
      oldPrice: 5.75,
      rating: 4.7,
      reviewsCount: 132,
      calories: 230,
      preparationTime: '7 min',
      categoryId: 'hot_drinks',
      ingredients: <String>['Cocoa', 'Milk', 'Marshmallow', 'Chocolate'],
      isRecommended: true,
      sizes: _drinkSizes,
      extras: _coffeeExtras,
    ),
  ];

  static FoodModel byId(String id) {
    return foods.firstWhere((food) => food.id == id, orElse: () => foods.first);
  }

  static const List<String> _mealSizes = <String>['Regular', 'Large', 'Family'];
  static const List<String> _pizzaSizes = <String>['Small', 'Medium', 'Large'];
  static const List<String> _sandwichSizes = <String>[
    'Single',
    'Double',
    'Combo',
  ];
  static const List<String> _dessertSizes = <String>['Mini', 'Regular', 'Share'];
  static const List<String> _drinkSizes = <String>['Small', 'Medium', 'Large'];

  static const List<String> _burgerExtras = <String>[
    'Extra cheese',
    'Fries',
    'Smoky sauce',
    'Jalapeno',
  ];
  static const List<String> _pizzaExtras = <String>[
    'Extra mozzarella',
    'Pepperoni',
    'Mushrooms',
    'Olives',
  ];
  static const List<String> _pastaExtras = <String>[
    'Parmesan',
    'Chicken',
    'Shrimp',
    'Garlic bread',
  ];
  static const List<String> _mealExtras = <String>[
    'Herb rice',
    'Grilled veggies',
    'Extra sauce',
    'Side salad',
  ];
  static const List<String> _orientalExtras = <String>[
    'Tahini',
    'Garlic dip',
    'Pickles',
    'Extra bread',
  ];
  static const List<String> _sandwichExtras = <String>[
    'Cheese',
    'Fries',
    'Extra sauce',
    'Pickles',
  ];
  static const List<String> _healthyExtras = <String>[
    'Avocado',
    'Quinoa',
    'Boiled egg',
    'Light dressing',
  ];
  static const List<String> _dessertExtras = <String>[
    'Chocolate sauce',
    'Berries',
    'Whipped cream',
    'Pistachio',
  ];
  static const List<String> _iceCreamExtras = <String>[
    'Caramel',
    'Nuts',
    'Brownie bites',
    'Sprinkles',
  ];
  static const List<String> _coffeeExtras = <String>[
    'Extra shot',
    'Oat milk',
    'Caramel',
    'Less sugar',
  ];
  static const List<String> _juiceExtras = <String>[
    'No sugar',
    'Chia seeds',
    'Extra ice',
    'Mint',
  ];
  static const List<String> _teaExtras = <String>[
    'Extra mint',
    'Honey',
    'Less sugar',
    'Ginger',
  ];

  static FoodModel _food({
    required String id,
    required String nameAr,
    required String nameEn,
    required String descriptionAr,
    required String descriptionEn,
    required String imageUrl,
    required double price,
    required double oldPrice,
    required double rating,
    required int reviewsCount,
    required int calories,
    required String preparationTime,
    required String categoryId,
    required List<String> ingredients,
    required List<String> sizes,
    required List<String> extras,
    bool isPopular = false,
    bool isRecommended = false,
  }) {
    return FoodModel(
      id: id,
      nameAr: nameAr,
      nameEn: nameEn,
      descriptionAr: descriptionAr,
      descriptionEn: descriptionEn,
      imageUrl: imageUrl,
      price: price,
      oldPrice: oldPrice,
      rating: rating,
      reviewsCount: reviewsCount,
      calories: calories,
      preparationTime: preparationTime,
      categoryId: categoryId,
      ingredients: ingredients,
      reviews: reviews,
      isPopular: isPopular,
      isRecommended: isRecommended,
      isAvailable: true,
      sizes: sizes,
      extras: extras,
    );
  }
}
