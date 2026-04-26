return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local lualine = require("lualine")
        local lazy_status = require("lazy.status")

        local theme_file = vim.fn.stdpath("data") .. "/current_theme.txt"

        local function get_current_theme()
            local file = io.open(theme_file, "r")

            if file then
                local theme_name = file:read("*line")
                file:close()

                return theme_name
            end

            return "vague"
        end

        local theme_map = {
            vesper = "auto",
            kanagawa = "auto",
            rosepine = "auto",
            vague = "auto",
            gruvbox = "auto"
        }

        local function get_lualine_theme()
            local current_theme = get_current_theme()
            local lualine_theme = theme_map[current_theme]

            if not lualine_theme then
                return "auto"
            end

            return lualine_theme
        end

        local function setup_lualine()
            lualine.setup({
                options = {
                    theme = get_lualine_theme(),
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "", right = "" },
                    disabled_filetypes = { "NvimTree", "dashboard" }
                },

                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff", "diagnostics" },
                    lualine_c = { { "filename", path = 1 } },
                    lualine_x = {
                        {
                            lazy_status.updates,
                            cond = lazy_status.has_updates,
                        },
                        "encoding",
                        "fileformat",
                        "filetype"
                    },
                    lualine_y = { "progress" },
                    lualine_z = { "location" }
                },
            })
        end

        setup_lualine()

        vim.api.nvim_create_autocmd("ColorScheme", {
            pattern = "*",
            callback = function()
                vim.defer_fn(function()
                    setup_lualine()
                end, 50)
            end,
            desc = "update lualine when theme changes"
        })
    end,
}
