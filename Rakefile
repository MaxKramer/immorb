require "bundler/gem_tasks"
require "rspec/core/rake_task"
require 'immobilienscout'

RSpec::Core::RakeTask.new(:spec)

task :default => :run

task :run do
	search_urls = [
		'https://www.immobilienscout24.de/Suche/controller/asyncResults.go?searchUrl=/Suche/S-T/Wohnung-Miete/Umkreissuche/Berlin_2dPrenzlauer_20Berg_20_28Prenzlauer_20Berg_29/-/228407/2513896/-/1276003001054/2/2,00-/40,00-60,00/EURO--700,00/-/-/-/true?saveSearchId=69888420&enteredFrom=saved_search',
		'https://www.immobilienscout24.de/Suche/controller/asyncResults.go?searchUrl=/Suche/S-T/Wohnung-Miete/Umkreissuche/Berlin_2dPrenzlauer_20Berg_20_28Prenzlauer_20Berg_29/-/228407/2513896/-/1276003001054/2/2,00-/40,00-60,00/EURO--700,00/-/-/-/true?saveSearchId=69888420&enteredFrom=saved_search',
		'https://www.immobilienscout24.de/Suche/controller/asyncResults.go?searchUrl=/Suche/S-T/Wohnung-Miete/Fahrzeitsuche/Berlin_2dMitte_20_28Mitte_29/-/227904/2512393/-/1276003001046/20/2,00-/45,00-55,00/EURO--700,00?saveSearchId=69318231&enteredFrom=saved_search',
		'https://www.immobilienscout24.de/Suche/controller/asyncResults.go?searchUrl=/Suche/S-T/Wohnung-Miete/Fahrzeitsuche/Berlin_2dMitte_20_28Mitte_29/-/228105/2512492/-/1276003001046/30/2,00-/45,00-/EURO--700,00/-/-/-/true?saveSearchId=68842701&enteredFrom=saved_search',
		'https://www.immobilienscout24.de/Suche/controller/asyncResults.go?searchUrl=/Suche/S-T/Wohnung-Miete/Umkreissuche/Berlin_2dPrenzlauer_20Berg_20_28Prenzlauer_20Berg_29/-/228407/2513897/-/1276003001054/2/2,00-/40,00-60,00/EURO--700,00/-/-/-/true?saveSearchId=68021012&enteredFrom=saved_search',
		'https://www.immobilienscout24.de/Suche/controller/asyncResults.go?searchUrl=/Suche/S-T/Wohnung-Miete/Umkreissuche/Berlin_2dKreuzberg_20_28Kreuzberg_29/-/226681/2508679/-/1276003001034/1/2,00-/45,00-/EURO--700,00?saveSearchId=70089957&enteredFrom=saved_search',
		'https://www.immobilienscout24.de/Suche/controller/asyncResults.go?searchUrl=/Suche/S-T/Wohnung-Miete/Umkreissuche/Berlin_2dKreuzberg_20_28Kreuzberg_29/10969/228162/2510300/Moritzplatz/-/1/2,00-/45,00-/EURO--700,00?enteredFrom=result_list',
		'https://www.immobilienscout24.de/Suche/controller/asyncResults.go?searchUrl=/Suche/S-T/Wohnung-Miete/Umkreissuche/Berlin/10245/231263/2511344/Gr_fcnberger_20Stra_dfe/-/1/2,00-/45,00-/EURO--700,00?enteredFrom=result_list',
		'https://www.immobilienscout24.de/Suche/controller/asyncResults.go?searchUrl=/Suche/S-T/Wohnung-Miete/Umkreissuche/Berlin_2dFriedrichshain_20_28Friedrichshain_29/10245/231177/2511202/Simon_2dDach_2dStra_dfe/-/1/2,00-/45,00-/EURO--700,00?enteredFrom=result_list',
		'https://www.immobilienscout24.de/Suche/controller/asyncResults.go?searchUrl=/Suche/S-T/Wohnung-Miete/Umkreissuche/Berlin/-/227396/2513156/U_20Rosenthaler_20Platz/-/1/2,00-/45,00-/EURO--700,00?enteredFrom=result_list',
		'https://www.immobilienscout24.de/Suche/controller/asyncResults.go?searchUrl=/Suche/S-T/Wohnung-Miete/Umkreissuche/Berlin/10405/228550/2513730/Knaackstra_dfe/-/1/2,00-/45,00-/EURO--700,00?enteredFrom=result_list',
		'https://www.immobilienscout24.de/Suche/controller/asyncResults.go?searchUrl=/Suche/S-T/Wohnung-Miete/Umkreissuche/Berlin/10115/227343/2513946/Arkonaplatz/-/1/2,00-/45,00-/EURO--700,00?enteredFrom=result_list',
		'https://www.immobilienscout24.de/Suche/controller/asyncResults.go?searchUrl=/Suche/S-T/Wohnung-Miete/Umkreissuche/Berlin/-/228154/2513538/U_20Senefelderplatz/-/2/2,00-/45,00-/EURO--700,00?enteredFrom=result_list'
	]

	client = ImmobilienScout::Client.new(search_urls: search_urls)
	client.execute
end

task :console do
	exec './bin/console'
end