# Vim Tidy Table

A Vim plugin for tidying markdown pipe tables (see `pipe_tables` in
[Pandoc Markdown][1]).

Currently, this plugin only supports tidying the simple form:

```markdown
No  | Color | Notes
--- | ----- | --------------------
1   | Red   | Can symbolize danger
2   | White | Too bright
3   | Blue  | A great color
```

**Note** that the header line requires a minimum of 3 dashes.

## Installation

This plugin requires the [Tabular][2] plugin. Just install using your
favorite plugin manager like [vim-plug][3], for example:

```vimscript
Plug 'godlygeek/tabular'
Plug `genebarker/vim-tidytable'
```


[1]: https://pandoc.org/MANUAL.html#pandocs-markdown
[2]: https://github.com/godlygeek/tabular
[3]: https://github.com/junegunn/vim-plug
