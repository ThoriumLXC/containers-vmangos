---
--- Custom User Accounts
---

INSERT INTO realmd.account (`id`, `username`, `gmlevel`, `sessionkey`, `v`, `s`, `token_key`, `email`, `joindate`, `last_ip`, `failed_logins`, `locked`, `lock_country`, `last_login`, `online`, `expansion`, `mutetime`, `locale`, `os`, `platform`, `current_realm`, `flags`, `security`, `email_verif`, `geolock_pin`) 
VALUES
    (2, 'PLAYER', 0, NULL, '35F47F7DC31BBFA22FF64DB5D16D1F4286729D669026C95C4196F6ABE4A96E0D', '8193C70E3F3E52CA24D0928DDEB2F553B220224AE68C9D7A2D73B04E689E9E23', '', NULL, '2025-01-01 00:00:00', '0.0.0.0', 0, 0, '00', '0000-00-00 00:00:00', 0, 0, 0, 0, '', '', 0, 0, NULL, 0, 0),
    (3, 'MODERATOR', 0, NULL, '62CC406F717920F3F67F8548102DC7D3A48EE5E2DF0E1403304F405544D083AF', 'EF2E76023E3A86B5F9D656FDF4B409398331387D1C3B4431F1CF747C70B71331', '', NULL, '2025-01-01 00:00:00', '0.0.0.0', 0, 0, '00', '0000-00-00 00:00:00', 0, 0, 0, 0, '', '', 0, 0, NULL, 0, 0),
    (4, 'GAMEMASTER', 0, NULL, '2D803949A1A92F301B3881BAC35879EAD4CBE0503DFBB2E0301C280240CB9E74', '82D19B52D05BD203C6B74599CA909A1305243F697AAE45C343F991458726EDA7', '', NULL, '2025-01-01 00:00:00', '0.0.0.0', 0, 0, '00', '0000-00-00 00:00:00', 0, 0, 0, 0, '', '', 0, 0, NULL, 0, 0),
    (5, 'ADMINISTRATOR', 0, NULL, '36A0C299D3E35B7F15C5EEF746FFDD8A3A6B69E35FD4E54D13CDB9C6279FDF8D', 'BA433188212299612B4DC12316F04E04EF92A4B31F692B1AE4E89CC60913AF6F', '', NULL, '2025-01-01 00:00:00', '0.0.0.0', 0, 0, '00', '0000-00-00 00:00:00', 0, 0, 0, 0, '', '', 0, 0, NULL, 0, 0);

INSERT INTO realmd.account_access (`id`, `gmlevel`, `RealmID`)
VALUES
    (2, 0, 1),
    (3, 1, 1),
    (4, 3, 1),
    (5, 6, 1);

INSERT INTO realmd.realmcharacters (`realmid`, `acctid`, `numchars`)
VALUES
    (1, 2, 0),
    (1, 3, 0),
    (1, 4, 0),
    (1, 5, 0);
