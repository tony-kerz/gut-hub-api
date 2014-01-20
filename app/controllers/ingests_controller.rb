class IngestsController < ApplicationController
  #before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  before_filter :authenticate_user!

  def index
    ingests = Ingest.all
    @ingest_folder = Settings.ingest_folder
    logger.debug {"ingest_folder=#{@ingest_folder}"}
    if logger.debug?
      ingests.each_index {|idx| log.debug {"ingest[#{idx}]: #{ingests[idx]}"}}
    end
    @files = []
    Dir.glob("#{@ingest_folder}/*") do |file_name|
      ingest = ingests.find {|ingest| ingest.file_name == file_name }
      file = { name: File.basename(file_name), time: File.mtime(file_name), size: File.size(file_name), ingest: ingest}
      @files.push(file)
      logger.debug {"processed file_name=#{file}..." }
    end
  end

  def create
    #@recipe = Recipe.new(recipe_params)
    logger.debug {"params=#{params}"}
    render nothing: true
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.json
  def destroy
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to recipes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recipe_params
      params.require(:recipe).permit(:title, :description)
    end
end
