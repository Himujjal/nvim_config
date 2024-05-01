local backupObsidianWithGit = function()
  local curr_date = os.date "%Y-%m-%d-%H-%M-%S"
  local commit_msg = "Backup Obsidian " .. curr_date
  local curr_directory = vim.fn.getcwd()

  local cmd = "git add . && git commit -m " .. commit_msg .. "&& git push origin"

  local job = vim.fn.jobstart(cmd, {
    cwd = curr_directory,
    stdout = vim.fn.tempname(),
    on_exit = function()
      -- notify user that backup is done
      vim.notify("Backup Obsidian with Git", 0, { title = "Backup" })
    end,
  })
end

return function()
  -- Neovide configutation here
  vim.g.neovide_cursor_animation_length = 0.03
  vim.g.neovide_cursor_trail_length = 0.2

  vim.g.guifont = "FiraCode Nerd Font:h10"

  vim.api.nvim_create_user_command("ObsidianBackup", function() backupObsidianWithGit() end, { nargs = 0 })
  -- vim.api.nvim_create_user_command("ObsidianBackup", 'echo "Hello world!"', {})
end
