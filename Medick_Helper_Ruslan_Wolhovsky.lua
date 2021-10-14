script_name('Medick Helper')
script_version '3.8.2 BETA 1'
local dlstatus = require "moonloader".download_status
script_author('Doni_Baerra,Makar_Sheludkov,Ruslan_Wolhovsky')
local sf = require 'sampfuncs'
local key = require "vkeys"
local inicfg = require 'inicfg'
local a = require 'samp.events'
local sampev = require 'lib.samp.events'
local imgui = require 'imgui' -- загружаем библиотеку/
local encoding = require 'encoding' -- загружаем библиотеку
local wm = require 'lib.windows.message'
local gk = require 'game.keys'
local dlstatus = require('moonloader').download_status
local second_window = imgui.ImBool(false)
local third_window = imgui.ImBool(false)
local first_window = imgui.ImBool(false)
local bMainWindow = imgui.ImBool(false)
local sInputEdit = imgui.ImBuffer(128)
local tCarsName = {"Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck", "Trashmaster", "Stretch", "Manana", "Infernus",
"Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam", "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BFInjection", "Hunter",
"Premier", "Enforcer", "Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach", "Cabbie", "Stallion", "Rumpo",
"RCBandit", "Romero","Packer", "Monster", "Admiral", "Squalo", "Seasparrow", "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed",
"Yankee", "Caddy", "Solair", "Berkley'sRCVan", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RCBaron", "RCRaider", "Glendale", "Oceanic", "Sanchez", "Sparrow",
"Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton", "Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage",
"Dozer", "Maverick", "NewsChopper", "Rancher", "FBIRancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "BlistaCompact", "PoliceMaverick",
"Boxvillde", "Benson", "Mesa", "RCGoblin", "HotringRacerA", "HotringRacerB", "BloodringBanger", "Rancher", "SuperGT", "Elegant", "Journey", "Bike",
"MountainBike", "Beagle", "Cropduster", "Stunt", "Tanker", "Roadtrain", "Nebula", "Majestic", "Buccaneer", "Shamal", "hydra", "FCR-900", "NRG-500", "HPV1000",
"CementTruck", "TowTruck", "Fortune", "Cadrona", "FBITruck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan", "Blade", "Freight",
"Streak", "Vortex", "Vincent", "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder", "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada",
"Yosemite", "Windsor", "Monster", "Monster", "Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RCTiger", "Flash", "Tahoma", "Savanna", "Bandito",
"FreightFlat", "StreakCarriage", "Kart", "Mower", "Dune", "Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30", "Huntley", "Stafford", "BF-400", "NewsVan",
"Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club", "FreightBox", "Trailer", "Andromada", "Dodo", "RCCam", "Launch", "PoliceCar", "PoliceCar",
"PoliceCar", "PoliceRanger", "Picador", "S.W.A.T", "Alpha", "Phoenix", "GlendaleShit", "SadlerShit", "Luggage A", "Luggage B", "Stairs", "Boxville", "Tiller",
"UtilityTrailer"}
local tCarsTypeName = {"Автомобиль", "Мотоицикл", "Вертолёт", "Самолёт", "Прицеп", "Лодка", "Другое", "Поезд", "Велосипед"}
local tCarsSpeed = {43, 40, 51, 30, 36, 45, 30, 41, 27, 43, 36, 61, 46, 30, 29, 53, 42, 30, 32, 41, 40, 42, 38, 27, 37,
54, 48, 45, 43, 55, 51, 36, 26, 30, 46, 0, 41, 43, 39, 46, 37, 21, 38, 35, 30, 45, 60, 35, 30, 52, 0, 53, 43, 16, 33, 43,
29, 26, 43, 37, 48, 43, 30, 29, 14, 13, 40, 39, 40, 34, 43, 30, 34, 29, 41, 48, 69, 51, 32, 38, 51, 20, 43, 34, 18, 27,
17, 47, 40, 38, 43, 41, 39, 49, 59, 49, 45, 48, 29, 34, 39, 8, 58, 59, 48, 38, 49, 46, 29, 21, 27, 40, 36, 45, 33, 39, 43,
43, 45, 75, 75, 43, 48, 41, 36, 44, 43, 41, 48, 41, 16, 19, 30, 46, 46, 43, 47, -1, -1, 27, 41, 56, 45, 41, 41, 40, 41,
39, 37, 42, 40, 43, 33, 64, 39, 43, 30, 30, 43, 49, 46, 42, 49, 39, 24, 45, 44, 49, 40, -1, -1, 25, 22, 30, 30, 43, 43, 75,
36, 43, 42, 42, 37, 23, 0, 42, 38, 45, 29, 45, 0, 0, 75, 52, 17, 32, 48, 48, 48, 44, 41, 30, 47, 47, 40, 41, 0, 0, 0, 29, 0, 0
}
local tCarsType = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1,
3, 1, 1, 1, 1, 6, 1, 1, 1, 1, 5, 1, 1, 1, 1, 1, 7, 1, 1, 1, 1, 6, 3, 2, 8, 5, 1, 6, 6, 6, 1,
1, 1, 1, 1, 4, 2, 2, 2, 7, 7, 1, 1, 2, 3, 1, 7, 6, 6, 1, 1, 4, 1, 1, 1, 1, 9, 1, 1, 6, 1,
1, 3, 3, 1, 1, 1, 1, 6, 1, 1, 1, 3, 1, 1, 1, 7, 1, 1, 1, 1, 1, 1, 1, 9, 9, 4, 4, 4, 1, 1, 1,
1, 1, 4, 4, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 7, 1, 1, 1, 1, 8, 8, 7, 1, 1, 1, 1, 1, 1, 1,
1, 3, 1, 1, 1, 1, 4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 7, 1, 1, 1, 1, 8, 8, 7, 1, 1, 1, 1, 1, 4,
1, 1, 1, 2, 1, 1, 5, 1, 2, 1, 1, 1, 7, 5, 4, 4, 7, 6, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 5, 5, 1, 5, 5
}
local bIsEnterEdit = imgui.ImBool(false)
local ystwindow = imgui.ImBool(false)
local helps = imgui.ImBool(false)
local obnova = imgui.ImBool(false)
local infbar = imgui.ImBool(false)
local updwindows = imgui.ImBool(false)
local tEditData = {
	id = -1,
	inputActive = false
}
encoding.default = 'CP1251' -- указываем кодировку по умолчанию, она должна совпадать с кодировкой файла. CP1251 - это Windows-1251
u8 = encoding.UTF8
local fa = require 'faIcons'
local fa_glyph_ranges = imgui.ImGlyphRanges({ fa.min_range, fa.max_range })
function imgui.BeforeDrawFrame()
    if fa_font == nil then
        local font_config = imgui.ImFontConfig() -- to use 'imgui.ImFontConfig.new()' on error
        font_config.MergeMode = true
        fa_font = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/resource/fonts/fontawesome-webfont.ttf', 14.0, font_config, fa_glyph_ranges)
    end
end
require 'lib.sampfuncs'
seshsps = 1
ctag = "{9966cc} Medick Helper {ffffff}|"
players1 = {'{ffffff}Ник\t{ffffff}Ранг'}
players2 = {'{ffffff}Дата принятия\t{ffffff}Ник\t{ffffff}Ранг\t{ffffff}Статус'}
frak = nil
rang = nil
ttt = nil
dostavka = false
rabden = false
tload = false
changetextpos = false
tLastKeys = {}
narkoh = 0
health = 0
departament = {}
smslogs = {}
radio = {}
vixodid = {}
local config_keys = {
    fastsms = { v = {}}
}
function apply_custom_style()

	imgui.SwitchContext()
	local style = imgui.GetStyle()
	local colors = style.Colors
	local clr = imgui.Col
	local ImVec4 = imgui.ImVec4
	local ImVec2 = imgui.ImVec2

	style.WindowPadding = ImVec2(15, 15)
	style.WindowRounding = 6.0
	style.FramePadding = ImVec2(5, 5)
	style.FrameRounding = 4.0
	style.ItemSpacing = ImVec2(12, 8)
	style.ItemInnerSpacing = ImVec2(8, 6)
	style.IndentSpacing = 25.0
	style.ScrollbarSize = 15.0
	style.ScrollbarRounding = 9.0
	style.GrabMinSize = 5.0
	style.GrabRounding = 3.0

    colors[clr.WindowBg]              = ImVec4(0.14, 0.12, 0.16, 1.00);
    colors[clr.ChildWindowBg]         = ImVec4(0.30, 0.20, 0.39, 0.00);
	colors[clr.PopupBg]               = ImVec4(0.05, 0.05, 0.10, 0.90);
    colors[clr.Border]                = ImVec4(0.89, 0.85, 0.92, 0.30);
    colors[clr.BorderShadow]          = ImVec4(0.00, 0.00, 0.00, 0.00);
	colors[clr.FrameBg]               = ImVec4(0.30, 0.20, 0.39, 1.00);
	colors[clr.FrameBgHovered]        = ImVec4(0.41, 0.19, 0.63, 0.68);
	colors[clr.FrameBgActive]         = ImVec4(0.41, 0.19, 0.63, 1.00);
	colors[clr.TitleBg]               = ImVec4(0.41, 0.19, 0.63, 0.45);
	colors[clr.TitleBgCollapsed]      = ImVec4(0.41, 0.19, 0.63, 0.35);
	colors[clr.TitleBgActive]         = ImVec4(0.41, 0.19, 0.63, 0.78);
	colors[clr.MenuBarBg]             = ImVec4(0.30, 0.20, 0.39, 0.57);
	colors[clr.ScrollbarBg]           = ImVec4(0.30, 0.20, 0.39, 1.00);
	colors[clr.ScrollbarGrab]         = ImVec4(0.41, 0.19, 0.63, 0.31);
	colors[clr.ScrollbarGrabHovered]  = ImVec4(0.41, 0.19, 0.63, 0.78);
	colors[clr.ScrollbarGrabActive]   = ImVec4(0.41, 0.19, 0.63, 1.00);
	colors[clr.ComboBg]               = ImVec4(0.30, 0.20, 0.39, 1.00);
	colors[clr.CheckMark]             = ImVec4(0.56, 0.61, 1.00, 1.00);
	colors[clr.SliderGrab]            = ImVec4(0.41, 0.19, 0.63, 0.24);
	colors[clr.SliderGrabActive]      = ImVec4(0.41, 0.19, 0.63, 1.00);
	colors[clr.Button]                = ImVec4(0.41, 0.19, 0.63, 0.44);
	colors[clr.ButtonHovered]         = ImVec4(0.41, 0.19, 0.63, 0.86);
	colors[clr.ButtonActive]          = ImVec4(0.64, 0.33, 0.94, 1.00);
	colors[clr.Header]                = ImVec4(0.41, 0.19, 0.63, 0.76);
	colors[clr.HeaderHovered]         = ImVec4(0.41, 0.19, 0.63, 0.86);
	colors[clr.HeaderActive]          = ImVec4(0.41, 0.19, 0.63, 1.00);
	colors[clr.ResizeGrip]            = ImVec4(0.41, 0.19, 0.63, 0.20);
	colors[clr.ResizeGripHovered]     = ImVec4(0.41, 0.19, 0.63, 0.78);
	colors[clr.ResizeGripActive]      = ImVec4(0.41, 0.19, 0.63, 1.00);
	colors[clr.CloseButton]           = ImVec4(1.00, 1.00, 1.00, 0.75);
	colors[clr.CloseButtonHovered]    = ImVec4(0.88, 0.74, 1.00, 0.59);
	colors[clr.CloseButtonActive]     = ImVec4(0.88, 0.85, 0.92, 1.00);
	colors[clr.PlotLines]             = ImVec4(0.89, 0.85, 0.92, 0.63);
	colors[clr.PlotLinesHovered]      = ImVec4(0.41, 0.19, 0.63, 1.00);
	colors[clr.PlotHistogram]         = ImVec4(0.89, 0.85, 0.92, 0.63);
	colors[clr.PlotHistogramHovered]  = ImVec4(0.41, 0.19, 0.63, 1.00);
	colors[clr.TextSelectedBg]        = ImVec4(0.41, 0.19, 0.63, 0.43);
	colors[clr.ModalWindowDarkening]  = ImVec4(0.20, 0.20, 0.20, 0.35);
end
apply_custom_style()

local fileb = getWorkingDirectory() .. "\\config\\medick.bind"
local tBindList = {}
if doesFileExist(fileb) then
	local f = io.open(fileb, "r")
	if f then
		tBindList = decodeJson(f:read())
		f:close()
	end
else
	tBindList = {
        [1] = {
            text = "",
            v = {key.VK_No}
        }
	}
end

local medick =
{
  main =
  {
    posX = 1738,
    posY = 974,
    widehud = 320,
    male = true,
    wanted == false,
    clear == false,
    hud = false,
    tar = 'Интерн',
	tarr = 'Ваш Тэг',
	tarb = false,
	clistb = false,
	clisto = false,
	givra = false,
    clist = 0,
	health = 0,
	narkoh = 0,
  },
  commands =
  {
    ticket = false,
	zaderjka = 5
  },
   keys =
  {
	tload = 113,
	tazer = 113,
	fastmenu = 114,
  }
}
cfg = inicfg.load(nil, 'medick/config.ini')
test = imgui.CreateTextureFromFile(getGameDirectory() .. '\\moonloader\\medick\\images\\arz.png')
local libs = {'sphere.lua', 'rkeys.lua', 'imcustom/hotkey.lua', 'imgui.lua', 'MoonImGui.dll', 'imgui_addons.lua'}
function main()
  while not isSampAvailable() do wait(1000) end
  if seshsps == 1 then
	ftext('Medick Helper успешно загружен.',-1)
	ftext('Глав.Врач: Ruslan Wolhovsky.',-1)
	ftext('Скрипт редактировал: Doni Baerra, Makar Sheludkov, Ruslan Wolhovsky',-1)
	ftext('Функции скрипта команда и кнопка: {ff0000} /mh и F3 или ПКМ+Z',-1)
	ftext('Перезагрузить скрипт если отключится, одновременно нажать {ff0000}Ctrl+R.',-1)
  end
  if not doesDirectoryExist('moonloader/config/medick/') then createDirectory('moonloader/config/medick/') end
  if cfg == nil then
    sampAddChatMessage("{9966cc}Medick Help {ffffff}| Отсутсвует файл конфига, создаем.", -1)
    if inicfg.save(medick, 'medick/config.ini') then
      sampAddChatMessage("{9966cc}Medick Help {ffffff}| Файл конфига успешно создан.", -1)
      cfg = inicfg.load(nil, 'medick/config.ini')
    end
  end
  if not doesDirectoryExist('moonloader/lib/imcustom') then createDirectory('moonloader/lib/imcustom') end
  for k, v in pairs(libs) do
        if not doesFileExist('moonloader/lib/'..v) then
            downloadUrlToFile('https://raw.githubusercontent.com/WhackerH/kirya/master/lib/'..v, getWorkingDirectory()..'\\lib\\'..v)
            print('Загружается библиотека '..v)
        end
    end
	if not doesFileExist("moonloader/config/medick/keys.json") then
        local fa = io.open("moonloader/config/medick/keys.json", "w")
        fa:close()
    else
        local fa = io.open("moonloader/config/medick/keys.json", 'r')
        if fa then
            config_keys = decodeJson(fa:read('*a'))
        end
    end
  while not doesFileExist('moonloader\\lib\\rkeys.lua') or not doesFileExist('moonloader\\lib\\imcustom\\hotkey.lua') or not doesFileExist('moonloader\\lib\\imgui.lua') or not doesFileExist('moonloader\\lib\\MoonImGui.dll') or not doesFileExist('moonloader\\lib\\imgui_addons.lua') do wait(0) end
  if not doesDirectoryExist('moonloader/medick') then createDirectory('moonloader/medick') end
  hk = require 'lib.imcustom.hotkey'
  imgui.HotKey = require('imgui_addons').HotKey
  rkeys = require 'rkeys'
  imgui.ToggleButton = require('imgui_addons').ToggleButton
  while not sampIsLocalPlayerSpawned() do wait(0) end
  local _, myid = sampGetPlayerIdByCharHandle(playerPed)
  local name, surname = string.match(sampGetPlayerNickname(myid), '(.+)_(.+)')
  sip, sport = sampGetCurrentServerAddress()
  sampSendChat('/stats')
  while not sampIsDialogActive() do wait(0) end
  proverkk = sampGetDialogText()
  local frakc = proverkk:match('.+Организация%s+(.+)%s+Должность')
  local rang = proverkk:match('.+Должность%s+%d+ %((.+)%)%s+Работа')
  local telephone = proverkk:match('.+Телефон%s+(.+)%s+Законопослушность')
  rank = rang
  frac = frakc
  tel = telephone
  sampCloseCurrentDialogWithButton(1)
  print(frakc)
  print(rang)
  print(telephone)
  ystf()
  update()
  sampCreate3dTextEx(641, '{ffffff}None', 4294927974, 2346.1362,1666.7819,3040.9387, 3, true, -1, -1)
  sampCreate3dTextEx(642, '{ffffff}None', 4294927974, 2337.5002,1657.4896,3040.9524, 3, true, -1, -1)
  sampCreate3dTextEx(643, '{ffffff}None.{ff0000}угу!', 4294927974, 2337.8091,1669.0276,3040.9524, 3, true, -1, -1)
  local spawned = sampIsLocalPlayerSpawned()
  for k, v in pairs(tBindList) do
		rkeys.registerHotKey(v.v, true, onHotKey)
  end
  fastsmskey = rkeys.registerHotKey(config_keys.fastsms.v, true, fastsmsk)
  sampRegisterChatCommand('r', r)
  sampRegisterChatCommand('f', f)
  sampRegisterChatCommand('dlog', dlog)
  sampRegisterChatCommand('smslog', slog)
  sampRegisterChatCommand('rlog', rlog)
  sampRegisterChatCommand('dcol', cmd_color)
  sampRegisterChatCommand('dmb', dmb)
  sampRegisterChatCommand('smsjob', smsjob)
  sampRegisterChatCommand('where', where)
  sampRegisterChatCommand('mh', mh)
  sampRegisterChatCommand('vig', vig)
  sampRegisterChatCommand('yvig', yvig)
  sampRegisterChatCommand('ivig',ivig)
  sampRegisterChatCommand('unvig',unvig)
  sampRegisterChatCommand('giverank', giverank)
  sampRegisterChatCommand('cinv', cinv)
  sampRegisterChatCommand('ffixcar', fixcar)
  sampRegisterChatCommand('invite', invite)
  sampRegisterChatCommand('invn', invitenarko)
  sampRegisterChatCommand('blg', blg)
  sampRegisterChatCommand('oinv', oinv)
  sampRegisterChatCommand('fgv', fgiverank)
  sampRegisterChatCommand('zinv', zinv)
  sampRegisterChatCommand('ginv', ginv)
  sampRegisterChatCommand('uninvite', uninvite)
  sampRegisterChatCommand('infomoh', infomoh)
  sampRegisterChatCommand('z', zheal)
    sampRegisterChatCommand('sethud', function()
        if cfg.main.givra then
            if not changetextpos then
                changetextpos = true
                ftext('По завершению введите команду еще раз.')
            else
                changetextpos = false
				inicfg.save(cfg, 'medick/config.ini') -- сохраняем все новые значения в конфиге
            end
        else
            ftext('Для начала включите инфо-бар.')
        end
    end)
  sampRegisterChatCommand('yst', function() ystwindow.v = not ystwindow.v end)
  while true do wait(0)
     datetime = os.date("!*t",os.time()) 
if datetime.min == 00 and datetime.sec == 10 then 
sampAddChatMessage("{F80505}Не забудь оставить {0CF513}TimeCard {F80505}на форуме", -1) 
wait(1000)
end
    if #departament > 25 then table.remove(departament, 1) end
	if #smslogs > 25 then table.remove(smslogs, 1) end
	if #radio > 25 then table.remove(radio, 1) end
    if cfg == nil then
      sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Отсутсвует файл конфига, создаем.", -1)
      if inicfg.save(medick, 'medick/config.ini') then
        sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Файл конфига успешно создан.", -1)
        cfg = inicfg.load(nil, 'medick/config.ini')
      end
    end
	    local myhp = getCharHealth(PLAYER_PED)
        local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
    if wasKeyPressed(cfg.keys.fastmenu) and not sampIsDialogActive() and not sampIsChatInputActive() then
    submenus_show(fastmenu(id), "{9966cc}Medick Helper {ffffff}| Быстрое меню")
    end
	    local myhp = getCharHealth(PLAYER_PED)
        local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
    if wasKeyPressed(cfg.keys.fastmenu) and not sampIsDialogActive() and not sampIsChatInputActive() then
    submenus_show(fastmenu(id), "{9966cc}Medick Helper {ffffff}| Система повышений")
	end
          if valid and doesCharExist(ped) then
            local result, id = sampGetPlayerIdByCharHandle(ped)
            if result and wasKeyPressed(key.VK_Z) then
                gmegafhandle = ped
                gmegafid = id
                gmegaflvl = sampGetPlayerScore(id)
                gmegaffrak = getFraktionBySkin(id)
			    local color = ("%06X"):format(bit.band(sampGetPlayerColor(id), 0xFFFFFF))
                --[[ftext(gmegafid)
                ftext(gmegaflvl)
                ftext(gmegaffrak)]]
				megaftimer = os.time() + 300
                submenus_show(pkmmenu(id), "{9966cc}Medick Helper {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
            end
        end
	if cfg.main.givra == true then
      infbar.v = true
      imgui.ShowCursor = false
    end
    if cfg.main.givra == false then
      infbar.v = false
      imgui.ShowCursor = false
    end
		if changetextpos then
            sampToggleCursor(true)
            local CPX, CPY = getCursorPos()
            cfg.main.posX = CPX
            cfg.main.posY = CPY
        end
		imgui.Process = second_window.v or third_window.v or bMainWindow.v or ystwindow.v or updwindows.v or infbar.v
  end
  function rkeys.onHotKey(id, keys)
	if sampIsChatInputActive() or sampIsDialogActive() or isSampfuncsConsoleActive() then
		return false
	end
end
end

local fpt = [[
Глава №1. Общее положение
1.01 Устав является обязательным к исполнению всеми сотрудниками организации.
1.02 Устав Министерства Здравоохранения является документом, регулирующем взаимоотношения руководства Ministry Of Health с сотрудниками организации, а имущество больниц является государственной собственностью.
1.03 Незнание устава не освобождает вас от ответственности.
1.04 За нарушение устава к сотруднику организации могут применяться различные санкции, начиная от устного предупреждения и заканчивая увольнением из рядов организации Ministry of Health с занесением в черный список.
1.05 Решение главного врача является окончательным и обжалованию не подлежит.
1.06 Работа медицинского работника основывается так же на принципах милосердия, доброты.
1.07 Устав может исправляться или дополняться Главным Врачом.
1.08 Нарушить устав или приказать его нарушить в разумных целях может только Глав. Врач. а так же сотрудники по приказу вышестоящего руководства MOH.
1.09 Обладание наивысшим достижимым уровнем здоровья является одним из основных прав каждого человека без различия расы, религии, политических убеждений, экономического или социального положения.
1.10 Любой гражданин штата имеет право на получение услуг Ministry Of Health без различия расы, религии, политических
убеждений, экономического или социального положения.

Глава №2. Режим работы
2.01 Режим работы в будние дни (Понедельник — Пятница) начинается с 8:00 и заканчивается в 21:00.
2.02 Режим работы в выходные дни (Суббота — Воскресенье) начинается с 9:00 и заканчивается в 20:00.
2.03 По приказу Главного Врача, сотрудник обязан явиться на работу в течении 30 минут.
2.04 Обеденный перерыв начинается в 13:00 до 14:00 ежедневно.
2.05 Главный Врач вправе изменить график режима работы по своему усмотрению.
2.06 РП сон разрешается только во время обеденного перерыва, с 13:00 до 14:00.
2.07 Выезд в закусочные вне обеденного перерыва возможны только с разрешения руководства MOH.

Глава №3. Обязанности сотрудников
3.01 Медицинский работник обязан оказать медицинскую помощь нуждающемуся, без различия расы, религии, политических убеждений, экономического или социального положения.
3.02 Сотрудники MOH обязательно должны быть вежливыми и обращаться к людям и к коллегам, строго на 'Вы'. (за нецензурную лексику в /b также последует наказание вплоть до увольнения)
3.03 Сотрудник MOH обязан доставить пострадавшего до приемного покоя больницы, если есть такая необходимость.
3.04 Сотрудник обязан оказывать медицинскую помощь, прилагая все усилия и навыки (RP-отыгровка), Нарушение влечет за собой ( Понижение, Увольнение)
3.05 Сотрудник MOH обязан парковать личный транспорт исключительно на стоянке разрешенной департаментом города.
3.06 Отдыхать, (AFK) разрешается только в ординаторской больницы.
3.07 За сон ( AFK ) на посту более 100 секунд карается (Выговором, понижением, увольнением.)
3.07 В рабочее время, сотрудник MOH обязан находиться на назначенном ему посту и исполнять свои должностные обязанности.
3.08 По принятию вызова, медицинский сотрудник обязан делать доклад в рацию о принятии вызова от диспетчера.
3.09 Руководитель а так же Заместитель Руководителя отдела, обязан научить сотрудников своего отдела всему, что знает сам — в полной мере.
3.10 Воздушный патруль штата разрешён с должности 'Психолог'.
3.11 Наземный патруль города разрешен с должности 'Мед.Брата' от двух человек, в том случае, если все посты заняты.
3.12 Ношение и применение огнестрельного оружия разрешено с должности 'Психолог' и выше, исключение при выездов на ЧС. В случае нарушение (Выговор)
3.13 Перевод между отделами осуществляется с должности 'Нарколог' с разрешения вашего Начальника отдела.


Глава №4. Запреты сотрудника
4.01 Отказ от выхода на работу, а так же самовольное завершение рабочего дня. (Выговор)
4.02 Нахождение в казино в рабочее или не рабочее время в форме (Выговор, Понижение, Увольнение)
4.03 Входить в РП сон во время рабочего дня и вне рабочего времени в форме (Сотрудник обязан снять рабочую форму после завершения рабочего дня, для РП сна).
4.04 За неподчинение руководящему составу (Психолог и выше, в некоторых случаях Главы или Заместители отделов) карается (Понижением, Увольнением)
4.05 Введение в заблуждение руководство и их обман, а так же Глав.отделов и их заместителей, карается (увольнением с дальнейшим занесением в Черный Список MOH.)
4.06 За лечение витаминами, аскорбинками и прочим, сотрудник будет караться (Выговором, Понижением.)
4.07 Не выполнение служебных обязанностей для руководства карается (Снятием с должности)
4.08 Любой признак неуважения, попытка унизить достоинство человека карается (выговором, понижением, увольнением с дальнейшим занесением в Черный Список.)
4.09 Курение внутри здания запрещено (Выговор, Понижение)
4.10 Лечение любых болезней производится исключительно в палате, операционной или в карте скорой помощи. За нарушение данного пункта (Выговор, Понижение)
4.11 Использовать служебные автомобили и вертолёты в личных целях карается (Выговором)
4.12 Использование спец.сигналов в личных целях запрещено, карается (Выговором)
4.13 Некорректное использование волны департамента карается (Выговором, Увольнением)
4.14 Использование волны департамента сотрудникам ниже должности 'Мед.Брат' [3 ранг] карается (Выговором, Увольнением)
4.15 Сотрудникам запрещено пререкаться с начальством по рации карается (Выговором)
4.16 Выяснять отношения, оскорбления на любой волне карается (Выговором, Понижением)
4.17 Любая реклама в рации организации или департамента карается (Понижением, Увольнением)
4.18 Пользоваться рацией департамента если она закрыта на ЧС. (Выговор)
4.19 Запрещено выпрашивать повышение, карается (Выговором, Понижением)
4.20 За ношение формы не по должности, карается (Выговором, Понижением)
4.21 Запрещается ношение лишних аксессуаров, переизбыток их, карается (Выговором, Понижением)

Глава №5. Использование рации
5.01 Абсолютно все сотрудники обязаны строго соблюдать правила пользования рацией.
5.02 При вызове кареты по волне департамента, сотрудник, который выезжает на вызов, обязан сообщить по волне Минздрава о своем выезде на вызов. А руководители в данном случае обязаны сообщить по волне департамента о выезде кареты.
5.03 Сотрудник обязан сообщать в рацию доклады о заступлении на пост или патруль, о состоянии поста или патруля, об уезде с поста с указанием причины.
5.04 Сотрудник обязан находясь на посту, докладывать в рацию каждые 5 минут часа. (Пример: 12:05, 12:10 и т.д)
5.05 При запросе от старшего состава или Глав отделов и их заместителей, с просьбой сообщении статуса постов, сотрудник - обязан незамедлительно сообщить.

Глава №6. Повышения / понижения / выговоры / увольнения
6.01 Система повышения едина для всех сотрудников MOH.
6.02 Все повышения, понижения, выговоры и увольнения фиксируются в соответствующих реестрах.
6.03 Выговор является предупреждением. Два выговора — понижением в должности. Три выговора — увольнение.
6.04 В случае несогласия с решением старшего состава касательно выговора, понижения или увольнения сотрудник вправе подать жалобу Главному Врачу в соответствующем разделе.
6.05 Сотруднику может быть отказано в повышении в связи с малой активностью.

Глава №7. Правила отпуска и неактива.
7.01 Сотрудник имеет право взять отпуск с должности 'Доктор' [6 ранг]
7.02 Длительность отпуска составляет не более 14 дней раз в два месяца.
7.03 Неактив берётся сроком до 14 дней, при наличии уважительной причины.
7.04 В случае, если работник возвращается в указанный срок, его восстанавливают в должности.
7.05 В случае, если сотрудник не возвращается в указанный срок, он (Увольняется)
7.06 При служебной необходимости, сотрудник может быть вызван с отпуска.
7.07 Во время отпуска или неактива строго запрещается находится в криминальных группировках, карается (Увольнением)
7.08 Во время нахождения в отпуске или неактиве, запрещено нарушать законы Штата, ЕКГС. (Понижение, Увольнение)
]]

function dmb()
	lua_thread.create(function()
		status = true
		players2 = {'{ffffff}Дата принятия\t{ffffff}Ник\t{ffffff}Ранг\t{ffffff}Статус'}
		players1 = {'{ffffff}Ник\t{ffffff}Ранг'}
		sampSendChat('/members')
		while not gotovo do wait(0) end
		if gosmb then
			sampShowDialog(716, "{ffffff}В сети: "..gcount.." | {ae433d}Организация | {ffffff}Time: "..os.date("%H:%M:%S"), table.concat(players2, "\n"), "x", _, 5) -- Показываем информацию.
		elseif krimemb then
			sampShowDialog(716, "{ffffff}В сети: "..gcount.." | {ae433d}Организация | {ffffff}Time: "..os.date("%H:%M:%S"), table.concat(players1, "\n"), "x", _, 5) -- Показываем информацию.
		end
		gosmb = false
		krimemb = false
		gotovo = false
		status = false
		gcount = nil
	end)
end
function blg(pam)
    local id, frack, pric = pam:match('(%d+) (%a+) (.+)')
    if id and frack and pric and sampIsPlayerConnected(id) then
        name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
        sampSendChat(string.format("/d %s, благодарю %s за %s. Цените!", frack, rpname, pric))
    else
        ftext("Введите: /blg [id] [Фракция] [Причина]", -1)
		ftext("Пример: транспортировку, спасение жизни, и т.д. ", -1)
    end
end

function dmch()
	lua_thread.create(function()
		statusc = true
		players3 = {'{ffffff}Ник\t{ffffff}Ранг\t{ffffff}Статус'}
		sampSendChat('/members')
		while not gotovo do wait(0) end
		if gosmb then
			sampShowDialog(716, "{9966cc}Medick Helper {ffffff}| {ae433d}Вне офиса {ffffff}| Time: "..os.date("%H:%M:%S"), table.concat(players3, "\n"), "x", _, 5) -- Показываем информацию.
		end
		gosmb = false
		krimemb = false
		gotovo = false
		statusc = false
	end)
end

function dlog()
    sampShowDialog(97987, '{9966cc}Medick Help{ffffff} | Лог сообщений департамента', table.concat(departament, '\n'), '»', 'x', 0)
end
function slog()
    sampShowDialog(97987, '{9966cc}Medick Help{ffffff} | Лог SMS', table.concat(smslogs, '\n'), '»', 'x', 0)
end

function rlog()
    sampShowDialog(97988, '{9966cc}Medick Help{ffffff} | Лог Рации', table.concat(radio, '\n'), '»', 'x', 0)
end

function yvig(pam)
  local id, pric = string.match(pam, '(%d+)%s+(.+)')
  if rank == 'Психолог' or rank == 'Хирург' or rank == 'Зам.Глав.Врача' or rank == 'Глав.Врач' or  rank == 'Доктор' then
  if id == nil then
    sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Введите: /yvig [ID] [Причина]", -1)
  end
  if id ~=nil and not sampIsPlayerConnected(id) then
    sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Игрок с ID: "..id.." не подключен к серверу.", -1)
  end
  if id ~= nil and sampIsPlayerConnected(id) then
      if pric == nil then
        sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Введите: /yvig [ID] [ПРИЧИНА]", -1)
      end
      if pric ~= nil then
	   if cfg.main.tarb then
        name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
        sampSendChat(string.format("/r [%s]: %s - Получает устный выговор по причине: %s.", cfg.main.tarr, rpname, pric))
		else
		name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
		sampSendChat(string.format("/r %s - Получает устный выговор по причине: %s.", rpname, pric))
      end
  end
end
end
end

function vig(pam)
  local id, pric = string.match(pam, '(%d+)%s+(.+)')
  if rank == 'Психолог' or rank == 'Хирург' or rank == 'Зам.Глав.Врача' or  rank == 'Главный Врач' then
  if id == nil then
    sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Введите: /vig [ID] [Причина]", -1)
  end
  if id ~=nil and not sampIsPlayerConnected(id) then
    sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Игрок с ID: "..id.." не подключен к серверу.", -1)
  end
  if id ~= nil and sampIsPlayerConnected(id) then
      if pric == nil then
        sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Введите: /vig [ID] [ПРИЧИНА]", -1)
      end
      if pric ~= nil then
	   if cfg.main.tarb then
        name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
        sampSendChat(string.format("/r [%s]: %s - Получает выговор по причине: %s.", cfg.main.tarr, rpname, pric))
		else
		name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
		sampSendChat(string.format("/r %s - Получает выговор по причине: %s.", rpname, pric))
      end
  end
end
end
end
function ivig(pam)
  local id, pric = string.match(pam, '(%d+)%s+(.+)')
  if rank == 'Психолог' or rank == 'Хирург' or rank == 'Зам.Глав.Врача' or  rank == 'Глав.Врач' or  rank == 'Доктор' then
  if id == nil then
    sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Введите: /ivig [ID] [Причина]", -1)
  end
  if id ~=nil and not sampIsPlayerConnected(id) then
    sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Игрок с ID: "..id.." не подключен к серверу.", -1)
  end
  if id ~= nil and sampIsPlayerConnected(id) then
      if pric == nil then
        sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Введите: /ivig [ID] [ПРИЧИНА]", -1)
      end
      if pric ~= nil then
	   if cfg.main.tarb then
        name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
        sampSendChat(string.format("/r [%s]: %s - Получает строгий выговор по причине: %s.", cfg.main.tarr, rpname, pric))
		else
		name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
		sampSendChat(string.format("/r %s - Получает строгий выговор по причине: %s.", rpname, pric))
      end
  end
end
end
end

function unvig(pam)
  local id, pric = string.match(pam, '(%d+)%s+(.+)')
  if rank == 'Психолог' or rank == 'Хирург' or rank == 'Зам.Глав.Врача' or  rank == 'Глав.Врач' then
  if id == nil then
    sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Введите: /unvig [ID] [Причина]", -1)
  end
  if id ~=nil and not sampIsPlayerConnected(id) then
    sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Игрок с ID: "..id.." не подключен к серверу.", -1)
  end
  if id ~= nil and sampIsPlayerConnected(id) then
  
      if pric == nil then
        sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Введите: /unvig [ID] [ПРИЧИНА]", -1)
      end
      if pric ~= nil then
	   if cfg.main.tarb then
        name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
        sampSendChat(string.format("/r [%s]: %s - Получает cнятие выговора по причине: %s.", cfg.main.tarr, rpname, pric))
		else
		name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
		sampSendChat(string.format("/r %s - Получает cнятие выговора по причине: %s.", rpname, pric))
      end
  end
end
end
end

function where(params) -- запрос местоположения
   if rank == 'Доктор' or rank == 'Психолог' or rank == 'Хирург' or rank == 'Зам.Глав.Врача' or  rank == 'Глав.Врач' then
	if params:match("^%d+") then
		params = tonumber(params:match("^(%d+)"))
		if sampIsPlayerConnected(params) then
			local name = string.gsub(sampGetPlayerNickname(params), "_", " ")
			 if cfg.main.tarb then
			    sampSendChat(string.format("/r [%s]: %s, доложите свое местоположение. На ответ 20 секунд.", cfg.main.tarr, name))
			else
			sampSendChat(string.format("/r %s, доложите свое местоположение. На ответ 20 секунд.", name))
			end
			else
			ftext('{FFFFFF} Игрок с данным ID не подключен к серверу или указан ваш ID.', 0x046D63)
		end
		else
		ftext('{FFFFFF} Используйте: /where [ID].', 0x046D63)
		end
		else
		ftext('{FFFFFF}Данная команда доступна с 6 ранга.', 0x046D63)
	end
end

function getrang(rangg)
local ranks = 
        {
		['1'] = 'Интерн',
		['2'] = 'Санитар',
		['3'] = 'Мед.брат',
		['4'] = 'Спасатель',
		['5'] = 'Нарколог',
		['6'] = 'Доктор',
		['7'] = 'Психолог',
		['8'] = 'Хирург',
		['9'] = 'Зам.Глав.Врача',
		['10'] = 'Глав.Врач'
		}
	return ranks[rangg]
end

function giverank(pam)
    lua_thread.create(function()
    local id, rangg, plus = pam:match('(%d+) (%d+)%s+(.+)')
	if sampIsPlayerConnected(id) then
	  if rank == 'Психолог' or rank == 'Хирург' or rank == 'Зам.Глав.Врача' or  rank == 'Глав.Врач' then
        if id and rangg then
		if plus == '-' or plus == '+' then
		ranks = getrang(rangg)
		        local _, handle = sampGetCharHandleBySampPlayerId(id)
				if doesCharExist(handle) then
				local x, y, z = getCharCoordinates(handle)
				local mx, my, mz = getCharCoordinates(PLAYER_PED)
				local dist = getDistanceBetweenCoords3d(mx, my, mz, x, y, z)
				if dist <= 5 then
				if cfg.main.male == true then
				sampSendChat('/me снял старый бейджик с человека напротив стоящего')
				wait(3000)
				sampSendChat('/me убрал старый бейджик в карман')
				wait(3000)
                sampSendChat(string.format('/me достал новый бейджик %s', ranks))
				wait(3000)
				sampSendChat('/me закрепил на рубашку человеку напротив новый бейджик')
				wait(3000)
				else
				sampSendChat('/me сняла старый бейджик с человека напротив стоящего')
				wait(3000)
				sampSendChat('/me убрала старый бейджик в карман')
				wait(3000)
                sampSendChat(string.format('/me достала новый бейджик %s', ranks))
				wait(3000)
				sampSendChat('/me закрепила на рубашку человеку напротив новый бейджик')
				wait(3000)
				end
				end
				end
				sampSendChat(string.format('/giverank %s %s', id, rangg))
				wait(3000)
				if cfg.main.tarb then
                sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - %s в должности до %s%s.', cfg.main.tarr, plus == '+' and 'Повышен' or 'Понижен(а)', ranks, plus == '+' and ', Поздравляем!' or ''))
                else
				sampSendChat(string.format('/r '..sampGetPlayerNickname(id):gsub('_', ' ')..' - %s в должности до %s%s.', plus == '+' and 'Повышен' or 'Понижен', ranks, plus == '+' and ', Поздравляем!' or ''))
				wait(3000)
				sampSendChat('/b /time 1 +F8 делай.Обязательно')
            end
			else
			ftext('Вы ввели неверный тип [+/-]')
		end
		else
			ftext('Введите: /giverank [id] [ранг] [+/-]')
		end
		else
			ftext('Данная команда доступна с 7 ранга')
	  end
	  else
			ftext('Игрок с данным ID не подключен к серверу или указан ваш ID')
	  end
   end)
 end
function fgiverank(pam)
    lua_thread.create(function()
    local id, rangg, plus = pam:match('(%d+) (%d+)%s+(.+)')
	if sampIsPlayerConnected(id) then
	  if rank == 'Психолог' or rank == 'Хирург' or rank == 'Зам.Глав.Врача' or  rank == 'Глав.Врач' then
        if id and rangg then
		if plus == '-' or plus == '+' then
		ranks = getrang(rangg)
		        local _, handle = sampGetCharHandleBySampPlayerId(id)
				if doesCharExist(handle) then
				local x, y, z = getCharCoordinates(handle)
				local mx, my, mz = getCharCoordinates(PLAYER_PED)
				local dist = getDistanceBetweenCoords3d(mx, my, mz, x, y, z)
				if dist <= 5 then
				if cfg.main.male == true then
				sampSendChat('/me снял старый бейджик с человека напротив стоящего')
				wait(3000)
				sampSendChat('/me убрал старый бейджик в карман')
				wait(3000)
                sampSendChat(string.format('/me достал новый бейджик %s', ranks))
				wait(3000)
				sampSendChat('/me закрепил на рубашку человеку напротив новый бейджик')
				wait(3000)
				else
				sampSendChat('/me сняла старый бейджик с человека напротив стоящего')
				wait(3000)
				sampSendChat('/me убрала старый бейджик в карман')
				wait(3000)
                sampSendChat(string.format('/me достала новый бейджик %s', ranks))
				wait(3000)
				sampSendChat('/me закрепила на рубашку человеку напротив новый бейджик')
				wait(3000)
				end
				end
				end
			else
			ftext('Вы ввели неверный тип [+/-]')
		end
		else
			ftext('Введите: /giverank [id] [ранг] [+/-]')
		end
		else
			ftext('Данная команда доступна с 6 ранга')
	  end
	  else
			ftext('Игрок с данным ID не подключен к серверу или указан ваш ID')
	  end
   end)
 end
function invite(pam)
    lua_thread.create(function()
        local id = pam:match('(%d+)')
	  if rank == 'Зам.Глав.Врача' or  rank == 'Глав.Врач' or  rank == 'Хирург' or  rank == 'Психолог' then
        if id then
		if sampIsPlayerConnected(id) then
                sampSendChat('/me достал(а) бейджик и передал(а) его '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
				wait(3000)
				sampSendChat(string.format('/invite %s', id))
			else
			ftext('Игрок с данным ID не подключен к серверу или указан ваш ID')
		end
		else
			ftext('Введите: /invite [id]')
		end
		else
			ftext('Данная команда доступна с 7 ранга.')
	  end
   end)
 end
 function fixcar()
    lua_thread.create(function()
	  if rank == 'Зам.Глав.Врача' or  rank == 'Глав.Врач' or  rank == 'Хирург' or  rank == 'Психолог' then
        sampSendChat('/rb Спавн организационного транспорта через 15 секунд')
		wait(5000)
		sampSendChat('/rb  Спавн организационного транспорта через 10 секунд')
		wait(5000)
		sampSendChat('/rb  Спавн организационного транспорта через 5 секунд')
		wait(5000)
		sampSendChat('/rb  Спавн организационного транспорта')
		wait(1000)
		sampSendChat('/ffixcar')
	  end
   end)
 end
 function invitenarko(pam)
    lua_thread.create(function()
        local id = pam:match('(%d+)')
	  if rank == 'Зам.Глав.Врача' or  rank == 'Глав.Врач' or  rank == 'Хирург' or rank == 'Психолог' then
        if id then
		if sampIsPlayerConnected(id) then
                sampSendChat('/me достал(а) бейджик нарколога и передал(а) его '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
				wait(3000)
				sampSendChat(string.format('/invite %s', id))
				wait(6000)
				sampSendChat(string.format('/giverank %s 5', id))
				wait(2000)
				sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - Был принят на нарколога, Поздравляем', cfg.main.tarr))
			else
			ftext('Игрок с данным ID не подключен к серверу или указан ваш ID')
		end
		else
			ftext('Введите: /invn [id]')
		end
		else
			ftext('Данная команда доступна с 7 ранга.')
	  end
   end)
 end
function zheal(pam)
    lua_thread.create(function()
        local id = pam:match('(%d+)')
        if id then
		if sampIsPlayerConnected(id) then
                sampSendChat("/do Через плечо врача накинута мед. сумка на ремне.")
				wait(3000)
				sampSendChat("/me достал из мед.сумки лекарство и бутылочку воды")
				wait(3000)
				sampSendChat('/me передал лекарство и бутылочку воды '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
				wait(1100)
				sampSendChat(string.format('/heal %s', id))
			else
			ftext('Игрок с данным ID не подключен к серверу или указан ваш ID')
		end
		else
			ftext('Введите: /z [id]')
		end
   end)
end
 function ginv(pam)
    lua_thread.create(function()
        local id = pam:match('(%d+)')
		local _, handle = sampGetCharHandleBySampPlayerId(id)
	if id then
	if doesCharExist(handle) then
		local x, y, z = getCharCoordinates(handle)
		local mx, my, mz = getCharCoordinates(PLAYER_PED)
		local dist = getDistanceBetweenCoords3d(mx, my, mz, x, y, z)
	  if dist <= 5 then
	  if cfg.main.tarb then
		if sampIsPlayerConnected(id) then
                submenus_show(ginvite(id), "{9966cc}Medick Helpers {ffffff}| Выбор отдела")
				else
			ftext('Игрок с данным ID не подключен к серверу или указан ваш ID')
            end
		else
			ftext('Включите автотег в настройках')
		end
		else
			ftext('Рядом с вами нет данного человека')
	  end
	  else
			ftext('Рядом с вами нет данного человека')
	end
	  else
			ftext('Введите: /ginv [id]')
	end
	  end)
   end
   
   function cinv(pam)
    lua_thread.create(function()
        local id = pam:match('(%d+)')
		local _, handle = sampGetCharHandleBySampPlayerId(id)
	if id then
	if doesCharExist(handle) then
		local x, y, z = getCharCoordinates(handle)
		local mx, my, mz = getCharCoordinates(PLAYER_PED)
		local dist = getDistanceBetweenCoords3d(mx, my, mz, x, y, z)
	  if dist <= 5 then
	  if cfg.main.tarb then
		if sampIsPlayerConnected(id) then
                submenus_show(crpinv(id), "{9966cc}Medick Helpers {ffffff}| Выбор отдела")
				else
			ftext('Игрок с данным ID не подключен к серверу или указан ваш ID')
            end
		else
			ftext('Включите автотег в настройках')
		end
		else
			ftext('Рядом с вами нет данного человека')
	  end
	  else
			ftext('Рядом с вами нет данного человека')
	end
	  else
			ftext('Введите: /cinv [id]')
	end
	  end)
   end

 function zinv(pam)
    lua_thread.create(function()
        local id = pam:match('(%d+)')
		local _, handle = sampGetCharHandleBySampPlayerId(id)
	if id then
	if doesCharExist(handle) then
		local x, y, z = getCharCoordinates(handle)
		local mx, my, mz = getCharCoordinates(PLAYER_PED)
		local dist = getDistanceBetweenCoords3d(mx, my, mz, x, y, z)
	  if dist <= 5 then
	  if cfg.main.tarb then
		if sampIsPlayerConnected(id) then
                submenus_show(zinvite(id), "{9966cc}Medick Helpers {ffffff}| Выбор отдела")
				else
			ftext('Игрок с данным ID не подключен к серверу или указан ваш ID')
            end
		else
			ftext('Включите автотег в настройках')
		end
		else
			ftext('Рядом с вами нет данного человека')
	  end
	  else
			ftext('Рядом с вами нет данного человека')
	end
	  else
			ftext('Введите: /zinv [id]')
	end
	  end)
   end
 function oinv(pam)
    lua_thread.create(function()
        local id = pam:match('(%d+)')
		local _, handle = sampGetCharHandleBySampPlayerId(id)
	if id then
	if doesCharExist(handle) then
		local x, y, z = getCharCoordinates(handle)
		local mx, my, mz = getCharCoordinates(PLAYER_PED)
		local dist = getDistanceBetweenCoords3d(mx, my, mz, x, y, z)
	  if dist <= 5 then
	  if cfg.main.tarb then
		if sampIsPlayerConnected(id) then
                submenus_show(oinvite(id), "{9966cc}Medick Helpers {ffffff}| Выбор отдела")
				else
			ftext('Игрок с данным ID не подключен к серверу или указан ваш ID')
            end
		else
			ftext('Включите автотег в настройках')
		end
		else
			ftext('Рядом с вами нет данного человека')
	  end
	  else
			ftext('Рядом с вами нет данного человека')
	end
	  else
			ftext('Введите: /oinv [id]')
	end
	  end)
   end

 function uninvite(pam)
    lua_thread.create(function()
        local id, pri4ina = pam:match('(%d+)%s+(.+)')
	  if rank == 'Хирург' or rank == 'Зам.Глав.Врача' or  rank == 'Глав.Врач' then
        if id and pri4ina then
		if sampIsPlayerConnected(id) then
                sampSendChat('/me забрал(а) форму и бейджик у '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
				wait(3000)
				sampSendChat(string.format('/uninvite %s %s', id, pri4ina))
			else
			ftext('Игрок с данным ID не подключен к серверу или указан ваш ID')
		end
		else
			ftext('Введите: /uninvite [id] [причина]')
		end
		else
			ftext('Данная команда доступна с 8 ранга')
	  end
   end)
 end
 function zinvite(id)
 return
{
  {
   title = "{80a4bf}» {FFFFFF}Отдел SES",
    onclick = function()
	sampSendChat('/me достал(а) бейджик Заместителя Главы Санитарно-Эпидемиологической-Станции и передал(а) его '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(5000)
	sampSendChat('/b /clist 12')
	wait(5000)
	sampSendChat('/b тег в /r [Зам.Главы.SES]')
	wait(5000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - новый Заместитель Санитарно-Эпидемиологической-Станции.', cfg.main.tarr))
	end
   },
   
   {
   title = "{80a4bf}» {FFFFFF}Отдел ПСБ",
    onclick = function()
	sampSendChat('/me достал(а) бейджик Заместителя Главы Поисково-Спасательной Бригады и передал(а) его '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(4000)
	sampSendChat('/b /clist 29 ')
	wait(4000)
	sampSendChat('/b тег в /r [Зам.Главы ПСБ]')
	wait(4000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - новый Заместитель Поисково-Спасательной Бригады.', cfg.main.tarr))
	end
   },
 }
end
function crpinv(id)
 return
{
  {
   title = "{80a4bf}» {FFFFFF}Начальник",
    onclick = function()
	sampSendChat('/me достал(а) бейджик Начальника Control Room и передал(а) его '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(7000)
	sampSendChat('/b /clist 15')
	wait(7000)
	sampSendChat('/b тег в /r [Chief CR]')
	wait(7000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - новый Начальник Control Room.', cfg.main.tarr))
	end
   },
   
   {
   title = "{80a4bf}» {FFFFFF}Ст.Диспетчер",
    onclick = function()
	sampSendChat('/me достал(а) бейджик Старшего Диспетчера Control Room и передал(а) его '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(7000)
	sampSendChat('/b /clist 10')
	wait(7000)
	sampSendChat('/b тег в /r [Senior Dispatcher]')
	wait(7000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - новый Ст.Диспетчер Control Room.', cfg.main.tarr))
	end
   },
   {
   title = "{80a4bf}» {FFFFFF}Диспетчер",
    onclick = function()
	sampSendChat('/me достал(а) бейджик Диспетчера Control Room и передал(а) его '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(7000)
	sampSendChat('/b /clist 11')
	wait(7000)
	sampSendChat('/b тег в /r [Dispatcher CR]')
	wait(7000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - новый Диспетчер Control Room.', cfg.main.tarr))
	end
   },
   {
   title = "{80a4bf}» {FFFFFF}Сотрудник",
    onclick = function()
	sampSendChat('/me достал(а) бейджик Сотрудника Control Room и передал(а) его '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(7000)
	sampSendChat('/b /clist 16')
	wait(7000)
	sampSendChat('/b тег в /r [Employee CR]')
	wait(7000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - новый Сотрудник Control Room.', cfg.main.tarr))
	end
   },
 }
end
function oinvite(id)
 return
{
  {
   title = "{80a4bf}» {FFFFFF}Отдел SES [Инспектор SES]",
    onclick = function()
	sampSendChat('/me достал(а) бейджик Инспектора Санитарно-Эпидемиологичесой-Станции и передал его '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(5000)
	sampSendChat('/b /clist 10')
	wait(5000)
	sampSendChat('/b тег в /r [SES]')
	wait(5000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - повышается в долности на Инспектора Санитарно-Эпидемиологичесой-Станции.', cfg.main.tarr))
	end
   },
  {
   title = "{80a4bf}» {FFFFFF}Отдел SES",
    onclick = function()
	sampSendChat('/me достал(а) бейджик Стажера Санитарно-Эпидемиологичесой-Станции и передал его '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(5000)
	sampSendChat('/b /clist 19')
	wait(5000)
	sampSendChat('/b тег в /r [Cтажер SES]')
	wait(5000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - новый  сотрудник  Санитарно-Эпидемиологичесой-Станции.', cfg.main.tarr))
	end
   },

   -- {
   -- title = "{80a4bf}» {FFFFFF}Отдел УТУ",
    -- onclick = function()
	-- sampSendChat('/me достал(а) бейджик Сотрудника(цы) Учебно-Тренингово отделения и передал его '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	-- wait(5000)
	-- sampSendChat('/b /clist 15')
	-- wait(5000)
	-- sampSendChat('/b тег в /r [УТУ]')
	-- wait(5000)
	-- sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - новый  Сотрудник Отдела MA.', cfg.main.tarr))
	-- end
   -- },
   {
   title = "{80a4bf}» {FFFFFF}Отдел ПСБ",
    onclick = function()
	sampSendChat('/me достал(а) бейджик Стажера Поисково-Спасательной Бригады и передал его '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(5000)
	sampSendChat('/b /clist 2')
	wait(5000)
	sampSendChat('/b тег в /r [Cтажер ПСБ]')
	wait(5000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - новый  сотрудник  Поисково-Спасательной Бригады.', cfg.main.tarr))
	end
   },
 }
end
function ginvite(id)
 return
{
  {
   title = "{80a4bf}» {FFFFFF}Отдел ПСБ Глава.",
    onclick = function()
	if rank == 'Зам.Глав.Врача' or  rank == 'Главный Врач' or  rank == 'Хирург' then
	sampSendChat('/me достал(а) бейджик Главы  Поисково-Спасательной Бригады и передал(а) его '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(5000)
	sampSendChat('/b /clist 21')
	wait(5000)
	sampSendChat('/b тег в /r [Глава ПСБ]')
	wait(5000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - новый Глава Поисково-Спасательной Бригады ', cfg.main.tarr))
	else
	ftext('Вы не можете назначить Главу данного отдела.')
	end
	end
   },
   {
   title = "{80a4bf}» {FFFFFF}Отдел SES Глава.",
    onclick = function()
	if rank == 'Зам.Глав.Врача' or  rank == 'Главный Врач' or  rank == 'Хирург' then
	sampSendChat('/me достал(а) бейджик Главы  Санитарно-Эпидемиологической-Станции и передал(а) его '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(5000)
	sampSendChat('/b /clist 8')
	wait(5000)
	sampSendChat('/b тег в /r [Глава SES]')
	wait(5000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - новый Глава Санитарно-Эпидемиологической-Станции ', cfg.main.tarr))
	else
	ftext('Вы не можете назначить Главу данного отдела.')
	end
	end
   },
 }
end
function fastmenu(id)
 return
{
  {
   title = "{80a4bf}»{FFFFFF} Меню {ffffff}лекций",
    onclick = function()
	submenus_show(fthmenu(id), "{9966cc}Medick Helper {0033cc}| Меню лекций")
	end
   },
   {
   title = "{80a4bf}»{FFFFFF} Cобеседование",
    onclick = function()
	submenus_show(sobesedmenu(id), "{9966cc}Medick Helper {0033cc}| Меню Собеседования")
	end
   },
   -- {
   -- title = "{80a4bf}»{FFFFFF} Основное меню",
    -- onclick = function()
	-- submenus_show(osmrmenu(id), "{9966cc}Medick Helper {0033cc}| Основное меню")
	-- end
   -- },
   -- {
   -- title = "{80a4bf}»{FFFFFF} Дополнительно",
    -- onclick = function()
	-- submenus_show(osmrmenu1(id), "{9966cc}Medick Helper {0033cc}| Мед.осмотр")
	-- end
   -- },
   {
	title = '{80a4bf}»{FFFFFF} Меню {ffffff}Меню агитации {ff0000}(Ст.Состав)',
    onclick = function()
	  if rank == 'Зам.Глав.Врача' or  rank == 'Глав.Врач' or  rank == 'Хирург' or  rank == 'Психолог' then
	submenus_show(agitmenu(id), '{9966cc} Medick Helper {0033cc}| Меню агитации')
	else
	ftext('Вы не находитесь в Ст.Составе')
	end
	end
   },
    {
   title = "{80a4bf}»{FFFFFF} Меню {ffffff}гос.новостей {ff0000}(Ст.Состав)",
    onclick = function()
	if rank == 'Психолог' or rank == 'Хирург' or rank == 'Зам.Глав.Врача' or rank == 'Глав.Врач' then
	submenus_show(govmenu(id), "{9966cc}Medick Helper {0033cc}| Меню гос.новостей")
	else
	ftext('Вы не находитесь в Ст.Составе')
	end
	end
   },
   {
   title = "{80a4bf}»{FFFFFF} Меню {ffffff}отделов",
    onclick = function()
	if rank == 'Психолог' or rank == 'Хирург' or rank == 'Зам.Глав.Врача' or rank == 'Глав.Врач' or rank == 'Доктор' or rank == 'Нарколог' then
	submenus_show(otmenu(id), "{9966cc}Medick Helper {0033cc}| Меню отделов")
	else
	ftext('Ваш ранг недостаточно высок')
	end
	end
   },
   {
   title = "{80a4bf}»{FFFFFF} Вызвать сотрудника полиции в Больницу {ffffff}в /d {ff0000}(3+ ранги)",
    onclick = function()
	if rank == 'Мед.брат' or rank =='Спасатель' or rank =='Нарколог' or rank == 'Доктор' or rank == 'Психолог' or rank == 'Хирург' or rank == 'Зам.Глав.Врача' or rank == 'Глав.Врач' then
	sampSendChat(string.format('/d LSPD, Вышлите сотрудника в Больницу. Благодарю!'))
	else
	ftext('Ваш ранг недостаточно высок')
	end
	end
   },
}
end

function otmenu(id)
 return
{
  {
   title = "{80a4bf}»{FFFFFF} Пиар отдела в рацию {ff00ff}СЭС{ff0000}(Для глав/замов отдела)",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	sampSendChat(string.format('/r [%s]: Уважаемые сотрудники, минуточку внимания.', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: В Санитарно-Эпидемиологическую-Станцию производится пополнение сотрудников.', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: Вступить в отдел можно с должности "Мед.Брат".', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: Для подробной информации пишите на п.'..myid..'.', cfg.main.tarr))
	wait(5000)
    sampSendChat(string.format('/rb [%s]: От вас требуется хорошее отыгрывание РП ситуаций', cfg.main.tarr))
	end
   },
   {
   title = "{80a4bf}»{FFFFFF} Пиар отдела в рацию {0000ff}УТУ{ff0000}(Для глав/замов отдела)",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	sampSendChat(string.format('/r [%s]: Уважаемые сотрудники, минуточку внимания.', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: В Учебно-Тренинговое отделение производится пополнение сотрудников.', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: Вступить в отдел можно с должности "Нарколог".', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: Для подробной информации пишите на п.'..myid..'.', cfg.main.tarr))
	end
   },
   -- {
   -- title = "{80a4bf}»{FFFFFF} Пиар отдела в рацию {0000ff}CR{ff0000}(Для глав/замов отдела)",
    -- onclick = function()
	-- local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	-- sampSendChat(string.format('/r [%s]: Уважаемые сотрудники, минуточку внимания.', cfg.main.tarr))
    -- wait(5000)
    -- sampSendChat(string.format('/r [%s]: В Control Room производится пополнение сотрудников.', cfg.main.tarr))
    -- wait(5000)
    -- sampSendChat(string.format('/r [%s]: Вступить в отдел можно с должности "Мед.Брат".', cfg.main.tarr))
    -- wait(5000)
    -- sampSendChat(string.format('/r [%s]: Для подробной информации пишите на п.'..myid..'.', cfg.main.tarr))
	-- end
   -- },
}
end

function sobesedmenu(id)
    return
    {
      {
        title = '{5b83c2}« Раздел собеседование »',
        onclick = function()
        end
      },
      {
        title = '{80a4bf}» {ffffff}Приветствие.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myname = sampGetPlayerNickname(myid)
        sampSendChat('Здравствуйте. Я сотрудник больницы '..myname:gsub('_', ' ')..', вы на собеседование?')
		wait(4000)
		sampSendChat('/do На рубашке бейджик с надписью '..rank..' | '..myname:gsub('_', ' ')..'.')
		end
      },
      {
        title = '{80a4bf}» {ffffff}Документы.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat('Ваш паспорт и диплом,пожалуйста.')
		wait(3000)
		sampSendChat('/b /showpass '..myid..'')
		wait(3000)
		sampSendChat('/b Диплом по РП.')
        end
      },
	  {
        title = '{80a4bf}» {ffffff}Заявка на офф.портал на Нарколога{ff0000} ЕСЛИ 6 лет в штате.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat('Вы можете оставить заявление на офф.портале, на должность Нарколог, а можете сейчас на интерна.')
		wait(5000)
		sampSendChat('/b evolve-rp.su -> 03 server -> гос. службы -> министерство здравохранения -> Заявление на должность нарколога.')
		wait(3000)
		sampSendChat('Оставите заявление или сейчас на интерна?')
        end
      },
	  {
        title = '{80a4bf}» {ffffff} Изучение документов.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
		sampSendChat('/me взял документы у человека напротив, после начал их изучать')
		wait(4000)
        sampSendChat('/me ознакомивщись с документами, вернул их обратно ')
        end
      },
	  {
        title = '{80a4bf}» {ffffff}Расскажите немного о себе.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
		sampSendChat('Хорошо, расскажите немного о себе.')
		wait(4000)
        end
      },
	  {
        title = '{80a4bf}» {ffffff}Карьера.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat('Как бы вы хотели, чтобы развивалась ваша карьера?.')
        end
      },
	  {
	     title = '{80a4bf}» {ffffff}Опыт в данной сфере.',
        onclick = function()
        sampSendChat('Имели раньше опыт в данной сфере?')
		wait(4000)
        end
      },
	  {
	   title = '{80a4bf}» {ffffff}Проблемы с законом.',
	   onclick = function()
	   sampSendChat('Имели раньше проблемы с законом?')
	   wait(4000)
	   end
      },
	  {
        title = '{80a4bf}» {ffffff}Cтресс на работе.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat('Как вы справляетесь со стрессом на работе?')
        end
      },
	  {
        title = '{80a4bf}» {ffffff}Прошлая работа.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat('Что вас не устраивало в прошлой работе?')
        end
      },
	  {
        title = '{80a4bf}» {ffffff}Зарплата.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat('На какую зарплату вы расчитываете?')
        end
      },
	  {
        title = '{80a4bf}» {ffffff}РП термины.',
        onclick = function()
        sampSendChat('Что по вашему означает таково понятие как РП и ДМ?')
		wait(4000)
        end
      },
	  {
        title = '{80a4bf}» {ffffff}Что над головой.',
        onclick = function()
        sampSendChat('Что у меня над головой?')
		wait(4000)
        end
      },
	  {
        title = '{80a4bf}» {ffffff}Приказы руководства.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat('Как вы переносите приказы руководства?')
        end
      },
	  {
        title = '{80a4bf}» {ffffff}РП термины в /b.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat('/b РП и ПГ в /sms '..myid..'')
		wait(4000)
        end
      },
	  {
        title = '{80a4bf}» {ffffff}Вы приняты.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat('Поздравляю, вы нам подходите.')
        end
      },
	  {
        title = '{80a4bf}» {ffffff}Вы не приняты.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat('Прошу прощения, но вы нам не подходите.')
        end
	  },
    }
end

function govmenu(id)
return
{
   {
   title = "{80a4bf}»{FFFFFF} Собеседование:",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	local myname = sampGetPlayerNickname(myid)
	sampSendChat("/d OG,вещаю")
		wait(1300)
		sampSendChat("/gov [MOH]: Давно хотели получать большую зарплату и спасать жизни людей? ")
        wait(cfg.commands.zaderjka * 750)
        sampSendChat('/gov [MOH]: Тогда тебе к нам! Прямо сейчас проходит собеседование в Мин.Здравоохранение.')
        wait(cfg.commands.zaderjka * 750)
		sampSendChat('/gov [MOH]: Вас ожидает: Дружный коллектив, карьерный рост, большая зарплата и премии каждый день. ')
		wait(cfg.commands.zaderjka * 750)
        sampSendChat('/gov [MOH]: Всех кандидатов будем ждать на первом этаже Больницы г.Los Santos  ')
		wait(cfg.commands.zaderjka * 750)
		sampSendChat('/gov [MOH]: С Уважением, '..rank..' Больницы г. Los-Santos - '..myname:gsub('_', ' ')..'.')
		wait(2000)
        sampSendChat("/d OG,освободил гос.волну.")
		wait(1000)
		sampAddChatMessage("{F80505}Не забудь {F80505}добавить {0CF513} /addvacancy!", -1)
		if cfg.main.hud then
        sampSendChat("/time 1")
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
	end
	},
    {
	title = "{80a4bf}»{FFFFFF} Конец собеседования:",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	local myname = sampGetPlayerNickname(myid)
	sampSendChat("/d OG,вещаю")
        wait(1300)
		sampSendChat("/me достал КПК, после чего подключился к гос. волне новостей")
		wait(cfg.commands.zaderjka * 1300)
        sampSendChat("/gov [MOH]: Уважаемые жители и гости штата, минуточку внимания! ")
        wait(cfg.commands.zaderjka * 1300)
        sampSendChat('/gov [MOH]: Собеседование в Министерство Здравоохранения окончено.')
        wait(cfg.commands.zaderjka * 1300)
		sampSendChat('/gov [MOH]: Сообщаю, что на оф.портале министерства здравоохранения открыты заявление на должность "Нарколог" ')
		wait(cfg.commands.zaderjka * 1300)
        sampSendChat('/gov [MOH]:С Уважением, '..rank..' Больницы города Los-Santos - '..myname:gsub('_', ' ')..'. ')
		wait(1300)
        sampSendChat("/d OG,освободил гос.волну.")
		wait(1200)
		if cfg.main.hud then
        sampSendChat("/time 1")
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
	end	
	},
    {
	title = '{80a4bf}»{FFFFFF} Заявка на Нарколога и Мед.Брата:',
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	local myname = sampGetPlayerNickname(myid)
	sampSendChat('/d OG,вещаю')
        wait(cfg.commands.zaderjka * 750)
		sampSendChat('/me достал КПК, после чего подключился к гос. волне новостей')
		wait(cfg.commands.zaderjka * 750)
        sampSendChat('/gov [MOH]: Давно хотели спасать людей и проводить сеансы от наркозависимости ? ')
        wait(cfg.commands.zaderjka * 750)
		sampSendChat('/gov [MOH]: Тогда тебе к нам, на оф.сайте Минздрава открыты заявки на д."Нарколог" и "Мед.Брат" ')
		wait(cfg.commands.zaderjka * 750)
        sampSendChat('/gov [MOH]: Вас ожидает: дружный коллектив, карьерный рост, высокая зарплата и премии каждый день ')
		wait(cfg.commands.zaderjka * 750)
        sampSendChat('/gov [MOH]: По окончанию стажировки сотрудник получает премию до 300.000$ .')
		wait(cfg.commands.zaderjka * 750)
		sampSendChat('/gov [MOH]: С Уважением, '..rank..' Больницы города Los-Santos - '..myname:gsub('_', ' ')..'. ')
		wait(cfg.commands.zaderjka * 750)
        sampSendChat('/d OG,освободил гос.волну.')
		wait(1200)
		end
	},
	{
	title = "{80a4bf}»{FFFFFF} Акция жизнь без наркотиков:",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	local myname = sampGetPlayerNickname(myid)
	sampSendChat("/d OG,вещаю")
        wait(cfg.commands.zaderjka * 1300)
		sampSendChat("/me достал КПК, после чего подключился к гос. волне новостей")
		wait(cfg.commands.zaderjka * 1300)
        sampSendChat("/gov [MOH] Уважажемые жители и гости Штата, минуточку внимание!")
        wait(cfg.commands.zaderjka * 1300)
		sampSendChat('/gov [MOH] Сегодня в больнице г.Los-Santos проходит акция "Жизнь без наркотиков"')
		wait(cfg.commands.zaderjka * 1300)
        sampSendChat('/gov [MOH] Каждый кто имеет с этим проблемы может пройти Сеанс от наркозависимости совершено бесплатно')
		wait(cfg.commands.zaderjka * 1300)
        sampSendChat('/gov [MOH] Это ваш шанс изменить жизнь к лучшему!')
		wait(cfg.commands.zaderjka * 1300)
		sampSendChat('/gov [MOH]:С Уважением, '..rank..' Больницы города Los-Santos - '..myname:gsub('_', ' ')..'. ')
		wait(cfg.commands.zaderjka * 1300)
        sampSendChat("/d OG,освободил гос.волну.")
		wait(1200)
		if cfg.main.hud then
        sampSendChat("/time 1")
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
	end
	},	
	{
	title = "{80a4bf}»{FFFFFF} Лечение бесплатно (до 6 уровня):",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	local myname = sampGetPlayerNickname(myid)
	sampSendChat("/d OG,вещаю")
		wait(1300)
		sampSendChat("/gov [MOH]: Здравствуйте, увжаемые жители нашего штата!")
        wait(cfg.commands.zaderjka * 750)
        sampSendChat('/gov [MOH]: Хотим напомнить вам, что по Постановлению №134 от 28.09.2021...')
        wait(cfg.commands.zaderjka * 750)
		sampSendChat('/gov [MOH]: ... о "Предоставлении бесплатных мед.услуг для новоприезжих"')
		wait(cfg.commands.zaderjka * 750)
		sampSendChat('/gov [MOH]: Гражданам проживающие в нашем Штате меньше 6-и лет лечение предоставляется бесплатным!')
		wait(cfg.commands.zaderjka * 750)
		sampSendChat('/gov [MOH]: С Уважением, '..rank..' Больницы г. Los-Santos - '..myname:gsub('_', ' ')..'.')
		wait(2000)
        sampSendChat("/d OG,освободил гос.волну.")
		wait(1000)
		if cfg.main.hud then
        sampSendChat("/time 1")
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
	end
	}	
}	
end	
   -- title = "{80a4bf}»{FFFFFF} COVID 19:",
    -- onclick = function()
	-- local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	-- local myname = sampGetPlayerNickname(myid)
	-- sampSendChat("/d OG,вещаю")
        -- wait(cfg.commands.zaderjka * 1300)
		-- sampSendChat("/me достал КПК, после чего подключился к гос. волне новостей")
		-- wait(cfg.commands.zaderjka * 1300)
        -- sampSendChat("/gov [МОН] Уважаемые жители штата, минуточку внимание!")
        -- wait(cfg.commands.zaderjka * 1300)
		-- sampSendChat('/gov [МОН] В данный момент, поступила информация про вирус!')
		-- wait(cfg.commands.zaderjka * 1300)
        -- sampSendChat('/gov [МОН] Будьте осторожны, носите маски и держите дистанцию,так же не забывайте мыть руки с мылом.')
		-- wait(cfg.commands.zaderjka * 1300)
        -- sampSendChat('/gov [МОН] Про вирус вы сможете узнать, на офф.портале штата!')
		-- wait(cfg.commands.zaderjka * 1300)
		-- sampSendChat('/gov [MOH]:С Уважением, '..rank..' Больницы города Los-Santos - '..myname:gsub('_', ' ')..'. ')
		-- wait(cfg.commands.zaderjka * 1300)
		-- sampSendChat('/gov [МОН] Будьте здоровы, Не болейте!')
		-- wait(cfg.commands.zaderjka * 1300)
        -- sampSendChat("/d OG,освободил гос.волну.")
		-- wait(1200)
		-- if cfg.main.hud then
        -- sampSendChat("/time")
        -- wait(500)
        -- setVirtualKeyDown(key.VK_F8, true)
        -- wait(150)
        -- setVirtualKeyDown(key.VK_F8, false)
		-- end
	-- end
   -- },
    -- {
   -- title = "{80a4bf}»{FFFFFF} Система {fb05d6}рефералов:",
    -- onclick = function()
	-- local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	-- local myname = sampGetPlayerNickname(myid)
	-- sampSendChat("/d OG,вещаю")
        -- wait(cfg.commands.zaderjka * 1300)
		-- sampSendChat("/me достал КПК, после чего подключился к гос. волне новостей")
		-- wait(cfg.commands.zaderjka * 1300)
        -- sampSendChat("/gov [МОН] Уважаемые жители штата, минуточку внимание!")
        -- wait(cfg.commands.zaderjka * 1300)
		-- sampSendChat('/gov [MOH] В центральной больнице города Los-Santos`a действует реферальная система.')
		-- wait(cfg.commands.zaderjka * 1300)
        -- sampSendChat('/gov [MOH]: С данной системой вы можете ознакомиться на оф.портале больницы.')
		-- wait(cfg.commands.zaderjka * 1300)
		-- sampSendChat('/gov [MOH]:С Уважением, '..rank..' Больницы города Los-Santos - '..myname:gsub('_', ' ')..'. ')
		-- wait(cfg.commands.zaderjka * 1300)
		-- sampSendChat('/gov [МОН] Будьте здоровы, Не болейте!')
		-- wait(cfg.commands.zaderjka * 1300)
        -- sampSendChat("/d OG,освободил гос.волну.")
		-- wait(1200)
		-- if cfg.main.hud then
        -- sampSendChat("/time")
        -- wait(500)
        -- setVirtualKeyDown(key.VK_F8, true)
        -- wait(150)
        -- setVirtualKeyDown(key.VK_F8, false)
		-- end
	-- end
   -- },
-- end
function fastsmsk()
	if lastnumber ~= nil then
		sampSetChatInputEnabled(true)
		sampSetChatInputText("/t "..lastnumber.." ")
	else
		ftext("Вы ранее не получали входящих сообщений.", 0x046D63)
	end
end

function osmrmenu(id)
 return
{
  {
    title = "{80a4bf}»{FFFFFF} Лечение пациента",
    onclick = function()
	    sampSendChat("/do Через плечо врача накинута мед. сумка на ремне.")
        wait(3000)
        sampSendChat("/me достал из мед.сумки лекарство и бутылочку воды")
        wait(3000)
        sampSendChat("/me передал лекарство и бутылочку воды пациенту")
        wait(3000)
        sampSendChat("/heal")
    end
  },
  {
    title = "{80a4bf}»{FFFFFF} Сеанс",
    onclick = function()
	    sampSendChat("/do Через плечо врача накинута мед.сумка на ремне.")
        wait(4000)
        sampSendChat("/me достал из мед.сумки вату, спирт, шприц и препарат")
        wait(4000)
		sampSendChat("/me пропитал вату спиртом")
		wait(4000)
		sampSendChat("/do Пропитанная спиртом вата в левой руке.")
		wait(4000)
		sampSendChat("/me обработал ватой место укола на вене пациента")
		wait(4000)
		sampSendChat("/do Шприц и препарат в правой руке.")
                wait(4000)
		sampSendChat("/me аккуратным движением вводит препарат в вену пациента")
                wait(4000)
		sampSendChat("/todo Ну вот и всё*вытащив шприц из вены и приложив вату к месту укола.")
                wait(4000)
		sampSendChat("/healaddict")





    end
  },
  {
    title = "{80a4bf}»{FFFFFF} Справка 1",
    onclick = function()
	    sampSendChat("/do На столе стоит ящик с мед.картами и неврологическим молоточком.")
        wait(5000)
        sampSendChat(" Имеете ли Вы жалобы на здоровье?")
        wait(5000)
        sampSendChat("/do В левой руке чёрная ручка.")
        wait(5000)
        sampSendChat("/me сделал запись в мед.карте")
        wait(5000)
        sampSendChat("/me достал из ящика неврологический молоточек")
        wait(5000)
        sampSendChat("Присаживайтесь, начнем обследование.")
        wait(5000)
        sampSendChat("/me достал из ящика неврологический молоточек")
        wait(5000)
        sampSendChat("/me водит молоточком перед глазами пациента")
        wait(5000)
        sampSendChat("/me убедился, что зрачки движутся содружественно и рефлекс в норме")
        wait(5000)
        sampSendChat("/me сделал запись в мед.карте")
        wait(5000)
        sampSendChat("/me ударил молоточком по левому колену пациента")
        wait(5000)
        sampSendChat("/me ударил молоточком по правому колену пациента")
        wait(5000)
		sampSendChat("/checkheal")
    end
  },
  {
    title = "{80a4bf}»{FFFFFF} Справка 2",
    onclick = function()
	    sampSendChat(" Здесь тоже все впорядке. Теперь проверим Вашу кровь.")
        wait(5000)
        sampSendChat("/do На полу стоит мини-лаборатория.")
        wait(5000)
        sampSendChat("/do Через плечо врача накинута мед.сумка на ремне.")
        wait(5000)
        sampSendChat("/me пропитал вату спиртом")
        wait(5000)
        sampSendChat("/do Пропитанная спиртом вата в левой руке.")
        wait(5000)
        sampSendChat("/me обработал ватой место укола на вене пациента")
        wait(5000)
        sampSendChat("/do Шприц и специальная колбочка в правой руке.")
        wait(5000)
        sampSendChat("/me аккуратным движением вводит шприц в вену пациента")
        wait(5000)
        sampSendChat("/me перелил кровь из шприца в специальную колбу, затем поместил её в мини-лабораторию")
        wait(5000)
        sampSendChat("/checkheal")
    end
  },  
  {
    title = "{80a4bf}»{FFFFFF} Лечение пациента",
    onclick = function()
		sampSendChat(" Здравствуйте, что Вас беспокоит?")
		wait(5000)
		sampSendChat("/do Через плечо врача накинута мед. сумка на ремне.")
		wait(5000)
		sampSendChat("/me достал из мед.сумки лекарство и бутылочку воды")
		wait(5000)
		sampSendChat("/me передал лекарство и бутылочку воды пациенту")
		wait(5000)
		sampSendChat("/heal")
    end
  },
}
end

function osmrmenu2(id)
 return
{
  {
    title = "{80a4bf}»{FFFFFF} Сеанс.",
    onclick = function()
	    sampSendChat("/do Через плечо врача накинута мед.сумка на ремне.")
        wait(5000)
		sampSendChat("/me достал из мед.сумки вату, спирт, шприц и препарат")
		wait(5000)
		sampSendChat("/me пропитал вату спиртом")
		wait(5000)
		sampSendChat("/do Пропитанная спиртом вата в левой руке.")
		wait(5000)
		sampSendChat("/me обработал ватой место укола на вене пациента")
		wait(5000)
		sampSendChat("/do Шприц и препарат в правой руке.")
		wait(5000)
		sampSendChat("/me набрал в шприц препарат")
		wait(5000)
		sampSendChat("/me аккуратным движением вводит препарат в вену пациента")
		wait(5000)
		sampSendChat("/healaddict")
    end
  },
}
end

function osmrmenu(id)
 return
{
  {
    title = "{80a4bf}»{FFFFFF} Лечение пациента",
    onclick = function()
	    sampSendChat("/do Через плечо врача накинута мед. сумка на ремне.")
            wait(3000)
            sampSendChat("/me достал из мед.сумки лекарство и бутылочку воды")
            wait(3000)
           sampSendChat("/me передал лекарство и бутылочку воды пациенту")
           wait(3000)
           sampSendChat("/heal") 
    end
  },
  {
    title = "{80a4bf}»{FFFFFF} Справка 1",
    onclick = function()
	     sampSendChat("/do На столе стоит ящик с мед.картами и неврологическим молоточком.")
        wait(5000)
        sampSendChat(" Имеете ли Вы жалобы на здоровье?")
        wait(5000)
        sampSendChat("/do В левой руке чёрная ручка.")
        wait(5000)
        sampSendChat("/me сделал запись в мед.карте")
        wait(5000)
        sampSendChat("/me достал из ящика неврологический молоточек")
        wait(5000)
        sampSendChat("Присаживайтесь, начнем обследование.")
        wait(5000)
        sampSendChat("/me достал из ящика неврологический молоточек")
        wait(5000)
        sampSendChat("/me водит молоточком перед глазами пациента")
        wait(5000)
        sampSendChat("/me убедился, что зрачки движутся содружественно и рефлекс в норме")
        wait(5000)
        sampSendChat("/me сделал запись в мед.карте")
        wait(5000)
        sampSendChat("/me ударил молоточком по левому колену пациента")
        wait(5000)
        sampSendChat("/me ударил молоточком по правому колену пациента")
        wait(5000)
		sampSendChat("/checkheal")
    end
  },
  {
    title = "{80a4bf}»{FFFFFF} Справка 2",
    onclick = function()
	    sampSendChat(" Здесь тоже все впорядке. Теперь проверим Вашу кровь.")
        wait(5000)
        sampSendChat("/do На полу стоит мини-лаборатория.")
        wait(5000)
        sampSendChat("/do Через плечо врача накинута мед.сумка на ремне.")
        wait(5000)
        sampSendChat("/me пропитал вату спиртом")
        wait(5000)
        sampSendChat("/do Пропитанная спиртом вата в левой руке.")
        wait(5000)
        sampSendChat("/me обработал ватой место укола на вене пациента")
        wait(5000)
        sampSendChat("/do Шприц и специальная колбочка в правой руке.")
        wait(5000)
        sampSendChat("/me аккуратным движением вводит шприц в вену пациента")
        wait(5000)
        sampSendChat("/me перелил кровь из шприца в специальную колбу, затем поместил её в мини-лабораторию")
        wait(5000)
        sampSendChat("/checkheal")
    end
  },
  {
    title = "{80a4bf}»{FFFFFF} Заполнение справки",
    onclick = function()
	    sampSendChat("/do Шкафчик открыт.")
        wait(5000)
        sampSendChat("/do В шкафчике стоят бланки справок.")
        wait(5000)
        sampSendChat("/me достал из шкафчика бланк справки")
        wait(5000)
        sampSendChat("/me выписал справку о том, что пациент не имеет наркозависимости и годен к службе")
        wait(5000)
        sampSendChat("/me передал справку пациенту в руки")
        wait(5000)
        sampSendChat("/do Протянута правая рука со справкой.")
        wait(5000)
		sampSendChat("/checkheal")
    end
  },  
  {
    title = "{80a4bf}»{FFFFFF} Делаем сеанс,если он зависим",
    onclick = function()
		sampSendChat("/do На экране показан положительный результат теста крови пациента.")
		wait(5000)
		sampSendChat("/me достал из шкафчика бланк справки.")
		wait(5000)
		sampSendChat("/me выписал справку о том, что пациент вылечен годен к службе.")
		wait(5000)
		sampSendChat("/healaddict")
    end
  },
}
end

function remont(id)
 return
{
  {
    title = "{80a4bf}»{FFFFFF} Открываем мешок с песком",
    onclick = function()
	    sampSendChat("/do На полу мешок с песком.")
        wait(5000)
        sampSendChat("/me открыл мешок с песком")
		wait(5000)
		sampSendChat("/do Мешок с песком открыт.")
    end
  },
  {
    title = "{80a4bf}»{FFFFFF} Берем лопату",
    onclick = function()
	    sampSendChat("/do Около мешка лежит лопата, мастерок и ведро. ")
        wait(5000)
        sampSendChat("/me взял лопату, мастерок и ведро")
		wait(5000)
		sampSendChat("/me поставил ведро перед мешком")
		wait(5000)
		sampSendChat("/do Ведро перед мешком.")
		wait(5000)
		sampSendChat("/do Процесс..")
		wait(5000)
		sampSendChat("/me закончил накладывать песок в ведро")
		wait(5000)
		sampSendChat("/do Ведро полное.")
    end
  },
  {
    title = "{80a4bf}»{FFFFFF} Идем к яме",
    onclick = function()
	    sampSendChat("/me поднял ведро и пошел к яме")
        wait(5000)
        sampSendChat("/do В асфальте глубокая яма.")
		wait(5000)
		sampSendChat("/me высыпал песок в яму")
		wait(5000)
		sampSendChat("/do Песок в яме.")
		wait(5000)
		sampSendChat("/me убрал ведро и достал мастерок")
    end
  },
  {
    title = "{80a4bf}»{FFFFFF} Мастерок в руке.",
    onclick = function()
	    sampSendChat("/do Мастерок в руке.")
        wait(5000)
        sampSendChat("/me разравнивает песок мастерком")
		wait(5000)
		sampSendChat("/do Процесс.")
		wait(5000)
		sampSendChat("/me закончил равнять песок")
		wait(5000)
		sampSendChat("/do Песок лежит ровно")
    end
  },
  {
    title = "{80a4bf}»{FFFFFF} Возвращаетесь в место где брали песок и продолжаете отыгрывать РП",
    onclick = function()
	    sampSendChat("/do На полу лежит асфальт.")
        wait(5000)
        sampSendChat("/me лопатой накладывает асфальт в ведро")
		wait(5000)
		sampSendChat("/do Процесс.")
		wait(5000)
		sampSendChat("/me закончил накладывать асфальт в ведро")
		wait(5000)
		sampSendChat("/do Ведро полностью забито асфальтом.")
    end
  },
  {
    title = "{80a4bf}»{FFFFFF} Возвращаетесь к месту куда высыпали песок и продолжаете отыгрывать РП",
    onclick = function()
	    sampSendChat("/me поставил ведро около ямы ")
        wait(5000)
        sampSendChat("/do Ведро около ямы")
		wait(5000)
		sampSendChat("/me лопатой выкладывает асфальт на песок")
		wait(5000)
		sampSendChat("/do Процесс..")
		wait(5000)
		sampSendChat("/me выложил асфальт на песок")
		wait(5000)
		sampSendChat("/do Асфальт лежит на песке.")
		wait(5000)
		sampSendChat("/me достал мастерок и начал разравнивать асфальт")
		wait(5000)
		sampSendChat("/me разравнял мастерком асфальт")
		wait(5000)
		sampSendChat("/do Залатал яму")
    end
  },
}
end

function osmrmenu1(id)
 return
{
  {
    title = "{80a4bf}»{FFFFFF} Мед.осмотр на призыве",
    onclick = function()
	    sampSendChat("- Хорошо. Сейчас мы проверим Вас на наличие наркозависимости.")
        wait(5000)
        sampSendChat("/do Через плечо врача накинута мед.сумка на ремне.")
        wait(5000)
        sampSendChat("/me достал из мед.сумки вату, спирт, шприц и специальную колбочку")
        wait(5000)
        sampSendChat("/me пропитал вату спиртом")
        wait(5000)
        sampSendChat("/do Пропитанная спиртом вата в левой руке.")
        wait(5000)
         sampSendChat("/me обработал ватой место укола на вене пациента")
        wait(5000)
        sampSendChat("/do Шприц и специальная колбочка в правой руке.")
        wait(5000)
        sampSendChat("/me аккуратным движением вводит шприц в вену пациента")
        wait(5000)
        sampSendChat("/me с помощью шприца взял немного крови для анализа")
        wait(5000)
        sampSendChat("/me перелил кровь из шприца в специальную колбу, затем поместил её в мини-лабораторию")
        wait(5000)
        sampSendChat("/me с помощью шприца взял немного крови для анализа")
        wait(5000)
        sampSendChat("/me перелил кровь из шприца в специальную колбу, затем поместил её в мини-лабораторию")
        wait(5000)
    end
  },
  {
    title = "{80a4bf}»{FFFFFF} Исследование уровня глюкозы в крови",
    onclick = function()
		sampSendChat("/do На столе стоит ящик с мед.картами и неврологическим молоточком ")
		wait(5000)
		sampSendChat("/me достал из ящика мед.карту на имя пациента.")
		wait(5000)
		sampSendChat(" Имеете ли Вы жалобы на здоровье?")
		wait(5000)
		sampSendChat("/do В левой руке чёрная ручка.")
		wait(5000)
		sampSendChat("/me сделал запись в мед.карте")
		wait(5000)
		sampSendChat("/me достал из ящика неврологический молоточек")
		wait(5000)
		sampSendChat(" Присаживайтесь, начнем обследование.")
		wait(5000)
		sampSendChat("/me водит молоточком перед глазами пациента")
		wait(5000)
		sampSendChat("/me убедился, что зрачки движутся содружественно и рефлекс в норме")
		wait(5000)
		sampSendChat(" Хорошо. Рефлексы зрения в норме.")
		wait(5000)
		sampSendChat("/me сделал запись в мед.карте")
		wait(5000)
		sampSendChat("/me ударил молоточком по левому колену пациента")
		wait(5000)
		sampSendChat(" Здесь тоже все впорядке. Проверим Вашу кровь.")
		wait(5000)
		sampSendChat("Исследуем ваш уровень глюкозы в крови")
		wait(5000)
		sampSendChat("/me достал из мед. сумки и надел стерильные перчатки")
		wait(5000)
		sampSendChat("/do Перчатки надеты.")
        wait(5000)
        sampSendChat("/me взял скарификатор со стола и проколол палец пациента")
		wait(5000)
		sampSendChat("/me сделал запись в мед.карте")
        wait(5000)
		sampSendChat("/me взял пробирку со стола и набрал в неё кровь из пальца, затем поместил её в мини-лабораторию")
		wait(5000)
		sampSendChat("/do На экране показан результат теста крови: 4,5 ммоль/л")
		wait(5000)
		sampSendChat("/checkheal")
    end
  },
}
end
function fthmenu(id)
 return
{
  {
    title = '{80a4bf}»{FFFFFF} Лекция для {139BEC}Интерна',
    onclick = function()
	    sampSendChat('Здраствуйте, Интерны ')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Мы рады приветстовать вас в стенах нашей больницы.Помните, вы пока только ученики .')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Существует ряд правил, они закреплены в Уставе больницы .')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Например, вам категорически запрещено прогуливать лекции.  ')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Запрещено брать медикаменты. А так же приступать к лечению пациентов,это опасно для их жизни  ')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Итак, чтобы окончить Интернатуру и получить долгожданное повышение, вам необходимо:.  ')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Ознакомиться с порталом штата, прослушать все лекции, затем пойти к старшему составу.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Они у вас проверяют знания устава, названий препаратов. И получаете свое повышение в должности.  ')
         wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Так же, не забывайте носить свои бэйджики №13. На этом лекция окончена. Вопросы есть?  . ')
		wait(5000)
		if cfg.main.hud then
        sampSendChat('/time 1')
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
    end
  },
   {
   title = '{80a4bf}»{FFFFFF} Первая помощь при {139BEC}Кровотечений',
    onclick = function()
       sampSendChat('Приветствую, коллеги. Сегодня я прочту Вам лекцию на тему «Первая помощь при кровотечении». ')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Нужно четко понимать, что артериальное кровотечение представляет смертельную опасность для жизни. ')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Первое, что требуется – перекрыть сосуд выше поврежденного места. ')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Для этого прижмите артерию пальцами и срочно готовьте жгут. ')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Используйте в таком случае любые подходящие средства: ')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('шарф, платок, ремень, оторвите длинный кусок одежды.') 
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Стягивайте жгут до тех пор, пока кровь не перестанет сочиться из раны. ')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('В случае венозного кровотечения действия повторяются, за исключением того, что..') 
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('.. жгут накладывается чуть ниже поврежденного места. ')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Следует помнить, что при обоих видах кровотечения жгут накладывается не более двух часов..') 
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('.. в жаркую погоду и не более часа в холодную. ')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('При капиллярном кровотечении следует обработать поврежденное место перекисью водорода.. ')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('.. и наложить пластырь, либо перебинтовать рану. ')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Спасибо за внимание.')
       wait(1200)
       if cfg.main.hud then
        sampSendChat('/time 1')
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
    end
  },
  {
  title = '{80a4bf}»{FFFFFF} Первая помощь при {139BEC}Обмороках',
    onclick = function()
      sampSendChat('Приветствую, коллеги. Сегодня я прочту Вам лекцию на тему «Первая помощь при обмороках». ')
      wait(cfg.commands.zaderjka * 5000)
      sampSendChat('Обмороки сопровождаются кратковременной потерей сознания, вызванной.. ')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('.. недостаточным кровоснабжением мозга. ')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('Обморок могут вызвать: резкая боль, эмоциональный стресс, ССБ и так далее. ')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('Бессознательному состоянию обычно предшествует резкое ухудшение самочувствия: ')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('нарастает слабость, появляются тошнота, головокружение, шум или звон в ушах. ')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('Затем человек бледнеет, покрывается холодным потом и внезапно теряет сознание. ')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('Первая помощь должна быть направлена на улучшение кровоснабжения мозга.. ')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('.. и обеспечение свободного дыхания. ')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('Если пострадавший находится в душном, плохо проветренном помещении, то.. ')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('.. откройте окно, включите вентилятор или вынесите потерявшего сознание на воздух.')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('Протрите его лицо и шею холодной водой, похлопайте по щекам и.. ')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('.. дайте пострадавшему понюхать ватку, смоченную нашатырным спиртом. ')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('Спасибо за внимание.')
       wait(1200)
		if cfg.main.hud then
        sampSendChat('/time 1')
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
    end
  },
  {
    title = '{80a4bf}»{FFFFFF} Первая помощь при {139BEC}ДТП',
    onclick = function()
       sampSendChat('Приветствую, коллеги. Сегодня я прочту Вам лекцию на тему «Первая помощь при ДТП». ')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Оказывая первую помощь, необходимо действовать по правилам. ')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Немедленно определите характер и источник травмы. ')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Наиболее частые травмы в случае ДТП - сочетание повреждений черепа.. ')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('.. и нижних конечностей и грудной клетки. ')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Необходимо извлечь пострадавшего из автомобиля, осмотреть его. ')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Далее следует оказать первую помощь в соответствии с выявленными травмами. ')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Выявив их, требуется перенести пострадавшего в безопасное место.. ')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('.. укрыть от холода, зноя или дождя и вызвать врача, а затем.. ')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('.. организовать транспортировку пострадавшего в лечебное учреждение.') 
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Спасибо за внимание.')
       wait(1200)
		if cfg.main.hud then
        sampSendChat('/time 1')
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
    end
  },
   {
    title = '{80a4bf}»{FFFFFF} Лекция для {139BEC}Нарколога',
    onclick = function()
	    sampSendChat('Здраствуйте. На должности Нарколог носим свои  бэйджики №18.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Сеансы от наркозависимости производятся специализированными препаратами. ')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Сеансы проводятся только в операционной на втором этаже больнице ')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Так же вы теперь должны будете помогать на призывах. ')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Чтобы повысится в должности, вам нужно будет пройти школу Спасателей, школа состоит из 6-и этапов. ')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Подробней на официальном сайте Министерства Здравоохранения. ')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('На этом лекция окончена. Вопросы имееются? ')
		wait(1200)
		if cfg.main.hud then
        sampSendChat('/time 1')
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
    end
  },
  {
    title = '{80a4bf}»{FFFFFF} Лекция о {139BEC}Вреде курения',
    onclick = function()
	    sampSendChat('Теперь я расскажу вам о вреде курения.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Курение - одна из самых знаменитых и распространенных привычек на сегодняшний день.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Запомните, господа, несколько вещей.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Курение вызывает рак и хроническое заболевание легких.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Также, табачный дым вызывает у некоторых людей всяческие кожные заболевания.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Брось сигарету - спаси себя и весь мир.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('На этом все, помните, Мин.Здрав. заботится о вашем здоровье.')
		wait(1200)
		if cfg.main.hud then
        sampSendChat('/time 1')
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
    end
  },
  {
    title = '{80a4bf}»{FFFFFF} Лекция о том {139BEC} как нужно обращаться с пациентами',
    onclick = function()
	    sampSendChat('Теперь лекция, о том, как нужно обращаться с пациентами.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Для начала, вы должны вежливо их поприветствовать, что бы им было приятно.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Дальше, вы должны представиться, и спросить чем можете помочь.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Если же человек молчит, не уходите, может думает что выбрать.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Когда человек задал вопрос, вы должны корректно ответить.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Если же вопрос грубый, неадекватный, не отвечайте.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('При угрозе и неадекватных действиях - вызовите полицию.')
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Спасибо за внимание, данная лекция подошла к концу.')
		wait(1200)
		if cfg.main.hud then
        sampSendChat('/time 1')
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
    end
  },
  {
    title = '{80a4bf}»{FFFFFF} Лекция о {139BEC} Наркотических препаратах',
    onclick = function()
	    sampSendChat('Здравствуйте, Уважаемые коллеги.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Сейчас я расскажу вам о вреде наркотических веществ.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Наркотики - это вещества, способные вызывать состояние эйфории.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Наркомания - заболевание, вызванное употреблением наркотических веществ.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('В среде употребляющих наркотики, выше риск заражения различными заболеваниями.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Каждому по силам помочь бороться с наркоманией.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Коллеги, обретайте уверенность в том, что вам не нужны наркотики.')
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat('На этом лекция окончена, спасибо за внимание!')
		wait(1200)
		if cfg.main.hud then
        sampSendChat('/time 1')
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
    end
  },
  {
    title = '{80a4bf}»{FFFFFF} Лекция о {139BEC} Вирусах',
    onclick = function()
	    sampSendChat('Сейчас я расскажу вам несколько советов о вирусах.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Все мы знаем о вирусах и о их быстром размножении.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Вирусы опасны. И чаще всего приводят к летальным исходам.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Господа, запомните несколько советов от Мин.Здрава.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Первое, если вы заражены, не контактируйте со здоровым.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Второе, обычный поцелуй может заразить вашу вторую половинку.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('И третье, чаще мойте руки! Особенно, если вас окружаю больные коллеги.')
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat('На этом все, помните, врачи штата заботится о вашем здоровье.')
		wait(1200)
		if cfg.main.hud then
        sampSendChat('/time 1')
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
    end
  },
   {
    title = '{80a4bf}»{FFFFFF} Лекция{139BEC} ПМП',
    onclick = function()
	sampSendChat('Здраствуйте уважаемые коллеги.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Большинство людей, оказавшись на месте теракта, впадают в панику и не знают, что им делать до приезда медиков.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('А между тем дорога буквально каждая минута, главное – понимать, как правильно оказать первую помощь. ')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Остановить кровотечение, не промывать рану, не извлекать инородные тела и глубоко дышать...')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('...вот основные действия, которые могут помочь пострадавшим при теракте.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Длительность факта изоляции человека специалисты считают ключевым моментом...')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('...для состояния пострадавших. Оптимально она не должна превышать 30 минут.')
        wait(cfg.commands.zaderjka * 1000)
		sampSendChat('Если дольше — у тяжелых пострадавших могут развиться опасные для жизни осложнения или просто наступит смерть.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Известно, что в связи с несвоевременным оказанием медицинской помощи при катастрофах, инцидентах, любых происшествиях, где есть пострадавшие...')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('...в течение первого часа погибает до 30% пострадавших, через три часа — до 70% а через шесть часов — до 90%')
        wait(cfg.commands.zaderjka * 1000)
		sampSendChat('Эти цифры показывают: первая помощь при терактах нужна чем скорее, тем лучше, до приезда медиков.')
        wait(cfg.commands.zaderjka * 1000)
		sampSendChat('На месте катастрофы или теракта вам надо справиться с тремя проблемами, которые убивают людей быстрее всего:')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('- внешняя угроза;')
		wait(cfg.commands.zaderjka * 1000)
		sampSendChat('- сильное кровотечение;')
		wait(cfg.commands.zaderjka * 1000)
		sampSendChat('- проблемы с дыханием.')
		wait(cfg.commands.zaderjka * 1000)
		sampSendChat('Их надо ликвидировать в той же приоритетности. Вам надо сфокусироваться лишь на этих трёх вещах и количество выживших будет максимально.')
        wait(cfg.commands.zaderjka * 1000)
		sampSendChat('Первая помощь — это комплекс срочных мер, направленных на спасение жизни человека')
		wait(cfg.commands.zaderjka * 1000)
		sampSendChat('Несчастный случай, резкий приступ заболевания, отравление — в этих и других чрезвычайных ситуациях необходима грамотная первая помощь...')
		wait(cfg.commands.zaderjka * 1000)
		if cfg.main.hud then
        sampSendChat('/time 1')
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
	end
   }
}
end

do

function imgui.OnDrawFrame()
   if first_window.v then
	local tagfr = imgui.ImBuffer(u8(cfg.main.tarr), 256)
	local tagb = imgui.ImBool(cfg.main.tarb)
	local clistb = imgui.ImBool(cfg.main.clistb)
	local autoscr = imgui.ImBool(cfg.main.hud)
	local hudik = imgui.ImBool(cfg.main.givra)
	local clisto = imgui.ImBool(cfg.main.clisto)
	local stateb = imgui.ImBool(cfg.main.male)
	local waitbuffer = imgui.ImInt(cfg.commands.zaderjka)
	local clistbuffer = imgui.ImInt(cfg.main.clist)
    local iScreenWidth, iScreenHeight = getScreenResolution()
	local btn_size = imgui.ImVec2(-0.1, 0)
    imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(7, 3))
    imgui.Begin(fa.ICON_COGS .. u8 ' Настройки##1', first_window, btn_size, imgui.WindowFlags.NoResize)
	imgui.PushItemWidth(200)
	imgui.AlignTextToFramePadding(); imgui.Text(u8("Использовать автотег"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'Использовать автотег', tagb) then
    cfg.main.tarb = not cfg.main.tarb
    end
	if tagb.v then
	if imgui.InputText(u8'Введите ваш Тег.', tagfr) then
    cfg.main.tarr = u8:decode(tagfr.v)
    end
	end
	imgui.Text(u8("Инфо-бар вылеченых"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'Включить/Выключить инфо-бар', hudik) then
        cfg.main.givra = not cfg.main.givra
		ftext(cfg.main.givra and 'Инфо-бар включен, установить положение /sethud' or 'Инфо-бар выключен')
    end
	imgui.Text(u8("Быстрый ответ на последнее смс"))
	imgui.SameLine()
    if imgui.HotKey(u8'##Быстрый ответ смс', config_keys.fastsms, tLastKeys, 100) then
	    rkeys.changeHotKey(fastsmskey, config_keys.fastsms.v)
		ftext('Клавиша успешно изменена. Старое значение: '.. table.concat(rkeys.getKeysName(tLastKeys.v), " + ") .. ' | Новое значение: '.. table.concat(rkeys.getKeysName(config_keys.fastsms.v), " + "))
		saveData(config_keys, 'moonloader/config/medick/keys.json')
	end
	imgui.Text(u8("Использовать автоклист"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'Использовать автоклист', clistb) then
        cfg.main.clistb = not cfg.main.clistb
    end
    if clistb.v then
        if imgui.SliderInt(u8"Выберите значение клиста", clistbuffer, 0, 33) then
            cfg.main.clist = clistbuffer.v
        end
		imgui.Text(u8("Использовать отыгровку раздевалки"))
	    imgui.SameLine()
		if imgui.ToggleButton(u8'Использовать отыгровку раздевалки', clisto) then
        cfg.main.clisto = not cfg.main.clisto
        end
    end
	imgui.Text(u8("Мужские отыгровки"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'Мужские отыгровки', stateb) then
        cfg.main.male = not cfg.main.male
    end
	if imgui.SliderInt(u8'Задержка в лекциях и отыгровках(сек)', waitbuffer, 1, 25) then
     cfg.commands.zaderjka = waitbuffer.v
    end
	imgui.Text(u8("Автоскрин лекций/гос.новостей"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'Автоскрин лекций', autoscr) then
        cfg.main.hud = not cfg.main.hud
    end
    if imgui.CustomButton(u8('Сохранить настройки'), imgui.ImVec4(0.08, 0.61, 0.92, 0.40), imgui.ImVec4(0.08, 0.61, 0.92, 1.00), imgui.ImVec4(0.08, 0.61, 0.92, 0.76), btn_size) then
	ftext('Настройки успешно сохранены.', -1)
    inicfg.save(cfg, 'medick/config.ini') -- сохраняем все новые значения в конфиге
    end
    imgui.End()
   end
    if ystwindow.v then
                imgui.LockPlayer = true
                imgui.ShowCursor = true
                local iScreenWidth, iScreenHeight = getScreenResolution()
                imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
                imgui.SetNextWindowSize(imgui.ImVec2(iScreenWidth/2, iScreenHeight / 2), imgui.Cond.FirstUseEver)
                imgui.Begin(u8('Medick Tools | Устав Больницы'), ystwindow)
                for line in io.lines('moonloader\\medick\\ystav.txt') do
                    imgui.TextWrapped(u8(line))
                end
                imgui.End()
            end
  if second_window.v then
    imgui.LockPlayer = true
    imgui.ShowCursor = true
    local iScreenWidth, iScreenHeight = getScreenResolution()
    local btn_size1 = imgui.ImVec2(70, 0)
	local btn_size = imgui.ImVec2(130, 0)
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
    imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(7, 5))
    imgui.Begin('Medick Helpers | Main Menu | Version: '..thisScript().version, second_window, mainw,  imgui.WindowFlags.NoResize)
	local text = 'Разработали:'
    imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(u8(text)).x)/3)
    imgui.Text(u8(text))
	imgui.SameLine()
	imgui.TextColored(imgui.ImVec4(0.90, 0.16 , 0.30, 1.0), 'Makar_Sheludkov, Doni_Baerra, Ruslan_Wolhovsky')
	imgui.Image(test, imgui.ImVec2(890, 140))
    imgui.Separator()
	if imgui.Button(u8'Биндер', imgui.ImVec2(50, 30)) then
      bMainWindow.v = not bMainWindow.v
    end
	imgui.SameLine()
    if imgui.Button(fa.ICON_COGS .. u8' Настройки скрипта', imgui.ImVec2(141, 30)) then
      first_window.v = not first_window.v
    end
    imgui.SameLine()
    if imgui.Button(fa.ICON_EXCLAMATION_TRIANGLE .. u8' Сообщить об ошибке/баге', imgui.ImVec2(181, 30)) then os.execute('explorer "https://vk.com/mark_kaufmann"')
    btn_size = not btn_size
    end
	imgui.SameLine()
    if imgui.Button(fa.ICON_REFRESH .. u8' Перезагрузить скрипт', imgui.ImVec2(155, 30)) then
      showCursor(false)
      thisScript():reload()
    end
	imgui.SameLine()
    if imgui.Button(fa.ICON_WRENCH .. u8' Информация о обновлениях', imgui.ImVec2(192, 30)) then
      obnova.v = not obnova.v
    end
    if imgui.Button(fa.ICON_POWER_OFF .. u8' Отключить скрипт', imgui.ImVec2(135, 30), btn_size) then
      showCursor(false)
      thisScript():unload()
    end
	imgui.SameLine()
    if imgui.Button(fa.ICON_INFO .. u8 ' Помощь', imgui.ImVec2(70, 30)) then
      helps.v = not helps.v
    end
	imgui.SameLine()
    if imgui.Button(fa.ICON_STOP_CIRCLE .. u8' Остановить лекцию', imgui.ImVec2(145, 30)) then
	showCursor(false)
	thisScript():reload()
    end
	imgui.SameLine()
    if imgui.Button(fa.ICON_LINE_CHART .. u8' Система повышений', imgui.ImVec2(155, 30)) then os.execute('explorer "https://evolve-rp.su/index.php?threads/moh-sistema-povyshenija-upd-14-03-20.133094/-Система-повышения-сотрудников-Больницы.71029/"')
    btn_size = not btn_size
    end
	imgui.SameLine()
    if imgui.Button(fa.ICON_BOOK .. u8' Устав', imgui.ImVec2(70, 30)) then os.execute('explorer "https://evolve-rp.su/index.php?threads/moh-ustav-ministerstva-i-sistema-nakazanij.132703/"')
    btn_size = not btn_size
    end
	imgui.SameLine()
    if imgui.Button(fa.ICON_QUESTION .. u8' Помощь для новичков [FAQ]', imgui.ImVec2(195, 30)) then os.execute('explorer "https://evolve-rp.su/index.php?threads/moh-f-a-q-informacija-dlja-novichkov.111667//"')
    btn_size = not btn_size
    end
	if imgui.Button(fa.ICON_BOOK .. u8' История Глав.Врачей', imgui.ImVec2(235, 30)) then os.execute('explorer "https://evolve-rp.su/index.php?threads/history-moh-com-istorija-glavnyx-vrachej.199206/"')
	btn_size = not btn_size
	end
	imgui.SameLine()
	if imgui.Button(fa.ICON_BOOK .. u8' Форумный раздел МОН', imgui.ImVec2(220, 30)) then os.execute('explorer "https://evolve-rp.su/index.php?forums/ministerstvo-zdravooxranenija.280/"')
	btn_size = not btn_size
	end
	imgui.SameLine()
	if imgui.Button(fa.ICON_COGS .. u8' Очистить чат ', imgui.ImVec2(220, 30)) then
		sampAddChatMessage("")
		sampAddChatMessage("")
		sampAddChatMessage("")
		sampAddChatMessage("")
		sampAddChatMessage("")
		sampAddChatMessage("")
		sampAddChatMessage("")
		sampAddChatMessage("")
		sampAddChatMessage("")
		sampAddChatMessage("")
		sampAddChatMessage("")
		sampAddChatMessage("")
		sampAddChatMessage("")
		sampAddChatMessage("")
		sampAddChatMessage("")
		sampAddChatMessage("")
		sampAddChatMessage("")
		sampAddChatMessage("{9966cc} Medick Helper {ffffff}| Чат успешно очищен!", 0xFFFFFF)
	btn_size = not btn_size	
	end
	imgui.Separator()
	imgui.BeginChild("Информация", imgui.ImVec2(410, 150), true)
	imgui.Text(u8 'Имя и Фамилия:   '..sampGetPlayerNickname(myid):gsub('_', ' ')..'')
	imgui.Text(u8 'Должность:') imgui.SameLine() imgui.Text(u8(rank))
	imgui.Text(u8 'Номер телефона:   '..tel..'')
	if cfg.main.tarb then
	imgui.Text(u8 'Тег в рацию:') imgui.SameLine() imgui.Text(u8(cfg.main.tarr))
	end
	if cfg.main.clistb then
	imgui.Text(u8 'Номер бейджика:   '..cfg.main.clist..'')
	imgui.Text(u8 'Версия скрипта: 3.8.2 BETA 1')
	end
	imgui.EndChild()
	imgui.Separator()
	imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(u8("Текущая дата: %s")).x)/1.5)
	imgui.Text(u8(string.format("Текущая дата: %s", os.date())))
    imgui.End()
  end
  	if infbar.v then
            _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
            local myname = sampGetPlayerNickname(myid)
            local myping = sampGetPlayerPing(myid)
            local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
            imgui.SetNextWindowPos(imgui.ImVec2(cfg.main.posX, cfg.main.posY), imgui.ImVec2(0.5, 0.5))
            imgui.SetNextWindowSize(imgui.ImVec2(cfg.main.widehud, 175), imgui.Cond.FirstUseEver)
            imgui.Begin('Medic Helper', infbar, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoTitleBar)
            imgui.CentrText('Medic Helper')
            imgui.Separator()
            imgui.Text((u8"Информация: %s [%s] | Пинг: %s"):format(myname, myid, myping))
            if isCharInAnyCar(playerPed) then
                local vHandle = storeCarCharIsInNoSave(playerPed)
                local result, vID = sampGetVehicleIdByCarHandle(vHandle)
                local vHP = getCarHealth(vHandle)
                local carspeed = getCarSpeed(vHandle)
                local speed = math.floor(carspeed)
                local vehName = tCarsName[getCarModel(storeCarCharIsInNoSave(playerPed))-399]
                local ncspeed = math.floor(carspeed*2)
                imgui.Text((u8 'Транспорт: %s [%s]|HP: %s|Скорость: %s'):format(vehName, vID, vHP, ncspeed))
            else
                imgui.Text(u8 'Транспорт: Нет')
            end
			    imgui.Text((u8 'Время: %s'):format(os.date('%H:%M:%S')))
            if valid and doesCharExist(ped) then 
                local result, id = sampGetPlayerIdByCharHandle(ped)
                if result then
                    local targetname = sampGetPlayerNickname(id)
                    local targetscore = sampGetPlayerScore(id)
                    imgui.Text((u8 'Цель: %s [%s] | Уровень: %s'):format(targetname, id, targetscore))
                else
                    imgui.Text(u8 'Цель: Нет')
                end
            else
                imgui.Text(u8 'Цель: Нет')
            end
			local cx, cy, cz = getCharCoordinates(PLAYER_PED)
			local zcode = getNameOfZone(cx, cy, cz)
			imgui.Text((u8 'Локация: %s | Квадрат: %s'):format(u8(getZones(zcode)), u8(kvadrat())))
			imgui.Text((u8 'Вылечено: %s | Вылечено от нарко: %s'):format((health), u8(narkoh)))
            inicfg.save(cfg, 'medick/config.ini')
            imgui.End()
        end
    if obnova.v then
                local iScreenWidth, iScreenHeight = getScreenResolution()
                imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(7, 3))
                 imgui.Begin(fa.ICON_WRENCH .. u8' Обновления', obnova, imgui.WindowFlags.NoResize, imgui.WindowFlags.NoCollapse)
				imgui.BeginChild("Обновления", imgui.ImVec2(540, 250), true, imgui.WindowFlags.VerticalScrollbar)
                imgui.BulletText(u8 'Что было сделано:')
				imgui.Separator()
				imgui.BulletText(u8 'v2.9.2')
				imgui.BulletText(u8 '1.Команда /z - Для лечения в автомобиле.')
				imgui.BulletText(u8 '2.Полностью переписана Менюшка Пкм+Z.')
				imgui.Separator()
				imgui.BulletText(u8 'v2.9.3')
				imgui.BulletText(u8 '1.Удалено проктически все что связнано с Medick Helper.')
                imgui.BulletText(u8 '2.Переработаны задержки всех отыгровок.')
				imgui.BulletText(u8 '3.Устранены мелкие баги и проблемы с текстом.')
				imgui.Separator()
				imgui.BulletText(u8 'v2.9.4')
				imgui.BulletText(u8 '1.Изменен цвет интерфейса')
				imgui.Separator()
				imgui.BulletText(u8 'v2.9.5')
				imgui.BulletText(u8 '1.Теперь гл.меню открывается на /mh')
				imgui.BulletText(u8 '2.Добавлено в меню Пкм+Z меню собеседования')
				imgui.Separator()
				imgui.BulletText(u8 'v2.9.7')
				imgui.BulletText(u8 '1.Переработан полностью /sethud')
				imgui.Separator()
				imgui.BulletText(u8 'v3.0')
				imgui.BulletText(u8 '1.Теперь убрано ВСЕ что остовалось от Instructors helper.')
				imgui.BulletText(u8 '2.В меню Пкм+Z добавлена проверка на вирус.')
				imgui.BulletText(u8 '3.Добавлены новые лекции и Gov.')
				imgui.Separator()
				imgui.BulletText(u8 'v3.2')
				imgui.BulletText(u8 '1.Возвращена настройка задержки в Настройках скрипта.')
				imgui.BulletText(u8 '2.Добавлены новые лекции и методы лечения.')
				imgui.BulletText(u8 '3.Доработаны задержки.')
                imgui.Separator()
				imgui.BulletText(u8 'v3.8')
				imgui.BulletText(u8 '1.Добавлены логи "/smslog" и "/rlog" ')
				imgui.BulletText(u8 '2.Полностью изменен интерфейс')
				imgui.BulletText(u8 '3.Добавлены новые лекции, мелкие изменения по тексту')
				imgui.BulletText(u8 '4.Добавлена кастомизация интерфейса')
				imgui.BulletText(u8 '5.Немного изменен Худ')
				imgui.Separator()
				imgui.BulletText(u8 'v3.8.1')
				imgui.BulletText(u8 '1.Сделал reboot скрипта на версию v3.7" ')
				imgui.BulletText(u8 '2.Вернул интерфейс, убрал кастомизацию.')
				imgui.BulletText(u8 '3.Добавлены новые лекции, изменнены отделы.')
				imgui.BulletText(u8 '4.Исправлен "/smslog" ')
				imgui.BulletText(u8 '5.Исправлен биндер.')
				imgui.BulletText(u8 '5.Изменен интерфейс.')
				imgui.Separator()
				imgui.BulletText(u8 'v3.8.2 BETA 1')
				imgui.BulletText(u8 'Исправление бага с /smsjob для Глав.Врача')
				imgui.BulletText(u8 'Добавлена кнопка "История Глав.Врачей" в главном меню /mh')
				imgui.BulletText(u8 'Добавлена кнопка "Старший Состав" в главном меню /mh')
				imgui.BulletText(u8 'Добавлена новая команда /infomoh - выдает информацию о Больнице ЛС')
				imgui.BulletText(u8 'Обновлена информация об Глав.Враче')
				imgui.BulletText(u8 'Добавлен новый слот для вещания в /gov')
				imgui.BulletText(u8 'Исправлен баг с /time в некоторых вещаниях /gov')
				imgui.BulletText(u8 'Добавлена функция "Очистка чата"')
				imgui.Separator()
				imgui.BulletText(u8 'Связь и предложения:')
				imgui.BulletText(u8('ВК: Mark(кликабельно)'))
				if imgui.IsItemClicked() then
				os.execute('explorer https://vk.com/mark_kaufmann')
				end
                imgui.BulletText(u8'Discord(Baerra#0419)')
				imgui.Separator()
				imgui.BulletText(u8 ('ВК: Ruslan(кликабельно)'))
				if imgui.IsItemClicked() then
				os.execute('explorer https://vk.com/wolhovsky')
				end
				imgui.BulletText(u8'Telegram (@dmitry_krasavchikov)')
				imgui.EndChild()
                imgui.End()
    end
	if helps.v then
                local iScreenWidth, iScreenHeight = getScreenResolution()
                imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(7, 3))
                imgui.Begin(fa.ICON_INFO .. u8 ' Помощь по скрипту', helps, imgui.WindowFlags.NoResize, imgui.WindowFlags.NoCollapse)
				imgui.BeginChild("Список команд", imgui.ImVec2(495, 230), true, imgui.WindowFlags.VerticalScrollbar)
                imgui.BulletText(u8 '/mh - Открыть меню скрипта')
                imgui.Separator()
				imgui.BulletText(u8 '/z [id] - Вылечить пациента в авто')
				imgui.BulletText(u8 '/vig [id] [Причина] - Выдать выговор по рации')
				imgui.BulletText(u8 '/ivig [id] [Причина] - Выдать строгий выговор по рации')
				imgui.BulletText(u8 '/unvig [id] [Причина] - Снять выговор по рации')
                imgui.BulletText(u8 '/dmb - Открыть /members в диалоге')
				imgui.BulletText(u8 '/blg [id] [Фракция] [Причина] - Выразить игроку благодарность в /d')
				imgui.BulletText(u8 '/oinv[id] - Принять человека в отдел')
				imgui.BulletText(u8 '/zinv[id] - Назначить человека Заместителем отдела')
				imgui.BulletText(u8 '/ginv[id] - Назначить человека Главой отдела')
                imgui.BulletText(u8 '/where [id] - Запросить местоположение по рации')
                imgui.BulletText(u8 '/yst - Открыть устав Больницы')
				imgui.BulletText(u8 '/smsjob - Вызвать на работу весь мл.состав по смс')
                imgui.BulletText(u8 '/dlog - Открыть лог 25 последних сообщений в департамент')
				imgui.BulletText(u8 '/sethud - Установить позицию инфо-бара')
				imgui.BulletText(u8 '/cinv - Принятие в CR')
				imgui.Separator()
                imgui.BulletText(u8 'Клавиши: ')
                imgui.BulletText(u8 'ПКМ+Z на игрока - Меню взаимодействия')
                imgui.BulletText(u8 'F3 - "Быстрое меню"')
				imgui.EndChild()
                imgui.End()
    end
  if bMainWindow.v then
  local iScreenWidth, iScreenHeight = getScreenResolution()
	local tLastKeys = {}

   imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
   imgui.SetNextWindowSize(imgui.ImVec2(800, 530), imgui.Cond.FirstUseEver)

   imgui.Begin(u8("Medick Help | Биндер##main"), bMainWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize)
	imgui.BeginChild("##bindlist", imgui.ImVec2(795, 442))
	for k, v in ipairs(tBindList) do
		if hk.HotKey("##HK" .. k, v, tLastKeys, 100) then
			if not rkeys.isHotKeyDefined(v.v) then
				if rkeys.isHotKeyDefined(tLastKeys.v) then
					rkeys.unRegisterHotKey(tLastKeys.v)
				end
				rkeys.registerHotKey(v.v, true, onHotKey)
			end
		end
		imgui.SameLine()
		if tEditData.id ~= k then
			local sText = v.text:gsub("%[enter%]$", "")
			imgui.BeginChild("##cliclzone" .. k, imgui.ImVec2(500, 21))
			imgui.AlignTextToFramePadding()
			if sText:len() > 0 then
				imgui.Text(u8(sText))
			else
				imgui.TextDisabled(u8("Пустое сообщение ..."))
			end
			imgui.EndChild()
			if imgui.IsItemClicked() then
				sInputEdit.v = sText:len() > 0 and u8(sText) or ""
				bIsEnterEdit.v = string.match(v.text, "(.)%[enter%]$") ~= nil
				tEditData.id = k
				tEditData.inputActve = true
			end
		else
			imgui.PushAllowKeyboardFocus(false)
			imgui.PushItemWidth(500)
			local save = imgui.InputText("##Edit" .. k, sInputEdit, imgui.InputTextFlags.EnterReturnsTrue)
			imgui.PopItemWidth()
			imgui.PopAllowKeyboardFocus()
			imgui.SameLine()
			imgui.Checkbox(u8("Ввод") .. "##editCH" .. k, bIsEnterEdit)
			if save then
				tBindList[tEditData.id].text = u8:decode(sInputEdit.v) .. (bIsEnterEdit.v and "[enter]" or "")
				tEditData.id = -1
			end
			if tEditData.inputActve then
				tEditData.inputActve = false
				imgui.SetKeyboardFocusHere(-1)
			end
		end
	end
	imgui.EndChild()

	imgui.Separator()

	if imgui.Button(u8"Добавить клавишу") then
		tBindList[#tBindList + 1] = {text = "", v = {}}
	end

   imgui.End()
  end
  end
end

function onHotKey(id, keys)
	local sKeys = tostring(table.concat(keys, " "))
	for k, v in pairs(tBindList) do
		if sKeys == tostring(table.concat(v.v, " ")) then
			if tostring(v.text):len() > 0 then
				local bIsEnter = string.match(v.text, "(.)%[enter%]$") ~= nil
				if bIsEnter then
					sampProcessChatInput(v.text:gsub("%[enter%]$", ""))
				else
					sampSetChatInputText(v.text)
					sampSetChatInputEnabled(true)
				end
			end
		end
	end
end

function showHelp(param) -- "вопросик" для скрипта
    imgui.TextDisabled('(?)')
    if imgui.IsItemHovered() then
        imgui.BeginTooltip()
        imgui.PushTextWrapPos(imgui.GetFontSize() * 35.0)
        imgui.TextUnformatted(param)
        imgui.PopTextWrapPos()
        imgui.EndTooltip()
    end
end

function onScriptTerminate(scr)
	if scr == script.this then
		if doesFileExist(fileb) then
			os.remove(fileb)
		end
		local f = io.open(fileb, "w")
		if f then
			f:write(encodeJson(tBindList))
			f:close()
		end
		local fa = io.open("moonloader/config/medick/keys.json", "w")
        if fa then
            fa:write(encodeJson(config_keys))
            fa:close()
        end
	end
end

addEventHandler("onWindowMessage", function (msg, wparam, lparam)
	if msg == wm.WM_KEYDOWN or msg == wm.WM_SYSKEYDOWN then
		if tEditData.id > -1 then
			if wparam == key.VK_ESCAPE then
				tEditData.id = -1
				consumeWindowMessage(true, true)
			elseif wparam == key.VK_TAB then
				bIsEnterEdit.v = not bIsEnterEdit.v
				consumeWindowMessage(true, true)
			end
		end
	end
end)

function submenus_show(menu, caption, select_button, close_button, back_button)
    select_button, close_button, back_button = select_button or '»', close_button or 'x', back_button or '«'
    prev_menus = {}
    function display(menu, id, caption)
        local string_list = {}
        for i, v in ipairs(menu) do
            table.insert(string_list, type(v.submenu) == 'table' and v.title .. ' »' or v.title)
        end
        sampShowDialog(id, caption, table.concat(string_list, '\n'), select_button, (#prev_menus > 0) and back_button or close_button, sf.DIALOG_STYLE_LIST)
        repeat
            wait(0)
            local result, button, list = sampHasDialogRespond(id)
            if result then
                if button == 1 and list ~= -1 then
                    local item = menu[list + 1]
                    if type(item.submenu) == 'table' then -- submenu
                        table.insert(prev_menus, {menu = menu, caption = caption})
                        if type(item.onclick) == 'function' then
                            item.onclick(menu, list + 1, item.submenu)
                        end
                        return display(item.submenu, id + 1, item.submenu.title and item.submenu.title or item.title)
                    elseif type(item.onclick) == 'function' then
                        local result = item.onclick(menu, list + 1)
                        if not result then return result end
                        return display(menu, id, caption)
                    end
                else -- if button == 0
                    if #prev_menus > 0 then
                        local prev_menu = prev_menus[#prev_menus]
                        prev_menus[#prev_menus] = nil
                        return display(prev_menu.menu, id - 1, prev_menu.caption)
                    end
                    return false
                end
            end
        until result
    end
    return display(menu, 31337, caption or menu.title)
end

function r(pam)
    if #pam ~= 0 then
        if cfg.main.tarb then
            sampSendChat(string.format('/r [%s]: %s', cfg.main.tarr, pam))
        else
            sampSendChat(string.format('/r %s', pam))
        end
    else
        ftext('Введите /r [текст]')
    end
end
function f(pam)
    if #pam ~= 0 then
        if cfg.main.tarb then
            sampSendChat(string.format('/f [%s]: %s', cfg.main.tarr, pam))
        else
            sampSendChat(string.format('/f %s', pam))
        end
    else
        ftext('Введите /f [текст]')
    end
end
function ftext(message)
    sampAddChatMessage(string.format('%s %s', ctag, message), 0x139BEC)
end

function mh()
  second_window.v = not second_window.v
end

function tloadtk()
    if tload == true then
     sampSendChat('/tload'..u8(cfg.main.norma))
    else if tload == false then
     sampSendChat("/tunload")
    end
  end
end
function imgui.CentrText(text)
            local width = imgui.GetWindowWidth()
            local calc = imgui.CalcTextSize(text)
            imgui.SetCursorPosX( width / 2 - calc.x / 2 )
            imgui.Text(text)
        end
        function imgui.CustomButton(name, color, colorHovered, colorActive, size)
            local clr = imgui.Col
            imgui.PushStyleColor(clr.Button, color)
            imgui.PushStyleColor(clr.ButtonHovered, colorHovered)
            imgui.PushStyleColor(clr.ButtonActive, colorActive)
            if not size then size = imgui.ImVec2(0, 0) end
            local result = imgui.Button(name, size)
            imgui.PopStyleColor(3)
            return result
        end

function pkmmenu(id)
    local color = ("%06X"):format(bit.band(sampGetPlayerColor(id), 0xFFFFFF))
    return
    {
      {
        title = "{80a4bf}»{ffffff} Меню Врача",
        onclick = function()
        pID = tonumber(args)
        submenus_show(instmenu(id), "{9966cc}Medick Helper {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
      {
        title = "{80a4bf}» {ffffff}Раздел Лечения",
        onclick = function()
        pID = tonumber(args)
        submenus_show(oformenu(id), "{9966cc}Medick Helper {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
	  {
		title = "{80a4bf}»{FFFFFF} Вопросы по Уставу/Расценки {ff0000}(Ст.Состава)",
		onclick = function()
		if rank == 'Психолог' or rank == 'Хирург' or rank == 'Зам.Глав.Врача' or rank == 'Глав.Врач' then
		submenus_show(ustav(id), "{9966cc}Medick Helper {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."]")
		else
		ftext('Вы не находитесь в Ст.Составе')
		end
		end
   },
	  {
        title = "{80a4bf}» {ffffff}Призыв меню",
        onclick = function()
        pID = tonumber(args)
        submenus_show(priziv(id), "{9966cc}Medick Helper {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
	  {
        title = "{80a4bf}» {ffffff}Проверка Вируса",
        onclick = function()
        pID = tonumber(args)
        submenus_show(virus(id), "{9966cc}Medick Helper {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
	  {
        title = "{80a4bf}» {ffffff}Меню собеседования {ff0000}(Ст.Состава)",
        onclick = function()
        pID = tonumber(args)
        if rank == 'Доктор' or rank == 'Психолог' or rank == 'Хирург' or rank == 'Зам.Глав.Врача' or  rank == 'Глав.Врач' then
		submenus_show(sobesedmenu(id), "{9966cc}Medick Helper {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
		else
		ftext('Вы не находитесь в Ст.Составе')
		end
        end
      },
	  {
        title = "{ffffff}» Меню рентгена, порезов, переломов",
        onclick = function()
        pID = tonumber(args)
        submenus_show(renmenu(id), "{9966cc}Medic Helper {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
	}
end
function agitmenu(id)
 return
{
   {
   title = '{80a4bf}»{FFFFFF} Агитация 1',
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	local myname = sampGetPlayerNickname(myid)
	sampSendChat('/d OG, Мин.Здравоохранение в поисках квалифицированных врачей. Подробней на pgr '..myid..'')
	end
	
	 },
    {
   title = '{80a4bf}»{FFFFFF} Агитация 2',
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	local myname = sampGetPlayerNickname(myid)
	sampSendChat('/d OG, Давно хотел получать большую зарплату? Оставляй заявку на д.Нарколог...')
	wait(cfg.commands.zaderjka * 750)
	sampSendChat('/d ..Подробней на оф.сайте') 
	end
   },
}
end
function ustav(id)
    return
    {
      {
        title = '{5b83c2}« Раздел Устава »',
        onclick = function()
        end
      },
      {
        title = '{80a4bf}» {ffffff}Сколько минут дается сотруднику, чтобы прибыть на работу и переодеться в рабочую форму?',
        onclick = function()
        sampSendChat("Сколько минут дается сотруднику, чтобы прибыть на работу и переодеться в рабочую форму?")
		wait(1500)
		ftext("{FFFFFF}- Правильный ответ: {A52A2A}15 минут.", -1)
		end
      },
      {
        title = '{80a4bf}» {ffffff}С какой должности разрешено использовать волну департамента в качестве переговоров?',
        onclick = function()
        sampSendChat("С какой должности разрешено использовать волну департамента в качестве переговоров?")
		wait(500)
		ftext("{FFFFFF}- Правильный ответ: {A52A2A}С должности Мед.Брата.", -1)
		end
      },
	  {
        title = '{80a4bf}» {ffffff}С какой должности разрешено выезжать в наземный патруль штата?',
        onclick = function()
        sampSendChat(" С какой должности разрешено выезжать в наземный патруль штата?")
		wait(1500)
		ftext("{FFFFFF}- Правильный ответ: {A52A2A}С должности Мед.Брата.", -1)
		end
      },
	  {
        title = '{80a4bf}» {ffffff}С какой должности разрешено использовать воздушно-транспортное средство?',
        onclick = function()
        sampSendChat("С какой должности разрешено использовать воздушно-транспортное средство?")
		wait(1500)
		ftext("{FFFFFF}- Правильный ответ: {A52A2A}С должности Психолога, по разрешению {ff0000}рук-во с доктора.", -1)
		end
      },
	  {
        title = '{80a4bf}» {ffffff}Какие заведения запрещено посещать во время рабочего дня?',
        onclick = function()
        sampSendChat("Какие заведения запрещено посещать во время рабочего дня?")
		wait(1500)
		ftext("{FFFFFF}- Правильный ответ: {A52A2A}Автобазар, Казино.", -1)
		end
      },
	  {
        title = '{80a4bf}» {ffffff}Сколько должен заплатить гражданин Evolve, чтобы выйти из черного списка?',
        onclick = function()
        sampSendChat("Сколько должен заплатить гражданин Evolve, чтобы выйти из черного списка?")
		wait(1500)
		ftext("{FFFFFF}- Правильный ответ: {A52A2A}от {ff0000}100.000 до {ff0000}150.000 вирт.", -1)
		end
      },
	  {
        title = '{5b83c2}« Раздел вопросов по медикаментам »',
        onclick = function()
        end
	  },
	  {
        title = '{80a4bf}» {ffffff}Какие мед.препараты Вы выпишите от боли в животе?',
        onclick = function()
        sampSendChat("Какие мед.препараты Вы выпишите от боли в животе?")
		wait(1500)
		ftext("{FFFFFF}- Правильный ответ: {A52A2A}Но-шпа, Дротаверин, Кеторолак, Спазмалгон, Кетанов.", -1)
		end
      },
	  {
        title = '{80a4bf}» {ffffff}Какие мед.препараты Вы выпишите при боли в голове?',
        onclick = function()
        sampSendChat("Какие мед.препараты Вы выпишите при боли в голове?")
		wait(1500)
		ftext("{FFFFFF}- Правильный ответ: {A52A2A}Аспирин, Анальгин, Цитрамон, Диклофенак, Пенталгин.", -1)
		end
      },
	  {
        title = '{80a4bf}» {ffffff}Какие мед.препараты Вы выпишите от боли в горле?',
        onclick = function()
        sampSendChat("Какие мед.препараты Вы выпишите от боли в горле?")
		wait(1500)
		ftext("{FFFFFF}- Правильный ответ: {A52A2A}Гексализ, Фалиминт, Стрепсилс.", -1)
		end
      },
	  {
        title = '{80a4bf}» {ffffff}Какие мед.препараты Вы выпишите от температуры?',
        onclick = function()
        sampSendChat("Какие мед.препараты Вы выпишите от температуры?")
		wait(1500)
		ftext("{FFFFFF}- Правильный ответ: {A52A2A}Парацетамол, Нурофен, Ибуклин, Ринза.", -1)
		end
      },
	  {
        title = '{80a4bf}» {ffffff}Какие мед.препараты Вы выпишите при кашле?',
        onclick = function()
        sampSendChat("Какие мед.препараты Вы выпишите при кашле?")
		wait(1500)
		ftext("{FFFFFF}- Правильный ответ: {A52A2A}Амбробене, Амброгексал, АЦЦ, Бромгексин, Доктор Мом.", -1)
		end
      },
	  {
        title = '{5b83c2}« Раздел вопросов по медикаментам »',
        onclick = function()
        end
	  },
	  {
        title = '{80a4bf}» {ffffff}ДТП',
        onclick = function()
        sampSendChat("Представим ситуацию вы ехали на срочный вызов, и становитесь свидетелем ДТП, водитель вылетает на трассу...")
		wait(1500)
		sampSendChat("...умирает два человека один который вас вызывал, второй пострадавший в этом ДТП, ваши действия?")
		end
      },
	  {
        title = '{80a4bf}» {ffffff}Огнестрел',
        onclick = function()
        sampSendChat("Вы идете по полю и видите как на земле лежит человек с огнестрельным раннем в ноге...")
		wait(1500)
		sampSendChat("...собой есть мед.сумка, современных препаратов нету, ваши действия ?")
		end
      },
	  {
        title = '{80a4bf}» {ffffff}Обморок',
        onclick = function()
        sampSendChat("Вы видите как человек упал в обморок, ваши действия ?")
		end
      },
    }
end
function saveData(table, path)
	if doesFileExist(path) then os.remove(path) end
    local sfa = io.open(path, "w")
    if sfa then
        sfa:write(encodeJson(table))
        sfa:close()
    end
end
function ystf()
    if not doesFileExist('moonloader/medick/ystav.txt') then
        local file = io.open("moonloader/medick/ystav.txt", "w")
        file:write(fpt)
        file:close()
        file = nil
    end
end
function instmenu(id)
    return
    {
      {
        title = '{5b83c2}« Раздел Врача »',
        onclick = function()
        end
      },
      {
        title = '{80a4bf}» {ffffff}Приветствие.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myname = sampGetPlayerNickname(myid)
        sampSendChat("Здравствуйте. Я сотрудник больницы "..myname:gsub('_', ' ')..", чем могу помочь?")
		end
      },
      {
        title = '{80a4bf}» {ffffff}Паспорт',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat("Ваш паспорт, пожалуйста.")
		wait(5000)
		sampSendChat("/b /showpass "..myid.."")
        end
      },
	  {
        title = '{80a4bf}» {ffffff}Попрощаться с клиентом',
        onclick = function()
        sampSendChat("Всего вам доброго.")
        end
      }
    }
end

function ystf()
    if not doesFileExist('moonloader/medick/ystav.txt') then
        local file = io.open("moonloader/medick/ystav.txt", "w")
        file:write(fpt)
        file:close()
        file = nil
    end
end
function oformenu(id)
    return
    {
      {
        title = '{5b83c2}« Раздел Лечения »',
        onclick = function()
        end
      },
      {
        title = '{80a4bf}» {ffffff}Лечение.',
        onclick = function()
		  sampSendChat("/do Через плечо врача накинута мед. сумка на ремне.")
		  wait(2000)
          sampSendChat("/me достал из мед.сумки лекарство и бутылочку воды")
          wait(2000)
		  sampSendChat('/me передал лекарство и бутылочку воды '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
		  wait(1100)
		  sampSendChat("/heal "..id) 
		  end
      },
	  {
        title = '{80a4bf}» {ffffff}Справка',
        onclick = function()
		sampSendChat("/do На столе стоит ящик с мед.картами и неврологическим молоточком.")
        wait(3000)
        sampSendChat(" Имеете ли Вы жалобы на здоровье?")
        wait(3000)
        sampSendChat("/do В левой руке чёрная ручка.")
        wait(3000)
        sampSendChat("/me сделал запись в мед.карте")
        wait(3000)
        sampSendChat("/me достал из ящика неврологический молоточек")
        wait(3000)
        sampSendChat("Присаживайтесь, начнем обследование.")
        wait(3000)
        sampSendChat("/me достал из ящика неврологический молоточек")
        wait(3000)
        sampSendChat('/me водит молоточком перед глазами '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
        wait(3000)
        sampSendChat("/me убедился, что зрачки движутся содружественно и рефлекс в норме")
        wait(3000)
        sampSendChat("/me сделал запись в мед.карте")
        wait(3000)
        sampSendChat('/me ударил молоточком по левому колену '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
        wait(3000)
        sampSendChat('/me ударил молоточком по правому колену '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
        wait(3000)
		sampSendChat("/checkheal "..id)
		end
      },
	  {
        title = '{ffffff}» Обработка ватки нашатырём',
        onclick = function()
        sampSendChat("/me открыл аптечку")
        wait(3000) 
        sampSendChat("/me достал из аптечки ватку и нашатырь")
        wait(3000) 
        sampSendChat("/me обработал ватку нашатырем, после чего поднес к носу пострадавшего")
        wait(3000) 
        sampSendChat("/me водит ваткой вокруг носа")
        wait(3000) 
        sampSendChat("Не волнуйтесь, у вас случился в обморок.")
        wait(3000) 
        sampSendChat("Сейчас мы доставим вас в больницу, где разберемся с причиной данного недуга.") 
		end
      },
	  {
        title = '{80a4bf}» {ffffff}Лечение от наркозависимости',
        onclick = function()
		sampSendChat("/do Через плечо врача накинута мед.сумка на ремне.")
        wait(2000)
        sampSendChat("/me достал из мед.сумки шприц.")
		wait(2000)
		sampSendChat("/do Шприц в левой руке.")
		wait(2000)
		sampSendChat('/me обработал ватой место укола на вене '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
        wait(2000)
		sampSendChat('/me аккуратным движением вводит препарат в вену '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
        wait(2000)
		sampSendChat("/todo Ну вот и всё*вытащив шприц из вены и приложив вату к месту укола.")
        wait(2000)
        sampSendChat("/healaddict " .. id .. "  10000")
		end
      }
    }
end
function renmenu(args)
    return
    {
      {
        title = '{5b83c2}« Список процедур »',
        onclick = function()
        end
      },
      {
        title = '{ffffff}» Рентгеновский аппарат',
        onclick = function()
        sampSendChat("Ложитесь на кушетку и лежите смирно.")
        wait(3000) 
        sampSendChat("/me включил рентгеновский аппарат")
        wait(3000) 
        sampSendChat("/do Рентгеновский аппарат зашумел.")
        wait(3000) 
        sampSendChat("/me провел рентгеновским аппаратом по поврежденному участку")
        wait(3000) 
        sampSendChat("/me рассматривает снимок")
        wait(3000) 
        sampSendChat("/try обнаружил перелом") 
		end
      },
      {
        title = '{5b83c2}« Если у пациента перелом конечностей »',
        onclick = function()
        end
      },
      {
        title = '{ffffff}» Перелом конечностей',
        onclick = function()
        sampSendChat("Садитесь на кушетку.")
        wait(3000) 
        sampSendChat("/me взял со стола перчатки и надел их")
        wait(3000) 
        sampSendChat("/do Рентгеновский аппарат зашумел.")
        wait(3000) 
        sampSendChat("/me взял шприц с обезбаливающим, после чего обезболил поврежденный участок")
        wait(3000) 
        sampSendChat("/me провел репозицию поврежденного участка")
        wait(3000) 
        sampSendChat("/me подготовил гипсовый пороошок")
        wait(3000) 
        sampSendChat("/me раскатил бинт вдоль стола, после чего втер гипсовый раствор")
        wait(3000) 
        sampSendChat("/me свернул бинт, после чего зафиксировал перелом")
        wait(3000) 
        sampSendChat("Приходите через месяц. Всего доброго!")
        wait(3000) 
        sampSendChat("/me снял перчатки и бросил их в урну возле стола") 
		end
      },
      {
        title = '{5b83c2}« Если у пациента перелом позвоночника/ребер »',
        onclick = function()
        end
      },
      {
        title = '{ffffff}» Перелом позвоночника/ребер',
        onclick = function()
        sampSendChat("/me осторожно уклал пострадавшего на операционный стол")
        wait(3000) 
        sampSendChat("/me взял со стола перчатки и надел их")
        wait(3000) 
        sampSendChat("/me подключил пострадавшего к капельнице")
        wait(3000) 
        sampSendChat("/me намочил ватку спиртом и обработал кожу на руке пациента")
        wait(3000) 
        sampSendChat("/me внутривенно ввел Фторотан")
        wait(3000) 
        sampSendChat("/do Наркоз начинает действовать, пациент потерял сознание.")
        wait(3000) 
        sampSendChat("/me достал скальпель и пинцет")
        wait(3000) 
        sampSendChat("/me с помощью различных инструментов произвел репозицию поврежденного участка")
        wait(3000) 
        sampSendChat("/me достал из тумбочки специальный корсет")
        wait(3000) 
        sampSendChat("/me зафиксировал поврежденный участок с помощью карсета")
        wait(3000) 
        sampSendChat("/me снял перчатки и бросил их в урну возле стола")
        wait(3000) 
        sampSendChat("/me убрал в отдельный контейнер грязный инструментарий")
        wait(3000) 
        sampSendChat("/do Прошло некоторое время, пациент пришел в сознание.") 
		end
      },
      {
        title = '{5b83c2}« Если у пациента глубокий порез »',
        onclick = function()
        end
      },
      {
        title = '{ffffff}» Глубокий порез',
        onclick = function()
        sampSendChat("/me взял со стола перчатки и надел их")
        wait(3000) 
        sampSendChat("/me провел осмотр пациента")
        wait(3000) 
        sampSendChat("/me определил степень тяжести пореза у пациента")
        wait(3000) 
        sampSendChat("/me обезболил поврежденный участок")
        wait(3000) 
        sampSendChat("/me достал из мед. сумки жгут и наложил его поверх повреждения")
        wait(3000) 
        sampSendChat("/me разложил хирургические инструменты на столе")
        wait(3000) 
        sampSendChat("/me взял специальные иглу и нити")
        wait(3000) 
        sampSendChat("/me зашил кровеносный сосуд и проверил пульс")
        wait(3000) 
        sampSendChat("/me протер кровь и зашил место пореза")
        wait(3000) 
        sampSendChat("/me отложил иглу и нити в сторону")
        wait(3000) 
        sampSendChat("/me снял жгут, взял бинты и перебинтовал поврежденный участок кожи")
        wait(3000) 
        sampSendChat("До свадьбы заживет, удачного дня, не болейте.")
        wait(3000) 
        sampSendChat("/me убрал в отдельный контейнер грязный инструментарий") 
		end
      },
    }
end
function priziv(id)
    return
    {
	  {
        title = '{80a4bf}» {ffffff}Приветствие',
        onclick = function()
		sampSendChat("Добрый день, приветствую вас на призыве.")
        wait(2000)
		sampSendChat("Будте добры предоставить документы потверждающии вашу личность.")
        wait(2000)
		end
      },
	  {
        title = '{80a4bf}» {ffffff}Паспорт(РП)',
        onclick = function()
		sampSendChat("/me протянул левую руку и взял паспорт у человека на против.")
        wait(3000)
		sampSendChat("/do Паспорт в левой руке.")
        wait(3000)
		sampSendChat("/me открыл паспорт на нужной странице и запомнил данные человека.")
        wait(3000)
		sampSendChat("/me закрыл паспорт.")
        wait(3000)
		sampSendChat("/do Паспорт закрыт.")
        wait(3000)
		sampSendChat("/me вернул паспорт человеку на против.")
        wait(3000)
		end
      },
	  {
        title = '{80a4bf}» {ffffff}Проверка на призыве',
        onclick = function()
		sampSendChat("- Хорошо. Сейчас мы проверим Вас на наличие наркозависимости.")
        wait(3000)
        sampSendChat("/do Через плечо врача накинута мед.сумка на ремне.")
        wait(3000)
        sampSendChat("/me достал из мед.сумки вату, спирт, шприц и специальную колбочку")
        wait(3000)
        sampSendChat("/me пропитал вату спиртом")
        wait(3000)
        sampSendChat("/do Пропитанная спиртом вата в левой руке.")
        wait(3000)
        sampSendChat('/me обработал ватой место укола на вене '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
        wait(3000)
        sampSendChat("/do Шприц и специальная колбочка в правой руке.")
        wait(3000)
        sampSendChat('/me аккуратным движением вводит шприц в вену '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
        wait(3000)
        sampSendChat("/me с помощью шприца взял немного крови для анализа")
        wait(3000)
        sampSendChat("/me перелил кровь из шприца в специальную колбу, затем поместил её в мини-лабораторию")
        wait(1300)
		sampSendChat("/checkheal "..id)
		end
      },
	  {
        title = '{80a4bf}» {ffffff} Годен',
        onclick = function()
		sampSendChat('/do На экране показан отрицательный результат теста крови '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
        wait(3000)
        sampSendChat("/me выписал справку о том, что пациент не имеет наркозависимости и годен к службе.")
        wait(3000)
		sampSendChat("/me передал справку пациенту в руки")
		wait(3000)
		sampSendChat("/do Протянута правая рука со справкой.")
		end
      },
	  {
        title = '{80a4bf}» {ffffff} Не Годен',
        onclick = function()
		sampSendChat('/do На экране показан положительный результат теста крови '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
        wait(3000)
        sampSendChat("Вы имеете наркозависимость.Пройдите сеанс от зависимости у нарколога.")
        wait(3000)
		sampSendChat("/me поставил печать 'Не годен' на мед.карту призывника")
		end
      }
    }
end
function virus(id)
    return
    {
	  {
        title = '{80a4bf}» {ffffff}Приветствие',
        onclick = function()
		sampSendChat("Добрый день,сейчас мы проведем вам тест на вирус.")
        wait(7000)
		sampSendChat("Вы не против если я вам задам несколько вопросов?")
        wait(10000)
		sampSendChat("Были-ли у вас симпомы в данном месяце,такие как головокружение, тошнота, сонливость?")
        wait(15000)
		sampSendChat("Хорошо.")
		end
      },
	  {
        title = '{80a4bf}» {ffffff}Проверка температуры',
        onclick = function()
		sampSendChat("/do На полу стоит Медицинская сумка.")
        wait(10000)
        sampSendChat("/me открыл мед.сумку .")
        wait(10000)
        sampSendChat("/do Мед.сумка открыта.")
        wait(10000)
        sampSendChat("/me достал из мед.сумки электронный градусник.")
        wait(10000)
        sampSendChat("/do Электронный градусник в левой руке.")
        wait(10000)
        sampSendChat("/me передал электронный градусник человеку на против.")
        wait(10000)
        sampSendChat("Возьмите, градусник и поставьте его под подмышку.")
        wait(10000)
        sampSendChat("Хорошо, давайте немного подождем.")
        wait(10000)
        sampSendChat("Все давайте градусник мне.")
        wait(10000)
        sampSendChat("/me взял градусник у человека на против и посмотрел температуру.")
        wait(10000)
        sampSendChat("/do Температура 36.6")
        wait(10000)
        sampSendChat("Хорошо, с температурой у вас все хорошо.")
		end
      },
	  {
        title = '{80a4bf}» {ffffff}Проверка температуры(немного заболел)',
        onclick = function()
		sampSendChat("/do На полу стоит Медицинская сумка.")
        wait(10000)
        sampSendChat("/me открыл мед.сумку .")
        wait(10000)
        sampSendChat("/do Мед.сумка открыта.")
        wait(10000)
        sampSendChat("/me достал из мед.сумки электронный градусник.")
        wait(10000)
        sampSendChat("/do Электронный градусник в левой руке.")
        wait(10000)
        sampSendChat("/me передал электронный градусник человеку на против.")
        wait(10000)
        sampSendChat("Возьмите, градусник и поставьте его под подмышку")
        wait(10000)
        sampSendChat("Хорошо, давайте немного подождем.")
        wait(10000)
        sampSendChat("Все давайте градусник мне.")
        wait(10000)
        sampSendChat("/me взял градусник у человека на против и посмотрел температуру.")
        wait(10000)
        sampSendChat("/do Температура 36.7")
        wait(10000)
        sampSendChat("Походу вы немножко простудились, но в этом нет ничего страшного.")
		end
      },
	  {
        title = '{80a4bf}» {ffffff} Взятие крови',
        onclick = function()
		sampSendChat("/me достал из мед.сумки вату, спирт, шприц и специальную колбочку.")
        wait(10000)
        sampSendChat("/me пропитал вату спиртом")
        wait(10000)
        sampSendChat("/do Пропитанная спиртом вата в левой руке.")
        wait(10000)
        sampSendChat('/me обработал ватой место укола на вене пациента.')
        wait(10000)
        sampSendChat("/do Шприц и специальная колбочка в правой руке.")
        wait(10000)
        sampSendChat('/me аккуратным движением вводит шприц в вену.')
        wait(10000)
        sampSendChat("/me с помощью шприца взял немного крови для анализа.")
        wait(10000)
        sampSendChat("/me перелил кровь из шприца в специальную колбу.")
        wait(10000)
        sampSendChat("/me закрыл колбу крышкой.")
        wait(10000)
        sampSendChat("Готово, теперь ожидайте результаты анализа.")
        wait(10000)
		end
      }
    }
end

function infomoh(arg)
	sampAddChatMessage("{9966cc} Medick Helper {ffffff}| На данный момент лидером Ministry of Health является - {139BEC}Ruslan Wolhovsky", 0xFFFFFF)
	sampAddChatMessage("{9966cc} Medick Helper {ffffff}| {139BEC}Ministry of Health {FFFFFF}сотрудничает с депутатом {139BEC}Maxik Chest", 0xFFFFFF)
	sampAddChatMessage("{9966cc} Medick Helper {ffffff}| Для людей, проживающих в штате менее 6-ти лет - {139BEC}лечение бесплатное", 0xFFFFFF)
end

function getFraktionBySkin(playerid)
    fraks = {
        [0] = 'Гражданский',
        [1] = 'Гражданский',
        [2] = 'Гражданский',
        [3] = 'Гражданский',
        [4] = 'Гражданский',
        [5] = 'Гражданский',
        [6] = 'Гражданский',
        [7] = 'Гражданский',
        [8] = 'Гражданский',
        [9] = 'Гражданский',
        [10] = 'Гражданский',
        [11] = 'Гражданский',
        [12] = 'Гражданский',
        [13] = 'Гражданский',
        [14] = 'Гражданский',
        [15] = 'Гражданский',
        [16] = 'Гражданский',
        [17] = 'Гражданский',
        [18] = 'Гражданский',
        [19] = 'Гражданский',
        [20] = 'Гражданский',
        [21] = 'Ballas',
        [22] = 'Гражданский',
        [23] = 'Гражданский',
        [24] = 'Гражданский',
        [25] = 'Гражданский',
        [26] = 'Гражданский',
        [27] = 'Гражданский',
        [28] = 'Гражданский',
        [29] = 'Гражданский',
        [30] = 'Rifa',
        [31] = 'Гражданский',
        [32] = 'Гражданский',
        [33] = 'Гражданский',
        [34] = 'Гражданский',
        [35] = 'Гражданский',
        [36] = 'Гражданский',
        [37] = 'Гражданский',
        [38] = 'Гражданский',
        [39] = 'Гражданский',
        [40] = 'Гражданский',
        [41] = 'Aztec',
        [42] = 'Гражданский',
        [43] = 'Гражданский',
        [44] = 'Aztec',
        [45] = 'Гражданский',
        [46] = 'Гражданский',
        [47] = 'Vagos',
        [48] = 'Aztec',
        [49] = 'Гражданский',
        [50] = 'Гражданский',
        [51] = 'Гражданский',
        [52] = 'Гражданский',
        [53] = 'Гражданский',
        [54] = 'Гражданский',
        [55] = 'Гражданский',
        [56] = 'Grove',
        [57] = 'Мэрия',
        [58] = 'Гражданский',
        [59] = 'Автошкола',
        [60] = 'Гражданский',
        [61] = 'Армия',
        [62] = 'Гражданский',
        [63] = 'Гражданский',
        [64] = 'Гражданский',
        [65] = 'Гражданский', -- над подумать
        [66] = 'Гражданский',
        [67] = 'Гражданский',
        [68] = 'Гражданский',
        [69] = 'Гражданский',
        [70] = 'МОН',
        [71] = 'Гражданский',
        [72] = 'Гражданский',
        [73] = 'Army',
        [74] = 'Гражданский',
        [75] = 'Гражданский',
        [76] = 'Гражданский',
        [77] = 'Гражданский',
        [78] = 'Гражданский',
        [79] = 'Гражданский',
        [80] = 'Гражданский',
        [81] = 'Гражданский',
        [82] = 'Гражданский',
        [83] = 'Гражданский',
        [84] = 'Гражданский',
        [85] = 'Гражданский',
        [86] = 'Grove',
        [87] = 'Гражданский',
        [88] = 'Гражданский',
        [89] = 'Гражданский',
        [90] = 'Гражданский',
        [91] = 'LS News', -- под вопросом
        [92] = 'Гражданский',
        [93] = 'Гражданский',
        [94] = 'Гражданский',
        [95] = 'Гражданский',
        [96] = 'Гражданский',
        [97] = 'Гражданский',
        [98] = 'Мэрия',
        [99] = 'Гражданский',
        [100] = 'Байкер',
        [101] = 'Гражданский',
        [102] = 'Ballas',
        [103] = 'Ballas',
        [104] = 'Ballas',
        [105] = 'Grove',
        [106] = 'Grove',
        [107] = 'Grove',
        [108] = 'Vagos',
        [109] = 'Vagos',
        [110] = 'Vagos',
        [111] = 'RM',
        [112] = 'RM',
        [113] = 'LCN',
        [114] = 'Aztec',
        [115] = 'Aztec',
        [116] = 'Aztec',
        [117] = 'Yakuza',
        [118] = 'Yakuza',
        [119] = 'Rifa',
        [120] = 'Yakuza',
        [121] = 'Гражданский',
        [122] = 'Гражданский',
        [123] = 'Yakuza',
        [124] = 'LCN',
        [125] = 'RM',
        [126] = 'RM',
        [127] = 'LCN',
        [128] = 'Гражданский',
        [129] = 'Гражданский',
        [130] = 'Гражданский',
        [131] = 'Гражданский',
        [132] = 'Гражданский',
        [133] = 'Гражданский',
        [134] = 'Гражданский',
        [135] = 'Гражданский',
        [136] = 'Гражданский',
        [137] = 'Гражданский',
        [138] = 'Гражданский',
        [139] = 'Гражданский',
        [140] = 'Гражданский',
        [141] = 'FBI',
        [142] = 'Гражданский',
        [143] = 'Гражданский',
        [144] = 'Гражданский',
        [145] = 'Гражданский',
        [146] = 'Гражданский',
        [147] = 'Мэрия',
        [148] = 'Гражданский',
        [149] = 'Grove',
        [150] = 'Мэрия',
        [151] = 'Гражданский',
        [152] = 'Гражданский',
        [153] = 'Гражданский',
        [154] = 'Гражданский',
        [155] = 'Гражданский',
        [156] = 'Гражданский',
        [157] = 'Гражданский',
        [158] = 'Гражданский',
        [159] = 'Гражданский',
        [160] = 'Гражданский',
        [161] = 'Гражданский',
        [162] = 'Гражданский',
        [163] = 'FBI',
        [164] = 'FBI',
        [165] = 'FBI',
        [166] = 'FBI',
        [167] = 'Гражданский',
        [168] = 'Гражданский',
        [169] = 'Yakuza',
        [170] = 'Гражданский',
        [171] = 'Гражданский',
        [172] = 'Гражданский',
        [173] = 'Rifa',
        [174] = 'Rifa',
        [175] = 'Rifa',
        [176] = 'Гражданский',
        [177] = 'Гражданский',
        [178] = 'Гражданский',
        [179] = 'Army',
        [180] = 'Гражданский',
        [181] = 'Байкер',
        [182] = 'Гражданский',
        [183] = 'Гражданский',
        [184] = 'Гражданский',
        [185] = 'Гражданский',
        [186] = 'Yakuza',
        [187] = 'Мэрия',
        [188] = 'СМИ',
        [189] = 'Гражданский',
        [190] = 'Vagos',
        [191] = 'Army',
        [192] = 'Гражданский',
        [193] = 'Aztec',
        [194] = 'Гражданский',
        [195] = 'Ballas',
        [196] = 'Гражданский',
        [197] = 'Гражданский',
        [198] = 'Гражданский',
        [199] = 'Гражданский',
        [200] = 'Гражданский',
        [201] = 'Гражданский',
        [202] = 'Гражданский',
        [203] = 'Гражданский',
        [204] = 'Гражданский',
        [205] = 'Гражданский',
        [206] = 'Гражданский',
        [207] = 'Гражданский',
        [208] = 'Yakuza',
        [209] = 'Гражданский',
        [210] = 'Гражданский',
        [211] = 'СМИ',
        [212] = 'Гражданский',
        [213] = 'Гражданский',
        [214] = 'LCN',
        [215] = 'Гражданский',
        [216] = 'Гражданский',
        [217] = 'СМИ',
        [218] = 'Гражданский',
        [219] = 'МОН',
        [220] = 'Гражданский',
        [221] = 'Гражданский',
        [222] = 'Гражданский',
        [223] = 'LCN',
        [224] = 'Гражданский',
        [225] = 'Гражданский',
        [226] = 'Rifa',
        [227] = 'Мэрия',
        [228] = 'Гражданский',
        [229] = 'Гражданский',
        [230] = 'Гражданский',
        [231] = 'Гражданский',
        [232] = 'Гражданский',
        [233] = 'Гражданский',
        [234] = 'Гражданский',
        [235] = 'Гражданский',
        [236] = 'Гражданский',
        [237] = 'Гражданский',
        [238] = 'Гражданский',
        [239] = 'Гражданский',
        [240] = 'Автошкола',
        [241] = 'Гражданский',
        [242] = 'Гражданский',
        [243] = 'Гражданский',
        [244] = 'Гражданский',
        [245] = 'Гражданский',
        [246] = 'Байкер',
        [247] = 'Байкер',
        [248] = 'Байкер',
        [249] = 'Гражданский',
        [250] = 'СМИ',
        [251] = 'Гражданский',
        [252] = 'Army',
        [253] = 'Гражданский',
        [254] = 'Байкер',
        [255] = 'Army',
        [256] = 'Гражданский',
        [257] = 'Гражданский',
        [258] = 'Гражданский',
        [259] = 'Гражданский',
        [260] = 'Гражданский',
        [261] = 'СМИ',
        [262] = 'Гражданский',
        [263] = 'Гражданский',
        [264] = 'Гражданский',
        [265] = 'Полиция',
        [266] = 'Полиция',
        [267] = 'Полиция',
        [268] = 'Гражданский',
        [269] = 'Grove',
        [270] = 'Grove',
        [271] = 'Grove',
        [272] = 'RM',
        [273] = 'Гражданский', -- надо подумать
        [274] = 'МОН',
        [275] = 'МОН',
        [276] = 'МОН',
        [277] = 'Гражданский',
        [278] = 'Гражданский',
        [279] = 'Гражданский',
        [280] = 'Полиция',
        [281] = 'Полиция',
        [282] = 'Полиция',
        [283] = 'Полиция',
        [284] = 'Полиция',
        [285] = 'Полиция',
        [286] = 'FBI',
        [287] = 'Army',
        [288] = 'Полиция',
        [289] = 'Гражданский',
        [290] = 'Гражданский',
        [291] = 'Гражданский',
        [292] = 'Aztec',
        [293] = 'Гражданский',
        [294] = 'Гражданский',
        [295] = 'Гражданский',
        [296] = 'Гражданский',
        [297] = 'Grove',
        [298] = 'Гражданский',
        [299] = 'Гражданский',
        [300] = 'Полиция',
        [301] = 'Полиция',
        [302] = 'Полиция',
        [303] = 'Полиция',
        [304] = 'Полиция',
        [305] = 'Полиция',
        [306] = 'Полиция',
        [307] = 'Полиция',
        [308] = 'МОН',
        [309] = 'Полиция',
        [310] = 'Полиция',
        [311] = 'Полиция'
    }
    if sampIsPlayerConnected(playerid) then
        local result, handle = sampGetCharHandleBySampPlayerId(playerid)
        local skin = getCharModel(handle)
        return fraks[skin]
    end
end

function a.onSendClickPlayer(id)
	if rank == 'Стажер' or rank == 'Консультант' or rank == 'Мл.Инструктор' or rank == 'Инструктор' or rank == 'Доктор' or rank == 'Психолог' or rank == 'Хирург' or rank == 'Зам.Глав.Врача' or rank == 'Глав.Врач' then
    setClipboardText(sampGetPlayerNickname(id))
	ftext('Ник скопирован в буфер обмен.')
	else
	end
end

function smsjob()
  if rank == 'Психолог' or rank == 'Хирург' or rank == 'Зам.Глав.Врача' or  rank == 'Глав.Врач' then
    lua_thread.create(function()
        vixodid = {}
		status = true
		sampSendChat('/members')
        while not gotovo do wait(0) end
        wait(1200)
        for k, v in pairs(vixodid) do
            sampSendChat('/sms '..v..' Приветствую, на работу, у вас 15 минут')
            wait(1200)
        end
        players2 = {'{ffffff}Ник\t{ffffff}Ранг\t{ffffff}Статус'}
		players1 = {'{ffffff}Ник\t{ffffff}Ранг'}
		gotovo = false
        status = false
        vixodid = {}
	end)
	else
	ftext('Данная команда доступна с 7 ранга')
	end
end

function update()
    local updatePath = os.getenv('TEMP')..'\\Update.json'
    -- Проверка новой версии
    downloadUrlToFile("https://raw.githubusercontent.com/RusWolhovsky/Medick_Helper_Ruslan_Wolhovsky.lua/main/update.json", updatePath, function(id, status, p1, p2)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            local file = io.open(updatePath, 'r')
            if file and doesFileExist(updatePath) then
                local info = decodeJson(file:read("*a"))
                file:close(); os.remove(updatePath)
                if info.version ~= thisScript().version then
                    lua_thread.create(function()
                        wait(2000)
                        -- Загрузка скрипта, если версия изменилась
                        downloadUrlToFile("https://raw.githubusercontent.com/RusWolhovsky/Medick_Helper_Ruslan_Wolhovsky.lua/main/Medick_Helper_Ruslan_Wolhovsky.lua", thisScript().path, function(id, status, p1, p2)
                            if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                                ftext('Обновление до актуальной версии '..info.version..' обнаружено.')
                                thisScript():reload()
                            end
                        end)
                    end)
                else
                    ftext('Обновление не обнаружено. Актуальная версия '..info.version..'.', -1)
                end
            end
        end
    end)
end

function cmd_color() -- функция получения цвета строки, хз зачем она мне, но когда то юзал
	local text, prefix, color, pcolor = sampGetChatString(99)
	sampAddChatMessage(string.format("Цвет последней строки чата - {934054}[%d] (скопирован в буфер обмена)",color),-1)
	setClipboardText(color)
end

function getcolor(id)
local colors =
        {
		[1] = 'Зелёный',
		[2] = 'Светло-зелёный',
		[3] = 'Ярко-зелёный',
		[4] = 'Бирюзовый',
		[5] = 'Жёлто-зелёный',
		[6] = 'Темно-зелёный',
		[7] = 'Серо-зелёный',
		[8] = 'Красный',
		[9] = 'Ярко-красный',
		[10] = 'Оранжевый',
		[11] = 'Коричневый',
		[12] = 'Тёмно-красный',
		[13] = 'Серо-красный',
		[14] = 'Жёлто-оранжевый',
		[15] = 'Малиновый',
		[16] = 'Розовый',
		[17] = 'Синий',
		[18] = 'Голубой',
		[19] = 'Синяя сталь',
		[20] = 'Сине-зелёный',
		[21] = 'Тёмно-синий',
		[22] = 'Фиолетовый',
		[23] = 'Индиго',
		[24] = 'Серо-синий',
		[25] = 'Жёлтый',
		[26] = 'Кукурузный',
		[27] = 'Золотой',
		[28] = 'Старое золото',
		[29] = 'Оливковый',
		[30] = 'Серый',
		[31] = 'Серебро',
		[32] = 'Черный',
		[33] = 'Белый',
		}
	return colors[id]
end
function sampev.onSendSpawn()
    pX, pY, pZ = getCharCoordinates(playerPed)
    if cfg.main.clistb and getDistanceBetweenCoords3d(pX, pY, pZ, 2337.3574,1666.1699,3040.9524) < 20 then
        lua_thread.create(function()
            wait(1200)
			sampSendChat('/clist '..tonumber(cfg.main.clist))
			wait(500)
			local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
			local color = ("%06X"):format(bit.band(sampGetPlayerColor(myid), 0xFFFFFF))
			colors = getcolor(cfg.main.clist)
            ftext('Цвет ника сменен на: {'..color..'}'..cfg.main.clist..' ['..colors..']')
        end)
    end
end
-- Тест dmb n
-- Тест dmb z
function sampev.onServerMessage(color, text)
        if text:find('Рабочий день начат') and color ~= -1 then
        if cfg.main.clistb then
		if rabden == false then
            lua_thread.create(function()
                wait(100)
				sampSendChat('/clist '..tonumber(cfg.main.clist))
				wait(500)
                local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
			    local color = ("%06X"):format(bit.band(sampGetPlayerColor(myid), 0xFFFFFF))
                colors = getcolor(cfg.main.clist)
                ftext('Цвет ника сменен на: {'..color..'}'..cfg.main.clist..' ['..colors..']')
                rabden = true
				wait(1000)
				if cfg.main.clisto then
				local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
                local myname = sampGetPlayerNickname(myid)
				if cfg.main.male == true then
				sampSendChat("/me открыл шкафчик")
                wait(3000)
                sampSendChat("/me снял свою одежду, после чего сложил ее в шкаф")
                wait(3000)
                sampSendChat("/me взял рабочую одежду, затем переоделся в нее")
                wait(3000)
                sampSendChat("/me нацепил бейджик на рубашку")
                wait(3000)
                sampSendChat('/do На рубашке бейджик с надписью "'..rank..' | '..myname:gsub('_', ' ')..'".')
				end
				if cfg.main.male == false then
				sampSendChat("/me открыла шкафчик")
                wait(3000)
                sampSendChat("/me сняла свою одежду, после чего сложила ее в шкаф")
                wait(3000)
                sampSendChat("/me взяла рабочую одежду, затем переоделась в нее")
                wait(3000)
                sampSendChat("/me нацепила бейджик на рубашку")
                wait(3000)
                sampSendChat('/do На рубашке бейджик с надписью "'..rank..' | '..myname:gsub('_', ' ')..'".')
				end
			end
            end)
        end
	  end
    end
	if text:find('SMS:') and text:find('Отправитель:') then
		wordsSMS, nickSMS = string.match(text, 'SMS: (.+) Отправитель: (.+)');
		local idsms = nickSMS:match('.+%[(%d+)%]')
		lastnumber = idsms
	end
    if text:find('Рабочий день окончен') and color ~= -1 then
        rabden = false
    end
	if text:find('Вы вылечили') then
        local Nicks = text:match('Вы вылечили Игрока (.+) .')
		health = health + 1
   end
   	if text:find('сеанс лечения от наркозависимости') then
        local Nicks = text:match('Вы вылечили игрока (.+) от наркозависимости.')
		narkoh = narkoh + 1
   end
	if text:find('Вы выгнали (.+) из организации. Причина: (.+)') then
        local un1, un2 = text:match('Вы выгнали (.+) из организации. Причина: (.+)')
		lua_thread.create(function()
		wait(3000)
		if cfg.main.tarb then
        sampSendChat(string.format('/r [%s]: %s - Уволен по причине "%s".', cfg.main.tarr, un1:gsub('_', ' '), un2))
        else
		sampSendChat(string.format('/r %s - Уволен по причине "%s".', un1:gsub('_', ' '), un2))
		end
		end)
    end
	if text:find('передал(- а) удостоверение (.+)') then
        local inv1 = text:match('передал(- а) удостоверение (.+)')
		lua_thread.create(function()
		wait(3000)
		if cfg.main.tarb then
        sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - %s новый сотрудник коллектива автошколы. Приветствуем! %s%s', cfg.main.tarr, inv1:gsub('_', ' ')))
        else
		sampSendChat(string.format('/r %s - новый сотрудник коллектива автошколы. Приветствуем! %s%s', inv1:gsub('_', ' ')))
		end
		end)
    end
	if color == -8224086 then
        local colors = ('{%06X}'):format(bit.rshift(color, 8))
        table.insert(departament, os.date(colors..'[%H:%M:%S] ') .. text)
    end
	if color == -1920073984 and (text:match('.+ .+%: .+') or text:match('%(%( .+ .+%: .+ %)%)')) then
            local colors = ("{%06X}"):format(bit.rshift(color, 8))
            table.insert(radio, os.date(colors.."[%H:%M:%S] ") .. text)
        end
	if color == -65366 and (text:match('SMS%: .+. Отправитель%: .+') or text:match('SMS%: .+. Получатель%: .+')) then
            local colors = ("{%06X}"):format(bit.rshift(color, 8))
            table.insert(smslogs, os.date(colors.."[%H:%M:%S] ") .. text)
        end
	if statusc then
		if text:match('ID: .+ | .+: .+ %- .+') and not fstatus then
			gosmb = true
			local id, nick, rang, stat = text:match('ID: (%d+) | (.+): (.+) %- (.+)')
			local color = ("%06X"):format(bit.band(sampGetPlayerColor(id), 0xFFFFFF))
		    src_good = ""
            src_bad = ""
			local _, myid = sampGetPlayerIdByCharHandle(playerPed)
			local _, handle = sampGetCharHandleBySampPlayerId(id)
			local myname = sampGetPlayerNickname(myid)
				if doesCharExist(handle) then
					local x, y, z = getCharCoordinates(handle)
					local mx, my, mz = getCharCoordinates(PLAYER_PED)
					local dist = getDistanceBetweenCoords3d(mx, my, mz, x, y, z)

					if dist <= 50 then
						src_good = src_good ..sampGetPlayerNickname(id).. ""
					end
					else
						src_bad = src_bad ..sampGetPlayerNickname(id).. ""
			if src_bad ~= myname then
			table.insert(players3, string.format('{'..color..'}%s[%s]{ffffff}\t%s\t%s', src_bad, id, rang, stat))
			return false
		end
		end
		end
		if text:match('Всего: %d+ человек') then
			local count = text:match('Всего: (%d+) человек')
			gcount = count
			gotovo = true
			return false
		end
		if color == -1 then
			return false
		end
		if color == 647175338 then
			return false
        end
        if text:match('ID: .+ | .+: .+') and not fstatus then
			krimemb = true
			local id, nick, rang = text:match('ID: (%d+) | (.+): (.+)')
			local color = ("%06X"):format(bit.band(sampGetPlayerColor(id), 0xFFFFFF))
			table.insert(players1, string.format('{'..color..'}%s[%s]{ffffff}\t%s', nick, id, rang))
			return false
        end
    end
	if status then
		if text:match('ID: .+ | .+ | .+: .+ %- .+') and not fstatus then
			gosmb = true
			local id, data, nick, rang, stat = text:match('ID: (%d+) | (.+) | (.+): (.+) %- (.+)')
			local color = ("%06X"):format(bit.band(sampGetPlayerColor(id), 0xFFFFFF))
			local nmrang = rang:match('.+%[(%d+)%]')
            if stat:find('Выходной') and tonumber(nmrang) < 7 then
                table.insert(vixodid, id)
            end
			table.insert(players2, string.format('{ffffff}%s\t {'..color..'}%s[%s]{ffffff}\t%s\t%s', data, nick, id, rang, stat))
			return false
		end
		if text:match('Всего: %d+ человек') then
			local count = text:match('Всего: (%d+) человек')
			gcount = count
			gotovo = true
			return false
		end
		if color == -1 then
			return false
		end
		if color == 647175338 then
			return false
        end
        if text:match('ID: .+ | .+: .+') and not fstatus then
			krimemb = true
			local id, nick, rang = text:match('ID: (%d+) | (.+): (.+)')
			local color = ("%06X"):format(bit.band(sampGetPlayerColor(id), 0xFFFFFF))
			table.insert(players1, string.format('{'..color..'}%s[%s]{ffffff}\t%s', nick, id, rang))
			return false
        end
    end
end
function getZones(zone)
    local names = {
      ['SUNMA'] = 'Bayside Marina',
      ['SUNNN'] = 'Bayside',
      ['BATTP'] = 'Battery Point',
      ['PARA'] = 'Paradiso',
      ['CIVI'] = 'Santa Flora',
      ['BAYV'] = 'Palisades',
      ['CITYS'] = 'City Hall',
      ['OCEAF'] = 'Ocean Flats',
      ['HASH'] = 'Hashbury',
      ['JUNIHO'] = 'Juniper Hollow',
      ['ESPN'] = 'Esplanade North',
      ['FINA'] = 'Financial',
      ['CALT'] = 'Calton Heights',
      ['SFDWT'] = 'Downtown',
      ['JUNIHI'] = 'Juniper Hill',
      ['CHINA'] = 'Chinatown',
      ['THEA'] = 'King`s',
      ['GARC'] = 'Garcia',
      ['DOH'] = 'Doherty',
      ['SFAIR'] = 'Easter Bay Airport',
      ['EASB'] = 'Easter Basin',
      ['ESPE'] = 'Esplanade East',
      ['ANGPI'] = 'Angel Pine',
      ['SHACA'] = 'Shady Cabin',
      ['BACKO'] = 'Back o Beyond',
      ['LEAFY'] = 'Leafy Hollow',
      ['FLINTR'] = 'Flint Range',
      ['HAUL'] = 'Fallen Tree',
      ['FARM'] = 'The Farm',
      ['ELQUE'] = 'El Quebrados',
      ['ALDEA'] = 'Aldea Malvada',
      ['DAM'] = 'The Sherman Dam',
      ['BARRA'] = 'Las Barrancas',
      ['CARSO'] = 'Fort Carson',
      ['QUARY'] = 'Hunter Quarry',
      ['OCTAN'] = 'Octane Springs',
      ['PALMS'] = 'Green Palms',
      ['TOM'] = 'Regular Tom',
      ['BRUJA'] = 'Las Brujas',
      ['MEAD'] = 'Verdant Meadows',
      ['PAYAS'] = 'Las Payasadas',
      ['ARCO'] = 'Arco del Oeste',
      ['HANKY'] = 'Hankypanky Point',
      ['PALO'] = 'Palomino Creek',
      ['NROCK'] = 'North Rock',
      ['MONT'] = 'Montgomery',
      ['HBARNS'] = 'Hampton Barns',
      ['FERN'] = 'Fern Ridge',
      ['DILLI'] = 'Dillimore',
      ['TOPFA'] = 'Hilltop Farm',
      ['BLUEB'] = 'Blueberry',
      ['PANOP'] = 'The Panopticon',
      ['FRED'] = 'Frederick Bridge',
      ['MAKO'] = 'The Mako Span',
      ['BLUAC'] = 'Blueberry Acres',
      ['MART'] = 'Martin Bridge',
      ['FALLO'] = 'Fallow Bridge',
      ['CREEK'] = 'Shady Creeks',
      ['WESTP'] = 'Queens',
      ['LA'] = 'Los Santos',
      ['VE'] = 'Las Venturas',
      ['BONE'] = 'Bone County',
      ['ROBAD'] = 'Tierra Robada',
      ['GANTB'] = 'Gant Bridge',
      ['SF'] = 'San Fierro',
      ['RED'] = 'Red County',
      ['FLINTC'] = 'Flint County',
      ['EBAY'] = 'Easter Bay Chemicals',
      ['SILLY'] = 'Foster Valley',
      ['WHET'] = 'Whetstone',
      ['LAIR'] = 'Los Santos International',
      ['BLUF'] = 'Verdant Bluffs',
      ['ELCO'] = 'El Corona',
      ['LIND'] = 'Willowfield',
      ['MAR'] = 'Marina',
      ['VERO'] = 'Verona Beach',
      ['CONF'] = 'Conference Center',
      ['COM'] = 'Commerce',
      ['PER1'] = 'Pershing Square',
      ['LMEX'] = 'Little Mexico',
      ['IWD'] = 'Idlewood',
      ['GLN'] = 'Glen Park',
      ['JEF'] = 'Jefferson',
      ['CHC'] = 'Las Colinas',
      ['GAN'] = 'Ganton',
      ['EBE'] = 'East Beach',
      ['ELS'] = 'East Los Santos',
      ['JEF'] = 'Jefferson',
      ['LFL'] = 'Los Flores',
      ['LDT'] = 'Downtown Los Santos',
      ['MULINT'] = 'Mulholland Intersection',
      ['MUL'] = 'Mulholland',
      ['MKT'] = 'Market',
      ['VIN'] = 'Vinewood',
      ['SUN'] = 'Temple',
      ['SMB'] = 'Santa Maria Beach',
      ['ROD'] = 'Rodeo',
      ['RIH'] = 'Richman',
      ['STRIP'] = 'The Strip',
      ['DRAG'] = 'The Four Dragons Casino',
      ['PINK'] = 'The Pink Swan',
      ['HIGH'] = 'The High Roller',
      ['PIRA'] = 'Pirates in Men`s Pants',
      ['VISA'] = 'The Visage',
      ['JTS'] = 'Julius Thruway South',
      ['JTW'] = 'Julius Thruway West',
      ['RSE'] = 'Rockshore East',
      ['LOT'] = 'Come-A-Lot',
      ['CAM'] = 'The Camel`s Toe',
      ['ROY'] = 'Royal Casino',
      ['CALI'] = 'Caligula`s Palace',
      ['PILL'] = 'Pilgrim',
      ['STAR'] = 'Starfish Casino',
      ['ISLE'] = 'The Emerald Isle',
      ['OVS'] = 'Old Venturas Strip',
      ['KACC'] = 'K.A.C.C. Military Fuels',
      ['CREE'] = 'Creek',
      ['SRY'] = 'Sobell Rail Yards',
      ['LST'] = 'Linden Station',
      ['JTE'] = 'Julius Thruway East',
      ['LDS'] = 'Linden Side',
      ['JTN'] = 'Julius Thruway North',
      ['HGP'] = 'Harry Gold Parkway',
      ['REDE'] = 'Redsands East',
      ['VAIR'] = 'Las Venturas Airport',
      ['LVA'] = 'LVA Freight Depot',
      ['BINT'] = 'Blackfield Intersection',
      ['GGC'] = 'Greenglass College',
      ['BFLD'] = 'Blackfield',
      ['ROCE'] = 'Roca Escalante',
      ['LDM'] = 'Last Dime Motel',
      ['RSW'] = 'Rockshore West',
      ['RIE'] = 'Randolph Industrial Estate',
      ['BFC'] = 'Blackfield Chapel',
      ['PINT'] = 'Pilson Intersection',
      ['WWE'] = 'Whitewood Estates',
      ['PRP'] = 'Prickle Pine',
      ['SPIN'] = 'Spinybed',
      ['SASO'] = 'San Andreas Sound',
      ['FISH'] = 'Fisher`s Lagoon',
      ['GARV'] = 'Garver Bridge',
      ['KINC'] = 'Kincaid Bridge',
      ['LSINL'] = 'Los Santos Inlet',
      ['SHERR'] = 'Sherman Reservoir',
      ['FLINW'] = 'Flint Water',
      ['ETUNN'] = 'Easter Tunnel',
      ['BYTUN'] = 'Bayside Tunnel',
      ['BIGE'] = 'The Big Ear',
      ['PROBE'] = 'Lil` Probe Inn',
      ['VALLE'] = 'Valle Ocultado',
      ['LINDEN'] = 'Linden Station',
      ['UNITY'] = 'Unity Station',
      ['MARKST'] = 'Market Station',
      ['CRANB'] = 'Cranberry Station',
      ['YELLOW'] = 'Yellow Bell Station',
      ['SANB'] = 'San Fierro Bay',
      ['ELCA'] = 'El Castillo del Diablo',
      ['REST'] = 'Restricted Area',
      ['MONINT'] = 'Montgomery Intersection',
      ['ROBINT'] = 'Robada Intersection',
      ['FLINTI'] = 'Flint Intersection',
      ['SFAIR'] = 'Easter Bay Airport',
      ['MKT'] = 'Market',
      ['CUNTC'] = 'Avispa Country Club',
      ['HILLP'] = 'Missionary Hill',
      ['MTCHI'] = 'Mount Chiliad',
      ['YBELL'] = 'Yellow Bell Golf Course',
      ['VAIR'] = 'Las Venturas Airport',
      ['LDOC'] = 'Ocean Docks',
      ['STAR'] = 'Starfish Casino',
      ['BEACO'] = 'Beacon Hill',
      ['GARC'] = 'Garcia',
      ['PLS'] = 'Playa del Seville',
      ['STAR'] = 'Starfish Casino',
      ['RING'] = 'The Clown`s Pocket',
      ['LIND'] = 'Willowfield',
      ['WWE'] = 'Whitewood Estates',
      ['LDT'] = 'Downtown Los Santos'
    }
    if names[zone] == nil then return 'Не определено' end
    return names[zone]
end
function kvadrat()
    local KV = {
        [1] = "А",
        [2] = "Б",
        [3] = "В",
        [4] = "Г",
        [5] = "Д",
        [6] = "Ж",
        [7] = "З",
        [8] = "И",
        [9] = "К",
        [10] = "Л",
        [11] = "М",
        [12] = "Н",
        [13] = "О",
        [14] = "П",
        [15] = "Р",
        [16] = "С",
        [17] = "Т",
        [18] = "У",
        [19] = "Ф",
        [20] = "Х",
        [21] = "Ц",
        [22] = "Ч",
        [23] = "Ш",
        [24] = "Я",
    }
    local X, Y, Z = getCharCoordinates(playerPed)
    X = math.ceil((X + 3000) / 250)
    Y = math.ceil((Y * - 1 + 3000) / 250)
    Y = KV[Y]
    local KVX = (Y.."-"..X)
    return KVX
end