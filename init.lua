sprint_mod = {}

-- Konfigurationswerte
local sprint_speed = tonumber(minetest.settings:get("sprint_speed")) or 1.5  -- Ändere den Wert hier auf die gewünschte Sprintgeschwindigkeit

-- Funktion zum Überprüfen des Sprintzustands
local function is_sprinting(player)
    local controls = player:get_player_control()
    return controls.aux1 and not player:get_player_velocity().y ~= 0
end

-- Funktion zum Aktualisieren der Geschwindigkeit
local function update_speed(player)
    if is_sprinting(player) then
        player:set_physics_override({speed = sprint_speed})
    else
        player:set_physics_override({speed = 1.0})
    end
end

-- Mod-Initialisierung
minetest.register_on_joinplayer(function(player)
    -- Bei Spielereintritt die Geschwindigkeit aktualisieren
    update_speed(player)
end)

-- Event-Handler für die Aktualisierung der Geschwindigkeit
minetest.register_globalstep(function(dtime)
    for _, player in ipairs(minetest.get_connected_players()) do
        update_speed(player)
    end
end)
