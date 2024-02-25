return {
  "mfussenegger/nvim-dap",
  dependencies = {

    -- fancy UI for the debugger
    {
      "rcarriga/nvim-dap-ui",
      -- stylua: ignore
      keys = {
        { "<leader>cdu", function() require("dapui").toggle({}) end, desc = "Debug UI toggle" },
        { "<leader>cde", function() require("dapui").eval() end,     desc = "Debug - Eval",   mode = { "n", "v" } },
      },
      opts = {},
      config = function(_, opts)
        -- setup dap config by VsCode launch.json file
        -- require("dap.ext.vscode").load_launchjs()
        local dap = require("dap")
        local dapui = require("dapui")
        dapui.setup(opts)
        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open({})
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close({})
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close({})
        end
      end,
    },

    -- virtual text for the debugger
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {},
    },

    -- mason.nvim integration
    {
      "jay-babu/mason-nvim-dap.nvim",
      dependencies = "mason.nvim",
      cmd = { "DapInstall", "DapUninstall" },
      opts = {
        -- Makes a best effort to setup the various debuggers with
        -- reasonable debug configurations
        automatic_installation = true,

        -- You can provide additional configuration to the handlers,
        -- see mason-nvim-dap README for more information
        handlers = {},

        -- You'll need to check that you have the required things installed
        -- online, please don't ask me how to install them :)
        ensure_installed = {
          -- Update this to ensure that you have the debuggers for the langs you want
          "java-debug-adapter"
        },
      },
    },
  },

  config = function()
    require('dap.ext.vscode').load_launchjs()
    vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

    local function nnoremap(rhs, lhs, desc)
      vim.keymap.set("n", rhs, lhs, { desc = desc })
    end

    nnoremap("<leader>cbb", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Set breakpoint")
    nnoremap("<leader>cbc", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
      "Set conditional breakpoint")
    nnoremap("<leader>cbl", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>",
      "Set log point")
    nnoremap('<leader>cbr', "<cmd>lua require'dap'.clear_breakpoints()<cr>", "Clear breakpoints")
    nnoremap('<leader>cba', '<cmd>Telescope dap list_breakpoints<cr>', "List breakpoints")

    nnoremap("<leader>cdc", "<cmd>lua require'dap'.continue()<cr>", "Continue")
    nnoremap("<leader>cdj", "<cmd>lua require'dap'.step_over()<cr>", "Step over")
    nnoremap("<leader>cdk", "<cmd>lua require'dap'.step_into()<cr>", "Step into")
    nnoremap("<leader>cdo", "<cmd>lua require'dap'.step_out()<cr>", "Step out")
    nnoremap('<leader>cdd', "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect")
    nnoremap('<leader>cdt', "<cmd>lua require'dap'.terminate()<cr>", "Terminate")
    nnoremap("<leader>cdr", "<cmd>lua require'dap'.repl.toggle()<cr>", "Open REPL")
    nnoremap("<leader>cdl", "<cmd>lua require'dap'.run_last()<cr>", "Run last")
    nnoremap('<leader>cdi', function() require "dap.ui.widgets".hover() end, "Variables")
    nnoremap('<leader>cd?', function()
      local widgets = require "dap.ui.widgets"; widgets.centered_float(widgets.scopes)
    end, "Scopes")
    nnoremap('<leader>cdf', '<cmd>Telescope dap frames<cr>', "List frames")
    nnoremap('<leader>cdh', '<cmd>Telescope dap commands<cr>', "List commands")
  end,
}
