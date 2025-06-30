" Test script for pcgen.vim functions
" This script tests that tabbedToMultiLine() and multiLineToTabbed() work correctly
" and that the transformation is reversible

" Load the plugin
source ../ftplugin/pcgen.vim

" Function to run the test
function! RunTest()
  " Clear any existing buffer
  silent! %delete _
  
  " Load the sample file
  silent! execute "read ../sample.lst"
  " Remove the first empty line
  silent! 1delete _
  
  " Save the original content
  let original_lines = getline(1, '$')
  let original_content = join(original_lines, "\n")
  
  echo "Original content loaded. Lines: " . len(original_lines)
  
  " Apply tabbedToMultiLine
  let b:did_conversion = 0
  call pcgen#tabbedToMultiLine()
  
  let multiline_lines = getline(1, '$')
  let multiline_content = join(multiline_lines, "\n")
  
  echo "Converted to multiline. Lines: " . len(multiline_lines)
  
  " Apply multiLineToTabbed
  call pcgen#multiLineToTabbed()
  
  let restored_lines = getline(1, '$')
  let restored_content = join(restored_lines, "\n")
  
  echo "Converted back to tabbed. Lines: " . len(restored_lines)
  
  " Compare original and restored content
  if original_content ==# restored_content
    echo "TEST PASSED: Content was correctly restored!"
  else
    echo "TEST FAILED: Content was not correctly restored!"
    echo "Original line count: " . len(original_lines)
    echo "Restored line count: " . len(restored_lines)
    
    " Show differences
    let i = 0
    let max_lines = max([len(original_lines), len(restored_lines)])
    while i < max_lines
      if i >= len(original_lines)
        echo "Extra line in restored: " . restored_lines[i]
      elseif i >= len(restored_lines)
        echo "Missing line in restored: " . original_lines[i]
      elseif original_lines[i] !=# restored_lines[i]
        echo "Difference at line " . (i+1) . ":"
        echo "  Original: " . original_lines[i]
        echo "  Restored: " . restored_lines[i]
      endif
      let i += 1
    endwhile
  endif
endfunction

" Run the test
call RunTest()

" Exit vim after running the test
" quitall!