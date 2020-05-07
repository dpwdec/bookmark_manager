feature 'bookmark/:id/edit' do
  scenario 'user can edit the url' do
    connection = PG.connect(dbname: 'bookmark_manager_test')

    connection.exec("INSERT INTO bookmarks VALUES(1, 'http://www.makersacademy.com', 'Makers');")
    visit('/bookmarks')
    find(:id, '1 edit').click
    fill_in('url', with: 'http://www.another-website.com')
    click_button('submit')
    expect(page).to have_content('http://www.another-website.com')
  end

  scenario 'user can edit both url and title' do
    connection = PG.connect(dbname: 'bookmark_manager_test')

    connection.exec("INSERT INTO bookmarks VALUES(1, 'http://www.makersacademy.com', 'Makers');")
    visit('/bookmarks')
    find(:id, '1 edit').click
    fill_in('title', with: 'Another Website')
    fill_in('url', with: 'http://www.another-website.com')
    click_button('submit')
    expect(page).to have_content('http://www.another-website.com')
    expect(page).to have_content('Another Website')
  end
end
