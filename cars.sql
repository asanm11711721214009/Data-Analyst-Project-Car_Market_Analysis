create database Car_Market;
use Car_Market;
select*from car_market_analysis;

-- Query 1
 Alter table car_market_analysis rename column MyUnknownColumn to sno;
 
 -- Query 2
 -- checking for null values
SELECT column_name, null_count 
FROM (
    SELECT 'car_name' AS column_name, COUNT(*) AS null_count FROM car_market_analysis WHERE car_name IS NULL
    UNION ALL
    SELECT 'brand' AS column_name, COUNT(*) AS null_count FROM car_market_analysis WHERE brand IS NULL
    UNION ALL
    SELECT 'model' AS column_name, COUNT(*) AS null_count FROM car_market_analysis WHERE model IS NULL
    UNION ALL
    SELECT 'km_driven' AS column_name, COUNT(*) AS null_count FROM car_market_analysis WHERE km_driven IS NULL
    UNION ALL
    SELECT 'seller_type' AS column_name, COUNT(*) AS null_count FROM car_market_analysis WHERE seller_type IS NULL
    UNION ALL
    SELECT 'fuel_type' AS column_name, COUNT(*) AS null_count FROM car_market_analysis WHERE fuel_type IS NULL
    UNION ALL
    SELECT 'transmission_type' AS column_name, COUNT(*) AS null_count FROM car_market_analysis WHERE transmission_type IS NULL
    UNION ALL
    SELECT 'mileage' AS column_name, COUNT(*) AS null_count FROM car_market_analysis WHERE mileage IS NULL
    UNION ALL
    SELECT 'eng' AS column_name, COUNT(*) AS null_count FROM car_market_analysis WHERE eng IS NULL
    UNION ALL
    SELECT 'max_power' AS column_name, COUNT(*) AS null_count FROM car_market_analysis WHERE max_power IS NULL
    UNION ALL
    SELECT 'seats' AS column_name, COUNT(*) AS null_count FROM car_market_analysis WHERE seats IS NULL
    UNION ALL
    SELECT 'selling_price' AS column_name, COUNT(*) AS null_count FROM car_market_analysis WHERE selling_price IS NULL
) as counts ;

-- No null values exist

-- Query 3
-- top 5 brands based on average selling price
select brand as Brand, round(avg(selling_price),0) as avg_selling_price
from car_market_analysis
group by Brand
order by avg_selling_price desc
limit 5;
-- Ferrari has the highest average selling price of 39500000 INR

-- Query 4
-- least 5 brands based on average selling price
select brand as Brand, round(avg(selling_price),0) as avg_selling_price
from car_market_analysis
group by Brand
order by avg_selling_price asc
limit 5;
-- Datsun has the highest average selling price of 345617 INR

-- QUERY 5
-- most sold brand of cars 
select brand as Brand, count(*) as count
from car_market_analysis
group by Brand
order by count desc
limit 1;
-- The most sold brand of cars belongs to Maruti

-- QUERY 6 
-- exploring the vehicle age of used cars being sold
select concat(round(avg(vehicle_age),0), " years")as 'avg vehicle age',
concat(round(max(vehicle_age),0), " years")as 'max vehicle age',
concat(round(min(vehicle_age),0), " years")as 'min vehicle age'
from car_market_analysis;
-- the avg age of vehicles recorded is 6 years, maximum age recorded is 29 years and minimum age recorded is 0 years

-- QUERY 7
 -- checking the top 5 most dominating used cars sold in the market
 select car_name as 'Car Name',
 count(car_name) as 'Count of Cars'
 from car_market_analysis
 group by car_name
 order by count(car_name) desc
 limit 1;
 -- -- Hyundai i20 emerges as the dominating car in the used vehicles market
 
-- QUERY 8
-- checking the most expensive cars in the used cars market on an average
select car_name as 'Car Name',
round(avg(selling_price),0) as 'Average selling price'
from car_market_analysis
group by car_name
order by avg(selling_price) desc
limit 3;
-- Ferrari GTC4Lusso emerges as the car with highest selling price on an average

-- QUERY 9
-- checking the least expensive cars in the used cars market on an average
select car_name as 'Car Name',
round(avg(selling_price),0) as 'Average selling price'
from car_market_analysis
group by car_name
order by avg(selling_price) asc
limit 3;
-- Maruti Alto emerges as the car with lowest selling price on an average

-- QUERY 10
-- statistics for different types of sellers
select seller_type as 'Type of Sellers',
count(*) as 'Count of Cars Sold',
round(avg(selling_price),0) as 'Average Selling Price'
from car_market_analysis
group by  seller_type ;
-- dealers constitute a  significant chunk of seller in the used cars market and average selling price of cars is 858057 INR

-- QUERY 11
 -- getting crucial statistics for each transmission type
 select transmission_type as 'Transmission Type',
round(avg(selling_price),0) as 'Average Selling Price',
round(avg(km_driven),0) as 'Average km Driven',
round(avg(max_power),0) as 'Maximum Power in BHP'
from car_market_analysis
group by transmission_type;
-- automatic cars have higher selling prices on an average as well as maximum power

-- QUERY 12
-- statistics of fuel type
select fuel_type as 'Type of Fuel',
count(*) as 'Count of Vehicles',
round(avg(selling_price),0) as 'Avg Selling Price',
round(avg(km_driven),0) as 'Avg km Driven',
round(avg(mileage),0) as 'Avg Mileage'
from car_market_analysis
group by fuel_type;
-- petrol cars constitute bulk of the market . The highest selling price is of Electric cars,
--  LPG cars have the most km dirven and CNG cars have highest mileage on an average.

-- QUERY 13
-- finding the top 3 overpriced brands
select brand as 'Brand',
round(avg(selling_price),0) as 'Average Selling Price',
round((avg(selling_price)-(select avg(selling_price) from car_market_analysis)),0)as 'Price Difference'
from car_market_analysis
group by brand 
having  avg(selling_price) > (select avg(selling_price) from car_market_analysis)
order by 'Price Difference' DESC
limit 3;
-- Mini Brand is the most overpriced brand in used cars, followed by Mercedes-Benz

-- QUERY 14
-- Top 3 best price deals on used cars
select brand as 'Brand',
round(avg(selling_price),0) as 'Average Selling Price',
round((avg(selling_price)-(select avg(selling_price) from car_market_analysis)),0)as 'Price Difference'
from car_market_analysis
group by brand 
having  avg(selling_price) < (select avg(selling_price) from car_market_analysis)
order by 'Price Difference' ASC
limit 3;
-- Maruti brand emerges as the best deal of used cars after price comparison, followed by Hyundai and Ford

-- QUERY 15
-- analyzing the seats in used cars
select seats, count(*)as 'Count',
 round(avg(selling_price),0) as 'Average Selling Price' ,
 round(avg(mileage),0) as 'Average Mileage' 
 from car_market_analysis
 group by seats;
-- 5 seater cars are predominant in the market and have high mileage on average,
-- The highest selling price on average is of 7 seater cars of 1164031 INR 

-- QUERY 16
-- brands with cars having highest mileage
select brand as "Brand", 
round(avg(mileage),2) as "Average Mileage"
from car_market_analysis
group by brand
order by avg(mileage) DESC
limit 5;
-- maruti cars have highest mileage followed by Lexus

-- QUERY 17
-- brands with cars having lowest mileage
select brand as "Brand", 
round(avg(mileage),2) as "Average Mileage"
from car_market_analysis
group by brand
order by avg(mileage) ASC
limit 5;
-- Ferrari brand cars have the least mileage 