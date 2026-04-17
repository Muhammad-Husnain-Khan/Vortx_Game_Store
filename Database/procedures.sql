
CREATE PROCEDURE sp_RegisterUser
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

CREATE PROCEDURE sp_AddGame
    @GameTitle VARCHAR(200),
    @Description VARCHAR(MAX),
    @PublisherID INT,
    @ReleaseDate DATE,
    @Price DECIMAL(10,2),
    @DiscountPercentage DECIMAL(5,2),
    @AgeRating VARCHAR(10),
    @FileSize VARCHAR(50),
    @IsFeatured BIT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @FinalPrice DECIMAL(10,2) = @Price * (1 - @DiscountPercentage / 100);
    INSERT INTO Games (GameTitle, Description, PublisherID, ReleaseDate, Price, DiscountPercentage, FinalPrice, AgeRating, FileSize, IsFeatured, IsActive)
    VALUES (@GameTitle, @Description, @PublisherID, @ReleaseDate, @Price, @DiscountPercentage, @FinalPrice, @AgeRating, @FileSize, @IsFeatured, 1);
    SELECT SCOPE_IDENTITY() AS NewGameID;
END
GO

CREATE PROCEDURE sp_BrowseActiveGames
AS
BEGIN
    SET NOCOUNT ON;
    SELECT g.GameID, g.GameTitle, p.PublisherName, g.FinalPrice, g.AverageRating, g.TotalSales
    FROM Games g
    JOIN Publishers p ON g.PublisherID = p.PublisherID
    WHERE g.IsActive = 1
    ORDER BY g.GameTitle ASC;
END
GO

CREATE PROCEDURE sp_SearchGamesByTitle
    @Keyword VARCHAR(200)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT GameID, GameTitle, FinalPrice, AverageRating
    FROM Games
    WHERE GameTitle LIKE '%' + @Keyword + '%'
      AND IsActive = 1
    ORDER BY AverageRating DESC;
END
GO

CREATE PROCEDURE sp_ApplyDiscount
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

CREATE PROCEDURE sp_RemoveGame
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

CREATE PROCEDURE sp_PlaceOrder
    @UserID INT,
    @TotalAmount DECIMAL(10,2),
    @PaymentMethod VARCHAR(50),
    @PaymentStatus VARCHAR(20),
    @TransactionID VARCHAR(100),
    @BillingAddress VARCHAR(MAX),
    @GameIDs VARCHAR(MAX),
    @Prices VARCHAR(MAX),
    @Quantities VARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO Orders (UserID, TotalAmount, PaymentMethod, PaymentStatus, TransactionID, BillingAddress)
    VALUES (@UserID, @TotalAmount, @PaymentMethod, @PaymentStatus, @TransactionID, @BillingAddress);
    SELECT SCOPE_IDENTITY() AS NewOrderID;
END
GO

CREATE PROCEDURE sp_AddOrderDetail
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

CREATE PROCEDURE sp_GetRevenuePerGame
AS
BEGIN
    SET NOCOUNT ON;
    SELECT g.GameTitle,
           COUNT(od.OrderDetailID) AS TotalOrders,
           SUM(od.Subtotal)        AS TotalRevenue,
           AVG(od.PurchasePrice)   AS AvgSalePrice
    FROM Games g
    LEFT JOIN OrderDetails od ON g.GameID = od.GameID
    GROUP BY g.GameID, g.GameTitle
    ORDER BY TotalRevenue DESC;
END
GO

CREATE PROCEDURE sp_GetUsersWithOrderCount
AS
BEGIN
    SET NOCOUNT ON;
    SELECT u.UserID, u.Username, u.Email,
           COUNT(o.OrderID) AS TotalOrders
    FROM Orders o
    RIGHT JOIN Users u ON o.UserID = u.UserID
    WHERE u.IsActive = 1
    GROUP BY u.UserID, u.Username, u.Email
    ORDER BY TotalOrders DESC;
END
GO

CREATE PROCEDURE sp_AuditPublishersAndGames
AS
BEGIN
    SET NOCOUNT ON;
    SELECT p.PublisherName, g.GameTitle
    FROM Publishers p
    FULL OUTER JOIN Games g ON p.PublisherID = g.PublisherID
    WHERE p.PublisherID IS NULL OR g.GameID IS NULL;
END
GO

CREATE PROCEDURE sp_GetGamesAboveAveragePrice
AS
BEGIN
    SET NOCOUNT ON;
    SELECT GameID, GameTitle, FinalPrice
    FROM Games
    WHERE FinalPrice > (SELECT AVG(FinalPrice) FROM Games WHERE IsActive = 1)
      AND IsActive = 1
    ORDER BY FinalPrice DESC;
END
GO

CREATE PROCEDURE sp_GetAllAccountsList
AS
BEGIN
    SET NOCOUNT ON;
    SELECT Username, Email, 'User' AS AccountType
    FROM Users
    WHERE IsActive = 1
    UNION
    SELECT Username, Email, 'Admin' AS AccountType
    FROM Administrators
    WHERE IsActive = 1
    ORDER BY AccountType, Username;
END
GO

CREATE PROCEDURE sp_GetGamesBothPurchasedAndWishlisted
AS
BEGIN
    SET NOCOUNT ON;
    SELECT g.GameTitle, g.FinalPrice
    FROM Games g
    WHERE g.GameID IN (
        SELECT GameID FROM UserLibrary
        INTERSECT
        SELECT GameID FROM Wishlist
    );
END
GO

CREATE PROCEDURE sp_GetWishlistedNotPurchased
AS
BEGIN
    SET NOCOUNT ON;
    SELECT g.GameTitle, g.FinalPrice, g.AverageRating
    FROM Games g
    WHERE g.GameID IN (
        SELECT GameID FROM Wishlist
        EXCEPT
        SELECT GameID FROM UserLibrary
    )
    ORDER BY g.AverageRating DESC;
END
GO

CREATE PROCEDURE sp_GetTopRatedGames
    @MinReviews INT = 1
AS
BEGIN
    SET NOCOUNT ON;
    SELECT g.GameTitle,
           COUNT(r.ReviewID) AS TotalReviews,
           AVG(r.Rating)     AS AvgRating,
           MAX(r.Rating)     AS BestRating,
           MIN(r.Rating)     AS WorstRating
    FROM Games g
    JOIN Reviews r ON g.GameID = r.GameID
    GROUP BY g.GameID, g.GameTitle
    HAVING COUNT(r.ReviewID) > @MinReviews
    ORDER BY AvgRating DESC;
END
GO

CREATE PROCEDURE sp_GetUserPurchaseHistory
    @UserID INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT o.OrderID, o.OrderDate, g.GameTitle,
           od.PurchasePrice, od.Quantity, od.Subtotal,
           o.PaymentMethod, o.PaymentStatus
    FROM Orders o
    JOIN OrderDetails od ON o.OrderID = od.OrderID
    JOIN Games g         ON od.GameID = g.GameID
    WHERE o.UserID = @UserID
    ORDER BY o.OrderDate DESC;
END
GO

CREATE PROCEDURE sp_SubmitReview
    @GameID INT,
    @UserID INT,
    @Rating INT,
    @ReviewText VARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO Reviews (GameID, UserID, Rating, ReviewText)
    VALUES (@GameID, @UserID, @Rating, @ReviewText);

    UPDATE Games
    SET AverageRating = (SELECT AVG(CAST(Rating AS DECIMAL(3,2))) FROM Reviews WHERE GameID = @GameID),
        TotalReviews  = (SELECT COUNT(*) FROM Reviews WHERE GameID = @GameID)
    WHERE GameID = @GameID;
END
GO

CREATE PROCEDURE sp_ManageWishlist
    @UserID INT,
    @GameID INT,
    @Action VARCHAR(10)
AS
BEGIN
    SET NOCOUNT ON;
    IF @Action = 'ADD'
    BEGIN
        INSERT INTO Wishlist (UserID, GameID)
        SELECT @UserID, @GameID
        WHERE NOT EXISTS (
            SELECT 1 FROM Wishlist WHERE UserID = @UserID AND GameID = @GameID
        );
    END
    ELSE IF @Action = 'REMOVE'
    BEGIN
        DELETE FROM Wishlist
        WHERE UserID = @UserID AND GameID = @GameID;
    END
END
GO

CREATE PROCEDURE sp_BrowseGamesByCategory
    @CategoryName VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT g.GameTitle, g.FinalPrice, g.AverageRating,
           p.PublisherName, c.CategoryName
    FROM Games g
    JOIN GameCategories gc ON g.GameID      = gc.GameID
    JOIN Categories     c  ON gc.CategoryID = c.CategoryID
    JOIN Publishers     p  ON g.PublisherID  = p.PublisherID
    WHERE c.CategoryName = @CategoryName
      AND g.IsActive = 1
    ORDER BY g.AverageRating DESC, g.FinalPrice ASC;
END
GO

CREATE PROCEDURE sp_GetMonthlySalesReport
AS
BEGIN
    SET NOCOUNT ON;
    SELECT YEAR(o.OrderDate)          AS SaleYear,
           MONTH(o.OrderDate)         AS SaleMonth,
           COUNT(DISTINCT o.OrderID)  AS TotalOrders,
           SUM(od.Quantity)           AS UnitsSold,
           SUM(od.Subtotal)           AS TotalRevenue
    FROM Orders o
    JOIN OrderDetails od ON o.OrderID = od.OrderID
    WHERE o.PaymentStatus = 'Completed'
    GROUP BY YEAR(o.OrderDate), MONTH(o.OrderDate)
    ORDER BY SaleYear DESC, SaleMonth DESC;
END
GO


