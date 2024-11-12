# E-Commerce Web Application

## Overview
This project is a fully functional e-commerce web application built with Flask, SQLAlchemy, and Bootstrap, providing a responsive and dynamic user interface. It features an intuitive product catalog, secure user authentication, an interactive shopping cart, and an admin panel for managing products and orders.

## Key Features & Flask Components

### Product Catalog Display
- The homepage displays a product catalog with images, descriptions, and prices.
- Products are retrieved from the database using SQLAlchemy and displayed in a responsive grid layout using Bootstrap.
- Each product has an "Add to Cart" option, allowing customers to specify quantities and add products to their cart.

### User Authentication
- Users can log in as either **admin** or **customer**, with different views and access permissions for each role.
- User credentials are stored securely using password hashing (Werkzeug).
- Flask sessions manage login states and user sessions.

### Admin Panel for Product Management
- Admin users can add, edit, and delete products.
- Admin-specific routes are protected with the `admin_required` decorator to restrict access.
- Admins can manage product details, including uploading product images and updating inventory.

### Shopping Cart Functionality
- Users can add products to the cart, with quantity and total cost details displayed.
- The cart is stored in the user's session, allowing them to continue shopping or proceed to checkout.

### Checkout & Order Processing
- The checkout page allows users to review their cart and make payments using a mock payment processor.
- Upon successful payment, order details are saved to the database as an order record.
- Users receive a confirmation message upon successful order submission.

### Product Image Upload
- Admins can upload product images, which are saved to the server and associated with the respective products.
- Images are served from the `/static/uploads/` folder and displayed alongside product details.

### Responsive Design
- The app is responsive, with product images displayed in a grid layout that adjusts according to screen size.
- Bootstrap is used to ensure a consistent and mobile-friendly UI.

### Error Handling & Flash Messages
- The application provides feedback using flash messages for successful actions (e.g., adding products, successful login) and errors (e.g., invalid login credentials, insufficient stock).
- Custom error pages handle 404 errors gracefully.

### Database Integration (SQLAlchemy)
- SQLAlchemy is used for managing and querying the database, including tables for `Product`, `User`, and `Order`.
- Relationships between products and orders are managed using foreign keys.

### File Upload Management
- Supports uploading and validating images with allowed extensions like PNG, JPG, and JPEG.
- Product images are stored in a dedicated folder (`static/uploads/`) and served dynamically using Flask’s `url_for()` function.

## Technologies Used
- **Flask** for the web framework
- **SQLAlchemy** for database interaction
- **Jinja2** for templating engine
- **Werkzeug** for secure password handling
- **Bootstrap** for frontend styling
- **Flask-SQLAlchemy** for managing database models

## Demonstration and Access
The application can be hosted on a live server (e.g., **Heroku**, **AWS**, or local deployment), where users can register, log in, browse products, manage the shopping cart, and complete purchases.

## Future Enhancements

1. **User Profiles and Order History**
   - Enable users to create detailed profiles, track past orders, and view order history.
   - Allow for address management and saved payment methods for quicker checkout.

2. **Enhanced Admin Dashboard**
   - Include sales analytics, product performance insights, and customer demographics.
   - Implement bulk product upload capabilities for easier inventory management.

3. **Product Reviews and Ratings**
   - Allow customers to leave reviews and ratings for purchased products.
   - Display average ratings and review counts on product pages to improve customer trust.

4. **Advanced Search and Filtering**
   - Introduce a robust search feature with filters for categories, price range, ratings, and brands.
   - Include auto-suggestions and sorting options (e.g., price, popularity) for better user experience.

5. **Wishlist and Save for Later**
   - Allow users to add products to a wishlist or save items for future purchase.
   - Notify users of price changes or availability for wishlist items.

