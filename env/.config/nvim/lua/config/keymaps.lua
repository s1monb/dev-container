local map = vim.keymap.set

-- File Explorer
map("n", "<leader>e", "<cmd>Oil<cr>", { desc = "Open File explorer" })

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Telescope Find Files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Telescope Live Grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Telescope Find Buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Telescope Help Tags" })
map("n", "<leader>fd", "<cmd>Telescope git_files<cr>", { desc = "Telescope Git Files" })
map("n", "<leader>fl", "<cmd>Telescope lsp_references<cr>", { desc = "Telescope LSP References" })

-- Buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })

-- LSP
map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { silent = true })
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { silent = true })
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", { silent = true })
