# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
r = Recipe.create(title: 'pasta y fagoli', description: 'macaroni and beans')
r.ingredients.create(amount: 1, uom: UnitOfMeasure::CUP, name: 'pasta')
r.ingredients.create(amount: 1/2.0, uom: UnitOfMeasure::CUP, name: 'celery')
r.ingredients.create(amount: 1, uom: UnitOfMeasure::TSP, name: 'oregano')
r.instructions.create(step: 1, text: 'cook pasta')
r.instructions.create(step: 2, text: 'saute celery')
r.instructions.create(step: 3, text: 'add oregano')

r = Recipe.create(title: 'cinnamon toast', description: 'yum')
r.ingredients.create(amount: 1, uom: UnitOfMeasure::SLICE, name: 'bread')
r.ingredients.create(amount: 1/8.0, uom: UnitOfMeasure::TSP, name: 'cinnamon')
r.ingredients.create(amount: 1/4.0, uom: UnitOfMeasure::TSP, name: 'sugar')
r.ingredients.create(amount: 1/2.0, uom: UnitOfMeasure::TSP, name: 'butter')
r.instructions.create(step: 1, text: 'toast bread')
r.instructions.create(step: 2, text: 'spread butter on toast')
r.instructions.create(step: 3, text: 'mix cinnamon and sugar')
r.instructions.create(step: 4, text: 'sprinkle mixture evenly on toast')


