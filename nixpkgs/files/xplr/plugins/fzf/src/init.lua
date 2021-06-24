local function setup()
  local xplr = xplr

  xplr.config.modes.builtin.default.key_bindings.on_key["F"] = {
    help = "search with preview",
    messages = {
      {
        BashExec = [===[
        PTH=$(cat "${XPLR_PIPE_DIRECTORY_NODES_OUT:?}" | awk -F / '{print $NF}' | fzf --preview "pistol '{}'")
        if [ -d "$PTH" ]; then
          echo ChangeDirectory: "'"$PWD/${PTH:?}"'" >> "${XPLR_PIPE_MSG_IN:?}"
          elif [ -f "$PTH" ]; then
          echo FocusPath: "'"$PWD/${PTH:?}"'" >> "${XPLR_PIPE_MSG_IN:?}"
        fi
        ]===]
      },
    },
  }
end

return { setup = setup }
