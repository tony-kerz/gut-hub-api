#json.extract! @recipe, :title, :description, :created_at, :updated_at
json.partial! 'recipes/recipe', recipe: @recipe