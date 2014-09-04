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

Station.create(name: 'Иртышская набережная', latitude: 54.968094, longitude: 73.378906)
Station.create(name: 'Омская крепость', latitude: 54.982530, longitude: 73.370534)
Station.create(name: 'Речной порт', latitude: 54.946384, longitude: 73.375287)
Station.create(name: 'Парк культуры и отдыха', latitude: 54.972240, longitude: 73.412647)
Station.create(name: 'СКК имени Виктора Блинова', latitude: 54.975311, longitude: 73.394763)
Station.create(name: 'Фестиваль', latitude: 54.980632, longitude: 73.322986)
Station.create(name: 'ОмГУ ФКН', latitude: 54.036532, longitude: 73.269736)
Station.create(name: 'It-loft', latitude: 54.976856, longitude: 73.3913869)

Rate.create(name: 'Тариф "Спортивный"', price: 1)

Admin.create(email: 'verify-operators@smart-bikes.ru')