class ProfileContactsController < ApplicationController
  before_action :set_profile_contact, only: [:show, :swap, :edit, :update, :destroy]

  def swap
    @user_is_owner_of_profile = has_profile_permission?(@profile_contact)
    return unless @user_is_owner_of_profile
    respond_to do |format|
      format.js
    end
  end

  def add
    @profile_contact = ProfileContact.new(profile_id: params[:profile_id])
    @user_is_owner_of_profile = has_profile_permission?(@profile_contact)
    return unless @user_is_owner_of_profile
    respond_to do |format|
      format.js
    end
  end

  def create
    @profile_contact = ProfileContact.new(profile_contact_params)
    @user_is_owner_of_profile = has_profile_permission?(@profile_contact)
    return unless @user_is_owner_of_profile
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

  def update
    @user_is_owner_of_profile = has_profile_permission?(@profile_contact)
    return unless @user_is_owner_of_profile
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

  def destroy
    @profile_contact.destroy
    respond_to do |format|
      format.html { redirect_to profile_contacts_url, notice: 'Profile contact was successfully destroyed.' }
      format.js
      format.json { head :no_content }
    end
  end

  private
    def set_profile_contact
      @profile_contact = ProfileContact.find(params[:id])
    end

    def profile_contact_params
      params.require(:profile_contact).permit(:profile_id, :contact_type, :name, :link)
    end
end
