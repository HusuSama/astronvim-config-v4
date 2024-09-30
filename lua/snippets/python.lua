local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require "luasnip.util.events"
local ai = require "luasnip.nodes.absolute_indexer"
local extras = require "luasnip.extras"
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require "luasnip.extras.expand_conditions"
local postfix = require("luasnip.extras.postfix").postfix
local types = require "luasnip.util.types"
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

return {
  postfix(".print", {
    -- f(function(_, parent) return "print(" .. parent.snippet.env.POSTFIX_MATCH .. ")" end, {}),
    f(function(_, parent)
      local node = parent.snippet.env.POSTFIX_MATCH
      if node then
        return "print(" .. node .. ")"
      else
        vim.notify("POSTFIX_MATH is nil value", vim.log.levels.ERROR)
      end
    end),
  }),

  s("__main__", {
    t { 'if __name__ == "__main__":' },
    t { "", "\t" },
    i(1, "pass"),
  }),

  s("pto", {
    t { "def pytest_addoption(parser: pytest.Parser) -> None:" },
    t { "", "\t" },
    i(1, "..."),
  }),

  s("ptc", {
    t { "def pytest_configure(config: pytest.Config) -> None:" },
    t { "", "\t" },
    i(1, "..."),
  }),

  s("ptst", {
    t { "def pytest_sessionstart(session: pytest.Session) -> None:" },
    t { "", "\t" },
    i(1, "..."),
  }),

  s("ptsf", {
    t { "def pytest_sessionfinish(session: pytest.Session) -> None:" },
    t { "", "\t" },
    i(1, "..."),
  }),

  s("ptst", {
    t { "def pytest_sessionstart(session: pytest.Session) -> None:" },
    t { "", "\t" },
    i(1, "..."),
  }),

  s("ptcm", {
    t { "def pytest_collection_modifyitems(session: pytest.Session, config: pytest.Config, items: list) -> None:" },
    t { "", "\t" },
    i(1, "..."),
  }),

  s("ptcf", {
    t { "def pytest_collection_finish(session: pytest.Session) -> None:" },
    t { "", "\t" },
    i(1, "..."),
  }),

  s("ptrs", {
    t { "def pytest_runtest_setup(item: pytest.Item) -> None:" },
    t { "", "\t" },
    i(1, "..."),
  }),

  s("ptrm", {
    t { "@pytest.hookimpl(hookwrapper=True)" },
    t { "", "def pytest_runtest_makereport(item: pytest.Item, call: pytest.CallInfo) -> None:" },
    t { "", "\t" },
    i(1, "..."),
  }),

  s("ptts", {
    t {
      "def pytest_terminal_summary(terminalreporter, exitstatus: pytest.ExitCode, config: pytest.Config) -> None:",
    },
    t { "", "\t" },
    i(1, "..."),
  }),
}
