class InvitationRequestsController < ApplicationController
  before_action :set_invitation_request, only: [:show, :edit, :update, :destroy]

  # GET /invitation_requests
  # GET /invitation_requests.json
  def index
    @invitation_requests = InvitationRequest.all
  end

  # GET /invitation_requests/1
  # GET /invitation_requests/1.json
  def show
  end

  # GET /invitation_requests/new
  def new
    @invitation_request = InvitationRequest.new
  end

  # GET /invitation_requests/1/edit
  def edit
  end

  # POST /invitation_requests
  # POST /invitation_requests.json
  def create
    @invitation_request = InvitationRequest.new(invitation_request_params)

    respond_to do |format|
      if @invitation_request.save
        format.html { redirect_to @invitation_request, notice: 'Invitation request was successfully created.' }
        format.json { render :show, status: :created, location: @invitation_request }
      else
        format.html { render :new }
        format.json { render json: @invitation_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invitation_requests/1
  # PATCH/PUT /invitation_requests/1.json
  def update
    respond_to do |format|
      if @invitation_request.update(invitation_request_params)
        format.html { redirect_to @invitation_request, notice: 'Invitation request was successfully updated.' }
        format.json { render :show, status: :ok, location: @invitation_request }
      else
        format.html { render :edit }
        format.json { render json: @invitation_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invitation_requests/1
  # DELETE /invitation_requests/1.json
  def destroy
    @invitation_request.destroy
    respond_to do |format|
      format.html { redirect_to invitation_requests_url, notice: 'Invitation request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invitation_request
      @invitation_request = InvitationRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invitation_request_params
      params.require(:invitation_request).permit(:name, :email, :expertise, :github, :linkedin, :portfolio, :message)
    end
end
