require 'bundler/setup'
Bundler.require

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL']||"sqlite3:db/development.db")

class User < ActiveRecord::Base
  has_secure_password

  has_many :comedy_storys
  has_many :likes
  has_many :funnys
  has_many :relationships

  has_many :followings, through: :relationships, source: :follow_user
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_user_id'
  has_many :followers, through: :reverse_of_relationships, source: :user


  validates :password,
    length: {in: 5..10}

  # def follow(other_user)
  #   unless self == other_user
  #     self.relationships.find_or_create_by(follow_id:other_user.id)
  #   end

  # end

  # def unfollow(other_user)
  #   relationship = self.relationships.find_by(follow_id: other_user.id)
  #   relationship.destroy if relationship
  # end

  def following?(other_user)
    self.followings.include?(other_user)
  end
end

class Relationship < ActiveRecord::Base
  belongs_to :user
  belongs_to :follow_user, class_name: 'User'
  validates :user_id, presence: true
  validates :follow_user_id, presence: true
end

class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :comedy_storys
end

class Funny < ActiveRecord::Base
  belongs_to :user
  belongs_to :comedy_storys
end

class Comedy_story < ActiveRecord::Base
  belongs_to :user
  has_many :likes
  has_many :funnys
end

class Camp < ActiveRecord::Base

end