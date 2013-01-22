class HomeController < ApplicationController
  before_filter :authenticate_user!, :except => :welcome
  layout :choose_layout
  
  def news
  end
  
  def pictures
  end
  
  def welcome
  end
  
  def start 
    @news = Post.where(:type_is => 'news').paginate(:page => params[:page], :per_page => 2)   
    @disc = Post.where(:type_is => 'discussion').paginate(:page => params[:page], :per_page => 2)   
  end
  
  def index
    @users = User.all
  end

private
  def choose_layout    
    if [ 'events' ].include? action_name
      'blank'
    else
      'application'
    end
  end
end