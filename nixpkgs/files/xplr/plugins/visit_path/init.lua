local function setup()
  xplr.config.modes.builtin.action.key_bindings.on_key["o"] = {
    help = "visit file",
    messages = {
      "PopMode",
      { SwitchModeCustom = "visit_path" },
      { SetInputBuffer = "" },
    },
  }

  xplr.config.modes.custom.visit_path = {
    name = "visit path",
    key_bindings = {
      on_key = {
        enter = {
          messages = {
            "FocusPathFromInput",
            "PopMode",
          }
        },
        esc = {
          help = "cancel",
          messages = {
            "PopMode"
          },
        },
        ["ctrl-c"] = {
          help = "terminate",
          messages = {
            "Terminate"
          }
        }
      },
      default = {
        messages = {
          "BufferInputFromKey",
        }
      }
    },
  }
end

return { setup = setup }
