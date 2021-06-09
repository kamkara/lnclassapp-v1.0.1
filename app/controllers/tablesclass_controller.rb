class TablesclassController < ApplicationController
   before_action :authenticate_user!
   before_action :find_courses
   before_action :find_posts
   before_action :find_messages

  def index
    @courses = Course.all
    @posts =Post.all
    @messages = Message.all
  end
private
  #enable level
    def find_courses
      @courses = Course.all
    end
    def find_posts
      @posts = Post.all
    end
    def find_messages
      @messages = Message.all
    end
end
