local actions = require('telescope.actions')

require('telescope').setup {
    defaults = {
        border = true,
        borderchars = AW.ui.borderchars,
        file_ignore_patterns = {'node_modules'},
        layout_strategy = 'flex',
        mappings = {
            i = {
                ['<Tab>']   = actions.move_selection_worse,
                ['<S-Tab>'] = actions.move_selection_better,
                ['<Esc>']   = actions.close,
                ['<C-u>']   = false,  -- Normal ^U behaviour
                ['<C-h>']   = require('telescope.actions.generate').which_key {
                    normal_hl = 'CustomMediumBright',
                    border_hl = 'CustomMediumBrightBlank'
                }
            }
        },
        path_display = function(_, path)  -- remove leading ./
            return path:gsub('^./', '')
        end,
        winblend = AW.ui.winblend
    }
}

AW.colorcmd.register [[
    hi! link TelescopeBorder NormalFloat
    hi! link TelescopeNormal NormalFloat
    hi! link TelescopePromptPrefix NormalFloat
    hi! link TelescopePromptCounter  NormalFloat
    hi! link TelescopeSelection CustomHighlight
]]
