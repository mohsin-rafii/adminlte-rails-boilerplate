class WelcomeController < ApplicationController
  def home
    #it is giving all authors , but we dont need all of them..
    @authors = User.where(role: "author")
    #we onyl need the one who are subscribed by the reader.
    if current_user
      user = User.where(id: current_user.id)
      @subscribed_authors = user.first.subscribers
    end
    
    #deburger
  end

  def change_subscribe_status
    #######if the subscribed button is pressed
    #get the auhtor id
    #find current user id
    #make the changes
    if (params[:choice_type] == "follow")
      user_status = UserSubscriber.new
      #reader id
      user_status.user_id = current_user.id
      ########coming from the params 
      user_status.subscriber_id = User.find(params[:author_id]).id
      user_status.save
      #deburger
    else
      #dsada
      user_status = UserSubscriber.find_by(user_id: current_user.id , subscriber_id: params[:author_id])
      #dsdsa
      user_status.delete
      #here
      user = User.find(params[:author_id])
      #here
      user_comments = Comment.where(user_id: current_user.id , post_id: user.posts.ids)
      #deburger 
      user_comments.delete_all
    end
    #now it will go to the action method first
    redirect_to action: "home"
    # if we use render it will just look for the page .
    #post = Post.find(params[:pid]) 
  end
end
