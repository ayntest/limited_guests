-- Limits guest accounts.

minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	if name:find('[Gg]uest') then
		-- only chat is available (prevents possible lasting damage)
		minetest.set_player_privs(name, {shout=true})
		
		if channels then
			-- set channel
			channels.command_set(name, 'guest')
		end
		
		-- limit movement speed
		player:set_physics_override( { speed = 0.85 } )
		-- formspec warning
		local formspec = 'size[6.3,6]'..
		"image[.25,.25;7,5.75;guestwarn.png]"..
		'button_exit[2,5.4;2,1;exit;Close'
		minetest.show_formspec(name, 'warn', formspec)
		minetest.log('info','Showing warning formspec to '..name)
	end
end)

notification_timer = 0
minetest.register_globalstep(function(dtime)
	notification_timer = notification_timer + dtime
	if notification_timer < 30 then return end
	notification_timer = 0
	for _,player in ipairs(minetest.get_connected_players()) do
		local name = player:get_player_name()
		if name:find('[Gg]uest') then
			minetest.chat_send_player(name, 'Server: In order to start digging and building you should join with a proper name (not starting with Guest)')
		end
	end
end)

print('[Limited guests] loaded')
