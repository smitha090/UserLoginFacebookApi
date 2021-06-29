class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and 
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[facebook]
  # mount_uploader :image, ImageUploader
  has_many :groups


  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session[“devise.facebook_data”] && session[“devise.facebook_data”][“extra”][“raw_info”]
        user.email = data[“email”] if user.email.blank?
      end
    end
  end
  
  def self.from_omniauth(auth)
    user = User.where(email: auth.info.email).first
    oauth_token = auth.credentials.token
    @graph = Koala::Facebook::API.new(oauth_token)
    my_groups = @graph.get_connections("me", "groups").select 
    
    if user
      user.provider = auth.provider
      user.uid = auth.uid
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.email = auth.info.email
      user.gender = auth.extra.raw_info.gender
      user.location = auth.info.location
      user.create_groups(my_groups)
      user.save!
      user
      
    else
      user = User.new
        user.provider = auth.provider
        user.uid = auth.uid
        user.first_name = auth.info.first_name
        user.last_name = auth.info.last_name
        user.email = auth.info.email
        user.gender = auth.extra.raw_info.gender
        user.password = Devise.friendly_token[0, 20]
        user.location = auth.info.location
        user.create_groups(my_groups)
        user.save!
        user
    end  
    
    user
  end

  def create_groups(my_groups)
    my_groups.each do |item, obj|
      user_group = self.groups.new
      user_group.group_name = item['name']
      user_group.group_id = item['id']
      user_group.save
    end
    
  end  

end
