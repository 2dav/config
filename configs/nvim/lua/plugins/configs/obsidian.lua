local status_ok, obs = pcall(require, "obsidian")
if not status_ok then 
	vim.notify("obsidian.nvim not loaded")
	return 
end

opts = {
	-- dir = "~/notes",
	workspaces = {
		{
			name = "notes",
			path = "~/notes",
		},
	},
	completion = {
		nvim_cmp = true,
		min_chars = 2,
	},
	picker = {
		name = "fzf-lua",
	},
	preferred_link_style = "markdown",
	open_notes_in = "vsplit",

	-- templates = {
	--     folder = "templates",
	--     date_format = "%Y-%m-%d",
	--     time_format = "%H:%M",
	--     substitutions = {},
	-- },
}

local obs = obs.setup(opts)
local function new_note(subdir, ask_name, template)
    -- get file name, otherwise use ISO timestamp
    local fname = ""
    if ask_name == true then
        -- get file name from user input or return ""
        inp = vim.fn.input("Name: ", "") 
        -- if no name given and ask_name == true, cancel note creation
        if inp == "" then return end
        fname = inp
    else
        -- if ask_name == false, then assign timestamp for filename
        fname = tostring(os.date("%y%m%d%H%M%S")) 
    end

    -- create query to check if note already exists
    -- can be a file name or path to a file
    local query = fname .. ".md"
    if subdir ~= nil then
        query = subdir .. "/" .. fname .. ".md"
    end

    -- try to find the note, and create if not found
    -- if path given, checks all sub directories of the vault for the path
    -- if file name is given, checks again all sub directories of the vault for the name
    local note = obs:resolve_note(query)

    if note == nil then
		path = tostring(obs.dir) .. "/" .. subdir
        note = obs:new_note(fname, fname, path)
    end

    -- create a split window and open note on that window
    -- vim.cmd("vsplit")
    vim.cmd("edit " .. tostring(note.path))

    -- if a template is given, apply the template immediately
    if template ~= nil then
        vim.cmd("ObsidianTemplate " .. template .. ".md")
    end
end


vim.keymap.set("n", "<leader>nn", function()
    new_note("capture", true, nil)
end, { noremap = true, desc = "Capture Note" })

-- Create a project note on 'project' sub directory
-- of the vault, get file name from the input,
-- and apply the "project" template
vim.keymap.set("n", "<leader>np", function()
    new_note("projects", true, "project")
end, { noremap = true, desc = "Project Note" })

