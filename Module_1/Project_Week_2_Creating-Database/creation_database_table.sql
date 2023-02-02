CREATE DATABASE Education;

USE Education;

CREATE TABLE IF NOT EXISTS Countries (
	country_code VARCHAR(255),
    country_name VARCHAR(255),
    PRIMARY KEY(country_code)
);

CREATE TABLE IF NOT EXISTS government_expenditure (
	country_code VARCHAR(255),
    expenditure FLOAT,
    FOREIGN KEY(country_code) REFERENCES Countries(country_code)
);

CREATE TABLE IF NOT EXISTS labor_force_advanced_edu (
	country_code VARCHAR(255),
    labor_force_advanced_education FLOAT,
    FOREIGN KEY(country_code) REFERENCES Countries(country_code)
);

CREATE TABLE IF NOT EXISTS university_enrollment_rate (
	country_code VARCHAR(255),
    university_enrollment FLOAT,
    FOREIGN KEY(country_code) REFERENCES Countries(country_code)
);

CREATE TABLE IF NOT EXISTS unemployment_advanced_edu (
	country_code VARCHAR(255),
	unemployment_advanced FLOAT,
    FOREIGN KEY(country_code) REFERENCES Countries(country_code)
);

