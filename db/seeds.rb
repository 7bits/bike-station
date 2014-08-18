# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Rent.destroy_all
User.destroy_all
Station.destroy_all
Bike.destroy_all
Rate.destroy_all
Admin.destroy_all

station_1 = Station.create(name: 'Иртышская набережная', latitude: 54.968094, longitude: 73.378906, gates_count: 10)
station_2 = Station.create(name: 'Омская крепость', latitude: 54.982530, longitude: 73.370534, gates_count: 10)
station_3 = Station.create(name: 'Речной порт', latitude: 54.946384, longitude: 73.375287, gates_count: 10)
station_4 = Station.create(name: 'Парк культуры и отдыха', latitude: 54.972240, longitude: 73.412647, gates_count: 10)
station_5 = Station.create(name: 'СКК имени Виктора Блинова', latitude: 54.975311, longitude: 73.394763, gates_count: 10)
 
bike_1 = Bike.create(name: 'default_1', station: station_1, uuid: '8457bf43-81c8-44b1-8ba5-c85575a1a4c8')
bike_2 = Bike.create(name: 'default_2', station: station_1, uuid: 'f221414e-d4cc-4587-a275-d691e3591c68')
bike_3 = Bike.create(name: 'default_3', station: station_2, uuid: '0d641816-faa3-4977-8187-202760e7e3e8')
bike_4 = Bike.create(name: 'default_4', station: station_2, uuid: '9b65ab96-7266-437c-b10d-d992979e4658')

rate_1 = Rate.create(name: 'Тариф "Спортивный"', price: 10)

Admin.create(email: 'verify-operators@smart-bikes.ru')