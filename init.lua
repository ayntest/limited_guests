-- Limits guest accounts.

minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	if name:find('[Gg]uest') then
		-- only chat is available (prevents lasting damage)
		minetest.set_player_privs(name, {shout=true})
		-- limit movement speed (don't mapgen too much)
		player:set_physics_override( { speed = 0.9 } )
		-- formspec warning
		local formspec = 'size[6.3,6]'..
		"image[.25,.25;7,5.75;guestwarn.png]"..
		'button_exit[2,5.4;2,1;exit;Close'
		minetest.show_formspec(name, 'warn', formspec)
		--minetest.log('action','Showing warning formspec to '..name)
	end
end)

print('[limited_guests] loaded')
