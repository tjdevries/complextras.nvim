# complextras.nvim

Some fun extenstions / extras for ins-completion in neovim

Provides completion for:
- Matching lines (not exact matches)
- Exact matching lines in directory (do not have to open directory)
    - Works better if ripgrep is installed.


You can

## Installation

```
Plug 'nvim-lua/plenary.nvim'
Plug 'tjdevries/complextras.nvim'
```


## Usage

You can map things like this:

```
inoremap <c-x><c-d> <c-r>=luaeval("require('complextras').complete_line_from_cwd()<CR>
```

See `:help complextras`
