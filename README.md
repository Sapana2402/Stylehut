

https://github.com/user-attachments/assets/785c4fb2-9b9d-4024-ae8e-ca29b56f6edf

iOS Development Concepts & Technologies Used in StyleHut

#### 1. Swift Programming Language
•  Swift 5.0 with modern language features
•  Async/Await for asynchronous programming
•  Closures and completion handlers
•  Extensions for code organization
•  Protocols and Delegates implementation
•  Error Handling with do-catch blocks

#### 2. Architecture & Design Patterns

#### MVVM Architecture (Model-View-ViewModel)
•  Models: ProductModel, CartModel, WishListModel, ProductDetailsModel
•  ViewModels: ProductViewModel, CartViewModels, WishListViewModel, CategoriesViewModel
•  Views: Storyboard-based UI with custom ViewControllers

#### Singleton Pattern
•  AuthManager.shared for authentication management
•  LoaderView.shared for global loading indicator
•  NetworkManager class methods

#### Delegation Pattern
•  UICollectionViewDelegate, UICollectionViewDataSource
•  UIScrollViewDelegate for auto-slider functionality

#### 3. UIKit Framework Components

#### Navigation & View Controllers
•  UIViewController base class implementation
•  UINavigationController for navigation stack
•  Segues for screen transitions with data passing
•  Storyboard interface design

#### Collection Views & Table Views
•  UICollectionView with custom layouts
•  UITableView for list-based interfaces
•  Custom Cells: ProductListCollectionViewCell, CartTableViewCell, WishListCollectionViewCell
•  XIB files for custom cell design
•  Flow Layout with custom sizing and spacing

#### UI Controls
•  UITextField with validation
•  UIButton with action handling
•  UIImageView with rounded corners and clipping
•  UILabel for text display
•  UIPageControl for pagination indicators
•  UIActivityIndicatorView for loading states

#### Auto Layout & Constraints
•  NSLayoutConstraint programmatic constraints
•  Interface Builder constraints
•  Dynamic height calculations for collection views

#### 4. Networking & API Integration

#### URLSession Framework
•  RESTful API consumption
•  JSON Parsing with Codable protocol
•  HTTP Methods: GET, POST requests
•  Authentication with Bearer tokens
•  Error Handling for network requests
•  Async/Await networking pattern

#### API Features
•  User registration and OTP verification
•  Product listing with pagination
•  Category and subcategory management
•  Cart and wishlist operations
•  Product search and filtering

#### 5. Data Management

#### UserDefaults
•  Token storage for authentication
•  User email persistence
•  Settings and preferences storage

#### Core Data Setup
•  .xcdatamodeld file configured (though not actively used in shown code)
•  Core Data stack preparation

#### Codable Protocol
•  JSON Serialization/Deserialization
•  Custom model structures for API responses
•  Type-safe data parsing

#### 6. Third-Party Libraries

#### Kingfisher Framework
•  Image Caching and loading from URLs
•  Animated GIF support (AnimatedImageView)
•  Memory Management for images
•  Placeholder and error handling

#### 7. User Interface & Experience

#### Custom UI Components
•  Rounded Corners with CALayer properties
•  Masked Corners for specific corner rounding
•  Shadow Effects and border styling
•  Custom Loading View with overlay

#### Auto-Sliding Banner
•  Timer-based automatic sliding
•  Page Control indicator
•  Manual Swipe detection with scroll view delegates
•  Infinite Scrolling simulation

#### Responsive Design
•  Dynamic Cell Sizing based on screen width
•  Collection View Flow Layout customization
•  Constraint-based responsive layouts

#### 8. Authentication & Security

#### Email Validation
•  Regular Expression (NSPredicate) validation
•  Real-time input validation

#### Token-Based Authentication
•  Authorization Headers for API requests

#### OTP Verification
•  Two-factor authentication implementation
•  Secure user verification process

#### 9. Advanced iOS Features

#### Safari Services
•  SFSafariViewController for in-app web browsing
•  Privacy Policy integration

#### Activity Indicators
•  Global Loading overlay system
•  Local Loading states for specific actions
•  User Interaction blocking during loading

#### Alert Controllers
•  UIAlertController for user notifications
•  Error Messaging system
•  Reusable alert components

#### 10. Code Organization & Best Practices

#### Feature-Based Architecture
•  Modular code organization by features
•  Separate folders for Authentication, ProductList, Cart, etc.
•  Clean Code principles

#### Constants Management
•  Centralized constants in Constants.swift
•  URL Configuration management
•  Reusable Identifiers for cells and segues

#### Memory Management
•  Weak References to prevent retain cycles
•  Proper Cleanup of timers and observers
•  ARC (Automatic Reference Counting) compliance

#### 11. Animation & Visual Effects
•  UIView Animations for smooth transitions
•  GIF Animation support with Kingfisher
•  Page Control animations
•  Collection View scroll animations
