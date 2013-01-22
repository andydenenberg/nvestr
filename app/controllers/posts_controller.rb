class PostsController < ApplicationController
  before_filter :authenticate_user!
 
  def add_comment
    @post = Post.find(params[:post])
    @post.comments.new
    render :partial => 'add_comment', :layout => false    
  end

  def add_attachment
    @post = Post.find(params[:post])
    @post.attachments.new
    render :partial => 'add_attachments', :layout => false    
  end
    
  def index
    if params[:type_is] == 'Discussions & News' or params[:type_is] == nil
      type_is = '' 
    else 
      type_is = 'type_is = "' + params[:type_is] + '"' 
    end

    @type_is = 'Discussion' # params[:type_is]
    type_is = 'type_is = "Discussion"'

    @posts = Post.where(type_is).paginate(:page => params[:page], :per_page => 5).order('created_at desc')
    
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    @type_is = params[:type_is]

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @type_is = params[:type_is]
    @post = Post.new
    @post.attachments.build
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    @type_is = params[:type_is]
    
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end
end
