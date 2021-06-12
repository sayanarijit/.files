local function setup()
  xplr.config.modes.builtin.action.key_bindings.on_key.D = {
    help = "disk usage",
    messages = {
      {
        BashExec = [===[
        SELECTED=$(dua i)
        if [ "$SELECTED" ]; then
          while read -r line; do
            echo SelectPath: '"'$(realpath "${line:?}")'"' >> "${XPLR_PIPE_MSG_IN:?}"
          done <<< "$SELECTED"
        fi
        ]===]
      },
      "PopMode",
      "ClearScreen",
    },
  }
end

return { setup = setup }
