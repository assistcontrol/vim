-- Leader is space
vim.g.mapleader = ' '

-- Key mappings
AW.maps = {}

local cmd = function(command)
    return table.concat({'<Cmd>', command, '<CR>'})
end

local map = AW.map

-- Mash j and k, or jj/kk in place of ESC
map('i', 'jk', '<Esc>')
map('i', 'kj', '<Esc>')
-- Sometimes it comes out as jj or kk
map('i', 'jj', '<Esc>')
map('i', 'kk', '<Esc>')

-- Move normally onto wrapped lines
map('n', 'j', 'gj')
map('n', 'k', 'gk')

-- Alt-J/K jumps tabs
map('n', '<A-j>', cmd[[tabprevious]])
map('n', '<A-k>', cmd[[tabnext]])

-- ^J/^K jumps buffers
map('n', '<C-j>', cmd[[bnext]])
map('n', '<C-k>', cmd[[bprevious]])

-- J/K moves selected lines
map('v', 'J', "<Cmd>move '>+1<CR>gv=gv")
map('v', 'K', "<Cmd>move '<-2<CR>gv=gv")

-- Search using proper regexes by default
map('n', '/', [[/\v]])
map('n', '?', [[?\v]])

-- // and ?? clear search results
map('n', '//', cmd[[nohlsearch]])
map('n', '??', cmd[[nohlsearch]])

-- Tab/S-Tab through completion list
map('i', '<Tab>',   [[pumvisible() ? '<C-n>' : '<Tab>']],   {expr = true})
map('i', '<S-Tab>', [[pumvisible() ? '<C-n>' : '<S-Tab>']], {expr = true})

-- S surrounds visual region
map('x', 'S', cmd[[lua MiniSurround.add('visual')]])

-- ^\ saves
map({'i', 'n'}, '<C-\\>', cmd[[write]])

-- \\ shows buffers
map('n', '\\\\', cmd[[Telescope buffers]], {desc = 'buffers'})

-- Readline-esque keys for insert and command modes
local has_readline, readline = pcall(require, 'readline')
if has_readline then
    map('!', '<C-a>', readline.dwim_beginning_of_line)
    map('!', '<C-e>', readline.end_of_line)
    map('!', '<C-w>', readline.backward_kill_word)
    map('!', '<C-k>', readline.kill_line)
    map('!', '<C-u>', function() readline.end_of_line(); readline.dwim_backward_kill_line() end)
end

AW.maps.leader = {
    -- In which-key.nvim format
    k = {cmd[[wincmd k]], 'window up'},
    j = {cmd[[wincmd j]], 'window down'},
    h = {cmd[[wincmd h]], 'window left'},
    l = {cmd[[wincmd l]], 'window right'},

    ['<leader>'] = {cmd[[b#]],                     'alternate'},
    ['<cr>']     = {cmd[[lua AW.next_pane()]],     'next window'},
    e = {cmd[[lua AW.filebrowser()]],              'browse'},
    s = {cmd[[FocusSplitNicely]],                  'split'},
    w = {cmd[[lua require('nvim-window').pick()]], 'pick window'},
    q = {cmd[[lua MiniBufremove.delete()]],        'close buffer'},
    x = {cmd[[NvimTreeFocus]],                     'explorer'},
    X = {cmd[[NvimTreeClose]],                     'unexplorer'},
    z = {cmd[[lua require('mini.misc').zoom()]],   'zoom'},

    b = {
        name = 'buffer',
        b = {cmd[[Telescope buffers]],          'list'},
        d = {cmd[[lua MiniBufremove.delete()]], 'delete'},
        n = {cmd[[bnext]],                      'next'},
        p = {cmd[[bprevious]],                  'previous'},
        ['<leader>'] = {cmd[[bnext]],           'next'},
    },

    d = {
        name = 'code dx',
        n = {cmd[[lua vim.diagnostic.goto_next({float = true})]], 'next'},
        p = {cmd[[lua vim.diagnostic.goto_prev({float = true})]], 'previous'},
    },

    f = {
        name = 'find',
        b = {cmd[[Telescope buffers]],     'buffers'},
        d = {cmd[[Telescope diagnostics]], 'diagnostics'},
        e = {cmd[[Explore]],               'explorer'},
        g = {cmd[[Telescope live_grep]],   'grep'},
        t = {cmd[[Telescope]],             'telescope'},
        f = {cmd[[lua AW.filebrowser()]],  'files'}
    },

    m = {
        -- alias mm='make -j$(sysctl -n hw.ncpu)'
        name = 'make',
        m = {cmd[[TermExec cmd="mm"]],      'all'},
        t = {cmd[[TermExec cmd="mm test"]], 'test'}
    },

    o = {
        name = 'fold',
        c = {'zc', 'close'},
        C = {'zM', 'close all'},
        o = {'zo', 'open'},
        O = {'zR', 'open all'},
        ['<leader>'] = {'za', 'toggle'}
    }
}

-- Gitsigns sets keymaps via a callback
function AW.maps.gitsigns(bufnr)
    map('n', '[c', function() require('gitsigns').prev_hunk() end, {buffer = bufnr, desc = 'previous git hunk'})
    map('n', ']c', function() require('gitsigns').next_hunk() end, {buffer = bufnr, desc = 'next git hunk'})
end
