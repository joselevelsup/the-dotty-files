local M = {
  'goolord/alpha-nvim'
}

function M.config()
  local alpha = require("alpha")
  local dashboard = require("alpha.themes.dashboard")

  local Headers = {
    {
      [[=================     ===============     ===============   ========  ========]],
      [[\\ . . . . . . .\\   //. . . . . . .\\   //. . . . . . .\\  \\. . .\\// . . //]],
      [[||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\/ . . .||]],
      [[|| . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||]],
      [[||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||]],
      [[|| . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\ . . . . ||]],
      [[||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\_ . .|. .||]],
      [[|| . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\ `-_/| . ||]],
      [[||_-' ||  .|/    || ||    \|.  || `-_|| ||_-' ||  .|/    || ||   | \  / |-_.||]],
      [[||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \  / |  `||]],
      [[||    `'         || ||         `'    || ||    `'         || ||   | \  / |   ||]],
      [[||            .===' `===.         .==='.`===.         .===' /==. |  \/  |   ||]],
      [[||         .=='   \_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \/  |   ||]],
      [[||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \/  |   ||]],
      [[||   .=='    _-'          '-__\._-'         '-_./__-'         `' |. /|  |   ||]],
      [[||.=='    _-'                                                     `' |  /==.||]],
      [[=='    _-'                                                            \/   `==]],
      [[\   _-'                                                                `-_   /]],
      [[ `''                                                                      ``' ]],
    },
    {
      [[.;;;;;;;;;;;;;;,  ,;:;;;;;;;;;,    ,;;;;;;;;;;;'..;;;;;    ,;;;;;:]],
      [[.l0KKKKKKKKKKKKKx:d0KKKKKKKKKKK0d:cxKKKKKKKKKKKK0olOKK0Kx. ;OKK0KO]],
      [['kKKKKKKKKK0K0KOdkKKK0KKKKK0KKKkodOKKK00KKKK0KKKkdOK0000c'dK000Kx.]],
      [['kK0KKkolokKK0KOdkK0KKkolokKKKKkddOKKKKkolokK00KkdOK0K0KOx0K000Kx.]],
      [['kK0KKl   :0K0KOokK0K0c   c0K0KkddOK0K0:   lKK0KkdOK00KKKKKK000Kx.]],
      [['kK00Kl   :000KOdkK0K0c   :0K0KkddOK0K0:   lKK0KkdOK0KKKK0KK0K0Kk.]],
      [['kK00Kc   :0K0KOdkK0K0c   :0K0KkddOK0K0:   lKKKKkdOK0KKKKKK0KK0Kk.]],
      [['kK00Kc   :0K00OdkK0K0c   c0K0KkddOK0K0:   lKK0KkdOK000K00KK000Kx.]],
      [['kK00Kc   :0K00OdkK0K0c   c0K0KkddOK0K0:   lK00KkdOK00KKKKK0000Kk.]],
      [['kK00Kl   :0KKKOdkKKK0c   c0K0KkddOK0K0:   lKK0KkdOK0K0O0K00000Kk.]],
      [['kK00Kl .;x0KKKOokKKKKx:. cKKKKkddOKKK0: .:kK00KkdOK0KOox0od0K0Kx.]],
      [['kK00KxokKKKKKKOokK0KK0KkoxKK0KkddOK0K0xok00KK0KxoOK0K0;:d,lKK0Kx.]],
      [['kK000KKKKKK0K0d'.cx0KK0KKKKK0KkddOK0KKKK000K0x:.,x0KK0;...lK00Kx.]],
      [['kK0000000K0kl,.   .,lk0K000KK0o;:d0KK000K0kl'    .,lO0;   lK00Kx.]],
      [['kK000K00Od;.         .;oO00xl'    'lk00Oo;.         .;.   lK00Kx.]],
      [['kK00K0x:.               .:,.        .,;.                  l000Kx.]],
      [[.kK0kl,.                                                   .lk00o.]],
      [[.dd;.                                                        .;do.]],
      [[.                                                               ..]]
    }
  }

  local quotes = {
    "Welcome home, great Programmer.",
    "Warning: the Dev has entered Neovim.",
    "Tell me...do you have nothing to say to your codebase...before you write more code? \n \n \n \t \t \t \t \t No.",
    "Rip and Tear with Neovim",
    "Your affinity for documentation is apparent. I'm confident you'll find something useful there.",
    "You will remain... unbroken... for your code... is eternal."
  }

  local dashboard_header = Headers[math.random(#Headers)]
  local dashboard_footer = quotes[math.random(#quotes)]

  local dashboard_menu = {
    dashboard.button("SPC f SPC", "  Find File", ":Telescope find_files<CR>"),
    dashboard.button("SPC f p", "  Projects", ":Telescope workspaces<CR>"),
    dashboard.button("SPC p u", "ﮮ  Update Plugins", ":Lazy sync<CR>"),
  }

  dashboard.section.header.val = dashboard_header
  dashboard.section.buttons.val = dashboard_menu
  dashboard.section.footer.val = dashboard_footer

  alpha.setup(dashboard.opts)
end

return M
