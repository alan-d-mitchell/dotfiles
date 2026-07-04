if vim.b.current_syntax then
    return
end

vim.b.current_syntax = "mir"

local function syn_keyword(group, keywords)
    vim.cmd(string.format(
        "syntax keyword %s %s",
        group,
        table.concat(keywords, " ")
    ))
end

local function syn_match(group, pattern, extra)
    vim.cmd(string.format(
        "syntax match %s /%s/ %s",
        group,
        pattern,
        extra or ""
    ))
end

local function syn_region(group, start, stop, opts)
    vim.cmd(string.format(
        "syntax region %s start=/%s/ end=/%s/ %s",
        group,
        start,
        stop,
        opts or ""
    ))
end

-- comments

vim.cmd([[syntax region mir_comment start=+//+ end=+$+ oneline]])

-- keywords

syn_keyword("mir_keyword", {
    "fn",
    "let",
    "mut",
    "const",
    "move",
    "drop",
    "call",
    "builtin",
    "goto",
    "return",
    "unreachable",
    "switch_int",
    "true",
    "false",
    "as",
})

-- locals

syn_match("mir_local", [[\<_[0-9]\+\>]])

-- basic blocks

syn_match("mir_basic_block", [[\<bb[0-9]\+\>]])

-- types

syn_match("mir_type", [[->\s*\zs[A-Za-z_][A-Za-z0-9_:<>]*]])

syn_match("mir_user_type", [[\<[A-Z][A-Za-z0-9_]*\>]])

-- numbers

syn_match("mir_number", [[\<\d\+\>]])

syn_match("mir_number", [[\<0x[0-9a-fA-F]\+\>]])

-- strings

syn_match("mir_escape", [[\\.]], "contained")

syn_region(
    "mir_string",
    '"',
    '"',
    'oneline contains=mir_escape'
)

-- operators

vim.cmd([[syntax match mir_operator /=/]])
vim.cmd([[syntax match mir_operator /->/]])
vim.cmd([[syntax match mir_operator /&/]])
vim.cmd([[syntax match mir_operator /\*/]])
vim.cmd([[syntax match mir_operator /,/]])
vim.cmd([[syntax match mir_operator /:/]])

-- projection syntax

syn_match("mir_projection", [[\.[0-9]\+]])

-- switch labels

syn_match("mir_label", [[\<true:\>]])
syn_match("mir_label", [[\<false:\>]])
syn_match("mir_label", [[\<return:\>]])

-- DefIDs such as DefID(12)
syn_match("mir_defid", [[DefID([^)]*)]])

-- aggregate(...)
syn_match("mir_aggregate", [[\<aggregate\ze(]])

-- builtin function names
syn_match("mir_builtin_name", [[\<builtin\s\+\zs\w\+\ze(]])

local function apply_highlights()
    vim.cmd([[
        highlight default link mir_keyword      Keyword

        highlight default link mir_local        Identifier
        highlight default link mir_basic_block  Label

        highlight default link mir_type         Type
        highlight default link mir_user_type    Type

        highlight default link mir_number       Number

        highlight default link mir_string       String
        highlight default link mir_escape       SpecialChar

        highlight default link mir_comment      Comment

        highlight default link mir_operator     Operator
        highlight default link mir_projection   Special

        highlight default link mir_label        Special

        highlight default link mir_defid         Constant
        highlight default link mir_aggregate     Function
        highlight default link mir_builtin_name  Function
    ]])
end

apply_highlights()

vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = apply_highlights,
})
