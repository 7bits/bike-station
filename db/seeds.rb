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
station_6 = Station.create(name: 'Фестиваль', latitude: 54.980632, longitude: 73.322986, gates_count: 10)
station_7 = Station.create(name: 'ОмГУ ФКН', latitude: 54.036532, longitude: 73.269825, gates_count: 10)
station_8 = Station.create(name: 'It-loft', latitude: 54.976856, longitude: 73.3913869, gates_count: 10)

rate_1 = Rate.create(name: 'Тариф "Спортивный"', price: 1)

Admin.create(email: 'verify-operators@smart-bikes.ru')