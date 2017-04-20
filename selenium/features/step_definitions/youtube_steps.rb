user = "";
url = "";
current_canal = "";

When /^Voy a Youtube$/ do
    visit "https://youtube.com"
end

Then /^El primer video tiene como autor el usuario dado$/ do
     expect(find(".yt-lockup-title > a[title='#{user}']")).to have_content(user)
end

Then /^El primer video no tiene como autor el usuario dado$/ do
   elem_1 =  first(".yt-lockup-title")
   elem_2 =  find(".yt-lockup-title > a[title='#{user}']")
   expect(elem_1).not_to eq(elem_2)
end

When /^Hago la búsqueda$/ do
    within("#masthead-search") do
      fill_in 'search_query', with: user
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
    duracion_encontrada = find('span.ytp-time-duration').text
    if duracion_encontrada != duracion then
      # Posible anuncio
      minutos = Integer(duracion_encontrada.split(':')[0])
      segundos = Integer(duracion_encontrada.split(':')[1])
      # Esperar al anuncio
      sleep minutos * 60 + segundos + 2
      duracion_encontrada = find('span.ytp-time-duration').text
    end
    expect(duracion_encontrada).to eq(duracion)
end

Given /^El usuario \"([^\"]*)\"$/ do |usuario|
     user = usuario;
end

Given /^El canal (.+)$/ do |canal|
    current_canal = canal
end

When /^Pincho el canal en el menu$/ do
    find('#appbar-guide-button').click unless ! find('#guide-container').nil?
    sleep 2
    find('#guide-container').find('a[title="' + current_canal + '"]').click
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
    execute_script "window.scrollBy(0,10000)"
    sleep 10
    first_elem = first(".off").text
    all(".off").each do |el|
        expect(Integer(first_elem)).to be >= Integer(el.text)
    end
end
