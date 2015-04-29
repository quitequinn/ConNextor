class InvitationRequestsController < ApplicationController

  # GET /invitation_requests
  # GET /invitation_requests.json
  def index
    # TODO add security
    @invitation_requests = InvitationRequest.all
  end

  # GET /invitation_requests/new
  def new
    @invitation_request = InvitationRequest.new
    @interests = Interest.all
  end

  # POST /invitation_requests
  # POST /invitation_requests.json
  def create
    @invitation_request = InvitationRequest.new(invitation_request_params)

    respond_to do |format|
      if @invitation_request.save
        format.html { redirect_to root_path, notice: 'Invitation received. We will notify you soon!' }
        format.json { render :show, status: :created, location: @invitation_request }
      else
        @interests = Interest.all
        format.html { render :new }
        format.json { render json: @invitation_request.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def invitation_request_params
      params.require(:invitation_request).permit(:name, :email, :expertise, :github, :linkedin, :portfolio, :message, :resume)
    end
end
