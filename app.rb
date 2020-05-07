require 'sinatra/base'
require './lib/bookmark'

#$verbose = true

class BookmarkManager < Sinatra::Base

  use Rack::MethodOverride

  before '/' do
    verbose_output(request.url) if $verbose
  end

  get '/' do
    redirect('/bookmarks')
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

  patch '/bookmarks' do
    Bookmark.update(params[:id], params[:url], params[:title])
    redirect('/bookmarks')
  end

  get '/bookmarks/:id/edit' do
    @bookmark = Bookmark.get_by_id(params[:id])
    erb(:edit_bookmark)
  end

  run! if app_file == $0

  private

  def verbose_output(where)
    puts "\n#{where}"
    puts "session: "; p session
    puts "params: "; p params
  end
end
