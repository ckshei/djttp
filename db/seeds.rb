# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
User.create([{uid:1}, {uid:2}, {uid:3}])
Event.create([{name:"party", host_id:1}])
EventGuest.create({event_id:1, guest_id:1})
