if vim.b.current_syntax then
    return
end

vim.b.current_syntax = "chunk"

local function syn_match(group, pattern, extra)
    vim.cmd(string.format("syntax match %s /%s/ %s", group, pattern, extra or ""))
end

-- ── Patterns ──────────────────────────────────────────────────────────────────

-- == SECTION_NAME == headers
vim.cmd([[syntax region chunk_header start=/^== / end=/ ==$/ oneline]])

-- L0000: jump labels
syn_match("chunk_label", [[^L\d\+:]])

-- 4-digit instruction offset at start of line e.g. 0042
syn_match("chunk_offset", [[\s\+\zs\d\{4}\ze\s]])

-- Opcodes — all uppercase words after the offset
syn_match("chunk_opcode", [[\s\+[A-Z][A-Z_]\+\ze\b]])

-- Numeric arguments e.g. the index after the opcode
syn_match("chunk_number", [[\<\d\+\>]])

-- Quoted constant values e.g. 'MAIN' '1' '<FN>'
vim.cmd([[syntax region chunk_constant start=+'+ end=+'+ oneline]])

-- -> L0000 jump targets
syn_match("chunk_jump_target", [[-> L\d\+]])

-- (TYPE: FUNCTION) type annotations
vim.cmd([[syntax region chunk_type start=+(TYPE: + end=+)+ oneline]])

-- ── Highlight links ───────────────────────────────────────────────────────────

local function apply_highlights()
    vim.cmd([[
        highlight default link chunk_header       Title
        highlight default link chunk_label        Label
        highlight default link chunk_offset       LineNr
        highlight default link chunk_opcode       Keyword
        highlight default link chunk_number       Number
        highlight default link chunk_constant     String
        highlight default link chunk_jump_target  Special
        highlight default link chunk_type         Type
    ]])
end

apply_highlights()

vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = apply_highlights,
})
