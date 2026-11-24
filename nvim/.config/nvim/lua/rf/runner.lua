local M = {}

local Runner = {
  buf = nil,
}

local function runner_is_valid()
  return Runner.buf
    and vim.api.nvim_buf_is_valid(Runner.buf)
    and vim.bo[Runner.buf].buftype == "terminal"
end

local function set_terminal_keymaps(buf)
  local opts = { buffer = buf, silent = true }

  -- Leave terminal-job mode
  vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], opts)

  -- Window navigation from terminal
  vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], opts)
  vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]], opts)
  vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], opts)
  vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], opts)
end

local function open_runner_terminal_right()
  vim.cmd("vsplit")
  vim.cmd("wincmd l")
  vim.cmd("terminal")
  Runner.buf = vim.api.nvim_get_current_buf()
  set_terminal_keymaps(Runner.buf)
end

local function goto_runner_terminal()
  if not runner_is_valid() then
    open_runner_terminal_right()
    return
  end

  -- If visible, jump to it
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(win) == Runner.buf then
      vim.api.nvim_set_current_win(win)
      return
    end
  end

  -- Otherwise show existing terminal buffer in a new right split
  vim.cmd("vsplit")
  vim.cmd("wincmd l")
  vim.api.nvim_win_set_buf(0, Runner.buf)
end

local function send_to_runner(cmd)
  local job = vim.b[Runner.buf].terminal_job_id
  if not job then
    Runner.buf = nil
    goto_runner_terminal()
    job = vim.b[Runner.buf].terminal_job_id
  end

  vim.fn.chansend(job, cmd .. "\n")
end

local function clear_cmd()
  return "clear"
end

function M.setup(opts)
  opts = opts or {}

  local key = opts.key or "<leader>r"
  local keep_focus = opts.keep_focus or false
  local python_cmd = opts.python_cmd or "python3"
  local interactive = opts.interactive
  if interactive == nil then
    interactive = true
  end

  vim.keymap.set("n", key, function()
    if vim.bo.filetype ~= "python" then
      vim.notify("Current buffer is not a Python file", vim.log.levels.WARN)
      return
    end

    vim.cmd("write")
    local file = vim.fn.expand("%:p")
    local curwin = vim.api.nvim_get_current_win()

    goto_runner_terminal()
    send_to_runner(clear_cmd())

    local run_cmd
    if interactive then
      run_cmd = string.format("%s -i %s", python_cmd, vim.fn.shellescape(file))
    else
      run_cmd = string.format("%s %s", python_cmd, vim.fn.shellescape(file))
    end

    send_to_runner(run_cmd)

    if keep_focus then
      vim.api.nvim_set_current_win(curwin)
    else
      vim.cmd("startinsert")
    end
  end, { desc = "Run current Python file in right terminal" })
end

return M
