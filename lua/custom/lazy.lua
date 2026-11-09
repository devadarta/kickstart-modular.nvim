local M = {}
local done = {}

-- Instala o plugin mas NÃO carrega (load = função vazia)
function M.add(specs)
  vim.pack.add(specs, { load = function() end })
end

-- Executa fn uma única vez por nome.
-- Só marca como feito se fn terminar sem erro (assim um erro não "trava" o plugin silenciosamente).
function M.once(name, fn)
  if done[name] then return end
  fn()
  done[name] = true
end

-- packadd tolerante (ignora plugin inexistente, ex.: fzf-native sem `make`)
function M.pack(...)
  for _, n in ipairs { ... } do
    pcall(vim.cmd.packadd, n)
  end
end

-- Roda fn uma vez, no primeiro dos eventos informados
function M.on_event(name, events, fn)
  vim.api.nvim_create_autocmd(events, {
    once = true,
    group = vim.api.nvim_create_augroup('lazy-' .. name, { clear = true }),
    callback = function() M.once('event:' .. name, fn) end,
  })
end

-- Mason compartilhado (LSP e DAP usam). O setup coloca os binários no PATH.
function M.mason()
  M.once('mason', function()
    vim.cmd.packadd 'mason.nvim'
    require('mason').setup {}
  end)
end

return M
