class ProjectToTagsController < ApplicationController
  before_action :set_project_to_tag, only: [:show, :edit, :update, :destroy]

  # GET /project_to_tags
  # GET /project_to_tags.json
  def index
    set_user_project_env
    # Security Clearance
    if @user_to_project and @is_owner
      @project_to_tags = @project.project_to_tags
    end
  end

  # GET /project_to_tags/1
  # GET /project_to_tags/1.json
  def show
  end

  # GET /project_to_tags/new
  def new
    @project_to_tag = ProjectToTag.new
  end

  # GET /project_to_tags/1/edit
  def edit
  end

  # POST /project_to_tags
  # POST /project_to_tags.json
  def create
    @project_to_tag = ProjectToTag.new(project_to_tag_params)

    respond_to do |format|
      if @project_to_tag.save
        format.html { redirect_to @project_to_tag, notice: 'Project to tag was successfully created.' }
        format.json { render :show, status: :created, location: @project_to_tag }
      else
        format.html { render :new }
        format.json { render json: @project_to_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /project_to_tags/1
  # PATCH/PUT /project_to_tags/1.json
  def update
    respond_to do |format|
      if @project_to_tag.update(project_to_tag_params)
        format.html { redirect_to @project_to_tag, notice: 'Project to tag was successfully updated.' }
        format.json { render :show, status: :ok, location: @project_to_tag }
      else
        format.html { render :edit }
        format.json { render json: @project_to_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /project_to_tags/1
  # DELETE /project_to_tags/1.json
  def destroy
    @project_to_tag.destroy
    respond_to do |format|
      format.html { redirect_to project_to_tags_url, notice: 'Project to tag was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project_to_tag
      @project_to_tag = ProjectToTag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_to_tag_params
      params.require(:project_to_tag).permit(:project_id, :project_tag_id)
    end
end
