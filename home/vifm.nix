{ pkgs, ... }:

{
  programs.vifm = {
    enable = true;
    # Menggunakan package default dari nixpkgs 24.11 -> Vifm 0.13
    # package = pkgs.vifm;

    extraConfig = ''
      " ============================================================================
      "  PENGATURAN DASAR (SETIAP OPSI SUDAH DIPASTIKAN VALID UNTUK VIFM 0.13)
      " ============================================================================
      " Editor
      set vicmd=nvim
      set vixcmd=nvim

      " Tampilan dan Navigasi
      set number
      set scrolloff=5
      set history=100
      set undolevels=100
      set vimhelp

      " Pencarian
      set ignorecase
      set smartcase
      set incsearch
      set hlsearch

      " Perilaku File
      set trash
      set syscalls
      set sortnumbers

      " Pengurutan (Sorting)
      set sort=name
      set sortorder=ascending

      " ============================================================================
      "  KEY MAPPINGS (SEMIRIP RANGER)
      " ============================================================================
      " Navigasi Dasar
      nnoremap h lh
      nnoremap j gj
      nnoremap k gk
      nnoremap l l
      nnoremap gg gg
      nnoremap G G
      nnoremap <C-u> <C-u>
      nnoremap <C-d> <C-d>
      nnoremap <C-f> <C-f>
      nnoremap <C-b> <C-b>

      " Manajemen Tab (Tab)
      nnoremap <C-n> :tabnew<CR>
      nnoremap <C-w> :tabclose<CR>
      nnoremap <Tab> :tabnext<CR>
      nnoremap <S-Tab> :tabprev<CR>
      nnoremap gt :tabnext<CR>
      nnoremap gT :tabprev<CR>
      nnoremap 1 :tab 1<CR>
      nnoremap 2 :tab 2<CR>
      nnoremap 3 :tab 3<CR>
      nnoremap 4 :tab 4<CR>
      nnoremap 5 :tab 5<CR>
      nnoremap 6 :tab 6<CR>
      nnoremap 7 :tab 7<CR>
      nnoremap 8 :tab 8<CR>
      nnoremap 9 :tab 9<CR>

      " Riwayat Direktori
      nnoremap H :history -1<CR>
      nnoremap L :history +1<CR>

      " Operasi File
      nnoremap dd :delete<CR>
      nnoremap yy :yank<CR>
      nnoremap p :paste<CR>
      nnoremap P :paste<CR>
      nnoremap dD :delete!<CR>
      nnoremap dT :trash<CR>
      nnoremap r :rename<CR>
      nnoremap a :rename<CR>

      " Menyalin Nama / Path
      nnoremap yp :execute 'echo @%"'<CR>
      nnoremap yd :execute 'echo %d"'<CR>
      nnoremap yn :execute 'echo %:t"'<CR>
      nnoremap y. :execute 'echo %:t:r"'<CR>

      " Marking / Visual Mode
      nnoremap V :Visual<CR>
      nnoremap v :select<CR>
      nnoremap <Space> :select<CR>

      " Pencarian dan Filter
      nnoremap / :grep<Space>
      nnoremap n :noremap <CR> :next<CR>
      nnoremap N :previous<CR>
      nnoremap f :filter<Space>

      " Perubahan Metode Pengurutan (Sorting)
      nnoremap or :set sortorder=descending<CR>:set sort=name<CR>
      nnoremap os :set sort=size<CR>
      nnoremap ob :set sort=name<CR>
      nnoremap on :set sort=name<CR>
      nnoremap om :set sort=time<CR>
      nnoremap ot :set sort=type<CR>
      nnoremap oa :set sort=atime<CR>

      " Tombol Toggle
      "   'za' untuk toggle (menampilkan/menyembunyikan) file tersembunyi (dotfiles)
      "   'zo' untuk menampilkan file tersembunyi
      "   'zm' untuk menyembunyikan file tersembunyi
      "   'zd' untuk menyembunyikan file yang dipilih dari tampilan
      nnoremap zh :windo set hidden!<CR> 
      nnoremap zd :windo set sortorder!<CR>

      " Lompat Cepat ke Direktori
      nnoremap gh :cd ~<CR>
      nnoremap ge :cd /etc<CR>
      nnoremap gu :cd /usr<CR>
      nnoremap gd :cd /dev<CR>
      nnoremap go :cd /opt<CR>
      nnoremap gv :cd /var<CR>
      nnoremap gp :cd /tmp<CR>
      nnoremap gr :cd /<CR>

      " Keluar & Refresh
      nnoremap q :quit<CR>
      nnoremap Q :quit!<CR>
      nnoremap R :refresh<CR>
      nnoremap <C-l> :redraw<CR>
      nnoremap ? :help<CR>

      " Inspeksi & Edit
      nnoremap i :file<CR>
      nnoremap E :edit<CR>

      " Shell
      nnoremap s :!!$SHELL<CR>
      nnoremap S :!!$SHELL<CR>
      nnoremap ! :!!<CR>

      " Bookmark
      nnoremap m :mark<Space>
      nnoremap ' :goto<Space>

      " Tampilan Status Bar
      set statusline=" %t %= %M %C"
    '';
  };
}
