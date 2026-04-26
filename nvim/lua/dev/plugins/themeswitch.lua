return {
    {
        "thesimonho/kanagawa-paper.nvim",
        lazy = true,
        config = function()
            require('kanagawa-paper').setup({
                transparent = false,
                gutter = false,

                styles = {
                    comment = { italic = false },
                    functions = { italic = false },
                    keyword = { italic = false, bold = false },
                    statement = { italic = false, bold = false },
                    type = { italic = false },
                },
           })
        end,
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = true,
        config = function()
            require("rose-pine").setup({
                variant = "main",
                dark_variant = "main",

                styles = {
                    bold = true,
                    italic = false,
                    transparency = false,
                },
            })
        end,
    },
    {
        "vague2k/vague.nvim",
        lazy = true,
        config = function()
            require("vague").setup({
                transparent = false,
                italic = false,
            })
        end
    },
    {
        "ellisonleao/gruvbox.nvim",
        lazy = true,
        config = function()
            require("gruvbox").setup({
                transparent_mode = false,
                italic = {
                    strings = false,
                    emphasis = false,
                    comments = false,
                    operators = false,
                    folds = false,
                }
            })
        end
    },
    {
        "projekt0n/github-nvim-theme",
        lazy = true,
        config = function()
            require("github-theme").setup({
                options = {
                    hide_end_of_buffer = true,
                    transparent = false,

                    styles = {
                        comments = 'NONE',
                        functions = 'NONE',
                        keywords = 'NONE',
                        variables = 'NONE',
                        conditionals = 'NONE',
                        constants = 'NONE',
                        numbers = 'NONE',
                        operators = 'NONE',
                        strings = 'NONE',
                        types = 'NONE',
                    },
                },
            })
        end
    },
    {
        "folke/tokyonight.nvim",
        lazy = true,
        priority = 0,
        config = function()
            require("tokyonight").setup({
                transparent = false,

                styles = {
                    comments = { italic = false },
                    keywords = { italic = false },
                },
            })
        end
    },
    {
        "savq/melange-nvim",
        lazy = true,
        priority = 0,
    },
    {
        "catppuccin/nvim",
        lazy = true,
        priority = 0,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha",
                transparent_background = false,
                no_italic = false,

                styles = {
                    comments = {},
                    conditionals = {},
                    loops = {},
                    functions = {},
                    keywords = {},
                    strings = {},
                    variables = {},
                    numbers = {},
                    booleans = {},
                    properties = {},
                    types = {},
                    operators = {},
                    miscs = {},
                }
            })
        end
    },
    {
        "datsfilipe/vesper.nvim",
        lazy = false, -- Keep as default
        priority = 1000,
        config = function()
            -- Path to store the current theme
            local theme_file = vim.fn.stdpath("data") .. "/current_theme.txt"

            require('vesper').setup({
                transparent = false,

                italics = {
                    comments = false,
                    keywords = false,
                    functions = false,
                    strings = false,
                    variables = false,
                },
            })

            -- Available colorschemes
            local colorschemes = {
                vesper = "vesper",
                kanagawa = "kanagawa-paper",
                rosepine = "rose-pine-moon",
                vague = "vague",
                gruvbox = "gruvbox",
                github = "github_dark_tritanopia",
                tokyonight = "tokyonight-moon",
                melange = "melange",
                catppuccin = "catppuccin",
            }

            -- Function to save current theme
            local function save_theme(theme_name)
                local file = io.open(theme_file, "w")

                if file then
                    file:write(theme_name)
                    file:close()
                end
            end

            -- Function to load saved theme
            local function load_saved_theme()
                local file = io.open(theme_file, "r")

                if file then
                    local theme_name = file:read("*line")
                    file:close()

                    return theme_name
                end

                return "rose-pine-moon" -- default fallback
            end

            -- Function to safely set colorscheme
            local function set_colorscheme(name)
                local scheme = colorschemes[name]

                if not scheme then
                    vim.notify("colorscheme '" .. name .. "' not found!", vim.log.levels.ERROR)

                    return false
                end

                local ok, _ = pcall(vim.cmd.colorscheme, scheme)
                if ok then

                    -- get rid of italics for melange them
                    if name == "melange" then
                        local highlights = vim.api.nvim_get_hl(0, {})

                        for group, opts in pairs(highlights) do
                            if opts.italic then
                                vim.api.nvim_set_hl(0, group, vim.tbl_extend("force", opts, { italic = false }))
                            end
                        end
                    end

                    save_theme(name) -- Save the theme when successfully set

                    return true
                else
                    vim.notify("failed to load " .. name .. " colorscheme", vim.log.levels.ERROR)
                    return false
                end
            end

            -- Load and set the saved theme on startup
            local saved_theme = load_saved_theme()
            set_colorscheme(saved_theme)

            -- Create user commands
            vim.api.nvim_create_user_command("ColorVesper", function()
                set_colorscheme("vesper")
            end, { desc = "switch to vesper colorscheme" })

            vim.api.nvim_create_user_command("ColorKanagawa", function()
                set_colorscheme("kanagawa")
            end, { desc = "switch to kanagawa colorscheme" })

            vim.api.nvim_create_user_command("ColorRosePine", function()
                set_colorscheme("rosepine")
            end, { desc = "switch to rosepine moon colorscheme" })

            vim.api.nvim_create_user_command("ColorVague", function()
                set_colorscheme("vague")
            end, { desc = "switch to Vague colorscheme "})

            vim.api.nvim_create_user_command("ColorGruv", function()
                set_colorscheme("gruvbox")
            end, { desc = "switch to gruvbox colorscheme "})

            vim.api.nvim_create_user_command("ColorGit", function()
                set_colorscheme("github")
            end, { desc = "switch to github colorscheme "})

            vim.api.nvim_create_user_command("ColorTokyo", function()
                set_colorscheme("tokyonight")
            end, { desc = "switch to tokyonight colorscheme "})

            vim.api.nvim_create_user_command("ColorMelange", function()
                set_colorscheme("melange")
            end, { desc = "switch to melange colorscheme "})

            vim.api.nvim_create_user_command("ColorCatpuccin", function()
                set_colorscheme("catppuccin")
            end, { desc = "switch to catppuccin colorscheme "})

            -- Generic command that takes colorscheme name as argument
            vim.api.nvim_create_user_command("SwitchTheme", function(opts)
                local name = opts.args
                if name == "" then
                    -- Show available colorschemes if no argument provided
                    local available = {}

                    for key, _ in pairs(colorschemes) do
                        table.insert(available, key)
                    end

                    vim.notify("available colorschemes: " .. table.concat(available, ", "), vim.log.levels.INFO)
                else
                    set_colorscheme(name)
                end
            end, {
                    nargs = "?",
                    complete = function()
                        local options = {}

                        for key, _ in pairs(colorschemes) do
                            table.insert(options, key)
                        end

                        return options
                    end,
                    desc = "switch colorscheme (shows available options if no args)"
                })

            -- Keymaps for quick switching
            local keymap = vim.keymap
            keymap.set("n", "<leader>cvp", function() set_colorscheme("vesper") end, { desc = "switch to vesper" })
            keymap.set("n", "<leader>ck", function() set_colorscheme("kanagawa") end, { desc = "switch to kanagawa" })
            keymap.set("n", "<leader>cr", function() set_colorscheme("rosepine") end, { desc = "switch to rosepine moon" })
            keymap.set("n", "<leader>cvg", function() set_colorscheme("vague") end, { desc = "switch to vague" })
            keymap.set("n", "<leader>cgb", function() set_colorscheme("gruvbox") end, { desc = "switch to gruvbox" })
            keymap.set("n", "<leader>cgh", function() set_colorscheme("github") end, { desc = "switch to github" })
            keymap.set("n", "<leader>ct", function() set_colorscheme("tokyonight") end, { desc = "switch to tokyonight" })
            keymap.set("n", "<leader>cm", function() set_colorscheme("melange") end, {desc = "switch to melange" })
            keymap.set("n", "<leader>ccp", function() set_colorscheme("catppuccin") end, {desc = "switch to catppuccin" })

            -- Cycle through colorschemes
            local scheme_list = {
                "vesper",
                "kanagawa",
                "rosepine",
                "vague",
                "gruvbox",
                "github",
                "tokyonight",
                "melange",
                "catppuccin",
            }

            -- Set current_index based on saved theme
            local current_index = 1
            for i, theme in ipairs(scheme_list) do
                if theme == saved_theme then
                    current_index = i
                    break
                end
            end

            keymap.set("n", "<leader>cf", function()
                current_index = current_index % #scheme_list + 1
                set_colorscheme(scheme_list[current_index])
            end, { desc = "cycle to next colorscheme" })

            keymap.set("n", "<leader>cp", function()
                current_index = current_index - 1

                if current_index < 1 then
                    current_index = #scheme_list
                end

                set_colorscheme(scheme_list[current_index])
            end, { desc = "cycle to previous colorscheme" })
        end,
        opts = {},
    }
}
