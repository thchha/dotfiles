if exists("s:ticky_beeing")
	finish 
endif
let s:ticky_beeing = 1

let g:sticky_suggestion_min_length = 2

inoremap <expr> <cr> sticky_suggestion#accept()

" takes the first suggestion. 
function! sticky_suggestion#accept()
	if pumvisible() == 1
		return "\<c-n>\<esc>\a"
	else
		return "\<cr>"
	endif
endfunction

augroup StickySuggestionMenuGroup
	au!
	"au TextChangedI * noautocmd call s:onKeystroke()
	au InsertCharPre * noautocmd call s:onKeystroke()
augroup end

function! s:onKeystroke()
	if pumvisible() == 1 | return | endif
	let p = 1
	while p < g:sticky_suggestion_min_length
		let p += 1
		let cc = getline('.')[col('.')-p] =~ '\K'
		if cc == 0 | return | endif
	endwhile
	
	if &omnifunc == '' 
		call feedkeys("\<c-x>\<c-n>")
		return
	endif
	call feedkeys("\<c-x>\<c-o>")
endfunction
