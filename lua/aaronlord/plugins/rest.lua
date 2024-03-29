return {
    "rest-nvim/rest.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    ft = { "http" },
    config = function()
        local rest = require('rest-nvim')

        rest.setup({
            -- Open request results in a horizontal split
            result_split_horizontal = false,
            -- Keep the http file buffer above|left when split horizontal|vertical
            result_split_in_place = true,
            -- stay in current windows (.http file) or change to results window (default)
            stay_in_current_window_after_split = true,
            -- Skip SSL verification, useful for unknown certificates
            skip_ssl_verification = true,
            -- Encode URL before making request
            encode_url = true,
            -- Highlight request on run
            highlight = {
                enabled = true,
                timeout = 150,
            },
            result = {
                -- toggle showing URL, HTTP info, headers at top the of result window
                show_url = true,
                -- show the generated curl command in case you want to launch
                -- the same request via the terminal (can be verbose)
                show_curl_command = true,
                show_http_info = true,
                show_headers = true,
                -- table of curl `--write-out` variables or false if disabled
                -- for more granular control see Statistics Spec
                show_statistics = false,
                -- executables or functions for formatting response body [optional]
                -- set them to false if you want to disable them
                formatters = {
                    json = "jq",
                    html = function(body)
                        return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
                    end
                },
            },
            -- Jump to request line on run
            jump_to_request = true,
            env_file = '.env',
            custom_dynamic_variables = {},
            yank_dry_run = true,
            search_back = true,
        })

        vim.keymap.set('n', '<F5>', rest.run)
    end
}
