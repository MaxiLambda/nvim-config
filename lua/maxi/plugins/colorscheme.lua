return {
	"folke/tokyonight.nvim",
	priority = 1000, --load before everything
	config = function ()
		--load colorscheme
		vim.cmd([[colorscheme tokyonight]])
	end
}
