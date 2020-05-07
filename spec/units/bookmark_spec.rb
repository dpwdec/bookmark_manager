require 'bookmark'

describe Bookmark do
  describe '.all' do
    it 'returns all bookmarks' do

      connection = PG.connect(dbname: 'bookmark_manager_test')

      # Add the test data
      connection.exec("INSERT INTO bookmarks(url, title) VALUES ('http://www.makersacademy.com', 'Makers Academy');")
      connection.exec("INSERT INTO bookmarks(url, title) VALUES('http://www.google.com', 'Google');")
      connection.exec("INSERT INTO bookmarks(url, title) VALUES('http://www.destroyallsoftware.com', 'Destroy All Software');")

      bookmarks = Bookmark.all

      expect(bookmarks[0].url).to eq("http://www.makersacademy.com")
      expect(bookmarks[1].url).to eq("http://www.google.com")
      expect(bookmarks[2].url).to eq("http://www.destroyallsoftware.com")

      expect(bookmarks[0].title).to eq("Makers Academy")
      expect(bookmarks[1].title).to eq("Google")
      expect(bookmarks[2].title).to eq("Destroy All Software")
    end
  end

  describe '.add' do
    it 'adds a new bookmark' do
      bookmark = Bookmark.add('http://www.testwebsite.com', 'Test Website')
      expect(bookmark['url']).to eq('http://www.testwebsite.com')
    end
  end

  describe '.update' do
    it 'updates a bookmark' do
      bookmark = Bookmark.add('http://www.testwebsite.com', 'Test Website')
      another_bookmark = Bookmark.update(bookmark['id'], bookmark['url'], 'Another Website')
      expect(bookmark['title']).not_to eq(another_bookmark['title'])
    end
  end

  describe '.delete' do
    it 'deletes a bookmark' do
      Bookmark.add('http://www.testwebsite.com', 'Test Website')
      expect { Bookmark.delete('Test Website') }.to change { Bookmark.all.length }.by(-1)
    end
  end

  describe '.get_by_id' do
    it 'gets a specific bookmark' do
      connection = PG.connect(dbname: 'bookmark_manager_test')
      connection.exec("INSERT INTO bookmarks(id, url, title) VALUES (1, 'http://www.makersacademy.com', 'Makers Academy');")
      bookmark = Bookmark.get_by_id(1)
      expect(bookmark.id).to eq(1)
    end
  end


  describe 'title and url arguments' do

    let(:subject) { described_class.new(1, 'http://www.makersacademy.com', 'Makers Academy')}

    it 'returns the title' do
      expect(subject.title).to eq ('Makers Academy')
    end

    it 'returns the url' do
      expect(subject.url).to eq ('http://www.makersacademy.com')
    end

    it 'return the id' do
      expect(subject.id).to eq(1)
    end
  end
end
