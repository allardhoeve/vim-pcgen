" Manual test script to visualize the transformation process
" This script shows the intermediate steps of the transformation

" Load the plugin
source ../ftplugin/pcgen.vim

" Function to run the manual test
function! RunManualTest()
  " Clear any existing buffer
  silent! %delete _
  
  " Load the sample file
  silent! execute "read ../sample.lst"
  " Remove the first empty line
  silent! 1delete _
  
  " Save the original content
  let original_lines = getline(1, '$')
  
  echo "=== ORIGINAL CONTENT ==="
  for line in original_lines
    echo line
  endfor
  
  " Apply tabbedToMultiLine
  let b:did_conversion = 0
  call pcgen#tabbedToMultiLine()
  
  let multiline_lines = getline(1, '$')
  
  echo "\n=== AFTER tabbedToMultiLine ==="
  for line in multiline_lines
    echo line
  endfor
  
  " Apply multiLineToTabbed
  call pcgen#multiLineToTabbed()
  
  let restored_lines = getline(1, '$')
  
  echo "\n=== AFTER multiLineToTabbed ==="
  for line in restored_lines
    echo line
  endfor
  
  " Compare original and restored content
  let original_content = join(original_lines, "\n")
  let restored_content = join(restored_lines, "\n")
  
  if original_content ==# restored_content
    echo "\nTEST PASSED: Content was correctly restored!"
  else
    echo "\nTEST FAILED: Content was not correctly restored!"
    
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
call RunManualTest()

" Exit vim after running the test
" quitall!