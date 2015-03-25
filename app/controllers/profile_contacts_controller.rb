class ProfileContactsController < ApplicationController
  before_action :set_profile_contact, only: [:show, :swap, :edit, :update, :destroy]

  # # GET /profile_contacts
  # # GET /profile_contacts.json
  # def index
  #   @profile_contacts = ProfileContact.all
  # end
  #
  # # GET /profile_contacts/1
  # # GET /profile_contacts/1.json
  # def show
  # end
  #
  # # GET /profile_contacts/new
  # def new
  #   @profile_contact = ProfileContact.new
  # end
  #
  # # GET /profile_contacts/1/edit
  # def edit
  # end

  # AJAX purposes only.
  # GET /profile_contact/swap/1
  def swap
    return unless check_permission
    respond_to do |format|
      format.js
    end
  end

  # GET /profile_contact/add/:profile_id
  def add
    @profile_contact = ProfileContact.new(profile_id: params[:profile_id])
    return unless check_permission
    respond_to do |format|
      format.js
    end
  end

  # POST /profile_contacts
  # POST /profile_contacts.json
  def create
    @profile_contact = ProfileContact.new(profile_contact_params)
    return unless check_permission
    respond_to do |format|
      if @profile_contact.save
        format.html { redirect_to @profile_contact, notice: 'Profile contact was successfully created.' }
        format.js
        format.json { render :show, status: :created, location: @profile_contact }
      else
        format.html { render :new }
        format.json { render json: @profile_contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profile_contacts/1
  # PATCH/PUT /profile_contacts/1.json
  def update
    return unless check_permission
    respond_to do |format|
      if @profile_contact.update(profile_contact_params)
        format.html { redirect_to @profile_contact, notice: 'Profile contact was successfully updated.' }
        format.js
        format.json { render :show, status: :ok, location: @profile_contact }
      else
        format.html { render :edit }
        format.json { render json: @profile_contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # # DELETE /profile_contacts/1
  # # DELETE /profile_contacts/1.json
  # def destroy
  #   @profile_contact.destroy
  #   respond_to do |format|
  #     format.html { redirect_to profile_contacts_url, notice: 'Profile contact was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
  def check_permission
    @user_is_owner_of_profile = has_profile_permission? @profile_contact
    redirect_to root_url, notice: 'Wrong Permissions' unless @user_is_owner_of_profile
    return false unless @user_is_owner_of_profile
    true
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_profile_contact
    @profile_contact = ProfileContact.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def profile_contact_params
    params.require(:profile_contact).permit(:profile_id, :contact_type, :name, :link)
  end
end
