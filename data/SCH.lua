--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- __________.__                                ________                          __               .__.__  __      __  .__    .__           _____.__.__              
-- \______   |  |   ____ _____    ______ ____   \______ \   ____     ____   _____/  |_    ____   __| _|___/  |_  _/  |_|  |__ |__| ______ _/ ____|__|  |   ____      
--  |     ___|  | _/ __ \\__  \  /  ____/ __ \   |    |  \ /  _ \   /    \ /  _ \   __\ _/ __ \ / __ ||  \   __\ \   __|  |  \|  |/  ___/ \   __\|  |  | _/ __ \     
--  |    |   |  |_\  ___/ / __ \_\___ \\  ___/   |    `   (  <_> ) |   |  (  <_> |  |   \  ___// /_/ ||  ||  |    |  | |   Y  |  |\___ \   |  |  |  |  |_\  ___/     
--  |____|   |____/\___  (____  /____  >\___  > /_______  /\____/  |___|  /\____/|__|    \___  \____ ||__||__|    |__| |___|  |__/____  >  |__|  |__|____/\___  > /\ 
--                     \/     \/     \/     \/          \/              \/                   \/     \/                      \/        \/                      \/  \/ 
--
--	Please do not edit this file!							Please do not edit this file!							Please do not edit this file!
--
--	Editing this file will cause you to be unable to use Github Desktop to update!
--
--	Any changes you wish to make in this file you should be able to make by overloading. That is Re-Defining the same variables or functions in another file, by copying and
--	pasting them to a file that is loaded after the original file, all of my library files, and then job files are loaded first.
--	The last files to load are the ones unique to you. User-Globals, Charactername-Globals, Charactername_Job_Gear, in that order, so these changes will take precedence.
--
--	You may wish to "hook" into existing functions, to add functionality without losing access to updates or fixes I make, for example, instead of copying and editing
--	status_change(), you can instead use the function user_status_change() in the same manner, which is called by status_change() if it exists, most of the important 
--  gearswap functions work like this in my files, and if it's unique to a specific job, user_job_status_change() would be appropriate instead.
--
--  Variables and tables can be easily redefined just by defining them in one of the later loaded files: autofood = 'Miso Ramen' for example.
--  States can be redefined as well: state.HybridMode:options('Normal','PDT') though most of these are already redefined in the gear files for editing there.
--	Commands can be added easily with: user_self_command(commandArgs, eventArgs) or user_job_self_command(commandArgs, eventArgs)
--
--	If you're not sure where is appropriate to copy and paste variables, tables and functions to make changes or add them:
--		User-Globals.lua - 			This file loads with all characters, all jobs, so it's ideal for settings and rules you want to be the same no matter what.
--		Charactername-Globals.lua -	This file loads with one character, all jobs, so it's ideal for gear settings that are usable on all jobs, but unique to this character.
--		Charactername_Job_Gear.lua-	This file loads only on one character, one job, so it's ideal for things that are specific only to that job and character.
--
--
--	If you still need help, feel free to contact me on discord or ask in my chat for help: https://discord.gg/ug6xtvQ
--  !Please do NOT message me in game about anything third party related, though you're welcome to message me there and ask me to talk on another medium.
--
--  Please do not edit this file!							Please do not edit this file!							Please do not edit this file!
-- __________.__                                ________                          __               .__.__  __      __  .__    .__           _____.__.__              
-- \______   |  |   ____ _____    ______ ____   \______ \   ____     ____   _____/  |_    ____   __| _|___/  |_  _/  |_|  |__ |__| ______ _/ ____|__|  |   ____      
--  |     ___|  | _/ __ \\__  \  /  ____/ __ \   |    |  \ /  _ \   /    \ /  _ \   __\ _/ __ \ / __ ||  \   __\ \   __|  |  \|  |/  ___/ \   __\|  |  | _/ __ \     
--  |    |   |  |_\  ___/ / __ \_\___ \\  ___/   |    `   (  <_> ) |   |  (  <_> |  |   \  ___// /_/ ||  ||  |    |  | |   Y  |  |\___ \   |  |  |  |  |_\  ___/     
--  |____|   |____/\___  (____  /____  >\___  > /_______  /\____/  |___|  /\____/|__|    \___  \____ ||__||__|    |__| |___|  |__/____  >  |__|  |__|____/\___  > /\ 
--                     \/     \/     \/     \/          \/              \/                   \/     \/                      \/        \/                      \/  \/ 
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
		Custom commands:

		Shorthand versions for each stratagem type that uses the version appropriate for
		the current Arts.

										Light Arts              Dark Arts

		gs c scholar light              Light Arts/Addendum
		gs c scholar dark                                       Dark Arts/Addendum
		gs c scholar cost               Penury                  Parsimony
		gs c scholar speed              Celerity                Alacrity
		gs c scholar aoe                Accession               Manifestation
		gs c scholar power              Rapture                 Ebullience
		gs c scholar duration           Perpetuance
		gs c scholar accuracy           Altruism                Focalization
		gs c scholar enmity             Tranquility             Equanimity
		gs c scholar skillchain                                 Immanence
		gs c scholar addendum           Addendum: White         Addendum: Black
--]]



-- Initialization function for this job file.
function get_sets()
	-- Load and initialize the include file.
	include('Sel-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
	
	LowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
		'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II',
		'Stonega', 'Waterga', 'Aeroga', 'Firaga', 'Blizzaga', 'Thundaga'}

	info.addendumNukes = S{"Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",
		"Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V"}

	state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
	state.Buff['Enlightenment'] = buffactive['Enlightenment'] or false
	
	update_active_stratagems()
	
	autows = 'Realmrazer'
	autofood = 'Pear Crepe'
	
	data.skillchains.scholar = {}
	data.skillchains.scholar['1'] = {
		['Fire'] = 		{['skillchain'] = 'Liquefaction', 	['first_spell'] = 'Stone',		['second_spell'] = 'Pyrohelix',		['burst_elements'] = '{Fire}'},
		['Wind'] = 		{['skillchain'] = 'Detonation', 	['first_spell'] = 'Stone',		['second_spell'] = 'Anemohelix',	['burst_elements'] = '{Wind}'},
		['Lightning'] = {['skillchain'] = 'Impaction', 		['first_spell'] = 'Water',		['second_spell'] = 'Ionohelix',		['burst_elements'] = '{Lightning}'},
		['Light'] = 	{['skillchain'] = 'Transfixion', 	['first_spell'] = 'Noctohelix',	['second_spell'] = 'Luminohelix',	['burst_elements'] = '{Light}'},
		['Earth'] = 	{['skillchain'] = 'Scission', 		['first_spell'] = 'Fire',		['second_spell'] = 'Geohelix',		['burst_elements'] = '{Earth}'},
		['Ice'] = 		{['skillchain'] = 'Induration', 	['first_spell'] = 'Water',		['second_spell'] = 'Cryohelix',		['burst_elements'] = '{Ice}'},
		['Water'] = 	{['skillchain'] = 'Reverberation', 	['first_spell'] = 'Stone',		['second_spell'] = 'Hydrohelix',	['burst_elements'] = '{Water}'},
		['Dark'] = 		{['skillchain'] = 'Compression', 	['first_spell'] = 'Blizzard',	['second_spell'] = 'Noctohelix',	['burst_elements'] = '{Dark}'},
	}
	data.skillchains.scholar['2'] = {
		['Fire'] = 		{['skillchain'] = 'Fusion', 		['first_spell'] = 'Fire',		['second_spell'] = 'Ionohelix',		['burst_elements'] = '{Fire}, {Light}'},
		['Light'] = 	{['skillchain'] = 'Fusion', 		['first_spell'] = 'Fire',		['second_spell'] = 'Ionohelix',		['burst_elements'] = '{Fire}, {Light}'},
		['Wind'] = 		{['skillchain'] = 'Fragmentation', 	['first_spell'] = 'Blizzard',	['second_spell'] = 'Hydrohelix',	['burst_elements'] = '{Wind}, {Lightning}'},
		['Lightning'] = {['skillchain'] = 'Fragmentation', 	['first_spell'] = 'Blizzard',	['second_spell'] = 'Hydrohelix',	['burst_elements'] = '{Wind}, {Lightning}'},
		['Earth'] = 	{['skillchain'] = 'Gravitation', 	['first_spell'] = 'Aero',		['second_spell'] = 'Noctohelix',	['burst_elements'] = '{Earth}, {Dark}'},
		['Dark'] = 		{['skillchain'] = 'Gravitation', 	['first_spell'] = 'Aero',		['second_spell'] = 'Noctohelix',	['burst_elements'] = '{Earth}, {Dark}'},
		['Ice'] = 		{['skillchain'] = 'Distortion', 	['first_spell'] = 'Luminohelix',['second_spell'] = 'Geohelix',		['burst_elements'] = '{Ice}, {Water}'},
		['Water'] = 	{['skillchain'] = 'Distortion', 	['first_spell'] = 'Luminohelix',['second_spell'] = 'Geohelix',		['burst_elements'] = '{Ice}, {Water}'},
	}
	data.skillchains.scholar['ws'] = {
		['Fire'] = 		{['skillchain'] = 'Liquefaction',	['weaponskill'] = 'Rock Crusher',	['second_spell'] = 'Pyrohelix',		['burst_elements'] = '{Fire}'},
		['Wind'] = 		{['skillchain'] = 'Detonation', 	['weaponskill'] = 'Rock Crusher',	['second_spell'] = 'Anemohelix',	['burst_elements'] = '{Wind}'},
		['Lightning'] = {['skillchain'] = 'Impaction', 		['weaponskill'] = 'Starburst',		['second_spell'] = 'Ionohelix',		['burst_elements'] = '{Lightning}'},
		['Light'] = 	{['skillchain'] = 'Transfixion', 	['weaponskill'] = 'Starburst',		['second_spell'] = 'Luminohelix',	['burst_elements'] = '{Light}'},
		['Earth'] = 	{['skillchain'] = 'Scission', 		['weaponskill'] = 'Shell Crusher',	['second_spell'] = 'Geohelix',		['burst_elements'] = '{Earth}'},
		['Ice'] = 		{['skillchain'] = 'Induration', 	['weaponskill'] = 'Starburst',		['second_spell'] = 'Cryohelix',		['burst_elements'] = '{Ice}'},
		['Water'] = 	{['skillchain'] = 'Reverberation', 	['weaponskill'] = 'Omniscience',	['second_spell'] = 'Hydrohelix',	['burst_elements'] = '{Water}'},
		['Dark'] = 		{['skillchain'] = 'Compression', 	['weaponskill'] = 'Omniscience',	['second_spell'] = 'Noctohelix',	['burst_elements'] = '{Dark}'},
	}
	init_job_states({"Capacity","AutoFoodMode","AutoTrustMode","AutoWSMode","AutoNukeMode","AutoShadowMode","AutoStunMode","AutoDefenseMode"},{"AutoBuffMode","AutoRuneMode","Weapons","OffenseMode","WeaponskillMode","IdleMode","Passive","RuneElement","RecoverMode","ElementalMode","CastingMode","TreasureMode",})
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.

function job_filtered_action(spell, eventArgs)

end

function job_pretarget(spell, spellMap, eventArgs)

end

function job_precast(spell, spellMap, eventArgs)

	if spell.action_type == 'Magic' then
		if spellMap == 'Cure' or spellMap == 'Curaga' then
			gear.default.obi_back = gear.obi_cure_back
			gear.default.obi_waist = gear.obi_cure_waist
		elseif spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' then
			if LowTierNukes:contains(spell.english) or spell.english:endswith('helix') then
				gear.default.obi_back = gear.obi_low_nuke_back
				gear.default.obi_waist = gear.obi_low_nuke_waist
			else
				gear.default.obi_back = gear.obi_high_nuke_back
				gear.default.obi_waist = gear.obi_high_nuke_waist
			end
		end
		
		if state.CastingMode.value == 'Proc' then
			classes.CustomClass = 'Proc'
		elseif state.CastingMode.value == 'OccultAcumen' then
			classes.CustomClass = 'OccultAcumen'
		end
	end

end

function job_post_precast(spell, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
		local arts_active = arts_active()
		if arts_active and spell.type:startswith(arts_active) and sets.precast.FC.Arts then
			if sets.precast.FC.Arts[spell.english] then
				equip(sets.precast.FC.Arts[spell.english])
			elseif sets.precast.FC.Arts[spellMap] then
				equip(sets.precast.FC.Arts[spellMap])
			elseif sets.precast.FC.Arts[spell.skill] then
				equip(sets.precast.FC.Arts[spell.skill])
			else
				equip(sets.precast.FC.Arts)
			end
		end
	elseif spell.type == 'WeaponSkill' then
		local WSset = standardize_set(get_precast_set(spell, spellMap))
		
		if (WSset.ear1 == "Moonshade Earring" or WSset.ear2 == "Moonshade Earring") then
			-- Replace Moonshade Earring if we're at cap TP
			if sets.MaxTP and get_effective_player_tp(spell, WSset) > 3200 then
				equip(sets.MaxTP[spell.english] or sets.MaxTP)
			end
		end
	end
end

-- Run after the general midcast() is done.
function job_post_midcast(spell, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
		apply_grimoire_bonuses(spell, action, spellMap, eventArgs)
		if spell.skill == 'Enfeebling Magic' then
			if (state.Buff['Light Arts'] or state.Buff['Addendum: White']) and sets.buff['Light Arts'] then
				equip(sets.buff['Light Arts'])
			elseif (state.Buff['Dark Arts'] or state.Buff['Addendum: Black']) and sets.buff['Dark Arts'] then
				equip(sets.buff['Dark Arts'])
			end
		elseif default_spell_map == 'ElementalEnfeeble' and (state.Buff['Dark Arts']  or state.Buff['Addendum: Black']) and sets.buff['Dark Arts'] then
			equip(sets.buff['Dark Arts'])
		elseif spell.skill == 'Elemental Magic' and spell.english ~= 'Impact' then
			if state.CastingMode.value ~= 'Proc' then
				if state.Buff.Klimaform and spell.element == world.weather_element and sets.buff['Klimaform'] then
					equip(sets.buff['Klimaform'])
				end
				if state.Buff.Ebullience and sets.buff['Ebullience'] then
					equip(sets.buff['Ebullience'])
				end
				if state.Buff.Immanence and sets.buff['Immanence'] then
					equip(sets.buff['Immanence'])
				end
			end
		end
	end
end

function job_aftercast(spell, spellMap, eventArgs)
	if not spell.interrupted then
		if spell.type == 'Scholar' then
			windower.send_command:schedule(1,'gs c showcharge')
		elseif spell.action_type == 'Magic' then
			if state.UseCustomTimers.value and spell.english == 'Sleep' or spell.english == 'Sleepga' then
				windower.send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 60 down spells/00220.png')
			elseif state.UseCustomTimers.value and spell.english == 'Sleep II' then
				windower.send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 90 down spells/00220.png')
			end
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
	if default_spell_map == 'Cure' or default_spell_map == 'Curaga'  then
		if state.Weapons.value ~= 'None' and not state.UnlockWeapons.value then
			if world.weather_element == 'Light' then
				return 'MeleeLightWeatherCure'
			elseif world.day_element == 'Light' then
				return 'MeleeLightDayCure'
			else
				return 'MeleeCure'
			end
		elseif world.weather_element == 'Light' then
			return 'LightWeatherCure'
		elseif world.day_element == 'Light' then
			return 'LightDayCure'
		end
	elseif spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' and not spell.english:contains('helix') then
		if LowTierNukes:contains(spell.english) then
			return 'LowTierNuke'
		else
			return 'HighTierNuke'
		end
	end
end

function job_customize_idle_set(idleSet)
	if state.Buff['Sublimation: Activated'] then
		if (state.IdleMode.value == 'Normal' or state.IdleMode.value:contains('Sphere')) and sets.buff.Sublimation then
			idleSet = set_combine(idleSet, sets.buff.Sublimation)
		elseif state.IdleMode.value:contains('DT') and sets.buff.DTSublimation then
			idleSet = set_combine(idleSet, sets.buff.DTSublimation)
		end
	end

	if state.IdleMode.value == 'Normal' or state.IdleMode.value:contains('Sphere') then
		if player.mpp < 51 then
			if sets.latent_refresh then
				idleSet = set_combine(idleSet, sets.latent_refresh)
			end
			
			if (state.Weapons.value == 'None' or state.UnlockWeapons.value) and idleSet.main then
				local main_table = get_item_table(idleSet.main)

				if  main_table and main_table.skill == 12 and sets.latent_refresh_grip then
					idleSet = set_combine(idleSet, sets.latent_refresh_grip)
				end
				
				if player.tp > 10 and sets.TPEat then
					idleSet = set_combine(idleSet, sets.TPEat)
				end
			end
		end
   end

	return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
	update_active_stratagems()
	update_sublimation()
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
	display_current_caster_state()
	eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for direct player commands.
function job_self_command(commandArgs, eventArgs)
	if commandArgs[1]:lower() == 'showcharge' then
		add_to_chat(204, '~~~Current Stratagem Charges Available: ['..get_current_stratagem_count()..']~~~')
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Reset the state vars tracking stratagems.
function update_active_stratagems()
	state.Buff['Accession'] = buffactive['Accession'] or false
	state.Buff['Ebullience'] = buffactive['Ebullience'] or false
	state.Buff['Rapture'] = buffactive['Rapture'] or false
	state.Buff['Perpetuance'] = buffactive['Perpetuance'] or false
	state.Buff['Immanence'] = buffactive['Immanence'] or false
	state.Buff['Penury'] = buffactive['Penury'] or false
	state.Buff['Parsimony'] = buffactive['Parsimony'] or false
	state.Buff['Celerity'] = buffactive['Celerity'] or false
	state.Buff['Alacrity'] = buffactive['Alacrity'] or false
	state.Buff['Manifestation'] = buffactive['Manifestation'] or false
	state.Buff['Tabula Rasa'] = buffactive['Tabula Rasa'] or false
	state.Buff['Klimaform'] = buffactive['Klimaform'] or false
end

function update_sublimation()
	state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
end

-- Equip sets appropriate to the active buffs, relative to the spell being cast.
function apply_grimoire_bonuses(spell, action, spellMap)
	if state.Buff.Perpetuance and spell.type =='WhiteMagic' and spell.skill == 'Enhancing Magic' then
		equip(sets.buff['Perpetuance'])
	end
	if state.Buff.Rapture and (spellMap == 'Cure' or spellMap == 'Curaga') then
		equip(sets.buff['Rapture'])
	end

	if state.Buff.Penury then
		equip(sets.buff['Penury'])
	elseif state.Buff.Parsimony then
		equip(sets.buff['Parsimony'])
	end
	
	if spell.element == world.weather_element then
		if state.Buff.Celerity then
			equip(sets.buff['Celerity'])
		elseif state.Buff.Alacrity then
			equip(sets.buff['Alacrity'])
		end
	end
end

function handle_job_elemental(command, target)
	if command == 'weather' then
		local spell_recasts = windower.ffxi.get_spell_recasts()
		
		if target == player.id and buffactive[data.elements.storm_of[state.ElementalMode.value]] and not state.Buff.Klimaform and spell_recasts[287] < spell_latency then
			windower.chat.input('/ma "Klimaform" <me>')
		elseif player.job_points[(res.jobs[player.main_job_id].ens):lower()].jp_spent > 99 then
			windower.chat.input('/ma "'..data.elements.storm_of[state.ElementalMode.value]..' II"')
		else
			windower.chat.input('/ma "'..data.elements.storm_of[state.ElementalMode.value]..'"')
		end
		return true
	elseif command:endswith('nuke') then
		local spell_recasts = windower.ffxi.get_spell_recasts()
		
		if state.ElementalMode.value == 'Light' then
			if spell_recasts[29] < spell_latency and actual_cost('Banish II') < player.mp then
				windower.chat.input('/ma "Banish II" '..target..'')
			elseif spell_recasts[28] < spell_latency and actual_cost('Banish') < player.mp then
				windower.chat.input('/ma "Banish" '..target..'')
			else
				add_to_chat(123,'Abort: Banishes on cooldown or not enough MP.')
			end
		else
			local spell_recasts = windower.ffxi.get_spell_recasts()
			local tiers = {' V',' IV',' III',' II',''}
			if command == 'smallnuke' then
				tiers = {' II',''}
			end

			for k in ipairs(tiers) do
				local spell_name = data.elements.nuke_of[state.ElementalMode.value]..tiers[k]
				local spell_id = get_spell_id_by_name(spell_name)
				if silent_can_cast(spell_name) and spell_recasts[spell_id] < spell_latency and actual_cost(spell_id) < player.mp then
					windower.chat.input('/ma "'..spell_name..'" '..target..'')
					return true
				end
			end
			add_to_chat(123,'Abort: All '..state.ElementalMode.value..' nukes on cooldown or or not enough MP.')
		end
		return true
	elseif command == 'helix' then
		if player.job_points[(res.jobs[player.main_job_id].ens):lower()].jp_spent > 1199 then
			windower.chat.input('/ma "'..data.elements.helix_of[state.ElementalMode.value]..'helix II" '..target..'')
		else
			windower.chat.input('/ma "'..data.elements.helix_of[state.ElementalMode.value]..'helix" '..target..'')
		end
		return true
	elseif command:contains('skillchain') then
		local immactive = 0
		if state.Buff['Immanence'] then
			immactive = 1
		end

		if player.target.type ~= "MONSTER" then
			add_to_chat(123,'Abort: You are not targeting a monster.')
			return true
		elseif silent_check_silence() or buffactive.paralysis or silent_check_amnesia() then
			add_to_chat(123,'You are disabled, cancelling skillchain.')
			return true
		elseif (get_current_stratagem_count() + immactive) < 2 then
			add_to_chat(123,'Abort: You have less than two stratagems available.')
			return true
		elseif not (state.Buff['Dark Arts']  or state.Buff['Addendum: Black']) then
			add_to_chat(123,"Can't use elemental skillchain commands without Dark Arts - Activating.")
			windower.chat.input('/ja "Dark Arts" <me>')
			return true
		end
		local last_character = string.sub(command, -1)
		
		if last_character == '1' or last_character == '2' then
			local skillchain = data.skillchains.scholar[last_character][state.ElementalMode.value]
			local spell_recasts = windower.ffxi.get_spell_recasts()
			local first_spell_id = get_spell_id_by_name(skillchain.first_spell)
			local second_spell_id = get_spell_id_by_name(skillchain.second_spell)
			if spell_recasts[first_spell_id] > (spell_latency + 1.3*60) then
				add_to_chat(123,'Abort: ['..skillchain.first_spell..'] waiting on recast. ('..seconds_to_clock(spell_recasts[first_spell_id]/60)..')')
			elseif spell_recasts[second_spell_id] > (spell_latency + 6.9*60) then
				add_to_chat(123,'Abort: ['..skillchain.second_spell..'] waiting on recast. ('..seconds_to_clock(spell_recasts[second_spell_id]/60)..')')
			else
				if not state.Buff['Immanence'] then windower.chat.input('/ja "Immanence" <me>') end
				windower.chat.input('/p {'..skillchain.skillchain..'} -'..player.target.name..'- MB: '..skillchain.burst_elements..' <scall21> OPEN!')
				windower.chat.input:schedule(1.3,'/ma "'..skillchain.first_spell..'" '..player.target.id)
				windower.chat.input:schedule(5.6,'/ja "Immanence" <me>')
				windower.chat.input:schedule(6.9,'/p {'..skillchain.skillchain..'} -'..player.target.name..'- MB: '..skillchain.burst_elements..' <scall21> CLOSE!')
				windower.chat.input:schedule(6.9,'/ma "'..skillchain.second_spell..'" '..player.target.id)
			end
		elseif last_character == '3' then
			if state.ElementalMode.value ~= 'Fire' then
				add_to_chat(123,'Abort: Fire is the only element with a consecutive 3-step skillchain.')
			elseif (get_current_stratagem_count() + immactive) < 3 then
				add_to_chat(123,'Abort: You have less than three stratagems available.')
			else
				local spell_recasts = windower.ffxi.get_spell_recasts()
				local stone_id = get_spell_id_by_name('Stone')

				if spell_recasts[159] > (spell_latency + 1.3*60) then
					add_to_chat(123,'Abort: [Stone] waiting on recast. ('..seconds_to_clock(spell_recasts[159]/60)..')')
				elseif spell_recasts[281] > (spell_latency + 6.9*60) then
					add_to_chat(123,'Abort: [Pyrohelix] waiting on recast. ('..seconds_to_clock(spell_recasts[281]/60)..')')
				elseif spell_recasts[283] > (spell_latency + 16.3*60) then
					add_to_chat(123,'Abort: [Pyrohelix] waiting on recast. ('..seconds_to_clock(spell_recasts[283]/60)..')')
				else
					if not state.Buff['Immanence'] then windower.chat.input('/ja "Immanence" <me>') end
					
					windower.chat.input('/p {Liquefaction} -'..player.target.name..'- MB: (Fire) <scall21> OPEN!')
					windower.chat.input:schedule(1.3,'/ma "Stone" '..player.target.id)
					windower.chat.input:schedule(5.6,'/ja "Immanence" <me>')
					windower.chat.input:schedule(6.9,'/p {Liquefaction} -'..player.target.name..'- MB: {Fire} <scall21> CLOSE!')
					windower.chat.input:schedule(6.9,'/ma "Pyrohelix" '..player.target.id)
					windower.chat.input:schedule(13,'/ja "Immanence" <me>')
					windower.chat.input:schedule(16.3,'/p {Fusion} -'..player.target.name..'- MB: {Fire}, {Light} <scall21> CLOSE!')
					windower.chat.input:schedule(16.3,'/ma "Ionohelix" '..player.target.id)
				end
			end
		elseif last_character == '4' then
			if (get_current_stratagem_count() + immactive) < 4 then
				add_to_chat(123,'Abort: You have less than four stratagems available.')
			else
				state.CastingMode:set('Proc')
				if state.DisplayMode.value then update_job_states()	end
				
				windower.chat.input('/p Starting 4-Step {Skillchain} -'..player.target.name..'-')
				if not state.Buff['Immanence'] then windower.chat.input('/ja "Immanence" <me>') end
				windower.chat.input:schedule(1.3,'/ma "Aero" '..player.target.id)
				windower.chat.input:schedule(5.6,'/ja "Immanence" <me>')
				windower.chat.input:schedule(6.9,'/ma "Stone" '..player.target.id)
				windower.chat.input:schedule(11.2,'/ja "Immanence" <me>')
				windower.chat.input:schedule(12.5,'/ma "Water" '..player.target.id)
				windower.chat.input:schedule(17.8,'/ja "Immanence" <me>')
				windower.chat.input:schedule(19.1,'/ma "Thunder" '..player.target.id)
			end
		elseif last_character == '6' then
			if get_current_stratagem_count() < 5 then
				add_to_chat(123,'Abort: You have less than five stratagems available.')
			elseif not state.Buff['Immanence'] then
				add_to_chat(123,'Immanence not active, wait for stratagem cooldown. - Activating Immanence.')
				windower.chat.input('/ja "Immanence" <me>')
			else
				state.CastingMode:set('Proc')
				if state.DisplayMode.value then update_job_states()	end
				windower.chat.input('/p Starting 6-Step {Skillchain} -'..player.target.name..'-')
				windower.chat.input('/ma "Aero" <t>')
				windower.chat.input:schedule(4.3,'/ja "Immanence" <me>')
				windower.chat.input:schedule(5.6,'/ma "Stone" '..player.target.id)
				windower.chat.input:schedule(9.9,'/ja "Immanence" <me>')
				windower.chat.input:schedule(11.2,'/ma "Water" '..player.target.id)
				windower.chat.input:schedule(15.5,'/ja "Immanence" <me>')
				windower.chat.input:schedule(16.8,'/ma "Thunder" '..player.target.id)
				windower.chat.input:schedule(21.1,'/ja "Immanence" <me>')
				windower.chat.input:schedule(22.4,'/ma "Fire" '..player.target.id)
				windower.chat.input:schedule(26.7,'/ja "Immanence" <me>')
				windower.chat.input:schedule(28,'/ma "Thunder" '..player.target.id)
			end
		elseif command == 'wsskillchain' then
			if player.tp < 1000 then
				add_to_chat(123,"Abort: You don't have enough TP for this skillchain.")
			else
				local skillchain = data.skillchains.scholar['ws'][state.ElementalMode.value]
				local available_ws = S(windower.ffxi.get_abilities().weapon_skills)
				local weaponskill_id = get_weaponskill_id_by_name(skillchain.weaponskill)

				if not available_ws:contains(weaponskill_id) then
					add_to_chat(123,"Abort: You don't have access to ["..skillchain.weaponskill.."].")
					return
				end
				
				local spell_recasts = windower.ffxi.get_spell_recasts()
				local second_spell_id = get_spell_id_by_name(skillchain.second_spell)
				
				if spell_recasts[second_spell_id] > (spell_latency + 6.3*60) then
					add_to_chat(123,'Abort: ['..skillchain.second_spell..'] waiting on recast. ('..seconds_to_clock(spell_recasts[second_spell_id]/60)..')')
					return
				end

				if not state.Buff['Immanence'] then windower.chat.input('/ja "Immanence" <me>') end
				windower.chat.input('/p {'..skillchain.skillchain..'} -'..player.target.name..'- MB: '..skillchain.burst_elements..' <scall21> OPEN!')
				windower.chat.input:schedule(1.3,'/ws "'..skillchain.weaponskill..'" '..player.target.id)
				windower.chat.input:schedule(6.3,'/p {'..skillchain.skillchain..'} -'..player.target.name..'- MB: '..skillchain.burst_elements..' <scall21> CLOSE!')
				windower.chat.input:schedule(6.3,'/ma "'..skillchain.second_spell..'" '..player.target.id)
			end
		elseif command == 'endskillchain' then
			local spell_recasts = windower.ffxi.get_spell_recasts()
			local helix_id = get_spell_id_by_name(data.elements.helix_of[state.ElementalMode.value]..'helix')

			if spell_recasts[second_spell_id] > (spell_latency + 6.3*60) then
				add_to_chat(123,'Abort: ['..skillchain.second_spell..'] waiting on recast. ('..seconds_to_clock(spell_recasts[second_spell_id]/60)..')')
			else
				if not state.Buff['Immanence'] then windower.chat.input('/ja "Immanence" <me>') end
				windower.chat.input:schedule(1.3,'/p {'..skillchain.skillchain..'} -'..player.target.name..'- MB: '..state.ElementalMode.value..' <scall21> CLOSE!')
				windower.chat.input:schedule(1.3,'/ma "'..data.elements.helix_of[state.ElementalMode.value]..'helix" '..target..'')
			end
		end
		return true
	end
	return false
end

-- Gets the current number of available stratagems based on the recast remaining
-- and the level of the sch.
function job_tick()
	if check_arts() then return true end
	if check_buffup() then return true end
	if check_buff() then return true end
	return false
end

function check_arts()
	if not arts_active() and (buffup ~= '' or (not data.areas.cities:contains(world.area) and ((state.AutoArts.value and in_combat) or state.AutoBuffMode.value ~= 'Off'))) then
	
		local abil_recasts = windower.ffxi.get_ability_recasts()

		if abil_recasts[232] < latency then
			windower.chat.input('/ja "Dark Arts" <me>')
			add_tick_delay()
			return true
		end

	end
	
	return false
end

buff_spell_lists = {
	Auto = {--Options for When are: Always, Engaged, Idle, OutOfCombat, Combat
		{Name='Haste',		Buff='Haste',		SpellID=57,		When='Always'},
		{Name='Stoneskin',	Buff='Stoneskin',	SpellID=54,		When='Always'},
		{Name='Klimaform',	Buff='Klimaform',	SpellID=287,	When='Combat'},
	},

	Default = {
		{Name='Reraise',	Buff='Reraise',		SpellID=113,	Reapply=false},
		{Name='Haste',		Buff='Haste',		SpellID=57,		Reapply=false},
		{Name='Refresh',	Buff='Refresh',		SpellID=109,	Reapply=false},
		{Name='Aquaveil',	Buff='Aquaveil',	SpellID=55,		Reapply=false},
		{Name='Stoneskin',	Buff='Stoneskin',	SpellID=54,		Reapply=false},
		{Name='Klimaform',	Buff='Klimaform',	SpellID=287,	Reapply=false},
		{Name='Blink',		Buff='Blink',		SpellID=53,		Reapply=false},
		{Name='Regen',		Buff='Regen',		SpellID=108,	Reapply=false},
		{Name='Phalanx',	Buff='Phalanx',		SpellID=106,	Reapply=false},
	},
}