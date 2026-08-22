{ pkgs, ... }:

{
  programs.vifm = {
    enable = true;
    # Menggunakan package default dari nixpkgs 24.11 -> Vifm 0.13

    extraConfig = ''
      " ============================================================================
      "  PENGATURAN DASAR (VALID UNTUK VIFM 0.13)
      " ============================================================================
      " Editor dan Tampilan
      set vicmd=nvim
      set number
      set scrolloff=5
      set history=100
      set undolevels=100

      " Pencarian
      set ignorecase
      set smartcase
      set incsearch
      set hlsearch

      " Perilaku File
      set trash
      set syscalls
      set sortnumbers

      " Pengurutan
      set sort=name
      set sortorder=ascending

      " ============================================================================
      "  KEY MAPPINGS (SEMIRIP RANGER & SUDAH BENAR)
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

      " Manajemen Tab (Tab Baru & Tutup Tab)
      nnoremap <C-n> :tabnew<CR>       " Tab baru
      nnoremap <C-w> :tabclose<CR>     " Tutup tab
      nnoremap gt :tabnext<CR>         " Tab berikutnya
      nnoremap gT :tabprev<CR>         " Tab sebelumnya

      " Manajemen Panel (Yang Benar: Ctrl + W)
      nnoremap <C-w>h <C-w>h           " Pindah ke panel kiri
      nnoremap <C-w>l <C-w>l           " Pindah ke panel kanan
      nnoremap <Tab> <C-w>l            " Pindah ke panel kanan (opsional)

      " Riwayat Direktori
      nnoremap H :history -1<CR>
      nnoremap L :history +1<CR>

      " Operasi File (Sesuai Ranger)
      nnoremap dd :delete<CR>
      nnoremap yy :yank<CR>
      nnoremap p :paste<CR>
      nnoremap P :paste<CR>
      nnoremap dD :delete!<CR>
      nnoremap dT :trash<CR>
      nnoremap r :rename<CR>

      " Menyalin Nama / Path
      nnoremap yp :execute 'echo @%"'<CR>
      nnoremap yn :execute 'echo %:t"'<CR>

      " Marking / Visual Mode
      nnoremap V :Visual<CR>
      nnoremap v :select<CR>
      nnoremap <Space> :select<CR>

      " Pencarian dan Filter
      nnoremap / :grep<Space>
      nnoremap n :noremap <CR> :next<CR>
      nnoremap N :previous<CR>
      nnoremap f :filter<Space>

      " Perubahan Metode Pengurutan
      nnoremap os :set sort=size<CR>
      nnoremap ob :set sort=name<CR>
      nnoremap om :set sort=time<CR>
      nnoremap ot :set sort=type<CR>

      " Tombol Toggle (File Tersembunyi)
      " zo = tampilkan, zm = sembunyikan, za = toggle
      nnoremap zo :windo set hidden!<CR>
      nnoremap zm :windo set hidden!<CR>
      nnoremap za :windo set hidden!<CR>

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

      " ============================================================================
      "  BOOKMARK (MARK)
      " ============================================================================
      " Cara pakai: 'm' + huruf untuk pasang, ' + huruf untuk panggil
      nnoremap m :mark<Space>
      nnoremap M :marks<CR>
      nnoremap ' :goto<Space>

      " Tampilan Status Bar
      set statusline=" %t %= %M %C"
    '';
  };
}
