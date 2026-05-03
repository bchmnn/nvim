_G.utils = _G.utils or {}

function utils.flatten_list_values(tbl)
	return vim.iter(vim.tbl_values(tbl)):fold({}, function(acc, lst)
		for _, v in ipairs(lst) do
			if not vim.tbl_contains(acc, v) then
				table.insert(acc, v)
			end
		end
		return acc
	end)
end
