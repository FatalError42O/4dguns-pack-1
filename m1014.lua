minetest.register_tool("guns4d_pack_1:m1014", {
    description = "m1014 (12 gauge)",
    wield_scale = {x=.5, y=.5, z=.5},
    inventory_image = "m1014_inv.png"
})
Guns4d.gun:inherit({
    name = "guns4d_pack_1:m1014",
    itemstring = "guns4d_pack_1:m1014",
    properties = {
        inventory = {
            render_image = "m1014_ortho.png",
            render_size = 2,
        },
        visuals = {
            flash_offset = vector.new(0, -.001, 0),
            scale = 1.5,
            mesh = "m1014.b3d",
            magazine = "mag",
            textures = {
                "m1014.png"
            },
            backface_culling = false,
            animations = {
                empty = {x=0,y=0},
                loaded = {x=1,y=1},
                unload = {x=52, y=60},
                store = {x=61, y=75},
                load1 = {x=11, y=45}, --first load
                load2 = {x=25, y=45}, --all the rest
                charge1 = {x=45, y=74}, --charge after loading carts
                charge2 = {x=60, y=75},
                draw  = {x=76, y=90},
                fire = {x=1, y=10}
            },
        },
        sounds = { --currently is identical to the glock because I havent had time to get real sounds...
            fire = {
                {
                    sound = "glock21_firing",
                    max_hear_distance = 25, --far min_hear_distance is also this.
                    pitch = {
                        min = .8,
                        max = 1.05
                    },
                    gain = {
                        min = .9,
                        max = 1
                    },
                    attenuation_rate = .004
                },
                {
                    sound = "ar_firing_far",
                    min_hear_distance = 25,
                    max_hear_distance = 250,
                    pitch = {
                        min = 1.1,
                        max = 1.2
                    },
                    gain = {
                        min = .35,
                        max = .4
                    },
                    attenuation_rate = .04
                }
            },
            charge = {sound="ar_charge", delay = 0, pitch=.8, max_hear_distance=8}
        },
        firemodes = {
            "single",
        },
        firerateRPM = 500,
        hip = {
            offset = vector.new(-.2,.11,.65),
        },
        ads = {
            offset = vector.new(0,0,.511),
            horizontal_offset = .1,
            aim_time = .5
        },
        sway = {
            max_angle = {player_axial=4, gun_axial=.25},
            angular_velocity = {player_axial=1, gun_axial=.3},
            hipfire_velocity_multiplier = { --same as above but for velocity.
                gun_axial = 1,
                player_axial = 1
            },
            hipfire_angle_multiplier = { --same as above but for velocity.
                gun_axial = 1,
                player_axial = 1
            }
        },
        recoil = {
            velocity_correction_factor = {
                gun_axial = 2,
                player_axial = 6,
            },
            angular_velocity_max = {
                gun_axial = 2,
                player_axial = 8,
            },
            angular_velocity = {
                gun_axial = {x=.3, y=.55},
                player_axial = {x=1.75, y=4},
            },
            bias = {
                gun_axial = {x=-.1, y=0},
                player_axial = {x=.5, y=0},
            },
            target_correction_max_rate = {
                gun_axial = 12,
                player_axial = 12,
            },
            target_correction_factor = { --angular correction rate per second: time_since_fire*target_correction_factor
                gun_axial = 2,
                player_axial = 10,
            },
        },
        wag = {
            offset = {gun_axial={x=.1,y=-.3}, player_axial={x=1,y=1}},
        },
        ammo = {
            magazine_only = false,
            capacity = 7,
            accepted_bullets = {"guns4d_pack_1:12G"}, --first bullet default
        },
        reload = {
            {action="charge", time=.5, anim="charge2", sounds={sound="ar_charge", delay = 0, pitch=.8}},
            {action="load_cartridge_once", time=1.05, anim="load1", sounds = {sound="ar_mag_load", delay = .65}},
            {action="load_cartridge", time=.75, anim="load2", sounds = {sound="ar_mag_load", delay = .25}},
            {action="charge", time=.8, anim="charge1", sounds={sound="ar_charge", delay = 0, pitch=.8}}
        },
        charging = { --how the gun "cocks"
            require_charge_on_swap = true,
            bolt_charge_mode = "no_catch", --"none"-chamber is always full, "catch"-when fired to dry bolt will not need to be charged after reload, "no_catch" bolt will always need to be charged after reload.
            draw_time = 1,
            draw_sound = "charge",
        },
    },
    --[[custom_construct = function(self)
        self.offsets.screen_offset = {
            player_axial = vector.new(),
            gun_axial = vector.new(),
        }
    end,]]
    consts = {
        HAS_BREATHING = true,
        DEFAULT_FPS = 40,
        ROOT_BONE = "main",
        VERSION = {1,3,2}
    }
})