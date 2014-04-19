vmap <silent> <leader>aa :call SwapAround()<CR>
vmap <silent> <leader>a, :call SwapAround(',')<CR>
vmap <silent> <leader>a. :call SwapAround('\.')<CR>
vmap <silent> <leader>a; :call SwapAround(';')<CR>
vmap <silent> <leader>a<Space> :call SwapAround("[ \t\n]*")<CR>

function! SwapAround(...) range
  if 1 == a:0
    let exp = a:1
  else
    call inputsave()
    let exp = input('pivot:')
    call inputrestore()
  endif
  if exp !~ '[ \t\n]' 
    let exp = '[ \t\n]*'.exp.'[ \t\n]*'
  endif
  call s:SwapAroundBase(exp, getpos("'<"), getpos("'>"))
endfunction

function! s:SwapAroundBase(sepExp, start, end) range
    let save_a = @a
    try
      let originalText = s:getText(a:start, a:end)
      let sepStart = match(originalText, a:sepExp)
      let sepEnd = matchend(originalText, a:sepExp)
      let firstOne = strpart(originalText, 0, sepStart)
      let sep = strpart(originalText, sepStart, sepEnd - sepStart)
      let secondOne = strpart(originalText, sepEnd)
      let @a = secondOne.sep.firstOne
      let posStatus = setpos(".", a:start)
      normal! v
      let posStatus = setpos(".", a:end)
      normal "ap
    finally
      let @a = save_a
    endtry
endfunction

function! s:getText(start, end)
  let lines = getline(a:start[1], a:end[1])
  let lines[-1] = lines[-1][: a:end[2] - 1]
  let lines[0] = lines[0][a:start[2] - 1:]
  return join(lines, "\n")
endfunction
