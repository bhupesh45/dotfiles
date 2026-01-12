local map = vim.keymap.set

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Move Lines
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>x", "<cmd>bdelete<cr>", { desc = "Delete Buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- Clear search highlights and stop snippet on Escape
vim.api.nvim_set_keymap("n", "<esc>", ":noh<CR>", { noremap = true, silent = true, desc = "Clear search highlight" })

-- Handle Escape in insert and select modes
vim.api.nvim_set_keymap(
    "i",
    "<esc>",
    "<C-o>:noh<CR><esc>",
    { noremap = true, silent = true, desc = "Escape and Clear hlsearch" }
)
vim.api.nvim_set_keymap(
    "s",
    "<esc>",
    "<C-o>:noh<CR><esc>",
    { noremap = true, silent = true, desc = "Escape and Clear hlsearch" }
)

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Comment
map("n", "<leader>/", "gcc", { desc = "Toggle Comment", remap = true })
map("v", "<leader>/", "gc", { desc = "Toggle comment", remap = true })

map("n", ";", ":", { desc = "Better colon" })

-- Variable rename
map({ "n", "v" }, "<leader>vr", vim.lsp.buf.rename, { desc = "Rename Variable" })
