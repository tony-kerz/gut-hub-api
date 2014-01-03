json.extract! recipe, :title, :description
json.url recipe_url(recipe, format: :json)
json.ingredients recipe.ingredients, :amount, :uom, :name
json.instructions recipe.instructions, :step, :text
