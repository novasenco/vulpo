" Author: Nova Senco
" Last Change: 06 October 2020
" Description: dark, naturalistic, retro colorscheme

" setup {{{1

hi clear
if exists('syntax_on')
  syntax reset
endif
let colors_name = 'vulpo'
if &background isnot 'dark'
  set background=dark
endif


let s:fg  = get(g:, 'vulpo_wood') ? 137 : 187
let s:gfg = get(g:, 'vulpo_wood') ? '#af875f' : '#d7d7af'
let s:bg  = 234
let s:gbg = '#1c1c1c'
let s:palette = [
\ '238', '167',  '65', '173',  '66',  '95', '101', '187',
\ '241', '203', '107', '180', '109', '140',  '72', '251', ]
let s:xpalette = [
\ '#444444', '#d75f5f', '#5f875f', '#d7875f', '#5f8787', '#875f5f', '#87875f', '#d7d7af',
\ '#626262', '#ff5f5f', '#87af5f', '#d7af87', '#87afaf', '#af87d7', '#5faf87', '#c6c6c6', ]
let s:atmap = {'B':'bold', 'R':'reverse', 'I':'italic', 'U':'underline'}
let s:alt16 = {'233fg':0, '233bg':'NONE', '235fg':0, '235bg':0, '236fg':0, '236bg':0}
let s:altx = {'233':'#121212', '235':'#262626', '236':'#303030', }
let s:t_Co = exists('&t_Co') && !empty(&t_Co) && &t_Co > 1 ? &t_Co : 2
let s:type = has('gui_running') || exists('termguicolors') && &termguicolors || s:t_Co >= 256 ? 0 : s:t_Co >= 16 ? 1 : 2

if has('gui_running') || has('termguicolors') && &termguicolors
  let g:terminal_ansi_colors = copy(s:xpalette)
endif
if has('nvim')
  for ind in range(16)
    exe 'let g:terminal_color_'.ind '=' string(s:xpalette[ind])
  endfor
endif

fun! s:hi(g, at, fg, bg, lat, lfg, lbg)
  let at = join(map(split(a:at, '\zs'), "get(s:atmap, v:val, 'NONE')"), ',')
  let gat = at
  let fg = a:fg !~ '^\d\+$' ? 'NONE' : a:fg < 16 ? s:palette[a:fg] : a:fg
  let bg = a:bg !~ '^\d\+$' ? 'NONE' : a:bg < 16 ? s:palette[a:bg] : a:bg
  let gfg = fg is 'NONE' ? 'NONE' : a:fg < 16 ? s:xpalette[a:fg] :
  \ get(s:altx, a:fg, 'NONE')
  let gbg = bg is 'NONE' ? 'NONE' : a:bg < 16 ? s:xpalette[a:bg] :
  \ get(s:altx, a:bg, 'NONE')
  if s:type is 1
    let fg = a:fg !~ '^\d\+' ? 'NONE' : a:fg < 16 ? a:fg : a:fg == s:fg ? 'NONE' :
    \ a:fg == s:bg ? 0 :  s:alt16[a:fg.'fg']
    let bg = a:bg !~ '^\d\+' ? 'NONE' : a:bg < 16 ? a:bg : a:bg == s:bg ? 'NONE' :
    \ a:bg == s:fg ? 7 :  s:alt16[a:bg.'bg']
  elseif s:type is 2
    let fg = a:lfg !~ '^\d\+$' ? 'NONE' : a:lfg
    let bg = a:lbg !~ '^\d\+$' ? 'NONE' : a:lbg
    let at = join(map(split(a:lat, '\zs'), { _,at -> get(s:atmap, at, 'NONE') }), ',')
  endif
  exe 'hi' a:g 'cterm='.at 'ctermfg='.fg 'ctermbg='.bg 'gui='.at 'guifg='.gfg 'guibg='.gbg
endfun

com! -buffer -nargs=+ -bar Hi call <sid>hi(<f-args>)

" :help group-name  {{{1

Hi Comment - 8 - - 7 -
Hi Ignore  - 8 - - 7 -

Hi Constant - 1 - - 1 -
Hi String   - 2 - - 2 -

Hi Identifier - 11 - B 3 -

hi! link Function Identifier
hi! link PreProc  Identifier
hi! link Special  Identifier
hi! link Type     Identifier

Hi Statement - 3 - - 3 -
Hi Tag       U 3 - B 3 -

Hi Bold       B - - B - -
Hi Italic     B 6 - B 4 -
Hi Underlined U - - B 5 -

hi! link HtmlBold   Bold
hi! link HtmlItalic Italic

Hi Error BR 1 - BR 1 7
Hi Todo  BR 2 - BR 2 7

" :help highlight-groups  {{{1

exe printf('hi Normal ctermfg=%d ctermbg=%d guifg=%s guibg=%s', s:fg, s:bg, s:gfg, s:gbg)

hi! link Terminal Normal

Hi StatusLine   - 15 0   - 0 6
Hi StatusLineNC - 11 236 B 6 0

hi! link StatusLineTerm   StatusLine
hi! link StatusLineTermNC StatusLineNC

Hi TabLine     - 11 0   - 3 -
Hi TabLineFill - 2  233 - 6 -
Hi TabLineSel  B 11 8   B 3 -

Hi Pmenu      - 3  0 - 3 0
Hi PmenuSel   - 11 8 B 3 0
Hi PmenuSbar  R 0  - - 6 0
Hi PmenuThumb R 2  - - 0 6

Hi WildMenu BR 3 - BR 3 -

Hi Title      B 4  -   - 3 -
Hi SpecialKey - 4  -   B 6 -

Hi NonText     - 4 233 B 6 -
hi! link EndOfBuffer NonText 
hi! link Folded      NonText 

Hi Search       BR 3  -   - 0 3
Hi IncSearch    BR 11 -   B 0 3
Hi QuickFixLine B  -  236 B - -

Hi Conceal  B 6  - - 7 -
Hi Cursor   R 15 - R 0 7
Hi lCursor  R 15 - R 0 7
Hi CursorIM R 15 - R 0 7

Hi Directory - 12 - B 4 -

Hi ErrorMsg   BR 1  - R 1 -
Hi WarningMsg BR 11 - R 3 -

Hi ModeMsg    B  3 - B 3 -

hi! link MoreMsg  ModeMsg
hi! link Question ModeMsg

Hi SpellBad   BR 1 - BR 1 7
Hi SpellCap   BR 1 - BR 1 7
Hi SpellLocal BR 1 - BR 1 7
Hi SpellRare  BR 1 - BR 1 7

Hi DiffAdd     BR 2  - BR 2 -
Hi DiffDelete  -  5  5 -  1 1
Hi DiffChange  R  6  - R  6 -
Hi DiffText    BR 11 - R  3 -

Hi DiffAdded   B 2 236 R 2 -
Hi DiffRemoved B 1 236 R 1 -

Hi ColorColumn  - - 235 - - -
Hi CursorColumn - - 235 - - -
Hi CursorLine   - - 235 - - -

Hi Visual    - 6 0 - 5 -
Hi VisualNOS - 6 0 - 5 -

Hi VertSplit - 2 0 B 6 -

Hi LineNr       - 11 236 B 3 -
Hi CursorLineNr - 1  236 B 1 -
Hi LineNrAbove  - 11 236 B 3 -
Hi LineNrBelow  - 11 236 B 3 -
Hi FoldColumn   - 1  236 B 1 -
Hi SignColumn   - 11 236 - 3 -

Hi MatchParen BR 3 - BR 3 -

delc Hi

if get(g:, 'vulpo_ft_mods', 1) " ft-specific modifications {{{1

  hi! link cStorageClass Statement
  hi! link cEnum         Statement
  hi! link cTypedef      Statement

  hi! link cMacroName            Identifier
  hi! link cDataStructureKeyword Identifier

  hi! link vimHiAttrib     Constant
  hi! link vimCommentTitle Title

endif " }}}

" vim: set cole=0 syn=off:
