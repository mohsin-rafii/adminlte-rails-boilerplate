class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  after_action :verify_authorized, except: [:index, :show]
  #after_action :verify_policy_scoped, only: :index

  # GET /posts
  # GET /posts.json
  def index
    #if user is a author then show him all his posts.
    if current_user.role == "author"
      @posts = Post.where(user_id: current_user.id )
    elsif current_user.role == "admin"
    #uf the user is admin then he can see all the posts
      @posts = Post.all
    else
    #if user is an reader then show him all this posts of authors that he is subscribed to.
      user = User.where(id: current_user.id)
      @subscribed_authors = user.first.subscribers
      #to save relevant posts form all the subscribers
      @posts = Post.where(user_id: @subscribed_authors.ids)
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @comments = @post.comments
  end

  # GET /posts/new
  def new
    @post = Post.new
    authorize @post
  end

  # GET /posts/1/edit
  def edit
    authorize @post
  end

  # POST /posts
  # POST /posts.json
  def create
    #deburger
    @post = Post.new(post_params)
    @post.title = params[:post][:title]
    @post.body = params[:post][:content]
    @post.user_id = current_user.id
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
    authorize @post
    #here
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
    authorize @post
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
    authorize @post
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
      #authorize @post
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :user_id, :body, :content)
    end
end
