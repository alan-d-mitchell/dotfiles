if vim.b.current_syntax then
    return
end
vim.b.current_syntax = "vypr"

local function syn_keyword(group, keywords)
    vim.cmd(string.format("syntax keyword %s %s", group, table.concat(keywords, " ")))
end

local function syn_match(group, pattern, extra)
    vim.cmd(string.format("syntax match %s /%s/ %s", group, pattern, extra or ""))
end

-- Comments — must come first so keywords inside them don't match
vim.cmd([[syntax region vypr_comment start=+#+ end=+$+ oneline]])

-- ── Keywords ─────────────────────────────────────────────────────────────────

syn_keyword("vypr_keyword", {
    "def", "return", "pass", "in", "import",
})

syn_keyword("vypr_conditional", {
    "if", "elif", "else",
})

syn_keyword("vypr_repeat", {
    "for", "while",
})

syn_keyword("vypr_statement", {
    "break", "continue",
})

syn_keyword("vypr_type", {
    "int", "float", "bool", "str", "list",
})

syn_keyword("vypr_operator_word", {
    "and", "or", "not",
})

syn_keyword("vypr_boolean", {
    "True", "False", "None",
})

-- ── Patterns ─────────────────────────────────────────────────────────────────

-- User defined types (PascalCase)
syn_match("vypr_user_type", [[\<[A-Z][A-Za-z0-9_]*\>]])

-- Numbers and floats
syn_match("vypr_number", [[\<\d\+\(\.\d\+\)\?\>]])
syn_match("vypr_number", [[\<0x[0-9a-fA-F]\+\>]])
syn_match("vypr_number", [[\<0b[01]\+\>]])
syn_match("vypr_number", [[\<0o[0-7]\+\>]])

-- Escape sequences (contained inside strings)
syn_match("vypr_escape", [[\\.]], "contained")

-- Strings — single and double quoted
vim.cmd([[syntax region vypr_string start=/"/ end=/"/ oneline contains=vypr_escape]])
vim.cmd([[syntax region vypr_string start=/'/ end=/'/ oneline contains=vypr_escape]])

-- Multiline strings (triple quoted)
vim.cmd([[syntax region vypr_multiline_string start=/"""/ end=/"""/]])
vim.cmd([[syntax region vypr_multiline_string start=/'''/ end=/'''/]])

-- Operators
vim.cmd([[syntax match vypr_operator /==/]])
vim.cmd([[syntax match vypr_operator /!=/]])
vim.cmd([[syntax match vypr_operator /<=/]])
vim.cmd([[syntax match vypr_operator />=/]])

-- Function calls — anything followed by (
syn_match("vypr_function_call", [[\<\h\w*\ze\s*(]])

-- ── Highlight links ───────────────────────────────────────────────────────────

local function apply_highlights()
    vim.cmd([[
        highlight default link vypr_keyword             Keyword
        highlight default link vypr_conditional         Conditional
        highlight default link vypr_repeat              Repeat
        highlight default link vypr_statement           Statement
        highlight default link vypr_type                Type
        highlight default link vypr_user_type           Type
        highlight default link vypr_operator_word       Operator
        highlight default link vypr_boolean             Boolean
        highlight default link vypr_number              Number
        highlight default link vypr_string              String
        highlight default link vypr_multiline_string    String
        highlight default link vypr_escape              SpecialChar
        highlight default link vypr_operator            Operator
        highlight default link vypr_function_call       Function
        highlight default link vypr_comment             Comment
    ]])
end

apply_highlights()

vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = apply_highlights,
})
