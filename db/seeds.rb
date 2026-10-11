# Realistic seed data for Zigi Food Delivery Platform
# Uses find_or_create_by to preserve existing data idempotently.

puts "== Seeding Zigi database =="


# 1. Users
admin_user = User.find_by(email: "rahulgawade2006@gmail.com")
if admin_user
  admin_user.update(name: "Rahul Gawade", role: "admin", phone: "9876543210", address: "Flat 402, Green Glen Residency, FC Road, Pune")
else
  User.create!(
    name: "Rahul Gawade",
    email: "rahulgawade2006@gmail.com",
    password: "password123",
    password_confirmation: "password123",
    role: "admin",
    phone: "9876543210",
    address: "Flat 402, Green Glen Residency, FC Road, Pune"
  )
end

customer_user = User.find_by(email: "abc@gmail.com")
if customer_user
  customer_user.update(name: "Aman Sharma", role: "customer", phone: "9823012345", address: "Flat 101, Shanti Niketan, Kothrud, Pune")
else
  User.create!(
    name: "Aman Sharma",
    email: "abc@gmail.com",
    password: "password123",
    password_confirmation: "password123",
    role: "customer",
    phone: "9823012345",
    address: "Flat 101, Shanti Niketan, Kothrud, Pune"
  )
end

# 2. Restaurants
restaurants_data = [
  {
    name: "Paradise Biryani",
    description: "Legendary royal Hyderabadi dum biryani cooked over slow fire with authentic hand-ground spices.",
    cuisine: "Biryani, North Indian, Mughlai",
    rating: 4.6,
    delivery_time: "25-30 mins",
    price_for_two: 450,
    address: "Shop 12, FC Road, Shivajinagar",
    city: "Pune",
    image_url: "https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?auto=format&fit=crop&w=800&q=80",
    featured: true,
    pure_veg: false,
    phone: "020-25678901",
    dishes: [
      { name: "Chicken Dum Biryani", description: "Rich basmati rice cooked with succulent chicken cuts, saffron, and aromatic spices.", price: 290, is_veg: false, category: "Biryani", image_url: "https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?auto=format&fit=crop&w=600&q=80" },
      { name: "Paneer Subz Biryani", description: "Layers of fragrant rice with fresh paneer cubes and tossed garden vegetables.", price: 240, is_veg: true, category: "Biryani", image_url: "https://images.unsplash.com/photo-1633945274405-b6c8069047b0?auto=format&fit=crop&w=600&q=80" },
      { name: "Murgh Malai Tikka", description: "Boneless chicken marinated with cashew cream, cheese, and grilled in tandoor.", price: 320, is_veg: false, category: "Starters", image_url: "https://images.unsplash.com/photo-1599488615731-7e5c2823ff28?auto=format&fit=crop&w=600&q=80" },
      { name: "Garlic Butter Naan", description: "Oven-baked fluffy leavened bread brushed with melted butter and fresh minced garlic.", price: 65, is_veg: true, category: "Breads", image_url: "https://images.unsplash.com/photo-1626074353765-517a681e40be?auto=format&fit=crop&w=600&q=80" },
      { name: "Shahi Gulab Jamun (2 Pcs)", description: "Soft deep-fried dough balls soaked in rose-flavored warm sugar syrup.", price: 90, is_veg: true, category: "Desserts", image_url: "https://images.unsplash.com/photo-1589301760014-d929f3979dbc?auto=format&fit=crop&w=600&q=80" }
    ]
  },
  {
    name: "Pizza Bella Roma",
    description: "Wood-fired artisanal pizzas made with San Marzano tomatoes and authentic Italian mozzarella.",
    cuisine: "Pizza, Italian, Fast Food",
    rating: 4.4,
    delivery_time: "30-35 mins",
    price_for_two: 500,
    address: "Lane 6, Koregaon Park",
    city: "Pune",
    image_url: "https://images.unsplash.com/photo-1513104890138-7c749659a591?auto=format&fit=crop&w=800&q=80",
    featured: true,
    pure_veg: false,
    phone: "020-26123456",
    dishes: [
      { name: "Classic Margherita Pizza", description: "Tangy tomato passata, fresh basil leaves, and creamy buffalo mozzarella cheese.", price: 320, is_veg: true, category: "Pizza", image_url: "https://images.unsplash.com/photo-1604382355076-af4b0eb60143?auto=format&fit=crop&w=600&q=80" },
      { name: "Smoky Chicken Pepperoni", description: "Loaded with spiced chicken pepperoni slices, caramelized onions, and molten mozzarella.", price: 420, is_veg: false, category: "Pizza", image_url: "https://images.unsplash.com/photo-1534308983496-4fabb1a015ee?auto=format&fit=crop&w=600&q=80" },
      { name: "Creamy Penne Alfredo", description: "Al dente penne pasta tossed in rich parmesan garlic white sauce with sautéed mushrooms.", price: 290, is_veg: true, category: "Pasta", image_url: "https://images.unsplash.com/photo-1621996346565-e3d5d6281745?auto=format&fit=crop&w=600&q=80" },
      { name: "Cheesy Garlic Breadsticks", description: "Freshly baked dough topped with garlic butter, Italian herbs, and mozzarella strings.", price: 150, is_veg: true, category: "Sides", image_url: "https://images.unsplash.com/photo-1573140247632-f8fd74997d5c?auto=format&fit=crop&w=600&q=80" }
    ]
  },
  {
    name: "Shree Krishna Veg Delights",
    description: "Pure vegetarian haven serving rich North Indian curries, paneer delicacies, and royal thalis.",
    cuisine: "North Indian, Pure Veg, Thali",
    rating: 4.7,
    delivery_time: "20-25 mins",
    price_for_two: 320,
    address: "Near Deccan Gymkhana, JM Road",
    city: "Pune",
    image_url: "https://images.unsplash.com/photo-1585937421612-70a008356fbe?auto=format&fit=crop&w=800&q=80",
    featured: true,
    pure_veg: true,
    phone: "020-25534123",
    dishes: [
      { name: "Paneer Butter Masala", description: "Fresh cottage cheese simmered in buttery velvety tomato gravy seasoned with kasuri methi.", price: 260, is_veg: true, category: "Main Course", image_url: "https://images.unsplash.com/photo-1631452180519-c014fe946bc7?auto=format&fit=crop&w=600&q=80" },
      { name: "Dal Makhani Special", description: "Slow-simmered black lentils and kidney beans enriched with pure butter and cream.", price: 220, is_veg: true, category: "Main Course", image_url: "https://images.unsplash.com/photo-1546833999-b9f581a1996d?auto=format&fit=crop&w=600&q=80" },
      { name: "Royal Maharaja Thali", description: "2 Sabzis, Dal, Jeera Rice, 3 Butter Rotis, Raita, Salad, and Gulab Jamun.", price: 340, is_veg: true, category: "Thali", image_url: "https://images.unsplash.com/photo-1610057099443-fde8c4d50f91?auto=format&fit=crop&w=600&q=80" },
      { name: "Veg Kadhai", description: "Medley of seasonal vegetables and bell peppers cooked in freshly crushed kadhai masala.", price: 230, is_veg: true, category: "Main Course", image_url: "https://images.unsplash.com/photo-1589302168068-964664d93dc0?auto=format&fit=crop&w=600&q=80" }
    ]
  },
  {
    name: "Burger Nation",
    description: "Juicy grilled patties, crispy smashed burgers, golden fries, and thick handcrafted shakes.",
    cuisine: "Burgers, Fast Food, American",
    rating: 4.3,
    delivery_time: "20-25 mins",
    price_for_two: 350,
    address: "Viman Nagar Central, Near Phoenix Mall",
    city: "Pune",
    image_url: "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=800&q=80",
    featured: false,
    pure_veg: false,
    phone: "020-41235678",
    dishes: [
      { name: "Crispy Chicken Supreme Burger", description: "Double crispy fried chicken breast fillet with melted cheese, lettuce, and secret sauce.", price: 230, is_veg: false, category: "Burgers", image_url: "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=600&q=80" },
      { name: "Spicy Veggie Crunch Burger", description: "Crisp potato and pea patty seasoned with spicy chipotle mayo and pickles in a brioche bun.", price: 160, is_veg: true, category: "Burgers", image_url: "https://images.unsplash.com/photo-1520072959219-c595dc870360?auto=format&fit=crop&w=600&q=80" },
      { name: "Peri Peri French Fries", description: "Crispy golden crinkle-cut fries tossed with zesty African bird's eye chili seasoning.", price: 120, is_veg: true, category: "Sides", image_url: "https://images.unsplash.com/photo-1576107232684-1279f3908594?auto=format&fit=crop&w=600&q=80" },
      { name: "Belgian Chocolate Milkshake", description: "Thick creamy shake blended with dark Belgian chocolate and vanilla bean gelato.", price: 160, is_veg: true, category: "Beverages", image_url: "https://images.unsplash.com/photo-1572490122747-3968b75cc699?auto=format&fit=crop&w=600&q=80" }
    ]
  },
  {
    name: "Dakshin Tiffins",
    description: "Crispy ghee roast dosas, fluffy steamed idlis, and authentic piping hot filter coffee.",
    cuisine: "South Indian, Pure Veg, Breakfast",
    rating: 4.8,
    delivery_time: "15-20 mins",
    price_for_two: 240,
    address: "Opposite Garware College, Karve Road",
    city: "Pune",
    image_url: "https://images.unsplash.com/photo-1610057099443-fde8c4d50f91?auto=format&fit=crop&w=800&q=80",
    featured: true,
    pure_veg: true,
    phone: "020-25441234",
    dishes: [
      { name: "Special Ghee Podi Masala Dosa", description: "Crispy golden fermented crepe smeared with aromatic spicy podi gunpowder and potato masala.", price: 140, is_veg: true, category: "Dosa", image_url: "https://images.unsplash.com/photo-1668236543090-82eba5ee5976?auto=format&fit=crop&w=600&q=80" },
      { name: "Steamed Button Idli (12 Pcs)", description: "Bite-sized melt-in-mouth rice cakes served dipped in sambar and fresh coconut chutney.", price: 90, is_veg: true, category: "Tiffins", image_url: "https://images.unsplash.com/photo-1589301760014-d929f3979dbc?auto=format&fit=crop&w=600&q=80" },
      { name: "Medu Vada (2 Pcs)", description: "Crispy deep-fried lentil donuts with fluffy insides, served with tomato chutney.", price: 80, is_veg: true, category: "Tiffins", image_url: "https://images.unsplash.com/photo-1626777552726-4a6b54c97e46?auto=format&fit=crop&w=600&q=80" },
      { name: "Madras Filter Kaapi", description: "Traditional South Indian frothy chicory-blended brewed coffee in a brass davarah.", price: 50, is_veg: true, category: "Beverages", image_url: "https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?auto=format&fit=crop&w=600&q=80" }
    ]
  },
  {
    name: "Wok & Roll Asian Kitchen",
    description: "Sizzling Hakka noodles, Cantonese dim sums, Manchurian gravies, and Thai curries.",
    cuisine: "Chinese, Asian, Thai",
    rating: 4.3,
    delivery_time: "25-30 mins",
    price_for_two: 420,
    address: "Baner Main Road, Near High Street",
    city: "Pune",
    image_url: "https://images.unsplash.com/photo-1569718212165-3a8278d5f624?auto=format&fit=crop&w=800&q=80",
    featured: false,
    pure_veg: false,
    phone: "020-67891234",
    dishes: [
      { name: "Chicken Hakka Noodles", description: "Wok-tossed noodles with shredded chicken, crunchy cabbage, carrots, and spring onions.", price: 240, is_veg: false, category: "Noodles", image_url: "https://images.unsplash.com/photo-1569718212165-3a8278d5f624?auto=format&fit=crop&w=600&q=80" },
      { name: "Veg Manchurian Dry (8 Pcs)", description: "Minced vegetable crispy dumplings tossed in ginger, garlic, soya sauce, and green chilies.", price: 210, is_veg: true, category: "Starters", image_url: "https://images.unsplash.com/photo-1541832676-9b763b0239ab?auto=format&fit=crop&w=600&q=80" },
      { name: "Chicken Steamed Dimsums (6 Pcs)", description: "Delicate translucent wrappers filled with seasoned minced chicken, served with fiery dip.", price: 230, is_veg: false, category: "Dimsum", image_url: "https://images.unsplash.com/photo-1496116218417-1a781b1c416c?auto=format&fit=crop&w=600&q=80" }
    ]
  },
  {
    name: "The Sweet Tooth Patisserie",
    description: "Artisan pastries, Belgian chocolate brownies, waffles, and gourmet cheesecakes.",
    cuisine: "Desserts, Bakery, Cakes",
    rating: 4.9,
    delivery_time: "15-25 mins",
    price_for_two: 280,
    address: "Kothrud Stand, DP Road",
    city: "Pune",
    image_url: "https://images.unsplash.com/photo-1551024709-8f23befc6f87?auto=format&fit=crop&w=800&q=80",
    featured: false,
    pure_veg: true,
    phone: "020-25381234",
    dishes: [
      { name: "New York Baked Cheesecake Slice", description: "Dense and creamy classic cheesecake on a graham cracker crust with berry compote.", price: 210, is_veg: true, category: "Cakes", image_url: "https://images.unsplash.com/photo-1533134242443-d4fd215305ad?auto=format&fit=crop&w=600&q=80" },
      { name: "Gooey Belgian Walnut Brownie", description: "Fudgy warm chocolate brownie loaded with toasted California walnuts.", price: 130, is_veg: true, category: "Brownies", image_url: "https://images.unsplash.com/photo-1606313564200-e75d5e30476c?auto=format&fit=crop&w=600&q=80" },
      { name: "Nutella Overload Waffle", description: "Crisp golden Belgian waffle smothered with warm Nutella and dark chocolate chips.", price: 180, is_veg: true, category: "Waffles", image_url: "https://images.unsplash.com/photo-1562376552-0d160a2f238d?auto=format&fit=crop&w=600&q=80" }
    ]
  },
  {
    name: "Rolls & Bowls Express",
    description: "Crisp flaky parathas rolled with juicy tikkas, sauces, and healthy grain rice bowls.",
    cuisine: "Rolls, Fast Food, Wraps",
    rating: 4.2,
    delivery_time: "20-25 mins",
    price_for_two: 260,
    address: "Hinjewadi Phase 1, Near Blue Ridge",
    city: "Pune",
    image_url: "https://images.unsplash.com/photo-1626777552726-4a6b54c97e46?auto=format&fit=crop&w=800&q=80",
    featured: false,
    pure_veg: false,
    phone: "020-66778899",
    dishes: [
      { name: "Double Egg Double Chicken Roll", description: "Layered flaky paratha rolled with two fried eggs, spiced juicy chicken chunks, and onions.", price: 180, is_veg: false, category: "Rolls", image_url: "https://images.unsplash.com/photo-1626777552726-4a6b54c97e46?auto=format&fit=crop&w=600&q=80" },
      { name: "Paneer Tikka Kathi Roll", description: "Tandoori paneer cubes wrapped in a mint chutney-brushed whole wheat paratha.", price: 150, is_veg: true, category: "Rolls", image_url: "https://images.unsplash.com/photo-1606491956689-2ea866880c84?auto=format&fit=crop&w=600&q=80" },
      { name: "Chicken Teriyaki Rice Bowl", description: "Steamed jasmine rice topped with grilled chicken glazed in sweet & savory teriyaki sauce.", price: 220, is_veg: false, category: "Bowls", image_url: "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=600&q=80" }
    ]
  }
]

restaurants_data.each do |r_data|
  dishes = r_data.delete(:dishes)
  restaurant = Restaurant.find_or_initialize_by(name: r_data[:name])
  restaurant.update!(r_data)

  dishes.each do |d_data|
    product = restaurant.products.find_or_initialize_by(name: d_data[:name])
    product.update!(d_data.merge(restaurant: restaurant, available: true))
  end
end

# 3. Create a realistic sample past order for the customer user to demonstrate the tracking and receipt features
if customer_user && customer_user.orders.empty?
  first_restaurant = Restaurant.first
  if first_restaurant && first_restaurant.products.any?
    sample_order = Order.create!(
      user: customer_user,
      restaurant: first_restaurant,
      restaurant_id: first_restaurant.id,
      restru_id: first_restaurant.id,
      subtotal: 530,
      delivery_fee: 0,
      tax: 27,
      discount: 0,
      total: 557,
      order_status: "preparing",
      payment_status: "paid",
      payment_method: "Demo UPI (GooglePay)",
      payment_ref: "DEMO-UPI-774921",
      delivery_address: customer_user.address,
      contact_phone: customer_user.phone,
      customer_name: customer_user.name,
      notes: "Please provide extra green chutney"
    )

    p1 = first_restaurant.products.first
    p2 = first_restaurant.products.second
    sample_order.items.create!(product: p1, quantity: 1, price: p1.price) if p1
    sample_order.items.create!(product: p2, quantity: 1, price: p2.price) if p2
  end
end

puts "== Seed complete! Created #{Restaurant.count} restaurants and #{Product.count} dishes =="
