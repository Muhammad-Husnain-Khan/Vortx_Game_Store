USE VORTX_GameStore;
GO

-- =============================================
-- ADDITIONAL PUBLISHERS (10 more)
-- =============================================
SET IDENTITY_INSERT Publishers ON;
INSERT INTO Publishers (PublisherID, PublisherName, Description, Country, FoundedYear, IsActive)
VALUES
(6,  'FromSoftware',       'Japanese studio known for Dark Souls, Sekiro, and Elden Ring. Mastered the "Soulslike" genre.',            'Japan',          1986, 1),
(7,  'Sony Interactive',   'PlayStation publisher bringing exclusives to PC including God of War and Spider-Man.',                      'Japan',          1993, 1),
(8,  'Warner Bros. Games', 'Publishing arm of Warner Bros. producing Batman, Hogwarts Legacy, and Mortal Kombat.',                     'United States',  2004, 1),
(9,  'Larian Studios',     'Belgian RPG specialists who created Divinity: Original Sin and Baldur''s Gate 3.',                         'Belgium',        1996, 1),
(10, 'Bethesda Softworks', 'Legendary developer of The Elder Scrolls, Fallout, and DOOM series.',                                      'United States',  1986, 1),
(11, 'Supergiant Games',   'Indie studio known for Bastion, Transistor, and Hades.',                                                   'United States',  2009, 1),
(12, 'ConcernedApe',       'One-man studio by Eric Barone, creator of Stardew Valley.',                                                'United States',  2012, 1),
(13, 'Team Cherry',        'Australian indie studio behind the critically acclaimed Hollow Knight.',                                    'Australia',      2014, 1),
(14, 'Techland',           'Polish developer known for Dead Island and Dying Light series.',                                            'Poland',         1991, 1),
(15, 'Game Science',       'Chinese studio that developed the AAA hit Black Myth: Wukong.',                                            'China',          2014, 1);
SET IDENTITY_INSERT Publishers OFF;
GO

-- =============================================
-- ADDITIONAL GAMES (25 more, GameID 9-33)
-- =============================================
SET IDENTITY_INSERT Games ON;
INSERT INTO Games (GameID, GameTitle, Description, PublisherID, ReleaseDate, Price, DiscountPercentage, FinalPrice, AgeRating, ThumbnailPath, CoverImagePath, TrailerURL, SystemRequirements, FileSize, AverageRating, TotalReviews, TotalSales, IsFeatured, IsActive)
VALUES

-- 9. Elden Ring
(9, 'Elden Ring', 'Rise, Tarnished, and be guided by grace to brandish the power of the Elden Ring and become an Elden Lord in the Lands Between. A vast world created by Hidetaka Miyazaki and George R.R. Martin.', 6, '2022-02-25', 59.99, 20.00, 47.99, 'M',
 'https://cdn.akamai.steamstatic.com/steam/apps/1245620/header.jpg',
 'https://cdn.akamai.steamstatic.com/steam/apps/1245620/library_600x900_2x.jpg',
 'https://www.youtube.com/watch?v=E3Huy2cdih0',
 '{"minimum":{"cpu":"Intel Core i5-8400","ram":"12 GB","gpu":"NVIDIA GeForce GTX 1060 3GB","storage":"60 GB"},"recommended":{"cpu":"Intel Core i7-8700K","ram":"16 GB","gpu":"NVIDIA GeForce GTX 1070 8GB","storage":"60 GB"}}',
 '60 GB', 0, 0, 0, 1, 1),

-- 10. God of War (2018)
(10, 'God of War', 'Enter the Norse realm. Kratos is a father again. As mentor and protector to Atreus, a son determined to earn his respect, he is forced to deal with and control the rage that has long defined him.', 7, '2022-01-14', 49.99, 30.00, 34.99, 'M',
 'https://cdn.akamai.steamstatic.com/steam/apps/1593500/header.jpg',
 'https://cdn.akamai.steamstatic.com/steam/apps/1593500/library_600x900_2x.jpg',
 'https://www.youtube.com/watch?v=K0u_kAWLJOA',
 '{"minimum":{"cpu":"Intel Core i5-2500K","ram":"8 GB","gpu":"NVIDIA GeForce GTX 960 4GB","storage":"70 GB"},"recommended":{"cpu":"Intel Core i5-6600K","ram":"8 GB","gpu":"NVIDIA GeForce GTX 1060 6GB","storage":"70 GB"}}',
 '70 GB', 0, 0, 0, 1, 1),

-- 11. Hogwarts Legacy
(11, 'Hogwarts Legacy', 'Experience Hogwarts in the 1800s. Your character holds the key to an ancient secret that threatens the wizarding world. Explore familiar and new locations as you master spells and brew potions.', 8, '2023-02-10', 59.99, 25.00, 44.99, 'T',
 'https://cdn.akamai.steamstatic.com/steam/apps/990080/header.jpg',
 'https://cdn.akamai.steamstatic.com/steam/apps/990080/library_600x900_2x.jpg',
 'https://www.youtube.com/watch?v=1O6Qstb21Ek',
 '{"minimum":{"cpu":"Intel Core i5-6600","ram":"16 GB","gpu":"NVIDIA GeForce GTX 960 4GB","storage":"85 GB SSD"},"recommended":{"cpu":"Intel Core i7-8700","ram":"16 GB","gpu":"NVIDIA GeForce RTX 1080 Ti","storage":"85 GB SSD"}}',
 '85 GB', 0, 0, 0, 1, 1),

-- 12. Baldur''s Gate 3
(12, 'Baldur''s Gate 3', 'Gather your party and return to the Forgotten Realms in a tale of fellowship and betrayal, sacrifice and survival. An epic RPG set in the D&D universe with unprecedented player freedom.', 9, '2023-08-03', 59.99, 0.00, 59.99, 'M',
 'https://cdn.akamai.steamstatic.com/steam/apps/1086940/header.jpg',
 'https://cdn.akamai.steamstatic.com/steam/apps/1086940/library_600x900_2x.jpg',
 'https://www.youtube.com/watch?v=1T22wNnUMWg',
 '{"minimum":{"cpu":"Intel Core i5-4690","ram":"8 GB","gpu":"NVIDIA GeForce GTX 970","storage":"150 GB SSD"},"recommended":{"cpu":"Intel Core i7-8700K","ram":"16 GB","gpu":"NVIDIA GeForce RTX 2060 Super","storage":"150 GB SSD"}}',
 '150 GB', 0, 0, 0, 1, 1),

-- 13. Black Myth: Wukong
(13, 'Black Myth: Wukong', 'An action RPG rooted in Chinese mythology. You are the Destined One, traveling through breathtaking landscapes inspired by Journey to the West, facing fearsome creatures from Chinese folklore.', 15, '2024-08-20', 59.99, 0.00, 59.99, 'M',
 'https://cdn.akamai.steamstatic.com/steam/apps/2358720/header.jpg',
 'https://cdn.akamai.steamstatic.com/steam/apps/2358720/library_600x900_2x.jpg',
 'https://www.youtube.com/watch?v=pnSsgRJmsCc',
 '{"minimum":{"cpu":"Intel Core i5-8400","ram":"16 GB","gpu":"NVIDIA GeForce GTX 1060 6GB","storage":"130 GB SSD"},"recommended":{"cpu":"Intel Core i7-9700","ram":"16 GB","gpu":"NVIDIA GeForce RTX 2060","storage":"130 GB SSD"}}',
 '130 GB', 0, 0, 0, 1, 1),

-- 14. Sekiro: Shadows Die Twice
(14, 'Sekiro: Shadows Die Twice', 'Carve your own clever path to vengeance in this award-winning adventure from FromSoftware. Explore late 1500s Sengoku Japan as the one-armed wolf, a disgraced warrior rescued from the brink of death.', 6, '2019-03-22', 59.99, 50.00, 29.99, 'M',
 'https://cdn.akamai.steamstatic.com/steam/apps/814380/header.jpg',
 'https://cdn.akamai.steamstatic.com/steam/apps/814380/library_600x900_2x.jpg',
 'https://www.youtube.com/watch?v=rXMX4YJ7Lks',
 '{"minimum":{"cpu":"Intel Core i3-2100","ram":"4 GB","gpu":"NVIDIA GeForce GTX 760","storage":"25 GB"},"recommended":{"cpu":"Intel Core i5-2500K","ram":"8 GB","gpu":"NVIDIA GeForce GTX 970","storage":"25 GB"}}',
 '25 GB', 0, 0, 0, 0, 1),

-- 15. DOOM Eternal
(15, 'DOOM Eternal', 'Hell''s armies have invaded Earth. Become the Slayer in an epic single-player campaign to conquer demons across dimensions and stop the final destruction of humanity with insanely fast combat.', 10, '2020-03-20', 39.99, 60.00, 15.99, 'M',
 'https://cdn.akamai.steamstatic.com/steam/apps/782330/header.jpg',
 'https://cdn.akamai.steamstatic.com/steam/apps/782330/library_600x900_2x.jpg',
 'https://www.youtube.com/watch?v=_oVwrpTo3ks',
 '{"minimum":{"cpu":"Intel Core i5-2500","ram":"8 GB","gpu":"NVIDIA GeForce GTX 1050 Ti","storage":"50 GB"},"recommended":{"cpu":"Intel Core i7-6700K","ram":"8 GB","gpu":"NVIDIA GeForce GTX 1060 6GB","storage":"50 GB"}}',
 '50 GB', 0, 0, 0, 0, 1),

-- 16. Hades
(16, 'Hades', 'Defy the god of the dead as you hack and slash out of the Underworld in this rogue-like dungeon crawler from the creators of Bastion. Battle through ever-shifting dungeons of Hades.', 11, '2020-09-17', 24.99, 30.00, 17.49, 'T',
 'https://cdn.akamai.steamstatic.com/steam/apps/1145360/header.jpg',
 'https://cdn.akamai.steamstatic.com/steam/apps/1145360/library_600x900_2x.jpg',
 'https://www.youtube.com/watch?v=91t0ha9x0AE',
 '{"minimum":{"cpu":"Intel Core 2 Duo E8400","ram":"4 GB","gpu":"NVIDIA GeForce GTX 460","storage":"15 GB"},"recommended":{"cpu":"Intel Core i5-7400","ram":"8 GB","gpu":"NVIDIA GeForce GTX 1050","storage":"15 GB"}}',
 '15 GB', 0, 0, 0, 0, 1),

-- 17. Stardew Valley
(17, 'Stardew Valley', 'You''ve inherited your grandfather''s old farm plot in Stardew Valley. Armed with hand-me-down tools and a few coins, you set out to begin your new life. Grow crops, raise animals, and make friends.', 12, '2016-02-26', 14.99, 0.00, 14.99, 'E',
 'https://cdn.akamai.steamstatic.com/steam/apps/413150/header.jpg',
 'https://cdn.akamai.steamstatic.com/steam/apps/413150/library_600x900_2x.jpg',
 'https://www.youtube.com/watch?v=ot7uXNQskhs',
 '{"minimum":{"cpu":"Intel Core 2 Duo 2.0 GHz","ram":"2 GB","gpu":"256 MB DirectX 10","storage":"500 MB"},"recommended":{"cpu":"Intel Core i5","ram":"4 GB","gpu":"2 GB DirectX 10","storage":"500 MB"}}',
 '500 MB', 0, 0, 0, 0, 1),

-- 18. Hollow Knight
(18, 'Hollow Knight', 'Forge your own path in Hollow Knight! An epic action-adventure through a vast ruined kingdom of insects and heroes. Explore twisting caverns, battle tainted creatures, and befriend bizarre bugs.', 13, '2017-02-24', 14.99, 40.00, 8.99, 'E',
 'https://cdn.akamai.steamstatic.com/steam/apps/367520/header.jpg',
 'https://cdn.akamai.steamstatic.com/steam/apps/367520/library_600x900_2x.jpg',
 'https://www.youtube.com/watch?v=UAO2urG23S4',
 '{"minimum":{"cpu":"Intel Core 2 Duo E5200","ram":"4 GB","gpu":"GeForce 9800GTX+","storage":"9 GB"},"recommended":{"cpu":"Intel Core i5","ram":"8 GB","gpu":"GeForce GTX 560","storage":"9 GB"}}',
 '9 GB', 0, 0, 0, 0, 1),

-- 19. Dying Light 2: Stay Human
(19, 'Dying Light 2: Stay Human', 'Over twenty years ago in Harran, we fought the virus and lost. Now, we''re losing again. The City is humanity''s last stronghold. Use your agility and parkour skills to survive in a post-apocalyptic open world.', 14, '2022-02-04', 59.99, 50.00, 29.99, 'M',
 'https://cdn.akamai.steamstatic.com/steam/apps/534380/header.jpg',
 'https://cdn.akamai.steamstatic.com/steam/apps/534380/library_600x900_2x.jpg',
 'https://www.youtube.com/watch?v=FOWLiKYpEvQ',
 '{"minimum":{"cpu":"Intel Core i3-9100","ram":"8 GB","gpu":"NVIDIA GeForce GTX 1050 Ti","storage":"60 GB SSD"},"recommended":{"cpu":"Intel Core i5-8600K","ram":"16 GB","gpu":"NVIDIA GeForce RTX 2060 6GB","storage":"60 GB SSD"}}',
 '60 GB', 0, 0, 0, 0, 1),

-- 20. Star Wars Jedi: Fallen Order
(20, 'Star Wars Jedi: Fallen Order', 'A galaxy-spanning adventure awaits in Star Wars Jedi: Fallen Order. Cal Kestis, a Padawan who survived Order 66, must complete his training, develop new powerful Force abilities, and master lightsaber combat.', 4, '2019-11-15', 39.99, 60.00, 15.99, 'T',
 'https://cdn.akamai.steamstatic.com/steam/apps/1172380/header.jpg',
 'https://cdn.akamai.steamstatic.com/steam/apps/1172380/library_600x900_2x.jpg',
 'https://www.youtube.com/watch?v=xIl2z5wwjdA',
 '{"minimum":{"cpu":"Intel Core i3-3220","ram":"8 GB","gpu":"NVIDIA GeForce GTX 650","storage":"55 GB"},"recommended":{"cpu":"Intel Core i7-6700K","ram":"16 GB","gpu":"NVIDIA GeForce GTX 1070","storage":"55 GB"}}',
 '55 GB', 0, 0, 0, 0, 1),

-- 21. Marvel''s Spider-Man Remastered
(21, 'Marvel''s Spider-Man Remastered', 'In Marvel''s Spider-Man Remastered, Peter Parker is an experienced superhero fighting New York''s biggest villains. Swing through the city, use environment to your advantage, and feel the full power of Spider-Man.', 7, '2022-08-12', 59.99, 25.00, 44.99, 'T',
 'https://cdn.akamai.steamstatic.com/steam/apps/1817070/header.jpg',
 'https://cdn.akamai.steamstatic.com/steam/apps/1817070/library_600x900_2x.jpg',
 'https://www.youtube.com/watch?v=nfKO9ckzLeQ',
 '{"minimum":{"cpu":"Intel Core i3-4160","ram":"8 GB","gpu":"NVIDIA GeForce GTX 950","storage":"75 GB SSD"},"recommended":{"cpu":"Intel Core i5-4670","ram":"16 GB","gpu":"NVIDIA GeForce GTX 1060 6GB","storage":"75 GB SSD"}}',
 '75 GB', 0, 0, 0, 1, 1),

-- 22. Resident Evil 4 Remake
(22, 'Resident Evil 4', 'Survival horror is reborn. Six years after the biological disaster in Raccoon City, Leon S. Kennedy tracks the president''s kidnapped daughter to a secluded European village. Completely rebuilt from the ground up.', 8, '2023-03-24', 39.99, 40.00, 23.99, 'M',
 'https://cdn.akamai.steamstatic.com/steam/apps/2050650/header.jpg',
 'https://cdn.akamai.steamstatic.com/steam/apps/2050650/library_600x900_2x.jpg',
 'https://www.youtube.com/watch?v=raqJAE2KmcU',
 '{"minimum":{"cpu":"Intel Core i5-8400","ram":"12 GB","gpu":"NVIDIA GeForce GTX 1060 3GB","storage":"60 GB"},"recommended":{"cpu":"Intel Core i7-8700","ram":"16 GB","gpu":"NVIDIA GeForce RTX 2070","storage":"60 GB"}}',
 '60 GB', 0, 0, 0, 0, 1),

-- 23. Detroit: Become Human
(23, 'Detroit: Become Human', 'Detroit: Become Human puts the destiny of both humanity and androids in your hands. Every choice you make affects the outcome of the game, with one of the most branching narratives ever created.', 7, '2020-06-18', 39.99, 50.00, 19.99, 'M',
 'https://cdn.akamai.steamstatic.com/steam/apps/1222140/header.jpg',
 'https://cdn.akamai.steamstatic.com/steam/apps/1222140/library_600x900_2x.jpg',
 'https://www.youtube.com/watch?v=8a-EObAMRiA',
 '{"minimum":{"cpu":"Intel Core i5-2300","ram":"8 GB","gpu":"NVIDIA GeForce GTX 780","storage":"55 GB"},"recommended":{"cpu":"Intel Core i7-3770","ram":"12 GB","gpu":"NVIDIA GeForce GTX 1080","storage":"55 GB"}}',
 '55 GB', 0, 0, 0, 0, 1),

-- 24. The Elder Scrolls V: Skyrim Special Edition
(24, 'The Elder Scrolls V: Skyrim Special Edition', 'The legendary open-world RPG remastered with stunning detail. The Empire of Tamriel is on the edge of civil war. Dragons, long lost to the passages of the Elder Scrolls, have returned.', 10, '2016-10-28', 39.99, 50.00, 19.99, 'M',
 'https://cdn.akamai.steamstatic.com/steam/apps/489830/header.jpg',
 'https://cdn.akamai.steamstatic.com/steam/apps/489830/library_600x900_2x.jpg',
 'https://www.youtube.com/watch?v=JSRtYpNRoN0',
 '{"minimum":{"cpu":"Intel Core i5-750","ram":"8 GB","gpu":"NVIDIA GeForce GTX 470 1GB","storage":"12 GB"},"recommended":{"cpu":"Intel Core i5-2400","ram":"8 GB","gpu":"NVIDIA GeForce GTX 780 3GB","storage":"12 GB"}}',
 '12 GB', 0, 0, 0, 0, 1),

-- 25. Fallout 4
(25, 'Fallout 4', 'As the sole survivor of Vault 111, you enter a world destroyed by nuclear war. Only you can rebuild and determine the fate of the Wasteland. Build settlements, craft weapons, and explore the open world.', 10, '2015-11-10', 19.99, 50.00, 9.99, 'M',
 'https://cdn.akamai.steamstatic.com/steam/apps/377160/header.jpg',
 'https://cdn.akamai.steamstatic.com/steam/apps/377160/library_600x900_2x.jpg',
 'https://www.youtube.com/watch?v=X5aJfebzkrM',
 '{"minimum":{"cpu":"Intel Core i5-2300","ram":"8 GB","gpu":"NVIDIA GeForce GTX 550 Ti 2GB","storage":"30 GB"},"recommended":{"cpu":"Intel Core i7-4790","ram":"8 GB","gpu":"NVIDIA GeForce GTX 780 3GB","storage":"30 GB"}}',
 '30 GB', 0, 0, 0, 0, 1),

-- 26. HELLDIVERS 2
(26, 'HELLDIVERS 2', 'The Galaxy''s Last Line of Offence. Enlist in the Helldivers and join the fight for freedom across a hostile galaxy in this fast, frantic third-person shooter. Spread managed democracy through superior firepower.', 7, '2024-02-08', 39.99, 20.00, 31.99, 'M',
 'https://cdn.akamai.steamstatic.com/steam/apps/553850/header.jpg',
 'https://cdn.akamai.steamstatic.com/steam/apps/553850/library_600x900_2x.jpg',
 'https://www.youtube.com/watch?v=UC4iMRB3Unc',
 '{"minimum":{"cpu":"Intel Core i7-4790K","ram":"8 GB","gpu":"NVIDIA GeForce GTX 1050 Ti","storage":"100 GB SSD"},"recommended":{"cpu":"Intel Core i7-9700K","ram":"16 GB","gpu":"NVIDIA GeForce RTX 2060","storage":"100 GB SSD"}}',
 '100 GB', 0, 0, 0, 1, 1),

-- 27. God of War Ragnarok
(27, 'God of War Ragnarok', 'Kratos and Atreus must journey across all Nine Realms as they face Asgardian forces and the threat of Ragnarok. Fimbulwinter is well underway and the world grows ever colder.', 7, '2024-09-19', 59.99, 10.00, 53.99, 'M',
 'https://cdn.akamai.steamstatic.com/steam/apps/2322010/header.jpg',
 'https://cdn.akamai.steamstatic.com/steam/apps/2322010/library_600x900_2x.jpg',
 'https://www.youtube.com/watch?v=EE-4GvjKcfs',
 '{"minimum":{"cpu":"Intel Core i5-8600","ram":"8 GB","gpu":"NVIDIA GeForce GTX 1070","storage":"190 GB SSD"},"recommended":{"cpu":"Intel Core i5-11600K","ram":"16 GB","gpu":"NVIDIA GeForce RTX 3060","storage":"190 GB SSD"}}',
 '190 GB', 0, 0, 0, 1, 1),

-- 28. Horizon Zero Dawn Remastered
(28, 'Horizon Zero Dawn Remastered', 'Experience Aloy''s legendary quest in stunning detail. Unravel the mysteries of a world ruled by machines in this remastered edition with enhanced visuals, improved performance, and all DLC included.', 7, '2024-10-31', 49.99, 15.00, 42.49, 'T',
 'https://cdn.akamai.steamstatic.com/steam/apps/2561580/header.jpg',
 'https://cdn.akamai.steamstatic.com/steam/apps/2561580/library_600x900_2x.jpg',
 'https://www.youtube.com/watch?v=u4-FCsiF5x4',
 '{"minimum":{"cpu":"Intel Core i3-8100","ram":"8 GB","gpu":"NVIDIA GeForce GTX 1050 Ti 4GB","storage":"100 GB"},"recommended":{"cpu":"Intel Core i5-8600","ram":"16 GB","gpu":"NVIDIA GeForce RTX 2070","storage":"100 GB"}}',
 '100 GB', 0, 0, 0, 0, 1),

-- 29. Star Wars Jedi: Survivor
(29, 'Star Wars Jedi: Survivor', 'The story of Cal Kestis continues in this third-person galaxy-spanning action-adventure game. Five years after Fallen Order, Cal must stay one step ahead of the Empire. Discover new Force abilities and lightsaber stances.', 4, '2023-04-28', 69.99, 30.00, 48.99, 'T',
 'https://cdn.akamai.steamstatic.com/steam/apps/1774580/header.jpg',
 'https://cdn.akamai.steamstatic.com/steam/apps/1774580/library_600x900_2x.jpg',
 'https://www.youtube.com/watch?v=VRaobDJjiec',
 '{"minimum":{"cpu":"Intel Core i7-7700K","ram":"8 GB","gpu":"NVIDIA GeForce GTX 1070","storage":"155 GB SSD"},"recommended":{"cpu":"Intel Core i5-11600K","ram":"16 GB","gpu":"NVIDIA GeForce RTX 2070","storage":"155 GB SSD"}}',
 '155 GB', 0, 0, 0, 0, 1),

-- 30. Palworld
(30, 'Palworld', 'Fight, farm, build and work alongside mysterious creatures called "Pals". Explore a vast open world in this multiplayer, open-world survival crafting game. Catch Pals to fight, build, and explore.', 15, '2024-01-19', 29.99, 0.00, 29.99, 'T',
 'https://cdn.akamai.steamstatic.com/steam/apps/1623730/header.jpg',
 'https://cdn.akamai.steamstatic.com/steam/apps/1623730/library_600x900_2x.jpg',
 'https://www.youtube.com/watch?v=SmEJV3pMi5Q',
 '{"minimum":{"cpu":"Intel Core i5-3570K","ram":"16 GB","gpu":"NVIDIA GeForce GTX 1050 2GB","storage":"40 GB"},"recommended":{"cpu":"Intel Core i9-9900K","ram":"32 GB","gpu":"NVIDIA GeForce RTX 2070","storage":"40 GB"}}',
 '40 GB', 0, 0, 0, 0, 1),

-- 31. Hades II (Early Access)
(31, 'Hades II', 'The sequel to the Game of the Year roguelike. As Melinoe, the immortal Princess of the Underworld, battle through the Underworld using dark sorcery to avenge your family against the Titan of Time.', 11, '2024-05-06', 29.99, 0.00, 29.99, 'T',
 'https://cdn.akamai.steamstatic.com/steam/apps/1145350/header.jpg',
 'https://cdn.akamai.steamstatic.com/steam/apps/1145350/library_600x900_2x.jpg',
 'https://www.youtube.com/watch?v=gJNSpUXhskI',
 '{"minimum":{"cpu":"Intel Core i5-8400","ram":"8 GB","gpu":"NVIDIA GeForce GTX 950","storage":"20 GB"},"recommended":{"cpu":"Intel Core i7-8700","ram":"16 GB","gpu":"NVIDIA GeForce GTX 1060","storage":"20 GB"}}',
 '20 GB', 0, 0, 0, 0, 1),

-- 32. Ghost of Tsushima: Director''s Cut
(32, 'Ghost of Tsushima: Director''s Cut', 'In 1274, the Mongol empire invaded Japan. As one of the last surviving samurai, you must forge a new path — the path of the Ghost — and wage an unconventional war for the freedom of Tsushima.', 7, '2024-05-16', 59.99, 15.00, 50.99, 'M',
 'https://cdn.akamai.steamstatic.com/steam/apps/2215430/header.jpg',
 'https://cdn.akamai.steamstatic.com/steam/apps/2215430/library_600x900_2x.jpg',
 'https://www.youtube.com/watch?v=Ur0pQblaZcE',
 '{"minimum":{"cpu":"Intel Core i3-7100","ram":"8 GB","gpu":"NVIDIA GeForce GTX 960","storage":"75 GB SSD"},"recommended":{"cpu":"Intel Core i5-8600","ram":"16 GB","gpu":"NVIDIA GeForce RTX 2060","storage":"75 GB SSD"}}',
 '75 GB', 0, 0, 0, 1, 1),

-- 33. It Takes Two
(33, 'It Takes Two', 'Embark on the craziest journey of your life in this genre-bending co-op adventure. Invite a friend to join for free with the Friend''s Pass. Play as Cody and May, a couple on the verge of divorce turned into dolls.', 4, '2021-03-26', 39.99, 50.00, 19.99, 'T',
 'https://cdn.akamai.steamstatic.com/steam/apps/1426210/header.jpg',
 'https://cdn.akamai.steamstatic.com/steam/apps/1426210/library_600x900_2x.jpg',
 'https://www.youtube.com/watch?v=GAWHzGNcbEQ',
 '{"minimum":{"cpu":"Intel Core i3-2100T","ram":"8 GB","gpu":"NVIDIA GeForce GTX 660","storage":"50 GB"},"recommended":{"cpu":"Intel Core i5-3570K","ram":"16 GB","gpu":"NVIDIA GeForce GTX 980","storage":"50 GB"}}',
 '50 GB', 0, 0, 0, 0, 1);

SET IDENTITY_INSERT Games OFF;
GO

-- =============================================
-- GAME CATEGORIES for new games
-- =============================================
INSERT INTO GameCategories (GameID, CategoryID) VALUES
(9, 1),   -- Elden Ring -> RPG
(9, 2),   -- Elden Ring -> Action
(10, 2),  -- God of War -> Action
(10, 5),  -- God of War -> Adventure
(11, 1),  -- Hogwarts Legacy -> RPG
(11, 5),  -- Hogwarts Legacy -> Adventure
(12, 1),  -- Baldur's Gate 3 -> RPG
(12, 4),  -- Baldur's Gate 3 -> Strategy
(13, 2),  -- Black Myth Wukong -> Action
(13, 1),  -- Black Myth Wukong -> RPG
(14, 2),  -- Sekiro -> Action
(14, 5),  -- Sekiro -> Adventure
(15, 2),  -- DOOM Eternal -> Action
(16, 2),  -- Hades -> Action
(16, 1),  -- Hades -> RPG
(17, 4),  -- Stardew Valley -> Strategy
(17, 5),  -- Stardew Valley -> Adventure
(18, 2),  -- Hollow Knight -> Action
(18, 5),  -- Hollow Knight -> Adventure
(19, 2),  -- Dying Light 2 -> Action
(19, 5),  -- Dying Light 2 -> Adventure
(19, 1),  -- Dying Light 2 -> RPG
(20, 2),  -- Jedi Fallen Order -> Action
(20, 5),  -- Jedi Fallen Order -> Adventure
(21, 2),  -- Spider-Man -> Action
(21, 5),  -- Spider-Man -> Adventure
(22, 2),  -- Resident Evil 4 -> Action
(22, 5),  -- Resident Evil 4 -> Adventure
(23, 5),  -- Detroit -> Adventure
(23, 4),  -- Detroit -> Strategy
(24, 1),  -- Skyrim -> RPG
(24, 5),  -- Skyrim -> Adventure
(25, 1),  -- Fallout 4 -> RPG
(25, 2),  -- Fallout 4 -> Action
(25, 5),  -- Fallout 4 -> Adventure
(26, 2),  -- HELLDIVERS 2 -> Action
(27, 2),  -- GoW Ragnarok -> Action
(27, 5),  -- GoW Ragnarok -> Adventure
(28, 1),  -- Horizon ZD -> RPG
(28, 2),  -- Horizon ZD -> Action
(28, 5),  -- Horizon ZD -> Adventure
(29, 2),  -- Jedi Survivor -> Action
(29, 5),  -- Jedi Survivor -> Adventure
(30, 5),  -- Palworld -> Adventure
(30, 4),  -- Palworld -> Strategy
(31, 2),  -- Hades II -> Action
(31, 1),  -- Hades II -> RPG
(32, 2),  -- Ghost of Tsushima -> Action
(32, 5),  -- Ghost of Tsushima -> Adventure
(33, 5),  -- It Takes Two -> Adventure
(33, 2);  -- It Takes Two -> Action
GO

-- =============================================
-- ADDITIONAL GAME IMAGES (screenshots)
-- =============================================
INSERT INTO GameImages (GameID, ImagePath, ImageType, DisplayOrder) VALUES
(9,  'https://cdn.akamai.steamstatic.com/steam/apps/1245620/ss_e80a907c2c43337e53316c71555c023df3f3bce3.jpg', 'screenshot', 1),
(9,  'https://cdn.akamai.steamstatic.com/steam/apps/1245620/ss_c372274833ae6e5437b952fa1979430546a43ad9.jpg', 'screenshot', 2),
(10, 'https://cdn.akamai.steamstatic.com/steam/apps/1593500/ss_f6aa297cf195c0408da6a66b498694467d649e6a.jpg', 'screenshot', 1),
(10, 'https://cdn.akamai.steamstatic.com/steam/apps/1593500/ss_ae44317e3bd07b7b696e52b79a68ef8e4e649a26.jpg', 'screenshot', 2),
(11, 'https://cdn.akamai.steamstatic.com/steam/apps/990080/ss_f72f29a16cbc2193e5e9642fb83a80d8c1b34787.jpg', 'screenshot', 1),
(11, 'https://cdn.akamai.steamstatic.com/steam/apps/990080/ss_04accc3b30b292ec32d8b4a2be3d5f24cc77e26c.jpg', 'screenshot', 2),
(12, 'https://cdn.akamai.steamstatic.com/steam/apps/1086940/ss_c73bc54415178c07faa3a8e9b3032c4a7e55a45b.jpg', 'screenshot', 1),
(12, 'https://cdn.akamai.steamstatic.com/steam/apps/1086940/ss_59e5b09d8fac6d7467b6b8cc6e8a4f90c6fceb24.jpg', 'screenshot', 2),
(13, 'https://cdn.akamai.steamstatic.com/steam/apps/2358720/ss_1.jpg', 'screenshot', 1),
(14, 'https://cdn.akamai.steamstatic.com/steam/apps/814380/ss_15f57eadc43cf7d8271b1d8b1eb4e17a088b46f8.jpg', 'screenshot', 1),
(15, 'https://cdn.akamai.steamstatic.com/steam/apps/782330/ss_6455ad37ae9d6bb4ee1cb51e1e8bbbdb04cf0805.jpg', 'screenshot', 1),
(16, 'https://cdn.akamai.steamstatic.com/steam/apps/1145360/ss_7e3b7e7d6a61c0d6e1e47f0cb8a1e5f0a0e0c0c0.jpg', 'screenshot', 1),
(17, 'https://cdn.akamai.steamstatic.com/steam/apps/413150/ss_b887651a93b0525739049eb4194f633de2df75be.jpg', 'screenshot', 1),
(18, 'https://cdn.akamai.steamstatic.com/steam/apps/367520/ss_5765cb0b50b3b2e0b8ce8e2e2c2e0e2e0c2c2c2c.jpg', 'screenshot', 1),
(21, 'https://cdn.akamai.steamstatic.com/steam/apps/1817070/ss_53c6c02cf5b0e0e5b2e0b8ce8e2e2c2e0e2e0c2c.jpg', 'screenshot', 1),
(22, 'https://cdn.akamai.steamstatic.com/steam/apps/2050650/ss_7e3b7e7d6a61c0d6e1e47f0cb8a1e5f0a0e0c0c0.jpg', 'screenshot', 1),
(26, 'https://cdn.akamai.steamstatic.com/steam/apps/553850/ss_5e0c6c02cf5b0e0e5b2e0b8ce8e2e2c2e0e2e0c2c.jpg', 'screenshot', 1),
(27, 'https://cdn.akamai.steamstatic.com/steam/apps/2322010/ss_7e3b7e7d6a61c0d6e1e47f0cb8a1e5f0a0e0c0c0.jpg', 'screenshot', 1),
(32, 'https://cdn.akamai.steamstatic.com/steam/apps/2215430/ss_5e0c6c02cf5b0e0e5b2e0b8ce8e2e2c2e0e2e0c2c.jpg', 'screenshot', 1);
GO

-- =============================================
-- ADDITIONAL REVIEWS for new games
-- =============================================
INSERT INTO Reviews (GameID, UserID, Rating, ReviewText) VALUES
(9,  3, 5, 'Elden Ring is an absolute masterpiece. The open world design combined with FromSoftware''s combat makes this the best game of 2022 hands down.'),
(9,  4, 4, 'Incredible game but the difficulty can be punishing. The lore is deep and the world is breathtaking. Highly recommended.'),
(9,  6, 5, 'Every corner has something to discover. The boss fights are legendary. This game will be remembered for decades.'),
(10, 3, 5, 'God of War on PC is incredible. The story of Kratos and Atreus is emotionally powerful. Ultra-wide support is a nice touch.'),
(10, 4, 5, 'One of the best action games ever made. The Leviathan Axe feels amazing to throw. The port is excellent.'),
(11, 4, 4, 'The wizarding world has never looked this good. Flying on a broom over Hogwarts at sunset is magical. Some side quests are repetitive.'),
(11, 6, 5, 'As a Harry Potter fan this is a dream come true. The Room of Requirement is my favorite place in any game. Beautiful.'),
(12, 3, 5, 'Baldur''s Gate 3 is the greatest RPG of the decade. The freedom of choice is unprecedented. Every playthrough feels completely different.'),
(12, 6, 5, 'Over 200 hours and still finding new things. The writing is phenomenal. Larian has set a new standard for RPGs.'),
(13, 3, 5, 'Black Myth Wukong is visually stunning. The combat is fluid and challenging. Chinese mythology brought to life in spectacular fashion.'),
(13, 4, 4, 'Beautiful world and satisfying combat. Some boss fights are frustrating but the sense of achievement is worth it.'),
(14, 3, 5, 'Sekiro is the most satisfying combat system in any game. Once it clicks, every deflect feels incredible. Game of the Year for a reason.'),
(16, 4, 5, 'Hades is the perfect roguelike. The story progresses with every run and the characters are wonderfully written. Addictive gameplay loop.'),
(16, 6, 4, 'Incredible art style and voice acting. The gameplay gets tighter with each weapon and boon combination. A masterclass in game design.'),
(17, 3, 5, 'Stardew Valley is pure joy. The perfect game to relax after a long day. Eric Barone is a genius for making this alone.'),
(17, 4, 5, 'Over 500 hours played and still going. The 1.6 update added so much. Best farming sim ever made.'),
(18, 6, 5, 'Hollow Knight is the best metroidvania ever created. The atmosphere, music, and level design are perfect. An indie masterpiece.'),
(21, 3, 4, 'Swinging through New York never gets old. The story is great and the combat is flashy. Solid PC port.'),
(22, 4, 5, 'Resident Evil 4 Remake is survival horror at its finest. The updated graphics and gameplay make Leon''s mission feel fresh again.'),
(24, 3, 5, 'Skyrim is timeless. Even after all these years, nothing matches the feeling of exploring Tamriel. Mods extend the life infinitely.'),
(26, 6, 4, 'HELLDIVERS 2 is the most fun I''ve had in co-op. Calling in orbital strikes on bugs is never boring. Democracy delivers!'),
(27, 4, 5, 'God of War Ragnarok is the perfect sequel. The Nine Realms are spectacular and the emotional beats hit hard. Must play.'),
(32, 3, 5, 'Ghost of Tsushima is beautiful. The samurai combat is elegant and the island of Tsushima is one of the most stunning open worlds ever.'),
(33, 4, 5, 'It Takes Two is the best co-op game ever made. Every level introduces a completely new mechanic. Hazelight is so creative.');
GO

-- =============================================
-- UPDATE all game ratings based on reviews
-- =============================================
UPDATE Games SET 
    AverageRating = (SELECT AVG(CAST(Rating AS DECIMAL(3,2))) FROM Reviews WHERE Reviews.GameID = Games.GameID),
    TotalReviews = (SELECT COUNT(*) FROM Reviews WHERE Reviews.GameID = Games.GameID)
WHERE GameID IN (SELECT DISTINCT GameID FROM Reviews);
GO

-- =============================================
-- ADDITIONAL WISHLIST entries
-- =============================================
INSERT INTO Wishlist (UserID, GameID) VALUES
(3, 13),  -- John wants Black Myth Wukong
(3, 11),  -- John wants Hogwarts Legacy
(3, 27),  -- John wants GoW Ragnarok
(4, 9),   -- Jane wants Elden Ring
(4, 13),  -- Jane wants Black Myth Wukong
(4, 21),  -- Jane wants Spider-Man
(4, 26),  -- Jane wants HELLDIVERS 2
(6, 12),  -- Sarah wants Baldur's Gate 3
(6, 22),  -- Sarah wants RE4 Remake
(6, 32),  -- Sarah wants Ghost of Tsushima
(6, 11),  -- Sarah wants Hogwarts Legacy
(3, 32),  -- John wants Ghost of Tsushima
(4, 17);  -- Jane wants Stardew Valley
GO

PRINT 'Data2: 25 additional games, 10 publishers, categories, screenshots, reviews, and wishlists inserted successfully!';
GO
