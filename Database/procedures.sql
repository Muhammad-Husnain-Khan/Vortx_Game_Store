USE VORTX_GameStore;
GO

-- =============================================
-- F-01: Register a New User
-- =============================================
CREATE OR ALTER PROCEDURE sp_RegisterUser
    @Username VARCHAR(50),
    @Email VARCHAR(100),
    @Password VARCHAR(255),
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @DateOfBirth DATE,
    @Country VARCHAR(50),
    @FirebaseUID VARCHAR(128)
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO Users (Username, Email, Password, FirstName, LastName, DateOfBirth, Country, IsActive, FirebaseUID)
    VALUES (@Username, @Email, @Password, @FirstName, @LastName, @DateOfBirth, @Country, 1, @FirebaseUID);
    SELECT SCOPE_IDENTITY() AS NewUserID;
END
GO

-- =============================================
-- Login User (find by FirebaseUID)
-- =============================================
CREATE OR ALTER PROCEDURE sp_LoginUser
    @FirebaseUID VARCHAR(128)
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE Users SET LastLoginDate = GETDATE() WHERE FirebaseUID = @FirebaseUID;
    SELECT UserID, Username, Email, FirstName, LastName, DateOfBirth, Country, Role, 
           AccountCreatedDate, LastLoginDate, IsActive, FirebaseUID
    FROM Users 
    WHERE FirebaseUID = @FirebaseUID AND IsActive = 1;
END
GO

-- =============================================
-- Get User by FirebaseUID
-- =============================================
CREATE OR ALTER PROCEDURE sp_GetUserByFirebaseUID
    @FirebaseUID VARCHAR(128)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT UserID, Username, Email, FirstName, LastName, DateOfBirth, Country, Role, 
           AccountCreatedDate, LastLoginDate, IsActive, FirebaseUID
    FROM Users 
    WHERE FirebaseUID = @FirebaseUID;
END
GO

-- =============================================
-- F-02: Add a New Game to the Store
-- =============================================
CREATE OR ALTER PROCEDURE sp_AddGame
    @GameTitle VARCHAR(200),
    @Description VARCHAR(MAX),
    @PublisherID INT,
    @ReleaseDate DATE,
    @Price DECIMAL(10,2),
    @DiscountPercentage DECIMAL(5,2),
    @AgeRating VARCHAR(10),
    @FileSize VARCHAR(50),
    @IsFeatured BIT,
    @ThumbnailPath VARCHAR(255) = NULL,
    @CoverImagePath VARCHAR(255) = NULL,
    @TrailerURL VARCHAR(500) = NULL,
    @SystemRequirements VARCHAR(MAX) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @FinalPrice DECIMAL(10,2) = @Price * (1 - @DiscountPercentage / 100);
    INSERT INTO Games (GameTitle, Description, PublisherID, ReleaseDate, Price, DiscountPercentage, FinalPrice, AgeRating, FileSize, IsFeatured, IsActive, ThumbnailPath, CoverImagePath, TrailerURL, SystemRequirements)
    VALUES (@GameTitle, @Description, @PublisherID, @ReleaseDate, @Price, @DiscountPercentage, @FinalPrice, @AgeRating, @FileSize, @IsFeatured, 0, @ThumbnailPath, @CoverImagePath, @TrailerURL, @SystemRequirements);
    SELECT SCOPE_IDENTITY() AS NewGameID;
END
GO

-- =============================================
-- F-03: Browse All Active Games
-- =============================================
CREATE OR ALTER PROCEDURE sp_BrowseActiveGames
AS
BEGIN
    SET NOCOUNT ON;
    SELECT g.GameID, g.GameTitle, g.Description, p.PublisherName, g.Price, g.DiscountPercentage,
           g.FinalPrice, g.AverageRating, g.TotalSales, g.TotalReviews, g.ThumbnailPath, 
           g.CoverImagePath, g.IsFeatured, g.ReleaseDate, g.AgeRating, g.FileSize
    FROM Games g
    JOIN Publishers p ON g.PublisherID = p.PublisherID
    WHERE g.IsActive = 1
    ORDER BY g.GameTitle ASC;
END
GO

-- =============================================
-- Featured Games for Homepage
-- =============================================
CREATE OR ALTER PROCEDURE sp_GetFeaturedGames
AS
BEGIN
    SET NOCOUNT ON;
    SELECT g.GameID, g.GameTitle, g.Description, p.PublisherName, g.Price, g.DiscountPercentage,
           g.FinalPrice, g.AverageRating, g.TotalSales, g.TotalReviews, g.ThumbnailPath, 
           g.CoverImagePath, g.IsFeatured, g.ReleaseDate
    FROM Games g
    JOIN Publishers p ON g.PublisherID = p.PublisherID
    WHERE g.IsActive = 1 AND g.IsFeatured = 1
    ORDER BY g.AverageRating DESC;
END
GO

-- =============================================
-- F-04: Search Games by Keyword
-- =============================================
CREATE OR ALTER PROCEDURE sp_SearchGamesByTitle
    @Keyword VARCHAR(200)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT g.GameID, g.GameTitle, g.Description, p.PublisherName, g.Price, g.DiscountPercentage,
           g.FinalPrice, g.AverageRating, g.TotalSales, g.TotalReviews, g.ThumbnailPath, 
           g.CoverImagePath, g.ReleaseDate
    FROM Games g
    JOIN Publishers p ON g.PublisherID = p.PublisherID
    WHERE g.GameTitle LIKE '%' + @Keyword + '%'
      AND g.IsActive = 1
    ORDER BY g.AverageRating DESC;
END
GO

-- =============================================
-- F-05: Apply a Discount to a Game
-- =============================================
CREATE OR ALTER PROCEDURE sp_ApplyDiscount
    @GameID INT,
    @DiscountPercentage DECIMAL(5,2)
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE Games
    SET DiscountPercentage = @DiscountPercentage,
        FinalPrice = Price * (1 - @DiscountPercentage / 100)
    WHERE GameID = @GameID;
END
GO

-- =============================================
-- F-06: Remove a Game from the Store
-- =============================================
CREATE OR ALTER PROCEDURE sp_RemoveGame
    @GameID INT,
    @HardDelete BIT = 0
AS
BEGIN
    SET NOCOUNT ON;
    IF @HardDelete = 0
    BEGIN
        UPDATE Games SET IsActive = 0 WHERE GameID = @GameID;
    END
    ELSE
    BEGIN
        DELETE FROM Games
        WHERE GameID = @GameID
          AND GameID NOT IN (SELECT DISTINCT GameID FROM OrderDetails);
    END
END
GO

-- =============================================
-- F-07: Place an Order
-- =============================================
CREATE OR ALTER PROCEDURE sp_PlaceOrder
    @UserID INT,
    @TotalAmount DECIMAL(10,2),
    @PaymentMethod VARCHAR(50),
    @PaymentStatus VARCHAR(20),
    @TransactionID VARCHAR(100),
    @BillingAddress VARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO Orders (UserID, TotalAmount, PaymentMethod, PaymentStatus, TransactionID, BillingAddress)
    VALUES (@UserID, @TotalAmount, @PaymentMethod, @PaymentStatus, @TransactionID, @BillingAddress);
    SELECT SCOPE_IDENTITY() AS NewOrderID;
END
GO

CREATE OR ALTER PROCEDURE sp_AddOrderDetail
    @OrderID INT,
    @GameID INT,
    @PurchasePrice DECIMAL(10,2),
    @Quantity INT
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO OrderDetails (OrderID, GameID, PurchasePrice, Quantity, Subtotal)
    VALUES (@OrderID, @GameID, @PurchasePrice, @Quantity, @PurchasePrice * @Quantity);
END
GO

-- =============================================
-- Add to User Library
-- =============================================
CREATE OR ALTER PROCEDURE sp_AddToLibrary
    @UserID INT,
    @GameID INT,
    @OrderID INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM UserLibrary WHERE UserID = @UserID AND GameID = @GameID)
    BEGIN
        INSERT INTO UserLibrary (UserID, GameID, OrderID)
        VALUES (@UserID, @GameID, @OrderID);
    END
END
GO

-- =============================================
-- Check if user owns a game
-- =============================================
CREATE OR ALTER PROCEDURE sp_CheckOwnership
    @UserID INT,
    @GameID INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT COUNT(*) AS Owned FROM UserLibrary WHERE UserID = @UserID AND GameID = @GameID;
END
GO

-- =============================================
-- F-08: View Total Revenue per Game
-- =============================================
CREATE OR ALTER PROCEDURE sp_GetRevenuePerGame
AS
BEGIN
    SET NOCOUNT ON;
    SELECT g.GameID, g.GameTitle,
           COUNT(od.OrderDetailID) AS TotalOrders,
           ISNULL(SUM(od.Subtotal), 0) AS TotalRevenue,
           ISNULL(AVG(od.PurchasePrice), 0) AS AvgSalePrice
    FROM Games g
    LEFT JOIN OrderDetails od ON g.GameID = od.GameID
    GROUP BY g.GameID, g.GameTitle
    ORDER BY TotalRevenue DESC;
END
GO

-- =============================================
-- F-09: List Users and Order Counts
-- =============================================
CREATE OR ALTER PROCEDURE sp_GetUsersWithOrderCount
AS
BEGIN
    SET NOCOUNT ON;
    SELECT u.UserID, u.Username, u.Email, u.FirstName, u.LastName, u.Role, u.IsActive,
           u.AccountCreatedDate, u.LastLoginDate, u.Country,
           COUNT(o.OrderID) AS TotalOrders
    FROM Orders o
    RIGHT JOIN Users u ON o.UserID = u.UserID
    GROUP BY u.UserID, u.Username, u.Email, u.FirstName, u.LastName, u.Role, u.IsActive,
             u.AccountCreatedDate, u.LastLoginDate, u.Country
    ORDER BY TotalOrders DESC;
END
GO

-- =============================================
-- F-10: Publisher and Game Audit
-- =============================================
CREATE OR ALTER PROCEDURE sp_AuditPublishersAndGames
AS
BEGIN
    SET NOCOUNT ON;
    SELECT p.PublisherName, g.GameTitle
    FROM Publishers p
    FULL OUTER JOIN Games g ON p.PublisherID = g.PublisherID
    WHERE p.PublisherID IS NULL OR g.GameID IS NULL;
END
GO

-- =============================================
-- F-11: Games Priced Above Average
-- =============================================
CREATE OR ALTER PROCEDURE sp_GetGamesAboveAveragePrice
AS
BEGIN
    SET NOCOUNT ON;
    SELECT g.GameID, g.GameTitle, g.FinalPrice, p.PublisherName, g.ThumbnailPath
    FROM Games g
    JOIN Publishers p ON g.PublisherID = p.PublisherID
    WHERE g.FinalPrice > (SELECT AVG(FinalPrice) FROM Games WHERE IsActive = 1)
      AND g.IsActive = 1
    ORDER BY g.FinalPrice DESC;
END
GO

-- =============================================
-- F-12: Combined Account List (FIXED - uses Role column)
-- =============================================
CREATE OR ALTER PROCEDURE sp_GetAllAccountsList
AS
BEGIN
    SET NOCOUNT ON;
    SELECT UserID, Username, Email, FirstName, LastName, Role AS AccountType, 
           IsActive, AccountCreatedDate, LastLoginDate
    FROM Users
    WHERE IsActive = 1
    ORDER BY Role DESC, Username ASC;
END
GO

-- =============================================
-- F-13: Purchased and Wishlisted Games
-- =============================================
CREATE OR ALTER PROCEDURE sp_GetGamesBothPurchasedAndWishlisted
AS
BEGIN
    SET NOCOUNT ON;
    SELECT g.GameID, g.GameTitle, g.FinalPrice, g.ThumbnailPath
    FROM Games g
    WHERE g.GameID IN (
        SELECT GameID FROM UserLibrary
        INTERSECT
        SELECT GameID FROM Wishlist
    );
END
GO

-- =============================================
-- F-14: Wishlisted but Not Purchased
-- =============================================
CREATE OR ALTER PROCEDURE sp_GetWishlistedNotPurchased
AS
BEGIN
    SET NOCOUNT ON;
    SELECT g.GameID, g.GameTitle, g.FinalPrice, g.AverageRating, g.ThumbnailPath
    FROM Games g
    WHERE g.GameID IN (
        SELECT GameID FROM Wishlist
        EXCEPT
        SELECT GameID FROM UserLibrary
    )
    ORDER BY g.AverageRating DESC;
END
GO

-- =============================================
-- F-15: Top-Rated Games
-- =============================================
CREATE OR ALTER PROCEDURE sp_GetTopRatedGames
    @MinReviews INT = 1
AS
BEGIN
    SET NOCOUNT ON;
    SELECT g.GameID, g.GameTitle, g.ThumbnailPath,
           COUNT(r.ReviewID) AS TotalReviews,
           AVG(CAST(r.Rating AS DECIMAL(3,2))) AS AvgRating,
           MAX(r.Rating) AS BestRating,
           MIN(r.Rating) AS WorstRating
    FROM Games g
    JOIN Reviews r ON g.GameID = r.GameID
    GROUP BY g.GameID, g.GameTitle, g.ThumbnailPath
    HAVING COUNT(r.ReviewID) >= @MinReviews
    ORDER BY AvgRating DESC;
END
GO

-- =============================================
-- F-16: User Purchase History
-- =============================================
CREATE OR ALTER PROCEDURE sp_GetUserPurchaseHistory
    @UserID INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT o.OrderID, o.OrderDate, g.GameTitle, g.ThumbnailPath,
           od.PurchasePrice, od.Quantity, od.Subtotal,
           o.PaymentMethod, o.PaymentStatus, o.TotalAmount
    FROM Orders o
    JOIN OrderDetails od ON o.OrderID = od.OrderID
    JOIN Games g ON od.GameID = g.GameID
    WHERE o.UserID = @UserID
    ORDER BY o.OrderDate DESC;
END
GO

-- =============================================
-- F-17: Submit or Update a Review
-- =============================================
CREATE OR ALTER PROCEDURE sp_SubmitReview
    @GameID INT,
    @UserID INT,
    @Rating INT,
    @ReviewText VARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;
    
    IF EXISTS (SELECT 1 FROM Reviews WHERE GameID = @GameID AND UserID = @UserID)
    BEGIN
        UPDATE Reviews SET Rating = @Rating, ReviewText = @ReviewText, ReviewDate = GETDATE()
        WHERE GameID = @GameID AND UserID = @UserID;
    END
    ELSE
    BEGIN
        INSERT INTO Reviews (GameID, UserID, Rating, ReviewText)
        VALUES (@GameID, @UserID, @Rating, @ReviewText);
    END

    UPDATE Games
    SET AverageRating = (SELECT AVG(CAST(Rating AS DECIMAL(3,2))) FROM Reviews WHERE GameID = @GameID),
        TotalReviews  = (SELECT COUNT(*) FROM Reviews WHERE GameID = @GameID)
    WHERE GameID = @GameID;
END
GO

-- =============================================
-- F-18: Add or Remove from Wishlist
-- =============================================
CREATE OR ALTER PROCEDURE sp_ManageWishlist
    @UserID INT,
    @GameID INT,
    @Action VARCHAR(10)
AS
BEGIN
    SET NOCOUNT ON;
    IF @Action = 'ADD'
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM Wishlist WHERE UserID = @UserID AND GameID = @GameID)
        BEGIN
            INSERT INTO Wishlist (UserID, GameID) VALUES (@UserID, @GameID);
        END
    END
    ELSE IF @Action = 'REMOVE'
    BEGIN
        DELETE FROM Wishlist WHERE UserID = @UserID AND GameID = @GameID;
    END
END
GO

-- =============================================
-- Get User Wishlist
-- =============================================
CREATE OR ALTER PROCEDURE sp_GetUserWishlist
    @UserID INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT w.WishlistID, g.GameID, g.GameTitle, g.FinalPrice, g.Price, g.DiscountPercentage,
           g.AverageRating, g.ThumbnailPath, g.CoverImagePath, p.PublisherName
    FROM Wishlist w
    JOIN Games g ON w.GameID = g.GameID
    JOIN Publishers p ON g.PublisherID = p.PublisherID
    WHERE w.UserID = @UserID AND g.IsActive = 1;
END
GO

-- =============================================
-- Get User Library
-- =============================================
CREATE OR ALTER PROCEDURE sp_GetUserLibrary
    @UserID INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT ul.LibraryID, g.GameID, g.GameTitle, g.ThumbnailPath, g.CoverImagePath,
           p.PublisherName, ul.PurchaseDate, ul.OrderID
    FROM UserLibrary ul
    JOIN Games g ON ul.GameID = g.GameID
    JOIN Publishers p ON g.PublisherID = p.PublisherID
    WHERE ul.UserID = @UserID;
END
GO

-- =============================================
-- F-19: Category-Based Game Browsing
-- =============================================
CREATE OR ALTER PROCEDURE sp_BrowseGamesByCategory
    @CategoryName VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT g.GameID, g.GameTitle, g.Description, g.FinalPrice, g.Price, g.DiscountPercentage,
           g.AverageRating, g.TotalReviews, g.TotalSales,
           p.PublisherName, c.CategoryName, g.ThumbnailPath, g.CoverImagePath, g.ReleaseDate
    FROM Games g
    JOIN GameCategories gc ON g.GameID = gc.GameID
    JOIN Categories c ON gc.CategoryID = c.CategoryID
    JOIN Publishers p ON g.PublisherID = p.PublisherID
    WHERE c.CategoryName = @CategoryName
      AND g.IsActive = 1
    ORDER BY g.AverageRating DESC, g.FinalPrice ASC;
END
GO

-- =============================================
-- F-20: Monthly Sales Report
-- =============================================
CREATE OR ALTER PROCEDURE sp_GetMonthlySalesReport
AS
BEGIN
    SET NOCOUNT ON;
    SELECT YEAR(o.OrderDate) AS SaleYear,
           MONTH(o.OrderDate) AS SaleMonth,
           COUNT(DISTINCT o.OrderID) AS TotalOrders,
           SUM(od.Quantity) AS UnitsSold,
           SUM(od.Subtotal) AS TotalRevenue
    FROM Orders o
    JOIN OrderDetails od ON o.OrderID = od.OrderID
    WHERE o.PaymentStatus = 'Completed'
    GROUP BY YEAR(o.OrderDate), MONTH(o.OrderDate)
    ORDER BY SaleYear DESC, SaleMonth DESC;
END
GO

-- =============================================
-- Get Full Game Details (for detail page)
-- =============================================
CREATE OR ALTER PROCEDURE sp_GetGameDetails
    @GameID INT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Game info
    SELECT g.*, p.PublisherName, p.Country AS PublisherCountry
    FROM Games g
    JOIN Publishers p ON g.PublisherID = p.PublisherID
    WHERE g.GameID = @GameID;
    
    -- Game categories
    SELECT c.CategoryID, c.CategoryName
    FROM GameCategories gc
    JOIN Categories c ON gc.CategoryID = c.CategoryID
    WHERE gc.GameID = @GameID;
    
    -- Game images
    SELECT ImageID, ImagePath, ImageType, DisplayOrder
    FROM GameImages
    WHERE GameID = @GameID
    ORDER BY DisplayOrder;
    
    -- Game reviews
    SELECT r.ReviewID, r.Rating, r.ReviewText, r.ReviewDate,
           u.Username, u.UserID
    FROM Reviews r
    JOIN Users u ON r.UserID = u.UserID
    WHERE r.GameID = @GameID
    ORDER BY r.ReviewDate DESC;
END
GO

-- =============================================
-- Get All Categories
-- =============================================
CREATE OR ALTER PROCEDURE sp_GetAllCategories
AS
BEGIN
    SET NOCOUNT ON;
    SELECT CategoryID, CategoryName, Description, IconPath
    FROM Categories
    WHERE IsActive = 1
    ORDER BY CategoryName;
END
GO

-- =============================================
-- Admin: Get All Games (including inactive)
-- =============================================
CREATE OR ALTER PROCEDURE sp_AdminGetAllGames
AS
BEGIN
    SET NOCOUNT ON;
    SELECT g.GameID, g.GameTitle, p.PublisherName, g.Price, g.DiscountPercentage,
           g.FinalPrice, g.AverageRating, g.TotalSales, g.TotalReviews,
           g.IsFeatured, g.IsActive, g.CreatedDate, g.ThumbnailPath
    FROM Games g
    JOIN Publishers p ON g.PublisherID = p.PublisherID
    ORDER BY g.CreatedDate DESC;
END
GO

-- =============================================
-- Admin: Toggle Game Active Status
-- =============================================
CREATE OR ALTER PROCEDURE sp_AdminToggleGameActive
    @GameID INT,
    @IsActive BIT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE Games SET IsActive = @IsActive WHERE GameID = @GameID;
END
GO

-- =============================================
-- Admin: Toggle Game Featured
-- =============================================
CREATE OR ALTER PROCEDURE sp_AdminToggleFeatured
    @GameID INT,
    @IsFeatured BIT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE Games SET IsFeatured = @IsFeatured WHERE GameID = @GameID;
END
GO

-- =============================================
-- Admin: Toggle User Active Status
-- =============================================
CREATE OR ALTER PROCEDURE sp_AdminToggleUserActive
    @UserID INT,
    @IsActive BIT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE Users SET IsActive = @IsActive WHERE UserID = @UserID;
END
GO

-- =============================================
-- Admin: Dashboard Stats
-- =============================================
CREATE OR ALTER PROCEDURE sp_AdminGetDashboardStats
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        (SELECT ISNULL(SUM(TotalAmount), 0) FROM Orders WHERE PaymentStatus = 'Completed') AS TotalSales,
        (SELECT COUNT(*) FROM Users WHERE Role = 'user' AND IsActive = 1) AS TotalUsers,
        (SELECT COUNT(*) FROM Users WHERE Role = 'user' AND AccountCreatedDate >= DATEADD(DAY, -30, GETDATE())) AS NewUsers,
        (SELECT COUNT(*) FROM Games WHERE IsActive = 1) AS ActiveGames,
        (SELECT COUNT(*) FROM Orders WHERE PaymentStatus = 'Pending') AS PendingOrders,
        (SELECT COUNT(*) FROM Orders WHERE PaymentStatus = 'Completed') AS CompletedOrders;
END
GO

-- =============================================
-- Get All Publishers
-- =============================================
CREATE OR ALTER PROCEDURE sp_GetAllPublishers
AS
BEGIN
    SET NOCOUNT ON;
    SELECT PublisherID, PublisherName, Description, Country, FoundedYear, IsActive
    FROM Publishers
    WHERE IsActive = 1
    ORDER BY PublisherName;
END
GO

PRINT 'All stored procedures created/updated successfully!';
GO
