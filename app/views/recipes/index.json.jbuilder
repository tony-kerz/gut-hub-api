#json.array!(@recipes) do |recipe|
#  json.extract! recipe, :title, :description
#  json.url recipe_url(recipe, format: :json)
#  json.ingredients recipe.ingredients, :amount, :uom, :name
#  json.instructions recipe.instructions, :order, :text
#end
json.array! @recipes, partial: 'recipes/recipe', as: :recipe