local M = {}

local function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

M.config = function()
  local status_ok, gitlinker = pcall(require, "gitlinker")
  if not status_ok then
    return
  end
  gitlinker.setup({
    opts = {
      remote = nil, -- force the use of a specific remote
      -- adds current line nr in the url for normal mode
      add_current_line_on_normal_mode = true,
      -- callback for what to do with the url
      action_callback = require("gitlinker.actions").copy_to_clipboard,
      -- print the url after performing the action
      print_url = false,
      -- mapping to call url generation
      mappings = "<leader>gy",
    },
    callbacks = {
      ["github.com"] = function(url_data)
        url_data["host"] = url_data.host:gsub("-sl","")
        url_data["host"] = url_data.host:gsub("-me","")
        local baseUrl = require("gitlinker.hosts").get_base_https_url(url_data)
        local url = baseUrl
            .. "/blob/"
            .. url_data.rev
            .. "/"
            .. url_data.file
        if url_data.lstart then
          url = url .. "#L" .. url_data.lstart
          if url_data.lend then
            url = url .. "-L" .. url_data.lend
          end
        end
        return url
      end,
    },
  })
end

return M
