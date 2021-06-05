local function setup(previewer, fifo_path)
  xplr.config.modes.builtin.default.key_bindings.on_key["P"] = {
    help = "search with preview",
    messages = {
      { BashExecSilently = 'NNN_FIFO="' .. fifo_path .. '" "' .. previewer .. '" &' },
      { CallLuaSilently = "custom.nnn_preview_tui_toggle" },
    },
  }

  -- TODO: create if doesn't exist

  xplr.fn.custom.nnn_preview_tui_toggle = function(app)
    return {
      { ToggleFifo = fifo_path },
    }
  end

end

return { setup = setup }
