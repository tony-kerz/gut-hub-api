class RecipeSerializer < ActiveModel::Serializer

  def serializable_object
    puts "object: #{object.inspect}"
    {
      id: object[:id],
      title: object[:title],
      description: object[:description],
      ingredients: object.ingredients.map do |ingredient|
        {
          name: ingredient[:name],
          amount: ingredient[:amount],
          uom: ingredient[:uom]
        }
      end,
      instructions: object.instructions.map do |step|
        {
          step: step[:step],
          text: step[:text]
        }
      end
    }
  end
end
