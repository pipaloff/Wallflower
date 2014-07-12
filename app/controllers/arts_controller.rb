class ArtsController < ApplicationController
  before_action :set_art, only: [:show, :edit, :update, :destroy]

  def authorize

      gon.code = params[:code]
      #pass in the code to get the access token
      gon.access_token_response = HTTParty.get("https://www.deviantart.com/oauth2/token?"+
      "grant_type=authorization_code&"+
      "client_id=1479&"+
      "client_secret=ff642ac312683d522fedcb531330d5a0&"+
      "code="+gon.code.to_s+"&"+
      "redirect_uri=http://wallflower.herokuapp.com/authorize"
      )

      #pass in the access token to get the username
      gon.username_response = HTTParty.get("https://www.deviantart.com/api/v1/oauth2/user/whoami?"+"access_token="+gon.access_token_response["access_token"].to_s)

      #pass in the username to access favorites
      redirect_to("http://"+gon.username_response["username"].to_s+".deviantart.com/favourites/?"+"access_token="+gon.acces_token_response["access_token"].to_s)
  end

  # GET /arts
  # GET /arts.json
  def index
    @arts = Art.all
  end

  # GET /arts/1
  # GET /arts/1.json
  def show
  end

  # GET /arts/new
  def new
    @art = Art.new
  end

  # GET /arts/1/edit
  def edit
  end

  # POST /arts
  # POST /arts.json
  def create
    @art = Art.new(art_params)

    respond_to do |format|
      if @art.save
        format.html { redirect_to @art, notice: 'Art was successfully created.' }
        format.json { render :show, status: :created, location: @art }
      else
        format.html { render :new }
        format.json { render json: @art.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /arts/1
  # PATCH/PUT /arts/1.json
  def update
    respond_to do |format|
      if @art.update(art_params)
        format.html { redirect_to @art, notice: 'Art was successfully updated.' }
        format.json { render :show, status: :ok, location: @art }
      else
        format.html { render :edit }
        format.json { render json: @art.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /arts/1
  # DELETE /arts/1.json
  def destroy
    @art.destroy
    respond_to do |format|
      format.html { redirect_to arts_url, notice: 'Art was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_art
      @art = Art.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def art_params
      params[:art]
    end
end
