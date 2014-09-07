class SessionSerializer < ActiveModel::Serializer

  def serializable_object
    if object
      {
        user: {
          email: object.email,
          roles: object.roles.collect { |role| role.name }
        }
      }
    else
      {
        user: nil
      }
    end
  end

end
