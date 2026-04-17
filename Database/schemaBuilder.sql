CREATE DATABASE VORTX_GameStore;
GO;
USE VORTX_GameStore;


CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    Username VARCHAR(50) NOT NULL UNIQUE,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE NULL,
    Country VARCHAR(50) NULL,
    Role VARCHAR(20) NOT NULL DEFAULT 'user'
        CHECK (Role IN ('user', 'admin')),
    AccountCreatedDate DATETIME DEFAULT GETDATE(),
    LastLoginDate DATETIME NULL,
    IsActive BIT DEFAULT 1,
    FirebaseUID VARCHAR(128) NOT NULL UNIQUE
);


CREATE TABLE Publishers (
    PublisherID INT PRIMARY KEY IDENTITY(1,1),
    PublisherName VARCHAR(100) NOT NULL UNIQUE,
    Description VARCHAR(MAX) NULL,
    Country VARCHAR(50) NOT NULL,
    FoundedYear INT NULL,
    CreatedDate DATETIME DEFAULT GETDATE(),
    IsActive BIT DEFAULT 1
);

CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName VARCHAR(50) NOT NULL UNIQUE,
    Description VARCHAR(500) NULL,
    IconPath VARCHAR(255) NULL,
    CreatedDate DATETIME DEFAULT GETDATE(),
    IsActive BIT DEFAULT 1
);



CREATE TABLE Games (
    GameID INT PRIMARY KEY IDENTITY(1,1),
    GameTitle VARCHAR(200) NOT NULL,
    Description VARCHAR(MAX) NULL,
    PublisherID INT NOT NULL,
    ReleaseDate DATE NULL,
    Price DECIMAL(10,2) NOT NULL,
    DiscountPercentage DECIMAL(5,2) DEFAULT 0,
    FinalPrice DECIMAL(10,2) NOT NULL,
    AgeRating VARCHAR(10) NULL,
    ThumbnailPath VARCHAR(255) NULL,
    CoverImagePath VARCHAR(255) NULL,
    TrailerURL VARCHAR(500) NULL,
    SystemRequirements VARCHAR(MAX) NULL,
    FileSize VARCHAR(50) NOT NULL,
    AverageRating DECIMAL(3,2) DEFAULT 0,
    TotalReviews INT DEFAULT 0,
    TotalSales INT DEFAULT 0,
    IsFeatured BIT DEFAULT 0,
    IsActive BIT DEFAULT 1,
    CreatedDate DATETIME DEFAULT GETDATE(),

    FOREIGN KEY (PublisherID) 
        REFERENCES Publishers(PublisherID)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);


CREATE TABLE GameCategories (
    GameCategoryID INT PRIMARY KEY IDENTITY(1,1),
    GameID INT NOT NULL,
    CategoryID INT NOT NULL,

    FOREIGN KEY (GameID) 
        REFERENCES Games(GameID)
        ON UPDATE NO ACTION
        ON DELETE CASCADE,

    FOREIGN KEY (CategoryID) 
        REFERENCES Categories(CategoryID)
        ON UPDATE NO ACTION
        ON DELETE CASCADE
);


CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    OrderDate DATETIME DEFAULT GETDATE(),
    TotalAmount DECIMAL(10,2) NOT NULL,
    PaymentMethod VARCHAR(50) NOT NULL,
    PaymentStatus VARCHAR(20) NOT NULL,
    TransactionID VARCHAR(100) NOT NULL,
    BillingAddress VARCHAR(MAX) NOT NULL,
    CreatedDate DATETIME DEFAULT GETDATE(),

    FOREIGN KEY (UserID) 
        REFERENCES Users(UserID)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT NOT NULL,
    GameID INT NOT NULL,
    PurchasePrice DECIMAL(10,2) NOT NULL,
    Quantity INT DEFAULT 1 NOT NULL,
    Subtotal DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (OrderID) 
        REFERENCES Orders(OrderID)
        ON UPDATE NO ACTION
        ON DELETE CASCADE,

    FOREIGN KEY (GameID) 
        REFERENCES Games(GameID)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE Reviews (
    ReviewID INT PRIMARY KEY IDENTITY(1,1),
    GameID INT NOT NULL,
    UserID INT NOT NULL,
    Rating INT NOT NULL,
    ReviewText VARCHAR(MAX) NULL,
    ReviewDate DATETIME DEFAULT GETDATE(),

    FOREIGN KEY (GameID) 
        REFERENCES Games(GameID)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,

    FOREIGN KEY (UserID) 
        REFERENCES Users(UserID)
        ON UPDATE NO ACTION
        ON DELETE CASCADE
);


CREATE TABLE UserLibrary (
    LibraryID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    GameID INT NOT NULL,
    PurchaseDate DATETIME DEFAULT GETDATE(),
    OrderID INT,

    FOREIGN KEY (UserID) 
        REFERENCES Users(UserID)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,

    FOREIGN KEY (GameID) 
        REFERENCES Games(GameID)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,

    FOREIGN KEY (OrderID) 
        REFERENCES Orders(OrderID)
        ON UPDATE NO ACTION
        ON DELETE CASCADE
);

CREATE TABLE Wishlist (
    WishlistID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    GameID INT NOT NULL,

    FOREIGN KEY (UserID) 
        REFERENCES Users(UserID)
        ON UPDATE NO ACTION
        ON DELETE CASCADE,

    FOREIGN KEY (GameID) 
        REFERENCES Games(GameID)
        ON UPDATE NO ACTION
        ON DELETE CASCADE
);


CREATE TABLE GameImages (
    ImageID INT PRIMARY KEY IDENTITY(1,1),
    GameID INT NOT NULL,
    ImagePath VARCHAR(255) NOT NULL,
    ImageType VARCHAR(50) NULL,
    DisplayOrder INT DEFAULT 0,
    UploadedDate DATETIME DEFAULT GETDATE(),

    FOREIGN KEY (GameID) 
        REFERENCES Games(GameID)
        ON UPDATE NO ACTION
        ON DELETE CASCADE
);
