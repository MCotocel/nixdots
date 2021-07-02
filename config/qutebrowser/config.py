# Load config.py settings
config.load_autoconfig(False)

# Aliases for commands
c.aliases = {'q': 'quit', 'w': 'session-save', 'wq': 'quit --save'}

# Editor
c.editor.command = ["kitty", "-e", "nvim", "{}"]

# Always restore sites
c.auto_save.session = True

# Completion menu height
c.completion.height = "20%"

# Confirm quit if downloading
c.confirm_quit = ["downloads"]

# Download locations
c.downloads.location.directory = "~/Downloads"

config.load_autoconfig()

c.colors.completion.category.bg                 = "#1f252a"
c.colors.completion.category.border.bottom      = "#1f252a"
c.colors.completion.category.border.top         = "#1f252a"
c.colors.completion.category.fg                 = "#1f252a"
c.colors.completion.even.bg                     = "#1f252a"
c.colors.completion.item.selected.bg            = "#1f252a"
c.colors.completion.item.selected.border.bottom = "#1f252a"
c.colors.completion.item.selected.border.top    = "#1f252a"
c.colors.completion.item.selected.fg            = "#d5d5d5"
c.colors.completion.match.fg                    = "#d5d5d5"
c.colors.completion.odd.bg                      = "#1f252a"
c.colors.completion.scrollbar.bg                = "#1f252a"
c.colors.completion.scrollbar.fg                = "#97d59b"

c.colors.downloads.bar.bg    = "#1f252a"
c.colors.downloads.error.bg  = "#ff8080"
c.colors.downloads.error.fg  = "#d5d5d5"
c.colors.downloads.start.bg  = "#97d59b"
c.colors.downloads.start.fg  = "#d5d5d5"
c.colors.downloads.stop.bg   = "#1f252a"
c.colors.downloads.stop.fg   = "#d5d5d5"
c.colors.downloads.system.bg = 'none'
c.colors.downloads.system.fg = 'none'

c.colors.hints.fg       = "#d5d5d5"
c.colors.hints.match.fg = "#97d59b"

c.colors.messages.error.bg       = "#ff8080"
c.colors.messages.error.border   = "#ff8080"
c.colors.messages.error.fg       = "#d5d5d5"
c.colors.messages.info.bg        = "#1f252a"
c.colors.messages.info.border    = "#1f252a"
c.colors.messages.info.fg        = "#d5d5d5"
c.colors.messages.warning.bg     = "#ff8080"
c.colors.messages.warning.border = "#ff8080"
c.colors.messages.warning.fg     = "#d5d5d5"

c.colors.prompts.bg          = "#1f252a"
c.colors.prompts.border      = '1px solid gray'
c.colors.prompts.fg          = "#d5d5d5"
c.colors.prompts.selected.bg = "#d5d5d5"

c.colors.statusbar.caret.bg             = "#c780ff"
c.colors.statusbar.caret.fg             = "#d5d5d5"
c.colors.statusbar.caret.selection.bg   = "#1f252a"
c.colors.statusbar.caret.selection.fg   = "#d5d5d5"
c.colors.statusbar.command.bg           = "#1f252a"
c.colors.statusbar.command.fg           = "#d5d5d5"
c.colors.statusbar.command.private.bg   = "#d5d5d5"
c.colors.statusbar.command.private.fg   = "#d5d5d5"
c.colors.statusbar.insert.bg            = "#97d59b"
c.colors.statusbar.insert.fg            = "#d5d5d5"
c.colors.statusbar.normal.bg            = "#1f252a"
c.colors.statusbar.normal.fg            = "#d5d5d5"
c.colors.statusbar.passthrough.bg       = "#80d1ff"
c.colors.statusbar.passthrough.fg       = "#d5d5d5"
c.colors.statusbar.private.bg           = '#666666'
c.colors.statusbar.private.fg           = "#d5d5d5"
c.colors.statusbar.progress.bg          = "#d5d5d5"
c.colors.statusbar.url.fg               = "#d5d5d5"
c.colors.statusbar.url.hover.fg         = "#80ffe4"
c.colors.statusbar.url.success.https.fg = "#d5d5d5"
c.colors.statusbar.url.warn.fg          = "#fffe80"

c.colors.tabs.bar.bg           = "#1f252a"
c.colors.tabs.even.bg          = "#1f252a"
c.colors.tabs.even.fg          = "#d5d5d5"
c.colors.tabs.indicator.error  = '#ff8080'
c.colors.tabs.odd.bg           = "#1f252a"
c.colors.tabs.odd.fg           = "#d5d5d5"
c.colors.tabs.selected.even.bg = "#384149"
c.colors.tabs.selected.even.fg = "#80d1ff"
c.colors.tabs.selected.odd.bg  = "#384149"
c.colors.tabs.selected.odd.fg  = "#80d1ff"

c.colors.webpage.bg = "#1f252a"

c.url.start_pages = "https://mcotocel.github.io/startpage/"

c.colors.webpage.preferred_color_scheme = "dark"
c.tabs.indicator.width = 0
c.tabs.padding = {"bottom": 10, "top": 10, "left": 20, "right": 20 }
c.tabs.favicons.show = 'never'
c.tabs.show = 'multiple'
c.colors.hints.bg = '#1f252a'
c.colors.hints.fg = '#d5d5d5'
c.zoom.default = '100%'
