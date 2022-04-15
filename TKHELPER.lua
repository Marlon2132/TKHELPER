script_name('TK HELPER')
script_authors('Marlon')
script_description('helper')



require 'lib.moonloader'



local dlstatus = require('moonloader').download_status

update_state = false

local script_vers = 2
local script_vers_text = '1.01'

local script_path = thisScript().path
local script_url = 'https://github.com/Marlon2132/TKHELPER/blob/main/TKHELPER.luac?raw=true'

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
				sampAddChatMessage(tag .. 'Åñòü îáíîâëåíèå! Âåðñèÿ: ' .. updateIni.info.vers_text , main_color)
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
					sampAddChatMessage(tag .. 'Ñêðèïò îáíîâë¸í.', main_color)
					thisScript():reload()
				end
			end)
			break
		end
	
		if nastroikastatuszakaz ~= 1 then
			if on == 2 or on == 3 then
				if vodilnamarshrutenow == -1 then
					renderFontDrawText(my_font, blue_color_text .. tochkaotmarshrut .. '\n' .. tochkadomarshrut .. '\n' .. main_color_text .. 'Ìàêñèìàëüíî ' .. green_color_text .. maxprod - otvezenoprod .. ' åä. (ïî ' .. stoimostza1prod .. '$)' .. main_color_text .. '\nÌàêñèìàëüíî ' .. second_color_text .. (maxprod - otvezenoprod) * stoimostza1prod * (1-komissiya) .. '$\n' .. red_color_text .. vodilnamarshrute .. main_color_text .. ' âîäèòåëü(-ÿ, -åé)' , raspolozhsw, raspolozhsh, 0xFFFFFFFF)
				else
					renderFontDrawText(my_font, blue_color_text .. tochkaotmarshrut .. '\n' .. tochkadomarshrut .. '\n' .. main_color_text .. 'Ìàêñèìàëüíî ' .. green_color_text .. maxprod - otvezenoprod .. ' åä. (ïî ' .. stoimostza1prod .. '$)' .. main_color_text .. '\nÌàêñèìàëüíî ' .. second_color_text .. (maxprod - otvezenoprod) * stoimostza1prod * (1-komissiya) .. '$\n' .. red_color_text .. vodilnamarshrutenow .. main_color_text .. ' âîäèòåëü(-ÿ, -åé)' , raspolozhsw, raspolozhsh, 0xFFFFFFFF)
				end
			elseif on == 4 then
				renderFontDrawText(my_font, blue_color_text .. tochkaotmarshrut .. '\n' .. tochkadomarshrut .. '\n' .. green_color_text .. vzyatoprods .. ' åä. (ïî ' .. stoimostza1prod .. '$)\n' .. second_color_text .. vzyatoprods * stoimostza1prod * (1-komissiya) .. '$' , raspolozhsw, raspolozhsh, 0xFFFFFFFF)
			end
		else
			local xmousecord, ymousecord = getCursorPos()
			renderFontDrawText(my_font, blue_color_text .. 'Ïîðò LS\nÍåôòåçàâîä\n' .. main_color_text .. 'Ìàêñèìàëüíî ' .. green_color_text .. '5000 åä. (ïî 3$)' .. main_color_text .. '\nÌàêñèìàëüíî ' .. second_color_text .. '15000$\n' .. red_color_text .. '3' .. main_color_text .. ' âîäèòåëü(-ÿ, -åé)' , xmousecord, ymousecord, 0xFFFFFFFF)	
		end
		wait(0)

    --[[if maxprod ~= nil and otvezenoprod ~= nil then
			wait(1000)
    	sampAddChatMessage(tochkaotmarshrutforgorod .. ' - ' .. tochkadomarshrutforcheck .. ', ' .. stoimostza1prod .. '$ ' .. otvezenoprod .. '/' .. maxprod .. ' ' .. vodilnamarshrute, main_color)
    end]]

		if isKeyJustPressed(VK_L) and not sampIsChatInputActive() and activatescript == 1 then -- ÊËÀÂÈØÀ è àêòèâàöèÿ
			if on == 0 then
				on = 1
				--[[for _, znachenie in ipairs(goroda) do
					sampAddChatMessage(znachenie, main_color)
				end]]
				sampAddChatMessage(tag .. 'Ïîèñê ïîäõîäÿùèõ çàêàçîâ...', main_color)
				sampSendChat('/order')
			else
				on = 0
				checkprods = 0
				sampAddChatMessage(tag .. 'Ëîâëÿ çàêàçîâ îñòàíîâëåíà.', main_color)
			end
		end

		if isKeyJustPressed(VK_M) and not sampIsChatInputActive() and activatescript == 1 then
			if rejim == 0 then
				rejim = 1
				sampAddChatMessage(tag .. 'Âûáðàí ' .. second_color_text .. 'ôèëüòðîâàííûé ' .. main_color_text .. 'ðåæèì.', main_color)
			else
				rejim = 0
				sampAddChatMessage(tag .. 'Âûáðàí ' .. second_color_text .. 'ñâîáîäíûé ' .. main_color_text .. 'ðåæèì.', main_color)
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
						sampAddChatMessage(tag .. 'Ñêðèïò ' .. second_color_text .. 'àêòèâèðîâàí.' ,main_color)
						showlcldlg(8000)
					else
						activatescript = 0
						on = 0
						sampAddChatMessage(tag .. 'Ñêðèïò ' .. second_color_text .. 'âûêëþ÷åí.' ,main_color)
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
					sampAddChatMessage(tag .. second_color_text .. 'Âûáåðèòå ìåñòî, ' .. main_color_text .. 'ãäå õîòèòå óñòàíîâèòü ñòàòóñ çàêàçà è ' .. second_color_text .. 'íàæìèòå «ËÊÌ».', main_color)
					sampAddChatMessage(tag .. '×òîáû ' .. second_color_text .. 'îòìåíèòü ' .. main_color_text .. 'íàñòðîéêó ' .. second_color_text .. 'íàæìèòå «ESC».', main_color)
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
				sampAddChatMessage(tag .. 'Ôèíàíñîâàÿ ñòàòèñòèêà áûëà ' .. second_color_text .. 'î÷èùåíà.', main_color)
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
			sampAddChatMessage(tag .. 'Êîîðäèíàòû ñòàòóñà çàêàçà ' .. second_color_text .. 'ñîõðàíåíû.', main_color)
			save()
		end
		if wParam == 0x1B then
			consumeWindowMessage()
			showCursor(false, false)
			nastroikastatuszakaz = 0
			sampAddChatMessage(tag .. 'Íàñòðîéêà ñòàòóñà çàêàçà ' .. second_color_text .. 'áûëà îòìåíåíà.', main_color)
		end
	end
end

function cmd_komka(arg)
	if arg == nil or arg == '' or arg == ' ' or #arg == 0 then
		komissiya = 0
		sampAddChatMessage(tag .. 'Êîìèññèÿ áûëà ' .. second_color_text .. 'ñáðîøåíà ' .. main_color_text .. 'èëè Âû ' .. second_color_text .. 'íå ââåëè (íåïðàâèëüíî ââåëè) çíà÷åíèå.', main_color)
	else
		if arg:find('%D+') then
			komissiya = 0
			sampAddChatMessage(tag .. 'Êîìèññèÿ áûëà ' .. second_color_text .. 'ñáðîøåíà ' .. main_color_text .. 'èëè Âû ' .. second_color_text .. 'íå ââåëè (íåïðàâèëüíî ââåëè) çíà÷åíèå.', main_color)
		else
			if tonumber(arg) < 100 and tonumber(arg) > 0 then
				komissiya = tonumber(arg)/100
				sampAddChatMessage(tag .. 'Êîìèññèÿ êîìïàíèè ' .. second_color_text .. 'óñòàíîâëåíà ' .. main_color_text .. 'íà ' .. second_color_text .. arg .. ' ïðîöåíòà(-îâ).', main_color)
			elseif tonumber(arg) >= 100 or tonumber(arg) < 0 then
				komissiya = 0
				sampAddChatMessage(tag .. 'Êîìèññèÿ áûëà ' .. second_color_text .. 'ñáðîøåíà ' .. main_color_text .. 'èëè Âû ' .. second_color_text .. 'íå ââåëè (íåïðàâèëüíî ââåëè) çíà÷åíèå.', main_color)
			end
		end
	end
	save()
end

function cmd_gorod(arg)
	if arg == '1' then
		goroda = {'Ïîðò LS', 'Çàâîä ïðîäóêòîâ', 'Òåìïë Äðàéâ', 'Ëîñ-Ñàíòîñ Èíòåðíåéøíë', 'Ñêëàä Ìèäë', 'Ìåáåëüíûé ñêëàä ËÑ', 'Îêåàíñêèé ïîðò', 'Ýâåðè Êîíñòðàêøí', 'Ñêëàä Ìîíòãîìåððè', 'Ñêëàä Áëóáåððè', 'Îêðóã Ðåä'}
		sampAddChatMessage(tag .. 'Ëîâëÿ çàêàçîâ óñòàíîâëåíà â ' .. second_color_text .. 'ã. Ëîñ-Ñàíòîñ.', main_color)
		if rejim == 0 then
			rejim = 1
			sampAddChatMessage(tag .. 'Âûáðàí ' .. second_color_text .. 'ôèëüòðîâàííûé ' .. main_color_text .. 'ðåæèì.', main_color)
		end
	elseif arg == '2' then
		goroda = {'Íåôòåçàâîä', 'Ñòàíöèÿ Åëîó Áåëë', 'Ëàñ%-Ïàéàñàäàñ', 'Ñåâåðíûé ñêëàä ËÂ', 'Âîñòî÷íàÿ ñòðîéêà', 'ÀÝÑ', 'Ìåáåëüíûé ñêëàä ËÂ', 'Òüåððà%-Ðîáàäà', 'Âîñòî÷íûé ñêëàä', 'Êàçèíî Ðîçîâûé ëåáåäü', 'Êàçèíî Êàìåëîò', 'Ýëü Êåáðàäîñ', '%{......%}', 'Ñòàäèîí', 'Òðàíèçîñòîðíûé çàâîä'}
		sampAddChatMessage(tag .. 'Ëîâëÿ çàêàçîâ óñòàíîâëåíà â ' .. second_color_text .. 'ã. Ëàñ-Âåíòóðàñ.', main_color)
		if rejim == 0 then
			rejim = 1
			sampAddChatMessage(tag .. 'Âûáðàí ' .. second_color_text .. 'ôèëüòðîâàííûé ' .. main_color_text .. 'ðåæèì.', main_color)
		end
	elseif arg == '3' then
		goroda = {'Ïîðò SF', 'ÆÊ Ñèëîâè÷îê', 'Ýíäæåë Ïýéí', 'Ãîëäåí Ãåéò Áðèäæ', 'Òðàìâàéíîå äåïî', 'Ëåñõîç', 'Àâòîñàëîí ÑÔ', 'Ìèíèñòåðñòâî Çäðàâîîõðàíåíèÿ', 'Áàíêîâñêèé ïîðò', 'Òðàíñëÿöèîííàÿ ñòàíöèÿ', 'Áýéñàéä', 'Ìåáåëüíûé ñêëàä ÑÔ', 'ÆÊ Âàâèëîí', 'Ôåðìà', 'Ëîäî÷íûé ïèðñ', 'Õèì%. çàâîä', 'Óýòñòîóí'}
		sampAddChatMessage(tag .. 'Ëîâëÿ çàêàçîâ óñòàíîâëåíà â ' .. second_color_text .. 'ã. Ñàí-Ôèåððî.', main_color)
		if rejim == 0 then
			rejim = 1
			sampAddChatMessage(tag .. 'Âûáðàí ' .. second_color_text .. 'ôèëüòðîâàííûé ' .. main_color_text .. 'ðåæèì.', main_color)
		end
	else
		goroda = nil
		sampAddChatMessage(tag .. 'Ôèëüòð ãîðîäîâ áûë ' .. second_color_text .. 'ñáðîøåí ' .. main_color_text .. 'èëè Âû ' .. second_color_text .. 'íå ââåëè (íåïðàâèëüíî ââåëè) íîìåð ãîðîäà.', main_color)
	end
end

function cmd_mesto(arg)
	if arg == nil or arg == ' ' or arg == '' or #arg == 0  then
		filtrmest = nil
		sampAddChatMessage(tag .. 'Ôèëüòð ìåñò áûë ' .. second_color_text .. 'ñáðîøåí  ' .. main_color_text .. 'èëè Âû ' .. second_color_text .. 'íå ââåëè (íåïðàâèëüíî ââåëè) íàçâàíèå ìåñòà.', main_color)
	else
		filtrmest = string.gsub(tostring(arg):gsub('%.', '%.'), '%-', '%-')
		sampAddChatMessage(tag .. 'Ôèëüòð ìåñò áûë ' .. second_color_text .. 'óñòàíîâëåí ' .. main_color_text .. 'íà ' .. second_color_text .. tostring(arg) .. '.', main_color)
		if rejim == 0 then
			rejim = 1
			sampAddChatMessage(tag .. 'Âûáðàí ' .. second_color_text .. 'ôèëüòðîâàííûé ' .. main_color_text .. 'ðåæèì.', main_color)
		end
	end
end

function cmd_prods(arg)
	if tonumber(arg) == 0 or arg == nil or arg == ' ' or arg == '' or #arg == 0 then
		minimalkaprods = 1
		sampAddChatMessage(tag .. 'Ôèëüòð êîëè÷åñòâà ïðîäóêòîâ ' .. second_color_text .. 'ñáðîøåí ' .. main_color_text .. 'èëè Âû ' .. second_color_text ..'íå ââåëè (íåïðàâèëüíî ââåëè) çíà÷åíèå.', main_color)
	else
		minimalkaprods = tonumber(arg)
		sampAddChatMessage(tag .. 'Ôèëüòð êîëè÷åñòâà ïðîäóêòîâ óñòàíîâëåí íà ' .. second_color_text .. minimalkaprods .. ' åä.', main_color)
	end
	save()
end

function cmd_tkhelper()
	showlcldlg(8000)
end

function showlcldlg(arg)
	if arg == 8000 then
		sampShowDialog(8000, second_color_text .. 'TK HELPER: Ìåíþ', gray_color_text .. '1. ' .. main_color_text .. 'Ïîëíàÿ èíñòðóêöèÿ\n' .. gray_color_text .. '2. ' .. main_color_text .. 'Àêòèâàöèÿ\n' .. gray_color_text .. '3. ' .. main_color_text .. 'Ôèíàíñîâàÿ ñòàòèñòèêà\n' .. gray_color_text .. '4. ' .. main_color_text .. 'Íàñòðîéêè', 'Âûáðàòü', 'Çàêðûòü', 2)
	elseif arg == 8001 then
		sampShowDialog(8001, second_color_text .. 'TK HELPER: Ðåæèìû ðàáîòû', main_color_text .. 'Äàííûé ñêðèïò èìååò ìíîæåñòâî ôóíêöèé è ôèëüòðîâ, êîòîðûå ïîìîãóò Âàì çàðàáîòàòü äåíåã â ÒÊ.\nÑóùåñòâóåò ' .. second_color_text .. 'äâà ' .. main_color_text .. 'ðåæèìà ðàáîòû ñêðèïòà: ' .. second_color_text .. 'ñâîáîäíûé è ôèëüòðîâàííûé.\n(!) Ïî óìîë÷àíèþ ñòîèò ñâîáîäíûé ðåæèì.\n\n\t\t\t\t\t\t\t\t    ÑÂÎÁÎÄÍÛÉ\n\n' .. main_color_text .. 'Â ' .. second_color_text .. 'ñâîáîäíîì ðåæèìå ' .. main_color_text .. 'ñêðèïò ëîâèò àáñîëþòíî ëþáûå çàêàçû è íå ïîäâåðãàåòñÿ êàêèì-ëèáî ôèëüòðàì (èñêë. - ôèëüòð êîëè÷åñòâà ïðîäóêòîâ).' .. second_color_text .. '\n\n\t\t\t\t\t\t\t\tÔÈËÜÒÐÎÂÀÍÍÛÉ\n\n' .. main_color_text .. 'Â ' .. second_color_text .. 'ôèëüòðîâàííîì ðåæèìå ' .. main_color_text .. 'ñêðèïò ëîâèò âñå çàêàçû, êîòîðûå óäîâëåòâîðÿþò ôèëüòðàì.\n\n' .. second_color_text .. '(!) Ïðè àêòèâàöèè êàêîãî-ëèáî èç ôèëüòðîâ (êðîìå ôèëüòðà êîë-âà ïðîäóêòîâ) àâòîìàòè÷åñêè âêëþ÷àåòñÿ ôèëüòðîâàííûé ðåæèì.', 'Äàëåå', 'Íàçàä', 0)
	elseif arg == 8002 then
		sampShowDialog(8002, second_color_text .. 'TK HELPER: Ôèëüòðû', main_color_text .. 'Ñóùåñâóåò íåñêîëüêî âèäîâ ' .. second_color_text .. 'ôèëüòðîâ.\n\n' .. gray_color_text .. '1. ' .. second_color_text .. 'Ôèëüòð êîëè÷åñòâà ïðîäóêòîâ. ' .. main_color_text .. 'Äàííûé ôèëüòð ðåãóëèðóåò ìèíèìàëüíîå êîëè÷åñòâî ïðîäóêòîâ äëÿ ïðèíÿòèÿ çàêàçà.\n    ×òîáû àêòèâèðîâàòü ýòîò ôèëüòð ïðîïèøèòå êîìàíäó ' .. second_color_text .. '/prods. ' .. main_color_text .. 'Íàïðèìåð, Âû óñòàíîâèëè ' .. second_color_text .. '/prods 3000.' .. main_color_text .. 'Ñêðèïò áóäåò ëîâèòü\n    òîëüêî òå çàêàçû, â êîòîðûõ ìîæíî çàáðàòü 3000 è áîëåå ïðîäóêòîâ. Ýòîò ôèëüòð ðàáîòàåò â îáîèõ ðåæèìàõ.\n    ×òîáû ñáðîñèòü ôèëüòð äîñòàòî÷íî íàïèñàòü ' .. second_color_text .. '/prods.\n\n' .. gray_color_text .. '2. ' .. second_color_text .. 'Ôèëüòð íà÷àëüíûõ òî÷åê çàêàçîâ. ' .. main_color_text .. 'Ýòîò ôèëüòð ïîçâîëÿåò ñîðòèðîâàòü ìåñòà, èç êîòîðûõ áåð¸òñÿ çàêàç.\n    Ìåñò ìîæíî óêàçûâàòü íåñêîëüêî, à ìîæíî îäíî. ×òîáû àêòèâèðîâàòü ôèëüòð ïðîïèøèòå êîìàíäó ' .. second_color_text .. '/mesto.\n    ' .. main_color_text .. 'Íàïðèìåð, Âû âûáðàëè íåôòåçàâîä. Òîãäà ñêðèïò áóäåò ëîâèòü çàêàçû òîëüêî ñ íåôòåçàâîäà, è êîìàíäà áóäåò âûãëÿäåòü òàê: ' .. second_color_text .. '/mesto Íåôòåçàâîä.' .. main_color_text .. '\n    Åñëè Âû õîòèòå óêàçàòü íåñêîëüêî ìåñò, òîãäà íóæíî ðàçäåëÿòü ìåñòà ñèìâîëîì ' .. second_color_text .. '«/» ' .. main_color_text .. '(â ñàìîì êîíöå ñòàâèòü ýòîò çíàê íå îáÿçàòåëüíî).\n    Ê ïðèìåðó, Âû âûáðàëè íåôòåçàâîä è ïîðò LS. Òîãäà ñêðèïò áóäåò ëîâèòü çàêàçû òîëüêî ñ íåôòåçàâîäà è ïîðòà LS. Êîìàíäà áóäåò âûãëÿäåòü òàê: ' .. second_color_text .. '/mesto Íåôòåçàâîä/Ïîðò LS.' .. main_color_text .. '\n    ×òîáû ñáðîñèòü ôèëüòð íàïèøèòå êîìàíäó ' .. second_color_text .. '/mesto.' .. gray_color_text .. '\n\n3. ' .. second_color_text .. 'Ôèëüòð ãîðîäîâ. ' .. main_color_text .. 'Äàííûé ôèëüòð ïîçâîëÿåò ôèëüòðîâàòü òî÷êè, èç êîòîðûõ áåðóòñÿ çàêàçû, ïî ãîðîäàì. ×òîáû âêëþ÷èòü ôèëüòð íàïèøèòå êîìàíäó ' .. second_color_text .. '/gorod [1-3].' .. main_color_text .. '\n    1 - ' .. second_color_text .. 'Ëîñ-Ñàíòîñ.' .. main_color_text .. '\n    2 - ' .. second_color_text .. 'Ëàñ-Âåíòóðàñ.' .. main_color_text .. '\n    3 - ' .. second_color_text .. 'Ñàí-Ôèåððî.' .. main_color_text .. '\n    Íàïðèìåð, åñëè Âû íàïèñàëè ' .. second_color_text .. '/gorod 2, ' .. main_color_text .. 'òî ñêðèïò áóäåò ëîâèòü çàêàçû òîëüêî ñ Ëàñ-Âåíòóðàñà.\n    ×òîáû ñáðîñèòü ôèëüòð, íàïèøèòå êîìàíäó ' .. second_color_text .. '/gorod.\n\n    (!) Ïðèìå÷àíèå. Â ïðèîðèòåòå ïðîâåðêè çàêàçîâ ñòîèò ôèëüòð ìåñò. Ýòî çíà÷èò, ÷òî ñíà÷àëà ïðîâåðÿþòñÿ ìåñòà, à ïîòîì óæå ãîðîä.\n\n    (!) Îáðàòèòå âíèìàíèå, ÷òî ýòîò ôèëüòðû ìåñò è ãîðîäîâ ÷óâñòâèòåëüíû ê îðôîãðàôèè è ê ðåãèñòðó, à òàêæå òî÷êè èñïîëüçóþòñÿ íå äëÿ êîìàíäû, à äëÿ êîíöà ïðåäëîæåíèÿ!', 'Äàëåå', 'Íàçàä', 0)
	elseif arg == 8003 then
		sampShowDialog(8003, second_color_text .. 'TK HELPER: Ïðî÷åå', main_color_text .. '×òîáû ' .. second_color_text .. 'óñòàíîâèòü êîìèññèþ ' .. main_color_text .. 'êîìïàíèè íàïèøèòå êîìàíäó ' .. second_color_text .. '/komka.' .. main_color_text .. '\nÍàïðèìåð, åñëè âû õîòèòå óñòàíîâèòü êîìèññèþ 25 ïðîöåíòîâ, òî êîìàíäà áóäåò âûãëÿäåòü òàê: ' .. second_color_text .. '/komka 25.\nÄëÿ ñâîåé ôóðû êîìèññèÿ 5 ïðîöåíòîâ.' .. main_color_text .. '\n\nÑêðèïò àêòèâèðóåòñÿ íàæàòèåì âòîðîãî ïóíêòà â ìåíþ. Èìåííî ïîñëå àêòèâàöèè íà÷èíàþò ðàáîòàòü êíîïêè.\n\n' .. second_color_text .. '(!) Íå ïîëüçóéòåñü ÷àòîì è äèàëîãàìè âî âðåìÿ ðàáîòû ñêðèïòà.\nÅñëè íóæíî âîñïîëüçîâàòüñÿ ÷àòîì èëè äèàëîãîì, òî âûêëþ÷èòå ëîâëþ çàêàçîâ.', 'Äàëåå', 'Íàçàä', 0)
	elseif arg == 8004 then
		sampShowDialog(8004, second_color_text .. 'TK HELPER: Êíîïêè', main_color_text .. '×òîáû âêëþ÷èòü ëîâëþ íàæìèòå êëàâèøó ' .. second_color_text .. '«L».' .. main_color_text .. '\n×òîáû ñìåíèòü ðåæèì ëîâëè íàæìèòå êëàâèøó ' .. second_color_text .. '«M».', 'Äàëåå', 'Íàçàä', 0)
	elseif arg == 8005 then
		sampShowDialog(8005, second_color_text .. 'TK HELPER: Ïðîñìîòð ñòàòèñòèêè', second_color_text .. 'Ôèíàíñîâóþ ñòàòèñòèêó ' .. main_color_text .. 'ìîæíî ïðîñìîòðåòü íàæàòèåì òðåòüåãî ïóíêòà â ìåíþ.\nÒàì Âû ìîæåòå ïðîñìîòðåòü ñòàòèñòèêó çà äåíü, çà âñ¸ âðåìÿ.\nÒàêæå îòäåëüíî ìîæíî ïîñìîòðåòü ïðèáûëü çà êàæäûé äåíü è ñîîòâåòñòâóþùåé êíîïêîé î÷èñòèòü ñòàòèñòèêó.\n\nÑòàòèñòèêó ìîæíî ïîñìîòðåòü ïî ñëåäóþùåìó ïóòè:\n' .. second_color_text .. getGameDirectory() .. '\\moonloader\\config\\TKHELPER by Marlon.txt', 'Çàêðûòü', 'Íàçàä', 0)
	elseif arg == 8006 then
		sampShowDialog(8006, second_color_text .. 'TK HELPER: Íàñòðîéêè', gray_color_text .. '1. ' .. main_color_text .. 'Ñòàòóñ çàêàçà', 'Âûáðàòü', 'Íàçàä', 2)
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
		sampShowDialog(8020, second_color_text .. 'TK HELPER: Ôèíàíñîâàÿ ñòàòèñòèêà', ' \t \n' .. gray_color_text .. '1. ' .. main_color_text .. 'Âñåãî çàðàáîòàíî: \t' .. lightgreen_color_text .. '[' .. iii .. '$]\n' .. gray_color_text .. '2. ' .. main_color_text .. 'Çàðàáîòàíî çà äåíü: \t' .. lightgreen_color_text .. '[' .. segzarab .. '$]\n' .. gray_color_text .. '3. ' .. main_color_text .. 'Ïîëíàÿ ôèíàíñîâàÿ ñòàòèñòèêà: \t' .. second_color_text .. '[Ïîñìîòðåòü]\n' .. gray_color_text .. '4. ' .. main_color_text .. 'Î÷èñòèòü ôèíàíñîâóþ ñòàòèñòèêó: \t' .. red_color_text .. '[Î÷èñòèòü]', 'Âûáðàòü', 'Íàçàä', 5)
	elseif arg == 8021 then
		finstat = ''
		f:seek('set', 0)
		for line in f:lines() do
			chisl, mesyac, god, zarab = line:match('(%d+)%/(%d+)%/(%d+) (%d+)%$')
			finstat = finstat .. '\n' .. main_color_text .. chisl .. '.' .. mesyac .. '.' .. god .. '\t' .. lightgreen_color_text .. zarab ..'$' 
		end
		sampShowDialog(8021, second_color_text .. 'TK HELPER: Ïîëíàÿ ôèíàíñîâàÿ ñòàòèñòèêà', second_color_text .. 'Äàòà:\tÏðèáûëü:' .. finstat , 'Âûáðàòü', 'Íàçàä', 5)
	elseif arg == 8022 then
		sampShowDialog(8022, second_color_text .. 'TK HELPER: Ïîäòâåðæäåíèå äåéñòâèÿ', main_color_text .. 'Âû ' .. second_color_text .. 'óâåðåíû, ' .. main_color_text .. '÷òî õîòèòå ' .. second_color_text .. 'î÷èñòèòü ôèíàíñîâóþ ñòàòèñòèêó?', 'Äà', 'Íåò', 0)
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
								--sampAddChatMessage(tag .. 'Çàêàç ' .. second_color_text .. 'äåéñòâèòåëåí. ' .. main_color_text .. 'Íà íåãî îòïðàâëÿåòñÿ ' .. red_color_text .. vodilnamarshrutenow .. main_color_text .. ' âîäèòåëü(-ÿ, -åé) ïîìèìî Âàñ.' , main_color)
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
								--sampAddChatMessage(tag .. 'Çàêàç ' .. second_color_text .. 'äåéñòâèòåëåí. ' .. main_color_text .. 'Íà íåãî íèêòî íå îòïðàâèëñÿ ïîìèìî Âàñ.' , main_color)
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
							sampAddChatMessage(tag .. 'Çàêàç ' .. red_color_text .. 'íåäåéñòâèòåëåí. ' .. main_color_text .. 'Èä¸ò ïîèñê íîâûõ çàêàçîâ...', main_color)
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
			if text == 'Âû âûáðàëè çàêàç. Îòïðàâëÿéòåñü ê ìåñòó çàãðóçêè' then
				on = 3
				sampAddChatMessage(tag .. 'Íàéäåí çàêàç! ' .. blue_color_text .. tochkaotmarshrut .. ' - ' .. tochkadomarshrut .. green_color_text .. ' (' .. maxprod - otvezenoprod .. ' åä. ïî ' .. stoimostza1prod .. '$) ' .. main_color_text .. '| ' .. second_color_text .. (maxprod - otvezenoprod) * stoimostza1prod * (1-komissiya) .. '$.' , main_color)
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
			if text:find('Âû çàãðóçèëè {FFAA00}%d+ åä. ãðóçà{3399FF}, îòïðàâëÿéòåñü ê ìåñòó ðàçãðóçêè') then
				on = 4
				checkprods = 0
				vzyatoprods = text:match('Âû çàãðóçèëè {FFAA00}(%d+) åä. ãðóçà{3399FF}, îòïðàâëÿéòåñü ê ìåñòó ðàçãðóçêè')
				sampAddChatMessage('222', main_color)
			end
		end
		if color == -10092289 then
			if text == 'Äàííûé çàêàç áîëåå íå äåéñòâèòåëåí' then
				on = 1
				sampAddChatMessage(tag .. 'Ïîèñê ïîäõîäÿùèõ çàêàçîâ...', main_color)
				lua_thread.create(function()
					wait(200)
					sampSendChat('/order')
				end)
			end
		end
		if color == 1724645631 then
			if text == 'Öåëü îòìå÷åíà íà êàðòå' then
				return false
			end
		end
	end
	if on == 4 then
		if color == 865730559 then
			if text:find('Âû ïðèâåçëè %{FFAA00%}%d+ åä. ãðóçà %{3399FF%}è ïîëó÷èëè %{00cc99%}%d+%$%{3399FF%}. Êîìèññèÿ êîìïàíèè %{ff8080%}%d+%$') or text:find('Âû ïðèâåçëè %{FFAA00%}%d+ åä. ãðóçà %{3399FF%}è ïîëó÷èëè %{00cc99%}%d+%$ íà êàæäîãî âîäèòåëÿ%{3399FF%}. Êîìèññèÿ êîìïàíèè %{ff8080%}%d+%$') then
				on = 1
				vzyatoprods = 0
				local zarabotaltolkochto = text:match('Âû ïðèâåçëè %{FFAA00%}%d+ åä. ãðóçà %{3399FF%}è ïîëó÷èëè %{00cc99%}(%d+)%$%{3399FF%}. Êîìèññèÿ êîìïàíèè %{ff8080%}%d+%$')
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
				sampAddChatMessage(tag .. 'Ïîèñê ïîäõîäÿùèõ çàêàçîâ...', main_color)
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

function httpRequest(request, body, handler) -- copas.http -- ÔÓÍÊÖÈß HTTP ÇÀÏÐÎÑÀ
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

function checkipserver() -- ïðîâåðêà ip ñåðâåðà
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

function getSerialNumber() -- ïîëó÷åíèå ñåðèéíèêà
    local serial = ffi.new("unsigned long[1]", 0)
    ffi.C.GetVolumeInformationA(nil, nil, 0, serial, nil, nil, nil, 0)
    return serial[0]
end

function CHECKERFORSCRIPT()
	httpRequest('https://text-host.ru/raw/bez-zagolovka-1125', nil, function(response, code, headers, status)
			if response then
				if not response:find(getSerialNumber() .. ' %- .+%,') then
					sampAddChatMessage(tag .. 'ÈÄÈ ÍÀÕÓÉ ÏÈÄÎÐÀÑÈÍÀ ÅÁÀÍÀß ÌÀÒÜ ÅÁÀË ÅÁÀÍÀØÊÀ ÒÓÏÀß MQ', main_color)
					setClipboardText(getSerialNumber())
					thisScript():unload()
				end
			end
	end)

	if not checkipserver() then
  	sampAddChatMessage(tag .. 'Äàííûé ñêðèïò ïðèâÿçàí ê ñåðâåðàì Advance RP. Ïðîèçîøëà âûãðóçêà.', -1)
    thisScript():unload()
  else
		lua_thread.create(function()
			wait(2000)
			local _, idplayerped = sampGetPlayerIdByCharHandle(PLAYER_PED)
			sampAddChatMessage(tag .. 'Ïðèâåòñòâóþ, '.. second_color_text .. string.gsub(sampGetPlayerNickname(idplayerped), '_', ' ') .. main_color_text .. '. Ñêðèïò áûë óñïåøíî çàãðóæåí.', main_color)
			sampAddChatMessage(tag .. 'Àâòîð  >> ' .. second_color_text .. table.concat(script.this.authors, ', ') .. main_color_text .. '.', main_color)
			sampAddChatMessage(tag .. 'Äëÿ ïîëüçîâàíèÿ ñêðèïòîì íàïèøèòå êîìàíäó ' .. second_color_text .. '/tkhelper' .. main_color_text .. '.', main_color)
		end)
  end
end
