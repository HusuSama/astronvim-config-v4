return {
  "yetone/avante.nvim",
  opts = {
    -- provider = "openai",
    -- auto_suggestions_provider = "openai", -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot
    -- openai = {
    --   endpoint = "https://api.deepseek.com/v1",
    --   model = "deepseek-chat",
    --   timeout = 30000, -- Timeout in milliseconds
    --   temperature = 0,
    --   max_tokens = 4096,
    --   -- optional
    --   api_key_name = "OPENAI_API_KEY", -- default OPENAI_API_KEY if not set
    provider = "deepseek",
    vendors = {
      deepseek = {
        __inherited_from = "openai",
        api_key_name = "DEEPSEEK_API_KEY",
        endpoint = "https://api.deepseek.com",
        model = "deepseek-coder",
      },
    },
  },
}
