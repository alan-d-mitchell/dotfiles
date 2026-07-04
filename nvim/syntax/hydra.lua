if vim.b.current_syntax then
    return
end

vim.b.current_syntax = "hydra"

local function syn_keyword(group, keywords)
    vim.cmd(string.format("syntax keyword %s %s", group, table.concat(keywords, " ")))
end

local function syn_match(group, pattern, extra)
    vim.cmd(string.format("syntax match %s /%s/ %s", group, pattern, extra or ""))
end

local function syn_region(group, start, stop, opts)
  local extra = opts or ""

  vim.cmd(string.format("syntax region %s start=/%s/ end=/%s/ %s", group, start, stop, extra))
end

vim.cmd([[syntax region hydra_comment start=+//+ end=+$+ oneline]])

vim.cmd([[syntax region hydra_block_comment start=+/\*+ end=+\*/+]])

syn_keyword("hydra_keyword", {
    "let", "const", "fn", "struct", "extension",
    "trait", "return", "include", "extern", "pub",
    "loop", "mut"
})

syn_keyword("hydra_conditional", {
     "if", "else", "match"
})

syn_keyword("hydra_repeat", {
    "for", "foreach", "while"
})

syn_keyword("hydra_statement", {
    "break", "continue", "in", "on", "as", "where"
})

syn_keyword("hydra_type", {
    "i8", "i16", "i32", "i64", "isize",
    "u8", "u16", "u32", "u64", "usize",
    "f32", "f64",
    "bool", "char", "void",
})

syn_keyword("hydra_special", {
    "anysize", "self", "call", "builtin"
})

syn_keyword("hydra_boolean", {
    "true", "false"
})

syn_keyword("hydra_builtin", {
    "println", "print"
})

syn_match("hydra_user_type", [[\<[A-Z][A-Za-z0-9_]*\>]])

syn_match("hydra_function_call", [[\(::\)\@<=\w\+]])

syn_match("hydra_escape", [[\\.]], "contained")

syn_match("hydra_number", [[\<\d\+\(\.\d\+\)\?\>]])

syn_match("hydra_number", [[\<0x[0-9a-fA-F]\+\>]])

syn_match("hydra_char", [[\('[^'\\]\|'\\.\)']])

vim.cmd([[syntax match hydra_operator /&&/]])
vim.cmd([[syntax match hydra_operator /||/]])
vim.cmd([[syntax match hydra_operator /!=/]])
vim.cmd([[syntax match hydra_operator /==/]])
vim.cmd([[syntax match hydra_operator /!/]])

syn_region("hydra_string", '"', '"', 'oneline contains=hydra_escape')

local function apply_highlights()
    vim.cmd([[
        highlight default link hydra_keyword        Keyword
        highlight default link hydra_conditional    Conditional
        highlight default link hydra_repeat         Repeat
        highlight default link hydra_statement      Statement
        highlight default link hydra_type           Type
        highlight default link hydra_user_type      Type
        highlight default link hydra_special        Special
        highlight default link hydra_boolean        Boolean
        highlight default link hydra_builtin        Function
        highlight default link hydra_function_call  Function
        highlight default link hydra_string         String
        highlight default link hydra_escape         SpecialChar
        highlight default link hydra_number         Number
        highlight default link hydra_comment        Comment
        highlight default link hydra_block_comment  Comment
        highlight default link hydra_char           Character
        highlight default link hydra_operator       Operator
    ]])
end

apply_highlights()

vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = apply_highlights,
})
