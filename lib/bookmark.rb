require 'pg'

class Bookmark

  attr_reader :id, :url, :title

  def initialize(id, url, title)
    @id = id
    @url = url
    @title = title
  end

  def self.all
    bookmarks = []

    result = connect_to_database.exec('SELECT * FROM bookmarks;')
    result.each do |row|
      bookmarks << Bookmark.new(row['id'], row['url'], row['title'])
    end

    bookmarks
  end

  def self.add(url, title)
    connect_to_database.exec("INSERT INTO bookmarks(url, title) VALUES ('#{url}', '#{title}')")
  end

  def self.delete(title)
    connect_to_database.exec("DELETE FROM bookmarks WHERE title = '#{title}'")
  end

  private

  def self.connect_to_database
    if ENV['ENVIRONMENT'] == 'test'
      PG.connect :dbname => 'bookmark_manager_test'
    else
      PG.connect :dbname => 'bookmark_manager'
    end
  end
end
