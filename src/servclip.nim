import std/asyncdispatch
from std/strformat import fmt
from std/strutils import parseInt

import pkg/jester
from pkg/nimclipboard/libclipboard import clipboard_new, clipboard_text,
                                          clipboard_set_text
from pkg/bluesoftcosmos import Product, getProduct

var cb = clipboard_new(nil)

routes:
  get "/get":
    resp $cb.clipboard_text
  get "/set/text/@text":
    let text = @"text"
    if not cb.clipboard_set_text cstring text:
      resp "Cannot set clipboard text"
    else:
      echo fmt"Edited clipboard to `{text}`"
      resp text
  get "/set/barcode/@code":
    var
      code = @"code"
      barcode: int64 = -1
      error = ""
    try:
      barcode = parseInt code
    except ValueError:
      error = "Barcode is not a integer"
    block:
      if barcode != -1:
        var data: Product
        try:
          data = await getProduct barcode
        except: discard
        if data.name.len > 0:
          let text = fmt"{barcode},{data.name}"
          if not cb.clipboard_set_text cstring text:
            error = "Cannot put barcode data in clipboard"
          else:
            echo fmt"Edited clipboard to `{text}`"
            resp $barcode
          break
        else:
          error = "Cannot get barcode data"
    if not cb.clipboard_set_text cstring code:
      resp "Cannot put barcode in clipboard"
    else:
      resp error
