local function setup()

  xplr.config.modes.builtin.action.key_bindings.on_key[":"] = {
    help = "send xplr message",
    messages = {
      "PopMode",
      { SwitchModeCustom = "message" },
      { SetInputBuffer = "" },
    }
  }

  xplr.config.modes.custom.message = {
    name = "message",
    key_bindings = {
      on_key = {
        enter = {
          help = "send",
          messages = {
            {
              BashExecSilently = [===[
              echo "${XPLR_INPUT_BUFFER:?}" >> "${XPLR_PIPE_MSG_IN:?}"
              ]===]
            },
            { SetInputBuffer = "" },
          }
        },
        backspace = {
          help = "remove last character",
          messages = {"RemoveInputBufferLastCharacter"}
        },
        ["ctrl-c"] = {
          help = "terminate",
          messages = {"Terminate"}
        },
        ["ctrl-u"] = {
          help = "remove line",
          messages = {
            { SetInputBuffer = "" },
          }
        },
        ["ctrl-w"] = {
          help = "remove last word",
          messages = {"RemoveInputBufferLastWord"}
        },
        esc = {
          help = "cancel",
          messages = {"PopMode"}
        },
      },
      default = {
        messages = {"BufferInputFromKey"}
      },
    }
  }

end

return { setup = setup }
