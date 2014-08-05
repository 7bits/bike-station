# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
station_1 = Station.create(name: 'Иртышская набережная', latitude: 54.968094, longitude: 73.378906, gates_count: 10)
station_2 = Station.create(name: 'Омская крепость', latitude: 54.982530, longitude: 73.370534, gates_count: 10)

bike_1 = Bike.create(station: station_1, uuid: '8457bf43-81c8-44b1-8ba5-c85575a1a4c8')
bike_2 = Bike.create(station: station_1, uuid: 'f221414e-d4cc-4587-a275-d691e3591c68')
bike_3 = Bike.create(station: station_2, uuid: '0d641816-faa3-4977-8187-202760e7e3e8')
bike_4 = Bike.create(station: station_2, uuid: '9b65ab96-7266-437c-b10d-d992979e4658')