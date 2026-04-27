
onedark_colorscheme = function() 
    require('onedark').setup({
        -- dark, darker, cool, deep, warm, warmer
        style = 'darker'
    })
end

doomone_colorscheme = function() 
    vim.g.doom_one_cursor_coloring = true
    vim.g.doom_one_italic_comments = false
    vim.g.doom_one_plugin_telescope = true
    vim.g.doom_one_enable_treesitter = true
    vim.g.doom_one_plugin_telescope = true
end

rosepine_colorscheme = function() 
    require("rose-pine").setup({
        styles = {
            italic = false,
            bold = false,
        }
    })
end

pica_del_teide_colorscheme = function()
    require("teide").setup({
        -- light, dark, darker, dimmed
        style = "dimmed",
        styles = {
            keywords = {
                italic = false
            }
        }
    })
end

edge_colorscheme = function()
    -- default, aura, neon
    vim.g.edge_style = 'aura'
    vim.g.edge_enable_italic = true
    vim.g.edge_dim_inactive_windows = false
end

onedarkpro_colorscheme = function()
    require("onedarkpro").setup({
        styles = {
            comments = 'italic'           
        },
        options = {
            cursorline = true
        },
    })
end


-- Apparently if I don't do this, the cursorline doesn't draw properly
onedarkpro_colorscheme()
vim.cmd.colorscheme("onedark")
vim.cmd.colorscheme("onedark_vivid")
