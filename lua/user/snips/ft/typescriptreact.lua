local ls = require "luasnip"

-- local snippet = ls.s
local snippet_from_nodes = ls.sn

local i = ls.insert_node
local t = ls.text_node
local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

local newline = function(text)
  return t { "", text }
end

return {


  -- test = { "local ", i(1), ' = require("', f(function(args)
  --   table.insert(RESULT, args[1])
  --   return { "hi" }
  -- end, { 1 }), '")', i(0) },

  -- test = { i(1), " // ", d(2, function(args)
  --   return snippet_from_nodes(nil, { str "hello" })
  -- end, { 1 }), i(0) },
}
