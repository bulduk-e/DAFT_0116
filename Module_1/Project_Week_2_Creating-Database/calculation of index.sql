USE Education;

CREATE TABLE Education.index_expenditure
SELECT country_code, expenditure, (( expenditure - (SELECT MIN(expenditure) FROM government_expenditure)) / ((SELECT MAX(expenditure) FROM government_expenditure) - (SELECT MIN(expenditure) FROM government_expenditure))  ) AS index_expenditure
FROM government_expenditure;

CREATE TABLE Education.index_laborforce
SELECT country_code, labor_force_advanced_education, (( labor_force_advanced_education - (SELECT MIN(labor_force_advanced_education) FROM labor_force_advanced_edu)) / ((SELECT MAX(labor_force_advanced_education) FROM labor_force_advanced_edu) - (SELECT MIN(labor_force_advanced_education) FROM labor_force_advanced_edu))  ) AS index_laborforce
FROM labor_force_advanced_edu;

CREATE TABLE Education.index_unemployment
SELECT country_code, unemployment_advanced, (( unemployment_advanced - (SELECT MIN(unemployment_advanced) FROM unemployment_advanced_edu)) / ((SELECT MAX(unemployment_advanced) FROM unemployment_advanced_edu) - (SELECT MIN(unemployment_advanced) FROM unemployment_advanced_edu))  ) AS index_unemployment
FROM unemployment_advanced_edu;

CREATE TABLE Education.index_university
SELECT country_code, university_enrollment, (( university_enrollment - (SELECT MIN(university_enrollment) FROM university_enrollment_rate)) / ((SELECT MAX(university_enrollment) FROM university_enrollment_rate) - (SELECT MIN(university_enrollment) FROM university_enrollment_rate))  ) AS index_university
FROM university_enrollment_rate;

CREATE TABLE Education.index_recap
SELECT countries.country_code, countries.country_name, index_expenditure.index_expenditure, index_laborforce.index_laborforce, 1-index_unemployment.index_unemployment as index_unemployment, index_university.index_university
FROM countries
LEFT JOIN index_expenditure
ON countries.country_code = index_expenditure.country_code
LEFT JOIN index_laborforce
ON countries.country_code = index_laborforce.country_code
LEFT JOIN index_unemployment
ON countries.country_code = index_unemployment.country_code
LEFT JOIN index_university
ON countries.country_code = index_university.country_code;

SELECT * FROM index_recap;

# weight: 
# expenditure : 0.20
# laborforce : 0.21
# unemployment : 0.27
# university : 0.32

SELECT country_name, ((index_expenditure*0.2) + (index_laborforce*0.21) + (index_unemployment*0.27) + (index_university*0.32))*100 as country_quality_score
FROM index_recap
ORDER BY country_quality_score DESC;

SELECT countries.country_code, countries.country_name, round(index_expenditure.index_expenditure,3) as index_expenditure, round(index_laborforce.index_laborforce,3) as index_laborforce, round(index_unemployment.index_unemployment,3) as index_unemployment, round(index_university.index_university,3) as index_university
FROM countries
LEFT JOIN index_expenditure
ON countries.country_code = index_expenditure.country_code
LEFT JOIN index_laborforce
ON countries.country_code = index_laborforce.country_code
LEFT JOIN index_unemployment
ON countries.country_code = index_unemployment.country_code
LEFT JOIN index_university
ON countries.country_code = index_university.country_code;