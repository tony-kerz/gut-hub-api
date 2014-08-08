class RecipeSerializer < ActiveModel::Serializer

  def serializable_object
    {
      id: object[:id],
      title: object[:title],
      description: object[:description]
    }
  end

end
