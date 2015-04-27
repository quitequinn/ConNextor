class InvitationCodeController < ApplicationController
  # POST invitation_code/validate
  def validate
    @valid = InvitationCode.validate(params[:code])
    respond_to do |format|
      format.js
    end
  end
end
