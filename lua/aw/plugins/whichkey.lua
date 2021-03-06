local wk = require('which-key')

wk.setup {
    show_help = false,
    icons = {
        breadcrumb = '',  -- Shown in command line
        group      = AW.icon('lsp'),
        separator  = ''   -- Between key and description
    },
    window = {
        winblend = AW.ui.winblend
    }
}

wk.register(AW.maps.leader, {mode = 'n', prefix = '<leader>'})

AW.colorcmd.register [[
    hi! link WhichKeyFloat CustomMedium
]]
