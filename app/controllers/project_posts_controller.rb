class ProjectPostsController < ApplicationController
  before_action :set_project_post, only: [:show, :edit, :update, :destroy]

  # GET /project_posts
  # GET /project_posts.json
  def index
    @project_posts = ProjectPost.all
  end

  # GET /project_posts/1
  # GET /project_posts/1.json
  def show
  end

  # GET /project_posts/new
  def new
    @project_post = ProjectPost.new
  end

  # GET /project_posts/1/edit
  def edit
  end

  # POST /project_posts
  # POST /project_posts.json
  def create
    @project_post = ProjectPost.new(project_post_params)

    respond_to do |format|
      if @project_post.save
        format.html { redirect_to @project_post, notice: 'Project post was successfully created.' }
        format.json { render :show, status: :created, location: @project_post }
      else
        format.html { render :new }
        format.json { render json: @project_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /project_posts/1
  # PATCH/PUT /project_posts/1.json
  def update
    respond_to do |format|
      if @project_post.update(project_post_params)
        format.html { redirect_to @project_post, notice: 'Project post was successfully updated.' }
        format.json { render :show, status: :ok, location: @project_post }
      else
        format.html { render :edit }
        format.json { render json: @project_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /project_posts/1
  # DELETE /project_posts/1.json
  def destroy
    @project_post.destroy
    respond_to do |format|
      format.html { redirect_to project_posts_url, notice: 'Project post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project_post
      @project_post = ProjectPost.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_post_params
      params.require(:project_post).permit(:user_id, :project_id, :text)
    end
end
