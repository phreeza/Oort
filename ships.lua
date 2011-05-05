-- Reactor is simulated deuterium+tritium fusion with 0.375% mass to energy
-- conversion. Thrust is generated by expelling dedicated reaction mass using
-- energy stored in the battery. Currently the depletion of reaction mass is
-- not simulated. The hydrogen fuel required is tiny compared to the mass of
-- the spacecraft and so is not simulated. The exhaust velocity is currently
-- set at 10 km/s but should be changed to an argument to the thrust()
-- function. 10 km/s is a relatively low exhaust velocity that lowers energy
-- use at the expense of using more reaction mass.

-- Energy/mass requirement for a fighter at full thrust for 1 second:
-- t = 1 s
-- M = 30000 kg (fighter mass)
-- a = 100 m/s^2 (slightly better than a space shuttle main engine bolted on to the fighter)
-- V = 100 m/s
-- v = 10000 m/s (exhaust velocity)
-- m*v = M*V
-- m = M*V/v = 300 kg = 1% of fighter's total mass
-- E = 0.5*m*v^2 = 15 GJ
-- Size the battery for 5 seconds of full thrust:
-- E_b = 15 GW * 5s = 75 GJ
-- Allow continuous thrust at 1/3 power:
-- P = 5 GW

local pi = 3.141592653589793

bullets = {
	slug = 1,
	plasma = 2,
	explosion = 3,
	ion_beam = 4,
	laser_beam = 5,
}

ships = {}

ships.fighter = {
	radius = 10,
	mass = 10e3,
	reaction_mass = 20e3,
	hull = 450e3,
	max_main_acc = 100,
	max_lateral_acc = 10,
	max_angular_acc = 1,
	cost = 10e9,
	guns = {
		main = {
			bullet_type = bullets.slug,
			bullet_mass = 0.001,
			bullet_radius = 1.0/32,
			bullet_velocity = 3000,
			bullet_ttl = 0.2,
			spread = 0.1,
			angle = 0.0,
			coverage = 0.8*pi,
			reload_time = 0.03,
			cost = 4.5e3,
		}
	},
	count_for_victory = true,
	energy = {
		initial = 5e9,
		rate = 5e9,
		limit = 15e9,
	},
	spawnable = {
		little_missile = 5,
	}
}

ships.ion_cannon_frigate = {
	radius = 40,
	mass = 160e3,
	reaction_mass = 40e3,
	hull = 10e6,
	max_main_acc = 20,
	max_lateral_acc = 2,
	max_angular_acc = 0.5,
	cost = 30e9,
	guns = {
		main = {
			bullet_type = bullets.ion_beam,
			bullet_mass = 0.0001,
			bullet_velocity = 32e3,
			bullet_ttl = 1.0/32,
			bullet_radius = 3,
			spread = 0.0,
			angle = 0.0,
			coverage = 0.0,
			reload_time = 0,
			cost = 30e9/32,
		}
	},
	count_for_victory = true,
	energy = {
		initial = 10e9,
		rate = 17e9,
		limit = 20e9,
	},
	spawnable = {
	}
}

ships.mothership = {
	radius = 80,
	mass = 1e6,
	reaction_mass = 1e6,
	hull = 20e6,
	max_main_acc = 10,
	max_lateral_acc = 1,
	max_angular_acc = 0.1,
	cost = 50e9,
	guns = {
		main = {
			bullet_type = bullets.laser_beam,
			bullet_mass = 0.00001,
			bullet_velocity = 16e3,
			bullet_ttl = 1.0/32,
			bullet_radius = 2,
			spread = 0.01,
			angle = 0,
			coverage = 2*pi,
			reload_time = 0,
			cost = 20e9/32,
		},
	},
	count_for_victory = true,
	energy = {
		initial = 30e9,
		rate = 10e9,
		limit = 100e9,
	},
	spawnable = {
		little_missile = 1,
		missile = 2,
		fighter = 5
	}
}

ships.missile = {
	radius = 2.5,
	hull = 10e3,
	mass = 1e3,
	reaction_mass = 400,
	max_main_acc = 100,
	max_lateral_acc = 20,
	max_angular_acc = 1.5,
	cost = 11e9,
	guns = {},
	warhead = 1e6,
	count_for_victory = false,
	energy = {
		initial = 10e9,
		rate = 0,
		limit = 10e9,
	},
	spawnable = {}
}

ships.little_missile = {
	radius = 1.0,
	mass = 200,
	reaction_mass = 80,
	hull = 3e3,
	max_main_acc = 300,
	max_lateral_acc = 150,
	max_angular_acc = 3,
	cost = 3e9,
	guns = {},
	warhead = 300e3,
	count_for_victory = false,
	energy = {
		initial = 2e9,
		rate = 0,
		limit = 2e9,
	},
	spawnable = {}
}

ships.small_target = {
	radius = 10.0,
	mass = 1,
	reaction_mass = 1000,
	hull = 100e3,
	max_main_acc = 1000,
	max_lateral_acc = 1000,
	max_angular_acc = 3,
	cost = 0,
	guns = {},
	count_for_victory = true,
	energy = {
		initial = 1e12,
		rate = 1e12,
		limit = 1e12,
	},
	spawnable = {}
}
