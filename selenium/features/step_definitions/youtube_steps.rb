user = "";
url = "";
current_canal = "";

When /^Voy a Youtube$/ do 
    visit "https://youtube.com"
end

Then /^El primer video tiene como autor el usuario dado$/ do 
     expect(find('li:nth-child(2) > div > div > div.yt-lockup-content > div.yt-lockup-byline > a')).to have_content(user)
end

Then /^El primer video no tiene como autor el usuario dado$/ do 
   expect(find('li:nth-child(2) > div > div > div.yt-lockup-content > div.yt-lockup-byline > a')).not_to have_content(user)
end

When /^Hago la búsqueda$/ do 
    within("#masthead-search") do
    fill_in 'search_query', with: user;
    end
    click_button 'search-btn'
end

When /^Voy a video dado$/ do 
    visit url
end

Given /^Url de un video \"([^\"]*)\"$/ do |entrada|
   url = entrada;
end

Then /^Tiene que durar \"([^\"]*)\"$/ do |duracion|
    expect(find('span.ytp-time-duration')).to have_content(duracion)
end

Given /^El usuario \"([^\"]*)\"$/ do |usuario|
     user = usuario;
end

Given /^El canal (.+)$/ do |canal|
    current_canal = canal
end

When /^Pincho el canal en el menu$/ do
    find('#appbar-guide-button').click()
    find('#guide-container').find('a[title="' + current_canal + '"]').click()
end

When /^Pincho cualquier video$/ do
    sleep 2
    first("h3.yt-lockup-title > a").click()
end

Then /^Debe contener el canal como categoría$/ do
    find('div#action-panel-details > button').click()
    expect(find('div#watch-description-extras > ul > li', text: 'Categoría').text).to have_content(current_canal)
end

Then /^El primer comentario debe tener más likes que el segundo$/ do
    #puts find('#comment-section-renderer-items section')['innerHtml']
    #expect(find('#comment-section-renderer-items:first-child').text).to 
end
