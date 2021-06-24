local function setup()

  local xplr = xplr

  xplr.config.modes.builtin.delete.key_bindings.on_key.d = {
    help = "trash",
    messages = {
        {
          BashExecSilently = [===[
          while IFS= read -r line; do trash-put -- "${line:?}";
          done < "${XPLR_PIPE_RESULT_OUT:?}"
          echo ExplorePwdAsync >> "${XPLR_PIPE_MSG_IN:?}"
          ]===],
        },
        "PopMode",
    },
  }

  xplr.config.modes.builtin.delete.key_bindings.on_key.r = {
    help = "restore from trash",
    messages = {
      {
        BashExec = [===[
        PTH=$(trash-list | fzf | awk '{print $3}')
        yes 0 | trash-restore "${PTH:?}"
        echo ExplorePwdAsync >> "${XPLR_PIPE_MSG_IN:?}"
        ]===],
      },
      "PopMode",
    },
  }
end

return { setup = setup }
