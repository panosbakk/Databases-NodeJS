CREATE VIEW researcher_info AS 
SELECT DISTINCT 
first_name + ' ' + last_name as full_name,
datediff( YY, researcher.birth_date, getdate()) as age,
sex
FROM ReservationCustomers
INNER JOIN Customers ON ReservationCustomers.Customer_ID = Customers.Customer_ID
INNER JOIN Reservations ON ReservationCustomers.Reservation_ID = Reservations.Reservation_ID
WHERE GETDATE() BETWEEN Arrival AND Departure