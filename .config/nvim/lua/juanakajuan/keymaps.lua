vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Quick fix list navigation
vim.keymap.set("n", "<leader>qn", "<CMD>cnext<CR>zz")
vim.keymap.set("n", "<leader>qp", "<CMD>cprev<CR>zz")

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Replace the word that I am currently on
vim.keymap.set(
    "n",
    "<leader>rw",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Find and replace on current word" }
)

vim.keymap.set(
    "x",
    "<leader>p",
    '"_dP',
    { desc = "Paste over highlighted text and still have the stuff I pasted" }
)

vim.keymap.set(
    "n",
    "<leader>zm",
    "<CMD>ZenMode<CR>",
    { desc = "Activate ZenMode" }
)
vim.keymap.set("n", "<leader>cl", "<CMD>ClangdSwitchSourceHeader<CR>")

-- Page jump up and down while keeping cursor in the middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Go to beginning and end
vim.keymap.set("i", "<C-b>", "<ESC>^i")
vim.keymap.set("i", "<C-e>", "<End>")

vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-f>", "<CMD>silent !tmux neww tmux-sessionizer.sh<CR>")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set(
    "n",
    "k",
    "v:count == 0 ? 'gk' : 'k'",
    { expr = true, silent = true }
)
vim.keymap.set(
    "n",
    "j",
    "v:count == 0 ? 'gj' : 'j'",
    { expr = true, silent = true }
)

vim.keymap.set(
    "n",
    "<leader>e",
    vim.diagnostic.open_float,
    { desc = "Open floating diagnostic message" }
)
vim.keymap.set(
    "n",
    "<leader>vs",
    "<CMD>vsplit<CR>",
    { desc = "Open vertical split" }
)
vim.keymap.set(
    "n",
    "<leader>fh",
    "<CMD>syntax sync fromstart<CR>",
    { desc = "Fix syntax highlighting" }
)
vim.keymap.set(
    "n",
    "<leader>fp",
    "<CMD>!npx prettier --write %<CR>",
    { desc = "[F]ormat [P]rettier" }
)
