# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Tea.create(title: "Matcha", description: "Good 'ol Matcha Tea", temperature: 90, brew_time: "60")
Tea.create(title: "Yerba Mate", description: "Good 'ol Yerba Mate", temperature: 100, brew_time: "120")
Tea.create(title: "Green Tea", description: "Good 'ol Green Tea", temperature: 85, brew_time: "70")
