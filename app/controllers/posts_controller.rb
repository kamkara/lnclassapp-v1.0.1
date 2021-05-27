class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course, only: [:create, :edit, :show, :update, :destroy]
  before_action :set_post, only: %i[ show edit update destroy ]


  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = @course.posts.build
  end

  # GET /posts/1/edit
  def edit
    @course = Course.find(params[:course_id])
    @post = @course.posts.find(params[:id])
  end

  # POST /posts or /posts.json
  def create
    @post = @course.posts.create(post_params)
    @post.user_id = current_user.id

    respond_to do |format|
      if @post.save
        format.html { redirect_to course_path(@course) }
        format.js # renders create.js.erb
      else
        format.html { redirect_to course_path(@course), notice: "post did not save. Please try again."}
        format.js
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    @post = @course.posts.friendly.find(params[:id])
     respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to course_path(@course), notice: 'post was successfully updated.' }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post = @course.posts.friendly.find(params[:id])
    @post.destroy
    redirect_to course_path(@course)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
     def set_course
      @course = Course.friendly.find(params[:course_id])
    end
    
    def set_post
      @post = Post.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:content, :slug, :user_id, :course_id)
    end
end
