-- Searching for the crime report on the murder that happened on the January 15th 2018 in SQL City
SELECT * FROM crime_scene_report
WHERE date = 20180115 AND type="murder" AND city="SQL City"

-- Output:
-- Security footage shows that there were 2 witnesses. 
-- The first witness lives at the last house on "Northwestern Dr". 
-- The second witness, named Annabel, lives somewhere on "Franklin Ave".	

-- Looking for the name of the two witnesses
SELECT * FROM person
WHERE address_street_name = "%Northwestern Dr%" 
ORDER BY address_number DESC

-- Output: 
-- id	name	license_id	address_number	address_street_name	ssn
-- 14887	Morty Schapiro	118009	4919	Northwestern Dr	111564949

SELECT * FROM person
WHERE name LIKE "%Annabel%" AND address_street_name LIKE "%Franklin Ave%"

-- Output:
-- id	name	license_id	address_number	address_street_name	ssn
-- 16371	Annabel Miller	490173	103	Franklin Ave	318771143

-- Looking for their witnesses report
SELECT * FROM interview
WHERE person_id=14887 OR person_id=16371

-- output
-- person_id	transcript
-- 14887	I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. The membership number on the bag started with "48Z". Only gold members have those bags. The man got into a car with a plate that included "H42W".
-- 16371	I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th.

-- Look for all the person that worked out on January 9th   

SELECT * FROM get_fit_now_check_in
WHERE check_in_date = 20180109 AND membership_id LIKE '48Z%'

-- output: 2 member
-- membership_id	check_in_date	check_in_time	check_out_time
-- 48Z7A	20180109	1600	1730
-- 48Z55	20180109	1530	1700

-- Checking the name and membership_status of those 2 persons
SELECT * FROM get_fit_now_member
WHERE id = "48Z7A" OR id = "48Z55"

-- output: They are both gold membership, both man so still not clear which one it can
-- id	person_id	name	membership_start_date	membership_status
-- 48Z55	67318	Jeremy Bowers	20160101	gold
-- 48Z7A	28819	Joe Germuska	20160305	gold

--Checking the licence_id in order to check after the plate number

SELECT * FROM person
WHERE id = "67318" OR id = "28819"

-- Output
-- id	name	license_id	address_number	address_street_name	ssn
-- 28819	Joe Germuska	173289	111	Fisk Rd	138909730
-- 67318	Jeremy Bowers	423327	530	Washington Pl, Apt 3A	871539279

-- Checking the number plate of the 2 licence_id

SELECT * FROM drivers_license
WHERE id = "173289" OR id = "423327"

-- Output: Only one output, the other has no car. The plate_number 0H42W2 matches with the witnesses report
-- id	age	height	eye_color	hair_color	gender	plate_number	car_make	car_model
-- 423327	30	70	brown	brown	male	0H42W2	Chevrolet	Spark LS

-- THE MURDERER IS JEREMY BOWERS. 

-- Let's check now his interview transcript
SELECT * FROM interview
WHERE person_id=67318

-- output:
-- I was hired by a woman with a lot of money. 
-- I don't know her name but I know she's around 5'5" (65") or 5'7" (67"). 
-- She has red hair and she drives a Tesla Model S. 
-- I know that she attended the SQL Symphony Concert 3 times in December 2017.

-- Checking who in drivers_license meets the description
SELECT * FROM drivers_license
WHERE (height BETWEEN 65 AND 67) AND hair_color="red" AND gender="female" AND car_make="Tesla" AND car_model="Model S"

-- output:
-- id	age	height	eye_color	hair_color	gender	plate_number	car_make	car_model
-- 202298	68	66	green	red	female	500123	Tesla	Model S
-- 291182	65	66	blue	red	female	08CM64	Tesla	Model S
-- 918773	48	65	black	red	female	917UU3	Tesla	Model S

-- Checking their name and id:
SELECT * FROM person
WHERE license_id=202298 OR license_id=291182 OR license_id=918773

-- output:
-- id	name	license_id	address_number	address_street_name	ssn
-- 78881	Red Korb	918773	107	Camerata Dr	961388910
-- 90700	Regina George	291182	332	Maple Ave	337169072
-- 99716	Miranda Priestly	202298	1883	Golden Ave	987756388

-- Checking their revenues with the ssn
SELECT * FROM income
WHERE ssn=961388910 OR ssn=337169072 OR ssn=987756388

-- output : Only two outcomes, both have similar revenues presumably high, and third persons can not be excluded based on that
-- ssn	annual_income
-- 961388910	278000
-- 987756388	310000

-- Checking their facebook events with their id

SELECT * FROM facebook_event_checkin
WHERE person_id=78881 OR person_id=90700 OR person_id=99716

-- output: the person with 99716 id (Miranda Priestly) has indeed attended 3 times the SQL Symphony Concert in December 2017
-- person_id	event_id	event_name	date
-- 99716	1143	SQL Symphony Concert	20171206
-- 99716	1143	SQL Symphony Concert	20171212
-- 99716	1143	SQL Symphony Concert	20171229

-- The murderer is JEREMY BOWERS, and the brain behind is MIRANDA PRIESTLY