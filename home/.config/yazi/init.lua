-- full-border.yazi
require("full-border"):setup {
	-- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
	type = ui.Border.ROUNDED,
}

-- git.yazi
require("git"):setup()
THEME.git = THEME.git or {}
THEME.git.modified = ui.Style():fg("blue")
THEME.git.deleted = ui.Style():fg("red"):bold()
THEME.git.modified_sign = "M"
THEME.git.deleted_sign = "D"

-- eza-preview
require("eza-preview"):setup({
  -- Determines the directory depth level to tree preview (default: 3)
  level = 2,

  -- Whether to follow symlinks when previewing directories (default: false)
  follow_symlinks = true,

  -- Whether to show target file info instead of symlink info (default: false)
  dereference = false,
})
