local M = {}

local CLOSING_CHARS = {
  [')'] = true,
  [']'] = true,
  ['}'] = true,
  ['"'] = true,
  ["'"] = true,
  ['`'] = true,
}

-- Simula a digitação de uma tecla.
local function feedkeys(keys)
  -- A função nvim_feedkeys() espera que teclas especiais (<Tab>, <CR>, <Esc>, ...) sejam convertidas
  -- para seus códigos internos. Por isso utilizamos nvim_replace_termcodes() antes de enviá-las ao editor.
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), 'n', false)
end

-- Retorna o caractere imediatamente à direita do cursor.
local function get_next_char(col)
  local NEXT_COL = col + 1
  local line = vim.api.nvim_get_current_line()
  -- string.sub() utiliza índices iniciando em 1. Por isso é necessário somar 1 à
  -- coluna antes de acessar a string.local
  return line:sub(NEXT_COL, NEXT_COL)
end

-- Verifica se o caracter da coluna é um caracter de fechamento (CLOSING_CHARS)
local function is_closing_char(col)
  if CLOSING_CHARS[get_next_char(col)] then return true end
  return false
end

-- Implementa o comportamento inteligente da tecla <Tab>.
--
-- Fluxo:
--   1. Se o próximo caractere for um delimitador de fechamento, apenas move o cursor para fora do par.
--   2. Caso contrário, mantém o comportamento padrão do <Tab>.
function M.smart_tab()
  -- nvim_win_get_cursor() retorna a coluna iniciando em 0.
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  if is_closing_char(col) then
    -- Move o cursor uma posição para a direita.
    -- Como a coluna da API também é baseada em zero, basta incrementar seu valor em uma unidade.
    vim.api.nvim_win_set_cursor(0, { row, col + 1 })
    return
  end

  -- Comportamento padrão da tecla <Tab>
  feedkeys '<Tab>'
end

return M
