"this is for using the plugin to fix open and close pairs
execute pathogen#infect()

"using indentation with C files
set autoindent
set cindent
set shiftwidth=4
set smartindent
set softtabstop=4

"Display the position of the cursor
set ruler

"Highlight two side-by-side spaces
highlight	DoubleWSpace ctermbg=red guibg=red
match		DoubleWSpace /  /

"Hoghlight a whitespace before a line break
autocmd InsertEnter * syn clear EOLWS | syn match EOLWS excludenl /\s\+\%#\@!$/
autocmd InsertLeave * syn clear EOLWS | syn match EOLWS excludenl /\s\+$/
highlight EOLWS ctermbg=white guibg=white

"Configuration of backup files
silent !mkdir -p ~/.vim/.backup
set backup
set backupdir=~/.vim/.backup//

"42 Header creation
noremap <C-c><C-h> :call Header()<enter>

autocmd BufWritePre *.c :call Update()
autocmd BufNewFile *.c :call Header()

"updating header's time
function! Update()
	if &modified
		return 0
	endif
	let date = strftime('%Y/%m/%d')
	let hour = strftime('%H:%M:%S')
	let updated = "/*   Updated: ".date." ".hour." by ".$USER
	let i = 17 - strwidth($USER)
	while i > 0
		let updated = updated . " "
		let i = i - 1
	endwhile
	let updated = updated . "###   ########.fr       */"
	call setline(9, updated)
endfunction

"creation of the header
function! Header()

	let filename = "/*   ".expand('%:t')
	let i = 50 - strwidth(expand('%:t'))
	while i > 0
		let filename = filename . " "
		let i = i - 1
	endwhile
	let filename = filename . " :+:      :+:    :+:   */"

	if !empty($MAIL)
		let mail = $MAIL
	else
		let mail = "marvin@42.fr"
	endif

	let author = "/*   By: ".$USER." <".mail.">"
	let authorlength = strwidth($USER) + strwidth(mail)
	let i = 40 - authorlength
	while i > 0
		let author = author . " "
		let i = i - 1
	endwhile
	let author = author . "+#+  +:+       +#+        */"

	let date = strftime('%Y/%m/%d')
	let hour = strftime('%H:%M:%S')
	let i = 18 - strwidth($USER)
	let created = "/*   Created: ".date." ".hour." by ".$USER
	while i > 0
		let created = created . " "
		let i = i - 1
	endwhile
	let created = created . "#+#    #+#             */"

	let updated = "/*   Updated: ".date." ".hour." by ".$USER
	let i = 17 - strwidth($USER)
	while i > 0
		let updated = updated . " "
		let i = i - 1
	endwhile
	let updated = updated . "###   ########.fr       */"

	:normal gg
	call append(0, "/* ************************************************************************** */")
	call append(1, "/*                                                                            */")
	call append(2, "/*                                                        :::      ::::::::   */")
	call append(3, filename)
	call append(4, "/*                                                    +:+ +:+         +:+     */")
	call append(5, author)
	call append(6, "/*                                                +#+#+#+#+#+   +#+           */")
	call append(7, created)
	call append(8, updated)
	call append(9, "/*                                                                            */")
	call append(10, "/* ************************************************************************** */")
endfunction
