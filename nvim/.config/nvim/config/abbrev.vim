""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""   ABBREVIATIONS   """"""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

cnoreabbrev H vert bo h

iabbrev now. <c-r>=strftime("%d.%m.%Y %H:%M:%S")<cr>
"iabbrev ,, „
"iabbrev '' “

augroup ProgGroup
	au FileType html iabb newhtml <!DOCTYPE html><cr><html lang="en"><cr><head><cr><meta charset="utf-9"><cr><title>$title</title><cr><meta name="description" content=""><cr><meta name="author" content=""><cr><!-- Mobile--><cr><meta name="viewport" content="width=device-width, initial-scale=1"><cr><link rel="stylesheet" href="normalize.css"><cr><link rel="stylesheet" href="initial.css"><cr><link rel="icon" type="image/png" href="images/favicon-16.png"><cr></head><cr><body><cr><footer><cr></footer><cr></body><cr></html>

	au FileType lua iabbr func function
	au FileType lua iabbr fun function
	au FileType lua iabbr eif elseif
	au FileType lua iabbr fori for i,v in ipairs() do<esc>4<left>a
	au FileType lua iabbr for for k,v in pairs() do<esc>4<left>a
augroup end
