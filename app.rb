require 'sinatra/base'
require './lib/bookmark'

class BookmarkManager < Sinatra::Base

  use Rack::MethodOverride

  get '/' do
    'Bookmark Manager'
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb (:'all_bookmarks')
  end

  post '/bookmarks' do
    Bookmark.add(params[:url], params[:title])
    redirect('/bookmarks')
  end

  delete '/bookmarks' do
    Bookmark.delete(params[:title])
    redirect('/bookmarks')
  end

  run! if app_file == $0
end
