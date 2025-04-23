return {
    "ray-x/go.nvim",
    dependencies = {  -- optional packages
        "ray-x/guihua.lua",
    },
    event = {"CmdlineEnter"},
    ft = {"go", 'gomod'}
}
