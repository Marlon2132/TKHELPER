script_name('TK HELPER')
script_authors('Marlon')
script_description('helper')



require 'lib.moonloader'



local dlstatus = require('moonloader').download_status

update_state = false

local script_vers = 1
local script_vers_text = '1.00'

local script_path = thisScript().path
local script_url = ''

local update_path = getWorkingDirectory() .. '/updateTKHELPER.ini'
local update_url = 'https://raw.githubusercontent.com/Marlon2132/TKHELPER/main/updateTKHELPER.ini'



local font_flag = require('moonloader').font_flag
local my_font = renderCreateFont('Verdana', 12, font_flag.BOLD + font_flag.BORDER)

local ffi = require("ffi")
ffi.cdef[[
    int __stdcall GetVolumeInformationA(
    const char* lpRootPathName,
    char* lpVolumeNameBuffer,
    uint32_t nVolumeNameSize,
    uint32_t* lpVolumeSerialNumber,
    uint32_t* lpMaximumComponentLength,
    uint32_t* lpFileSystemFlags,
    char* lpFileSystemNameBuffer,
    uint32_t nFileSystemNameSize
    );
]]

local sampev = require 'lib.samp.events'
local keys = require 'vkeys'
local copas = require 'copas'
local http = require 'copas.http'
local encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8

local inicfg = require 'inicfg'
local directIni = 'TKHELPER by Marlon.ini'
local ini = inicfg.load(inicfg.load({
    main = {
		minimalkaprods = 1,
		komissiya = 0,
    },
	cfg = {
		raspolozhsw = 840,
		raspolozhsh = 525,
	},
}, directIni))
inicfg.save(ini, directIni)

local ips =
{
    ['RED'] = '54.37.142.72:7777',
	['GREEN'] = '54.37.142.73:7777',
	['BLUE'] = '54.37.142.74:7777',
	['LIME'] = '54.37.142.75:7777',
}

local main_color = 0xFFFFFF
local second_color = 0xf08b1f
local gray_color = 0x8c8c8c
local blue_color = 0x00bbfa
local green_color = 0x287d27
local red_color = 0xf01818
local lightgreen_color = 0x00cc66

local main_color_text = '{FFFFFF}'
local second_color_text = '{f08b1f}'
local gray_color_text = '{8c8c8c}'
local blue_color_text = '{00bbfa}'
local green_color_text = '{287d27}'
local red_color_text = '{f01818}'
local lightgreen_color_text = '{00cc66}'

local tag = '{f08b1f}[TK HELPER]{FFFFFF} - '

raspolozhsw = ini.cfg.raspolozhsw
raspolozhsh = ini.cfg.raspolozhsh

fileDirectory = getGameDirectory() .. '\\moonloader\\config\\TKHELPER by Marlon.txt'
f = io.open(fileDirectory, 'r+')
readfile = nil



tochkaotmarshrutforgorod = ''
tochkadomarshrutforcheck = ''
tochkaotmarshrut = ''
tochkadomarshrut = ''
stoimostza1prod = 0
otvezenoprod = 0
maxprod = 0
vodilnamarshrute = 0
vodilnamarshrutenow = -1
textvodila = ''



minimalkaprods = ini.main.minimalkaprods
filtrmest = nil
goroda = nil
komissiya = ini.main.komissiya

function save()
	ini.main.minimalkaprods = minimalkaprods
	ini.main.komissiya = komissiya
	
	ini.cfg.raspolozhsw = raspolozhsw
	ini.cfg.raspolozhsh = raspolozhsh

	inicfg.save(ini, directIni)
end

vzyatoprods = 0



activatescript = 0
on = 0
rejim = 0
checkprods = 0

nastroikastatuszakaz = 0

function main()

	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end

	CHECKERFORSCRIPT()
	
	downloadUrlToFile(update_url, update_path, function(id, status)
		if status == dlstatus.STATUS_ENDDOWNLOADDATA then
			updateIni = inicfg.load(nil, update_path)
			if tonumber(updateIni.info.vers) > script_vers then
				update_state = true
				sampAddChatMessage(tag .. 'Есть обновление! Версия: ' .. updateIni.info.vers_text , main_color)
			end
			os.remove(update_path)
		end
	end)

	sampRegisterChatCommand('tkhelper', cmd_tkhelper)
	sampRegisterChatCommand('prods', cmd_prods)
	sampRegisterChatCommand('mesto', cmd_mesto)
	sampRegisterChatCommand('gorod', cmd_gorod)
	sampRegisterChatCommand('komka', cmd_komka)

	if f == nil then
		f = io.open(fileDirectory, 'w');
		f:close()
		f = io.open(fileDirectory, 'r+')
	end

	while true do
	
		if update_state then
			downloadUrlToFile(script_url, script_path_path, function(id, status)
				if status == dlstatus.STATUS_ENDDOWNLOADDATA then
					sampAddChatMessage(tag .. 'Скрипт обновлён.', main_color)
					thisScript():reload()
				end
			end)
			break
		end
	
		if nastroikastatuszakaz ~= 1 then
			if on == 2 or on == 3 then
				if vodilnamarshrutenow == -1 then
					renderFontDrawText(my_font, blue_color_text .. tochkaotmarshrut .. '\n' .. tochkadomarshrut .. '\n' .. main_color_text .. 'Максимально ' .. green_color_text .. maxprod - otvezenoprod .. ' ед. (по ' .. stoimostza1prod .. '$)' .. main_color_text .. '\nМаксимально ' .. second_color_text .. (maxprod - otvezenoprod) * stoimostza1prod * (1-komissiya) .. '$\n' .. red_color_text .. vodilnamarshrute .. main_color_text .. ' водитель(-я, -ей)' , raspolozhsw, raspolozhsh, 0xFFFFFFFF)
				else
					renderFontDrawText(my_font, blue_color_text .. tochkaotmarshrut .. '\n' .. tochkadomarshrut .. '\n' .. main_color_text .. 'Максимально ' .. green_color_text .. maxprod - otvezenoprod .. ' ед. (по ' .. stoimostza1prod .. '$)' .. main_color_text .. '\nМаксимально ' .. second_color_text .. (maxprod - otvezenoprod) * stoimostza1prod * (1-komissiya) .. '$\n' .. red_color_text .. vodilnamarshrutenow .. main_color_text .. ' водитель(-я, -ей)' , raspolozhsw, raspolozhsh, 0xFFFFFFFF)
				end
			elseif on == 4 then
				renderFontDrawText(my_font, blue_color_text .. tochkaotmarshrut .. '\n' .. tochkadomarshrut .. '\n' .. green_color_text .. vzyatoprods .. ' ед. (по ' .. stoimostza1prod .. '$)\n' .. second_color_text .. vzyatoprods * stoimostza1prod * (1-komissiya) .. '$' , raspolozhsw, raspolozhsh, 0xFFFFFFFF)
			end
		else
			local xmousecord, ymousecord = getCursorPos()
			renderFontDrawText(my_font, blue_color_text .. 'Порт LS\nНефтезавод\n' .. main_color_text .. 'Максимально ' .. green_color_text .. '5000 ед. (по 3$)' .. main_color_text .. '\nМаксимально ' .. second_color_text .. '15000$\n' .. red_color_text .. '3' .. main_color_text .. ' водитель(-я, -ей)' , xmousecord, ymousecord, 0xFFFFFFFF)	
		end
		wait(0)

    --[[if maxprod ~= nil and otvezenoprod ~= nil then
			wait(1000)
    	sampAddChatMessage(tochkaotmarshrutforgorod .. ' - ' .. tochkadomarshrutforcheck .. ', ' .. stoimostza1prod .. '$ ' .. otvezenoprod .. '/' .. maxprod .. ' ' .. vodilnamarshrute, main_color)
    end]]

		if isKeyJustPressed(VK_L) and not sampIsChatInputActive() and activatescript == 1 then -- КЛАВИША и активация
			if on == 0 then
				on = 1
				--[[for _, znachenie in ipairs(goroda) do
					sampAddChatMessage(znachenie, main_color)
				end]]
				sampAddChatMessage(tag .. 'Поиск подходящих заказов...', main_color)
				sampSendChat('/order')
			else
				on = 0
				checkprods = 0
				sampAddChatMessage(tag .. 'Ловля заказов остановлена.', main_color)
			end
		end

		if isKeyJustPressed(VK_M) and not sampIsChatInputActive() and activatescript == 1 then
			if rejim == 0 then
				rejim = 1
				sampAddChatMessage(tag .. 'Выбран ' .. second_color_text .. 'фильтрованный ' .. main_color_text .. 'режим.', main_color)
			else
				rejim = 0
				sampAddChatMessage(tag .. 'Выбран ' .. second_color_text .. 'свободный ' .. main_color_text .. 'режим.', main_color)
			end
		end

		local result, button, list, input = sampHasDialogRespond(8000)

		if result then
			if button == 1 then
				if list == 0 then
					showlcldlg(8001)
				elseif list == 1 then
					if activatescript == 0 then
						activatescript = 1
						sampAddChatMessage(tag .. 'Скрипт ' .. second_color_text .. 'активирован.' ,main_color)
						showlcldlg(8000)
					else
						activatescript = 0
						on = 0
						sampAddChatMessage(tag .. 'Скрипт ' .. second_color_text .. 'выключен.' ,main_color)
						showlcldlg(8000)
					end
				elseif list == 2 then
					showlcldlg(8020)
				elseif list == 3 then
					showlcldlg(8006)
				end
			end
		end

		local result, button, list, input = sampHasDialogRespond(8001)

		if result then
			if button == 1 then
				showlcldlg(8002)
			else
				showlcldlg(8000)
			end
		end

		local result, button, list, input = sampHasDialogRespond(8002)

		if result then
			if button == 1 then
				showlcldlg(8003)
			else
				showlcldlg(8001)
			end
		end

		local result, button, list, input = sampHasDialogRespond(8003)

		if result then
			if button == 1 then
				showlcldlg(8004)
			else
				showlcldlg(8002)
			end
		end
		
		local result, button, list, input = sampHasDialogRespond(8004)

		if result then
			if button == 1 then
				showlcldlg(8005)
			else
				showlcldlg(8003)
			end
		end
		
		local result, button, list, input = sampHasDialogRespond(8005)

		if result then
			if button == 1 then
				showlcldlg(8000)
			else
				showlcldlg(8004)
			end
		end
		
		local result, button, list, input = sampHasDialogRespond(8006)

		if result then
			if button == 1 then
				if list == 0 then
					sampAddChatMessage(tag .. second_color_text .. 'Выберите место, ' .. main_color_text .. 'где хотите установить статус заказа и ' .. second_color_text .. 'нажмите «ЛКМ».', main_color)
					sampAddChatMessage(tag .. 'Чтобы ' .. second_color_text .. 'отменить ' .. main_color_text .. 'настройку ' .. second_color_text .. 'нажмите «ESC».', main_color)
					nastroikastatuszakaz = 1
					showCursor(true, true)
				end
			else
				showlcldlg(8000)
			end
		end
		
		local result, button, list, input = sampHasDialogRespond(8020)
		
		if result then
			if button == 0 then
				showlcldlg(8000)
			else
				if list == 2 then
					showlcldlg(8021)
				elseif list == 3 then
					showlcldlg(8022)
				end
			end
		end
		
		local result, button, list, input = sampHasDialogRespond(8021)
		
		if result then
			if button == 0 then
				showlcldlg(8020)
			end
		end
		
		local result, button, list, input = sampHasDialogRespond(8022)
		
		if result then
			if button == 1 then
				local linesSS = {}
				for i = 1, getLastLineIndex(fileDirectory) do
					table.insert(linesSS, i)
				end
				removeLines(fileDirectory, linesSS)
				sampAddChatMessage(tag .. 'Финансовая статистика была ' .. second_color_text .. 'очищена.', main_color)
				showlcldlg(8020)
			else
				showlcldlg(8020)
			end
		end

	end
end

function get_xy_lparam(lParam)
	if nastroikastatuszakaz == 1 then
		local lp = ffi.new("unsigned long[1]", lParam)
		local x, y = ffi.cast("short*", lp), ffi.cast("short*", lp) + 1
		x, y = x[0], y[0]
		return x, y
	end
end

function onWindowMessage(uMsg, wParam, lParam)
	if nastroikastatuszakaz == 1 then
		if uMsg == 513 then
			local xstzakaz, ystzakaz = get_xy_lparam(lParam)
			raspolozhsw = xstzakaz
			raspolozhsh = ystzakaz
			showCursor(false, false)
			nastroikastatuszakaz = 0
			sampAddChatMessage(tag .. 'Координаты статуса заказа ' .. second_color_text .. 'сохранены.', main_color)
			save()
		end
		if wParam == 0x1B then
			consumeWindowMessage()
			showCursor(false, false)
			nastroikastatuszakaz = 0
			sampAddChatMessage(tag .. 'Настройка статуса заказа ' .. second_color_text .. 'была отменена.', main_color)
		end
	end
end

function cmd_komka(arg)
	if arg == nil or arg == '' or arg == ' ' or #arg == 0 then
		komissiya = 0
		sampAddChatMessage(tag .. 'Комиссия была ' .. second_color_text .. 'сброшена ' .. main_color_text .. 'или Вы ' .. second_color_text .. 'не ввели (неправильно ввели) значение.', main_color)
	else
		if arg:find('%D+') then
			komissiya = 0
			sampAddChatMessage(tag .. 'Комиссия была ' .. second_color_text .. 'сброшена ' .. main_color_text .. 'или Вы ' .. second_color_text .. 'не ввели (неправильно ввели) значение.', main_color)
		else
			if tonumber(arg) < 100 and tonumber(arg) > 0 then
				komissiya = tonumber(arg)/100
				sampAddChatMessage(tag .. 'Комиссия компании ' .. second_color_text .. 'установлена ' .. main_color_text .. 'на ' .. second_color_text .. arg .. ' процента(-ов).', main_color)
			elseif tonumber(arg) >= 100 or tonumber(arg) < 0 then
				komissiya = 0
				sampAddChatMessage(tag .. 'Комиссия была ' .. second_color_text .. 'сброшена ' .. main_color_text .. 'или Вы ' .. second_color_text .. 'не ввели (неправильно ввели) значение.', main_color)
			end
		end
	end
	save()
end

function cmd_gorod(arg)
	if arg == '1' then
		goroda = {'Порт LS', 'Завод продуктов', 'Темпл Драйв', 'Лос-Сантос Интернейшнл', 'Склад Мидл', 'Мебельный склад ЛС', 'Океанский порт', 'Эвери Констракшн', 'Склад Монтгомерри', 'Склад Блуберри', 'Округ Ред'}
		sampAddChatMessage(tag .. 'Ловля заказов установлена в ' .. second_color_text .. 'г. Лос-Сантос.', main_color)
		if rejim == 0 then
			rejim = 1
			sampAddChatMessage(tag .. 'Выбран ' .. second_color_text .. 'фильтрованный ' .. main_color_text .. 'режим.', main_color)
		end
	elseif arg == '2' then
		goroda = {'Нефтезавод', 'Станция Елоу Белл', 'Лас%-Пайасадас', 'Северный склад ЛВ', 'Восточная стройка', 'АЭС', 'Мебельный склад ЛВ', 'Тьерра%-Робада', 'Восточный склад', 'Казино Розовый лебедь', 'Казино Камелот', 'Эль Кебрадос', '%{......%}', 'Стадион', 'Транизосторный завод'}
		sampAddChatMessage(tag .. 'Ловля заказов установлена в ' .. second_color_text .. 'г. Лас-Вентурас.', main_color)
		if rejim == 0 then
			rejim = 1
			sampAddChatMessage(tag .. 'Выбран ' .. second_color_text .. 'фильтрованный ' .. main_color_text .. 'режим.', main_color)
		end
	elseif arg == '3' then
		goroda = {'Порт SF', 'ЖК Силовичок', 'Энджел Пэйн', 'Голден Гейт Бридж', 'Трамвайное депо', 'Лесхоз', 'Автосалон СФ', 'Министерство Здравоохранения', 'Банковский порт', 'Трансляционная станция', 'Бэйсайд', 'Мебельный склад СФ', 'ЖК Вавилон', 'Ферма', 'Лодочный пирс', 'Хим%. завод', 'Уэтстоун'}
		sampAddChatMessage(tag .. 'Ловля заказов установлена в ' .. second_color_text .. 'г. Сан-Фиерро.', main_color)
		if rejim == 0 then
			rejim = 1
			sampAddChatMessage(tag .. 'Выбран ' .. second_color_text .. 'фильтрованный ' .. main_color_text .. 'режим.', main_color)
		end
	else
		goroda = nil
		sampAddChatMessage(tag .. 'Фильтр городов был ' .. second_color_text .. 'сброшен ' .. main_color_text .. 'или Вы ' .. second_color_text .. 'не ввели (неправильно ввели) номер города.', main_color)
	end
end

function cmd_mesto(arg)
	if arg == nil or arg == ' ' or arg == '' or #arg == 0  then
		filtrmest = nil
		sampAddChatMessage(tag .. 'Фильтр мест был ' .. second_color_text .. 'сброшен  ' .. main_color_text .. 'или Вы ' .. second_color_text .. 'не ввели (неправильно ввели) название места.', main_color)
	else
		filtrmest = string.gsub(tostring(arg):gsub('%.', '%.'), '%-', '%-')
		sampAddChatMessage(tag .. 'Фильтр мест был ' .. second_color_text .. 'установлен ' .. main_color_text .. 'на ' .. second_color_text .. tostring(arg) .. '.', main_color)
		if rejim == 0 then
			rejim = 1
			sampAddChatMessage(tag .. 'Выбран ' .. second_color_text .. 'фильтрованный ' .. main_color_text .. 'режим.', main_color)
		end
	end
end

function cmd_prods(arg)
	if tonumber(arg) == 0 or arg == nil or arg == ' ' or arg == '' or #arg == 0 then
		minimalkaprods = 1
		sampAddChatMessage(tag .. 'Фильтр количества продуктов ' .. second_color_text .. 'сброшен ' .. main_color_text .. 'или Вы ' .. second_color_text ..'не ввели (неправильно ввели) значение.', main_color)
	else
		minimalkaprods = tonumber(arg)
		sampAddChatMessage(tag .. 'Фильтр количества продуктов установлен на ' .. second_color_text .. minimalkaprods .. ' ед.', main_color)
	end
	save()
end

function cmd_tkhelper()
	showlcldlg(8000)
end

function showlcldlg(arg)
	if arg == 8000 then
		sampShowDialog(8000, second_color_text .. 'TK HELPER: Меню', gray_color_text .. '1. ' .. main_color_text .. 'Полная инструкция\n' .. gray_color_text .. '2. ' .. main_color_text .. 'Активация\n' .. gray_color_text .. '3. ' .. main_color_text .. 'Финансовая статистика\n' .. gray_color_text .. '4. ' .. main_color_text .. 'Настройки', 'Выбрать', 'Закрыть', 2)
	elseif arg == 8001 then
		sampShowDialog(8001, second_color_text .. 'TK HELPER: Режимы работы', main_color_text .. 'Данный скрипт имеет множество функций и фильтров, которые помогут Вам заработать денег в ТК.\nСуществует ' .. second_color_text .. 'два ' .. main_color_text .. 'режима работы скрипта: ' .. second_color_text .. 'свободный и фильтрованный.\n(!) По умолчанию стоит свободный режим.\n\n\t\t\t\t\t\t\t\t    СВОБОДНЫЙ\n\n' .. main_color_text .. 'В ' .. second_color_text .. 'свободном режиме ' .. main_color_text .. 'скрипт ловит абсолютно любые заказы и не подвергается каким-либо фильтрам (искл. - фильтр количества продуктов).' .. second_color_text .. '\n\n\t\t\t\t\t\t\t\tФИЛЬТРОВАННЫЙ\n\n' .. main_color_text .. 'В ' .. second_color_text .. 'фильтрованном режиме ' .. main_color_text .. 'скрипт ловит все заказы, которые удовлетворяют фильтрам.\n\n' .. second_color_text .. '(!) При активации какого-либо из фильтров (кроме фильтра кол-ва продуктов) автоматически включается фильтрованный режим.', 'Далее', 'Назад', 0)
	elseif arg == 8002 then
		sampShowDialog(8002, second_color_text .. 'TK HELPER: Фильтры', main_color_text .. 'Сущесвует несколько видов ' .. second_color_text .. 'фильтров.\n\n' .. gray_color_text .. '1. ' .. second_color_text .. 'Фильтр количества продуктов. ' .. main_color_text .. 'Данный фильтр регулирует минимальное количество продуктов для принятия заказа.\n    Чтобы активировать этот фильтр пропишите команду ' .. second_color_text .. '/prods. ' .. main_color_text .. 'Например, Вы установили ' .. second_color_text .. '/prods 3000.' .. main_color_text .. 'Скрипт будет ловить\n    только те заказы, в которых можно забрать 3000 и более продуктов. Этот фильтр работает в обоих режимах.\n    Чтобы сбросить фильтр достаточно написать ' .. second_color_text .. '/prods.\n\n' .. gray_color_text .. '2. ' .. second_color_text .. 'Фильтр начальных точек заказов. ' .. main_color_text .. 'Этот фильтр позволяет сортировать места, из которых берётся заказ.\n    Мест можно указывать несколько, а можно одно. Чтобы активировать фильтр пропишите команду ' .. second_color_text .. '/mesto.\n    ' .. main_color_text .. 'Например, Вы выбрали нефтезавод. Тогда скрипт будет ловить заказы только с нефтезавода, и команда будет выглядеть так: ' .. second_color_text .. '/mesto Нефтезавод.' .. main_color_text .. '\n    Если Вы хотите указать несколько мест, тогда нужно разделять места символом ' .. second_color_text .. '«/» ' .. main_color_text .. '(в самом конце ставить этот знак не обязательно).\n    К примеру, Вы выбрали нефтезавод и порт LS. Тогда скрипт будет ловить заказы только с нефтезавода и порта LS. Команда будет выглядеть так: ' .. second_color_text .. '/mesto Нефтезавод/Порт LS.' .. main_color_text .. '\n    Чтобы сбросить фильтр напишите команду ' .. second_color_text .. '/mesto.' .. gray_color_text .. '\n\n3. ' .. second_color_text .. 'Фильтр городов. ' .. main_color_text .. 'Данный фильтр позволяет фильтровать точки, из которых берутся заказы, по городам. Чтобы включить фильтр напишите команду ' .. second_color_text .. '/gorod [1-3].' .. main_color_text .. '\n    1 - ' .. second_color_text .. 'Лос-Сантос.' .. main_color_text .. '\n    2 - ' .. second_color_text .. 'Лас-Вентурас.' .. main_color_text .. '\n    3 - ' .. second_color_text .. 'Сан-Фиерро.' .. main_color_text .. '\n    Например, если Вы написали ' .. second_color_text .. '/gorod 2, ' .. main_color_text .. 'то скрипт будет ловить заказы только с Лас-Вентураса.\n    Чтобы сбросить фильтр, напишите команду ' .. second_color_text .. '/gorod.\n\n    (!) Примечание. В приоритете проверки заказов стоит фильтр мест. Это значит, что сначала проверяются места, а потом уже город.\n\n    (!) Обратите внимание, что этот фильтры мест и городов чувствительны к орфографии и к регистру, а также точки используются не для команды, а для конца предложения!', 'Далее', 'Назад', 0)
	elseif arg == 8003 then
		sampShowDialog(8003, second_color_text .. 'TK HELPER: Прочее', main_color_text .. 'Чтобы ' .. second_color_text .. 'установить комиссию ' .. main_color_text .. 'компании напишите команду ' .. second_color_text .. '/komka.' .. main_color_text .. '\nНапример, если вы хотите установить комиссию 25 процентов, то команда будет выглядеть так: ' .. second_color_text .. '/komka 25.\nДля своей фуры комиссия 5 процентов.' .. main_color_text .. '\n\nСкрипт активируется нажатием второго пункта в меню. Именно после активации начинают работать кнопки.\n\n' .. second_color_text .. '(!) Не пользуйтесь чатом и диалогами во время работы скрипта.\nЕсли нужно воспользоваться чатом или диалогом, то выключите ловлю заказов.', 'Далее', 'Назад', 0)
	elseif arg == 8004 then
		sampShowDialog(8004, second_color_text .. 'TK HELPER: Кнопки', main_color_text .. 'Чтобы включить ловлю нажмите клавишу ' .. second_color_text .. '«L».' .. main_color_text .. '\nЧтобы сменить режим ловли нажмите клавишу ' .. second_color_text .. '«M».', 'Далее', 'Назад', 0)
	elseif arg == 8005 then
		sampShowDialog(8005, second_color_text .. 'TK HELPER: Просмотр статистики', second_color_text .. 'Финансовую статистику ' .. main_color_text .. 'можно просмотреть нажатием третьего пункта в меню.\nТам Вы можете просмотреть статистику за день, за всё время.\nТакже отдельно можно посмотреть прибыль за каждый день и соответствующей кнопкой очистить статистику.\n\nСтатистику можно посмотреть по следующему пути:\n' .. second_color_text .. getGameDirectory() .. '\\moonloader\\config\\TKHELPER by Marlon.txt', 'Закрыть', 'Назад', 0)
	elseif arg == 8006 then
		sampShowDialog(8006, second_color_text .. 'TK HELPER: Настройки', gray_color_text .. '1. ' .. main_color_text .. 'Статус заказа', 'Выбрать', 'Назад', 2)
	elseif arg == 8020 then
		local iii = 0
		f:seek('set', 0)
		for line in f:lines() do
			if line:find('%d+%/%d+%/%d+% %d+%$') then
				iii = iii + tonumber(line:match('%d+%/%d+%/%d+% (%d+)%$'))
			end
		end
		f:seek('set', 0)
		if f:read('*a'):len() ~= 0 then
			f:seek('set', 0)
			if getLastLineIndex(fileDirectory) == 1 then
				f:seek('set', 0)
				local laststrokafinstat = f:read('*a')
				if laststrokafinstat:find(os.date('%d') .. '%/' .. os.date('%m') .. '%/' .. os.date('%Y') .. ' %d+%$') then
					segzarab = laststrokafinstat:match('%d+%/%d+%/%d+ (%d+)%$')
				else
					segzarab = 0
				end
			else
				f:seek('set', 0)
				local laststrokafinstat = f:read('*a'):match('\n[^\n]*$')
				if laststrokafinstat:find(os.date('%d') .. '%/' .. os.date('%m') .. '%/' .. os.date('%Y') .. ' %d+%$') then
					segzarab = laststrokafinstat:match('%d+%/%d+%/%d+ (%d+)%$')
				else
					segzarab = 0
				end
			end
		else
			segzarab = 0
		end
		sampShowDialog(8020, second_color_text .. 'TK HELPER: Финансовая статистика', ' \t \n' .. gray_color_text .. '1. ' .. main_color_text .. 'Всего заработано: \t' .. lightgreen_color_text .. '[' .. iii .. '$]\n' .. gray_color_text .. '2. ' .. main_color_text .. 'Заработано за день: \t' .. lightgreen_color_text .. '[' .. segzarab .. '$]\n' .. gray_color_text .. '3. ' .. main_color_text .. 'Полная финансовая статистика: \t' .. second_color_text .. '[Посмотреть]\n' .. gray_color_text .. '4. ' .. main_color_text .. 'Очистить финансовую статистику: \t' .. red_color_text .. '[Очистить]', 'Выбрать', 'Назад', 5)
	elseif arg == 8021 then
		finstat = ''
		f:seek('set', 0)
		for line in f:lines() do
			chisl, mesyac, god, zarab = line:match('(%d+)%/(%d+)%/(%d+) (%d+)%$')
			finstat = finstat .. '\n' .. main_color_text .. chisl .. '.' .. mesyac .. '.' .. god .. '\t' .. lightgreen_color_text .. zarab ..'$' 
		end
		sampShowDialog(8021, second_color_text .. 'TK HELPER: Полная финансовая статистика', second_color_text .. 'Дата:\tПрибыль:' .. finstat , 'Выбрать', 'Назад', 5)
	elseif arg == 8022 then
		sampShowDialog(8022, second_color_text .. 'TK HELPER: Подтверждение действия', main_color_text .. 'Вы ' .. second_color_text .. 'уверены, ' .. main_color_text .. 'что хотите ' .. second_color_text .. 'очистить финансовую статистику?', 'Да', 'Нет', 0)
	end
end

function sampev.onShowDialog(dialogId, style, title, button1, button2, text)
	if on == 1 then
		if dialogId == 3079 then

			local i = style == 5 and -1 or 0

			for line in text:gmatch('[^\r\n]+') do
				tochkaotmarshrutforgorod = tostring(line:match('(.+) %- .+, %d%$	%d+%/%d+	%d+'))
				tochkadomarshrutforcheck = tostring(line:match('.+ %- (.+), %d%$	%d+%/%d+	%d+'))
				tochkaotmarshrut = string.gsub(tochkaotmarshrutforgorod, '%{......%}', '')
				tochkadomarshrut = string.gsub(tochkadomarshrutforcheck, '%{......%}', '')
				stoimostza1prod = tonumber(line:match('.+, (%d)%$	%d+%/%d+	%d+'))
				otvezenoprod = tonumber(line:match('.+, %d%$	(%d+)%/%d+	%d+'))
				maxprod = tonumber(line:match('.+, %d%$	%d+%/(%d+)	%d+'))
				vodilnamarshrute = tonumber(line:match('.+, %d%$	%d+%/%d+	(%d+)'))

				if maxprod ~= nil and otvezenoprod ~= nil then
					if maxprod - otvezenoprod >= minimalkaprods then

						if rejim == 1 then

							if filtrmest ~= nil then
								for mestechko in filtrmest:gmatch('[^/]+') do
									if tochkaotmarshrut:find(mestechko) then
										sampSendDialogResponse(3079, 1, i, nil)
										on = 2
										sampAddChatMessage('1', main_color)
										return false
									end
								end
								if goroda ~= nil then
									for _, znachenie in ipairs(goroda) do
										if tochkaotmarshrutforgorod:find(znachenie) then
											sampSendDialogResponse(3079, 1, i, nil)
											on = 2
											sampAddChatMessage('2', main_color)
											return false
										end
									end
								end
							end

							if goroda ~= nil then
								for _, znachenie in ipairs(goroda) do
									if tochkaotmarshrutforgorod:find(znachenie) then
										sampSendDialogResponse(3079, 1, i, nil)
										on = 2
										sampAddChatMessage('3', main_color)
										return false
									end
								end
							end

						elseif rejim == 0 then

							sampSendDialogResponse(3079, 1, i, nil)
							on = 2
							sampAddChatMessage('4', main_color)
							return false

						end
					end
				end
				i = i + 1
			end

			sampSendDialogResponse(3079, 0, 0, nil)

			lua_thread.create(function()
				wait(1000)
				if on == 1 then
					sampSendChat('/order')
				end
			end)
			sampAddChatMessage('5', main_color)
			--repeatcycle()
			return false
		end
	end



	if on == 3 or on == 2 then
		if checkprods == 1 then
			if dialogId == 3079 then
				for line in text:gmatch('[^\r\n]+') do
					if line:find(tochkaotmarshrutforgorod .. ' %- ' .. tochkadomarshrutforcheck .. ', ' .. stoimostza1prod .. '%$	%d+%/' .. maxprod .. '	%d+') then
						vodilnamarshrutenow = tonumber(line:match('.+, %d%$	%d+%/%d+	(%d+)')) - 1

						if tonumber(line:match('.+, %d%$	%d+%/(%d+)	%d+')) - tonumber(line:match('.+, %d%$	(%d+)%/%d+	%d+')) >= minimalkaprods then
							if vodilnamarshrutenow ~= 0 then
								--sampAddChatMessage(tag .. 'Заказ ' .. second_color_text .. 'действителен. ' .. main_color_text .. 'На него отправляется ' .. red_color_text .. vodilnamarshrutenow .. main_color_text .. ' водитель(-я, -ей) помимо Вас.' , main_color)
								sampSendDialogResponse(3079, 0, nil, nil)
								lua_thread.create(function()
									wait(1800)
									if on == 3 or on == 2 then
										sampSendChat('/order')
									end
								end)
								sampAddChatMessage('11', main_color)
								return false
							else
								--sampAddChatMessage(tag .. 'Заказ ' .. second_color_text .. 'действителен. ' .. main_color_text .. 'На него никто не отправился помимо Вас.' , main_color)
								sampSendDialogResponse(3079, 0, nil, nil)
								lua_thread.create(function()
									wait(1800)
									if on == 3 or on == 2 then
										sampSendChat('/order')
									end
								end)
								sampAddChatMessage('22', main_color)
								return false
							end
						else
							on = 1
							checkprods = 0
							sampAddChatMessage(tag .. 'Заказ ' .. red_color_text .. 'недействителен. ' .. main_color_text .. 'Идёт поиск новых заказов...', main_color)
							vodilnamarshrutenow = -1
							sampSendDialogResponse(3079, 0, nil, nil)
							lua_thread.create(function()
								wait(900)
								if on == 1 then
									sampSendChat('/order')
								end
							end)
							sampAddChatMessage('33', main_color)
							return false
						end

					end
				end
			end
		end
	end
end

function sampev.onServerMessage(color, text)
	if on == 2 then
		if color == 1724645631 then
			if text == 'Вы выбрали заказ. Отправляйтесь к месту загрузки' then
				on = 3
				sampAddChatMessage(tag .. 'Найден заказ! ' .. blue_color_text .. tochkaotmarshrut .. ' - ' .. tochkadomarshrut .. green_color_text .. ' (' .. maxprod - otvezenoprod .. ' ед. по ' .. stoimostza1prod .. '$) ' .. main_color_text .. '| ' .. second_color_text .. (maxprod - otvezenoprod) * stoimostza1prod * (1-komissiya) .. '$.' , main_color)
				checkprods = 1
				lua_thread.create(function()
					wait(1800)
					if on == 2 or on == 3 then
						sampSendChat('/order')
					end
				end)
				sampAddChatMessage('111', main_color)
				return false
			end
		end
	end
	if on == 3 then
		if color == 865730559 then
			if text:find('Вы загрузили {FFAA00}%d+ ед. груза{3399FF}, отправляйтесь к месту разгрузки') then
				on = 4
				checkprods = 0
				vzyatoprods = text:match('Вы загрузили {FFAA00}(%d+) ед. груза{3399FF}, отправляйтесь к месту разгрузки')
				sampAddChatMessage('222', main_color)
			end
		end
		if color == -10092289 then
			if text == 'Данный заказ более не действителен' then
				on = 1
				sampAddChatMessage(tag .. 'Поиск подходящих заказов...', main_color)
				lua_thread.create(function()
					wait(200)
					sampSendChat('/order')
				end)
			end
		end
		if color == 1724645631 then
			if text == 'Цель отмечена на карте' then
				return false
			end
		end
	end
	if on == 4 then
		if color == 865730559 then
			if text:find('Вы привезли %{FFAA00%}%d+ ед. груза %{3399FF%}и получили %{00cc99%}%d+%$%{3399FF%}. Комиссия компании %{ff8080%}%d+%$') or text:find('Вы привезли %{FFAA00%}%d+ ед. груза %{3399FF%}и получили %{00cc99%}%d+%$ на каждого водителя%{3399FF%}. Комиссия компании %{ff8080%}%d+%$') then
				on = 1
				vzyatoprods = 0
				local zarabotaltolkochto = text:match('Вы привезли %{FFAA00%}%d+ ед. груза %{3399FF%}и получили %{00cc99%}(%d+)%$%{3399FF%}. Комиссия компании %{ff8080%}%d+%$')
				f:seek('set', 0)
				if f:read('*a'):len() ~= 0 then
					f:seek('set', 0)
					if getLastLineIndex(fileDirectory) == 1 then
						f:seek('set', 0)
						local laststroka = f:read('*a')
						if not laststroka:find(string.gsub(os.date('%d') .. '/' .. os.date('%m') .. '/' .. os.date('%Y'), '/', '%/') .. ' %d+%$') then
							f:seek('end',0)
							f:write('\n' .. os.date('%d') .. '/' .. os.date('%m') .. '/' .. os.date('%Y') .. ' ' .. zarabotaltolkochto .. '$')
							f:flush()
						else
							local lastzarab = laststroka:match('%d+%/%d+%/%d+ (%d+)%$')
							removeLastLineInFile()
							f:seek('end',0)
							f:write(os.date('%d') .. '/' .. os.date('%m') .. '/' .. os.date('%Y') .. ' ' .. lastzarab + zarabotaltolkochto .. '$')
							f:flush()
						end
					else
						local laststroka = f:read('*a'):match('\n[^\n]*$')
						if laststroka:find(string.gsub(os.date('%d') .. '/' .. os.date('%m') .. '/' .. os.date('%Y'), '/', '%/') .. ' %d+%$') then
							local lastzarab = laststroka:match('%d+%/%d+%/%d+ (%d+)%$')
							removeLastLineInFile()
							f:seek('end',0)
							f:write('\n' .. os.date('%d') .. '/' .. os.date('%m') .. '/' .. os.date('%Y') .. ' ' .. lastzarab + zarabotaltolkochto .. '$')
							f:flush()
						else
							f:seek('end',0)
							f:write('\n' .. os.date('%d') .. '/' .. os.date('%m') .. '/' .. os.date('%Y') .. ' ' .. zarabotaltolkochto .. '$')
							f:flush()
						end
					end
				else
					f:seek('set',0)
					f:write(os.date('%d') .. '/' .. os.date('%m') .. '/' .. os.date('%Y') .. ' ' .. zarabotaltolkochto .. '$')
					f:flush()
				end
				sampAddChatMessage(tag .. 'Поиск подходящих заказов...', main_color)
				lua_thread.create(function()
					wait(200)
					sampSendChat('/order')
				end)
			end
		end
	end
end

function sampGetListboxItemByText(text, plain)
    if not sampIsDialogActive() then return -1 end
    plain = not (plain == false)
    for i = 0, sampGetListboxItemsCount() - 1 do
        print(sampGetListboxItemText(i))
        if sampGetListboxItemText(i):find(text, 1, plain) then
            sampAddChatMessage(i,-1)
            return i
        end
    end
    return -1
end

function removeLines(file, linesToRemove)
    if doesFileExist(file) then
        local lines = {}
        for line in io.lines(file) do table.insert(lines, line) end
        for k, v in ipairs(linesToRemove) do
            if lines[v] ~= nil then
                lines[v] = '**removedline**'
            end
        end
        local result = {}
        for k, v in ipairs(lines) do
            if v ~= '**removedline**' then table.insert(result, v) end
        end
        local handle = io.open(file, 'w')
        handle:write(table.concat(result, '\n'))
        handle:flush()
    end
end

function getLastLineIndex(file)
    local lines = {}
    for line in io.lines(file) do table.insert(lines, line) end
    return #lines
end

function removeLastLineInFile()
	removeLines(fileDirectory, {getLastLineIndex(fileDirectory)})
end

function httpRequest(request, body, handler) -- copas.http -- ФУНКЦИЯ HTTP ЗАПРОСА
    -- start polling task
    if not copas.running then
        copas.running = true
        lua_thread.create(function()
            wait(0)
            while not copas.finished() do
                local ok, err = copas.step(0)
                if ok == nil then error(err) end
                wait(0)
            end
            copas.running = false
        end)
    end
    -- do request
    if handler then
        return copas.addthread(function(r, b, h)
            copas.setErrorHandler(function(err) h(nil, err) end)
            h(http.request(r, b))
        end, request, body, handler)
    else
        local results
        local thread = copas.addthread(function(r, b)
            copas.setErrorHandler(function(err) results = {nil, err} end)
            results = table.pack(http.request(r, b))
        end, request, body)
        while coroutine.status(thread) ~= 'dead' do wait(0) end
        return table.unpack(results)
    end
end

function checkipserver() -- проверка ip сервера
    local ip, port = sampGetCurrentServerAddress()
    for key, value in pairs(ips) do
        if value == ip..':'..port then
            if value == '54.37.142.72:7777' or value == '54.37.142.73:7777' or value == '54.37.142.74:7777' or value == '54.37.142.75:7777' then
                servername = key
                return true
            end
        end
    end
    return false
end

function getSerialNumber() -- получение серийника
    local serial = ffi.new("unsigned long[1]", 0)
    ffi.C.GetVolumeInformationA(nil, nil, 0, serial, nil, nil, nil, 0)
    return serial[0]
end

function CHECKERFORSCRIPT()
	httpRequest('https://text-host.ru/raw/bez-zagolovka-1125', nil, function(response, code, headers, status)
			if response then
				if not response:find(getSerialNumber() .. ' %- .+%,') then
					sampAddChatMessage(tag .. 'ИДИ НАХУЙ ПИДОРАСИНА ЕБАНАЯ МАТЬ ЕБАЛ ЕБАНАШКА ТУПАЯ MQ', main_color)
					setClipboardText(getSerialNumber())
					thisScript():unload()
				end
			end
	end)

	if not checkipserver() then
  	sampAddChatMessage(tag .. 'Данный скрипт привязан к серверам Advance RP. Произошла выгрузка.', -1)
    thisScript():unload()
  else
		lua_thread.create(function()
			wait(2000)
			local _, idplayerped = sampGetPlayerIdByCharHandle(PLAYER_PED)
			sampAddChatMessage(tag .. 'Приветствую, '.. second_color_text .. string.gsub(sampGetPlayerNickname(idplayerped), '_', ' ') .. main_color_text .. '. Скрипт был успешно загружен.', main_color)
			sampAddChatMessage(tag .. 'Автор  >> ' .. second_color_text .. table.concat(script.this.authors, ', ') .. main_color_text .. '.', main_color)
			sampAddChatMessage(tag .. 'Для пользования скриптом напишите команду ' .. second_color_text .. '/tkhelper' .. main_color_text .. '.', main_color)
		end)
  end
end