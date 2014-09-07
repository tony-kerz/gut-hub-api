# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def force_user email: email, role: role
  user = User.where(email: email).first
  if user
    p "user=#{email} exists, destorying and recreating with role=#{role}..."
    user.destroy
  else
    p "user=#{email} not found, creating with role=#{role}..."
  end
  user = User.create!(email: email, password: 'pw', password_confirmation: 'pw')
  user.add_role role
end

p 'seeding roles...'
role_names = %w(admin user)

role_names.each do |role_name|
  #Role.find_or_create_by_name({ :name => role }, :without_protection => true)
  role = Role.where(name: role_name).first
  if role.nil?
    p "role=#{role_name} not found, creating..."
    Role.create(name: role)
  else
    p "role=#{role} already exists..."
  end
end

p 'seeding admins...'
emails = %w(admin@guthub.com a@b.co)
emails.each { |email| force_user email: email, role: :admin }

p 'seeding users...'
emails = %w(user@guthub.com)
emails.each { |email| force_user email: email, role: :user }

###

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

r = Recipe.create(title: 'hawaiian pizza', description: 'pizza with ham and pineapples')
r.ingredients.create(amount: 1, uom: UnitOfMeasure::SLICE, name: 'pineapple')
r.ingredients.create(amount: 1/8.0, uom: UnitOfMeasure::TSP, name: 'ham')
r.ingredients.create(amount: 1/4.0, uom: UnitOfMeasure::TSP, name: 'pizza pie')
r.ingredients.create(amount: 1/2.0, uom: UnitOfMeasure::TSP, name: 'cheese')
r.instructions.create(step: 1, text: 'cooka da pizza')
r.instructions.create(step: 2, text: 'putta da stuff')
r.instructions.create(step: 3, text: 'eata da pizza')
r.instructions.create(step: 4, text: 'throwa uppa da pizza')
