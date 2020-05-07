feature 'adding bookmarks' do
  scenario 'user adds a single bookmark' do
    insert_bookmark

    expect(page).to have_content('http://www.testwebsite.com')
    expect(page).to have_content('Test Website:')
  end
end
