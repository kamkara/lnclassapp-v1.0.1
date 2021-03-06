class AdminController < ApplicationController

  before_action :authenticate_user!
  before_action :find_materials
  before_action :find_levels
  before_action :find_courses
  before_action :find_posts
  before_action :find_messages
  before_action :find_users

  def index
    
    @Nb_sujets          = Course.all
    @NmbrePosts         =Post.all
    @NmbreMessages      = Message.all
    @NmbreUsers         = User.all.order("created_at desc")
    @NmbreDailyCourses  = Course.where(:created_at => 1.day.ago..Time.now)
    @DailyMessages      = Message.where(:created_at => 1.day.ago..Time.now).order("created_at desc")
    @NmbreDailyPosts    = Post.where(:created_at => 1.day.ago..Time.now)
    @NbDailyUsers       = User.where(:created_at => 1.day.ago..Time.now ).order("created_at desc")
    @NbDailyStutents       = @NbDailyUsers.where("role= ?", "Student")
    @DailyUsers         = User.where(:current_sign_in_at => 1.day.ago..Time.now)
  end
  #@NbDailyUsersByCity = @NbDailyUsers.where("role= ?", "Student")
  #@StudentsByCity        = User.where("city= ?  AND :role= ?", current_user.city, "Student")
  ##@DailyUsersByCity   = User.where("create_at= ?  AND :city=?", "1.day.ago..Time.now",  current_user.city)
  #@ProfsByCity        = User.where("city= ?  AND :role= ?", current_user.city, "Teacher")
  #@SuperProfsByCity   = User.where("city= ?  AND :role= ?", current_user.city, "Super prof")

  private
  #enable material
    def find_materials
      @materials = Material.all
    end

    #enable level
    def find_levels
      @levels = Level.all
    end
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
