class TablesclassController < ApplicationController
  before_action :authenticate_user!
  before_action :find_courses
  before_action :find_posts
  before_action :find_messages
  before_action :find_users

  def index
    @NmbreCourses  = Course.all
    @NmbrePosts    =Post.all
    @NmbreMessages = Message.all
    @NmbreUsers    = User.all
    @NmbreDailyCourses = Course.where(:created_at => 1.day.ago..Time.now)
    @NmbreDailyMessages = Message.where(:created_at => 1.day.ago..Time.now)
    @NmbreDailyPosts = Post.where(:created_at => 1.day.ago..Time.now)
    @NmbreDailyUsers = User.where(:created_at => 1.day.ago..Time.now)
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
    def find_users
      @users = User.all
    end
end
