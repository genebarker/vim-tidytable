# Vim Tidy Table

A Vim plugin for tidying markdown pipe tables (see `pipe_tables` in
[Pandoc Markdown][1]). Pipe tables are widely supported and work well in
[Github Markdown][2] and [PHP Markdown Extra][3].

Currently, this plugin only supports tidying the simple form:

```md
No  | Color | Notes
--- | ----- | --------------------
1   | Red   | Can symbolize danger
2   | White | Too bright
3   | Blue  | A great color
```

**Note** that the header line requires a minimum of 3 dashes.

## Installation

This plugin requires the [Tabular][4] plugin. So install both using your
favorite plugin manager like [vim-plug][5], for example:

```vim
Plug 'godlygeek/tabular'
Plug `genebarker/vim-tidytable'
```


[1]: https://pandoc.org/MANUAL.html#pandocs-markdown
[2]: https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/organizing-information-with-tables
[3]: https://michelf.ca/projects/php-markdown/extra/#table
[4]: https://github.com/godlygeek/tabular
[5]: https://github.com/junegunn/vim-plug
