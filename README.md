# vim-pcgen

A Vim plugin to ease the visualization of dense PCGen LST files.

## Features

- Converts tab-separated PCGen LST files into a more readable multi-line format
- Preserves the ability to convert back to the original tab-separated format
- Automatically converts back to tab-separated format when saving the file

## Usage

When editing a PCGen LST file:

- Press `<F2>` to convert from tabbed format to multi-line format for easier reading
- Press `<F3>` to convert back to tabbed format
- The file will automatically be converted back to tabbed format when saving

## Implementation Details

The plugin provides two main functions:

1. `pcgen#tabbedToMultiLine()`: Converts tab-separated format to multi-line format by:
   - Doubling all newlines to mark original line breaks
   - Replacing tabs with a newline and a tab, while keeping consecutive tabs on the original line

2. `pcgen#multiLineToTabbed()`: Converts multi-line format back to tab-separated format by:
   - Replacing newlines followed by a tab with just a tab
   - Converting double newlines back to single newlines

## Testing

Test scripts are provided to verify that the transformation is reversible:

### Automated Testing

Run all tests using the provided shell script:

```
cd ~/.vim/plugged/vim-pcgen/test
chmod +x run_tests.sh
./run_tests.sh
```

### Manual Testing

You can also run the tests individually:

```
cd ~/.vim/plugged/vim-pcgen/test
vim -S test_pcgen.vim  # Automated test
vim -S manual_test.vim  # Manual test with visual output
```

The tests load the sample.lst file, apply both transformations, and verify that the content is correctly restored, including blank lines between entries.

# Installation #

This uses [https://github.com/junegunn/vim-plug](vim-plug). Install that first, then add vim-pcgen to the dependencies by putting something like this in your `.vimrc`.

```
call plug#begin('~/.vim/plugged')

" List your plugins here
Plug 'tpope/vim-sensible'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug '/Users/allard/.vim/plugged/vim-pcgen'

call plug#end()

syntax on
filetype plugin indent on
```

## License

This plugin is provided under the same license as Vim itself.
