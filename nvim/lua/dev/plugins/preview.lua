return {
    "sylvanfranklin/omni-preview.nvim",
    dependencies = {
        { "chomosuke/typst-preview.nvim" },
        { "toppair/peek.nvim" },
        { "hat0uma/csvview.nvim" },
    },

    opts = {
    },

    keys = {
        {
            "<leader>tp", "<cmd>OmniPreview start<CR>", desc = "OmniPreview start"
        }
    }
}
