user = ""

Given /^El usuario \"([^\"]*)\"$/ do |usuario|
    user = usuario;
end

When /^Selecciono el filtro \"([^\"]*)\"/ do |filtro|
    sleep 2
    find("span", :text => "Filtros").click
    find("span", :class => "filter-text", :text => filtro, :wait => 1).click
end

Then /^Todos los resultados deben ser canales$/ do
    check_if_exist(".yt-lockup-channel")
end

Then /^Todos los resultados deben ser videos$/ do
    check_if_exist(".yt-lockup-video")
end

Then /^Todos los resultados deben ser listas de reproduccion$/ do
    check_if_exist(".yt-lockup-playlist")
end

Then /^Todos los resultados deben tener una duración mínima de 20 minutos$/ do
    sleep 2
    canales = all("ol.item-section > li")
    canales.each{ |elem|
        expect(get_seconds(elem)).to be >= 1200
    }
end

Then /^Todos los resultados deben tener una duración máxima de 4 min$/ do
    sleep 2
    canales = all("ol.item-section > li")
    canales.each{ |elem|
        expect(get_seconds(elem)).to be <= 240
    }
end

And /^Voy a Youtube$/ do
    visit "https://youtube.com"
end

And /^Hago la búsqueda$/ do
  within("#masthead-search") do
    fill_in 'search_query', with: user
  end
  click_button 'search-btn'
end

def check_if_exist(_class)
  sleep 2
  canales = all("ol.item-section > li")
  canales.each{ |c|
      expect(c.find(_class)).not_to be(nil)
  }
end

def get_seconds(elem)
  times = elem.find(".video-time").text.split(':')
  segundos = 0
  if times.length == 2 then
    # minutos : segundos
    minutos = times[0].to_i
    segundos = times[1].to_i + (minutos * 60)
  else
    # horas: minutos : segundos
    horas = times[0].to_i
    minutos = times[1].to_i + (horas * 60)
    segundos = times[2].to_i + (minutos * 60)
  end
  return segundos
end
