-------- Format size column

DU_CACHE = {}

local function split(s, delimiter)
    local result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end

local function setup()
  xplr.fn.builtin.fmt_general_table_row_cols_3 = function(m)
    if m.is_dir then
      local size = DU_CACHE[m.absolute_path]
      if size == nil then

        -- TODO: Use coroutine

        local p = io.popen("du -shx '" .. m.absolute_path .. "'")
        size = split(p:read("*a"), "\t")[1]
        p:close()
        DU_CACHE[m.absolute_path] = size
        return size
      else
        return size
      end
    else
      return m.human_size
    end
  end
end

return { setup = setup }
