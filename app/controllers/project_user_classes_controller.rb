class ProjectUserClassesController < ApplicationController
  before_action :set_project_user_class, only: [:show, :edit, :update, :destroy]

  # GET /project_user_classes
  # GET /project_user_classes.json
  def index
    @project_user_classes = ProjectUserClass.all
  end

  # GET /project_user_classes/1
  # GET /project_user_classes/1.json
  def show
  end

  # GET /project_user_classes/new
  def new
    @project_user_class = ProjectUserClass.new
  end

  # GET /project_user_classes/1/edit
  def edit
  end

  # POST /project_user_classes
  # POST /project_user_classes.json
  def create
    @project_user_class = ProjectUserClass.new(project_user_class_params)

    respond_to do |format|
      if @project_user_class.save
        format.html { redirect_to @project_user_class, notice: 'Project user class was successfully created.' }
        format.json { render :show, status: :created, location: @project_user_class }
      else
        format.html { render :new }
        format.json { render json: @project_user_class.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /project_user_classes/1
  # PATCH/PUT /project_user_classes/1.json
  def update
    respond_to do |format|
      if @project_user_class.update(project_user_class_params)
        format.html { redirect_to @project_user_class, notice: 'Project user class was successfully updated.' }
        format.json { render :show, status: :ok, location: @project_user_class }
      else
        format.html { render :edit }
        format.json { render json: @project_user_class.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /project_user_classes/1
  # DELETE /project_user_classes/1.json
  def destroy
    @project_user_class.destroy
    respond_to do |format|
      format.html { redirect_to project_user_classes_url, notice: 'Project user class was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project_user_class
      @project_user_class = ProjectUserClass.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_user_class_params
      params.require(:project_user_class).permit(:name)
    end
end
