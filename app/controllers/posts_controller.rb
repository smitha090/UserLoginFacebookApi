class PostsController < ApplicationController
    respond_to :html
    # after_action :send_mail, only: [:create]

    def index
      @group = Group.find(params[:group_id])
      @posts = @group.posts
    end

    def show
      @posts = @group.posts
    end

    def new
      @group = Group.find(params[:group_id])
      @post = Post.new
      respond_with(@post)
    end  

    def create
      @group = Group.find(params[:group_id])
      @post = @group.posts.new(post_params)
      @post.save!
      if ['Interior Designing', 'Gardening', 'Home Decorations', 'Cultural Events', 'Pets'].include? @post.text
        send_mail
      end  
      redirect_to group_posts_path
    end  
    
  private
  def post_params
    params.require(:post).permit(:title, :text, :group_id, :user_id)
  end

  def send_mail
    @user = current_user
    UserMailer.notification_confirmation(@user, @group).deliver_now!
  end  

end    