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
  def like_push?(comedy_id)
    Like.find_by(user_id: session[:user],comedy_story_id: comedy_id)
  end
end

helpers do
  def funny_push?(comedy_id)
    Funny.find_by(user_id: session[:user],comedy_story_id: comedy_id)
  end
end

helpers do
  def what_mentor?(user_id)
    User.find_by(id: user_id)
  end
end

helpers do
  def what_camp?(camp_id)
    Camp.find_by(id: camp_id)
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
  @all_comedys = Comedy_story.all.order("id desc")

  erb :home
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

  Comedy_story.find(params[:comedy_id]).destroy

  redirect '/mypage'
end

get '/edit' do
  @edit_story = Comedy_story.find(params[:comedy_id])
  erb :edit
end

post '/edit' do
  content = Comedy_story.find(params[:comedy_story_id])

  content.update({
    funny_comment_body: params[:edit_comedy_body],
  })

  redirect '/mypage'
end

post '/like' do
  Like.create({
    user_id: params[:user_id],
    comedy_story_id: params[:like_to_comedy_id],
  })

  content = Comedy_story.find(params[:comedy_id])
  content.good_count = content.good_count + 1
  content.save

  redirect '/'
end

post '/unlike' do
  Like.find_by(user_id: session[:user], comedy_id: params[:comedy_id]).destroy

  content = Comedy_story.find(params[:comedy_id])
  content.good_count = content.good_count - 1
  content.save

  redirect '/'
end

post 'funny' do
  Funny.create({
    user_id: params[:user_id],
    comedy_story_id: params[:funny_to_comedy_id],
  })

  content = Comedy_story.find(params[:comedy_id])
  content.funny_count = content.funny_count + 1.5
  content.save

  redirect '/'
end

post '/unfunny' do
  Funny.find_by(user_id: session[:user], comedy_id: params[:comedy_id]).destroy

  content = Comedy_story.find(params[:comedy_id])
  content.funny_count = content.funny_count - 1.5
  content.save

  redirect '/'
end

post '/follow' do
  Relationship.create({
    user_id: session[:user],
    follow_user_id: params[:follow_id],
  })

  redirect '/'
end



post '/unfollow' do
  Relationship.find_by(user_id: session[:user], follow_id: params[:follow_id]).destroy

  redirect '/'
end

get '/post' do
  @all_camps = Camp.all.order("id desc")

  erb :post
end

post '/post_comedy' do
  Comedy_story.create({
    user_id: params[:user_id],
    camp_id: params[:camp_id],
    funny_comment_body: params[:comment_body],
  })
  redirect '/'
end

get '/mypage' do
  @user_comedys = Comedy_story.where(user_id: session[:user])
  erb :mypage
end
