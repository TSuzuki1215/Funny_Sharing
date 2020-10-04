require 'bundler/setup'
Bundler.require

require 'sinatra/reloader' if development?

require './models'
require 'dotenv/load'

enable :sessions

before do
  Dotenv.load
  Cloudinary.config do |config|
    config.cloud_name = ENV["CLOUD_NAME"]
    config.api_key = ENV["CLOUDINARY_API_KEY"]
    config.api_secret = ENV["CLOUDINARY_API_SECRET"]
  end

end

helpers do
  def current_user
    User.find_by(id: session[:user])
  end
end

helpers do
  def following?(other_user)
    Relationship.find_by(user_id: session[:user],follow_id: other_user)
  end
end

helpers do
  def like_push?(comedy_id)
    Like.find_by(user_id: session[:user],comedy_story_id: comedy_id)
  end
end

helpers do
  def what_mentor?(user_id)
    User.find_by(user_id: user_id)
  end
end

helpers do
  def what_camp?(camp_id)
    Camp.find_by(camp_id: camp_id)
  end
end



get '/' do
  @all_comedys = Comedy_story.all.order("id desc")

  erb :index
end

post '/signin' do
  user = User.find_by(mentor_name: params[:mentor_name])
  if user && user.authenticate(params[:password])
    session[:user] = user.id
  end
  redirect '/'
end

get '/signup' do
  erb :sign_up
end

post '/signup' do
  img_url = ""
  if params[:user_profile]
    img = params[:user_profile]
    tempfile = img[:tempfile]
    upload = Cloudinary::Uploader.upload(tempfile.path)
    img_url = upload["url"]
  end

  user = User.create({
    mentor_name: params[:mentor_name],
    account: params[:account_id],
    password: params[:password],
    password_confirmation: params[:password_confirmation],
    user_profile_img_url: img_url,
    })



  if user.persisted?
    session[:user] = user.id
  end

  redirect '/'
end

get '/home' do
  @user = User.find(session[:user])
  @camps = Camp.all
  follow_user = Relationship.where(user_id: session[:user])

  follow_comedy_story = []

  for i in follow_user.follow_user_id do
    follow_comedy_story.push(Comedy_story.find_by(user_id: i))
  end
  @follow_timeline = follow_comedy_story
  @follow_user_comedy = Comedy_story.where(user_id: follow_user.id)
  erb :home
end

get '/search' do
  erb :search
end

post '/search' do
  @search_artist_name = params[:artist_name]

  res_o = Net::HTTP.get(URI.parse("https://itunes.apple.com/search?term=#{@search_artist_name}&country=US&media=music&limit=30"))
  hash_o = JSON.parse(res_o)

  @search_result = hash_o["results"]

  erb :search
end

get '/signout' do
  session[:user] = nil

  redirect '/'
end

post '/comment' do

  Music.create({
    user_id: session[:user],
    comment: params[:music_comment],
    artist_name: params[:artist_name],
    album_name: params[:album_name],
    music_name: params[:music_name],
    music_img_url: params[:music_img_url],
    sample_music_url: params[:sample_music_url],
  })

  redirect '/home'

end

post '/delete' do

  Music.find(params[:music_id]).destroy

  redirect '/home'
end

get '/edit/:id' do
  @edit_music = Music.find(params[:id])
  erb :edit
end

post '/edit/:id' do
  content = Music.find(params[:id])

  content.update({
    comment: params[:edit_comment],
  })

  redirect '/home'
end

post '/like' do
  Like.create({
    user_id: params[:user_id],
    comedy_story_id: params[:like_to_comedy_id],
  })

  redirect '/'
end

post '/follow' do
  Relationship.create({
    user_id: session[:user],
    follow_id: params[:follow_id],
  })

  redirect '/'
end

post '/unlike' do
  Like.find_by(user_id: session[:user], comedy_id: params[:comedy_id]).destroy

  redirect '/'
end

post '/unfollow' do
  Relationship.find_by(user_id: session[:user], follow_id: params[:follow_id]).destroy

  redirect '/'
end