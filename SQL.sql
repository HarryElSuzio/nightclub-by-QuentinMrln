INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
	('society_nightclub','Nightclub',1)
;

INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
	('society_nightclub','Nightclub', 1)
;
INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
	('society_nightclub', 'Nightclub', 1)
;

INSERT INTO `jobs`(`name`, `label`, `whitelisted`) VALUES
	('nightclub', 'Nightclub', 1)
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('nightclub',0,'novice','Videur', 0, '{"tshirt_1":23,"tshirt_2":1,"torso_1":166,"torso_2":0,"shoes_1":25,"shoes_2":0,"pants_1":33,"pants_2":0,"arms":17,"glasses_1":0,"glasses_2":0,"chain_1":0,"chain_2":0,"decals_1":0,"decals_2":0}','{"tshirt_1":20,"tshirt_2":1,"torso_1":163,"torso_2":0,"shoes_1":25,"shoes_2":0,"pants_1":61,"pants_2":9,"arms":34,"glasses_1":5,"glasses_2":0,"chain_1":0,"chain_2":0,"decals_1":0,"decals_2":0}'),
	('nightclub',1,'cdisenior','Barman', 0, '{"tshirt_1":22,"tshirt_2":0,"torso_1":11,"torso_2":0,"shoes_1":9,"shoes_2":2,"pants_1":24,"pants_2":0,"arms":1,"glasses_1":0,"glasses_2":0,"chain_1":0,"chain_2":0,"decals_1":0,"decals_2":0}','{"tshirt_1":24,"tshirt_2":0,"torso_1":28,"torso_2":3,"shoes_1":3,"shoes_2":0,"pants_1":41,"pants_2":2,"arms":0,"glasses_1":5,"glasses_2":0,"chain_1":0,"chain_2":0,"decals_1":0,"decals_2":0}'),
	('nightclub',2,'boss','Patron', 0, '{"tshirt_1":15,"tshirt_2":0,"torso_1":234,"torso_2":0,"shoes_1":12,"shoes_2":6,"pants_1":4,"pants_2":0,"arms":26,"glasses_1":17,"glasses_2":7,"chain_1":15,"chain_2":0,"decals_1":0,"decals_2":0,"helmet_1":77,"helmet_2":9}','{"tshirt_1":3,"tshirt_2":0,"torso_1":67,"torso_2":0,"shoes_1":24,"shoes_2":0,"pants_1":43,"pants_2":0,"arms":35,"glasses_1":5,"glasses_2":0,"chain_1":0,"chain_2":0,"decals_1":0,"decals_2":0}');

INSERT INTO `items` (`name`, `label`) VALUES
	('papier', 'Papier'),
	('flyers', 'Flyers'),
	('adiosmotherfucker', 'Adios Motherfucker'),
	('bacardicocktail', 'Bacardi Cocktail'),
	('cajuamigo', 'Caju Amigo'),
	('douxbaisers', 'Doux Baisers'),
	('episcopale', 'Episcopale'),
	('flamingdrpepper', 'Flaming Dr. Pepper'),
	('grasshopper', 'Grasshopper'),
	('harveywallbanger', 'Harvey Wallbanger'),
	('irishcoffee', 'Irish Coffee'),
	('jacqueline', 'Jacqueline'),
	('kirroyal', 'Kir Royal'),
	('longislandicedtea', 'Long Island Iced Tea'),
	('manhattan', 'Manhattan'),
	('negroni', 'Negroni'),
	('oldfashioned', 'Old fashioned'),
	('pinklady', 'Pink Lady'),
	('quentao', 'Quentão'),
	('rabodegalo', 'Rabo de galo'),
	('sangria', 'Sangria'),
	('tequilasunrise', 'Tequila Sunrise'),
	('vesper', 'Vesper'),
	('whiskyhighball', 'Whisky Highball'),
	('zombie', 'Zombie');