require 'bundler/setup'
Bundler.require

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL']||"sqlite3:db/development.db")

class User < ActiveRecord::Base
  has_secure_password

  has_many :comedy_storys
  has_many :likes
  has_many :funnys
  has_many :relationships

  validates :mail,
    presence: true,
    format: {with:/.+@.+/}
  validates :password,
    length: {in: 5..10}
end

class Relationship < ActiveRecord::Base

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