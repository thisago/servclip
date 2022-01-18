import pkg/jester
from pkg/nimclipboard/libclipboard import clipboard_new, clipboard_text, clipboard_set_text

var cb = clipboard_new(nil)

routes:
  get "/get":
    resp $cb.clipboard_text
  get "/set/@text":
    resp $cb.clipboard_set_text cstring @"text"
