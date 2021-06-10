class TablesclassController < ApplicationController
before_action :authenticate_user!
before_action :set_course
before_action :set_users

  def index
    @NmbreCourse = Course.all
    @NmbreUser    = User.all
  end

  private
    def set_course
      @course = Course.all
    end

    def set_users
      @user = User.all
    end
end
