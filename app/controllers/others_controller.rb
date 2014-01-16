class OthersController < ApplicationController

  def index
    o = Other.new
    o.instance_method
    Other.class_method

    render nothing: true
  end

end