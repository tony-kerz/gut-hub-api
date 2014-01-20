require 'smarter_csv'

class IngestsController < ApplicationController
  #before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  before_filter :authenticate_user!

  CSV_HEADERS = (1..2).collect {|s| s.to_s.to_sym}

  def index
    ingests = Ingest.all
    @ingest_folder = Settings.ingest_folder
    logger.debug { "ingest_folder=#{@ingest_folder}" }
    if logger.debug?
      ingests.each_index { |idx| log.debug { "ingest[#{idx}]: #{ingests[idx]}" } }
    end
    @files = []
    Dir.glob("#{@ingest_folder}/*") do |file_name|
      ingest = ingests.find { |ingest| ingest.file_name == file_name }
      file = {name: File.basename(file_name), time: File.mtime(file_name), size: File.size(file_name), ingest: ingest}
      @files.push(file)
      logger.debug { "processed file_name=#{file}..." }
    end
  end

  def create
    #@recipe = Recipe.new(recipe_params)
    logger.debug { "create: params=#{params}" }
    file_name = params[:file_name]
    if !file_name
      flash[:alert] = 'file_name required...'
    else
      ingestables = %w(recipe ingredient instruction)
      logger.debug { "create: ingestables=#{ingestables}" }
      ingestable = ingestables.find { |ingestable| file_name.start_with? ingestable }
      logger.debug { "create: identified ingestable=#{ingestable} for file_name=#{file_name}" }
      if !ingestable
        flash[:alert] = "unable to identify ingestable for file-name=#{file_name}..."
      else
        file = File.absolute_path("#{Settings.ingest_folder}/#{file_name}")
        logger.debug { "create: file=#{file}" }
        #total_chunks = SmarterCSV.process(file, {:col_sep => '|', :chunk_size => 2, :headers_in_file => false}) do |chunk|
        total_chunks = SmarterCSV.process(file, {col_sep: '|', headers_in_file: false, user_provided_headers: CSV_HEADERS}) do |chunk|
          chunk.each do |h|
            logger.debug { "create: csv-row=#{h}" }
            props = { title: h[:'1'], description: h[:'2']}
            recipe = Recipe.create(props)
          end
          puts chunk.inspect # we could at this point pass the chunk to a Resque worker..
        end
        logger.debug { "create: chunks=#{total_chunks}..." }
        flash[:notice] = 'file was successfully ingested...'
      end
    end
    redirect_to action: 'index'
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
