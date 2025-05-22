-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require("lspconfig")

local nvlsp = require "nvchad.configs.lspconfig"

local on_clangd_attach = function (_, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

lspconfig.clangd.setup({
    -- on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    on_attach = on_clangd_attach,
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    -- capabilities = nvlsp.capabilities,
    cmd = { "clangd", "--background-index" },
    filetypes = { "c", "cpp", "objc", "objcpp", "h" },
    single_file_support = true,
    flags = {
        debounce_text_changes = 150,
    },
    root_dir = lspconfig.util.root_pattern(
        '.clangd',
        '.clang-tidy',
        '.clang-format',
        'compile_commands.json',
        'compile_flags.txt',
        'configure.ac',
        '.git'
    )
})
lspconfig.lua_ls.setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
}

-- treesitter
require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "bash",
        "c",
        "cpp",
        "make",
        "lua",
        "luadoc",
        "markdown",
        "printf",
        "toml",
        "vim",
        "yaml"
    },
    highlight = {
        enable = true,
        use_languagetree = true,
    },
    indent = { enable = true },
})
