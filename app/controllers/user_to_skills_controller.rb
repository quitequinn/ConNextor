class UserToSkillsController < ApplicationController
  before_action :set_user_to_skill, only: [:show, :edit, :update, :destroy]

  def create
    @user_to_skill = UserToSkill.new(user_to_skill_params)
    @user_is_owner_of_association = has_user_permission?(@user_to_skill)
    return unless @user_is_owner_of_association
    respond_to do |format|
      if @user_to_skill.save
        format.html { redirect_to @user_to_skill, notice: 'User to skill was successfully created.' }
        format.json { render :show, status: :created, location: @user_to_skill }
      else
        format.html { render :new }
        format.json { render json: @user_to_skill.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user_is_owner_of_association = has_user_permission?(@user_to_skill)
    return unless @user_is_owner_of_association
    @user_to_skill.destroy
    respond_to do |format|
      format.html { redirect_to user_to_skills_url, notice: 'User to skill was successfully destroyed.' }
      format.js
      format.json { head :no_content }
    end
  end

  private
    def set_user_to_skill
      @user_to_skill = UserToSkill.find(params[:id])
    end

    def user_to_skill_params
      params.require(:user_to_skill).permit(:user_id, :skill_id)
    end
end
