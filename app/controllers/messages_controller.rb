class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_message, only: %i[ show edit update destroy ]
  before_action :set_course, only: [:create, :edit, :show, :update, :destroy]

  # GET /messages/1 or /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = @course.messages.build
  end

  # GET /messages/1/edit
   def edit
    @course = Course.find(params[:course_id])
    @message = @course.messages.find(params[:id])
  end

  # POST /messages or /messages.json
  def create
    @message = @course.messages.create(message_params)
    @message.user_id = current_user.id

    respond_to do |format|
      if @message.save
        format.html { redirect_to course_path(@course) }
        format.js # renders create.js.erb
      else
        format.html { redirect_to course_path(@course), notice: "message did not save. Please try again."}
        format.js
      end
    end
  end

  # PATCH/PUT /messages/1 or /messages/1.json
  def update
    @message = @course.messages.friendly.find(params[:id])
     respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to course_path(@course), notice: 'message was successfully updated.' }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1 or /messages/1.json
  def destroy
    @message = @course.messages.friendly.find(params[:id])
    @message.destroy
    redirect_to course_path(@course)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.friendly.find(params[:course_id])
    end
   
    
    def set_message
      @message = Message.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit(:content, :slug, :user_id, :course_id)
    end
end
