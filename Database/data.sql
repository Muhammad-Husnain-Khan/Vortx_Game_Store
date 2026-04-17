USE VORTX_GameStore;
GO
-- =============================================
-- admin (10)
-- =============================================

Select * from 



-- =============================================
-- PUBLISHERS (5)
-- =============================================
SET IDENTITY_INSERT Publishers ON;
INSERT INTO Publishers (PublisherID, PublisherName, Description, Country, FoundedYear, IsActive)
VALUES
(1, 'CD Projekt Red', 'Polish video game developer known for The Witcher series and Cyberpunk 2077.', 'Poland', 1994, 1),
(2, 'Rockstar Games', 'American game publisher known for Grand Theft Auto and Red Dead Redemption.', 'United States', 1998, 1),
(3, 'Ubisoft', 'French video game company known for Assassin''s Creed and Far Cry series.', 'France', 1986, 1),
(4, 'EA Sports', 'Division of Electronic Arts that develops sports video games.', 'United States', 1991, 1),
(5, 'Valve', 'American developer of Steam platform, Half-Life, and Counter-Strike.', 'United States', 1996, 1);
SET IDENTITY_INSERT Publishers OFF;
GO

-- =============================================
-- CATEGORIES (5)
-- =============================================
SET IDENTITY_INSERT Categories ON;
INSERT INTO Categories (CategoryID, CategoryName, Description, IsActive)
VALUES
(1, 'RPG', 'Role-Playing Games with character progression and story-driven gameplay.', 1),
(2, 'Action', 'Fast-paced games focused on combat, reflexes, and physical challenges.', 1),
(3, 'Sports', 'Simulation of real-world sports including football, basketball, and racing.', 1),
(4, 'Strategy', 'Games that emphasize tactical and strategic decision-making.', 1),
(5, 'Adventure', 'Exploration-focused games with narrative-driven experiences.', 1);
SET IDENTITY_INSERT Categories OFF;
GO

-- =============================================
-- GAMES (8)
-- =============================================
SET IDENTITY_INSERT Games ON;
INSERT INTO Games (GameID, GameTitle, Description, PublisherID, ReleaseDate, Price, DiscountPercentage, FinalPrice, AgeRating, ThumbnailPath, CoverImagePath, TrailerURL, SystemRequirements, FileSize, AverageRating, TotalReviews, TotalSales, IsFeatured, IsActive)
VALUES
(1, 'Cyberpunk 2077', 'An open-world action-adventure RPG set in the megalopolis of Night City. You play as V, a mercenary outlaw going after a one-of-a-kind implant that is the key to immortality.', 1, '2020-12-10', 59.99, 10.00, 53.99, 'M', 
 'https://cdn.akamai.steamstatic.com/steam/apps/1091500/header.jpg',
 'https://cdn.akamai.steamstatic.com/steam/apps/1091500/library_600x900_2x.jpg',
 'https://www.youtube.com/watch?v=8X2kIfS6fb8',
 '{"minimum":{"cpu":"Intel Core i5-3570K","ram":"8 GB","gpu":"NVIDIA GeForce GTX 780","storage":"70 GB SSD"},"recommended":{"cpu":"Intel Core i7-4790","ram":"12 GB","gpu":"NVIDIA GeForce GTX 1060 6GB","storage":"70 GB SSD"}}',
 '70 GB', 0, 0, 0, 1, 1),

(2, 'Grand Theft Auto V', 'Experience the interlocking stories of three unique criminals in the sprawling city of Los Santos. GTA V offers a world of unprecedented scale, detail, and opportunity.', 2, '2013-09-17', 29.99, 0.00, 29.99, 'M',
 'https://cdn.akamai.steamstatic.com/steam/apps/271590/header.jpg',
 'https://cdn.akamai.steamstatic.com/steam/apps/271590/library_600x900_2x.jpg',
 'https://www.youtube.com/watch?v=QkkoHAzjnUs',
 '{"minimum":{"cpu":"Intel Core 2 Quad Q6600","ram":"4 GB","gpu":"NVIDIA GeForce 9800 GT 1GB","storage":"72 GB"},"recommended":{"cpu":"Intel Core i5-3470","ram":"8 GB","gpu":"NVIDIA GeForce GTX 660 2GB","storage":"72 GB"}}',
 '72 GB', 0, 0, 0, 1, 1),

(3, 'EA Sports FC 25', 'The next chapter in football gaming with HyperMotionV technology, bringing the most authentic football experience ever with enhanced tactical AI and real-world player movements.', 4, '2024-09-27', 69.99, 15.00, 59.49, 'E',
 'https://cdn.akamai.steamstatic.com/steam/apps/2669320/header.jpg',
 'https://cdn.akamai.steamstatic.com/steam/apps/2669320/library_600x900_2x.jpg',
 'https://www.youtube.com/watch?v=VkBq_MCOaQQ',
 '{"minimum":{"cpu":"Intel Core i5-6600K","ram":"8 GB","gpu":"NVIDIA GeForce GTX 1050 Ti","storage":"100 GB"},"recommended":{"cpu":"Intel Core i7-6700","ram":"12 GB","gpu":"NVIDIA GeForce GTX 1660","storage":"100 GB"}}',
 '100 GB', 0, 0, 0, 0, 1),

(4, 'Assassin''s Creed Shadows', 'Experience feudal Japan as both a deadly shinobi and a powerful samurai in this open-world action RPG. Explore a beautiful and dangerous world during a transformative period in Japanese history.', 3, '2025-03-20', 69.99, 0.00, 69.99, 'M',
 'https://cdn.akamai.steamstatic.com/steam/apps/3035570/header.jpg',
 'https://cdn.akamai.steamstatic.com/steam/apps/3035570/library_600x900_2x.jpg',
 'https://www.youtube.com/watch?v=RGF_2gflNvA',
 '{"minimum":{"cpu":"Intel Core i7-8700K","ram":"16 GB","gpu":"NVIDIA GeForce GTX 1070","storage":"100 GB SSD"},"recommended":{"cpu":"Intel Core i5-11600K","ram":"16 GB","gpu":"NVIDIA GeForce RTX 3060","storage":"100 GB SSD"}}',
 '100 GB', 0, 0, 0, 1, 1),

(5, 'The Witcher 3: Wild Hunt', 'A story-driven, open world RPG set in a visually stunning fantasy universe full of meaningful choices and impactful consequences. You play as Geralt of Rivia, a monster hunter searching for his adopted daughter.', 1, '2015-05-19', 39.99, 50.00, 19.99, 'M',
 'https://cdn.akamai.steamstatic.com/steam/apps/292030/header.jpg',
 'https://cdn.akamai.steamstatic.com/steam/apps/292030/library_600x900_2x.jpg',
 'https://www.youtube.com/watch?v=c0i88t0Kacs',
 '{"minimum":{"cpu":"Intel Core i5-2500K","ram":"6 GB","gpu":"NVIDIA GeForce GTX 660","storage":"50 GB"},"recommended":{"cpu":"Intel Core i7-3770","ram":"8 GB","gpu":"NVIDIA GeForce GTX 770","storage":"50 GB"}}',
 '50 GB', 0, 0, 0, 1, 1),

(6, 'Counter-Strike 2', 'Counter-Strike 2 is the largest technical leap forward in CS history, built on the Source 2 engine with new maps, upgraded visuals, and responsive smoke grenades.', 5, '2023-09-27', 0.00, 0.00, 0.00, 'M',
 'https://cdn.akamai.steamstatic.com/steam/apps/730/header.jpg',
 'https://cdn.akamai.steamstatic.com/steam/apps/730/library_600x900_2x.jpg',
 'https://www.youtube.com/watch?v=c80dVYcL69E',
 '{"minimum":{"cpu":"Intel Core i5-2500K","ram":"8 GB","gpu":"NVIDIA GeForce GTX 780","storage":"85 GB"},"recommended":{"cpu":"Intel Core i5-9400F","ram":"12 GB","gpu":"NVIDIA GeForce RTX 2060","storage":"85 GB"}}',
 '85 GB', 0, 0, 0, 0, 1),

(7, 'Far Cry 6', 'Welcome to Yara, a tropical paradise frozen in time. Fight against Anton Castillo''s regime as guerrilla fighter Dani Rojas in the largest Far Cry playground ever.', 3, '2021-10-07', 59.99, 40.00, 35.99, 'M',
 'https://cdn.akamai.steamstatic.com/steam/apps/2369390/header.jpg',
 'https://cdn.akamai.steamstatic.com/steam/apps/2369390/library_600x900_2x.jpg',
 'https://www.youtube.com/watch?v=LH0wUZmmjdQ',
 '{"minimum":{"cpu":"Intel Core i5-4460","ram":"8 GB","gpu":"NVIDIA GeForce GTX 960","storage":"60 GB"},"recommended":{"cpu":"Intel Core i7-9700","ram":"16 GB","gpu":"NVIDIA GeForce GTX 1080","storage":"60 GB"}}',
 '60 GB', 0, 0, 0, 0, 1),

(8, 'Red Dead Redemption 2', 'America, 1899. Arthur Morgan and the Van der Linde gang are on the run. With federal agents and bounty hunters closing in, the gang must rob, steal and fight across rugged heartland of America.', 2, '2018-10-26', 59.99, 20.00, 47.99, 'M',
 'https://cdn.akamai.steamstatic.com/steam/apps/1174180/header.jpg',
 'https://cdn.akamai.steamstatic.com/steam/apps/1174180/library_600x900_2x.jpg',
 'https://www.youtube.com/watch?v=gmA6MrX81z4',
 '{"minimum":{"cpu":"Intel Core i5-2500K","ram":"8 GB","gpu":"NVIDIA GeForce GTX 770 2GB","storage":"150 GB"},"recommended":{"cpu":"Intel Core i7-4770K","ram":"12 GB","gpu":"NVIDIA GeForce GTX 1060 6GB","storage":"150 GB"}}',
 '150 GB', 0, 0, 0, 1, 1);
SET IDENTITY_INSERT Games OFF;
GO

-- =============================================
-- GAME CATEGORIES (many-to-many mappings)
-- =============================================
INSERT INTO GameCategories (GameID, CategoryID) VALUES
(1, 1), -- Cyberpunk 2077 -> RPG
(1, 2), -- Cyberpunk 2077 -> Action
(2, 2), -- GTA V -> Action
(2, 5), -- GTA V -> Adventure
(3, 3), -- EA Sports FC 25 -> Sports
(4, 2), -- AC Shadows -> Action
(4, 5), -- AC Shadows -> Adventure
(4, 1), -- AC Shadows -> RPG
(5, 1), -- Witcher 3 -> RPG
(5, 5), -- Witcher 3 -> Adventure
(6, 2), -- CS2 -> Action
(6, 4), -- CS2 -> Strategy
(7, 2), -- Far Cry 6 -> Action
(7, 5), -- Far Cry 6 -> Adventure
(8, 2), -- RDR2 -> Action
(8, 5), -- RDR2 -> Adventure
(8, 1); -- RDR2 -> RPG
GO

-- =============================================
-- USERS (6 users: 2 admin + 4 regular, 1 inactive)
-- NOTE: Replace FirebaseUID values with your actual Firebase UIDs
-- =============================================
SET IDENTITY_INSERT Users ON;
INSERT INTO Users (UserID, Username, Email, Password, FirstName, LastName, DateOfBirth, Country, Role, IsActive, FirebaseUID)
VALUES
(1, 'admin_husnain', 'admin@vortx.com', 'firebase_managed', 'Muhammad', 'Husnain', '2003-06-15', 'Pakistan', 'admin', 1, 'REPLACE_WITH_FIREBASE_UID_1'),
(2, 'admin_muazzam', 'admin2@vortx.com', 'firebase_managed', 'Muhammad', 'Muazzam', '2003-08-20', 'Pakistan', 'admin', 1, 'REPLACE_WITH_FIREBASE_UID_2'),
(3, 'john_doe', 'john@example.com', 'firebase_managed', 'John', 'Doe', '1995-03-22', 'United States', 'user', 1, 'REPLACE_WITH_FIREBASE_UID_3'),
(4, 'jane_smith', 'jane@example.com', 'firebase_managed', 'Jane', 'Smith', '1998-07-14', 'United Kingdom', 'user', 1, 'REPLACE_WITH_FIREBASE_UID_4'),
(5, 'alex_gamer', 'alex@example.com', 'firebase_managed', 'Alex', 'Johnson', '2000-11-30', 'Canada', 'user', 0, 'REPLACE_WITH_FIREBASE_UID_5'),
(6, 'sarah_plays', 'sarah@example.com', 'firebase_managed', 'Sarah', 'Williams', '1997-01-08', 'Australia', 'user', 1, 'REPLACE_WITH_FIREBASE_UID_6');
SET IDENTITY_INSERT Users OFF;
GO

-- =============================================
-- ORDERS (6 orders)
-- =============================================
SET IDENTITY_INSERT Orders ON;
INSERT INTO Orders (OrderID, UserID, OrderDate, TotalAmount, PaymentMethod, PaymentStatus, TransactionID, BillingAddress)
VALUES
(1, 3, '2025-01-15 10:30:00', 83.98, 'Credit Card', 'Completed', 'TXN-001-2025', '123 Main St, New York, NY 10001'),
(2, 3, '2025-02-20 14:15:00', 29.99, 'PayPal', 'Completed', 'TXN-002-2025', '123 Main St, New York, NY 10001'),
(3, 4, '2025-02-28 09:45:00', 59.49, 'Credit Card', 'Completed', 'TXN-003-2025', '456 Oak Ave, London, UK'),
(4, 4, '2025-03-10 16:00:00', 19.99, 'Debit Card', 'Completed', 'TXN-004-2025', '456 Oak Ave, London, UK'),
(5, 6, '2025-03-15 11:20:00', 47.99, 'Credit Card', 'Completed', 'TXN-005-2025', '789 Elm Dr, Sydney, AU'),
(6, 6, '2025-04-01 08:30:00', 35.99, 'PayPal', 'Pending', 'TXN-006-2025', '789 Elm Dr, Sydney, AU');
SET IDENTITY_INSERT Orders OFF;
GO

-- =============================================
-- ORDER DETAILS (9 line items)
-- =============================================
INSERT INTO OrderDetails (OrderID, GameID, PurchasePrice, Quantity, Subtotal) VALUES
(1, 1, 53.99, 1, 53.99),  -- John bought Cyberpunk 2077
(1, 2, 29.99, 1, 29.99),  -- John bought GTA V
(2, 5, 19.99, 1, 19.99),  -- John bought Witcher 3 (discounted)
(3, 3, 59.49, 1, 59.49),  -- Jane bought EA FC 25
(4, 5, 19.99, 1, 19.99),  -- Jane bought Witcher 3
(5, 8, 47.99, 1, 47.99),  -- Sarah bought RDR2
(6, 7, 35.99, 1, 35.99),  -- Sarah bought Far Cry 6 (pending)
(2, 6, 0.00, 1, 0.00),    -- John got CS2 (free)
(5, 2, 29.99, 1, 29.99);  -- Sarah bought GTA V
GO

-- =============================================
-- USER LIBRARY (purchased games)
-- =============================================
INSERT INTO UserLibrary (UserID, GameID, OrderID) VALUES
(3, 1, 1),  -- John owns Cyberpunk 2077
(3, 2, 1),  -- John owns GTA V
(3, 5, 2),  -- John owns Witcher 3
(3, 6, 2),  -- John owns CS2
(4, 3, 3),  -- Jane owns EA FC 25
(4, 5, 4),  -- Jane owns Witcher 3
(6, 8, 5),  -- Sarah owns RDR2
(6, 2, 5);  -- Sarah owns GTA V
GO

-- =============================================
-- REVIEWS (9 reviews)
-- =============================================
INSERT INTO Reviews (GameID, UserID, Rating, ReviewText) VALUES
(1, 3, 4, 'Cyberpunk 2077 has come a long way since launch. Night City is breathtaking and the story is incredibly engaging. The RPG elements are deep and rewarding.'),
(2, 3, 5, 'GTA V is a masterpiece that still holds up after all these years. The open world is unmatched and online mode keeps things fresh.'),
(5, 3, 5, 'The Witcher 3 is the greatest RPG ever made. The storytelling, world-building, and character development are second to none.'),
(3, 4, 4, 'EA FC 25 is a solid football game with improved gameplay mechanics. HyperMotionV makes a real difference in player animations.'),
(5, 4, 5, 'Absolutely stunning game. Every quest feels handcrafted with love. Geralt''s story is unforgettable.'),
(8, 6, 5, 'Red Dead Redemption 2 is a work of art. Arthur Morgan''s journey is one of the best stories in gaming history.'),
(2, 6, 4, 'GTA V is still one of the most fun games you can play. The heists are incredible and the world feels alive.'),
(1, 4, 3, 'Good game but had some bugs at launch. The recent updates have fixed most issues. Night City looks amazing.'),
(6, 3, 4, 'CS2 is a great evolution of Counter-Strike. The smoke grenades are a game-changer and the new maps feel fresh.');
GO

-- =============================================
-- UPDATE game ratings based on reviews
-- =============================================
UPDATE Games SET 
    AverageRating = (SELECT AVG(CAST(Rating AS DECIMAL(3,2))) FROM Reviews WHERE Reviews.GameID = Games.GameID),
    TotalReviews = (SELECT COUNT(*) FROM Reviews WHERE Reviews.GameID = Games.GameID)
WHERE GameID IN (SELECT DISTINCT GameID FROM Reviews);
GO

-- =============================================
-- UPDATE game sales based on completed orders
-- =============================================
UPDATE Games SET
    TotalSales = ISNULL((
        SELECT SUM(od.Quantity) 
        FROM OrderDetails od 
        JOIN Orders o ON od.OrderID = o.OrderID 
        WHERE od.GameID = Games.GameID AND o.PaymentStatus = 'Completed'
    ), 0);
GO

-- =============================================
-- WISHLIST (10 entries)
-- =============================================
INSERT INTO Wishlist (UserID, GameID) VALUES
(3, 4),  -- John wants AC Shadows
(3, 8),  -- John wants RDR2
(3, 7),  -- John wants Far Cry 6
(4, 1),  -- Jane wants Cyberpunk 2077
(4, 8),  -- Jane wants RDR2
(4, 2),  -- Jane wants GTA V
(6, 1),  -- Sarah wants Cyberpunk 2077
(6, 4),  -- Sarah wants AC Shadows
(6, 5),  -- Sarah wants Witcher 3
(6, 3);  -- Sarah wants EA FC 25
GO

-- =============================================
-- GAME IMAGES (screenshots for each game)
-- =============================================
INSERT INTO GameImages (GameID, ImagePath, ImageType, DisplayOrder) VALUES
(1, 'https://cdn.akamai.steamstatic.com/steam/apps/1091500/ss_b529b0abc43f55fc23fe8058eddb6e37c9629a6c.jpg', 'screenshot', 1),
(1, 'https://cdn.akamai.steamstatic.com/steam/apps/1091500/ss_872822c5e50dc71f345416098d29fc91f09ea832.jpg', 'screenshot', 2),
(2, 'https://cdn.akamai.steamstatic.com/steam/apps/271590/ss_32aa18ab3175e3002217862dd5a97a8e1b2abe4c.jpg', 'screenshot', 1),
(2, 'https://cdn.akamai.steamstatic.com/steam/apps/271590/ss_da39c16db175f6973770e54c3815549eaf0e1289.jpg', 'screenshot', 2),
(5, 'https://cdn.akamai.steamstatic.com/steam/apps/292030/ss_107600c1337accc09104f7a8b7f893a545303571.jpg', 'screenshot', 1),
(5, 'https://cdn.akamai.steamstatic.com/steam/apps/292030/ss_64eb760f9a2b67f6731a71cad01a23571f8e3a0c.jpg', 'screenshot', 2),
(8, 'https://cdn.akamai.steamstatic.com/steam/apps/1174180/ss_66b553f4c209476d3e4ce25fa4714c5e90229a21.jpg', 'screenshot', 1),
(8, 'https://cdn.akamai.steamstatic.com/steam/apps/1174180/ss_bac60bacbf5da8945103648c08d27d5e202444ca.jpg', 'screenshot', 2),
(6, 'https://cdn.akamai.steamstatic.com/steam/apps/730/ss_d830cfd0550fbb6095d1c23b1eb3076c8a0630df.jpg', 'screenshot', 1),
(4, 'https://cdn.akamai.steamstatic.com/steam/apps/3035570/ss_1.jpg', 'screenshot', 1);
GO

PRINT 'Seed data inserted successfully!';
GO
