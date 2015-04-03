class ProjectCommentsController < ApplicationController
  before_action :set_project_comment, only: [:show, :edit, :update, :destroy]

  def index
    @project_comments = ProjectComment.all
  end

  def show
  end

  def new
    @project_comment = ProjectComment.new
  end

  def edit
  end

  def create
    @project_comment = ProjectComment.new(project_comment_params)
    @project_comment.user_id = current_user_id

    respond_to do |format|
      if @project_comment.save
        project_post = @project_comment.project_post
        project_comments = ProjectComment.where(project_post_id: project_post.id)
        #javascript = "alert('#{current_user.email} has posted in project');"

        project_comments.each do |project_comment|
          Notification.create( user_id: project_comment.user_id, 
                               actor_id: current_user_id,
                               verb: 'Commented on project',
                               notification_type: 'ProjectComment',
                               message: "#{current_user.email} has commented on a post",
                               link: project_post_path(project_post.id),
                               isRead: false )
          
          #PrivatePub.publish_to("/inbox/#{project_comment.user_id}",javascript)
        end
      
        Activity.create( user_id: current_user_id,
                         activity_type: 'comment',
                         source_id: @project_comment.id,
                         parent_id: project_post.id,
                         parent_type: 'project_post')

        format.html { redirect_to project_path(params[:project_id]), notice: 'Project comment was successfully created.' }
        format.js
        format.json { render :show, status: :created, location: @project_comment }
      else
        format.html { render :new }
        format.json { render json: @project_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @project_comment.update(project_comment_params)
        format.html { redirect_to @project_comment.project_post.project, notice: 'Project comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @project_comment }
      else
        format.html { render :edit }
        format.json { render json: @project_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project_comment.destroy
    respond_to do |format|
      format.html { redirect_to project_path(params[:project_id]), notice: 'Project comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_project_comment
      @project_comment = ProjectComment.find(params[:id])
    end

    def project_comment_params
      params.require(:project_comment).permit(:project_post_id, :text)
    end
end
