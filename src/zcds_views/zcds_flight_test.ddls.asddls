@AbapCatalog.sqlViewName: 'ZCDS_SQL_TEST'
@EndUserText.label: 'Flight Data CDS View'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view ZCDS_FLIGHT_TEST as 
select 
from zscarr_test as airline
inner join zsflight_test as flight
  on airline.carrid = flight.carrid
{
   airline.carrid as airline_code,
   airline.carrname as airline_name,
   airline.currcode as curr_code,
   flight.connid as connection_id,
   flight.fldate as flight_date,
   flight.price as price,
   flight.currency as currency,
   flight.seatsmax as max_seats,
   flight.seatsocc as occupied_seats
}