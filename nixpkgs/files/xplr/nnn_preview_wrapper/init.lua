-- Usage Example:
--
-- require("nnn_preview_wrapper").setup{
--   plugin_path = os.getenv("HOME") .. "/.config/nnn/plugins/preview-tabbed",
--   fifo_path = "/tmp/xplr.fifo",
-- }

local function setup(o)

  local enabled = false
  local message = nil

  os.execute('[ ! -p "' .. o.fifo_path ..'" ] && mkfifo "' .. o.fifo_path .. '"')

  xplr.fn.custom.preview_toggle = function(app)

    if enabled then
      enabled = false
      message = "StopFifo"
    else
      os.execute('NNN_FIFO="' .. o.fifo_path .. '" "'.. o.plugin_path .. '" & ')
      enabled = true
      message = { StartFifo = o.fifo_path }
    end

    return { message }
  end

  xplr.config.modes.builtin.default.key_bindings.on_key["P"] = {
    help = "search with preview",
    messages = {
      { CallLuaSilently = "custom.preview_toggle" },
    },
  }
end

return { setup = setup }
