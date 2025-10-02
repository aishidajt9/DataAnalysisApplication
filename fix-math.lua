-- Pandoc Lua filter to fix nested math environments
-- Removes \[ and \] around align/gather/multline environments

function Math(el)
  if el.mathtype == "DisplayMath" then
    local text = el.text
    -- Check if contains align, gather, or multline
    if text:match("^%s*\\begin{align") or
       text:match("^%s*\\begin{gather") or
       text:match("^%s*\\begin{multline") then
      -- Return as RawInline LaTeX without display math wrapper
      return pandoc.RawInline('latex', text)
    end
  end
  return el
end
