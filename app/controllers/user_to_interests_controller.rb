class UserToInterestsController < ApplicationController
  before_action :set_user_to_interest, only: [:show, :edit, :update, :destroy]

  # GET /user_to_interests
  # GET /user_to_interests.json
  def index
    @user_to_interests = UserToInterest.all
  end

  # GET /user_to_interests/1
  # GET /user_to_interests/1.json
  def show
  end

  # GET /user_to_interests/new
  def new
    @user_to_interest = UserToInterest.new
  end

  # GET /user_to_interests/1/edit
  def edit
  end

  # POST /user_to_interests
  # POST /user_to_interests.json
  def create
    @user_to_interest = UserToInterest.new(user_to_interest_params)

    respond_to do |format|
      if @user_to_interest.save
        format.html { redirect_to @user_to_interest, notice: 'User to interest was successfully created.' }
        format.json { render :show, status: :created, location: @user_to_interest }
      else
        format.html { render :new }
        format.json { render json: @user_to_interest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_to_interests/1
  # PATCH/PUT /user_to_interests/1.json
  def update
    respond_to do |format|
      if @user_to_interest.update(user_to_interest_params)
        format.html { redirect_to @user_to_interest, notice: 'User to interest was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_to_interest }
      else
        format.html { render :edit }
        format.json { render json: @user_to_interest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_to_interests/1
  # DELETE /user_to_interests/1.json
  def destroy
    @user_to_interest.destroy
    respond_to do |format|
      format.html { redirect_to user_to_interests_url, notice: 'User to interest was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_to_interest
      @user_to_interest = UserToInterest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_to_interest_params
      params.require(:user_to_interest).permit(:user_id, :interest_id)
    end
end
