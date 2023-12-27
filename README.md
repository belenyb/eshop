# Eshop: A Flutter E-Commerce App

An online shopping app connected to a public API.

<img src="assets/docs/cover.png" alt="App Logo" width="400">

## Overview

This Flutter app is an e-commerce application that enables users to browse and shop for products from the [FakeStore API](https://fakestoreapi.com/). The app features a user authentication system, product listings, a shopping cart, and various UI elements to enhance the user experience.

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/belenyb/eshop.git

2. Navigate to the project directory:
   ```bash
    cd eshop

3. Install dependencies:
   ```bash
    flutter pub get

4. Run the app:
   ```bash
    flutter run

## Features

### Splash Screen
The splash screen uses a Stateful Widget and AnimatedBuilder to create a loading effect.

<img src="assets/docs/splashscreen.gif" width=200 height=auto alt="Splash screen" />

### Login
User authentication is implemented via the FakeStore API login service. Form validation is included.

###### Test credentials:
```
username: "johnd"
password: "m38rmF$"
```

<img src="assets/docs/login.gif" width=200 height=auto alt="Login screen" />

### Home
The home screen starts with a featured product randomly selected using the `getFeaturedProduct()` function inside the `app_provider.dart` file. This function utilizes a random number generator from the [dart:math](https://api.dart.dev/stable/3.2.3/dart-math/dart-math-library.html) library. Featured products use hero animation for a smooth transition between screens. The main page also contains a categories filter and a short list of products that can be expanded by clicking on the `SEE ALL` button.

<img src="assets/docs/home.gif" width=200 height=auto alt="Home screen" />

### Profile drawer
By clicking on the profile icon in the app bar, users can access the profile drawer. This information is also obtained from the public API.

<img src="assets/docs/profile.png" width=200 height=auto alt="Profile drawer" />

### Product detail
The screen includes additional product information and provides an "Add to Cart" functionality. When the user adds an item to the cart, a `View Cart` button is provided as a shortcut. This screen also includes rating stars using the [flutter_rating_bar](https://pub.dev/packages/flutter_rating_bar) package.

<img src="assets/docs/product.gif" width=200 height=auto alt="Product screen" />

### Cart
Add, remove, update, or empty all items using the [provider](https://pub.dev/packages/provider) package. The shopping cart employs the dismissible effect for easy item removal.

<img src="assets/docs/cart.gif" width=200 height=auto alt="Cart screen" />

### End of app
The conclusion of the app is marked by the presence of the `Buy now` button. At this point, you have the choice to either go back to the cart or start fresh by using the `Restart` button. This button clears all app data, giving you a clean slate for further testing.

<img src="assets/docs/buynow.png" width=200 height=auto alt="End of app dialog" />
