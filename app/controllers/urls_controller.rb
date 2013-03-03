class UrlsController < ApplicationController
  before_action :set_url, only: [:update, :destroy]
  before_action :set_access_token, only: [:edit, :show]

  # GET /urls
  # GET /urls.json
  def index
    @url = Url.new
    @links = [@url.links.build]
  end

  # GET /urls/1
  # GET /urls/1.json
  def show
  end

  # GET /urls/new
  def new
    @url = Url.new
    @links = [@url.links.build]
  end

  # GET /urls/1/edit
  def edit
    @links = @url.links
  end

  def redirect
    @url = Url.find_by(access_token: params[:id])
    link = @url.links.random.first
    link.update( count: link.count + 1)
    redirect_to "#{link.address}"
  end

  # POST /urls
  # POST /urls.json
  def create
    @url = Url.new(url_params)
    @url.access_token_set

    respond_to do |format|
      if @url.save
        format.html { redirect_to url_path(@url.access_token), notice: '短縮URLを作成しました。' }
        format.json { render action: 'show', status: :created, location: @url }
      else
         @links =  (@url.links.blank? ? [@url.links.build] : @url.links)

        format.html { render action: 'new' }
        format.json { render json: @url.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /urls/1
  # PATCH/PUT /urls/1.json
  def update
    respond_to do |format|
      if @url.update(url_params)
        format.html { redirect_to @url, notice: 'Url was successfully updated.' }
        format.json { head :no_content }
      else
        @links =  (@url.links.blank? ? [@url.links.build] : @url.links)
        format.html { render action: 'edit' }
        format.json { render json: @url.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /urls/1
  # DELETE /urls/1.json
  def destroy
    @url.destroy
    respond_to do |format|
      format.html { redirect_to urls_url }
      format.json { head :no_content }
    end
  end

  def new_link_form
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_url
      @url = Url.find(params[:id])
    end

    def set_access_token
       @url = Url.find_by( access_token: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def url_params
      params.require(:url).permit(:links_attributes => [:id , :address, :_destroy])
    end
end
